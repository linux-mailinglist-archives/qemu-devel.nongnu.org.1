Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E85759A4A
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:58:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9Y1-0003BI-Vc; Wed, 19 Jul 2023 11:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qM9Xs-00037m-2t
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:56:56 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qM9Xl-0007IR-7W
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:56:55 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b93fba1f62so58236941fa.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689782205; x=1690387005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JuHkd755TxaRlWG5RlSsbScpQRuzOZpdpHhnh7Tq8Bo=;
 b=il98BA0FoIm/w5G8f7ZCiE11M+cfZsGcff0ybwbYZCIA1/NGinxOyETlFzoiswdkj3
 s4TYHYKEz9T6h/26L+vG/NJOHRYJWY+U5XVXJVopNFjTrpXcy/ijFFKfKWISdQrBECvM
 l5/XLZHHMPM01GhI7DgsFTHVl7hsXMEZIWOmHNeOvaeSbF69lUsGp085C42orBOfhdBC
 EFYlqGGdOyOU7Lwck3eJly0TwlesCpR/aB7NlBU5vsE2Ky7dHO9hrnQAqx8vDUFjaFx8
 0Kt3UKAHDN3wfIxoLGx6HtKwiqOoLCRdnmG3VEws/RxryoO0sWUJAXetsc07Xq5tVe1T
 GFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689782205; x=1690387005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JuHkd755TxaRlWG5RlSsbScpQRuzOZpdpHhnh7Tq8Bo=;
 b=Pv5r9IYe5cAmFIp3gKxik5WCgT3huCmNeTrGiBdEk9VF+gyEc3OQH/m5wnPgJYfmNl
 FpUV4G/be7WFwH3qjr9Mn4/rv2ioUnLt2PbJQJhkDCIa0xSR/WO9v02574AhfoMNJ3wa
 eKlXdyUfFCI8v4qOKTEz/eQkr3OltaczirgMXom+jD9ZRepUUpNMWyjbbr+LcmLIQ+Zh
 AC4K6ptSbyZJAf12EO3HmDZoNG17unYfOYcYhyMTzhF5meXtbQS3Rd0u/jmJpzNhCF1t
 NnmZ9lKCboBLkqHMsYjKKJRb7QBplM1YDj8H3xkTQnUGlYR2giRSCE12bmZtWfwrFptO
 NIdg==
X-Gm-Message-State: ABy/qLYXfVDRn3dg2nQNWHR0ADtXXj0meFe2FIfkBrizebQpaMUTViMS
 x138WcEvg11Q8lBgqKsxgGlMSA==
X-Google-Smtp-Source: APBJJlHE8Kbr/OFiTQNOd/A/TShsOsSdxKkgPGnB4Pmz6ERujWGmjJeaVDqEap8RoFWvTlSESNNZGg==
X-Received: by 2002:a2e:9919:0:b0:2b6:fe3c:c3af with SMTP id
 v25-20020a2e9919000000b002b6fe3cc3afmr274730lji.27.1689782205210; 
 Wed, 19 Jul 2023 08:56:45 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a1c790e000000b003fc3b03caa4sm2351006wme.0.2023.07.19.08.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 08:56:44 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 0/5] target/arm: Fixes for RME
Date: Wed, 19 Jul 2023 16:30:14 +0100
Message-ID: <20230719153018.1456180-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=jean-philippe@linaro.org; helo=mail-lj1-x22f.google.com
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

With these patches I'm able to boot a Realm guest under
"-cpu max,x-rme=on". They are based on Peter's series which fixes
handling of NSTable:
https://lore.kernel.org/qemu-devel/20230714154648.327466-1-peter.maydell@linaro.org/


Running a Realm guest requires components at EL3 and R-EL2. Some rough
support for TF-A and RMM is available here:
https://jpbrucker.net/git/tf-a/log/?h=qemu-rme
https://jpbrucker.net/git/rmm/log/?h=qemu-rme
I'll clean this up before sending it out.

I also need to manually disable FEAT_SME in QEMU in order to boot this,
otherwise the Linux host fails to boot because hyp-stub accesses to SME
regs are trapped to EL3, which doesn't support RME+SME at the moment.
The right fix is probably in TF-A but I haven't investigated yet.

Jean-Philippe Brucker (5):
  target/arm/ptw: Load stage-2 tables from realm physical space
  target/arm/helper: Fix vae2_tlbmask()
  target/arm: Skip granule protection checks for AT instructions
  target/arm: Pass security space rather than flag for AT instructions
  target/arm/helper: Implement CNTHCTL_EL2.CNT[VP]MASK

 target/arm/internals.h | 25 ++++++++------
 target/arm/helper.c    | 78 ++++++++++++++++++++++++++++--------------
 target/arm/ptw.c       | 19 ++++++----
 3 files changed, 79 insertions(+), 43 deletions(-)

-- 
2.41.0


