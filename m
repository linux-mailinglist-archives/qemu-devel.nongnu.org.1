Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E357F7D6DEC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:02:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveRy-0003zz-9I; Wed, 25 Oct 2023 10:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRt-0003ze-EE
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:31 -0400
Received: from mail-vi1eur04on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70f]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRr-0005dH-NJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/5Z4XSdqy5J1t0XLADpKpYEs8bEqaGZRwzx6WqDWws2+bIEx1Jpq0vOkiEJjeHw4KK3rjF4nszX/Y1AsWuTYLx3RvNzqmPMi9UK3TY0XFgCMu9AkTqsmAoAXLdeN8IyuQhilh2V6AK+Y9IAfyzEa6rBRuLRuHqzMkX1d3SgBjWk1PCLE/AsJTtcR8KElpPHIYJw0Gnw5YRCTEVDrJbkA7koxmtDS+l5de7tH7NUAX2NtuMbEmp744zo36B58jvEO9qC0DrEP7aiHTKjl+nuVJPhb/Wf9v3PI6t8Ea7Rp0ziYR2dXZPDU+tigHF3aEQ1TTfnKO/Xy/+tjdA9qzCEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9s5W0nSK1DqegJPmFL70njD6Ic22z0A3vfxiaJ87+0=;
 b=bQGvdDe4UCF4Yz7SwbET1tg4b9J0gsS0ovRjIIp2MIdd8tQrS79FhXykF8B+hnWjvhOOBMLQqv6uWYVeLrk0PMQpszK048QxDEYKxBQG4KWTE3Yy9jhzo1RcB7T/f8KNMFXap5UlyBJb9+WYWQuO4PeAHsuq5IK/emuZ8w8nbh5KkBp1iouJG7CjOkUE487JdsEH766gy0vEHhNiHiK4vFz+/LujS+BHf3oz5fk4a8rK9zafR+ba6CaxljZznnwYKOSWaPaynWyYcZKXCss3BQQK61SAbAG8+Ls30ZDFdVVAGroh/VwPuyP6Eg8dyZmO+Unx9HywLD61R5/hQExpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9s5W0nSK1DqegJPmFL70njD6Ic22z0A3vfxiaJ87+0=;
 b=SIZOPJIpTmTaa73dRW9YLXInzSYCKJ3N8v3tD0V5ZKYz/7pFzxYeEdih9xPL2Jbdw42jgRN3Lq38+EOtyxt0M/T/HANSlMqnd8+/bO/aPCynd/ONccFimaCQNFBs/80ovZ0ck4v2MMOp36pFuLTM0xHiUR52MM5KWiw3A4PlaOdh928zBoRX9PE1AL6dJlL09qEZJZP0cLCD7p6cRdQ9MiMtnthPq/CDegL8bFRessN4ImtI0Q57i10VA2fjrBX7DVc/kib2dxjeAGzbw4C5JazfIVzXl0cG2D3htxmrnCpIJcGc/bGMLQjrTC8YjpLdtBYjhhV6Nuoac4gSxpdF1A==
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
Subject: [PATCH 4/6] qga: Add user creation functionality
Date: Wed, 25 Oct 2023 16:00:56 +0200
Message-Id: <20231025140058.113376-5-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 00a22a65-7b7a-4a55-aaac-08dbd562d7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/+KL+cctVPH7qRTzKNc8HcrxCkqmq+d4Gkxhgp/isdzR7Dm4VhVcmpiQ2sQCshA0FI2NZs2eSN2Z5+YeO2zv5Pv4sNTku9JQtDX8yo9knT4tDY0LqrMMmAxm43grFQRYEYeC8L/Uh915JQnzQezltFKLGZYICIJxSUuoVwhC9WvOklMtmRpligN4N1+YWZn5vYCgHFdjAI7/SYvFa4xeitwOXMDCcU5mzBwQKmbBr8pQ+tI/48bymn/OixPF3WG4J9Q7P8Iz2wIpBmYBnM2DMpMJT7HnVNb2XZ0yqTHJUIglssRImE0QIESeYzgXQKgNb4z1b09R/erFdkRgJusFZpnM5w9nIIszoTDzfMXgktww4AiYyB/JPvOpKeLS8hrMmJMNvwE5gY1upY2Uyt9Lvwx4veHGA9VAQFU5IfAGVVc0BBm9NVoHoVHx3GBc9sI0AHW6Omf9n3Mb4Prj4orr+gXuvXwWCxK8ObTgiCnbbXRyIRm9WWdUKUkg12cSxKIdD6NG3XN7VwZyxQ4VQjE8ctLBi+Qm/jcT15noj/MiEHotmVPXxE8KLbe4iWtBAz/Nb8GS3c9PShL8YV1bO/Xa54BsSD+LPxZCl6ZFwQd2dMRaGTWFmWtwRPPimTeSCYJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(66946007)(2616005)(66476007)(316002)(66556008)(6916009)(6666004)(6506007)(478600001)(1076003)(6486002)(6512007)(52116002)(83380400001)(36756003)(44832011)(5660300002)(86362001)(4326008)(8676002)(41300700001)(8936002)(26005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+oSLuH/uBl9+ap7TEmj4S9CC+TJeKbPAr8C2bQHnlHxXhwG1iw0taAqI3qKY?=
 =?us-ascii?Q?RTRMsd90+jciHlaWCWo/NumQSHr5G/AZV/pFA8f2obw6Pwjc5M2OknqtYKUT?=
 =?us-ascii?Q?CQ9ruFufaVszGqvYaUZCqkDyyfHqaYSCSvjjkGe3cmLmCRYcJLCalFK5Cv4Y?=
 =?us-ascii?Q?AimrCTvhdaxa9vtsJ+eO+quEbE08pUdO++4AvSFtQ0nDWwzzzIPq5na1ZNIT?=
 =?us-ascii?Q?UE9shmnp+scCAmG6/5YcNaSRNQmdRjtEf6kqoGRLn7flyR6G+S3Z5DbtbxK0?=
 =?us-ascii?Q?ibRVQ40oX4Gj4FQc10RXRK+UdEKYJFl4bcMRQw6LcIHwOWHv7UDbakDrrsv3?=
 =?us-ascii?Q?VQ0MZMmgpWYpV2Z9zURetVLs8CMxRX+cwQgPBsfDdOvvqCKxtcKSjPmduGSe?=
 =?us-ascii?Q?sATPVPHlUP+h6185GnnnrNo5sbB08oZaCUdWAlZE2NFYPOSDwybyf/Hy9nrm?=
 =?us-ascii?Q?x4QpFI8l+OC63W7zHQj8yy/RpBt/ABhPPEsLCQtXWUzhUj29xn4uSHbDo3Fv?=
 =?us-ascii?Q?6fYClRFKFJHrO/TNbGnGsV9TIzos6TyrITFkS7eobjgaPsZGILdKQTg2DcQZ?=
 =?us-ascii?Q?VmPgcv2Otgkpeye3xUOsVwsejanZEvagy08FN+Hqk2QyDd89mSxFFVgTtPZh?=
 =?us-ascii?Q?yST7baqxS8EDce/P7niEAwp3rNqBrh8uAz7SEPChUES3QZXx7F8gfWybaSRU?=
 =?us-ascii?Q?H0ML0oPBr8J4u+45yhtQq8VAOyeAbfpqJ7WGQDHhEeSPomgIuhVMSugrEZLE?=
 =?us-ascii?Q?XZznJHLUd4gL7PcfJchRbVMjoudc0wD0miKtX0tJzobE9ByVzECmLk5uCCEr?=
 =?us-ascii?Q?emgc0+gUimOh17I7S4wz2Io30cAIwByp1nSsyuxFuWonoOVBtotSHNrh5JY6?=
 =?us-ascii?Q?Wgia0ldmHmIB5ZntsKRJ2hp/aI++aZ6j9Nj0GdRdkwgBiS3yIKh32rY/Xdnv?=
 =?us-ascii?Q?hNvnFaq08KjDfCtGcmXz0frP5/oXzrNIqxhh4iV2pa/NYWcDFwqEJHG29JOC?=
 =?us-ascii?Q?bu/kOrWcAxbvTLVMRpHJHcyLKKQiQAqPialSACKxnxlowTZ24AfjSM25X3qu?=
 =?us-ascii?Q?Kl4td/ui4IVZQw6064bxbnPmiiNEc+1s0C09lRZy0NKQKruKhX0wGHlIuukM?=
 =?us-ascii?Q?l2xVFPmOERtVtoU2opF/3fIgGjDDfpX8sSGe5OF7RgL0tqNZcHK036HleAkm?=
 =?us-ascii?Q?ll96+Yj79OVzlyp+TzHFNqja2IRCgmZ0AQkfbh98bpngs2OB3zRwmefjCleX?=
 =?us-ascii?Q?kljhBDC/3YmdSNRf3klvYKQt+KOEmKoQgISMDE3E3JYvR4QeNYxtWl4BeWI8?=
 =?us-ascii?Q?Nud6zJfG9TmMy+sKz5CFBZ02GLm2KYykj/MXQJNxeo14xkxjZt/3JJDSLvgF?=
 =?us-ascii?Q?UtDKV9tLWTatwlLvVl2qG9e8kuloPRUoqOGHaJAEd5Tf/mqopMRbJUz4DZLg?=
 =?us-ascii?Q?yHK4UZkMgrhSPN1B4gxsmaZ7xBGafh+Nb7aFhl5D0tyBTRNDCOQp6nru7v2q?=
 =?us-ascii?Q?+zDvg2hYGUY5fU6hUdJdd4wIo9MrM2gaqdAja19g4DlZ138aSUAlRVfC7yxk?=
 =?us-ascii?Q?Ip+OaVQmzFP5NMH4od5et0NWrOvtecDcXN+XDHxooHpllFggYzzELZigzTwV?=
 =?us-ascii?Q?RL60/aPUtvs8ShX4H5Vj1FA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a22a65-7b7a-4a55-aaac-08dbd562d7b1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:01:10.6727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcJuuOU+/haR5I/3s0jv/pVIDHXItAzaPX0mggBVMLyaJR+iGHNP2+l+pu9lBWqh7bVu/TFzzRz1ynXgKB+SPMdbytRqyZ2FPR8BhRcxWp4=
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

Add an optional argument "create" to guest-set-user-password command to
create a user with provided username and password.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 qga/commands-posix.c | 19 +++++++++++++++++++
 qga/commands-win32.c | 22 ++++++++++++++++++++++
 qga/qapi-schema.json |  5 ++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 461b4d7bb6..26711a1a72 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2189,6 +2189,7 @@ out:
 void qmp_guest_set_user_password(const char *username,
                                  const char *password,
                                  bool crypted,
+                                 bool has_create, bool create,
                                  Error **errp)
 {
     char *passwd_path = NULL;
@@ -2227,6 +2228,24 @@ void qmp_guest_set_user_password(const char *username,
         goto out;
     }
 
+    /* create new user if requested */
+    if (has_create && create) {
+        char *str = g_shell_quote(username);
+        char *cmd = g_strdup_printf(
+                /* we want output only from useradd command */
+                "id -u %s >/dev/null 2>&1 || useradd -m %s",
+                str, str);
+        const char *argv[] = {
+            "/bin/sh", "-c", cmd, NULL
+        };
+        run_command(argv, NULL, errp);
+        g_free(str);
+        g_free(cmd);
+        if (*errp) {
+            goto out;
+        }
+    }
+
     const char *argv[] = {
 #ifdef __FreeBSD__
         passwd_path, "pw", "usermod", "-n", username,
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 5aa43a9ed7..618d862c00 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1921,6 +1921,7 @@ get_net_error_message(gint error)
 void qmp_guest_set_user_password(const char *username,
                                  const char *password,
                                  bool crypted,
+                                 bool has_create, bool create,
                                  Error **errp)
 {
     NET_API_STATUS nas;
@@ -1952,6 +1953,27 @@ void qmp_guest_set_user_password(const char *username,
         goto done;
     }
 
+    if (has_create && create) {
+        USER_INFO_1 ui = { 0 };
+
+        ui.usri1_name = user;
+        ui.usri1_password = wpass;
+        ui.usri1_priv = USER_PRIV_USER;
+        ui.usri1_flags = UF_SCRIPT | UF_DONT_EXPIRE_PASSWD;
+        nas = NetUserAdd(NULL, 1, (LPBYTE) & ui, NULL);
+
+        if (nas == NERR_Success) {
+            goto done;
+        }
+
+        if (nas != NERR_UserExists) {
+            gchar *msg = get_net_error_message(nas);
+            error_setg(errp, "failed to add user: %s", msg);
+            g_free(msg);
+            goto done;
+        }
+    }
+
     pi1003.usri1003_password = wpass;
     nas = NetUserSetInfo(NULL, user,
                          1003, (LPBYTE)&pi1003,
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b39be4cdc2..e96d463639 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1059,6 +1059,8 @@
 # @password: the new password entry string, base64 encoded
 #
 # @crypted: true if password is already crypt()d, false if raw
+# @create: #optinal user will be created if it does not exist yet.
+#     The default value is false. (since 8.2)
 #
 # If the @crypted flag is true, it is the caller's responsibility to
 # ensure the correct crypt() encryption scheme is used.  This command
@@ -1078,7 +1080,8 @@
 # Since: 2.3
 ##
 { 'command': 'guest-set-user-password',
-  'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' } }
+  'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool',
+  '*create': 'bool' } }
 
 ##
 # @GuestMemoryBlock:
-- 
2.34.1


