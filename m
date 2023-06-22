Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A073A480
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLyk-0006k9-Qn; Thu, 22 Jun 2023 11:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLyj-0006jy-7j
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:12:09 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCLyh-0000FM-5e
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:12:08 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b474dac685so74536511fa.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687446725; x=1690038725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gb7fjMzxIjRVnaIlvDuPa0Ek7eg4oRVJ9UXZSS5F+9M=;
 b=buFzDEZ40Gj21iuuDhWmhUpvV/GZSxSFNSxFb3dxjQXsoBm0H8zaERcJaQL68sHxvQ
 2WZz9kFIBCv2nxkbf3iUPpPzhv9O+oLmOskSvHdHmFtBZqVLy7D1fSqM0eG+UA6JZKuF
 Mvm51PF1C9d2tVbA4WqfHvg5lu7sjNOJ1jyC0QmQpIhC0p4dYCemjG2zwyzIumpjhVLK
 LjNd1R2C6d/Bc+dE9CDATZ4W7+0iOzXmiRe22GNX2koVE+43l9EcKckkM/EB3Ac3kWpy
 BqFNKpwjcpUuskeBKgkdhY5IqUneM1gr+LcQPMVkgaF/n7jkDt3I+FF2YiNYDbfFxm+e
 IfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687446725; x=1690038725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gb7fjMzxIjRVnaIlvDuPa0Ek7eg4oRVJ9UXZSS5F+9M=;
 b=jrfj1GBi6nWfVWgiNLZsx+vR92ACY6rtGhr05bC0Nj/hOjg2dQiQq8SqocvouBcXQO
 FsuMCW0Y02w7oNu9QIo79CSlZn7rhqbeM4GlAHtjWiV6wXgcv6ZRaPhtmPU4/aH2EnMo
 lTTYgH/yLXEK8kRXmHUkasgHAiNxGq9Qo705jvbVVFa6f6WmHwWs8t3UHW/Vbuv2JEVL
 /WYtbaI0jHqn5OMBJFTWQGZFgQnkfVhD7Re0V7YatkqdivtHHrTR9MmdVp0c6eQ4h+YZ
 t+nnyDAEWpiflec9TPOeeoeI+WeuAPQjhMUwIef4un2Fem4SaPqLyyyMHihHEoeBk6ae
 CdOQ==
X-Gm-Message-State: AC+VfDy7wW2sLsRB9ttA4cZgc7VXw6xTDynFLBgh+YQf6s4seKT+NZJi
 /lwHUUaO2DkJcxTTfNVgGJLGai+nOo+VZW/RHMFpmMUQ
X-Google-Smtp-Source: ACHHUZ5bXZ6BFUTkZc2PKpAu/HnxwBFA0ZQfDYjUMON3VEVWJS9tyUqhtJajva6f8sqZRHEG0Gp6NA==
X-Received: by 2002:a2e:9993:0:b0:2b4:7303:c112 with SMTP id
 w19-20020a2e9993000000b002b47303c112mr9629760lji.29.1687446725215; 
 Thu, 22 Jun 2023 08:12:05 -0700 (PDT)
Received: from stoup.. ([91.223.100.38]) by smtp.gmail.com with ESMTPSA id
 v3-20020a2e9f43000000b002b47fc5219dsm1320276ljk.67.2023.06.22.08.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:12:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 0/4] target/arm: Fix SME full tile indexing
Date: Thu, 22 Jun 2023 17:11:57 +0200
Message-Id: <20230622151201.1578522-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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

Fix #1620 and add its test case.
Several cleanups to aid debugging ZA[].  :-)

r~

Richard Henderson (4):
  target/arm: Avoid splitting Zregs across lines in dump
  target/arm: Dump ZA[] when active
  target/arm: Support reading ZA[] from gdbstub
  target/arm: Fix SME full tile indexing

 target/arm/cpu.h                  |  1 +
 target/arm/internals.h            |  3 ++
 target/arm/cpu.c                  | 54 +++++++++++--------
 target/arm/gdbstub.c              |  8 +++
 target/arm/gdbstub64.c            | 88 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c    | 24 ++++++---
 tests/tcg/aarch64/sme-outprod1.c  | 83 +++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target | 10 ++--
 8 files changed, 240 insertions(+), 31 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme-outprod1.c

-- 
2.34.1


