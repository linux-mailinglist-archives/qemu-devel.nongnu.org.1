Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75508A5CA10
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 17:01:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts222-0003rY-7t; Tue, 11 Mar 2025 12:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts21U-0003GY-Qs
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ts21R-0005Lu-AJ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d70VeyWE0KUag6YtYRbbTqQtQhZMWjZwKgRT9dpWuug=;
 b=PH9mNzOndhPQwsq6crhUyM7ywm0zMP39BI6Jrb39fR4AsiuHKpewblPKwVOkz+zEPmPdjZ
 hTSwoGr1yM32W4Z0IbyAG0YI6zwKmehkRvqgoYApXvxglY7vU9E+xVDEMQWvd3rPixmFWt
 cYHQhYGsduP82GfqVqPHNqWr/Fey/dg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-kkF1bIXGOImGVPePgpIKCQ-1; Tue,
 11 Mar 2025 11:59:58 -0400
X-MC-Unique: kkF1bIXGOImGVPePgpIKCQ-1
X-Mimecast-MFC-AGG-ID: kkF1bIXGOImGVPePgpIKCQ_1741708797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89EAD180025E
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 15:59:57 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F1A51800373; Tue, 11 Mar 2025 15:59:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-10.1 02/10] ui/clipboard: use int for selection field
Date: Tue, 11 Mar 2025 19:59:24 +0400
Message-ID: <20250311155932.1472092-3-marcandre.lureau@redhat.com>
In-Reply-To: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This allows to use a VMSTATE_INT32 field for migration purposes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/clipboard.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index ab6acdbd8a..14b6099e73 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -112,7 +112,7 @@ struct QemuClipboardNotify {
 struct QemuClipboardInfo {
     uint32_t refcount;
     QemuClipboardPeer *owner;
-    QemuClipboardSelection selection;
+    int selection; /* QemuClipboardSelection */
     bool has_serial;
     uint32_t serial;
     struct {
-- 
2.47.0


