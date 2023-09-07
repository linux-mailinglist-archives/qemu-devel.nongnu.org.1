Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4FB797285
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdI-00038c-2m; Thu, 07 Sep 2023 09:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd9-0002tV-KO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd6-0007Kz-95
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSIhgwdtPAh7ZASQK5Mkn904aeMaclvME+5f1ujXt2U=;
 b=ba11yOXB2nEpzsI0HXaRp9yOuv6qt0wqqH207WjG3zHrvDTnDPY1LcoGEhUd51stFA8AwT
 vatvGI6EOhKbyxjeb9CtlAnNvL+oUsR8uSrV5Egli/IGXW3J1qcXO5ua2ttBYJt1XfQe+I
 7LGQrlsYJiv2o2SnsKo+cDDdcgA5Zac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-IuMvGeiaOWGYlqjW2eTZow-1; Thu, 07 Sep 2023 09:01:01 -0400
X-MC-Unique: IuMvGeiaOWGYlqjW2eTZow-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401dba99384so6532135e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091656; x=1694696456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSIhgwdtPAh7ZASQK5Mkn904aeMaclvME+5f1ujXt2U=;
 b=EzqQgle/rHjv24WRn6/DNYIvRB4lxTIeL3WE7Hn37QlgDgXOoTlVLqKEVFPBdBXK5i
 +7MgWOASI1dnRZ0Z1X7iIKlwUm3Q+QrD0oFDAlbSJrHD8BjzR5cMQdMqqP5+onnODjbc
 RzbRm1HlEV2uQdHDz48G3oLm3MIsiR1YV31+Pb61Sa2ESYCvh0CwSHZe+K3DIwx2PODp
 ApBPSeY+SdUPg+qztAf+rOtaSv0qhzsvgRoimMb+xiSuJJrdN8X+9lylCRL2Z5wO5gfW
 y2ehDSBfYmOJcB2hB9qd6cMR+CC8DxgzeB6qC8CJvPXeH2vEJyyZyMxtSeLigGgldV0y
 OK7g==
X-Gm-Message-State: AOJu0YzmEJnY/oXUWhu2ONtZcZZ5ZY78qRNj1+tKyX6DU3XgnEr8LOyy
 U2afKUbCD4Tan5SZpHlublM1O+xsgr55Q+HNUTn4J7GFfCllqz2yjzmCG+Yc51iotv24MveTCjh
 KSaRJpgHZzeFRUtjQGh8nSkz++HXgq/exqAIUk9aMFPhF44coRf832RVcxwg1DdTc8AMKMKZL3p
 I=
X-Received: by 2002:a1c:ed08:0:b0:3ff:516b:5c65 with SMTP id
 l8-20020a1ced08000000b003ff516b5c65mr4225155wmh.30.1694091655971; 
 Thu, 07 Sep 2023 06:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV5OQ7bChc7GWb+ZnwKtA81RIgMPq3FdVhqi1KtAxPQ2zE+gym52ODYry3gWTp/SRUeE+PsQ==
X-Received: by 2002:a1c:ed08:0:b0:3ff:516b:5c65 with SMTP id
 l8-20020a1ced08000000b003ff516b5c65mr4225143wmh.30.1694091655607; 
 Thu, 07 Sep 2023 06:00:55 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a05600c21d000b003fbca942499sm2481151wmj.14.2023.09.07.06.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 21/51] meson: update unsupported host/CPU messages
Date: Thu,  7 Sep 2023 14:59:30 +0200
Message-ID: <20230907130004.500601-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

Unsupported CPU and OSes are not really going away, but the
project simply does not guarantee that they work.  Rephrase
the messages accordingly.  While at it, move the warning for
TCI performance at the end where it is more visible.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/meson.build b/meson.build
index 98e68ef0b1e..13f21fd24de 100644
--- a/meson.build
+++ b/meson.build
@@ -678,9 +678,7 @@ endif
 tcg_arch = host_arch
 if get_option('tcg').allowed()
   if host_arch == 'unknown'
-    if get_option('tcg_interpreter')
-      warning('Unsupported CPU @0@, will use TCG with TCI (slow)'.format(cpu))
-    else
+    if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
   elif get_option('tcg_interpreter')
@@ -4317,28 +4315,37 @@ summary_info += {'selinux':           selinux}
 summary_info += {'libdw':             libdw}
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
-if not supported_cpus.contains(cpu)
+if host_arch == 'unknown'
   message()
-  warning('SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!')
+  warning('UNSUPPORTED HOST CPU')
   message()
-  message('CPU host architecture ' + cpu + ' support is not currently maintained.')
-  message('The QEMU project intends to remove support for this host CPU in')
-  message('a future release if nobody volunteers to maintain it and to')
-  message('provide a build host for our continuous integration setup.')
-  message('configure has succeeded and you can continue to build, but')
-  message('if you care about QEMU on this platform you should contact')
-  message('us upstream at qemu-devel@nongnu.org.')
+  message('Support for CPU host architecture ' + cpu + ' is not currently')
+  message('maintained. The QEMU project does not guarantee that QEMU will')
+  message('compile or work on this host CPU. You can help by volunteering')
+  message('to maintain it and providing a build host for our continuous')
+  message('integration setup.')
+  if get_option('tcg').allowed() and target_dirs.length() > 0
+    message()
+    message('configure has succeeded and you can continue to build, but')
+    message('QEMU will use a slow interpreter to emulate the target CPU.')
+  endif
 endif
 
 if not supported_oses.contains(targetos)
   message()
-  warning('WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!')
+  warning('UNSUPPORTED HOST OS')
   message()
-  message('Host OS ' + targetos + 'support is not currently maintained.')
-  message('The QEMU project intends to remove support for this host OS in')
-  message('a future release if nobody volunteers to maintain it and to')
-  message('provide a build host for our continuous integration setup.')
+  message('Support for host OS ' + targetos + 'is not currently maintained.')
   message('configure has succeeded and you can continue to build, but')
-  message('if you care about QEMU on this platform you should contact')
-  message('us upstream at qemu-devel@nongnu.org.')
+  message('the QEMU project does not guarantee that QEMU will compile or')
+  message('work on this operating system. You can help by volunteering')
+  message('to maintain it and providing a build host for our continuous')
+  message('integration setup. This will ensure that future versions of QEMU')
+  message('will keep working on ' + targetos + '.')
+endif
+
+if host_arch == 'unknown' or not supported_oses.contains(targetos)
+  message()
+  message('If you want to help supporting QEMU on this platform, please')
+  message('contact the developers at qemu-devel@nongnu.org.')
 endif
-- 
2.41.0


