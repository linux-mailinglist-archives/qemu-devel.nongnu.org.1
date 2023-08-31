Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAAD78F623
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 01:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbr25-0006qo-NE; Thu, 31 Aug 2023 19:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr23-0006q8-PZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:24:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr1o-0002Gw-NP
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:24:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c1f8aaab9aso11053135ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693524282; x=1694129082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cYadnNUzS+EStUScAbd7zg63A8xSjmBqfglid51vMNM=;
 b=QBwIEakuGpcuvTEcoH96wbCul7hGrca3XVkdicJbd9ZqzcOeQqgRzalJSmSq6o1IEK
 as8/pkZIjnFJJC5JPKvafp6FMQW4HgqohvFX+SybqqnhnELcoZIPfaGjz7zvBkjb4KpP
 C3FbA0ljMyAARcIpkwp/kG3FzkkryrM4pZ7aMnF2PZX+dvJxMovRUlWVxr6OwGXSH1XI
 z++/UxOLNOvk2T4RPkrPBULCk5FGxz1jhPgrznT76d5GU3pJvDA1H0pW6mgVZ900ag5z
 +4ITBDILTaeoR/oay1yZO9ZJ9U4mmoDicGpdM+TZhD9T7MRxF3OQgdOcRILkTR5mdTq5
 O7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693524282; x=1694129082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cYadnNUzS+EStUScAbd7zg63A8xSjmBqfglid51vMNM=;
 b=OhF9USLjmfMdz5zlm2UZiw/kXqHBmmH+65ekKNEKZAAp8c7IEGYA/IrEF9xxb1C+L2
 gcFwRs3R8PZEm7oqEI2DqhBCjewRK0BOqQq/N+ZteXVjl1kSYgv2BAlwhLYzXYYpvo54
 JWiqP8wQqYFLu0ObSSfkGFq1cJHMCbDodUNh8N6ge6iWFRhCpjOu9JiwcxeinJEs0Q83
 8dz390Npx+xirtyBUstDRFwbWl5oZJayk0YO0a/BpVUflQDSi6XR26FUIjtWlo0GVONb
 s8S5TfCnHtZYPTVIiC4A/q40aDnGBOiv0G0dpuaPBHw7FaJmdlI1BLis24oK8avx/N6o
 a5nA==
X-Gm-Message-State: AOJu0YyTyzjdVhyTvqw0xDZZNXOdYWxUUWpabmZENm/SCQIIPlPXNm8x
 UyT+q1v7T7Hkv5ded6MULFzvZpWxTibveKp2syo=
X-Google-Smtp-Source: AGHT+IFeE00ydtprW77iClJLcF+QpFafvz0KCg0iJVAS7t1xIHWsXRwAqNUZM9Mi4uZ5iS7trU7PpA==
X-Received: by 2002:a17:902:d3d5:b0:1b6:c229:c350 with SMTP id
 w21-20020a170902d3d500b001b6c229c350mr1195958plb.18.1693524282543; 
 Thu, 31 Aug 2023 16:24:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 jd5-20020a170903260500b001bb8895848bsm1732711plb.71.2023.08.31.16.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 16:24:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 0/5] target/arm: Implement cortex-a710
Date: Thu, 31 Aug 2023 16:24:36 -0700
Message-Id: <20230831232441.66020-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
  * 9 patches upstreamed
  * Implement RMR_ELx generically, as a stub.
  * Implement TIDCP and the closely related v8.8 FEAT_TIDCP1.


r~


Richard Henderson (5):
  target/arm: Implement RMR_ELx
  target/arm: Implement cortex-a710
  target/arm: Implement HCR_EL2.TIDCP
  target/arm: Implement FEAT_TIDCP1
  target/arm: Enable SCTLR_EL1.TIDCP for user-only

 docs/system/arm/emulation.rst  |   1 +
 docs/system/arm/virt.rst       |   1 +
 target/arm/cpu.h               |   5 +
 target/arm/helper.h            |   2 +
 hw/arm/virt.c                  |   1 +
 target/arm/cpu.c               |   4 +
 target/arm/helper.c            |  64 ++++++----
 target/arm/tcg/cpu64.c         | 213 +++++++++++++++++++++++++++++++++
 target/arm/tcg/op_helper.c     |  33 +++++
 target/arm/tcg/translate-a64.c |  21 +++-
 target/arm/tcg/translate.c     |  33 +++++
 11 files changed, 353 insertions(+), 25 deletions(-)

-- 
2.34.1


