Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B446A783E87
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYP9M-0006JR-UX; Tue, 22 Aug 2023 07:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP8t-00069l-E3
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:01:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP8j-0003GG-9L
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:01:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so3897219f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692702095; x=1693306895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1sMs3qGzSrhdLqdng/d5ESwTL5bPH7/wEcHeNoDe2OA=;
 b=kvHIONfczIFVgtcdZCtgOnibDo5HJcmTxnF2G0fHii/nY61inPmjQCKrs+MfkUNpKc
 rAy0/g3JGliKArP4RsZHggG9cNI5jD3bo4hH9bveLUbyRQywKZc87J+BXIEJW5e8x5qE
 fhFtjtGPo9mBq2n7WhLf5JZBNuVeIADQx+IzCI/nVhqhVxghR5yKKqT8yhxChhdhedTj
 8MRxUqQIGfND2lIqxdlLP9gS++zPgBvcq6tnelB5w8yjmejKJ5bs8PmcpJY4lZvREtzT
 tSeutQBAP3gjyqNEbyNkyCwHWEC5IDi5oR4fwY6JfT4mxBCAhGkq2aakdSANueTA/XnP
 Nyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692702095; x=1693306895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1sMs3qGzSrhdLqdng/d5ESwTL5bPH7/wEcHeNoDe2OA=;
 b=EwQT0aHKPuHAEZAfIeWrgQ5KSLRFMDfhTpT2bBzG+Ecu/yUS21V2Nmx8+fcM6AzcLY
 momrZMqcoRmQEXi+Lg13ofBwV4G7Hmhaw4W4kA7E4jgHT1qhGg0NgwuRKh2HxzkNPtB1
 rq2Sr4VZOfBxf9XYpY05abpLlbHaFVbMtQ7FP5WYf1zH4Rbx2sIRCnw/9pbYZdaBkYGJ
 +9yGirdDNuZ71BzR1pmr2KPXbodTbVBx1UrMSZiCw5Y5GGOTt+Fux+tT9yE6IN/z4dqv
 UQY7u6ll39Tjwc0MMvAXra5BLVtBaHsVxuFapqDkYhn+vv5KuE5KBYXL8YdJDacx/ltz
 DlDw==
X-Gm-Message-State: AOJu0YzI0XEyKcyOnruubxqP1hQOjATpS5yp9CQ6XsnjdgqyDyPg0QDX
 i7u+3FKSiw/LJdRa1g/C7jI2RW9GgXpjNbRDVWecXA==
X-Google-Smtp-Source: AGHT+IH1DNXN64HUzZkrV2i8d5MotaflF3YILbDIwr6FacRJ9hDNe/KbdfhPTinsqvPb2dXlYum+bA==
X-Received: by 2002:a5d:530a:0:b0:314:15a8:7879 with SMTP id
 e10-20020a5d530a000000b0031415a87879mr7595177wrv.34.1692702094175; 
 Tue, 22 Aug 2023 04:01:34 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 h1-20020adffa81000000b0031980294e9fsm15405183wrr.116.2023.08.22.04.01.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 04:01:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH 0/6] target: Use TCG generic gen_hswap_i32/i64()
Date: Tue, 22 Aug 2023 13:01:23 +0200
Message-ID: <20230822110129.41022-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Some targets open-code gen_hswap();
replace by the generic helper.

Philippe Mathieu-Daudé (6):
  target/arm: Use hswap_i32() in VREV/SMLAD opcodes
  target/cris: Use hswap_i32() in SWAPW opcode
  target/microblaze: Use hswap_i32() in SWAPH opcode
  target/sh4: Use hswap_i32() in SWAP.W opcode
  target/mips: Use hswap_i64() in DSHD opcode
  target/loongarch: Use hswap_i64() in REVH.D opcode

 target/arm/tcg/translate-a32.h              |  6 ------
 target/arm/tcg/translate-neon.c             |  4 ++--
 target/arm/tcg/translate.c                  |  4 ++--
 target/cris/translate.c                     | 14 +-------------
 target/microblaze/translate.c               |  7 +------
 target/mips/tcg/translate.c                 | 14 +-------------
 target/sh4/translate.c                      |  2 +-
 target/cris/translate_v10.c.inc             |  2 +-
 target/loongarch/insn_trans/trans_bit.c.inc | 16 +---------------
 9 files changed, 10 insertions(+), 59 deletions(-)

-- 
2.41.0


