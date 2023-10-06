Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED77BB635
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:17:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinU-0008VY-3r; Fri, 06 Oct 2023 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinO-0008Pn-Bt
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinM-0000NY-Sx
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqzFG0nl98wuMsJDYYI6DGaasQUrXUt/A59VW574SOI=;
 b=PodaIioQdKn0hlkJBC4k31nCuY1belsP3HAKC7emzBOfCcueT8PL4wBIm41y5AfHg4PqVU
 Ix4ql/2Q+/VL9cUcXVcWBQnFHEAS5CBUM13edNQSVpcqwOMz38vJmByrEPF1oR+tM0FLB/
 ZRu381KDDQ+2YJhnOhUrpVRwXcHLVqo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-uLBrAO__MpGmMFX49rbTnQ-1; Fri, 06 Oct 2023 07:14:48 -0400
X-MC-Unique: uLBrAO__MpGmMFX49rbTnQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-536294c9526so1706888a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590887; x=1697195687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqzFG0nl98wuMsJDYYI6DGaasQUrXUt/A59VW574SOI=;
 b=n2VGd73FmPNZsCB6U/6X5PnFY2YGGF0UHzOWvTOPUczJqMBU6ePiIifif5VvouIm6d
 vwMHpo9mO79wN3ot5eGfu9puN4UjKzrWj+dfjHHFyhZxvuXMh/r4uyIp2aVXqZKetfqM
 3+B9q8wrxZnUTnnI0e1eobzJc0vCJG3Jqm0SfqxeRy4rLHh5sde61e+VMIK9ktDoAk/i
 yoU1DYda0XXuqEVCavRBMJw1FnWSLq13wY+BMneWlu44glIh5FWLd/YNZUKO+GlUKAtd
 HuOhmWyhIKlverLXePuC8uq4ZxLcz6ra2VBcnmSLgdcDv60jO91Q9wBanvjVMlzTa45m
 FVOw==
X-Gm-Message-State: AOJu0YxEPi/8ZyHh0+wSlX/AAR0jS2rjPG3osyOn3fhNhLTNJKaK/QuN
 Lbmkn7CZQSoWnAiqjZx/LOAtI4gg9l2yYCAQbiGGsXfaOabhK+9uP7nr9tntxpZsXGXiOODH/Zx
 J3X7igqrVs6FVrRe0nO/bUyAygm+wd0K2B7yGe2ujg06XarhE8DeagxluWdzgHc4Q+47rbJEm3y
 8=
X-Received: by 2002:aa7:c998:0:b0:527:ab3f:4350 with SMTP id
 c24-20020aa7c998000000b00527ab3f4350mr6535778edt.38.1696590887232; 
 Fri, 06 Oct 2023 04:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4V4/JiV3tuC7HIgmPKsNuWtdMVV1QCaUvZGlOwHhJ4xRYSf91iZP0ySNjdHiHa3ue3uIfKA==
X-Received: by 2002:aa7:c998:0:b0:527:ab3f:4350 with SMTP id
 c24-20020aa7c998000000b00527ab3f4350mr6535761edt.38.1696590886875; 
 Fri, 06 Oct 2023 04:14:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 g11-20020aa7d1cb000000b0052c9f1d3cfasm2420893edp.84.2023.10.06.04.14.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/26] configure: change $softmmu to $system
Date: Fri,  6 Oct 2023 13:14:04 +0200
Message-ID: <20231006111412.13130-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
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


