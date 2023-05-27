Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFCA713527
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 16:20:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ulJ-0007nt-J3; Sat, 27 May 2023 10:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulH-0007nY-NH
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:15 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulG-0002G7-6K
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:15 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-53482b44007so1121555a12.2
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685197152; x=1687789152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6wgd9zej+gcyZm1Ltl4mlnknAdCWHC1+a0+u7HE+tdw=;
 b=kxzCo9NxH7T+dbszMxwIKAYocsU4aUFUizNTAo3KJMJ1e5jiRli4rMPguX4wdZDjN3
 E8wH+iVUOuqkwttQXP2j7nQy3YLghbwO9Bt9VOMuXd9xasJjB0agbIuoFb26VEvtHLPB
 XGvZsTEdaWdAYRzAIfL4DBLj6ixHNiiw5Ilx1lIMTA+4c4QJ2Vz69M6fCAK4DePuX+e+
 M2ZxM7esiOo3UbqnULopQOLZNxKgsD/4P6FPFfDbcqa8CER4Ke8trzf31c82spBd7FoI
 INO+gKEcs61j7AJY5KLjab/zP4XhSPDBTopccUJU0t7ik7/Itzhf9BzgSrY2wMBi1clJ
 o8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685197152; x=1687789152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wgd9zej+gcyZm1Ltl4mlnknAdCWHC1+a0+u7HE+tdw=;
 b=ZHfH1Um0WD8BrMI9ACZb52GfLysijIHUPHpyS5QG+LqgayAHjqO0jgwddTOJvTldrw
 uAY/hJ2DaZd749xug5lA7gxdmHsueQXNbPW+S2oTAgaDIwOYcw+xPD3JB4lf1pvIT5kX
 0VwP9dcehCQwlnqZPXyZ5bKPkyOdcIn/4ela3KWoCu0iuStRVb7dB5YvzPoTebx+ubeQ
 LONXjySsmmQutAER1Koahw7a2h7D+KPjpIWuVcn655INbvYx3lXSSb96GC4ufSM8rO6K
 W3LltAj/qGr4Jy667/++jL1AZaPaJKaY30X+Slbj1e1oU3m4QjASGSDmwyFMXQB4EJ/L
 jJSQ==
X-Gm-Message-State: AC+VfDx17txqFka+XRaVmBrRLdK2y1UqbIqQpClvXLiLtdoI6lxKjwnA
 HwUEGnbNocKOVyivytKmaL2uzSLUNlNErJZkWqo=
X-Google-Smtp-Source: ACHHUZ5WzafNBaq5RVygyfNyYmd7Lz8pLgBVr0s5eChAMRGS0J6J2tgsNwb9mRId2TFsXXTrUlBBZg==
X-Received: by 2002:a17:903:1105:b0:1af:cbe4:d953 with SMTP id
 n5-20020a170903110500b001afcbe4d953mr7355378plh.60.1685197152058; 
 Sat, 27 May 2023 07:19:12 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:be31:c162:a57e:7431])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a170902759400b001a988a71617sm1258992pll.192.2023.05.27.07.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 07:19:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu,
	alex.bennee@linaro.org
Subject: [PATCH 0/4] fpu: Add float64_to_int{32,64}_modulo
Date: Sat, 27 May 2023 07:19:06 -0700
Message-Id: <20230527141910.1885950-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Extract some common code from Alpha and Arm, and which will
shortly also be required by the RISC-V Zfa extension.
Added a new test for Alpha; I already had a RISU test for Arm.


r~


Richard Henderson (4):
  fpu: Add float64_to_int{32,64}_modulo
  tests/tcg/alpha: Add test for cvttq
  target/alpha: Use float64_to_int64_modulo for CVTTQ
  target/arm: Use float64_to_int32_modulo for FJCVTZS

 include/fpu/softfloat.h         |  3 ++
 fpu/softfloat.c                 | 31 ++++++++++++
 target/alpha/fpu_helper.c       | 85 +++++++--------------------------
 target/arm/vfp_helper.c         | 71 +++++----------------------
 tests/tcg/alpha/test-cvttq.c    | 78 ++++++++++++++++++++++++++++++
 fpu/softfloat-parts.c.inc       | 78 ++++++++++++++++++++++++++++++
 tests/tcg/alpha/Makefile.target |  2 +-
 7 files changed, 221 insertions(+), 127 deletions(-)
 create mode 100644 tests/tcg/alpha/test-cvttq.c

-- 
2.34.1


