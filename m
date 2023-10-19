Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF67CFB48
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCd-0002y9-E2; Thu, 19 Oct 2023 09:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBn-0001rN-HG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBf-0001Ce-Go
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083f613275so12850515e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722542; x=1698327342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=980RYNOEtgl+U05wTxrGNkJ8Z29zZamfuIhgBMTwwfM=;
 b=gR1FPoc4Hzz5pBMKYXN2wvfpXRCmnYJjkckJyzN+0YMKk3TDxysTLQT8vK6SPTGSmn
 //zw2GdHpChLVTuU2EpZSEdZIcG47Ms+YVRO7biQGkCcxpZbYeDc6kVtttTEI1E6tMV0
 g41w0pipkUdlmmyjxlhgeCSIUgWPbRVHYMBLOyY/UUObXSVYbUFQO4PME9jcdwXfEL35
 Jz5oVu9ZKHCrGqBaLwEtc6Wb5Izo8lXvZgvzTEo7NY0ohCNY19FZD9U0sME51WJl4xEC
 Ya0LLuTipN4F2yU7nY9iXtJOvhFKBe+v4y5tQMw8WCjAF21A+3Rmrwg98ua4/UxBqqMT
 izQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722542; x=1698327342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=980RYNOEtgl+U05wTxrGNkJ8Z29zZamfuIhgBMTwwfM=;
 b=eZX9yxOrUph12TKwy0NMoaUiCkbP6zIimIuAZ3rjqZ+4tAGiVpoaxVfTDkeStx7RSJ
 +JDdSHXoxcvDiRqB7LfJ5lAuf1zmjCXjJhZFk4RxqTy8A21/RmpOypz8LhH1DHXMx0qy
 FEK3G7WAMFVR/prgEPcBhWOnS6e1TxkMIEKndcm2KdKcf0f79JmJXYzjznVQ7VEqndCu
 /iEpVOGN9wME+iwu02OlKi1e0JKL0Bs7tz2U/5v9DXmWksybrVj9Vy/K64bac8RUstrM
 iFRXBzg7ThNC9hJmwCa+0ME9CSC/xfhOOyF8/5Dnhj690/HSQ3i/FvQVDnEI52iNMSOs
 dmeg==
X-Gm-Message-State: AOJu0YwMebw4mup9U17Qe64Ge4FdbOSbTICKmEaZsYzolNq8hoQggkWR
 OmENRod2N6EV9CA/IubTytXTGyOxW5kMQjss/vY=
X-Google-Smtp-Source: AGHT+IFfa13mXzWw2tw8TeITPDadRYhul7ygs5Bw0CXJ0waRWSMDulToG33a19XZKgsik0unxnJQUQ==
X-Received: by 2002:a05:600c:1e11:b0:405:5ffd:21d2 with SMTP id
 ay17-20020a05600c1e1100b004055ffd21d2mr1954010wmb.19.1697722541933; 
 Thu, 19 Oct 2023 06:35:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/24] xlnx-bbram: hw/nvram: Use dot in device type name
Date: Thu, 19 Oct 2023 14:35:19 +0100
Message-Id: <20231019133537.2114929-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tong Ho <tong.ho@amd.com>

This replaces the comma (,) to dot (.) in the device type name
so the name can be used with the 'driver=' command line option.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20231003052139.199665-1-tong.ho@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/nvram/xlnx-bbram.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index 87d59ef3c0c..6fc13f8cc17 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -34,7 +34,7 @@
 
 #define RMAX_XLNX_BBRAM ((0x4c / 4) + 1)
 
-#define TYPE_XLNX_BBRAM "xlnx,bbram-ctrl"
+#define TYPE_XLNX_BBRAM "xlnx.bbram-ctrl"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxBBRam, XLNX_BBRAM);
 
 struct XlnxBBRam {
-- 
2.34.1


