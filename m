Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D277CE2F7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:39:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9YC-0000vG-M1; Wed, 18 Oct 2023 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Y9-0000uh-GB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9Y8-0007NC-25
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbMj+5RWahTieDRbcX5DC9e5dLRHLHSOEQ+5tZ4A9v0=;
 b=b1dtBXFb7RWDjWZFzIoickq9J6q+G1kXqQarfKYuM31w/IvLBm61VSeHTZKy56YUADQhiP
 S6sFgrD4calprmA20KiAm5d43x9cPg2fHUOUV6zagUyRzgb6c9qqMimLhC5k+yt4/od8F9
 yHNmrZYzN/MtKaw5ZoLeG9hcBmJAbSY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-L_7WRaMkMv6QFnuaMIhs0w-1; Wed, 18 Oct 2023 12:37:33 -0400
X-MC-Unique: L_7WRaMkMv6QFnuaMIhs0w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae57d8b502so526188966b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647052; x=1698251852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbMj+5RWahTieDRbcX5DC9e5dLRHLHSOEQ+5tZ4A9v0=;
 b=ET3ERji/mE8rCUtUmm8lk2vUMFyE0vBj4X4MZkvUqk0BfUecA+mp8eRMt5p5amjEUj
 zZFQjy14HeDcTaUnSJ3YgM4Lt1RI/U0gmjV+N/vVBX3Bp0BU7FkFJJiyiRSAgUUADxYU
 GrqZJs6UvXeCr4/ny9WFyjNKX0vR6I55vykkh0MvtAy66Zgj00NspIoGRcIBOR0wVhQn
 ekfkTxISGJX3Cy4Y3BnIyZ1KjpDzA24MgAWzliVzKFGBJ6fellcaO8qJpkTCHakOd2My
 gT0bnK6UTsJDfKZ8iJxSJFgmBVxUDeyFwAhwRK8u8Jdb8mM0ygWvEC1RSE+m+i1ujus/
 IrnA==
X-Gm-Message-State: AOJu0YxSBsML9AENQJh+mijAfYXsXfFnpekBMismf9gMHnMljAij+Vll
 aEtaYs1RhpgFF6ZjKdVAodsM9MdbJiJ6QRCaRjb11nRkho4+URCNSApYLJdwoIbK41LXDN6IYtZ
 eUsjD9x7UpAnd6iyjYhpzHcyj6eyrthCBvmEMug045zE5eLlVwV2lK9L5/umHA3r2hf4A3AJ19F
 4=
X-Received: by 2002:a17:907:7f20:b0:9b9:f46f:8925 with SMTP id
 qf32-20020a1709077f2000b009b9f46f8925mr4540526ejc.48.1697647052444; 
 Wed, 18 Oct 2023 09:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw3xiJ9kFUcOpikAjgpAbqM9ZAplu6mdOSrV3heUeQ4mzgcX85fI9D4F3qr2Vb18qhBvb5rg==
X-Received: by 2002:a17:907:7f20:b0:9b9:f46f:8925 with SMTP id
 qf32-20020a1709077f2000b009b9f46f8925mr4540513ejc.48.1697647052198; 
 Wed, 18 Oct 2023 09:37:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 i24-20020a1709061cd800b009ad8d444be4sm2008437ejh.43.2023.10.18.09.37.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/17] kvm: remove unnecessary stub
Date: Wed, 18 Oct 2023 18:37:12 +0200
Message-ID: <20231018163728.363879-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
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

This function is only invoked from hw/intc/s390_flic_kvm.c, and therefore
only if CONFIG_KVM is defined.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/stubs/kvm-stub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 51f522e52e8..a323252f8e2 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -92,11 +92,6 @@ void kvm_irqchip_change_notify(void)
 {
 }
 
-int kvm_irqchip_add_adapter_route(KVMState *s, AdapterInfo *adapter)
-{
-    return -ENOSYS;
-}
-
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
-- 
2.41.0


