Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB6C81DE40
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:31:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdX1-00052j-G8; Mon, 25 Dec 2023 00:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdX0-00052Z-6I
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:38 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWy-0007I2-Lm
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:37 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28beb1d946fso2878731a91.0
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482055; x=1704086855;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJQlTzAWPO+/klEeEAp+k9zko8Nhs/GsMEahvb4ufUs=;
 b=dt5+r3J0j8fKD6pkedFoM8wCLjs5C7Rsd3juuK0YegK9+WZyVTq4aLMH456NZAxMAJ
 JqdUUH96FEReACY6W+HvXPxya+voFSijbZKhqf/FDR1KThPG35pjJJaM8I3HRwwZUtmw
 69zxsAXD7TSwEkL4XNkWUwqw50Td2f0UIMNoOho84MTA6S1gtC9PQUp/Eemdec2K9N7x
 aI9tft4JB+gtaAPuGK3UPJAyeR8LjRhJnHzdeMwBZZw2Fqv2OO+EeOIDrw3AgPkpZ9wh
 z9VA0ohCOv0WVW7kpW2sRWN2KZhNkzzYBsQAGURK4AYHpVzvX3AxnIgTLffh8sV888gV
 2aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482055; x=1704086855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJQlTzAWPO+/klEeEAp+k9zko8Nhs/GsMEahvb4ufUs=;
 b=t+qndHC0kuAFiHI/r6PeU/KSsc5QtSbFOd9j8rt0cScz11+Ffpn3JqeT20oLJaiiPV
 Zr+0M2f7dvXWL9FvI0nHV+3Wvta3+5KNeM39ACHzSy6Y7eCYyWoWGgfXSXnRp61dyDq1
 cNqFQ9I50UJstrmvq5mUNA1PFlLZ7qLCO9bCZd4ElBMtgGhMsx037SWuWNUZ40pnYCmY
 HoHEcrazPnludBrQRaKQ0nd4GK5asn2nAZljH0AJSzNuMwqaBxex7RqbPjwdIWc8uCDS
 AHp/AX43fzZXJXNlStoM6567ztwoejECQ8TtB2j58LPH6Ye9ZpsZ+hCUTtXrqFhxcos3
 nHhQ==
X-Gm-Message-State: AOJu0YxAh2xhxdbMyzDkt43xu/dnPwvd54PojZBpRmAixh3KxcoMKJbJ
 KOQVpmrOb8J8T3mzThhs3tR6UrUYn+0jxKTFTlqaq0Xrq9KrNw==
X-Google-Smtp-Source: AGHT+IFPE5GzdDtMg6A3zWm6NTcGG1EF+Kh5Z205xLGf0YWvsqtPk8A/rYGKdYB453VMjpOzqVWIwA==
X-Received: by 2002:a05:6a20:12c9:b0:195:1df1:dd89 with SMTP id
 v9-20020a056a2012c900b001951df1dd89mr6789081pzg.95.1703482054686; 
 Sun, 24 Dec 2023 21:27:34 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:34 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 04/10] crypto: Introduce creation option and structure for
 detached LUKS header
Date: Mon, 25 Dec 2023 13:26:54 +0800
Message-Id: <57ccc93a05f69973d41b571615f9ef13fd9b2983.1703481380.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703481378.git.yong.huang@smartx.com>
References: <cover.1703481378.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce 'header' field in BlockdevCreateOptionsLUKS to support
detached LUKS header creation. Meanwhile, introduce header-related
field in QCryptoBlock.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/blockpriv.h   | 3 +++
 qapi/block-core.json | 3 +++
 qapi/crypto.json     | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 3c7ccea504..6289aea961 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -42,6 +42,9 @@ struct QCryptoBlock {
     size_t niv;
     uint64_t payload_offset; /* In bytes */
     uint64_t sector_size; /* In bytes */
+
+    bool detached_header; /* True if disk has a detached LUKS header */
+    uint64_t detached_header_size; /* LUKS header size plus key slot size */
 };
 
 struct QCryptoBlockDriver {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9ac256c489..8aec179926 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4948,6 +4948,8 @@
 # @file: Node to create the image format on, mandatory except when
 #        'preallocation' is not requested
 #
+# @header: Detached LUKS header node to format. (since 9.0)
+#
 # @size: Size of the virtual disk in bytes
 #
 # @preallocation: Preallocation mode for the new image (since: 4.2)
@@ -4958,6 +4960,7 @@
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
   'data': { '*file':            'BlockdevRef',
+            '*header':          'BlockdevRef',
             'size':             'size',
             '*preallocation':   'PreallocMode' } }
 
diff --git a/qapi/crypto.json b/qapi/crypto.json
index fd3d46ebd1..6b4e86cb81 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -195,10 +195,13 @@
 #     decryption key.  Mandatory except when probing image for
 #     metadata only.
 #
+# @detached-header: if true, disk has detached LUKS header.
+#
 # Since: 2.6
 ##
 { 'struct': 'QCryptoBlockOptionsLUKS',
-  'data': { '*key-secret': 'str' }}
+  'data': { '*key-secret': 'str',
+            '*detached-header': 'bool' }}
 
 ##
 # @QCryptoBlockCreateOptionsLUKS:
-- 
2.39.1


