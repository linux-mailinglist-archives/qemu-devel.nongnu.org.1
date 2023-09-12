Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA52379CEB8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vC-0002qU-Hp; Tue, 12 Sep 2023 06:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vA-0002pj-Po
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0v7-0003DW-4d
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBjKviHSEEDUVkGToh+5MHl5RaBzVuGNPEEBbtTtyb8=;
 b=Tf8QZNf8zhy/TA5QYvWtwDoaiA2TWqDCAdWA83yP8obVFv1a690G3BjsM1D2XkE0BjDcrp
 xI6NbWPsYo9o/S1d/wbQ2W6Cr9Egk09E13tMC0FkdawtOeCBuTju1NvuCIg8SfjOTfM+fS
 /zKjrugpZr35tzXxH7a1rMZf4V+8YsE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-l2YvkKMePRidhqb4IONc8g-1; Tue, 12 Sep 2023 06:46:58 -0400
X-MC-Unique: l2YvkKMePRidhqb4IONc8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D7DE8A0737
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:46:56 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74B9B2026D68;
 Tue, 12 Sep 2023 10:46:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Erico Nunes <ernunes@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 01/14] docs: vhost-user-gpu: add protocol changes for dmabuf
 modifiers
Date: Tue, 12 Sep 2023 14:46:35 +0400
Message-ID: <20230912104649.1638640-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Erico Nunes <ernunes@redhat.com>

VHOST_USER_GPU_DMABUF_SCANOUT2 is defined as a message with all the
contents of VHOST_USER_GPU_DMABUF_SCANOUT plus the dmabuf modifiers
which were ommitted.

The VHOST_USER_GPU_PROTOCOL_F_DMABUF2 protocol feature is defined as a
way to check whether this new message is supported or not.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20230714153900.475857-2-ernunes@redhat.com>
---
 docs/interop/vhost-user-gpu.rst | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user-gpu.rst b/docs/interop/vhost-user-gpu.rst
index b78806892d..3035822d05 100644
--- a/docs/interop/vhost-user-gpu.rst
+++ b/docs/interop/vhost-user-gpu.rst
@@ -134,6 +134,19 @@ VhostUserGpuEdidRequest
 :scanout-id: ``u32``, the scanout to get edid from
 
 
+VhostUserGpuDMABUFScanout2
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
++----------------+----------+
+| dmabuf_scanout | modifier |
++----------------+----------+
+
+:dmabuf_scanout: ``VhostUserGpuDMABUFScanout``, filled as described in the
+                 VhostUserGpuDMABUFScanout structure.
+
+:modifier: ``u64``, the DMABUF modifiers
+
+
 C structure
 -----------
 
@@ -163,7 +176,8 @@ Protocol features
 
 .. code:: c
 
-  #define VHOST_USER_GPU_PROTOCOL_F_EDID 0
+  #define VHOST_USER_GPU_PROTOCOL_F_EDID    0
+  #define VHOST_USER_GPU_PROTOCOL_F_DMABUF2 1
 
 New messages and communication changes are negotiated thanks to the
 ``VHOST_USER_GPU_GET_PROTOCOL_FEATURES`` and
@@ -263,3 +277,13 @@ Message types
   Retrieve the EDID data for a given scanout.
   This message requires the ``VHOST_USER_GPU_PROTOCOL_F_EDID`` protocol
   feature to be supported.
+
+``VHOST_USER_GPU_DMABUF_SCANOUT2``
+  :id: 12
+  :request payload: ``VhostUserGpuDMABUFScanout2``
+  :reply payload: N/A
+
+  Same as VHOST_USER_GPU_DMABUF_SCANOUT, but also sends the dmabuf modifiers
+  appended to the message, which were not provided in the other message.
+  This message requires the ``VHOST_USER_GPU_PROTOCOL_F_DMABUF2`` protocol
+  feature to be supported.
-- 
2.41.0


