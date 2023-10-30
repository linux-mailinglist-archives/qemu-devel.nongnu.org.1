Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1227DBBFA
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:41:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTRa-0001XL-RE; Mon, 30 Oct 2023 10:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRX-0001Tc-ST
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRR-0001v3-0O
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083f613275so33237985e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698676829; x=1699281629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVj8Lyu+q9x5vjJruURmWnURg8Bgtfz5nJe1rKfNnjc=;
 b=l9XFofqY40eX2o22JxQvvb7n/Y1zxtHMOabArZZXMpCsawGVBd0gzZdFGhziwba73s
 H76CYtofOX9dPmvEUjn2/vcra0cF8zBEOlWzEW+8S9KWjURhAWZSbJc3P/TwmVKh/aNj
 fG+iCl+GhdbpKeEZIHo1VMExfXQ7AoddZKTGAMumsbZRDGGYXwlhQlhOgC39BGp1wPf9
 rNiazZ4YO/syIQsAJybezC/6Ll2WB30zz+IqSpMQ9F5cXVryJ/zgR5UGczTAFDGqxnhH
 CqKgvF9N3vNLxNwQa3LkcRwaKJqRqfeaXd2miol3hzy2r/RoYMnZb1dh2CVaqQis/0Fq
 zZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698676829; x=1699281629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aVj8Lyu+q9x5vjJruURmWnURg8Bgtfz5nJe1rKfNnjc=;
 b=rqec+RWj6o57dPrtvKF54prr6G6w5jvPEaFdRiyfa0IQD9jI5nwQ96Mte1KTSH1BLc
 mwaOHjXm4JCp88rtIQerxOVW2A7/HPp8p8ItHf4rvCpRzf9N9D7YUSkLGXZVwha7zxBA
 eOuQxZYKwoTRmlLInraaZsFeAWBovQ7Fgpm6rHC12bdzkrQQ0lKAsiNoJqPmt/KEV4f3
 CvES87AnJ1ydZvOd49fGW9vWSq7QgbMAVMGL2jNkT7wGfF8ASsTvP/QCsVGLTom44ne4
 Pix60dQBXnbpq+AYMfSCUc0GB++P4zeTn4omeDiEBXToerRCTxQTuQotHNpVrXMdn1W8
 cDjw==
X-Gm-Message-State: AOJu0YzD/rdHSTUBNguuJTYbwSsTy24SeAEtjIF85w2ZqpIr1Pr9gfIf
 WvbYCb2YlgJ+pktHq8p6qaDEUYUsbVgRsoDCtTA=
X-Google-Smtp-Source: AGHT+IFyovKWaKgklMSqmOkM4ZOwVOwEtx3oRZP4ALic/VmmF4HYc/dmUWLdo9anjMf8cGZq9GAA1A==
X-Received: by 2002:a05:600c:a0a:b0:405:3b1f:968b with SMTP id
 z10-20020a05600c0a0a00b004053b1f968bmr8835285wmp.21.1698676829437; 
 Mon, 30 Oct 2023 07:40:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a05600c458500b004060f0a0fd5sm9314651wmo.13.2023.10.30.07.40.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 07:40:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/ppc/e500: Inline sysbus_create_simple(E500_SPIN)
Date: Mon, 30 Oct 2023 15:39:55 +0100
Message-ID: <20231030143957.82988-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030143957.82988-1-philmd@linaro.org>
References: <20231030143957.82988-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In the next commit we'll set properties to the TYPE_E500_SPIN
object. In order to ease next commit review, inline the
sysbus_create_simple() call first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index f8177c0280..e38f46df38 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1082,7 +1082,9 @@ void ppce500_init(MachineState *machine)
     }
 
     /* Register spinning region */
-    sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
+    dev = qdev_new("e500-spin");
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, pmc->spin_base);
 
     if (pmc->has_mpc8xxx_gpio) {
         qemu_irq poweroff_irq;
-- 
2.41.0


