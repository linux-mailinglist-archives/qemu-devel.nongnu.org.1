Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68F931351
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 13:45:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTK8O-0006zG-0g; Mon, 15 Jul 2024 07:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sTK8D-0006wa-Tb
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 07:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sTK8A-0004h0-8U
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 07:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721043872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I4MRZV9iiQREmx5w+sdeHz4sn0ouKabcvNq9Op16iz0=;
 b=iFMgtoIOInV56rhQ8eBME3QzRV/e0ASJUR7UPmC6RF/Z2AMdOSc7lGTDGv+edo5OcJPoDY
 6Ujf9s0kw5BpZpnXOxXe81NHCB4TEtnQEOEQTHNQigqmVv85EjkH0h3Qb4koOTO11yhK/P
 U6kCdrSbZe5S1BJ/ayYPeHvNlWfUur8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-LTgUdP_mO5WgiVStTKnpRQ-1; Mon,
 15 Jul 2024 07:44:31 -0400
X-MC-Unique: LTgUdP_mO5WgiVStTKnpRQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BEFB195421A
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 11:44:30 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD17F1955DC7; Mon, 15 Jul 2024 11:44:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] vl: fix "type is NULL" in -vga help
Date: Mon, 15 Jul 2024 15:44:20 +0400
Message-ID: <20240715114420.2062870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Don't pass NULL to module_object_class_by_name(), when the interface is
unavailable.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index bdd2f6ecf6..9e8f16f155 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1000,9 +1000,16 @@ static bool vga_interface_available(VGAInterfaceType t)
     const VGAInterfaceInfo *ti = &vga_interfaces[t];
 
     assert(t < VGA_TYPE_MAX);
-    return !ti->class_names[0] ||
-           module_object_class_by_name(ti->class_names[0]) ||
-           module_object_class_by_name(ti->class_names[1]);
+
+    if (!ti->class_names[0] || module_object_class_by_name(ti->class_names[0])) {
+        return true;
+    }
+
+    if (ti->class_names[1] && module_object_class_by_name(ti->class_names[1])) {
+        return true;
+    }
+
+    return false;
 }
 
 static const char *
-- 
2.45.2.827.g557ae147e6


