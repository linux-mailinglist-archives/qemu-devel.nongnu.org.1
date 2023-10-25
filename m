Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9067D788D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnI8-0001hg-58; Wed, 25 Oct 2023 19:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI6-0001hN-2Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI4-0005IM-0a
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAT6xAK95eTbsz03w/zt/d2PzehBm/TYbJG00acxeKQ=;
 b=QmrY+CqRALb+Q6Sq4TFiK0gEXHLQPFNT6HzFqiJp5mmZt4BI1qd1GURHJEtUqQ9HxKnJrJ
 RB/BexFIKFzDXbUsIS5AJtC6H0QDiuPZqbHzDJ7Dh/lBa70yHrhCL/ZaDI4Hr1diCwVsiK
 Ox2qDmmSm7SDovpkEzHHNzqXx233RDI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-tgX6nPhSNjyzZ5zhWDrGNw-1; Wed, 25 Oct 2023 19:27:53 -0400
X-MC-Unique: tgX6nPhSNjyzZ5zhWDrGNw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77405179afdso46105585a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276473; x=1698881273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAT6xAK95eTbsz03w/zt/d2PzehBm/TYbJG00acxeKQ=;
 b=JIZMDEuNmSMB9GLHLjhwAU6PJH00wUqQY9lmBpkCDcPxWNE5947vc57tF+ZFeFIiyR
 8WpCIVNtJsvdOIfVv54yxggqho4LYUxPFhxs45HbBzUFSUI/n0ltQ9Ut/l6geKd2ZhkW
 SOBQLRngVt7BgdplVUELt4hoIcRQoDy0NN5X3AIpAPddHlorwm2S4GFzu8UzTMw1hakS
 m9yIJa/DL1ChwZRA81snV6L8e3lO6uWrgZ805+qUJc25W3/bu3rCZV4U+ChprqNk7E6C
 nCxv8/B3Mko+RH85J0Pq+r6zD5U2t8iHLtvxqgjFPyJ1oEkkA0+TwUzZszsebt3Uzni5
 /NIQ==
X-Gm-Message-State: AOJu0YznF021O4saYou8HEWiGp/BGEbU1KIVft6rNEYxWO14/rBzs13F
 L/dZ7lMHBF6zvQlg8esRf0R0GSjiBvNHWGG7Jn3bmYW6MSyFnxX0MJXOS9zotzMY1KIaHdisE2r
 llNLYX6FrgsIOPRLiXhP55uUYJ5eoB/U57bx7rjthwcujmbHTMD5MLpCnmZGsavOkDSyz3rDESD
 8=
X-Received: by 2002:a05:620a:d82:b0:76f:1d96:4eb5 with SMTP id
 q2-20020a05620a0d8200b0076f1d964eb5mr18075249qkl.36.1698276472812; 
 Wed, 25 Oct 2023 16:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGftSWB4m2g7YJNqVfqNPhPNvEsoILCXm7qaLR6E+8fJU/hEEJml7jmnGNRmKWv+yYp3y2wVQ==
X-Received: by 2002:a05:620a:d82:b0:76f:1d96:4eb5 with SMTP id
 q2-20020a05620a0d8200b0076f1d964eb5mr18075235qkl.36.1698276472475; 
 Wed, 25 Oct 2023 16:27:52 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 cx22-20020a05620a51d600b007788bb0ab8esm4553236qkb.19.2023.10.25.16.27.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/24] kvm: i386: move KVM_CAP_IRQ_ROUTING detection to
 kvm_arch_required_capabilities
Date: Thu, 26 Oct 2023 01:27:10 +0200
Message-ID: <20231025232718.89428-18-pbonzini@redhat.com>
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

Simple code cleanup.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fb6655254fc..94b2516c29f 100644
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


