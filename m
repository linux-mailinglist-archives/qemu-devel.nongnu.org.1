Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B34B77D3BA
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Am-00052N-JE; Tue, 15 Aug 2023 15:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ak-00051u-RU
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ai-00012U-DJ
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6887059f121so586464b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129463; x=1692734263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UoPGaNmy3d49JYgjfGN387TdWSZZoEef5RmDjo8y+zo=;
 b=Edw9DCARFQQPefHOUOUEwVLi/djeNLJThdZXHmwOp6+y+rwBc+w0NE+gB6aRprdz5Q
 MupJWj+3S4XmhHbO9vqnYjXN1BKEMkpEKsAdCv1LrmO8TTyeCvy/+JqFcRdnkunHfgvF
 wvT9zia1IsXqRdofsKbO95P102dj22rDYnT3uDvpq0BB6Jo6qULDMx9qz9tOemR2J5Cn
 2ULmCB+k/BVY6uKMNe4RRGZSVULgxhYTg8OhS4ZNIQ6n1rafLHpghWoC/Xadz5I+tfdn
 +ugOAacNju0ZRCSjH8MGb76+aM+KaSLd1e7L8q4h4j58dSKTTT/++lKWSIv5GWJ7jbjn
 yfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129463; x=1692734263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UoPGaNmy3d49JYgjfGN387TdWSZZoEef5RmDjo8y+zo=;
 b=WvYpyCMKhvHor12yA6r3hfhCeO8Gmgy30dDeIbrciOuoXwNAMcLeNWgqaSU0zMZ2bh
 RIsKjkGuR69opbMCI2Xjb78r3cJEGPghcTQAq6wNf3PCK7Ii27rrsBq8u9xnSTAIYEA6
 DtbYnc0fq+YGzNFvbVLgv99PjaVR4eRJLCVW9DTsCngy0SglZ0S5WWQV/DJNf5x7w1UO
 9DnX2hBZF69FX7lBgdrjZFFyZtqEFv/H+eZHTF9gZQoPulRoYRKWv0d9YAOunHSqi+wQ
 EmHbdYasOgg5atfA07kSXQxvC3W+fXMOugv0x+yBhYmoifBTN7G6a351wYWwO3ik6VeW
 MfUg==
X-Gm-Message-State: AOJu0YyfwOGHkLPrEseDmbB/X8PlpVP8DmnHsLO8HeFGrywRMMu04dXE
 X03hV07ZSZNxvxq2n1nHcrbKydAStaNAsLeq+4o=
X-Google-Smtp-Source: AGHT+IEBCQvmnVr6eCVjdGpohzf55EFlMOPlRVEhy//9+MyN+kYuY3NMP3WDYVJgUZuie37QDxPQTQ==
X-Received: by 2002:a05:6300:8003:b0:132:79da:385a with SMTP id
 an3-20020a056300800300b0013279da385amr12372035pzc.23.1692129462667; 
 Tue, 15 Aug 2023 12:57:42 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 00/14] tcg/ppc: direct branching, power9, power10
Date: Tue, 15 Aug 2023 12:57:27 -0700
Message-Id: <20230815195741.8325-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Supercedes: 20230808030250.50602-1-richard.henderson@linaro.org
Supercedes: 20230815050117.34731-1-jniethe5@gmail.com

Build on Jordan's patch to allow direct branching and USE_REG_TB
to co-exist.  Use the power9 addpcis wherever pc-relative addrs
might be handy.  Merge in my power10 patches for prefixed insns.

Finish up with an RFC to disable TCG_REG_TB for power9+, when
pc-relative code sequences exist.  I've only lightly tested this,
and it seems to increase code size by a few insns per TB.  It
really depends on how much we end up using the constant pool.

What is needed is to determine if !TCG_REG_TB helps.  If it doesn't,
then some of these patches could be dropped as unreachable.


r~


Jordan Niethe (1):
  tcg/ppc: Enable direct branching tcg_out_goto_tb with TCG_REG_TB

Richard Henderson (13):
  tcg/ppc: Untabify tcg-target.c.inc
  tcg: Add tcg_out_tb_start backend hook
  tcg/ppc: Reinterpret tb-relative to TB+4
  tcg/ppc: Use ADDPCIS in tcg_out_tb_start
  tcg/ppc: Use ADDPCIS in tcg_out_movi_int
  tcg/ppc: Use ADDPCIS for the constant pool
  tcg/ppc: Use ADDPCIS in tcg_out_goto_tb
  tcg/ppc: Use PADDI in tcg_out_movi
  tcg/ppc: Use prefixed instructions in tcg_out_mem_long
  tcg/ppc: Use PLD in tcg_out_movi for constant pool
  tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
  tcg/ppc: Use PLD in tcg_out_goto_tb
  RFC tcg/ppc: Disable TCG_REG_TB for Power9/Power10

 tcg/tcg.c                        |   3 +
 tcg/aarch64/tcg-target.c.inc     |   5 +
 tcg/arm/tcg-target.c.inc         |   5 +
 tcg/i386/tcg-target.c.inc        |   5 +
 tcg/loongarch64/tcg-target.c.inc |   5 +
 tcg/mips/tcg-target.c.inc        |   5 +
 tcg/ppc/tcg-target.c.inc         | 280 ++++++++++++++++++++++++++-----
 tcg/riscv/tcg-target.c.inc       |   5 +
 tcg/s390x/tcg-target.c.inc       |   5 +
 tcg/sparc64/tcg-target.c.inc     |   5 +
 tcg/tci/tcg-target.c.inc         |   5 +
 11 files changed, 288 insertions(+), 40 deletions(-)

-- 
2.34.1


