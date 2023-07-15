Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B747548FE
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:57:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfiI-00041S-Il; Sat, 15 Jul 2023 09:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfi9-0003zb-FV
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfi7-0001Cq-E3
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1745954f8f.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429202; x=1692021202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfPcEEmBTn/D8MUOuhUDyuANxxowzTkGOvS1jQDZcxE=;
 b=OqXein9fBinO/gwAQJ8NmBxtj4z+/9wVz+3A58p4ExqZfC2jmo/5zpQk0tHgvWUksX
 tLO+e0KJc0xpFME0uwTGrunPDbS+Ikca/Y7DPA6ez2v6P4m7wf7GL+miQ5IRK3gm/aRD
 3MxwFiaZ5U0ywH+XqtscY404bD0IHIe/wVCpkiQn6zm7Lhlz/i5Aa/ffncsM06Vp26jo
 cRKwfxU6C5+sLrHYRs+x6FrVShqaiJDqmCpSTgaLE47Pb8/FHiQniteWjcOttPL9TQjD
 Owar/jrPyzbqen+GNwAiwx5Azu+hBwoFQ/InRhHAyt01O2zlLzHR1iJESI0ZhKNDr0MO
 8ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429202; x=1692021202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfPcEEmBTn/D8MUOuhUDyuANxxowzTkGOvS1jQDZcxE=;
 b=DqmalAbj+qtMaMbq3p3nYCibUoAJCYvhSWsGxQ/cOeOy6ss7i4XNj/nizlcw5r2WTj
 Z3qk2BtvJHmu5WnXY/wBOrIRqpnH0zTMA63YnsdWMInUPlBj4iCar6dBH/HPR2D63Zwb
 dx2Hnq66VfUqApRjNfO9MoPBtZ0o32mUcbNLk26kjq6yHXwWZODuTFHr67CAaqDH/XJc
 VehvSa9kOpGMeA//yjXcAwVsxKM6NTh2kLkAquEmVcQOWndZzhW5hnOmylsZF9RjBbi/
 egzGn5dtuc+zhmYasMNI4MWK4DUKMmklybYHWp68fLQM3bd3jAs9lOh0mtJ1YZBmarJX
 pe/A==
X-Gm-Message-State: ABy/qLYk/hZps/IbTbp/mJtQuaq1S6E0IZynS7vM/EH+ytHR2BqrwSFB
 MnkIRB7GPz62Y97Kvs7ugFyo+ij20pysBCDReO2+Rw==
X-Google-Smtp-Source: APBJJlF8ZrgLNdYZUaBRUsdBzu64bm1Vzu0PAsMrHFwQkOywWdaTuUbOF8V+JuHCJjHULx2KD4U0iQ==
X-Received: by 2002:adf:ed82:0:b0:314:2736:ba3e with SMTP id
 c2-20020adfed82000000b003142736ba3emr4533911wro.3.1689429202013; 
 Sat, 15 Jul 2023 06:53:22 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/47] linux-user: Remove #if 0 block in syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:32 +0100
Message-Id: <20230715135317.7219-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

These definitions are in sparc/signal.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e80d54780b..a4e4df8d3e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -547,30 +547,6 @@ typedef union target_sigval {
     int sival_int;
     abi_ulong sival_ptr;
 } target_sigval_t;
-#if 0
-#if defined (TARGET_SPARC)
-typedef struct {
-    struct {
-        abi_ulong psr;
-        abi_ulong pc;
-        abi_ulong npc;
-        abi_ulong y;
-        abi_ulong u_regs[16]; /* globals and ins */
-    }               si_regs;
-    int             si_mask;
-} __siginfo_t;
-
-typedef struct {
-    unsigned   long si_float_regs [32];
-    unsigned   long si_fsr;
-    unsigned   long si_fpqdepth;
-    struct {
-        unsigned long *insn_addr;
-        unsigned long insn;
-    } si_fpqueue [16];
-} __siginfo_fpu_t;
-#endif
-#endif
 
 #define TARGET_SI_MAX_SIZE      128
 
-- 
2.34.1


