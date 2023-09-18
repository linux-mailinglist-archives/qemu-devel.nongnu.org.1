Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B90727A4E2B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGjd-0008Op-5r; Mon, 18 Sep 2023 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjB-0006vN-Rb
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGj9-0004Ad-5y
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:01 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-532784c8770so328939a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695053037; x=1695657837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+18fO8c7Dk0qCgNhOL8JkONKbHnDNHi1cgc68a1fr4=;
 b=UsYJ+7hpAjzNQaE52yIQuo+wt63KLjjf1ElQYbCF/BauBdBzwinFwcyE6ORUfS/77s
 noywBnU1i+wuY1jhLfMhBtsXH9lt21+zZzqrKzxIy1Rp/OHh0hCKjUGGffwYw4IM/Yy2
 A9HHrkTMFhBEzpaHt1Q2M8HezFiLdA9H/nJhOwZcxwo2c41CuVLuUFsEYo9B8YEtTRO+
 bUDlR/sUZ643uuULSGDF+jXh3hbGFddVcherUTzKppdOrnMEdMP5qbQ3DPk1Rnte536q
 uQ1QuheJ0BJ3Ac0CNcesRs/8kKyoKJlb0hGP7ZK4cLqMA7I/dXMHX0AleQj/tHtVkVX2
 b81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695053037; x=1695657837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+18fO8c7Dk0qCgNhOL8JkONKbHnDNHi1cgc68a1fr4=;
 b=SwAhM3LMtF0x7L2cXLXAGW0+u4j7uRiRkbzJX/hBvobuXc4fbhObp75IclQQYMHePj
 p+27BBN92ZTHf0dh1xsArimvw9vhaCnoeVgUjr5G/hN4dSHRNNdaBej/qUZj8LNUX6n3
 Dt0sDE3mEBnxHnOut0kwO/jDSUeegDqyyAsH3Ujkv7M7aNGdRHLqOthVqHQHPIdMWfN0
 kiOS99f/ArTSWiBcHjEuxbBnbGr55IJq68aa/FS1w5yr0i+Lcpf/OMkHlFFZK9kYA+Sn
 2789UtTnpQXlMpGxlMntz4JC9RAbfZyudvHvXvG9CUsZg123rVL2i+p9QW6OoROhD00a
 F/9A==
X-Gm-Message-State: AOJu0YwM4A37YXcV21/T8EqtIG86AZIRwZ4Dy0kt6NCp8ew9MnH7R6wB
 Ar0i6KEZ382F3mn+yaIQo5ch0p2GVpLdHsvjLx6eYa3X
X-Google-Smtp-Source: AGHT+IGkFn7qy0jz8oacmoGjjfPL41FojFiYCtkDQb0dCjnyLoNnL5YigEsFHJXz/34UHFIkqAHEBQ==
X-Received: by 2002:a17:906:74db:b0:9ad:e3f0:f335 with SMTP id
 z27-20020a17090674db00b009ade3f0f335mr6095624ejl.70.1695053037410; 
 Mon, 18 Sep 2023 09:03:57 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 qt11-20020a170906eceb00b009a19fa8d2e9sm6481188ejb.206.2023.09.18.09.03.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:03:56 -0700 (PDT)
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
Subject: [PATCH 11/22] target/nios2: Create IRQs *after* accelerator vCPU is
 realized
Date: Mon, 18 Sep 2023 18:02:44 +0200
Message-ID: <20230918160257.30127-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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
 target/nios2/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 7a92fc5f2c..f500ca7ba2 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -201,14 +201,6 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
     Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-#ifndef CONFIG_USER_ONLY
-    if (cpu->eic_present) {
-        qdev_init_gpio_in_named(DEVICE(cpu), eic_set_irq, "EIC", 1);
-    } else {
-        qdev_init_gpio_in_named(DEVICE(cpu), iic_set_irq, "IRQ", 32);
-    }
-#endif
-
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -220,6 +212,14 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
     /* We have reserved storage for cpuid; might as well use it. */
     cpu->env.ctrl[CR_CPUID] = cs->cpu_index;
 
+#ifndef CONFIG_USER_ONLY
+    if (cpu->eic_present) {
+        qdev_init_gpio_in_named(DEVICE(cpu), eic_set_irq, "EIC", 1);
+    } else {
+        qdev_init_gpio_in_named(DEVICE(cpu), iic_set_irq, "IRQ", 32);
+    }
+#endif
+
     ncc->parent_realize(dev, errp);
     cpu_reset(cs);
 }
-- 
2.41.0


