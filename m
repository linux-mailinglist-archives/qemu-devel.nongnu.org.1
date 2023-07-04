Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93992747479
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhMK-0003V3-3y; Tue, 04 Jul 2023 10:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMF-0003UR-HO
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMD-0002pL-VH
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc587febfso49972555e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482220; x=1691074220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pk+gpOgsGH8h9nBVWWWI6hEwEfEczbV1bP+WYEKdNPQ=;
 b=Bj/E2EPDp15WN8r6eDFi/vxSVU7gTqJOmBi3HUoQANyUVl/EO5GP/9tonq7FrvUNNz
 5+dfNGXjFzTKYIqrMc3JU9GkF0YbtTQvjKYz6qZrqSpAY1snuc0nDau/eh5NKFp9XuCT
 CcTF423qll1CdckH5lLSpYZJtlFaMezdddwuzsFJhgO6KENFN7KtDe9veOUAKnzOZ00w
 uqNAXBwb/LEwbz0R6XLoeLlsXb14lmWdOG9kkKHaB16IaKlR3M/3mJ6eO3ykiSIwIfeN
 7SsDDuJjXlP+Rdq2bL/s18s3AU1zfzFlH5XY3KDIC1Ngj5NDAEa9RRevjnHfvGuIMeY0
 kR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482220; x=1691074220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pk+gpOgsGH8h9nBVWWWI6hEwEfEczbV1bP+WYEKdNPQ=;
 b=l8y1UaRnvxA+BiCHdxM14Z+N3v6J/MPhaHxF6hlDrCHYlx/FSboi8ZLeYX0kCrPWFr
 LrNz6gL5EPahT6hbfVrJcYiznnbvWccdqelyeuINXM3Fp0ouzSge98AOS8im5QtrfDoe
 pS/JLyH6ppcjkg5pgZDZQcKNBMOBCjzxPIEUXnJ9P3F/lBEsDEqKAN5WVSrsVuTV+sU+
 EYgklVn2UTcNxZIZGBX0w+Ht7B+DmDISqYPp3cW+xM6+3daJ1YQxcXWU9cZIwZHaLE1z
 TvNJHyYuR85SMeb2HnsvL+v/OOIcavva2rWCV2Fg6loB2/763Dv/S9YSH888tX6u7qjm
 b/eA==
X-Gm-Message-State: AC+VfDxx2p+c5McO4h6uZlUvj657VKGcMkXpTzBUt9JbREaYSt+zHKtA
 WMwWqPHglMTOgNjQ2a0r33646tLTW452XzjUEAA=
X-Google-Smtp-Source: ACHHUZ48gRfkMv62zXFONJmsOVS4Wb1UzVqMVGiHXuYfR/tuQ5rKxu7+/MXUO2l0njgUsuGTh425zQ==
X-Received: by 2002:a1c:4c10:0:b0:3fa:991c:2af9 with SMTP id
 z16-20020a1c4c10000000b003fa991c2af9mr10396745wmf.16.1688482220429; 
 Tue, 04 Jul 2023 07:50:20 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a056000194a00b0031134bcdacdsm28630753wry.42.2023.07.04.07.50.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/19] hw/timer/arm_timer: Declare QOM types using
 DEFINE_TYPES() macro
Date: Tue,  4 Jul 2023 16:49:54 +0200
Message-Id: <20230704145012.49870-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. Replace
the type_init() / type_register_static() combination.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 69c8863472..e410b37a23 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -380,13 +380,6 @@ static void icp_pit_init(Object *obj)
        save themselves.  */
 }
 
-static const TypeInfo icp_pit_info = {
-    .name          = TYPE_INTEGRATOR_PIT,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(icp_pit_state),
-    .instance_init = icp_pit_init,
-};
-
 static Property sp804_properties[] = {
     DEFINE_PROP_UINT32("freq0", SP804State, freq0, 1000000),
     DEFINE_PROP_UINT32("freq1", SP804State, freq1, 1000000),
@@ -402,18 +395,20 @@ static void sp804_class_init(ObjectClass *klass, void *data)
     k->vmsd = &vmstate_sp804;
 }
 
-static const TypeInfo sp804_info = {
-    .name          = TYPE_SP804,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SP804State),
-    .instance_init = sp804_init,
-    .class_init    = sp804_class_init,
+static const TypeInfo arm_timer_types[] = {
+    {
+        .name           = TYPE_INTEGRATOR_PIT,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(icp_pit_state),
+        .instance_init  = icp_pit_init,
+
+    }, {
+        .name           = TYPE_SP804,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(SP804State),
+        .instance_init  = sp804_init,
+        .class_init     = sp804_class_init,
+    }
 };
 
-static void arm_timer_register_types(void)
-{
-    type_register_static(&icp_pit_info);
-    type_register_static(&sp804_info);
-}
-
-type_init(arm_timer_register_types)
+DEFINE_TYPES(arm_timer_types)
-- 
2.38.1


