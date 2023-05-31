Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4980718A80
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:50:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4RoK-00018D-O8; Wed, 31 May 2023 15:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RoH-00017I-U5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4RoG-0002ch-AZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685562519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98jvU+feCca0uj4rnXF3/XaM0gWQFkEqAbMLDmu3sSg=;
 b=fCK75eS4TNlP+RLym4xCiyhMTN6U5/WqVfzqhvEztg7uwDpQdEz9V8U7YSKM55nKOnhf8q
 GudAm3UlX/WsRrPkHKheBOQ0Bd0ZpGJ4MbxK2WIVWcElvEc4ZW3PzDnU1NagMIDtwthRsJ
 BEK65q9pCIsOo2n3CkLR54l2gsyrsRE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-ObhguJkPO8iJjr858M8Rng-1; Wed, 31 May 2023 15:48:34 -0400
X-MC-Unique: ObhguJkPO8iJjr858M8Rng-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D0B528EA6E4;
 Wed, 31 May 2023 19:48:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03DC5492B0A;
 Wed, 31 May 2023 19:48:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, libvir-list@redhat.com,
 Greg Kurz <groug@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/11] qapi: make the vcpu parameters deprecated for 8.1
Date: Wed, 31 May 2023 15:48:10 -0400
Message-Id: <20230531194815.1508961-7-stefanha@redhat.com>
In-Reply-To: <20230531194815.1508961-1-stefanha@redhat.com>
References: <20230531194815.1508961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

From: Alex Bennée <alex.bennee@linaro.org>

I don't think I can remove the parameters directly but certainly mark
them as deprecated.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230526165401.574474-7-alex.bennee@linaro.org
Message-Id: <20230524133952.3971948-6-alex.bennee@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/about/deprecated.rst |  7 +++++++
 qapi/trace.json           | 40 +++++++++++++++++----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7c45a64363..0743459862 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -226,6 +226,13 @@ QEMU Machine Protocol (QMP) events
 
 Use the more generic event ``DEVICE_UNPLUG_GUEST_ERROR`` instead.
 
+``vcpu`` trace events (since 8.1)
+'''''''''''''''''''''''''''''''''
+
+The ability to instrument QEMU helper functions with vCPU-aware trace
+points was removed in 7.0. However QMP still exposed the vcpu
+parameter. This argument has now been deprecated and the remaining
+remaining trace points that used it are selected just by name.
 
 Human Monitor Protocol (HMP) commands
 -------------------------------------
diff --git a/qapi/trace.json b/qapi/trace.json
index 6bf0af0946..39b752fc88 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -37,13 +37,14 @@
 #
 # @vcpu: Whether this is a per-vCPU event (since 2.7).
 #
-# An event is per-vCPU if it has the "vcpu" property in the
-# "trace-events" files.
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always ignored.
 #
 # Since: 2.2
 ##
 { 'struct': 'TraceEventInfo',
-  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool'} }
+  'data': {'name': 'str', 'state': 'TraceEventState',
+           'vcpu': { 'type': 'bool', 'features': ['deprecated'] } } }
 
 ##
 # @trace-event-get-state:
@@ -52,19 +53,15 @@
 #
 # @name: Event name pattern (case-sensitive glob).
 #
-# @vcpu: The vCPU to query (any by default; since 2.7).
+# @vcpu: The vCPU to query (since 2.7).
+#
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always ignored.
 #
 # Returns: a list of @TraceEventInfo for the matching events
 #
-# An event is returned if:
-#
-# - its name matches the @name pattern, and
-# - if @vcpu is given, the event has the "vcpu" property.
-#
-# Therefore, if @vcpu is given, the operation will only match per-vCPU
-# events, returning their state on the specified vCPU. Special case:
-# if @name is an exact match, @vcpu is given and the event does not
-# have the "vcpu" property, an error is returned.
+# An event is returned if its name matches the @name pattern
+# (There are no longer any per-vCPU events).
 #
 # Since: 2.2
 #
@@ -75,7 +72,8 @@
 # <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu": false } ] }
 ##
 { 'command': 'trace-event-get-state',
-  'data': {'name': 'str', '*vcpu': 'int'},
+  'data': {'name': 'str',
+           '*vcpu': {'type': 'int', 'features': ['deprecated'] } },
   'returns': ['TraceEventInfo'] }
 
 ##
@@ -91,15 +89,11 @@
 #
 # @vcpu: The vCPU to act upon (all by default; since 2.7).
 #
-# An event's state is modified if:
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always ignored.
 #
-# - its name matches the @name pattern, and
-# - if @vcpu is given, the event has the "vcpu" property.
-#
-# Therefore, if @vcpu is given, the operation will only match per-vCPU
-# events, setting their state on the specified vCPU. Special case: if
-# @name is an exact match, @vcpu is given and the event does not have
-# the "vcpu" property, an error is returned.
+# An event is enabled if its name matches the @name pattern
+# (There are no longer any per-vCPU events).
 #
 # Since: 2.2
 #
@@ -111,4 +105,4 @@
 ##
 { 'command': 'trace-event-set-state',
   'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool',
-           '*vcpu': 'int'} }
+           '*vcpu': {'type': 'int', 'features': ['deprecated'] } } }
-- 
2.40.1


