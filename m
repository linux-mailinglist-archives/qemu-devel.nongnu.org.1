Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DAB754DD6
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 10:21:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKx0D-0003Kz-OS; Sun, 16 Jul 2023 04:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKx0A-0003KE-0k
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:21:10 -0400
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com
 ([40.107.94.85] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qKx06-00023x-3G
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 04:21:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvo3ZRkAq7eY4RnwKNXBiP/9AvSIymMyhx+ASicfeVmuYbvb2gjHflGauTb/v+YUBaG6HaEE8N0D5TYwyE5+dKMh75Y/4+tIviJZodF4Z6p+B3cx5L2lWYY7ejGd3iKyk7uHcBooihzw3RhgYI9ZLpammNo0zd/iHQy5OwX5m2PqccDFoShNcqNvnLLVq6Pu7Sag6G+KkFx8RKxgnrMXmGLcOSG4e1SbE2G8Y1NlKtoTuOVjxK85bG/CpZ6tM+xlJ+g565YKqE/h1kasZqnwIiuHaC1xBIskkiH/kUiGfYANZubcnQPMJWQhwx8m9DlccKXD8O3pYsbcz3r7AIcEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQAZ9K0xheLA++ONQa+U12rntxtv9+7Wl5s3yYNGCi8=;
 b=PgdY/UAqMJLOcYkfS07gp8hCbhdFxysFNHJhSixZBHeLJPKRwAHSPYshqUgdPz+GddQObsYpOwKoQ1EERfuxkwYTtjuQBjCA6kBnvK0K8CvooHlZ3I2snMIFCajnGPrLhErIC4Qfe5kOeMvUcXplxRDvKAJOuXKTZN6ieBWx4gTFVz0KwUTyrBEmlKUi9lhPmu6/xumlXytliHEPKQz5rDgPBlosbNLIJNMNVcgtr3Lzf+PkjV1A4YVfEDgl0Xd+xk/y+QSe6a7q8tg+fznqFR5Ooq3oqWOiOOnxeujGGeN6sR2N/XkGvGn8OcSkq90HELfMsvhMxeZxMJhYg8iGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQAZ9K0xheLA++ONQa+U12rntxtv9+7Wl5s3yYNGCi8=;
 b=WqbKGaKSoTyaJrWCZ9Jk8P6KZcuvDM88WcUMp0bGyDRW1WB+H2yCWETSHh4kIPR+pjLICOaO81n2jDkFxNB6fox+spZv7854fw4CQTM9M924yjwiIeXGpneCbJVjgUlSXT3BSA+k/QtQfpeQ3E6afbzMl7cfPd1KvGHshSFvx18/hwXdqy2p2az7zWe5rA+kfFO6UWtoA3T/Mc4H0dM4cEmFhiAimsomqPsBzlD38SLmn+A/Y9Oe+P8UEkFptSm13uOOOrmvZVPgUOj78wZ/6Q84mYmXpybGf35091DtQwDw2cyXAhX9NRQDQ4Xr0oXrdnsC79bqrvMhUP2xmqr4lg==
Received: from DM6PR01CA0016.prod.exchangelabs.com (2603:10b6:5:296::21) by
 IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 08:15:58 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::59) by DM6PR01CA0016.outlook.office365.com
 (2603:10b6:5:296::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31 via Frontend
 Transport; Sun, 16 Jul 2023 08:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31 via Frontend Transport; Sun, 16 Jul 2023 08:15:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Jul 2023
 01:15:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Jul
 2023 01:15:45 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Sun, 16 Jul
 2023 01:15:42 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH for-8.2 0/6] vfio/migration: Add P2P support for VFIO migration
Date: Sun, 16 Jul 2023 11:15:35 +0300
Message-ID: <20230716081541.27900-1-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 83deb120-d3cf-49c6-f786-08db85d4e285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SlwLKLE2ek4IiSKSWZD4ciK9LGbnwjzvFs5UYWJnSZ7QEuBeLVf2ftxkrMNa6AUU5yjtqjp3lItRBl33q7tbFkPp7ToQKoP9hq6VLyNvba4rMKsM7oqQYiEfUNLM7se67/sqdnK4rf+xRiE9/irYEhDDmay7zvwO8YUx5U0zgQgYnNVeFilMA4bSXlQDUQZ/NBzyIY+NgHiqc1muAowCUowfWj/7re3EpxnpG3p28ay9GOEj9mg1BYwjTzfRizRvaXnIUPM6iPhak2S3hNPXu0t2iOWOjGNkATppkPHelzCH2PHy7jUSIIfgSueBJ/fxZ9v3Puq7joZao7ZtfJtAtlFzIN4fOtpU15mhu9M54kr0ITsUNkBRWb0zWiExhHdVjRTocZQOK2ETXdlWGDv76/LArUB4yDRjqDrrkdKyA7qoi2cSHSSzPdZzFRHvC5PZ99nERMkJiusJGVH3GCu4/WV7qilK599fnVu2Dy1s8+EnfpSUKZI4GDNBpLygFEzGL63zM1IAus19tLCZT/D3XOcKxM301pF4i8rhFrar9Khs8mSz63qXy65hLpUnZS5xItNAXHYNReAREKRxR9ZXipjitGZZ70zYsPUGkw4YQiorG7NMXM2PdnDa1VSLqwqxFa7Fu3GzWNHv6izzW7Oh40SYajPGgPGQKiM+fRuZUbaKLZJSlhzJvKo2Llbxdw/Er+zqX5hj1i30QPxACfe+iHVxPAA8JUUIB00/9PMrjabkSoZR6TGDvCNssaz7zW8
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(54906003)(6666004)(7696005)(7636003)(40460700003)(356005)(82740400003)(478600001)(5660300002)(8676002)(8936002)(36756003)(2906002)(86362001)(4326008)(6916009)(40480700001)(70206006)(70586007)(41300700001)(316002)(426003)(107886003)(36860700001)(2616005)(47076005)(1076003)(26005)(83380400001)(336012)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 08:15:58.1486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83deb120-d3cf-49c6-f786-08db85d4e285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
Received-SPF: softfail client-ip=40.107.94.85; envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi all,

The first patch in this series adds a small optimization to VFIO
migration by moving the STOP_COPY->STOP transition to
vfio_save_cleanup(). Testing with a ConnectX-7 VFIO device showed that
this can reduce downtime by up to 6%.

The rest of the series adds P2P support for VFIO migration.

VFIO migration uAPI defines an optional intermediate P2P quiescent
state. While in the P2P quiescent state, P2P DMA transactions cannot be
initiated by the device, but the device can respond to incoming ones.
Additionally, all outstanding P2P transactions are guaranteed to have
been completed by the time the device enters this state.

The purpose of this state is to support migration of multiple devices
that are doing P2P transactions between themselves.

To implement P2P migration support, all the devices must be transitioned
to the P2P quiescent state before being stopped or started.

This behavior is achieved by adding an optional pre VM state change
callback to VMChangeStateEntry. These callbacks are invoked before the
main VM state change callbacks, transitioning all the VFIO devices to
the P2P state, and only then are the main callbacks invoked, which stop
or start the devices.

This will allow migration of multiple VFIO devices if all of them
support P2P migration.

Thanks.

Avihai Horon (5):
  vfio/migration: Move from STOP_COPY to STOP in vfio_save_cleanup()
  sysemu: Add pre VM state change callback
  qdev: Add qdev_add_vm_change_state_handler_full()
  vfio/migration: Add P2P support for VFIO migration
  vfio/migration: Allow migration of multiple P2P supporting devices

Joao Martins (1):
  vfio/migration: Refactor PRE_COPY and RUNNING state checks

 docs/devel/vfio-migration.rst     | 93 +++++++++++++++++++------------
 include/hw/vfio/vfio-common.h     |  2 +
 include/sysemu/runstate.h         |  7 +++
 hw/core/vm-change-state-handler.c | 14 ++++-
 hw/vfio/common.c                  | 50 +++++++++++++----
 hw/vfio/migration.c               | 83 +++++++++++++++++++--------
 softmmu/runstate.c                | 39 +++++++++++++
 hw/vfio/trace-events              |  2 +-
 8 files changed, 217 insertions(+), 73 deletions(-)

-- 
2.26.3


