Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EFF78B690
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qag8x-0003Lt-M8; Mon, 28 Aug 2023 13:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qag8u-0003Kf-VC
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:35:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qag8p-0001PJ-8c
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:35:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso27571655ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693243982; x=1693848782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MeSndXLcE+tpDFI6uG2GHaNoY6UtaQAU5xj79zv3YqY=;
 b=DscwPFnV0vxhZG0+n/QNiXRzTxpeZBfTqXLS8/5BG6naqqmPkTlH07cOhZlHnqBKro
 xdLWBjrKTzKMYh4fGCSpee36uugnYyq8nyhBi4UqFQE+lq8fIGLmBm2EWUzuQFiw60tu
 ja0rTZUCDVB1Nrje64FoNoheVAVYc8wZvNHrSwYRcduLd5Yecer3stnlf8pUqhsv3CX9
 06Z6gaVbZHjRoFXv90acGYXqA1+0s06OP1fmBzeTyba2vUk7E9bjeORdjjhkLTYFg6dR
 KExOGGbXhKg0meTwh0MgA5EaLcqqDhyedFqemMD06jhuG3dw8khtledVEU6dxyQhdGYn
 oWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243982; x=1693848782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MeSndXLcE+tpDFI6uG2GHaNoY6UtaQAU5xj79zv3YqY=;
 b=comKp0MHx51IJ5ZtpEwIlrXmd+3mlPjKg8NwUu/l/US/t8GdjAasNpRwvCTlabNLwD
 JfKAbJ6XLnUdCov21FPEQrHsxa1qVJewaLbGrvtFw5W8mfMwZtRKZrbYaItilUpVMyQ/
 qn+dihwBugA9qHTMh0vXgSGgqTHYGDNuC251U3yMuifCswdmCCbLLofOS1cdq3rToSwq
 NZe4KwTZ5Lq6YLxjYUCbaqLS2MLJ/Ry5ndO30kSpQEkHxsbK3tXrem06qjVvSYInP0kR
 EVXWsodayVCTERh8AOp+8TR1zi3r/d/u4XjCIMFD6DkYinxxvElO70EyXcRFAYHs/Op1
 dgNQ==
X-Gm-Message-State: AOJu0YzOVbPDffpolKmAsYWzPrM44o3JDPMmWknAflDgkf3JdLnYAhEC
 zWVaSmo1qUv5bDqynZALt7Lj09eGLWxifeDVYXZPirfg
X-Google-Smtp-Source: AGHT+IEB81K+9sSpSGtpoDwij1voyTZT0WFUZZukYe9Ceo7qelR6AH8V8MKyxiWRnaeNu4azgwDLzw==
X-Received: by 2002:a17:902:bf47:b0:1bd:bdfb:58e9 with SMTP id
 u7-20020a170902bf4700b001bdbdfb58e9mr23991134pls.40.1693243982638; 
 Mon, 28 Aug 2023 10:33:02 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 je1-20020a170903264100b001b80d411e5bsm7669103plb.253.2023.08.28.10.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:33:02 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 0/3] Dirty page rate and dirty page limit 20230829 patches 
Date: Tue, 29 Aug 2023 01:32:49 +0800
Message-Id: <cover.1693241678.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:

  Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)

are available in the Git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-fixes-pull-request

for you to fetch changes up to e424d9f7e749c84de4a6ce532981271db1c14b23:

  migration/dirtyrate: Fix precision losses and g_usleep overshoot (2023-08-28 21:03:58 +0800)
----------------------------------------------------------------
Dirty page limit and dirty page rate PULL request

Hi, this is the fix for dirty page limit and dirty page rate.

Please ignore the previous PULL requests that accidentally failed
to send and apply this patchset. :) 

Thanks, Yong.
----------------------------------------------------------------
Andrei Gudkov (1):
      migration/dirtyrate: Fix precision losses and g_usleep overshoot

alloc.young (2):
      softmmu: Fix dirtylimit memory leak
      softmmu/dirtylimit: Convert free to g_free

 migration/dirtyrate.c | 10 ++++++++--
 softmmu/dirtylimit.c  | 26 ++++++++++++--------------
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.39.1


