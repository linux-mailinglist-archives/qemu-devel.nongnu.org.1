Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D67D01A3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXmC-0001HG-Q4; Thu, 19 Oct 2023 14:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXlz-00016t-WB
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXlx-0006za-QR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so27707b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697740168; x=1698344968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kb9Cluqmv+FsiA4J6+AtsnRrean+OLv1oLbd3ARlQbw=;
 b=ImmdPra3ojN/04nkEMx1Ay9ZmJWwm5u56ZsLf+0joR0hzh3b4o+eJ6nEwOyVDcVxNX
 p5mw+3x4CjwjqkKV8aTQU/RRm/lgKWyp7SDuYwf7vWECz7A3bCR2EJFZWgwPxqlasdeI
 cD1qY6R8kz9LP6148/fTc6chtrw8uUy9IMsljkdQ+qPIe8+kEPZbuwwE4oRLKKJ5UY6U
 fUNnsW8Oatm63OmOzKDqyu7oqpBCFAvfQ6IwCwDE82M4YycdxlzsrUgtucjRIZRTKFQK
 zCiSjxLoLyrCRYeCeCiEDvfG5+bJgpwQh+ffP0JB02eIhZJsNvv8zPHc363zX316SkNh
 1X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740168; x=1698344968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kb9Cluqmv+FsiA4J6+AtsnRrean+OLv1oLbd3ARlQbw=;
 b=s7lqYpgt27up+4f8Y8j3k7yjeSCSh457sUgDQHSUkaKSkBCoF6LIBIi/Eyo+rP7lcY
 SqLBO0PbDvxBb2dKRBDEWvRgwkBmcgqeP3GP8X9DOUHRUu+saEmJ5Mvp8D5+wDTQrPrV
 BTV1RgVIzvnik0ZTCGBWcla4/ej5D6PJ2m11w28JdjEcI3xkGQg1ktb9PFivW3t/4DaB
 NTS7ZYnrsS4yM/QgIxBhqMbDsAM7wLzqvuxopAvUXomauLenoRlspWCZwLdXGB4I9hLf
 nag2Np3gNmu9qgIDADnPy+egy7792yXDBDPJLqi8KzTfALlIskdEd1zC2jzgKXyGHxKk
 gT6w==
X-Gm-Message-State: AOJu0Ywu5gJ+mzUTvIWy+exOF3svrp8BzmeBVSIWZsPRJ8D5pJSUToVO
 I10ENmYQJz0fzvETNqUyslDSEuBNb5HkijfNreg=
X-Google-Smtp-Source: AGHT+IHIzteroLSegHXhsBpngO4G9u91rxvevvjaQP5oPSsobFsqefp6KJZRXOVpASQSEYmI9NSpaA==
X-Received: by 2002:a05:6a20:2325:b0:172:9b19:66b6 with SMTP id
 n37-20020a056a20232500b001729b1966b6mr2550356pzc.32.1697740168322; 
 Thu, 19 Oct 2023 11:29:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e1-20020a630f01000000b005b856fab5e9sm72216pgl.18.2023.10.19.11.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:29:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
Subject: [PATCH 0/7] tcg: Expose tcg_gen_ext_{i32,i64,tl}
Date: Thu, 19 Oct 2023 11:29:14 -0700
Message-Id: <20231019182921.1772928-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

We have several copies of this function (or equivalent).
Expose the one already present in tcg-op-ldst.c.
Then, some target cleanups while searching for "ext8[us]".


r~


Richard Henderson (7):
  tcg: Export tcg_gen_ext_{i32,i64,tl}
  target/arm: Use tcg_gen_ext_i64
  target/i386: Use tcg_gen_ext_tl
  target/m68k: Use tcg_gen_ext_i32
  target/rx: Use tcg_gen_ext_i32
  target/tricore: Use tcg_gen_*extract_tl
  target/xtensa: Use tcg_gen_sextract_i32

 include/tcg/tcg-op-common.h    |  2 ++
 include/tcg/tcg-op.h           |  2 ++
 target/arm/tcg/translate-a64.c | 37 ++--------------------------------
 target/i386/tcg/translate.c    | 28 +++----------------------
 target/m68k/translate.c        | 23 +++------------------
 target/rx/translate.c          | 11 +++-------
 target/tricore/translate.c     | 20 ++++--------------
 target/xtensa/translate.c      | 12 +----------
 tcg/tcg-op-ldst.c              | 14 +++++++++----
 9 files changed, 30 insertions(+), 119 deletions(-)

-- 
2.34.1


