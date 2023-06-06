Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD05723FFB
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:47:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6UCg-00015Y-KT; Tue, 06 Jun 2023 06:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6UCd-00013F-NY
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:46:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6UCa-0008Eb-Ee
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:46:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6ffc2b314so50667155e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686048370; x=1688640370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dEjhODPeDspd2DTqfRmFTcsDtUp7wwGuYHP+us8ZLc4=;
 b=UE1c8UmfWUn/F3K6bLFmOiaJFaQAJoW8XJLeeqSFHYzyY955kvFQ22eRmeJBWPvE/q
 97myvl27q0Ax8yR9fPG029UYR4CgQAVktIfIGGUS3UNIqHceFBwWjE9EwXJhISIKC9If
 NVa0SWkS5HNXFwknl7HvbiX4Dzc973L1gmn8PBC1M+CSoU6RGoPt74YLq5i/JBmwi62a
 FdeVUNfRbcIXgzA8Im/IO7+W0dqGD4aDWQSHeoywYROTI++T/ZRr9INnlrVSWs1oU0o2
 ofSdDlqjoKiy19jIjll/YxGiGUWghLp3zr+pcVmUVzRIduX59qlmRCYaIkLbNY7519qn
 cDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686048370; x=1688640370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEjhODPeDspd2DTqfRmFTcsDtUp7wwGuYHP+us8ZLc4=;
 b=C/MFrTt3IlIgc3wss5RV+in75c6AxswHDt1Q4E+VBIHoVtP8RpEOZ2yDWzGCuZ+sfB
 5V1XBh/rLtleJIcdQjep2cIoCsPWKnUfG5vYBoCjjCfuDkAEagziXvX/h5R9jw1jaoVW
 oFEJrLL1/lrYOJXa40ctQamQh9qT4Z2mg8PZWwUgQlbCL629IfE39tSh2ubdcOk+zdn3
 gqb3LKK/KIO7BJlZJYEIK1fsaCvhpLKqBoMNUjvNufo6u/iFWizZpQqSsLDwQVOie2/N
 m8HjG6bSS923JFCxqnvp4ImMBefiU4bD+Vw1OBh9b6/mXYplTZ89HWEf4VUOfssj7Vrr
 en6g==
X-Gm-Message-State: AC+VfDwOW7LxqQ23QHOnBOYOGVBCRVAKIKqQVcCwKvRZSOQ8FPb0dg4e
 qSx2YXTiOFCxMpDBgZOxV0nKlA==
X-Google-Smtp-Source: ACHHUZ6ounoGeQYJeLPfNR86aBfpt4L/rfd4PQVX5EkMrkzpktZlfnuW+foMqfBoWbhWQkEEukW9iA==
X-Received: by 2002:a05:600c:220f:b0:3f7:395d:6585 with SMTP id
 z15-20020a05600c220f00b003f7395d6585mr5572012wml.15.1686048370657; 
 Tue, 06 Jun 2023 03:46:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f7298a32ccsm12195508wma.41.2023.06.06.03.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 03:46:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 0/2] allwinner-a10: Fix interrupt controller regression
Date: Tue,  6 Jun 2023 11:46:07 +0100
Message-Id: <20230606104609.3692557-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In commit 2c5fa0778c3b430 we fixed an endianness bug in the Allwinner
A10 PIC model; however in the process we introduced a regression.
This is because the old code was robust against the incoming 'level'
argument being something other than 0 or 1, whereas the new code was
not.

In particular, the allwinner-sdhost code treats its IRQ line as
0-vs-non-0 rather than 0-vs-1, so when the SD controller set its IRQ
line for any reason other than transmit the interrupt controller would
ignore it. The observed effect was a guest timeout when rebooting the
guest kernel.

Patch 1 in this series fixes the regression by restoring the
old behaviour of aw_a10_pic_set_irq() for non-0 levels; it
is stable material.

Patch 2 changes the SD controller to follow our usual convention that
simple IRQ lines only send 0 or 1; this isn't strictly necessary with
patch 1, but it avoids future surprises. It doesn't need to go to
stable.

thanks
-- PMM

Peter Maydell (2):
  hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1
  hw/sd/allwinner-sdhost: Don't send non-boolean IRQ line levels

 hw/intc/allwinner-a10-pic.c | 2 +-
 hw/sd/allwinner-sdhost.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


