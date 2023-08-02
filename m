Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1370076D4A1
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 19:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRFEj-0000Qd-I4; Wed, 02 Aug 2023 13:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qRFEf-0000NP-SG
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 13:02:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qRFEd-0003Tx-4L
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 13:02:09 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso692875e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690995724; x=1691600524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sCFGSHt30kvaa5bFMVRWFrSJMF+aHbNAKH7KKhkj+Mo=;
 b=hQRTPJlqor3ceR2OoJdZTm6QRIPCs9djMRcaSzALk4XYkDc+HXp3ygenGSqw9fffzQ
 UP11nQsTj+JqEsfrcIINZOmaKcTaExxwTVhUs2xMi9izja65GnbTJZA/7DspElycXFrP
 Z2vtGMznC3SdRNq4mTnlT8TDY0PbFBp57qC4eRCfbJ7Sk8XJ2tLFSSIuDK5uiuTHjzVc
 IX19fALkIQVzCoCqFTKPd1SVhokhS+7O+fvbLHUC8U7cyyUrwASkeJRCjSslBbjyBbGz
 A3P4jY9LB4bUsbgbaH91pdrOj7Q0zYJVccLMaOFfF3wBIU8RBRABPxk3EhSWaEIuso9A
 YKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690995724; x=1691600524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCFGSHt30kvaa5bFMVRWFrSJMF+aHbNAKH7KKhkj+Mo=;
 b=W+2nvr3QV6x1PBWTx7qNJJ83SwBM3Q32edit2IOwYJTYsub13T3KE7vsiT54H615Um
 TDztBxDZnN9QlTtmakd5K8/EdOFTSvURMRgKWgVRwAtQvQLJq9+BIq4D50nmjkfTIGgi
 HsPJYKndHw4XElz1WyQxfHqaJgMcV2+YCM2pioq5HTV2WgmRtqaIKrSiegQE75+s0WQm
 q/urV87h7UIr3Nn6euONd9STjlc/mIkg7gHkkaOuRHpP4R/mHWUa1FHJBq7VJ1+3wi6V
 FDLM7+XUbIkVpZMWjnH1xqPilvsqd/av9RUbK/WTaPZ8xBEasjVb3IDNs6NsE5cxAvs0
 swMA==
X-Gm-Message-State: ABy/qLaQSYGCq9Z4nP2rrKTBBkQ8pkmO331V7rGnsb4r85jwHN/siYB5
 dqPht88O19Wnxg/8TMp/9Bwpvg==
X-Google-Smtp-Source: APBJJlE7R5xSJ6NPLnFIGFR4gt7zccMZlx7HyWunwSnPV8I+FrC4fsiwb2IcipzjLj+w2Wt+0DiLYw==
X-Received: by 2002:a1c:7419:0:b0:3fb:e2af:49f6 with SMTP id
 p25-20020a1c7419000000b003fbe2af49f6mr5010562wmc.39.1690995724259; 
 Wed, 02 Aug 2023 10:02:04 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a1cf307000000b003fa98908014sm2149081wmq.8.2023.08.02.10.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 10:02:03 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 0/6] target/arm: Fixes for RME
Date: Wed,  2 Aug 2023 18:01:51 +0100
Message-ID: <20230802170157.401491-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
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

A few patches to fix RME support and allow booting a realm guest, based
on https://lore.kernel.org/qemu-devel/20230714154648.327466-1-peter.maydell@linaro.org/

Since v1 I fixed patches 1, 2 and 6 following Peter's comments, and
added patch 5. Patch 6 now factors the timer IRQ update into a new
function, which is a bit invasive but seems cleaner.

v1: https://lore.kernel.org/qemu-devel/20230719153018.1456180-2-jean-philippe@linaro.org/

Jean-Philippe Brucker (6):
  target/arm/ptw: Load stage-2 tables from realm physical space
  target/arm/helper: Fix tlbmask and tlbbits for TLBI VAE2*
  target/arm: Skip granule protection checks for AT instructions
  target/arm: Pass security space rather than flag for AT instructions
  target/arm/helper: Check SCR_EL3.{NSE,NS} encoding for AT instructions
  target/arm/helper: Implement CNTHCTL_EL2.CNT[VP]MASK

 target/arm/cpu.h        |   3 +
 target/arm/internals.h  |  25 +++---
 target/arm/helper.c     | 171 +++++++++++++++++++++++++++++-----------
 target/arm/ptw.c        |  39 +++++----
 target/arm/trace-events |   7 +-
 5 files changed, 170 insertions(+), 75 deletions(-)

-- 
2.41.0


