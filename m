Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91EBD8295
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 10:25:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aKI-0003JD-Gh; Tue, 14 Oct 2025 04:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v8aKF-0003HC-S1
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:24:07 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1v8aKB-0003uI-BA
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:24:07 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-269639879c3so49044545ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 01:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1760430241; x=1761035041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=026+MkGDqz12mXQJte4DznqG5pLwCGi6DGsBZLqInuM=;
 b=DQGo3DIIyUNgx41g6jkuD9IZDOtCS1DSgzhY8lbQ0xbUqSCWAzUCO32glhXBtnzGyZ
 8ab9AxXguMqiImgGNQ0sLSLpReRdrV9/i+YUTGEn07X1RkAvXRKiKxlxsZHQZcroMISW
 gIDnJfHGLEz8DLryzlCiJb29aE+J0McpEtumvHc38acZqYgqdms8scsEa01k7IOQPhCi
 7ezbon1D+ufAc5WPA6GNA5OIbS3oNvZGDlGwBvEol5KZaxADvHpFMmPoPpQBluZjB+9v
 Lyt0yRLbmMLsw6+opw6BJ2TJ6/OuBi1IgMs74DlenFLyNtz+hXEHiO3hgIiXyibkxO8L
 GShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760430241; x=1761035041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=026+MkGDqz12mXQJte4DznqG5pLwCGi6DGsBZLqInuM=;
 b=QhbXplVL7P6FL/1hrufAYPAU1rKhKD4gbVilqNjO+TpSx9Vt+3E2aF5Qx/Ku+jqM3S
 gTjIfe0nUn9pFwg982gJ0dx8vVKmmAiTZ46DJo7zCgjsa4scAFN0zIs8ekhvhrg5JTd9
 24MJpEgHAiE0o2Om1xUj2VUtLnrW9NL3H4o3Rq9F8DHiob0Nr7+nLOgSjqf5DRUicDrR
 C3yDtDoz6NdNc6t+klsReKi0XRWzQO0NkdraWnWr3TqQIetP0Q3lfDCmY24qwULSk8zl
 p8T1EB02mLiIcZYQD0oOn+4u3dd8fHlgzrr3mn5f1Ww9YMOpmZt72oiHTdcTsUV7r3tc
 3UIw==
X-Gm-Message-State: AOJu0Yyc7NijqalSWAyc3NFcJwbjfNrku8UaHgFIg4ZW2/HhssziXmGW
 o6Hy+pvuw9f6raLuO72P0KY3/R7h5J2kuZX2qedwPweoFLHU8Lev5vZsD3SEKbr2h2/6v/gwrOO
 KFlCPJrx035FFPNPvi+30QeZBZiYr4i7xHryKrONtp8ybeOC60BFgxWfcEAqHQgHlQqOSxc483A
 TsJK0MHI2LmBsCUaN8GUWd02QmFivJtGxu6deJNdqZ
X-Gm-Gg: ASbGncso7MBzlwJJ1j1JH4KcMXHIYpahXGTGjiV8W2NKC2WdLtkEBfkfO5n0wWD3mMR
 4KPv/PHIV1Dl5rjIw7Gui5yi9TfWc4v822X9EIXFcOQ7HI88nYdDvOE0QDvT4QjYQ03Qp/gbsi+
 UWDihWEltBbIuEVC11d1TfVACT6FUspoHPGQw8qX58aks4QKOs9MyuOt1BasFN02wQ5jzxe4b+W
 FlqE6KMN3LQz03g5DTwJV/TKL8FQmMA+SAZ/3tp14DTv85buAGcef6B5Dos6ICi1Vrk7vwo7rEx
 84S+QGcfzoWT1FyYTklN92BSIdX5irXdc4UBhPPDifuvawI/YE924xSqzbDGjShaxeJD0vFVq9L
 ds4GQUV6LQPP6MBPjDIOFb/nNyNgzGAwugJVn0kxFp1u/TrWkPRH5qw6LfMBrbLwEQF2GYKIp78
 EJIysrS+aOoIvcP/Y=
X-Google-Smtp-Source: AGHT+IETd5g8Um1+ut15Nb6iztyzEnFiDFYPiBvqdA5TJK1PhnktkYoSA1KGNewUw7rPPmq56H32Aw==
X-Received: by 2002:a17:902:f64d:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-2902741f7admr293189115ad.61.1760430241375; 
 Tue, 14 Oct 2025 01:24:01 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93e06sm157162815ad.115.2025.10.14.01.23.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Oct 2025 01:24:00 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v1 2/2] target/riscv: Make PMP CSRs conform to WARL constraints
Date: Tue, 14 Oct 2025 16:23:38 +0800
Message-ID: <20251014082338.87618-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251014082338.87618-1-jay.chang@sifive.com>
References: <20251014082338.87618-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62c.google.com
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

This patch ensure pmpcfg and pmpaddr comply with WARL constraints.

When the PMP granularity is greater than 4 bytes, NA4 mode is not valid
per the spec and will be silently ignored.

According to the spec, changing pmpcfg.A only affects the "read" value
of pmpaddr. When G > 2 and pmpcfg.A is NAPOT, bits pmpaddr[G-2:0] read
as all ones. When G > 1 and pmpcfg.A is OFF or TOR, bits pmpaddr[G-1:0]
read as all zeros. This allows software to read back the correct
granularity value.

In addition, when updating the PMP address rule in TOR mode,
the start and end addresses of the PMP region should be aligned
to the PMP granularity. (The current SPEC only state in TOR mode
that bits pmpaddr[G-1:0] do not affect the TOR address-matching logic.)

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/pmp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 72f1372a49..a15265c8d2 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -108,6 +108,17 @@ static int pmp_is_invalid_smepmp_cfg(CPURISCVState *env, uint8_t val)
         g_assert_not_reached();
     }
 }
+/*
+ * Calculate PMP granularity value 'g'
+ *
+ * The granularity value 'g' is defined as log2(granularity) - 2, where
+ * granularity is the minimum alignment requirement for PMP regions in bytes.
+ */
+static inline int pmp_get_granularity_g(CPURISCVState *env)
+{
+    return __builtin_ctz(riscv_cpu_cfg(env)->pmp_granularity >> 2);
+}
+
 
 /*
  * Count the number of active rules.
@@ -153,6 +164,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpcfg write - invalid\n");
         } else {
+            uint8_t a_field = pmp_get_a_field(val);
+            /*
+             * When granularity g >= 1 (i.e., granularity > 4 bytes),
+             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
+             */
+            if ((riscv_cpu_cfg(env)->pmp_granularity >
+                MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
+                    return false;
+            }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
             return true;
@@ -199,6 +219,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     target_ulong prev_addr = 0u;
     hwaddr sa = 0u;
     hwaddr ea = 0u;
+    int g = pmp_get_granularity_g(env);
 
     if (pmp_index >= 1u) {
         prev_addr = env->pmp_state.pmp[pmp_index - 1].addr_reg;
@@ -211,6 +232,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_TOR:
+        /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
+        if (g >= 1) {
+            prev_addr &= ~((1UL << g) - 1UL);
+            this_addr &= ~((1UL << g) - 1UL);
+        }
         if (prev_addr >= this_addr) {
             sa = ea = 0u;
             break;
@@ -577,6 +603,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
 
 /*
  * Handle a read from a pmpaddr CSR
+ * Change A field of pmpcfg affects the read value of pmpaddr
  */
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 {
@@ -585,6 +612,25 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 
     if (addr_index < pmp_regions) {
         val = env->pmp_state.pmp[addr_index].addr_reg;
+        int g = pmp_get_granularity_g(env);
+        switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg)) {
+        case PMP_AMATCH_OFF:
+            /* fallthrough */
+        case PMP_AMATCH_TOR:
+            /* Bit [g-1:0] read all zero */
+            if (g >= 1 && g < TARGET_LONG_BITS) {
+                val &= ~((1UL << g) - 1UL);
+            }
+            break;
+        case PMP_AMATCH_NAPOT:
+            /* Bit [g-2:0] read all one */
+            if (g >= 2 && g < TARGET_LONG_BITS) {
+                val |= ((1UL << (g - 1)) - 1UL);
+            }
+            break;
+        default:
+            break;
+        }
         trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
     } else {
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.48.1


