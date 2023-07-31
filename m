Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD4D76A25D
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa1y-0000oR-L3; Mon, 31 Jul 2023 17:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1w-0000nJ-CS
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:16 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1u-0006Lh-OV
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:16 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-267fc19280bso3994469a91.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837333; x=1691442133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vFQyG0oQPZPOgBGUUKWB+Ob+Xif64TY7Jsa7q8Jf29E=;
 b=IKCkaU3oOrvmOg6N4aI8ucbDQTEmeBtZoA6cKImSJiIY4V2lz86TmyYohTPQbE9pr9
 JdNYgx+LW6yGQx4HQxMNR/wnO2CAPmyp69mFeExH0EDcWIPVRzLJhKx3P5W7Ql/Zt0Kk
 lAc3Ip6CCg7+P7xD5Hp1dpBA4hJy2e7eYReT04L8zjoCuKkfpEOslw6dvbtua4CE59o+
 sPy4dFgvwCJcDVReQ8giohiIukz3R4uk00wXsJZQ5X+9ePIMi6VTEMkNAfvZUMhQgiwp
 G0rlMTi+RanqGRP61KbxhDuZcZ63ynYB1yniDStXjtQAsYOlzhBbwwoDK5a1Ze/BXnDF
 C6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837333; x=1691442133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFQyG0oQPZPOgBGUUKWB+Ob+Xif64TY7Jsa7q8Jf29E=;
 b=dKdPa8/fJPzSWLzSqtgk/CKQnXi5mZRY/1m3qHyMvuoZO8PWQcSC/vOaYvt+y1BKth
 H3CUjK/fAES9R35xf23kCGZElMc9/EuuI5ANK+mgX/lnLG2PuKFo2q2RtDDRZvlidpOp
 YUMFZco63TXG2pzL46WmlCwJvvq5p6Z6uwuZwATYQ5aPHc3pQu6SpVrDmPs0QcCT7tNX
 /QIGo/qydW4qtvKyyk+/2L8PB3snpOKP1uopoRWhnihY/b0Lkrn68zcaiA6pu7Uzp15l
 uwXtvTqm0nCD4+6lXJi4c4uJLIgROKfklRsZHSbQ8L0/qj8rssBxt+VlsTlWt5ROnCXR
 Rjbg==
X-Gm-Message-State: ABy/qLZf2cFTClVlzKTkkw0UFaXCVGa2WEBCWJ4aJbb/yd4tskyRFqgN
 LRutC9LUFbxYcFMhSM9mIppzHqR3VG+N62dm9OA=
X-Google-Smtp-Source: APBJJlHdme8WRXU/ht6zDvNYnt3qVO4AvcG+PGZety9y9FX+Ej7LL5McNR3FexlP9xEyRU4jlzTMWA==
X-Received: by 2002:a17:90a:318c:b0:267:f1d7:ed68 with SMTP id
 j12-20020a17090a318c00b00267f1d7ed68mr12621215pjb.14.1690837332951; 
 Mon, 31 Jul 2023 14:02:12 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] tcg patch queue for rc2
Date: Mon, 31 Jul 2023 14:02:01 -0700
Message-Id: <20230731210211.137353-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

The following changes since commit 234320cd0573f286b5f5c95ee6d757cf003999e7:

  Merge tag 'pull-target-arm-20230731' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-07-31 08:33:44 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230731

for you to fetch changes up to 8b94ec53f367db7adcc9b59c483ce3e6c7bc3740:

  target/s390x: Move trans_exc_code update to do_program_interrupt (2023-07-31 12:19:13 -0700)

----------------------------------------------------------------
util/interval-tree: Access left/right/parent atomically
accel/tcg: Clear gen_tb on buffer overflow
bsd-user: Specify host page alignment if none specified
bsd-user: Allocate guest virtual address space
target/ppc: Disable goto_tb with architectural singlestep
target/s390x: Move trans_exc_code update to do_program_interrupt

----------------------------------------------------------------
Helge Deller (1):
      linux-user/armeb: Fix __kernel_cmpxchg() for armeb

Richard Henderson (8):
      util/interval-tree: Use qatomic_read for left/right while searching
      util/interval-tree: Use qatomic_set_mb in rb_link_node
      util/interval-tree: Introduce pc_parent
      util/interval-tree: Use qatomic_read/set for rb_parent_color
      accel/tcg: Clear tcg_ctx->gen_tb on buffer overflow
      bsd-user: Allocate guest virtual address space
      target/ppc: Disable goto_tb with architectural singlestep
      target/s390x: Move trans_exc_code update to do_program_interrupt

Warner Losh (1):
      bsd-user: Specify host page alignment if none specified

 accel/tcg/translate-all.c      |  1 +
 bsd-user/main.c                | 48 ++++++++++++++++++++++---
 bsd-user/mmap.c                |  3 +-
 linux-user/arm/cpu_loop.c      |  9 +++--
 target/ppc/translate.c         |  3 ++
 target/s390x/tcg/excp_helper.c | 40 ++++++++++++++-------
 util/interval-tree.c           | 79 +++++++++++++++++++++++++-----------------
 7 files changed, 132 insertions(+), 51 deletions(-)

