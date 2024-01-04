Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A9824A95
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 23:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLVjS-0001Zh-Qn; Thu, 04 Jan 2024 16:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjR-0001ZK-2S
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjP-0003OG-EP
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704405506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dggxOoMGSHPsNTmOlVnHH3e8clB1PCJuMh7wIlsQipU=;
 b=IEJH2Qpp00/NuEbQuZUVwF4lgmE6euFAG4W2NndqgfaWjwT/oBytUeIgRhVAGm8wHbfZy4
 Xzm/hYcOjcczc7ScMViyED0rgxGO/N8tenIdNE1AZJak/52zVp79KmM3rOTtKM+Ha7vurH
 knm+NgZRimVDa2PmtnFd1NHqP6JGZ50=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-hG0csCU1Nba2gi0Savje1Q-1; Thu, 04 Jan 2024 16:58:24 -0500
X-MC-Unique: hG0csCU1Nba2gi0Savje1Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e34df6fdcso5790685e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704405502; x=1705010302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dggxOoMGSHPsNTmOlVnHH3e8clB1PCJuMh7wIlsQipU=;
 b=kveGS3XXkkf2kp0W6Px6iZkjJ5kHsB2l1rskhWWl3AYTze9hHauiBEWl+MHo075uBS
 VBtlVYeywJj9iXSFvDiB2vLH1YFVcu4yGnHkvL7PvnNm7yEVwrotajvCou/aScviCQlU
 s6sIv6HwTLxbyju0ySe9AGBwEXN6LB+yGe3MhWZEH5JyA8QxdvhslQRDg7qC+IcDkGh1
 t+L/cbG1cdQUx/rqf88ijZrmXBbSPCsYRYo4EDJOXiU2Qvi2uhJzgqTGHYGnLDc+N07a
 BP/53abWSO/3kd+v3KA/MQteFgE+yUU5QqEoe34iQzwzVX6p9FgNz0KTqnON/z3PWFJI
 7RIg==
X-Gm-Message-State: AOJu0YzZGOkAfaSv/Gjz63JYjoqVZK3/zy4Az+DHuKX0AINJsRraz4ZZ
 HOgxIR7yqv0cnsSvXicpkH1oCyae+mjYCHmNbai+9OJcGgsnauHktIhNAKAdqHd5UWJXLPKBKSj
 3GOrIod0fPeGJ/o8g7hh+NZHICv5XeJ/ewkOr+VohNk9Xv9r5gfEy0kwwZoyCGY9P83ZWOfiu9N
 Hby0A8qdY=
X-Received: by 2002:a05:600c:474d:b0:40e:3505:3326 with SMTP id
 w13-20020a05600c474d00b0040e35053326mr646793wmo.19.1704405502605; 
 Thu, 04 Jan 2024 13:58:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRSKIlSUOBUk4/2AUefchVoRW+1EyXNs88WdW0sMk5He7GiiNE2hR0gOXrY+9Ukhbza+bV7g==
X-Received: by 2002:a05:600c:474d:b0:40e:3505:3326 with SMTP id
 w13-20020a05600c474d00b0040e35053326mr646789wmo.19.1704405502364; 
 Thu, 04 Jan 2024 13:58:22 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 mb16-20020a170906eb1000b00a26aeb9e37csm113268ejb.6.2024.01.04.13.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:58:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v2 3/8] vga: mask addresses in non-VESA modes to 256k
Date: Thu,  4 Jan 2024 22:58:06 +0100
Message-ID: <20240104215813.156153-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104215813.156153-1-pbonzini@redhat.com>
References: <20240104215813.156153-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index aebc1aeaaef..296182b0b93 100644
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


