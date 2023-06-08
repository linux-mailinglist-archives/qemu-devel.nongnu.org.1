Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FB72820E
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:01:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7G8m-000434-HQ; Thu, 08 Jun 2023 09:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8V-0003tJ-8S
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7G8L-0004e7-2k
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686232620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bj4sFgcf1CT0aTygZ2dK8R2P2P3+I8UOLBiEDFaHrc4=;
 b=ThvrICpbXbfGgL08vmGzZ5UrAZTn4NF2Y6sItFO+C4xGTqzFPAgXxo/mxz2qheLmSqj28B
 RhMU7+NdkdzDFO3mf3lvCDScVL0A1tEWty79eljMdxsgcJkVNipqPvmebgghUhk6IZsMGj
 LTYN1Rfg1c+x+fBohhj1JKKFK9oJoMQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-NyXT2Xe2P7mYv2V9cHsc3A-1; Thu, 08 Jun 2023 09:56:58 -0400
X-MC-Unique: NyXT2Xe2P7mYv2V9cHsc3A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 123F83823A23;
 Thu,  8 Jun 2023 13:56:58 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7177F48205E;
 Thu,  8 Jun 2023 13:56:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 02/24] nbd: Consistent typedef usage in header
Date: Thu,  8 Jun 2023 08:56:31 -0500
Message-Id: <20230608135653.2918540-3-eblake@redhat.com>
In-Reply-To: <20230608135653.2918540-1-eblake@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

We had a mix of struct declarataions followed by typedefs, and direct
struct definitions as part of a typedef.  Pick a single style.  Also
float a couple of opaque typedefs earlier in the file, as a later
patch wants to refer NBDExport* in NBDRequest.  No semantic impact.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v4: new patch
---
 include/block/nbd.h | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index a4c98169c39..9c3ceae5ba5 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2022 Red Hat, Inc.
+ *  Copyright Red Hat
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device
@@ -26,24 +26,25 @@
 #include "qapi/error.h"
 #include "qemu/bswap.h"

+typedef struct NBDExport NBDExport;
+typedef struct NBDClient NBDClient;
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
@@ -56,14 +57,13 @@ typedef struct NBDOptionReplyMetaContext {
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
@@ -282,7 +282,7 @@ static inline bool nbd_reply_type_is_error(int type)
 #define NBD_ESHUTDOWN  108

 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
-struct NBDExportInfo {
+typedef struct NBDExportInfo {
     /* Set by client before nbd_receive_negotiate() */
     bool request_sizes;
     char *x_dirty_bitmap;
@@ -310,8 +310,7 @@ struct NBDExportInfo {
     char *description;
     int n_contexts;
     char **contexts;
-};
-typedef struct NBDExportInfo NBDExportInfo;
+} NBDExportInfo;

 int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
                           QCryptoTLSCreds *tlscreds,
@@ -330,9 +329,6 @@ int nbd_client(int fd);
 int nbd_disconnect(int fd);
 int nbd_errno_to_system_errno(int err);

-typedef struct NBDExport NBDExport;
-typedef struct NBDClient NBDClient;
-
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);

 AioContext *nbd_export_aio_context(NBDExport *exp);
-- 
2.40.1


