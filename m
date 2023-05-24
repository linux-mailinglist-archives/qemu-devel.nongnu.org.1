Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8F570F7EE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:41:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oik-0008KL-Cp; Wed, 24 May 2023 09:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oie-0008DA-Dj
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:40:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oib-0003m7-Rg
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:39:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3078a3f3b5fso853753f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684935596; x=1687527596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8t/+YNw/1eSOPZpziklGn9RfJ8rpI03v6Iz3JI+Nis=;
 b=c7r/IPmz4+dCI2ecMOxeIYY/cmrdZ0Ww4+tpx2GLjdV6yJ/zaBwYChz3kF1lRfksR8
 zbTdA64H1xf8fI9rNnph1G3cysabyea57TSuTI4iRwYCzhVUmVojzxaDXweixWgjWWQu
 bLDrTzeLUoLzv+YbAW2/2a2YSoHNPvpGOj3p09mgbuvy5+f/bOxKphmtpBIo/fMW2Dzp
 cOw5Rbwh57is3ULKQmc8eI62IWI8tkPTUlgJ4GIKxdqKc1cT8JG9HyB8liS6G2OhdOnk
 7oYFef9EQGZbQkckzPAklUwuQO46990P+ZetUZJ9ebod/JzcRdVtD6w9oIFhjSFOfEpz
 vQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684935596; x=1687527596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8t/+YNw/1eSOPZpziklGn9RfJ8rpI03v6Iz3JI+Nis=;
 b=QLJ832G2iYayHFtMeTj5VUM7zWOiTK5gn0+tKqcFi/AU9aTMfHV0Z6Atxfe95jaZJV
 1jKiE2bfQwzyGJu9CeEzRZXsiFFGwung+68boBQDYopdYa0fjVkPs072GlbIHzWSH1KY
 BPeZ8xNP8asrn4LdGNSMx4tPyz0OnY4NSTrBAhkwyy4B2bE6ZbE8OxfIFnfVuNtT4rJv
 oQk4/gdMJgduK7ucAjkjCVWeXUlgaVQ8d5J7eIdvLre3I8IH8hSkh/8TvbKvtX1ll6Ov
 laq6e/28Ck4h8NA7trNVcZu6k30rfZJL7bf4vC66xoSEboRttn47/JOB6amEEXnYVFrE
 VPjQ==
X-Gm-Message-State: AC+VfDzrdfBnaazp3/5sZIexhEAgRGgSOkf6iC/Yc2p5oJbx3Si1YkX/
 iYez+l5YQS4Ih4kB0/3JSk+NSA==
X-Google-Smtp-Source: ACHHUZ7WiV4ar2GeoaU5mLZzfpI9+F9Q6tNauywUrRvQOGndNRpx3D/pxBEcmO0iBYQa0aWt43JvVQ==
X-Received: by 2002:a5d:6ace:0:b0:306:3945:65e9 with SMTP id
 u14-20020a5d6ace000000b00306394565e9mr13786975wrw.3.1684935596080; 
 Wed, 24 May 2023 06:39:56 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y10-20020adff6ca000000b002f103ca90cdsm14555961wrp.101.2023.05.24.06.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 06:39:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7F1751FFC0;
 Wed, 24 May 2023 14:39:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 05/10] qapi: make the vcpu parameters deprecated for 8.1
Date: Wed, 24 May 2023 14:39:47 +0100
Message-Id: <20230524133952.3971948-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524133952.3971948-1-alex.bennee@linaro.org>
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

I don't think I can remove the parameters directly but certainly mark
them as deprecated.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230523125000.3674739-6-alex.bennee@linaro.org>

---
v5
  - reword match description
  - fix reference to return for set operation
---
 docs/about/deprecated.rst |  9 +++++++++
 qapi/trace.json           | 40 +++++++++++++++++----------------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e934e0a13a..e44cde057f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -254,6 +254,15 @@ it. Since all recent x86 hardware from the past >10 years is capable of the
 QEMU API (QAPI) events
 ----------------------
 
+``vcpu`` trace events (since 8.1)
+'''''''''''''''''''''''''''''''''
+
+The ability to instrument QEMU helper functions with vcpu aware trace
+points was removed in 7.0. However the QAPI still exposed the vcpu
+parameter. This argument has now been deprecated and the remaining
+used trace points converted to plain trace points selected just by
+name.
+
 ``MEM_UNPLUG_ERROR`` (since 6.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/qapi/trace.json b/qapi/trace.json
index 6bf0af0946..e561f3d3da 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -37,13 +37,14 @@
 #
 # @vcpu: Whether this is a per-vCPU event (since 2.7).
 #
-# An event is per-vCPU if it has the "vcpu" property in the
-# "trace-events" files.
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always false.
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
 #
-# Returns: a list of @TraceEventInfo for the matching events
-#
-# An event is returned if:
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always false.
 #
-# - its name matches the @name pattern, and
-# - if @vcpu is given, the event has the "vcpu" property.
+# Returns: a list of @TraceEventInfo for the matching events
 #
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
-#
-# - its name matches the @name pattern, and
-# - if @vcpu is given, the event has the "vcpu" property.
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always false.
 #
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
2.39.2


