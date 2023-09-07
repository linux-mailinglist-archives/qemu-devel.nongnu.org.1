Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D37D7972AC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdR-0003On-KP; Thu, 07 Sep 2023 09:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdE-00031b-G4
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd9-0007M2-If
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTC08l5E2LHxzBEzXg14rY8tH1ESV2HYzTzj23bXChc=;
 b=KFx2qR+JEXbgqtvSNpZGKt283iX5CllZnEoPVVnvwsTDuDm/N8DW6JWynnOmucBV10VZL4
 je1CW4W/u1OUssVvsjfiX5DvhLu2JwV3uQupeZiGC9m81Dg027DWEYUgFmdTcT3GRAr0px
 j1i/FCCgGj6yn71rXAgGmauTTvA7d50=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-QcLKb9HVPp-A9PHU9FokkQ-1; Thu, 07 Sep 2023 09:01:04 -0400
X-MC-Unique: QcLKb9HVPp-A9PHU9FokkQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401d8873904so7455145e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091660; x=1694696460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTC08l5E2LHxzBEzXg14rY8tH1ESV2HYzTzj23bXChc=;
 b=aSqhvLzMnA18CMXUlMac4tuqbyC7x4BWN5LW/ldNZCsEAp6tQ89lPoHUkOa7ATozP7
 zZq7Dsdqme0+Eh6ydToMN0/ds9nd3WFTNE6DkRBZqcYJXy0FKaRhjlNwlpVRVlSa3SCE
 3FuL8clSPpW5U/rZ3/DRVMdJ8WiO72RuSaul59n4mQ/iMDTgfI4JPeaxT2md7ku+aZyC
 Rgs+/qQNjDbK0QuZPdmci28GUIRe8jeKLSrneq3a4lbBd2yv/mPRpTDWDM9fYUDzVzqB
 amy9qEODAHPyRL5xcffcVAz5anUc2FOqjBsaBVM8/jkQRBLODaPBJEgD1kWcOa8ukVW4
 7srQ==
X-Gm-Message-State: AOJu0YzHgHuFAr6H9ip5fyW8HMMEe6dA7rpVl5Fk4gtkOXLRfYZeTIXH
 Z6yWS0NlHuBm92WAHeV6lr+Warj3NdaNPUuSp60aqMA8/ynh7TeMzEdmtpF5O9eUxceBDDfex1w
 JuUfdnaRfZNsi32YrkJkM3+nPn63D83J+bnz9kgMzy2lZKvApfMTcevdJYz6Uhs+KIr6dgFXwFg
 M=
X-Received: by 2002:a5d:6a47:0:b0:31a:e21f:37ee with SMTP id
 t7-20020a5d6a47000000b0031ae21f37eemr4321458wrw.67.1694091660446; 
 Thu, 07 Sep 2023 06:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmkHX/8WZfepA/atmGhfXGk9m0D8OxIZ0DbISmr8Pb64iZomeGNSuQBjoa5AEfyrIc26Jldg==
X-Received: by 2002:a5d:6a47:0:b0:31a:e21f:37ee with SMTP id
 t7-20020a5d6a47000000b0031ae21f37eemr4321440wrw.67.1694091660140; 
 Thu, 07 Sep 2023 06:01:00 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 q12-20020adffecc000000b00316eb7770b8sm23521272wrs.5.2023.09.07.06.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 23/51] configure: create native file with contents of $host_cc
Date: Thu,  7 Sep 2023 14:59:32 +0200
Message-ID: <20230907130004.500601-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The argument of --host-cc is not obeyed when cross compiling.  To avoid
this issue, place it in a configuration file and pass it to meson
with --native-file.

While at it, clarify that --host-cc is not obeyed anyway when _not_
cross compiling, because cc="$host_cc" is placed before --host-cc is
processed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 7743c18f2fe..378a0de9fb6 100755
--- a/configure
+++ b/configure
@@ -288,7 +288,7 @@ static="no"
 #  ${cross_prefix}gcc (if cross-prefix specified)
 #  system compiler
 if test -z "${CC}${cross_prefix}"; then
-  cc="$host_cc"
+  cc="cc"
 else
   cc="${CC-${cross_prefix}gcc}"
 fi
@@ -927,8 +927,8 @@ Advanced options (experts only):
   -Dmesonoptname=val       passthrough option to meson unmodified
   --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be blank [$cross_prefix]
   --cc=CC                  use C compiler CC [$cc]
-  --host-cc=CC             use C compiler CC [$host_cc] for code run at
-                           build time
+  --host-cc=CC             when cross compiling, use C compiler CC for code run
+                           at build time [$host_cc]
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
   --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
@@ -1892,7 +1892,6 @@ if test "$skip_meson" = no; then
   echo "windres = [$(meson_quote $windres)]" >> $cross
   echo "windmc = [$(meson_quote $windmc)]" >> $cross
   if test "$cross_compile" = "yes"; then
-    cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
     echo "system = '$targetos'" >> $cross
     case "$cpu" in
@@ -1909,6 +1908,14 @@ if test "$skip_meson" = no; then
     else
         echo "endian = 'little'" >> $cross
     fi
+    cross_arg="--cross-file config-meson.cross"
+
+    native="config-meson.native.new"
+    echo "# Automatically generated by configure - do not modify" > $native
+    echo "[binaries]" >> $native
+    echo "c = [$(meson_quote $host_cc)]" >> $native
+    mv $native config-meson.native
+    cross_arg="$cross_arg --native-file config-meson.native"
   else
     cross_arg="--native-file config-meson.cross"
   fi
-- 
2.41.0


