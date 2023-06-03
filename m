Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E53F7213A2
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfH-0006zS-7W; Sat, 03 Jun 2023 18:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfF-0006ym-Bo
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:01 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfD-0004vK-SA
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:01 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6af7d6f6f41so2759411a34.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831038; x=1688423038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrRYdivMM96HHIbU1TiSv5S5HwpNhqcS+USfH17ZDVY=;
 b=ZXuuw79Q0AXcArghSOpNGM7ZhhfqJqq+G12XrJbknFGuot9DBoWnDFR3N8Yy3rS+cf
 1TRlezftf4zPawOUGiN7sTBWIOJetOF85mQTkt26vTFda376qx8YguamEQiofnfy4U88
 qnxViD7lVL3bj7b+YML+ljh8QCAtT1SGTLz8NlsauCI1efv65mclBMqWEE3zs6YQWmVh
 WFOBbHF9WJSp03IRiAZc5fxa4MyncHy00HJYaIe0fZu3L1O8T6cksE+USRNmDYIbfH9t
 TLTb6b5/es9Bq6WqJvOZwV4DQTHt8hh90HlXtJVfNuOrGZvzrJ+8F0/xaMZLRQEbs9Q2
 lwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831038; x=1688423038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrRYdivMM96HHIbU1TiSv5S5HwpNhqcS+USfH17ZDVY=;
 b=TwUEK27Fhyq85M8SfdHKDTAXvsDEho7LbANduI1qtW4u+AxBtW8EbO9Cnq0EDapflp
 9UDDlv8qEgH5zd5PlYGJGBquiW9tPMXLjJH/jwfFywgDu8foMiLS5fV8YSTrm7+8wX52
 Fe0aclWdEbKL2qWwLOsldvBO946tIFpRxkO9EreRwQri3FlqmXhOM7XJFS1AgcsDpHGU
 xVyOwl8QWBy7zqdqBaUx45LCuq6kIcrWHRJXv8Au3G/82qLhG1ccZw1YPiQWxGwhsu9G
 t03JRC4SukX1li/fa2doitO3Xuh7odlcy0uTVqkQp3pVXf+hsdy33LVFiOAmYf23Wr8f
 6/qQ==
X-Gm-Message-State: AC+VfDymluq7EPqFu9ywF2vKWGwYgJSaXMH5BCUVUcO3IfKiqn/++OM5
 jraNem1R01XmGUS1C6zumV959loa8hHyaoyMnwo=
X-Google-Smtp-Source: ACHHUZ7YynUg+qZWf/o8OXjcVw/zSefbaj8PzMKXAKAC4uB44VdUOx1kJefNXLeOZUbWYJmizlHidw==
X-Received: by 2002:a05:6830:39d9:b0:6b0:c632:ff59 with SMTP id
 bt25-20020a05683039d900b006b0c632ff59mr6357282otb.19.1685831038698; 
 Sat, 03 Jun 2023 15:23:58 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:23:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 02/15] linux-user: Remove #if 0 block in syscall_defs.h
Date: Sat,  3 Jun 2023 15:23:42 -0700
Message-Id: <20230603222355.1379711-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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


