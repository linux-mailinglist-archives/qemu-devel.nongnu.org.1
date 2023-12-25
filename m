Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 442D881DE3C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:30:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdXR-000588-JP; Mon, 25 Dec 2023 00:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdXQ-00057z-66
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:30:04 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdXO-0007LU-Ny
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:30:03 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6dbef8420aaso87928a34.3
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482080; x=1704086880;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRysB8cvYPSKAt6SyvAAu4RjPWDEBwqeC3YTz4T4KdA=;
 b=RQUnXwAivgjDI2zQPJd9kvjYRAvTY3b+pr2bjFK8CFjqy3C/BOioBYdsV3oRAHRltt
 SgVa3AVBEZGYsXyES1A260UgRA7KZrRK4AfC1C5vtFiGZQnMXGRbDMQerkbhQPQQ9Kq1
 /Y4wesz4u4ItFnthhn3zqz4bORczGC19eHK+XFl+LO1UVGB+zUOtyheuG9kMr8EdM2er
 TJG0pnj73WXqMwJrPwLKtF3lb4dipI2Ysy3RJ0/ZHJqMJhRGSIku67suZtTjgtc6z3HS
 Uhw7mfG7gG7WQneX4rp1vkIxg6R2qi7N9bMo/oRdlQ5YLuYooDg0S4G2NmWEEGEwASFi
 aRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482080; x=1704086880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRysB8cvYPSKAt6SyvAAu4RjPWDEBwqeC3YTz4T4KdA=;
 b=wTgL3YDGGuwkZGP/S/qA0FkmQuFHk//neFPSifT7WGXEcL8fVMxh1nnw6ej+3JOmmP
 hu27PtRQK7K86X/jLDmdPRruHsuyT/febPbgf09BLYbzIEkLRPV5Vl/GdJXsydsry1yZ
 fJWj3Cdfu/bXJz9K2XyXZXiE//GJg9aHFQXxhkBDp+jyxFSJvMrS3eRGDyT0zpDGOTgX
 QmDKTDApRtNcpI+yvkr9gPdMV3myx/E4LtVNPc5zQxCSnizCg7EH8MywzAW0c7j6JaTJ
 y5VMvnh/4cZbh3iv3nxByYOJ4ZiiMcsWdQ6058hPNrvK73RTWNtcU3v7uG32JVz9w4++
 Fkqw==
X-Gm-Message-State: AOJu0YzUCsmhao+z83mW4TUU9UcOJns322cPeNZZfjmUuXGmpwlvJvoe
 uksPIwmf0viIO32acVH5UlXV4tmfBiKYxVqyjtMytZuZi0hynQ==
X-Google-Smtp-Source: AGHT+IEvmzD+ZXl78ggQ8kyFTW5nf8K83dY3CmuLcPqb9AFfQaxDpVcC5xgdnnqHYxkPbAFGxGH+uQ==
X-Received: by 2002:a05:6808:23d4:b0:3bb:89ad:9802 with SMTP id
 bq20-20020a05680823d400b003bb89ad9802mr6230690oib.114.1703482080063; 
 Sun, 24 Dec 2023 21:28:00 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:59 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 10/10] MAINTAINERS: Add section "Detached LUKS header"
Date: Mon, 25 Dec 2023 13:27:00 +0800
Message-Id: <fcd9ff60fde1a7ab9d41bf3fc456fadaf8fe83cd.1703481381.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703481378.git.yong.huang@smartx.com>
References: <cover.1703481378.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x329.google.com
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

I've built interests in block cryptography and also
have been working on projects related to this
subsystem.

Add a section to the MAINTAINERS file for detached
LUKS header, it only has a test case in it currently.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 395f26ba86..f0f7b889a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3391,6 +3391,11 @@ F: migration/dirtyrate.c
 F: migration/dirtyrate.h
 F: include/sysemu/dirtyrate.h
 
+Detached LUKS header
+M: Hyman Huang <yong.huang@smartx.com>
+S: Maintained
+F: tests/qemu-iotests/tests/luks-detached-header
+
 D-Bus
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 S: Maintained
-- 
2.39.1


