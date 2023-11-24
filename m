Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88B7F6C68
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:41:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Prc-00020Q-83; Fri, 24 Nov 2023 01:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PrW-0001zQ-Nv; Fri, 24 Nov 2023 01:40:26 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PrU-0005ym-Ti; Fri, 24 Nov 2023 01:40:26 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6cbe7386263so990385b3a.2; 
 Thu, 23 Nov 2023 22:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700808023; x=1701412823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lXsCpWfuWuBrHIJjGc1TTRFIsy+JpYWHEwrxjkX9OcA=;
 b=ZT9kPldISyzajZ39RZc0mijG5JbmDxlp0fOl7um9/fsl+ldYUg0pLPc+cLURA4n1TU
 /u6l5e9KPI6Ti7sV0Jszc7/MX7wDWLXDq9W3NXEUyqx3/GG4gWFE95Mlvp2tJA0X3K6m
 qz/nPAhyZgf3EPTPLbMB2VXzV8PCzV8GEsvUZDUcv+dn4z1nYy/JX7dTASx7XL9cbJ9K
 pvg6Szb9pqTq6Xl4b5VDPIysdk3PiHnB3LU76E3O3B4t/ojdLQUkFz3G4/nHNBW7SjiK
 StTKwc99p3tB6UK9eLLVI//nhyEtLMr3yj2w8jDv8I1NVrJrp/gJ7LM7OeKu5nkDqXns
 we4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700808023; x=1701412823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lXsCpWfuWuBrHIJjGc1TTRFIsy+JpYWHEwrxjkX9OcA=;
 b=SqpYQMa9iqf6oVaGnt1gx1TtpDoA+bOI88wOdqdkGx/Lg4dvqJhEXjjeQXY0pWpbR0
 koAFCrFHOuPxx6OiEIGcoMcMR6LqSIKI2rbz899gN4kJoZ0em7GSdP+P3HuWMUppH3W1
 7+WGjStSswkXe/eVkU8lhUUPYbZAJtB1FyPLEJRDipwySc9ZUU3MG9epzNZ2H88zLGfd
 3rWGt38a4kQZNo9uhaDdjotc0KSc7XAFm0ApmFz/DXaLG/HLU6GQHOKCiGMVfYRPlRzo
 s9GGWrDELkNUYc9s7KZDXHK0n0q/MfLJ/C/j14qlEu3bgx7V6ew2tjzlf80O/mMAeNWS
 2DSw==
X-Gm-Message-State: AOJu0YzRXoozZQy5+Xe1zd2t0Db0BqyWii5kq2elKsqWxiUb4f1T0bAc
 N3mt2ZIJMXI3HIWxMf1WiYUJc3eIAQJXBg==
X-Google-Smtp-Source: AGHT+IFAkK0BjxeWZ67Qk1MdJSdzz+LhK8hViyyYLH45JvV4+15bZaUjsXuxTxfD/wIt6DQrnCXAUQ==
X-Received: by 2002:a05:6a00:21c7:b0:690:ce30:47ba with SMTP id
 t7-20020a056a0021c700b00690ce3047bamr1993629pfj.10.1700808022786; 
 Thu, 23 Nov 2023 22:40:22 -0800 (PST)
Received: from wheely.local0.net ([1.145.239.154])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a62f249000000b006cb8a8a4bbfsm2152013pfl.186.2023.11.23.22.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 22:40:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] ppc: pnv ChipTOD and various timebase fixes
Date: Fri, 24 Nov 2023 16:39:54 +1000
Message-ID: <20231124064001.198572-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Since v1 of combined chiptod+timebase fixes series (most improvements
thanks to Cedric):
- Cut down unused ChipTOD FSM states, documented it, and added more
  state/transition checking.
- Only return running status if TOD FSM is RUNNING.
- Add reset function that sets TOD to ERROR state as per workbook.
- Put "TTYPE" broadcasting to other chip TODs into a class function.
- Put TOD-to-core TTYPE addressing into a class function.
- Move hacky addressing helpers private to pnv_chiptod.c
- Small changelog improvements.
- Minor changelog and comment typos and improvements, variable and
  function name improvements, format string fixes.

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

 include/hw/ppc/pnv.h         |   2 +
 include/hw/ppc/pnv_chip.h    |   3 +
 include/hw/ppc/pnv_chiptod.h |  54 ++++
 include/hw/ppc/pnv_xscom.h   |   9 +
 target/ppc/cpu.h             |  50 ++-
 hw/ppc/pnv.c                 |  45 +++
 hw/ppc/pnv_chiptod.c         | 611 +++++++++++++++++++++++++++++++++++
 target/ppc/helper_regs.c     |  39 ++-
 target/ppc/ppc-qmp-cmds.c    |   4 +
 target/ppc/timebase_helper.c | 309 +++++++++++++++++-
 target/ppc/translate.c       |  42 ++-
 hw/ppc/meson.build           |   1 +
 hw/ppc/trace-events          |   4 +
 13 files changed, 1148 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/ppc/pnv_chiptod.h
 create mode 100644 hw/ppc/pnv_chiptod.c

-- 
2.42.0


