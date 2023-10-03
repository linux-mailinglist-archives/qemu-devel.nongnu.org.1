Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67D7B70E5
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAn-0007xe-OR; Tue, 03 Oct 2023 14:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAj-0007wz-Hv
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAg-0001e3-MA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso9544225ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357860; x=1696962660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ncd9uhIBH6XC4y5EYvgDXbzM5BS5PSGBBTY0b7dF6ms=;
 b=MCsn+2Kc1ZdKTDXGpUaoHABg/Vp8xO9oC7RJgx0amryUiFQaEdH28zBoYwngT8t6Pj
 GBRe45jveNzhWYSM5bGihO0z1ucOklvEvbpZOffZI22VwN4M2R5dmltahl+Shq94Ht2F
 17em5cFVyWABhEe0/N0cncBPeUxS9t7LUrZxJwJbjmgopx+IDw0ghgV410PTSm9x+Jl7
 PV+iV6Fdy3cwpcBczHTeSBSKwjnHU3OIaDahExJSBtv64Kjgw814qDZzCHLhO7/IvXmd
 6PC6XAFdJGP9lDvN6i3sGGSLH2PclJYmTGigOxF/uf8Y/eHKPpETt0v2TO1Ogbh67JTq
 hKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357860; x=1696962660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ncd9uhIBH6XC4y5EYvgDXbzM5BS5PSGBBTY0b7dF6ms=;
 b=o6rCW+UeZ1seIkE3PMCBsQgpbFShOT28JC8cMtrVVeZW1A9NQKH0Vn6GqNGBHz8YMG
 GmojhkZjJCcFLl6diCaqhDfSZb+G0tRArJxNbFRkg2x0U6uCaVisk1oflHxjYfhByeof
 sYHjfxORC4SpXwgzNBQOyG+0bB89rsO+NkRsFZPu7l0DARLc8VLaD2t5bh+y5dnEObBt
 fH7m4IqSfv5ITjak8wNzIQ3hh/asUVKgvcjEeHCOcpaZyijVbxyPqYJyDlehYERCt6SJ
 IOijGlVzLe8gqmg3pMUc3FOu0/TujrhDDFKbvrVQXifdCg1z9IhlAvBKSDM5P5D/C8hw
 3GRA==
X-Gm-Message-State: AOJu0YxOeqDyneYxciyAYek6EC3RN0URZx9X5+VBQUBM9xUXbg+Z0hNT
 9uIJ6mIIMJt5FHkQfsOXeQIwMFlQq/2b4/GRn/I=
X-Google-Smtp-Source: AGHT+IFCZuYU/CbySPNZCaZsiondqJntnp4NcCUOwlRXIZTr5SfbPtWVP7xMW3affNYbSWYekQYqqA==
X-Received: by 2002:a17:902:d2ce:b0:1c6:291e:24b6 with SMTP id
 n14-20020a170902d2ce00b001c6291e24b6mr385608plc.37.1696357859777; 
 Tue, 03 Oct 2023 11:30:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:30:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 00/16] TCG code quality tracking
Date: Tue,  3 Oct 2023 11:30:42 -0700
Message-Id: <20231003183058.1639121-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Based-on: <20231003173052.1601813-1-richard.henderson@linaro.org>
("[PULL 00/47] tcg patch queue")

v16: 20230628120430.73777-1-fei2.wu@intel.com

Changes for v17:
  * Split some patches, and other preliminary cleanup.


r~


Fei Wu (2):
  util/log: Add -d tb_stats
  accel/tcg: Dump hot TBs at the end of the execution

Richard Henderson (9):
  accel/tcg: Move HMP info jit and info opcount code
  tcg: Record orig_nb_ops TCGContext
  tcg: Record nb_deleted_ops in TCGContext
  tcg: Record nb_spills in TCGContext
  accel/tcg: Add TBStatistics structure
  accel/tcg: Collect TB jit statistics
  util/log: Add Error argument to qemu_str_to_log_mask
  softmmu: Export qemu_ram_ptr_length
  monitor: Change MonitorDec.get_value return type to int64_t

Vanderson M. do Rosario (5):
  accel/tcg: Collect TB execution statistics
  accel/tcg: Add tb_stats hmp command
  accel/tcg: Add tb_stats_collect and tb_stats_dump
  disas: Allow monitor_disas to read from ram_addr_t
  accel/tcg: Add info [tb-list|tb] commands to HMP

 accel/tcg/internal-common.h      |   2 -
 accel/tcg/tb-context.h           |   4 +-
 bsd-user/bsd-proc.h              |   2 +
 include/disas/disas.h            |   8 +-
 include/exec/cputlb.h            |   1 -
 include/exec/memory.h            |   2 +
 include/exec/translation-block.h |   3 +
 include/monitor/hmp-target.h     |   5 +-
 include/qemu/log.h               |   2 +-
 include/qemu/typedefs.h          |   1 +
 include/tcg/tb-stats.h           | 165 ++++++++++++++++
 include/tcg/tcg.h                |   8 +-
 accel/tcg/cpu-exec.c             |   6 +
 accel/tcg/cputlb.c               |  15 --
 accel/tcg/monitor.c              | 317 ++++++++++++++++++++++++++++++-
 accel/tcg/tb-maint.c             |   3 +-
 accel/tcg/tb-stats.c             | 231 ++++++++++++++++++++++
 accel/tcg/translate-all.c        | 167 ++++------------
 accel/tcg/translator.c           |  28 +++
 bsd-user/main.c                  |   6 +-
 disas/disas-mon.c                |  32 +++-
 linux-user/exit.c                |  10 +-
 linux-user/main.c                |   7 +-
 monitor/hmp-cmds-target.c        |  27 +--
 monitor/hmp-cmds.c               |   5 +-
 monitor/hmp-target.c             |   2 +
 softmmu/physmem.c                |   4 +-
 softmmu/runstate.c               |   2 +
 softmmu/vl.c                     |   7 +-
 stubs/tb-stats.c                 |  20 ++
 target/i386/monitor.c            |   4 +-
 target/ppc/ppc-qmp-cmds.c        |  20 +-
 target/sparc/monitor.c           |   8 +-
 tcg/tcg.c                        |  50 ++---
 util/log.c                       |  51 ++++-
 accel/tcg/meson.build            |   1 +
 hmp-commands-info.hx             |  14 ++
 hmp-commands.hx                  |  15 ++
 stubs/meson.build                |   1 +
 39 files changed, 1027 insertions(+), 229 deletions(-)
 create mode 100644 include/tcg/tb-stats.h
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 stubs/tb-stats.c

-- 
2.34.1


