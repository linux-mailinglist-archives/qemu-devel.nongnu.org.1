Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B382F132
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:15:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7Q-0006kZ-9c; Tue, 16 Jan 2024 10:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7K-0006gQ-Nw
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:42 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7H-0005sI-Fe
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:42 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e6f652eb8so31588215e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417958; x=1706022758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NvpufcK0hHOLVmcnnY2pYEiueg1e1Oqxnoqne95QDFw=;
 b=ge4DKUyq6P0gl1yiZPc7S2bhR2L3+y3R8jfu/Bgb9tCXF1e0t3lLsAjmcIGrCVRdHl
 6sIIpngUM4C4a+S7v8arfM4pyoQ27wK4J9CBI52ETxDK/aQJgLCYhnUgFs5hFhlNNr2h
 rF+KSgvNqkctAvI0/xCRXVtX/gazPwl+QWS4m6vao3OdHhl8M+H7AAUWDsIF3T4qzugf
 L9WEE7URR8Q8xkhrK1wuRS/UHAz+dUGiW7tetJ1nuJt1e4vb/7CD7SrYeF3AU+nRaAWw
 HWgoKIyIOzfIuO9dEcgxTFgNVY2zpAhqJzWFjv3FSXYDhC1fiMrtGl511u2KvopZlHWq
 ksog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417958; x=1706022758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvpufcK0hHOLVmcnnY2pYEiueg1e1Oqxnoqne95QDFw=;
 b=uo1vuYGWNAffAp+m2mC1WrrcThxq1iM4aCW5/FcnmmZ/un7knkwmfneYxE8TPS2C6d
 07Q30zWkn1GPSsQ50jf7N80OfGYElAZPXf4Yrsgl8wIATkQg9tXAbGMaLHYRXPT8uy1C
 076EFkVORY4xchaXnaIWh0MQTghcUBHeoCtljNfCMavlPjKWWAN6vW/t1i+wEyDTrynh
 1xGeS4IrhLItj3xB20QtcGI+k+LjXkqq/kQafk+roOSYCJFJXGYUATB15rsYgR/XFf/g
 Os0NppHnXPSIvG2XImlwpl+zblWCUQevQkQZT24ee9DeoszT0ECz4FOw1eqnsnB5B5wb
 N+5w==
X-Gm-Message-State: AOJu0Yzsik02qMTJG/OE7n2wjQdcNqTOpG8Vpit8N7Oz/S16OIGLHZpZ
 tDoccRxAmUhchlCQgVOBkauhhTJr+tFwXF1mX+NEI5RkqIc=
X-Google-Smtp-Source: AGHT+IHYnwinNGny/aXvQvq4ONwfv2QLd42arRMlJOknk/HQycYAveBYBXlTdCpUREzzs1bnPvX1Cw==
X-Received: by 2002:a1c:7c02:0:b0:40e:6f2c:8840 with SMTP id
 x2-20020a1c7c02000000b0040e6f2c8840mr2594056wmc.203.1705417958206; 
 Tue, 16 Jan 2024 07:12:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/21] load_elf: fix iterator's type for elf file processing
Date: Tue, 16 Jan 2024 15:12:28 +0000
Message-Id: <20240116151228.2430754-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Anastasia Belova <abelova@astralinux.ru>

j is used while loading an ELF file to byteswap segments'
data. If data is larger than 2GB an overflow may happen.
So j should be elf_word.

This commit fixes a minor bug: it's unlikely anybody is trying to
load ELF files with 2GB+ segments for wrong-endianness targets,
but if they did, it wouldn't work correctly.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: 7ef295ea5b ("loader: Add data swap option to load-elf")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/elf_ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 0a5c258fe68..9c35d1b9da6 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -500,7 +500,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             }
 
             if (data_swab) {
-                int j;
+                elf_word j;
                 for (j = 0; j < file_size; j += (1 << data_swab)) {
                     uint8_t *dp = data + j;
                     switch (data_swab) {
-- 
2.34.1


