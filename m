Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200784F1F5
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Feb 2024 10:07:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpY-0005RQ-W8; Fri, 09 Feb 2024 04:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpW-0005RI-CI
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:54 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpU-0000gE-J2
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:54 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5114fa38434so740704e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469550; x=1708074350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahGl576821/GPhzoaU/l92B3Gi9UsGeCtBiy/M2bP2c=;
 b=zRAabjQh37izhSxFMEp0RgP2iVF3e9hKVSBjmDDaYlaxJfOd1aI5F7lLULGqfxpMba
 R3cQolo2N/W/7pLH0HEHRenHAn8k603bSP7NhlcE/JBvYkReTYJgIC8GisjG/cHyEbdY
 nHzfKlWUJ4Md0pG4Psth59PpSglaO/lQwqh6Doh4pXXRoEJhA/XaUH+VG/+z1NA1h4ML
 NvFbPxvcNdS/EEsx07xrIV1/gR6xmK8mSb5RTLKpZC79vAyT7mAl8D8G3xdGGmWSG97B
 +8/dyqsUYF6x8knEy+3w75RK64+cf0U8vaMCayTEx4iL4A3brlTmbhd8YIww66U59NPV
 m7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469550; x=1708074350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahGl576821/GPhzoaU/l92B3Gi9UsGeCtBiy/M2bP2c=;
 b=O/lhTWcmq5w+0xbXgY7ykCyN0Gq3KDYRgVLjO1kOcZ/GfsXYf2U+t0D4kz3QyqyLeP
 SA5LQ6liiSpujcBTwdmGrVj0JzeTYFNgPG7+wTf73ZEv6u65PErEOOjoUjjh+aAXe6zK
 3ZJxRf8wzwSLEMhxDc8NeDHYOwSxfdZJ5cOI1hQ5NWq4jBqGTULt+EwJisc/nXYyxUNx
 TRtyyzjZHARqxggqz4KJ2t1ItVnM7WkR4KaSx80QzSoiEwnQkAcS5Ywzp/ygku6eWNDg
 ol4NOdHyz4gjQlUDiLXg520Os07aRtVb1Xe46dhmBnfD4+zbrbgPU4DD5XG2hKfTUAFP
 jPhg==
X-Gm-Message-State: AOJu0Yzr6HjqBZmikcc/sckRw9O9XBcMHPvZqB1yIl3nZFMgAR9C9+8T
 TkiymOe1K/mwnbslm38XkZY6ax2vmnWUvgUc36Rm7+GUpFsJTogFRzlag1pGfn64YawK1jOQtSo
 Kkog=
X-Google-Smtp-Source: AGHT+IEFQk0pGbloP5dgQKHpp0iXnVCTxtF4EQDanYrCzExjtBmj8gqHOSe8FcmYXyRiYxrKi1x8pw==
X-Received: by 2002:ac2:43ad:0:b0:511:62b4:2a03 with SMTP id
 t13-20020ac243ad000000b0051162b42a03mr651142lfl.62.1707469550547; 
 Fri, 09 Feb 2024 01:05:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVPehQY/5wqZU8VfWtxvAs+2e61QqMGWPgCtdo+dml3sNmvpx1qFhBDj3DS9rFJBiT3DerPZ5HhG+UpXlw2wPB3D4EOsFA6YZUrRTEMwSeYD1Y4fXd1D7CfyqoVF/LGfOuIKOZJUDdNwjjpkxhFIiA8e8+5xTh2F0mZXdXFrWVNyvzhiuYnu6x4kSzgnjv0yrCEfN+RnYB/VRl5+4F14UJQAv5wsTPnA1nvHoAOkrdxsTXmQ5mKsMHaW6pqRvEGLKs0PEQmFwKH3eaKWB+kMLKtF7derysr5SsjkRLQb5UahqLxEoDobYfF9quopcj6eFpsezSOPOBNL1bXJjBaY5PBYD0uBhs=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 n44-20020a05600c502c00b004104c42ad5asm1966194wmr.22.2024.02.09.01.05.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:05:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 06/11] hw/misc/mips_itu: Remove MIPSITUState::saar field
Date: Fri,  9 Feb 2024 10:05:07 +0100
Message-ID: <20240209090513.9401-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This field is not set. Remove it along with the dead
code it was guarding.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/mips_itu.h |  3 ---
 hw/misc/mips_itu.c         | 22 +++-------------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index de7400c1fe..27c9a1090d 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -70,9 +70,6 @@ struct MIPSITUState {
 
     /* ITU Control Register */
     uint64_t icr0;
-
-    /* SAAR */
-    uint64_t *saar;
 };
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 9705efeafe..f8acfb3ee2 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -94,12 +94,6 @@ static void itc_reconfigure(MIPSITUState *tag)
     uint64_t size = (1 * KiB) + (am[1] & ITC_AM1_ADDR_MASK_MASK);
     bool is_enabled = (am[0] & ITC_AM0_EN_MASK) != 0;
 
-    if (tag->saar) {
-        address = (tag->saar[0] & 0xFFFFFFFFE000ULL) << 4;
-        size = 1ULL << ((tag->saar[0] >> 1) & 0x1f);
-        is_enabled = tag->saar[0] & 1;
-    }
-
     memory_region_transaction_begin();
     if (!(size & (size - 1))) {
         memory_region_set_size(mr, size);
@@ -158,12 +152,7 @@ static inline ITCView get_itc_view(hwaddr addr)
 static inline int get_cell_stride_shift(const MIPSITUState *s)
 {
     /* Minimum interval (for EntryGain = 0) is 128 B */
-    if (s->saar) {
-        return 7 + ((s->icr0 >> ITC_ICR0_BLK_GRAIN) &
-                    ITC_ICR0_BLK_GRAIN_MASK);
-    } else {
-        return 7 + (s->ITCAddressMap[1] & ITC_AM1_ENTRY_GRAIN_MASK);
-    }
+    return 7 + (s->ITCAddressMap[1] & ITC_AM1_ENTRY_GRAIN_MASK);
 }
 
 static inline ITCStorageCell *get_cell(MIPSITUState *s,
@@ -535,15 +524,10 @@ static void mips_itu_reset(DeviceState *dev)
 {
     MIPSITUState *s = MIPS_ITU(dev);
 
-    if (s->saar) {
-        s->saar[0] = 0x11 << 1;
-        s->icr0 = get_num_cells(s) << ITC_ICR0_CELL_NUM;
-    } else {
-        s->ITCAddressMap[0] = 0;
-        s->ITCAddressMap[1] =
+    s->ITCAddressMap[0] = 0;
+    s->ITCAddressMap[1] =
             ((ITC_STORAGE_ADDRSPACE_SZ - 1) & ITC_AM1_ADDR_MASK_MASK) |
             (get_num_cells(s) << ITC_AM1_NUMENTRIES_OFS);
-    }
     itc_reconfigure(s);
 
     itc_reset_cells(s);
-- 
2.41.0


