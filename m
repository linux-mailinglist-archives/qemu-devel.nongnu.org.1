Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F527B6FD4
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFD-00006M-M7; Tue, 03 Oct 2023 13:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF8-0008UY-03
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:34 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF5-0007Xd-7G
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:33 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57ba2cd3507so686064eaf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354290; x=1696959090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCQObv9jj94bGM+uw0gpwPFUW1gAHzG1Iim/6umT+FE=;
 b=Fz40KNil10EwdxT8JvMwr4WVAbwdbfX3bZierP1myHPnlIzNgkzqBMhbUHEPE1c3Tb
 yXqhLDAukSWYnE6dNSHCyW5dvolUZ6+t5Wrbg5RKixR5LLrZAsqterH0jEZTqPyUo4AQ
 OrESOhhjGrBZBsNIbkcRik4z6P9NmxiwTD843ASMgQTYZUGcgB/SrYQzTq0wiJA7MuWF
 FF3J2skx7/IqQYHZekn9FBPDrIu2aC76eR8LGwBzbKVPIO8GHQvnfKS4EUho9yl4MfkI
 Dv8KGbIoL/f0EdAMscZ5t+Bq3UyqbDZNHYE+BrmiObNr8dbQAmfC5e6mXtnfNb4WlCLc
 Y32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354290; x=1696959090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCQObv9jj94bGM+uw0gpwPFUW1gAHzG1Iim/6umT+FE=;
 b=vixJYk4AA7b4ntR5TfilN6PfADzBavFV01wINeeWHvhszINPcMmGIt6/yRSJU/Qe7c
 vmT+wU1TphPYJXHLusysiKQ3+1jbQj9uFzJx8dhA5C4AYuTQ6vLTbrM6iu2XhnRzLPaf
 KNde86gcdwM39BmrTUP4PtQk0mtlJzFCvQYEMOo64KFXN1rzPKXRssxCWlAepXpgUd6Q
 YDFulxcxdRZk+ZH9BayYlWOSRwbSyNscVHNh/4Dhkek3QzvUrmmYYuRTTkQxWs+8SKBC
 xAbRDYq0psr48wIr9PXOhEhnOu8ffEdtci18gVz3f+CX7yrbrdSNedEszxjYlXl+p3PO
 75rw==
X-Gm-Message-State: AOJu0YwlbgtnjB8FX1XP28NiO50mjMJel/hc/b5XCijyQr685lAGqwmy
 JUxqPd89dETP+pNgjGywPbEh/w9asf22spe1lHY=
X-Google-Smtp-Source: AGHT+IG2QoJwDqSo9KsVlrr/d88D9ybz9nbtu9oU70a/E8stSuHFhQEy9SxR0PbQXH2HNI7LBqHGxg==
X-Received: by 2002:a05:6358:910:b0:13a:bd3:3f85 with SMTP id
 r16-20020a056358091000b0013a0bd33f85mr103916rwi.23.1696354290216; 
 Tue, 03 Oct 2023 10:31:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 33/47] accel/tcg: Restrict dump_exec_info() declaration
Date: Tue,  3 Oct 2023 10:30:38 -0700
Message-Id: <20231003173052.1601813-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
index 57ab397df1..f2fa52029e 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -105,6 +105,8 @@ static inline bool cpu_in_serial_context(CPUState *cs)
 extern int64_t max_delay;
 extern int64_t max_advance;
 
+void dump_exec_info(GString *buf);
+
 extern bool one_insn_per_tb;
 
 /**
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b14255923b..5340907cfd 100644
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


