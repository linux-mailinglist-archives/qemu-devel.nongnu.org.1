Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 946BF7F5C57
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:32:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66z3-000603-U1; Thu, 23 Nov 2023 05:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66yf-0005ql-8W; Thu, 23 Nov 2023 05:30:36 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66ya-0006bu-El; Thu, 23 Nov 2023 05:30:32 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5bd099e3d3cso450061a12.1; 
 Thu, 23 Nov 2023 02:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700735426; x=1701340226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=88X429hdm82eN1N5tztqHF9L+1Np9uq1z6GRyO2coPo=;
 b=muKl5nstGC3XJLvOA0EQb8WlRvyQCME8XYZaKHH1iBc/JtEsXn/dBW+KmVeQCrPZQF
 3W/mdqE1Wv+YcRVwKGTwjSNpS9gO/uxKZ1zl6csEKsqH4GPJpGXBmL/ZW75Ji15SRC2B
 s4gC14mMVY1QNonfRd3936uln+Ty/oHOhHrQGcU+Llwjw+Qkafd+2hxrbDSG3JYfFz6n
 ypPwQEQXjpD54G9yhE99pT1JAInMrFUpuhIZvSFktMTl9QVy6kuG66WE0qDCTXKqKaaa
 K5LVeUtlOvwtXbdXRZmJJjPwfjWK+cHKwQwwJ4A60hCbs20iwodqE6svEUVc0hJHogaN
 0IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735426; x=1701340226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=88X429hdm82eN1N5tztqHF9L+1Np9uq1z6GRyO2coPo=;
 b=T3sKo087sIp9QJnSU4m78yihNmtxrQ6MxWdYq7KQFNvPc3TQXB8EhCXPmK5kTFbdQb
 8z/NTNriFFlDCzRQBVtcqbyVWxLchrFXwYUjXbvaXErO+TG8fyb6mGu5qzsgn1TvATQu
 9Jq5zt/3UwpqidtODA33OtxzDMz7sHp4Z+Xe989wsEnSOr+cbI0oaEdNY4QjZlYIbp/R
 fYnmqv2Z102TBp6wQtNgTHE1HDzF5+g7jbXAP+HDaH+GL9bYit9qhMZKWSGH8LNOrXI1
 3ZKZH7+HhytSAgEELrJIp47iNA4RBDLpXovVxoImkTQDk7f0/UwOPsCeyZABEExnpcHN
 n+Bw==
X-Gm-Message-State: AOJu0YxnAuHsQN16CSmpXdjbAElUclg489SUILpOzXNXVvytxaeJ8CBW
 uV3b5qxUEs8by6G3nYs3ranfXZ/suLQ=
X-Google-Smtp-Source: AGHT+IHz9cTi6bj2tymvX1QuHDtxPNcsZzKiQlN4bKPrxJxn8AQ6zKf/3kNWNg+dB6/R5ZkDhMOyZg==
X-Received: by 2002:a05:6a20:5610:b0:187:4118:141 with SMTP id
 ir16-20020a056a20561000b0018741180141mr4393829pzc.5.1700735425886; 
 Thu, 23 Nov 2023 02:30:25 -0800 (PST)
Received: from wheely.local0.net (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001cc1dff5b86sm1009070pld.244.2023.11.23.02.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:30:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/7] ppc: pnv ChipTOD and various timebase fixes
Date: Thu, 23 Nov 2023 20:30:11 +1000
Message-ID: <20231123103018.172383-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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


