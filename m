Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AC712A92
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:25:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2aE3-0000it-B8; Fri, 26 May 2023 12:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1q2aE1-0000ik-2J
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:23:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1q2aDk-0005Lq-Qt
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:23:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6a6b9c079so7090845e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685118195; x=1687710195; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PfD6CiCzOb2myd3zu5oxlakXRkLwHYULmFDVbdeGFA=;
 b=tU1765oZBRHioqfg8eYP1BLDKiXsg9rA6FS+BgAh5LvDO6vfp2K+mpGMzJMZX+BrVz
 9+RgkOy5MQzdEMhcnINFciiNEYY8Ut0s9uSo+nkQZN7OA3gxMcIWMqR7NtmshrvsImx4
 hvNJOAzx0mZ7Jtm6CAWBAKjeKeCCUEYnfcjfH/SaW9pY8xPnTr6yw1I1tDilTG4lg0iw
 trxQB8R3wk2wAkSuNCqVPuMA1ASY+B6JrRspzztvKpK+pxSohPBDp22phiW1TsXBVXig
 3atC3+qY06jPXGLKE/S1cywMujC2mder590Y3eYjK+N2zJbY+9nv96KQK0yGnnQzL7nX
 w+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685118195; x=1687710195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PfD6CiCzOb2myd3zu5oxlakXRkLwHYULmFDVbdeGFA=;
 b=T8Kn9d4jn1EK3hrsvY88ZrJDIYGeaQureZ3YQWBwu/hO9nPjJjtdJQM8rm2ErMDgZJ
 /VLW+D74QqksZKpEdZLs/4qG/drfPQ9gbvetPEA0gs0lr/Ug1X3FL5onjx97BAUZ7W9n
 GM94I5x+Oyi0ZijqPzfbvfRQni77iIBBTCs+DdfJXpW2BTLFwWgJWSCw9nnygShRsfg3
 BNNFVrracoQrrFoCs2qXcE6YgUUPfiAhG49kPQGk6lQn5SivbYd07S1HznAymPrCKARC
 /InM7LvO4HiDjkFpxIJfDpHKNo92VdXJe0c4D5tjKvzky/PZcRs5J2efLT/6B2WQsDXl
 AYkQ==
X-Gm-Message-State: AC+VfDwH4KrjgqiKKsJ0RTEUYAX5BKNtzUzbvdNB8Ye9zUQ/uMRPQWoD
 R9Pzkatp/SrmFzf8xCqtm2G1GQ==
X-Google-Smtp-Source: ACHHUZ6cm9asLTwyQ5xQrzZPWRrRcRpfYF4pUMZQXrBPnvnnHu33sKKrbABiUG4mg5sDo2H+LjXkJA==
X-Received: by 2002:a05:600c:d5:b0:3f4:2973:b8c8 with SMTP id
 u21-20020a05600c00d500b003f42973b8c8mr2077213wmm.26.1685118195479; 
 Fri, 26 May 2023 09:23:15 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f6129d2e30sm9312090wmd.1.2023.05.26.09.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:23:15 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 rkanwal@rivosinc.com
Subject: [PATCH v2 3/6] target/riscv: Set VS* bits to one in mideleg when
 H-Ext is enabled
Date: Fri, 26 May 2023 17:23:05 +0100
Message-Id: <20230526162308.22892-4-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526162308.22892-1-rkanwal@rivosinc.com>
References: <20230526162308.22892-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

With H-Ext supported, VS bits are all hardwired to one in MIDELEG
denoting always delegated interrupts. This is being done in rmw_mideleg
but given mideleg is used in other places when routing interrupts
this change initializes it in riscv_cpu_realize to be on the safe side.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db0875fb43..269a094f42 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1280,6 +1280,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
                                           riscv_pmu_timer_cb, cpu);
         }
      }
+
+    /* With H-Ext, VSSIP, VSTIP, VSEIP and SGEIP are hardwired to one. */
+    if (riscv_has_ext(env, RVH)) {
+        env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;
+    }
 #endif
 
     riscv_cpu_finalize_features(cpu, &local_err);
-- 
2.25.1


