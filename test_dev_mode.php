<?php
use Magento\Framework\App\Bootstrap;

require __DIR__ . '/src/app/bootstrap.php';

$bootstrap = Bootstrap::create(BP, $_SERVER);
$objectManager = $bootstrap->getObjectManager();

// Get the SMTP helper
$smtpHelper = $objectManager->get(\Mageplaza\Smtp\Helper\Data::class);

// Get the Mail resource
$resourceMail = $objectManager->get(\Mageplaza\Smtp\Mail\Rse\Mail::class);

// Test developer mode
$storeId = 1;
$isDevMode = $resourceMail->isDeveloperMode($storeId);

echo "Store ID: $storeId\n";
echo "Developer Mode Enabled: " . ($isDevMode ? 'YES' : 'NO') . "\n";

// Test configuration directly
$devConfig = $smtpHelper->getDeveloperConfig('developer_mode', $storeId);
echo "Direct Config Value: " . ($devConfig ? 'YES' : 'NO') . "\n";

// Test if SMTP is enabled
$smtpEnabled = $smtpHelper->getSmtpConfig('enabled', $storeId);
echo "SMTP Enabled: " . ($smtpEnabled ? 'YES' : 'NO') . "\n";
