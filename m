Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA2831920
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:27:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRn-0003Qd-30; Thu, 18 Jan 2024 07:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRg-0003Ho-4N
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRe-0005n7-FV
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBO1lrsnPEtJ2wirtQ5cQNGuGOk+ezHaN3UBTfhCnlg=;
 b=WrcgY6rAxCGZ52IGI33BmtyUDa2Zuw9D6T+60Qv5TqapbLUmr5n11jJBs5IjrwmKn0/fGv
 xrW5QylRTBWjobnbQKe6pgZeuNL8mI8hzrrS/u9ieBuZsp9pXMkzbGIR1rfkfpKQtxZ0e1
 FBMLNmvdJ0pZUNGZI8Hf2FPz1a25G+0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-3W9szgaRP2ieVvZDgRDCDw-1; Thu, 18 Jan 2024 07:24:25 -0500
X-MC-Unique: 3W9szgaRP2ieVvZDgRDCDw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50e55470b49so9819323e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580663; x=1706185463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBO1lrsnPEtJ2wirtQ5cQNGuGOk+ezHaN3UBTfhCnlg=;
 b=s1EysoATDYcIIVYwIawF/BeHnq+HCCqCmREqPkJCQKhmBId9ARjn7ru5yEya5aAk1L
 WBTuL6OAzMpICuHUwdyRh4o/yenF7K1ssoNHRStGrMieauwewLEfKgI6lauQOY1oz7mj
 onWC2Z+nTzEiSorQUGzUbFNO6FsJIue/5xtVghlWLtGbmvLQuF5psBz4s36NwlWwmWoq
 hHXPF0czMarSZUbaV6Q4rzWQpbYFtjr4JUzG9Xk+gfoRP0ZZySnhuzFRPMRqsWdHn7mo
 gHbGSx0I2Nrmqyo0d2uo2Rk+ksuhNUOPE4GwMUlNR8SHQscqLMoFd687HBFt30kZk/x2
 mBbw==
X-Gm-Message-State: AOJu0YxDwIIxzOJMN5VLipfXA4NiB8JsK8HZdVs4TMF9Jr8dXSwQJT58
 IfqJdChneY3MAwwiBqOJ2hVvx7YaSmVW/EjvJXoXiPF0FJSypkeSL03EKc9DluVfCqsECQgb4wO
 rZpOZq9Fg+uzQDEyet2mHpJijM3I311kvsy5eu6Gyl8F26V0bdDQ//8k26igYGNDjwbjM90r/vR
 AtRfQlWY6rniprK3mgGkz1TO3jIlOLuDqtFtGt
X-Received: by 2002:a05:6512:48c6:b0:50f:98d:35df with SMTP id
 er6-20020a05651248c600b0050f098d35dfmr356165lfb.5.1705580663116; 
 Thu, 18 Jan 2024 04:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9IXMytBtaQqrKnADivLdmKrcRnL7TSizJOpYSQgIOmOo7MtwHlSuZ9t1usTXjEwrj47J1Wg==
X-Received: by 2002:a05:6512:48c6:b0:50f:98d:35df with SMTP id
 er6-20020a05651248c600b0050f098d35dfmr356160lfb.5.1705580662767; 
 Thu, 18 Jan 2024 04:24:22 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a170906360800b00a2bd52d2a84sm9012442ejb.200.2024.01.18.04.24.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] vga: mask addresses in non-VESA modes to 256k
Date: Thu, 18 Jan 2024 13:24:03 +0100
Message-ID: <20240118122416.9209-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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
index fea26f91232..5bf4d14f342 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -47,6 +47,9 @@ bool have_vga = true;
 /* 16 state changes per vertical frame @60 Hz */
 #define VGA_TEXT_CURSOR_PERIOD_MS       (1000 * 2 * 16 / 60)
 
+/* Address mask for non-VESA modes.  */
+#define VGA_VRAM_SIZE                   (256 * KiB)
+
 /*
  * Video Graphics Array (VGA)
  *
-- 
2.43.0


