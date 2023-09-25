Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76B7ADF94
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrE9-0003Rq-4m; Mon, 25 Sep 2023 15:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDt-0003F8-W1
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qkrDr-00023z-Rb
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695669983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRqRj5jm1rRUFQPsmG7EYknr2RpaIYkSYftxX1+25PQ=;
 b=I8zuJM7HfzaPz2Y4xkewg60jL1MMKnHFwiHW78konZ6YLy2+/q7zH4kIg0hlmF0HPkyF67
 GmvxJ95hrg51Dh0zTWog6yF6MWPlAATTc9wy/B2b/L8CnWv0qk3es67hIAadTN+IXuZE4k
 Ohhvm3Thsvqt/MmEbHRHWv1w4fLVNqQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-wq0_iFgaMCWfWL8ctvcVPw-1; Mon, 25 Sep 2023 15:26:17 -0400
X-MC-Unique: wq0_iFgaMCWfWL8ctvcVPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 949CD29AB412;
 Mon, 25 Sep 2023 19:26:17 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE2751E3;
 Mon, 25 Sep 2023 19:26:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: libguestfs@redhat.com,
	qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH v7 05/12] nbd/server: Enable initial support for extended
 headers
Date: Mon, 25 Sep 2023 14:22:35 -0500
Message-ID: <20230925192229.3186470-19-eblake@redhat.com>
In-Reply-To: <20230925192229.3186470-14-eblake@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Time to start supporting clients that request extended headers.  Now
we can finally reach the code added across several previous patches.

Even though the NBD spec has been altered to allow us to accept
NBD_CMD_READ larger than the max payload size (provided our response
is a hole or broken up over more than one data chunk), we are not
planning to take advantage of that, and continue to cap NBD_CMD_READ
to 32M regardless of header size.

For NBD_CMD_WRITE_ZEROES and NBD_CMD_TRIM, the block layer already
supports 64-bit operations without any effort on our part.  For
NBD_CMD_BLOCK_STATUS, the client's length is a hint, and the previous
patch took care of implementing the required
NBD_REPLY_TYPE_BLOCK_STATUS_EXT.

We do not yet support clients that want to do request payload
filtering of NBD_CMD_BLOCK_STATUS; that will be added in later
patches, but is not essential for qemu as a client since qemu only
requests the single context base:allocation.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v5: add R-b, s/8.1/8.2/

v4: split out parts into earlier patches, rebase to earlier changes,
simplify handling of generic replies, retitle (compare to v3 9/14)
---
 docs/interop/nbd.txt |  1 +
 nbd/server.c         | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
index f5ca25174a6..9aae5e1f294 100644
--- a/docs/interop/nbd.txt
+++ b/docs/interop/nbd.txt
@@ -69,3 +69,4 @@ NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
 NBD_CMD_FLAG_FAST_ZERO
 * 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
 * 7.1: NBD_FLAG_CAN_MULTI_CONN for shareable writable exports
+* 8.2: NBD_OPT_EXTENDED_HEADERS
diff --git a/nbd/server.c b/nbd/server.c
index 8448167b12a..b09ee44c159 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -482,6 +482,10 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
         [10 .. 133]   reserved     (0) [unless no_zeroes]
      */
     trace_nbd_negotiate_handle_export_name();
+    if (client->mode >= NBD_MODE_EXTENDED) {
+        error_setg(errp, "Extended headers already negotiated");
+        return -EINVAL;
+    }
     if (client->optlen > NBD_MAX_STRING_SIZE) {
         error_setg(errp, "Bad length received");
         return -EINVAL;
@@ -1264,6 +1268,10 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
             case NBD_OPT_STRUCTURED_REPLY:
                 if (length) {
                     ret = nbd_reject_length(client, false, errp);
+                } else if (client->mode >= NBD_MODE_EXTENDED) {
+                    ret = nbd_negotiate_send_rep_err(
+                        client, NBD_REP_ERR_EXT_HEADER_REQD, errp,
+                        "extended headers already negotiated");
                 } else if (client->mode >= NBD_MODE_STRUCTURED) {
                     ret = nbd_negotiate_send_rep_err(
                         client, NBD_REP_ERR_INVALID, errp,
@@ -1280,6 +1288,19 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
                                                  errp);
                 break;

+            case NBD_OPT_EXTENDED_HEADERS:
+                if (length) {
+                    ret = nbd_reject_length(client, false, errp);
+                } else if (client->mode >= NBD_MODE_EXTENDED) {
+                    ret = nbd_negotiate_send_rep_err(
+                        client, NBD_REP_ERR_INVALID, errp,
+                        "extended headers already negotiated");
+                } else {
+                    ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
+                    client->mode = NBD_MODE_EXTENDED;
+                }
+                break;
+
             default:
                 ret = nbd_opt_drop(client, NBD_REP_ERR_UNSUP, errp,
                                    "Unsupported option %" PRIu32 " (%s)",
-- 
2.41.0


