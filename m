Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6707BFE87
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDBL-0007Jm-MN; Tue, 10 Oct 2023 09:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqDBJ-0007JY-AV
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:53:53 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqDBH-0001hH-Pk
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:53:53 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so9319797a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696946030; x=1697550830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X01cDrFh6MKKFL5QggGGmKmc6mkeCQSDemTVVtXnJhw=;
 b=xOiBrYn8CULeB1waRTH7NiTQz4zKltfRRVNDQUVhf6EZh/7iVN2ljA/uHRTA3DZiaJ
 fP1EOcbRS5lzhcaDmPN3zoIIWsSE0904ozyaLvGcDGk5ueck9aPVmaINXeaiVwNQ59qe
 K7qlSn/8uw9iObtJAFOcErOjd78HP+dw6vEbDIt7A3e+7Kp+gfqOQnOz22nKD76KO9rS
 3iRrG6h4lGrGxyQo5TUNIS8HWqXM51L77p71Jt9S9Ps85vfoxFuSoeEpbb/zncjvTihl
 lcmCjSnXAUfevKtgEDx/JRfW3Kd7iXnqd3AYkXKKjyU8YK9JGjWswWjGXegbVvhy3mkk
 MHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696946030; x=1697550830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X01cDrFh6MKKFL5QggGGmKmc6mkeCQSDemTVVtXnJhw=;
 b=HrQ3D3ukZacIT6BAfaV8+KWTKQrthIPewoTw+TtWsXRvKvsks+NNOmHtAmyiXPwevO
 Lx8eSFwU58kHqRi54f/N5WTUxPdsU5IBYmLMWgGwTE4FdgT4mXAgajd+4XHyaXMGzEC9
 t92vsraQE25uRnaYCAutlJkmh287rjajbw59bkWZTe3sU6kloDfaVnaCyUNmTBXfXAU2
 SaYpoiDdKJ+Nv9rtujShN4mCdPOxU6X5motAoEpiDTxs8apicpjYrQxLXN7hSbOWvSSo
 oXofD64HrZvZtqnNL1g71H6IWT0HO9zShS5wIM3XFhD9MaJgEJOD+jXzVRzhsoEM4Np8
 WGeQ==
X-Gm-Message-State: AOJu0Yxo9cieA0mlN//pJIRFuuuEMNx+SgwHCcmJFQZrSBRko2UROSp7
 PY8lxLJ388oOrul3b0K47KZcDKzdYV8bgNWc/HFoBg==
X-Google-Smtp-Source: AGHT+IGA2i1ZBpvt9AwTgbjefr+x7v/GHb9I58wIgr5OQKC66I96U03lXrIULAEnSEn5oByYidSMrg==
X-Received: by 2002:aa7:d683:0:b0:527:251e:1be8 with SMTP id
 d3-20020aa7d683000000b00527251e1be8mr16428047edr.13.1696946030137; 
 Tue, 10 Oct 2023 06:53:50 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 by1-20020a0564021b0100b005224f840130sm7632462edb.60.2023.10.10.06.53.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 06:53:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/loongarch/virt: Remove unused ISA UART
Date: Tue, 10 Oct 2023 15:53:41 +0200
Message-ID: <20231010135342.40219-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010135342.40219-1-philmd@linaro.org>
References: <20231010135342.40219-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The LoongArch 'virt' machine doesn't use any ISA UART.
No need to build the device model, remove its Kconfig entry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/loongarch/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 1e7c5b43c5..fcd5f2b4b6 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -7,7 +7,6 @@ config LOONGARCH_VIRT
     imply NVDIMM
     select ISA_BUS
     select SERIAL
-    select SERIAL_ISA
     select VIRTIO_PCI
     select PLATFORM_BUS
     select LOONGARCH_IPI
-- 
2.41.0


