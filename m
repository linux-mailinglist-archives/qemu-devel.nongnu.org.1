Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD13C79E79F
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOfr-0000iK-9Q; Wed, 13 Sep 2023 08:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfb-0000bP-S5
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfV-0002Wh-Mk
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694606906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyQUJfnnRSR32nQM5oGFcEXgp3Ef9zq8Wifz1rub+ek=;
 b=fySqLO2caZ4/7LFQldT7+y72QT0oTLMMzCEuqWkYi0AGXqWQ/MdDojzm7sEUDkbik+In3C
 9gDtvkWxeNSbZBkxTGRXxOdcW9USIZMUBdFyzMFY35EcqGfV6xjBxLGJXj5zcAjS4DNbMZ
 UAkopUUD3+rEurQNPt3AngFRBe85uo8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-3TaJmJO5O3WOwZc7EZyRoA-1; Wed, 13 Sep 2023 08:08:25 -0400
X-MC-Unique: 3TaJmJO5O3WOwZc7EZyRoA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c5c762f97so4952039f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694606903; x=1695211703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyQUJfnnRSR32nQM5oGFcEXgp3Ef9zq8Wifz1rub+ek=;
 b=lSfmNtqPF0yWY3aWJ6ry3tSGvb2QGngoSK49ajx/7Uc8snOuugmM/zjnnIISr0fHpC
 jUOzE/+A6AgrMrnLQ9QUGrFl9q/unI74XtvpgI1Xs3H5rEVY4cqJwHXOjHHgRkigyLLo
 Y8ZJsIpNy29aky4UJrhvPssKqlhn2m7soYC2i9OIwXT5m01jsbZmK9dwauyjPYsIuVBi
 xxGopGoGdfD+cik3P3l9cYSTAnm+VHRhLZIvgEqvmc0R9n5zoWKgVAc/Dsy6yuDaFTW1
 bvCQGGK/6AVJm8MAWhKYkD5rHW1UOnZiKBkzbhMrmWA1BWXA5acijgm78J8QL8qy8LTw
 ymUg==
X-Gm-Message-State: AOJu0Yz1DAiWGknlPH2I4n0hHBAmL/pPH7lyFxlTCXtjsEHJi/77soSn
 ZSoNsWPusVzVBLgcbaarrz/KEQ2tSbpqSvYNd88aeai3i3LTkt+dThbX4GtuMKjmHkVWobi6WwN
 4hu7CPNM7sPG8stRH3sZIZrkLvBWLL0iTdyVfvetyaKOAfLiNqMWZSkEN1efIjtf2qf+d88elmt
 Y=
X-Received: by 2002:a5d:68d1:0:b0:31a:e744:1297 with SMTP id
 p17-20020a5d68d1000000b0031ae7441297mr1726778wrw.50.1694606903592; 
 Wed, 13 Sep 2023 05:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0BpehFpGcQoX/Nba9tkKl9tJpxk/pRGw/gDUhHFzghrBKNpo1IVDC1LtFIWrCSUpF4/7vNw==
X-Received: by 2002:a5d:68d1:0:b0:31a:e744:1297 with SMTP id
 p17-20020a5d68d1000000b0031ae7441297mr1726760wrw.50.1694606903089; 
 Wed, 13 Sep 2023 05:08:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4150000000b00317a29af4b2sm15393794wrq.68.2023.09.13.05.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 05:08:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Perkin <jonathan@perkin.org.uk>,
	qemu-stable@nongnu.org
Subject: [PULL 1/4] meson: Fix targetos match for illumos and Solaris.
Date: Wed, 13 Sep 2023 14:08:17 +0200
Message-ID: <20230913120820.969262-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913120820.969262-1-pbonzini@redhat.com>
References: <20230913120820.969262-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jonathan Perkin <jonathan@perkin.org.uk>

qemu 8.1.0 breaks on illumos platforms due to _XOPEN_SOURCE and others no longer being set correctly, leading to breakage such as:

  https://us-central.manta.mnx.io/pkgsrc/public/reports/trunk/tools/20230908.1404/qemu-8.1.0/build.log

This is a result of meson conversion which incorrectly matches against 'solaris' instead of 'sunos' for uname.

First time submitting a patch here, hope I did it correctly.  Thanks.

Signed-off-by: Jonathan Perkin <jonathan@perkin.org.uk>
Message-ID: <ZPtdxtum9UVPy58J@perkin.org.uk>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build     | 4 ++--
 net/meson.build | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 0e31bdfabf1..5150a74831b 100644
--- a/meson.build
+++ b/meson.build
@@ -226,7 +226,7 @@ if targetos == 'darwin'
   if compiler.get_id() == 'gcc'
     qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
   endif
-elif targetos == 'solaris'
+elif targetos == 'sunos'
   # needed for CMSG_ macros in sys/socket.h
   qemu_common_flags += '-D_XOPEN_SOURCE=600'
   # needed for TIOCWIN* defines in termios.h
@@ -2048,7 +2048,7 @@ have_slirp_smbd = get_option('slirp_smbd') \
 if have_slirp_smbd
   smbd_path = get_option('smbd')
   if smbd_path == ''
-    smbd_path = (targetos == 'solaris' ? '/usr/sfw/sbin/smbd' : '/usr/sbin/smbd')
+    smbd_path = (targetos == 'sunos' ? '/usr/sfw/sbin/smbd' : '/usr/sbin/smbd')
   endif
   config_host_data.set_quoted('CONFIG_SMBD_COMMAND', smbd_path)
 endif
diff --git a/net/meson.build b/net/meson.build
index d2d70634e5e..51caa42c9d2 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -47,7 +47,7 @@ elif targetos == 'linux'
   system_ss.add(files('tap.c', 'tap-linux.c'))
 elif targetos in bsd_oses
   system_ss.add(files('tap.c', 'tap-bsd.c'))
-elif targetos == 'solaris'
+elif targetos == 'sunos'
   system_ss.add(files('tap.c', 'tap-solaris.c'))
 else
   system_ss.add(files('tap.c', 'tap-stub.c'))
-- 
2.41.0


