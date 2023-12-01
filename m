Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA0800ABA
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:18:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92SU-0005YJ-Qg; Fri, 01 Dec 2023 07:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92Rz-0005WZ-3f; Fri, 01 Dec 2023 07:16:55 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92Ru-0006Ic-Ip; Fri, 01 Dec 2023 07:16:54 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6cdfb721824so734943b3a.3; 
 Fri, 01 Dec 2023 04:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433005; x=1702037805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lpcw7+ztIQtQXg4jYFmRkunL+gpWzDaScOqJZ1WZZ1M=;
 b=VB+tvq7e0vb6KIHc7eevYLbAZ1HesnYynvpvG/ecYiMZZQpIv7aZckVdp6d/YXlCh0
 /byr23yWTyDSs9jHUANDOT/V4HaKagSbWb1xpWtNg2hOfrbY1ULUB+EH16NStlPmSi8X
 xzGWZ9PsPyQWJroUjrw4hdtFUUSodUlPbZqC5ASFvik+KqWZaX3LJzKG8zSAzWgAT2zr
 TPjhz8D1pq4N7LRm9xbbhXHDYgSJCazE2HRiBJXt1G49bJuoBLTDZcezgTT6BEAL45/O
 IohH6ntUHJusU/6b7JgBKWCMeBeGAhokr2rxAENBRsYR4Ew/Eszu9HJ1g8l3h2HmTvGN
 w/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433005; x=1702037805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lpcw7+ztIQtQXg4jYFmRkunL+gpWzDaScOqJZ1WZZ1M=;
 b=QByiMSopRQ1UkGQt4znaWMaCYLbt1Eh2xIQ5K+XtnnytHjlxlG9z76UEVCsY6Q8uAW
 fFX99FJRMYELR39e+dRZgCM01Mda45oTpAYDOzVf5+2zp7czdP3LaBrgfLP1vEzM6Yiv
 vajKDvqmljnZ1iBOmUixift/gW8LYv0U3QnoAQVH8iLob4XhaYpsNFcshBSTWCrWAW3r
 L6adq4L1evxT42aocUC3w5VVBlgtJySU0hgeeXVd+xrDI4ij4SuuTFOsZgFgvbE4yZpy
 ZVJTf7GLJUTzzJEAqSfrvsQ1S/ZnR8j2/zHWkMOs1whEJcH5ns56jX+NvHE4NoPC2Gtb
 lc6A==
X-Gm-Message-State: AOJu0YxhOism5SIEpnliQFoCPTvkCR9LKgzDj2UrAbKfbrBCATpl/Fbj
 TLTVN50vgG8m7xcrAgISJRlNWczmDIU=
X-Google-Smtp-Source: AGHT+IH7zRZl+wtIsDHfSd0UWFbDq9L48KlPfbumRs9DCp+hhF+NbuAC5u+7fMxnk3jaQd91d68a2w==
X-Received: by 2002:a05:6a20:5491:b0:18c:5e1:77b8 with SMTP id
 i17-20020a056a20549100b0018c05e177b8mr25849566pzk.58.1701433005099; 
 Fri, 01 Dec 2023 04:16:45 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006cdd39faaaesm2830782pfd.20.2023.12.01.04.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:16:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/8] ppc: pnv ChipTOD and various timebase fixes
Date: Fri,  1 Dec 2023 22:16:28 +1000
Message-ID: <20231201121636.142694-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

This accumulated a few changes and review comment fixes since v2:
- Remove the now unnecessary class xscom ops.
- Split the introduction of the chiptod model from wiring it to
  machines.
- Fix chiptod model patch changelog.
- Wrap chiptod/tb state machine variables in CPUArchState in a struct.

Will put this in the next merge window if no objections. Thanks to
Cedric for all the review and help.

Thanks,
Nick

Nicholas Piggin (8):
  target/ppc: Rename TBL to TB on 64-bit
  target/ppc: Improve timebase register defines naming
  target/ppc: Fix move-to timebase SPR access permissions
  pnv/chiptod: Add POWER9/10 chiptod model
  ppc/pnv: Wire ChipTOD model to powernv9 and powernv10 machines
  pnv/chiptod: Implement the ChipTOD to Core transfer
  target/ppc: Implement core timebase state machine and TFMR
  target/ppc: Add SMT support to time facilities

 include/hw/ppc/pnv.h         |   2 +
 include/hw/ppc/pnv_chip.h    |   3 +
 include/hw/ppc/pnv_chiptod.h |  53 ++++
 include/hw/ppc/pnv_xscom.h   |   9 +
 target/ppc/cpu.h             |  57 +++-
 hw/ppc/pnv.c                 |  45 +++
 hw/ppc/pnv_chiptod.c         | 586 +++++++++++++++++++++++++++++++++++
 target/ppc/helper_regs.c     |  39 ++-
 target/ppc/ppc-qmp-cmds.c    |   4 +
 target/ppc/timebase_helper.c | 309 +++++++++++++++++-
 target/ppc/translate.c       |  42 ++-
 hw/ppc/meson.build           |   1 +
 hw/ppc/trace-events          |   4 +
 13 files changed, 1129 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/ppc/pnv_chiptod.h
 create mode 100644 hw/ppc/pnv_chiptod.c

-- 
2.42.0


