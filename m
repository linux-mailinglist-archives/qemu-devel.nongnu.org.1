Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F7C7081CB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6e-0004PP-8y; Thu, 18 May 2023 08:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6Q-0004Bn-4M
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6K-00082G-RI
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f42c865534so19289425e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414281; x=1687006281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DfLkJ/KKotr8qkh9BlAVe/zewDqYjcmGwxDXPduCDv0=;
 b=Jtwul7lNYZy+w/SdrVmtkS6d6o4TkzMxiMOu83VckjPo/s80Mv6tRxCJw0vRZPew/h
 1+a4CJ2RnMwJYozxmu52V4VcYEEAxTD+xbbfnhyFEIhLoDy9qlQNDehSRbgkkUVjrZ9+
 kxUU8MAPzKcWTbhs0MCjsXDojUMOMFAYTfTMgRfF9Ds0D6vSwsd4xPFl9+H2FspSodkl
 8mE0IhqphfNu21d9nCzPTuR6M6ok7q+1jZZNDmw6CFJ431VUV8zvceiWddF0VOpcTQj3
 82PWktqbG2CMnq6YTTqUxrhozKXvm8ibd7UCtYobbMi+kp57u8KUq/Vt0G+m631hlOli
 nzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414281; x=1687006281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfLkJ/KKotr8qkh9BlAVe/zewDqYjcmGwxDXPduCDv0=;
 b=AUnNTTTzW+LqjfpBei4oZmqHoLqXeThoODKEmuaITisVm5aVtX0ERYJNv+Ud/+OGF/
 m7znugUZwA65Cavjb62jmd8e1P0x9xWzi5QqKqprnDhXD9j30wjrrokCYU1TxSfe2+iO
 skxF33tN0sCRg78aJhuseWltTDtUkepq/Ldarst2sCdmuCUWp+5gFpdfK/H3ZjGNRFi0
 Y2GuVbMZAFMtK09TTSdUopsVvx0UJts/zXEqo095Xo8sK2wrQiWHsPEB7FlLRvFQwPda
 r3hw70pH7npLHjIp9YTtB2d24LNjDT3l4we9BBzYGFh3Eq7ZISoNU59plDsixO7UFTYX
 /qLw==
X-Gm-Message-State: AC+VfDz8D2HMsU8+FYj1Zs5r5FoGtlPqzeb8lsVkZMIiAa7KUtliRJAP
 CwQUmlWA4N+zeBTDmMH6pa/5p1a5Qj4UFGGUSd4=
X-Google-Smtp-Source: ACHHUZ6gZCcGXx3d7NG0xuOh+t62ZmlrRXXdv6Zqstf93x6EUcuz/GR/T45W5CvumR1JcojXeaCqCQ==
X-Received: by 2002:a05:600c:215:b0:3f4:27db:d with SMTP id
 21-20020a05600c021500b003f427db000dmr1313529wmi.17.1684414281149; 
 Thu, 18 May 2023 05:51:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/29] target/arm: Saturate L2CTLR_EL1 core count field rather
 than overflowing
Date: Thu, 18 May 2023 13:51:05 +0100
Message-Id: <20230518125107.146421-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The IMPDEF sysreg L2CTLR_EL1 found on the Cortex-A35, A53, A57, A72
and which we (arguably dubiously) also provide in '-cpu max' has a
2 bit field for the number of processors in the cluster. On real
hardware this must be sufficient because it can only be configured
with up to 4 CPUs in the cluster. However on QEMU if the board code
does not explicitly configure the code into clusters with the right
CPU count we default to "give the value assuming that all CPUs in
the system are in a single cluster", which might be too big to fit
in the field.

Instead of just overflowing this 2-bit field, saturate to 3 (meaning
"4 CPUs", so at least we don't overwrite other fields in the register.
It's unlikely that any guest code really cares about the value in
this field; at least, if it does it probably also wants the system
to be more closely matching real hardware, i.e. not to have more
than 4 CPUs.

This issue has been present since the L2CTLR was first added in
commit 377a44ec8f2fac5b back in 2014. It was only noticed because
Coverity complains (CID 1509227) that the shift might overflow 32 bits
and inadvertently sign extend into the top half of the 64 bit value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512170223.3801643-2-peter.maydell@linaro.org
---
 target/arm/cortex-regs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/cortex-regs.c b/target/arm/cortex-regs.c
index 17708480e75..ae817b08ddf 100644
--- a/target/arm/cortex-regs.c
+++ b/target/arm/cortex-regs.c
@@ -15,8 +15,15 @@ static uint64_t l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
 
-    /* Number of cores is in [25:24]; otherwise we RAZ */
-    return (cpu->core_count - 1) << 24;
+    /*
+     * Number of cores is in [25:24]; otherwise we RAZ.
+     * If the board didn't configure the CPUs into clusters,
+     * we default to "all CPUs in one cluster", which might be
+     * more than the 4 that the hardware permits and which is
+     * all you can report in this two-bit field. Saturate to
+     * 0b11 (== 4 CPUs) rather than overflowing the field.
+     */
+    return MIN(cpu->core_count - 1, 3) << 24;
 }
 
 static const ARMCPRegInfo cortex_a72_a57_a53_cp_reginfo[] = {
-- 
2.34.1


