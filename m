Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E22A25A35
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 13:58:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tew1p-0006Qw-G4; Mon, 03 Feb 2025 07:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tew1i-0006OQ-4a
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tew1g-0006p4-MN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738587488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuOXz/FMmveVaX83PK8mbmXnusd2fVvNMvvztVwsWN4=;
 b=NMARCH0Uyb0/gxzcWjOOT+sgaz09EY2hAkWjrwAtW0/z5I3Wehp2O1K2dTv9RSrz2ZGY7u
 Wlt9gDNynOaF0KE4Ga4LIBoQncOi6KJyiEt0SiWhDG1WIqLzweH/oCgbDVws05KGWiUFRI
 NWZqCwPTtHDmRCLZ/Nn/AZ43cdktPDQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Cl_GoYB4Mz2dkg6v8s8Ehw-1; Mon,
 03 Feb 2025 07:58:04 -0500
X-MC-Unique: Cl_GoYB4Mz2dkg6v8s8Ehw-1
X-Mimecast-MFC-AGG-ID: Cl_GoYB4Mz2dkg6v8s8Ehw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A38419560B8; Mon,  3 Feb 2025 12:58:02 +0000 (UTC)
Received: from localhost (unknown [10.39.208.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53C7830001BE; Mon,  3 Feb 2025 12:58:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org,
 Gerd Hoffmann <kraxel@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 6/8] ui/dbus: clarify the kind of win32 handle that is shared
Date: Mon,  3 Feb 2025 16:57:18 +0400
Message-ID: <20250203125721.640451-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250203125721.640451-1-marcandre.lureau@redhat.com>
References: <20250203125721.640451-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

"-display dbus" hands over a file mapping handle to the peer
process (not a file handle).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-display1.xml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index e70f2848b7..d702253431 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -527,14 +527,14 @@
   <interface name="org.qemu.Display1.Listener.Win32.Map">
     <!--
         ScanoutMap:
-        @handle: the shared map handle value.
+        @handle: the shared file mapping handle value (not a file handle)
         @offset: mapping offset.
         @width: display width, in pixels.
         @height: display height, in pixels.
         @stride: stride, in bytes.
         @pixman_format: image format (ex: ``PIXMAN_X8R8G8B8``).
 
-        Resize and update the display content with a shared map.
+        Resize and update the display content with a shared file mapping object.
     -->
     <method name="ScanoutMap">
       <arg type="t" name="handle" direction="in"/>
-- 
2.47.0


