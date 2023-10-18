Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 597817CE30B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Yf-0001Io-St; Wed, 18 Oct 2023 12:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YX-00015v-NS
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YW-0007PO-85
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hNy/PELxO0LF0vJtqdJo5ueuCedDBfVu0vtDyuyZxs=;
 b=LGHr5VA/NXYTZBw7P5WuPH+o4DaGt6UJ7WWhND0nnfntO9sgrVDUYEBKVDHjYBOy18cdlk
 5ofkMTUaMaCtP6Hom73yWSOZWozQRahX1uIKeQxU2tSUEOVotFUKgdnc33VnTZOffVbLQ8
 vKpjj5b2RN8ZKAvWYQ71c88LXGM2zE8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-1sUdqgXrPS2LaUWDI_oKBA-1; Wed, 18 Oct 2023 12:37:52 -0400
X-MC-Unique: 1sUdqgXrPS2LaUWDI_oKBA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9bf8678af70so305756366b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647071; x=1698251871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hNy/PELxO0LF0vJtqdJo5ueuCedDBfVu0vtDyuyZxs=;
 b=tX4BjerR7ndVGdMCH5dehlfph5veFPhIxS+7kBdw0n6KR7Hroj/OQYPrHO9okwlny5
 e7zdcUQkvJ8LU2QfPD2WQDvGPknMClG5G6Aec5LQfDI7EhTKQXLiXtKz46M7JbSkvxzj
 Lf+SVtY1ewUJnGdUFiA27dVtTP224v7W2nQCmhDw5iyiJYvhFpfaod4dxU99dSMBHpQw
 wRKzW2DyKT9jKqamtZFk1zko6MOOMIJNhtvVmSo7a8IL56QhL5WZAmfB0KTQivlkqXCH
 imlPr9KOYefI/IhI5t4CpZJSJDlugO2phKpNiyTfspclwtZp4qdnC+P05GoG5eYA6Yef
 5XpQ==
X-Gm-Message-State: AOJu0YxkRVzR3rXsO8w+dz0ostEBRaHoQLLAT4ZUgAujK7hHPNoi9x6H
 Zk5Lep6W0gouXaMTUyngjK++lfMXLmFGpUuC1qjGZy8MrW1c99jXnzq8NSXhUPLvDuEvQ204X8G
 apFacr64V0+lg49Hhq8Nv4G2kZgdJcmoNgtC+1FFa06G2b77/w4Ox+fj3EWIwAvfRDfI/e5wzux
 E=
X-Received: by 2002:a17:907:3e99:b0:9bd:c336:21e5 with SMTP id
 hs25-20020a1709073e9900b009bdc33621e5mr4173832ejc.56.1697647071342; 
 Wed, 18 Oct 2023 09:37:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkNmKEi8Qn3S+jHyt7bhLOBEdNAXJB0tM3ofBpQaSvsmAx3oK1UQxbbQfcZWhKDVrleHa0Uw==
X-Received: by 2002:a17:907:3e99:b0:9bd:c336:21e5 with SMTP id
 hs25-20020a1709073e9900b009bdc33621e5mr4173817ejc.56.1697647070924; 
 Wed, 18 Oct 2023 09:37:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a1709060b0700b009b64987e1absm1982707ejg.139.2023.10.18.09.37.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/17] kvm: i386: move KVM_CAP_IRQ_ROUTING detection to
 kvm_arch_required_capabilities
Date: Wed, 18 Oct 2023 18:37:21 +0200
Message-ID: <20231018163728.363879-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Simple code cleanup.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ab7d39d5399..91dd43eaa9b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -92,6 +92,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(EXT_CPUID),
     KVM_CAP_INFO(MP_STATE),
     KVM_CAP_INFO(SIGNAL_MSI),
+    KVM_CAP_INFO(IRQ_ROUTING),
     KVM_CAP_LAST_INFO
 };
 
@@ -2590,11 +2591,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    if (!kvm_check_extension(s, KVM_CAP_IRQ_ROUTING)) {
-        error_report("kvm: KVM_CAP_IRQ_ROUTING not supported by KVM");
-        return -ENOTSUP;
-    }
-
     has_xsave = kvm_check_extension(s, KVM_CAP_XSAVE);
     has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
     has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
-- 
2.41.0


