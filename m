Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4AB7D1441
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:42:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsVc-0003Mh-2Z; Fri, 20 Oct 2023 12:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsVF-000362-DB
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:37:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsVB-0002SK-1p
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:37:37 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso1558078a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697819841; x=1698424641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zp11byryPsUZ+4H8wFI4Zq/E/xqbK9hz7sAlcv7KVqc=;
 b=pLFg/PqwhSxLxyBpw1me7T4KXzVJ/MTeFtyPi8i2DFSvz4V1SOGcmKqQPt3lOh1IKX
 pWHOF3VZ3bOnTtH/6uMNsOwUG44qWCBS+GVl2zoi2J2OIF/APym4TrQBRKhgv0SeavxC
 /JgPk4WEieSKaQGwpnin3b0l+7YnznBXqU9QvgBTyK1EohwGXaMs0VqhjErz60PXtRC/
 WrMzuzxGXSiAXkQenS8xQ5sFducfDLWTa/j6RRtulpWz2M7vIpcCADD5xetMU9rNg14u
 V6cfVEhduT3TmuYTI3Vl3TB4P9epli+zbi77/Hx9fkQTYLCPvK7FmfCOjLOLtID0odvc
 ldqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819841; x=1698424641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zp11byryPsUZ+4H8wFI4Zq/E/xqbK9hz7sAlcv7KVqc=;
 b=cdFiAYw6kXvjlmerwNMxpaJwWSbZUpJfcV9Fd13XMKHk5k2B+3tkqnB9iEUhT5hn7A
 IAPKL9HDl4X9qaEnFlgzGHcLsK3yekyD4+9ZBNMPh/ksBRWjELiWSLaolUVbqD1Xf7Xt
 66o7CxGll0mJP4+bLY7THESB/IFj/phxU89TgTtysgaMS0iSlBY0uHd7z7OcTJ0ZmNAm
 kdsZBebQOsLJJTYc+JKwqqh6iXz647gMlqiJtn6HJOCSbvfZjXH5RV47FXrOuW8CQjWn
 y0MZaIl/6hy4l6ZSa1vxWFp6Q7stgv+7MFUze0/s3/y6LctV65NC1u1qVO4qYylWDQhq
 0B9w==
X-Gm-Message-State: AOJu0Yxd0rgAvyauhl2Wb7i4q7K1szGm0ALFHU9sUCdL2TNhyc2XznCe
 38P3/SmdYD2/hpovRsiRW9eDHUec1APU/2EDg0w=
X-Google-Smtp-Source: AGHT+IEiQRd93j6ORFqt6LLksrDvAtJ4jFmSOqwmG0w/kRCYG+YCyMIOK8p9iSZNmwu/QJv5BPBqFg==
X-Received: by 2002:a50:d542:0:b0:53f:a4f7:7bfb with SMTP id
 f2-20020a50d542000000b0053fa4f77bfbmr1827246edj.17.1697819841503; 
 Fri, 20 Oct 2023 09:37:21 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 n15-20020aa7c68f000000b0053eb9af1e15sm1738773edq.77.2023.10.20.09.37.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 09:37:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH 04/19] cpus: Filter for target specific CPU (loongarch)
Date: Fri, 20 Oct 2023 18:36:26 +0200
Message-ID: <20231020163643.86105-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020163643.86105-1-philmd@linaro.org>
References: <20231020163643.86105-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Enforce qemu_get_cpu() to return LoongArch CPUs in LoongArch
specific files.

Mechanical change using the following coccinelle script:

  @@ expression index; @@
  -   qemu_get_cpu(index, NULL)
  +   qemu_get_cpu(index, TYPE_LOONGARCH_CPU)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/loongarch/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 902e32a3e3..83ca7d6b98 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -560,7 +560,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
      * +--------+ +---------+ +---------+
      */
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        cpu_state = qemu_get_cpu(cpu, NULL);
+        cpu_state = qemu_get_cpu(cpu, TYPE_LOONGARCH_CPU);
         cpudev = DEVICE(cpu_state);
         lacpu = LOONGARCH_CPU(cpu_state);
         env = &(lacpu->env);
@@ -594,7 +594,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
      * cpu_pin[9:2] <= intc_pin[7:0]
      */
     for (cpu = 0; cpu < MIN(ms->smp.cpus, EXTIOI_CPUS); cpu++) {
-        cpudev = DEVICE(qemu_get_cpu(cpu, NULL));
+        cpudev = DEVICE(qemu_get_cpu(cpu, TYPE_LOONGARCH_CPU));
         for (pin = 0; pin < LS3A_INTC_IP; pin++) {
             qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
                                   qdev_get_gpio_in(cpudev, pin + 2));
-- 
2.41.0


