Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166B78CFF9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n5-0000rS-HM; Tue, 29 Aug 2023 19:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3s4-0007H5-Er
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:55:27 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3rh-0003su-Sq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:55:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68c3b9f8333so85152b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693335300; x=1693940100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5dsUBZXlseZmRdGVrRlYj7QltpmHFWoDGdt+4FX76MA=;
 b=u3kcN2IJ683OiTHXFVf66FjO3v00l6d01p0KqF0+kNurk0vpVxD01uqGQAhn6mnmlf
 5YmSlgKYfQzOyxrvFcnJQNb06EongbjOKuovGcYnq8MNQM1AaedR09yVED0roIU/D0cs
 8GuHFBgnmoDVqzl170utk/4PVAsgp8C57vAgx90gx+cp+j4V5Wo1uUQOgPhqD7Qx9Vis
 +2ZfZjzmZXxlnWbemLUUJCVAbuvKmdg0wllKYu+AfuZVDZX+mXppuMPM/eFuYiLLmZBT
 Pw9aBMauhblwqpSftzDTTdstNjxv9uhKB2Q+C52SWTN0mWBdhHfDDXG/ht+xkZlI7ZlR
 MMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693335300; x=1693940100;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5dsUBZXlseZmRdGVrRlYj7QltpmHFWoDGdt+4FX76MA=;
 b=Ns9giJPsrqXoLmmT8LI/wy0B0rT9ytixqyViL+rV2MrgWWVz6hSHh8NjRZzJua1q6e
 B+5gDwjG4NlO1og2CVua+uRqT79bF/P6O7c4FRGpsrXwboM8KyndDwxpwFg7UJGYpYPh
 r6mS89VC/5iZnrKlSzZ+m210yGJNisLNRnGs2wmA0IicCOkgqXzNMfAu6CVeUy0pUzvp
 WcikWAp4dWnXErYK6w2YmtuW2Onaj6TFFyoYfXNibKLPUPTEE7lGeQirP3als3EuBz2V
 qn4lYc2f+B4KSa1KcBhlomHmB7rDiQ+TFezTO+rJNAr9rYo6LC2UnYCN6oQ13JuLehO7
 sMpw==
X-Gm-Message-State: AOJu0Yz/lsHunHuPyWka4iJ6EPvvG4Px4WF2CI3NPz5D3nPe+wVVzC6j
 Uu8jUh7zeJxHKg4B6n9y6ZL9WSmn7tBbnBvnlk0=
X-Google-Smtp-Source: AGHT+IHdGimwwwEupifoJqyutFRDJyGu1bsgu2+3Jum03dlFpkycjpbRsNuK7Td3zJ8EVC70nXCk3Q==
X-Received: by 2002:a05:6a20:8426:b0:149:729c:d065 with SMTP id
 c38-20020a056a20842600b00149729cd065mr202017pzd.14.1693335300074; 
 Tue, 29 Aug 2023 11:55:00 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j9-20020a63b609000000b0055b44a901absm8562974pgf.70.2023.08.29.11.54.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 11:54:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] tcg patch queue
Date: Tue, 29 Aug 2023 11:54:58 -0700
Message-Id: <20230829185458.861690-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230829-2

for you to fetch changes up to 669fd6151337fdc81e34f7eb4940ba2f20d89957:

  Revert "include/exec: typedef abi_ptr to vaddr in softmmu" (2023-08-29 11:30:33 -0700)

----------------------------------------------------------------
softmmu: Use async_run_on_cpu in tcg_commit
tcg: Remove vecop_list check from tcg_gen_not_vec
tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32
Revert "include/exec: typedef abi_ptr to vaddr in softmmu"

----------------------------------------------------------------
Richard Henderson (5):
      softmmu: Assert data in bounds in iotlb_to_section
      softmmu: Use async_run_on_cpu in tcg_commit
      tcg: Remove vecop_list check from tcg_gen_not_vec
      tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32
      Revert "include/exec: typedef abi_ptr to vaddr in softmmu"

 include/exec/cpu-common.h    |  1 -
 include/exec/cpu_ldst.h      |  4 ++--
 tcg/sparc64/tcg-target.h     |  2 +-
 accel/tcg/cpu-exec-common.c  | 30 --------------------------
 softmmu/physmem.c            | 50 ++++++++++++++++++++++++++++++++------------
 tcg/tcg-op-vec.c             |  7 +++----
 tcg/sparc64/tcg-target.c.inc | 11 ----------
 7 files changed, 43 insertions(+), 62 deletions(-)

