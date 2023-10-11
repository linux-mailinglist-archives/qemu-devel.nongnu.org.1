Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A77C4B3B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:08:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTG7-0007Ou-QF; Wed, 11 Oct 2023 03:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTG5-0007O7-JH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:03:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTG4-0005iF-43
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:03:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c737d61a00so52063105ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007831; x=1697612631;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsSDkqUKog/zNogREHuw4Zud8CV5FNgLM47aE3A8fwA=;
 b=svgmbmpuaDrLfgHvRrFTu09MmgKoSWlxqi+VHlLwI6dscs/H2Kb/ZOggYL9BjTDBfc
 0AgemTl/sqeOvko0To5NcIebOXrywO5kLu4vibVQYyLjc0y98ylom7Z9SoQGgl9MpThb
 xod0cTdbLDHj95fGllnViOJswQgBtmR5W1XUOfJ0X8gZ/y2gLyu4qvFQWvfVCQ9pbSEX
 fOO9UhPLRUnxdfOQUY8Yr2gsFW/EKk7eL7ePg4Ohohwph1BEBPEUb3xC1uV6O3j/Xuxv
 3th0ndAYmhjy8mMUdBEyLPIq7csC6/VlMJbK0/FVeHO6jkJZBM9x2pnyM1djzMA2RsDd
 IpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007831; x=1697612631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsSDkqUKog/zNogREHuw4Zud8CV5FNgLM47aE3A8fwA=;
 b=KsYJNbIK7pfK/N+vfz++WftCWi3I792g9LFkVIjT2avKtxasfJC7fMIH9DP0gizXOC
 S6jweFoQfS0OLNeKQO6Z2fe/MzGr0ZkgUaHBNGL/DRszZ/kVJLbL7A/54ICsC0UMd9d/
 GYCxHhC8GIp0juCADWf/GVMsxfSkiaZrrBqpACFK7vUn6OiHi8tsV7vWQ4n1JO3dFHg6
 ZI3WHwAKrHl+5zg0gQZ+w8OGhfxJ9WH3XrbCNRitPnErmm0A6Xwo8UvLI4V7V4yITvXn
 JV6grp3gsRwn3WZN4CJTENBSiAzA0OTNpnAfAZkMTR1j1bpkCU/cK6WeZC3SQrTjc018
 GMPg==
X-Gm-Message-State: AOJu0YzQIraOrFQ6LD4jEgCkBdrTiPb7eMOB9j0/rF8KeTrIit51R42p
 WZU6bqkPFMhtsASVqp/8ifiA+g==
X-Google-Smtp-Source: AGHT+IFt6jamerr47QP8Rr/uN5MPPentgkriO7PHO1SGIGqHrA6L+2z0xtEgRg+T+LvpNgERIIgFaQ==
X-Received: by 2002:a17:902:c115:b0:1c5:e1b7:1c13 with SMTP id
 21-20020a170902c11500b001c5e1b71c13mr18748084pli.3.1697007830899; 
 Wed, 11 Oct 2023 00:03:50 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 j5-20020a170902c3c500b001bde6fa0a39sm13133013plj.167.2023.10.11.00.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:03:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v9 02/23] target/riscv: Remove misa_mxl validation
Date: Wed, 11 Oct 2023 16:02:48 +0900
Message-ID: <20231011070335.14398-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It is initialized with a simple assignment and there is little room for
error. In fact, the validation is even more complex.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/riscv/cpu.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3bb1ce90f9..1306054d27 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1087,11 +1087,10 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
-static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
+static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPUClass *cc = CPU_CLASS(mcc);
-    CPURISCVState *env = &cpu->env;
 
     /* Validate that MISA_MXL is set properly. */
     switch (mcc->misa_mxl_max) {
@@ -1107,11 +1106,6 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
     default:
         g_assert_not_reached();
     }
-
-    if (mcc->misa_mxl_max != env->misa_mxl) {
-        error_setg(errp, "misa_mxl_max must be equal to misa_mxl");
-        return;
-    }
 }
 
 /*
@@ -1493,11 +1487,7 @@ static void riscv_cpu_realize_tcg(DeviceState *dev, Error **errp)
         return;
     }
 
-    riscv_cpu_validate_misa_mxl(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    riscv_cpu_validate_misa_mxl(cpu);
 
     riscv_cpu_validate_priv_spec(cpu, &local_err);
     if (local_err != NULL) {
-- 
2.42.0


