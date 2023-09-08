Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2182798B30
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew8-0005Wo-W0; Fri, 08 Sep 2023 13:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeew4-0005VC-Hk
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevq-00019b-Ne
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401d24f1f27so25716505e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192769; x=1694797569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KzUC2YqCJygpvtjpx3lNOslXt8nXeXpZv7XxD1t0Tpg=;
 b=gHtyXIJ2xwuC6Kq0pOcr3lqhE3Ai4LVVEva7FrWGYXQ5CsA/+ca63NG2Ta+W6RA7lB
 ZWOzzT0yoGibP9LZNLiyCMkRa4oOh59Hn3a6T1wXL6CABsVpH4yYV2Bhh5yvimDAnNbv
 JWOj8rMWywIA4FMpYExf/80Bc0cA8fn42/2TbSNgksFUN5AigBZJQIRbbvatwmMJQNek
 mf/jdqs9K0ZKz5k++ZdQJmykYylMYPdFeTrtJhKrEI7wJhSzXtypEoMJHCfltCpFcrON
 rQRWRo/WRsP2UOecuXdgs1YptrA0dNuLbrEh12QdSAJ2d1HQ+C1/lflomn6TJVjqtfma
 IrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192769; x=1694797569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzUC2YqCJygpvtjpx3lNOslXt8nXeXpZv7XxD1t0Tpg=;
 b=qHNozDOXKJ7li+LmgViRmMGSgZlPE+T3lF3njBcLY+t030PsstIfQklfcdAv/crjGs
 EszRkZOZZhfpuNdR3Lbrpx+PNKrtl2u8gorpdB166gPSZFsWlJqcWbwcoX5d2FLTHRCp
 J2LMiU3vSDjZCpXfds33SQUf9rL8FBnoa38OuLPdk3ks4ExXt9i3jtrsUrZHJgGf5ite
 sYdEsABEXda6sUSGBCVx9oTYqXo0V5wBNNnKDEUORuxD/w2geCBqCbBRGQGjttZsmOb1
 kxX3ePF0oS52rO44rOLQzl4WWdv4eQcFgrJqqf49evK5u+zQzK1MQ4lfOrqt0CKmGI3L
 MXKw==
X-Gm-Message-State: AOJu0YyMQJ2qDD2obCnyGX4vdBd6+xlPdh1KTCZXdHp1tgN77xte4dMg
 hXsSfSOS346YqIsEg/3FiRvrFPaNFKGsoihNhfg=
X-Google-Smtp-Source: AGHT+IH4f3K7bLcUmNZ2ncvqayW0lCTl7eXj0LG0RTFHN/I+T87KYWt71lci7N36iV7IztmNGzLe6g==
X-Received: by 2002:a05:600c:218e:b0:3fe:4e4e:bedb with SMTP id
 e14-20020a05600c218e00b003fe4e4ebedbmr2627805wme.4.1694192769444; 
 Fri, 08 Sep 2023 10:06:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/26] arm64: Restore trapless ptimer access
Date: Fri,  8 Sep 2023 18:05:51 +0100
Message-Id: <20230908170557.773048-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Colton Lewis <coltonlewis@google.com>

Due to recent KVM changes, QEMU is setting a ptimer offset resulting
in unintended trap and emulate access and a consequent performance
hit. Filter out the PTIMER_CNT register to restore trapless ptimer
access.

Quoting Andrew Jones:

Simply reading the CNT register and writing back the same value is
enough to set an offset, since the timer will have certainly moved
past whatever value was read by the time it's written.  QEMU
frequently saves and restores all registers in the get-reg-list array,
unless they've been explicitly filtered out (with Linux commit
680232a94c12, KVM_REG_ARM_PTIMER_CNT is now in the array). So, to
restore trapless ptimer accesses, we need a QEMU patch to filter out
the register.

See
https://lore.kernel.org/kvmarm/gsntttsonus5.fsf@coltonlewis-kvm.c.googlers.com/T/#m0770023762a821db2a3f0dd0a7dc6aa54e0d0da9
for additional context.

Cc: qemu-stable@nongnu.org
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Colton Lewis <coltonlewis@google.com>
Message-id: 20230831190052.129045-1-coltonlewis@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ac440c33f9a..5e95c496bb9 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -674,6 +674,7 @@ typedef struct CPRegStateLevel {
  */
 static const CPRegStateLevel non_runtime_cpregs[] = {
     { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
+    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
 };
 
 int kvm_arm_cpreg_level(uint64_t regidx)
-- 
2.34.1


