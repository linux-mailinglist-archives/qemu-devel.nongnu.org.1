Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6880C461
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:21:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcTL-0000DX-Bi; Mon, 11 Dec 2023 04:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTI-0000CO-2z
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:04 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTF-0005vX-4R
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:03 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3332f1512e8so4010551f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286459; x=1702891259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZD5ABaQViFbHONtQO6M9d3Q2YykqwBMH8lb8WaRZX4k=;
 b=jo6bf3pD2C2c/A6G+jnpG6QujJdX+prBT381+gl93tQFLUaJFS5bB21/MRK6nu+9RS
 EcIJIjiYF62xsz48ZsVdL9yAHJRoObmrAkBwJrIqFXRNdX0Nzk/CJMeuBcdiaoyZEJwf
 CzDjjVuUQ2wFm+dVSsa8evzhBCJRRRJs8CokUo4h3TsNa2IbxrBofro7A5P5RjBP38b7
 SRn33tmvbavCarkmJhikBMnKLFsmYzO1BR3ksf8yf0Dd/Bzv0Nfr4nBJtmsA7xRe1D7P
 ta4CQFA5+xLBJ41neEjfRbYckmRQV8+TaBaLG1/XuhCRIZv1fhS1SIyIsGTZBmqsNw2n
 AtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286459; x=1702891259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZD5ABaQViFbHONtQO6M9d3Q2YykqwBMH8lb8WaRZX4k=;
 b=cNyMkNJRtXP5l72qFHytiXTliQwzywpYb8+z2lOH6aPQgrs1G3EZO5XO9cbHAUoIth
 xH9Io0+10/RghsDQoV9G5Db0te0QnyJyhEjxXBmb8r7C/tArFk6Oc+1+DkKDRUJP4oYt
 8hL0AA9Fr3/+ALd7yipGlMsc4GPeX9WfE/YHud5EVYQm489I+E9lNaGXngVyps6waHg4
 MIAG6X3naXBJlVHbE4w3GXYVa1ISSWo9hHgq77MD0HL40Eli/l+qpiSojk4KyhEBUqnd
 WNX912/pGhOWvEL0I2OltfgDNcPUJM8ZT/qpBt6ul7Zy6CzKFLFPEvUx5spa6j2atLJ5
 nixA==
X-Gm-Message-State: AOJu0Yzu5ZULPnbnb9YZsUS1SsL7HZ1qQDd6mz1ijEozWIOOvcZ9vRk0
 P+gkxfa/y7UUbz616Z5C27kV0A==
X-Google-Smtp-Source: AGHT+IFznid3nOP/6Ynh3vPKKTY8KUjA+eNoYpMQQilGH3fkXiImcueck3amfAAMZv7PXiKvB+Ls1A==
X-Received: by 2002:a1c:7417:0:b0:40b:5e59:e9ea with SMTP id
 p23-20020a1c7417000000b0040b5e59e9eamr1966848wmc.137.1702286459320; 
 Mon, 11 Dec 2023 01:20:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c15-20020adfe74f000000b0033335644478sm8081493wrn.114.2023.12.11.01.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:20:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A3EC5FBF8;
 Mon, 11 Dec 2023 09:13:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 15/16] accel/tcg: add trace_tlb_resize trace point
Date: Mon, 11 Dec 2023 09:13:44 +0000
Message-Id: <20231211091346.14616-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

I wondered if the discrepancy I was seeing in fill patterns was due to
some sort of non-deterministic resize being triggered. In theory we
could resize away at any point which might account for the difference.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c     | 2 ++
 accel/tcg/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c35df27caf..63f2a23709 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -201,6 +201,8 @@ static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
         return;
     }
 
+    trace_tlb_resize(old_size, new_size);
+
     g_free(fast->table);
     g_free(desc->fulltlb);
 
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 31dda01c12..11b49a63f1 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -10,6 +10,7 @@ exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
 memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
 memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
 tlb_fill(uint64_t vaddr, int size, int access_type, int mmu_idx) "0x%" PRIx64 "/%d %d %d"
+tlb_resize(size_t old, size_t new) "%zu -> %zu"
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, const void *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-- 
2.39.2


