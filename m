Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866F9720842
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:19:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58QL-00018q-9l; Fri, 02 Jun 2023 13:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q58QJ-00018T-5f
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q58QH-0004BH-Dj
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685726324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyGtBeWrPawvCHh+FujHykW4Fe0WDaS9CEcJgMSyHzM=;
 b=Rk5+d2GDk4y1pJ2/IrWn7I7YA3PclgzI4IypQanakHiM+L5yADi6sb62C+W9ju82edvo5u
 g73EJ7t6J3PNXFJ2kDPKMqZB8XW+o4DXS6D/4l9eaiR8HP46gKJeRM9SH0CQfMpxFozLR6
 NoUuBZMQ2sjLSYGM7yeCVHr+ESn/LOI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-Sd6_z0adNPmJNbq8cRiPsg-1; Fri, 02 Jun 2023 13:18:43 -0400
X-MC-Unique: Sd6_z0adNPmJNbq8cRiPsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC98D3815EE3;
 Fri,  2 Jun 2023 17:18:42 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56BBF2166B25;
 Fri,  2 Jun 2023 17:18:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 3/3] meson.build: Group the audio backend entries in a
 separate summary section
Date: Fri,  2 Jun 2023 19:18:32 +0200
Message-Id: <20230602171832.533739-4-thuth@redhat.com>
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

Let's make it easier for the users to spot audio-related entries
in the summary of the meson output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index c64ad3c365..365c6d60a5 100644
--- a/meson.build
+++ b/meson.build
@@ -4267,6 +4267,24 @@ summary_info += {'curses support':    curses}
 summary_info += {'brlapi support':    brlapi}
 summary(summary_info, bool_yn: true, section: 'User interface')
 
+# Audio backends
+summary_info = {}
+if targetos not in ['darwin', 'haiku', 'windows']
+  summary_info += {'OSS support':     oss}
+  summary_info += {'sndio support':   sndio}
+elif targetos == 'darwin'
+  summary_info += {'CoreAudio support': coreaudio}
+elif targetos == 'windows'
+  summary_info += {'DirectSound support': dsound}
+endif
+if targetos == 'linux'
+  summary_info += {'ALSA support':    alsa}
+  summary_info += {'PulseAudio support': pulse}
+endif
+summary_info += {'Pipewire support':  pipewire}
+summary_info += {'JACK support':      jack}
+summary(summary_info, bool_yn: true, section: 'Audio backends')
+
 # Network backends
 summary_info = {}
 if targetos == 'darwin'
@@ -4287,20 +4305,6 @@ summary_info += {'virgl support':     virgl}
 summary_info += {'blkio support':     blkio}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
-if targetos not in ['darwin', 'haiku', 'windows']
-  summary_info += {'OSS support':     oss}
-  summary_info += {'sndio support':   sndio}
-elif targetos == 'darwin'
-  summary_info += {'CoreAudio support': coreaudio}
-elif targetos == 'windows'
-  summary_info += {'DirectSound support': dsound}
-endif
-if targetos == 'linux'
-  summary_info += {'ALSA support':    alsa}
-  summary_info += {'PulseAudio support': pulse}
-endif
-summary_info += {'Pipewire support':   pipewire}
-summary_info += {'JACK support':      jack}
 summary_info += {'Linux AIO support': libaio}
 summary_info += {'Linux io_uring support': linux_io_uring}
 summary_info += {'ATTR/XATTR support': libattr}
-- 
2.31.1


