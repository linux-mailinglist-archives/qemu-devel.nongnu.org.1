Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D205378C043
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau74-0002rm-GH; Tue, 29 Aug 2023 04:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6f-0002dc-7M
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6a-0008Rd-4P
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+2YITt1ZYq7j1igsqUCB1nnRp6fLRIOelIupAjVtmo=;
 b=IaR9Rm4MjOI7FsHfZeHnSc+N1qS1eKruBBRMLQp+tnyhtRAudujcSGm6YS+ksSywRaB6Qo
 uIt8oZntRCRcdW7tweISxd0NKK95v7/jkeGs1s28DNK+YNdYF59Rhxa6nPE3y3m1r2lep1
 53hG03YTmf4THlZJ9wphR8irCH0VxtQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-fZW6lMtSMtyjIM6vTp376Q-1; Tue, 29 Aug 2023 04:29:41 -0400
X-MC-Unique: fZW6lMtSMtyjIM6vTp376Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-315af0252c2so2667625f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297780; x=1693902580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+2YITt1ZYq7j1igsqUCB1nnRp6fLRIOelIupAjVtmo=;
 b=dCk3B21bp6cOT1IyDX5AiGak69MqSENto+908200HNVBMOdwMlvtqPSKR/R0F/M4rD
 zAe3GWc1cYAKGVSgu98so93S8v4GEB8nKu+39jrEj9/sDLjjtiL6lJndZ8HS2Wp9uTYo
 i+fMJZnGSisqNljjpd1jE/IKQ09MOA93QDLnYQhyN3Q69kw9f7E01U5yj0qZv2+fqnnF
 ootr9HaL5xvFib8TbjVP6bLfcCV/J2Qh8yV3uN2YKRijNJ93+FvUPlfylJ6fOyqwHWe6
 Y06mWkASM2ndz2D3VgEHwiik2JQ+tONZy/nmq8O3xtJLS6nrV09Ry8iod6y2ajbnp1yn
 UVbA==
X-Gm-Message-State: AOJu0YzjZ18Qp1RLzAk+IGa8eR7YgIQV4BKWVrFG0q3GeuxumwheFccI
 xCiVGPDVPMxJOkhvnhdk2rPr55CR9eHXbk0h25P3y8N3sfHPLSMrMoxE+kolCpHC6wdnbeJPF0d
 GCmt+vn9gstia0/HNfdFCAnIznnQp01UG1y59afXuy1Em08Hdvm5R5/R91PhkCQuJzkaM8tf3Oc
 0=
X-Received: by 2002:a05:6000:12d2:b0:317:58eb:1e33 with SMTP id
 l18-20020a05600012d200b0031758eb1e33mr21791140wrx.8.1693297780303; 
 Tue, 29 Aug 2023 01:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF16TgdGGqRGfH4AGXb0+AEWao7BRFwkqMCOzSCJiww53/YnYopfBFp/ygvBAbeuQn03On5iA==
X-Received: by 2002:a05:6000:12d2:b0:317:58eb:1e33 with SMTP id
 l18-20020a05600012d200b0031758eb1e33mr21791132wrx.8.1693297780037; 
 Tue, 29 Aug 2023 01:29:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 o12-20020adfcf0c000000b0031ad2663ed0sm13007348wrj.66.2023.08.29.01.29.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] configure: create native file with contents of $host_cc
Date: Tue, 29 Aug 2023 10:29:25 +0200
Message-ID: <20230829082931.67601-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829082931.67601-1-pbonzini@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
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

The argument of --host-cc is not obeyed when cross compiling.  To avoid
this issue, place it in a configuration file and pass it to meson
with --native-file.

While at it, clarify that --host-cc is not obeyed anyway when _not_
cross compiling.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 3423f008d5c..b2bc1ff5f7b 100755
--- a/configure
+++ b/configure
@@ -922,7 +922,7 @@ Advanced options (experts only):
   --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be blank [$cross_prefix]
   --cc=CC                  use C compiler CC [$cc]
   --host-cc=CC             use C compiler CC [$host_cc] for code run at
-                           build time
+                           build time when cross compiling
   --cxx=CXX                use C++ compiler CXX [$cxx]
   --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
   --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
@@ -1886,7 +1886,6 @@ if test "$skip_meson" = no; then
   echo "windres = [$(meson_quote $windres)]" >> $cross
   echo "windmc = [$(meson_quote $windmc)]" >> $cross
   if test "$cross_compile" = "yes"; then
-    cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
     echo "system = '$targetos'" >> $cross
     case "$cpu" in
@@ -1903,6 +1902,14 @@ if test "$skip_meson" = no; then
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


