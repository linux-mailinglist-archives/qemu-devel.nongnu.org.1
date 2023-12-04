Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F18039BD
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABVY-0006wM-5L; Mon, 04 Dec 2023 11:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVV-0006vY-Gm
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:17 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVD-0005IQ-8M
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:17 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6cb55001124so4270346b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701706018; x=1702310818;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77C9fyBK+wCjHbA0j2qTNKB4ASsAQiztQYgybK7k++I=;
 b=1Z7oHjtEyvRQ8V/KsmHMRV4Nju+keGOinh0s+3ElEBauUBL2GZ+Zj9rr7VuHaXUlJm
 xPPDSyLO9DiCYJ0yc66vTxKL9kzYRJz4tv8SJablzvpX1cMBYV7IsDB3CKDeUfMjciqV
 BZjt2gw+rejhr1kHt1RDOmDVxsi6HW2CsxzqTmvtNReyUxgxtLHa9+SBVPnOrjJxWKPi
 5wpTTjxYs4aBQQybZy9FhixWrF1SNGeJseMDf8R6Y2Wt1hV3fJWdYWFFGFlm8KLx/u8t
 UAzznTPZaRFYI/UdgldfHNqP+/Vb3OVfn+UwRorcrC27cDWHZsMkE6IO6Ki2cOMNz6oe
 7c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701706018; x=1702310818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77C9fyBK+wCjHbA0j2qTNKB4ASsAQiztQYgybK7k++I=;
 b=AdK1+AYczoxuPwg74soPSvkSMzKXwROx3+id+kq0Ygu8x+4gk/0OQotP2A6gpn5OSj
 uwQHguzppezGOCPE543yuS9atUMsyWbRdoqXEEH1Ur/UiM1uCiMS0FLVtD88XSPDWR+V
 ccDbQeDsxKTKwePdtOkqcL41faO9JPbWeZPvCUaokKQlNJgbuQEU63++Mqea2Drc0iiv
 JQXIBw4JCX85IBsXEbfiIDCSBygT1FjltdUUzSDKTSFIA+nw28pt7WvgqusAzppc5PxS
 t61Hr+uW9kCBfFHxU5EvuYn9VNJGbLXjyMVbPfjx+voCLvLyRwfhXclljWAIIyMolfJn
 BZQw==
X-Gm-Message-State: AOJu0YyH8YNNEKKbBQDrmboklGhH9Ex2Fgme1oayGbtLAWEeHf1p5gZM
 9oJYOZxWzXPYkZ9OWgWxBxriqENDOl+rD1cgAaiGw2Ta
X-Google-Smtp-Source: AGHT+IEqHaQzs6HU2aZxrQNo9kCWPDV1YIaMDi0HAkWOowjgkc4i+LeTjSOkDfqtvvOvSRpMRX73VQ==
X-Received: by 2002:a05:6a20:138b:b0:18f:97c:3864 with SMTP id
 hn11-20020a056a20138b00b0018f097c3864mr3406251pzc.62.1701706017473; 
 Mon, 04 Dec 2023 08:06:57 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:06:57 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 5/8] qapi: Introduce Gluks types to qapi
Date: Tue,  5 Dec 2023 00:06:22 +0800
Message-Id: <356796b03a257593357fe660e49b17e2057009ef.1701705003.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701705003.git.yong.huang@smartx.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Primarily using the Luks types again, Gluks adds an
extra option called "header", which points to the Luks
header node's description.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 qapi/block-core.json | 22 +++++++++++++++++++++-
 qapi/crypto.json     | 10 +++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca390c5700..e2208f6891 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3185,12 +3185,14 @@
 #
 # @snapshot-access: Since 7.0
 #
+# @gluks: Since 9.0
+#
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
   'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
             'cloop', 'compress', 'copy-before-write', 'copy-on-read', 'dmg',
-            'file', 'snapshot-access', 'ftp', 'ftps', 'gluster',
+            'file', 'snapshot-access', 'ftp', 'ftps', 'gluks', 'gluster',
             {'name': 'host_cdrom', 'if': 'HAVE_HOST_BLOCK_DEVICE' },
             {'name': 'host_device', 'if': 'HAVE_HOST_BLOCK_DEVICE' },
             'http', 'https',
@@ -3957,6 +3959,23 @@
             '*debug': 'int',
             '*logfile': 'str' } }
 
+##
+# @BlockdevOptionsGLUKS:
+#
+# Driver specific block device options for GLUKS.
+#
+# @header: reference to the definition of the luks header node.
+#
+# @key-secret: the ID of a QCryptoSecret object providing the
+#     decryption key.
+#
+# Since: 9.0
+##
+{ 'struct': 'BlockdevOptionsGLUKS',
+  'base': 'BlockdevOptionsGenericFormat',
+  'data': { 'header': 'BlockdevRef',
+            'key-secret': 'str' } }
+
 ##
 # @BlockdevOptionsIoUring:
 #
@@ -4680,6 +4699,7 @@
       'file':       'BlockdevOptionsFile',
       'ftp':        'BlockdevOptionsCurlFtp',
       'ftps':       'BlockdevOptionsCurlFtps',
+      'gluks':      'BlockdevOptionsGLUKS',
       'gluster':    'BlockdevOptionsGluster',
       'host_cdrom':  { 'type': 'BlockdevOptionsFile',
                        'if': 'HAVE_HOST_BLOCK_DEVICE' },
diff --git a/qapi/crypto.json b/qapi/crypto.json
index fd3d46ebd1..9afb242b5b 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -154,11 +154,13 @@
 #
 # @luks: LUKS encryption format.  Recommended for new images
 #
+# @gluks: generic LUKS encryption format. (since 9.0)
+#
 # Since: 2.6
 ##
 { 'enum': 'QCryptoBlockFormat',
 #  'prefix': 'QCRYPTO_BLOCK_FORMAT',
-  'data': ['qcow', 'luks']}
+  'data': ['qcow', 'luks', 'gluks']}
 
 ##
 # @QCryptoBlockOptionsBase:
@@ -246,7 +248,8 @@
   'base': 'QCryptoBlockOptionsBase',
   'discriminator': 'format',
   'data': { 'qcow': 'QCryptoBlockOptionsQCow',
-            'luks': 'QCryptoBlockOptionsLUKS' } }
+            'luks': 'QCryptoBlockOptionsLUKS',
+            'gluks': 'QCryptoBlockOptionsLUKS' } }
 
 ##
 # @QCryptoBlockCreateOptions:
@@ -260,7 +263,8 @@
   'base': 'QCryptoBlockOptionsBase',
   'discriminator': 'format',
   'data': { 'qcow': 'QCryptoBlockOptionsQCow',
-            'luks': 'QCryptoBlockCreateOptionsLUKS' } }
+            'luks': 'QCryptoBlockCreateOptionsLUKS',
+            'gluks': 'QCryptoBlockCreateOptionsLUKS' } }
 
 ##
 # @QCryptoBlockInfoBase:
-- 
2.39.1


