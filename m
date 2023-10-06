Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D89D37BB61B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:15:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinJ-0008HF-Mh; Fri, 06 Oct 2023 07:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinF-0008FI-Fp
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin3-0000JJ-Sr
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6fm9E/O2tM3qMMoTzowAunSSCopmIRl6nWdSkz7Ns4=;
 b=ARtTpIe1Zr/eVfWNdBwm2M481Y1jGvNLrcmxErKdwR5gqkEvZ5JlzrZHfrTOBXkX41p4Uz
 BQ6UJ4RwXLgJR1q4E5+pCZ/OGgabVkXDBhZQfncp8mmTCgWshKdjw/AFtMjhf1H1wz8vDX
 Q+VVSDU/3VrQKYDrjKSxIATUeWE/CMk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-5gIW62gFMf-fC0OEtED2Rg-1; Fri, 06 Oct 2023 07:14:28 -0400
X-MC-Unique: 5gIW62gFMf-fC0OEtED2Rg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso174293866b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590867; x=1697195667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6fm9E/O2tM3qMMoTzowAunSSCopmIRl6nWdSkz7Ns4=;
 b=GgL+QYIm3kz0Q7bQBci3Jfm/Fxd+VdU75TVzikY+rqd3Qahtk7HaayratUtZ8Ne9di
 GqXiflwFNJxCRNSCkcgMvhlxEEsHsX1pmdM9MdB7Ym5LVr2T4tThq4olPvs7Xv1qLYHc
 fHRGyRsEpM35R+f0PkAuV3pPVFkBEPkdPhpvY2Yc6j9zRLL7TkcGwYOZKH0XDehIZQon
 14LXYUQs2ILPitPJVl/TFVCYoolgEopNZUXAtOpnZQ8QePiVUCYsjRE5EBHm9lmfpFX4
 GW1rDSHIYw8wggXMYaDmH7nL9cLvrEcZuX4TLZC1ojmN4fBRQ0aLsTNztPzfggd0fs+M
 hpKQ==
X-Gm-Message-State: AOJu0YyfKolb3JUJ6YwUJ8ffRmE9/KFQexR5Ar8fwm5+8pwvXtaZkjOm
 700tcpgPcVcG23xKWpEHuLUPJCPZQZ1cx5Eocp0CG/7sZAhRyOazNQQbeYNzWQQIXAbXMuYAEPM
 IAiwhg+k5acdyPSoDK2GUUfGWZs2ebPrrBEBr/X6csuvdPK0cNCi5VqVXho9drDdC13RCAIVo03
 I=
X-Received: by 2002:a17:906:1daa:b0:9ae:5f51:2e4a with SMTP id
 u10-20020a1709061daa00b009ae5f512e4amr5975092ejh.36.1696590866858; 
 Fri, 06 Oct 2023 04:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcoWMMhaeDU98dGPIy0WtFkURPfaCAob1IE9hXxMZP55vn7HrcuoKOfW4GkJuZ+vL9Gn4egQ==
X-Received: by 2002:a17:906:1daa:b0:9ae:5f51:2e4a with SMTP id
 u10-20020a1709061daa00b009ae5f512e4amr5975077ejh.36.1696590866515; 
 Fri, 06 Oct 2023 04:14:26 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 k26-20020a17090627da00b0099b7276235esm2734168ejc.93.2023.10.06.04.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/26] cpu: Correct invalid mentions of 'softmmu' by
 'system-mode'
Date: Fri,  6 Oct 2023 13:13:53 +0200
Message-ID: <20231006111412.13130-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-4-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu.c                | 2 +-
 hw/core/cpu-common.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu.c b/cpu.c
index 0769b0b1539..8cb67901423 100644
--- a/cpu.c
+++ b/cpu.c
@@ -209,7 +209,7 @@ static Property cpu_common_props[] = {
                      prctl_unalign_sigbus, false),
 #else
     /*
-     * Create a memory property for softmmu CPU object, so users can
+     * Create a memory property for system CPU object, so users can
      * wire up its memory.  The default if no link is set up is to use
      * the system address space.
      */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ced66c2b342..f04d59c8d5b 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -228,8 +228,8 @@ static void cpu_common_initfn(Object *obj)
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
-    /* *-user doesn't have configurable SMP topology */
-    /* the default value is changed by qemu_init_vcpu() for softmmu */
+    /* user-mode doesn't have configurable SMP topology */
+    /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
     cpu->cflags_next_tb = -1;
-- 
2.41.0


