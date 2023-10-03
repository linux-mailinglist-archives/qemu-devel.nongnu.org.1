Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A87B6428
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnao5-0001re-Ot; Tue, 03 Oct 2023 04:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao1-0001qy-8w
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnanz-0000HN-E9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJuRDnczFGkrZrQtbctZD5wLjABq9HjGRfbPbj3RDdI=;
 b=RcWFA2oAz8+Uub+3iNoqOTuYfbZF1cZtr5xJT/xH8SRJZ/fzMlxosUfvooWtNVcD04PsFf
 Ic4zo2oVUrKloJ0sr+BqH0MRRNZntwCrue9+6XGXMkKAxVCKxz9wCwp2F/VC3OZ1kvc6qg
 WfIYsikH8WK4GIddEUF5n0GpA8OJbw8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-klEGVl2WMsynvksOMxSM1Q-1; Tue, 03 Oct 2023 04:30:57 -0400
X-MC-Unique: klEGVl2WMsynvksOMxSM1Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso53289766b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321855; x=1696926655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJuRDnczFGkrZrQtbctZD5wLjABq9HjGRfbPbj3RDdI=;
 b=vmKtStv1nE9DZgpn8c+bmCz0Zo1bUP3VUt6VhNmlGYpIcmYDV5boHtk5xnIREiurYg
 KaMt9Xz85143kfo2BcBpkkyxdkmFxVMyznjW5CVO5Acaf2T7lGJwGUmueO+PHISwPbly
 woAi60DhKp/LZz9llUIzwQZFJZeISALanwQrD04YJe7rwRBpQKH54oKEQ71JcXjsxadX
 VrEkwGz5eg5k1xmXdO5vAob90DH0Ebe+bMuBi8mNx/wnGMV6YRrRXX1VtRtrPaqVSejC
 7YzswgDq379GCW8aevmhbI6D4uNG0JyvisekYhFsIx3tnN2aHJPzbPUlT8+sGRkbXjB6
 /agw==
X-Gm-Message-State: AOJu0YyLBYMHUCwtz+iF8nAzMZqAcPpnlgaALD9+V5XnbLuHyX4VmS8Y
 4XSxRhOKoVk8rj9PXFwk3OSn7xaKCJ/uqyihKF30WWse4LW/r2vnZci0InLip32otwe6/rupoWt
 YMdkfKHBhsCuNTuCE5GGSRmotJV1uP4eOWg5LWGm7FLPVdzdXtf1oPqPpd6583ESKm1lj3YG/4i
 c=
X-Received: by 2002:a17:906:538f:b0:9ae:699d:8a2a with SMTP id
 g15-20020a170906538f00b009ae699d8a2amr13026449ejo.5.1696321855373; 
 Tue, 03 Oct 2023 01:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2gxPr7jd+dut5hTeypIv9rVljl/ZlrN+TTjajaTLt7lNFW9v9r3RItOf24bCHu/yNUIapRg==
X-Received: by 2002:a17:906:538f:b0:9ae:699d:8a2a with SMTP id
 g15-20020a170906538f00b009ae699d8a2amr13026425ejo.5.1696321854992; 
 Tue, 03 Oct 2023 01:30:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 ch22-20020a170906c2d600b00993664a9987sm655577ejb.103.2023.10.03.01.30.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/24] meson: clean up static_library keyword arguments
Date: Tue,  3 Oct 2023 10:30:23 +0200
Message-ID: <20231003083042.110065-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
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


