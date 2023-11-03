Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E567E07AD
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:42:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8X-0005GO-OK; Fri, 03 Nov 2023 13:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy86-0005CW-7n
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:50 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy84-0003PG-Ey
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:45 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so1840922a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033122; x=1699637922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XzYCX+L5iT99cpY+/O+NzQHE0WiSxdxzFLn0Rn8rBfI=;
 b=qr/i7CNF/VYHptMMij1G/GZucWyM6qVLFyds6UP5/nQNzSZbHXabhzobwweqs7h2po
 qbLLHlClX9a70wHcUJEjhUvzKXa1X05kBBYrS51AUPZuo1YOAGUV96WGRfYPDbzdw7/Z
 cb787JbIj44RieqoYxwbgHcVaAWnUXeRwMAMDwR/ExE+9fAqC26MZJcqgt1O0SgD/DeX
 fMy3VUH6D7JOr3Gx9BkcwNLXrfx4vdzkMXi38BCicsAm7bfJYZHp4Tp26yp6ZOobDnR7
 bv8ff9d+XjSONQOSCj71y2uqWwoCpLchkm5tlxKcVuj97Op+gGYilgZdGhxaBQLO4Ruq
 1Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033122; x=1699637922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XzYCX+L5iT99cpY+/O+NzQHE0WiSxdxzFLn0Rn8rBfI=;
 b=IxLAb8kEtJ/RVMfa1P7PVQCgxmZsrZ8CQRN7AfWwalTbPqvNmIvGnYX7NAuFS0GSB0
 3Nuio/p808wBth1shoTH6XhHAc0QDlK+NH7mnw2vkcKvjy19yccNRitBdKO5C5qHIV8X
 KliCUtlrjbMqde+CenR2XU3obiL3NGiestW5FimrKG6WfRbC+pI6THLWfTg27Yaio6sK
 R6FHxjll5svcTsFzj1/cvireYWIJW2GVlizY6hk0SR54DETfBkws0QHftGmZuKMG151i
 5bOxSQf2x16Vpq5LmsPSHRWZmXrr+i2bysh+9+dnV3djixqERQKEeQzom7J2PA+aSUoo
 Svtg==
X-Gm-Message-State: AOJu0YyGcqT7dF4QW+nBeGY0Ps+ab85oeEbi+Oj8qJofEcKakdRLUIoZ
 mribboaNdrPNpMQQczZicE+/GdR7uSuOnpVnxC0=
X-Google-Smtp-Source: AGHT+IEhXNS/4zlgGkUtGBhI1ohx6NXrA9HT/6rHqcV/TnuGeSXHSDf5Fs9MHgtFnY+pd+EpYzqFSw==
X-Received: by 2002:a05:6a20:1613:b0:136:e26b:6401 with SMTP id
 l19-20020a056a20161300b00136e26b6401mr27905601pzj.16.1699033122419; 
 Fri, 03 Nov 2023 10:38:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 00/22] target/sparc: floating-point cleanup
Date: Fri,  3 Nov 2023 10:38:19 -0700
Message-Id: <20231103173841.33651-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Major changes: 

(1) Get rid of the env->qt[01] temporaries and use TCGv_i128 for float128.
(2) Perform ieee exception check within the helpers, before any writeback
    to the floating point registers.
(3) Split env->fsr into pieces to simplify update, especially compares.


r~


Based-on: 20231101041132.174501-1-richard.henderson@linaro.org
("[PATCH v2 00/21] target/sparc: Cleanup condition codes etc")


Richard Henderson (22):
  target/sparc: Use tcg_gen_qemu_{ld,st}_i128 for ASI_M_BCOPY
  target/sparc: Use tcg_gen_qemu_{ld,st}_i128 for ASI_M_BFILL
  target/sparc: Remove gen_dest_fpr_F
  target/sparc: Introduce gen_{load,store}_fpr_Q
  target/sparc: Inline FNEG, FABS
  target/sparc: Use i128 for FSQRTq
  target/sparc: Use i128 for FADDq, FSUBq, FMULq, FDIVq
  target/sparc: Use i128 for FqTOs, FqTOi
  target/sparc: Use i128 for FqTOd, FqTOx
  target/sparc: Use i128 for FCMPq, FCMPEq
  target/sparc: Use i128 for FsTOq, FiTOq
  target/sparc: Use i128 for FdTOq, FxTOq
  target/sparc: Use i128 for Fdmulq
  target/sparc: Remove qt0, qt1 temporaries
  target/sparc: Introduce cpu_get_fsr, cpu_put_fsr
  target/split: Split ver from env->fsr
  target/sparc: Clear cexc and ftt in do_check_ieee_exceptions
  target/sparc: Merge check_ieee_exceptions with FPop helpers
  target/sparc: Split cexc and ftt from env->fsr
  target/sparc: Remove cpu_fsr
  target/sparc: Split fcc out of env->fsr
  target/sparc: Remove FSR_FTT_NMASK, FSR_FTT_CEXC_NMASK

 target/sparc/cpu.h          |  39 +-
 target/sparc/helper.h       | 116 ++----
 linux-user/sparc/cpu_loop.c |   2 +-
 linux-user/sparc/signal.c   |  14 +-
 target/sparc/cpu.c          |  32 +-
 target/sparc/fop_helper.c   | 510 +++++++++++++----------
 target/sparc/gdbstub.c      |   8 +-
 target/sparc/ldst_helper.c  |   3 -
 target/sparc/machine.c      |  38 +-
 target/sparc/translate.c    | 799 ++++++++++++------------------------
 10 files changed, 680 insertions(+), 881 deletions(-)

-- 
2.34.1


