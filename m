Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A877E383
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:27:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHSe-0003uN-4A; Wed, 16 Aug 2023 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHSc-0003s9-9R
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHSZ-0003jP-Ny
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68874269df4so1119092b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692195918; x=1692800718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F7z2E+ZFTyywXfCvtaMWwFttBwfNEezUdelxUK+khHc=;
 b=b7TtlpSo6CRe0ElvxQqvcnIofYK0y3HjOOKx07oXjrs/NbGnbHl0bhaKA48zWjmIdk
 zZWmWDqZ/xG85Q6uSdeynpCcX5of4JPsoWfkqCazbaG6jlZogXKPopNGEGdL3pm3kWQm
 9DcfadKIaxSpSVn/u3H2APS+vnNxeV22Qctepm0qs66EaE1l4IpPkcbqkZd5zVruwjWf
 GT4iyygFEZoZk2cAPyT8lBw5cXBdgPyQ90JIRSmdCj0umdKNVwy/XxqXcfEoWvCzh9Wv
 n1bdRH4vrnLjceOfefnCWx9CCFRR2MHPtguNpRcyWn1JNWPkcfXC9aR/E+IDzA3+Qj/7
 npTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692195918; x=1692800718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F7z2E+ZFTyywXfCvtaMWwFttBwfNEezUdelxUK+khHc=;
 b=RuLDWzdV4sAHVLH+eXI5aisHezHWcFzsMX8Q5cRNH/PtmCmalowMzUooWrdrIBQI5Y
 zyWD8GB0kr4PHuS7PGNzgNi8ylNkghjsFeOkpyoH86+CHNwpWXmr2Wu7FOhVUTKbdLW6
 Ty/ILN30L4oEBO8oOQCd5vZVwaCah9P0Rv/LcZZqlHtByd0AIG6K7kYchhRGBqfszFk0
 G4l90AwKY/MPcAX3Wqe57yeruhL+yM9cd+Ys9DwSJs6D4x8O08gFglYRF/EPz/HkAElK
 LHHPlcJ/hnAyMV4nHienFSgADUKNDwwg5l29mB5zIOxDnEaN7CXAZqPAkMaTuXKEKzrI
 zHPw==
X-Gm-Message-State: AOJu0YydZLCPDZApK5dfGHmkrEuyq5mdQjChDUTFXau3HEGQsmoiIgI3
 gAk8+x+o2alJTB43gxnj4z5URT6xn9FZgiIbxEM=
X-Google-Smtp-Source: AGHT+IEVcbCmw6fm9c3gc21EEcdNKFNzd8wxApMiD3gMRmNFK06fRmz8hYL3KAFqE0BeDB8mh7LW5A==
X-Received: by 2002:a05:6a00:cce:b0:682:26e4:599e with SMTP id
 b14-20020a056a000cce00b0068226e4599emr2158557pfv.21.1692195917832; 
 Wed, 16 Aug 2023 07:25:17 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 i12-20020aa78b4c000000b00678cb337353sm11156019pfd.208.2023.08.16.07.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:25:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 0/4] tcg/aarch64: Enable BTI within the JIT
Date: Wed, 16 Aug 2023 07:25:12 -0700
Message-Id: <20230816142516.469743-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Patch 1 is cherry-picked from

[PATCH v3 02/14] tcg: Add tcg_out_tb_start backend hook
https://lore.kernel.org/qemu-devel/20230815195741.8325-3-richard.henderson@linaro.org/T/#u

here used for a different application.

There are not as many landing pads as I had imagined, so the
overhead here is really quite minimal.

The architecture enables the check only when the PTE for the
jump target is marked "guarded".  Linux implements this by
adding a PROT_BTI bit for mmap and mprotect.  I have isolated
this within a host_prot_read_exec() local function, which
seems clean enough.  So far, as far as I can tell, Linux it
the only OS to support BTI.


r~


Richard Henderson (4):
  tcg: Add tcg_out_tb_start backend hook
  util/cpuinfo-aarch64: Add CPUINFO_BTI
  tcg/aarch64: Emit BTI insns at jump landing pads
  tcg: Map code_gen_buffer with PROT_BTI

 host/include/aarch64/host/cpuinfo.h |  1 +
 tcg/region.c                        | 39 ++++++++++++++++------
 tcg/tcg.c                           |  3 ++
 util/cpuinfo-aarch64.c              |  4 +++
 tcg/aarch64/tcg-target.c.inc        | 52 +++++++++++++++++++++--------
 tcg/arm/tcg-target.c.inc            |  5 +++
 tcg/i386/tcg-target.c.inc           |  5 +++
 tcg/loongarch64/tcg-target.c.inc    |  5 +++
 tcg/mips/tcg-target.c.inc           |  5 +++
 tcg/ppc/tcg-target.c.inc            |  5 +++
 tcg/riscv/tcg-target.c.inc          |  5 +++
 tcg/s390x/tcg-target.c.inc          |  5 +++
 tcg/sparc64/tcg-target.c.inc        |  5 +++
 tcg/tci/tcg-target.c.inc            |  5 +++
 14 files changed, 119 insertions(+), 25 deletions(-)

-- 
2.34.1


