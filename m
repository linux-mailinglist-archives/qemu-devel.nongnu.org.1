Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8807A32B9
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3v-0007Wx-E3; Sat, 16 Sep 2023 17:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3E-0005FC-Io
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3C-0000Ww-HQ
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:04 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68fcb4dc8a9so3074941b3a.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900520; x=1695505320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwou9dRiH+VLiT9ntm3uIOKDMNj+TRwXlOoqSwbcsYA=;
 b=ynxZioXjWkj/dPEqLVn1mbxMUDpza9ieT5z64FA0DhpIcpcpJNeRPhFqnAwjAqAqH5
 MbYlEfl/kl7e8T0ioHLOpuDYmNQv/FmMly8Vzg+nFowzru8m4LudVMzL5nKr0P7Y2N+b
 jcK/0qrPPVZmZNPoWy5qY3Zgy0ff/bT7GKUzclvZsziy47UDs4/akz795toR9F0lja91
 N+WvP8+VJ8VzqlIOrA5NiNpnqiPetBg5YmTccZilRRlre6QF/tOER0MOus37hBqpBXl3
 A7PwHOydbfW57v/VSdGm1WOA5Ca37y1py4OegAy15mWD5MKYBD70FFN9PNYR4ibLFO7E
 TK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900520; x=1695505320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lwou9dRiH+VLiT9ntm3uIOKDMNj+TRwXlOoqSwbcsYA=;
 b=Vm3W6Xwx70iPfdB51fOOuxqBEmDJaEyKX/z4nYiQunuhLY6FxTROtSO/3D/Nuds1WR
 C4L4pl68E/EPpcGbXD2Aw2DyZkMPP07ZFIwk9c3+dXHMSPQLWBEsG/YiGqK9GyXSTYuT
 RdTGTVWzL7gZEvgwRtJZxKNwGMDQK8Gi7iTmfGtrZuCzbJQjXQZqcCIFP0PXV0i0Vgjb
 wl8Cl+28m6e5DrLP010vB/OKV56I+e+m3LaZ/kmsL/Lm1Ffoq5Wo93Ff2iuobc2IXRWY
 FXdKHdfllOH8xcUIZiQhTxdlLRH56gVfVIyW/jxBvaqTuY/c/kMIWqmjm4wSSBuezdul
 ozag==
X-Gm-Message-State: AOJu0YzrbMCeMR6SluUFgXXHDL7vD+Ui6Q88tjor4Vy9MedcdAXzChse
 qNDysTbpfXwSvxa5m9idU6nMSufasUysDyuAA+c=
X-Google-Smtp-Source: AGHT+IEGtvoH04fRCAf19BV6YNcrkNM2pxS5/3TtZKMvd2E0HYK/xM9ytzLm7ht5TTE8mTsALRmWrg==
X-Received: by 2002:a05:6a00:b83:b0:68f:ee51:7db1 with SMTP id
 g3-20020a056a000b8300b0068fee517db1mr5624088pfj.11.1694900520667; 
 Sat, 16 Sep 2023 14:42:00 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:42:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 38/39] accel/tcg: Have tcg_exec_realizefn() return a boolean
Date: Sat, 16 Sep 2023 14:41:22 -0700
Message-Id: <20230916214123.525796-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Following the example documented since commit e3fe3988d7 ("error:
Document Error API usage rules"), have tcg_exec_realizefn() return
a boolean indicating whether an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230915190009.68404-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 +-
 accel/tcg/cpu-exec.c   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8d262d141e..6c1db14842 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -410,7 +410,7 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
-void tcg_exec_realizefn(CPUState *cpu, Error **errp);
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
 /* Validate correct placement of CPUArchState. */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 95dd8a30cb..fd0fc08f76 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1089,7 +1089,7 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
-void tcg_exec_realizefn(CPUState *cpu, Error **errp)
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -1105,6 +1105,8 @@ void tcg_exec_realizefn(CPUState *cpu, Error **errp)
     tcg_iommu_init_notifier_list(cpu);
 #endif /* !CONFIG_USER_ONLY */
     /* qemu_plugin_vcpu_init_hook delayed until cpu_index assigned. */
+
+    return true;
 }
 
 /* undo the initializations in reverse order */
-- 
2.34.1


