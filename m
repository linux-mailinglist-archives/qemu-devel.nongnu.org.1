Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 471AB746914
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 07:43:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGYo7-0003T1-PK; Tue, 04 Jul 2023 01:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYnv-0003PV-Dj; Tue, 04 Jul 2023 01:42:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYnp-00040Z-R3; Tue, 04 Jul 2023 01:42:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b82bf265b2so23517025ad.0; 
 Mon, 03 Jul 2023 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688449335; x=1691041335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=UY6/jebI6uk/NNipWYOSkvZD8rbshUkVXQpPxGXfzZ0=;
 b=jYLjfbX2YOquhthr6zVP79o1YvYb756/O4cTrTOZlpn0Uxir9UJsze9GAAuyv+E4Sq
 Jgw2IdN737dTp5/72ir75+ogNK2vFzOBGvbUYPuChVDvsyconeXZPpRQ5hkFNZ6WXDLz
 mpYH357Hn7rctt2292oYH0Il2nSckwEvPLkcS4U5+YjXlrAo26oZnNR6/dTM0st2S6fB
 m77L+kxt0e1rQWwXAay27FcTY+plwO9Oh5bJlopqNYClrnXFukeCOPGGWtzHSdPjBPaL
 fTDf2cXzSRGdnzuAhl0BooAFXTYLIuvSNV/VwCLGNL0+5EB3A62Lm76rnQ92fhGMH2Id
 symQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688449335; x=1691041335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UY6/jebI6uk/NNipWYOSkvZD8rbshUkVXQpPxGXfzZ0=;
 b=DgL6cxjIauF35fY/OhG/VQtUM7RVkBMkOLdFfXSUIS16OXYmhCdE5hOjtG39/A35ja
 EWxFSKHiKTtyy3LSt4PT1LIP6nKE22ZzAtzUrRNsrUvvHHJDLbalzEoEsfUfdc7X7jYY
 fRosPTcCIhebTeRteyzIE5sOMbx3BQf9qq3gGg8CjagLxU8JdHv38JWrb5THAPjzLrwB
 bKgIq3rEtfT43pS9v5ctZljRa96QBakPTHtp+K5JGYh8YGMDKU7c1KNeg/8dYSetSPNj
 5SDfeblvEQ3nQbvy785Zww9X5ZhfoL+JEs66Clr1UIZcvM9vP6ny/eRJjZiG/Xd4R6CO
 +CoA==
X-Gm-Message-State: ABy/qLZ9KDFcS1SUd8z8NGPGyqjOJ0cRHVAs9qvl13uxSUzvHhFRLgGL
 xAGD7/1GAy3gWcd6HE4MfmsGaQCD+CY=
X-Google-Smtp-Source: APBJJlFQwkyjhpOZnlyTCgZu6mIV1VK3jL36Ln5OReHk/dFtBSksbxHTj1jniYaaLIz9uHYb2LwonQ==
X-Received: by 2002:a17:902:ea08:b0:1ad:f407:37d1 with SMTP id
 s8-20020a170902ea0800b001adf40737d1mr10012997plg.52.1688449335100; 
 Mon, 03 Jul 2023 22:42:15 -0700 (PDT)
Received: from localhost.localdomain
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090311c900b001ae59169f05sm16261879plh.182.2023.07.03.22.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 22:42:14 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 0/5] ppc/pnv: Extend "quad" model for p10
Date: Tue,  4 Jul 2023 15:11:59 +0930
Message-Id: <20230704054204.168547-1-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
class and subclasses it for P9 and P10.

I mistakenly thought we needed the quad model to implement the core
thread state scom on p10, because the read was coming in to the address
belonging to the quad. In fact the quad region was too large,
overlapping with the core. This is fixed in v2, and the core thread is
back where it should be in the core model. This should address Nick's
feedback on the v1 cover letter.

v2 also adds Cedric's r-b, fixes the s/write/read/ mistakes, and is
checkpatch clean.

v1: https://lore.kernel.org/qemu-devel/20230630035547.80329-1-joel@jms.id.au/

Joel Stanley (5):
  ppc/pnv: quad xscom callbacks are P9 specific
  ppc/pnv: Subclass quad xscom callbacks
  ppc/pnv: Add P10 quad xscom model
  ppc/pnv: Add P10 core xscom model
  ppc/pnv: Return zero for core thread state xscom

 include/hw/ppc/pnv_core.h  |  13 ++-
 include/hw/ppc/pnv_xscom.h |   2 +-
 hw/ppc/pnv.c               |  11 ++-
 hw/ppc/pnv_core.c          | 165 +++++++++++++++++++++++++++++++------
 4 files changed, 162 insertions(+), 29 deletions(-)

-- 
2.40.1


