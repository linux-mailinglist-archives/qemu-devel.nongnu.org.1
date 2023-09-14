Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2E47A03F9
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:35:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglYV-0002ts-3V; Thu, 14 Sep 2023 08:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qglXW-0002O3-Ol
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:33:47 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qglXV-0008Eo-45
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:33:46 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-271c700efb2so704165a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694694821; x=1695299621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2i5iORmaPcRV7ieGSCV0tofWjzs027VAkkmm8l6mIu4=;
 b=QZpd9GPNdta0IF3O/YHqqZZzaJJswotyKWJ/FHYQ59tuSc0/TzCk0JH792RybEmP4e
 xy3lJ31M5luDSNtGUZrEr1cSMAjBRehs0b2LI0OC3/ZrlbFFpNt/EBfGBGwcOHieJOw2
 wTG3mW1KXu6qFTWoKGn2lF3+RmbBtAPP56XyMEOkaJ59BqWRxZOsijDnx2Rf19MepiGP
 yzi4H7BHt3vnjtSzMWIKCcUv8yHYz4yQgOlh2G7O+E/frPN456oiOgXRTz931VkW/PJD
 jupyzuWRKhjQXmkWcIxaG9lPm2AZPPVxcRM4AS7dwpNpLGfoHK26dpuU+q8+298efV5P
 i0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694821; x=1695299621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2i5iORmaPcRV7ieGSCV0tofWjzs027VAkkmm8l6mIu4=;
 b=i1V5KZ1OJDLuh8unJ3cDh2rnJjSGton9E2Iu9DdfWahR/LNKN6DhHyeajccGTqpOoe
 iq39IO/mM3B1bxqOWGg90ERw7GyjgNy8V7tFS6RVgeuh5PsKyQBg1I9nMWI2p6cJrMKa
 QamIb6uhb/dl5ZNOQ3Zx/napWvsctu+0oanL+4ldaiwIXvoQvFhIKw6fWAPyMWklNPDa
 Y2BAlpDq4qWCLjfqaMynVhpDllKUQwLz69XED0QRqBsBMnUb2jtPA87IiUtq4hc4tJar
 uhG6jCXDL6NIhEaQ+jNEiuhbQmwekA6g+zN3ORjIm30oDHs+gdSFwxmiEadvWzXO32Ig
 MRBQ==
X-Gm-Message-State: AOJu0YxyfdYo7c7SjRlI5mKiZyTGewRMSkhWVq8It0VyGyxODg6j8nce
 BN6hgUA2gAsyNaLVNRAVrMb9JfadNU1S+ZHe8TwoTg==
X-Google-Smtp-Source: AGHT+IFlDiP+shAuXCGwOWWpk937o0m9ZHYJpzhq6Vi/xBPPCzOGN/ZZpvwt6xOJ9HLD5HUH+BxBjA==
X-Received: by 2002:a17:90a:2ce2:b0:271:9c5f:fc42 with SMTP id
 n89-20020a17090a2ce200b002719c5ffc42mr5028784pjd.31.1694694821567; 
 Thu, 14 Sep 2023 05:33:41 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 19-20020a17090a001300b00263f5ac814esm3311275pja.38.2023.09.14.05.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 05:33:40 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	alistair.francis@wdc.com
Subject: [PATCH] target/riscv: pmp: Ignore writes when RW=01
Date: Thu, 14 Sep 2023 15:47:51 +0530
Message-Id: <20230914101751.772576-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=mchitale@ventanamicro.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As per the Priv spec: "The R, W, and X fields form a collective WARL
field for which the combinations with R=0 and W=1 are reserved."
However currently such writes are not ignored as ought to be. The
combinations with RW=01 are allowed only when the Smepmp extension
is enabled and mseccfg.MML is set.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 target/riscv/pmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index f3eb6e6585..5b430be18c 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -119,6 +119,14 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
         if (locked) {
             qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - locked\n");
         } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
+            /* If !mseccfg.MML then ignore writes with encoding RW=01 */
+            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
+                (!riscv_cpu_cfg(env)->ext_smepmp ||
+                !MSECCFG_MML_ISSET(env))) {
+                val &= ~(PMP_WRITE | PMP_READ);
+                val |= env->pmp_state.pmp[pmp_index].cfg_reg &
+                       (PMP_WRITE | PMP_READ);
+            }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
             return true;
-- 
2.34.1


