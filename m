Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C47359AA
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:34:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtV-0001ib-JL; Mon, 19 Jun 2023 10:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsq-0000eb-TC
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsp-0002GY-Ay
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3a2so8621705e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184968; x=1689776968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FyPzDa94K3AZr/hbkz0BKSLwEV+wo2bmArnAzAqZpzg=;
 b=WlJLsUa0Mvgvx2K907TiI3dmeem7fIoOC3+Z8YTGBkQlaVaxcHNbiJHB07DCU5PaF1
 a7Mx9w0/vQrAhYr0EITvKwlXYmjlICr0noMat+fRicMHIPaDEeM8AOC5UHY92LOgJ0AY
 6LBF0H9arxsIQUFWNBk4HL85GlT5JYmo0XoruKjuxO2K7IIuOyCABtfHKnuG4nXwVSp+
 pZ1dUWoSctX0KCKctGFNLfpCG1HZIkn32hQVMozxgrIATqLEWrgsPiMZnhaC2Ih+ndO5
 qnv+hoIViMLSx7XZOFtq3nMMr+bqYRILCrh25K9dGHyyS6nktHYiEnTjPF7tgUpPR0sF
 Y+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184968; x=1689776968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyPzDa94K3AZr/hbkz0BKSLwEV+wo2bmArnAzAqZpzg=;
 b=Wl4KSAo3oSwONuUpMYxSThdLPyLwOHViGLdmWoHGDEjTNOz6elTW8fvZMoeYQe/kIR
 ldtidHcDPmtUc2u4LoZCWp22Cjx0b3p7ZoaRot9nWge4MYVPy03aR3C/UU92wnr1UVYq
 qNnb5Azuvq7+62yLu7s+Q4MrCMuNUKORvkddhau90GKVpRsQGCrx+B+0hCSYjf3JQ0A6
 TatUFcHVfEhzoV+IUoAo+yUflT5qfgMNQiMbOzr2k7kcy7JRJeAfkutfWwEdUoEDZq1a
 i2WIbOC/lyWxNlOLTuj+Ew4mD8bxi8e5WEbbMPM8/Bv3xvIn+G//hlgl57QgEoXe/LJ0
 IMzw==
X-Gm-Message-State: AC+VfDwH1XdbqRAU0hrr/SEGyOEPEdht0Pk2vPoc9G+m8coTypi39wvk
 COgiqc+w9cggjdT8Zp+76FIdRMBqd1MVXbgLJu4=
X-Google-Smtp-Source: ACHHUZ43ko/y2jPBewjqTrR2/oli4H1Uy2YB9n58l41HwdDj9d3qcKujnVCC9TLIMpmpfIL3gUTsAQ==
X-Received: by 2002:a7b:c7cb:0:b0:3f9:b1e7:8a41 with SMTP id
 z11-20020a7bc7cb000000b003f9b1e78a41mr2284730wmk.35.1687184968573; 
 Mon, 19 Jun 2023 07:29:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/33] hw/arm/Kconfig: sbsa-ref uses Bochs display
Date: Mon, 19 Jun 2023 15:29:08 +0100
Message-Id: <20230619142914.963184-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20230607092112.655098-1-marcin.juszkiewicz@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2159de3ce65..7de17d1e8c3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -268,6 +268,7 @@ config SBSA_REF
     select PL061 # GPIO
     select USB_EHCI_SYSBUS
     select WDT_SBSA
+    select BOCHS_DISPLAY
 
 config SABRELITE
     bool
-- 
2.34.1


