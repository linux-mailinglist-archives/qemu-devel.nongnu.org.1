Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D467B9D18
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:55:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNsY-0005UO-04; Thu, 05 Oct 2023 08:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNsL-0005Mv-M6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNsJ-00065B-GH
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=busP+bVpSl/RstJK/8SVRYqvgUwuC4Qnz0JrNaFQ5Kw=;
 b=Be6igvb5OulMjZmZnF6iftrzlnuPVixcIvOJCDzn6Nv0abnwiah097VeszoUzXA9Ta8q5x
 SzL14g9zP42gGAzl01tRSXlQ33ahEaUtoGHsSiFbuHSG6HyFd9ylBNTcXmF1L8ns4RNILE
 eQzbKzDgc2imXG3yYL8I4l1hGvytLtw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-AWAqublEPHyzt-E_CyIzVg-1; Thu, 05 Oct 2023 08:54:31 -0400
X-MC-Unique: AWAqublEPHyzt-E_CyIzVg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-52310058f1eso2493439a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510469; x=1697115269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=busP+bVpSl/RstJK/8SVRYqvgUwuC4Qnz0JrNaFQ5Kw=;
 b=HD/PH/G3+HdB+x7WSyxsD0oxZMWrl/4It2+O4F/IW137Y2OpZPXouHRRHwFTTXml8Q
 fh0Ucse2qOKqTaeazjwayz5T5esQT1RJmgt/yEi7l2UyhUxsLdmMB5ZWeV1qCkpGC12h
 ZetCM3l7ZL9+1IsTEzlhggttZ66/GpnFC23rZweheb5CZ+jsIiR6p+3h+D2qK7GWmsyC
 yhp7uvX6JGKu3hiRuyrVxHes7Ont7hOicpDW5ZWkEkmZbvUSuop+H9r5gVsdAaiwf07x
 oL3BRUrr6ZYSliaL6YkaRz6N2Fx/5FFlYfcJndpwDv9ZGF+UlskuoR0sPNVw3M11HAGO
 2SxQ==
X-Gm-Message-State: AOJu0YwsvGQavgpF58UOyLJ9grU9eq3TlnvlZQd6O77buEg56DUTUYvy
 PbsqgGP1lXRKU3hLCOgYHwJlKsVhzxQfEU1HHbu0yOEv0PJfzdJK/Fp7pFcYKgD8Hz1aqwdreVz
 NMOtZFEslQTIb2MTqovQxmnId7i0xT8B4okCPrPMMHl7M3KuQ93nTZ7ixMhs2lAhohhTRLTZIrq
 c=
X-Received: by 2002:a17:907:1c1e:b0:9a5:7dec:fab9 with SMTP id
 nc30-20020a1709071c1e00b009a57decfab9mr1249936ejc.9.1696510469456; 
 Thu, 05 Oct 2023 05:54:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1M5sWj/bBSXZFgwhF2riOgO27zFylbaP9qeptJhYbS44auT70M8Euaiix9Hd1kAZP02KJaA==
X-Received: by 2002:a17:907:1c1e:b0:9a5:7dec:fab9 with SMTP id
 nc30-20020a1709071c1e00b009a57decfab9mr1249917ejc.9.1696510469031; 
 Thu, 05 Oct 2023 05:54:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 jp20-20020a170906f75400b009a1c05bd672sm1131174ejb.127.2023.10.05.05.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:54:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] configure: change $softmmu to $system
Date: Thu,  5 Oct 2023 14:54:05 +0200
Message-ID: <20231005125427.65625-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"softmmu" is a deprecated moniker, do the easy change matching
the variable to the command line option.

Based-on: <20231004090629.37473-1-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index e08127045d0..97a5e8de491 100755
--- a/configure
+++ b/configure
@@ -252,7 +252,7 @@ docs="auto"
 EXESUF=""
 prefix="/usr/local"
 qemu_suffix="qemu"
-softmmu="yes"
+system="yes"
 linux_user=""
 bsd_user=""
 plugins="$default_feature"
@@ -740,9 +740,9 @@ for opt do
   ;;
   --enable-tcg) tcg="enabled"
   ;;
-  --disable-system) softmmu="no"
+  --disable-system) system="no"
   ;;
-  --enable-system) softmmu="yes"
+  --enable-system) system="yes"
   ;;
   --disable-user)
       linux_user="no" ;
@@ -864,7 +864,7 @@ else
         error_exit "user mode emulation not supported on this architecture"
     fi
 fi
-if [ "$softmmu" = "yes" ]; then
+if [ "$system" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/configs/targets/*-softmmu.mak"
 fi
 
@@ -1756,7 +1756,7 @@ for target in $target_list; do
 
   case $target in
     xtensa*-linux-user)
-      # the toolchain is not complete with headers, only build softmmu tests
+      # the toolchain is not complete with headers, only build system tests
       continue
       ;;
     *-softmmu)
-- 
2.41.0


