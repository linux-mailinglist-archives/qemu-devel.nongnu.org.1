Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE874B2B2
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm4u-0007Dq-Av; Fri, 07 Jul 2023 10:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4l-0007C0-0F
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4j-0006Nd-Kf
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLuaNWCF8ZUT88opz+YLHWmCBTV1N2sodCLhGrxdZ5w=;
 b=A8fSmk6LMt3guEBb1RjqahJLsfWCucPxXZFn3fqrE8OmmaO5R31kUYbuWo4PmMWvayK558
 vfglFnZ8g/boneZ+ufK+mszZLPi/p/y4CH8wRDo7dylvRDNA8ddcA7vMYlFwi2D2JQAq7w
 2TudYEEaC+BHXlrexrk3YlzUl+hz9WQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-CIqyK_DtMTCp0LNqqP4jBw-1; Fri, 07 Jul 2023 10:04:43 -0400
X-MC-Unique: CIqyK_DtMTCp0LNqqP4jBw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-50a16ab50e6so1226679a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738681; x=1691330681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLuaNWCF8ZUT88opz+YLHWmCBTV1N2sodCLhGrxdZ5w=;
 b=b7QjcxVHxU6yW/xLacgkbqcLa4Fb3+mjU4B1d1Ox3D7L0/tJ2uxMh22CALk/LM55+r
 CDFjR2fWpfyZUuQuVz+97rK2qcVBHCLqoHBkPGZunXxJXh4c7OBXlfMZAyL8F+DlcPLK
 ej3bA562evwPQWRvzrbJvLXwTqkDLy4TGYle4Wq/4grdK+56xXcQAJwjRMJjdtKowqkJ
 akBdezTyQyG8BuuwfidDwBt9Vps2r4OjbMdsuVgw9ob62AtJ0FpOO4UntCa1hDkq6aNH
 4rFd1wshsTh2JdhYsbJERJUByFctyKkZjIS/GCCxuqXP2nZMo/csJBHbjtwBYtU0rdjf
 UazA==
X-Gm-Message-State: ABy/qLa067l/84/YFFGFzHaZN3ffoqd1SCoDE1fKDoRppzyNdQ3MTCj7
 9TCZb0fuJJqZDvvz9NnHRNYOo8v4ZQdewSQKo/iNOCPdkmE2AnFsN5J/YWdu5fFIXFrYImYREkJ
 bLpbIRSkEr0F8imNmm8cUrGj8m+LggzTUYlgJMtuCzHdBUTXXoN2mor0mrNl/p0gE+FuEdurFZK
 8=
X-Received: by 2002:aa7:df95:0:b0:51e:2cdb:ed1f with SMTP id
 b21-20020aa7df95000000b0051e2cdbed1fmr4497044edy.9.1688738681306; 
 Fri, 07 Jul 2023 07:04:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1ktvx4EN7Qd0m6pSCnpsQgawk4lxZdol35k5aZahV1hBLuFsNJ7F2erMenzfKP0B98fycsQ==
X-Received: by 2002:aa7:df95:0:b0:51e:2cdb:ed1f with SMTP id
 b21-20020aa7df95000000b0051e2cdbed1fmr4497025edy.9.1688738681057; 
 Fri, 07 Jul 2023 07:04:41 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a50ec90000000b0051e2a5d9290sm2109023edr.77.2023.07.07.07.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 07:04:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>, qemu-stable@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 4/9] target/i386: Adjust feature level according to FEAT_7_1_EDX
Date: Fri,  7 Jul 2023 16:04:27 +0200
Message-ID: <20230707140432.88073-5-pbonzini@redhat.com>
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

If FEAT_7_1_EAX is 0 and FEAT_7_1_EDX is non-zero, as is the case
with a Granite Rapids host and
'-cpu host,-avx-vnni,-avx512-bf16,-fzrm,-fsrs,-fsrc,-amx-fp16', we can't
get CPUID_7_1 leaf even though CPUID_7_1_EDX has non-zero value.

Update cpuid_level_func7 according to CPUID_7_1_EDX, otherwise
guest may report wrong maximum number sub-leaves in leaf 07H.

Fixes: eaaa197d5b11 ("target/i386: Add support for AVX-VNNI-INT8 in CPUID enumeration")
Cc: qemu-stable@nongnu.org
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20230706054949.66556-2-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5688cabb4f..952744af97c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6880,6 +6880,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
-- 
2.41.0


