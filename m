Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B8706FD8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:46:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDz-0007KQ-CF; Wed, 17 May 2023 13:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDq-0007IZ-50
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDo-000492-Cz
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vk6JmC+5kO9bSQsl5rzJJ9aOVpIU11LB+iaULrCQgFM=;
 b=VRHcHQ/kD+pSwlpAz7cwdMH0KsJnHQj8ws7e245ImJiOq5yKIm6l4FIzhtdBxu5Md4h8jS
 GZe0fkkUrJ6MqxryCEEXTK6r7vQQY8S/oS644e8BwAZ48YCd2zj0GmgUXEc1WIHExlvRw0
 5oLPx+nCzvDlxfhPc1Y0r3byIoDN4bE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Ql5AxV9wNVaUdQ4jOMTD7g-1; Wed, 17 May 2023 13:45:53 -0400
X-MC-Unique: Ql5AxV9wNVaUdQ4jOMTD7g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42ceb4a4fso4344765e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345551; x=1686937551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vk6JmC+5kO9bSQsl5rzJJ9aOVpIU11LB+iaULrCQgFM=;
 b=fHAb1CrPHa0sym2pUqHsYF16c0SF13t59Hi/SnEQJxupm/I8A0SwemOYRK6sEuWBeg
 N82chXAdEaxTXkQmu9qKpWDym+kW3PeZ3Gl9qJlgDRSF7QAylb29DyVSrw6hnyVz43/a
 DITs8lxT1sQ4LBU5ovMP3/thum3rYJvaKwICr+m/DNBTeRpxWfl76TZVjdbzL/hjwayb
 /6kt5CqSvLHchytvGbBhQfNbwNz9GZ1TT3ah0z8FEJe4oMyWp+0EPSqnY5ot88FjEUSe
 BH4EzqXTYoDiGRk2BlOLT4rrQk4nqO/Sy+z2OcAqRmdyokCn1V1WBbMJm93g5n195zSv
 iZ0w==
X-Gm-Message-State: AC+VfDyXyRFvRp9T9jxZLRCF4Z/AbdmR4K2Pev/4wyb55rxpTQ15dN4f
 m7W6ktiMWxDAR82IDOBkxmRNec6jy6cs1kL3nYesaWmq2K0uyYfMBOsmsRFARS2WQX/eDZ2orzL
 gSYCoLZqrMFjvn/QkrV0hNTj2SBgs1w5uLcyyjHNBUjvqjQpWtmbyEAvg+5RSIvwzczdRZJGInO
 o=
X-Received: by 2002:a05:600c:2149:b0:3f5:1240:ace4 with SMTP id
 v9-20020a05600c214900b003f51240ace4mr5172354wml.25.1684345551533; 
 Wed, 17 May 2023 10:45:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55kTWOozPNAM7sEeUrUl+nKpMfAd4GWdPKoMpEuWGrD0kaY55VfoKhhIHE3xdBWEnwVlUCDQ==
X-Received: by 2002:a05:600c:2149:b0:3f5:1240:ace4 with SMTP id
 v9-20020a05600c214900b003f51240ace4mr5172339wml.25.1684345551222; 
 Wed, 17 May 2023 10:45:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a1cf712000000b003edc4788fa0sm2958218wmh.2.2023.05.17.10.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 17/68] make: clean after distclean deletes source files
Date: Wed, 17 May 2023 19:44:29 +0200
Message-Id: <20230517174520.887405-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Run 'make distclean' in a tree, and GNUmakefile is removed.
But, GNUmakefile is where we change directory to build.
Run 'make distclean' or 'make clean' again, and Makefile applies
the clean actions, such as this one, at the top level of the tree.
For example, it removes the .d source files in 'meson/test cases/d/*/*.d'.

    find . \( -name '*.so' -o -name '*.dll' -o \
          -name '*.[oda]' -o -name '*.gcno' \) -type f \
        ! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
        ! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
        -exec rm {} +

To fix, remove clean and distclean from UNCHECKED_GOALS, so those targets
are "checked", meaning that configure must be run before make.  However,
the check action does not trigger, because clean does not depend on
config-host.mak, so change the action to simply throw an error.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Message-Id: <1681909700-94095-1-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index e421f8a1f4f7..3c7d67142f13 100644
--- a/Makefile
+++ b/Makefile
@@ -26,7 +26,7 @@ quiet-command-run = $(if $(V),,$(if $2,printf "  %-7s %s\n" $2 $3 && ))$1
 quiet-@ = $(if $(V),,@)
 quiet-command = $(quiet-@)$(call quiet-command-run,$1,$2,$3)
 
-UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
+UNCHECKED_GOALS := TAGS gtags cscope ctags dist \
     help check-help print-% \
     docker docker-% vm-help vm-test vm-build-%
 
@@ -176,10 +176,8 @@ plugins:
 endif # $(CONFIG_PLUGIN)
 
 else # config-host.mak does not exist
-config-host.mak:
 ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
-	@echo "Please call configure before running make!"
-	@exit 1
+$(error Please call configure before running make)
 endif
 endif # config-host.mak does not exist
 
-- 
2.40.1


