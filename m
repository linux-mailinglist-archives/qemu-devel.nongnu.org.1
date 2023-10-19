Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 696EE7CFA63
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSdI-000689-Rn; Thu, 19 Oct 2023 09:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScc-0005sK-MF; Thu, 19 Oct 2023 08:59:30 -0400
Received: from mail-db8eur05on20717.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::717]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtSca-0002iq-Rz; Thu, 19 Oct 2023 08:59:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8awAWzVBXyE5yZwyYxUoMvU8TBnff11h6u9pnLVsQ1EtJWOmpjSmrLJLehWNIwh8nZkyz/426IkMXQX1kktTrdKtNHDcb6d0+keL8aau/Bm5tQiqEtCA/cZ9D+Sqw/LxP+hBLV7gTGhZEr/iyZ+CrMPp6EWaAcKWLO5q2/ix82++YObAZk6oEjwor9B16H6+s8JFbKpp+G6R6ohvMi7jnMh5qfcZ0TnullG3/dGIAjQAHP5fxJHVXPuwfpNZtMdVN71C7LKRb35cUVvpe6znXTJEa5znSC1zUKZSmZkQd7ygEYBBW+1CiLBkkqiQZbl0vIUPQ5cHcQwG+9UQRLlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djhWzR1OD9wSw+5JwkKqbMpl26LmShHjJ4ERxNNSq+8=;
 b=SYZMcvU9ls2HHyTZbSO/e5Hqtzh0s+1/QjPdAJ61vff4cnoaIVF+mCKITTl+p8kytQX0FfCUBEs9NyOroZtHH+4H/MfF0ObAxsT3V2hq40VWPs+G2cZzQ9gzSgo6GUELQPdnwGCwl+KTU2YJio2R0iVXaJoIZpWzwS4EITV9YKyrIHJvfRLwGw0NdmwFzQLjmq1Frw/8ldAu36k3PoK7iqjaqyzrT9GwF3Ya68VtA7/mA/I/w9AlLxp25SCLwhDRt2v0gc1+IXpEzt9kkHoAteaeg/dNwapvXxHDqN7MfGofPpNJUnm5HHy5eRrIRnoBLwiYr99JLeVuHZf4ILJZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djhWzR1OD9wSw+5JwkKqbMpl26LmShHjJ4ERxNNSq+8=;
 b=Ik2Pgt2H8v0t1JIhUP4qghXXKswtVDO+8ERXC35w+rqYDepF//SoydKa5Qf0LKgqTkQjvJGlXO1mNz2fT6MDhUUj5C3n9KdyPdyVjjdof1UM0/1X5G0zM8zbKf0zcBtkTZxmwgybdD6NjFs/DKQsobVrH52ubH8NnLmTiL8dO6PtQYI3DEqUFkasVUQOcnY+bxj6ZkWmATWae9gu9A2CF+4XLdrSvaClqNs9iWyndJ2VoSe1n2OaOX37ou2ceqwFy/zLEuo0jUvxPje3fwzAd2EJXw4oVYHZ9xT5HbDKgG2nLH4NPv1VjyJ6HF8yMUN6rACODR4gNFmSD88D/Z2E6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:19 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:19 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 19/20] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Thu, 19 Oct 2023 14:58:53 +0200
Message-Id: <20231019125854.390385-20-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: d91f73fa-9465-48be-cd94-08dbd0a334f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZdXcOMYQN3fp8s2QzsVt632KKFvkZkL1CG+MI3Qo/dEWKJab8yI5eu4drzSpsqCD3gPgberOVf0EjiYlZiDZ+aFTk1MmG4Tv3AFqkHYa8McSgvmxaTVOuTdDJd2pOinmutFGYIgXMaPLLQGAWmiu4oIWpB8vU7vroQRO/MiLGTiEgDjLCePLG8V9w3I8SNmo2vGIty1a54hRdAcZHgyXRbb8QcJw/phXxWtHWuzywqCKw5LenxRzmJnWQ6Iu6obnbwcNaToyt/tjyYPEoS6Wv5r5N98nNr1TvxKCg1sgZhb3JVmvAtvaAGIc9R7SUzK3leZpNwkMfxw8CDC+oD0TTvHtxDDEOPLbGEp8rlAMhKG3Zte8ZcJI+yghNELBHQ+TnwShxOf7IkU4I9cMI8HOL3lROcVJC6bUd3pHLSqYO5kMuoFybL0/iraXfNOGcm1yLF1hbpU7EzqqBUikQo/vEl+pySMkbJEEdEB6HH56m8AXTXpU3Zum1ADHb9Dr6PZXNanjJtTg8LIHgZqjx9iYk9QnmsCd35mhvxrHBvlraXJfdZ/BiCXL/Nepskgh+8N5zXLwXU4psdcPDfZY+HrI8tpoxwhzNVwkOSCvAbRpv37wM9n7EN/b9cj3U42ZOqT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pVVYtiPKosTVgB2CfzBcyQkpNFN7IU+j0FXDa8aDlGWZI9tF1Ojg0BkYmOFz?=
 =?us-ascii?Q?7wjKEa55BLtxsIEDVUTewHvie7TMh7k20np4WEzbsjVjm/n0XGsBxBZewVrr?=
 =?us-ascii?Q?q+0D3UsdzqYMW19jiI57LoXfunB1hHJ93/oMO4yKsvN8TQoNE8jbVGseZesr?=
 =?us-ascii?Q?4F3u2dHNxwDmscJUdCONBvtuKj3SgUd4UDQGCxIChG88j9jQPf3Qgkg6WdtS?=
 =?us-ascii?Q?RvoFYnXfZGUHa/GKtY+OB6XVGrIExed4aUIQO0rFNvSqUx72pSSyLAI/MiTS?=
 =?us-ascii?Q?3b6uTSHx3Jh2E6ihsHr5NHwcVmBCB2ySZFX3mpyIWhkAIIYoYPkXhaFMMM8k?=
 =?us-ascii?Q?0sOtzhCYGJNLiczY8y9JbzsBybXujuAgYccIvVZKslY5hgjzsVMgEZULuM73?=
 =?us-ascii?Q?MELbvM8M1dK67LCGGmE4lQIRihPAuU0xHyDW0EdMBSeMqYJRXVAQ5huA6v3n?=
 =?us-ascii?Q?yvzqAbT0aG16m3m9gTyaVXj3936DvQEladnl0puTreLn39cWc5tGfX9FijEC?=
 =?us-ascii?Q?JOipPiiEAcSzIUKxAKDWmAem8Nc7bZ/gI4XTuPlbJyHoouHiOCTHAF2l73go?=
 =?us-ascii?Q?FG0A4/zZI300zWIy8FDTJSFqxpUcpsELPEyXGGBvl0F9YG26kh4CpqqQmGzE?=
 =?us-ascii?Q?VPhgwAdIUhDVyykfH9jGICSh6LFzUrLfTh8te+TYZjDZ4pyLt1z8Uns6a3GI?=
 =?us-ascii?Q?G2970Pom/hreds31Uf+eCwlu9RQl4VfJpJ7Q2Vz8JpeV8rbjuDemCz6iVXE5?=
 =?us-ascii?Q?EuGHnvBeZAG/lzC1g1vWBUuOYoCAPDk3ZBH20PVU4icgf1dNXEM0zM4tmi/b?=
 =?us-ascii?Q?3+Ot3GJGC/dOddS7ZJmt+b9NfNj2zmEfa4VDrH7TEJjAzRKbheQhSjjQXdkg?=
 =?us-ascii?Q?DVq6UEzqNZZJpzl+3alf1SNv7hiw/Uxf/Xg3it+wMgCA0yCCkQNb7xCha2FA?=
 =?us-ascii?Q?vwtmxWxtFdfKQrcclEqmb1oHcO0EHO6TU1UxnxG7ahKN8pU2lw4DjMIZhKiQ?=
 =?us-ascii?Q?0usTpMIKVYY9PlhWHnLTOgdfH90+P9daOm5c8b/RelYBRciVsBgzVecviuKK?=
 =?us-ascii?Q?/MAmcYwnU4dOIPYOxzoVL2oAsNGZHCsyI69ISBugwGuOU/TJQIMtUR9sq+eY?=
 =?us-ascii?Q?HWRPEyV2h7r/13YRISyvNGCKLCTxoguAmjL3ZouK4VhgaCsGLvErBpLzBT/7?=
 =?us-ascii?Q?FvnKA3cdf1LG1i1tOD5x60dRi/tBzOeykcLBAPZJscmMOch6S7H5reUC6UTX?=
 =?us-ascii?Q?37rcfg3513Qy9Jfjm0GGInPk/02e/0bRC9poz0T/ZUiNciCMSMwUVu9PfVVi?=
 =?us-ascii?Q?qEgqKgLI9P1KXHM5vq3VTo5Cvx1IhCPqZAn5SAuljJNpMjbYwfOOVyZjN99y?=
 =?us-ascii?Q?Yk0ctbY75KMeXpwZCxSJnU4mGW+5ejRqCzV/rldAWkV8lS/MmzWa0B4b0cF9?=
 =?us-ascii?Q?U2XIZ++HleY9l138q8babU/u+/VNYg70ZBr+cRpXuo7GvBT0G9W/bg5U2pnz?=
 =?us-ascii?Q?W0+9gvyk2tNFUumRFC9aS0ull96eFCBzMDSc20tIAl/UEiEgNPD3PMoff4A9?=
 =?us-ascii?Q?qEHFSwWRl5klqLd6SBQbHYzXXWwhSv0mvlIobUUB360fjqw06uDbyh2TTf/K?=
 =?us-ascii?Q?/98fb07SgUpws3cij7cfVTM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91f73fa-9465-48be-cd94-08dbd0a334f6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:19.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyqXhERcCeuESKzhwc8Tz6SIB1CnJ8ZJawhvXvxYGmPnk9x+xURJCAt1AeF9ThvHRhgFkTRZHlNQZwd6AsaXmeNS5yM2DnmV+6dJzvsv52c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::717;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These tests pass with parallels format. Add parallels to supporting
formats for these tests.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/256                      | 2 +-
 tests/qemu-iotests/299                      | 2 +-
 tests/qemu-iotests/304                      | 2 +-
 tests/qemu-iotests/tests/block-status-cache | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index f34af6cef7..1a4c9c6885 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -26,7 +26,7 @@ from iotests import log
 
 iotests.verify_virtio_scsi_pci_or_ccw()
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'])
 size = 64 * 1024 * 1024
 
 with iotests.FilePath('img0') as img0_path, \
diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
index a7122941fd..d8c4399446 100755
--- a/tests/qemu-iotests/299
+++ b/tests/qemu-iotests/299
@@ -23,7 +23,7 @@ import iotests
 
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
 )
 
 nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index 198f282087..1ebf999930 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -23,7 +23,7 @@
 import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
 
-iotests.script_initialize(supported_fmts=['qcow2'],
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'],
                           supported_protocols=['file'])
 
 test_img = file_path('test.qcow2')
diff --git a/tests/qemu-iotests/tests/block-status-cache b/tests/qemu-iotests/tests/block-status-cache
index 5a7bc2c149..ade3d5b169 100755
--- a/tests/qemu-iotests/tests/block-status-cache
+++ b/tests/qemu-iotests/tests/block-status-cache
@@ -131,5 +131,5 @@ class TestBscWithNbd(iotests.QMPTestCase):
 if __name__ == '__main__':
     # The block-status cache only works on the protocol layer, so to test it,
     # we can only use the raw format
-    iotests.main(supported_fmts=['raw'],
+    iotests.main(supported_fmts=['raw', 'parallels'],
                  supported_protocols=['file'])
-- 
2.34.1


