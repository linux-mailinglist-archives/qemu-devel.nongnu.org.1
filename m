Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880F832055
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:11:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYgd-0005eL-TD; Thu, 18 Jan 2024 15:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgR-0005Yj-Mn
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgQ-00074q-2W
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e9ce530b9so315195e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608492; x=1706213292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RZro+jmubrqox1BtgtSrk1gGKfZgwoa/a4ZCw9lbhM=;
 b=s69KtmGz7UMVMFqdbu2nseeKRa6qd0YWvBn63QGkSHJBa0SkLtdFq5+PWDEsAC2tiM
 BwAhNu1Mvl9chPjDN6VoyKkRzPXwwbjOSeULbeX0dW9uaeE2oR1X2HBq3tOSiBJTRjbT
 G0Kx1aF2vc49RBnC3YMWAaFkYJ0Nom0q/qLkrUzzn22ly3Xi7q1ad4TKyNyaqs3rZ6P6
 EM2IMKNvlzroAOaMIsRnXa0n/vq7tZJ00WCPodTr7Cq0S12n1vDRRcUM/Hb0AfJk9HHa
 b6MT7XWHZrcRn16n0E7bmdhMibccx0yqQ0oTMQ8Ziqz9hzTFl4sgGGV/o4pz/c/NH2Bj
 ri7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608492; x=1706213292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RZro+jmubrqox1BtgtSrk1gGKfZgwoa/a4ZCw9lbhM=;
 b=jPTUkfbqezKrl/6j2VqEd5yzmPv/excnl1EPyrMEPWqTIqOlm1RuvBWhqFqS5sChYp
 KZuYRfKOvpx7mk4f8pwcvcbtLgoViWT6fIFe7Scy5+h4WejrAHi3i3GZsZXmIypUg9FJ
 HeS5NGBLir6plbQLkAuYqNi2H1/6XdcoPAVeVM7MypuovdTZkgtvfqnNp8u59gaLA44O
 RAI5Gg/5mJLLE9ap6U7A5kxRqqxpsqzCQ8SPARRv7NWRTUS9VBgSXWVFdnsVHaCsDN3W
 BAbYz3xbVKCC/snolW1r1BZ2swaEaqyvmTpTThofycqtbi3pPBG+cy/i461Vi+AU+9Uq
 /EdQ==
X-Gm-Message-State: AOJu0YyeDD/u7rr5lU04Z0iknnBSXEZuPFxRHgMDG2Q80JTWi2iOPtp1
 i0CDB0yN0jCbYHP6xY5elGNvaOcu1sa4gE5EJZHmOEZ1D8pzk0oopSKKhoiV2OLO1GfTHGomCqG
 ZBOX3rpnM
X-Google-Smtp-Source: AGHT+IHIrINmTnOMQD26Vbji91c115tW9Eh48P+DEoBgJUUBMuSZ053+kSt00YTqu9nRONkczU/a4Q==
X-Received: by 2002:a5d:6106:0:b0:336:7a58:39da with SMTP id
 v6-20020a5d6106000000b003367a5839damr872886wrt.106.1705608492322; 
 Thu, 18 Jan 2024 12:08:12 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d19-20020adf9c93000000b003365aa39d30sm4762614wre.11.2024.01.18.12.08.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:08:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org
Subject: [PATCH 15/20] target/arm: Expose M-profile register bank index
 definitions
Date: Thu, 18 Jan 2024 21:06:36 +0100
Message-ID: <20240118200643.29037-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The ARMv7M QDev container accesses the QDev SysTickState
by its secure/non-secure bank index. In order to make
the "hw/intc/armv7m_nvic.h" header target-agnostic in
the next commit, first move the M-profile bank index
definitions to "target/arm/cpu-qom.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Or do we want these in a more specific header?
---
 target/arm/cpu-qom.h | 15 +++++++++++++++
 target/arm/cpu.h     | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index f795994135..77bbc1f13c 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -36,4 +36,19 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
+/* For M profile, some registers are banked secure vs non-secure;
+ * these are represented as a 2-element array where the first element
+ * is the non-secure copy and the second is the secure copy.
+ * When the CPU does not have implement the security extension then
+ * only the first element is used.
+ * This means that the copy for the current security state can be
+ * accessed via env->registerfield[env->v7m.secure] (whether the security
+ * extension is implemented or not).
+ */
+enum {
+    M_REG_NS = 0,
+    M_REG_S = 1,
+    M_REG_NUM_BANKS = 2,
+};
+
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 41659d0ef1..d6a79482ad 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -73,21 +73,6 @@
 #define ARMV7M_EXCP_PENDSV  14
 #define ARMV7M_EXCP_SYSTICK 15
 
-/* For M profile, some registers are banked secure vs non-secure;
- * these are represented as a 2-element array where the first element
- * is the non-secure copy and the second is the secure copy.
- * When the CPU does not have implement the security extension then
- * only the first element is used.
- * This means that the copy for the current security state can be
- * accessed via env->registerfield[env->v7m.secure] (whether the security
- * extension is implemented or not).
- */
-enum {
-    M_REG_NS = 0,
-    M_REG_S = 1,
-    M_REG_NUM_BANKS = 2,
-};
-
 /* ARM-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
 #define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
-- 
2.41.0


