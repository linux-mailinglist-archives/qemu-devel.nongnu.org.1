Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4CCA1D5A8
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Jan 2025 12:56:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNia-0007j4-JT; Mon, 27 Jan 2025 06:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhs-0006rj-Vi
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:22 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNhn-0006zA-QA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso27339155e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978902; x=1738583702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4IS3z5t6aeYLZ7NAuHNel+nPJsLHRUkUZSl5ZYMkwc=;
 b=knJHu9SyuiZHxjrTdCFTk5xLIAODPj6854jIhzC/TQhm2RzIu/EE0qY+fnHPRekzuw
 BypN6mGXmoxhwK3Oyf4HDwyYWoSUPGNIYe9PPLOWuqGa7Un2ez2+vGTHUwlE1Hj/Cd61
 80YSTPOEL1cqRhSbTtE9XTgjIIbVAeWJdU4oRGyFMnUK7PxqGiur5FwxhQY+d4xqcv75
 bnZe6ZcMeiEfkBg0JqgByxje+sixQ7n7zQbgo+vcR9vMgM0p8Hi4Ado4YlUiUE7iYTZz
 zroleyWXpcKe8NJdl8O7/8IO6zugb7MUulvdM/vEEjNeHsjOgUCddqj7fvQ5vmBSwgSF
 p6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978902; x=1738583702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4IS3z5t6aeYLZ7NAuHNel+nPJsLHRUkUZSl5ZYMkwc=;
 b=b4mrIabQR2Xsc4BWvb7zVevlYFY2+X50yWOTtrXS8oYY+pDZ9x03v1l8nVBtRmzex9
 fDRYTt+beBJJ1oaxxrTk/9fTI4DLmn/IjzYyQlDZVHByCH1+X1Lxn57AKfuKSV7VoEEz
 Uig9avQoU8lt43EbA9olRuoP+7t7vXW3AmjueNFFLhcos7NNU52uiQqXyA0AnIyOtJBy
 4aRwRxPr1vDBrpPFKN/+vw2He1cytBMmTYBOEKHeSh2yuktamzaKNR+2l97WNMlWluhc
 VwegXOhyZB/Tjq+LfFctRhumhA+e1XuVF4qkgD9QwBpZ0BgmxfCa31YXlnW4aSAhYJAE
 V33A==
X-Gm-Message-State: AOJu0Yyc2vSDKHx/7WreUnTPAS1bIM8SnWhXaE9nO4DU4WuGxce5AQhx
 SBknutGjkbcbmv4N8ExsHsPCdQeZv+DaKWnssUIRJJgfL7iBzA+JwHbXgIw7/biWbFdCM2zM/9J
 GmKk=
X-Gm-Gg: ASbGnctuzI2Vo5ZdKv413xbMSM9Mabiogli5b7PLYprRF1gSVCRgjIk3OyomJDOMj5X
 nvahiU6ZCAs8bGXDEScczCDsMFNrqI3bCXUUE7ZawDB0ICuVnIFoHd+16M5mP/+5CJ/c4jvZBsu
 L4D2l1IA1olSo1MVSCo9ns4uIxSqPp16RwhST1bHT/B9PQApmWXwSw9m/Apbm+3e/UZMoWsaJMk
 wdjkkBakXxXhyFTKsqEI+PUz8cj2eTtuISuyiZNLVpsZkSe7KmM/xVxKqzIpWFm1FlEVFaFMuHz
 TrbgUs4n66bqP5Fbmwh34ftg6CePZNO541xFGvcMZMQlv1grllGbhAg=
X-Google-Smtp-Source: AGHT+IHET3rqSbR9s6dSwCNjBB9cODBqyhqFPWhEqy/MaP3DAHoJvFDTTKe8eo5it+0lahivn9T4jQ==
X-Received: by 2002:a05:600c:3546:b0:434:fc5d:179c with SMTP id
 5b1f17b1804b1-438b885f8ebmr162465155e9.13.1737978901751; 
 Mon, 27 Jan 2025 03:55:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48574csm130454235e9.9.2025.01.27.03.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:55:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/10] target/riscv: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 27 Jan 2025 12:54:23 +0100
Message-ID: <20250127115426.51355-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2c..b39a701d751 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1156,6 +1156,15 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     CPURISCVState *env = &cpu->env;
     info->target_info = &cpu->cfg;
 
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    info->endian = BFD_ENDIAN_LITTLE;
+
     switch (env->xl) {
     case MXL_RV32:
         info->print_insn = print_insn_riscv32;
-- 
2.47.1


