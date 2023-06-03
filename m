Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC27213A0
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfF-0006yq-UX; Sat, 03 Jun 2023 18:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfE-0006yb-E0
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:00 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfC-0004vD-S1
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:00 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6b0d38ce700so2750946a34.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831037; x=1688423037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f0BEzhaijs0e3X7S/YviHgfPMt0b+BruuN+7t8clb5U=;
 b=BYHrLo4nnuy5W+8zghDgBOZESM3VZYO2mB3UmNh9CpwIr33VpdlR2kHl8z2fIGPuai
 sWK7eVQ9KMA4ESsZQQJ83Csfs0DSVUTOi2916QAccAA6xmB5wOZrlqk4G1tFKp8c6fdl
 I0PhguRw4kfWe+zLfH6Pwhcs06xzqOZUeLmi3uopFx8h1SmLJN8N5JHtA6EfxRATMI33
 cisp4hd0yxp2yq17UlyK5ScT/PhwFCthxT1AQ1/DzTRw9BnQNp/AuVB/YTsGboG1xNyz
 hMWOLm4yrH50jEiO/3sPXaCTd590y0aZ2BgJJTeWEPTIpzyDIJxPhm/3Vzu/YijdOxvC
 Hwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831037; x=1688423037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f0BEzhaijs0e3X7S/YviHgfPMt0b+BruuN+7t8clb5U=;
 b=GVcJxTOG9Vpq38F1DrAB35J+MmalcrAfccSFWaRmPHGbS+5uBHIKmpyq08QHmjC1l6
 TP7iEw78MWZgR5rhh54zJ7u4jkiXHzBXOVHOcWG4zjZq7zbuad/Tef4FZPIu3D7mVP2U
 TZQUUuVmdW6lJKXVDpYwengHyFWcPwPObE8Ag++JbVn6uf6sQU5TnYT7xn9QXr8lXtWg
 ENm5LTIFfezKd/vgBj8Rw0sfeUPBgB6bUA3n7O7UTKBC2qXJP2HJ8ebl2tJ/Wdh1eAB8
 Vp7KhFk8F/LtHbvOyTUzI5PDn2Bl2oapc+MvtwM0vmdXU3InFKE+DTfeetpCeO6wgk3x
 aLhA==
X-Gm-Message-State: AC+VfDyVENYBETzmQ8P2P+e7aXR9sX9VGrSwS4ihF1A8P6gCvAa9iega
 nF60H7KCRt75JHKPjf7n9OWarFK2GN8PX8aja48=
X-Google-Smtp-Source: ACHHUZ7URtq17+MjsCrgMOhdTZzFD9J7vL9AI+1Csj3YKvmTYQsM3mkRsnMrJ7vWKnyLCy6rewNCQw==
X-Received: by 2002:a05:6830:1311:b0:6ad:e9d2:a999 with SMTP id
 p17-20020a056830131100b006ade9d2a999mr6011655otq.20.1685831036921; 
 Sat, 03 Jun 2023 15:23:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:23:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 00/15] linux-user: Fix syscalls_def.h for target abi
Date: Sat,  3 Jun 2023 15:23:40 -0700
Message-Id: <20230603222355.1379711-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Testing clang -fsanitize=undefined -fno-sanitize-recover=undefined yields

../src/linux-user/syscall.c:1241:5: runtime error: member access within \
   misaligned address 0x00004081007c for type \
   'struct target__kernel_timespec', which requires 8 byte alignment

etc, for sh4, microblaze, and nios2.

Fix all the non-abi_type usage within syscalls_def.h,
and also ABI_LLONG_ALIGNMENT for microblaze and nios2.


r~


Richard Henderson (15):
  linux-user: Reformat syscall_defs.h
  linux-user: Remove #if 0 block in syscall_defs.h
  linux-user: Use abi_uint not uint32_t in syscall_defs.h
  linux-user: Use abi_int not int32_t in syscall_defs.h
  linux-user: Use abi_ullong not uint64_t in syscall_defs.h
  linux-user: Use abi_llong not int64_t in syscall_defs.h
  linux-user: Use abi_uint not unsigned int in syscall_defs.h
  linux-user: Use abi_ullong not unsigned long long in syscall_defs.h
  linux-user: Use abi_llong not long long in syscall_defs.h
  linux-user: Use abi_int not int in syscall_defs.h
  linux-user: Use abi_ushort not unsigned short in syscall_defs.h
  linux-user: Use abi_short not short in syscall_defs.h
  linux-user: Use abi_uint not unsigned in syscall_defs.h
  include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for microblaze
  include/exec/user: Set ABI_LLONG_ALIGNMENT to 4 for nios2

 include/exec/user/abitypes.h |    5 +-
 linux-user/syscall_defs.h    | 2284 +++++++++++++++++-----------------
 2 files changed, 1134 insertions(+), 1155 deletions(-)

-- 
2.34.1


