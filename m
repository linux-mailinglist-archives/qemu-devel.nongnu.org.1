Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6958820AB7
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:32:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJs9w-0002Is-RH; Sun, 31 Dec 2023 04:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9t-0002Hs-Az
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:01 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rJs9r-0008MX-TJ
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:31:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTeZTriNMssuuNRZtCPcgnTEmLUeoxAQY9MqZDObdmAcEgYlhFrdgXAiGzhaGQel5Hr37Nj2TEMn2CFqp4n00Q7fnPONuEFpIC7+Gmd+HaNqEOCtLllYhxUOe09+MCPEBhulsQayMYfI8AIq4Vo+mVuseDv0c651dJ04w3qjBGOmUGRITfv7t4S10tC4+W+KZKUYgltswcyKoCYDvrbBCZ6f1ji89bsv8JoWthnFw42u0HfKBq+GlkbpGxXGJmmzvVvBsNsFco9hd4232VnODNp6kO8+6aN5wecw6g/+r4xgpwV/PzYCqFqLkh39C2MMw+zb6ivXEEN6LiVr6gN3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhmNg25SQ2zKpGEDKbEY4cfEtXiZ/4UMe/FxWEJOd64=;
 b=RjGzbNVrjezepKngTTCN7iUXqfq3O/3crTti0qyLM13XvvN8wszsj+LJLfwrKrViF4LZNe3smQcxe+uTFx2AOP4HAUC7g1TflYK4w3qzCaMAmCKmq+Go9wTnuWF+IXyZP7Al8ClMsxknkkFMzKMP9betxBwO4Apx7VWEa3bJpapP7K1snBde6skyvUBMSx9huJH8z9DZu60s5Q717SLLeLsu/uVSju6qROjX2ykf0DTTTcYvwHAifC8zMjsuWBLtG0QdbNtGjebdawBtDMdc0KQZY/0EYAcMK9/4saWROMb3pciyyNsbuBlFDVZYRhftsDvBqw8DcbvWS0mgPOvB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhmNg25SQ2zKpGEDKbEY4cfEtXiZ/4UMe/FxWEJOd64=;
 b=gehMEdLhEyrdZcvwTsAnZLSohkzVlG456mIEOQMvVeFDps0eM1lNqSD1l9WWmqKkbAxwCm0vh4Mh6GahVuZKhfTOesVblWMT2wpxzSuF9ji8j2dybDWLDhHe1UTNJbveFS1WMTsQhq915UhN7+wMW9iZ8fuFj5ZAqwPj9dsiFwMGafSyJu6xSJ2Jt6LfX3K9IaoPHGdhjAp+KEn8p8FxOlI30E+HuwY9DS7Qw+CEekCIVJiQ+Pb2ljplg2ZWI9zOcyxZzal15HPp+8jjQmyM7plkVvQAY5SG9oO12F/xperNAahNgkIAgs2d+PalPZYW8vO+DwHVSbtqOk9VvsjxLw==
Received: from DS7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:5:3b8::22)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Sun, 31 Dec
 2023 09:30:55 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a7) by DS7PR03CA0017.outlook.office365.com
 (2603:10b6:5:3b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20 via Frontend
 Transport; Sun, 31 Dec 2023 09:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 09:30:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:38 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 31 Dec
 2023 01:30:37 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 31 Dec
 2023 01:30:35 -0800
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Fabiano Rosas" <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH 07/11] migration/multifd: Fix leaking of Error in TLS error
 flow
Date: Sun, 31 Dec 2023 11:30:12 +0200
Message-ID: <20231231093016.14204-8-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20231231093016.14204-1-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca1edbb-ce16-49b8-6074-08dc09e32ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hswXKpxilCk1gXqjVWVCwlsf4FfDikYWcqyTFOacDoz6CyWTOhq6ENzm5CxWMyD2yd3fyfHIvYaaHLghzKXw9457uWOaeL0RFq60Soz3rjy/NwNRNMLcAinQ8+bInEvBklv6j5j8cfPkeUkHgg1ZcjIZQYUtIe0uOlQQrMp5xi71tJA9EBXtLpIDUrNi07DkxaVBH0hkekxK5kTsPcULa7iXEvtgTY4qTEZmtkGtpVYlImhheGMB5viqxjh7P6egUBLMSadM23MsUwCZBtqgY0cd2yTi0fjMAGF3Mp8HedWejGMiD2TIs/GWRDOmYO5o1cFh6xCHadY8meTenqHuo8Cz74J2I+B7OHqIxfSkmrhwEEOqt0+2b8ustTCWLWDeFCxlzbLTgUvAF20XExa5G3mPTkVUvOJmBeh43GeN5vDiHu1P1mhWWwF4yOC+uf+Yx2rPEbivVYtvgWE9d5sejOD7NW9bvNznlQDkjgv9Fzgo8wiUAVWzgdN34+Sa4mP2gwzSxe3oYU2kMI+zEMMDOipz0GpAavxU89yA6FnmM4OfGMBfSboWlM3x2jlI2i/aORvw5OxXJTyaoAF2x3Mxi085P2kuHMXBcDa4zMUdwBl2fKLgWkM9yjPARn6vkVLJRM8HWZuSjxx7PA3BF3vVPkpiVKJU1spO3pMG0nx1Z5kMZMM4UHj4k8HeGRbwJ2gEB/GDyvQ0AnDzv9Ne4rUpz3C3JWZ5Kvx0jqbOEc/b7yBtJxdfSCDIrVCc2R18KqPU
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(336012)(2616005)(107886003)(426003)(1076003)(26005)(86362001)(7636003)(36756003)(82740400003)(356005)(47076005)(4326008)(5660300002)(7696005)(6666004)(36860700001)(54906003)(8936002)(8676002)(70206006)(70586007)(316002)(6916009)(2906002)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 09:30:52.7946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca1edbb-ce16-49b8-6074-08dc09e32ee9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If there is an error in multifd TLS handshake task,
multifd_tls_outgoing_handshake() retrieves the error with
qio_task_propagate_error() but never frees it.

Fix it by freeing the obtained Error.

In addition, the error is not reported at all, so report it with
migrate_set_error().

Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 migration/multifd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 55d5fd55f8..9ac24866ad 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -787,6 +787,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
 
     trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
 
+    migrate_set_error(migrate_get_current(), err);
     /*
      * Error happen, mark multifd_send_thread status as 'quit' although it
      * is not created, and then tell who pay attention to me.
@@ -794,6 +795,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
     p->quit = true;
     qemu_sem_post(&multifd_send_state->channels_ready);
     qemu_sem_post(&p->sem_sync);
+    error_free(err);
 }
 
 static void *multifd_tls_handshake_thread(void *opaque)
-- 
2.26.3


