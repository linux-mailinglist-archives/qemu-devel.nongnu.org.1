Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D57E3D54
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:27:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LA8-0007Fw-DP; Tue, 07 Nov 2023 07:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L9d-0006Fy-ET
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:26:05 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0L9K-00057a-Ea
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:26:00 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so80522671fa.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699359939; x=1699964739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzHw9gxC37cDWskQ8Q09i1BaQBpN31WzD4SH6IynXXc=;
 b=CvKBMHhBGXTLC6ew4HjO2vX1SrgW4YEzhsR/cEtPTzKXNJGY/F87F7afNw0jSdQvRX
 ibvrxSO27zkrDE0gafJSNnh5tpCD6+K2nT31rLFKbA0QpkwwvHEt/6xnwr2OuhEzZiS3
 dEzudWcDJhSga5FzeRVYsaienTSX0lWUuVQufwpRnBW0e3JJJm6Wbps9hEQBmKCb89AC
 d7v0mwBUq6qTzXS+1L/CDJLlkxDq9cj2bKHm7/DgAMBvb0CX70thTkiZhwetqGRYYHOP
 CdJTSQ1nMBc2ZaHN1Q2irxZAEL8dph4kDEQvNqKLmeChXXMnb+zA3N85CwHsiijJ3qe+
 0wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359939; x=1699964739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzHw9gxC37cDWskQ8Q09i1BaQBpN31WzD4SH6IynXXc=;
 b=KzA/t1YhtkpKywF4WhepEbLYvg+A7X/IS+QeNs/2To6dLm8D1UT6akMXN7Zbq0xnZJ
 M79jB4LFY3jWiJG5YJ4KRsIPoYMXMdVjQsTVaXl4YnMUHdKFbPDDAPmDhxPmpDbMSkv9
 WHfhhBlq7v07fHLQ6oEUXiXf8VXuEtTVNQCpwfAvKzdk1L7nO6ZDuMh4zjLQexSpOLWr
 FbBhDqfK6ycLFqrCJ2MPV422PaL46EZnPmA1uI/xUXTqk/aOtmsG5ngQ8VQ347dheO6T
 eWvax49Ig7MuLifsquZUUnuIWcv2kUynX29L2gVIpR/lIG+rgi00gFoZ6mpfb3UEvcko
 eWBA==
X-Gm-Message-State: AOJu0Yxi4vBHT3Vig3HLaXtNSie2Kj+Q6Q429KZbGzDG2DYA5gnuTTRz
 s/6PkH9c4MJICOPges3EEczlVZQzw4+Pr+QBhlQ=
X-Google-Smtp-Source: AGHT+IHYS2sWYgS68pTucc6D2gT5/C0id0v/lkcQcfo8MWiVRRZXBiRLiYanm65MPWc8YdA86y3qKg==
X-Received: by 2002:a2e:3910:0:b0:2bc:d8cb:59fe with SMTP id
 g16-20020a2e3910000000b002bcd8cb59femr22459267lja.8.1699359938985; 
 Tue, 07 Nov 2023 04:25:38 -0800 (PST)
Received: from m1x-phil.lan ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 l26-20020a05600c1d1a00b003fef5e76f2csm12701908wms.0.2023.11.07.04.25.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Nov 2023 04:25:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 44/75] target/s390x/cpu: Restrict cpu_get_tb_cpu_state()
 definition to TCG
Date: Tue,  7 Nov 2023 13:24:34 +0100
Message-ID: <20231107122442.58674-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107122442.58674-1-philmd@linaro.org>
References: <20231107122442.58674-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

cpu_get_tb_cpu_state() is TCG specific. Another accelerator
calling it would be a bug, so restrict the definition to TCG,
along with "tcg_s390x.h" header inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231106114500.5269-4-philmd@linaro.org>
---
 target/s390x/cpu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 38d7197f4c..110902fa3c 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -29,7 +29,6 @@
 #include "cpu_models.h"
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
-#include "tcg/tcg_s390x.h"
 #include "qapi/qapi-types-machine-common.h"
 
 #define ELF_MACHINE_UNAME "S390X"
@@ -383,6 +382,10 @@ static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
+#ifdef CONFIG_TCG
+
+#include "tcg/tcg_s390x.h"
+
 static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
@@ -405,6 +408,8 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
     }
 }
 
+#endif /* CONFIG_TCG */
+
 /* PER bits from control register 9 */
 #define PER_CR9_EVENT_BRANCH           0x80000000
 #define PER_CR9_EVENT_IFETCH           0x40000000
-- 
2.41.0


