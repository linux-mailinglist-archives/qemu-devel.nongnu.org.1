Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B0D7A4E0F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGjd-0008Tm-RE; Mon, 18 Sep 2023 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjK-00077B-D7
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:11 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjE-0004FT-Gb
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:07 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52e5900cf77so5793802a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695053043; x=1695657843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBZjR8eqTRO2FcjHJbn6UW72+cRDsZ12eh5J24aMJRM=;
 b=ULAfeQ4ycNHwmdNM0Zx+K1UE1/p4THoywtr1OeOMxNgw/12Wk6Wxgynq0XWCaRs5U8
 J0IXmB8tTW2i/kj/ZZBMKfE9SuivJ8bshkUrx/cfI9bWsbcPiVyPOEN6gSv1sxa5RneC
 AzM5XAmZegX5MYItdcpBu85T7l6NbYCZCoOys3l2Cmv3y+jVi1AYU+p+jAMKodl2Zo1A
 9PmgjuJhFVBnJkBtrRTCP6m/IG457DwEFu4GC4kmpuBvV4o1T02fghZvTZU1cWNkHNjA
 BwsClz4xEwEZsbXiSz4gL/hivynqDLdK4h6gta6uKJL/1x7hF2QtaysH+rprPDCPXWOc
 vK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695053043; x=1695657843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBZjR8eqTRO2FcjHJbn6UW72+cRDsZ12eh5J24aMJRM=;
 b=aQlFm0ViQtuB4Kpy/1IiUlYOtjfhopvdM8+VQeG6xKdtcOttRHWs9w213O7Vtsf3dq
 rbWQUtvLffrTm2gIOY1aPmRroAIDUx6Fes/RInUptBM58ntU3L+RI6BzSeWKzZ1DSEzS
 NbUYxzZ8ffHM4BVDr8GtQbdwuML2MgiWSDp9mows6RWJ/NozrRxBb+6z2uaze4digZq6
 UkToCYYr0el1wxA3eKnmBirgpVzfCmfII0PKzeUP4v2TcSR678Uvd2P4TdhpFKAToVRT
 PS2EYAxtAj3EAUWuPy0lgojJ/TFpOLcSDH0elZSQytx6+rlXKz3agL644yjOY0ErgL/P
 VlVQ==
X-Gm-Message-State: AOJu0YxXM6cWkPnynJwqmsUuskJE9bTaNX9FVWBtOrfGIaGFkx7Ibcoy
 MhfXm6y2WRrIqJ3LJc7ni1sZPJ3+WrsOoR+SNQgoeWyj
X-Google-Smtp-Source: AGHT+IFSQh3aSy8WNfVsJ8gBPwr/UHTrTRJ5GVnUXxcFo9z61kuLhRihhFERCd0BfPS6IwLRcpPE5w==
X-Received: by 2002:a17:906:209b:b0:9a9:fa50:1fa8 with SMTP id
 27-20020a170906209b00b009a9fa501fa8mr8796931ejq.40.1695053042868; 
 Mon, 18 Sep 2023 09:04:02 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a170906240f00b0099bd1ce18fesm6723198eja.10.2023.09.18.09.04.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:04:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Marek Vasut <marex@denx.de>, David Gibson <david@gibson.dropbear.id.au>,
 Brian Cain <bcain@quicinc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Claudio Fontana <cfontana@suse.de>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-ppc@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alessandro Di Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Luc Michel <luc@lmichel.fr>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>, Stafford Horne <shorne@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Michael Rolnik <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 12/22] target/mips: Create clock *after* accelerator vCPU is
 realized
Date: Mon, 18 Sep 2023 18:02:45 +0200
Message-ID: <20230918160257.30127-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Architecture specific hardware doesn't have a particular dependency
on the accelerator vCPU (created with cpu_exec_realizefn), and can
be initialized *after* the vCPU is realized. Doing so allows further
generic API simplification (in few commits).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0aea69aaf9..7c81e6c356 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -464,20 +464,6 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    if (!clock_get(cpu->clock)) {
-#ifndef CONFIG_USER_ONLY
-        if (!qtest_enabled()) {
-            g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
-
-            warn_report("CPU input clock is not connected to any output clock, "
-                        "using default frequency of %s.", cpu_freq_str);
-        }
-#endif
-        /* Initialize the frequency in case the clock remains unconnected. */
-        clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
-    }
-    mips_cp0_period_set(cpu);
-
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -492,6 +478,20 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     fpu_init(env, env->cpu_model);
     mvp_init(env);
 
+    if (!clock_get(cpu->clock)) {
+#ifndef CONFIG_USER_ONLY
+        if (!qtest_enabled()) {
+            g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
+
+            warn_report("CPU input clock is not connected to any output clock, "
+                        "using default frequency of %s.", cpu_freq_str);
+        }
+#endif
+        /* Initialize the frequency in case the clock remains unconnected. */
+        clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
+    }
+    mips_cp0_period_set(cpu);
+
     mcc->parent_realize(dev, errp);
     cpu_reset(cs);
 }
-- 
2.41.0


