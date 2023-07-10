Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1374D2D2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInlF-0001Rd-HE; Mon, 10 Jul 2023 06:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInlB-0001RM-Ec
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:04:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInl8-0001tu-0i
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:04:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso44947315e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688983484; x=1691575484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LMOPfhO5ibhIM8wguQENwLu/kd+mXHQhja7vg27N5M=;
 b=BZFyNP0Qvl6j3gQGtMAYdILycCI3bmo3AqAhaVykrziftbX12Idqe5U72qpomxvm0o
 8hoObCvqVkSDfcrb7nstleDEKPmhMe7xC67+i8zjWtj/1J8tAJRHLz2n4JtnLl0Rl1/f
 1u+F1OUbmaY9vsUT6rpkl6zTDPmRRBv9uai8EtFc8blOsN8wGkrl3Oc/EZAs+6ugaESi
 yXXGczvK1UtrbE3R+nTSFHz3BE8W1/OSFguqWkaZCUXZuHI4DJlkJS0n7QNI6dJMvX1G
 iONVSo06r4UBHGL5i4u8QwiIorva/aExBbrVYtyqv0g5l5K3jUpofbivtWiH8DO40w+0
 9nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688983484; x=1691575484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LMOPfhO5ibhIM8wguQENwLu/kd+mXHQhja7vg27N5M=;
 b=gTEKX0zsPyw8fFIKxd2eZ7dSxLWjSP+8mz5wxt6FJiYyUjIv17+CvzlQM+lq/8piMs
 Dbm2QSI3FleRyB8FibjHyzYLTDtJiUqnp2hVGVCIqeNm22PAdq/9GbCJSz3HGtmodUDQ
 BCAW84p2XAYrHJUNM7U/fu5DLTEWliG+/t9ZF7eePj8Mot1kobAwmYSMJ/MqK6olP8S/
 edfnuv+5t0AlfyQKsrRuc6Obr/fgF5dDWDyehiWxil1KgSF5ecVnOhNkHj43UyvDK82t
 HHdBysZ07Tc7pnB5yl9xluxxRlE1ONVH9MDtfq5sne5mtw0V+znbZ05xS4x0rCcPkJsJ
 +bxA==
X-Gm-Message-State: ABy/qLaiz0LHjP6k7kkdZeCqww7cILfW05pfbJcLch0TpsqRg/52t2Tl
 KS/TGfK8WSxr51b1XWRSZ/2KEg==
X-Google-Smtp-Source: APBJJlF+5eR2+tIQ8/8+yyJImhnGzukopvdLQ7e72aOHcQEPv4yL+4VzHkt1/kWzexyhDgQGMPNzTg==
X-Received: by 2002:a05:6000:144:b0:313:ee3e:50c5 with SMTP id
 r4-20020a056000014400b00313ee3e50c5mr10395648wrx.20.1688983483964; 
 Mon, 10 Jul 2023 03:04:43 -0700 (PDT)
Received: from localhost.localdomain (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 u12-20020adfdd4c000000b0030ab5ebefa8sm11222109wrm.46.2023.07.10.03.04.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 03:04:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: 
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/6] hw/virtio: Build vhost-vdpa.o once
Date: Mon, 10 Jul 2023 12:04:32 +0200
Message-Id: <20230710100432.84819-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710094931.84402-1-philmd@linaro.org>
References: <20230710094931.84402-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The previous commit removed the dependencies on the
target-specific TARGET_PAGE_FOO macros. We can now
move vhost-vdpa.c to the 'softmmu_virtio_ss' source
set to build it once for all our targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index f32b22f61b..900864c1be 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -18,7 +18,8 @@ if have_vhost
     specific_virtio_ss.add(files('vhost-user.c'))
   endif
   if have_vhost_vdpa
-    specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-virtqueue.c'))
+    softmmu_virtio_ss.add(files('vhost-vdpa.c'))
+    specific_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
 else
   softmmu_virtio_ss.add(files('vhost-stub.c'))
-- 
2.38.1


