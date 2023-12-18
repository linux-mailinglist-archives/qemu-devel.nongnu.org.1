Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA1816F0E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 13:59:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFD9E-0003fE-UM; Mon, 18 Dec 2023 07:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD9D-0003ev-F1
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:55:03 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFD9B-00052z-IW
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 07:55:03 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d3ac87553bso2961945ad.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 04:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702904099; x=1703508899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8U63IzMzjkWDwurEnFNMBUdg1Ag6di1ouiDAsRlbPvQ=;
 b=KnaXo4tzjsqqLI2JrVA+EIRerrRRoTgcqQLEv+3/N+T8cTWWYVNtH/d3cJ5sy55Wgn
 F9Y7kq7QrROMddFGo8OKXBo06UaIkyDMRPxy7yIPtm2ttjpjiA/eBuuTSbqeyGiQNyPv
 WHy9FJWHWCc6dZC9SyvmjfQftJUEAizj/0ll5hA6arxzMDQ4PbJUgcR6sIr0NecR/fLj
 VgH6b16ho4XBXx7xlxV3eYshTw/AGLVibeOLYJ54jzIjEy6X6djz+N4qzJEiNmDXs0zt
 xUjWRfn4+RUsFSj5IWtvzLwQookbiuk9ElH1tmnwtemiI5AseU2mHEWjPwJ2Jn+AlLMp
 Z71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702904099; x=1703508899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8U63IzMzjkWDwurEnFNMBUdg1Ag6di1ouiDAsRlbPvQ=;
 b=uUZ0BV1puZulJrINrNuVYDezplbP2EFgIh+y18kKwuwhlUMAe4W9SNco4j2WquuKP8
 lGbOpUWdA+HA/d6WUDq9B1OQtBO8LBOO9w397cyTqmlayTxB2DtlZobsjPT9Rp0mlZye
 xUTMqRechew1kQjSVFTNDp2vyK+vZFAGYGmz7ir0DeU37aLtoNuGveBzOLOfbTyFi9TK
 TshToseL2ab8l8VRuSvOglg57OEZIXy0WwbKo5TrvG5Mfv221R6ODSv98DtJBw/NAQkq
 gsruMEaqtNaNSeTHuQkJTUfd5rzhjVBGOi2DL/ktvz03yAr/9L9aQSqPi4w8+SSWlUeD
 662Q==
X-Gm-Message-State: AOJu0YzcG7yV77JGxZLDBI9V54aUoWqUGYVoft050tVteca7n+1MPXuO
 +6QDdYPEESmjKMjnP/h0mo2XYbkfuE8bCCskL0E=
X-Google-Smtp-Source: AGHT+IGTgL2Yc3xKJ6AG2j9tkh7QtC0zGciJnKUvHXY/DvRit2+VqPLm3o5fe37oJmy59WEhv7v5jA==
X-Received: by 2002:a17:903:22d0:b0:1d0:6ffd:6e69 with SMTP id
 y16-20020a17090322d000b001d06ffd6e69mr9570450plg.97.1702904099580; 
 Mon, 18 Dec 2023 04:54:59 -0800 (PST)
Received: from grind.. ([179.93.21.205]) by smtp.gmail.com with ESMTPSA id
 c2-20020a170902848200b001d09c539c96sm7494897plo.229.2023.12.18.04.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 04:54:59 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v13 24/26] target/riscv: add 'parent' in profile description
Date: Mon, 18 Dec 2023 09:53:32 -0300
Message-ID: <20231218125334.37184-25-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218125334.37184-1-dbarboza@ventanamicro.com>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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

Certain S-mode profiles, like RVA22S64 and RVA23S64, mandate all the
mandatory extensions of their respective U-mode profiles. RVA22S64
includes all mandatory extensions of RVA22U64, and the same happens with
RVA23 profiles.

Add a 'parent' field to allow profiles to enable other profiles. This
will allow us to describe S-mode profiles by specifying their parent
U-mode profile, then adding just the S-mode specific extensions.

We're naming the field 'parent' to consider the possibility of other
uses (e.g. a s-mode profile including a previous s-mode profile) in the
future.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c         |  1 +
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6795f5da41..aa33e7a1cf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1540,6 +1540,7 @@ Property riscv_cpu_options[] = {
  * having a cfg offset) at this moment.
  */
 static RISCVCPUProfile RVA22U64 = {
+    .parent = NULL,
     .name = "rva22u64",
     .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
     .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6c5fceb5f5..44fb0a9ca8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -77,6 +77,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit);
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
 
 typedef struct riscv_cpu_profile {
+    struct riscv_cpu_profile *parent;
     const char *name;
     uint32_t misa_ext;
     bool enabled;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 152f95718b..6284d36809 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -797,7 +797,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
     CPURISCVState *env = &cpu->env;
     const char *warn_msg = "Profile %s mandates disabled extension %s";
     bool send_warn = profile->user_set && profile->enabled;
-    bool profile_impl = true;
+    bool parent_enabled, profile_impl = true;
     int i;
 
 #ifndef CONFIG_USER_ONLY
@@ -850,6 +850,13 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
     }
 
     profile->enabled = profile_impl;
+
+    if (profile->parent != NULL) {
+        parent_enabled = object_property_get_bool(OBJECT(cpu),
+                                                  profile->parent->name,
+                                                  NULL);
+        profile->enabled = profile->enabled && parent_enabled;
+    }
 }
 
 static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
@@ -1107,6 +1114,11 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     profile->user_set = true;
     profile->enabled = value;
 
+    if (profile->parent != NULL) {
+        object_property_set_bool(obj, profile->parent->name,
+                                 profile->enabled, NULL);
+    }
+
     if (profile->enabled) {
         cpu->env.priv_ver = profile->priv_spec;
     }
-- 
2.43.0


