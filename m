Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D87DF763F66
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjMR-00007v-2O; Wed, 26 Jul 2023 14:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMO-00006h-QT; Wed, 26 Jul 2023 14:35:44 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMN-0008C6-9A; Wed, 26 Jul 2023 14:35:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bba2318546so719845ad.1; 
 Wed, 26 Jul 2023 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396541; x=1691001341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9IRuODUqzZ4Utkuv00TnJb+H0Smu/qUWmThlbCjTAXw=;
 b=IDK5uAQnHB0Phzipt974Zm7eDwehGjBY0psgQzRr9otWNFySGAAb6KXV6a+0leO77X
 z/kUIUD52QP8hxZoJ4gsk7AWAMjPUGqOkGclkD7oxsSclZWmju9o1//Pak6mD3+qmeqf
 9O5udNj2dgURlWtNLIIcvygGqlwiWaKHMcFO0z2lYIkI5bRxEpHWGE6jGggxJYgzTwZw
 FbbdxQ/NBgNyAdBpTcs/AvWmYoe/aj6AysWyMh2K6usfQ53Wq5PrJZ8xObuqW0LFe76v
 el7gILSUq8/Ec+ks/l+zKSz7bvIQikqFxrxhiYxH+s+Wct87e0cibv7qLMA8WqsUxaCy
 Bqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396541; x=1691001341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9IRuODUqzZ4Utkuv00TnJb+H0Smu/qUWmThlbCjTAXw=;
 b=bbSbWZMAKJj9zTEEdydVC+RJok3+tAGCpbngS58MLolpfxnTGnxXbPZ4SPot9JY7Ye
 +MYtdK1QFZSw42dsxUDCyXaJlZDbsQrMH2bwiB9mzwXGd1Zb5rMLd1o29emKTuHyJTAw
 kkDJvdUHp2wk3xSCmQZPsEtGFBT35xelWgmbN2SOhBU1cTJF7fQrrBEgqlmpKSa01ahT
 GW0N1CIUNMyMZStoLiVoNyPnefpFUEUM3h3j9zARu83pau2S8AZlF4bsk6CuPUZm5QSy
 bwr6PEhuqQPHiLoyKWUP2MV55lqfI/1ccmNQvLln6J45XjHv/m43buCjh2NPTb/PDLbx
 zXLA==
X-Gm-Message-State: ABy/qLYNRmyNGhw0Va31o/Rb6Pv8EXLSE91Pa+Uq+MSQyYh0bNTgQkAb
 SF2xAhA9bH+3mmE+swNg0VA=
X-Google-Smtp-Source: APBJJlFW9pbxcWTURQ5CXuEQjx/o3/gwr3hyBPsk+9pzqqr7ZN2svphX1jAONUJs/z7yTVKyps5bMQ==
X-Received: by 2002:a17:902:7884:b0:1b8:a31b:ac85 with SMTP id
 q4-20020a170902788400b001b8a31bac85mr2639470pll.41.1690396541316; 
 Wed, 26 Jul 2023 11:35:41 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a17090301cd00b001b83dc8649dsm13485670plh.250.2023.07.26.11.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:35:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/7] ppc: record-replay fixes and enablement
Date: Thu, 27 Jul 2023 04:35:25 +1000
Message-Id: <20230726183532.434380-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Here is a series that gets ppc pseries and powernv machines into
better shape for record-replay, maybe for 8.2. It's likely got a
few deficiencies but it does run test cases and helped find bugs
in migration already. It requires previous decrementer fixes to
work well.

I think we can get away without patch 1 for 8.1, because we
inadvertently fixed regular (non-rr) migration of reservation
with  commit 392d328abe753. But opinions welcome.

For record/replay and avocado test reviewers, I would mainly
be interested in opinions about patch 6. I tried not to affect
existing archs much.

Thanks,
Nick

Nicholas Piggin (7):
  target/ppc: Fix CPU reservation migration for record-replay
  target/ppc: Fix timebase reset with record-replay
  spapr: Fix machine reset deadlock from replay-record
  spapr: Fix record-replay machine reset consuming too many events
  tests/avocado: boot ppc64 pseries replay-record test to Linux VFS
    mount
  tests/avocado: reverse-debugging cope with re-executing breakpoints
  tests/avocado: ppc64 reverse debugging tests for pseries and powernv

 hw/ppc/ppc.c                       | 11 ++++--
 hw/ppc/spapr.c                     | 32 +++++++++++++++---
 include/hw/ppc/spapr.h             |  2 ++
 target/ppc/compat.c                | 19 +++++++++++
 target/ppc/cpu.h                   |  3 ++
 target/ppc/machine.c               | 26 ++++++++++++--
 target/ppc/translate.c             |  4 +++
 tests/avocado/replay_kernel.py     |  3 +-
 tests/avocado/reverse_debugging.py | 54 +++++++++++++++++++++++++++---
 9 files changed, 139 insertions(+), 15 deletions(-)

-- 
2.40.1


