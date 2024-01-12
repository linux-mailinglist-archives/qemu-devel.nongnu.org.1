Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A582C738
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:24:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPvu-0003b9-RK; Fri, 12 Jan 2024 17:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOPvs-0003aw-UC
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:23:20 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOPvp-0002jv-UM
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:23:20 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2FF27CE2465;
 Fri, 12 Jan 2024 22:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E39CC433F1;
 Fri, 12 Jan 2024 22:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705098192;
 bh=NQfcFRjIUZJky5RoF9i4pzEm2bqPld5IeOEGPAv7l0g=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=coQJyIKxlz0g11FMD3cmJG7gRyaQWTT63hi+3gjRcZ0pyMa9ghKFgmUuKD4Y2zDdO
 H5tpkvIm/6RcMm4z7jn8v9dlcFSJwcuJa7Yc6TCFuJbm8PpegI9DtFSQ2bv5fg4dQD
 mn/nonZiiLV7cNlg7Ck/9J6bDKdAA2Snvb4zh2kb2OhAmoM713ywGkty5UJTe5yhp5
 EMgXXF/OfJ/stW3UUS+nMUEDh9Ngp4TDuRAI72F2f88TEux7NQvkgDESY3OX5XX2OF
 pFFRm1eUthIwEotNXsMpYEWg52QnR5RxIhRO8OtNCnQV0nbLWM0nIm3vra5gkm2qor
 zJQ3KraM9P9EA==
Date: Fri, 12 Jan 2024 23:23:08 +0100
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/9] target/hppa: Fix PDC address translation on PA2.0
 with PSW.W=0
Message-ID: <ZaG7zLKP3gFV4-H3@p100>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-5-deller@kernel.org>
 <551dac95-3346-41eb-aa8c-d22b19f8c4fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551dac95-3346-41eb-aa8c-d22b19f8c4fd@linaro.org>
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> Please adjust the code comment that immediately precedes this, not just
> within the commit message.

Like this: ?

Fix the address translation for PDC space on PA2.0 if PSW.W=0.
Basically, for any address in the 32-bit PDC range from 0xf0000000 to
0xf1000000 keep the lower 32-bits and just set the upper 32-bits to
0xfffffff0.

This mapping fixes the emulated power button in PDC space for 32- and
64-bit machines and is how the physical C3700 machine seems to map
PDC.

Figures H-10 and H-11 in the parisc2.0 spec [1] show that the 32-bit
region will be mapped somewhere into a higher and bigger 64-bit PDC
space.  The start and end of this 64-bit space is defined by the
physical address bits. But the figures don't specifiy where exactly the
mapping will start inside that region. Tests on a real HP C3700
regarding the address of the power button indicate, that the lower
32-bits will stay the same though.
[1] https://parisc.wiki.kernel.org/images-parisc/7/73/Parisc2.0.pdf

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Bruno Haible <bruno@clisp.org>

diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index 4c6ecda618..e4eac85880 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit 4c6ecda618f2066707f50c53f31419244fd7f77a
+Subproject commit e4eac85880e8677f96d8b9e94de9f2eec9c0751f
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 08abd1a9f9..4c28c58ee9 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -55,8 +55,14 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
         /* I/O address space */
         addr = (int32_t)addr;
     } else {
-        /* PDC address space */
-        addr &= MAKE_64BIT_MASK(0, 24);
+        /*
+         * PDC address space:
+         * Figures H-10 and H-11 of the parisc2.0 spec do not specify
+         * where to map into the 64-bit PDC address space.
+         * We map with an offset which equals the 32-bit address, which
+         * is what can be seen on physical machines too.
+         */
+        addr = (uint32_t)addr;
         addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
     }
     return addr;

