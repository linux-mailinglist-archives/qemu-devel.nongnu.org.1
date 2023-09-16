Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EAD7A332C
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 00:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhdMU-0006GV-EJ; Sat, 16 Sep 2023 18:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMS-0006G4-NQ
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMQ-000476-V9
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso31190485ad.2
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694901713; x=1695506513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wswtCBJyez7pOwlkJK20uOqePPi3jWRbxd/5TSBxlP8=;
 b=nrII+TQuN6H805m63QiCZiYeGx62Vn0zTyVafN3dcPFFo5Wmm9/Cq5/Vbi4hUyFcgY
 xzB8kALiUjFaV66wNXsZEgUxN6RYY73+V8UCSLyUm7e2LDJ7pkOWB2dpiekXnJJM8Uq/
 HFGFXI7lDpcZ2WiR6FjIiG4+np+D2ZrbPoqs5kq1d7GELuUycVqNLgs23yTuZj+IXOY0
 XuAy7Viue8r8ZPXLJYj6sm/Butef7X9Rkz+QlFPimOwakfhce/PNHj22DuQ8mLkSO9ug
 RFC7VHgbj3BQmMeWvSnQlSFRszExCccSP68gVgx8kGimk1i4hET3uKR0h34K4yrNvFpQ
 /OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694901713; x=1695506513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wswtCBJyez7pOwlkJK20uOqePPi3jWRbxd/5TSBxlP8=;
 b=k2h2ttYsYYBNgnQ61JBXr8aFVGOQMnwM74V6+hLf2/ceLQMKv0PW5hdO1l9wmDUMco
 Tg0XeMIg+ASCbIJdGPQse3RhNkTB7/YloTGXiUoJ1Koe9jC8zDIZhcA5pk3pOJREA1Lj
 o3eCVXSzRwfhOkyTz8ZhAuq1aZxtyxMrp6T0rHrUX+Ue8KsRBYBuHu0kF6oKUXubBg84
 Qn1H8X2E6HPnj7yu+J3PSO7bteQ6bIg1L0oPyAsEcNOcKWa9dZ7LbVFudtx0haecP/mI
 GlSndBw7TnAHqlVlyRUMd1rQ14a0tRKBqVIcAFynQTiWk96mz1rMDSprpR4US0miiIZk
 f54g==
X-Gm-Message-State: AOJu0YyrQAelzeWZJZhhJkmxAKxbLizpoIyTt/FWYl5+icTb8OGPgQoH
 d3GpCjmU+OC8aEDqMrefWNc2qceVz5NjRFmp8Ts=
X-Google-Smtp-Source: AGHT+IEw626NAwKkRj5QomdD/ALIdPkT/crU/HvppXxr82Rc3K6IrsJueXCUj0teoEI89OPeo3g+uA==
X-Received: by 2002:a17:902:c94f:b0:1c3:3dae:5869 with SMTP id
 i15-20020a170902c94f00b001c33dae5869mr6803532pla.63.1694901713037; 
 Sat, 16 Sep 2023 15:01:53 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902788300b001b531e8a000sm5707763pll.157.2023.09.16.15.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:01:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH 0/7] tcg/loongarch64: Improvements for 128-bit load/store
Date: Sat, 16 Sep 2023 15:01:44 -0700
Message-Id: <20230916220151.526140-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

For tcg generated code, use new registers with load so that we never
overlap the input address, so that we can simplify address build for
64-bit user-only.

For tcg out-of-line code, implement the host/ headers to for atomic 128-bit
load and store, reducing the cases for which we must raise EXCP_ATOMIC.


r~

Based-on: 20230916171223.521545-1-richard.henderson@linaro.org
("[PULL v2 00/39] tcg patch queue")

Richard Henderson (7):
  tcg: Add C_N2_I1
  tcg/loongarch64: Use C_N2_I1 for INDEX_op_qemu_ld_a*_i128
  util: Add cpuinfo for loongarch64
  tcg/loongarch64: Use cpuinfo.h
  host/include/loongarch64: Add atomic16 load and store
  accel/tcg: Remove redundant case in store_atom_16
  accel/tcg: Fix condition for store_atom_insert_al16

 .../include/loongarch64/host/atomic128-ldst.h | 52 +++++++++++++++++++
 host/include/loongarch64/host/cpuinfo.h       | 21 ++++++++
 .../loongarch64/host/load-extract-al16-al8.h  | 39 ++++++++++++++
 .../loongarch64/host/store-insert-al16.h      | 12 +++++
 tcg/loongarch64/tcg-target-con-set.h          |  2 +-
 tcg/loongarch64/tcg-target.h                  |  8 +--
 accel/tcg/cputlb.c                            |  2 +-
 tcg/tcg.c                                     |  5 ++
 util/cpuinfo-loongarch.c                      | 35 +++++++++++++
 accel/tcg/ldst_atomicity.c.inc                | 14 ++---
 tcg/loongarch64/tcg-target.c.inc              | 25 +++++----
 util/meson.build                              |  2 +
 12 files changed, 189 insertions(+), 28 deletions(-)
 create mode 100644 host/include/loongarch64/host/atomic128-ldst.h
 create mode 100644 host/include/loongarch64/host/cpuinfo.h
 create mode 100644 host/include/loongarch64/host/load-extract-al16-al8.h
 create mode 100644 host/include/loongarch64/host/store-insert-al16.h
 create mode 100644 util/cpuinfo-loongarch.c

-- 
2.34.1


