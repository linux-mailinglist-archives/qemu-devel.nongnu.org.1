Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3373712A45
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzt-0004Jn-CM; Fri, 26 May 2023 12:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzr-0004JZ-1k
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzd-0002e7-S5
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOMsYPI48p6M+QNMAUBxDQ/hy4HQGwgc/IU9K0zz3UU=;
 b=WBkw1gbQV92Fz5Zkjs2+YvTxYLVz3dmLwuohO16BXuiA91Q6OSz95WfqzDxs5nZzjR4Hbx
 FWyCqMSiomyqy878HAadHW66MbJmfKtRf7sfp/zwsHdsJi3LUbjTkfAHj4IrhUbSDbMR4E
 etJHdmuGnyRRh7WGse36hQb6qqusvr0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-Dve02pWrMBWrUDTSayVDkg-1; Fri, 26 May 2023 12:08:37 -0400
X-MC-Unique: Dve02pWrMBWrUDTSayVDkg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-513f337d478so816683a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117316; x=1687709316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOMsYPI48p6M+QNMAUBxDQ/hy4HQGwgc/IU9K0zz3UU=;
 b=DZqhPLK141YeBcuAKMyEqnGBPIQVmTX7UGxnGSBN9YA+2MoBRYPV62clIevxeAr0ZX
 cW3udbQ6M+qy7sQi98VNRGYjykcd/GScpfaBTHCxpmtnmBzqjpYPPdShdstHDwsL+BDt
 D3FDjIU/3/oFW6E39olX5r6chJD2SqPWzgrX1vgRUvBIYB31KWsIzFbtxgSk0l2Ujs2H
 hXMC5Fl49PkNWn5jl+KKRm3LJeCbFozdfLZdNrA4VQgCXyLaUe+Ta23jTJheXG0Lp/+t
 hhAfRhbN5rm7o1snXrcDjNFKNr18++8tTkdsmuPL4C2zruhhGXanqxSAjudvhbYaT7Lo
 uY5A==
X-Gm-Message-State: AC+VfDynNgcjH94vZHiCbwufyhQJmvnZ+2Q/DEtL7DTfmmd8RJZ/ibXH
 dUujljsNbiubNO96WTTwgMZ3A6Ksacry56Oefll3VUuZF4Z/fmbzBQHlu2HJRqCqksbhUA5THmT
 AxdR/I+a5clANmEakt86sNIX2cuPPxpVDYUtq2F0TTa0snX/37Y+pIYSTN3XjD+DaDt1iPlXnlz
 o=
X-Received: by 2002:a17:907:3f83:b0:970:c9f:2db6 with SMTP id
 hr3-20020a1709073f8300b009700c9f2db6mr2601220ejc.63.1685117316425; 
 Fri, 26 May 2023 09:08:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TVEbAaY8TKEl0Mvx3EfDJ0myzPgC8xsEKJyNtlwdiqTqLBajpODNi9R3QEZPT865fsEYixg==
X-Received: by 2002:a17:907:3f83:b0:970:c9f:2db6 with SMTP id
 hr3-20020a1709073f8300b009700c9f2db6mr2601195ejc.63.1685117316088; 
 Fri, 26 May 2023 09:08:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 ce23-20020a170906b25700b0096f8bb60c96sm2330411ejb.100.2023.05.26.09.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Subject: [PULL 06/12] meson: Add static glib dependency for initrd-stress.img
Date: Fri, 26 May 2023 18:08:18 +0200
Message-Id: <20230526160824.655279-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
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

From: Fabiano Rosas <farosas@suse.de>

We recently moved glib detection code to meson but this changes the
linker command line from -lglib-2.0 to using a path to libglib-2.0.so.
This does not work for static linking, which is used by stress.c:

 $ make V=1 tests/migration/initrd-stress.img
 cc -m64 -mcx16 -o tests/migration/stress ... -static -Wl,--start-group
 /usr/lib64/libglib-2.0.so -Wl,--end-group
 ...
 bin/ld: attempted static link of dynamic object `/usr/lib64/libglib-2.0.so'

Add a specific dependency for stress.c, which is linked statically.
The compiler command line is now:

 cc -m64 -mcx16 -o tests/migration/stress ... -static -pthread
 -Wl,--start-group -lm /usr/lib64/libpcre.a -lglib-2.0 -Wl,--end-group

Fixes: fc9a809e0d ("build: move glib detection and workarounds to meson")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <20230525212044.30222-3-farosas@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/migration/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/migration/meson.build b/tests/migration/meson.build
index dd562355a16e..ac71f1329014 100644
--- a/tests/migration/meson.build
+++ b/tests/migration/meson.build
@@ -1,9 +1,11 @@
 sysprof = dependency('sysprof-capture-4', required: false)
+glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
+                         method: 'pkg-config', static: true)
 
 stress = executable(
   'stress',
   files('stress.c'),
-  dependencies: [glib, sysprof],
+  dependencies: [glib_static, sysprof],
   link_args: ['-static'],
   build_by_default: false,
 )
-- 
2.40.1


