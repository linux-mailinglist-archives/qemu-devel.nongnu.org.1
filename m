Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E9779764E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:06:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHTx-0000mJ-Jv; Thu, 07 Sep 2023 12:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTv-0000kd-P0
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTs-0001zK-Bz
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so1154069f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102622; x=1694707422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gWVct8aGT1hpymY8jXn5ajadM9E/lPCqc9fsY248s6Q=;
 b=PtDDHAHQ8ot+r70nmREMqWA/ORX4jIOtIzJBuUkL71IPFh731c90jeG7qnjuNg9nNM
 yEgCywBdDnld+RxxE6hsfv5ToqtHls9INWrKNk7aq5YxozkYS4J+Yt0VuSP6zBgXUvSe
 6/Ej8+e4B8oXCFS6nsruTe8D81+8914u5Hc35nY5d3JAMP33TP5I2SvgewbBFQOvy4/2
 6q+f7oLvLsm+qMN13PSrTmc90d8e08i2wjHo3v67Eo8f3l/SDJU0AhnbAwHMi6ktSXPQ
 ECV/bQowJmx3ezI/402FIa4WpyMBkvQHkx1Q9VZvuR01bXfoKxdn806BUXu44EfKcdYI
 Gy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102622; x=1694707422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gWVct8aGT1hpymY8jXn5ajadM9E/lPCqc9fsY248s6Q=;
 b=AxlSiik+GmOBSittntIc5dxEJ/2tS/K9/5/+z8dZYkCv0Ic5IDAN7EtheLoawyuA29
 aBeOGoBx1knG+7EXbm2mzaHzrfi3DPsVrE5vrBs3bJfreHLSSZgVMcXxG8pbwClLwJI/
 OshzjNhVF84t9Jmdxx9lsegNLjpz3gAB+0UbkCI/371bLyiwdgDltLA+RYmgJoR9Evxn
 i9nCw4ij3JQqUjrSNJ/1VWJf94B2DRccFpPBB5U/oDgknb8hm1CESJ7WxlxaBcMAIu3k
 EkTe4AQTPOxIrHXX+ev8vdrVSu+Jog5RaU6OWaYQL2lZCMcPI3PBacndquoGGwBPYroO
 WwUQ==
X-Gm-Message-State: AOJu0YwSwCIT7tdeQ6aviMNaLzyD6efgPshlM+Ca4LDj5eu4nfy16140
 r2wzCssZ8l3GlX31muo7x39G8VBEU72NRAuoz4w=
X-Google-Smtp-Source: AGHT+IGgPAWsYWJYynpycfxFVpOYC9s8ugiHyDfx7NaAaBCaRCYHWxASvkYSIwtq+iEySwW9PFUaPQ==
X-Received: by 2002:a5d:6550:0:b0:314:3fc0:ba82 with SMTP id
 z16-20020a5d6550000000b003143fc0ba82mr4586870wrv.37.1694102622536; 
 Thu, 07 Sep 2023 09:03:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/14] target/arm: Implement FEAT_MOPS
Date: Thu,  7 Sep 2023 17:03:26 +0100
Message-Id: <20230907160340.260094-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

This patchset implements the Arm FEAT_MOPS architectural feature,
which is a set of instructions to implement memory copy and set
operations. The new instructions come in sets of three:
 * SETP, SETM, SETE -- memory set
 * SETGP, SETGM, SETME -- memory set with MTE tag setting
 * CPYP, CPYM, CPYE -- memory copy
In each case the copy or set is divided between the "prologue",
"main" and "epilogue" instructions in an implementation-defined
way; in guest code they are expected to always appear in order.

The first couple of patches here are a cleanup (already been seen
on list) and a bugfix for something I noticed while testing the
MTE related parts of this.

There are two things in this patchset that are not currently ideal:

 (1) the MTE tag checking is correct, but not optimal for
 performance, because it reuses the existing checkN() function,
 which was designed to work on small memory areas and so
 prefers to read tag memory a byte at a time rather than in
 larger chunks that then need masking. I have opted to leave
 this as a TODO comment in the code for future improvement
 rather than try to address it in the initial submission.

 (2) we use the same approach the s390 memcopy instruction
 does, of checking for interrupts periodically so that a
 memcopy of 2GB doesn't stall the whole system. This doesn't
 work for icount mode, because there interrupts are all timed
 to number of instructions executed and the memcopy is still
 only a single insn regardless of how long it takes. I've
 not tried to tackle this because I'm not totally sure of
 what the right thing is, and also because it's a preexisting
 problem with the s390 equivalent insn anyway...

I think it's OK for this to go as-is, and we can think about
those problems later, but am open to other opinions on that.

thanks
-- PMM

Aaron Lindsay (1):
  target/arm: Add ID_AA64ISAR2_EL1

Peter Maydell (13):
  target/arm: Remove unused allocation_tag_mem() argument
  target/arm: Don't skip MTE checks for LDRT/STRT at EL0
  target/arm: Implement FEAT_MOPS enable bits
  target/arm: Pass unpriv bool to get_a64_user_mem_index()
  target/arm: Define syndrome function for MOPS exceptions
  target/arm: New function allocation_tag_mem_probe()
  target/arm: Implement MTE tag-checking functions for FEAT_MOPS
  target/arm: Implement the SET* instructions
  target/arm: Define new TB flag for ATA0
  target/arm: Implement the SETG* instructions
  target/arm: Implement MTE tag-checking functions for FEAT_MOPS copies
  target/arm: Implement the CPY* instructions
  target/arm: Enable FEAT_MOPS for CPU 'max'

 docs/system/arm/emulation.rst  |   1 +
 target/arm/cpu.h               |   8 +
 target/arm/internals.h         |  55 +++
 target/arm/syndrome.h          |  12 +
 target/arm/tcg/helper-a64.h    |   8 +
 target/arm/tcg/translate.h     |   4 +-
 target/arm/tcg/a64.decode      |  33 ++
 target/arm/helper.c            |  32 +-
 target/arm/hvf/hvf.c           |   1 +
 target/arm/kvm64.c             |   2 +
 target/arm/tcg/cpu64.c         |   4 +
 target/arm/tcg/helper-a64.c    | 816 +++++++++++++++++++++++++++++++++
 target/arm/tcg/hflags.c        |  21 +
 target/arm/tcg/mte_helper.c    | 280 +++++++++--
 target/arm/tcg/translate-a64.c | 157 ++++++-
 15 files changed, 1366 insertions(+), 68 deletions(-)

-- 
2.34.1


