Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58D7A32B6
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:44:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3k-0005l0-3U; Sat, 16 Sep 2023 17:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd34-0005D4-92
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:54 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd32-0000Uj-0L
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so3062526b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900510; x=1695505310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBIBs23OlZVEshNt40JGjGpTqqNUJKr0SLco/M6cVKg=;
 b=a402C2fXDvVtOTW3LQV9UXBO/knzU8tu9fGnTji47IjoaMcl44T9c8hddr+Tf6hyPl
 Z0HF823PttO4NQ7NQkyxYq8zXDs+NnuQGlp26dQSh88WIwm2GHXTkwglw4Bl6vbeRBXJ
 GjmEiybFkYAyShHf2PmcuEiGgqJEYNfr4wEd1GDk1TCNB8WmHqNs6QGiuPZbFybW7PES
 93z4kuW2lRZhlhykhe42vTSH2SnH/I9v97HJ9iux/VDyBkkxfZb5SKszTpkyJrR0ZhY8
 wK7oYXOUQmlhsVlvX+mXfHr70DXAnjvKuSMpOxCLl9H76RCFA836zIzieS9z201SDjY7
 /2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900510; x=1695505310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBIBs23OlZVEshNt40JGjGpTqqNUJKr0SLco/M6cVKg=;
 b=RHHO8TPdcu/VYgitV2JtHBGpXu/NERWhFLwc6qcLCvYucvClS/YDho+yRf3VmDHeDd
 x/w+0d+TvuVaG6fvfAnsFkvH09iZQjfLGplRiK/MjIWrU4F71iM/SXxVnZY9Pg0uE/+0
 0TTFE/yUc0KnULIQsSis9EC3ohcY8NPpz8S7N8OXZoC2I3mTpbFX6LmCFU+pPa8ZMNdr
 1bcPUwaoFfJoJaMwiePitY/RSw9drCrLR1wayZ/KBGiZdgrAkhvG+5epMBbJ89RTektF
 KxAIpgA1vDaZScld4EzdyaY6WlRwAocv5LUW5lOuzcAdRus+0lAssaNr0L0CsWgK0MhG
 zVag==
X-Gm-Message-State: AOJu0YzWzdbJ/UCWfXkgkH2uEbsNVVojwqbO/LARU+96m4wMWJXek0F1
 jxxLK4e+hDp2EoB6suOgbb70kGbnxhaEKH44T8Q=
X-Google-Smtp-Source: AGHT+IFazrvAFowfXeuQDBN+zk4s/Xm6dg3EaRnd2urjsbMAHDw62sRXA9vnLY2AXFMi7LUBdZtG4g==
X-Received: by 2002:a05:6a20:7d9a:b0:157:64e4:4260 with SMTP id
 v26-20020a056a207d9a00b0015764e44260mr216072pzj.9.1694900510633; 
 Sat, 16 Sep 2023 14:41:50 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 26/39] accel/tcg: Restrict dump_exec_info() declaration
Date: Sat, 16 Sep 2023 14:41:10 -0700
Message-Id: <20230916214123.525796-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In commit 00c9a5c2c3 ("accel/tcg: Restrict 'qapi-commands-machine.h'
to system emulation") we moved the definition to accel/tcg/ which is
where this function is called. No need to expose it outside.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal.h   | 2 ++
 include/exec/cpu-all.h | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index e8cbbde581..cd6b9eb7f0 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -102,6 +102,8 @@ static inline bool cpu_in_serial_context(CPUState *cs)
 extern int64_t max_delay;
 extern int64_t max_advance;
 
+void dump_exec_info(GString *buf);
+
 extern bool one_insn_per_tb;
 
 /**
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 6af7944a38..8d262d141e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -406,11 +406,6 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
     return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
 }
 
-#ifdef CONFIG_TCG
-/* accel/tcg/translate-all.c */
-void dump_exec_info(GString *buf);
-#endif /* CONFIG_TCG */
-
 #endif /* !CONFIG_USER_ONLY */
 
 /* accel/tcg/cpu-exec.c */
-- 
2.34.1


