Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E79273FB6F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Ef-0001up-MX; Tue, 27 Jun 2023 07:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7Ea-0001tw-Mz
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:48 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7EZ-0004kQ-66
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:48 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-986d8332f50so561017766b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687866705; x=1690458705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwRqncGBMw48ZRHZQQygcwpEXInzVqgYCZMTOEm7gro=;
 b=mnixBROMk4W/E5oZOyhcDKzrHtFUiMXo/SHSOVZCdjVa4W+QHAk1YP6JN0WdriXCRg
 7kgoxdRSdpXiXm9/tuZtgVuUAVG4ULDZsoY7BNnEAtsId8Zrgl3kiwhYh8lszegl3BbK
 eboQUwrTSJ19pIAC5BvplUdAQ5sUlzxk+8+17nFe/f8c02iQ5HztThoAHTWuKxBxryTN
 vQz3qYE32MLVfAyKfOuC1Jf5fuf2ID3FOaFQZuzkK/hinGVcshX/IMsG6Y03ITu8CKRp
 tLJv9jBxZg9m/AMaSr9x1W1DFD3qMA1U+SUcDCepP90EDHA7/670RNlWEjyMxhvaXW6J
 bCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866705; x=1690458705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwRqncGBMw48ZRHZQQygcwpEXInzVqgYCZMTOEm7gro=;
 b=CT1Z6ZdiqxVsY8ax7EfjPMPXKb2lDH31ImAroP7FI2yM6UbBm4gMl8/h3+pHZVXc1Y
 hnv+SPhdFXY3N2CqsTmuddBhdsYYFoeBu+thBkFePcOGagUEWVGUj6N51hCHfoEiZUAx
 9uu9DMtdYKUGUInsG4HEknHD6OM/kaZpkcfJeBuW6C0N8qTFGNQv2FnFOdKwcDdYvpgQ
 8iJ4pMzokj7gHgxyg/52dDtTnHPrSgpVmr5fYuqF/sLj6r4jGzJ3AkkwZTUzhjn1Ko2a
 sA/aSXUQvvUKL1VG5GcWDbFgZNQL79x9+/OQ5jLh/aN9+d5goWUrezPjFynoXfjFY5ov
 Kucg==
X-Gm-Message-State: AC+VfDyMgv7hGZbZdhAHhiXTvhVB67lP06i5OEgLy8Uf4o/dn1KVj5d0
 xtMN1MYFMslkDYPgJVZACpY5UFYxfZQtILkhVL4=
X-Google-Smtp-Source: ACHHUZ6xLnSQ/b3U5NJqWbrTuz86G0gbNTSsjgso5M/VhbPKvGVEY9yrkxTf9DH2qSNmGFKSSTxcGw==
X-Received: by 2002:a17:906:6a04:b0:988:a837:327a with SMTP id
 qw4-20020a1709066a0400b00988a837327amr22018537ejc.44.1687866705562; 
 Tue, 27 Jun 2023 04:51:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a17090634ce00b0098238141deasm4478624ejb.90.2023.06.27.04.51.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 04:51:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/6] target/ppc: Move CPU QOM definitions to cpu-qom.h
Date: Tue, 27 Jun 2023 13:51:21 +0200
Message-Id: <20230627115124.19632-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230627115124.19632-1-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-qom.h | 5 +++++
 target/ppc/cpu.h     | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 9666f54f65..c2bff349cc 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -31,6 +31,11 @@
 
 OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
+#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
+#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
+#define cpu_list ppc_cpu_list
+
 ObjectClass *ppc_cpu_class_by_name(const char *name);
 
 typedef struct CPUArchState CPUPPCState;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index af12c93ebc..e91e1774e5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1468,12 +1468,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
 int ppc_dcr_read(ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
 int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
-#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
-#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
-#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
-
-#define cpu_list ppc_cpu_list
-
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
 static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
-- 
2.38.1


