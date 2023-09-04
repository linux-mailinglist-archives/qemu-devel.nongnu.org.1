Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B6791B5A
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:17:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCGF-0002MU-Qa; Mon, 04 Sep 2023 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdCGC-000258-Sj
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:17:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdCGA-0008Nv-AX
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:17:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso1244883f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844224; x=1694449024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VjDY4c8F9rfD2zVHTmHxX9NTugubDyKQYFuZQKiivIc=;
 b=sxhyFC5NySMRT0YUcoPAOoAJL7PQzm79ahQKRuXiyWmQ1wERSr7XMp2FkwRRMvVjyT
 shF8t8PFXsZ4abFQa01WrcKkqMHCUjtt23dwkmzswuGvDrL4RpxvBYSsuSELPWmgXrcf
 qaW4NRGUIi22vsw58z2Z526sjU2IFwJ2HKWVXm0lY/ArUZVx1ZMg0aIUVyCWFfBwaCjK
 M+305ax7W1B+1AbLjBm9X07QvabzhGEhYACRIHboEs/wtww75DAAZa8wGcxW5AUZxnn2
 36QDmK7PaiAZdzO6xPAZ2jLwMTIjWR+r+f8P2FHphMpzEbI1DLQuAg3J8O0g4VQiHSiF
 JVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844224; x=1694449024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VjDY4c8F9rfD2zVHTmHxX9NTugubDyKQYFuZQKiivIc=;
 b=AmCepfCZbl5lQI7OmwVmR4uKuUY56K3/TDcFXmFeJFxixcer9RASx1RnKWIRD9xXcu
 Lio9+YSEIC09PXA3gDF8pFeANKJjTBAUuePkM1OAAo1kKawL/7mKri87LMOr37FdI4BB
 mMblNGNfZ1doSfqJa4aJ+MjZSv7lxKSNVGQWynAIgqPbQnfu1MzEMWGNLiu034s2dzmT
 8biKmcQ4OXjRv0iHnFVB0vAqzB9G2ctsF2xMMzi81+n6CCcCjPwoktzcoYkgg5g9YB0r
 gWrVurNRgwnignRcyJM3IojRORNBqQnq72resROUBpTo1Abbuz6Q3MEhvAAiIjjqgAxo
 hswg==
X-Gm-Message-State: AOJu0YxhGe9hWLcrlvtkjN2pfc6dWjO19tzlDUwAVpADwu6yxI3YRBLU
 m25bveIp+9qDF+QICqLpBEmK/tOIOWRCDHGovY8=
X-Google-Smtp-Source: AGHT+IGR/LR4zd17PqC2mkySokxZq1+Z7/KORf4jLLx55z5kuZ8eXDAOcxxexEsX1y2+GHNEnODDsw==
X-Received: by 2002:adf:ebcd:0:b0:313:eaf5:515 with SMTP id
 v13-20020adfebcd000000b00313eaf50515mr7184092wrn.6.1693844224240; 
 Mon, 04 Sep 2023 09:17:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y13-20020adffa4d000000b00317df42e91dsm15022776wrr.4.2023.09.04.09.17.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 09:17:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/devel/loads-stores: Fix git grep regexes
Date: Mon,  4 Sep 2023 17:17:03 +0100
Message-Id: <20230904161703.3996734-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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


