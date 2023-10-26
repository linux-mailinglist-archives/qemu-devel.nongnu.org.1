Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3F7D7B6A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:15:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvrl9-0002Wv-K4; Thu, 26 Oct 2023 00:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl7-0002VV-Aa
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:13 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl2-0000ip-B9
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:13 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-577e62e2adfso397868a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 21:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698293645; x=1698898445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yWl3X9ckwF3yG0ZK9oFC4Uk2YcUEOZHmKJfJvllMuI0=;
 b=RJYcnHHd+fTVe1zCfNpW3l8lDNuUNsWQWMHf4rgjVc6M7YX0CR3sdERZpor+tdvOXT
 N0y8tQ5MGD/uwsjUKsbG+CMvQBI5p2hMYhid6lRw4PxOSzJP8ehhd5Z1cIi2FYQxPUHa
 yQbgoD16DKp4xhom7Bz7PIdrdfMuO57MYjzU8t7F16MBqLLFbg9ErTdH0JvfpNUFDIEX
 Gt2QNM39kpUGsGtdtdHfhrUI7lFwNt/o6FiHXGHbOBk/KVGfz5yuNxCdVpqG/jCw2RzQ
 WoyjUI9KHQSzRsAGqiOsQ/xPPPwcaDgsZj1cesoBcnnWkE/9N1tJsQrY/j/3PHn6JH0D
 To5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698293645; x=1698898445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yWl3X9ckwF3yG0ZK9oFC4Uk2YcUEOZHmKJfJvllMuI0=;
 b=MLPuucaf0JBt91LXgvzRjjhXAgZhkMZFnSKMWQqY2HpvrV2jJ4/d2KXGI8R5sYE97v
 pwL3DNWW38FyfQvsK0H2ieYHsQxfldyXhyZUeLuEmw+p6Kqegazhy1NVJfF8WNqJPTyO
 R3enSuc1rTlHcpwk1h7R0U4Q6ycIBloAbDukd+XZe8mwdTmHaY8+/ekg3XPFZX/ZO83p
 +/oRBvz+toc7weHMI2cFrLFrjimpaI980V0F0U9w8j1GztY5cSwdMnhluq06VvJrReuV
 XjP4mHj81FZCpLo22x9yL98o3CtDAINuQJY5ks1yfroNZVglYZEYx0aKE9R0O7Cmm4G1
 1LpQ==
X-Gm-Message-State: AOJu0YxHn4OQt0c6O1O+HYMN2mhY669bONctU1H7c2BKF6DxBcUxhG5N
 l2zoqG1vvd5ao60dh+9GpI7kkKYHO2U0hXqSl6E=
X-Google-Smtp-Source: AGHT+IHRc7FFKY7Yu5tMD+R9XZp3StmObJhYRbgoVPPLG2KgMZCUQqCaKhf3TeMDE6WlQvA6Zu0DaQ==
X-Received: by 2002:a05:6a20:914a:b0:17e:2afd:4087 with SMTP id
 x10-20020a056a20914a00b0017e2afd4087mr7867299pzc.56.1698293645370; 
 Wed, 25 Oct 2023 21:14:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001b8b2b95068sm9953929pli.204.2023.10.25.21.14.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 21:14:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] tcg: Always implement neg and movcond
Date: Wed, 25 Oct 2023 21:13:58 -0700
Message-Id: <20231026041404.1229328-1-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Having opcodes always present means that we can remove some tests.
NOT and MOVCOND were *almost* always present anyway.

A close candidate is NOT.  The hiccup is s390x: except for the most
recent hardware revision, there is no single insn which can implement
the operation.

I experimented with replacements:

    i32: xilf r,-1             (6 bytes, requires R=X)
         lcr r,x; ahi r,-1     (6 bytes)
    i64: lcgr r,x; aghi r,-1   (8 bytes)

But both don't compare well with the current

         lghi tmp,-1           (4 bytes, shared)
         xgrk r,x,tmp          (4 bytes)

With the constant -1 managed by register allocation, it gets loaded
once and then reused between operations.

An alternative might be to assume the presence of all opcodes during
initial expansion and lower them later, after optimization.  I'm close
to doing just that for the more complex opcodes like deposit anyway,
because the expansion is too complex for the optimizer to do anything
sensible after constant propagation.


r~


Richard Henderson (6):
  tcg/mips: Split out tcg_out_setcond_int
  tcg/mips: Always implement movcond
  tcg: Remove TCG_TARGET_HAS_movcond_{i32,i64}
  tcg/mips: Implement neg opcodes
  tcg/loongarch64: Implement neg opcodes
  tcg: Remove TCG_TARGET_HAS_neg_{i32,i64}

 include/tcg/tcg-op-common.h      |  12 +-
 include/tcg/tcg-opc.h            |   8 +-
 include/tcg/tcg.h                |   2 -
 tcg/aarch64/tcg-target.h         |   4 -
 tcg/arm/tcg-target.h             |   2 -
 tcg/i386/tcg-target.h            |   4 -
 tcg/loongarch64/tcg-target.h     |   4 -
 tcg/mips/tcg-target.h            |   4 -
 tcg/ppc/tcg-target.h             |   4 -
 tcg/riscv/tcg-target.h           |   4 -
 tcg/s390x/tcg-target.h           |   4 -
 tcg/sparc64/tcg-target.h         |   4 -
 tcg/tci/tcg-target.h             |   4 -
 tcg/optimize.c                   |  15 +-
 tcg/tcg-op.c                     |  60 ++---
 tcg/tcg.c                        |  12 +-
 tcg/tci.c                        |   2 -
 tcg/loongarch64/tcg-target.c.inc |   9 +
 tcg/mips/tcg-target.c.inc        | 383 +++++++++++++------------------
 19 files changed, 192 insertions(+), 349 deletions(-)

-- 
2.34.1


