Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1D17CF101
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNIv-0007Sl-6N; Thu, 19 Oct 2023 03:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHj-0005vP-AW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHg-0003J5-Bh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40839652b97so15423025e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699850; x=1698304650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHmBGLBbzcVN7N0Yqtsp1sIeIJxOxMcSEmxWkKW9TOQ=;
 b=MD9Ap+wCuXyISoKoAZvrgqqrD5fv6eebi5aVPiOYU/wGM2yvcJ+Z8+9Qqi6iEWtx5H
 WomqtbfuDOQJvogQoA6wCc/DXIjdNr/NKrpOJ6HSfidwWVIcqa0SLjWzO0xiK5iGAUFh
 /VAV0ioefxIMy8UZ5+clEKUbqEBp1kOlsrWgXlmOujRsxJiR9cZ3XnA4oTCKKAiM+tdJ
 +3qu7/+VdGVIFtKeHO/XSOGjDsQMF8l4PUM//LB+4sPLMr8Quu8OFxKpbRvvYh3Q9eQO
 V1zVeosjJfFu/hHep0st1QsRCt+er+WdqLrAbweigKAmTePrvDcmnqPEG4p1KD+1ObOg
 jdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699850; x=1698304650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHmBGLBbzcVN7N0Yqtsp1sIeIJxOxMcSEmxWkKW9TOQ=;
 b=OOik9K68wm5eJdtRuF0W63CsbU3BVeW12iB/v3kE1+broWNEn7F34iA3sy825YFhsU
 YiUu2qnRawlAAW9LlTGvOl19KVqm/Pg8wuahZ54ocXqUgrbPN7Jv6aEM4s5aa2qqlNXE
 /qCCsDUvBmb1GhZZPYsjZx/V6otInjIKaypdf9eKfSARKkazi+t8L7rCtOCtNtSsgoJr
 2cap0iiFIwKDP9koQYlIf2NFdVYoVvv87G7HSYGiFuVnrfJwYNKXGYqXsNSSmVLO3fQ9
 zN4PV/qZGJdk5IN6zfBLvtebMZ1iDOeAIi7GEwQU0JGZRXnOjZY9p+dzXx1jkvRkz+Wu
 M8sw==
X-Gm-Message-State: AOJu0YzMEbYQd38bROlBcHJXlZNrRt+JnlLZjzs1Bofq0/3nBONl8vOO
 2h6HmhKdFWRlEPQqDQkQyqZWXMn4HtqImCgYpMj2oQ==
X-Google-Smtp-Source: AGHT+IGkDp4jnFiZaR5gynL8fveFHHh70nzeiWVPHLgpYlazdOE5lcUI9X+2hk/3o5JzvM01pi88Zw==
X-Received: by 2002:adf:fe8f:0:b0:32d:ba78:d60e with SMTP id
 l15-20020adffe8f000000b0032dba78d60emr849091wrr.65.1697699849994; 
 Thu, 19 Oct 2023 00:17:29 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 f5-20020a5d50c5000000b003140f47224csm3796543wrt.15.2023.10.19.00.17.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:17:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 07/12] hw/arm/virt: Realize ARM_GICV2M sysbus device before
 accessing it
Date: Thu, 19 Oct 2023 09:16:05 +0200
Message-ID: <20231019071611.98885-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
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

sysbus_mmio_map() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02c7a7ff3c..5b08a98f07 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -690,10 +690,10 @@ static void create_v2m(VirtMachineState *vms)
     DeviceState *dev;
 
     dev = qdev_new("arm-gicv2m");
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
 
     for (i = 0; i < NUM_GICV2M_SPIS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-- 
2.41.0


