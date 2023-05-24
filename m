Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514CA70FDEB
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 20:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tIU-00061N-FJ; Wed, 24 May 2023 14:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tIO-00060t-2v
 for qemu-devel@nongnu.org; Wed, 24 May 2023 14:33:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tID-0006wb-PU
 for qemu-devel@nongnu.org; Wed, 24 May 2023 14:33:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d1e96c082so964844b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684953179; x=1687545179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kaWOVDLt3VP8XW+0WuocQB7SOilaZbvFA2n7jlaov7M=;
 b=z0Zo1WaA3eaN9y7yx429n5ky45TBnCvJ4ltvvwwnKFdRrmvsR/w2GqnVU97UFAkZ8F
 a1hx9bv+tiwJJ1iyut2k2/Q/vPNnKHb2RaU+tEbBvf9+9gyi03ZqS+A18mkJ+taorD0d
 TgzUVamfKGTezrL05ptJ5pQt457cc2aJWxUUaLJlCFXdkvv+oHMIe/OX9t0YVxVoMsOL
 qeGbai3AxejbcN1VpVd8SYA1sHC6D/SdSRZPQzvmRjwVKuYohvVUSln4uuOxgBMseYMx
 Jaj6l6T+JM93wrSqk1JXCOqbPki3amvZUHG0uPXKhksvTt7s7SDS7ympds2yLC2Vvw6I
 mI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684953179; x=1687545179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kaWOVDLt3VP8XW+0WuocQB7SOilaZbvFA2n7jlaov7M=;
 b=jr/1i4K+7HSRdTEKhxUewh3CCocoV0y9VGTLbSZVS3RzAeMgQ6VaTHxW1FRNVm4opc
 hyle8VH6Q5CBfgEOOOun4f5AvZD78zESob8PTSlgY4naHTFfFMVGrhnSvs5FZ6nXqWT/
 kjBQes3gODaaeDv9eAC83+23gZbG8WkDNmmP8413jtpk9OqRDNza6jSuUOs0OrKEobfj
 Nt3MIc6uHm70sz0vRkWUjxudESDVgQJjwenXLlY7eFVmw0vGlO28+8sWTn/ppZyeYOKC
 SUpGLQYdnLfgwBaMDoDPJBxw0Do3lFntVssVi4BiZptETOqxk/fsG84MTqqODALlnEoV
 gZPQ==
X-Gm-Message-State: AC+VfDzjJQAfhGPN30wE1D+6EXIOF3ZObDssJPVBFODQ8DiOFOlxnhmT
 vWTaFsQaLmv+bGYuN/JxphZdXrugV6Lscfg8Csg=
X-Google-Smtp-Source: ACHHUZ5/wcDX8kSZmL3umFsVImd7USpQGrZRLrHNj2zTLZH2QfBuCpWI/N0ce6j1WYQcbwDfeUWuRg==
X-Received: by 2002:a05:6a21:99a6:b0:10b:f980:18d3 with SMTP id
 ve38-20020a056a2199a600b0010bf98018d3mr11185754pzb.1.1684953179468; 
 Wed, 24 May 2023 11:32:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 2-20020a170902c20200b001ac2be26340sm9042008pll.222.2023.05.24.11.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 11:32:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v3 0/2] accel/tcg: Improvements to atomic128.h
Date: Wed, 24 May 2023 11:32:56 -0700
Message-Id: <20230524183258.1194571-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Changes for v3:
  * Most of the v2 patch set merged, except x86_64 atomic128-ldst.h,
    which failed testing with clang-11 with debian 11.

  * New patch to change __int128_t detection.

  * This in turn enabled CONFIG_ATOMIC128, which was not ideal.
    This clang bug/mis-feature of using a cmpxchg sequence for
    implementing __atomic_load_n was already noted for aarch64,
    so I should have expected it would also be true for x86_64.
    Given that I am adding inline assembly for CPUINFO_ATOMIC_VMOVDQA
    anyway, this isn't a big deal, but I did need to adjust the ifdefs.


r~


Richard Henderson (2):
  meson: Split test for __int128_t type from __int128_t arithmetic
  qemu/atomic128: Add x86_64 atomic128-ldst.h

 meson.build                               | 15 +++--
 host/include/x86_64/host/atomic128-ldst.h | 68 +++++++++++++++++++++++
 include/qemu/int128.h                     |  4 +-
 3 files changed, 80 insertions(+), 7 deletions(-)
 create mode 100644 host/include/x86_64/host/atomic128-ldst.h

-- 
2.34.1


