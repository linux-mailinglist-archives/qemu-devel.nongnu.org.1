Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 434ED7EA250
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:47:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b1V-00078k-4D; Mon, 13 Nov 2023 12:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1G-0006wt-EZ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:44 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1D-0003Jj-K9
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so37260275e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699897597; x=1700502397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=EkpvYAF7gTkD8B8NBwDgYc9FjhctrZCHwJUodKCn85Q=;
 b=fpyipvkCuyrcdLGw53hVZmIj1+RQhCz2j3Zq+BI2C696kT1pPAqH0GkAVrILEG6p9K
 pniQtS0dcWDT1RrXvV7YKNUlEXswnwyQbzIUDYitZa/N85NLrZXRzL2Yi/2/jf0iM7cr
 8P/3u+bJdMQDw3D1tVYvnXVBqrpf1oUapkNhFkmOX7BbbATxDfLPvYPMNSTRXVLSzSta
 GeMCDdjL/2gfCNgkAz5seXDcH1Iz4u8RUwE5Y87Cp5SBo3RDKwijnH0+mpk3qwMF1wK+
 y4+lrxDXDFC2sJv3OrZyxNQvXGZ8laQMeb1yrFA7cL+1fbDulsKMFModEd1jmMxgFciN
 /DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897597; x=1700502397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EkpvYAF7gTkD8B8NBwDgYc9FjhctrZCHwJUodKCn85Q=;
 b=JPkMvopyzVWINaj7VVEBm8XsIsSoRZKsuFBEcfQoNg7tzFrIAndjiJdEkDg6LlY+LU
 33STdBbcvZevXBQFIN2vP873/wOMPTAU+y7ImKW5k/Px8LhrkHnu3Npy8hdlfvKANotU
 mhXYG7xV69Vve1Fc7P028C2Wlk7JUFECeIFBOAfqp0DOJ4B7a5Io0GaY8Wl91WICRPR3
 WnujoDA73LqfkSoVMNsoPNoBrx9Opryye4vM9Uf7BaNH75JN5GOLaMJvGqcIeqZRpx2j
 81t/n8WNhZPO8OqrvSgVOjp6f8pYkwXetM2/Y3uoZotAonalf8nVh218VH7LdSeZIRhV
 O/4w==
X-Gm-Message-State: AOJu0YwfQD7jZM/Xu+obCDalMem5ee6/YWu+1eVbnpLhgm/L9uSB4z+k
 6WOGa6A436IaoH/w3JNSL+/fZpwx5DL8JoJSIxY=
X-Google-Smtp-Source: AGHT+IGvUEZw3SkXKEe9MPb0BpPnWzj0Pp8nH4cojrjmCyJLV9JjPKLXWcknadr5VCAl//WlPoNydw==
X-Received: by 2002:a05:600c:524e:b0:406:53aa:7a5f with SMTP id
 fc14-20020a05600c524e00b0040653aa7a5fmr6345693wmb.10.1699897597205; 
 Mon, 13 Nov 2023 09:46:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c22c800b0040303a9965asm14391110wmg.40.2023.11.13.09.46.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:46:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] target-arm queue
Date: Mon, 13 Nov 2023 17:46:31 +0000
Message-Id: <20231113174635.2540484-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Hi; here are a handful of small bug fixes for Arm guests for rc0.

thanks
-- PMM

The following changes since commit 69680740eafa1838527c90155a7432d51b8ff203:

  Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into staging (2023-11-11 11:23:25 +0800)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20231113

for you to fetch changes up to f6e8d1ef05a126de796ae03dd81e048e3ff48ff1:

  target/arm/tcg: enable PMU feature for Cortex-A8 and A9 (2023-11-13 16:31:41 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/virt: fix GIC maintenance IRQ registration
 * target/arm: HVC at EL3 should go to EL3, not EL2
 * target/arm: Correct MTE tag checking for reverse-copy MOPS
 * target/arm/tcg: enable PMU feature for Cortex-A8 and A9

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      hw/arm/virt: fix GIC maintenance IRQ registration

Nikita Ostrenkov (1):
      target/arm/tcg: enable PMU feature for Cortex-A8 and A9

Peter Maydell (2):
      target/arm: HVC at EL3 should go to EL3, not EL2
      target/arm: Correct MTE tag checking for reverse-copy MOPS

 hw/arm/virt.c                  |  6 ++++--
 target/arm/tcg/cpu32.c         |  2 ++
 target/arm/tcg/mte_helper.c    | 12 ++++++++++--
 target/arm/tcg/translate-a64.c |  4 +++-
 4 files changed, 19 insertions(+), 5 deletions(-)

