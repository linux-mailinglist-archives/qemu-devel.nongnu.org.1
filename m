Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3D784825
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUlo-0008On-WA; Tue, 22 Aug 2023 13:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUlm-0008Me-98
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:02:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYUli-0002K2-8N
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:02:17 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso30509425ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692723731; x=1693328531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NO/hXvsZQzGour+b4WKm8Pz/s6TYJUAERQ5W+PsN5tE=;
 b=q5IfgzuM2o1BrsTuBXMC4a0MShaJg6TBkPlX2hDCUwc//OlwkPiceIdUB7IX6RKk6k
 kapCglB1PBNhV1VAlDBh4Bgyy0n7f1o6rMDa2OEby0Km8TCtLhoOKUPG2HhUitsgch/Z
 9S3LcYsjhM/pwfi8/z+DRtLf6FrerNmB6C3+iQP940Ig9nGynxCYgJigi4VRWVGwmR13
 /RPtbCSILmQ8SFbl52gsywmbRN5j2hxrgqMfyxxAkX3+1z+9ZW0CiPSeCZ1CM1Llqb+3
 VRUrYSLSAPjYzdJ9QONkwqFsFdKtM+i0qsMRTM5cQeWV1bs21JwvX7K/AlMVCWiSHVge
 6DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723731; x=1693328531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NO/hXvsZQzGour+b4WKm8Pz/s6TYJUAERQ5W+PsN5tE=;
 b=CeSzQQMFfUsToBMPCcgvg6uSj0gv4h6u3jKXOnDwoHUSQd+WBbr4yJCmHI2lma6w2p
 idzWSwSwn+m6r6KU7QO+zFxnnn8e0NAJp5ZuIT9N05HMZXjf3AiGlzwESRZp4rKBHWt3
 q990r4fgL2/uTXm/ksaAjDZbiigIfRowqsMpe+0OJmBAOByg4jSP0YXlEeRMLaDh7qiT
 NMvXoozVPq8L1jz4q4NVFIIn58I6qmnhsU+wNCr2Szkl7ppGiKYQkIhmINiuLYh7MO+3
 DRIchUJ2PKLYWGsphsDvD3+EMObbP2Zlkph7n1fyYwSc1AInyUmmhpbSKfxjGd4aZExJ
 rBww==
X-Gm-Message-State: AOJu0YzFyB9oNy84SYoCWkLJqwklJIUf/JyWcnYMzyB8HudsvL9OM5pm
 jPIbrVFua8YhLtNcwKrOPPJGd03bdaSkT2PpbOw=
X-Google-Smtp-Source: AGHT+IEF/RlbVLKQ2VV33/MIzZbxod5+rL+yZupW3f/hdYGDvRbKpRVb89+GBZccRc7lXFaLRZIfaQ==
X-Received: by 2002:a17:902:f80d:b0:1b3:d6c8:7008 with SMTP id
 ix13-20020a170902f80d00b001b3d6c87008mr7058436plb.57.1692723730919; 
 Tue, 22 Aug 2023 10:02:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b00264040322desm8761121pje.40.2023.08.22.10.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 10:02:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/3] linux-user/aarch64: Add ESR signal frame record
Date: Tue, 22 Aug 2023 10:02:06 -0700
Message-Id: <20230822170209.1130173-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We use this ourselves in qemu for SIGSEGV handling, and the kernel
now adds one for the FPAC fault.


r~


Richard Henderson (3):
  linux-user/aarch64: Add ESR signal frame for SIGSEGV, SIGBUS
  linux-user/aarch64: Fix normal SIGILL si_code
  linux-user/aarch64: Add ESR signal frame for PACFAIL

 linux-user/aarch64/cpu_loop.c |  7 ++++-
 linux-user/aarch64/signal.c   | 54 ++++++++++++++++++++++++++++++++++-
 tests/tcg/aarch64/pauth-2.c   | 25 +++++++++++++++-
 3 files changed, 83 insertions(+), 3 deletions(-)

-- 
2.34.1


