Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 712CB7C6A4E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsVO-00079v-Nn; Thu, 12 Oct 2023 06:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqsVK-000789-Tr
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:01:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1qqsVI-0006z1-Pl
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:01:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3296b49c546so636702f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697104875; x=1697709675;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCYl2ITD4wBOSdR+ouSLn64FfrgWlxT7ZNZhf+YF/cY=;
 b=woNO6CBhHoLe0p/NTlTHcO16ZDJBrpM9MScLOjzmOhBljQXeHEzEqijeDVbT8OazSF
 4PS+9RVVSWUWVAZ6Mp5vUtsfS68LykNmG49MznLt4KVBiVSocqUHzvqb4H4Jx/ZMRdx9
 RMM42xD2u0xQ1rqVRj8mQ6xs/GcDxpyMgqipyBN58Pu5MpwYcYAW8hr7yNoZWm89LJcF
 CtZY+fI3a/rk2YKcE+xr1unhyLhLYEqm0EvHRv9u5Hpuq8KbR6PILmwHneY0c9UzJd0T
 b8bbmmecSIrX8K+GO7N4zeATkXNlaTLfKISegSxOxxS02CXTKgTNZaW61Sk1Z4XKgwkp
 gm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697104875; x=1697709675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCYl2ITD4wBOSdR+ouSLn64FfrgWlxT7ZNZhf+YF/cY=;
 b=ocLpsmYH+PMwiodcA1UnV64n3DAkaohJAdu0kNVsEWR+ZqpaL7zw2n8QPK+GBnjr4K
 H/KL/4ALg5bwB0ITIuNTg/VG7NuX2gYwOeokmsOee4o/PfX18OB4/5MTn33LYYqCJ+sn
 3jfqvCwrfEttjOEAeUlbXZk4272tZgB7/oKtPgXMzZAfPj1vr2WER7uDjLXAmOctLMiS
 0NslJ0Gf4T+hDPFSYowUg5iA7Xwkg2auDhwrw8a39CELflEjkwPDavNLty+r/hbt/cSU
 pla011dMByJtXZea7fhrRyoNS68M4BNHImjbYbPHRCZDfp7FnS5wI4EKmGKLxauATm4m
 k7Pw==
X-Gm-Message-State: AOJu0YxFUeBR+a8wkg69T/o4jp3hmLE0hk+rc3Z4NaeESzpxr5lNtBlZ
 I5eWqUnNqxfEErZ+WFIlO8tAMA==
X-Google-Smtp-Source: AGHT+IFfI9o1IKSKwDw2npe/u9/rNys0e/h6DSPXioXPAT/NHZDT34YNbrPNHHxIx2KhBPU7BJbj1g==
X-Received: by 2002:a5d:58ca:0:b0:31f:9b4f:1910 with SMTP id
 o10-20020a5d58ca000000b0031f9b4f1910mr20831327wrf.63.1697104874892; 
 Thu, 12 Oct 2023 03:01:14 -0700 (PDT)
Received: from localhost.localdomain
 (cpc91760-watf12-2-0-cust235.15-2.cable.virginm.net. [81.111.69.236])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056000024c00b0032d88e370basm3803122wrz.34.2023.10.12.03.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 03:01:14 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v4 3/6] target/riscv: Set VS* bits to one in mideleg when
 H-Ext is enabled
Date: Thu, 12 Oct 2023 11:01:00 +0100
Message-Id: <20231012100103.28612-4-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012100103.28612-1-rkanwal@rivosinc.com>
References: <20231012100103.28612-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

With H-Ext supported, VS bits are all hardwired to one in MIDELEG
denoting always delegated interrupts. This is being done in rmw_mideleg
but given mideleg is used in other places when routing interrupts
this change initializes it in riscv_cpu_realize to be on the safe side.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a28918ab30..34e034b9f3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -618,7 +618,12 @@ static bool tcg_cpu_realize(CPUState *cs, Error **errp)
             cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                           riscv_pmu_timer_cb, cpu);
         }
-     }
+    }
+
+    /* With H-Ext, VSSIP, VSTIP, VSEIP and SGEIP are hardwired to one. */
+    if (riscv_has_ext(env, RVH)) {
+        env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;
+    }
 #endif
 
     return true;
-- 
2.34.1


