Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03721710E19
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:17:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlJ-0004lO-O9; Thu, 25 May 2023 10:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl7-0004fD-88
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl3-0007eK-Sw
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcyOskrg26ldLftCyL08wJ83ZLvx5fXvsC3Lu+udNq4=;
 b=aCp8YAQCDJCgMdrG1R502vlnYTHmjuXi1G+ObAHipOeC5yaaAGmWaz9LTRONcYPOlSJhVv
 zP0L1nmHqSrimeWx1aN0pMaC5xiPgIuInxmR9Fzp9Z70RS2BeoPtCT/S686bXIaSwLYStc
 CkBFCFu1Lj1lrjV9YR0OEWQfxkSQ7V8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-CH-QH4aHPNmar2QndXK2aQ-1; Thu, 25 May 2023 10:15:54 -0400
X-MC-Unique: CH-QH4aHPNmar2QndXK2aQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9715654aba1so78933066b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024151; x=1687616151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcyOskrg26ldLftCyL08wJ83ZLvx5fXvsC3Lu+udNq4=;
 b=DLgGzIHtTqgIA/R+F6HwO0NLaYOBUYvsVOwXHCx5/2cVudPs/VEk4tn4n8/lGWyWhC
 4C68K+k8No+RRgRpQn0BZrPCiItG0QdmvzxavvTsHhMqF023kapCiWZJjNNhO6Ezd0Yr
 rdocay+DX9zuKr87wbV3wsS4PG1RQpwG8uzt6WVmRYqGkYewwKFoeZDl/VH/zTKMSiRF
 K9OBYqF39Ho0Gmz0BGV1SCxOoQ+vSOElKg/5Aqv1YWqzt/Xk1zoBl1io/3lYFbswS/0I
 F5SnjZvjGXxroDgdWueyKdjXzh7ZoxqtOmYRy0cC15vv8z48UNxr4LsHwUor62QRWOQe
 AWYg==
X-Gm-Message-State: AC+VfDyHi1d1/Z+jqWUQpVzCq+CU3DP1x2KrZ64IVWMnOz0JtfKiJsuB
 oCqX30n76nLHuuy09TvmCqYpWwJcX4ihVFEbmt9EzF/d30uWSMI7jeWcn3L/ZLGf5iGQ90T2/bh
 dhlKGctYIUWbpj1I0V3Z1GEYJAg46jN2zrqPKCj6FfLOrdogFx5U58hnSlUAGYwvgCyAei8ST4n
 g=
X-Received: by 2002:a17:907:2d1e:b0:969:9c0c:4c97 with SMTP id
 gs30-20020a1709072d1e00b009699c0c4c97mr1667502ejc.1.1685024150757; 
 Thu, 25 May 2023 07:15:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Q0BjyZC59jHG5oBx4ykEJPF+OojZbn1cDfqFtxRt2UzZ9Cey4NXWQYMryS2imjzNmeFxfRg==
X-Received: by 2002:a17:907:2d1e:b0:969:9c0c:4c97 with SMTP id
 gs30-20020a1709072d1e00b009699c0c4c97mr1667480ejc.1.1685024150397; 
 Thu, 25 May 2023 07:15:50 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a170906144300b00966238a202esm904624ejc.7.2023.05.25.07.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/20] softmmu/ioport.c: make MemoryRegionPortioList owner of
 portio_list MemoryRegions
Date: Thu, 25 May 2023 16:15:23 +0200
Message-Id: <20230525141532.295817-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Currently when portio_list MemoryRegions are freed using portio_list_destroy() the RCU
thread segfaults generating a backtrace similar to that below:

    #0 0x5555599a34b6 in phys_section_destroy ../softmmu/physmem.c:996
    #1 0x5555599a37a3 in phys_sections_free ../softmmu/physmem.c:1011
    #2 0x5555599b24aa in address_space_dispatch_free ../softmmu/physmem.c:2430
    #3 0x55555996a283 in flatview_destroy ../softmmu/memory.c:292
    #4 0x55555a2cb9fb in call_rcu_thread ../util/rcu.c:284
    #5 0x55555a29b71d in qemu_thread_start ../util/qemu-thread-posix.c:541
    #6 0x7ffff4a0cea6 in start_thread nptl/pthread_create.c:477
    #7 0x7ffff492ca2e in __clone (/lib/x86_64-linux-gnu/libc.so.6+0xfca2e)

The problem here is that portio_list_destroy() unparents the portio_list
MemoryRegions causing them to be freed immediately, however the flatview
still has a reference to the MemoryRegion and so causes a use-after-free
segfault when the RCU thread next updates the flatview.

Solve the lifetime issue by making MemoryRegionPortioList the owner of the
portio_list MemoryRegions, and then reparenting them to the portio_list
owner. This ensures that they can be accessed as QOM children via the
portio_list owner, yet the MemoryRegionPortioList owns the refcount.

Update portio_list_destroy() to unparent the MemoryRegion from the
portio_list owner (while keeping mrpio->mr live until finalization of the
MemoryRegionPortioList), so that the portio_list MemoryRegions remain
allocated until flatview_destroy() removes the final refcount upon the
next flatview update.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230419151652.362717-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/ioport.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index 33720fe5664a..b66e0a5a8ebc 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -229,6 +229,8 @@ static void portio_list_add_1(PortioList *piolist,
                               unsigned off_low, unsigned off_high)
 {
     MemoryRegionPortioList *mrpio;
+    Object *owner;
+    char *name;
     unsigned i;
 
     /* Copy the sub-list and null-terminate it.  */
@@ -245,8 +247,25 @@ static void portio_list_add_1(PortioList *piolist,
         mrpio->ports[i].base = start + off_low;
     }
 
-    memory_region_init_io(&mrpio->mr, piolist->owner, &portio_ops, mrpio,
+    /*
+     * The MemoryRegion owner is the MemoryRegionPortioList since that manages
+     * the lifecycle via the refcount
+     */
+    memory_region_init_io(&mrpio->mr, OBJECT(mrpio), &portio_ops, mrpio,
                           piolist->name, off_high - off_low);
+
+    /* Reparent the MemoryRegion to the piolist owner */
+    object_ref(&mrpio->mr);
+    object_unparent(OBJECT(&mrpio->mr));
+    if (!piolist->owner) {
+        owner = container_get(qdev_get_machine(), "/unattached");
+    } else {
+        owner = piolist->owner;
+    }
+    name = g_strdup_printf("%s[*]", piolist->name);
+    object_property_add_child(owner, name, OBJECT(&mrpio->mr));
+    g_free(name);
+
     if (piolist->flush_coalesced_mmio) {
         memory_region_set_flush_coalesced(&mrpio->mr);
     }
@@ -308,6 +327,7 @@ static void memory_region_portio_list_finalize(Object *obj)
 {
     MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
 
+    object_unref(&mrpio->mr);
     g_free(mrpio->ports);
 }
 
-- 
2.40.1


