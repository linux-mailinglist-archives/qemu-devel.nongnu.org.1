Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F27AE736C2D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:45:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaik-0001Qu-Bf; Tue, 20 Jun 2023 08:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaii-0001Q7-KX
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:28 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaid-0001pF-Si
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:27 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f865f0e16cso4163790e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265060; x=1689857060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wIUKd8nUjdD19hY+EPgAAtsoE5P7UXxO7bd73Rrx3zU=;
 b=sMj2dYNBisA7Vqn0mMqh7lF8Y0A0/c1KKORk/CGbzz+UBu1gUVRSletrAsRBHLugW2
 Spz66tKtzTrhXG2bcN3v2ISg36snB1oMHwYKKMbzvIpazCnggtEx/fX+jpQ6CeS8zsEB
 x1Uw6rS/W7IPah2ILuQVfU8tZOVbw+JJv4nZPeInbAJD9MH2UF5cT8XtQKSHVDvoku6E
 8yHnnixXKq6y9wGApXq6cmFbM98Pn0+muV2BTgao8NerpudY57x6bLe42+yBcJKa2h1X
 urBQdVBUAjRVMVA1HdcjHkCbNtiiix4EHEzUeAm5xGml9OJaM13fLu3pS5x6mQVSERBX
 OnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265060; x=1689857060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIUKd8nUjdD19hY+EPgAAtsoE5P7UXxO7bd73Rrx3zU=;
 b=PghvQntsUFG32xrUatVKHqFzSkbu8Dzc1rKszXUolBKkrrYsrQwYnjFUGmd9jp9t8v
 iLifEbtObK/DRfOvov63ReB1Fhog4zTsEaaVzIhkqUQYnxYK/DXkFd6n3Aa7/ZwK0zG7
 ZBu42hWxn7GMQRLUjG68RqHxrAaUCZfPPOIzfPMBBTh4Kz1l5GCA4OGFM4xOVHrpJYwZ
 CZ4pywqdK9D4F6MliAeXjxWlAUPpoxAw6fzaCfoi/w0qs5vDg/kQGKOLcahBymlK6Ncy
 iBfF9W5hDHrewNUte7lXyaqpQa3xuzePeyUYgFWDzpPygjzqa6/cYqN148zazxWxzdyG
 AT3w==
X-Gm-Message-State: AC+VfDwHPOGtAcHEZVhhQ64S8LOpEsWSpeNRBojGKo0QfR8oTqn8lD4j
 jsZtI6MVBTH1KR7+ez7eAdy/UUCy8YvY2c6ioDSPyGCz
X-Google-Smtp-Source: ACHHUZ6H8jClhlff4Ur/FfpC2UDZH0wwh9Ev0STae6nrYun88m26soBTF1hAUucUAPyMn/1t8ELJQw==
X-Received: by 2002:a19:641e:0:b0:4f9:556b:93c5 with SMTP id
 y30-20020a19641e000000b004f9556b93c5mr750333lfb.40.1687265060570; 
 Tue, 20 Jun 2023 05:44:20 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 00/20] target/arm: Implement FEAT_RME
Date: Tue, 20 Jun 2023 14:43:58 +0200
Message-Id: <20230620124418.805717-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
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

Changes for v5:
  * Enabled only by cpu property x-rme=on, not -cpu max.
  * Rebase vs SecEL2 fixes, now in master.

This doesn't have the magic RMM memory, which previous patch sets
included for booting Huawei's forked TF-A.  Upstream TF-A does not
have sufficient code to build either PLAT={qemu,qemu_sbsa} with
the RMM enabled, so that can't be tested either at the moment.

All I can say is that this doesn't appear to break anything else
with x-rme=on.  Which is less than satisfying.


r~


Richard Henderson (20):
  target/arm: Add isar_feature_aa64_rme
  target/arm: Update SCR and HCR for RME
  target/arm: SCR_EL3.NS may be RES1
  target/arm: Add RME cpregs
  target/arm: Introduce ARMSecuritySpace
  include/exec/memattrs: Add two bits of space to MemTxAttrs
  target/arm: Adjust the order of Phys and Stage2 ARMMMUIdx
  target/arm: Introduce ARMMMUIdx_Phys_{Realm,Root}
  target/arm: Remove __attribute__((nonnull)) from ptw.c
  target/arm: Pipe ARMSecuritySpace through ptw.c
  target/arm: NSTable is RES0 for the RME EL3 regime
  target/arm: Handle Block and Page bits for security space
  target/arm: Handle no-execute for Realm and Root regimes
  target/arm: Use get_phys_addr_with_struct in S1_ptw_translate
  target/arm: Move s1_is_el0 into S1Translate
  target/arm: Use get_phys_addr_with_struct for stage2
  target/arm: Add GPC syndrome
  target/arm: Implement GPC exceptions
  target/arm: Implement the granule protection check
  target/arm: Add cpu properties for enabling FEAT_RME

 include/exec/memattrs.h     |   9 +-
 target/arm/cpu.h            | 151 ++++++++--
 target/arm/internals.h      |  27 ++
 target/arm/syndrome.h       |  10 +
 target/arm/cpu.c            |   4 +
 target/arm/helper.c         | 162 +++++++++-
 target/arm/ptw.c            | 570 +++++++++++++++++++++++++++++-------
 target/arm/tcg/cpu64.c      |  53 ++++
 target/arm/tcg/tlb_helper.c |  96 +++++-
 9 files changed, 935 insertions(+), 147 deletions(-)

-- 
2.34.1


