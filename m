Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99480756C
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:41:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuwO-0006yt-Sw; Wed, 06 Dec 2023 11:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwM-0006yc-F5
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:02 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwK-0003mY-MF
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:02 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cf7a8ab047so31966325ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701880679; x=1702485479;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lzq/6uBa8Sn9homJ2UmZstCzNIMtGnzp/+bkC0HtRY4=;
 b=ox3mo8XzQDun9wqMkp03kN3eENdQf52mi5f2FaMNcUq6zgQtCHen00jPCa/p9+EePO
 y0ySaiGaA9RBld2eZvbruROGdU0L5w+MRS1B0duzNNwzXlKRmIzZqAw98qjT3uWv6+qS
 NKNbohLkHWV0kwuvxMN76h2D//haMk+GnL7DkiQIPqI5qxnYnZjYWpofb3e051XAgGqI
 hcorcLXgyK2b1UZOrajw7YL5jN2Qzwxmjdr1bcNteN59/TpWddOwCnYaOCY0cHsaHby1
 KujlqGDF5CsSuG/Vgau+NS+qA/Id+OsomrsOqqjbREoO3yVdt/2jWofuL3iSkJddkox7
 iLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880679; x=1702485479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lzq/6uBa8Sn9homJ2UmZstCzNIMtGnzp/+bkC0HtRY4=;
 b=ifzrmBqA4M6n0G4wfPX4OWSFsuK+uouq76bmvAxk6JhD6g+RbmX9Gt/jryCwAC+hQ2
 2CigjNmvswdOHvJyiy2H05G5g5x30baWmoHNpcu0JTfVFeWeM4gZQ3FQPhPg/TFA42L8
 hXmU/xOlXG/QSE+PgsxWvPl6Le2gmKRzpeOEStc51ycTKiMhhtBmnMBU3cpmhwCHzR9p
 4QdfsTXC5lXXW2szrB0jYwsdruhrAL69WkjKEmhx0eYFZQ7oirmv5gFH/0grvjCSr+Rp
 mQYUCs9g2Qqq8rEdVHbC9Po3UKXFVJhllsEisDqBs9J/FE9+nrmcrDIK/ymy/HQPiy0d
 gVbg==
X-Gm-Message-State: AOJu0YxnVe9qRGXzIsElneM3iRY2RdJvTqHKaNXqGZ/sItQOR1ujIMPc
 Jn47WBIAZ/D8j/R4ZUb3C/63Uh+lm8oIKk9yzlQw2QTr
X-Google-Smtp-Source: AGHT+IHjYLGSi99NOQjQ64UIfwsdbpbcLEnr0ycFXtwodoGRurjmDFBC0dYb8R1g6qREqDojoi60XQ==
X-Received: by 2002:a17:902:ef91:b0:1d0:6ffd:8372 with SMTP id
 iz17-20020a170902ef9100b001d06ffd8372mr729405plb.125.1701880678545; 
 Wed, 06 Dec 2023 08:37:58 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a170902bb8e00b001d04d730687sm42570pls.103.2023.12.06.08.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 08:37:58 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [v2 1/4] crypto: Introduce option and structure for detached LUKS
 header
Date: Thu,  7 Dec 2023 00:37:42 +0800
Message-Id: <5b99f60c7317092a563d7ca3fb4b414197015eb2.1701879996.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701879996.git.yong.huang@smartx.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x632.google.com
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


