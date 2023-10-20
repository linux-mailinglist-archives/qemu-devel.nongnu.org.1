Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6E7D0DFF
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnAG-0006Q0-0l; Fri, 20 Oct 2023 06:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9s-0006NQ-6W
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtn9q-0005Hs-7x
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:55:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40839652b97so5227025e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697799308; x=1698404108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maNUiJX2EIXBBVU6tPTB8OzF/SPwSGfPTsnOI6AFUoE=;
 b=BxuziZJiJAsqzzJ7sC7dSdsLTIGrWPK2smHvS0lCutmqk0Unuh/QcJmWi1S5H3k5i1
 T9Ia/Ja6ctDEc0iQ45ID/9BYDIamVtMM55gVtWHClSnSsKRaKDX9KZor+j5VComuYiax
 uN8CHU5XIBeNjuUWSC7kgO1hTO4yFwzNlr/WG5f6EUWTnlzEh0qbkXaC5Y4hXqNa3leh
 yoPW4ipDVxiSDzBhxPxWOnWqmWCls9pAjAJ1RJbRF47nGByJaNxbY5iqqfyF+CK/h2mg
 lREtwBmYsm9aBJwYtTr1mNYWR44WFZEIDcgMXFmvXYC+Hommskk8PJ/Oj/J3YQ+p9QNi
 1YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697799308; x=1698404108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=maNUiJX2EIXBBVU6tPTB8OzF/SPwSGfPTsnOI6AFUoE=;
 b=qA/NEhrSthckZ7YyO1A0Fq/Db/3HCWnGGl4h0yaTLxv4Svnu+igmDNK/oOEs63G1g9
 5m93jxlu/p2HlmACWbbCpxlpdBzhV+12YZSlKbBG+U8g4b4nE0FfBztCURuFu52nYAMw
 BV33uk2oBreZM1nwwo/qivDGgE0zaUxVbY5Oakw/CSHN8ZY+e2s/DnJclQnMoNi1Ec5C
 AglKUcphVpazXm7lFOXHmSHKB23kW+Uq2sRlJOOxX4RnXMM5KWX+GLWx6fXFCekMlyYd
 jLTPIdmOJfcDQrHXvmYuq3DcEkkdVFVEh57AbxZqIGSv7UP4ulHAsV7yrsU6kh7q3oxt
 cpgg==
X-Gm-Message-State: AOJu0YzGsRvoxnsuiwQ47tSXgOZVTOOwjfhP9Dog7rnH0tsa4Kf95dSV
 JfYZdh4f8kaGjM0KuBAkfWx/o7NoNQoQB8BXSbI=
X-Google-Smtp-Source: AGHT+IFUgX6islf+HMPIsrVzHnK0AiUMlLh3d1e33SM7ve5bEZJmpcCLYXoSYm5Z59O+FEFez+ueUQ==
X-Received: by 2002:a05:600c:1992:b0:406:872d:7725 with SMTP id
 t18-20020a05600c199200b00406872d7725mr1223870wmq.1.1697799308184; 
 Fri, 20 Oct 2023 03:55:08 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 k17-20020a5d66d1000000b00327cd5e5ac1sm1446378wrw.1.2023.10.20.03.55.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 03:55:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 3/5] hw/i386/pc: Inline legacy pcspk_init() in
 pc_basic_device_init()
Date: Fri, 20 Oct 2023 12:54:44 +0200
Message-ID: <20231020105447.43482-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020105447.43482-1-philmd@linaro.org>
References: <20231020105447.43482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c58a15182e..3937d88355 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1286,7 +1286,11 @@ bool pc_basic_device_init(struct PCMachineState *pcms,
             /* connect PIT to output control line of the HPET */
             qdev_connect_gpio_out(hpet, 0, qdev_get_gpio_in(DEVICE(pit), 0));
         }
-        pcspk_init(pcms->pcspk, isa_bus, pit);
+        object_property_set_link(OBJECT(pcms->pcspk), "pit",
+                                 OBJECT(pit), &error_fatal);
+        if (!isa_realize_and_unref(pcms->pcspk, isa_bus, errp)) {
+            return false;
+        }
     }
 
     /* Super I/O */
-- 
2.41.0


