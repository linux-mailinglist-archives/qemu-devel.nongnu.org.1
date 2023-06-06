Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F5B725019
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 00:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6fRW-0005DS-3H; Tue, 06 Jun 2023 18:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6fRU-0005Ca-74
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:46:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6fRN-0001FF-1y
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 18:46:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-651ffcc1d3dso3948253b3a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 15:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686091571; x=1688683571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n5Hd9wF3SA8O3vHUNCL/EbPuYQ6aCmo0Nwy8NbLBCYg=;
 b=Dnmng2zQJ7+mSEa5FIBn1X/K3UIqTRbBQ/PuJB38P+Ze11uL7KiebTEnwF4b/DYvAB
 MUfyNIozpK/C0ULbW7MsMMyTo34sUwUFI8lU83wzPiRahc4AlKtaPHbtPL0oQSht7hvk
 34c9C5EzeFU33x8PkHbiaPsoY7cnbrWvYjsQd7NGYJeTAZFBCzj/hR2t6FZ16gqYxMZN
 NLiwxYOMnJyMBpGqPZWv8T/wSbprSe+nJDVjQGKMdx1nB+yZWTvy5egrLpUAkflp55zO
 +OhTZ4Cj4qZFt2DdZIZjwOnMtp9ev1s6q4bqBQiv369Hp8jxbXNqRUl/pa8fH4/CTS/a
 CJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686091571; x=1688683571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5Hd9wF3SA8O3vHUNCL/EbPuYQ6aCmo0Nwy8NbLBCYg=;
 b=gefarWGv+qF262q26c+oDO4YxWZwwfytrzIiDPZk8UA7Ob+Kzerozw7nF0b3IC33Mx
 eZ2RPr7Iz8VGarxXUW5lQZWrR4U+cxJOZ1NJJcauk2Ol/bdf1HXu9riG2GdlETC6c562
 JcEV95WsUHNgcPGN0DY8lBMEFIZrryXoaa6LigoVYsvdXF360Wk0ycZL5DFUnWjpzIbl
 awoU8IQBsIh/TibtLC4CfqLaPYp7J3cDMotmQGBuxXFtqOdmMQbkxm9t+R8VwOjLsHRF
 oxNjVjRwCEtJh/eZATEQIiKljMDk/Qcawjy4y2JhLE3DRpdc1ic2wuvTpi2VskAHJHz3
 LSaw==
X-Gm-Message-State: AC+VfDxdlFGBzakZqq3BLtBpyKZpMSLl0G9kzQ4IUvK+cGqWFhWiPBCn
 DAdHBQLoYIP1x/OFrT0kHPWCE5136V20k8I1hfM=
X-Google-Smtp-Source: ACHHUZ4F2PLqEXxhYjVxHGC4F+0t4R0EinCVFprYGB+0Ia6HixD5eN/faNjK2xGMYmhUELwPED3hZQ==
X-Received: by 2002:a05:6a00:22c4:b0:653:cfa8:dc51 with SMTP id
 f4-20020a056a0022c400b00653cfa8dc51mr3128922pfj.22.1686091570915; 
 Tue, 06 Jun 2023 15:46:10 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 t8-20020aa79388000000b0065cfd5cbef3sm3346969pfe.15.2023.06.06.15.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 15:46:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	alex.bennee@linaro.org,
	thuth@redhat.com
Subject: [PATCH 0/2] target/arm: Fix --disable-tcg build
Date: Tue,  6 Jun 2023 15:46:07 -0700
Message-Id: <20230606224609.208550-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Broken during my build tcg once series.
I thought we already had a test for this, but no, so add one.


r~


Richard Henderson (2):
  target/arm: Only include tcg/oversized-guest.h if CONFIG_TCG
  gitlab: Add cross-arm64-kvm-only

 target/arm/ptw.c             | 5 +++--
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.34.1


