Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6E79A3DE
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagQ-000392-VN; Mon, 11 Sep 2023 02:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafp-0002a7-1W
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:32 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafk-0004yp-OH
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:28 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1d544a4a315so3186959fac.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414721; x=1695019521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccGf/43x5nzKqeckplvIj3QC6H4I6RRe2CJqwTH4Zqo=;
 b=l78ZIk/Ya75/XN2VH273NULrt9fIy2iCWH24h8Jxd0elOZ/Gy0Y9uVsdHh4YrmXnaX
 NZ+pKw6zr7pqdGjEtJvmTQWgfFsWLrApAU8lCfGgs/f2AP5c4feiqjkdduzacHnD8n7x
 adw3t/fYBvzHHx+kgBAjfVndfcs0ybhKc9okWZt63/5tiqSHv8xkoiALJH+zje3KU553
 7CcW/0k/NKLUMlSVTG7r/D8nqpR3GczsYN2iQyyMScFJVWf2EB5Js5iH4ApcgYuIige0
 F4MJRjeQY2d1RtyfhLxngKhAkpij68zbsoJNhjk79XSrIVWutW8MY66C/qjmKe2eJ9bS
 NW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414721; x=1695019521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ccGf/43x5nzKqeckplvIj3QC6H4I6RRe2CJqwTH4Zqo=;
 b=SVUkof1zJx2UPX76wi8mjfKXz65bBOahvX3UaOBFkwFnQ70/Y2jVmm0LerNqn+6k20
 uqy6aUol6jtAw5cowQ/qUsUyXThGoXcZTPfWloIUI+lyiaHXmKRdCgcPoALIPOPthiyv
 leLEG1d44zx8ZJppBZ1ktbTlWKSJsJp6Zb8VDBAZ2AZoQkTEIedccisDDT9phfacnYgj
 mfxjuAYcYemvxCNkipqJ9mnMHk4U0utatgelLDGI+q12ed9lWk2FwLNSEqb6ya9ZdxsU
 MZAOfnzlP8Pc7dWpRAicQ/RWHQyS3jHsaRFNnhqtiTrWAs99SvVgy5xHb3A04uUKd7hJ
 RS6A==
X-Gm-Message-State: AOJu0YxVAdw6arKjjx6d0Ar9CP8R6VNOm4Euzq789D8GtEqr8tTvur+9
 AgjRnBJ+FqCLJEWiKM/8Rj2YNGQrmRH2Hw==
X-Google-Smtp-Source: AGHT+IGgqAZeAe9tRs/gCJ7VvBy5tHnMXA7bHnlZx9w6XVQqL3e7hv3JfVnr8/+Qc7zBzdVsgmgJ9Q==
X-Received: by 2002:a05:6870:f225:b0:1ba:2a58:b15e with SMTP id
 t37-20020a056870f22500b001ba2a58b15emr11411592oao.2.1694414721703; 
 Sun, 10 Sep 2023 23:45:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 27/45] hw/intc: Make rtc variable names consistent
Date: Mon, 11 Sep 2023 16:43:02 +1000
Message-ID: <20230911064320.939791-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jason Chien <jason.chien@sifive.com>

The variables whose values are given by cpu_riscv_read_rtc() should be named
"rtc". The variables whose value are given by cpu_riscv_read_rtc_raw()
should be named "rtc_r".

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230728082502.26439-2-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index bf77e29a70..25cf7a5d9d 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -64,13 +64,13 @@ static void riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
     uint64_t next;
     uint64_t diff;
 
-    uint64_t rtc_r = cpu_riscv_read_rtc(mtimer);
+    uint64_t rtc = cpu_riscv_read_rtc(mtimer);
 
     /* Compute the relative hartid w.r.t the socket */
     hartid = hartid - mtimer->hartid_base;
 
     mtimer->timecmp[hartid] = value;
-    if (mtimer->timecmp[hartid] <= rtc_r) {
+    if (mtimer->timecmp[hartid] <= rtc) {
         /*
          * If we're setting an MTIMECMP value in the "past",
          * immediately raise the timer interrupt
@@ -81,7 +81,7 @@ static void riscv_aclint_mtimer_write_timecmp(RISCVAclintMTimerState *mtimer,
 
     /* otherwise, set up the future timer interrupt */
     qemu_irq_lower(mtimer->timer_irqs[hartid]);
-    diff = mtimer->timecmp[hartid] - rtc_r;
+    diff = mtimer->timecmp[hartid] - rtc;
     /* back to ns (note args switched in muldiv64) */
     uint64_t ns_diff = muldiv64(diff, NANOSECONDS_PER_SECOND, timebase_freq);
 
-- 
2.41.0


