Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 944D678B33A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 16:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadLM-0005Yo-M3; Mon, 28 Aug 2023 10:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qadLK-0005UC-1p
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:35:50 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qadLE-0004f0-5u
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:35:48 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c1e128135aso4757205ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693233219; x=1693838019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ar7ypxdjUtDNbAjjyZHCP3Rrujc+GK1GiPkUHsv5+t8=;
 b=WcL6bNelvp7T2l5eySAH3c2gHJK2V+ZP3NIgovopJPXLsU2a6nVPXNNLXDYbETijPS
 DPKzKoO9enxn/Mquut6cvpSaacLr8wdFYUn7DfR1X30NO1/WNvzT6FTont5oFVemF2JT
 mHExwvCgDsP5xhn8esQ0c86Pi5aSpUd5jQbMj57Xy1NWjR6fwzUkLECHQyDZWsAfDaM3
 5SvH9lBKgUgxjKbXd5/McjQBqvfpoOQCUTSuYHR7EcP3zbSwe8NLdgea23RVVfH5EwvI
 PBH6bJApPCx8aXPs/x+jDeoLeRPbhtQMEqeS0ooTH8kyVeY1yghR0tmuU785Cv3YwUo9
 wlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693233219; x=1693838019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ar7ypxdjUtDNbAjjyZHCP3Rrujc+GK1GiPkUHsv5+t8=;
 b=Za++uYJBZqMvqM491WyKmklWwBcSL/luRoitwaF84SUzRt1zeze3jxVgJnGj8F1yLa
 wt994d52iaNpLT99UyJEwSIWYoToD6gEM/mb+PFwC2En/K2BAVZyGLp3n+UjOyXCj+sL
 SI6k++OrhKdHDNyWZ7BZXNwO0Ce1S/cbNcV8TSvLIBwey5ATZppQhJi8y3gXYa2OD01u
 EGvhuX4VPG3+K1CieGzsEOjQsUIXHYuO4oeFSdza0/h5IIRv2NDgh4CmfvMbs5hSdS56
 khacUDmx8Eqq5CWJSwPU05nFMI/KIr+Viloy9o4YisdDWTLi8CcyTdnKEnB3+59vUvtV
 nQng==
X-Gm-Message-State: AOJu0Yx27YGpW9zvot2whjx90hw1NP5GjNixhtc658O0gMTFIupeJEsP
 I2MmG59a8zQbIhJkHF8QAPCkA6vIDLmSOvFGonecxdweWrI=
X-Google-Smtp-Source: AGHT+IHwlONoe5XqrSHrAOvps0mn4C21p7RiDj5x4QyurJRVcOOP7GwLeaEQlN/zE87UW3HUZ6eeeA==
X-Received: by 2002:a17:902:d2c9:b0:1c0:b163:2cc3 with SMTP id
 n9-20020a170902d2c900b001c0b1632cc3mr12487855plc.52.1693233218599; 
 Mon, 28 Aug 2023 07:33:38 -0700 (PDT)
Received: from c74-1708-dev.zelin.local ([103.20.128.80])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902c10c00b001bdc2fdcf7esm7453794pli.129.2023.08.28.07.33.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Aug 2023 07:33:38 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>,
 "alloc . young" <alloc.young@outlook.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 0/3] Dirty page rate and dirty page limit 20230828 patches 
Date: Mon, 28 Aug 2023 22:32:54 +0800
Message-Id: <cover.1693228686.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x636.google.com
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

From: Hyman <yong.huang@smartx.com>

The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:

  Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)

are available in the git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-fixes-pull-request

for you to fetch changes up to e424d9f7e749c84de4a6ce532981271db1c14b23:

  migration/dirtyrate: Fix precision losses and g_usleep overshoot (2023-08-28 21:03:58 +0800)

----------------------------------------------------------------
Dirty page limit and dirty page rate PULL request

Hi, this is the fix for dirty page limit and dirty page rate.

Please apply.

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
1.8.3.1


