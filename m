Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C874B2AB
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm4v-0007Eg-DE; Fri, 07 Jul 2023 10:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4q-0007DP-Vh
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4p-0006PL-JN
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiOYyMPdCF+gwvA6gOi5sKlNmjezeXeGKI/uztjBq80=;
 b=UMzpcdbfXQVi2FBN7Q5cvGms3MJm3qfAXY0dhg9bmsZH5j3tVJMKWEiVaOyTSX/SE4/R5u
 9+vuCactGJuZQQORJ97TT+dWeHbgUGuT+JMbVYyj7eyqq67OBDPu4wFNyDT0zWOm1NxOgS
 CZWoIfDt4Ebpqn46FNo5w7TR0gBWyUM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-JmDwEawMNZmRe0H4JiiNtA-1; Fri, 07 Jul 2023 10:04:49 -0400
X-MC-Unique: JmDwEawMNZmRe0H4JiiNtA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb9364b320so1904124e87.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738688; x=1691330688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiOYyMPdCF+gwvA6gOi5sKlNmjezeXeGKI/uztjBq80=;
 b=R1ZzPVkFAopg/SkSoyYuBjIbDw+kxoX8Gkwt2uinNYcD8+kD76Pv2Or5KdsVzrU7v3
 23mo+KNpGJ0m5lh5llbYDIlsgjhk1H2btkAAP9q/LEEvahWp/+c1VwTKikaJrfdk48w6
 eXc/pVm7XGRHXkhTN1PB/j7BcZpcuvRLCV0qIaZ7tjtTPdew/N+YRZ+N9kH22aRREo8a
 0iwmnZiZR5kQ4VGl19Z3CRQF0aiuaFP4iOadpQfNjF+v8IxJ/atKzX6nnKoSiMxwy2aX
 g83bvNUeG+MDwc7S5JhK1wgEySTeVr9UZo9yCQiUab9bt3FUjPzhFiD+VLTnwB+v8tt0
 Cv0Q==
X-Gm-Message-State: ABy/qLYd/gOpd+wFSs/soUi2n8VpYUkRyJgaVsYrgSutJQNbu4qm1oBG
 lMVqZ/JmNVOoOd/ccfbOVfEIt47XOZrwtkELD7GC2JnJAeNC/2Wc4446BSjpEGHDadfs63iRMOp
 A4QEf6eP4qPECr5iicWiDgbekmxXSVbLJN4wi/rii6mogIGxiLalFVrvIOC1PmINgwPs4cw4imu
 Y=
X-Received: by 2002:ac2:5e7b:0:b0:4fb:8948:2b28 with SMTP id
 a27-20020ac25e7b000000b004fb89482b28mr3945969lfr.63.1688738688014; 
 Fri, 07 Jul 2023 07:04:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHbMZyTPRiBLHIxCDguaXKffoR/JroWYLteOPtfpW+AeH8RpDOsZHD88JYVlQS9os0FFjHw4w==
X-Received: by 2002:ac2:5e7b:0:b0:4fb:8948:2b28 with SMTP id
 a27-20020ac25e7b000000b004fb89482b28mr3945950lfr.63.1688738687745; 
 Fri, 07 Jul 2023 07:04:47 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k17-20020a05640212d100b0051a4c1dc813sm2107693edx.82.2023.07.07.07.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 07:04:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Wang <lei4.wang@intel.com>,
	Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 8/9] target/i386: Add few security fix bits in
 ARCH_CAPABILITIES into SapphireRapids CPU model
Date: Fri,  7 Jul 2023 16:04:31 +0200
Message-ID: <20230707140432.88073-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707140432.88073-1-pbonzini@redhat.com>
References: <20230707140432.88073-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Lei Wang <lei4.wang@intel.com>

SapphireRapids has bit 13, 14 and 15 of MSR_IA32_ARCH_CAPABILITIES
enabled, which are related to some security fixes.

Add version 2 of SapphireRapids CPU model with those bits enabled also.

Signed-off-by: Lei Wang <lei4.wang@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Message-ID: <20230706054949.66556-6-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 852c45b9658..ec229072e76 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3944,8 +3944,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (SapphireRapids)",
         .versions = (X86CPUVersionDefinition[]) {
             { .version = 1 },
-            { /* end of list */ },
-        },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "sbdr-ssdp-no", "on" },
+                    { "fbsdp-no", "on" },
+                    { "psdp-no", "on" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name = "Denverton",
-- 
2.41.0


