Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D4781277
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX3jD-00010H-MS; Fri, 18 Aug 2023 13:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3jB-0000z8-9I
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:57:41 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3j9-00049Q-74
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:57:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a76d882052so834726b6e.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692381457; x=1692986257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rJDVG/AZSqjsj3RL7418yahcbtiSsjy6tBuRAsKJOWE=;
 b=xsuhjVKCtAA2gpICbFZ42YTASbpesnoZkMoHGNRNfYJwV6c4G23G2iagbM149ECrRo
 81OCfluDnuPvglhovAPa3uP3l3Q+xhqRG5zl6VAYg2L5swXeOTa4fkvykHXVGsqa3lsD
 v7AdF/G3YTLx6ciOF9mbJKKoGHi/vWW1BISc3o04sG0xkd+BqsDwfL/Dl8CBLOd7Wevc
 0+MmG+WHo2jc5VV2Cj0K4uXUlfu+wQyAJe7nYgapHTFuSa13pVnqLtwhgFykcRAO9SJo
 yGLxvpnHbupMvhbR8nCKSigQs7nevyqog12TDNPYcjZl6oOPFdUj7jjGAokX2R1uZhNv
 miEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692381457; x=1692986257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rJDVG/AZSqjsj3RL7418yahcbtiSsjy6tBuRAsKJOWE=;
 b=j5EEu7SL/x/bL1TFC7t6ZLPP9vI00T+qsM90CMVPqEFmuihoLpdwiCfEJpcRk8OALD
 SZTO3L5PTfhZlnXbN842tIqqjtDXnS4F1pCgASIXgJrolDRM356lJabZx22RVH6fTaMk
 Q85TJdC4TdIw3vu5AT4OEyaa+6BA6uXOCCc40MuhKA2PiBRmMKNEjt5ymcrMu/Z8vXJS
 s8eszJJEF59CdY1FswRjEBryuebwzmLsyPW/UqXTMINM7ZGrip3MhjuaYRUgsuXQj1G5
 Q2DspXPDxTZerFvtmYNc8I+ofHvpsFBN2U7/H680dJ1jz9pbdxgyoGPypf3nxD4kfOTL
 C8FA==
X-Gm-Message-State: AOJu0Yzudc1LMqHMXxyAnBA1Ly7KKn5/mxDAs0KdOLS5zzHrz3r4UF42
 wo6aCVC9zW9FV6UXOj1DW6yAOHeUCZuVG0t96A4=
X-Google-Smtp-Source: AGHT+IH0ENIuV5YxxPyLAE50ex0KOjjX3VRAyw8TnUjymFpq03wszh45weg+tfIytounN2mRN0zAxA==
X-Received: by 2002:a05:6808:1307:b0:3a4:894a:9f57 with SMTP id
 y7-20020a056808130700b003a4894a9f57mr4430852oiv.6.1692381457636; 
 Fri, 18 Aug 2023 10:57:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a638c4b000000b005637030d00csm1838212pgn.30.2023.08.18.10.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:57:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com
Subject: [PATCH 0/3] bsd-user: image_info cleanups
Date: Fri, 18 Aug 2023 10:57:33 -0700
Message-Id: <20230818175736.144194-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

This mirrors some changes I've posted for linux-user,
removing stuff from image_info which is unused.


r~


Richard Henderson (3):
  bsd-user: Remove ELF_START_MMAP and image_info.start_mmap
  bsd-user: Remove image_info.mmap
  bsd-user: Remove image_info.start_brk

 bsd-user/arm/target_arch_elf.h    | 1 -
 bsd-user/i386/target_arch_elf.h   | 1 -
 bsd-user/qemu.h                   | 3 ---
 bsd-user/x86_64/target_arch_elf.h | 1 -
 bsd-user/elfload.c                | 4 +---
 bsd-user/main.c                   | 2 --
 6 files changed, 1 insertion(+), 11 deletions(-)

-- 
2.34.1


