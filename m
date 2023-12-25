Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADE81DE62
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdoV-0004jF-Af; Mon, 25 Dec 2023 00:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoT-0004im-8t
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:41 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoR-00023v-Nk
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:41 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3bb53e20a43so2822086b6e.1
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483138; x=1704087938;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJQlTzAWPO+/klEeEAp+k9zko8Nhs/GsMEahvb4ufUs=;
 b=RE/c/efDBqsZfdfdUWlzySFl8DcfbNimIATD1oUQB+mUb+f/oC6wZV8vk5xAyisAnp
 ocLcg3f0PN/VQadgpepIAXil65XqWrPj66x+VBxH99yprXrkFsXXw/qXPlzqH8Qf4YtK
 I2c+twEN9n9lbUm2izn5C2drVpePY32t3MQqq1xFkpYN1MWMpS8jw3b+ocXDGk8qjJRb
 jGCMuFX5G5vGb0MEjDj/PcaTq72rXxDFAWoDAYVYSD9RuRG2yBHrupdz6uh6uokodcQj
 KIbeBOuAX+KzAxOVUwbnX5rnMBHuAyuO0ADU1QWnMKfpCbsRjlUXy8rUdYjVp3ZVGM/A
 pJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483138; x=1704087938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJQlTzAWPO+/klEeEAp+k9zko8Nhs/GsMEahvb4ufUs=;
 b=XoEAlc70WWVR0hPhwaXpojLYWPgzEmi17FnJair4eFtqOr0ggpUjlukVgaMlHknNcG
 rBMHxiwD4jSs66uoG3l02JXjnFtNeaQNeYXlElRUAwnCj2ZtAq694zrRDw+rEGamRxtp
 ZM3a+ZFPmkXhpC+z2TNDGoNsURNQMW3SW5Qq98yxHwoulmaT3nvyfTlURKZs64YDKYdR
 OxhyufDEwuZRnGzLBwz7iulP5Hb37f6/k9UEg/NKKBI95KoOj7+DQA5U5rlXfixbRRLU
 PNh2ZsGRtDnJ5xzFKbBqqYfQL2vB+4mtevM4BbYEPRtEznUlHxJ1kI6gl48SSazuVYWG
 Y4ww==
X-Gm-Message-State: AOJu0Yzd/ms28uShPccCewWkmGFz1P51FEARMTijkJF5VyH3+X9NtnGF
 cRK8CMugICNh5z9cVLAtuIIxbS9C5M4GCTUsR06pk3Oz38xvhQ==
X-Google-Smtp-Source: AGHT+IGB+3Flm2chnspm2v4DeR47JMmLuUrj+8FdtPmByL6TUKwizdnoJe78EKguV0g5zeJW6ukf+w==
X-Received: by 2002:a05:6808:148a:b0:3bb:aab0:d899 with SMTP id
 e10-20020a056808148a00b003bbaab0d899mr1195437oiw.37.1703483137943; 
 Sun, 24 Dec 2023 21:45:37 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:45:37 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 04/10] crypto: Introduce creation option and
 structure for detached LUKS header
Date: Mon, 25 Dec 2023 13:45:06 +0800
Message-Id: <57ccc93a05f69973d41b571615f9ef13fd9b2983.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703482349.git.yong.huang@smartx.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22d.google.com
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


