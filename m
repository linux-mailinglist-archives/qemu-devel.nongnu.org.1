Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8D775F52
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:38:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTiRH-0002ZC-Kf; Wed, 09 Aug 2023 08:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRF-0002Xf-3G
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qTiRC-0002nm-Aw
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:37:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-314172bac25so5143703f8f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691584635; x=1692189435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/4ysh9xQ8pcgY+P8IcJ5XzhWArdi/CT5G2Y6EcaPHbo=;
 b=OpNWUhihDLHlvVr6Y0IQh7P6heQit8mh0P2tbEIX5waUneUCpbTTygJFI+Pi05/izt
 xKeuF8WjRrgSdMTYOWq46N9+Fm7DlhJypaTIeDeWYFjITpXQVh821C1xBRGPeY6/056S
 QF/vEJahEzjxAKG9mWEb0DyxCzaoH7zYtxLv5+7c0hf26JKY0K1Q7cwtKd+VAihBkLJo
 kcjfqgSNXu8lRNBK3ABrOm3tqNO3kZ12BVa7szbEttrDWYuyo4viB9xS6EwHs2e7N4EN
 MtxTasv8EyXFSrEhe60rINIiwcj0NoSzxzu3QThYsqgvFefIBtwSfg330rMDm/7jbzdu
 9ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691584635; x=1692189435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4ysh9xQ8pcgY+P8IcJ5XzhWArdi/CT5G2Y6EcaPHbo=;
 b=QHrcS5n2KRN6oXkUFlWEjjWfqsuMF07XZuWjFInncSP2LbkGuEsiL7TEV1BtqsgXAV
 NxAMs79gQNOt5j0htiUtmyw1VmkzYO1FM4UcRxsIcZWpk3BsX9gSGMsBUQ/m7FH8mEhh
 XGWVPAxt9eFAzXqCGkPLEf6WSqKkKTrs91y3wT9HkU8exbmxaqRgy/7eLVAKUbvzbsJY
 u6ax5FzjAcr3pKFFIshJDVnQ6ppUb9lup7ve9lzGRBbhm+Xt00z9WBMwS0R7L0h/aEm6
 WbBQryHvO3tCdDM7CKbKNFWVRNtlVXnDK++4zYHv4gOBhLtDphP2RZIXLycQMIOwAC1k
 LOdg==
X-Gm-Message-State: AOJu0YyBu4ojSxuJXOHhhvVJIn8WZd+Kxsv9hYonuaQuxu8kUC0bDD4P
 NPdim0GXWz/JOrPYvdYWJhxKNg==
X-Google-Smtp-Source: AGHT+IFMuDeS3V6FQT5StZdyTVkor22ZYvSEWzKgW1tF7d8NOG1H6EK3qN7vW97DJ+vbvLPRsMUiyQ==
X-Received: by 2002:adf:edd2:0:b0:317:eeaa:22cd with SMTP id
 v18-20020adfedd2000000b00317eeaa22cdmr1869460wro.37.1691584634894; 
 Wed, 09 Aug 2023 05:37:14 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a5d5246000000b00317f70240afsm5617888wrc.27.2023.08.09.05.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 05:37:14 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 0/6] target/arm: Fixes for RME
Date: Wed,  9 Aug 2023 13:37:00 +0100
Message-ID: <20230809123706.1842548-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A few patches to fix RME support and allow booting a realm guest, based
on "[PATCH v2 00/15] target/arm/ptw: Cleanups and a few bugfixes"
https://lore.kernel.org/all/20230807141514.19075-1-peter.maydell@linaro.org/

Since v2:

* Updated the comment in patch 5. I also removed the check for FEAT_RME,
  because as pointed out in "target/arm: Catch illegal-exception-return
  from EL3 with bad NSE/NS", the SCR_NSE bit can only be set with
  FEAT_RME enabled. Because of this additional change, I didn't add the
  Reviewed-by.

* Added an EL-change hook to patch 6, to update the timer IRQ
  when changing the security state. I was wondering whether the
  el_change function should filter security state changes, since we only
  need to update IRQ state when switching between Root and
  Secure/NonSecure. But with a small syscall benchmark exercising
  EL0-EL1 switch with FEAT_RME enabled, I couldn't see any difference
  with and without the el_change hook, so I kept it simple.

* Also added the .raw_write callback for CNTHCTL_EL2.

v2: https://lore.kernel.org/all/20230802170157.401491-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (6):
  target/arm/ptw: Load stage-2 tables from realm physical space
  target/arm/helper: Fix tlbmask and tlbbits for TLBI VAE2*
  target/arm: Skip granule protection checks for AT instructions
  target/arm: Pass security space rather than flag for AT instructions
  target/arm/helper: Check SCR_EL3.{NSE,NS} encoding for AT instructions
  target/arm/helper: Implement CNTHCTL_EL2.CNT[VP]MASK

 target/arm/cpu.h        |   4 +
 target/arm/internals.h  |  25 +++---
 target/arm/cpu.c        |   4 +
 target/arm/helper.c     | 184 ++++++++++++++++++++++++++++++----------
 target/arm/ptw.c        |  39 ++++++---
 target/arm/trace-events |   7 +-
 6 files changed, 188 insertions(+), 75 deletions(-)

-- 
2.41.0


