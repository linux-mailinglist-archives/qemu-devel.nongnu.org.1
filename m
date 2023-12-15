Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C08146E9
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:29:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6NL-0002no-FP; Fri, 15 Dec 2023 06:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6NI-0002mq-Hp
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:29:00 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6NE-0008DL-Rr
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:59 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d0bcc0c313so1326935ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639733; x=1703244533;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pi8rBs3H6d5UCS4ax38pPa/AnRGEOIdS0XPsGWwIxMI=;
 b=Yo5t92tochXO2II2q05EibvW/rY8XmowW8c/logXKPdXH7UiBZo6SxFe1CNe5bzJsx
 VjDNJH4drpycZrYCtuV9v2Ql/YqXNXr+KWnbu3I2Zhd4mp4Fy3lvAQS7yJjqXi+MVAhh
 LlmH+ZJiK5ivVr/vZq/8IRAOc9dkOKFUqYZLjGsxMKF+sIAG70iDPDws7UJTvnqVgliS
 7tcE5mC6n/jcs2OkJ4z4k0ovbupkN/7v4xcQUiRjGnI97YsO6lyaRF1eywEgDbTEIKfh
 At7s/ss8CPAQZyQIi9HPsl7kssc3MvvYwZW6HcVCE5JHDckqRDSlyK3if76KBrBuB787
 I0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639733; x=1703244533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pi8rBs3H6d5UCS4ax38pPa/AnRGEOIdS0XPsGWwIxMI=;
 b=TGlvTTbJN3w2yPetSoUuZoUAKR/pqvfOXf1K8oqdK/6l90iCIgYehDyDhogOfb24Hh
 35vElbqQ8w1CRlXAOZffHlgwj/cU8ZDYhnTHKVykl9NR2Yb1nYB0Y8tvm3M3esfC2OXV
 fbrigOUkwJ7zy4LAG6VdgbunpeKzEiuDpZnqL14l4KbsYlKOFDGTRJRQogxZfn/pOEGd
 z2mppqWUugOdznFhu9MaC5D3oWemAr9vkiA9ivHXr/4pUma6/Waa++ffd34xUgfI4p+h
 LzJoOrS4DfsW1ty1cDdiEpPa0YxcurNoVuyM+WY0l6RcXsX4HzPUL8mV3nHB7iA+YOTK
 n3Cw==
X-Gm-Message-State: AOJu0YwTAk9GwW5SLGqeA9haKOJzQqfUw8MpzO1e2Gbtc9pfgDKAwuYg
 pqvCKkbByps9NbmkmPnMlAjFQA==
X-Google-Smtp-Source: AGHT+IGNXd2KSSAOKhnIbHdcjCr8I6UlY/AbU17W1Xs1gWW+WLTJE5D9+oVK86dyqZvFcjGg5pOgPg==
X-Received: by 2002:a17:902:fc4f:b0:1d3:4796:c201 with SMTP id
 me15-20020a170902fc4f00b001d34796c201mr3822481plb.128.1702639733232; 
 Fri, 15 Dec 2023 03:28:53 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 w7-20020a1709027b8700b001d38ca8cbc2sm749163pll.156.2023.12.15.03.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:28:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:28:36 +0900
Subject: [PATCH v2 4/4] tests/qtest: Depend on dbus_display1_dep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-dbus-v2-4-1e2e6aa02115@daynix.com>
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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


