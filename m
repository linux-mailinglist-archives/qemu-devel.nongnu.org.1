Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66EB7D1947
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 00:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtyAN-00041R-Nc; Fri, 20 Oct 2023 18:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtyAL-00041A-LI
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:40:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtyAH-0007mD-EI
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:40:25 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9bca1d96cso10551675ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697841619; x=1698446419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYiBcU3Fn0p70tChmz3TC4ARZgksdFnrCu6UPFtrSy0=;
 b=LboLpCG5rPLh5LQgzt+I/4WBptT1rqJn9jFvRfzd7AC8S/TCFGHnukexevlVz1i3g0
 qyRqVOk+m4K1J7jv9PtLxj6+IJUbsSE+F720TirPB9xX6k63xipP9Mdjxsde5Hn9cDT8
 ZUuVL8xO9bmnK6z1Oo4zh1dHdH6ThRMGVuJ9Maqa5otPrSaxpoHramYUju3YYx5bL73D
 KhmzCyckRcGSNvMjYZ5srsSJ58VoFR7PqA7ZrOPh4gVxZu0pm7ldBlLbG9hqbT4HYQez
 VD8AfuKeSGXOd8GKAzM5gL40pbbLT0wNp8/2+Dpr1sZkBEwauJnG1+Jmz5Y8yad8sTpY
 KNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697841619; x=1698446419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYiBcU3Fn0p70tChmz3TC4ARZgksdFnrCu6UPFtrSy0=;
 b=tJkAOxwtdrUHym/sDjUfc3SI9+qyPMVxM3731diG2yFf3ZvSkzR3YLEHvxdJIhGAxm
 Had9Xt4S9LNSe9qaD1QJmk1puZYan9YEq6/3w0vTjdbA4M18XK92oejvEEKJ2GxxE6z2
 fxdk2m/5iMSTa6n5+QSbDy+y5F5lS/Zfi09Vk+X5ILrcxMHafAo86fFlROKrPDn7gogM
 Q+363ESO4i5kyWcByNsCrNbIVApqB7Cd3qXdpZhHstZYNK+MGLcZDR0ZfFDIJJ3zUQyf
 DMeP8r3+TUAK1/5GOmk3v1Sg/h+0rofq2QXtFnvOQm/LeavWw74KFYuMvDVBn65CTf3t
 ll4A==
X-Gm-Message-State: AOJu0Yy7G0pRR3cd1lNT5F/2pKuFfIgMdG9iszxHm4ZeN9E20W1r02AU
 bts6EA58MhqbKuBi4nOpFW2dWMmye6oUftM2zNI=
X-Google-Smtp-Source: AGHT+IFXlG+SDx5bKeKJ2fQcl6xOQyxoRNVExJd9pk3L65bw/f0Vxo3TNcrc9SiurTgbjsy95vvKjA==
X-Received: by 2002:a17:902:e5cb:b0:1ca:220:ce42 with SMTP id
 u11-20020a170902e5cb00b001ca0220ce42mr3194478plf.37.1697841618761; 
 Fri, 20 Oct 2023 15:40:18 -0700 (PDT)
Received: from grind.. ([177.45.186.249]) by smtp.gmail.com with ESMTPSA id
 h1-20020a170902704100b001c61921d4d2sm1992373plt.302.2023.10.20.15.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 15:40:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 6/6] target/riscv/tcg: handle profile MISA bits
Date: Fri, 20 Oct 2023 19:39:51 -0300
Message-ID: <20231020223951.357513-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020223951.357513-1-dbarboza@ventanamicro.com>
References: <20231020223951.357513-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

The profile support is handling multi-letter extensions only. Let's add
support for MISA bits as well.

We'll go through every known MISA bit. If the user set the bit, doesn't
matter if to 'true' or 'false', ignore it. If the profile doesn't
declare the bit as mandatory, ignore it. Otherwise, set or clear the bit
in env->misa_ext and env->misa_ext_mask depending on whether the profile
was set to 'true' or 'false'.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ba11d0566d..73c7453af6 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -42,6 +42,12 @@ static bool cpu_cfg_ext_is_user_set(uint32_t ext_offset)
                                  GUINT_TO_POINTER(ext_offset));
 }
 
+static bool cpu_misa_ext_is_user_set(uint32_t misa_bit)
+{
+    return g_hash_table_contains(misa_ext_user_opts,
+                                 GUINT_TO_POINTER(misa_bit));
+}
+
 static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
                                      bool enabled)
 {
@@ -797,6 +803,16 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
     profile->enabled = value;
 
+    for (i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+
+        if (cpu_misa_ext_is_user_set(bit) || !(profile->misa_ext & bit)) {
+            continue;
+        }
+
+        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
+    }
+
     for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
         ext_offset = profile->ext_offsets[i];
 
-- 
2.41.0


