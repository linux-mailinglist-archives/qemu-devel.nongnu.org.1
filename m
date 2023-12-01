Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6A800AD7
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:26:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92a1-0004mb-7T; Fri, 01 Dec 2023 07:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92Zx-0004lU-Nf; Fri, 01 Dec 2023 07:25:09 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92Zw-0002wl-48; Fri, 01 Dec 2023 07:25:09 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28613d87c4cso1872672a91.3; 
 Fri, 01 Dec 2023 04:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433506; x=1702038306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88X429hdm82eN1N5tztqHF9L+1Np9uq1z6GRyO2coPo=;
 b=lkAgTJfApeux3Mc3ZoQNKmVMkeGMANJqTR6HjNfyJFnVuVr3QtdoRAvFV9cc1S6uGJ
 HnNeQcyFPtB0AoYRZVb19H9TeLJkyy9iXCBXx2iwYw+hH6qqp5Riss0IE3LMOERHfml4
 n/SCPOVcd7suZX/zzpqmuetoG7OmoB+jG7IK71QYXxhVXLanAtunxbCFiOqzqy8PsFxs
 TpMdw2EDlFm2dE0ytTV1sOSUmzOvu8Eplg4N+mIb6KDev0oekUmJfJbeOWE0z8CV+Kb9
 TNvo1D6MLoLJIo3f5vc326nXWu4HqEezg2/BOLCy55gtN7kFExybRorZtNBjjUfqzNJb
 j5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433506; x=1702038306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88X429hdm82eN1N5tztqHF9L+1Np9uq1z6GRyO2coPo=;
 b=kTx2YlTRy1OPzZtKt2I7br9e8RV+r5mU62CAKDU+xucxP8Rpn5mRagZ+MxJjsiOfKZ
 inT8usyBw5a4y41VpgCHRziLd3sAo77lAx9PzZuy++orwiXpQbYzvWVzEYR7NqNrqebu
 jpX9CBL1FIaNfMS9IYQiCP6qrveYS30be44bwu+UbLHksVLdA+7QHDtLAzzEmKparLFg
 vXTl5qea0sSAYvFrc8oYw73ZdJKngfhZe9kTPZY278yg2WHwHeJ/7hwA7fKz3lZq1ewI
 sTrxTvCWk879/wjkDC1sJc43xMJKkoRs16bYo5IReP+/KS2O4W1DuDop6uQoJBg4cGw9
 T2tQ==
X-Gm-Message-State: AOJu0YwTlWDeidxQeTavasxd4XbPTDgpfdXnR8Xr4/ZIFnhNUPSOXKpL
 WlB3DXbcSmpuVtAUXGveOjgMr/Nw+8M=
X-Google-Smtp-Source: AGHT+IFSNCr997eJLdN2Q097u2m2P4jWefCJfyVdcCCGQROCEbWqG2E31YdMbOBSCsUaUJEb5VJKxg==
X-Received: by 2002:a17:90b:3e89:b0:285:ff7d:ad6b with SMTP id
 rj9-20020a17090b3e8900b00285ff7dad6bmr11241767pjb.4.1701433505617; 
 Fri, 01 Dec 2023 04:25:05 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 1-20020a17090a19c100b00280070a2613sm5355932pjj.51.2023.12.01.04.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:25:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 0/7] ppc: pnv ChipTOD and various timebase fixes
Date: Fri,  1 Dec 2023 22:24:55 +1000
Message-ID: <20231201122455.143936-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201122455.143936-1-npiggin@gmail.com>
References: <20231201122455.143936-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

The chiptod/TFMR/state machine is not really tied to the other
time register fixes, but they touch some of the same code, and
logically same facility.

Changes since v1 of chiptod patches:
- Split hackish ChipTOD<->TFMR/TBST interface into its own patch
- Fix multi-socket addressing on P9 / chip ID mode (P10 works)
- Change chiptod primary/secondary setting to use class properties
- Add more comments to explain TOD overview and timebase state
  machine.
- SMT support for TFMR, some functionality is limited to thread 0.
- FIRMWARE_CONTROL_ERROR bit implemented in TFMR.
- Misc cleanups and bug fixes.

The hacky part, addressing core from chiptod, is still hacky. Is
there strong objection to it?

This successfully runs skiboot chiptod initialisation code with
POWER9 and POWER10 multi-socket, multi-core, SMT. That requires
skiboot 7.1 (not in-tree), otherwise chiptod init is skipped on
QEMU machines.

Thanks,
Nick

Nicholas Piggin (7):
  target/ppc: Rename TBL to TB on 64-bit
  target/ppc: Improve timebase register defines naming
  target/ppc: Fix move-to timebase SPR access permissions
  pnv/chiptod: Add POWER9/10 chiptod model
  pnv/chiptod: Implement the ChipTOD to Core transfer
  target/ppc: Implement core timebase state machine and TFMR
  target/ppc: Add SMT support to time facilities

 include/hw/ppc/pnv_chip.h    |   3 +
 include/hw/ppc/pnv_chiptod.h |  55 ++++
 include/hw/ppc/pnv_core.h    |   4 +
 include/hw/ppc/pnv_xscom.h   |   9 +
 target/ppc/cpu.h             |  50 +++-
 hw/ppc/pnv.c                 |  63 +++++
 hw/ppc/pnv_chiptod.c         | 509 +++++++++++++++++++++++++++++++++++
 target/ppc/helper_regs.c     |  39 ++-
 target/ppc/ppc-qmp-cmds.c    |   4 +
 target/ppc/timebase_helper.c | 309 ++++++++++++++++++++-
 target/ppc/translate.c       |  42 ++-
 hw/ppc/meson.build           |   1 +
 hw/ppc/trace-events          |   4 +
 13 files changed, 1067 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/ppc/pnv_chiptod.h
 create mode 100644 hw/ppc/pnv_chiptod.c

-- 
2.42.0


