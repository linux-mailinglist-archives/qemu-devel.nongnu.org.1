Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA79A7D7884
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHy-0001bL-Q9; Wed, 25 Oct 2023 19:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHw-0001YF-Rt
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHu-00053y-BD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULsRG+XU+XVacD6X5WW4XfFMbqSG6WE2QP4goo2ipGw=;
 b=FQyIx4b79J7msMYUrQGBqjfDkEHE9hQLnTZ5GSyi9OSOAYBNj3IWSWt7h7+tNyi1TtvbI9
 CYnpGZAxg4oJsfTSLjvlTuJuUvAsJOAlKoTH1uX2JVtjEJnjNCTdOWba456VFhS17MY1HB
 LINNNICxd4DpiSVQAd0q7SbGKD9diTY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-INZIIQKHOJiu3thkL8lySw-1; Wed, 25 Oct 2023 19:27:44 -0400
X-MC-Unique: INZIIQKHOJiu3thkL8lySw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-778999c5f1dso41760085a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276463; x=1698881263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULsRG+XU+XVacD6X5WW4XfFMbqSG6WE2QP4goo2ipGw=;
 b=LLwWjGlr3sZCwRrPn3YntiKJgLIugLJOeIEcYRrfxRDsMISlPZmlQHK5kNt6dmKPeN
 6ox+YMEbt0ifWzr46aH9Zzz6cbrMxZXwzMtc9byNVT/GK3sNyiAcf6+D4x5EUVLwklqI
 zgHZKZtGRUtojBIHMMNbvMQ+XiOGdkQY5MWnnY3iBZkf1CGggv9WCV2FsA7ZYQwM9/Re
 R4s9Y8mkqus4EC3IdiNKqbYSFyQCQMb+c3fZZB4ViNL6D8tCzqzCb0QvfNHHgkNOK6ZH
 COgQ9ejfkOGaHECroc1Lz/538iuCST96fnqI21M/v904/kAA2WJpkIbt2X/UmygqDa+K
 lzjg==
X-Gm-Message-State: AOJu0YwPcNSpkR9obQKCIs9TjtOSOE+ErWANxE8wT9UwNHNnmanAK/kY
 5/++GbwS4pHr3S33rIdjKQVPMjwPQXCB6qyadZ0p7L2Y5D3Kc5lEDO2R6BE6e43Snz0dXLIu/Uo
 d1tSolHUB/LIa6AwnfHZgY9PBHN80ABLVJcllUfYtOOHjsqsa4G/KTeX19VkTMX9F7aaOJLd/fr
 A=
X-Received: by 2002:a05:620a:1710:b0:778:a93c:e661 with SMTP id
 az16-20020a05620a171000b00778a93ce661mr18770922qkb.32.1698276463029; 
 Wed, 25 Oct 2023 16:27:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGesiSPoTRvVP+Dz/lrDeKP4SibjPRAGk6vhNXb6oKuX9+bz5kF/K40ULAX/J5h4SS/IA3dlw==
X-Received: by 2002:a05:620a:1710:b0:778:a93c:e661 with SMTP id
 az16-20020a05620a171000b00778a93ce661mr18770908qkb.32.1698276462648; 
 Wed, 25 Oct 2023 16:27:42 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a05620a0c0f00b0077892023fc5sm4554601qki.120.2023.10.25.16.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 12/24] kvm: require KVM_IRQFD for kernel irqchip
Date: Thu, 26 Oct 2023 01:27:05 +0200
Message-ID: <20231025232718.89428-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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

KVM_IRQFD was introduced in Linux 2.6.32, and since then it has always been
available on architectures that support an in-kernel interrupt controller.
We can require it unconditionally.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 575dee53b39..16d58d2598a 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -167,6 +167,7 @@ extern bool kvm_msi_use_devid;
 #define kvm_irqchip_is_split() (false)
 #define kvm_async_interrupts_enabled() (false)
 #define kvm_halt_in_kernel() (false)
+#define kvm_irqfds_enabled() (false)
 #define kvm_eventfds_enabled() (false)
 #define kvm_resamplefds_enabled() (false)
 #define kvm_msi_via_irqfd_enabled() (false)
-- 
2.41.0


