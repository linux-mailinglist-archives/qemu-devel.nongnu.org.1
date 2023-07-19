Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC677759FFD
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDvG-00063l-ES; Wed, 19 Jul 2023 16:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDvB-000601-JC
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv7-0001op-Kh
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689799032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ELlNn2jEd3BrZ/cNFLVn+OpiYlQZCkwS6oxnIlZrSw=;
 b=TEvY1NhAndmbTcquCmWQ3uRdxLbVN3BV3rdziiu55+V6DVeW8raNGHNTbIE1Hd4v+jEKxR
 IdsjI2VnTXY4HClNnQ8I1yV+iVEXQj4D3wP9PKExsvOCxzd6G+dOifY4HTzu8Ey137clG7
 hbAP84GtnPrncyzAfHDwezvFe3BTVTQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-p5EXd2nyPZ2N42lkp7_H_g-1; Wed, 19 Jul 2023 16:37:07 -0400
X-MC-Unique: p5EXd2nyPZ2N42lkp7_H_g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7164E38117F3;
 Wed, 19 Jul 2023 20:37:07 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F13804CD0F5;
 Wed, 19 Jul 2023 20:37:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 08/14] nbd: Consistent typedef usage in header
Date: Wed, 19 Jul 2023 15:27:45 -0500
Message-ID: <20230719202736.2675295-24-eblake@redhat.com>
In-Reply-To: <20230719202736.2675295-16-eblake@redhat.com>
References: <20230719202736.2675295-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We had a mix of struct declarations followed by typedefs, and direct
struct definitions as part of a typedef.  Pick a single style.  Also
float forward declarations of opaque types to the top of the file,
rather than interspersed with function declarations, which will help a
future patch that wants to expose yet another opaque type that will be
referenced in NBDRequest.  No semantic impact.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230608135653.2918540-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
[eblake: alter patch per mailing list feedback]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index a4c98169c39..9dcb5357d15 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2022 Red Hat, Inc.
+ *  Copyright Red Hat
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -26,24 +26,26 @@
 #include "qapi/error.h"
 #include "qemu/bswap.h"

+typedef struct NBDExport NBDExport;
+typedef struct NBDClient NBDClient;
+typedef struct NBDClientConnection NBDClientConnection;
+
 extern const BlockExportDriver blk_exp_nbd;

 /* Handshake phase structs - this struct is passed on the wire */

-struct NBDOption {
+typedef struct NBDOption {
     uint64_t magic; /* NBD_OPTS_MAGIC */
     uint32_t option; /* NBD_OPT_* */
     uint32_t length;
-} QEMU_PACKED;
-typedef struct NBDOption NBDOption;
+} QEMU_PACKED NBDOption;

-struct NBDOptionReply {
+typedef struct NBDOptionReply {
     uint64_t magic; /* NBD_REP_MAGIC */
     uint32_t option; /* NBD_OPT_* */
     uint32_t type; /* NBD_REP_* */
     uint32_t length;
-} QEMU_PACKED;
-typedef struct NBDOptionReply NBDOptionReply;
+} QEMU_PACKED NBDOptionReply;

 typedef struct NBDOptionReplyMetaContext {
     NBDOptionReply h; /* h.type = NBD_REP_META_CONTEXT, h.length > 4 */
@@ -56,14 +58,13 @@ typedef struct NBDOptionReplyMetaContext {
  * Note: these are _NOT_ the same as the network representation of an NBD
  * request and reply!
  */
-struct NBDRequest {
+typedef struct NBDRequest {
     uint64_t handle;
     uint64_t from;
     uint32_t len;
     uint16_t flags; /* NBD_CMD_FLAG_* */
     uint16_t type; /* NBD_CMD_* */
-};
-typedef struct NBDRequest NBDRequest;
+} NBDRequest;

 typedef struct NBDSimpleReply {
     uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
@@ -282,7 +283,7 @@ static inline bool nbd_reply_type_is_error(int type)
 #define NBD_ESHUTDOWN  108

 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
-struct NBDExportInfo {
+typedef struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
     char *x_dirty_bitmap;
@@ -310,8 +311,7 @@ struct NBDExportInfo {
     char *description;
     int n_contexts;
     char **contexts;
-};
-typedef struct NBDExportInfo NBDExportInfo;
+} NBDExportInfo;

 int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
                           QCryptoTLSCreds *tlscreds,
@@ -330,9 +330,6 @@ int nbd_client(int fd);
 int nbd_disconnect(int fd);
 int nbd_errno_to_system_errno(int err);

-typedef struct NBDExport NBDExport;
-typedef struct NBDClient NBDClient;
-
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);

 AioContext *nbd_export_aio_context(NBDExport *exp);
@@ -409,8 +406,6 @@ const char *nbd_cmd_lookup(uint16_t info);
 const char *nbd_err_lookup(int err);

 /* nbd/client-connection.c */
-typedef struct NBDClientConnection NBDClientConnection;
-
 void nbd_client_connection_enable_retry(NBDClientConnection *conn);

 NBDClientConnection *nbd_client_connection_new(const SocketAddress *saddr,
-- 
2.41.0


