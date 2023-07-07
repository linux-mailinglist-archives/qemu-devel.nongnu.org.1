Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35274B2B4
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:07:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm4t-0007Do-Pl; Fri, 07 Jul 2023 10:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4o-0007CS-1u
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4m-0006OY-Mw
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqsJQaftY1Uc5GURCDMxtfHcPTonhG6bpqMWSq1J8Po=;
 b=dQjbAGkFmVam2BFIEVcR142L3IIMjIEULVP4wl7pvIQ2ziPsR+5J/VVKchVi27Kuwg2oL1
 KpVCpX+d7InXSqgkc+w1enfxdjrKGyE+9gkcgbMd02/PGTG5RKAjaLI8ovuvKeV95UtRsa
 aZ5ived6w+MTSQ4CSdflU66LNxGCs/A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-VvWSTGDbPLSiRVci6l1r6A-1; Fri, 07 Jul 2023 10:04:46 -0400
X-MC-Unique: VvWSTGDbPLSiRVci6l1r6A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51d91ca5635so1390455a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738684; x=1691330684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqsJQaftY1Uc5GURCDMxtfHcPTonhG6bpqMWSq1J8Po=;
 b=XSIqcsGPMlDKaU/d4F5PdWiNDWIN5DnZoV4121mDMzNxbp8UjXXo8/y+tvhzZr2ihc
 dGDg65zfU08Nsbteg92chI2XNw0NGhMepmsDgbZjGKsc56DsT/Nuc3VCI6lOmDAAOk4V
 u7hUyV0ESFouKZH72k/O6DK2M5yPzc7mHqnqF7VDrXJAiTbUhXIiQVCQCs4t7DTI8GCr
 yfq38rKAWTFrq4U7HSmvBB3inzP2eJl6Q2F+sC4jnJzjEt8Xk09kqshT/j7kme8ERxAs
 ScLlmQKQ3a/ORdDSlYR9zYYB8LiqGOPYfWk47COP0v9topyYCo6iQ47vby2qbUUppB9g
 7zyg==
X-Gm-Message-State: ABy/qLaxam8mIA73fqvWwZVVbbsl5lUkPY8lDh3jiNkc4GM/X25CnoHZ
 WfZbQ5HJ1aGI/lwkneI2Fe2lcnwHZ3xTmIT3g2giX0/GFLcNJSE67zsvIz/KcoGh3v2oC3Lzw+7
 9sSPLDqGYBm/blLSGsFFO3IKbU2OgFGyAYv+/PKi8EUll4AsRYGsJajTej4Aszvz5635VYF801m
 4=
X-Received: by 2002:a17:906:a96:b0:977:eed1:453c with SMTP id
 y22-20020a1709060a9600b00977eed1453cmr2670224ejf.73.1688738684667; 
 Fri, 07 Jul 2023 07:04:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGExnWn/CUp6+JOnqGY3/jJcL/CSZrS2DhPr783frwm1/dLHuCP1moiMjdQlvZ/eGc8PuOYPg==
X-Received: by 2002:a17:906:a96:b0:977:eed1:453c with SMTP id
 y22-20020a1709060a9600b00977eed1453cmr2670214ejf.73.1688738684404; 
 Fri, 07 Jul 2023 07:04:44 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a170906148900b009786c8249d6sm2258010ejc.175.2023.07.07.07.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 07:04:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 6/9] target/i386: Allow MCDT_NO if host supports
Date: Fri,  7 Jul 2023 16:04:29 +0200
Message-ID: <20230707140432.88073-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707140432.88073-1-pbonzini@redhat.com>
References: <20230707140432.88073-1-pbonzini@redhat.com>
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

From: Tao Su <tao1.su@linux.intel.com>

MCDT_NO bit indicates HW contains the security fix and doesn't need to
be mitigated to avoid data-dependent behaviour for certain instructions.
It needs no hypervisor support. Treat it as supported regardless of what
KVM reports.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20230706054949.66556-4-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de531842f6b..ebfaf3d24c7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -432,6 +432,10 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         uint32_t eax;
         host_cpuid(7, 1, &eax, &unused, &unused, &unused);
         ret |= eax & (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC);
+    } else if (function == 7 && index == 2 && reg == R_EDX) {
+        uint32_t edx;
+        host_cpuid(7, 2, &unused, &unused, &unused, &edx);
+        ret |= edx & CPUID_7_2_EDX_MCDT_NO;
     } else if (function == 0xd && index == 0 &&
                (reg == R_EAX || reg == R_EDX)) {
         /*
-- 
2.41.0


