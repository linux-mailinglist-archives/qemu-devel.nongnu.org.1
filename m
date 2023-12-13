Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C681096A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 06:21:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDHey-0003Kk-MF; Wed, 13 Dec 2023 00:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDHew-0003KQ-Rf
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 00:19:50 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDHev-0002XO-G3
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 00:19:50 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d345b187bbso9686525ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 21:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702444788; x=1703049588;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=caaD9uJR8zKkQ5sN9Nz1V/05Ns/HBdasuDc37tyWikU=;
 b=3cu51oJ5rCSfwBkbvNOK64PH9I1KdFbGM4PpJhd4IQvVuYWIe5MBlXebcjHTMsLaVz
 PUJFI+WxAXfrSaXrDiquHUzrCURzIYEvgaZ51tp56wNBj99p6VgpoB1Jdw22JJMyjq1x
 RYCjaxZnpPUv8oQvvHd3TXVOEge4WOxFwXTmr0STLm41Zs2YTC5S+2tn+KDZmpmNXqqG
 wvWUTFmZLHX0RMz87qZjAtJGCqudust4s5ONnvuOPC8jqQyk9A6iME+7t7/ZZCk0tjnh
 mYZbcrAyIMcQ5GxoLQFASf09a1diwUwQ9hmQD6OPO4Qxt1WqYFZLqr/dErJoKe6Xg7qA
 r6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702444788; x=1703049588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=caaD9uJR8zKkQ5sN9Nz1V/05Ns/HBdasuDc37tyWikU=;
 b=wo2q7mmU2EYeSsBxrQw1PQxnopy3stVyyu1mQyWsPpSQ31RQnfDdET346SrCkjddiF
 dNxnSe2NNxINKXJoNSFkhmMEHwP8OPpeJmYEI6sJ2dlPA/hG7I+qaOuOH8zF1d+etPWF
 hipCqcsAZWUzVMNZXf46HbaBIP0AnNS3ATOYEGdcQ+d3HcYNyj3IIEg7BWUc43bHEHqV
 gQd9fLRRX7Ii6bYDMBk9bttbNwB/fOB8dPA7M5g6LPCFWFAIWlqpn/P82wSnnAj0Nbx5
 Xf/xwm8OddafHadIaMG+9zjVPCuX0aUl/txTvkXdSzpYlEAaLziGMcmNpQWSbUSEXWET
 mXtA==
X-Gm-Message-State: AOJu0Yw8/ULIq8wZ9euz1tKub/9qod2xusm/v9G0UdtTD5gH4HNEZUrV
 xxwp6/VIER915iLvHYZc2G8LOg==
X-Google-Smtp-Source: AGHT+IGEkAgT0W6ppjv/XchelR8Qn6b2gsdHlRgLm2jsc8wS1HDxswH+bEHVgI5C3q3OgCuoaGZG7g==
X-Received: by 2002:a17:902:d58b:b0:1d0:4be4:8dcc with SMTP id
 k11-20020a170902d58b00b001d04be48dccmr9483150plh.9.1702444788130; 
 Tue, 12 Dec 2023 21:19:48 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 ix4-20020a170902f80400b001d34126d64dsm1699212plb.222.2023.12.12.21.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 21:19:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 13 Dec 2023 14:19:29 +0900
Subject: [PATCH v7 1/4] hw/riscv: Use misa_mxl instead of misa_mxl_max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-riscv-v7-1-a760156a337f@daynix.com>
References: <20231213-riscv-v7-0-a760156a337f@daynix.com>
In-Reply-To: <20231213-riscv-v7-0-a760156a337f@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The effective MXL value matters when booting.

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


