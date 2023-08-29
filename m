Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C1F78CA21
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb27K-0002aF-KY; Tue, 29 Aug 2023 13:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb278-0002Sz-3K
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb274-00051w-1k
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:48 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-268bc714ce0so16045a91.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328564; x=1693933364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ww92S7dxGZMhTCUXqzVQrznHGFDIFt354NfPx+CVV7s=;
 b=pRMwpqy3/MJeZ4r6m88OSefXNY604JG6Z61t47RzOzr+rLEK6R4LZo2eF7xcz4tRrH
 CPib5cFDSnieudxC8niQw3nHEf5k0yDKJHPkNAS5htJE0EzclNyTy98yyL0BYSuzY4ZF
 iBBeNt6sjVA+sA/gWEVqqrolHT0KjJ/W6YOmF8acUosJ5xiGagHs37XfclqKDrYtL+vv
 aMV1hougbcwRAslC7i0ye+E1lXnymcF48vLWW27FKNE4f+VY9B6r0LLzYutHSIUHJhVj
 PAse64R0C44mb6IvUaLcvBGvrMHUVPVnoH7EZccA452B+oXGwImbDiwz+gqssGBCBJrS
 ASOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328564; x=1693933364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ww92S7dxGZMhTCUXqzVQrznHGFDIFt354NfPx+CVV7s=;
 b=LWjL8T87uP4yhUOnUypstOOgM4cQykRvFCL7siuzfll0cjxUYej9Vl0pR9kQ28sWHz
 7q1//1JK5fLOoV8ZQgWxeA8P2lzjxuEUsDM4I87VwEbc/XQJ0C+yk9/2i98dXYghnu5S
 TsuHVEaiZGZrhTak8+LczprvQjLH09s7slHMUj78lQZQGYtRsAfcL7/F89gfujb/AWwU
 p0sbaBK0MnVFnHPRp9NqB++plrAJ7iBwTUhwwGThcra/L2RYz9Z6UhzJHYbmuFnOMabk
 vhuB9grN7C3YWvPq/0WM+WKE1nnMPI7SQNZcUwtoxJC+MhTybWfyA35zu1zh0lPZQp4T
 nJvw==
X-Gm-Message-State: AOJu0Yw2GxCYcWSngE3JfUFGRut3P7RHk8mqxzLriKDkb1oLgjuG3XGA
 qGhnXgnogdl3D03XE9QlsbcXh3drdB6O7Ln2wd4=
X-Google-Smtp-Source: AGHT+IFe1ShrH5sNsUs12yNmZNij05XG0HjJ49oqKurNLV1bMhU+bAynPJqM8zTUkjxdS1sCKZVUKw==
X-Received: by 2002:a17:90a:b110:b0:26d:5094:13ea with SMTP id
 z16-20020a17090ab11000b0026d509413eamr4288773pjq.0.1693328561489; 
 Tue, 29 Aug 2023 10:02:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 cv2-20020a17090afd0200b00267b7c5d232sm10989645pjb.48.2023.08.29.10.02.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 10:02:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] tcg patch queue
Date: Tue, 29 Aug 2023 10:02:36 -0700
Message-Id: <20230829170240.765996-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

The following changes since commit 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0:

  Merge tag '2023q3-bsd-user-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-29 08:58:00 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230829

for you to fetch changes up to dad2f2f5afbaf58d6056f31dfd4b9edd0854b8ab:

  tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32 (2023-08-29 09:57:39 -0700)

----------------------------------------------------------------
softmmu: Use async_run_on_cpu in tcg_commit
tcg: Remove vecop_list check from tcg_gen_not_vec
tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32

----------------------------------------------------------------
Richard Henderson (4):
      softmmu: Assert data in bounds in iotlb_to_section
      softmmu: Use async_run_on_cpu in tcg_commit
      tcg: Remove vecop_list check from tcg_gen_not_vec
      tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32

 include/exec/cpu-common.h    |  1 -
 tcg/sparc64/tcg-target.h     |  2 +-
 accel/tcg/cpu-exec-common.c  | 30 --------------------------
 softmmu/physmem.c            | 50 ++++++++++++++++++++++++++++++++------------
 tcg/tcg-op-vec.c             |  7 +++----
 tcg/sparc64/tcg-target.c.inc | 11 ----------
 6 files changed, 41 insertions(+), 60 deletions(-)

