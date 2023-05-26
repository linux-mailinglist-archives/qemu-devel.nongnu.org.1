Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E94711B15
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:25:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LF7-0002UA-Am; Thu, 25 May 2023 20:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF5-0002Tv-Qo
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:39 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF3-00026q-03
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:39 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2537a79b9acso256512a91.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060615; x=1687652615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oWmpuHiYrAaybZGkEOTMqbkZLiVlU+Qbx26/dKO+6E8=;
 b=fqh8IJHvzVY3wT0Tnz89vUjmr+HYneUwDVDcKmMfyqhu6WgFnsoo/0UiKqjEmgXrvf
 y7zJvujqCnVUDtdNybFrIaIIn83sXPd+EetT0THJwUf+MG5z8VzxGb3pTbV4p/zb1giv
 slamPiv/YLmxh9IconKeuL2YuHeamauYiOSXxltsiABQnEzrLqj5PNDhDHjHh20U+V/h
 jiR8vZg7vk5UnzbW4nc7mf0wU6vwY0FAvwTtIPRDm3/aUfWxBe+XNeVYcdSuwvaX6sr2
 mX67VL1NVHOJ3SWN7k7vqqXYM9q5H5zoPRWEJE6cR8lhLrsW0HyxfvBaae1UgJ+OAvSu
 K15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060615; x=1687652615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWmpuHiYrAaybZGkEOTMqbkZLiVlU+Qbx26/dKO+6E8=;
 b=BoBpwBvZ9TiM/uwJit4nMax1w8Vhs/rGeXMoEmjTOke0TM8kWDYjKvzO7HzErKEsbL
 qXtCSU8UDN56qrAsVOPW7k1aC90Isti+K407UZgJF26eGtASXMCdH753wPVZ0w3hSW/G
 wkly4tnT5TXM3eQSFPl0J+iRRc4Rda8kI2MPlKR3T3OBpJuh7JNVWKTzVMwZLrSM4Zuq
 HxorSb7MkwiEAjlExd048Tn7B/ajQ4lo/1Pm3UzT6/oRwPkGG2OV5RrSHNHAMd+JEnjc
 H67ae7A6MgYVkebcGu8jg4u/6Mc1QMXAk9J9FekP05uqLCD23spTqgUwnfVQ86m689Xc
 XvOw==
X-Gm-Message-State: AC+VfDxIKCr+0aV0O3PzpkUut2xZhn/WjdjZ7pS5AQajjMoZjLDRwY4E
 DLpNrspGvq8DeyEvAV7HUqd6Sdf8UZJFT+Iksi0=
X-Google-Smtp-Source: ACHHUZ7xOUBizwHW7ysmQ0dVNVS8DEaC7tTlpHEsY6eEpDE4pOZ5/t4c6Fvg1skY7oewLayMIQ8XCg==
X-Received: by 2002:a17:90a:68c6:b0:233:fb7d:845a with SMTP id
 q6-20020a17090a68c600b00233fb7d845amr641177pjj.4.1685060615276; 
 Thu, 25 May 2023 17:23:35 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 00/16] tcg: Improvements to atomic128
Date: Thu, 25 May 2023 17:23:18 -0700
Message-Id: <20230526002334.1760495-1-richard.henderson@linaro.org>
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

This is a merge of a couple of singleton fixes, CONFIG_ATOMIC128
detection, and tcg backend code generation patch sets, just to
keep everything in one place.

Tested with the Arm FEAT_LSE2 patch set, which greatly increases
the number of 16-byte atomic operations.

Patches needing review:
  01-tcg-Fix-register-move-type-in-tcg_out_ld_helper_r.patch
  02-accel-tcg-Fix-check-for-page-writeability-in-load.patch
  03-meson-Split-test-for-__int128_t-type-from-__int12.patch
  05-tcg-i386-Support-128-bit-load-store.patch
  07-tcg-aarch64-Reserve-TCG_REG_TMP1-TCG_REG_TMP2.patch
  08-tcg-aarch64-Simplify-constraints-on-qemu_ld-st.patch
  12-accel-tcg-Extract-load_atom_extract_al16_or_al8-t.patch
  13-accel-tcg-Extract-store_atom_insert_al16-to-host-.patch
  14-accel-tcg-Add-x86_64-load_atom_extract_al16_or_al.patch
  15-accel-tcg-Add-aarch64-lse2-load_atom_extract_al16.patch
  16-accel-tcg-Add-aarch64-store_atom_insert_al16.patch


r~


Richard Henderson (16):
  tcg: Fix register move type in tcg_out_ld_helper_ret
  accel/tcg: Fix check for page writeability in load_atomic16_or_exit
  meson: Split test for __int128_t type from __int128_t arithmetic
  qemu/atomic128: Add x86_64 atomic128-ldst.h
  tcg/i386: Support 128-bit load/store
  tcg/aarch64: Rename temporaries
  tcg/aarch64: Reserve TCG_REG_TMP1, TCG_REG_TMP2
  tcg/aarch64: Simplify constraints on qemu_ld/st
  tcg/aarch64: Support 128-bit load/store
  tcg/ppc: Support 128-bit load/store
  tcg/s390x: Support 128-bit load/store
  accel/tcg: Extract load_atom_extract_al16_or_al8 to host header
  accel/tcg: Extract store_atom_insert_al16 to host header
  accel/tcg: Add x86_64 load_atom_extract_al16_or_al8
  accel/tcg: Add aarch64 lse2 load_atom_extract_al16_or_al8
  accel/tcg: Add aarch64 store_atom_insert_al16

 meson.build                                   |  15 +-
 .../aarch64/host/load-extract-al16-al8.h      |  40 +++
 host/include/aarch64/host/store-insert-al16.h |  47 ++++
 .../generic/host/load-extract-al16-al8.h      |  45 ++++
 host/include/generic/host/store-insert-al16.h |  50 ++++
 host/include/x86_64/host/atomic128-ldst.h     |  68 +++++
 .../x86_64/host/load-extract-al16-al8.h       |  50 ++++
 include/qemu/int128.h                         |   4 +-
 tcg/aarch64/tcg-target-con-set.h              |   4 +-
 tcg/aarch64/tcg-target-con-str.h              |   1 -
 tcg/aarch64/tcg-target.h                      |  11 +-
 tcg/i386/tcg-target.h                         |   4 +-
 tcg/ppc/tcg-target-con-set.h                  |   2 +
 tcg/ppc/tcg-target-con-str.h                  |   1 +
 tcg/ppc/tcg-target.h                          |   3 +-
 tcg/s390x/tcg-target-con-set.h                |   2 +
 tcg/s390x/tcg-target.h                        |   2 +-
 tcg/tcg.c                                     |   4 +-
 accel/tcg/ldst_atomicity.c.inc                |  78 +-----
 tcg/aarch64/tcg-target.c.inc                  | 243 ++++++++++++++----
 tcg/i386/tcg-target.c.inc                     | 191 +++++++++++++-
 tcg/ppc/tcg-target.c.inc                      | 108 +++++++-
 tcg/s390x/tcg-target.c.inc                    | 103 +++++++-
 23 files changed, 913 insertions(+), 163 deletions(-)
 create mode 100644 host/include/aarch64/host/load-extract-al16-al8.h
 create mode 100644 host/include/aarch64/host/store-insert-al16.h
 create mode 100644 host/include/generic/host/load-extract-al16-al8.h
 create mode 100644 host/include/generic/host/store-insert-al16.h
 create mode 100644 host/include/x86_64/host/atomic128-ldst.h
 create mode 100644 host/include/x86_64/host/load-extract-al16-al8.h

-- 
2.34.1


