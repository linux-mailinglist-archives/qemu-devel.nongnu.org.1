Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A64707020
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:56:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDx-0007KB-4E; Wed, 17 May 2023 13:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDo-0007G3-Pe
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDl-00044p-KM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l876oqAb8aNAhYWvZIc/atB5ahSGSdR5tVYDJUVhSc0=;
 b=c2MXn5hHbI/54Nz4hZSavtGXD7GO0TCcGBq7IcmpYgrrioq7lhLWUP5SD+h4r4AR05mjoB
 5Q0bM0BHhGh5Rq6bZBqFJlXbrfXdH93KLWo7nRf7dwdTq3/W4PrW7ZVtciWYLgDCzjiqDh
 ta1b4TV20UmXGSrbywFJmUYV4Pprfg8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-FvIONaD8PvyKEtmiqnLpmA-1; Wed, 17 May 2023 13:45:48 -0400
X-MC-Unique: FvIONaD8PvyKEtmiqnLpmA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f4fa463282so7685315e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345547; x=1686937547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l876oqAb8aNAhYWvZIc/atB5ahSGSdR5tVYDJUVhSc0=;
 b=CoSjo4TuBd+PbiDmDnTp4PwHvgIlln5LsZ179tN9SjxjhQYfyU5zJ5BTmIz0aPlP4V
 VN3c1gWuHn/GkE39Bf/xJdA/xJ2pgRYGidCqkpbYyW4eogUtDdk4HtmTHN5B2USOKVTS
 D7bBz7t9SKyU5/HVdAnfo1wigd68IPJ9+YySkbvjaO3R/yPbLv6UQZWfkDk632Sdru3V
 Kxin5qNy3EbWqTwxe6mjKjSAwhi8O41wjnTwRWmcfq9qmYQTfB8nT2lSzJ5ieeq1/Ikm
 sKpyEU96rXmCdo3J1BzFeEcgECY/PUFWf9TeUpYWWWss6WcmeYTNZqMWPXbjhlwmGQpg
 eYEg==
X-Gm-Message-State: AC+VfDys5FNebS3vXpgGdeGBmklJOzLHuBltCDoIvHITHTr3pjABHr+y
 G+HDQKjGZRpduSsVrTphfU6hzQPV6OKt3KGYk5aCcB/QNr8HWOZyqeLwCwTTz0Bo/OhpqIVUkHT
 fcMTqBo5hSgykKIec1FKX+hPI9rxXWPtRvxgqV0be2OuPu60GtGZDYFoffTDHTFUlZgjnlAN+Il
 c=
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id
 y24-20020a05600c365800b003f423743517mr23442540wmq.19.1684345547054; 
 Wed, 17 May 2023 10:45:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EpzmgVVWnv8LrZ+BwyKt+zx5qo979l/37YQBOXsXEaceFv6kvihlKeZBU3m/HF+dzWKwN7A==
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id
 y24-20020a05600c365800b003f423743517mr23442521wmq.19.1684345546516; 
 Wed, 17 May 2023 10:45:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc850000000b003f42d3111b8sm2894515wml.30.2023.05.17.10.45.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/68] tcg: round-robin: do not use mb_read for rr_current_cpu
Date: Wed, 17 May 2023 19:44:26 +0200
Message-Id: <20230517174520.887405-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-accel-ops-rr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 5788efa5ff4d..b6d10fa9a250 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -72,11 +72,13 @@ static void rr_kick_next_cpu(void)
 {
     CPUState *cpu;
     do {
-        cpu = qatomic_mb_read(&rr_current_cpu);
+        cpu = qatomic_read(&rr_current_cpu);
         if (cpu) {
             cpu_exit(cpu);
         }
-    } while (cpu != qatomic_mb_read(&rr_current_cpu));
+        /* Finish kicking this cpu before reading again.  */
+        smp_mb();
+    } while (cpu != qatomic_read(&rr_current_cpu));
 }
 
 static void rr_kick_thread(void *opaque)
@@ -241,8 +243,9 @@ static void *rr_cpu_thread_fn(void *arg)
         }
 
         while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
-
+            /* Store rr_current_cpu before evaluating cpu_can_run().  */
             qatomic_mb_set(&rr_current_cpu, cpu);
+
             current_cpu = cpu;
 
             qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
@@ -280,7 +283,7 @@ static void *rr_cpu_thread_fn(void *arg)
             cpu = CPU_NEXT(cpu);
         } /* while (cpu && !cpu->exit_request).. */
 
-        /* Does not need qatomic_mb_set because a spurious wakeup is okay.  */
+        /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
 
         if (cpu && cpu->exit_request) {
-- 
2.40.1


