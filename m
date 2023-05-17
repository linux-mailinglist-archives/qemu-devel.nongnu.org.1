Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA9706FF8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDZ-0006zl-UF; Wed, 17 May 2023 13:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDV-0006sy-FO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDT-00040o-RD
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3Rv+ESo7WNW5A9ZevmKZ3JyG2kyStdtRscAL+/MXEo=;
 b=ePbc/7o5uPdJwdiaufTVH4hKF3CG//kzJylA9onq5sj6ZR/1/xzXuFcoKwkSiyUqW2F00X
 2i2GJzrNxt7RvI5nM8DEVkG4v7eKJ3JYqqTLgJE6h8LUF0F6/QAK8JWyiu0r+6GxID8/qu
 7lP/IwdL2AUHSy9yt5AYZzRHcpmWRGg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ztM8WjMzP2KFx3fIHdvmbg-1; Wed, 17 May 2023 13:45:33 -0400
X-MC-Unique: ztM8WjMzP2KFx3fIHdvmbg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3063287f1c9so490262f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345531; x=1686937531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s3Rv+ESo7WNW5A9ZevmKZ3JyG2kyStdtRscAL+/MXEo=;
 b=JFMLjJWWKMBvfAtUQEvum3avg/Mm/Wd+EmFG3Q44Q81IcOjZGPjrbGAZ5hqDik871g
 QaVXznLMbtlHtHUJTIQpHeD72JQIK5UftG/4IgbcXfdA+NGvMu3HOY1lL+7VhR6XY7ea
 /oxv62CowoDmj+svgOGmdTB+JuaonGKB7UA6HiuW/cMj525VXDjT/RAJMfl773fvRt9y
 pRzBpE5j7O4Ht5+Oi1K/kmV9a8eV85fURvwCG5N4M6BwcvPu+lWPrmLnDamG7JjwXs2c
 irKtYvsgxUgj3BqjYqMNhcMAAZCWJYi2Y8AZyLh1v1s8CbGhEn8dt+CpaxCmStVp12NV
 Kxzw==
X-Gm-Message-State: AC+VfDwCR3xI0aPWqqX3eSJaHLNGukLHYOluRO5OsxMmhY32xCuj5jC8
 ReGbwfeYng9KvdvxrSh7Z0oQYOfDfvDmCItMP2mwjt0eZtfyMcKuR+fihnYY77eLM7zHFknnFDx
 YYDh8r4n3ml03mzjHYlQFmFq2iXXtDJVdWIF0fcrzIhOMpYTEVtae7ZM034UhW2ERsij6tU//MX
 w=
X-Received: by 2002:a5d:6b4c:0:b0:306:339b:684 with SMTP id
 x12-20020a5d6b4c000000b00306339b0684mr1178716wrw.65.1684345531681; 
 Wed, 17 May 2023 10:45:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6atJmOk4XTZFh9HYGm14KZMk8YC0NzuLD7kknNU6lBi80SiTvKQbci6Rtloi9hbSN68USyiw==
X-Received: by 2002:a5d:6b4c:0:b0:306:339b:684 with SMTP id
 x12-20020a5d6b4c000000b00306339b0684mr1178704wrw.65.1684345531335; 
 Wed, 17 May 2023 10:45:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a7bce10000000b003f427687ba7sm2920254wmc.41.2023.05.17.10.45.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/68] tests/tcg/i386: correct mask for VPERM2F128/VPERM2I128
Date: Wed, 17 May 2023 19:44:17 +0200
Message-Id: <20230517174520.887405-6-pbonzini@redhat.com>
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

The instructions also use bits 3 and 7 of their 8-byte immediate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/test-avx.py b/tests/tcg/i386/test-avx.py
index d9ca00a49e6c..641a2ef69ebc 100755
--- a/tests/tcg/i386/test-avx.py
+++ b/tests/tcg/i386/test-avx.py
@@ -49,7 +49,7 @@
     'VEXTRACT[FI]128': 0x01,
     'VINSERT[FI]128': 0x01,
     'VPBLENDD': 0xff,
-    'VPERM2[FI]128': 0x33,
+    'VPERM2[FI]128': 0xbb,
     'VPERMPD': 0xff,
     'VPERMQ': 0xff,
     'VPERMILPS': 0xff,
-- 
2.40.1


