Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B9377555F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:31:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTeZp-0001bf-3T; Wed, 09 Aug 2023 04:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTeZm-0001bS-HZ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTeZk-0000gN-Vu
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691569792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RkBVuS+6agitdw186DJC/AMPSh4wQnuDJvm2qT0ChKk=;
 b=eY9n6jZGzM9RhT4s4qKGaQBn5LFb7Mli+QPNny/AkQlpFN5WHsQ/N5yJFZmp2NzGkldMx9
 OE6bQrI0NB7hdEy/W8vehoEArytgc5XXI+8i5dBSkWAfJagwwLgDkKGjiPFzIa2X0oXPNi
 uxat5X8F8IsVyNcmiYmsYxBPBQEBPy4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-Prx8rABFOVWF4v89u8tQyw-1; Wed, 09 Aug 2023 04:29:50 -0400
X-MC-Unique: Prx8rABFOVWF4v89u8tQyw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so3765850f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 01:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691569789; x=1692174589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RkBVuS+6agitdw186DJC/AMPSh4wQnuDJvm2qT0ChKk=;
 b=SFuRzLSq+lkbNRary6da7JzxJ+SqUhY+eBLkj7lF9OFFekXBqTDo9h7hsjM7K8Lfh/
 pXB6tFWpw7rTYqSZLvYg9nBAL9AGUGWCMvRey4auwnUUcobZl0ptCmrqINnE2S/yRHce
 FnkX1Ru2GTHeBoGIU2HVSVPmACglnXAlDkXfUQtSW/dro9TMnAmqEI7jHgMVAaJNJ9Db
 OI/O6bE/IPEycfU9E15vVpkcekv5NRnDbgtgs4hore1OHneELgNOJgnjnmYALGNSDeFj
 BX10mo7CO4JFKDj/EdxEALlfZ7CkWji74JAWSLioFR6iUwLNfxNoFyhmeaRuLA/1GqcZ
 TGSg==
X-Gm-Message-State: AOJu0Yxyz139UzQvZ0WFsBCpX2PpyZt7Wv0TdDbH8m0jddhncyT3KzQU
 RMqxYP+87hf807z+5oioIRVOOcdXqQFgCWWK93lUPJSmraYevwdu2iHySr0QWWcdhp/swgisXly
 FLKQuTXR265RiRpgsAuYPd2aHqciCAN+XG2KjeIXIpPWxoR9y/D7/9RvMWpkWRiaQCzeoSXW5Id
 c=
X-Received: by 2002:a5d:5303:0:b0:317:eee2:6fba with SMTP id
 e3-20020a5d5303000000b00317eee26fbamr1230371wrv.40.1691569789004; 
 Wed, 09 Aug 2023 01:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwo6iW22UMPa4NiOZiqrvLuPFZI8YCQzQ/obImICFJDH3EKXExE0bsO92jnkj1gshidl8ajg==
X-Received: by 2002:a5d:5303:0:b0:317:eee2:6fba with SMTP id
 e3-20020a5d5303000000b00317eee26fbamr1230357wrv.40.1691569788558; 
 Wed, 09 Aug 2023 01:29:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m15-20020adfe0cf000000b00313de682eb3sm15963792wri.65.2023.08.09.01.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 01:29:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	alex.bennee@linaro.org
Subject: [PATCH for-8.2] configure: fix and complete detection of tricore tools
Date: Wed,  9 Aug 2023 10:29:44 +0200
Message-ID: <20230809082946.747668-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

The tricore tools are not detected when they are installed in
the host system, only if they are taken from an external
container.  For this reason the build-tricore-softmmu job
was not running the TCG tests.

In addition the container provides all tools, not just as/ld/gcc,
so there is no need to special case tricore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/configure b/configure
index 133f4e32351..f2bd8858d6c 100755
--- a/configure
+++ b/configure
@@ -1271,6 +1271,7 @@ fi
 : ${cross_prefix_sh4="sh4-linux-gnu-"}
 : ${cross_prefix_sparc64="sparc64-linux-gnu-"}
 : ${cross_prefix_sparc="$cross_prefix_sparc64"}
+: ${cross_prefix_tricore="tricore-"}
 : ${cross_prefix_x86_64="x86_64-linux-gnu-"}
 
 : ${cross_cc_aarch64_be="$cross_cc_aarch64"}
@@ -1458,10 +1459,6 @@ probe_target_compiler() {
       tricore)
         container_image=debian-tricore-cross
         container_cross_prefix=tricore-
-        container_cross_as=tricore-as
-        container_cross_ld=tricore-ld
-        container_cross_cc=tricore-gcc
-        break
         ;;
       x86_64)
         container_image=debian-amd64-cross
-- 
2.41.0


