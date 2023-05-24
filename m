Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0024570F995
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:02:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxt-0006Uz-Ai; Wed, 24 May 2023 10:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxc-0006Hf-Eo
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxZ-0006N3-O5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30aa1eb95a0so936528f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940365; x=1687532365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50SL7zbNGl/fD7oTGtJ8qBrDyfPUgCnUWKs/hQwlad4=;
 b=NP0MhVp96M6zkPmX0TGWKygB31Bd/ybIuSWwGmRVrkhPSHTg9+mpoiBof0mDbwlaYq
 T+HDIO+jixPETamR3yEt8XXovaZ+PtGlOqF5BBf1eiqdadY2V2+Ebc+y2R/Hal1Zua//
 HXyq86MTGAPh+dIXlcg+oFB+0Gl8knr0ysZencIGWOThoBWv8Rjg7td8k9U5xTK8mLKR
 9VWGibobVKNpJuxJk+QQLl0sY2z7cxanCXEin3+ojkcZwl0iMoYBoaG9l1ewfx96lf7n
 1nGdLmpEyuZfA4Edy1o1/JReOhR64hY6qmNDx3dPvKZVmpam0DUuyx4A8bb9rTtXuxtc
 xCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940365; x=1687532365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50SL7zbNGl/fD7oTGtJ8qBrDyfPUgCnUWKs/hQwlad4=;
 b=PliLg8icqs9ct7LDyTptB2U2WgYVjmTt7svRlx0QQv2DoG5wiEhMXtGscPyYNRKpa1
 Lq38qFRSl8WCSDS+noxuHoGSUEtKFjHNBTw8pequoj08Fd/tReBHs/KR5UEe+hSd2ubb
 o4oYPrvOktY439Sx+gMhJj9CXiRsSF4Nsgb1oDWEw+DiqicWuHq2OEVTLXdvIL6wurzq
 TO3CHVM+qSl15e8/4JbFqC1GxGHwn1c7D3FwPL1c7iuRJpZat0aWC0hOSqRgKCx0QIct
 qqPAcaRXB81SCvRuS0LdPv3lOnLKMaKEo/LWZMrxpQ6aFtZoRAinhUsvd/+qrUp8VIwq
 Tn8w==
X-Gm-Message-State: AC+VfDwbfmTcFzt1HTjRNVO5qEaz8Ep8xlLLm8GYMqLB/um4qhhuvPg+
 gBPROPVUD3a5yxf+dMAnd2k+c1qzpC3mraQ/GmUhgA==
X-Google-Smtp-Source: ACHHUZ4E/OI0rkEzHfumP/pttGuijVY+G5c/tFGGgq5bNgTTSYqZxiywngKmWDt6vn+P0BYMP2WEkQ==
X-Received: by 2002:a5d:5002:0:b0:2f6:bf04:c8cc with SMTP id
 e2-20020a5d5002000000b002f6bf04c8ccmr27678wrt.55.1684940365713; 
 Wed, 24 May 2023 07:59:25 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a5d4001000000b003062ad45243sm14826928wrp.14.2023.05.24.07.59.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/10] hw/arm/realview: Introduce abstract RealviewMachineClass
Date: Wed, 24 May 2023 16:58:59 +0200
Message-Id: <20230524145906.33156-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524145906.33156-1-philmd@linaro.org>
References: <20230524145906.33156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Introduce the abstract QOM TYPE_REALVIEW_MACHINE to
handle fields common to all Realview machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 07a80d0de3..f0a8a93b08 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -30,6 +30,15 @@
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
 
+struct RealviewMachineClass {
+    MachineClass parent_obj;
+};
+typedef struct RealviewMachineClass RealviewMachineClass;
+
+#define TYPE_REALVIEW_MACHINE   MACHINE_TYPE_NAME("realview-common")
+DECLARE_CLASS_CHECKERS(RealviewMachineClass,
+                       REALVIEW_MACHINE, TYPE_REALVIEW_MACHINE)
+
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
 
@@ -448,20 +457,25 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
 static const TypeInfo realview_machine_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("realview-eb"),
-        .parent         = TYPE_MACHINE,
+        .parent         = TYPE_REALVIEW_MACHINE,
         .class_init     = realview_eb_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("realview-eb-mpcore"),
-        .parent         = TYPE_MACHINE,
+        .parent         = TYPE_REALVIEW_MACHINE,
         .class_init     = realview_eb_mpcore_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("realview-pb-a8"),
-        .parent         = TYPE_MACHINE,
+        .parent         = TYPE_REALVIEW_MACHINE,
         .class_init     = realview_pb_a8_class_init,
     }, {
         .name           = MACHINE_TYPE_NAME("realview-pbx-a9"),
-        .parent         = TYPE_MACHINE,
+        .parent         = TYPE_REALVIEW_MACHINE,
         .class_init     = realview_pbx_a9_class_init,
+    }, {
+        .name           = TYPE_REALVIEW_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .class_size     = sizeof(RealviewMachineClass),
+        .abstract       = true,
     }
 };
 
-- 
2.38.1


