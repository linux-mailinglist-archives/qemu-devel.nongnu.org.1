Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3537A4E4E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGje-0008WL-Hu; Mon, 18 Sep 2023 12:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjQ-0007JZ-D7
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:17 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGjK-0004Gd-60
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:04:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52c4d3ff424so5805941a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695053048; x=1695657848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpBrxdgyPGajszRQj4tnQ2gfsy466T4SLwv71ztnz3k=;
 b=Gr++Q9e3lQr6z74NJXlK0bU56at5bUOJdk1RCVGeUUFGNElgIe7PLjNloLrsj5l6+2
 +1qZS4pYX1KN0Kfopgms0o2yuHhP0SM2X7ilt0actOVDOqbwt8sEInO7iLbu2e7kDgBg
 GLGdP3tflPnNCNs6GCjXdG2pcYx93ie8ofZPAnyTAd30lVgDf2Wmkf86rnrMKCc8Tl/h
 Q8mjo0I+cpOdgARdt3nlgXU53OD2DbaH60YJMrsa6Ep8naHBcep0AKPIModWH4REYc4u
 nz4JsT+XgUTI/zq5X08ObVBg1OyVLhPq26rPEdV6eg95pMbn9BpI86RtnmfHHViHC6lN
 Ozlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695053048; x=1695657848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpBrxdgyPGajszRQj4tnQ2gfsy466T4SLwv71ztnz3k=;
 b=TYNRjTGMtRJ0dLOpX73i5s0lFQfb5cY5ThhbisvJOvfvZYqiWcc3juRMwTyCYqUms6
 fYPAeUhKgY8zWAY4kViMTdiconDiad5zIWkwVwkPB46SAT3M65f7Fr3q3kggly83gzx3
 bUP74tMmD7CkhsAycGPBI3HWiHn+i8AuEWVoB6+eSlUnT+shYkHOuP9W3cb6b/F+YhW/
 zvhk91T20vybEgU1CEsXVKkBXFEpotPm6sZwebR4kcz01wMxYCD/1U023ITPd/RnAzgI
 vcJ+wJ3zmCdLMh8uQL7FL44YyUMC4Ja2v8DJB7ZbDITGbCVgeZy2BbmuY2wMD849a/Wv
 r/Rg==
X-Gm-Message-State: AOJu0YywHknyJ2hDiClCT0UXTXMvVlLOrAO83f9LPn23O4zRENNWHljH
 v/qcP14971wov2tBouDcCUm/FqymZ3N74uTmpSZHB+Gk
X-Google-Smtp-Source: AGHT+IG6EnV1NPtLa02ojf1AOOFHw9u/ZZVKTH8rmKjYxc3URy3huazjFDCLq8lcPx0zxuOm3uW8nA==
X-Received: by 2002:a17:907:2cd8:b0:9a5:c9a4:ba1a with SMTP id
 hg24-20020a1709072cd800b009a5c9a4ba1amr8408544ejc.59.1695053048266; 
 Mon, 18 Sep 2023 09:04:08 -0700 (PDT)
Received: from localhost.localdomain
 (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170906088400b009928b4e3b9fsm6613541eje.114.2023.09.18.09.04.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 09:04:07 -0700 (PDT)
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
Subject: [PATCH 13/22] target/xtensa: Create IRQs *after* accelerator vCPU is
 realized
Date: Mon, 18 Sep 2023 18:02:46 +0200
Message-ID: <20230918160257.30127-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918160257.30127-1-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
 target/xtensa/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 300d19d45c..bbfd2d42a8 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -162,10 +162,6 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-#ifndef CONFIG_USER_ONLY
-    xtensa_irq_init(&XTENSA_CPU(dev)->env);
-#endif
-
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -174,6 +170,10 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 
     cs->gdb_num_regs = xcc->config->gdb_regmap.num_regs;
 
+#ifndef CONFIG_USER_ONLY
+    xtensa_irq_init(&XTENSA_CPU(dev)->env);
+#endif
+
     xcc->parent_realize(dev, errp);
 }
 
-- 
2.41.0


