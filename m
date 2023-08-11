Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4077779717
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 20:26:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWpF-0002OO-U3; Fri, 11 Aug 2023 14:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUWpD-0002Ms-BX
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 14:25:27 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUWpA-0003oI-D6
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 14:25:27 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-799761430c2so629941241.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691778304; x=1692383104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iQWGIGyjSjTmqkt22c86absvPht5A+dob6U27lQudSo=;
 b=iNvctOem7OnCJ0t+IWI54p56H7eI7HTaw/U15Yg0Lt/7HgFLM/+esfsZ2FqR0r2AV1
 /xSwe5WOVmzxKHW3cBSxm0yLTckEGIk/iEoxEQ6ZjbJ8SqMTr+geo+BaPWLAofQSqgJi
 +BCZF3gtLQ75CSmMIMM8w/KBZkAY2lBuusYH6eU7j6LcByyNxzxvFwsXNxu3KDBhwW/p
 wR+w5fCto3WlJDeOH7mPGxH+xA/85qqVNp3DbnGyVfWtRgkYJQnZT69NEh/KUE0ZXrLA
 tO1MBOCrL7VW6h11354zuOuMp9+nirpEstwPLeK5B5tEk9vL8pm4kO2qZmKFH9cZdxZQ
 siSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691778304; x=1692383104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iQWGIGyjSjTmqkt22c86absvPht5A+dob6U27lQudSo=;
 b=FzXz7A+1Swx1kAyjIaq41TUQEMU6jLaMWMh0hlZO7BBX6nr11xq39kZWvufrSKGV+V
 l43MQwpgepOgIr7HiRd+c82NAdr8tX0IskGcZAP7q1Gp0xtXW5O2EN8LHcFgMD5reP5r
 FWHeyBbOhhlwcd9KAGjcJogH3mgMJpFlUvCSMs0DbxSTRKCmTfURSe0TOF6/wkauqgou
 G9IJXy4IMZjQLjcFrQktPhIXTp7WLqaEmC9SpwW4QHlhVW7JFiG0EiAL7kipxQUjGU6M
 eqlfGr3aVsgBckWYOlBByOx1WpMPDUstlbS/pt+6Ftgj289QjAJIJRXBQ9Q42C9oPnzB
 3jSg==
X-Gm-Message-State: AOJu0Yx0fUKnLk8uzVjsdReRT5XPWYLfvLye/5mhM6dFIlan4MLBlgRP
 bG3P5mEPvE+tj9GhOqx25tlI8+FqgoDi4Nmt
X-Google-Smtp-Source: AGHT+IEiDezpV6yT/Ys/7GYINjcDsLJAejL3cI6uxWt1LyZfzNgEF2Xnk3qy6cKSZvuacOQuq5mCLg==
X-Received: by 2002:a05:6102:4a9:b0:444:ca59:57a6 with SMTP id
 r9-20020a05610204a900b00444ca5957a6mr2469777vsa.8.1691778304580; 
 Fri, 11 Aug 2023 11:25:04 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
 by smtp.gmail.com with ESMTPSA id
 g30-20020ab016de000000b007876731f2dbsm638234uaf.22.2023.08.11.11.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 11:25:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/2] riscv-to-apply queue
Date: Fri, 11 Aug 2023 14:24:43 -0400
Message-ID: <20230811182445.1185140-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 3944e93af06f06eb07316e0bef46b007573e0309:

  Update version for v8.1.0-rc3 release (2023-08-10 12:49:56 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230811-3

for you to fetch changes up to b274c2388e9fcde75d60c6e7c7d8f888874b61b7:

  hw/riscv/virt.c: change 'aclint' TCG check (2023-08-11 14:16:26 -0400)

----------------------------------------------------------------
Sixth RISC-V PR for 8.1

This is a last minute PR for RISC-V.

The main goal is to fix
https://gitlab.com/qemu-project/qemu/-/issues/1823
which is a regression that means the aclint option
cannot be enabled.

While we are here we also fixup KVM issue.

 * KVM: fix mvendorid size
 * Fixup aclint check

----------------------------------------------------------------
Daniel Henrique Barboza (2):
      target/riscv/kvm.c: fix mvendorid size in vcpu_set_machine_ids()
      hw/riscv/virt.c: change 'aclint' TCG check

 hw/riscv/virt.c    | 20 +++++++++++++-------
 target/riscv/kvm.c |  9 ++++++++-
 2 files changed, 21 insertions(+), 8 deletions(-)

