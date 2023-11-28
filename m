Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38C7FBBBD
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:38:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yHu-0001xv-Ns; Tue, 28 Nov 2023 08:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHr-0001x6-RZ
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:03 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHp-000863-Jy
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:03 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-548f0b7ab11so7373779a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701178679; x=1701783479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AU3XHV66pWU29DJMHZUdephtHQTkVekgNrGzgZLdqHA=;
 b=rSEU1WnVZbcXU60hPlgN8aASM/1URl015XiZqkvbcVbtXpk9MbVpXpIZVCyKA1JzGN
 FMBSczVgnko8hFwvgU+7SPu+N9sgH9FgC9zecLTFF7+rWXQUPgPSHJbztI3gR+/sf9Io
 /Wpk7G+eFpSX2muBvkMZhrqc5SRNidCIJxZuOwog6WavOjDGNS+cSLFhwNYAqY55EERl
 MtByU9EzqNoga7mx9cx41jF9WVMoibLx2v2gLlREuPJDQ0dbcNBEI5XsrT7W1V/h8foF
 SMkIaQXqEC4ROEPuQjPilLrNdd7B3137dIJVpfQ46hCb+Ii17CncSMSQpVaiq2Whwp0g
 gozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701178679; x=1701783479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AU3XHV66pWU29DJMHZUdephtHQTkVekgNrGzgZLdqHA=;
 b=CI3JxYl7zSlejuIlAI9zn2IZUmr/AN/bKMLa0nMBdiYHVepn2pcqAF3h+XKEhuOcet
 imU56qdAH3MapcvxJw3n5dmXMYHZYAmHm7Bw6+XX0myid7bd+Bny81uS26Y2EijHG/f/
 cm9CtMvsBozs/91/WElFJGgbK4+lPI7YeDME86yUU6ixsChFU//FrcnwtWcVovItXtGv
 cbIFREpqucMGg+RGdIVsfsEUPrxuAd/AnmLjoYr77hEYDc6QstJxnWaDWn/x/jBj/x0A
 wfVcbw3a38lKwL6gvWsNlc9efrQl+EXsH7wFLFQabm8jqLTRi4bUEb7hhglJBfzlA5mu
 b8ZA==
X-Gm-Message-State: AOJu0Ywygk6PMJM3hdf/psFzHB3FivvMz74Eb/qvmwZGJ4wJGexunVXs
 o7i2Oefx9nqbcQyiPRCReic3IsGEmPYU5QOKGpo=
X-Google-Smtp-Source: AGHT+IG2YRrfzhFpMwaIEeVc531l5d0AFGSSIM4FRFac44qmYPsDPFjElgnaNdirkgIT3NHvIDgfJw==
X-Received: by 2002:a17:906:583:b0:a00:893f:58cf with SMTP id
 3-20020a170906058300b00a00893f58cfmr9986731ejn.54.1701178679633; 
 Tue, 28 Nov 2023 05:37:59 -0800 (PST)
Received: from m1x-phil.lan (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 bw24-20020a170906c1d800b009fc24437439sm6785378ejb.158.2023.11.28.05.37.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Nov 2023 05:37:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 3/7] hw/usb/vt82c686-uhci-pci: Use ISA instead of PCI interrupts
Date: Tue, 28 Nov 2023 14:37:36 +0100
Message-ID: <20231128133740.64525-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128133740.64525-1-philmd@linaro.org>
References: <20231128133740.64525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This device is part of a superio/ISA bridge chip and IRQs from it are
routed to an ISA interrupt. Use via_isa_set_irq() function to implement
this in a vt82c686-uhci-pci specific irq handler.

This reverts commit 422a6e8075752bc5342afd3eace23a4990dd7d98.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <ed5cdeaba7cf01eebdaa35f84c63427f4d8876b1.1701035944.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/vt82c686-uhci-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
index b4884c9011..6162806172 100644
--- a/hw/usb/vt82c686-uhci-pci.c
+++ b/hw/usb/vt82c686-uhci-pci.c
@@ -1,7 +1,14 @@
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/isa/vt82c686.h"
 #include "hcd-uhci.h"
 
+static void uhci_isa_set_irq(void *opaque, int irq_num, int level)
+{
+    UHCIState *s = opaque;
+    via_isa_set_irq(&s->dev, 0, level);
+}
+
 static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
 {
     UHCIState *s = UHCI(dev);
@@ -15,6 +22,8 @@ static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
     pci_set_long(pci_conf + 0xc0, 0x00002000);
 
     usb_uhci_common_realize(dev, errp);
+    object_unref(s->irq);
+    s->irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);
 }
 
 static UHCIInfo uhci_info[] = {
-- 
2.41.0


