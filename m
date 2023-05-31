Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43072718B46
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SYP-00078f-Hg; Wed, 31 May 2023 16:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYF-00075O-WD
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYE-0003AO-DB
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f606912ebaso939665e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565368; x=1688157368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axVpU0i2p75LH2asCUomaSunVbrAGYJD7scBST0rZU4=;
 b=w4dI9igElL4S66mQ9PeZEGHEm2TRMeJISnLQ4j/7gJEv3yMR/8O/7L9VTf1mCwuHGy
 WXfNkzEDJGcf31Zj33BP1CWpJcEMpLeMfvsaSZDhD+3iWFRk1rDCv+e52/g8+bhLU6P+
 PMVQvY3Urrs/G67vF7kmvVbu6vhXSTGbgIs50uwb90KOEcQ+uHR/soR2MilbxHIqAw7K
 g5IjRF9dxWIpcbwDfUa03Uhw4qsA4QiBc6aJM9HkGnDpuNF/xllFbfiXygllika60PS5
 FRtxwwrTAE+MzNjqIr36N6rFSz0MjL1AEqiptgTt0sDtF0kR1tCGo83p3/iKrh2NcSsy
 hd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565368; x=1688157368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axVpU0i2p75LH2asCUomaSunVbrAGYJD7scBST0rZU4=;
 b=lGnOlXgeaJxF4psj/qP8rCqQG2PEx6fg9sNgKY10GYlh3dxj0JY/Croh/Kqw0IMTQo
 YFYke0lBvj34tYL+DNrOlH+c+qjH74ytwviDdGlTcTSJSVMx69aIdUMkkZW4dnREknKz
 cDU+cX2zyvUbQhPPgEzBBPbaSuVYujOemdd9IM3OjWVe2otDmEKqCgVLbZLQinMAIWZR
 Rk19kwj6kyNvlzXst75pF7WNpDWD6skzmOhwTDCkpZ0Cvgy5fXU0fgtkxhkkUNgKBQ2j
 8h5l7Kb257JHh0edWJkWGkb3TF8izAeupZuYoUJOzzV0qf2Qbwca150pMKRzd4O3wAra
 PIHw==
X-Gm-Message-State: AC+VfDzOYFOuTma1c2XgOR1JIay8BYkcjl8NVlWj/QKCMrFdup0AnEBz
 MzY9DDtN4cBKRtZ7jvgEunjL7jeqO6uq3E3qt2w=
X-Google-Smtp-Source: ACHHUZ6FyCdS4xZ2yBUhpIySH7hFdVftn0j3PcRwnQ7XYKe2OgCM+p1moYYK91D0MhnuafiA2bmbVw==
X-Received: by 2002:a7b:ce91:0:b0:3f6:89a:94c8 with SMTP id
 q17-20020a7bce91000000b003f6089a94c8mr301976wmj.24.1685565368541; 
 Wed, 31 May 2023 13:36:08 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a05600c290700b003f42d8dd7ffsm21935638wmd.19.2023.05.31.13.36.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:36:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/15] hw/timer/arm_timer: Declare QOM types using
 DEFINE_TYPES() macro
Date: Wed, 31 May 2023 22:35:45 +0200
Message-Id: <20230531203559.29140-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


