Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 184C279D32E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:05:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg40z-0008AH-Fs; Tue, 12 Sep 2023 10:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40W-00086Q-Mr
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:04:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40L-0003pU-QI
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:04:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so64844995e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527476; x=1695132276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=N0l3cNMDjTcat81VeeDZ5nH8TL6OPDrztoRIGeuKelg=;
 b=hUER+QCWwPz36UdPonNMQ0YSHdj9LCmKhmRWXRKwaqEC2R9wP9v7LuGGCi/DcQqaxZ
 8EsAqNrIGEQ5+NSgYG85FNg6JiAv5UCDoL8GrUp/wsdxpz/irRN+KgORzTo8Eyg2w1ko
 CbB8CRpGtXB+RkobIRuA8+iXA2hfi+POVbijZSpRQ9U2GKNv4vAGWn+o6z6LZ8ZQWQod
 cDXQP4b5SzVqgLWdH3jYIXh0HjrW4TZR4TF3GaBj6cVWJdbAOqFImL9NlZZZKFTFVWRu
 iQuI1ahbHE6vTQINPthf7BRQ7QM1PJnp5XJOdE64PeGOlTpH5movCqRCwUOGFZm1utTm
 jWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527476; x=1695132276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N0l3cNMDjTcat81VeeDZ5nH8TL6OPDrztoRIGeuKelg=;
 b=KPvjOZS5o+eY+QVpPExDFRe6cOBxCU/CLlSaSyzhQKo4WwuO2wncsacxwCBIhX+Mxw
 zbRZVpnqbRLlWGJJ5vCSzaHe18ZFOAJdmGRcYf2FioKRhsmqjICTkuGOSonOGJm85PDf
 TcVWXQFIZjcD+KNSKx8qrYBjkuKg3FQVJJ1mKN232A3TK08sGrs0eAHEpPUezRTfGFgE
 ylDmU9zs7PdxScZW4wPHgFeXct0mQiF256Ks7af6aj1zOLhbirrUcmX1Dw4BB9ySo6/B
 gRm/OWroqamoS1cElzaQvl0nxDayPpOKDzQ30FqYwwmVKcnwP8HuYZ15ssUQdDJPy1hG
 bJaQ==
X-Gm-Message-State: AOJu0YyMRVw4JucutjZYP+IdFkO6fywhdMY9PQe7re67SA3xhcobR8fM
 dgoAN2eNSByXCCvOuHeJyFa4LYpkEqknYqtocgQ=
X-Google-Smtp-Source: AGHT+IGqCVusG0PFhyrJMAdqHHiwNySYaAkr4Wc9ED4IuvQ0s3a0BLWKgs4XSKoxjiBGBy4k/mG9BQ==
X-Received: by 2002:a7b:c01a:0:b0:401:d3dd:c3c with SMTP id
 c26-20020a7bc01a000000b00401d3dd0c3cmr10810113wmb.39.1694527475794; 
 Tue, 12 Sep 2023 07:04:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm12892672wrq.49.2023.09.12.07.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 07:04:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] target/arm: Implement FEAT_MOPS
Date: Tue, 12 Sep 2023 15:04:22 +0100
Message-Id: <20230912140434.1333369-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

This patchset implements the Arm FEAT_MOPS architectural feature,
which is a set of instructions to implement memory copy and set
operations. The new instructions come in sets of three:
 * SETP, SETM, SETE -- memory set
 * SETGP, SETGM, SETME -- memory set with MTE tag setting
 * CPYP, CPYM, CPYE -- memory copy
In each case the copy or set is divided between the "prologue",
"main" and "epilogue" instructions in an implementation-defined
way; in guest code they are expected to always appear in order.

Based-on: 20230911135340.1139553-1-peter.maydell@linaro.org
("target/arm: hwcaps updates, FEAT_HBC")
so we can set the MOPS hwcap in the last patch.

Changes v1->v2:
 * one patch already upstream
 * patches 7, 9, 11 updated to have separate helper functions
   for SET vs SETG and CPY vs CPYF
 * use cpu_st16_mmu() for SETG memory set
 * fix CPYFP saturation limit
 * CPYFM and CPYFE now correctly always copy forwards
 * patch 12 now sets the MOPS hwcap bit

Patches still needing review: 11, 12

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

Peter Maydell (12):
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
 target/arm/cpu.h               |   7 +
 target/arm/internals.h         |  55 +++
 target/arm/syndrome.h          |  12 +
 target/arm/tcg/helper-a64.h    |  14 +
 target/arm/tcg/translate.h     |   4 +-
 target/arm/tcg/a64.decode      |  35 ++
 linux-user/elfload.c           |   1 +
 target/arm/helper.c            |  28 +-
 target/arm/tcg/cpu64.c         |   1 +
 target/arm/tcg/helper-a64.c    | 878 +++++++++++++++++++++++++++++++++
 target/arm/tcg/hflags.c        |  21 +
 target/arm/tcg/mte_helper.c    | 241 ++++++++-
 target/arm/tcg/translate-a64.c | 160 +++++-
 14 files changed, 1419 insertions(+), 39 deletions(-)

-- 
2.34.1


