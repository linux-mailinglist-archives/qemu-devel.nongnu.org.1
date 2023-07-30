Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36075768432
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 09:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ07s-00053J-IU; Sun, 30 Jul 2023 02:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQ07J-00050R-MZ
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:41:26 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1qQ07H-00065O-T4
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 02:41:25 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-40648d758f1so24957981cf.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 23:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690699282; x=1691304082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dI0gdpPKANQUK3lyruxPBH4LnSOmWsKb8Vgds5YhBjQ=;
 b=Kkom9EQb4yMB6hqvBYeUR1rZwZDCrai/GRnmHksucKUwqMpU6vvTKNRdIWsQGcG260
 HluAvEMIQw5Hqtq8MTktNiJRWin9phoLEJGi3dE2XKruZIkXWu/wljfZ9sVDtZKHiai4
 iHgEiJcy9+dCxx/EDiXxiYoKZugDDr2wfVCfyrmBdWmobGk5FQbw7EH2E/DMbei7Nhk/
 ofDixx7oTNjmgHyQ/svhUlFlgfhvDi9qBFJDE/sIdZ5d2yiTP2fVzFRjgx/6nuYtbunP
 MUtOgiZSTxSGCDsq1foZS15/XQxzTtwKLMmK0daEUSC1BU52cBwPR94uLg9zvoV9Sfv6
 +obA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690699282; x=1691304082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dI0gdpPKANQUK3lyruxPBH4LnSOmWsKb8Vgds5YhBjQ=;
 b=ggWXBSTzyzBNv5pOdFLUrFQEs5Dv+CsNzRIhP6FbgqKRR/J/VPBB+5RQsqoPTPboeZ
 URYbro+r+xhpLupht6Pk75FUzxxTOfB/s0a4euXKf0IL/mRXF5GXkbLxzhAzvHBHCmN+
 2KXxtWEcdM77sh3kzyKU8Mdo7KVxpd6emHxs2+r8MLnWaPVdrz3EZX5ClbLjLgHHUocO
 orWerEs5PEGf+34h51rr3n9RvJ/S6w9VBxXTmtKnGaC/nCaMQMpQKWEXX3QH+gfghsXK
 QU7oCwWxHL/tPCk89zo49RghRg3nY9u4YMwmTJwGi26mDGIFsbVtcgElD9DzkC8GLnW1
 vvbA==
X-Gm-Message-State: ABy/qLYG+58lo2oYXRZmbJaJfv6OS5MlX2Wg2s8Ze+4fTbLbS5ISWCqz
 tXX6m1jnijNiPuzsFen4dFAvAOUGqVRpBg==
X-Google-Smtp-Source: APBJJlEPfOEB+/Zx1QqmVSfslVzIDOlk9ggrIgqH5KDfmh4q3okahhkh/asvNvoGYzklowAWwkH2cw==
X-Received: by 2002:ac8:5887:0:b0:401:e423:3ef4 with SMTP id
 t7-20020ac85887000000b00401e4233ef4mr9950841qta.63.1690699282575; 
 Sat, 29 Jul 2023 23:41:22 -0700 (PDT)
Received: from debian.hsd1.ma.comcast.net ([2601:182:cc00:77b0::aecb])
 by smtp.gmail.com with ESMTPSA id
 oq7-20020a05620a610700b00767c961eb47sm2347254qkn.43.2023.07.29.23.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 23:41:22 -0700 (PDT)
From: Dinah Baum <dinahbaum123@gmail.com>
To: qemu-devel@nongnu.org
Cc: Dinah Baum <dinahbaum123@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v3 1/3] qapi: Moved architecture agnostic data types to
 `machine`
Date: Sun, 30 Jul 2023 02:40:55 -0400
Message-Id: <20230730064057.357598-2-dinahbaum123@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230730064057.357598-1-dinahbaum123@gmail.com>
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=dinahbaum123@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Dinah Baum <dinahbaum123@gmail.com>
---
 qapi/machine-target.json | 78 +---------------------------------------
 qapi/machine.json        | 77 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f0a6b72414..3ee2f7ca6b 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -4,83 +4,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
-##
-# @CpuModelInfo:
-#
-# Virtual CPU model.
-#
-# A CPU model consists of the name of a CPU definition, to which delta
-# changes are applied (e.g. features added/removed). Most magic values
-# that an architecture might require should be hidden behind the name.
-# However, if required, architectures can expose relevant properties.
-#
-# @name: the name of the CPU definition the model is based on
-#
-# @props: a dictionary of QOM properties to be applied
-#
-# Since: 2.8
-##
-{ 'struct': 'CpuModelInfo',
-  'data': { 'name': 'str',
-            '*props': 'any' } }
-
-##
-# @CpuModelExpansionType:
-#
-# An enumeration of CPU model expansion types.
-#
-# @static: Expand to a static CPU model, a combination of a static
-#     base model name and property delta changes.  As the static base
-#     model will never change, the expanded CPU model will be the
-#     same, independent of QEMU version, machine type, machine
-#     options, and accelerator options.  Therefore, the resulting
-#     model can be used by tooling without having to specify a
-#     compatibility machine - e.g. when displaying the "host" model.
-#     The @static CPU models are migration-safe.
-#
-# @full: Expand all properties.  The produced model is not guaranteed
-#     to be migration-safe, but allows tooling to get an insight and
-#     work with model details.
-#
-# Note: When a non-migration-safe CPU model is expanded in static
-#     mode, some features enabled by the CPU model may be omitted,
-#     because they can't be implemented by a static CPU model
-#     definition (e.g. cache info passthrough and PMU passthrough in
-#     x86). If you need an accurate representation of the features
-#     enabled by a non-migration-safe CPU model, use @full.  If you
-#     need a static representation that will keep ABI compatibility
-#     even when changing QEMU version or machine-type, use @static
-#     (but keep in mind that some features may be omitted).
-#
-# Since: 2.8
-##
-{ 'enum': 'CpuModelExpansionType',
-  'data': [ 'static', 'full' ] }
-
-##
-# @CpuModelCompareResult:
-#
-# An enumeration of CPU model comparison results.  The result is
-# usually calculated using e.g. CPU features or CPU generations.
-#
-# @incompatible: If model A is incompatible to model B, model A is not
-#     guaranteed to run where model B runs and the other way around.
-#
-# @identical: If model A is identical to model B, model A is
-#     guaranteed to run where model B runs and the other way around.
-#
-# @superset: If model A is a superset of model B, model B is
-#     guaranteed to run where model A runs.  There are no guarantees
-#     about the other way.
-#
-# @subset: If model A is a subset of model B, model A is guaranteed to
-#     run where model B runs.  There are no guarantees about the other
-#     way.
-#
-# Since: 2.8
-##
-{ 'enum': 'CpuModelCompareResult',
-  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
+{ 'include': 'machine.json' }
 
 ##
 # @CpuModelBaselineInfo:
diff --git a/qapi/machine.json b/qapi/machine.json
index a08b6576ca..192c781310 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1691,3 +1691,80 @@
 { 'command': 'dumpdtb',
   'data': { 'filename': 'str' },
   'if': 'CONFIG_FDT' }
+
+##
+# @CpuModelInfo:
+#
+# Virtual CPU model.
+#
+# A CPU model consists of the name of a CPU definition, to which delta
+# changes are applied (e.g. features added/removed). Most magic values
+# that an architecture might require should be hidden behind the name.
+# However, if required, architectures can expose relevant properties.
+#
+# @name: the name of the CPU definition the model is based on
+#
+# @props: a dictionary of QOM properties to be applied
+#
+# Since: 2.8
+##
+{ 'struct': 'CpuModelInfo',
+  'data': { 'name': 'str', '*props': 'any' } }
+
+##
+# @CpuModelExpansionType:
+#
+# An enumeration of CPU model expansion types.
+#
+# @static: Expand to a static CPU model, a combination of a static
+#     base model name and property delta changes.  As the static base
+#     model will never change, the expanded CPU model will be the
+#     same, independent of QEMU version, machine type, machine
+#     options, and accelerator options.  Therefore, the resulting
+#     model can be used by tooling without having to specify a
+#     compatibility machine - e.g. when displaying the "host" model.
+#     The @static CPU models are migration-safe.
+#
+# @full: Expand all properties.  The produced model is not guaranteed
+#     to be migration-safe, but allows tooling to get an insight and
+#     work with model details.
+#
+# Note: When a non-migration-safe CPU model is expanded in static
+#     mode, some features enabled by the CPU model may be omitted,
+#     because they can't be implemented by a static CPU model
+#     definition (e.g. cache info passthrough and PMU passthrough in
+#     x86). If you need an accurate representation of the features
+#     enabled by a non-migration-safe CPU model, use @full.  If you
+#     need a static representation that will keep ABI compatibility
+#     even when changing QEMU version or machine-type, use @static
+#     (but keep in mind that some features may be omitted).
+#
+# Since: 2.8
+##
+{ 'enum': 'CpuModelExpansionType',
+  'data': [ 'static', 'full' ] }
+
+##
+# @CpuModelCompareResult:
+#
+# An enumeration of CPU model comparison results.  The result is
+# usually calculated using e.g.  CPU features or CPU generations.
+#
+# @incompatible: If model A is incompatible to model B, model A is not
+#     guaranteed to run where model B runs and the other way around.
+#
+# @identical: If model A is identical to model B, model A is
+#     guaranteed to run where model B runs and the other way around.
+#
+# @superset: If model A is a superset of model B, model B is
+#     guaranteed to run where model A runs.  There are no guarantees
+#     about the other way.
+#
+# @subset: If model A is a subset of model B, model A is guaranteed to
+#     run where model B runs.  There are no guarantees about the other
+#     way.
+#
+# Since: 2.8
+##
+{ 'enum': 'CpuModelCompareResult',
+  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
-- 
2.30.2


