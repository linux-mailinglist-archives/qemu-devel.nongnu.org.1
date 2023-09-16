Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DE7A2DA8
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:31:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0i-0005sh-8s; Fri, 15 Sep 2023 23:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0f-0005ry-TX
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:17 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0e-0007yH-7g
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fbbb953cfso2449788b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835014; x=1695439814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpsTd2fMb3n+PPnNCGSH2JmhVc/GBkL2FsB8m4U3Ra8=;
 b=Rsk+8Pl1JXlpe5veeYGql+1S759gCRR/J84Ni1vRgFmVCCoiGk+ZfNHHTp+VH1H5+l
 GicFN7v7QZ6LE4fiGCsGTKxTGC/+vio29jmsR3XLvuajYMRHyuqzUzszyeux5kL2TtbZ
 rgrOfkb6ke1TyyUIXHXeDzG/6uty+GAB7TyhYXMnvPvSCzuKD8mCPAV0P6amMZBVpFi6
 1wBc6VK5XlOHRWlKqsmqH/y0vQKSvyNst8vjpJY1/3JViLYKv/tfNvDb0Ga/mXVB0HVY
 JE+1mGydKhGbxK6gvxb5SMxM6/HcGNp5NnRrJoV6Cbrq+1VFKOCOy32zcyDEpOhfWwzO
 eURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835014; x=1695439814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpsTd2fMb3n+PPnNCGSH2JmhVc/GBkL2FsB8m4U3Ra8=;
 b=e8GESxOU7z/tObsGRxBtrwZJlNrtHhYKtf1HgLFYUX0xGYc24Sc1RYGPQV/f/ocec2
 F1b6r9wqhpkB2Z6AbmJMwvD78ZXCAheOwQB3MOmxITojhxDwXjJ3h+yt+y0I8WXGEOF7
 r0G5WVozXMWeS7V/UwskuLaHrY8WhDMJ2Ky6eaM+8YqoIkMPzfYQXf5tiv5tcCcD9YSt
 IL1Bts5WAIByA4THbJsH4dbjPUlpH+H4ST7g4NDaung1AlrVC80D03gxTFS0/C0kc0Tm
 tEuGwhv3Tg9Aeub+f5aLrN2RDJJduD7eLP85WDngoFKEwxESgSuwW3hRmHhGQm9wYMl1
 3msQ==
X-Gm-Message-State: AOJu0Yz3oU2VR7edw/QmkYxIxKrJP5mRE1tbGvJh8YLizNNkkqrmLjlp
 /mNvhN5Rt8HB9Uz9OvDfE+i7B6GBq1gjsST6i/g=
X-Google-Smtp-Source: AGHT+IHcK/BME8FxJENzf6bZQP77i8Hosrwe9xj7ceXqihv7ZEqHDHFbqOm9U4ZYhMftagctl9R8NA==
X-Received: by 2002:a05:6a00:180f:b0:690:2818:a4ce with SMTP id
 y15-20020a056a00180f00b006902818a4cemr4654927pfa.7.1694835014496; 
 Fri, 15 Sep 2023 20:30:14 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Ivan Warren <ivan@vmfacility.fr>
Subject: [PULL 01/39] accel/tcg: mttcg remove false-negative halted assertion
Date: Fri, 15 Sep 2023 20:29:33 -0700
Message-Id: <20230916033011.479144-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

mttcg asserts that an execution ending with EXCP_HALTED must have
cpu->halted. However between the event or instruction that sets
cpu->halted and requests exit and the assertion here, an
asynchronous event could clear cpu->halted.

This leads to crashes running AIX on ppc/pseries because it uses
H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted = 1 and
H_PROD sets other cpu->halted = 0 and kicks it.

H_PROD could be turned into an interrupt to wake, but several other
places in ppc, sparc, and semihosting follow what looks like a similar
pattern setting halted = 0 directly. So remove this assertion.

Reported-by: Ivan Warren <ivan@vmfacility.fr>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230829010658.8252-1-npiggin@gmail.com>
[rth: Keep the case label and adjust the comment.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index b276262007..4b0dfb4be7 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -100,14 +100,9 @@ static void *mttcg_cpu_thread_fn(void *arg)
                 break;
             case EXCP_HALTED:
                 /*
-                 * during start-up the vCPU is reset and the thread is
-                 * kicked several times. If we don't ensure we go back
-                 * to sleep in the halted state we won't cleanly
-                 * start-up when the vCPU is enabled.
-                 *
-                 * cpu->halted should ensure we sleep in wait_io_event
+                 * Usually cpu->halted is set, but may have already been
+                 * reset by another thread by the time we arrive here.
                  */
-                g_assert(cpu->halted);
                 break;
             case EXCP_ATOMIC:
                 qemu_mutex_unlock_iothread();
-- 
2.34.1


