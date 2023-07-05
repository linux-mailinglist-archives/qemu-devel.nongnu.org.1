Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 946CF7483C3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1HW-0004Yk-Fv; Wed, 05 Jul 2023 08:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1HQ-0004YJ-GY; Wed, 05 Jul 2023 08:06:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1HO-0003QD-Qs; Wed, 05 Jul 2023 08:06:44 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-666eb03457cso3192503b3a.1; 
 Wed, 05 Jul 2023 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688558801; x=1691150801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QpWQZZvqc+xRSq8Cw25A0bSQznzupSTQBbkmzzSuxAk=;
 b=G08B9u6A5XFKOMOEHpgHv9MncFYhrrZGbC3NlhJz6OjKkKALJ4ziU7kwSU/4OK0cfI
 esNy4vZ20auwzAJuo+vAGsK13S6K8SijbFwKe7K9DG7Zh3svVonFoSbouDx1S0H1QwyA
 zeReRUUYQ/7MrI/uK8i48ZGvkAPyDxYWIYW4ogtkvLlgsGaPtvI1m4S5FM9LkbHTDDbT
 Ty6yJsFfmSdRGVoKxvbj/m/8IOKUpqJsc87/ayiWCkV7YXsvUHdXcPAKRCXNdYutzmxG
 q909PFGixZiPU77x80jt/R/Kw+PQPErM6tHeEit4qP5o4E4fkYv1SgVAHyn0yoLAgf8L
 ikGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558801; x=1691150801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpWQZZvqc+xRSq8Cw25A0bSQznzupSTQBbkmzzSuxAk=;
 b=k1/cnwkXfQkczj0evW96l1UnEc/Qr61VzLYwn40IqZamaty5FCXNJJSEUWho7z3I4g
 R8ybCZS7r7ewdoCOCmkEOk4J8BWyac53dkeUBIjHH/6mosGX7viHaroacMcDs+4+mo0i
 +bVxl39zG9RFpn9ptwe5ea2WaXNqq9WEuDi5XX1tWCGBQl6U89kK50f0JRiu6EyWJqhW
 tVNIOP1aU7UGOOOzPhfLA6eK1ucnT4vLqRzyp6o8JroawklenERq5YHKY/6jhShYtgtz
 gq3C6CCMQn4vIF41aABNQOBFfOICB7AkyV3U+MquYyWFn/B/C0lbwuUyJSoAQ+pdb//F
 GGcw==
X-Gm-Message-State: ABy/qLbYf0t53yux4vMCstXVCMbJltadJF2qKfhhTILvDf8cPrdxAiLw
 EegdnpPXrmCBsxKBG9r1ZhU=
X-Google-Smtp-Source: APBJJlFDqCBjkdr6HFIfX8kKXUOnELdUrwfBDur8wlVVC+2cUDwoYsuPZt94MR4boJx35rnMFGjY1A==
X-Received: by 2002:a62:1ac9:0:b0:668:7090:bf18 with SMTP id
 a192-20020a621ac9000000b006687090bf18mr11563164pfa.34.1688558800734; 
 Wed, 05 Jul 2023 05:06:40 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a056a00271000b0067459e92801sm15764843pfv.64.2023.07.05.05.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 05:06:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] ppc/pnv: SMT support for powernv
Date: Wed,  5 Jul 2023 22:06:27 +1000
Message-Id: <20230705120631.27670-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

These patches implement enough to install a distro, boot, run SMP KVM
guests with libvirt with good performance using MTTCG (as reported by
Cedric).

There are a few more SPRs that need to be done, and per-LPAR SPRs are
mostly not annotated yet so it can't run in 1 LPAR mode. But those can
be added in time, it will take a bit of time to get everything exactly
as hardware does so I consider this good enough to run common
software usefully.

Since RFC:
- Rebased against ppc-next (no conflicts vs upstream anyway).
- Add patch 4 avocado boot test with SMT, as was added with pseries SMT.
- Renamed POWERPC_FLAG_1LPAR to POWERPC_FLAG_SMT_1LPAR since it implies
  SMT.
- Fixed typos, patch 1, 3 changelogs improvement (hopefully).

Since v1:
- Fix clang compile bug
- Fix LPAR-per-thread bug in CTRL/DPDES/msgsndp in patch 1
- Add 2-socket test case to powernv Linux boot avocado test
- Remove SMT caveat from docs/system/ppc/powernv.rst

Thanks,
Nick

Nicholas Piggin (4):
  target/ppc: Add LPAR-per-core vs per-thread mode flag
  target/ppc: SMT support for the HID SPR
  ppc/pnv: SMT support for powernv
  tests/avocado: Add powernv machine test script

 docs/system/ppc/powernv.rst  |  5 ---
 hw/ppc/pnv.c                 | 12 +++++
 hw/ppc/pnv_core.c            | 13 +++---
 hw/ppc/spapr_cpu_core.c      |  2 +
 target/ppc/cpu.h             |  3 ++
 target/ppc/cpu_init.c        | 14 +++++-
 target/ppc/excp_helper.c     |  4 ++
 target/ppc/helper.h          |  1 +
 target/ppc/misc_helper.c     | 29 ++++++++++++
 target/ppc/spr_common.h      |  1 +
 target/ppc/translate.c       | 27 ++++++++---
 tests/avocado/ppc_powernv.py | 87 ++++++++++++++++++++++++++++++++++++
 12 files changed, 179 insertions(+), 19 deletions(-)
 create mode 100644 tests/avocado/ppc_powernv.py

-- 
2.40.1


