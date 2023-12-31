Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A04820AD8
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:41:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsIV-0003NR-P9; Sun, 31 Dec 2023 04:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIA-0003Li-En
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsI8-0001Oh-Tb
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704015572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0GKZTfjYpI+EqFxN4nTQimzWkUmQb261OTT9Ja7F90=;
 b=EXK4ahMJ5Zig+HpqDSCIIy4BUb36HyBm7LVC8yMfS0fWCs6qSNtnPxOBHurNotKb29CxNH
 ISFxO+9E/SSwU8pDSqB9Cx/3zd81dChcWkRoR+YzVyesXX4bgb3k2EMW0ABerVm+ZLAJIW
 5//JwFuUgTk5pzKqlecmdK17SJQ/a30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-JKG2F1d7OSWO2J6x3EmmNw-1; Sun, 31 Dec 2023 04:39:30 -0500
X-MC-Unique: JKG2F1d7OSWO2J6x3EmmNw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d86184891so2718685e9.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 01:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704015568; x=1704620368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0GKZTfjYpI+EqFxN4nTQimzWkUmQb261OTT9Ja7F90=;
 b=W1wxcWPix1OI5mmDWfYhmNxe39jA3zLQkJjpMJQL63HVP20gBwBbneuU/uhl1Yi5JH
 HW7ShFxFAwVYYNRV3o0UEzvEIzV1eDrl20v65GAZBa+xzDa3e4aQS6gZhHHH+mX1w7lC
 uLcqKNAMZpGdAeboiHWaHWn6JMAWilDAadd5kgTlQyKaN1Lrtv7T3au1w/Edyznlt5dU
 L5+FEnILcO4iNTIBmXSoaRP4HnZEgDyQ9TprzsSIBvNwOnAHbK6YrmPZOe75IuSnMQUY
 7XoPnLJI2Xv9RK2YCBv5jWFmOjj0FFkDSLC14/BFEBZY4+9BVDbQlSuGCaiTX9XuZZC5
 kCqg==
X-Gm-Message-State: AOJu0Yz9XvOJ898HHaytQ+RpORmQsULy/Nejb73/x6TdafhCZyADhHsF
 4xiWfRxLMqPArzDq/KlBBvFciS98tpNb2KqQ2Hf/xQhYMj0hDhSG9dxv59RDC3YY7JAbjkZUZc8
 aViO3KPWE/bOodINho0rthz80YCBnDy8kdoEx1jX0KARZGBGG2tuQKCYLyY+g4hPO07F0aju4Id
 Qr6RzYWHk=
X-Received: by 2002:a05:600c:1f17:b0:40d:8818:579e with SMTP id
 bd23-20020a05600c1f1700b0040d8818579emr129923wmb.108.1704015568567; 
 Sun, 31 Dec 2023 01:39:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES6ifd+XykLF5DpBUVkOuveQx8mj93qLIWqmHnGQuS9G0EQr7VZ9sYygqBGclr97XY6VFSCQ==
X-Received: by 2002:a05:600c:1f17:b0:40d:8818:579e with SMTP id
 bd23-20020a05600c1f1700b0040d8818579emr129919wmb.108.1704015568304; 
 Sun, 31 Dec 2023 01:39:28 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 w11-20020adfcd0b000000b003367e35abd4sm23356938wrm.71.2023.12.31.01.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 01:39:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 3/8] vga: mask addresses in non-VESA modes to 256k
Date: Sun, 31 Dec 2023 10:39:13 +0100
Message-ID: <20231231093918.239549-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231093918.239549-1-pbonzini@redhat.com>
References: <20231231093918.239549-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows setting the start address to a high value, and reading the
bottom of the screen from the beginning of VRAM.  Commander Keen 4
("Goodbye, Galaxy!") relies on this behavior.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga-helpers.h | 9 +++++----
 hw/display/vga.c         | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga-helpers.h b/hw/display/vga-helpers.h
index 10e9cfd40a0..83b9a15604a 100644
--- a/hw/display/vga-helpers.h
+++ b/hw/display/vga-helpers.h
@@ -108,7 +108,7 @@ static void vga_draw_line2(VGACommonState *vga, uint8_t *d,
     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
     width >>= 3;
     for(x = 0; x < width; x++) {
-        data = vga_read_dword_le(vga, addr);
+        data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
         data &= plane_mask;
         v = expand2[GET_PLANE(data, 0)];
         v |= expand2[GET_PLANE(data, 2)] << 2;
@@ -144,7 +144,7 @@ static void vga_draw_line2d2(VGACommonState *vga, uint8_t *d,
     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
     width >>= 3;
     for(x = 0; x < width; x++) {
-        data = vga_read_dword_le(vga, addr);
+        data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
         data &= plane_mask;
         v = expand2[GET_PLANE(data, 0)];
         v |= expand2[GET_PLANE(data, 2)] << 2;
@@ -177,7 +177,7 @@ static void vga_draw_line4(VGACommonState *vga, uint8_t *d,
     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
     width >>= 3;
     for(x = 0; x < width; x++) {
-        data = vga_read_dword_le(vga, addr);
+        data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
         data &= plane_mask;
         v = expand4[GET_PLANE(data, 0)];
         v |= expand4[GET_PLANE(data, 1)] << 1;
@@ -209,7 +209,7 @@ static void vga_draw_line4d2(VGACommonState *vga, uint8_t *d,
     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
     width >>= 3;
     for(x = 0; x < width; x++) {
-        data = vga_read_dword_le(vga, addr);
+        data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
         data &= plane_mask;
         v = expand4[GET_PLANE(data, 0)];
         v |= expand4[GET_PLANE(data, 1)] << 1;
@@ -242,6 +242,7 @@ static void vga_draw_line8d2(VGACommonState *vga, uint8_t *d,
     palette = vga->last_palette;
     width >>= 3;
     for(x = 0; x < width; x++) {
+        addr &= VGA_VRAM_SIZE - 1;
         PUT_PIXEL2(d, 0, palette[vga_read_byte(vga, addr + 0)]);
         PUT_PIXEL2(d, 1, palette[vga_read_byte(vga, addr + 1)]);
         PUT_PIXEL2(d, 2, palette[vga_read_byte(vga, addr + 2)]);
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 3bd357d72c2..b1660bdde67 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -47,6 +47,9 @@ bool have_vga = true;
 /* 16 state changes per vertical frame @60 Hz */
 #define VGA_TEXT_CURSOR_PERIOD_MS       (1000 * 2 * 16 / 60)
 
+/* Address mask for non-VESA modes.  */
+#define VGA_VRAM_SIZE                   262144
+
 /*
  * Video Graphics Array (VGA)
  *
-- 
2.43.0


