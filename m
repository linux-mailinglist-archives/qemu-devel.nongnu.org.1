Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8A8165FB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 06:17:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF5zP-0007LJ-U6; Mon, 18 Dec 2023 00:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF5zB-0007Hz-LT
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 00:16:13 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF5z4-0003OB-U9
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 00:16:11 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6d089e8b1b2so1101149b3a.3
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 21:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702876565; x=1703481365;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xYQj7cyXWL0Qtnc1jkuPpdu9+gBdKiIK/mZUsUTXWpo=;
 b=bFFy6cTRQfCoMFNYDFY7k1i4Qf9PBHImAR2Hf3d/M5FRIo2t36zJjGoNnioU/gvyf2
 /eMyA8WJVHDKG7S8BYmPx71T2dOFpX4VykQiEVd9ZWREBibJ27+yCiU2X00TKWhTKOuI
 ym5GTgswv6Mx3ahSpvuDfcXrSRE3vEzhxPDdpsSCDJa+hDLdHz4xAk9XcPwOtpnWcaSb
 7u5RBgifmip+7Igur/fGfI66tWJoqOw8JFmg+c5a6TiGqAzWFv066OXHwzYrwQc6zSdL
 SixNfNlC27shxqplv+A6DwwY3nl0u+WB4I23muF73YJWogKZYIr0AZSA1O4r4WTMe34A
 2hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702876565; x=1703481365;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYQj7cyXWL0Qtnc1jkuPpdu9+gBdKiIK/mZUsUTXWpo=;
 b=DFRiWSZ0eGqdY3wAK1vWwrRfD07o12rP2m+fMVcCFOL4nzGKpLf5WmhOPmI1ZtdZIF
 aFgOnEm7x9sgQW72Qz4NokyH0yVIY1GaxXqJ6pmPrzXimUXqEe9HoFmmu0724sMp74Ed
 lN+hK5HuhG9V79QTQ7eTweLjjD0xmyqEuEZOQ1mZQ1ia8EowJNTBilHuCiWPLu7NEg7Y
 zo8Hnz4TDck8Pib9gmKMPrQHM3sNgoZ/A2O28b/80+BtmnXAHSN2WK5tI1aNZqTVvNto
 o++S+3RtbaCGHO+GbzjRYVJkZGputItGbx1X5qA9nqXkE1DYu/fPq7JKNogW31AbYcqZ
 v85w==
X-Gm-Message-State: AOJu0YxNUMiwuEZyEmoomz+alzXL3evobgDdSrXqfkZByCJo20ARCxqu
 eM3Kgy7OJgqNRBYWc1rSbenOSQ==
X-Google-Smtp-Source: AGHT+IHtf3DwjDeb56G82qYBQlEth4w/BXo6zY3FBcMnYhS3cXEUb555+S/VjDNYTPB4RVW9Rqk73g==
X-Received: by 2002:a05:6a00:2181:b0:6ce:4f97:5ada with SMTP id
 h1-20020a056a00218100b006ce4f975adamr8506824pfi.43.1702876565200; 
 Sun, 17 Dec 2023 21:16:05 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 k13-20020aa792cd000000b006ce273562fasm17222468pfa.40.2023.12.17.21.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 21:16:04 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Dec 2023 14:15:47 +0900
Subject: [PATCH v8 1/4] hw/riscv: Use misa_mxl instead of misa_mxl_max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-riscv-v8-1-c9bf2b1582d7@daynix.com>
References: <20231218-riscv-v8-0-c9bf2b1582d7@daynix.com>
In-Reply-To: <20231218-riscv-v8-0-c9bf2b1582d7@daynix.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mikhail Tyutin <m.tyutin@yadro.com>, 
 Aleksandr Anenkov <a.anenkov@yadro.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

A later commit requires one extra step to retrieve misa_mxl_max. As
misa_mxl is semantically more correct and does not need such a extra
step, refer to misa_mxl instead. Below is the explanation why misa_mxl
is more semantically correct to refer to than misa_mxl_max in this case.

Currently misa_mxl always equals to misa_mxl_max so it does not matter
which of misa_mxl or misa_mxl_max to refer to. However, it is possible
to have different values for misa_mxl and misa_mxl_max if QEMU gains a
new feature to load a RV32 kernel on a RV64 system, for example. For
such a behavior, the real system will need the firmware to switch MXL to
RV32, and if QEMU implements the same behavior, mxl will represent the
MXL that corresponds to the kernel being loaded. Therefore, it is more
appropriate to refer to mxl instead of misa_mxl_max when
misa_mxl != misa_mxl_max.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/riscv/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0ffca05189f0..bc67c0bd1890 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -36,7 +36,7 @@
 
 bool riscv_is_32bit(RISCVHartArrayState *harts)
 {
-    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
+    return harts->harts[0].env.misa_mxl == MXL_RV32;
 }
 
 /*

-- 
2.43.0


