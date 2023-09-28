Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1797B1561
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllp2-0007Kb-L1; Thu, 28 Sep 2023 03:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlloz-0007KR-4J
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllox-0001kh-8A
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695887546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EJuRDnczFGkrZrQtbctZD5wLjABq9HjGRfbPbj3RDdI=;
 b=Uw5lHc35k6knK9TDUy52o748s3bSJKWI3UM8i1WKHcfk52+vTjBeGkjBtLJz0Wh0iYZiyX
 fB2khJ28eFMoz9hX3CkJssxd7GPgCiaxhiFMpR1GARF2LZjVvO/WGz5l5mBqOLseFG/sv0
 FdtdVJ9N1VtvDMtFyuscheW1jaMDVMU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-ORHxRhtvMeucBUUh4X97SQ-1; Thu, 28 Sep 2023 03:52:23 -0400
X-MC-Unique: ORHxRhtvMeucBUUh4X97SQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a9e12a3093so1236505966b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695887541; x=1696492341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJuRDnczFGkrZrQtbctZD5wLjABq9HjGRfbPbj3RDdI=;
 b=fXWTkWUjhayCta13K0QSulzSFSLRD1JAlxC0LJelWBptbaRk0pptHvfqdQgfoiyDma
 3VFbnfG5tQItaHXMz6A8SIXKWVn/ea9xP0thoPEsYvFIZHUy9g8D38L6Qg7X/ODpVXX7
 Z/zF2CJqR0TWJ4qL9zumdCUDkL9eCwJuQa4v0/uMXfUYhH+7k47mXZRtA5YG2EUUcQ95
 FCKfOCGyNFNTewod0e50bwugeNnrwktTt/z8IGWxXFk4NItejWJz0Gvh45L4qOC/LVW1
 aOwsWfwSupgynG7I3JO0I2MQq1WrMts0SLNNCN/uG/9q7iIohkHzxGJTEuMKleKwinnc
 Wgfg==
X-Gm-Message-State: AOJu0Ywx3lGzY5nAna4RMQTalDjV61t+cb9NIsnqtLEKIRtMGMAew9Ba
 laDGBKx1XCL6wf57GC9juPqWIGXfxknFkYuTyguyJ0JebV4OvbczjVtlubEEN/94ePJFuGsYT3B
 cdRwoumRu13G1r6o0EG1OJa9bReFxuiH4VHXcW8D0fymMjrEulIsf0xUPU8AEvoTnOeK/CXkpI2
 s=
X-Received: by 2002:a17:906:54:b0:9a2:295a:9bbc with SMTP id
 20-20020a170906005400b009a2295a9bbcmr492145ejg.37.1695887541534; 
 Thu, 28 Sep 2023 00:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIeWJQQy3ey+BIMMZnjpI+MNvqpsAaJ3+COdeGBVpOGR/Oe1QNLXmGqhlN2ZtrBOlkg1k28w==
X-Received: by 2002:a17:906:54:b0:9a2:295a:9bbc with SMTP id
 20-20020a170906005400b009a2295a9bbcmr492134ejg.37.1695887541156; 
 Thu, 28 Sep 2023 00:52:21 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 bn23-20020a170906c0d700b0099cd1c0cb21sm10423827ejb.129.2023.09.28.00.52.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:52:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: clean up static_library keyword arguments
Date: Thu, 28 Sep 2023 09:52:19 +0200
Message-ID: <20230928075219.874855-1-pbonzini@redhat.com>
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

These are either built because they are dependencies of other targets,
or not needed at all because they are used via extract_objects().
Mark them as "build_by_default: false"; if applicable, mark them
as "fa" so that -Wl,--whole-archive does not interact with the
linker script used for fuzzing.

(The "fa" hack is brittle; updating to Meson 1.1 would allow using
declare_dependency(objects: ...) instead).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1044
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 gdbstub/meson.build |  4 ++--
 meson.build         | 11 +++++++----
 tcg/meson.build     |  4 ++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index 9500b9dc4e6..a5a1f4e433f 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -21,12 +21,12 @@ libgdb_user = static_library('gdb_user',
                              gdb_user_ss.sources() + genh,
                              name_suffix: 'fa',
                              c_args: '-DCONFIG_USER_ONLY',
-                             build_by_default: have_user)
+                             build_by_default: false)
 
 libgdb_softmmu = static_library('gdb_softmmu',
                                 gdb_system_ss.sources() + genh,
                                 name_suffix: 'fa',
-                                build_by_default: have_system)
+                                build_by_default: false)
 
 gdb_user = declare_dependency(link_whole: libgdb_user)
 user_ss.add(gdb_user)
diff --git a/meson.build b/meson.build
index 81430ce2348..21a1bc03f87 100644
--- a/meson.build
+++ b/meson.build
@@ -3180,7 +3180,6 @@ foreach d : hx_headers
                 input: files(d[0]),
                 output: d[1],
                 capture: true,
-                build_by_default: true, # to be removed when added to a target
                 command: [hxtool, '-h', '@INPUT0@'])
 endforeach
 genh += hxdep
@@ -3366,12 +3365,15 @@ endif
 qom_ss = qom_ss.apply(config_targetos, strict: false)
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
-                        name_suffix: 'fa')
+                        name_suffix: 'fa',
+                        build_by_default: false)
 qom = declare_dependency(link_whole: libqom)
 
 event_loop_base = files('event-loop-base.c')
-event_loop_base = static_library('event-loop-base', sources: event_loop_base + genh,
-                                 build_by_default: true)
+event_loop_base = static_library('event-loop-base',
+                                 sources: event_loop_base + genh,
+                                 name_suffix: 'fa',
+                                 build_by_default: false)
 event_loop_base = declare_dependency(link_whole: event_loop_base,
                                      dependencies: [qom])
 
@@ -3380,6 +3382,7 @@ stub_ss = stub_ss.apply(config_all, strict: false)
 util_ss.add_all(trace_ss)
 util_ss = util_ss.apply(config_all, strict: false)
 libqemuutil = static_library('qemuutil',
+                             build_by_default: false,
                              sources: util_ss.sources() + stub_ss.sources() + genh,
                              dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, pixman])
 qemuutil = declare_dependency(link_with: libqemuutil,
diff --git a/tcg/meson.build b/tcg/meson.build
index 0014dca7d4f..4be4a616caa 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -28,7 +28,7 @@ libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
                              name_suffix: 'fa',
                              c_args: '-DCONFIG_USER_ONLY',
-                             build_by_default: have_user)
+                             build_by_default: false)
 
 tcg_user = declare_dependency(link_with: libtcg_user,
                               dependencies: tcg_ss.dependencies())
@@ -38,7 +38,7 @@ libtcg_softmmu = static_library('tcg_softmmu',
                                 tcg_ss.sources() + genh,
                                 name_suffix: 'fa',
                                 c_args: '-DCONFIG_SOFTMMU',
-                                build_by_default: have_system)
+                                build_by_default: false)
 
 tcg_softmmu = declare_dependency(link_with: libtcg_softmmu,
                                  dependencies: tcg_ss.dependencies())
-- 
2.41.0


