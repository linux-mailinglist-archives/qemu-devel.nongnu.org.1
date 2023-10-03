Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4B87B6FF2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjJD-0000R4-5r; Tue, 03 Oct 2023 13:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIH-0000As-BY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIA-0007sN-5h
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c6219307b2so8691405ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354480; x=1696959280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gwPqWvuhcHJ9I33/TA5Lbxvf9yIUByfRRWOPYGingU=;
 b=ftvKVga3VaPcxwtw2L/u3dM+cx3zMtg7C+uM+aW/9tEkugyvAw7OuMrjoxuhsdbFsI
 rwAYNh2QpRlrrcgR+Prxj8mFPPqEsWPXcrz44OGfUy5/4PJzwxbQ2u68gf+0dmdvquID
 DJbSbNw5nfEhjUYsjUyUnEcI+1zDzJDh67GrJYyIoV+mViKCkTDWKedY0fFzaXswJ2ZW
 3Bn5C8WVevB5NGSJcSUAzX1gA+AxrKgoSlzorYUfdJgGZ4O9kz7dMV1rFYW+vjhurz0K
 qXm080RBryW5WlH2ifELrDjdzoWXNlF6IqReR5LCcAB++nquyI2WM3XW46xXAWYmARQE
 2rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354480; x=1696959280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gwPqWvuhcHJ9I33/TA5Lbxvf9yIUByfRRWOPYGingU=;
 b=N0bcUQ2Wr12GeV3TONL9LpOT3inaA4Ar25gpRFEl/XJ9qy3tP5Xs9NwzUnxji1/KNc
 QPwoB4hbI3nPawDtn5xkGJXpne8xIxCAZfadKKW06IX4nZ/b+rtw8Lqny3TXM6vQaMj6
 /yI2jnLLJTpVx9HlilJuEtEKri9UchSJUzRId+NWhhIKk46qd14k727dI9i0xUmBbIEL
 xrW5CeTXVEU/dzuUDqm2DgoEzMXMikJXNpN1NRzuorb9x1bppELAeU2ct1+HXpiCPLjq
 X9cd/wjSzItYsMe0PHOIPDXLxXhW81OPeao1l1IbbawjQSAk23OfOG1GDIa+P1AoqFJW
 wtbg==
X-Gm-Message-State: AOJu0YyIjdIR977ECltuhlJeLdIRN6OiDJH6gvUxWy2YcK3RVCoDgD81
 yJ+FKN9aHtEj38hMseBkO1zUj4P8difJrg97qFw=
X-Google-Smtp-Source: AGHT+IFhizAEfdhHzH5+9+rgOe2T3ev36Mq7Z4rdstpLKGynil4+c45ZB6QhPgAAWiIB4SjTjclS+g==
X-Received: by 2002:a17:902:da89:b0:1c7:3aad:305e with SMTP id
 j9-20020a170902da8900b001c73aad305emr382991plx.27.1696354480591; 
 Tue, 03 Oct 2023 10:34:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y9-20020a17090322c900b001bc676df6a9sm1855118plg.132.2023.10.03.10.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:34:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/47] tcg: Remove argument to tcg_prologue_init
Date: Tue,  3 Oct 2023 10:30:47 -0700
Message-Id: <20231003173052.1601813-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We can load tcg_ctx just as easily within the callee.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h   | 2 +-
 accel/tcg/tcg-all.c | 2 +-
 bsd-user/main.c     | 2 +-
 linux-user/main.c   | 2 +-
 tcg/tcg.c           | 3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 7743868dc9..2e2d12d421 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -784,7 +784,7 @@ static inline void *tcg_malloc(int size)
 
 void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
 void tcg_register_thread(void);
-void tcg_prologue_init(TCGContext *s);
+void tcg_prologue_init(void);
 void tcg_func_start(TCGContext *s);
 
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7ea7dead16..a81400d3ee 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -121,7 +121,7 @@ static int tcg_init_machine(MachineState *ms)
      * There's no guest base to take into account, so go ahead and
      * initialize the prologue now.
      */
-    tcg_prologue_init(tcg_ctx);
+    tcg_prologue_init();
 #endif
 
     return 0;
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 6c9addb75a..7ad406903a 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -586,7 +586,7 @@ int main(int argc, char **argv)
      * generating the prologue until now so that the prologue can take
      * the real value of GUEST_BASE into account.
      */
-    tcg_prologue_init(tcg_ctx);
+    tcg_prologue_init();
 
     target_cpu_init(env, regs);
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 0a62e2be47..eb66ddec11 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -994,7 +994,7 @@ int main(int argc, char **argv, char **envp)
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
-    tcg_prologue_init(tcg_ctx);
+    tcg_prologue_init();
 
     target_cpu_copy_regs(env, regs);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9256217b8f..e37e5a3b5d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1395,8 +1395,9 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     return tb;
 }
 
-void tcg_prologue_init(TCGContext *s)
+void tcg_prologue_init(void)
 {
+    TCGContext *s = tcg_ctx;
     size_t prologue_size;
 
     s->code_ptr = s->code_gen_ptr;
-- 
2.34.1


