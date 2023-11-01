Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9F7DDBC8
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2Zy-0005u0-LB; Wed, 01 Nov 2023 00:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zw-0005tO-41
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:40 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zr-0007SU-SQ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:39 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d81d09d883dso5801234276.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811894; x=1699416694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J6XK/s/RdFSznJX6peAagzrh0zBnv0QuEh4OFcYckRQ=;
 b=xYg9Zcsdsk/gaaCxNamWkBOD9ibTuje93TQGoUtMTNi+csFqRuKSaIoxVY/6BPJFDd
 Adupr0hMEdGRd5dIcbVJ+WG64O/4swtOn9evdRbHDPZ6/xXEw/Y0lTL4FI/+zRToZboY
 /McFzujS5MZ68QrMPcXRXkWr6VzOqjWMmPz55/6Hv2RFj/z4bHfgfK5QYGNS2JCkZd7j
 gbBrtP2PrzaVeLvSTuZ0+v3dNO1CRaklK6oWCOxzsdd1jl3Gb/pFfaPf8kivuTwEWdgQ
 pxrqpZaezX2UDSAuBSd6R+hvCaUBfUBn4RQkaXfFKf+fACz0s3EkrWF93+5rPZf/baHi
 KsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811894; x=1699416694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J6XK/s/RdFSznJX6peAagzrh0zBnv0QuEh4OFcYckRQ=;
 b=Zqk5vRqZXCaztmQ+2am0k3K2NTBr0B1p3hf88jK6GjSule8XRpUI1INSBToixcVGvk
 bSNuiiYFL6ln/oYqZrB7bUvGtTJkonJ7C9NOHBGQ4OZz9vDnHDNrkFUGAhn9kgJ56ZY+
 3WFphVYaOsZXyKap4AetpVc7YiSvyc24DmZybFvYxjZIyNJDBS3OuxcSNYQNkXXsAKjs
 JdZO/pxOalmCWn1qOajx572ag0hFZ90F7AAoLh2LNXAkO26p8wca/plWWKkmif9zXKmU
 EIhde7BjxkYWc5DpTi5F2W0bkWzWf077jsEG2a/R8fMbljOcGgbT8x+IiP6TYFsn6VhN
 HTew==
X-Gm-Message-State: AOJu0YxCbGGOZbAJUxoKETAf4pEDEiXwpmN5VRiKJgKDvD3C5iz/vqBw
 mNyD7wKQDzvFIC1JVeTGiD2etkSe/P80/kfcDOM=
X-Google-Smtp-Source: AGHT+IGpm582Xjv/8xbcXK57GLK4aKYFZVqU0OlkS99FbTRK53Ac1n/YkTLsiMGMwAMmowggxtib2A==
X-Received: by 2002:a25:84c9:0:b0:d81:5d5a:25a3 with SMTP id
 x9-20020a2584c9000000b00d815d5a25a3mr13019985ybm.43.1698811894365; 
 Tue, 31 Oct 2023 21:11:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 00/21] target/sparc: Cleanup condition codes etc
Date: Tue, 31 Oct 2023 21:11:11 -0700
Message-Id: <20231101041132.174501-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2a.google.com
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

This was part of my guess for some of the performance problems.

I saw compute_all_sub quite high in the profile at some point, and I
believe that the test case has a partially rotated loop such that "cmp"
is in a delay slot, and so the gen_compare fast path for CC_OP_SUB is
not visible to the conditional branch that uses the output of the compare.
Which means that helper_compute_psr gets called more often that we'd like.

Since almost all Sparc instructions that set cc also have a version of
the instruction that does not set cc, we can trust that the compiler
has only used the cc-setting version when it is actually required.
Thus, unlike CISC processors, there is very little scope for optimization
of the flags -- we might as well compute them immediately.

Move away from CC_OP to explicit computation of conditions.  This is
modeled on target/arm for the (mostly) separate representation of the bits.
We can pack icc.[NV] and xcc.[NV] into the same target_ulong, but Z and C
cannot share.  (For "normal" setting of Z, we could share, but it is
possible to set xcc.Z and !icc.Z via explicit write to %ccr, and for
that we have to have two variables.)

After removing CC_OP, clean up the handling of conditions so that we can
minimize additional setcond required for env->cond.

Finally, inline some division, which can make use of the new out-of-line
exception path, which means we can expand UDIVX and SDIVX with very few
host insns.  The 64/32 UDIV insn needs only a few more.  Leave UDIVcc and
SDIV* out of line, as the overflow and saturation computation in these
cases is really too large to inline.


r~


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
  target/sparc: Merge advance_jump_uncond_{never,always} into
    advance_jump_cond
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
 target/sparc/cc_helper.c      |  471 ------------
 target/sparc/cpu.c            |    1 -
 target/sparc/helper.c         |  171 ++---
 target/sparc/int32_helper.c   |    5 -
 target/sparc/int64_helper.c   |    5 -
 target/sparc/machine.c        |   45 +-
 target/sparc/translate.c      | 1333 ++++++++++++++-------------------
 target/sparc/win_helper.c     |   56 +-
 target/sparc/meson.build      |    1 -
 15 files changed, 789 insertions(+), 1406 deletions(-)
 delete mode 100644 target/sparc/cc_helper.c

-- 
2.34.1


