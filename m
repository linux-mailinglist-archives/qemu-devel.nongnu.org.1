Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834281DE3B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:30:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdWq-000515-Nh; Mon, 25 Dec 2023 00:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWo-00050S-3v
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:26 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWm-0007HU-NS
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:25 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ba52d0f9feso2842025b6e.0
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482043; x=1704086843;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3WxEzglk8uoFov+TGXHb/niKmhlgSt8io2ZCxKmYxI=;
 b=Bs7SehCnxRBeV2tRxh+Z5xMDTfEki0yR+qEG5KyDNm2NVYKFS0KZKVePFgYJRp87yb
 EEa8URHjXpW2WgcVKR1LVU0boie/TH5VsK4vqtLUJiQGjXQ1bt+qZp2HXP4XHT4N0vmi
 3Hn3+RLPrkTIIiYBGVDvFQkkwPMxDG3sjpKUY6nKAnP8Vs83AKFZb6QJjaWPEhsC2VrQ
 kcIEa1FuxymUPaBhWI/TqjirPLD/jK5IyfAqxHoSWPOQqeZcMrwaLF0mkKUavhQgIQbW
 byZVr4MEd+nQ5P/0SFoZJ1lOLeYPkRHkCbwdnAy6P9YTCkaWzS2VgrQ3V7pGmXFpoAzX
 phcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482043; x=1704086843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3WxEzglk8uoFov+TGXHb/niKmhlgSt8io2ZCxKmYxI=;
 b=phoxsuxyDe8WMqijVY9AnnJTdKPTaFTFWGHRe+YN3Xxd9bF2q30WC5lWn/1kLpHQlz
 jSwlpzggie5IFEY+zUGJIkfCe68TkdNG7smCAONdvKwVWfp6jySJL89BdbWCAG8Zewn7
 KPAoqPgUUlNe0LsUGdKZ7w9AKCj6Lg+hC/+T4yUGKU5WGj/5Y5+IHMvwcEBPvLhA44uF
 kTl0CxDpAxN8BCqtf01DVZvXWUW1BuUhIlCuM3Fa82nPD6Ica3G2nd+TbSoCb9ds7MWS
 ZfvhkPO1d+ULQbqEJ0yg+j74wEdECrz/mZ4wPgPEDYZU/99gAXX28QwkM/v3rdyj9YY0
 Ua2g==
X-Gm-Message-State: AOJu0Yz/mu5zs569GJw2kDqgWLGnORrwyoFi1z88FzxYSp7owaptuoB9
 oiznzdIbcFn96OrI46fRKtAVRLFxEOhexYVDX1zlA0EGc4nGAg==
X-Google-Smtp-Source: AGHT+IGObvQGA/FjvNuLDp8F9M+flWpqSWsYErTJcf2NXrBbZ10T2NGAFz6890VrWB6rMQ+iZ2opmQ==
X-Received: by 2002:a05:6808:1493:b0:3bb:9636:1c04 with SMTP id
 e19-20020a056808149300b003bb96361c04mr4303647oiw.22.1703482042531; 
 Sun, 24 Dec 2023 21:27:22 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:22 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 01/10] crypto: Introduce option and structure for detached LUKS
 header
Date: Mon, 25 Dec 2023 13:26:51 +0800
Message-Id: <a34c12048198cea06d5d1a69a3fa8b76ab13cbba.1703481379.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703481378.git.yong.huang@smartx.com>
References: <cover.1703481378.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22b;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22b.google.com
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

Add the "header" option for the LUKS format. This field would be
used to identify the blockdev's position where a detachable LUKS
header is stored.

In addition, introduce header field in struct BlockCrypto

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <5b99f60c7317092a563d7ca3fb4b414197015eb2.1701879996.git.yong.huang@smartx.com>
---
 block/crypto.c       | 1 +
 qapi/block-core.json | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index 921933a5e5..f82b13d32b 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -39,6 +39,7 @@ typedef struct BlockCrypto BlockCrypto;
 struct BlockCrypto {
     QCryptoBlock *block;
     bool updating_keys;
+    BdrvChild *header;  /* Reference to the detached LUKS header */
 };
 
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca390c5700..10be08d08f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3352,11 +3352,15 @@
 #     decryption key (since 2.6). Mandatory except when doing a
 #     metadata-only probe of the image.
 #
+# @header: optional reference to the location of a blockdev
+#     storing a detached LUKS header. (since 9.0)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsLUKS',
   'base': 'BlockdevOptionsGenericFormat',
-  'data': { '*key-secret': 'str' } }
+  'data': { '*key-secret': 'str',
+            '*header': 'BlockdevRef'} }
 
 ##
 # @BlockdevOptionsGenericCOWFormat:
-- 
2.39.1


