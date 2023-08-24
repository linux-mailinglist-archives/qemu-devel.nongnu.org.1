Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1FC78744F
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:34:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCK1-0001QO-8K; Thu, 24 Aug 2023 11:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCJy-0001Ph-Ar
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCJv-0003RI-Kg
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fee8b78097so46861945e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692891145; x=1693495945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M0JCieYoW6jUCNsZb73UkxWb252sBnt7qHRsV0F/3BE=;
 b=SupNhZQHS+y0r2/35l2PYd5FF67Pp94zw66r4OOpfT4Q7dre95/9mMr7qFUIw4NiLY
 Z6NhqeDvSXndafwtkXm45jm4HCnJaPk7cAVEMCQBPlRofWNjMQvp/QuYsdGPdk1lq5Pq
 TDjmTr7qT/XkZfC4oocOA6d3bEUHT6cnjHhlABqaxJRq4e+AUS7z9oh+lyEqt88wq6DU
 XqZFHydiiyqoywXZ9Wgo1Pnk7dPXHc3UTYCdlNanL4lIchA3JvroSh2PeRzZ2G6S4bmC
 b42p6cWBscQsuIpI0m7O+Lo5cCEJ3RAIGOcDgNqsHktuHW/KARR09w42Gc0veZ9QXaxC
 1EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692891145; x=1693495945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M0JCieYoW6jUCNsZb73UkxWb252sBnt7qHRsV0F/3BE=;
 b=HZsuAAC8BtzQ254FkvI04S1LQ6rDpCgi5lpaqjubhXAKGLfSnaKw+8JaK82OfCE2P5
 95Lz4rr0/1Fz/el1F5Rg4Z8Ktl3X+Rj/t0w02+XAqATcndMr9mqV9Ou6Tm5me4BttI72
 JWKS/fN1asQP1okeKU+rIzv9F1Q2+eMhWwErDWEXjO/Q/pmkshbq7LzC9Gdg1mQM4dKr
 xwtQesk6VBqqXkX1hNfPfU3bg5U6czgumGX39JKwGHrKR/o74SBbE1L1g1WPXuWt02bt
 boyBCuk7D9n5kac8NkXZoBtjijRB/zFJK3m46speq2pzEV9FUrjqfain8raBNp1aRDxz
 ztNg==
X-Gm-Message-State: AOJu0Yw4p0uJS1WfmilloLqAFp9o43b6MBStVSB7VA0ueK5Lq3ru5705
 mnwEl4b+8AXTIsZwvk8K77sA8qEO4CDVR/T0Pi4=
X-Google-Smtp-Source: AGHT+IHjQLGsee7H9l1TEgmh7Pent+mgkBZ2m9+iZWcYvH5eHha/GfMTkSEwu+ad9A+M8UZOnDZyXg==
X-Received: by 2002:adf:ded1:0:b0:313:f395:f5a3 with SMTP id
 i17-20020adfded1000000b00313f395f5a3mr12762108wrn.38.1692891145658; 
 Thu, 24 Aug 2023 08:32:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x4-20020adff0c4000000b003180fdf5589sm22918640wro.6.2023.08.24.08.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:32:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 qemu-ppc@nongnu.org
Subject: [PATCH 0/4] net: avoid variable length arrays
Date: Thu, 24 Aug 2023 16:32:20 +0100
Message-Id: <20230824153224.2517486-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

This patchset removes the use of variable length arrays in a couple
of network devices and the net/ core code.  In one case we can switch
to a fixed-sized array on the stack; in the other three we have to
use a heap allocation.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Philippe had a go at these in  a patch in 2021:
https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/20210505211047.1496765-16-philmd@redhat.com/
but these are re-implementations, mostly.

Usual disclaimer: I have tested these patches only with
"make check" and "make check-avocado".

thanks
-- PMM

Peter Maydell (4):
  hw/net/fsl_etsec/rings.c: Avoid variable length array
  hw/net/rocker: Avoid variable length array
  net/dump: Avoid variable length array
  net/tap: Avoid variable-length array

 hw/net/fsl_etsec/rings.c      | 12 ++++++++++--
 hw/net/rocker/rocker_of_dpa.c |  2 +-
 net/dump.c                    |  2 +-
 net/tap.c                     |  3 ++-
 4 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.34.1


