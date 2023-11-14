Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A177EB6E0
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 20:27:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2z3w-0003tV-EE; Tue, 14 Nov 2023 14:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2z3t-0003sQ-Mp
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:27:01 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2z3r-00070I-Vs
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:27:01 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ce3084c2d1so17085605ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699990018; x=1700594818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=77AcxJkwSrsL4rudUttNUWrE+nrDbI9gsLqvLvpxgL0=;
 b=Ziy9gxqdhuHGnzaDOAa1TMymCspNEV2aNODfNO02nnDFGeZUduU5hC7ZXTjSgbdVGK
 g3eB7IPhU2tR/3PzeQWhi2qwpMv4JaJ909zX7wJWSntq5IPUuPWRo3huHPPTMOxOI48/
 49CxRbtjeXsji5ZHZRJxbZuL1C38fvq7yDgvpG7qgnFQXJAY21QmNuG+7AukPWjzgmI9
 Wiw9LQfGaWN253h7D7yIIBMV9f0tcZ4soss+Iy7ykMUCKtAc97Hos6kRcYwuiRVIAvVR
 DV3MiAtwNBFnWT0dTFOU1ttp+E+vNPvn5/T5USMXQFd3SZfEgUfCSwICRK31M4IkmM39
 cs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699990018; x=1700594818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77AcxJkwSrsL4rudUttNUWrE+nrDbI9gsLqvLvpxgL0=;
 b=qxKfE7G4k/LaTtAkp74GxQZwhK5nYcDG2jhev/VtnNv+ihPzPWQyLYCtIhPESvGgQM
 NHyZX5+vBKGVbTkVWf28GxFTRkB/Ak6mOC84pMmGRYTKuosN/pKAzz58ddaf6SCLYlEh
 RsdvzhMzeZpfns4cfHvQEy/57iGoXnHmIWzn2HNl0Zmtjp7AI5Va3dmPXA9mzY0ou5Dh
 ROFyUD7cFr5Up77X7YsSWl/M2AJMln+MPuggMnM71Fbg1eydTmZRr6HkyHhADPVyF4yY
 y31uGpraw+KMFiXbJsJiDRDVb148I00Y7XOcQFQ1mbXpHmcg2JaygS5WYfBKtwHzwY38
 /TyA==
X-Gm-Message-State: AOJu0YzdDtF1vNzfemf0iVQr9hONexlFDCAeAh24YPbS9oEJ2n5EeqzB
 JEqmyC4vHnkIYDMuUXJKQCscTbtwpmnK9l5mD/4=
X-Google-Smtp-Source: AGHT+IGGw4QgTzrRpVVocBUxVL+kP+GPuwo2Cmcy4jovHJpayIDk99ld14uAvbuB52rWDYVduV0Jow==
X-Received: by 2002:a17:903:ca:b0:1cc:f064:8d6a with SMTP id
 x10-20020a17090300ca00b001ccf0648d6amr2952113plc.5.1699990017995; 
 Tue, 14 Nov 2023 11:26:57 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j18-20020a170902c3d200b001c728609574sm6052643plj.6.2023.11.14.11.26.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 11:26:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] tcg+sparc patch queue
Date: Tue, 14 Nov 2023 11:26:53 -0800
Message-Id: <20231114192656.176451-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

The following changes since commit 6d44474b3b47af21c7b01f3ad781373f1a6a2d78:

  Merge tag 'pull-request-2023-11-14' of https://gitlab.com/thuth/qemu into staging (2023-11-14 10:50:22 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231114

for you to fetch changes up to 0dfae4f94813995c365bfabac22cba1cea8758bd:

  target/sparc: Fix RETURN (2023-11-14 10:40:54 -0800)

----------------------------------------------------------------
accel/tcg: Forward probe size on to notdirty_write
accel/tcg: Remove CF_LAST_IO
target/sparc: Fix RETURN

----------------------------------------------------------------
Jessica Clarke (1):
      accel/tcg: Forward probe size on to notdirty_write

Richard Henderson (2):
      accel/tcg: Remove CF_LAST_IO
      target/sparc: Fix RETURN

 docs/devel/tcg-icount.rst        |  6 ------
 include/exec/translation-block.h | 13 ++++++-------
 accel/tcg/cpu-exec.c             |  2 +-
 accel/tcg/cputlb.c               | 11 +++++++----
 accel/tcg/tb-maint.c             |  6 ++----
 accel/tcg/translate-all.c        |  4 ++--
 accel/tcg/translator.c           | 22 +++++++++-------------
 system/watchpoint.c              |  6 ++----
 target/sparc/translate.c         |  2 +-
 9 files changed, 30 insertions(+), 42 deletions(-)

