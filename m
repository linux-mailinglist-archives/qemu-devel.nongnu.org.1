Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B879A867
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhMU-0005ol-El; Mon, 11 Sep 2023 09:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMR-0005ii-Mb
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMH-00039T-Nr
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2775941f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694440423; x=1695045223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=k0jBq4oF6jCx/majD4+9H6Sti+74uufIErJN9e/RdIs=;
 b=KJuK+Gz6gfyisUU9hM+bwrXKV+iDaECheoZP1z7gqd5q0jq7eaeXseroWxQU92HSKs
 qePG3N2FkJSMfL6fzLCWsFU+yyan9BzLUtAhmorDKg8BUPBu9rII2ua+dss6nwdaDyZs
 XMZ5hZvLJ1vv6gqMxy7hlqU+f6v/O+kyYxYdRmflzNSITl3U1OrinVMIcFqOdmXyz7TC
 cvCMVygeZ34BOgZtPJHBSAzlwK3HI9L0ZEg7K//RW0DYszvgBGV4HWNeFXmu40bMUSKP
 q80Bdf3sL3jkqvwqOuCQNZ+Tm60+Vd+kPWUKvwDqlEh6NAEgM11jKfM/YeooLMBvKjf0
 FDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694440423; x=1695045223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k0jBq4oF6jCx/majD4+9H6Sti+74uufIErJN9e/RdIs=;
 b=NIuCEEXmCfYQoSI+Lz/0VR4HiV6l+wH9LITzrTIwEYOGvnTQ64/lsfwl440GBKgp8i
 u69wOiPP0ue6LuPWzUIyapjTYkJsLYAiXrb1mujpFjuAxMrndJFe5pAWvJZ3fOX5IvjJ
 ayxD4wjYA5AObvIWHdp5LvgJ+7m4FM8pekTcJ903MuNAZ0dqEUbsfGdiRAZU+H1wdc8/
 2fRQE8l0JJp1/Jd9ul0eK4i3qHGWJslvJ8ahM0Vk9CZ7ja3SVlVVqMUksHvYrIfkvufx
 P8kGGyUUytPsXzS4CteEemAXb/MHTb+xvD2cCi+de/bzJ3Hy95m28N7VxDjQ+1Ue/LxV
 u8Vg==
X-Gm-Message-State: AOJu0YwTcuND2yIsf36GnfiNhHFPaNunEbiQlKgnCEy2dR5fO/npdebK
 QEKHeqoO4A9dSd2tWbu97zFMhlWJe4S5BnZ/s+o=
X-Google-Smtp-Source: AGHT+IFDlsRHjx47MkEq05cgh3wrPgBES/cI+qLxTeAMoprBQ9YCGyaw4+CFbD14U+z5ko+Sgtgrig==
X-Received: by 2002:a5d:540e:0:b0:319:55f9:d50d with SMTP id
 g14-20020a5d540e000000b0031955f9d50dmr6664320wrv.33.1694440422993; 
 Mon, 11 Sep 2023 06:53:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm10079758wrq.49.2023.09.11.06.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 06:53:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/7] target/arm: hwcaps updates, FEAT_HBC
Date: Mon, 11 Sep 2023 14:53:33 +0100
Message-Id: <20230911135340.1139553-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

This patchset started off as "implement FEAT_HBC" but I ended
up finding I needed to do a bit of cleanup regarding the elf
hwcaps bits, so most of the patchset is that cleanup and the
FEAT_HBC is the simple patch at the end.

Patch 1 is the ID_AA64ISAR2_EL1 that's been on the list multiple
times already. It's in a target-arm pullreq that's already on
the list, so I've only included it here so the series compiles
as a standalone patchset.

Patch 2 is a bugfix for some errors in feature string names
in the emulated /proc/cpuinfo.

Patches 3-6 update our definitions of hwcap bit values from the
current Linux kernel source tree, our ID register field definitions
from the current public system register XML, and make sure we're
in sync with the kernel about what hwcap bits we report and what
ID register fields we expose to user-only guest processes.
(The only actual bug fixed here is some missing arm32 hwcap bits,
but the rest of the changes are useful to, for instance, let us
add FEAT_HBC support.)

Patch 7 is the actual FEAT_HBC support. This feature is a variant
on the B.cond conditional branch that provides some hint
information to the branch predictor; since we don't do branch
prediction this is easy for us to implement.

Patch 7 will have an obvious trivial textual conflict with
the FEAT_MOPS work; I suspect this will get in first, since it's
much simpler. I also forgot about the hwcap for FEAT_MOPS, but
once these patches are applied that is a one-liner fix to add
the GET_FEATURE_ID(aa64_mops, ARM_HWCAP2_A64_MOPS).

thanks
-- PMM

Aaron Lindsay (1):
  target/arm: Add ID_AA64ISAR2_EL1

Peter Maydell (6):
  linux-user/elfload.c: Correct SME feature names reported in cpuinfo
  linux-user/elfload.c: Add missing arm and arm64 hwcap values
  linux-user/elfload.c: Report previously missing arm32 hwcaps
  target/arm: Update AArch64 ID register field definitions
  target/arm: Update user-mode ID reg mask values
  target/arm: Implement FEAT_HBC

 docs/system/arm/emulation.rst  |  1 +
 target/arm/cpu.h               | 28 ++++++++++++++
 target/arm/tcg/a64.decode      |  3 +-
 linux-user/elfload.c           | 71 ++++++++++++++++++++++++++++++----
 target/arm/helper.c            | 15 +++++--
 target/arm/hvf/hvf.c           |  1 +
 target/arm/kvm64.c             |  2 +
 target/arm/tcg/cpu64.c         |  4 ++
 target/arm/tcg/translate-a64.c |  4 ++
 9 files changed, 118 insertions(+), 11 deletions(-)

-- 
2.34.1


