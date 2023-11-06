Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE767E28C6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01bA-00007t-E4; Mon, 06 Nov 2023 10:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01b2-00087m-J7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:33:01 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01ak-0004NP-3E
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:58 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32fdc5be26dso240888f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284760; x=1699889560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=96tTRZzTo5lzHBefnnTujQF6PrCnnI8GATKXvxfKeEQ=;
 b=zWqjR1ddkhTIGwIvRagN2yOwjg1ceqpktgrmNN6Ua6PNIiO28QrC45AGHO/LdrzS81
 8SmV2elE5/WX0Fs10+LSyMQtnp/3BA3Gfx+hgSTSMeBtz/UGxvKpfjxWV50+Zs1Q+0Tl
 8a7cf/jANjo2KxDVPmvJtWw9zulo4zgsS0SiwzW4jgVkPcXsQx6CuQ3d2nZP2UA+FPrh
 oOa+LlbtLo5tA43ho9x2STjtW5Do1PYqJ5QWtc5LhwcFlDmEhJL9cqcsHVPgPlZ7/y9b
 pUlHM9xfOP2qqKyo3Jc8TjodnQRr/xVtT3GNlWyfW8zNtkmOB2cGeFjaDux+frgNVv0W
 9ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284760; x=1699889560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96tTRZzTo5lzHBefnnTujQF6PrCnnI8GATKXvxfKeEQ=;
 b=dlPlZrzDu50zSelw0KjCqI1k2pK+o1spKgnhv615M6tQvgXrjd4R8jrr4LDyJpq9DR
 mCPbGnc54oLJIH9u0kjD/vukUqN3RiUBtx2YXP4BGzouuEuliI3kfaVTjshUGPEhiekW
 DWMoPP+eG6W0lA2BSPVlXWzEg9rOLC6NJXfFYSLx0E9xNV3K1BYCxNxEYpGCib0qw6wY
 XxxWMS9Sy49ZYAksAafgP/7JUaXNNUkPsluNVJc9XndmVRtG5h6w3eLptBTAGjrjrBXd
 9djMQDFWI4ppz3UJ3NXadux3vFbLPX/P2h2q3b34PJ/PA/ul15tlKvNWZZc5rZk+8IR6
 ov1A==
X-Gm-Message-State: AOJu0Yx9ZI6/S4fl8Im5gvNqJ+PbOCBuFdPkn40dSJtkXdBTfcK3MQ1N
 PSm4gujjbEICPjJC4dKiv21WIyDQfa5v84qG/Ek=
X-Google-Smtp-Source: AGHT+IHPmlUuxICiAlHqKqrmW+5a8ZkaEN0/HJVPPXo7rZyZLxGpI7vsw0sE2E2Sxo6NiNFXhJ7VIw==
X-Received: by 2002:a5d:4a0c:0:b0:32d:a3ee:6f73 with SMTP id
 m12-20020a5d4a0c000000b0032da3ee6f73mr21204628wrq.42.1699284760088; 
 Mon, 06 Nov 2023 07:32:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] tests/qtest/bios-tables-test: Allow changes to virt SPCR
 and DBG2
Date: Mon,  6 Nov 2023 15:32:28 +0000
Message-Id: <20231106153238.1426649-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Allow changes to the virt board SPCR and DBG2 -- we are going to fix
an error in the UART descriptions there.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..6673e2c4c13 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/SPCR",
+"tests/data/acpi/virt/DBG2",
-- 
2.34.1


