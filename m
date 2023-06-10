Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 290CE72ABB7
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yi9-0005Ht-1t; Sat, 10 Jun 2023 09:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yi7-0005GB-5F; Sat, 10 Jun 2023 09:32:55 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yi5-0007jc-MQ; Sat, 10 Jun 2023 09:32:54 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-55afa2472d9so1793675eaf.0; 
 Sat, 10 Jun 2023 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403972; x=1688995972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLzeS7gztbAOBe2aKBq1DtCEM+pkrfXK/dxGLvsedFc=;
 b=G2WoAZFUISa6vtPMinlBcsX8n9oMbWorUOyPyrUdhBrYl/XrY4L59Y/qx6S1O+zpl2
 X4qXc8whicejvXUKhb5ueu11ol6utrR3eKP3JGrhTu7Eu/z7IdapaVxolU4Xnmt3oUH7
 q3oMyNlFRBsNN9s3kpHOsyqcvl9rhcXCHWX297b9KUiy9gA8teacyweay00rQMg57HaB
 6Vqi7wNC3xjZGAZZD6RIoq7AA83WjT/luFqNhA6vC112ubdHTZDLVm9hDDEQQba21xIw
 /ENBNqGwgxsKntrNtN78xdKGVhc8mCN2Hns4cJgDI+gsCzrhPJOg3Z03JyAkeFoUEjk/
 E1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403972; x=1688995972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLzeS7gztbAOBe2aKBq1DtCEM+pkrfXK/dxGLvsedFc=;
 b=Cox1Z/57AN8UE7ZBj/Av1iYxSzU9LwPDNqJJFnVacscT6MVNAQxPSca4oiL9Q4UuMY
 DZqZMazPlO0egimxHuLYIWFnRrdfWcR5enws66U+TeAqP0YB360ID56eIRve6/ZWhRqh
 iRbqCCtib6JHB5TPlsUuDbWV9cXtc2ZOEpJD6fafiY+Ok2DFB/Eb9vS1ZY62FXelLAwc
 eJFAekTnJksV6iqcKByv57f4y8KJ6+raV1jPLE2eorjJhXnJCpxKbV5maYbnO3WGi2e/
 U2DOrgzMhb2zPMkfDFOLgEDXkWXzh/Rb8kGB2KYm+K5InQzepZfxpPpd9HDVtbgm+uL3
 7VOg==
X-Gm-Message-State: AC+VfDwHvQxmqPNxRPoFZOXD8T/r1Xfh5589Or95+TnRataB6iPOzJaM
 GZnzckJbySjzqAl2ZcQeDYF8jbgRWOU=
X-Google-Smtp-Source: ACHHUZ4wBQ02xXVpn57yA5vhc0r4N87Xk2oC1lgOX9+vglcR8jNqwMsLG+RcSZUw85NkNpIvJVxYFQ==
X-Received: by 2002:aca:bcc1:0:b0:39c:6024:430a with SMTP id
 m184-20020acabcc1000000b0039c6024430amr785785oif.8.1686403971819; 
 Sat, 10 Jun 2023 06:32:51 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:51 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 29/29] hw/ppc/Kconfig: MAC_NEWWORLD should always select
 USB_OHCI_PCI
Date: Sat, 10 Jun 2023 10:31:32 -0300
Message-Id: <20230610133132.290703-30-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The PowerMacs have an OHCI controller soldered on the motherboard,
so this should always be enabled for the "mac99" machine.
This fixes the problem that QEMU aborts when the user tries to run
the "mac99" machine with a build that has been compiled with the
"--without-default-devices" configure switch.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20230530102041.55527-1-thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index a689d9b219..5dfbf47ef5 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -115,6 +115,7 @@ config MAC_NEWWORLD
     select MAC_PMU
     select UNIN_PCI
     select FW_CFG_PPC
+    select USB_OHCI_PCI
 
 config E500
     bool
-- 
2.40.1


