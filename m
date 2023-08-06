Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D947714E3
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScha-0000GH-U5; Sun, 06 Aug 2023 08:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchX-0000Cr-2q
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001md-EO
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=mRkTYdBmZ8HeR/4MFaNqDw6eQy2u65G/+JhLkB5yVp8=;
 h=X-UI-Sender-Class:From:To:Subject:Date;
 b=lSXMxblUXI3rgKIdrBNaZmYpiQC+vJJXxdZP28+dh7MG7uGhSSXPZIa/juqy6HnNv6aeFEH
 f8hlbKNvEqqxXC5T/T7qOwQYblF4JR38pnOwM9il7+B+KanQrnu7KQhiH6F57xen1Sfo0LkfI
 02uuKtHYac0fnKGaludX0n54nyx2WrcrVr5vr/kC0RQGhVqdr6EKobYov3vChNYYglwi7ZyHe
 BEeu543ToOVz7TjlnyxV8hF9jvAocvY90xmE62bjQAsMmd/OKp2tKdbuT7HD/PqszBBaMQDzg
 JFuAflGHgtNs+ybQ80gq7jURltOsrm02sFqiiNVMeMNgvXpzwr2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1pdPkc4AFm-00y71W; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/23] Introduce MMU_INDEX()
Date: Sun,  6 Aug 2023 14:17:09 +0200
Message-ID: <20230806121732.91853-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EfprE1WGyjWK7ZlE6AfwjALxgFhLfUHt/pl59XkO+8LLuFRV5t8
 dLR/XwnoQ/7yIA/0Du0wJHNC4erudsAF52pL9TmEp3ekObZB18TdzfPhKdABjrVuyv3g42y
 AphU/KfDXAfhagGDvvodpuK+D9nifM5fYyLQ8BxGfBZvCb6e+UJZy5J5S5E89izA5Q7OE/o
 j+GNXuOWK7Mlw99QHzu/Q==
UI-OutboundReport: notjunk:1;M01:P0:wL015sKgvq4=;U6pWXAoYaP6u6ReJCkIpovoSu1w
 8YuI0F3QN6x/1mGhIfeabnEFytxAZKygctMz4GAtaV+MRPYHA9RF2GdsR/CvDseNfG1cQRyid
 B4irR7wssEuLHmD5lsTm6MqqfAiIjwkbrBmAIOvnjtKXcOUizXZtwXWI7K0ybUuPOiZ5RuiGh
 pjYNCjgEZDr9q2LKFB/OyfZnrBuDMhPMopxSHaB6KbmC3xplWlp7nzZcK3HIxWt4HaX+PNpe9
 0E25N4X5y8idy+i1JLKzxj5dGvKm2sbDFpb3+wZTvcJYmIaTnaK0LxGHq19rb/HG+8CKIZO9B
 ogCdKtfm6KUFqq8sS6zgMsConY8+FV6ERRhs86IYeHcMagHR+Hrlbr0pPDn3Eb8KJPD0Cyut6
 iISmbO1hufsdAmdV3SbOPVExEYSwjv5DFePPrCHW/yHjrk2riUQp4Q5XF1jNQOmFYWVTa0pxb
 MRGRXMDu+ansmWGH8W9w7Me0H77yfeFOyQBGHmQPMO+9ivoITFD7MvMEAeq+jab8iOnqHfUvo
 O9fsdmgmVeMguzPQiTQnVp1jfhm9ZxdrChccz0Cpw1X8sOukdoDbQXmuL89kFhlH//Rx7d4F+
 gSpo/8N+gB3Uz9+txrvwAEAEDwx40M8JnB0m+aPmlOeSNDhwOHF1gKOVysCK6xKDngH+0xV/X
 bITqal1ZHLI+nWTpm0Sdll7pSXY5x0CPWWGFFf3B1+LKTI/05Gt3ZSHx6eBlBKnqgiYMTH/Dl
 aJoyZvi71U4bANIAtR8UxnQ/3bKx66x/mvOMVS8O2c8XmcYrwT6oMVVi/k3DwRck23ZUIJypl
 xzBxnLCZYxvdbm1cR1tzLn+DBkYVXbj2o14iq5YYFciw3uI4RpDyqqXpltGft3s8DsOFeXS43
 XF5faMtoiv4pbAGMEd5TKgdCOnNTuKZbnxuOfMx+DSvAViwJ30bDhLYeemaaMiUi+FMbe6WCl
 f8cFnwJV3c1XDIPDhanLaigWVsQ=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is v2 of the patchset.
It is *identical* to v1, but v1 missed patches #20-24 since I hit
a mail batch limit with my email provider.

This patchset introduces the new helper macro MMU_INDEX().
whill will (after applying the last patch) allow to generate
 smaller code by the tcg.

Patch #1 adds the MMU_INDEX() helper macro, which simply wraps
the given value.

Patches #2-#23 are trivial patches which convert each target to use the MM=
U_INDEX()
macro.

Patch #24 switches MMU_INDEX() to return a new MMU idx which
is counts down from (NB_MMU_MODES-1). That change reduces the needed
negative offset to access the TLB entry which in turn let the tcg compiler
generates smaller instructions.

Please review.

Helge

Helge Deller (23):
  cpu-defs.h; Add MMU_INDEX() helper
  target/i386: Use MMU_INDEX() helper
  target/hppa: Use MMU_INDEX() helper
  target/alpha: Use MMU_INDEX() helper
  target/avr: Use MMU_INDEX() helper
  target/hexagon: Use MMU_INDEX() helper
  target/loongarch: Use MMU_INDEX() helper
  target/mips: Use MMU_INDEX() helper
  target/openrisc: Use MMU_INDEX() helper
  target/riscv: Use MMU_INDEX() helper
  target/s390x: Use MMU_INDEX() helper
  target/sparc: Use MMU_INDEX() helper
  target/xtensa: Use MMU_INDEX() helper
  target/arm: Use MMU_INDEX() helper
  target/cris: Use MMU_INDEX() helper
  target/m68k: Use MMU_INDEX() helper
  target/microblaze: Use MMU_INDEX() helper
  target/m68k: Use MMU_INDEX() helper
  target/ppc: Use MMU_INDEX() helper
  target/rx: Use MMU_INDEX() helper
  target/sh4: Use MMU_INDEX() helper
  target/tricore: Use MMU_INDEX() helper
  cpu-defs.h: Reduce generated code size by inverting MMU_INDEX()

 include/exec/cpu-defs.h   | 10 ++++++++++
 target/alpha/cpu.h        |  6 +++---
 target/arm/cpu.h          |  4 ++--
 target/avr/cpu.h          |  4 ++--
 target/cris/cpu.h         |  4 ++--
 target/hexagon/cpu.h      |  2 +-
 target/hppa/cpu.h         |  6 +++---
 target/i386/cpu.h         | 10 +++++-----
 target/loongarch/cpu.h    |  8 ++++----
 target/m68k/cpu.h         |  6 +++---
 target/microblaze/cpu.h   |  6 +++---
 target/mips/cpu.h         |  6 +++---
 target/nios2/cpu.h        |  4 ++--
 target/openrisc/cpu.h     |  6 +++---
 target/ppc/cpu.h          |  5 +++--
 target/riscv/cpu.h        |  4 ++--
 target/riscv/cpu_helper.c |  2 +-
 target/rx/cpu.h           |  2 +-
 target/s390x/cpu.h        | 10 +++++-----
 target/sh4/cpu.h          |  7 ++++---
 target/sparc/cpu.h        | 20 ++++++++++----------
 target/tricore/cpu.h      |  4 ++--
 target/xtensa/cpu.h       |  4 ++--
 23 files changed, 76 insertions(+), 64 deletions(-)

=2D-
2.41.0


