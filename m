Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC17D6DE7
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:02:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveRv-0003zd-SY; Wed, 25 Oct 2023 10:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRr-0003z6-CD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:27 -0400
Received: from mail-vi1eur04on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70f]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRp-0005dH-PQ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZaXwAFp+kGsASfBibVxBO9ZWn5G9hBvdlE9B3bjwN5MtM8hbQiYtzqqV00DtquIlWqIImoGxQKOFaDOjNZTboIVg+weu33SUYxSekbTDHpYMkLtUmZH8jnOKklwaZ/2Br7sWVwgi8SSXp0EWQ7y2og7Ol8Lfb1mozMDyB+P3zzghi1B7lgQbzX08B3fMHodizu1mYgQjaXRyNB617W5gC7SyNej8+/Inv1EtCpFjmjvFsjYYZ5c1IFbhXyr3dC+W6v4iTVd7YlGPpbNOrHBwPabqfkXTnKddHcYo9zX/zZ81xKBOykLa16riPMJUQ9pQPwVB/0DvPnJHCAyrmzd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1j6wdAPLklf+4ZSuJxzVOi4eVpH21DF166Vux9f7w8=;
 b=isu2rSsZpPRbr5YxHPwjf3XEkYtbeAIWxXmmD5q71sYinmrjEYBwj2C/QpSg4UHyNF5DM7luNedcKxTEttG6ISEuZJDHTf1bP7lg12BQCQwQYKmk6jq0c5YvH7DGrjLa1L6SBe5eGNtNSkqUp+svHWtyjpmk7tsD25JNaBQWN4+pbBx7B/MTzM5jZvy5/H5C63+8Tra31y7uc41bhj3cjqrKHSPCPpX9oaWfZ5xYF3mAhTrN6SyO8V+DwjSYipTr1Fw2QRCP4mTXTe9n+oXqtONcSNpj1VaHngwT/6dglSRqLpVRg0/P7859OYzcEXlVwiXqSKcpJIOcbJs1YDII2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1j6wdAPLklf+4ZSuJxzVOi4eVpH21DF166Vux9f7w8=;
 b=HA3dcON8Sit+VN3K1+04JZQNbo/xWbqsVe0mWSI/z1HyOeEbQsXjSPg/JGXsFwcTrIiNoh+8jmWqGTsnqB4fqG6YoH6ridhZfrTcx5J47WqQEfp0J0kDm1sCPimyp0IGoSfYrRjtAF2cK0Od8Fmty21fpUwRoIqJksXYhWE2qFTHZkF9wowWi6ooi5oIdZB0teqzjZGmQ5Jp2WBH1FtzIGW3N1q7mZbAlNuDpJF1/BU5ghbJkYlbb/ZL0/8KEoUKQ4jklsACo/4vPap4uF9eyKuv1W92NyBuIZCfKWmjugPd3Lz+lTiWm3E5cOPTwApjm11jxhRz4YU7C8H5cGJfGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB10363.eurprd08.prod.outlook.com
 (2603:10a6:20b:56b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 14:01:10 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6863.043; Wed, 25 Oct 2023
 14:01:10 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
Subject: [PATCH 3/6] qga: Let run_command() work without input data
Date: Wed, 25 Oct 2023 16:00:55 +0200
Message-Id: <20231025140058.113376-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0167.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::24) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB10363:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd76c85-6880-4f70-846a-08dbd562d76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKmpZiUV7/dh804G1mwO34hSJaHY56AyNeQcrNrmORCKviKAF9o3UyQr0l2gU+bX1lVKEDeTIaaaHfyVpDVI5+2t1TBpNEq0dnPF1LskDIh/pl7RNvfXouDMsIWAuNx0TAR9U39R3ke6m0bzEQDSR0DI0ZCZGBSy1/rZuNSzTdNlwjGMjy3WehZ5fSbcrYzgTwi4G1ZFnk0d6r6BC+ajxDJC2zzDi8qfgbTmxY8fMoV6q2dHVx+iet5ctH8B7ICsvmec+WgK+jxDAFVxO3nYkyhS33XUGVQ3ql8XDzW5OZ0iJ8hKzYmeCiFBxTWrYAC+qyoUIuUSWtAnNpszj0rOEvLpmwRdBBUrpLcXybxitmt8oeRJvv9Hs52mxvhqAPZRXAx83bEnlCyN709kmWsbzoECGrqZlrfIq2DKGYI0AjiPFx/o3V1x/cgGocl1MbmWZhglBpKMAm/Z+YLukqrLHjFCJoS385SYCpxii9BxgnmphC/9CLOUCjQHaFbDqrE52tSFEFUWZGiexuU9jSBUX0qVOHmsYS4lAKdxKw+xfMuprVqzDkB3K/FNWaqmJjoV/dVPDVt0+ceUHYIwVuAOP4wV1Wr4oK+KONfI2eTfFzXt4pDF3fQwINsOzMgPItUh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(66946007)(2616005)(66476007)(316002)(66556008)(6916009)(6666004)(6506007)(478600001)(1076003)(6486002)(6512007)(52116002)(83380400001)(36756003)(44832011)(5660300002)(86362001)(4326008)(8676002)(41300700001)(8936002)(26005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j9f6H22wxaouXW8fyDhrR2oelx4eRMgBsd/tvDrx6JDhezlXawlriUaTumcz?=
 =?us-ascii?Q?wNAViv7JAUEfNdUBNIUpry4twhIkKVgszhVDPuHyUV6IAsnSm1CQDP7eflnz?=
 =?us-ascii?Q?/W0dSBDiI3rOUwqsYHn+RRjqcNiRe5rtWyvhBhpK64xc5G8uAhXXNDKtl6cL?=
 =?us-ascii?Q?iLKl8Zfxp9rB7JfymgAdpNflW6qOrP0bguX5vPRqX5DSEdwBCVzC1flSo7gA?=
 =?us-ascii?Q?m/QqUtfD41QfgF3jivcmtMMcucf9th8zlKXVxRY2GK6hEdFmnbhCDpHyCWzb?=
 =?us-ascii?Q?MoZPSaz0m/mMbL/NoY6Duck2poXkwTHqs13cjTcoXHlhHVqTaJXfU4SQQtyQ?=
 =?us-ascii?Q?W2cC2OJX9br2CHhJvagnDTumwNNrLTHkmEF29RCIoWh8tgCjwp90IhKSba0C?=
 =?us-ascii?Q?dZGbx/hENJwRm9DlIoEB/i7sFurMUA/+Sp+gXc3wlpwt1M24XI3Q3eVoVHyJ?=
 =?us-ascii?Q?CSGUE+3CBQw27OTTjuaANwJ3k6pZmCha4noHqNNhsGnB/5GiJIHkQri68tFX?=
 =?us-ascii?Q?t55EB2q5LbvVaOQzd3c+SknmjUJvnpTYMOZnjWr/nCXMCzdRXLrXYg/A2eDc?=
 =?us-ascii?Q?7LetbFubNr+NLi+nZ7l71ucCTOOIR24lEPiJXSQkVrvL1DqRj8ai6OIzhfSa?=
 =?us-ascii?Q?C0HEvCQB2Ipq/k+UF4tOWxVaas/JMWBgfO4Hwhx8EUpsX20MouPC3v/C/cEE?=
 =?us-ascii?Q?iSzKmSvIFILmEUvI0SLssNXlGn0wTvU/+Qv/IkugeFqnt8kakCeX0iuegyTe?=
 =?us-ascii?Q?hFOsf24+cE+coUJ73WhsFzJHdaFxLo5KQ0V8YYeKgAQb/4NvnRHOndebR1GZ?=
 =?us-ascii?Q?DuNw+kEcxiSrqLASM7lF5Ocfls0kh8QndF2ejtfaFkWFYOzhpZbVqKGKP/Wd?=
 =?us-ascii?Q?su4ZTyiwGVeXwBJBOytF6kvbrOguhhHnuePFOiykWCzBzCJR8hTlT6f8Lssv?=
 =?us-ascii?Q?C5lSK+pTxT/98sB8EL0OaHzvKgL3p6svEpa+2d+9WIo56w65viooY/bTYETW?=
 =?us-ascii?Q?tIYGtdHI8NOzsM7AN03lLtYa2q5obC3C0EQ5H1vknANZb4aS0URcYM+Q2no5?=
 =?us-ascii?Q?oDfxa2pUSnhZp7hRT3n1mmKk48Lan1B4oKcOSvDAGvSBR3T3LhW6QfWCH/XM?=
 =?us-ascii?Q?qZzQOx++el4JgfghwK2mbtwX6yVysPwcL9JS529Hbl2J5lGj3GXtY2kj2Qa8?=
 =?us-ascii?Q?hBWjy411D1ZAnhUQEI1hBsRw9t0ashHjZ22cQBqf5noFzaCtlkp13qYXl+kj?=
 =?us-ascii?Q?eP8kDczlax0UvUg08mQi8kaFXzVPFoLSYDiaqiL0J16lc8jS21Io1I5SsiR2?=
 =?us-ascii?Q?yU6p2k/AY3OaaQMxXyWLcyybUZxsw8YkzsLQQGLDNmQK+u2Af+KWWpI2JDGx?=
 =?us-ascii?Q?VuBErWwdwzxqQzGUXW1b+9PCnQXodbSHNA9YaToyQatYrdDNnBdUJGXfH5Ep?=
 =?us-ascii?Q?bpuifnYoQeqL85R0lLY4fFadPrqrXFCRN1etafTBnkgFF9tisD1oN6XYwwwa?=
 =?us-ascii?Q?7nnhM8JV87oV/miqhbiq6022EctZ15L8peFxGb3BxSvFJYvhl/KSfd5nwyIp?=
 =?us-ascii?Q?/cu7qwTf88m5/5rRWlI+7mcOBQjYJVf4uSuUCW8QBATgmNjfIOaTGQlPuXr3?=
 =?us-ascii?Q?4DGBMYyoWp/767kEicMVVG4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd76c85-6880-4f70-846a-08dbd562d76c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:01:10.2009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYN2aLRAtWUbvEPWPqrEgvArREIFsCnMkZ/mpnwaGjwXTkakNXKHB1I7fWC4/sDHe+N8Tn81ohQIAN4AIxdkse3VAgL3IJqWcypo55tDok0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10363
Received-SPF: pass client-ip=2a01:111:f400:fe0e::70f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

run_command() has in_str argument that specifies the input string.
Let it be NULL if there is no input.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 qga/commands-posix.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index e7b82aaf37..461b4d7bb6 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2122,16 +2122,22 @@ static void run_command(const char *argv[], const char *in_str, Error **errp)
     int in_len, status;
     int datafd[2] = { -1, -1 };
 
-    if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
-        error_setg(errp, "cannot create pipe FDs");
-        goto out;
+    if (in_str) {
+        if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
+            error_setg(errp, "cannot create pipe FDs");
+            goto out;
+        }
     }
 
     pid = fork();
     if (pid == 0) {
-        close(datafd[1]);
         setsid();
-        dup2(datafd[0], 0);
+        if (in_str) {
+            close(datafd[1]);
+            dup2(datafd[0], 0);
+        } else {
+            reopen_fd_to_null(0);
+        }
         reopen_fd_to_null(1);
         reopen_fd_to_null(2);
 
@@ -2141,17 +2147,20 @@ static void run_command(const char *argv[], const char *in_str, Error **errp)
         error_setg_errno(errp, errno, "failed to create child process");
         goto out;
     }
-    close(datafd[0]);
-    datafd[0] = -1;
 
-    in_len = strlen(in_str);
+    if (in_str) {
+        close(datafd[0]);
+        datafd[0] = -1;
 
-    if (qemu_write_full(datafd[1], in_str, in_len) != in_len) {
-        error_setg_errno(errp, errno, "cannot write new account password");
-        goto out;
+        in_len = strlen(in_str);
+        if (qemu_write_full(datafd[1], in_str, in_len) != in_len) {
+            error_setg_errno(errp, errno, "cannot write new account password");
+            goto out;
+        }
+
+        close(datafd[1]);
+        datafd[1] = -1;
     }
-    close(datafd[1]);
-    datafd[1] = -1;
 
     ga_wait_child(pid, &status, &local_err);
     if (local_err) {
-- 
2.34.1


