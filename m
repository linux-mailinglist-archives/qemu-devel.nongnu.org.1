Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F276A1C47A
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Jan 2025 18:03:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYJ-0007mA-MY; Sat, 25 Jan 2025 12:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYB-0007bT-MI
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:28 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjY9-0000Vz-TD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:27 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so2749609f8f.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824544; x=1738429344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxDvorJyhEvTzUUQpDwPeiHnLMk9jCN8DN75q+YWX5k=;
 b=yaxoYgbcLrG0AbeBuB/uydvM3QT0JXCyXgZG/CaQaE9tyXTEkYLNTiKtHR24ejkkGC
 tPmkxSctOdWSnGi99v5Sl90iL0J+8gwtxvJR0SNjNqJT8dezqpGnGNaUs2G363kYwTWK
 HGASgW/UZVsz+DnXEFIhcZBZIwB+ncJrZ9kqgrpFmbnUHi/dJ5VulSwZRuBVdTi9Z85U
 gAoTz99L/vU0UfBwKuSijAiyEiNLFOJVn+97ydIqi/je7qdDtxxoRS84k8blzkoNTlpr
 3DQ1/ogzCt/0ekAzgbO9BLT6hLn8CGxVXtWD07Ansrn3hNcWQu6XLYBHChBpufA+H9OV
 qSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824544; x=1738429344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxDvorJyhEvTzUUQpDwPeiHnLMk9jCN8DN75q+YWX5k=;
 b=mBGTh6Et8D+uZ3I0oiJPGPk7L8mYaOTuuO0X6wzWufKadGGqGI5Mw0TT9j/m992B/X
 4SjQNUhkEOxHlvkywpNjkecxo4sJE7p7UUPDREer3J7ODFlARHwhTAuIfgLEmdodp/Ea
 Y4VMIqELR3DIIMmMayMXBN+CF302ISXPeJImNjtGo9Syn2i1VYLNKd3WDjUF2I2yDkSp
 bVyfGdvLbC+/T/me2BlImdpONISbumGKO2XmDysUAXNEW1gFkdFEWZ1SO96UIso9C4Oy
 bVqxdX+DYtwKrRXr0EcTxFL2EjgOJGUaYxT3nANz1MFeDfJUo0giNx9EVm1GZG5XPnMm
 ag4w==
X-Gm-Message-State: AOJu0YzzE1DgRhtVg+lSfi4ctt36px8z6jSDTZh60XbHRxfj1tkgr2u/
 pflyQ8ULTvqLCVsGBqagQoenAid4n5SCiBaML294wEgWv9Th/fI+HzeIqkw74yKrltTv6fbpoED
 tjrI=
X-Gm-Gg: ASbGncsnre4qh9eqjzJb5/derAQSB/pH5ErwNHdC59NY556q/ZqGBfs+CN1L8lCNGew
 Uf1+ZhtEYqDAdEAveD5Yy6cCymvSvJ5fSFxsbHZ3Z+GUrRwW67l4mxOQzdUWSfPHSiWuqbaFxBo
 e1WAy20Ygkn0g1KCYMo4n3ZJ8WhhaEI+ym8Kn6Yv9yTVBYliMlGU7b6AuNnl8fxUnr3JpU2ISG5
 cBygjhWj78TRMoDEr6lyM9qId8B1uNXW0rlFGd0UlMRp0zPOA30rYqYs3BCvh2O9H1Sx53cai76
 RGMNWsbKaIg40HbHrg3mi6Y28AdRGkWT9wXnx7xa7sVJd5YExecBMbY=
X-Google-Smtp-Source: AGHT+IElU3CmoHgm6P5E4R/D/n5GJND2j0ODrU6aU+H0VQ2gs/t9JMYn/cjJiTgLHBIEnHNaCaXVJA==
X-Received: by 2002:a5d:5f8c:0:b0:38a:873f:e31f with SMTP id
 ffacd0b85a97d-38bf5677ca4mr29730759f8f.1.1737824544092; 
 Sat, 25 Jan 2025 09:02:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1baf3esm6103844f8f.75.2025.01.25.09.02.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/24] target/microblaze: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:13 +0100
Message-ID: <20250125170125.32855-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f114789abd8..7a90cb3016b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -115,10 +115,12 @@ static void mb_restore_state_to_opc(CPUState *cs,
     cpu->env.iflags = data[1];
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool mb_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -415,6 +417,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
+    .has_work = mb_cpu_has_work,
     .get_phys_page_attrs_debug = mb_cpu_get_phys_page_attrs_debug,
 };
 #endif
@@ -450,7 +453,6 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
-    cc->has_work = mb_cpu_has_work;
     cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
-- 
2.47.1


