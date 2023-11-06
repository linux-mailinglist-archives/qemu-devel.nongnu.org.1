Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A07E2060
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:52:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy2s-0002FQ-KD; Mon, 06 Nov 2023 06:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2p-0002C3-0P
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:27 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy2m-00058A-8B
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:45:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso31458865e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271122; x=1699875922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OScb+MD6WbCnK5YT/0hy0dsrhtV6qe8GNeuNwraSp7g=;
 b=zvaOW7nTPooBOgajabZDOEBejKDSo4LJBGr5sRYU2UEPGEN7mpaueH6X3GkAcfEVZZ
 iga3pgvA5McGL+3Sjx7yf6sky4FqyT6fGxJey1qWnKxF8lMl48VU7ZwgGOAgIYvZr0I4
 eKTFbwGHrctUBVZPP1Qhbx01/JSNWtZNIEFEaJCHqkm9EbfSabFYtv91ZmPlGzskoApM
 Cvxqgdsne1le7iU+hdTBJ8IhyvbsU/6g/ycmLug2F3+x0MJy4kl7Mjqt9Y4P8CxrsFJd
 sV3btX/mNsM1R2qWG9Rl9Y6H+3Ekox0G1Gsk3eJVYt39++zHOKMEP4+B/qJc+mZIQsHE
 /eCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271122; x=1699875922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OScb+MD6WbCnK5YT/0hy0dsrhtV6qe8GNeuNwraSp7g=;
 b=aGZU6DBW1QQXQ23O5FjRBGFozA0Xh512mYkXy+iSGRORu80L5h/Sxj/5+ioS60Ig3k
 7Zs9/4k6bZM6BfHiWQE+Rrq2E4Q4GlOGcr13EmKUVXytFm6wncPNVPRKr+5UPeS8N7g4
 ltq1B2HdM2Sv3RsMh1WUZ4okxIcWftbNXCysuKHJn+nnRBEGbXV6OWcK2VBxOxalIAhW
 IIlKTnPYfQ+FFeuH0+ospL2ALbGWawFVI6DWNDyUQm36GCj32PCKHDOwmKYEhSKDOYlZ
 GUGRwFgFmnEFyQfZEB43IZMuues1p2ye3uFkzmcq+b85nMafP7RmhH8Sg4KIhwrh7Ir/
 Nd1g==
X-Gm-Message-State: AOJu0YzHt/2dAuxsGEkTFkiJwn7yZvL45AqiM+fiRO4ksnAmbg7D5nL2
 5HEPjp224IElSL2YMitum0ZBX2IQJhzKY7KuTlw=
X-Google-Smtp-Source: AGHT+IGAOdY5A3GwN75FdxPAG0atuBxGA/wwWhD+pwzZ1XnfwZucSKccVnRSndvi0N85iekeVf/bQA==
X-Received: by 2002:a05:600c:1c90:b0:402:ebe1:7960 with SMTP id
 k16-20020a05600c1c9000b00402ebe17960mr13100183wms.2.1699271122597; 
 Mon, 06 Nov 2023 03:45:22 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b004064ac107cfsm11920533wmq.39.2023.11.06.03.45.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:45:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] target/s390x/cpu: Restrict cpu_get_tb_cpu_state()
 definition to TCG
Date: Mon,  6 Nov 2023 12:44:58 +0100
Message-ID: <20231106114500.5269-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106114500.5269-1-philmd@linaro.org>
References: <20231106114500.5269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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


