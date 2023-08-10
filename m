Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D072C777FFB
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUA60-0001yo-Sy; Thu, 10 Aug 2023 14:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5o-0001wz-EE
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:05 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5h-0001xw-CE
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:03 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso10702435ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691690934; x=1692295734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=M9a6lo9Zrh5qWxWrIPmne0yaP0A6AxsHyFDGKhdH2cw=;
 b=eZuGfs9SBxNsMC+TxRRygvvpmoQoEV+nNQ0Wuy+Dd7J8aGLEZMtbHif9RZuiT61VH+
 tfKdZ+4o7TLDZLSuRwHn/uU1uXscKUNdVGdwsyg4j9VxusNQUPaVHMWXMgrPUCzs5Udt
 6LE19SVoSjqMt8PnTWVyuDspIJoF8PPXK3itr0IHurfk2FJaQZ7SHfDTqmAZ9K586ZIr
 5p/CQcqvTMHvn4l6hzZTPF0eQ2p1fcjIC3JDOrNrS3vInvWygwmGCGbEmu8t/x5I9Um0
 31nRnf8R5aAsIDly+YytPs9Dk/AanO42Wd9wfOVymRDk/E66tz2uBrO+AN99jChIZJ6W
 PImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691690934; x=1692295734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M9a6lo9Zrh5qWxWrIPmne0yaP0A6AxsHyFDGKhdH2cw=;
 b=K/sdlaAzO7Dr0Yxa3zjNU7y29nOKV/VQ75JtxoRj+cGQJ73oX2AsCQkGkMyoQetxwu
 ruWicx0iNNmFK/gEAIJMubaXaisU2hi3jGk4mBMYZxPIim19Ku7vyt3EUCQM0+oqjuw4
 AadSBYQKSG/JO/kLDag3OdUnAnbDkxSSiWFatN6Jjn4g1REun6SRKnN9ZyY5C8PIrTEB
 RCNuN+rh5fzWXQCKYQO8CYO2pyZ1mvIUQArAhFeEILOxVkVYTAIr1LSMXATORHxeeOj1
 n70RCTDZmkjZJvi7q/BRz05pj7gKZAxKIJp8grfiV64j6UR9/EA6rbl83N7DR84gP7X7
 YRFg==
X-Gm-Message-State: AOJu0Yy7M8cPI+w7SPrlSee0ZD1T8vdrzqfnTTlnFBF3Qxn/QM5hIvZI
 j9+qw4/BK1uaCPX68i8Gw5vCeUUwVhMI1vo/bP8=
X-Google-Smtp-Source: AGHT+IGIJklHRAKNQ2E3eCZOsT8pU9YxwFK1BnaI/ZuEI13bSDtCokN0gl4FmRfyorCCFScZVFUQMA==
X-Received: by 2002:a17:902:d2c6:b0:1bc:203f:3b3c with SMTP id
 n6-20020a170902d2c600b001bc203f3b3cmr3536661plc.24.1691690934531; 
 Thu, 10 Aug 2023 11:08:54 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170902b60e00b001bd41b70b65sm2085212pls.49.2023.08.10.11.08.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 11:08:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] tcg/gdbstub late fixes
Date: Thu, 10 Aug 2023 11:08:48 -0700
Message-Id: <20230810180852.54477-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 64d3be986f9e2379bc688bf1d0aca0557e0035ca:

  Merge tag 'or1k-pull-request-20230809' of https://github.com/stffrdhrn/qemu into staging (2023-08-09 15:05:02 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230810

for you to fetch changes up to f1b0f894c8c25f7ed24197ff130c7acb6b9fd6e7:

  gdbstub: don't complain about preemptive ACK chars (2023-08-10 11:04:34 -0700)

----------------------------------------------------------------
accel/tcg: Avoid reading too much in load_atom_{2,4}
tests/tcg: ensure system-mode gdb tests start stopped
gdbstub: more fixes for client Ctrl-C handling

----------------------------------------------------------------
Alex Bennée (3):
      tests/tcg: ensure system-mode gdb tests start stopped
      gdbstub: more fixes for client Ctrl-C handling
      gdbstub: don't complain about preemptive ACK chars

Richard Henderson (1):
      accel/tcg: Avoid reading too much in load_atom_{2,4}

 gdbstub/gdbstub.c                 | 10 ++++++++--
 tests/tcg/aarch64/lse2-fault.c    | 38 ++++++++++++++++++++++++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc    | 10 ++++++++--
 gdbstub/trace-events              |  1 +
 tests/guest-debug/run-test.py     |  9 +++------
 tests/tcg/aarch64/Makefile.target |  2 +-
 6 files changed, 59 insertions(+), 11 deletions(-)
 create mode 100644 tests/tcg/aarch64/lse2-fault.c

