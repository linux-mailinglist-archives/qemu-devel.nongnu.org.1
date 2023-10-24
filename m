Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C864C7D5899
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKNS-000244-9v; Tue, 24 Oct 2023 12:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvKNE-0001xd-8N
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:35:22 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvKN9-0004Li-0e
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:35:17 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c4fe37f166so67330841fa.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698165312; x=1698770112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=36Ak5eB0m5J1zM/IZMmGa4L9AvRMMkX41INBVpt2JKw=;
 b=CKCuGyDINItWz4//nOLfZBzZp70mE2hlvjm06u3ZSWRB6OBYnMgzQjcpLPk+hi5myu
 GtvKP0UHVBRuNhObgpHL6f77SR8SZhSPwu2zf+DT+GkctDjPTcuCifyXA1SiOVKp2KVk
 tGQV1r6XundjhJPzjE+PvRTN6pTZQtUNS18FcTAPRvq1ZPjwBV+Re9Xe5VAS4Js4XPKR
 TGSiRAvpznimgjHoQj4uYZRMrh9eYvGWyANaVunGeJz5Cf8rz0fcrFH9JUtlRdufPhsH
 NEWDDSGvlzEANNjAIVmbOEsZAVm0fR99cIzpWxA83PWkoxytTlPKSWwki1vFyJ7jcPzm
 Pjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698165312; x=1698770112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=36Ak5eB0m5J1zM/IZMmGa4L9AvRMMkX41INBVpt2JKw=;
 b=iDjlUwg6iafiSvajRDOJ1xF0KlWAbkIZsb16Eo1OijM0i8z6G5YKraxALV6oOElcVR
 kHsUxxsvwK/RFsdgycSyj9CUB1bboHFzsrP4EbY7No8ErI1ecLgn/FN+h5eLNK1usuG8
 9H/B8tPJ/aTOonKmw5WMuiGZQi9VUcMojEN6Y8GJBcIlcPcgcD1QBillGYr5sr4AZZv/
 NAROuvyWW1bm0Pm0F85sAMxO9wPjR3jEKNevOymHOigR9z1cR3GmG+IpNS4nWEdK2+d5
 zCWL6qTskANrpaO4czuJ1jGES886L4HpCt5vJ5cRdXHRllSczTzfdMAq+anYQRF1uJjp
 +D9A==
X-Gm-Message-State: AOJu0Yx2ZzG0PK795HNUOSQzeFS8Ft2HsfECx6apunLXt29of59aNNnJ
 l56EVyQHz7qic+QTBo2BrafpkA==
X-Google-Smtp-Source: AGHT+IEeKGokidj4m3MIdio/4aRor06y2a6puQuplhJDy+NKVu6+/gCxD3XAGXnsHWUV9V19aSCPyA==
X-Received: by 2002:a2e:b0c3:0:b0:2c5:1702:a434 with SMTP id
 g3-20020a2eb0c3000000b002c51702a434mr9211381ljl.52.1698165312038; 
 Tue, 24 Oct 2023 09:35:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm16860101wmh.11.2023.10.24.09.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 09:35:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/6] target/arm: Move feature tests to their own header
Date: Tue, 24 Oct 2023 17:35:04 +0100
Message-Id: <20231024163510.2972081-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

The main aim of this patchset is patch 1: there are a lot of
feature test functions in target/arm/cpu.h now (~1000 lines,
nearly a quarter of the file), and most of the source files that
pull in the target cpu.h do not care about them. So we can move
them out to a new cpu-features.h, hopefully reducing compile
time and avoiding having to recompile so many files when adding
a new feature test function.

Patches 2-5 are followup cleanup, which I don't feel so strongly
about. They try to impose a little order on the AArch64 test
functions by sorting them so that feature tests on the same
ID register are grouped together. This is pretty much how the
file started, except that as we added new features sometimes
we put them at the bottom of the list rather than in their
right place. But if this feels like unnecessary churn I'm
happy to drop these.

thanks
-- PMM

Peter Maydell (6):
  target/arm: Move feature test functions to their own header
  target/arm: Move ID_AA64MMFR1 and ID_AA64MMFR2 tests together
  target/arm: Move ID_AA64MMFR0 tests up to before MMFR1 and MMFR2
  target/arm: Move ID_AA64ISAR* test functions together
  target/arm: Move ID_AA64PFR* tests together
  target/arm: Move ID_AA64DFR* feature tests together

 bsd-user/arm/target_arch.h        |   1 +
 linux-user/aarch64/target_prctl.h |   2 +
 target/arm/cpu-features.h         | 994 ++++++++++++++++++++++++++++++
 target/arm/cpu.h                  | 971 -----------------------------
 target/arm/internals.h            |   1 +
 target/arm/tcg/translate.h        |   2 +-
 hw/arm/armv7m.c                   |   1 +
 hw/intc/armv7m_nvic.c             |   1 +
 linux-user/aarch64/cpu_loop.c     |   1 +
 linux-user/aarch64/signal.c       |   1 +
 linux-user/arm/signal.c           |   1 +
 linux-user/elfload.c              |   4 +
 linux-user/mmap.c                 |   4 +
 target/arm/arch_dump.c            |   1 +
 target/arm/cpu.c                  |   1 +
 target/arm/cpu64.c                |   1 +
 target/arm/debug_helper.c         |   1 +
 target/arm/gdbstub.c              |   1 +
 target/arm/helper.c               |   1 +
 target/arm/kvm64.c                |   1 +
 target/arm/machine.c              |   1 +
 target/arm/ptw.c                  |   1 +
 target/arm/tcg/cpu64.c            |   1 +
 target/arm/tcg/hflags.c           |   1 +
 target/arm/tcg/m_helper.c         |   1 +
 target/arm/tcg/op_helper.c        |   1 +
 target/arm/tcg/pauth_helper.c     |   1 +
 target/arm/tcg/tlb_helper.c       |   1 +
 target/arm/vfp_helper.c           |   1 +
 29 files changed, 1028 insertions(+), 972 deletions(-)
 create mode 100644 target/arm/cpu-features.h

-- 
2.34.1


