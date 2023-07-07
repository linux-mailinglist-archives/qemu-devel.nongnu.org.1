Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ECE74B3F6
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:19:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnDh-00014m-A7; Fri, 07 Jul 2023 11:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDe-00014S-ON
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:18:02 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnDd-0000kK-7g
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:18:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbfa811667so9822025e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688743079; x=1691335079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVD90IOvXxa9gbrEDa2+is9EMTWQ2Ss4OFWOQoPhb+k=;
 b=jlG1mIAbb6Amm3EB8v43W3s4wHOWt1Gl8butodOCqp4W2VlLjD5nQJNnH9Iv1ui4fT
 FprcjY/xPtq5eTLKBKMbOrYgkuFxiD2AtCyU5TWEQ9cr5sGdUPGbr2pLzkZVBJzfZ4Ok
 NGexL8fKFvNVi1mi68Zdg754bui5lhJDrj0pZ/A3z2vhUkHq/FAEA+OukKRB9lqVwngC
 BEudfjeR3e5g1CCPYrMQWyBa4RTdDy7MltP3kTCh1wAX3ZBVQ0a3Bdnt07QL9P9fgbUl
 kyFI/JqVeWByz0juqjNGz7pOH8WhXJZGdrxmKe/xaetYtdOAcix/Kll1nUgbDHxILWRQ
 5oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743079; x=1691335079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVD90IOvXxa9gbrEDa2+is9EMTWQ2Ss4OFWOQoPhb+k=;
 b=ajIGjKHhqLX8tE+W25cOqY3uqTCn27k3xtJnSKsIdViccC83yw6j+zwAkssa0qWeOZ
 1C1cXo4nl+0ZVJS4V7VeMv0VEQvHziUrE7wV1uourrKKdbm4imArR4PNBip9K3PjGOw2
 guBGJ8JT1UFh27gZxxqoKUdMKh6uKyQt/6hBxqmalsVdfLBj4c+rhQ9PHKL3Ct+A+735
 +zx7+xdtpExRUaWo2onXteqPwLYsrpFFsDuzqQOKSmOcbcIbDic6aHW+RS6SQdQwpgTC
 tM3atfXatoetm7s3Tu5JnWgpWLysN+1F50j45ESQ+njKbR2b5mBWAOBNQ7wkWDcUtGrV
 Oidw==
X-Gm-Message-State: ABy/qLaUsdZ4xIkalCphU7DSqwXaNQ/PWXs9rIr948WGCA/umhjER48R
 AuZu4cqyHQmC+vUHHIx+iHzOqL8gAJZQpHMbkIw=
X-Google-Smtp-Source: APBJJlEGkj3u6Au/U3bRVu8L9i1ZuDIn74V8IR1M+AOwxmeEh1zR8JRuq1NXFvGBtQ26bnaJ3mTOLQ==
X-Received: by 2002:a05:600c:4f85:b0:3fb:ebe2:6f5f with SMTP id
 n5-20020a05600c4f8500b003fbebe26f5fmr5719820wmq.13.1688743079656; 
 Fri, 07 Jul 2023 08:17:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 y18-20020adfd092000000b0031424950a99sm4691723wrh.81.2023.07.07.08.17.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Jul 2023 08:17:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/6] hw/virtio: Build vhost-vdpa.o once
Date: Fri,  7 Jul 2023 17:17:18 +0200
Message-Id: <20230707151719.70613-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230707151719.70613-1-philmd@linaro.org>
References: <20230707151719.70613-1-philmd@linaro.org>
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


