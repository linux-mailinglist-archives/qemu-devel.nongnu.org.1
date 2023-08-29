Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB878C893
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0bk-0005wJ-W2; Tue, 29 Aug 2023 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb0bi-0005vj-KJ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb0bf-00055Z-Rk
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693322770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CMuAafKXq3gse0UedUzJh/uxFnCA61JyJOs1yFqIgas=;
 b=SluMMWqGg8sDkC9e9FiWcBC3KTQJGXeBxz4O9RYk6OnXfBFeyXmj6ewejD/8pLSN4PfPcf
 sYNEF1snG+kqC/7JHdIb7leHdm2a54TLAReRVk94swdr2og0C3mr9r+5KblFOY1BwYprTi
 mj7cA6pMZKXX2KOSAmN15Bd72jKtENE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-4HX8gB8DOJOWY65ZBF7b3w-1; Tue, 29 Aug 2023 11:26:08 -0400
X-MC-Unique: 4HX8gB8DOJOWY65ZBF7b3w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so31896165e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693322767; x=1693927567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CMuAafKXq3gse0UedUzJh/uxFnCA61JyJOs1yFqIgas=;
 b=NbZK6GvcHgexjf4wWpW4nvjKnx/rqB0sqFAKrcujxPz6s0bdfgEgUdN52zodWg4rGH
 Eoxmb3Ei7bBSzMBa8DPmx1KeJMmk/KAuI/CsjL51sj097c1cUs7lLi9vo0zRYrt1E+9e
 AR9HD7WzhJalS6tkP7Uz7QkfN4RxOyv/UaacU3bFPxmbdG3NxyfqX689eL3bqkIGgINp
 a3FiaCSo1gRyDlwu7u+IpI3BKJxDNx8QETd+PWWjAOVRlclSTmCR6yAP7bdGi0n3uH4I
 KANvZNklTdvmgcTjekIoqu9CPtVobzBDk1n2wEeLYLKKJ5oGqR2ZmZGfSHlH/sLcmDLL
 OezA==
X-Gm-Message-State: AOJu0Yy5VnECqe0KPCjUj5RTHRkIiV7EIOzm/qJRx5sHHhyK7oI0C5GE
 km1nrqO7kqdaXKgYR2Cf3j75QwMuLV+1nGFD4X6Pe5NJk+zsacG+MWl/5zJ51C6Lhzl8zJLN56U
 DAT3yvm/W29pQU6tthI7VGf7cjxVDP7ybniRkCVjhF7SfHV4q7wLarmhIG9shuPuABzvjCpsatu
 c=
X-Received: by 2002:adf:e645:0:b0:31a:d90e:42cd with SMTP id
 b5-20020adfe645000000b0031ad90e42cdmr22103393wrn.35.1693322767034; 
 Tue, 29 Aug 2023 08:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqIsEdNToOFQFbNDdhgvtQosr+FhRUX97Ta4NwQeP9yVUQBkrKUsSwohXd07gTVrP5s7uALw==
X-Received: by 2002:adf:e645:0:b0:31a:d90e:42cd with SMTP id
 b5-20020adfe645000000b0031ad90e42cdmr22103374wrn.35.1693322766535; 
 Tue, 29 Aug 2023 08:26:06 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 m15-20020adffe4f000000b003195504c754sm13997876wrs.31.2023.08.29.08.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 08:26:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386: raise FERR interrupt with iothread locked
Date: Tue, 29 Aug 2023 17:25:55 +0200
Message-ID: <20230829152604.101542-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Otherwise tcg_handle_interrupt() triggers an assertion failure:

  #5  0x0000555555c97369 in tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:83
  #6  tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:81
  #7  0x0000555555b4d58b in pic_irq_request (opaque=<optimized out>, irq=<optimized out>, level=1) at ../hw/i386/x86.c:555
  #8  0x0000555555b4f218 in gsi_handler (opaque=0x5555579423d0, n=13, level=1) at ../hw/i386/x86.c:611
  #9  0x00007fffa42bde14 in code_gen_buffer ()
  #10 0x0000555555c724bb in cpu_tb_exec (cpu=cpu@entry=0x555557434cb0, itb=<optimized out>, tb_exit=tb_exit@entry=0x7fffe9bfd658) at ../accel/tcg/cpu-exec.c:457

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1808
Reported-by: NyanCatTW1 <https://gitlab.com/a0939712328>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/fpu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/sysemu/fpu_helper.c b/target/i386/tcg/sysemu/fpu_helper.c
index 1c3610da3b9..fd8cc72a026 100644
--- a/target/i386/tcg/sysemu/fpu_helper.c
+++ b/target/i386/tcg/sysemu/fpu_helper.c
@@ -31,7 +31,9 @@ void x86_register_ferr_irq(qemu_irq irq)
 void fpu_check_raise_ferr_irq(CPUX86State *env)
 {
     if (ferr_irq && !(env->hflags2 & HF2_IGNNE_MASK)) {
+        qemu_mutex_lock_iothread();
         qemu_irq_raise(ferr_irq);
+        qemu_mutex_unlock_iothread();
         return;
     }
 }
-- 
2.41.0


