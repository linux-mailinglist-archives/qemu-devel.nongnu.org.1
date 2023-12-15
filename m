Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0718146C5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:23:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6Gn-0005ag-DO; Fri, 15 Dec 2023 06:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6Gl-0005aS-66
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:22:15 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6Gg-0001D8-C5
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:22:14 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6cea5548eb2so485217b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639328; x=1703244128;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pi8rBs3H6d5UCS4ax38pPa/AnRGEOIdS0XPsGWwIxMI=;
 b=BKaqNKxn0ehNvZej/2A0dMaRlWfKLaNu7qiup752TKi73V7XrsoGnVZz+bFyEJLkGF
 hH3HpfVEpW2IYERvS0Hi6/Dx6BU9QeE0M1pC19ZdNHnR7LmU2lkA2zux48VnmDi3qKGP
 tv86zGHii1VUEVQA5JFI1yWOiz7H7Uqht5wf+78LtN7dy64L9ct8uzx+4Cr+U4z4fbMI
 0HgcHZVWraJRRAOmcvhet35MFbDFTk+5YFVuVRCQrFmoPT7Aowa/46KDVXU7if58Ud6I
 +kbyc6snpuZQiAmmQNtbcudnXB8qsUZt16bHAuFywhhv6BECjuRHkCZa9b9HYhC1h9iB
 cPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639328; x=1703244128;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pi8rBs3H6d5UCS4ax38pPa/AnRGEOIdS0XPsGWwIxMI=;
 b=Mjoyqk9UjRGKjZB4b3JR9w8oHRxAJ6LCBjC0QapbaXj0/LrA/rCRuI5kWNEA/MLBRK
 YwzWvarPnJDeQG9ycx09iKl0Fz4ZhPMILuuGl82J8Go4fi/JsI+JH6hy7v2IpXz1IQJT
 rdEYpTcvUk6nabNHd4+W3ZUwKXXL+1yGUmRmwQH8GyGf4ZSw85QasZzgxAsA8OeBx07x
 nv2pz2ILn8sPXt31g6xMZnX1vBKdBChecxj3/yr8Xh4l1P1boEwyQd5iKqCT7nvyJvUB
 p1fYKGNPZqkPy6x49a73sQUTTiQ/CBc2cqvuOaWK61e1l9oJgE69wIon3IlCyxp/ZNK7
 IntQ==
X-Gm-Message-State: AOJu0Yx/+EVNnSzU/e+v0f3+qKg7H0y9rgH2/LZtyaKijN4ZKUKzLV9T
 cxUrnE68DGq+AOyMBfI3J7R/BA==
X-Google-Smtp-Source: AGHT+IGDWDqDTq6NX6x7r7m3rT4YV7SD38tf5ytQs2BgOQFW3i6TXIO/paAQP366sJ42nTYf3feBkw==
X-Received: by 2002:a05:6a00:218f:b0:6cb:d2cb:5234 with SMTP id
 h15-20020a056a00218f00b006cbd2cb5234mr13471083pfi.32.1702639328669; 
 Fri, 15 Dec 2023 03:22:08 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 g16-20020aa78750000000b006c4d47a7668sm13359894pfo.127.2023.12.15.03.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:22:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:21:39 +0900
Subject: [PATCH 4/4] tests/qtest: Depend on dbus_display1_dep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-dbus-v1-4-349e059ac5b2@daynix.com>
References: <20231215-dbus-v1-0-349e059ac5b2@daynix.com>
In-Reply-To: <20231215-dbus-v1-0-349e059ac5b2@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

It ensures dbus-display1.c will not be recompiled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 47dabf91d048..3a1a79d7c72e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -332,7 +332,7 @@ if vnc.found()
 endif
 
 if dbus_display
-  qtests += {'dbus-display-test': [dbus_display1, gio]}
+  qtests += {'dbus-display-test': [dbus_display1_dep, gio]}
 endif
 
 qtest_executables = {}

-- 
2.43.0


