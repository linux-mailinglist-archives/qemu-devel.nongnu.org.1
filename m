Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5B7EA2AF
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:18:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bVe-0007e0-0v; Mon, 13 Nov 2023 13:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVY-0007Yf-U8
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:01 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2bVX-0000Wg-EN
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:18:00 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9e5dd91b0acso540625266b.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899477; x=1700504277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AakYZYdXvcPNi6Iu21AoMUro5aPu6dbPeOCnwN0r1zY=;
 b=F1HzQ2zgc0RQi1wObhGWQPxS83PEi/uRTzar6dwQfceBuOS1M9Jf42Im/N0QojJ9pX
 2xBV+z/uVK1PgcvnuO63ex3Kt39clLIdR3IKgzpH+ObHvzorULk+J1/HBHyALbnNHbCH
 4TZto6YTDyHMxfA1B5DjR5U1/izLNMI0s2Ysh4K7wKjrgF+2GeLffAtdrWdaT9FsoZ+f
 njR8YE0RUCIm821kGVh1iFtrMp2T+1fmDduNjgfZFVI/ovsRQPJ9LL8++OOW4UdHLit8
 a5R+ZVAysljTIwcfF1QxOqOPUmhVqjB9oxtUG8L8pvjVpGb4N7nA92TMHavOD3YPYbHv
 aJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899477; x=1700504277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AakYZYdXvcPNi6Iu21AoMUro5aPu6dbPeOCnwN0r1zY=;
 b=aAJ84vVYJoh05Wd3igMzYI7bo9dWi+K4HV0qmRUzvY2TlywWeP9U1m0ic1PTbiG9Bz
 DfJTrTAZfqU6tYzuVlYlCUBb9LL4B9jmANCHMHGBF4MrV3kdkamAPmhTIRHrq4LPLk6j
 sUU5TXcWglZGe4QUPzy77r5j25Ggiviq7aYClpWs55R3KcdLRNy6PY0AUaLJH3gBYet6
 tgOJaCma5fS5GWZpkzY8zs1FYRYVKt4ZSuO3LgSdmtAiaUBgnoRVsDfxN+urryyG2IBs
 V16e+t2zleMw3Vb/NCzUbDojM7qZF21639zSr9S2Z1G8qsV++1TP2DsihlkYGKVTTPJZ
 M/Pw==
X-Gm-Message-State: AOJu0Yzek7EqRlKsz1uOmpvNN8pJRtLCiIFKXtWhujAmAMuzzJd1JbVS
 hMDHX5Df6PG3pOUQ5cEH8D56krbOGHRnI8RjR0g=
X-Google-Smtp-Source: AGHT+IGadP1wkT/qgfFvtad+hX3CRGQwn0Z1gbh2a1HMBlKL2ZauDhTR37JLimRaoVjPbuW4bdpSWA==
X-Received: by 2002:a17:906:3597:b0:9ce:96db:c83e with SMTP id
 o23-20020a170906359700b009ce96dbc83emr6134233ejb.42.1699899477751; 
 Mon, 13 Nov 2023 10:17:57 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 ov22-20020a170906fc1600b0098951bb4dc3sm4334101ejb.184.2023.11.13.10.17.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 10:17:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alexandra Diupina <adiupina@astralinux.ru>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] hw/display/vmware_vga: fix probably typo
Date: Mon, 13 Nov 2023 19:17:41 +0100
Message-ID: <20231113181744.49537-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113181744.49537-1-philmd@linaro.org>
References: <20231113181744.49537-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Alexandra Diupina <adiupina@astralinux.ru>

When calling trace_vmware_verify_rect_greater_than_bound() replace
"y" with "h" and y with h

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 02218aedb1 ("hw/display/vmware_vga: replace fprintf calls with trace events")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231110174104.13280-1-adiupina@astralinux.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/vmware_vga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 7490d43881..3f26bea190 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -336,8 +336,8 @@ static inline bool vmsvga_verify_rect(DisplaySurface *surface,
         return false;
     }
     if (h > SVGA_MAX_HEIGHT) {
-        trace_vmware_verify_rect_greater_than_bound(name, "y", SVGA_MAX_HEIGHT,
-                                                    y);
+        trace_vmware_verify_rect_greater_than_bound(name, "h", SVGA_MAX_HEIGHT,
+                                                    h);
         return false;
     }
     if (y + h > surface_height(surface)) {
-- 
2.41.0


