Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BB8CD754
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 17:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATU-0007l1-Ry; Thu, 23 May 2024 11:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATJ-0007kI-Na
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATG-0002SE-VW
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34d8d11a523so4396205f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478509; x=1717083309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cix61aPqu8KvNLcJRTXQi8LmaQzXhkWR11FG/+cNvi0=;
 b=ziknbGrukqmCc06aXFV4uOjnuZtEzOYh5dnflB4mWEyZEJeDYqYR0ya/lH5O6kJ8so
 hhqGfE0S8np11DXw1r0kLJJJRWlPniHtydkgdeNxVVKdyfyjMOjQfYSCQOuZu9YZ2D5x
 VBNXzG/eK14Pbwp0lKxoNhBjpHiSHy5/wBon6I4IRUSoHnx7jb6vWGQmTfkBGTo5BMDY
 JfNNYMLVFWMcHbTdjgby462f56KSKz0uoKRKbkUwYmdIxZIEpGXBp4Et31HCRwnh8KK8
 3RLHfnezGD8DkdhKYPgD/aSk9UWxpojZopZbBoAobs/9xMjnDmq4FHiYWD0Gr1LA40j8
 eJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478509; x=1717083309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cix61aPqu8KvNLcJRTXQi8LmaQzXhkWR11FG/+cNvi0=;
 b=w2f+vhVQoBLaxHkPjHJWyP1EcD+utt0xMLba67uK/m57Tze+inzFiYheOUUkh8mD7+
 OW3XaUvnDoRvzYUmjGhoZqbZnDV0IGwsanytsHKswaiMi24huTvVgq0zfm+mhNo93yr0
 BgplaMMX9uETsVG765K/pUjThit95xG/JHtEnJGysXfP6gWa04AmyxcCJmGKkwKVuuP/
 BNe7cZy5wnJsul7Hglnq49ByilGqHjOYcfbt3zwZENP7gBJIrajiwiL535bkTMREcsF9
 AUSgjy/100G/ah6RTb5iUQq8d5nT4bt5N/6Flx4mVzO4SQoZvzjVAsiIO8jaLNC0q8Xh
 /CZQ==
X-Gm-Message-State: AOJu0Yxft+Fywjr+x7rLTL7AIM4XwSjBuw33agk/9kZLJ7Rvq6gaguov
 WdC7MtmszAs8NtYRqEs7fiZGcHad2yaIsTim5RwTwgw7KfNz210ruQaYqxBsB88lBK5V5WlGz2y
 N
X-Google-Smtp-Source: AGHT+IGfiIBBp2poKxJPjelqv0TZM1AYJFAFjkIkASI94qmoRGpMq5s6F1xFFWwySL0M1XAdtsCaWQ==
X-Received: by 2002:adf:f04c:0:b0:352:e4d5:5e12 with SMTP id
 ffacd0b85a97d-354d8cdd4d9mr4059736f8f.20.1716478509483; 
 Thu, 23 May 2024 08:35:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/37] hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
Date: Thu, 23 May 2024 16:34:33 +0100
Message-Id: <20240523153505.2900433-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Andrey Shumilin <shum.sdl@nppct.ru>

In gic_cpu_read() and gic_cpu_write(), we delegate the handling of
reading and writing the Non-Secure view of the GICC_APR<n> registers
to functions gic_apr_ns_view() and gic_apr_write_ns_view().
Unfortunately we got the order of the arguments wrong, swapping the
CPU number and the register number (which the compiler doesn't catch
because they're both integers).

Most guests probably didn't notice this bug because directly
accessing the APR registers is typically something only done by
firmware when it is doing state save for going into a sleep mode.

Correct the mismatched call arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: 51fd06e0ee ("hw/intc/arm_gic: Fix handling of GICC_APR<n>, GICC_NSAPR<n> registers")
Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
[PMM: Rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
---
 hw/intc/arm_gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 074cf50af25..e4b8437f8b8 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
             *data = s->h_apr[gic_get_vcpu_real_id(cpu)];
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
-            *data = gic_apr_ns_view(s, regno, cpu);
+            *data = gic_apr_ns_view(s, cpu, regno);
         } else {
             *data = s->apr[regno][cpu];
         }
@@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
             s->h_apr[gic_get_vcpu_real_id(cpu)] = value;
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
-            gic_apr_write_ns_view(s, regno, cpu, value);
+            gic_apr_write_ns_view(s, cpu, regno, value);
         } else {
             s->apr[regno][cpu] = value;
         }
-- 
2.34.1


