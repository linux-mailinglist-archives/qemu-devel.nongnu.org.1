Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 503DE720844
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58QI-00018F-KT; Fri, 02 Jun 2023 13:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q58QH-00016X-7q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q58QF-0004B9-M4
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685726323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LAzvwtLIG/70csw4DTIjDoy08MK3cibOBxxTbyvidrM=;
 b=hVKqOo06gWfoU2jof1tdiYyx0vxg0MwZX/jBEFoPMaC+J4VctvqoOr/Gcvopx04y83HU59
 GUpix0nKNABE5QN3ZQWoWWBuaKXZlHh+8Vx0InsEhXJOBENysTih8s2j3C5CtKLFRtQ4Mb
 v8qQtpeDAZvhPbBuRV69kXj1MH5uMeI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-Dh6zWfiJMYu8KUuwtjq75Q-1; Fri, 02 Jun 2023 13:18:39 -0400
X-MC-Unique: Dh6zWfiJMYu8KUuwtjq75Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4265811E7C;
 Fri,  2 Jun 2023 17:18:38 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C2962166B25;
 Fri,  2 Jun 2023 17:18:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/3] meson.build: Group the UI entries in a separate summary
 section
Date: Fri,  2 Jun 2023 19:18:30 +0200
Message-Id: <20230602171832.533739-2-thuth@redhat.com>
In-Reply-To: <20230602171832.533739-1-thuth@redhat.com>
References: <20230602171832.533739-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's make it easier for the users to spot UI-related entries in
the summary of the meson output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index a61d3e9b06..4a20a2e712 100644
--- a/meson.build
+++ b/meson.build
@@ -4243,32 +4243,44 @@ summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
 summary(summary_info, bool_yn: true, section: 'Crypto')
 
-# Libraries
+# UI
 summary_info = {}
 if targetos == 'darwin'
   summary_info += {'Cocoa support':           cocoa}
-  summary_info += {'vmnet.framework support': vmnet}
 endif
 summary_info += {'SDL support':       sdl}
 summary_info += {'SDL image support': sdl_image}
 summary_info += {'GTK support':       gtk}
 summary_info += {'pixman':            pixman}
 summary_info += {'VTE support':       vte}
+summary_info += {'PNG support':       png}
+summary_info += {'VNC support':       vnc}
+if vnc.found()
+  summary_info += {'VNC SASL support':  sasl}
+  summary_info += {'VNC JPEG support':  jpeg}
+endif
+summary_info += {'spice protocol support': spice_protocol}
+if spice_protocol.found()
+  summary_info += {'  spice server support': spice}
+endif
+summary_info += {'curses support':    curses}
+summary_info += {'brlapi support':    brlapi}
+summary(summary_info, bool_yn: true, section: 'User interface')
+
+# Libraries
+summary_info = {}
+if targetos == 'darwin'
+  summary_info += {'vmnet.framework support': vmnet}
+endif
+summary_info = {}
 summary_info += {'slirp support':     slirp}
 summary_info += {'libtasn1':          tasn1}
 summary_info += {'PAM':               pam}
 summary_info += {'iconv support':     iconv}
-summary_info += {'curses support':    curses}
 summary_info += {'virgl support':     virgl}
 summary_info += {'blkio support':     blkio}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
-summary_info += {'PNG support':       png}
-summary_info += {'VNC support':       vnc}
-if vnc.found()
-  summary_info += {'VNC SASL support':  sasl}
-  summary_info += {'VNC JPEG support':  jpeg}
-endif
 if targetos not in ['darwin', 'haiku', 'windows']
   summary_info += {'OSS support':     oss}
   summary_info += {'sndio support':   sndio}
@@ -4283,7 +4295,6 @@ if targetos == 'linux'
 endif
 summary_info += {'Pipewire support':   pipewire}
 summary_info += {'JACK support':      jack}
-summary_info += {'brlapi support':    brlapi}
 summary_info += {'vde support':       vde}
 summary_info += {'netmap support':    have_netmap}
 summary_info += {'l2tpv3 support':    have_l2tpv3}
@@ -4295,10 +4306,6 @@ summary_info += {'PVRDMA support':    have_pvrdma}
 summary_info += {'fdt support':       fdt_opt == 'disabled' ? false : fdt_opt}
 summary_info += {'libcap-ng support': libcap_ng}
 summary_info += {'bpf support':       libbpf}
-summary_info += {'spice protocol support': spice_protocol}
-if spice_protocol.found()
-  summary_info += {'  spice server support': spice}
-endif
 summary_info += {'rbd support':       rbd}
 summary_info += {'smartcard support': cacard}
 summary_info += {'U2F support':       u2f}
-- 
2.31.1


