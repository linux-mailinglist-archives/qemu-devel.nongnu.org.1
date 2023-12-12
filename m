Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E02980E8FC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:23:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzuG-0006Zf-Ho; Tue, 12 Dec 2023 05:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rCzuC-0006ZL-Au
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:22:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rCzuA-0007q4-PX
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702376541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucjuuz59Eb5S+ytMt6V/ocgOwnaQyl+aftIQogBEN0k=;
 b=Cz0rgeahyKUqU6CVGtyQcNdq2bAdTImQRNc/4xBo3VS0yFFTGNNWJhYsHJ6KL3Wif7MzGt
 yQerdHvjcGXzXPKxeMMkn4uwqx5D+g5zqJDEXptZ36T+dk4HUO1nP6HhSjAmf5OrczOJsG
 ZoOwQPynNdYbVjl6iL6U0Z7Dk6+q4Mw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-OlzNfUd5MgiZCSNY7eaSgA-1; Tue, 12 Dec 2023 05:22:20 -0500
X-MC-Unique: OlzNfUd5MgiZCSNY7eaSgA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40c31eb65a7so20567315e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 02:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702376538; x=1702981338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucjuuz59Eb5S+ytMt6V/ocgOwnaQyl+aftIQogBEN0k=;
 b=B8VP03sEOMfRVtB4oLs4wXScJ5Fnjs0bcffvsDIjJizBKhEI1suRk2lLMSX1tgBWO4
 1COav4OIF9P+Ax0O28A58yRnVhcPeLwz9gaAXYQOijW8CzW8dIxdqR9Z0L+pvD3I8GJR
 m2ShMs8be/TH0LTIsHtJ0zWAJwoJVL6jQLau6c51it5nLpYK5/KMlT0pzIbvHIt1ms9a
 aIfRV+iKHSpeFFe6SqdzKJ6PlwDarv3H+misIZLFhhNQ5MOrhAdhzHCWn0tM3lBWuoPq
 zIkCYgMOjiOjlHAsYf2PVNiQ5k3UBKsG9kuHchyCPcBJT3IWfLUvP3bP0s6P/ysp1rBS
 AYWA==
X-Gm-Message-State: AOJu0Yy14TChvbR/rIhQXu77LmlS/df4+9xbzHwZOcqVEmkLz1Yqw/Kr
 bOGEFUU7TVxoxbI7c7aguqWxhQglMCztTqPjvT+21UkB2Y9/RRTpqtCsqS5+LIPRuYPRwzk5vet
 8ADMFJylO2rVOUDJrNUAKWAlm32LC4bGiPmfG72ojR3abzcwkgYaMmJSqgoQawJrTVpb8pn5eOK
 k=
X-Received: by 2002:a05:600c:4897:b0:40c:2b49:460d with SMTP id
 j23-20020a05600c489700b0040c2b49460dmr2830668wmp.135.1702376538338; 
 Tue, 12 Dec 2023 02:22:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFeN2Lwjr8K3WhrGezWHhCZ5+gSEoAcmbJQpg0GeWbhJV5NgFvtjWlpFZpqflwycUJqxB9Cg==
X-Received: by 2002:a05:600c:4897:b0:40c:2b49:460d with SMTP id
 j23-20020a05600c489700b0040c2b49460dmr2830652wmp.135.1702376537865; 
 Tue, 12 Dec 2023 02:22:17 -0800 (PST)
Received: from [10.201.49.8] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a5d5192000000b0033339027c89sm10469510wrv.108.2023.12.12.02.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 02:22:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Stefano Stabellini <stefano.stabellini@amd.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Young <m.a.young@durham.ac.uk>
Subject: [PULL 1/2] meson, xen: fix condition for enabling the Xen accelerator
Date: Tue, 12 Dec 2023 11:22:13 +0100
Message-ID: <20231212102214.243921-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212102214.243921-1-pbonzini@redhat.com>
References: <20231212102214.243921-1-pbonzini@redhat.com>
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

A misspelled condition in xen_native.h is hiding a bug in the enablement of
Xen for qemu-system-aarch64.  The bug becomes apparent when building for
Xen 4.18.

While the i386 emulator provides the xenpv machine type for multiple architectures,
and therefore can be compiled with Xen enabled even when the host is Arm, the
opposite is not true: qemu-system-aarch64 can only be compiled with Xen support
enabled when the host is Arm.

Expand the computation of accelerator_targets['CONFIG_XEN'] similar to what is
already there for KVM.

Cc: Stefano Stabellini <stefano.stabellini@amd.com>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Reported-by: Michael Young <m.a.young@durham.ac.uk>
Fixes: 0c8ab1cddd6 ("xen_arm: Create virtio-mmio devices during initialization", 2023-08-30)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index ec01f8b138a..67f4ede8aea 100644
--- a/meson.build
+++ b/meson.build
@@ -123,21 +123,24 @@ if get_option('kvm').allowed() and targetos == 'linux'
   kvm_targets_c = '"' + '" ,"'.join(kvm_targets) + '"'
 endif
 config_host_data.set('CONFIG_KVM_TARGETS', kvm_targets_c)
-
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
 
+if cpu in ['x86', 'x86_64']
+  xen_targets = ['i386-softmmu', 'x86_64-softmmu']
+elif cpu in ['arm', 'aarch64']
+  # i386 emulator provides xenpv machine type for multiple architectures
+  xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
+else
+  xen_targets = []
+endif
+accelerator_targets += { 'CONFIG_XEN': xen_targets }
+
 if cpu in ['aarch64']
   accelerator_targets += {
     'CONFIG_HVF': ['aarch64-softmmu']
   }
 endif
 
-if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
-  # i386 emulator provides xenpv machine type for multiple architectures
-  accelerator_targets += {
-    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu'],
-  }
-endif
 if cpu in ['x86', 'x86_64']
   accelerator_targets += {
     'CONFIG_HVF': ['x86_64-softmmu'],
-- 
2.43.0


