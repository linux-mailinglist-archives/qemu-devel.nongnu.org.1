Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF9C78EE6B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:18:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLI-00082u-9a; Thu, 31 Aug 2023 09:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGu-0004jw-Uq
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhGp-00061g-GR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:59:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso7296795e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486773; x=1694091573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCCxv16p0EiY2aKlOpGL2Z1uWvBgdn7GkvBoQqZSuSQ=;
 b=XrC7DTwUFnqOeLsTkPLW6yUb1NY+iNSk1KXGr8nZ2RaH9ALSGbv8TEdrWPyvqrNDQO
 +by4fiGlpzKWrJKF+hWX/K7c0kP0KNwB9+qjzySDc7ugCtPzej+U/6Sgt2Zxrc31k7qS
 qTudWVCvHzNPH2MsnuB2xWCBJe8T6Y4IOTUlhsjRELeJ/KBGTOfZU3121P/UVZMMOyMs
 t0ld2Ou8gAaH7ONCTJseKxcu46BARghmbTQyeZTyO88TcdqIstCHz0QdslibXzlNYXcC
 eBKT0l87IRq5iJ1j5t9N9+QUSG9q7GtdtM0ULeHPLbQ1jTTRqDo1Rywa6Oy1z1BRnBJ4
 afRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486773; x=1694091573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sCCxv16p0EiY2aKlOpGL2Z1uWvBgdn7GkvBoQqZSuSQ=;
 b=QVlmR9akUCp82u0sIZso9E7W528JzPM/TorUfpooIzUYQfUvDpAgR4XthKzcIPlT/z
 x5k0J7BmWNjtXIXfLHylN0ZPbf31LUUz1Oy1JivKv94O+mLwa7cQvFLJinmrbgg0Qr2K
 Rtf+CkoBs5frWASZEtlVINHa3JO3pJUjF1N9Zv8MzUF/B84icpud1M4g+bwKo2jaqrxS
 xUGfwJpsV0/trZYo2Xp2okjc611qKh7xCWLy9k7ReY07903seboweduaqCLkP23FMM/Z
 yM5pjrJs07+gjD0Ti3FJQ9XJNlEVXTNjTagIMHjlQJIpYrpLxElaAIobCnsg0d9I8h+I
 6sMg==
X-Gm-Message-State: AOJu0YzULFJfZ78u25vvTkSvS02fW8MIhBkrn+61Rpb5jfrUHSKCigDP
 3Bdvxl5NRKPZPw9kezoc5iylRf0LZKVlh5J/Iio=
X-Google-Smtp-Source: AGHT+IEeC3gq5VJyMXfII0kcH/A4EW7CmvDoRsTVWuxXwQitf9eoymhkncZXtEa22ByiLuh7y3LDCA==
X-Received: by 2002:adf:f40c:0:b0:315:9e1b:4ea6 with SMTP id
 g12-20020adff40c000000b003159e1b4ea6mr3895600wro.58.1693486773261; 
 Thu, 31 Aug 2023 05:59:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a5d550f000000b0031c5ce91ad6sm2142636wrv.97.2023.08.31.05.59.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:59:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 27/41] hw/ide: spelling fixes
Date: Thu, 31 Aug 2023 14:56:29 +0200
Message-ID: <20230831125646.67855-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20230823065335.1919380-14-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci_internal.h | 4 ++--
 hw/ide/cmd646.c        | 2 +-
 hw/ide/core.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 2480455372..c244bbd8be 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -61,13 +61,13 @@ enum AHCIHostReg {
     AHCI_HOST_REG_CTL        = 1,  /* GHC: global host control */
     AHCI_HOST_REG_IRQ_STAT   = 2,  /* IS: interrupt status */
     AHCI_HOST_REG_PORTS_IMPL = 3,  /* PI: bitmap of implemented ports */
-    AHCI_HOST_REG_VERSION    = 4,  /* VS: AHCI spec. version compliancy */
+    AHCI_HOST_REG_VERSION    = 4,  /* VS: AHCI spec. version compliance */
     AHCI_HOST_REG_CCC_CTL    = 5,  /* CCC_CTL: CCC Control */
     AHCI_HOST_REG_CCC_PORTS  = 6,  /* CCC_PORTS: CCC Ports */
     AHCI_HOST_REG_EM_LOC     = 7,  /* EM_LOC: Enclosure Mgmt Location */
     AHCI_HOST_REG_EM_CTL     = 8,  /* EM_CTL: Enclosure Mgmt Control */
     AHCI_HOST_REG_CAP2       = 9,  /* CAP2: host capabilities, extended */
-    AHCI_HOST_REG_BOHC       = 10, /* BOHC: firmare/os handoff ctrl & status */
+    AHCI_HOST_REG_BOHC       = 10, /* BOHC: firmware/os handoff ctrl & status */
     AHCI_HOST_REG__COUNT     = 11
 };
 
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index cabe9048b1..c0bcfa4414 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -257,7 +257,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
 
     pci_conf[CNTRL] = CNTRL_EN_CH0; // enable IDE0
     if (d->secondary) {
-        /* XXX: if not enabled, really disable the seconday IDE controller */
+        /* XXX: if not enabled, really disable the secondary IDE controller */
         pci_conf[CNTRL] |= CNTRL_EN_CH1; /* enable IDE1 */
     }
 
diff --git a/hw/ide/core.c b/hw/ide/core.c
index de48ff9f86..ee116891ed 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1698,7 +1698,7 @@ static bool cmd_set_features(IDEState *s, uint8_t cmd)
                 put_le16(identify_data + 63, 0x07);
                 put_le16(identify_data + 88, 0x3f);
                 break;
-            case 0x02: /* sigle word dma mode*/
+            case 0x02: /* single word dma mode */
                 put_le16(identify_data + 62, 0x07 | (1 << (val + 8)));
                 put_le16(identify_data + 63, 0x07);
                 put_le16(identify_data + 88, 0x3f);
-- 
2.41.0


