Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB577D03F6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaPb-0004lh-Oo; Thu, 19 Oct 2023 17:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPZ-0004jn-Um
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaPY-0004If-BF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40838915cecso978785e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750310; x=1698355110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hpCEMkB9kpmbEy5heZ/fa+AI3RvYUKVxbgc0+G8NZg=;
 b=HwJrf++QMtiTSWXfbskBoxt9VMCIBD9kmt2R+4hVwzo2PAnyCbScwzHhK0/xHH3U4z
 r9iFV6mTh69YBMQSXiIhcnG1D5tU7MJTmEQKuccxao9I2CVrH3SW0bp2FJtCyXaTFjmn
 d0RQha9znx50V0Bd0MY0xoc8ANYky/BGHi00tR0AIF/hGrf5HC1XfuFP//lM0kotB3Wd
 /AtD2GCtFi5UHJmgCpeYXVI0x1f9ui3v8AN6zoZs8fInsII8K6odNG96flTfHtWogJKp
 3l9NkWsNA7RC2Od8r0fmCzUkfbuD5UMeMMXHvqF94aKB/dlruDfX5foLco4OuSR0ihkn
 rmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750310; x=1698355110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hpCEMkB9kpmbEy5heZ/fa+AI3RvYUKVxbgc0+G8NZg=;
 b=gJUzlYglntPHIqqyKC1qh1SCUyf0vY9myWrXvMGzsvHnSfme5aBR2GNPvl5Z1377ZZ
 DER5BlKfaZM/8YZJEhYVynDwFJaalMQA9vXkWgP+OVOVywLce8nin/0TFqPGjDm60ujm
 q+dtHZyLjpoit3NrV6leOUFFuXra4j2ffCSt90EiwNAfWUCGL1YcLXn0DcLlflOrRFdc
 tvif+iV2cnnuyZMcgSUybZMXV2B1VsKK6g46FmSqSHkEe0Bb/PAuiDZBoSjZT7Zh09OS
 GDPQ/LiGYRNkcSlhW0x4Ii2+n4ni8pXpThOyZFfQCXt/I4VCNeGiCuWfdMp1iYMKHDub
 llyw==
X-Gm-Message-State: AOJu0YzxImzvJEJEn5tWDRSKr9/LN0e5nKvbzuv5WseJGfPjZquVBXQZ
 K2w83ZvZ8uvc1lOB502zczk3S47Gx1FrrIdQXnKo4Q==
X-Google-Smtp-Source: AGHT+IEeDgzZrfYTlwPRCruNWRUYF85h/UQt6o6kRe4oSXYavBLOKwVHSXOqx52TVuxBBkYf/CdGjA==
X-Received: by 2002:a05:600c:3b0f:b0:405:39b4:3145 with SMTP id
 m15-20020a05600c3b0f00b0040539b43145mr74847wms.2.1697750310609; 
 Thu, 19 Oct 2023 14:18:30 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 fm12-20020a05600c0c0c00b004030e8ff964sm5343291wmb.34.2023.10.19.14.18.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:18:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/46] MAINTAINERS: Split vt82c686 out of fuloong2e
Date: Thu, 19 Oct 2023 23:17:27 +0200
Message-ID: <20231019211814.30576-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The VIA south bridges are now mostly used by other machines not just
fuloong2e so split off into a separate section and take maintainership.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20231015141517.219317456A7@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bd4fe378d..5f7d8ed866 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1322,10 +1322,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Odd Fixes
 F: hw/mips/fuloong2e.c
-F: hw/isa/vt82c686.c
 F: hw/pci-host/bonito.c
-F: hw/usb/vt82c686-uhci-pci.c
-F: include/hw/isa/vt82c686.h
 F: include/hw/pci-host/bonito.h
 F: tests/avocado/machine_mips_fuloong2e.py
 
@@ -2481,6 +2478,15 @@ S: Maintained
 F: hw/isa/piix4.c
 F: include/hw/southbridge/piix.h
 
+VIA South Bridges (VT82C686B, VT8231)
+M: BALATON Zoltan <balaton@eik.bme.hu>
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
+S: Maintained
+F: hw/isa/vt82c686.c
+F: hw/usb/vt82c686-uhci-pci.c
+F: include/hw/isa/vt82c686.h
+
 Firmware configuration (fw_cfg)
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Gerd Hoffmann <kraxel@redhat.com>
-- 
2.41.0


