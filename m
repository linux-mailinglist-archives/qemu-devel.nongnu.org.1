Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D8F7FA78C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:09:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f69-0007Tx-7V; Mon, 27 Nov 2023 12:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f62-0007Rp-Rm
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5z-0004dH-JH
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b4a8db314so155445e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104910; x=1701709710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z25o5HgpS769sk9FWaELdrm182ytGgUoPKT3/jaRyEU=;
 b=ZUBOqEcgtMjks5jLUb0ovvKTTXJQiIdSpspkVlepP2SMxSua04ytRYArzHCk+f0XjL
 DpOuEWVTyPfFJL4o282mA2iaBQEfxw0cy4bqd5s8v6yC8l7AFWtXQGsWo2asJGceuhkK
 Fa/xyK1YnayrWDZOaQ8vcX/DI0SnHlmdJN1yeCnxjaJOHrPNk87HoAC2g4Q2R+bkEszm
 JFQbMVyHXM2m11NtsBIAG+ai6WMjBD9ed7hATA7SGjso03ph6+our+pMP+0oHQn8C3Xp
 qWNvSR8evwKLi2vxOQcKjsEWSLlgBr3x4T9BPk8GEu3FPsokxe5gu4fosm4lV+QkRWk+
 n5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104910; x=1701709710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z25o5HgpS769sk9FWaELdrm182ytGgUoPKT3/jaRyEU=;
 b=nbvwGfNK50HyRE4dpkxDwO5rh01L8JR5cZhnlqgSMjB+9xHx/sFQVX5jzK0WN/QAGA
 JfDLlMrTHEF8JKb3575zHirKXerq6T7fvrw4fbAEJBQIsoRIA19kmEvUFSGoYweXXdaJ
 qcOQOM7b95TTb2Hvn/PNX5KmKrJxWTkeasuQ4lpkg0TmacQT3Zb7whDsjTnR+0wGl0W8
 EpuCqjvRDBwTshowE5wGOfl9yS5QAkn7nZ7vqlMfC3QnkTFZ5O7NXx9+bW9vnYp3yzQX
 ku1o22KhF3chwc2obP8AKy1Tow9IQqRMyQxsluWnX9ZOyTKVOG+642Qhkou8msXk5k3r
 Y8FQ==
X-Gm-Message-State: AOJu0YyrRIgDLGsWt10c6dVGZsPhZymmteXPTbGyCeIZquRSGrSeMV8G
 Sdvm2BzbJSdXsvKbBhYTVDkIeR7EqJUV9r5rTT8=
X-Google-Smtp-Source: AGHT+IGuHifjooqi6K+dZu14L9z0TaDUyYIvYXdWTYrTdss6jC5rPP2/EKCkQV3ILVKTkJ2XWe4CaA==
X-Received: by 2002:a05:600c:4ed0:b0:40b:2b86:c886 with SMTP id
 g16-20020a05600c4ed000b0040b2b86c886mr5335928wmq.31.1701104909856; 
 Mon, 27 Nov 2023 09:08:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/13] hw/misc/mps2-scc: Free MPS2SCC::oscclk[] array on
 finalize()
Date: Mon, 27 Nov 2023 17:08:17 +0000
Message-Id: <20231127170823.589863-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 0be6bfac62 ("qdev: Implement variable length array properties")
added the DEFINE_PROP_ARRAY() macro with the following comment:

  * It is the responsibility of the device deinit code to free the
  * @_arrayfield memory.

Commit 4fb013afcc added:

  DEFINE_PROP_ARRAY("oscclk", MPS2SCC, num_oscclk, oscclk_reset,
                    qdev_prop_uint32, uint32_t),

but forgot to free the 'oscclk_reset' array. Do it in the
instance_finalize() handler.

Cc: qemu-stable@nongnu.org
Fixes: 4fb013afcc ("hw/misc/mps2-scc: Support configurable number of OSCCLK values") # v6.0.0+
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231121174051.63038-4-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/mps2-scc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index b3b42a792cd..fe5034db140 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -329,6 +329,13 @@ static void mps2_scc_realize(DeviceState *dev, Error **errp)
     s->oscclk = g_new0(uint32_t, s->num_oscclk);
 }
 
+static void mps2_scc_finalize(Object *obj)
+{
+    MPS2SCC *s = MPS2_SCC(obj);
+
+    g_free(s->oscclk_reset);
+}
+
 static const VMStateDescription mps2_scc_vmstate = {
     .name = "mps2-scc",
     .version_id = 3,
@@ -385,6 +392,7 @@ static const TypeInfo mps2_scc_info = {
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MPS2SCC),
     .instance_init = mps2_scc_init,
+    .instance_finalize = mps2_scc_finalize,
     .class_init = mps2_scc_class_init,
 };
 
-- 
2.34.1


