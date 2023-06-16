Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F33733766
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 19:23:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAD97-0000iX-RU; Fri, 16 Jun 2023 13:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qAD8z-0000hx-Ti
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 13:21:55 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qAD8x-0001pF-59
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 13:21:52 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1a9b0ec6f4cso1030899fac.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686936109; x=1689528109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qY1waEWBuc6KJfgZJsQyHUvmvZuv7F98uQqKiiM+5Q=;
 b=QNGxwGMhapduYRDgUzp4L+21VWzQB5oYoYnGWkopTeIkKgjuEVqqINKRtQSdgP+Gzn
 xbqTEYVwhqFrQPTqnLAOUyB/EtDtRZinJ4ZsgRNAWuJkZMJUwOwFLWMwr1wC1OKRI/BN
 63VvwOZ8+/D0vX6NDs+K9s0uXNFr77549ESmc4svKT8ivbl6+ebRRsCiQ+Yy4UXgjanp
 yv/Dx09sD2Y2T2c02IyoJH9CcNcw4RU+9F/c4TtsuL1jHWqN32slJNOP5qlvlSugW3no
 tlxaRcxhSnNNEe6O9NoKJKv5WjenUCGaRpTjhe/4zYjlT/cwbwLmBPKgWP4wiiyx8YyA
 fcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686936109; x=1689528109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qY1waEWBuc6KJfgZJsQyHUvmvZuv7F98uQqKiiM+5Q=;
 b=MUmH4nJOeke/sm3wcipwLFOkZOQYOPtBRH/NnZsnts9Ti7fE88Slev/MDg+ZSK6UKc
 2apm7LjxvEqMmXaRMBW99ETVjqA8e57ayyy29+i2YUQQtzFkYsPDzUOoc7OslW/0dlMH
 tesHHibK/DHbLWhk0XEnU+rAkgHKv1otsmjDStJQKiCnbnDo2YegN0YGNjmPI4Kjt27r
 yQXGXsqCFK+1hesY97KcDuLavMlz9ZxFpNYerdNiljn3UmOljOcoxxMgs3PB6mbiNjlt
 jqyvRBE7gJRlO/ibV4spoSe1AeUJNXVehXV3Yxlm7Ue0/d2Bep+/BZA089rt0b+ibbpQ
 Zscg==
X-Gm-Message-State: AC+VfDw282ZCYy8QTCgqnz/7YPc2PnhZuxggneAVaksloe2Kkuow7My/
 qOWlXLzceImCHekZJq/6Agg3Yq5lKWeH/m5oXAc=
X-Google-Smtp-Source: ACHHUZ4jt/vtIZssBTFiIHJeD9Dt2aJsj90A+ysFm78+2XNR3yqmWGCZmEqkFsYFY3cPTUVtPn9BVg==
X-Received: by 2002:a05:6870:ea04:b0:177:ad57:cb36 with SMTP id
 g4-20020a056870ea0400b00177ad57cb36mr3585882oap.27.1686936109592; 
 Fri, 16 Jun 2023 10:21:49 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 w24-20020a4ae4d8000000b005584e0c8f9csm7095732oov.3.2023.06.16.10.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jun 2023 10:21:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/1] hw/riscv/virt.c: check for 'ssaia' with KVM AIA
Date: Fri, 16 Jun 2023 14:21:41 -0300
Message-Id: <20230616172141.756386-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616172141.756386-1-dbarboza@ventanamicro.com>
References: <20230616172141.756386-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2b.google.com
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

KVM AIA relies on ext_ssaia support present in the host. At this moment
we're not checking. A KVM guest is doomed to hung if we use any 'aia'
option, aside from 'aia=none', and KVM does not support 'ssaia'.

Add a check for it. The placement is intentional: we need to check
before riscv_imsic_realize(), where the TCG logic can force
cpu->cfg.ext_ssaia to be 'true' and overwrite what KVM set before.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f025a0fcaf..c192059186 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1409,6 +1409,18 @@ static void virt_machine_init(MachineState *machine)
                     RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
                     RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
             }
+        } else {
+            /*
+             * With KVM enabled, check if the user wants to use AIA
+             * and we have the proper support for it.
+             */
+            RISCVCPU *cpu = &s->soc[i].harts[0];
+
+            if (s->aia_type != VIRT_AIA_TYPE_NONE && !cpu->cfg.ext_ssaia) {
+                error_report("Unable to set AIA: host does not "
+                             "have extension 'ssaia' enabled");
+                exit(1);
+            }
         }
 
         /* Per-socket interrupt controller */
-- 
2.40.1


