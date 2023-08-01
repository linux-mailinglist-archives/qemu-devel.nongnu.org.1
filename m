Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93E76AE93
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:40:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlqz-0001or-1E; Tue, 01 Aug 2023 05:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qQlqu-0001m5-LT
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qQlqt-0004n9-1O
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690882777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaUDgtYi/teIWkkoRplo+n2xCUGsY4ZKELv/pSpNuq8=;
 b=Cprk4hjyjk2yBMmbJ38p0nA52AShVdTS7YJ3ghCAP1hCLs0moSU8Xsswvh2b/jLUXknb7Z
 VKHf3WVstziNjA13RSx/kOsjAv5PDkIbXE46+hFGVd4hztK1H9Ozv2/uJ83WfKo1937xNm
 9jk6PIG2y/6NtTx+z726P9xxypOOmBs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-rRd2Q4-lO6aiVfZNhIOecQ-1; Tue, 01 Aug 2023 05:39:36 -0400
X-MC-Unique: rRd2Q4-lO6aiVfZNhIOecQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E55D481DA5D;
 Tue,  1 Aug 2023 09:39:35 +0000 (UTC)
Received: from localhost (unknown [10.39.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 319781454147;
 Tue,  1 Aug 2023 09:39:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: zhouzongmin@kylinos.cn,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/2] vmmouse: use explicit code
Date: Tue,  1 Aug 2023 13:39:28 +0400
Message-ID: <20230801093928.309361-2-marcandre.lureau@redhat.com>
In-Reply-To: <20230801093928.309361-1-marcandre.lureau@redhat.com>
References: <20230801093928.309361-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It's weird to shift x & y without obvious reason. Let's make this more
explicit and future-proof.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/vmmouse.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index fce13a5cde..cd9ac11afc 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -46,6 +46,11 @@
 
 #define VMMOUSE_VERSION		0x3442554a
 
+#define VMMOUSE_MIN_X 0
+#define VMMOUSE_MIN_Y 0
+#define VMMOUSE_MAX_X 0xFFFF
+#define VMMOUSE_MAX_Y 0xFFFF
+
 #define TYPE_VMMOUSE "vmmouse"
 OBJECT_DECLARE_SIMPLE_TYPE(VMMouseState, VMMOUSE)
 
@@ -106,8 +111,12 @@ static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int buttons_
         buttons |= 0x08;
 
     if (s->absolute) {
-        x <<= 1;
-        y <<= 1;
+        x = qemu_input_scale_axis(x,
+                                  INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_MAX,
+                                  VMMOUSE_MIN_X, VMMOUSE_MAX_X);
+        y = qemu_input_scale_axis(y,
+                                  INPUT_EVENT_ABS_MIN, INPUT_EVENT_ABS_MAX,
+                                  VMMOUSE_MIN_Y, VMMOUSE_MAX_Y);
     }
 
     s->queue[s->nb_queue++] = buttons;
-- 
2.41.0


