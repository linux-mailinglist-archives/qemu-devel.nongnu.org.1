Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0873CF6A
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLFr-0006b3-1q; Sun, 25 Jun 2023 04:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qDLFf-0006Yb-M2
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:37:46 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qDLFe-0001GA-0Y
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:37:43 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-56314bd1c34so1426864eaf.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687682260; x=1690274260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VZwC3oLTFTRGZdL0RREApGkzM3uSK6SADi9DLcFfq94=;
 b=JVrSUtt24li3tkDZEQd4Yg1A8sJI1epN+pAAXI1TkLnuVSCs30D/ePcCwWQTWkJ+WE
 ysOOR5RPdRCpfyD5FEDwMhw0Ou+DbatnqnF6Oba28uoV0cEjhJ54RayZrVFhRcDd3y8K
 c2HdKYYbzOSh1/O6vx6K5piYPUt+Goi3FNQsShv/augZHi0dUFWOzGwOHXOpA7WQYUp3
 4u7Kv2QepFifBUgQFsuC3tFoG9d6fDHYlF/p7D6nLmJl6NzmfeSl/dTfukuuQ2wQ0z/g
 5BwqiFM1d0y/k2QjemvqY5TO6m7tVZ5PKlVac7zlfIY7AZcps2NkH7hslmlen9NE7zMQ
 2COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687682260; x=1690274260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VZwC3oLTFTRGZdL0RREApGkzM3uSK6SADi9DLcFfq94=;
 b=XuoYQSGJASN/fyjguHx0PyskkDHWlWznyiKZbr54I6vkImiCgbc0lbjCKZosn5OXlx
 dQhphlUdMNJpLC/iziBBxQ7Ba3GOZ8Jqb11ZLtIvZw7EaxMF5HH8Kp+Vw639VvUavXSd
 RhU3GYWY4Q+jpfUxq3bVP8KCeIC1WzuVOXj8FHD5ICw72GthJpbesr6Pbi6jc6lKJzMi
 ZL7ocYcG8ssdDcrbGe7qjaheTLqjX20y3xHxK7JHtAwb46dpC9DGkYyKWgPYJv0RGZl9
 HwIESiYioTD2Aaa0qDS3o/JxekeF/F12fO9ZyQNRl6p25n+Y1OiaRwxgH8lVlHFZrSVU
 rcOQ==
X-Gm-Message-State: AC+VfDwr/MkGXIOjC1yGypp28fKWM9FV2UqN8MGXy0hmC+mniI9b0LbI
 oulM4FJLjMt2Egvu3287EDU=
X-Google-Smtp-Source: ACHHUZ4Xm63TcDJXD8nFEvsNMowh+r4XvmeOXe5iXhUPcMrygOB4AseRSkfWXEnsipX25n9sjVAqvQ==
X-Received: by 2002:a05:6808:2225:b0:39e:e0f0:55ed with SMTP id
 bd37-20020a056808222500b0039ee0f055edmr22720190oib.53.1687682260235; 
 Sun, 25 Jun 2023 01:37:40 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 c7-20020a17090ad90700b0025bcdada95asm2340026pjv.38.2023.06.25.01.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 01:37:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH RFC] icount: don't adjust virtual time backwards after warp
Date: Sun, 25 Jun 2023 18:37:31 +1000
Message-Id: <20230625083731.3108-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

With icount shift=auto, the QEMU_CLOCK_VIRTUAL can be adjusted backwards
after a warp, resulting in the machine observing time going backwards.
Linux on powerpc can't handle this, and it results in lockup due to a
time delta underflowing.

This patch seems to solve it, no more backwards time observed. Is it a
reasonable way to address it?

Thanks,
Nick

---
 softmmu/icount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/softmmu/icount.c b/softmmu/icount.c
index 7ae6544909..a6d605dfad 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -273,6 +273,9 @@ static void icount_warp_rt(void)
              */
             int64_t cur_icount = icount_get_locked();
             int64_t delta = clock - cur_icount;
+            if (delta < 0) {
+                warp_delta = 0;
+            }
             warp_delta = MIN(warp_delta, delta);
         }
         qatomic_set_i64(&timers_state.qemu_icount_bias,
-- 
2.40.1


