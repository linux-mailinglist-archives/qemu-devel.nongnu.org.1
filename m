Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97277C876C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrImb-0005HG-DU; Fri, 13 Oct 2023 10:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIlR-0000jE-AV
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:03:43 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIlK-0002db-NX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:03:41 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso3701707a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697205813; x=1697810613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrvfAY2mn68woULbVz677TRglvUf81ZbqsLucDKzz7I=;
 b=BuR4CrcQgvTLeeaTMb8Bk3H5XdhPsgW98bz4La7ZOnNL3QvJersAfWaAy0I1UN+AXZ
 LXqF9y/SKBSrq5nkyRn81BiVFwp19C3XvwOx8T8wIfOa+FXb8wcfmq950jUuTqKb9tkm
 w49Fn6qLw/Xcly8Qklr83OCeG7SQZq26Ymkv16BN0B7dIzKxrCT2Yk6E/FCHhCsYewD1
 ktx6dYgzD/pdwTxruhG5Tx1qo1Rog2qa9+JNkoHSkBuLh4E1mDCPaJdlcAZe0oosaBgC
 8Cbz8ETlCMttoJ78NEwqhQP1O+M2DCyTDu3QWV2lT8sZOTmX5h9FFCZrY5koN3Dvfd4z
 E0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205813; x=1697810613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrvfAY2mn68woULbVz677TRglvUf81ZbqsLucDKzz7I=;
 b=TTPyhhFPe1S91cr26NDdBOLl2y0CvcxCQu0T4y5Cz7v/zwN18TFLovOH1YQyOf9qBf
 ZOQJnFKiMuSGS3FHz3KG3P9uSp/R5JPJOngsOLxOHrzOZUaEnd6eCgXZ5IMTMBrQsjdm
 n3lJlFpTeuGY7jC595faNm1zBI1gO1mJt3DKsVWd8euQD+j13kFZXc9cHSXnxMDntiJK
 Q2kHAenwuvF/msxma2NLm5vuMnl9IHRwBafqCcUtTAtRL4BxLvXn1G3bLSqbJ3TZjGSB
 qrosUHfB39IrY/4VJ79XZwljZ9fYFrDWXa53+aV2RtnHjHoIYzPwyJqxT73cfH95gH5p
 hsxg==
X-Gm-Message-State: AOJu0YwM4W9R1FipyT+KUWkASvVrNWZcsvZUkDsUANRahzSffPylV0lO
 +yETVQR6bPxwIO/8pGOeSyFaTcVfgDxyo1Bp6fE=
X-Google-Smtp-Source: AGHT+IEUsMGvpO3RJfa6gU3r/m2NZyEoNanZHMDJrLUZncT/njhJcdzN9ZchseMNx+HawAYYHhT5Rg==
X-Received: by 2002:a17:906:23f2:b0:9b2:6db8:e0fa with SMTP id
 j18-20020a17090623f200b009b26db8e0famr22738729ejg.41.1697205813224; 
 Fri, 13 Oct 2023 07:03:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a170906b20800b009adce1c97ccsm12437059ejz.53.2023.10.13.07.03.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:03:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yanan Wang <wangyanan55@huawei.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Marek Vasut <marex@denx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 14/16] target/mips: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Fri, 13 Oct 2023 16:01:13 +0200
Message-ID: <20231013140116.255-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013140116.255-1-philmd@linaro.org>
References: <20231013140116.255-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

In few commits we are going to add more types, so replace
the type_register_static() to ease further reviews.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index a0023edd43..83ee54f766 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -595,17 +595,21 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 #endif /* CONFIG_TCG */
 }
 
-static const TypeInfo mips_cpu_type_info = {
-    .name = TYPE_MIPS_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(MIPSCPU),
-    .instance_align = __alignof(MIPSCPU),
-    .instance_init = mips_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(MIPSCPUClass),
-    .class_init = mips_cpu_class_init,
+static const TypeInfo mips_cpu_types[] = {
+    {
+        .name           = TYPE_MIPS_CPU,
+        .parent         = TYPE_CPU,
+        .instance_size  = sizeof(MIPSCPU),
+        .instance_align = __alignof(MIPSCPU),
+        .instance_init  = mips_cpu_initfn,
+        .abstract       = true,
+        .class_size     = sizeof(MIPSCPUClass),
+        .class_init     = mips_cpu_class_init,
+    }
 };
 
+DEFINE_TYPES(mips_cpu_types)
+
 static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(oc);
@@ -630,7 +634,6 @@ static void mips_cpu_register_types(void)
 {
     int i;
 
-    type_register_static(&mips_cpu_type_info);
     for (i = 0; i < mips_defs_number; i++) {
         mips_register_cpudef_type(&mips_defs[i]);
     }
-- 
2.41.0


