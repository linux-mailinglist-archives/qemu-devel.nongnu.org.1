Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB57D6DEA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:02:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveS1-00040Y-KJ; Wed, 25 Oct 2023 10:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRv-0003zj-Se
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:31 -0400
Received: from mail-vi1eur04on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70f]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRu-0005dH-0N
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDbevDX8FtB6TH4ZbBRt99gTtCUWHIUdV1N3b29zwSEUVqjQRIVAoywuvvd/rSozXuMfda/G7eSU+cbwWxPixoHLPDhILJqf7RqgnQ2pPMemUPVISO5yWwmuZqFlT61MFJqzdb5JWF32AbuThTu5HU0kgN53t5o9+aBo9l6Zr3WwlOf75CTf14k7uRs/EH3m5IAL6DhcsZSzKdUcokG8TcnIrMmsMQk/FzZa4pha46zlT1Zm3+DLeRMcdaBz+rB57ieRqghYbP7ThvNmdv+9l5IYlDKmsbX3ohy3FghMUTcrPJmz9nSkehWDBaE8o8NivLGh1o8CNiBFCQ4a5nArVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5VoQPBHvnBJdxo3utUCRy5WdZkxc4cqOEYjXSFJf6U=;
 b=ZJWXbxUjSiRA2ICNKw9MT87TusApUzurlVeKN2WEylraBE9s2cWKE3lfkEzxcp30ywwSsa0pZc9W+CnuCQyPmDb3xDNTH7clsJJqC3ck0nojb+RpXDJDEuKc02cBW6UrQUYmEcxeg/N8wgRt7J5LMktPvyTnV19St9wJqAzpbttPs3ckidaDT83sikG9eqrUM6vKDt08+utUvF6mQhuk3dxtQhxvJT9IMcVoG1YrRlWxOUqVbArJcrmXRsodtazCthG41yZuyPIT78Mxwcm+eIjsfdbHCepF4knCTYasDJy2GAi5N6n3aEYJLUadFSoPgruEY9US3ed3TSbKAF8dBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5VoQPBHvnBJdxo3utUCRy5WdZkxc4cqOEYjXSFJf6U=;
 b=oyNHAnyga15p1AgKV1POasAkcDEtWJV+h/GzkSc1MosK37Km2Pozpfzsa735UFGydDL5lhFi4ySBRQAhMp8b451ag8zpObzD7xmf0Perf+5dnWsdtt1LvWnYjbJxZVChivU/WGQH6pTUN6GoYUSEz04xUUwE/k2EFFhLIlnh6j2tpkKPlSfp7oYhLEX26pDkNiIkE0S+7PHVaShxUAHP+r66k5efYEiaqJSYlTgj/vhpj5L/d2aaR5R7Cjnc1QaMkfHgC7AQd3OKz1W4Y4qp8y77rcua7elFFUYq45wPJi24UcG8p0ya5P1XPOZzCl7RhEUN96y07kpe5I+W6v4FQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB10363.eurprd08.prod.outlook.com
 (2603:10a6:20b:56b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 14:01:11 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6863.043; Wed, 25 Oct 2023
 14:01:11 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
Subject: [PATCH 5/6] qga: Add timeout for fsfreeze
Date: Wed, 25 Oct 2023 16:00:57 +0200
Message-Id: <20231025140058.113376-6-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11326a1f-e1b2-4c6a-0bc5-08dbd562d811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +k6tUvuNXVPtpUJuahSc9s2LqvoZuhPy6NXnFRsg8hNNiu6CsxMj0oeCUMvGodQ9aQyBbrt042xl6T03gE7f7EUhzU87HkAnKHP6Q1BkzrI66jkpaATLNhAOWYO3nmtAamLD8Yzh7FZxO9uJJLtsXnqt3DvOwgRf4iAxHvKLHFzRHrRSFjRGMk+vgvDPyDy71y/tpR+yHXVKNY6JN1sTfl2zdqbZf2MbVVnyQvo/eGWV9Ba1JPqnJWsuGJN5epidpqvHvabBC9LPWaHgBkxIMHrYFqGoFPmxZx26UGWi7g/AI87UwIjP/d5sIqqd6TtmWgkV5D0mNvTqgVvSmXXE0I+uZ5P9DbiA+2y9VFseA3NDVLPJ1s8k8v2nuLG7sFzAPgkAUSVoUiaMmz7sRUDGq2x0+mf8WxsvHBslc7c0vBQEzqfwf57BJwrHAEEw428gYXB2oPcUiwucFeCi/Eaj5pOEaIFhUbBFNZft5MQ+dhtLocWYJJoP/bHgCRnVcL88nPcu9ZENx49iT47L0G+NCfFsTbWfdIot29wBdxy2aTFvfd+uEEt+czSVDb/OIzBg8oD40E34o1+067hjLsBYYDo4pycI6ERESubIM5VIBqXYN/vUoLtbEZN4Kn91dvxl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(66946007)(2616005)(66476007)(316002)(66556008)(6916009)(6666004)(6506007)(478600001)(1076003)(6486002)(6512007)(52116002)(83380400001)(36756003)(44832011)(5660300002)(86362001)(4326008)(8676002)(41300700001)(8936002)(26005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n63HpQFfKcctBt1gx8kgXrEd7aKzdnWZM6DuI/CjAc8Z5Lfx4sikKFMxOygT?=
 =?us-ascii?Q?BlNmHcClZSEEuU5/bOMJY7b+MruVcGweP7Y3dKLz+ZmG3XCZMQFtjLn1BLRS?=
 =?us-ascii?Q?itRhccS/Ww3l9jFTXUqHIYRwhWkO8+P7keXWrmInTUBw8LiiOU4ELrXE4Rvb?=
 =?us-ascii?Q?/zubOoVrgJ/1TyJ2V0sHohAHc90FUMVpkPi2vAlDrPBC1tKE3zig3y4uMzou?=
 =?us-ascii?Q?Hwa4cp/X1+cy/eAeDiHfxmBIzQaq2tV7CTc56C936dLH/fzHDcW3YFtkqUr0?=
 =?us-ascii?Q?nzy5T98XxjitgG9EoJ7MiOT3JsSyawHj3e+GLXG7WTVOoNyUmm3CdBQk7RIp?=
 =?us-ascii?Q?49KNWwc2yhXs5u1LLxHaXs8Tcj3Ds+CnwoLTMWP719Kh80Z1bTZOADZHMOoP?=
 =?us-ascii?Q?NAPa5f7A5k/sG1Bvg8T7PGIWOsskS7bo1dtEcknxJIA4ovdofJuIebfss6Y5?=
 =?us-ascii?Q?nSoCeONsClTzc430vXvTY9J/63PhO4gtLrL6DlUZ7/dRUzDssI7CLA+DxIiw?=
 =?us-ascii?Q?95FPEMB9dr4gHMr0jS8CEE37x0zA+B9DVmOCyHNiXDw3QXMAsYLEk0CyIjRh?=
 =?us-ascii?Q?RrP1S8rIlgSKIjFZ1rSG2RQ4mQVFHI1n0ZDaEgUfLW3jY3KRggwdSfn4ZcnW?=
 =?us-ascii?Q?Ppu+kUh21pExTOTIZhAeYoSCNKk9HtoDG4lVYFXnU3bd2ZDlgYGzbbnp+/G+?=
 =?us-ascii?Q?xWGietXKIoCApVqTtHuaqhN/QIPFGN81C/MwdG789HAfM58eBNRvhMTBI5gn?=
 =?us-ascii?Q?uniV+KWVU6F8PC+FrMSmodtJhbpi1xhRSSrci50EbfNVGSHKnCEHDFSnNQrJ?=
 =?us-ascii?Q?MWMg1lFT1LsPot+eJTMdEoPDiez/QQR/Tj/GlmElgaHvC+yCUlbJjna/yWus?=
 =?us-ascii?Q?EfNgfmdpcus/5tH6oer0Wzv6XDJdY/yfy6os6y9Pcf5htUVa+luPQiwcUoKx?=
 =?us-ascii?Q?l0ZctzdjULG0gLS4n9XHQ69Xm0pZQ0IVIdhN1FctpVVun9Yh7g/W2uhu3hpl?=
 =?us-ascii?Q?iZks7jFrdrHCNJ5xZ+es52LOrVrbvVfsc6XGH6P+jTo6AyZ7URfM7ztPyqqu?=
 =?us-ascii?Q?KVtRYrIw3FJltwQKN/d/u4zI15r3DXRaDogxqWdfl6vq+eIbO4s+Ekm9iHoV?=
 =?us-ascii?Q?cAz62O7RgMQfpxpcTUPDlsF+MTZxLcCppJi9aCZ2GFMbK4EKjSV0VOSEIj2K?=
 =?us-ascii?Q?DnQxWtTNIYb3+64oTPEH7O+cW7q+tfM3peoeoCgaGdAXiM1aLfm57vPF7NYc?=
 =?us-ascii?Q?1qggR3IiA6boSfYeP3V5EkDNZ8FMQygsVQdgD8pdejWUcAUNr7E1N/FubCBN?=
 =?us-ascii?Q?zLxE687SFIKHyBzQjG4WLJMufxoBP4QKy3f7R4MLrMwz2j6jebe2tXVrMEnR?=
 =?us-ascii?Q?XJGwv56jWUXf0lv6Tqvjk23Lcehk+wNe4l0JUyrdNNeYs4Uk1Zgbg4wKYr37?=
 =?us-ascii?Q?oKw+6MAQMU6B9FWm4jTu6Yodoh+dzs6ilkFsVOBHIdI6SZHJ5UaJWRwOCRio?=
 =?us-ascii?Q?SMZlZxLTFaRroWnGDvuqkUYsEa1CEJ6ib0ewhPK8rBWhK4mJ/Z+9VuTwuzi1?=
 =?us-ascii?Q?DFObRd2A2LmSLj6FdBslnwLIopSLtnORNJUK7aY8RJIG/Cp2aJ4od7Dd7n6n?=
 =?us-ascii?Q?mpY+yqVAcTMrOZJ2jiMI5Og=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11326a1f-e1b2-4c6a-0bc5-08dbd562d811
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:01:11.2829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Is1rcGGaaJejeE/CW5knP7czwIhImGthyhmrkYlUocgjJdhExEMtdp+WzBZ9m4fe+me5e8JVjyd1aVk5ZCqtUbRxfAoge45qASHTwJd1vA=
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

In some cases it would be useful to thaw a filesystem by timeout after
freezing this filesystem by guest-fsfreeze-freeze-list. Add an optional
argument "timeout" to the command.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 qga/commands-posix.c   | 21 ++++++++++++++++++---
 qga/commands-win32.c   | 16 ++++++++++++++--
 qga/guest-agent-core.h |  3 ++-
 qga/main.c             | 19 ++++++++++++++++++-
 qga/qapi-schema.json   |  9 ++++++++-
 5 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 26711a1a72..e8a79e0a41 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -707,13 +707,17 @@ GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
     return GUEST_FSFREEZE_STATUS_THAWED;
 }
 
-int64_t qmp_guest_fsfreeze_freeze(Error **errp)
+int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeout,
+                                  Error **errp)
 {
-    return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
+    return qmp_guest_fsfreeze_freeze_list(false, NULL, has_timeout, timeout,
+                                          errp);
 }
 
 int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
                                        strList *mountpoints,
+                                       bool has_timeout,
+                                       int64_t timeout,
                                        Error **errp)
 {
     int ret;
@@ -734,8 +738,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
         return -1;
     }
 
+    if (!has_timeout || timeout < 0) {
+        timeout = 0;
+    }
     /* cannot risk guest agent blocking itself on a write in this state */
-    ga_set_frozen(ga_state);
+    ga_set_frozen(ga_state, timeout);
 
     ret = qmp_guest_fsfreeze_do_freeze_list(has_mountpoints, mountpoints,
                                             mounts, errp);
@@ -780,6 +787,12 @@ static void guest_fsfreeze_cleanup(void)
         }
     }
 }
+
+gboolean ga_frozen_timeout_cb(gpointer data)
+{
+    guest_fsfreeze_cleanup();
+    return G_SOURCE_REMOVE;
+}
 #endif
 
 /* linux-specific implementations. avoid this if at all possible. */
@@ -3119,6 +3132,8 @@ int64_t qmp_guest_fsfreeze_freeze(Error **errp)
 
 int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
                                        strList *mountpoints,
+                                       bool has_timeout,
+                                       int64_t timeout,
                                        Error **errp)
 {
     error_setg(errp, QERR_UNSUPPORTED);
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 618d862c00..51fd6dcd58 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1221,13 +1221,16 @@ GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
  * Freeze local file systems using Volume Shadow-copy Service.
  * The frozen state is limited for up to 10 seconds by VSS.
  */
-int64_t qmp_guest_fsfreeze_freeze(Error **errp)
+int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeout,
+                                  Error **errp)
 {
     return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
 }
 
 int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
                                        strList *mountpoints,
+                                       bool has_timeout,
+                                       int64_t timeout,
                                        Error **errp)
 {
     int i;
@@ -1240,8 +1243,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
 
     slog("guest-fsfreeze called");
 
+    if (!has_timeout || timeout < 0) {
+        timeout = 0;
+    }
     /* cannot risk guest agent blocking itself on a write in this state */
-    ga_set_frozen(ga_state);
+    ga_set_frozen(ga_state, timeout);
 
     qga_vss_fsfreeze(&i, true, mountpoints, &local_err);
     if (local_err) {
@@ -1299,6 +1305,12 @@ static void guest_fsfreeze_cleanup(void)
     vss_deinit(true);
 }
 
+gboolean ga_frozen_timeout_cb(gpointer data)
+{
+    guest_fsfreeze_cleanup();
+    return G_SOURCE_REMOVE;
+}
+
 /*
  * Walk list of mounted file systems in the guest, and discard unused
  * areas.
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index b4e7c52c61..d8d1bb9505 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -39,8 +39,9 @@ void ga_enable_logging(GAState *s);
 void G_GNUC_PRINTF(1, 2) slog(const gchar *fmt, ...);
 void ga_set_response_delimited(GAState *s);
 bool ga_is_frozen(GAState *s);
-void ga_set_frozen(GAState *s);
+void ga_set_frozen(GAState *s, int64_t timeout);
 void ga_unset_frozen(GAState *s);
+gboolean ga_frozen_timeout_cb(gpointer data);
 const char *ga_fsfreeze_hook(GAState *s);
 int64_t ga_get_fd_handle(GAState *s, Error **errp);
 int ga_parse_whence(GuestFileWhence *whence, Error **errp);
diff --git a/qga/main.c b/qga/main.c
index 8668b9f3d3..6c7c7d68d8 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -94,6 +94,7 @@ struct GAState {
         const char *pid_filepath;
     } deferred_options;
 #ifdef CONFIG_FSFREEZE
+    guint frozen_timeout_id;
     const char *fsfreeze_hook;
 #endif
     gchar *pstate_filepath;
@@ -478,7 +479,7 @@ bool ga_is_frozen(GAState *s)
     return s->frozen;
 }
 
-void ga_set_frozen(GAState *s)
+void ga_set_frozen(GAState *s, int64_t timeout)
 {
     if (ga_is_frozen(s)) {
         return;
@@ -492,6 +493,15 @@ void ga_set_frozen(GAState *s)
         g_warning("unable to create %s, fsfreeze may not function properly",
                   s->state_filepath_isfrozen);
     }
+#ifdef CONFIG_FSFREEZE
+    if (timeout) {
+        s->frozen_timeout_id = g_timeout_add_seconds(timeout,
+                                                     ga_frozen_timeout_cb,
+                                                     NULL);
+    } else {
+        s->frozen_timeout_id = 0;
+    }
+#endif
 }
 
 void ga_unset_frozen(GAState *s)
@@ -500,6 +510,13 @@ void ga_unset_frozen(GAState *s)
         return;
     }
 
+#ifdef CONFIG_FSFREEZE
+    /* remove timeout callback */
+    if (s->frozen_timeout_id) {
+        g_source_remove(s->frozen_timeout_id);
+    }
+#endif
+
     /* if we delayed creation/opening of pid/log files due to being
      * in a frozen state at start up, do it now
      */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index e96d463639..29ad342f0a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -440,6 +440,9 @@
 # command succeeded, you may call @guest-fsfreeze-thaw later to
 # unfreeze.
 #
+# @timeout: after this period in seconds filesystems will be thawed
+#     (since 8.2)
+#
 # Note: On Windows, the command is implemented with the help of a
 #     Volume Shadow-copy Service DLL helper.  The frozen state is
 #     limited for up to 10 seconds by VSS.
@@ -452,6 +455,7 @@
 # Since: 0.15.0
 ##
 { 'command': 'guest-fsfreeze-freeze',
+  'data':    { '*timeout': 'int' },
   'returns': 'int' }
 
 ##
@@ -464,13 +468,16 @@
 #     If omitted, every mounted filesystem is frozen.  Invalid mount
 #     points are ignored.
 #
+# @timeout: after this period in seconds filesystems will be thawed
+#     (since 8.2)
+#
 # Returns: Number of file systems currently frozen.  On error, all
 #     filesystems will be thawed.
 #
 # Since: 2.2
 ##
 { 'command': 'guest-fsfreeze-freeze-list',
-  'data':    { '*mountpoints': ['str'] },
+  'data':    { '*mountpoints': ['str'], '*timeout': 'int' },
   'returns': 'int' }
 
 ##
-- 
2.34.1


