Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 816CC7DCE21
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxp3d-0000u8-NF; Tue, 31 Oct 2023 09:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxp3U-0000sn-Ao
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxp3Q-0006da-2d
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:45:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so46744115e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698759906; x=1699364706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ypz0cfC1DEOkumJW+Z/7m5C5efFoS/oHtx6ppez0zu0=;
 b=FZ4rSV0eq1dpNa8REXFgEjxCT9VswnUo5PpCR5H1O3ZarDvQI52o1mWpu8uCOH/AUF
 XGfC294z1lvUoLtB6XoFoeO+wTMN+j43chdp+PpHGWOT3h7wXFZcCJzezryhruCpmjD6
 D57L6MtiJAb4uW7hBg6pkoseZDrdSYntWgx46EKQp/ewwteY1/nkD1LELEPiu6yU0hPF
 BkSzbiSahzNFADzvuH7d3Utb+wMeGX5kOBWCY4avGyXD8DHRLnuUtktlWBsOzdr3nA6J
 pZGldqkTy/39AHJDFiSDu0H2A0PsdAHfnH36iwT10dWXOy8RM+p29ghGTxZrxkpobaCc
 l+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698759906; x=1699364706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ypz0cfC1DEOkumJW+Z/7m5C5efFoS/oHtx6ppez0zu0=;
 b=f3B4md1QlBN8JGwqFb3PheMgDTKaFsMOIyMQc4DhjrZ7Bv8NFNX1t3f1C12IiVbC6Y
 +G4zEdCjQZ7xDWcApJ2V47huKWKgAjbSwOq9b772F6DBcP1f7rFlFuDEGqK0exlI6e41
 G+i0uw1iTK6D3tpdjoVdJqflmtB9FQJnk5p+tQ/sqJYc44+Q002euoWXEPRL7is3Knq0
 8x0uMRIhj8I6J0o2OAh6MtiORAn0CA+bbeUV6wXuljwbP5cF2Qi7Y2JBX3uZV04ML3RY
 n/6eFC5BKQPIJijOXMBijl5wSBk5SgCAdFUKLGnesDq+YpeAtZMN/QADt3eROgjH3xnV
 PHLA==
X-Gm-Message-State: AOJu0Yx1sAREVNiK1wC+b/5Hgu36XxCnR8aK4xoJK2FFtRZ9EBsADV3H
 BbnT9HRXkhsuoxsIRZIvIg+SVw==
X-Google-Smtp-Source: AGHT+IESsohjK59mSumb64Us03ddWdW9yz1MXu5XQdJ6tCKOpbf7Tk+lQtUGPFI/PbYtP38xArMD9A==
X-Received: by 2002:a05:600c:20c:b0:409:4823:57d7 with SMTP id
 12-20020a05600c020c00b00409482357d7mr3516088wmi.14.1698759906599; 
 Tue, 31 Oct 2023 06:45:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004068de50c64sm1754989wmm.46.2023.10.31.06.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:45:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>
Subject: [PATCH v2 0/3] virt: Report UART correctly in ACPI DBG2/SPCR
Date: Tue, 31 Oct 2023 13:45:02 +0000
Message-Id: <20231031134505.4110877-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

This patchseries is Udo's patch, plus the necessary extra patches
that update the golden-reference files for bios-tables-test so that
'make check' continues to pass. I'm sending these to the list for
completeness, mostly: review is of course welcome but I plan to put
these into target-arm.next fairly soon.

Patch 2 has already been reviewed.

thanks
-- PMM

Peter Maydell (2):
  tests/qtest/bios-tables-test: Allow changes to virt SPCR and DBG2
  tests/qtest/bios-tables-test: Update virt SPCR and DBG2 golden
    references

Udo Steinberg (1):
  hw/arm/virt: Report correct register sizes in ACPI DBG2/SPCR tables.

 hw/arm/virt-acpi-build.c  |   4 ++--
 tests/data/acpi/virt/DBG2 | Bin 87 -> 87 bytes
 tests/data/acpi/virt/SPCR | Bin 80 -> 80 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


