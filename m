Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513AAE2098
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 19:15:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJv-0000W1-Gg; Fri, 20 Jun 2025 13:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJn-0000Sz-DV
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJl-0004D6-Se
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso1264765f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439657; x=1751044457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLX6rcSSOatokSoUj/Vh4pkcX3PAjzJZuqfjXFPaG7s=;
 b=YeUpdyA5PsjSPPHhbbZ30u2U/eNPzCXVK43aqYgHhsHaKNv7oGMuRSTShs3t7kDw4+
 O4sR3DV2IsChjYP4cPioEuarGfypyoven2FplnrpgJGvDYG7KWsZ+yo/ykX64dtsLpGs
 RAU2P8H9weM0syJsSA1GEmTr8/Rf6hBJn5xODFhexTqN+14Wg0WAMhxOTj1S6CxXw42Z
 MBNbEBGjURa8vXvIAvljc+3xf7u4nHUv0EE+uPPdhx51RtKhQxXBTvxNEijweutCXEdk
 3JKVTFAV1ms+RUj1thtkfmJ5zeoxyRz9UMZIu9gIFapIHxDRr6yuQkf6ATgOvsMKiIot
 GX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439657; x=1751044457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLX6rcSSOatokSoUj/Vh4pkcX3PAjzJZuqfjXFPaG7s=;
 b=L3/JL0fSWrqm3gtVFBswE4wON5oYebD1D8A9AYkuZ75ueUlke1Ym3rbhqdd490YPaH
 sosTcU/5lHAr7QcXmscSYHVI1VWwN7kQxbLUJwUWKxnY2EauqczXNstWPc0g9APQzTmn
 h1L3WbkoJua9GP4rPXmy5AnJVzrcFD3YztpAzHGT20Qe+TUpz1wgKtZm9HwVvyP/WWN/
 n/mJprJjPyA3TgXwN4s3TaemosNJW7G9bPGAsIArBfloetqirftwNNM6WyzJC7irVmQa
 4hM20XWa+HQLQbZ5KcX21VpoDourN+Ai4+bnmbbRiTrHiOjw306bWx+eXDmAuTaQ4RgB
 f1QA==
X-Gm-Message-State: AOJu0YyLc9rFE4fC0nI8/XslJ9AIisr9bQfX59NImQRAATUa1Hwir2/7
 V53LT9B26gJ/HqsKFL23neGo9YtVsZIlRLK3E7/eyGWahSrVSC1ctzCod/Prsnx/Wabp6uBDKYs
 Xky5TR1I=
X-Gm-Gg: ASbGncsfQLg/tqgyr4JcHmaqsIoe580uPsYXhbBe0JVJv3jgbZY+e6aiLttbxu9I9du
 S0pG+6ZpU7JheKeHnaKAqeHeotFA69AYImkD2mWag3YYSLNZlVCthksi5iRREwcluKwjUCVC0rV
 32/rWSDnJoCB80EDOa4Lz/mTPswEuRvCdOSR8pNw3xqg8KAybtea4R4fSmAMIXXmisgAZ4JxiRh
 3A4aKGdWW43cpczmp4ndfU3ul5Dw/ZMlFLRlKSIzwAAMyRPfcmh2BXKnrVdiYdBSpcLwHaV0QrX
 n1jbzsK41au8T9zBsTxqkJtZtIniTMbJxqYAk5EcfdfST32dXdW8bC7o7CBs6YT3vn8M8Z0SsE7
 h79sxztRtiFj7HPhOveNOD4GK7szdjZhbQ+1u
X-Google-Smtp-Source: AGHT+IE1gopHu3zgCitv23Q+O00mTAJpZvECaY1TiUYiIFHl3jqIenCnEP7aY20udb7ufniQgS7AOQ==
X-Received: by 2002:a05:6000:1a8f:b0:3a5:5298:ce28 with SMTP id
 ffacd0b85a97d-3a6d12fb253mr3271457f8f.4.1750439657559; 
 Fri, 20 Jun 2025 10:14:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45366b4d0adsm20605215e9.14.2025.06.20.10.14.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 07/48] accel/kvm: Prefer local AccelState over global
 MachineState::accel
Date: Fri, 20 Jun 2025 19:13:00 +0200
Message-ID: <20250620171342.92678-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f19b20c9fdb..8f6c0bf3888 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2588,15 +2588,13 @@ static int kvm_init(MachineState *ms, AccelState *as)
         { /* end of list */ }
     }, *nc = num_cpus;
     int soft_vcpus_limit, hard_vcpus_limit;
-    KVMState *s;
+    KVMState *s = KVM_STATE(as);
     const KVMCapabilityInfo *missing_cap;
     int ret;
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
 
-    s = KVM_STATE(ms->accelerator);
-
     /*
      * On systems where the kernel can support different base page
      * sizes, host page size may be different from TARGET_PAGE_SIZE,
-- 
2.49.0


