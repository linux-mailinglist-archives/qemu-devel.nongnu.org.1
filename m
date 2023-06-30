Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91932743358
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 05:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF5F1-0008Hl-Vj; Thu, 29 Jun 2023 23:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5Ex-0008Gp-ND; Thu, 29 Jun 2023 23:56:11 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5Et-00023O-L0; Thu, 29 Jun 2023 23:56:11 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1b0719dd966so1284925fac.1; 
 Thu, 29 Jun 2023 20:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688097360; x=1690689360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=u5JMTCeiOnIYES3limCYJDDHWevZnvlLuz5USrFcEPc=;
 b=jEPGQadcdjYZthXREwwO6H3PDoS436svmM6R5RJWJyemzz8a8P4oyOGq9OGpzoP0SX
 E5Gz7hHiuRLnyTMWSOVPvopE+wL0zdmLk87ZuKdAQgbm9AWurV4YiQLUFkCN0ZkmzqFj
 AdRU7gPwcMtH7yiCtbTx1O3C+GuQPc9lcfuDL33PObFlRfoEvo74BHBF1AoQzCDHr4HS
 ycZJmaaT/i4Pm+nXQ//mT5UaCAm8uZdoV9/Jo0GAJgd/l9uSkPj56wKC1SHMrZRyuOpk
 lcG9n0S7FhC/t3eNDQvAz0msuPXXnpt5+gpfbdiSpfM2ePclG4T0VJ5K8/NjRG++ay1B
 HI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688097360; x=1690689360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5JMTCeiOnIYES3limCYJDDHWevZnvlLuz5USrFcEPc=;
 b=Btm7Icjk/Y3Vvv9rMYT5typovAjGLvXqYLCQRjihSlXSZPlJetZSlP1cQfeQQHNdvX
 tiAAnAmQwvulWEH+6Be22hnSGxVp+C6S24Tn0F8hFFqZHoh9u8BD68V0VB5xKDA/8DrN
 rOp1H7zq2T9edDK5qx/th4XEHr6h2x6aKnotHClzs2kiXTTlSjLfvO5gt2NuFNT4XTv3
 ciiqtYMbYiE/RmgNxnFNogipVXdFEG2/bPFO34cs1VP8K3UqTw3zjfg9/5bZWl/tuUfh
 AivtGBG/hnfVfdV4apQfdv5qpMONrq5tqD2Xj88SrK5zXVm3Oc/NJ5ublZj2fAzy6KLc
 Wxlw==
X-Gm-Message-State: ABy/qLayJmEJ0g/tm9A/V6fzKXUWeyLTDlCv36lOQwJrxd2zAmgSHXKc
 CVmM0HzR4rhOg4HHm59zM04=
X-Google-Smtp-Source: APBJJlGnoOocGGZ5qV/5F1Z5+S419V66CmmBstqoSQlNkq5Ewn101OMArCqRvAGC6B5pV5bP6Z9GnA==
X-Received: by 2002:a05:6870:ac87:b0:1b0:4899:10d with SMTP id
 ns7-20020a056870ac8700b001b04899010dmr2298681oab.35.1688097360097; 
 Thu, 29 Jun 2023 20:56:00 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15]) by smtp.gmail.com with ESMTPSA id
 29-20020a17090a195d00b0025ef39c0f87sm10639290pjh.0.2023.06.29.20.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 20:55:59 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH 0/4] ppc/pnv: Extend "quad" model for p10
Date: Fri, 30 Jun 2023 13:25:43 +0930
Message-Id: <20230630035547.80329-1-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=joel.stan@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The quad model implements the EC xscoms for the p9 machine, reusing the
same model for p10 which isn't quite correct. This series adds a PnvQuad
class and subclasses it for P9 and P10. Implement the core thread state
xscom as an example. I expect more function to be implemented in future
patches.

There's one outstanding question. Skiboot has this for the p10 scom:

 #define P10_EC_CORE_THREAD_STATE        0x412

However the read that comes is for 0x28412. I suspect the upper 0x28000
are addressing bits, so we're really reporting the core thread state for
the given core. Should the model instead wired so one is created for
each chiplet? Or should we report the value for all possible cores, like
the P9 code does for P9X_EX_NCU_SPEC_BAR?

    switch (offset) {
    case P9X_EX_NCU_SPEC_BAR:
    case P9X_EX_NCU_SPEC_BAR + 0x400: /* Second EX */

Joel Stanley (4):
  ppc/pnv: quad xscom callbacks are P9 specific
  ppc/pnv: Subclass quad xscom callbacks
  ppc/pnv: Add P10 quad ops
  ppc/pnv: Return zero for core thread state xscom

 include/hw/ppc/pnv_core.h |  12 +++-
 hw/ppc/pnv.c              |  11 ++--
 hw/ppc/pnv_core.c         | 114 +++++++++++++++++++++++++++++++-------
 3 files changed, 113 insertions(+), 24 deletions(-)

-- 
2.40.1


