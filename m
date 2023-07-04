Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F335674723F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:07:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfk8-0001RZ-0o; Tue, 04 Jul 2023 09:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfk5-0001Qe-QD
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:06:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfk4-0003Tl-4y
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:06:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-314172bb818so6354294f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688476010; x=1691068010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8zLjpDD0zK/WJbpqRspbFIMqr9DpD2291ImUv+z4BQM=;
 b=SggdcBinL57/rnHpmdWFILW/jf7OEbkbiEUEsENSY8xeOioXU5Ge0ci88w3n8op/Hl
 sGfz6sXajFjyENPLXJU0n27PnkjA/SzSP/N/MVf3UAn+dujavIiOJbdc1N9PWYNgP2Wo
 3M0B4nkzNrGQFSUQTy19BZTO3foRR9PxuCXSq/+RCEYzAUEPKAhPian4DulS5JXv442r
 9rzmEF/2cZj+5ViQQXsRJ+KwfT0TAlD+rcd2GBOTMYjJTctB7sQCHzPW5S7bzhmExkUQ
 HF9GuYNo7AgC/PSCt5VxGRzLrfoP1LLntiSCplcKthTAyp0GADhHxY6bQSkP2ycyqD11
 z3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476010; x=1691068010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8zLjpDD0zK/WJbpqRspbFIMqr9DpD2291ImUv+z4BQM=;
 b=V9VByxXJIK8d+2WZSnx9V3rHEeqgiRZC3vnm8mtloTWjbU9BI6A1Rq2ipZilz9AMGM
 Df9QqlBsus5WXmPTAlBdzgBPW+Ju/9gWpr794bcL2G09X6q8mUJBE5Uy8D5l5z5aalbM
 7BwCVGuC+iK11KVCHnR3ltH1u1c5XWJ/6ae5EFyMfDWPfhGXlVIyqjoDRWZfI7mbj5Bk
 9QhzeZQ1LrWohXsbHEOPAbPPBmF+4cwAHrL7bTV61MxF4Y+ttt/hAYlW9TIgvF/pI7kT
 KNndCvs6AM5WtczOykhRC3oyZiJUcepLZYOzCrTZcjbAeGGZ9vchDm5+lcb2xH3bG7Dl
 pcjw==
X-Gm-Message-State: ABy/qLb2usvDeMqG/eW6JjrNu6LHRoDhxUObfhq77ovwVKYjod0GiWZe
 xzOZz7DQVsfS3NteQ82GwT9r2w==
X-Google-Smtp-Source: APBJJlFCq/TfGM7ZlpVCMRzHq4PRNNgXvDrF56H8sdGVq5HICBBmUCjebCXCY8SpPSAszMvK3yYUxA==
X-Received: by 2002:a5d:6647:0:b0:314:362d:6d7b with SMTP id
 f7-20020a5d6647000000b00314362d6d7bmr5573655wrw.19.1688476009866; 
 Tue, 04 Jul 2023 06:06:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a10-20020adfeeca000000b00314103d6daesm15834737wrp.47.2023.07.04.06.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 06:06:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/arm: Implement Cortex Neoverse-V1
Date: Tue,  4 Jul 2023 14:06:45 +0100
Message-Id: <20230704130647.2842917-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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


This patchset implements the Cortex Neoverse-V1 CPU type, as a
representative Armv8.3 (+ some extras from 8.4) CPU matching real
hardware.  The main thing we were waiting for to be able to define
this was FEAT_LSE2, and that is now supported.

There are a few things the real hardware implements that QEMU does
not yet, which patch 1 ensures we don't advertise to the guest:

  * FEAT_TRF (Self-hosted Trace Extension)
  * Trace Macrocell system register access
  * Memory mapped trace
  * FEAT_AMU (Activity Monitors Extension)
  * FEAT_MPAM (Memory Partitioning and Monitoring Extension)
  * FEAT_NV (Nested Virtualization)

Most of these, like FEAT_SPE which we were already suppressing, are
"introspection/trace" type features which QEMU is unlikely to ever
implement.  The odd-one-out here is FEAT_NV -- we could implement
that and at some point we probably will.
                
Patch 2 then implements the CPU itself.

thanks
-- PMM

Peter Maydell (2):
  target/arm: Suppress more TCG unimplemented features in ID registers
  target/arm: Define neoverse-v1

 docs/system/arm/virt.rst |   1 +
 hw/arm/sbsa-ref.c        |   1 +
 hw/arm/virt.c            |   1 +
 target/arm/cpu.c         |  33 ++++++++--
 target/arm/tcg/cpu64.c   | 128 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 160 insertions(+), 4 deletions(-)

-- 
2.34.1


