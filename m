Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7448570DCFE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:51:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTJ-0007aR-O6; Tue, 23 May 2023 08:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTH-0007Zv-FH
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RT9-0005JK-Oo
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so7279430f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846203; x=1687438203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HT3f4xlRu6XVFJkMQtmY/b219drXYZCMSK1yobPtGSc=;
 b=VEnn+TtFjS209pYt4om9ePQA+TTPEwY4kDZixKmPGWC/m1um9m3ikj0tna3TrhrPlA
 EmpjlCAyPkCd/7crq8lF/SJ/YAkqUKFetDx65Hi4tcpiigU1Kq9harm1uwed4ZS9SrV8
 jIomNhXveCUdj1Ap7NdlZEjLDWxVldvGMNCqppDP5ZUdKzt9LBKuKG4UY39fdMp66RK8
 /JOx9Mqist8SWWpuSF76L2n29sOmcpw3GU6Ht81Aq+uwMDU2VYSVuzCxcLeVvAUh/JLI
 LXM9TFFzRHfK+6TpfXG5YOJ6akkKC6VHOamOvooCjRPuVBySzYDtvhGOzgiwTf66dIFL
 Qe6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846203; x=1687438203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HT3f4xlRu6XVFJkMQtmY/b219drXYZCMSK1yobPtGSc=;
 b=I389/sBtTNYdFRBdmvGRC+aPd6YiAp8EskzmEKh5dU+ks5SlLTJSQr1z0aA3MY4BqI
 ZotLuPtAHaBv2280DYB9JqCifDsGPvgrz+0Cu7qU5z3K9TMlDMX4x3POH5U8rrzfAUmH
 6v3vzNNIi2bAn5SroEArZzQDKfcQGch5mVj0Reza/DK16awsHgksNE0b+35fNlMnHYQv
 2A75QyYCGsAoarcH7Dalk5lhf3xWYuYEK2nDHYD+I31hRA/1QJ/RdTg7C280xB+xtdK8
 KaX4Tn4v31iIc0HemVuUKTJEMqN75uzEul563tLCkXqtBQrBnysTHKa2NlXWjwmbk6zX
 owcQ==
X-Gm-Message-State: AC+VfDyA2HK2x2MdRjw0jhMry24yt9mYuN9iLhamnVZLYeOH2NcPncdp
 GOIQq62i0ovJ+QGNAOMUkKddKw==
X-Google-Smtp-Source: ACHHUZ5Pwrb2dCfBCiTML5D8Zroll25PTxfJRBwjg1Iy90s+3BMF0o6iVSHkgYuOH9wd1Cyh/OC/pA==
X-Received: by 2002:a5d:45c4:0:b0:309:3ddc:1c8d with SMTP id
 b4-20020a5d45c4000000b003093ddc1c8dmr8660172wrs.70.1684846203637; 
 Tue, 23 May 2023 05:50:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a5d640c000000b00307c8d6b4a0sm10995580wru.26.2023.05.23.05.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EFB21FFC0;
 Tue, 23 May 2023 13:50:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 05/10] qapi: make the vcpu parameters deprecated for 8.1
Date: Tue, 23 May 2023 13:49:55 +0100
Message-Id: <20230523125000.3674739-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523125000.3674739-1-alex.bennee@linaro.org>
References: <20230523125000.3674739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Message-Id: <20230420150009.1675181-6-alex.bennee@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230503091756.1453057-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230505155336.137393-6-alex.bennee@linaro.org>

---
v4
  - used @deprecated in json
  - added note to deprecated.rst
---
 docs/about/deprecated.rst |  9 +++++++++
 qapi/trace.json           | 38 ++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 20 deletions(-)

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
index 6bf0af0946..aac58e875b 100644
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
@@ -52,19 +53,17 @@
 #
 # @name: Event name pattern (case-sensitive glob).
 #
-# @vcpu: The vCPU to query (any by default; since 2.7).
+# @vcpu: The vCPU to query (since 2.7).
+#
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always false.
 #
 # Returns: a list of @TraceEventInfo for the matching events
 #
 # An event is returned if:
 #
-# - its name matches the @name pattern, and
-# - if @vcpu is given, the event has the "vcpu" property.
-#
-# Therefore, if @vcpu is given, the operation will only match per-vCPU
-# events, returning their state on the specified vCPU. Special case:
-# if @name is an exact match, @vcpu is given and the event does not
-# have the "vcpu" property, an error is returned.
+# - its name matches the @name pattern
+#   There are no longer any per-vCPU events
 #
 # Since: 2.2
 #
@@ -75,7 +74,8 @@
 # <- { "return": [ { "name": "qemu_memalign", "state": "disabled", "vcpu": false } ] }
 ##
 { 'command': 'trace-event-get-state',
-  'data': {'name': 'str', '*vcpu': 'int'},
+  'data': {'name': 'str',
+           '*vcpu': {'type': 'int', 'features': ['deprecated'] } },
   'returns': ['TraceEventInfo'] }
 
 ##
@@ -91,15 +91,13 @@
 #
 # @vcpu: The vCPU to act upon (all by default; since 2.7).
 #
-# An event's state is modified if:
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always false.
 #
-# - its name matches the @name pattern, and
-# - if @vcpu is given, the event has the "vcpu" property.
+# An event's state is modified if:
 #
-# Therefore, if @vcpu is given, the operation will only match per-vCPU
-# events, setting their state on the specified vCPU. Special case: if
-# @name is an exact match, @vcpu is given and the event does not have
-# the "vcpu" property, an error is returned.
+# - its name matches the @name pattern
+#   There are no longer any per-vCPU events
 #
 # Since: 2.2
 #
@@ -111,4 +109,4 @@
 ##
 { 'command': 'trace-event-set-state',
   'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool',
-           '*vcpu': 'int'} }
+           '*vcpu': {'type': 'int', 'features': ['deprecated'] } } }
-- 
2.39.2


