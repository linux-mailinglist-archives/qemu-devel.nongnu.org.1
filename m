Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF627DBF3A
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:41:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxWFI-0000W2-0C; Mon, 30 Oct 2023 13:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxWFD-0000TB-Pq
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:40:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxWFB-0000B1-Ti
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:40:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32f7c80ab33so1415169f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698687603; x=1699292403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JSidavZgzvowrW64VxdmqiVfrHkIfq+Vecol2GK2W74=;
 b=GS941/U84ca5QNuXttulTNHJVQCU8M32h23t98XjSy4DFMVzB2gteisZA5pXzBFkPC
 fjhHr43WfrzpYnhHkJJL9zc/0q7AUNDiBD56BO1kMqTuGFj6hTmDK5XT9h8wynczVVRG
 MET/hagWB3ZJlA7TsOLmZyLpQQsIa3k4Lcyw9ZYZkgwB3zQ35/Oe4p8sSUhw7AfdZZ3s
 5yYDpcPUxfdlNXrrS+JwjVrg2i32mZT3dkee8e8Eat/BPD9JV2N+Wm/Lb/Pwrcm/kHaU
 AE4NDl3fnSvs++3sHzXJ3ZysPbt/OkQhog2K33Ty9B91GcfDRhMSWrWk0n9EkyM+62ke
 1IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698687603; x=1699292403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JSidavZgzvowrW64VxdmqiVfrHkIfq+Vecol2GK2W74=;
 b=qcb+1Fxp7V2gTRNg9kRMDixVL5Jh1pU+ymtucncWSN36uctRhLwZUc+ASVRbU+wJZU
 oMEEDvxwdamtsXy3ZcEzPX04l1ecdYWi6u5RmZ9jRUSyu+4CPWxOpRb/eevpg2ztZN77
 v905qzycp0ZaliKxAMjvvOcCZkkVjYQXZaJyJhP3bf6fV3MwchaP9aKFSxwutEPv9gBz
 WFQlDiLu22gPX7ezS5vimjs+d53QE5FEsWSsVYGBiRDjjW+BcC4kel1ol40Y5FfnjfhK
 aGVbHc70x7rT/3nyp+upLBAT4ruqn5uF5rl0TKMhPQpro3zJnkAufbYiKZ519OarsbSC
 KyPg==
X-Gm-Message-State: AOJu0YzBrEuR889OUMJq/0TixK+AAd3sb792LBZ0WnWHOa5IqSFYFdXj
 fi2ngb4rLxHye3RNHchBRFfb7w==
X-Google-Smtp-Source: AGHT+IEH2rw0DroVelHo2w3J06rXdFfanh74KhWq73EFf4bGKBI/zdLB5Ml5cTo0NMD77AiabmDlyA==
X-Received: by 2002:a05:6000:1562:b0:32d:a01a:9573 with SMTP id
 2-20020a056000156200b0032da01a9573mr9358538wrz.8.1698687603097; 
 Mon, 30 Oct 2023 10:40:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a5d5950000000b0032f7d1e2c7csm5912914wri.95.2023.10.30.10.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 10:40:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Fix various FEAT_MOPS bugs
Date: Mon, 30 Oct 2023 17:39:57 +0000
Message-Id: <20231030174000.3792225-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

This patchset fixes some bugs in FEAT_MOPS that were encountered
by somebody trying to use it in qemu user-mode:
 * we forgot to set the SCTLR bit in CPU reset, so all the
   insns UNDEF
 * we weren't reporting the hwcap bit because of a uint32_t
   vs uint64_t mixup
 * we didn't handle the case of SET* with Xs == XZR correctly

This set of patches fix these issues.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Enable FEAT_MOPS insns in user-mode emulation
  linux-user: Report AArch64 hwcap2 fields above bit 31
  target/arm: Make FEAT_MOPS SET* insns handle Xs == XZR correctly

 linux-user/loader.h         |  2 +-
 linux-user/elfload.c        |  8 ++++----
 target/arm/cpu.c            |  2 ++
 target/arm/tcg/helper-a64.c | 15 ++++++++++++---
 4 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.34.1


