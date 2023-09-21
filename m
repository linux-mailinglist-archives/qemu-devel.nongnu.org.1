Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5657A984B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcI-0001z4-2t; Thu, 21 Sep 2023 13:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcF-0001yn-Ou
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcC-0007ef-TO
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-403012f27e3so13316735e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317843; x=1695922643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XhGk3GBdxEvMx812AhOFNtmmzN8nojmeRnwh2UQUEnk=;
 b=IHt3hQwZwB+9hQDYSjqJ2FRYMaDG2Y/cn0MMZ1o9F1Mi0s1i6vU+nv6jg3APsPBfrG
 9ZqNeOSG3FiiCSCbHiSIfTIe0QxRwn6LGgiBKfM9QdUdFWtdnDQiRwzYq/eqKu96x5VE
 XCFS+svaLfDpyuiaEJmky4r/anUH5UCZs//Nl6noUgjDTedvD3PMInt3bkgysunKsf1M
 w4neee6/L9mzj3ksyzTB75Dp2hNzihbA3Fj/SCS42MLdL6jSEZmVOLDZSKoydA17AKUB
 Y16RF5sWLjODvrpsKGLpJIydQCg2OXJKScF0o1xaUO98opXLc89ZuC/CL50IYsSOhTvv
 RKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317843; x=1695922643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XhGk3GBdxEvMx812AhOFNtmmzN8nojmeRnwh2UQUEnk=;
 b=jMLOu01VKmlk8oXo4ZkUxMfJEGck8jktHeQn1F0Rcb7hDg0c1r20RkXt2A4f9ucKWF
 Z3QMOS62iAivKe0CxRLObWrWOuE0H6F1Pzu1TU7e9Rs6DMa8aAGBRXakc45oDBl+oeFB
 ApWe1w8onUNbERzRToIBU2w1uLvGCctxluY+7Id0RjKwrg9xRi0uJEAPGxNTihwM5q7v
 wNRnK3bjN+l9o3we6QyKsb46H0xGO+CjxMPHQG5EiTADimf1xoXly93GtVnctPxWGaNr
 BdHWL8mBOpA7+gn1Cj8B03hXgjQqgixAAKi7TDhEP293RMbYLRiWs7DGwSyE5+SjbnJs
 Efvg==
X-Gm-Message-State: AOJu0Yzf+8BpYdNetKNWV0e6s6/hknhn0IaWZdku8HOxmssYO7bmJe/H
 aukdrbzKtxRitCazvdeCh8wYS85Ba18tfpfP0M0=
X-Google-Smtp-Source: AGHT+IFS/bfxvbtjwhtp8jbOwAZX+r6a9adDZY1phpdut+3Qsz3aMLdBkzJjiEwpXNxOZHnII2N6CA==
X-Received: by 2002:a05:6000:1108:b0:320:121:2300 with SMTP id
 z8-20020a056000110800b0032001212300mr5490617wrw.1.1695317843429; 
 Thu, 21 Sep 2023 10:37:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/30] docs/devel/loads-stores: Fix git grep regexes
Date: Thu, 21 Sep 2023 18:36:52 +0100
Message-Id: <20230921173720.3250581-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The loads-and-stores documentation includes git grep regexes to find
occurrences of the various functions.  Some of these regexes have
errors, typically failing to escape the '?', '(' and ')' when they
should be metacharacters (since these are POSIX basic REs). We also
weren't consistent about whether to have a ':' on the end of the
line introducing the list of regexes in each section.

Fix the errors.

The following shell rune will complain about any REs in the
file which don't have any matches in the codebase:
 for re in $(sed -ne 's/ - ``\(\\<.*\)``/\1/p' docs/devel/loads-stores.rst); do git grep -q "$re" || echo "no matches for re $re"; done

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230904161703.3996734-1-peter.maydell@linaro.org
---
 docs/devel/loads-stores.rst | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index dab6dfa0acc..ec627aa9c06 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -63,12 +63,12 @@ which stores ``val`` to ``ptr`` as an ``{endian}`` order value
 of size ``sz`` bytes.
 
 
-Regexes for git grep
+Regexes for git grep:
  - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st24\(_[hbl]e\)\?_p\>``
- - ``\<ldn_\([hbl]e\)?_p\>``
- - ``\<stn_\([hbl]e\)?_p\>``
+ - ``\<ldn_\([hbl]e\)\?_p\>``
+ - ``\<stn_\([hbl]e\)\?_p\>``
 
 ``cpu_{ld,st}*_mmu``
 ~~~~~~~~~~~~~~~~~~~~
@@ -121,8 +121,8 @@ store: ``cpu_st{size}{end}_mmu(env, ptr, val, oi, retaddr)``
  - ``_le`` : little endian
 
 Regexes for git grep:
- - ``\<cpu_ld[bwlq](_[bl]e)\?_mmu\>``
- - ``\<cpu_st[bwlq](_[bl]e)\?_mmu\>``
+ - ``\<cpu_ld[bwlq]\(_[bl]e\)\?_mmu\>``
+ - ``\<cpu_st[bwlq]\(_[bl]e\)\?_mmu\>``
 
 
 ``cpu_{ld,st}*_mmuidx_ra``
@@ -155,8 +155,8 @@ store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
  - ``_le`` : little endian
 
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_mmuidx_ra\>``
- - ``\<cpu_st[bwlq](_[bl]e)\?_mmuidx_ra\>``
+ - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
+ - ``\<cpu_st[bwlq]\(_[bl]e\)\?_mmuidx_ra\>``
 
 ``cpu_{ld,st}*_data_ra``
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -193,8 +193,8 @@ store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
  - ``_le`` : little endian
 
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_data_ra\>``
- - ``\<cpu_st[bwlq](_[bl]e)\?_data_ra\>``
+ - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data_ra\>``
+ - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data_ra\>``
 
 ``cpu_{ld,st}*_data``
 ~~~~~~~~~~~~~~~~~~~~~
@@ -231,9 +231,9 @@ store: ``cpu_st{size}{end}_data(env, ptr, val)``
  - ``_be`` : big endian
  - ``_le`` : little endian
 
-Regexes for git grep
- - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_data\>``
- - ``\<cpu_st[bwlq](_[bl]e)\?_data\+\>``
+Regexes for git grep:
+ - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data\>``
+ - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data\+\>``
 
 ``cpu_ld*_code``
 ~~~~~~~~~~~~~~~~
@@ -296,7 +296,7 @@ swap: ``translator_ld{sign}{size}_swap(env, ptr, swap)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
-Regexes for git grep
+Regexes for git grep:
  - ``\<translator_ld[us]\?[bwlq]\(_swap\)\?\>``
 
 ``helper_{ld,st}*_mmu``
@@ -325,7 +325,7 @@ store: ``helper_{size}_mmu(env, addr, val, opindex, retaddr)``
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
-Regexes for git grep
+Regexes for git grep:
  - ``\<helper_ld[us]\?[bwlq]_mmu\>``
  - ``\<helper_st[bwlq]_mmu\>``
 
@@ -382,7 +382,7 @@ succeeded using a MemTxResult return code.
 
 The ``_{endian}`` suffix is omitted for byte accesses.
 
-Regexes for git grep
+Regexes for git grep:
  - ``\<address_space_\(read\|write\|rw\)\>``
  - ``\<address_space_ldu\?[bwql]\(_[lb]e\)\?\>``
  - ``\<address_space_st[bwql]\(_[lb]e\)\?\>``
@@ -400,7 +400,7 @@ Note that portions of the write which attempt to write data to a
 device will be silently ignored -- only real RAM and ROM will
 be written to.
 
-Regexes for git grep
+Regexes for git grep:
  - ``address_space_write_rom``
 
 ``{ld,st}*_phys``
@@ -438,7 +438,7 @@ device doing the access has no way to report such an error.
 
 The ``_{endian}_`` infix is omitted for byte accesses.
 
-Regexes for git grep
+Regexes for git grep:
  - ``\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>``
  - ``\<st[bwlq]\(_[bl]e\)\?_phys\>``
 
@@ -462,7 +462,7 @@ For new code they are better avoided:
 
 ``cpu_physical_memory_rw``
 
-Regexes for git grep
+Regexes for git grep:
  - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
 
 ``cpu_memory_rw_debug``
@@ -497,7 +497,7 @@ make sure our existing code is doing things correctly.
 
 ``dma_memory_rw``
 
-Regexes for git grep
+Regexes for git grep:
  - ``\<dma_memory_\(read\|write\|rw\)\>``
  - ``\<ldu\?[bwlq]\(_[bl]e\)\?_dma\>``
  - ``\<st[bwlq]\(_[bl]e\)\?_dma\>``
@@ -538,7 +538,7 @@ correct address space for that device.
 
 The ``_{endian}_`` infix is omitted for byte accesses.
 
-Regexes for git grep
+Regexes for git grep:
  - ``\<pci_dma_\(read\|write\|rw\)\>``
  - ``\<ldu\?[bwlq]\(_[bl]e\)\?_pci_dma\>``
  - ``\<st[bwlq]\(_[bl]e\)\?_pci_dma\>``
-- 
2.34.1


