Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD117F66AF
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:53:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EoF-0008Sa-7E; Thu, 23 Nov 2023 13:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6Enu-0007zX-DO
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:51:59 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6Enl-0008I1-KL
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:51:53 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so8748235ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700765504; x=1701370304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDRclKp36HGTBfuGMgAcoAlDAO8icCS2R/NFUb3VCsA=;
 b=iaz7HrtpbC4pSfUKemiLn1r//U/OSWmcHxJylhFKsWy5ZwCZ6P/EiRPM6OhFP6KaCX
 FSYpxXh5Mwv0oqDk/Z7Juskj47sAbTvbw40QiVk9257k/SlLkqyAdArTVwKZOa17lDac
 tkKmw5OyI3GrTPVu2vTjmMjDQi5dfSNIFX10bjFixNhFPWTenrQjr1jjeSfNiu3sSFJ0
 RXTzW4zth5arxVIAVc26W5CzU7LIqBhmwyyz4iVOmxDInNqnwBmEKMEp0uF6jb/pv8UB
 Y3oN9e7tJzJnles0wXejMjR6OBm5g8sL/g0ZCv5jqkn8a1KptXFCKcRufDe4AhQcmj5e
 9kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700765504; x=1701370304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDRclKp36HGTBfuGMgAcoAlDAO8icCS2R/NFUb3VCsA=;
 b=dXc7pl+tGGrRHSpzHbhkro/1mnxu9z6V+r5zpLKLu/2Zfq5O+bZrWILW0zjy641RsO
 tYgc0xF6Zi+DVZPAht5CMV0FJV6wX/4BfQ3KO7k+Bt4z+jvfSlNbrEgU0VlqMMBh2aCH
 rCr9OSGvalL1zAymPsxed9LWOiiHOgkKAL4lZ0R6I2hrmsVF0woLquLfwq0gfiMz99HH
 rYWCskyDB32TmD8ZFJrj09bplVHTUyfnNz9dD7AwKMyOSMQ1ngJZTr/np9NzpP19Di53
 LyGDK896tV8pFFMj/YB9payEB+Vb123LAnHJU/fasir2llcToUqd2L2AgeLfnC6RmUgA
 zsDQ==
X-Gm-Message-State: AOJu0YwM7beDD9Jd3FZ2MFTsKDiJ8MrMqchrG1wIy6zBGI0ky9doTwmw
 ogpDtYabyjH3/Fk4GxEGjUxVDUuSApff2njulis=
X-Google-Smtp-Source: AGHT+IGa4ACqGZVvJX2sCtJKGiiZwChQfFjumyimEIMRtW8QrvPGbXE6uw7Rew+1JKOB03fieHllLw==
X-Received: by 2002:a17:902:c146:b0:1cc:449b:41e3 with SMTP id
 6-20020a170902c14600b001cc449b41e3mr304954plj.59.1700765504060; 
 Thu, 23 Nov 2023 10:51:44 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090282c400b001bb1f0605b2sm1662638plz.214.2023.11.23.10.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 10:51:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v11 05/18] target/riscv: add zicbop extension flag
Date: Thu, 23 Nov 2023 15:51:09 -0300
Message-ID: <20231123185122.1100436-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
References: <20231123185122.1100436-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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

QEMU already implements zicbom (Cache Block Management Operations) and
zicboz (Cache Block Zero Operations). Commit 59cb29d6a5 ("target/riscv:
add Zicbop cbo.prefetch{i, r, m} placeholder") added placeholders for
what would be the instructions for zicbop (Cache Block Prefetch
Operations), which are now no-ops.

The RVA22U64 profile mandates zicbop, which means that applications that
run with this profile might expect zicbop to be present in the riscv,isa
DT and might behave badly if it's absent.

Adding zicbop as an extension will make our future RVA22U64
implementation more in line with what userspace expects and, if/when
cache block prefetch operations became relevant to QEMU, we already have
the extension flag to turn then on/off as needed.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/virt.c        | 5 +++++
 target/riscv/cpu.c     | 3 +++
 target/riscv/cpu_cfg.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d2eac24156..da650865e5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -273,6 +273,11 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
                                   cpu_ptr->cfg.cboz_blocksize);
         }
 
+        if (cpu_ptr->cfg.ext_zicbop) {
+            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-size",
+                                  cpu_ptr->cfg.cbop_blocksize);
+        }
+
         qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv");
         qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
         qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a52bf1e33c..40c64581ec 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -78,6 +78,7 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
  */
 const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
+    ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicntr, PRIV_VERSION_1_12_0, ext_zicntr),
@@ -1376,6 +1377,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zhinxmin", ext_zhinxmin, false),
 
     MULTI_EXT_CFG_BOOL("zicbom", ext_zicbom, true),
+    MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
     MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
 
     MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
@@ -1510,6 +1512,7 @@ Property riscv_cpu_options[] = {
     DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
 
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
+    DEFINE_PROP_UINT16("cbop_blocksize", RISCVCPU, cfg.cbop_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
 
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index f4605fb190..bd2ff87cc8 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -65,6 +65,7 @@ struct RISCVCPUConfig {
     bool ext_zicntr;
     bool ext_zicsr;
     bool ext_zicbom;
+    bool ext_zicbop;
     bool ext_zicboz;
     bool ext_zicond;
     bool ext_zihintntl;
@@ -142,6 +143,7 @@ struct RISCVCPUConfig {
     uint16_t vlen;
     uint16_t elen;
     uint16_t cbom_blocksize;
+    uint16_t cbop_blocksize;
     uint16_t cboz_blocksize;
     bool mmu;
     bool pmp;
-- 
2.41.0


