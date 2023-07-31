Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C9769936
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTgT-0005WW-GV; Mon, 31 Jul 2023 10:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgR-0005Vd-60
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgP-0007eQ-Bq
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso42439355e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812935; x=1691417735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qvygQ0COgngCU7qc2BFLcdA0T/qIUSKjC7okGba7Vpw=;
 b=h2AGp2mfiJmW+smK1p2KmaWYxD9fzZNpaftvEPwHOuGcumrngDEXjYtxjg38iQqV7H
 8R/UVZAZJraYAU7eXfSvLpTIJicqtoGu+Q3zkCaeCm3uCoi+cdAiy9ojZZO4IrQ7keeo
 65ztZZC2JSdVdMtQ4UAt2mzoT5z/TJeNr/Oq5UTeAG5mldrsv72Z3VmjEm/V2Tz7Csfr
 0KRY388TAfIjQo7TD6tKf38M9F1KFeK+R3LBL9sWsqd/1xk3Cp2t2CvLxF/sRFj+v3z5
 E7BgQnNl4A6OSBEFGiorPDKcojPku+fLqtJZxbGtwg/LoKMGnq3gWKsQcJINg3OyAikZ
 eKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812935; x=1691417735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qvygQ0COgngCU7qc2BFLcdA0T/qIUSKjC7okGba7Vpw=;
 b=QChv228Ligv1j+T85/nmITPAvWrsV4mbXWonOrpcEbeTmyCy2zqVSwPHTvVCOmTzPy
 gptzYFwDLKpTV/WBC+XLXdeeT1a0fzCVPW8H1BZEqdMpO7Nx78phnueFQnGSVoHw5xml
 jIlve+vLjCeu8dJ6JISR/974OCfO9A4Itz410DPKGjbLtnMcjQq1+9wrFlRxjmFOWWd7
 HmHoxaD7ZF2lnSSYahvCVDcOaEz3Pff4DCiakpI5RUf754bxdUxGh8MrPBu52OCIhPo1
 i11tQ9RjssvNHYPSIpeHMU4awbuDFxawSYWcBCZo2E2dMGoSDbCrXfGKhMQnVn5nIT2g
 /Gtw==
X-Gm-Message-State: ABy/qLbTooPkpdcU68ozCSlcml84AAvfL5PgGqLxzG8p1rgFuSc9JK7t
 wDE8MR5BQWlhY4fngtZ659xhJiyhOIkYjkQjMyg=
X-Google-Smtp-Source: APBJJlEu77wv3oY9MN/au+iJXjBf5I3C08+vHSoLzwZKiNjyYcYFpQYTgUZ4q2hpefisOkqNZ07MgA==
X-Received: by 2002:a1c:f309:0:b0:3fc:e7d:ca57 with SMTP id
 q9-20020a1cf309000000b003fc0e7dca57mr69957wmq.2.1690812935423; 
 Mon, 31 Jul 2023 07:15:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm11450675wmz.29.2023.07.31.07.15.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 07:15:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] target-arm queue
Date: Mon, 31 Jul 2023 15:15:27 +0100
Message-Id: <20230731141533.3303894-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi; here's a target-arm pull for rc2. Four arm-related fixes,
and a couple of bug fixes for other areas of the codebase
that seemed like they'd fallen through the cracks.

thanks
-- PMM

The following changes since commit ccb86f079a9e4d94918086a9df18c1844347aff8:

  Merge tag 'pull-nbd-2023-07-28' of https://repo.or.cz/qemu/ericb into staging (2023-07-28 09:56:57 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20230731

for you to fetch changes up to 108e8180c6b0c315711aa54e914030a313505c17:

  gdbstub: Fix client Ctrl-C handling (2023-07-31 14:57:32 +0100)

----------------------------------------------------------------
target-arm queue:
 * Don't build AArch64 decodetree files for qemu-system-arm
 * Fix TCG assert in v8.1M CSEL etc
 * Fix MemOp for STGP
 * gdbstub: Fix client Ctrl-C handling
 * kvm: Fix crash due to access uninitialized kvm_state
 * elf2dmp: Don't abandon when Prcb is set to 0

----------------------------------------------------------------
Akihiko Odaki (1):
      elf2dmp: Don't abandon when Prcb is set to 0

Gavin Shan (1):
      kvm: Fix crash due to access uninitialized kvm_state

Nicholas Piggin (1):
      gdbstub: Fix client Ctrl-C handling

Peter Maydell (2):
      target/arm: Avoid writing to constant TCGv in trans_CSEL()
      target/arm/tcg: Don't build AArch64 decodetree files for qemu-system-arm

Richard Henderson (1):
      target/arm: Fix MemOp for STGP

 accel/kvm/kvm-all.c            |  2 +-
 contrib/elf2dmp/main.c         |  5 +++++
 gdbstub/gdbstub.c              | 13 +++++++++++--
 target/arm/tcg/translate-a64.c | 21 ++++++++++++++++++---
 target/arm/tcg/translate.c     | 15 ++++++++-------
 target/arm/tcg/meson.build     | 10 +++++++---
 6 files changed, 50 insertions(+), 16 deletions(-)

