Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B07D7890
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnIS-0002CC-Os; Wed, 25 Oct 2023 19:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnIG-00026y-OJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnIF-0005K3-9e
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJ36OWrZCktK0QmLa2cv+blW9nwulBgc4Ukr617HBmY=;
 b=R82127fHcTv3OSjBD45IECvoGvacTVUy10adLJMu3fBBkcenUlw+cNSYMzIdw/b3YMwwxF
 DCvY5WUgQtdWdd7l2A70CBYzxEHIZ3qsmndvMjnVPQE8Q/4QBAUzjr7PM7Wa5Gg7W+7RUq
 MH3JTvgvURbqhewd0W6PIHOWgDC7CR8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-DOdXtai6PCWqXvNA_-hk0Q-1; Wed, 25 Oct 2023 19:28:03 -0400
X-MC-Unique: DOdXtai6PCWqXvNA_-hk0Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d040c58eeso3733396d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276482; x=1698881282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJ36OWrZCktK0QmLa2cv+blW9nwulBgc4Ukr617HBmY=;
 b=kLgjsxWvCVZ4cu1LDgnOEaDHxb2Z8fnTgaaWW3YEXRi87yyRiOVQ6kvX2y6PjnIFyr
 YULyRJ3rjwWXV4b9QH2S1d4yHauydp+YqjHq81FYeN7YY1l3zNZKyXfZvjdxostLvjbD
 ow0UoCyHx5T0Qikxn6i5vm3NSwym0KBLKCRuJyi8jTeuCtydKf6tQiEpkDVhlNkvcXwV
 jWEQ+0haKwcDVaEYwdiBMjMKCwDVUcEJscuXgT+p9yxHeLu+QlUBr43ja1FAEhArYu5x
 igKdXB8/lCRinYfd1Svj3CnvnyGFyS7Mz6SVFkx0ihm++x6Hzd7BvfkwcP6cqLly4Edy
 hYCA==
X-Gm-Message-State: AOJu0YxAZHycjdKd3mfpRMui1J4GeaPOTdDjkbz5otl9d4uXMjHN0UGI
 BiDyKUw/WLjhSoSMemYWBp5qQG79ASVTFeq1XnuHW2tdhxg/fKhQx60kzOPOsyQl8PYsAbgHNu1
 eG32XmvBjqBaRtPuS2fGBIbw4+K9hC9nQD7HvYP1BA5w9oDj0jD4y6A8Y9tcLLMKpMV3czTyLMn
 c=
X-Received: by 2002:ad4:4ea7:0:b0:649:384f:ed4 with SMTP id
 ed7-20020ad44ea7000000b00649384f0ed4mr22372606qvb.19.1698276482379; 
 Wed, 25 Oct 2023 16:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG1+zrBXH5ZhJV4SjSeSctsGZuBG5BU66Ri1KZHtE0IFva6NuLOhMgdt9882PtBLjOHaj/rw==
X-Received: by 2002:ad4:4ea7:0:b0:649:384f:ed4 with SMTP id
 ed7-20020ad44ea7000000b00649384f0ed4mr22372593qvb.19.1698276481981; 
 Wed, 25 Oct 2023 16:28:01 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a0cef8d000000b0065b17b925d0sm4751912qvr.38.2023.10.25.16.28.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:28:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] kvm: i386: require KVM_CAP_SET_IDENTITY_MAP_ADDR
Date: Thu, 26 Oct 2023 01:27:16 +0200
Message-ID: <20231025232718.89428-24-pbonzini@redhat.com>
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

This was introduced in KVM in Linux 2.6.32, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index d4bf327fa6f..e364b842e6d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -99,6 +99,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
     KVM_CAP_INFO(MCE),
     KVM_CAP_INFO(ADJUST_CLOCK),
+    KVM_CAP_INFO(SET_IDENTITY_MAP_ADDR),
     KVM_CAP_LAST_INFO
 };
 
@@ -2600,20 +2601,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
      * Since these must be part of guest physical memory, we need to allocate
      * them, both by setting their start addresses in the kernel and by
-     * creating a corresponding e820 entry. We need 4 pages before the BIOS.
-     *
-     * Older KVM versions may not support setting the identity map base. In
-     * that case we need to stick with the default, i.e. a 256K maximum BIOS
-     * size.
+     * creating a corresponding e820 entry. We need 4 pages before the BIOS,
+     * so this value allows up to 16M BIOSes.
      */
-    if (kvm_check_extension(s, KVM_CAP_SET_IDENTITY_MAP_ADDR)) {
-        /* Allows up to 16M BIOSes. */
-        identity_base = 0xfeffc000;
-
-        ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
-        if (ret < 0) {
-            return ret;
-        }
+    identity_base = 0xfeffc000;
+    ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
+    if (ret < 0) {
+        return ret;
     }
 
     /* Set TSS base one page after EPT identity map. */
-- 
2.41.0


