Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4D7DE6CD
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:45:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI2i-0002WZ-Td; Wed, 01 Nov 2023 16:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2g-0002W0-OX
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:22 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qyI2f-0000e7-8q
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:42:22 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d9ca471cf3aso190269276.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698871339; x=1699476139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QqMbaZ9ZTHkQg0Yfq1IBFSzq4QoXF5VtwzSAbraCcY=;
 b=TBKZWpSKZ/2tRV56wnsiIpk3O8WrrGZEG/psruqKUoIuQlIvtPF4UoKZ1LeMLZeu9t
 t5e5eneq790lIJ1Xp/tTFOMSr/BcTU6KOeBNFAJp22hBidkawnNzqoc3IAjam9d+yGY3
 RMctnYyN+Cl+q+iFlP/V4AIfENXV6IAppeNbdoPPPkF/+XdS/lFpk23ryDaFXHaLfvgz
 SA+FvaneScnDVKYBgivnwJtb7P3JIQf3EBfgFLtKdLxQnV796GprkBwPNArBJp8VxYzR
 8dskGPRS6At1P2L2TgCPdfoeC1sZdYJy8WaOdcdJP19NT9xIYZQuo4rhwD0hJ63N7+cn
 fmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871339; x=1699476139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QqMbaZ9ZTHkQg0Yfq1IBFSzq4QoXF5VtwzSAbraCcY=;
 b=VJIZMaVOmKGO0hSRMAyqzbF8fUwApAayjOsZRcNudBHQRxxrktiHODCNNSQHbgUXYG
 S3uBenZcSdjSo1FkFAudzIrw0499TnZkQPdgXpO41vmvo/ipS2FlZ43RFRsS9A3xdn5M
 wYBOQz1pEE9CvhhoZlVWxUduP1XVVf0VMyMJM3Hbpti25kaBRNQcKxL2I1VW08ejG1ao
 WkjhEZsAi12ivY/iTUGV/BGxxCNqUg0wyHVVtEDvX+JpGRxYG1zQhTAEZxhkKgAVZ2jX
 HZPMGSIxBynK5vyRl7eNbJTKhi9jlZ3Gh1yURRMsJRG6KJld4CUtUInYjORNTlvAqaS1
 5SDw==
X-Gm-Message-State: AOJu0YxPNLufMCxD4RsiIWEkJOR2Hm35A5fCu8hKBw6JjDFdRoTpjuvr
 4q4FMTzWcmGtcUWeC9rRa+ACTfPEG7tHYGvSTH4=
X-Google-Smtp-Source: AGHT+IH9fe2t8SSf/H4HLOw+H0lQ+HMp2715ocMS6i4YTuxuFF71lF6GlcQ4C4G8B+H+4kIcsm74mA==
X-Received: by 2002:a25:ae11:0:b0:da3:9565:635a with SMTP id
 a17-20020a25ae11000000b00da39565635amr5611851ybj.56.1698871339374; 
 Wed, 01 Nov 2023 13:42:19 -0700 (PDT)
Received: from grind.. ([179.193.10.161]) by smtp.gmail.com with ESMTPSA id
 z187-20020a2533c4000000b00d9cc49edae9sm329724ybz.63.2023.11.01.13.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:42:19 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 03/19] target/riscv/cpu.c: set satp_max_supported in
 cpu_riscv_set_satp()
Date: Wed,  1 Nov 2023 17:41:48 -0300
Message-ID: <20231101204204.345470-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101204204.345470-1-dbarboza@ventanamicro.com>
References: <20231101204204.345470-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb33.google.com
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

The setter() for the boolean attributes that set satp_mode (sv32, sv39,
sv48, sv57, sv64) considers that the CPU will always do a
set_satp_mode_max_supported() during cpu_init().

This is not the case for the KVM 'host' CPU, and we'll add another CPU
that won't set satp_mode_max() during cpu_init(). Users should be able
to set a max_support in these circunstances.

Allow cpu_riscv_set_satp() to set satp_mode_max_supported if the CPU
didn't set one prior.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 822970345c..9f6837ecb7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1100,6 +1100,7 @@ static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name,
 static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
+    RISCVCPU *cpu = RISCV_CPU(obj);
     RISCVSATPMap *satp_map = opaque;
     uint8_t satp = satp_mode_from_str(name);
     bool value;
@@ -1108,6 +1109,16 @@ static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    /*
+     * Allow users to set satp max supported if the CPU didn't
+     * set any during cpu_init(). First value set to 'true'
+     * in this case is assumed to be the max supported for
+     * the CPU.
+     */
+    if (value && cpu->cfg.satp_mode.supported == 0) {
+        set_satp_mode_max_supported(cpu, satp);
+    }
+
     satp_map->map = deposit32(satp_map->map, satp, 1, value);
     satp_map->init |= 1 << satp;
 }
-- 
2.41.0


