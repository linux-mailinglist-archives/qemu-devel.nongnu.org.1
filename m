Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C872461A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xic-00052b-HB; Tue, 06 Jun 2023 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XiY-000513-Gt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XiW-0001DD-Rd
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHfLiXVp97JLQcvOUWVEcSgCuNPPISjI6L4XOmlDQjQ=;
 b=Zn8rqmNjcZ3ELOys+vfm5oFgt6RY+9y36oKr6f+yB/sY36IsGE5URJleepL2X0tjUGm4oH
 w/8I+FyA0O8kPxiSoauDf1mLlOhAX/Bcv6kJHKE2APSYn3ecH3q9tvxhJQQUOmmSgiYXjq
 mM8IEd5dMltCS+NQHplXrEzS4GUUhRQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-QtndTbh8PpG5SZHeY6K56g-1; Tue, 06 Jun 2023 10:31:21 -0400
X-MC-Unique: QtndTbh8PpG5SZHeY6K56g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so453561466b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061879; x=1688653879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHfLiXVp97JLQcvOUWVEcSgCuNPPISjI6L4XOmlDQjQ=;
 b=HSKn5IgF83iHKfWo6uDRHvUAYH63iu85tmCWf3lbD0i03bWarxfM3blNL5IThy97GK
 tFYMKLk6/2vF3vT75DFZFhhQaq2aWE94wJ9+fjxWX6KlC+Z2mH59NNKbT26PkH3TpB+o
 Bx3awV9zpCPJlO+4DC9HB8CCUIrqrW4XkbmdHZy1wne7N5BMRW8JXkAs7P1LgHz/Bafl
 Me+2KtzLuV2wpGKTNRh1cpEwlH4j8xgNWEEixpFui7C52jyGtdVXAwj89/wASNiYTmOl
 jwmoIUct3FOkT5gWuGTG/CF3Pw+m1YKkk26uN1rHEGskr8zSQ9ERr9jDUSMmv4Ugvzr0
 NlYg==
X-Gm-Message-State: AC+VfDwHwOCCkT1FNX+EwCkZu+kAZ+fE0UUl228uUrDx1P2i6PmfinWJ
 Suo1/fkEKpEnYLNovZn3v8qWddzMUpfJ889dx25BdhNH7yZYg8k+JI0iqvI9McuGgTaYfg3pnQS
 c5MQ22HKUR2ad19qzZSFEKNWD8Dm8iAV766iza5vxPbqRHemgZ5Zk6CLzNp8Oq6E2vCOJRBZvHY
 w=
X-Received: by 2002:a17:907:6ea1:b0:94f:73db:b390 with SMTP id
 sh33-20020a1709076ea100b0094f73dbb390mr2863289ejc.65.1686061879477; 
 Tue, 06 Jun 2023 07:31:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Rh7l037PNkCSqDaQORqaRs6Xg4pPbnDDcfBm1YcG3nXbRoXNAWT904BFAzDVl2O1DUQo1QA==
X-Received: by 2002:a17:907:6ea1:b0:94f:73db:b390 with SMTP id
 sh33-20020a1709076ea100b0094f73dbb390mr2863252ejc.65.1686061878983; 
 Tue, 06 Jun 2023 07:31:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a17090611d000b00974630b1e85sm5517967eja.155.2023.06.06.07.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
Subject: [PULL 01/21] meson: Avoid implicit declaration of absent functions
Date: Tue,  6 Jun 2023 16:30:56 +0200
Message-Id: <20230606143116.685644-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
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

From: Michal Privoznik <mprivozn@redhat.com>

While detecting a presence of a function via 'cc.links()'
gives desired result (i.e. detects whether function is present),
it also produces a warning on systems where the function is not
present (into meson-log.txt), e.g.:

  qemu.git/build/meson-private/tmph74x3p38/testfile.c:2:34: \
  warning: implicit declaration of function 'malloc_trim' [-Wimplicit-function-declaration]

And some distributions (e.g. Gentoo) parse the meson log and
consider these erroneous because it can lead to feature
misdetection (see [1]).

We can check whether given function exists via
'cc.has_function()' or whether STATX_* macros exist via
'cc.has_header_symbol()'.

1: https://wiki.gentoo.org/wiki/Modern_C_porting
Resolves: https://bugs.gentoo.org/898810
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Message-Id: <8e02776d18595a1c575c90a189ff65f1785f76ca.1685442612.git.mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index a61d3e9b06a..969a84f2a44 100644
--- a/meson.build
+++ b/meson.build
@@ -1797,8 +1797,7 @@ malloc = []
 if get_option('malloc') == 'system'
   has_malloc_trim = \
     get_option('malloc_trim').allowed() and \
-    cc.links('''#include <malloc.h>
-                int main(void) { malloc_trim(0); return 0; }''')
+    cc.has_function('malloc_trim', prefix: '#include <malloc.h>')
 else
   has_malloc_trim = false
   malloc = cc.find_library(get_option('malloc'), required: true)
@@ -1811,34 +1810,19 @@ if not has_malloc_trim and get_option('malloc_trim').enabled()
   endif
 endif
 
-# Check whether the glibc provides statx()
-
 gnu_source_prefix = '''
   #ifndef _GNU_SOURCE
   #define _GNU_SOURCE
   #endif
 '''
-statx_test = gnu_source_prefix + '''
-  #include <sys/stat.h>
-  int main(void) {
-    struct statx statxbuf;
-    statx(0, "", 0, STATX_BASIC_STATS, &statxbuf);
-    return 0;
-  }'''
 
-has_statx = cc.links(statx_test)
+# Check whether the glibc provides STATX_BASIC_STATS
+
+has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_source_prefix)
 
 # Check whether statx() provides mount ID information
 
-statx_mnt_id_test = gnu_source_prefix + '''
-  #include <sys/stat.h>
-  int main(void) {
-    struct statx statxbuf;
-    statx(0, "", 0, STATX_BASIC_STATS | STATX_MNT_ID, &statxbuf);
-    return statxbuf.stx_mnt_id;
-  }'''
-
-has_statx_mnt_id = cc.links(statx_mnt_id_test)
+has_statx_mnt_id = cc.has_header_symbol('sys/stat.h', 'STATX_MNT_ID', prefix: gnu_source_prefix)
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
   .require(targetos == 'linux',
-- 
2.40.1


