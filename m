Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5E7DE6E0
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:45:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI31-0002jg-0A; Wed, 01 Nov 2023 16:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2z-0002jW-IY
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:41 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2w-0000k3-TL
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:41 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-da0359751dbso244804276.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871358; x=1699476158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9raNQUR8M8FL8GUSRMtUjkusVa+uIoPzSHAduhHO24=;
 b=QRRMGIhCqo2Gj2SXc4IVK1/fCiwXg4/jnrO7VxMW4/7rGaY/EbO9BEqgipmxet84Oa
 sSEgHT4PVdp9/ea99J4hLE67TDs1k9rBjYVPRJYg/5oinDhdWehyvWwXT6G9Mw1n2nf5
 7pRn+EKGCkH/ktPw693SwOxkYWLwCZALzuItMZFNMZacuA/jtAQbkhbHD8qhOqOoD2v4
 /kS9JQCRi4ATniOvJ3t1lOlQvrAq7O8u3s/8voNnKhQNjgWdzTfNoTQnvHqEPM8bBh52
 JHbYPNNsSy6NsSlobg5rC6+lokm+eA6k75g9hLXYA8X9yUiVV+6uh5MOfhoGFH3S9Oid
 ATTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871358; x=1699476158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9raNQUR8M8FL8GUSRMtUjkusVa+uIoPzSHAduhHO24=;
 b=D3ksBtps4e9SJC2egrN48U7mhrROnfXp/fchk2KDJjeeRHE0rpJytk5ovPFV+EK5GE
 xnR8cAqsQqzuYJnycwSYsn1UMizCp++Hk0NghIQSVfYTZRgjFLGxnghr7wRjl0OetX1O
 bxX+rtp6y6sPY5Bf7PHCvhiktH1PEBhcC1/rVXT9nXMuMEkQjRiLwUalBS7rKBRLWppS
 x0s2b+36aRuMEFzk51KVMUIae8LfAvOUU5mWs31rhRrRhPfZ8UZqMxYtX7BRJkPiLD5u
 D/lHEe23H+jY0KcMSjwQXqZI0uvPliB4IIGr6jn3cwqk+7COaTkJqXlmjL9a9Gj/OUol
 ZxAA==
X-Gm-Message-State: AOJu0YxdQyZ3Ap83a3NedKHPC536Xl9AVpLdUYc6B1u+pNhr3yVt6Qrg
 XBeiiekMHq43G8K7Fa6B+7m5CINBbGZBDqs6g1Q=
X-Google-Smtp-Source: AGHT+IFXy9AJ2qOm/MUgR2jawAum6X+hOET4orfWEX9Su3RvLGNun0axeHOgE3FMJdjwfyy/pWDXEA==
X-Received: by 2002:a25:738c:0:b0:da3:aef8:efc7 with SMTP id
 o134-20020a25738c000000b00da3aef8efc7mr3039806ybc.0.1698871357765; 
 Wed, 01 Nov 2023 13:42:37 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:42:37 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 10/19] target/riscv: add rva22u64 profile definition
Date: Wed,  1 Nov 2023 17:41:55 -0300
Message-ID: <20231101204204.345470-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101204204.345470-1-dbarboza@ventanamicro.com>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb2c.google.com
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

The rva22U64 profile, described in:

https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#rva22-profiles

Contains a set of CPU extensions aimed for 64-bit userspace
applications. Enabling this set to be enabled via a single user flag
makes it convenient to enable a predictable set of features for the CPU,
giving users more predicability when running/testing their workloads.

QEMU implements all possible extensions of this profile. All the so
called 'synthetic extensions' described in the profile that are cache
related are ignored/assumed enabled (Za64rs, Zic64b, Ziccif, Ziccrse,
Ziccamoa, Zicclsm) since we do not implement a cache model.

An abstraction called RISCVCPUProfile is created to store the profile.
'ext_offsets' contains mandatory extensions that QEMU supports. Same
thing with the 'misa_ext' mask. Optional extensions must be enabled
manually in the command line if desired.

The design here is to use the common target/riscv/cpu.c file to store
the profile declaration and export it to the accelerator files. Each
accelerator is then responsible to expose it (or not) to users and how
to enable the extensions.

Next patches will implement the profile for TCG and KVM.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 32 ++++++++++++++++++++++++++++++++
 target/riscv/cpu.h | 12 ++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c7c09c1f7c..c5bb2210ab 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1469,6 +1469,38 @@ Property riscv_cpu_options[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+/*
+ * RVA22U64 defines some 'named features' or 'synthetic extensions'
+ * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
+ * and Zicclsm. We do not implement caching in QEMU so we'll consider
+ * all these named features as always enabled.
+ *
+ * There's no riscv,isa update for them (nor for zic64b, despite it
+ * having a cfg offset) at this moment.
+ */
+static RISCVCPUProfile RVA22U64 = {
+    .name = "rva22u64",
+    .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs), CPU_CFG_OFFSET(ext_zfhmin),
+        CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
+        CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
+        CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+
+        /* mandatory named features for this profile */
+        CPU_CFG_OFFSET(zic64b),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
+RISCVCPUProfile *riscv_profiles[] = {
+    &RVA22U64,
+    NULL,
+};
+
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bf12f34082..e4d5d69207 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -66,6 +66,18 @@ const char *riscv_get_misa_ext_description(uint32_t bit);
 
 #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
 
+typedef struct riscv_cpu_profile {
+    const char *name;
+    uint32_t misa_ext;
+    bool enabled;
+    bool user_set;
+    const int32_t ext_offsets[];
+} RISCVCPUProfile;
+
+#define RISCV_PROFILE_EXT_LIST_END -1
+
+extern RISCVCPUProfile *riscv_profiles[];
+
 /* Privileged specification version */
 enum {
     PRIV_VERSION_1_10_0 = 0,
-- 
2.41.0


