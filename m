Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F2572BB06
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8d8C-0003NR-Q2; Mon, 12 Jun 2023 04:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1q8d8A-0003NF-A4
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:42:30 -0400
Received: from mail-os0jpn01on2072a.outbound.protection.outlook.com
 ([2a01:111:f403:700c::72a]
 helo=JPN01-OS0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i@zenithal.me>) id 1q8d88-0007Ry-OC
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEQpFJefKASz+A+LdxQkiEZwIjE8QSQMKLGjwPVYkNgu7mpl8KyQT81MRhrHGb+TryyTKYWjZiJ3wDqgG3CC8bCXWHky/MJKA8b/OWQlyw69jayxBRFbMrShfCQa77i8HTUhvs3WP3oiW+WK3VTxAspJ2h9TAuw1e5d7i0DceSU2f0nnXQSYP9Vm75jEHY8S7qNDrqMXQjdOEFXzibqpDJ3cdEH1d4wkeu/shDlET1WhK6p7eXL8RViHzwanCbr4bfSgeRLuvsIq6HGZH0oBqSlRz+E/BPvPnfgwWFBcCAiaEiubSJQMA/BXJBBQrixzh9z1rv0OlrrraY/Gkaa6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pxSxWwi3TDmU+Nq5fkIqjqtz3nJ8lssDKeLI0g1Pw0=;
 b=labeeEJ/4O6duW3rM5K+dcqlKNcx+/h3mP9R46nJMWgBwHr4/x8Nw/5xZs1Bb34tkTCLm27YIvSMdxAZfZzntX4Knxbg8cZiQyGtvhYfj02BHzoxwzmTjGvuacRN9wPWhMKUsfGYAbmcTjw+3gHteEub+RHDItQVSpvFRBN4bZfPwlYbHu2KrjAb5CaE4iyYBQGZzXpyLtaGenKwshw6M8gcjyvfKR1FGG+p1POKdSlrwCaeONydtQPrLfdALSTS/AHh37WPJqerFfo/fUVmy/VIlFAKKcWkAEecWgwXXAAwRPMFZ0Y5xJbBBkGjPhvEcbuSeoC7Ce24ztQ4st4TAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pxSxWwi3TDmU+Nq5fkIqjqtz3nJ8lssDKeLI0g1Pw0=;
 b=h+qYxS70XAySm9aE5aUccT2cyyd2SKiKCHgnXIzt1PEG3Z1vTZgzuTXC6G6GI/x6e/y3h0VIR/fkrvjlnqOuM76q872GXDsgO/3VPdv7R/N27o95ZIABcvVGwTDJ4Mbq/dXYK3kNa0SfHM+M5+Ok+i4nHf/Ty58tFMafU8N7tVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYWP286MB2778.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Mon, 12 Jun 2023 08:42:22 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a0fc:750e:507b:2606]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a0fc:750e:507b:2606%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 08:42:22 +0000
Date: Mon, 12 Jun 2023 16:42:16 +0800
From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
To: Gerd Hoffmann <kraxel@redhat.com>,
	"Canokeys.org" <contact@canokeys.org>
Cc: qemu-devel@nongnu.org, tlaurion <insurgo@riseup.net>
Subject: [PATCH 1/2] docs/system/devices/canokey: fix recursive cloning
Message-ID: <ZIbaaE7OnaG5Vj0L@Sun>
References: <ZIbY8nBXQbv2qZJ8@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIbY8nBXQbv2qZJ8@Sun>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TYWP286MB2778:EE_
X-MS-Office365-Filtering-Correlation-Id: 5598ebc8-f64b-4d80-b83e-08db6b20f0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPZm7dDI34OfND+Z6wVhFsdfv0QeEKOZwodtBxOhlB6fAOYFkWaaZt3E5DQQfFiWU1UIiMo34eQ+46W8YiEGkwCnB5yTmUbPZMEubgTf/4gGm42Lsp7LN8v2lHBmNZ17Q9/QdljLFbHsvi7Lgs+wNZTALxmpYW4pnw8T87t+Ns1qR238u2J6dHcRncHCPuEW0mlIIagbXrKRjAlvRHlO5Ll0ah8kG48szQr66LkIFGKKLPhXOCw0+gCNozLPrpNcvb/H1xe/F/iV0zsvgJNjTBRSvV/R5Ac4yAisFgpI82QttiB/uI2LJ8xEaIGu65UcuxyXOG4H/Dc5Y0TKq6ryuQkKqA1YWARzXC2gaOIy7D1BpXyOjKaVyuAuN9Ta7PlsIpB55KDSyu7+YNZaEecKDSMMqA8uqAJ41dB4C6Z5AG3eCH+YHciIN52J9ySZocvpbxDoT7m9JRUpP+uNi2sWBLhEbhbaNGJBlST9m+qufaBi101iuiQedxh2SanGcd5voCWYcfrSy+u1eUQQeBmbW4147Ks3jIRA+zes935++H7XItGVCMCJ9uFotV8UKqHFp4TstsIVjPS/tOB8nbDaxZZc4ODOavu+4ruCINCjdUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(346002)(376002)(136003)(366004)(396003)(39830400003)(451199021)(86362001)(6486002)(786003)(316002)(8676002)(966005)(33716001)(41300700001)(83380400001)(5660300002)(6512007)(38100700002)(9686003)(6506007)(6666004)(41320700001)(8936002)(66476007)(66556008)(66946007)(4326008)(478600001)(186003)(4744005)(2906002)(110136005)(49092004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxKqaKiWzoDu2NLp8Ly+2s5Jra/IJWRZY5hub4VjJYrXCPoBItz7u6w6FBW8?=
 =?us-ascii?Q?gOL0WAHbYnHdD0DIJjhli8tfUtimEbzcFsXvXXRiO7aIO4W5l7mdoPUCHJAS?=
 =?us-ascii?Q?cdeBdv2yVwhkNtMaAiZLWaOsrDGSU49XsfPPvLkO/liT8E1D1bQROTb3qy/L?=
 =?us-ascii?Q?RcdnuVEASunmDr0ROu3/pknynQgiWlOFl/YyhAaYzVBz00bLIRpjBA/VHjrv?=
 =?us-ascii?Q?4X1/AGMY6NlcpSIlHxt1MxC+MaMHumMmh4B6XMq09DqLxz6Eua07dgsY3auX?=
 =?us-ascii?Q?q1mqlrxmuk04YWkGHLZwPKSMrmEjw5x64SR8Jhwh/62NvqPRiZW5ddXgbTKf?=
 =?us-ascii?Q?dixV1Mse/wP/O035yOouReOsJ9usIrDgiqJnQ4aGF3Se8KP5PzYXashn00em?=
 =?us-ascii?Q?+4luq9b1IUJoLhazutZTINrcjCdfaW48xyiKZPlkDkATr7kXdj+qR4/XAoxn?=
 =?us-ascii?Q?Y5uaEoCTH2eyK7R1ZPUce/IADJfgkiDqPtHUA8IOkaXlU32DYMt9nr6Z3YJa?=
 =?us-ascii?Q?k7gfHHw0pRtnQkLqd3uR+wuleLBXkv8sXVommC9tbrSMWUB9spLcQCINd5fN?=
 =?us-ascii?Q?pCwXbsiSO60Amc9myDnCsfw6Aeiol0K3W1EF2EndQZN1b7xYy01F+isxsJj/?=
 =?us-ascii?Q?gV8MzTLsRuP+D528j0EytKPWE274V0BrL7Bp8HJDyZQD6H4F1yPAE7Ezs1Ur?=
 =?us-ascii?Q?FerQ6EuB9PitnZgZesoohzhHs9hZr/2vrgRwT4NcbPgnt8wKFtn1m5nGlpfi?=
 =?us-ascii?Q?lBdVPxDYuLdLR96Y/ZVuZLyILR2Qeo0m5OTfzASsUfqjErVi5Ni29yLW4M32?=
 =?us-ascii?Q?IuDu4g8sSJoprPVtaezkQZCNKO4VroaemxpkoXWK0w8YLnwb8jWnStuAarPW?=
 =?us-ascii?Q?20/dUlqm32YFlQ0VGIRlOU0C8JJut11SO9GrbEDJuWIRQm/BVwMXRR0buZsW?=
 =?us-ascii?Q?yUnlz6uCo0xJ7WMDrYrhj/7mpKJpgd6skiARWctRN5hS0hZWWjQde4LMN9Oi?=
 =?us-ascii?Q?oopdLy/I/pL1C/ximq/2wXLVMdpVu8xd5fNcgsSmBgb+GeWMEw2n8W0qt1Se?=
 =?us-ascii?Q?qrnwUrOu2dXJWyVazhH3aUS+5hFByUWhY+OUM1KbDO+xPTUZf99y8au3KUn1?=
 =?us-ascii?Q?b2WbiQJlM8Fnl+afroUBQybdt0rHsw4HEJPA6UinUHuEAdCMBfG6Ln9wAJxx?=
 =?us-ascii?Q?IPdspjt6FP2Zm/cRfVdllnw4QkaOWh5JFjFYWRt4lUZW/Mc7Xa73PYl8IyuO?=
 =?us-ascii?Q?MgwVEztgHuCJj92mZN+IjQx0Ib3ZbYqJ3PggI1suhLvIkXT8dgUr6ueD3N/3?=
 =?us-ascii?Q?zAGsGQekTLTzzvuf8iUde8dZAnws4PeTE1fqSrvV5JyGiZ1ShuDydyYWMUwy?=
 =?us-ascii?Q?5xhRyjEK/MwdvKXXvL8cr2wQtuY8n1NFL0ae5om3wrHu5wzEW6jHLUm5TdZw?=
 =?us-ascii?Q?kzh9eHHrHMbxR9tyFjdHavi4LiKZ+ev5NBX+1p9sxDmemEitH3tx42QfCbnL?=
 =?us-ascii?Q?digyDIBBMyYLFdrvOK/deKg1s/5EKAS/LlKSeDSKmmyQ6ZA6O+ca8UC+lV/k?=
 =?us-ascii?Q?SJsFOWZ9Tv7tQYqc07XsjC7eefi9fcGyAOkG59yK?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 5598ebc8-f64b-4d80-b83e-08db6b20f0be
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:42:22.6282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Zm88omhktSOxxHNYR/tPnKibU5jAyXAllIdvIB4h2Jny4VOQdqGVv+CrXCZT3vq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2778
Received-SPF: pass client-ip=2a01:111:f403:700c::72a;
 envelope-from=i@zenithal.me;
 helo=JPN01-OS0-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

canokey-qemu contains submodules so it needs
recursive cloning

Reported-By: tlaurion <insurgo@riseup.net>
Link: https://github.com/canokeys/canokey-qemu/issues/3
Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 docs/system/devices/canokey.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/canokey.rst b/docs/system/devices/canokey.rst
index cfa6186e48..5492e6792c 100644
--- a/docs/system/devices/canokey.rst
+++ b/docs/system/devices/canokey.rst
@@ -53,7 +53,7 @@ libcanokey-qemu is required to use CanoKey QEMU.
 
 .. code-block:: shell
 
-    git clone https://github.com/canokeys/canokey-qemu
+    git clone --recursive https://github.com/canokeys/canokey-qemu
     mkdir canokey-qemu/build
     pushd canokey-qemu/build
 
-- 
2.37.2


