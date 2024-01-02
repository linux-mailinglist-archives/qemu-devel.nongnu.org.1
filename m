Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70E3821F2F
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:05:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKhGk-0006K2-H9; Tue, 02 Jan 2024 11:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGY-0006Gg-1g
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKhGS-0002cW-Th
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:05:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d5b89e2bfso56729165e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704211511; x=1704816311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufonMTH/Sl8kmFdoBgYSf3okj9N+8Wa+NSxI0KCId+c=;
 b=D1llJWyGhZgFxn3O2fUJEH05tVzdAkpeFyOfCxiUWfIyhoaJ6XD+ovIJKi+cSAc/na
 oCEwjCsJjOVzfue1dERqMHkBmP0ZeU47qtZf40eJb8ChQxGqpp0614Zd1NuuiPNhh+dL
 XGPvzbiCu9G/Dsopzsm+e85Es7B0fCJh2zAc1JOBxxIHZVqin1YtoulBbVUlvzEbu3Mv
 3vAif3PBo/OjNhH0Gs1g3gaX6bol55Z45uuNAspe6Br2h+pbCqQymOrzfr1Wk6Ka/lWY
 t/kXvLBIE0j9CdTiHEAaPmizxBFphCdTubarCDlYhAZMjbWnnw6rM8EpMDMMmMQrxOkq
 LMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704211511; x=1704816311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufonMTH/Sl8kmFdoBgYSf3okj9N+8Wa+NSxI0KCId+c=;
 b=rwbyIZUQEYBHh43jeEMoQSzKv5NqVKYemgtvDObc1eU3ekjkj+yO7EhxMnCFsWu0en
 NborIQSxVgivfwA/PdaPjTlGd5Sa4SgAnhD+M11lPo9MH41y+5mt58wHzwpmljrS3i67
 Qw4WhUdo3zJydDUpyPew0EfmnWpOA15WYUWS5GZk+BX9prJy5GGTVlnsKXEbuDFs2rhY
 r1ruZ71ayVeZudwo/1+Qr9xZmejr1GTlqrNp3uqPkjE3pZbv0MAkrugapzRWONmhZB4M
 uVk1Aiz4VuyE8SsFeNSlXubttr7WWRZZVjUhHEOWU8bKEObjM/fS7CudvHSSIvEiw4hp
 LoyQ==
X-Gm-Message-State: AOJu0Yyzgv7CSkv/+2fbZ5pjA6J7LeBvgG/LXD6ij8Zm/BR8C/prySQ7
 +qKYrsII4rK17R7FH53BTlaHZPnsOPc2TEvJVX33YGoOHXQ=
X-Google-Smtp-Source: AGHT+IEfenUzNg89P4j1gidzONQnhOe9H3bTMyqqyOK78NSJs8PafFY6IIv5Fgxey5SLF3EwUAq+cw==
X-Received: by 2002:a05:600c:520c:b0:40d:8a04:a134 with SMTP id
 fb12-20020a05600c520c00b0040d8a04a134mr934490wmb.79.1704211511039; 
 Tue, 02 Jan 2024 08:05:11 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 bg29-20020a05600c3c9d00b0040d6d755c90sm19136952wmb.42.2024.01.02.08.05.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 08:05:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Frederic Konrad <fkonrad@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/5] qdev-properties: Add OptionalBool QAPI type
Date: Tue,  2 Jan 2024 17:04:51 +0100
Message-ID: <20240102160455.68612-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102160455.68612-1-philmd@linaro.org>
References: <20240102160455.68612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

To be able to distinct whether a boolean qdev property
has been set or not, add the DEFINE_PROP_BOOL_NODEFAULT()
qdev macro based on the tri-state OptionalBool QAPI type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/common.json             | 16 ++++++++++++++++
 include/hw/qdev-properties.h |  5 +++++
 hw/core/qdev-properties.c    | 10 ++++++++++
 3 files changed, 31 insertions(+)

diff --git a/qapi/common.json b/qapi/common.json
index 6fed9cde1a..884c143e2a 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -207,3 +207,19 @@
 ##
 { 'struct': 'HumanReadableText',
   'data': { 'human-readable-text': 'str' } }
+
+##
+# @OptionalBool:
+#
+# An enumeration of three options: true, false, and unset
+#
+# @unset: Unset (default)
+#
+# @false: False
+#
+# @true: True
+#
+# Since: 9.0
+##
+{ 'enum': 'OptionalBool',
+  'data': [ 'false', 'true', 'unset' ] }
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 0e1930177e..8cf95da2c3 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -49,6 +49,7 @@ struct PropertyInfo {
 extern const PropertyInfo qdev_prop_bit;
 extern const PropertyInfo qdev_prop_bit64;
 extern const PropertyInfo qdev_prop_bool;
+extern const PropertyInfo qdev_prop_bool_unset;
 extern const PropertyInfo qdev_prop_enum;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
@@ -105,6 +106,10 @@ extern const PropertyInfo qdev_prop_link;
                 .set_default = true,                         \
                 .defval.u    = (bool)_defval)
 
+#define DEFINE_PROP_BOOL_NODEFAULT(_name, _state, _field) \
+    DEFINE_PROP_SIGNED(_name, _state, _field, OPTIONAL_BOOL_UNSET, \
+                        qdev_prop_bool_unset, OptionalBool)
+
 /**
  * The DEFINE_PROP_UINT64_CHECKMASK macro checks a user-supplied value
  * against corresponding bitmask, rejects the value if it violates.
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 0c17a5de82..1bec8ee679 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -260,6 +260,16 @@ const PropertyInfo qdev_prop_bool = {
     .set_default_value = set_default_value_bool,
 };
 
+/* --- optional bool --- */
+
+const PropertyInfo qdev_prop_bool_unset = {
+    .name  = "OptionalBool",
+    .enum_table  = &OptionalBool_lookup,
+    .get   = qdev_propinfo_get_enum,
+    .set   = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- 8bit integer --- */
 
 static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
-- 
2.41.0


