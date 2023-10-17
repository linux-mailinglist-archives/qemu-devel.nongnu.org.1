Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 627227CBB75
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdlT-0007q2-L9; Tue, 17 Oct 2023 02:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlR-0007pu-O7
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlP-0001pc-Sv
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:13 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso31342645ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524870; x=1698129670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xiYuE6LZKR+Ni9ajxMzMvQtYupTJfklVfqzTPwpZ/rQ=;
 b=HeypVC0ZPPcPvKGioPCFwMTnx93+eooM1EaOHwkaUzDvMtgN5/7EBZ72yAjenwUa/w
 5e4p0QG1bF+5J6p+Ftohd1cw8loA4lWddSS96L4VONKwrKMsLOKBnVnxlJjccPEvNXrx
 NZCmUXw4kkA+V/yu+ZeazHVgGmQ3Nvuf9N4F+gRo0LRi0zc+NRo1hnSEcvQwnrt3Ij23
 68KrkckRdNC+kwHqA5l/sEBntHnZfDmWZCNWNzqhey+h/zfnWNqWzugZ1/m/tYg4Ojns
 MoJM8RKyI1+eRp1s78Lg/4NiHoUpxUVz825FlcMsoxho/ylaRlhvfC3FTzWqX/oABCKO
 qCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524870; x=1698129670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xiYuE6LZKR+Ni9ajxMzMvQtYupTJfklVfqzTPwpZ/rQ=;
 b=nSTuj/1wbnz2pUnfTzZDgWQYBf3xaJTTuehFyZtMhLSMOrMnYpcqi1k9xBzgOhm+gK
 Wp+tzaMB44qdBRj6P011uj6Wk7qSJe5mwAUpx0QjwmWLx+1Zuo1O4dDczaHJF+fn8QRX
 wyZsj0Lei+t0iifPqA+KdSCOx4OStJvHHV11nSZuzGAfxixqwz7071YM4WD3OOdKr0RS
 NjYuxsnItmMzZuT/lVwzYb5DXpAwQPfqwSfQUjAdKnKUPBXR/bpPrZLcdW4wkcSIdpLt
 L20ShR0DNGhaqvR5d4J4hyaKxvM0EprLXjtG3A5ohWTWk/KGssl8iAY4F22k311z6Bh9
 9/3A==
X-Gm-Message-State: AOJu0Yyc9FrzjMbwKEoAS2USrNXZDaPfqoefxEAtf+I3tsUnPWUF1ffD
 aa+6dP2zkKuJQG/W+qHTFKqPTRHtBAEpLudn7YA=
X-Google-Smtp-Source: AGHT+IEE47Wy/RzxeDNUU53Q3Oag03qP17tTOta6/oJSfifKK8GN7bfqIwRnJWvmaD3W0sMVRKrZfA==
X-Received: by 2002:a17:903:28cd:b0:1c9:fb76:42f8 with SMTP id
 kv13-20020a17090328cd00b001c9fb7642f8mr1274776plb.68.1697524870344; 
 Mon, 16 Oct 2023 23:41:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 00/20] target/sparc: Cleanup condition codes etc
Date: Mon, 16 Oct 2023 23:40:49 -0700
Message-Id: <20231017064109.681935-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

This was part of my guess for some of the performance problems.

I saw compute_all_sub quite high in the profile at some point,
and I believe that the test case has a partially rotated loop
such that "cmp" is in a delay slot, and so the gen_compare fast
path for CC_OP_SUB is not visible to the conditional branch
that uses the output of the compare.  Which means that 
helper_compute_psr gets called much more often that we'd like.

Move away from CC_OP to explicit computation of conditions.
This is modeled on target/arm for the (mostly) separate
representation of the bits.  We can pack icc.[NV] and xcc.[NV]
into the same target_ulong, but Z and C cannot share.

After removing CC_OP, clean up the handling of conditions so
that we can minimize additional setcond required for env->cond.

Finally, inline some division, which can make use of the new
out-of-line exception path, which means we can expand UDIVX
and SDIVX with very few host insns.  The 64/32 UDIV insn needs
only a few more.  Leave UDIVcc and SDIV* out of line, as the
overflow and saturation computation in these cases is really
too large to inline.


r~

Based-on: 20231017061244.681584-1-richard.henderson@linaro.org
("[PATCH v2 00/90] target/sparc: Convert to decodetree")

Richard Henderson (20):
  target/sparc: Introduce cpu_put_psr_icc
  target/sparc: Split psr and xcc into components
  target/sparc: Remove CC_OP_DIV
  target/sparc: Remove CC_OP_LOGIC
  target/sparc: Remove CC_OP_ADD, CC_OP_ADDX, CC_OP_TADD
  target/sparc: Remove CC_OP_SUB, CC_OP_SUBX, CC_OP_TSUB
  target/sparc: Remove CC_OP_TADDTV, CC_OP_TSUBTV
  target/sparc: Remove CC_OP leftovers
  target/sparc: Remove DisasCompare.is_bool
  target/sparc: Change DisasCompare.c2 to int
  target/sparc: Always copy conditions into a new temporary
  target/sparc: Do flush_cond in advance_jump_cond
  target/sparc: Merge gen_branch2 into advance_pc
  target/sparc: Merge advance_jump_uncond_{never,always} into
    advance_jump_cond
  target/sparc: Use DISAS_EXIT in do_wrpsr
  target/sparc: Merge gen_op_next_insn into only caller
  target/sparc: Record entire jump condition in DisasContext
  target/sparc: Discard cpu_cond at the end of each insn
  target/sparc: Implement UDIVX and SDIVX inline
  target/sparc: Implement UDIV inline

 linux-user/sparc/target_cpu.h |    4 +-
 target/sparc/cpu.h            |   58 +-
 target/sparc/helper.h         |    9 +-
 linux-user/sparc/cpu_loop.c   |   23 +-
 linux-user/sparc/signal.c     |    2 +-
 target/sparc/cc_helper.c      |  471 -------------
 target/sparc/cpu.c            |    1 -
 target/sparc/helper.c         |  156 ++---
 target/sparc/int32_helper.c   |    5 -
 target/sparc/int64_helper.c   |    5 -
 target/sparc/machine.c        |   44 +-
 target/sparc/translate.c      | 1225 ++++++++++++++-------------------
 target/sparc/win_helper.c     |   55 +-
 target/sparc/meson.build      |    1 -
 14 files changed, 724 insertions(+), 1335 deletions(-)
 delete mode 100644 target/sparc/cc_helper.c

-- 
2.34.1


