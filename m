Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 105ED7BB63C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinT-00009z-Um; Fri, 06 Oct 2023 07:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinF-0008FY-I9
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin3-0000JW-W5
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf5kliQJvODafTBVKI8xhSD2Qcuhj4Z5mREXuzd9NXw=;
 b=g/eU3R7B6uuoMkDpbpwJGwnJayW16a1zvZA/pTk1k4DUB96GqpXnPoaf6N/uBo+5vdOGLs
 E+AA37BMdPERcA2xy9DXzT4Oij1IVjiB1DHNhunpvD29KHXXnnUZXAsP5+ArlXS1bnXoL0
 95C9l6RJ//Wgk7HMhKXezWZULVje4DE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-U4dNbeNmOtenU8vMa3gZIA-1; Fri, 06 Oct 2023 07:14:39 -0400
X-MC-Unique: U4dNbeNmOtenU8vMa3gZIA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b822f5c156so171494166b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590878; x=1697195678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bf5kliQJvODafTBVKI8xhSD2Qcuhj4Z5mREXuzd9NXw=;
 b=FQ+YsfRxeTSWVv55INYcKeoS7NJTJKi7/iTKF20eu/CI3MxuTcLqrZ4XlRaNskaqFo
 vJyQEXqdJbfIxrOLXLy2u7E44zi7WG+1RNSHiNKuVpUhuhj9hwo5c/P1AgaxnMIBMM8W
 FbEJP5X4Pgx+JIO17CsZTHtsRxu8cj38xVW8+JVigiLycq1zAgchNdLJz4reNVWCVc+U
 reVlL3hZLFlZYHj+S6m8mcOIJl/QSQSG0VYPV52abYGQuermAMdCaa3yVzfa65rejJ28
 6WTxKRF9FPrJewnlixOoN7gKRvm/oemWlQLv2PQi+U7itpFFev2S/QipMUcjhIX9U3Pr
 LoGA==
X-Gm-Message-State: AOJu0YxsOBxLKZYboD82QJW/rcCPt3h66jIP/bn6NmiDiv9en/IOIeGn
 Y7+QOOhPjoG9NwgHYBfc0nhN0bfXhnVBdab3q/svQEoQcEry8RafzLHUvYtoERM1AxHCsPfiKlr
 3wBljNCZTwQK8H7cK9AMoCcW/CMnHZdrSOXlreJNzRd9GhV01BhrTS0X5Optnyygmj4NG8aOKSz
 0=
X-Received: by 2002:a17:907:75f4:b0:9ae:699d:8a2f with SMTP id
 jz20-20020a17090775f400b009ae699d8a2fmr7067675ejc.2.1696590878243; 
 Fri, 06 Oct 2023 04:14:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELq7OGp0eREBrquIAUcJHkeKgYLQFZiyzxuAJ+ns9FwnPMToLSkkdORmlo23qaYfU4bi9hKA==
X-Received: by 2002:a17:907:75f4:b0:9ae:699d:8a2f with SMTP id
 jz20-20020a17090775f400b009ae699d8a2fmr7067656ejc.2.1696590877908; 
 Fri, 06 Oct 2023 04:14:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 ss7-20020a170907038700b009a9fbeb15f5sm2668221ejb.46.2023.10.06.04.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/26] target/i386: Rename i386_softmmu_kvm_ss -> i386_kvm_ss
Date: Fri,  6 Oct 2023 13:13:59 +0200
Message-ID: <20231006111412.13130-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Software MMU is TCG specific. Here 'softmmu' is misused
for system emulation. Anyhow, since KVM is system emulation
specific, just rename as 'i386_kvm_ss'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-10-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 5d9174bbb5d..84d9143e602 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -1,14 +1,14 @@
-i386_softmmu_kvm_ss = ss.source_set()
+i386_kvm_ss = ss.source_set()
 
-i386_softmmu_kvm_ss.add(files(
+i386_kvm_ss.add(files(
   'kvm.c',
   'kvm-cpu.c',
 ))
 
-i386_softmmu_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
+i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
-i386_softmmu_kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
+i386_kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
 
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
-i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_softmmu_kvm_ss)
+i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
-- 
2.41.0


