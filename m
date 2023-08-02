Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E976D38E
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 18:20:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qREZM-00062n-04; Wed, 02 Aug 2023 12:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qREZJ-000620-PY
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:25 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qREZH-0006Fm-Kb
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 12:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690993161; bh=8jTgPIWHUxVg4IO8II84q75EeJ9c5GfSF7Vd0/klmIs=;
 h=From:To:Cc:Subject:Date:From;
 b=nFa589TsZZZEhTZ0+8caV+abbfvDzqwxMr5SLMDkigjpRaHCtCCjBNkvLr5AXe4BC
 95rl2LYE7l4PbKdbi9E5SIj3/2YtMvUsxCF3YR8VtCcA0IByThpS2wM4oOUb0btVGC
 gAivuTD/KSM2pVzS8WybIRzWT0d2hjk3Bb/uxMVt2G5va3oFFbbecMvdH7CQNzUUhp
 KtXuAMaBKUAiXUZJPzHGLf7Q82GnYcr2JMkjuD4RDxIP8KTrp7zDbejKNLcuz5n/8c
 2/Xtp4WMGGipg0N6QcXEaKPe4xmEvWxNTCGTL/y8MZbpdSqo4oISgbTMHur2T1BZe7
 4m0ntz6RKIFEg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 43BC23F21D80;
 Wed,  2 Aug 2023 09:19:21 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id FN-niiTH-5zG; Wed,  2 Aug 2023 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690993158; bh=8jTgPIWHUxVg4IO8II84q75EeJ9c5GfSF7Vd0/klmIs=;
 h=From:To:Cc:Subject:Date:From;
 b=dbN1K8aDR8uBChDF35U6x0T3qsbxrWzDp54Of2EhqcPsfec2HHoniaGaA+8UgOIHA
 yyU+zV8PBU7nCM25V1B64miQ7Me6vcYr0N5biPFpByNTlC7tkN2HTJWVeaNgzlvBCR
 xGKs9OLMQ7sBBSWv4gzHo4I36p2knttZvJV/oeRAeyNwOAkDsNAgvW1/jsN0gkYtZt
 Coh1ZliT1R4V7Mapnm2qm2FuImOWz/0hLmTyzze3I1/ItRSxZ3f5kPaX5XV+sAmdgk
 WZzULFV2uSo8XRTCR4b6nGGvkvA4fOW1ESjqk65Y1Xa6dRxalqUkBiC2aP9WMVlEF6
 HG1K3xODMb1tA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id A89E63F20206;
 Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 6F2011E601E7; Wed,  2 Aug 2023 09:19:18 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 0/3] target/m68k: Fix a few semihosting bugs
Date: Wed,  2 Aug 2023 09:19:11 -0700
Message-Id: <20230802161914.395443-1-keithp@keithp.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The first two patches mirror similar patches I recently sent for nios2.

 1. Use correct parameter for EXIT (d1 instead of d0)
 2. Fix use of deposit64 in LSEEK (argument order was incorrect)

The second patch has also been submitted by Peter Maydell, it's
included here because it was required to get things working.

The final patch adds semihosting support for non-ColdFire processors
(which don't support the HALT instruction) by using BKPT #0 instead
(as per the m68k semihosting docs).

All of these have been tested using picolibc (patches for m68k support
there are moving upstream as well).



