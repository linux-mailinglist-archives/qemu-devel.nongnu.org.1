Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC72399CBBD
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Oct 2024 15:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LKI-0002mG-4n; Mon, 14 Oct 2024 09:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LJk-0002OF-5u
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LJi-00042c-Dq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728913257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QaqMtwz/SiIH8E539RyAF5MUt55FMFDu8YMxQ2hY+1s=;
 b=TLIk3WV8OwnNAPSkH649OdmqAk8qEwycMo8pNwVoJ8VAMTY1FdY+mWVN2w8UscXiP1w5by
 wzCVTPd1NNjJHuMgLACJI2Dh5DrGPI+DvJCG5B3AvxN7WTHWe3p1F3+ksPhTIyLUGc6NLM
 urFP/QyuR1ofkj6uOH3LmILxFxVsnug=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-a8gTg2m1OK2RIVhdzmn-rA-1; Mon,
 14 Oct 2024 09:40:55 -0400
X-MC-Unique: a8gTg2m1OK2RIVhdzmn-rA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 544DD19560B4; Mon, 14 Oct 2024 13:40:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.12])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55AB219560AA; Mon, 14 Oct 2024 13:40:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 15/20] ui/dbus: add Listener.Unix.Map interface XML
Date: Mon, 14 Oct 2024 17:39:30 +0400
Message-ID: <20241014133935.470709-16-marcandre.lureau@redhat.com>
In-Reply-To: <20241014133935.470709-1-marcandre.lureau@redhat.com>
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-16-marcandre.lureau@redhat.com>
---
 ui/dbus-display1.xml | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index d5bb279698..e70f2848b7 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -469,6 +469,53 @@
     <property name="Interfaces" type="as" access="read"/>
   </interface>
 
+  <!--
+      org.qemu.Display1.Listener.Unix.Map:
+
+      This optional client-side interface can complement
+      org.qemu.Display1.Listener on ``/org/qemu/Display1/Listener`` for
+      Unix-specific shared memory scanouts.
+  -->
+  <?if $(env.HOST_OS) != windows?>
+  <interface name="org.qemu.Display1.Listener.Unix.Map">
+    <!--
+        ScanoutMap:
+        @handle: the shared map FD.
+        @offset: mapping offset, in bytes.
+        @width: display width, in pixels.
+        @height: display height, in pixels.
+        @stride: stride, in bytes.
+        @pixman_format: image format (ex: ``PIXMAN_X8R8G8B8``).
+
+        Resize and update the display content with a shared map.
+    -->
+    <method name="ScanoutMap">
+      <arg type="h" name="handle" direction="in"/>
+      <arg type="u" name="offset" direction="in"/>
+      <arg type="u" name="width" direction="in"/>
+      <arg type="u" name="height" direction="in"/>
+      <arg type="u" name="stride" direction="in"/>
+      <arg type="u" name="pixman_format" direction="in"/>
+    </method>
+
+    <!--
+        UpdateMap:
+        @x: the X update position, in pixels.
+        @y: the Y update position, in pixels.
+        @width: the update width, in pixels.
+        @height: the update height, in pixels.
+
+        Update the display content with the current shared map and the given region.
+    -->
+    <method name="UpdateMap">
+      <arg type="i" name="x" direction="in"/>
+      <arg type="i" name="y" direction="in"/>
+      <arg type="i" name="width" direction="in"/>
+      <arg type="i" name="height" direction="in"/>
+    </method>
+  </interface>
+  <?endif?>
+
   <!--
       org.qemu.Display1.Listener.Win32.Map:
 
-- 
2.47.0


