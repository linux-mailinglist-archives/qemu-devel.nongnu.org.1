Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C35A7FF1BA
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 15:26:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8hz3-0006GN-1q; Thu, 30 Nov 2023 09:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hz0-0006Fm-8T
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:25:38 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hyx-0008Pr-Ht
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:25:37 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50bbb4de875so1429255e87.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701354333; x=1701959133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RVrwZHzqL53D0d21SzvbYXyLe3vUhOAbfQcX8nMf5Y=;
 b=NpP/uEpw5XkiKyWF/D0NUol+2idkFYl1Vqm4Z8PiTyeB5h4HaaNz73DqH5oA64bjBO
 ABv3V3n5SsdttRmCF8AYcTwwo1av94dgxft5KEV1oJpHFfwg4EIRlbtIdwJXE3AeyHsO
 WNOEBZ1hqfr4o3PkZpqCnznS7b5RAfUKHxKJmdvTYGJkLqIO5WDJLhTx97jLcOQ6cZNM
 frmURUwIVrbeZHqkEI0w2hG6aAq6pNdUc0K63jupeT3PwF9hvm+Dv0I5/1Mlu3CkeLiy
 Nl37KwTq5X3oww/GC+f/6cax0rw8oXOGsoleZJmvY3HrSG/FnKct91f5WjICZOJ0fANr
 U1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701354333; x=1701959133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RVrwZHzqL53D0d21SzvbYXyLe3vUhOAbfQcX8nMf5Y=;
 b=pByunrmvhH4GszS7kLDd8ETaZJpiphKdwb6FsgF/wN+PpsvXydNpDwTITC36NLUils
 ohkuoiQHNhFMwU4QSqSVlxUvnc7tW5WFEgYh166xDdSM9s1QKCRUWxdM5kv+B6zpi7lJ
 zqWSBXZWNwjmBJsGJzhkKQyGLmA3G6XJjeL+M8cCtrC1/ZYnzBKfrJBRc9rh7TKfLGWL
 VJ1oLXNrOmEHjmCKgJsqFrbPIjz6w4fjbbHiuw26QRf9+l071EtPfMBXbqYjM1xPyrSL
 fwqeIb83VK3u4D9+PGcan5LJslPhqgHdUDKdYNYIV2jAiOFrEtvQha69ITQlWhvtDEe5
 Iw1g==
X-Gm-Message-State: AOJu0YyCxUDc7O5wqHPARtQYMx029RvvbmfAVl74DRTNM1rHtr8ZAKnk
 41MfTWqM3bIYcG0kT6l32kjde6KCqjOh7Ai80H0gBA==
X-Google-Smtp-Source: AGHT+IHqWxGWu3FYouLY1vUkrVp9oOiZ2MHIh5pGZ884N/2cipX2YzXpycbaYUz7Fboid2u/imneaQ==
X-Received: by 2002:a05:6512:3da5:b0:50b:d4c7:193c with SMTP id
 k37-20020a0565123da500b0050bd4c7193cmr460444lfv.24.1701354333339; 
 Thu, 30 Nov 2023 06:25:33 -0800 (PST)
Received: from m1x-phil.lan (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 w8-20020a056402070800b0054aeac2c4b9sm591628edx.81.2023.11.30.06.25.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Nov 2023 06:25:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 2/3] target/arm: Restrict DC CVAP & DC CVADP
 instructions to TCG accel
Date: Thu, 30 Nov 2023 15:25:18 +0100
Message-ID: <20231130142519.28417-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130142519.28417-1-philmd@linaro.org>
References: <20231130142519.28417-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Hardware accelerators handle that in *hardware*.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4844cf1d78..20e13215bb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7645,6 +7645,7 @@ static const ARMCPRegInfo rndr_reginfo[] = {
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
                           uint64_t value)
 {
+#ifdef CONFIG_TCG
     ARMCPU *cpu = env_archcpu(env);
     /* CTR_EL0 System register -> DminLine, bits [19:16] */
     uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
@@ -7669,6 +7670,10 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
         }
 #endif /*CONFIG_USER_ONLY*/
     }
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
 }
 
 static const ARMCPRegInfo dcpop_reg[] = {
-- 
2.41.0


