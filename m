Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 971E870DBF5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ql5-0002PC-2g; Tue, 23 May 2023 08:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql3-0002OL-38
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql0-0008Q9-Oa
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f60dfc5f93so3008565e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684843489; x=1687435489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m48o9UKPJBNyKWN1u+Z5qrJZ+esObNyORYdpABQw87E=;
 b=F2GgIQoy3gd8+ezAAco5cDdO1sKt2iRWc3EKBADr+KcGXkQym1XRE9dJ2y5XvAOmjT
 1ZGUY8gtNi94SrLeeoZxVambCG2OBh5NEA+O3MPlGbMZdZ9Xycw8nVTOX+1MCmjRH3FL
 +jTYdSi5dX1twhCk0g20HdLgICUX7aStFWQgJIl3h3HlZYTqaDBNfFE1nZabx+39AXNX
 P0VHF27x84s0B7YzcLxPUZDbwnpUcgbJw4XsZcJp6K2QYfmpCNjr8uSCyfuaNvRDKMxN
 qE565m5d3p2hLd0iHyciN+4fOZK7J3BqhrMHwKptedzAptMKyZ455aupQan4uVmB7fuD
 Pndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684843489; x=1687435489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m48o9UKPJBNyKWN1u+Z5qrJZ+esObNyORYdpABQw87E=;
 b=PobNTM7qhd5ClgHYOmPuA7ZvMzmCxW9WcAKrhSHJL2of4hIo03DYSPAqVftXdTfm+Y
 OtSm+zftQebC+3UZ0ifh2iNghvUGMYLZuDb3JxCTZ0dprZNRxnOOnmlFj4s0NObVPNdG
 75cVz4/hHAmsi3cn5TQXMMCMFl3i7n+ZNdMO0TLbuB2HXV8RyjW1X7aggTLx4b+nSSPL
 6LJvY2naPJ7rg0XoU8rB62Prk7hyqwsohRH76F1zyEHlLr5wxHEgNA3mCr+Wio/nAbTC
 N0G5m2MGoxWop6fBR4LHOIAcDZJIFkqF8mgldMOp2YJ32NaRlx3mQjrQECAz/Uq22i3v
 SG+w==
X-Gm-Message-State: AC+VfDwThVB2GJyWZmAtI11IZqaE5sSybqoysyW6UyH8ZgsKqQkq2Nhk
 YVo7GcbUB+Eqnh87Se8WbWDh+/RGl+l0ufhLPJg=
X-Google-Smtp-Source: ACHHUZ7m4VZiC5Cr1bHDC/EVqWOgEhit6DmLAXmP7fHW2XrATrd4MjQkkirfn6Ym3eu3C8rs2HuCPA==
X-Received: by 2002:a05:600c:2288:b0:3f4:298f:4d01 with SMTP id
 8-20020a05600c228800b003f4298f4d01mr9497434wmf.26.1684843489018; 
 Tue, 23 May 2023 05:04:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm10848778wrm.19.2023.05.23.05.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:04:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/6] decodetree: support named fields
Date: Tue, 23 May 2023 13:04:41 +0100
Message-Id: <20230523120447.728365-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patchset adds support to the decodetree generator
for "named fields", where one field can refer to some
other already extracted field, as well as to portions
of the instruction word. The specific case where I want
this is for some load/store insns in the A64 decoder:

# Load/store with an unsigned 12 bit immediate, which is scaled by the
# element size. The function gets the sz:imm and returns the scaled immediate.
# For vectors, opc bit 1 (insn bit 23) is effectively bit 2 of the size.
%uimm_scaled    10:12 sz:3 !function=uimm_scaled
@ldst_uimm      .. ... . .. .. ............ rn:5 rt:5 &ldst_imm unpriv=0 p=0 w=0 imm=%uimm_scaled
STR_i           sz:2 111 0 01 00 ............ ..... ..... @ldst_uimm sign=0 ext=0
LDR_i           00 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=0
LDR_i           01 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=1
LDR_i           10 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=2
LDR_i           11 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=3
LDR_i           00 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=0
LDR_i           01 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=1
LDR_i           10 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=2
LDR_i           00 111 0 01 11 ............ ..... ..... @ldst_uimm sign=1 ext=1 sz=0
LDR_i           01 111 0 01 11 ............ ..... ..... @ldst_uimm sign=1 ext=1 sz=1

Here we need to manually decode the sz field in bits 31:30 because
of the complexity of the sign/ext and the parts of the encode space
that are UNDEF (or are prefetch). And we want to use a !function
to do the "scale the immediate offset by the size of the datatype"
so we can use the same LDR_i and STR_i trans_ functions that we
already have for the unscaled-immediate loads and stores.

But at the moment you can't re-decode bits in a %field that are fixed
in the instruction pattern, and you can't refer to the
already-decoded sz value directly. This patchset implements the
syntax used above where the %field can refer to another field,
e.g. 'sz:2'.

Patch 1 fixes a trivial bug in the check.sh script that meant
that failures weren't reported up to meson.

thanks
-- PMM

Peter Maydell (6):
  tests/decodetree/check.sh: Exit failure for all failures
  docs: Document decodetree named field syntax
  scripts/decodetree: Pass lvalue-formatter function to str_extract()
  scripts/decodetree: Implement a topological sort
  scripts/decodetree: Implement named field support
  tests/decode: Add tests for various named-field cases

 docs/devel/decodetree.rst            |  33 +++-
 tests/decode/err_field1.decode       |   2 +-
 tests/decode/err_field10.decode      |   7 +
 tests/decode/err_field7.decode       |   7 +
 tests/decode/err_field8.decode       |   8 +
 tests/decode/err_field9.decode       |  14 ++
 tests/decode/succ_named_field.decode |  19 +++
 scripts/decodetree.py                | 239 +++++++++++++++++++++++++--
 tests/decode/check.sh                |   1 +
 9 files changed, 310 insertions(+), 20 deletions(-)
 create mode 100644 tests/decode/err_field10.decode
 create mode 100644 tests/decode/err_field7.decode
 create mode 100644 tests/decode/err_field8.decode
 create mode 100644 tests/decode/err_field9.decode
 create mode 100644 tests/decode/succ_named_field.decode

-- 
2.34.1


