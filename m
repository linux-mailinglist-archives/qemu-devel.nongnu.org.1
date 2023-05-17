Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA2706D5F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:53:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJSW-0003Ot-CD; Wed, 17 May 2023 11:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSS-0003M1-2h
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:56 -0400
Received: from mail-mw2nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::602]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzJSQ-0005wE-6T
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:52:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROAJv+Wc5LOUlCZ01AR0rxYFGFTewAsb34YT92vpNMATiadJ2MJ+vRsbqtKjPlcYYPEoMHZqeeSFuJZoayXHWihtpTmEClgSBVdVsFkaWMQUiSy0JPGFSS/pOPmaO0LKtLpYviBI7UYOc1w7D8syz0HdfcLx4Yb0CZQHxP2fkzo7CDSeMABo7WIk4VKlCofhCZBfXqQljYduuKww1reqcrBfe1e293WCcS6UFgoob37O9mLJb2FrSJsd9ZOTYTdfaj6Y3bzbO7bhd2BDhK5JRLC4nBsDEbizG11a/swgNN6gu180+u4pn6d/4siXX8XmpoYP2gCRU/hjzWg/vdpbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwg/xFQs5M2jSep5gzsnhFAF7zskD7cQHJBRmmfUmBs=;
 b=KrNF/21ZWt9GloN2pq7Z0nPWK5ARjorS0uXx5tMs7kdVHbr/5/Wu5yE8/V7hAY/AbI/eoXdy866xPTzmq3VkTYTMFg7x2fJffYdr2wOuLNdocjxfOB31WQE1MjiIYPT5fg0qV8jyJT1jKvUIe5Y/ONc5KoRCEeMlL84AEpZ5ZGSW95bSr6nyGRAJIhwd9RK7b0gXJkCmzM4gkH/siXYKGLyZTaGhG3MbEEwxP85plW8Um/MM1bZo4DPx6+E8brZTOWX2ehvDoewEboPCC0AfNmWRY35+Jv3p9soqvMWvndFnC0qDVDGsXqM4NskYHrzS5rj8dQ3c4PA9SP3GYFQGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwg/xFQs5M2jSep5gzsnhFAF7zskD7cQHJBRmmfUmBs=;
 b=j0wD5JqvmGvJt6/Sqyo92aR4JNBJDYEpLywBV/SKASyP3TNGNgb2qI8+eWDWidlSinCO3do1fKcO0Zv7vEauD9clQeSIQxANwETCda4ijzm3yVvKzKKoNiVWFjo/E33AbT+iUUo/c85FMMZtvlTp3REVzUOf7NcNOsXX6b0MQNkoJRxNTYPONOoJEE51BhWjcoPlYCA9adlPS/cVMe1MTsyV6K5xyfsOBuo/R2xpvn37W6swqrxAwVUEZgNnZLsnUggoMAMhEw20lamPutzNHspAdG+ZKiI0s0nUXUPeSF60yi4twPBtVYV3YPSjzuXWNLZc9uTJ2WgKFxF3xe5t5g==
Received: from BN0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:e7::21)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 15:52:50 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::ee) by BN0PR03CA0046.outlook.office365.com
 (2603:10b6:408:e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 15:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 15:52:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 08:52:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 17 May 2023 08:52:40 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport;
 Wed, 17 May 2023 08:52:36 -0700
From: Avihai Horon <avihaih@nvidia.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2 3/7] migration: Enable precopy initial data capability
Date: Wed, 17 May 2023 18:52:15 +0300
Message-ID: <20230517155219.10691-4-avihaih@nvidia.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230517155219.10691-1-avihaih@nvidia.com>
References: <20230517155219.10691-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd3a2ff-4480-4c17-b90c-08db56eec46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irNmAnpQaGpp74fMTKw/3GGxvYXhhdCGyL6BYbEPW3/f1bgIcsLJUSpGjnkPlNRb4qONXsCBdZZDadPStGr8gFWUNUfq1dp4hp7Q+kuvlomTwm6gdF6i+pCDs00SNyQD8WNaB1e7rY8tcOf4k+nYxxAUk/WJFXtads16mTjd4iB/pAtf4mZevFZq9HUIZ/Ple203RltmAIATrYvISirSgU1sg9S08Zq9Mdy2C5aXuJ076RyDsX/IYtuA907lbfD6/gcPbKRJ+a4gjB0q6fvrwwnh2I3u1azvngJH9fywkniVbXtq+Qzb7ZZogjgI975tUpl7j0fh4xispKFR3cjlkHtfjWu5h7lK59vFhLTY2MVpEVpkmFZ6mf2Ilpe1e3ZlY+TY45QfwkmAXHkBCtNCQnnpZLNVdVjyAtdMAFsou7R3btThnJ95/SKuWR5l2/TOQud4n+DRDlarHwuj7cuyEIJvNMFDwXWwztC+zC4DS7SOqXkUY6SbrTIaQToSsnx8fqObmV7Tmc4RhS4jQrPH8WbtvxmrAp6mg/xixNQ6XFp3lTbsjNTIsVdxYpcuzKpBK5GCNvSmwVJVZn5hiqIhyK/RosgatsFct0fyaeYbIMyo3D0aOKIeRdnpCS/JVCV392l62/Gv0UBjy89xxwIX+bgOtBFIexyyxo9dP/OlFR9VouJS1D3ILXZzXoFaBH8k+Xue6bM9SdUyEe2BkUjDAdogDE56q9fKYq1DLQc3+/QaPe3va8X2KstpdhsG4ieK
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(70586007)(70206006)(478600001)(54906003)(6916009)(4326008)(316002)(7696005)(6666004)(41300700001)(5660300002)(40460700003)(186003)(1076003)(26005)(8676002)(8936002)(7416002)(40480700001)(4744005)(2616005)(47076005)(2906002)(336012)(36756003)(83380400001)(426003)(36860700001)(82740400003)(82310400005)(356005)(7636003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:52:49.8690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd3a2ff-4480-4c17-b90c-08db56eec46c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
Received-SPF: softfail client-ip=2a01:111:f400:7e89::602;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Now that precopy initial data logic has been implemented, enable the
capability.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/options.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 0a31921a7a..3449ce4f14 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -561,10 +561,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
                              "capability 'return-path'");
             return false;
         }
-
-        /* Disable this capability until it's implemented */
-        error_setg(errp, "'precopy-initial-data' is not implemented yet");
-        return false;
     }
 
     return true;
-- 
2.26.3


