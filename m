Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7983BABEFD
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Sep 2025 09:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VDx-0001PL-Lw; Tue, 30 Sep 2025 03:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDv-0001Oy-4G
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3VDp-0008UG-Lq
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 03:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759218986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgP5cNBnnT5cOOTVWD7cI42jGEXjOTZ4hnatAD0qlOc=;
 b=BsyEF0ZmK7gBtZfA+x4Eg/vSrS3Fk9K9xRSHQsiFw54hjs3lFRq7+KR7l144L17Tcef9fU
 JYn6THoq96IOorpchR5CvotgBe5dN0Tw/nRcOyLs0EVLgaMS3sAaUyDb1l/0rTgpVfuZDd
 fXztDQoRsNts2L9Yp8SeyWJtrIhfrgU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-MSmP930OM-KP78tdYWHHgA-1; Tue,
 30 Sep 2025 03:56:22 -0400
X-MC-Unique: MSmP930OM-KP78tdYWHHgA-1
X-Mimecast-MFC-AGG-ID: MSmP930OM-KP78tdYWHHgA_1759218982
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12ED7180058B; Tue, 30 Sep 2025 07:56:22 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B12F91800577; Tue, 30 Sep 2025 07:56:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 richard.henderson@linaro.org
Subject: [PULL 3/5] ui/spice: fix crash when disabling GL scanout on
Date: Tue, 30 Sep 2025 11:55:57 +0400
Message-ID: <20250930075559.133650-4-marcandre.lureau@redhat.com>
In-Reply-To: <20250930075559.133650-1-marcandre.lureau@redhat.com>
References: <20250930075559.133650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When spice_qxl_gl_scanout2() isn't available, the fallback code
incorrectly handles NULL arguments to disable the scanout, leading to:

Program terminated with signal SIGSEGV, Segmentation fault.
#0  spice_server_gl_scanout (qxl=0x55a25ce57ae8, fd=0x0, width=0, height=0, offset=0x0, stride=0x0, num_planes=0, format=0, modifier=72057594037927935, y_0_top=0)
    at ../ui/spice-display.c:983
983         if (num_planes <= 1) {

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2391334
Fixes: 98a050ca93afd8 ("ui/spice: support multi plane dmabuf scanout")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20250903193818.2460914-1-marcandre.lureau@redhat.com>
---
 ui/spice-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 669832c561..db71e866f8 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -980,7 +980,9 @@ static void spice_server_gl_scanout(QXLInstance *qxl,
     spice_qxl_gl_scanout2(qxl, fd, width, height, offset, stride,
                           num_planes, format, modifier, y_0_top);
 #else
-    if (num_planes <= 1) {
+    if (fd == NULL) {
+        spice_qxl_gl_scanout(qxl, -1, 0, 0, 0, 0, false);
+    } else if (num_planes <= 1) {
         spice_qxl_gl_scanout(qxl, fd[0], width, height, stride[0], format, y_0_top);
     } else {
         error_report("SPICE server does not support multi plane GL scanout");
-- 
2.51.0


