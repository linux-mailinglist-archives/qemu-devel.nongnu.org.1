Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF178B3C9
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 16:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadfx-0004hF-BP; Mon, 28 Aug 2023 10:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1qadfu-0004Wi-EO
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:57:06 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1qadfr-0000um-TV
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:57:06 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso5085494e87.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1693234622; x=1693839422; 
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DsLmdJs+hmNN+vsbvbOMZLA7s8YzN/0ZTTxJV82lXHo=;
 b=q59AYJnnFcJbY83j3/XU4lj23//IvNKVd7NGHd6wSJ0v1a+lPgtwrO/b79+eiNVJTH
 H7nUNbAM3XOlwInJ4klF7CWXa7sYgfBFstvVZenJ24Jg1d2eb97VNw1vaFerrrF31g2F
 Em+BlWfG1Zjhuwd440RlxFTI7+hgm9HUoulrzVOMsTNaggREpEqK3TJIQisTuHJldki0
 sudT/FjcS0JY+r5azzu7s2R5X/GDngYdQYRWq9GsmRPuNTkJttVMZG4DqicXFtDYMJaU
 OeCVHexYnVnYcSA7STzAg/xpUlc6qn3lm/cj0Vd9fcROq6B6NpfgRGweWchtJYKRP4o+
 SFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693234622; x=1693839422;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsLmdJs+hmNN+vsbvbOMZLA7s8YzN/0ZTTxJV82lXHo=;
 b=e14K49uwK387AWIrRVfSvLj7bqztKfypqzHFu8kVQx1Tgu7YjMv8PkklzV9zy+ULIO
 UomPGvA5OI+59g0XuAH5pLaT5QBmKBJY55Q2YdrnKAN7OGwBn9J2caAYBAUdfT+wQoIo
 xIsdJ/UcaOFk2Rq7XAREIF3qV4/R0juajwmcL/WuOLKzV6C2uT5ckSRuXm/KPyyeyNBw
 ahOu7DQ9E6W9tKpsk8xwfA6yayTleERWag41ZdSnKGIju0ye5LMDfnNSA5EHJ6jeuziA
 SKMPzClqBDkWpSGOfI/T2ZE4OKsv2ryVYlK0JW07BXo4uau1lNn/eZb1DmSQX2m6Ft2u
 WOuw==
X-Gm-Message-State: AOJu0YxWYJuBIo/7kJfMdWyeHszwWsLS9A9dWwXMEFdSOqgDQ1o9q4uu
 Ku8QWHFI1WoXvgRbuaVunYaIujHGOWfQQMaBNIxF2Q==
X-Google-Smtp-Source: AGHT+IHj3ftls7UK1YTEXQJgX4CfS4t+zgYhLM4tqW9SHqAo/6HV5kGICuoF/itpyzd9If/WSXrivw==
X-Received: by 2002:a05:6512:1088:b0:4fb:89b3:3373 with SMTP id
 j8-20020a056512108800b004fb89b33373mr21782599lfg.43.1693234621559; 
 Mon, 28 Aug 2023 07:57:01 -0700 (PDT)
Received: from [192.168.50.45] (h-155-4-92-80.A980.priv.bahnhof.se.
 [155.4.92.80]) by smtp.gmail.com with ESMTPSA id
 18-20020ac24852000000b0050089b26ea1sm1594968lfy.276.2023.08.28.07.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 07:57:00 -0700 (PDT)
Message-ID: <bc82203b72d7efb30f1b4a8f9eb3d94699799dc8.camel@rivosinc.com>
Subject: [PATCH] linux-user/riscv: Add new extensions to hwprobe
From: Robbin Ehn <rehn@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Mon, 28 Aug 2023 16:56:59 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=rehn@rivosinc.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds the new extensions in
linux 6.5 to the hwprobe syscall.

And fixes RVC check to OR with correct value.
The previous variable contains 0 therefore it
did work.

Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
---
 linux-user/syscall.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9353268cc1..c46a0b1493 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9049,6 +9049,10 @@ static int do_getdents64(abi_long dirfd, abi_long ar=
g2, abi_long count)
 #define RISCV_HWPROBE_KEY_IMA_EXT_0     4
 #define     RISCV_HWPROBE_IMA_FD       (1 << 0)
 #define     RISCV_HWPROBE_IMA_C        (1 << 1)
+#define     RISCV_HWPROBE_IMA_V        (1 << 2)
+#define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
+#define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
+#define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
=20
 #define RISCV_HWPROBE_KEY_CPUPERF_0     5
 #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
@@ -9096,7 +9100,15 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *e=
nv,
                     riscv_has_ext(env, RVD) ?
                     RISCV_HWPROBE_IMA_FD : 0;
             value |=3D riscv_has_ext(env, RVC) ?
-                     RISCV_HWPROBE_IMA_C : pair->value;
+                     RISCV_HWPROBE_IMA_C : 0;
+            value |=3D riscv_has_ext(env, RVV) ?
+                     RISCV_HWPROBE_IMA_V : 0;
+            value |=3D cfg->ext_zba ?
+                     RISCV_HWPROBE_EXT_ZBA : 0;
+            value |=3D cfg->ext_zbb ?
+                     RISCV_HWPROBE_EXT_ZBB : 0;
+            value |=3D cfg->ext_zbs ?
+                     RISCV_HWPROBE_EXT_ZBS : 0;
             __put_user(value, &pair->value);
             break;
         case RISCV_HWPROBE_KEY_CPUPERF_0:
--=20
2.39.2


