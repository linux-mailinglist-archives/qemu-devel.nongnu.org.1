Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB937E1642
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:13:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjTx-00039p-DG; Sun, 05 Nov 2023 15:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjTv-00039T-IM
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:27 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjTt-00027W-SY
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:27 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso3090906b3a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215144; x=1699819944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oi6VFs4RCF9MHarAKm/2EY9p+ikytl5LOoXeVlUMQKI=;
 b=ouEnnFqrACLMAtShcbKEo+x1Br/hQGJsudBKyxziaY0mFKhbJer15RU6SH2XDui8cJ
 J0NPAA3Rx1j/ZMHj1W1WWxCMZR1XseF468aR3K4eKKQxq8KLVJgpcjlF3X6eu9DkGf6Y
 OvVi6+9MbjS7rDTZLUqONEFkoZCYbCRzUE7YDNynX+o6MCF9bt9xVlgsdQh1a4ZQTgIP
 yUbaIpiZisJiDx6DjwZ3gCCZixgcdRYt3ep76dhNPza0eiWes4VCMqLQwhp4vl0/PNqs
 Dv1fI8NDrl/sSIFKHQqtTljsyw9Dj5PsD4YtAQraSFrDIpxL8b77NGLzi9HXc7trIkFo
 /aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215144; x=1699819944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oi6VFs4RCF9MHarAKm/2EY9p+ikytl5LOoXeVlUMQKI=;
 b=vvN0CrkcT5U9ipXzCmJ+c+lg1b6UKfxvZD6ZrnlEgjf7L9yM7MLCDTKpGDoQgT3sx6
 iWCysexcNfneuUjYnRc76VmGmTx63TnAITVmae7f6zVsGHur/FLmL6j7IlT3Vl/6FzqT
 l4pwLeiA6VhZNtobbVbaKA6PkaobV1VExyfrJuSHl5lYgn1RCOh5VOqIm3EbOo1X/4Vy
 BlkEXf7ZxnZwRyLUm+saz/QkXRaP4BrSLbEuOohGT+lebjjunM5ZPOx/bvGlRcE+SI9n
 snwjKihpnrU2ZPQ5tZ/7BwkTNYtOsGtDwzbs2PdHzLLmAnVM3ikgcDWJeU8IR89lu72J
 btsA==
X-Gm-Message-State: AOJu0YxenEwTE4YollunAZUdsCpXaC1W1sR+udz+NlM2jH5c/a92yH+P
 reO/LBeMc90Jj01ju5Sf+x5i4hFHBVI2DN3Jltk=
X-Google-Smtp-Source: AGHT+IEnZM8Wtuq9JKQxdKzAOx43I04bmoPT+C0drEf1ZxqK11Ale/t5P/fnCERGQzgUedozFnzXAA==
X-Received: by 2002:a05:6a00:15ce:b0:68b:e29c:b69 with SMTP id
 o14-20020a056a0015ce00b0068be29c0b69mr11049695pfu.9.1699215143891; 
 Sun, 05 Nov 2023 12:12:23 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] target/sparc: Cleanup condition codes
Date: Sun,  5 Nov 2023 12:12:01 -0800
Message-Id: <20231105201222.202395-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The following changes since commit d762bf97931b58839316b68a570eecc6143c9e3e:

  Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-sp-20231105

for you to fetch changes up to 2c4f56c9aa7e1e8a34428c4efe17788be11fb73f:

  target/sparc: Check for invalid cond in gen_compare_reg (2023-11-05 12:07:21 -0800)

----------------------------------------------------------------
target/sparc: Explicitly compute condition codes

----------------------------------------------------------------
Richard Henderson (21):
      target/sparc: Introduce cpu_put_psr_icc
      target/sparc: Split psr and xcc into components
      target/sparc: Remove CC_OP_LOGIC
      target/sparc: Remove CC_OP_DIV
      target/sparc: Remove CC_OP_ADD, CC_OP_ADDX, CC_OP_TADD
      target/sparc: Remove CC_OP_SUB, CC_OP_SUBX, CC_OP_TSUB
      target/sparc: Remove CC_OP_TADDTV, CC_OP_TSUBTV
      target/sparc: Remove CC_OP leftovers
      target/sparc: Remove DisasCompare.is_bool
      target/sparc: Change DisasCompare.c2 to int
      target/sparc: Always copy conditions into a new temporary
      target/sparc: Do flush_cond in advance_jump_cond
      target/sparc: Merge gen_branch2 into advance_pc
      target/sparc: Merge advance_jump_uncond_{never,always} into advance_jump_cond
      target/sparc: Pass displacement to advance_jump_cond
      target/sparc: Merge gen_op_next_insn into only caller
      target/sparc: Record entire jump condition in DisasContext
      target/sparc: Discard cpu_cond at the end of each insn
      target/sparc: Implement UDIVX and SDIVX inline
      target/sparc: Implement UDIV inline
      target/sparc: Check for invalid cond in gen_compare_reg

 linux-user/sparc/target_cpu.h |   17 +-
 target/sparc/cpu.h            |   58 +-
 target/sparc/helper.h         |   12 +-
 target/sparc/insns.decode     |    7 +-
 linux-user/sparc/cpu_loop.c   |   11 +-
 linux-user/sparc/signal.c     |    2 +-
 target/sparc/cc_helper.c      |  471 ---------------
 target/sparc/cpu.c            |    1 -
 target/sparc/helper.c         |  171 +++---
 target/sparc/int32_helper.c   |    5 -
 target/sparc/int64_helper.c   |    5 -
 target/sparc/machine.c        |   45 +-
 target/sparc/translate.c      | 1333 ++++++++++++++++++-----------------------
 target/sparc/win_helper.c     |   56 +-
 target/sparc/meson.build      |    1 -
 15 files changed, 789 insertions(+), 1406 deletions(-)
 delete mode 100644 target/sparc/cc_helper.c

