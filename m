Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7574281DE5F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdoL-0004fc-OE; Mon, 25 Dec 2023 00:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoI-0004fF-OI
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:30 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoG-00022r-PT
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:30 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so2737647a12.1
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483126; x=1704087926;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3WxEzglk8uoFov+TGXHb/niKmhlgSt8io2ZCxKmYxI=;
 b=RRVJwg3Utxh+7RrayNQr5mH6jduEdc1MD6o0L2fy5bpvYn2uPm/cutBAoENNRmB6bb
 aWFmbZxhdOO6ryjNSEj5T/8fpGodPRnEXavT8EcDBkYvQdW8vnWEyE8BldPi+2IhXJ/i
 /BJv1LkwPw7xqIbDmXPSBFp0Z+mktUBqXft5gdoLAu4eOVrNIbSUi/m03Yj7Q4V0FFGk
 1e5lhhM/XsBrim7NzUS/PUmgl46rV5UJzOZp/9H57ZyREsdKYgIeZYEGZRHbcf80KRbY
 837Fnpr5oO+l0d07zqPOtjuZBuCfGpBNad+IJG/CvniCovrPakWVmXJpoxJ6ZF7Lh50t
 DnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483126; x=1704087926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3WxEzglk8uoFov+TGXHb/niKmhlgSt8io2ZCxKmYxI=;
 b=E4G+gsgsqCUsKJK+HjTp40NitNzS3LsFMAV3SzPbWcuRLKYjeQwOffbBxFONsJMr1A
 TKWz2S9+aVSEKanGHqbhPsk8fYIf4TdMtaeTkszvmTUdxWeEQfuqHdyOzaGilDvT8ZiX
 FC7s8ZtSmaYP72ZjrvvuDH2aGzE/ZOSK5MCKa1BCAz153V388bJR+yo6aiY6oHhrx1Ge
 Di1ZQBewQaKEFhhZuwmKAeOw8dIokS2uo4y8N1fO1H5exYqlfnAD5oSmTNxXzzgf6uS6
 MbkcLC7MATuzIoBJhlJbC4RhM4U6UKmtnNRY/tdEVDkNKrFNJ+nbhhb1JnfDAAra6z3G
 bBHQ==
X-Gm-Message-State: AOJu0YzFJ1KOn61kV5fnEA/R5uEgcP/SzmaDZAbXrqqvMCo+r5a8bIIV
 ezJkU6QSHsSCZK4vo0Uslv3q2wmWPpO6AfP60BKGrvVONulRsQ==
X-Google-Smtp-Source: AGHT+IGTczOAqaLjn2DWekj8+QlvuaqQxB3WyeiWcJXQXtrBtFeGWOm/ZeTsHc8OhMohVaSbA5+q2A==
X-Received: by 2002:a05:6a20:7f94:b0:194:f454:8e9 with SMTP id
 d20-20020a056a207f9400b00194f45408e9mr5618654pzj.106.1703483126116; 
 Sun, 24 Dec 2023 21:45:26 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:45:25 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 01/10] crypto: Introduce option and structure for
 detached LUKS header
Date: Mon, 25 Dec 2023 13:45:03 +0800
Message-Id: <a34c12048198cea06d5d1a69a3fa8b76ab13cbba.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703482349.git.yong.huang@smartx.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x531.google.com
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


