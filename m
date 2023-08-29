Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B416878C041
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau6u-0002p4-QA; Tue, 29 Aug 2023 04:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6e-0002dM-UD
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6Y-0008Ql-Kc
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AouVmZmtK7J+Cy4ZSfvQOHcTgPdMRLqJWR/mWaTU8Rg=;
 b=P+XXhJMRr52S/YYa+bXj/0r8ZFda0NZP0E4FktpMJPhTKgsNfcRhLOuCC8R8/J8zpUHHqe
 hGv+qCI+B+7uw+gvlccqhqD8C7PVkKXz0G6oe+gPWMgf531L1/2f4eCh+IHgpOSZKNFvj4
 OdeybWWXkCwLjw5CjCpsFARFgFpvvtY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-e7QLVZ6oNiy5dpLUBJcY4g-1; Tue, 29 Aug 2023 04:29:40 -0400
X-MC-Unique: e7QLVZ6oNiy5dpLUBJcY4g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-317a84a3ebeso2541008f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297778; x=1693902578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AouVmZmtK7J+Cy4ZSfvQOHcTgPdMRLqJWR/mWaTU8Rg=;
 b=Mq+JpEFEHEp7MmOneeGDiqpNKgLtCK2pTkjBSf7IoYhZPrloYc8J/XoeOlvaLUnyBT
 yTjcuUwFwbHCvRPKmnOXvGSb44q+MPwcWjaDekKklrAVzuKSZLEd98Zqihq7UvMAis8h
 ZKywixailszGU4aHFxC/ASEhItEtqYt/e3KazCwEm7o6nnMQ153cs9hhX+KoiVSI50RD
 ZSuWA47FJ3xl4QCyVB/RPto28ApzOpweBZkPKFr+o/bCMdliQWATBuQoYxu8gGWx80Bl
 NiHi6ocgV2Pfi8EBiXwQf74orgFDbZ452UNU4a8JANXOnXb07ThcDgTbbMeqI+1+kp2Y
 fafA==
X-Gm-Message-State: AOJu0Yz6/WNe8SvEwEsobrU4M5uZED3j8VxCUoXR0gbHZVbuFgz6VNDW
 j4uIV7Sl/t/6sSI4gT18s2kSP4eWtwj4jtHQ2fgTYqoMx34bjURusbRjgpSC8OSLHfzmMh0L1Ka
 Vgitb5/gNVW19/+Dw87dqi/DkQyHyxz5kupYuRq76cso6s67QxXW1pBO0xUz9kQucMV5LZkb+6S
 Q=
X-Received: by 2002:a5d:4cc6:0:b0:319:6997:9432 with SMTP id
 c6-20020a5d4cc6000000b0031969979432mr1412006wrt.1.1693297778510; 
 Tue, 29 Aug 2023 01:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRg82WdyXJn9SUVz0dnj3FdWUJiY4x5v3/7/xrVoBZQj4Yej1uZxIR52B4tMWl5dqC/fWrYQ==
X-Received: by 2002:a5d:4cc6:0:b0:319:6997:9432 with SMTP id
 c6-20020a5d4cc6000000b0031969979432mr1411994wrt.1.1693297778215; 
 Tue, 29 Aug 2023 01:29:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a5d46cf000000b0031762e89f94sm12900858wrs.117.2023.08.29.01.29.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/10] configure: remove HOST_CC
Date: Tue, 29 Aug 2023 10:29:24 +0200
Message-ID: <20230829082931.67601-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829082931.67601-1-pbonzini@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
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

$(HOST_CC) is only used to invoke the preprocessor, and $(CC) can be
used instead now that there is a Tricore C compiler.  Remove the variable
from config-host.mak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                 | 1 -
 tests/tcg/tricore/Makefile.softmmu-target | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure b/configure
index b9bd008592a..3423f008d5c 100755
--- a/configure
+++ b/configure
@@ -1794,7 +1794,6 @@ fi
 mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
-echo "HOST_CC=$host_cc" >> $config_host_mak
 
 # versioned checked in the main config_host.mak above
 if test -n "$gdb_bin"; then
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index aff7c1b5802..2ec0bd36225 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -28,7 +28,7 @@ TESTS += test_context_save_areas.c.tst
 QEMU_OPTS += -M tricore_testboard -cpu tc27x -nographic -kernel
 
 %.pS: $(ASM_TESTS_PATH)/%.S
-	$(HOST_CC) -E -o $@ $<
+	$(CC) -E -o $@ $<
 
 %.o: %.pS
 	$(AS) $(ASFLAGS) -o $@ $<
-- 
2.41.0


