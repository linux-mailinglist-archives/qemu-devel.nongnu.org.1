Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20547712B30
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:55:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ahi-0002zN-RT; Fri, 26 May 2023 12:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahd-0002w8-0c
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahb-0002G9-7s
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30aa1eb95a0so878161f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120046; x=1687712046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQ4C0OH2eXL3stB8nBityndanYvrzr6EMyO8JmAb43Q=;
 b=JSciatZzZT+/LKY+y2KMXH0kosb+UexjoTuKmWDeQhMg+M8fhDC4D+T2zX3FQMnYt8
 4Sefc2oCh5mAc10Aw8zlMMhMuTEP/gKy99sYIQ0UnATZhio4p85UD+CA8tlx+vSHjEdI
 VXpox2/Qjm6vRGnzWyj9YWZCrGFtZPB8bY+gxXPFlz2SiNsJAxprUAlr0ylHXgjAUa/k
 vwTFcauy1gn5fbuB4aRlpbPKV+vj+uWMbJMuFEhUwLd8vSjgOcYJKvFx75THaEBml3TR
 kekYiLQPwbiNsQl0J2w5rpbRTyYwMGXjNRR75B3TK5t06+RGwNv2xdokByb8wmxdsMFf
 7/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120046; x=1687712046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQ4C0OH2eXL3stB8nBityndanYvrzr6EMyO8JmAb43Q=;
 b=HykILAWyjq9PdEvc0ZZ+dfg5uCnS5VxUR7/6uWIWXAwmWC85HEp4LmgtYZh9l9CFfC
 6JjT53kDExs7Rm5bKPZASoyCVOSe+/GaF+NbD5PNXk/y9kR/7RRgGo43sT5LHVFIRthC
 FmGw5/ECx7/1LinXc5fEZPEfdtd5XUw96+ohFWGAYaZPES5Z/qpvEmbzGtyQuPiTgcJK
 NaT8IUb51dSbfnYqFxF2Zt8AsRh42bMwbxSh0WVXegBln/i+cOSNxdlDQImR6p9flZmj
 WBj18DDXenKBrKhNtqRF+8SFxzlsPCT3aBcVNn+lqV6GZhcLEAq+CwByVioWAUPuqToe
 BOfw==
X-Gm-Message-State: AC+VfDwXWYqmHMJhNswUS6AI3AX2WqXxnne8ardyANHzdcDDwq+1Fron
 bDm3b92IdEis7sRZ+VMEKBa5Qw==
X-Google-Smtp-Source: ACHHUZ5eceDSZOhMP8OXzX8FmEtpFASs3JOtlPla8NLP2sO/kFtqnu+PwhgZ6fWG9Drt7COSWnUKUQ==
X-Received: by 2002:adf:f604:0:b0:30a:9043:8f1d with SMTP id
 t4-20020adff604000000b0030a90438f1dmr1570311wrp.5.1685120045787; 
 Fri, 26 May 2023 09:54:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a5d540e000000b00307a86a4bcesm5659872wrv.35.2023.05.26.09.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:54:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8C651FFBF;
 Fri, 26 May 2023 17:54:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 06/11] qapi: make the vcpu parameters deprecated for 8.1
Date: Fri, 26 May 2023 17:53:56 +0100
Message-Id: <20230526165401.574474-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526165401.574474-1-alex.bennee@linaro.org>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
Message-Id: <20230524133952.3971948-6-alex.bennee@linaro.org>

---
v6
  - s/QAPI/QMP/
  - /and always false./and always ignored./
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
 #
-# Returns: a list of @TraceEventInfo for the matching events
-#
-# An event is returned if:
+# Features:
+# @deprecated: Member @vcpu is deprecated, and always ignored.
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
+# @deprecated: Member @vcpu is deprecated, and always ignored.
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


