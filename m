Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A672B78C04D
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qau6q-0002ns-VL; Tue, 29 Aug 2023 04:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6f-0002dN-0f
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qau6Y-0008Qi-R8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693297781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbINoetYo4VP8iqmSjHGVe74IecBpQ2pTHYEBg3wUwQ=;
 b=jTTxJdDB1Fw0Ve603Q4wHBDX63Y6gZrmFQ9n6eZ5z2vPBNT/xS1bqwiDe9LAhzQAp2WXWI
 u+ZmpKv8xxe5ejQeslYWP8MqFD7trsv5SbrLn571Yr+y/qjaeS40Hc66DmRYxnDJOn500J
 ASkTjp4VyENym6io/2L/JR4TFfGvEjA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-GVucSB8_N2yXlC1unOENVQ-1; Tue, 29 Aug 2023 04:29:39 -0400
X-MC-Unique: GVucSB8_N2yXlC1unOENVQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5007f3d3255so4539827e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297777; x=1693902577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UbINoetYo4VP8iqmSjHGVe74IecBpQ2pTHYEBg3wUwQ=;
 b=WeGClmhgfOLy3mgwmFEVFiKfMYGXeIXltAA2/Gcf1DHFuGCkSz4HRWgalL6etWKFyq
 IjprHNhRVJZZU9k63EqZQnbAr/lSjQur/fl0lD6JcaJ9Z1cEaKVjIZfBtBI1bRC05pvy
 kBdtsBF/pkTgm8qaSMoJDQtcsjjnj7wQ8TraZerdcKS0UJu5IHCNr9OAy4vJHNMzyaUu
 cBONts5F5xDqGiBulqj3Vl/6gr7Ly8bwWMCISnFZxsMcdz/2iKj7peX162tY9cCWbDC2
 60e1hkKJzWA31q/foVKkwNndoTLBffu70j4PyngFe72o6qZSnQtcEf+ZKsBiiCHRBOoy
 OU2g==
X-Gm-Message-State: AOJu0YyQ6uaI2+0v2HuMin1ZEgi+T7rNDrDn6DLVKd2YSoDWbdAtbPwq
 K0PojmXxrIVLgr9fgZxJ4vkM+SGgNlioEqCsCn9LxluUtm4Db5Fj7BBHYg6T5uBizXmqzO3Xzmy
 BfidHPXfzyYNVo+lyPrUyh6b4grdwwqTEP1OtIhnzdH0nSkDNnGkGxQgLARyrx3K3MCGP52s7ek
 Y=
X-Received: by 2002:a19:9102:0:b0:500:a408:dbd with SMTP id
 t2-20020a199102000000b00500a4080dbdmr7516441lfd.55.1693297777442; 
 Tue, 29 Aug 2023 01:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+iGk6tyqDQKeteFpkPaL6fexbu+KeSkyYw699YsrBsgG+TRwSNwEEnY2a8tyuB9alt4MXyw==
X-Received: by 2002:a19:9102:0:b0:500:a408:dbd with SMTP id
 t2-20020a199102000000b00500a4080dbdmr7516424lfd.55.1693297776836; 
 Tue, 29 Aug 2023 01:29:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 m30-20020a05600c3b1e00b00401d8181f8bsm866628wms.25.2023.08.29.01.29.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 01:29:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] meson: update unsupported host/CPU messages
Date: Tue, 29 Aug 2023 10:29:23 +0200
Message-ID: <20230829082931.67601-3-pbonzini@redhat.com>
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

Unsupported CPU and OSes are not really going away, but the
project simply does not guarantee that they work.  Rephrase
the messages accordingly.  While at it, move the warning for
TCI performance at the end where it is more visible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index 98e68ef0b1e..02b035a3808 100644
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
@@ -4317,28 +4315,34 @@ summary_info += {'selinux':           selinux}
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
 endif
 
 if not supported_oses.contains(targetos)
   message()
-  warning('WARNING: SUPPORT FOR THIS HOST OS WILL GO AWAY IN FUTURE RELEASES!')
+  warning('UNSUPPORTED HOST OS')
+  message()
+  message('Support for host OS ' + targetos + 'is not currently maintained.')
+  message('The QEMU project does not guarantee that QEMU will compile or')
+  message('work on this operating system. You can help by volunteering')
+  message('to maintain it and providing a build host for our continuous.')
+  message('integration setup.')
+endif
+
+if host_arch == 'unknown' or not supported_oses.contains(targetos)
   message()
-  message('Host OS ' + targetos + 'support is not currently maintained.')
-  message('The QEMU project intends to remove support for this host OS in')
-  message('a future release if nobody volunteers to maintain it and to')
-  message('provide a build host for our continuous integration setup.')
   message('configure has succeeded and you can continue to build, but')
+  if host_arch == 'unknown' and get_option('tcg').allowed() and target_dirs.length() > 0
+    message('QEMU will use a slow interpreter to emulate the target CPU;')
+  endif
   message('if you care about QEMU on this platform you should contact')
   message('us upstream at qemu-devel@nongnu.org.')
 endif
-- 
2.41.0


