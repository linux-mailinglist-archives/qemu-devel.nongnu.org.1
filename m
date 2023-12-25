Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE181DE5D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdou-0004nu-Gh; Mon, 25 Dec 2023 00:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdos-0004na-Dm
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:48:06 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdor-0002C4-4J
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:48:06 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ba2e4ff6e1so2900874b6e.3
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483162; x=1704087962;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRysB8cvYPSKAt6SyvAAu4RjPWDEBwqeC3YTz4T4KdA=;
 b=fqNdfAj3+a6Acw5jC1UMN8NjSSYytja/dniwYDEU2NuesvoMpFtQiA1c+95Gkk2Mii
 8pK3z8IP6pxNQkBGte1qkR+4dnaztCT9MVHqsr7PBoHcZOqHeCF0yUt0oV0hc/BpS+DZ
 NeGw0rfykM5pUKJ1f2uGRbKIgfbxPWz7O9pJoLsCTOyyVl3GZ9+dTCSKVrh+RIhA+Yhf
 iviT6bBuk3s6QrCMPTXeeee1qpWpclJi8TPjY/53P20WlElN2EtAcVMMjpO2+UKAk4/+
 vEJCwicZnFlKbb1ySlC40jJ90zB1nRee9v8KytFBHcd991zkW3OtByEvDlk2qzCZexZw
 cIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483162; x=1704087962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRysB8cvYPSKAt6SyvAAu4RjPWDEBwqeC3YTz4T4KdA=;
 b=q8B2G2GUbK5JKlxZIORqVBYQiTjPTv8g6mIyOgEcZeiH/YKPXvWYZ2x4+rwWEYAXuU
 Goknv5gIkc5wKhyqxPG/0LmrGKEddHElBVQCmDDdI8dbbZML2QUtXRXcYnZYg1g+YIyR
 Fr4madsW/GlesL0U2r19/1mzPFPLHIdZV77V+2lwTwOezhmil/kvnRisBkALBiXBZ3/9
 oJI+F4SyCThBPG2sm/WuSrho8Q6dgASO12N6AnwtbhAXzCTBXdPzfvb4A7LT61Q91mY3
 crQLeKoJDYjy1+zTklYWO4XZeUQcT8GclNU8LCyT+8BOcABPq+FCMK/NkRbHPaM9dVis
 XrHw==
X-Gm-Message-State: AOJu0YwqDu6DMOxzxuBHaNyBu3fif23tly6tBOcQH6154Wgo1VNDVLm+
 kYa/ouz35tnUqwWitlXRGVwm3Dl9fC0CQPqh37ZwSa9SdX9K2A==
X-Google-Smtp-Source: AGHT+IH7KG0tltyCwjAjK5IIfrQGk1UXqsuOyZTwgy2ZjKD8sm4tianfwhkRuIwRE+hRCzSIUOaAmg==
X-Received: by 2002:a05:6808:f91:b0:3b8:45cf:9b2 with SMTP id
 o17-20020a0568080f9100b003b845cf09b2mr6157554oiw.20.1703483162349; 
 Sun, 24 Dec 2023 21:46:02 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:46:01 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 10/10] MAINTAINERS: Add section "Detached LUKS
 header"
Date: Mon, 25 Dec 2023 13:45:12 +0800
Message-Id: <fcd9ff60fde1a7ab9d41bf3fc456fadaf8fe83cd.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703482349.git.yong.huang@smartx.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22e.google.com
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


