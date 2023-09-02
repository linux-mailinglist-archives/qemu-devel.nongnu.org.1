Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A239F79080C
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:06:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEA-0000w8-5h; Sat, 02 Sep 2023 08:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE8-0000vZ-8r
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE6-0001g9-0b
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqCLzWC5Te9PQ+uHTLXN6umOZS02O1C9B8XH1Qm66mo=;
 b=OvyWP1Q/u5XuSmLWAsqbqw1blNsoljSDr6hHrC0r1YTiLLK2E0QNQ1YxRw/G3wwFHDi5Xh
 rcv8wdw9KuSqvgDUOcNuSeJL8duCmDToRiQ5fmam5mWYycLpXrETa9ZAmwyp+I2+70ZRfk
 JTsVux6LZ0sQoPyTIMvvIrSb2c9vWZc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-vivoJQk5NVW0rR8UWSEQCw-1; Sat, 02 Sep 2023 08:59:42 -0400
X-MC-Unique: vivoJQk5NVW0rR8UWSEQCw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-500a9156daaso10973e87.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659581; x=1694264381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqCLzWC5Te9PQ+uHTLXN6umOZS02O1C9B8XH1Qm66mo=;
 b=fEH01hCno8OIdZVRjEKtEbthryAC4OI/goKTds7ftaAy/UpM0/v1+R3lC8lY1gQHIs
 Kf5CH6w/8YvNTCtv5FdVgwI+89pqzG8vrIuJAiarKpskKFQoE0qn/gIB8VxEPkZ28mzg
 v1XaE8UXKdpg46gn6jH9CM1ACMvk85MZU9N1RSFWx2nzvuTOuz4Yhr4Y1q4Poth0EJgw
 76f4wNJbBH1o0UlcMp3rcI+l8fWjcJ4mAIR8r808tkaW0npuc6KdcFxFWGQIteT/7HHw
 Akl3OovwAxuOuE05eDFaHD9uqEpK1/vxMoS2OTIqnnMmP1a8r2gwHq2LtwZdDVuNFHnj
 4rcw==
X-Gm-Message-State: AOJu0YxePvX1ZlWTvbpEXFGfwR0cYGEEYhL+HpYYDrlAxuhKwNtn1sXW
 /ZqkYCchX/rzBXXV3v9k/P93XQcKf/PJRITaRKHrlqjxATiFMOuh+a9YABRwytanAq4GwrYaR88
 Xnk9A6TiO1ISospFrCv3Xxc+Q2JVPIux9hTK+ugP8TPz2grlrXVp6ynqiOnEYsH1OirWJVPcPTS
 U=
X-Received: by 2002:a05:6512:3194:b0:500:b96a:6f59 with SMTP id
 i20-20020a056512319400b00500b96a6f59mr4307657lfe.56.1693659580829; 
 Sat, 02 Sep 2023 05:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUh1GKfebFSh8M1iznBUa210lpaB/QSB4vVAIum1BA9Gkx5fXol3rs4prlg6bUXcNfaurAeg==
X-Received: by 2002:a05:6512:3194:b0:500:b96a:6f59 with SMTP id
 i20-20020a056512319400b00500b96a6f59mr4307644lfe.56.1693659580326; 
 Sat, 02 Sep 2023 05:59:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c249100b003fbc30825fbsm7823128wms.39.2023.09.02.05.59.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/15] meson: update unsupported host/CPU messages
Date: Sat,  2 Sep 2023 14:59:21 +0200
Message-ID: <20230902125934.113017-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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

Unsupported CPU and OSes are not really going away, but the
project simply does not guarantee that they work.  Rephrase
the messages accordingly.  While at it, move the warning for
TCI performance at the end where it is more visible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/meson.build b/meson.build
index 98e68ef0b1e..9bcf117f8a4 100644
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
+  message('to maintain it and providing a build host for our continuous.')
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
+  message('to maintain it and providing a build host for our continuous.')
+  message('integration setup. This will ensure that future versions of QEMU')
+  message('will keep working on ' + targetos + '.')
+endif
+
+if host_arch == 'unknown' or not supported_oses.contains(targetos)
+  message()
+  message('If you care about QEMU on this platform, please contact the')
+  message('developers at qemu-devel@nongnu.org.')
 endif
-- 
2.41.0


