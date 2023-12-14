Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E99B812830
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 07:33:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDfGp-0001s7-Il; Thu, 14 Dec 2023 01:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDfGn-0001rs-7W
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 01:32:29 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDfGl-00045F-Lx
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 01:32:28 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28ad7a26f4aso2249000a91.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 22:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702535546; x=1703140346;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b3CUKeEYm/gOZXVInNJSdSYc1B1o0RTKVcYbhcdNsuM=;
 b=TSEWJgdbDLNuGhj3Wu2TDGdpfVzIN+eiA6gjaVVXB86n4tkvn0cnR8/RTWpdKyZFzu
 MUYv7A3LL/oU1vKzqWHRUeWCxtN/QkmLsQGLwCBUuEUTq+Tdo2PaxBwihfdwo2vg55Jp
 IMsUi6m63SeJ/BraDqdji/SGsW8P/1MYR9SVoaKLuGOhQBi7irWzq4yJSgrPrK+2HSJ9
 XjaP/gElqLlB4TnWo5Otx9BkrC2UNhTuusoZtb8sIArPfjFzVfcgdS1x2sX9LTrqNHsa
 2RFDtf31xXF5DtzUkNt4BlcKEltEouAFGMUpwZpDVZp6Tea+xJEusnvw5CuHf2CRhT5J
 Vvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702535546; x=1703140346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3CUKeEYm/gOZXVInNJSdSYc1B1o0RTKVcYbhcdNsuM=;
 b=FOMvCceHRUq1dMn2kVdfUtAFV8xmTx4MJKN53kx/O7pnsWUcYpbokL6HvFbJlOOTHI
 jkLGqGqxDznjWwrDH8MYlgeNYg0UCkDEUcMn4xG/64XDTlFwpa1qW274nutIsE92C3BI
 y6P8P8TYxyOxMnLV14WtpOtPv1mgj9CsgJHjial1dCaHMaCgUCqaARgekHOS7YDbQrxu
 VDJd8zOy1lGohQJ1YDU5qOnGIOHR+fVi5Q/a1sbJ4I6FeN/Nfv6Cd/2/sKfbFXZR/rxQ
 vkdwkRkkNuy8kNe8F/GQy34pM6DYHtEP/WWueX33kIIdzBLfFyqPe+1qCB/iT+zvSz22
 IYvQ==
X-Gm-Message-State: AOJu0YzK/Pq58YCRV90Rq6DfW84IASHflc5Vo/4dRMriodMCJbmeZZWj
 CitFNiI9ym9QzQdTSRy2Idk2Mg==
X-Google-Smtp-Source: AGHT+IFDCQ0hjraQ6rxoMypT72B+xk+dXtO8FrckGUVRyh4qOZz6dUA21Mrwez0hFHSCtXjUzKjb+g==
X-Received: by 2002:a17:902:704c:b0:1d0:ba40:b0e1 with SMTP id
 h12-20020a170902704c00b001d0ba40b0e1mr9379527plt.124.1702535546340; 
 Wed, 13 Dec 2023 22:32:26 -0800 (PST)
Received: from localhost ([157.82.200.183])
 by smtp.gmail.com with UTF8SMTPSA id
 z5-20020a170903018500b001cf65844874sm11626412plg.45.2023.12.13.22.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 22:32:26 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 14 Dec 2023 15:31:35 +0900
Subject: [PATCH 1/2] qemu-options: Unify the help entries for cocoa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-options-v1-1-113f347b0e3f@daynix.com>
References: <20231214-options-v1-0-113f347b0e3f@daynix.com>
In-Reply-To: <20231214-options-v1-0-113f347b0e3f@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Carwyn Ellis <carwynellis@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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

Apparently the help entries were not merged when the patches got in.

Fixes: f844cdb99714 ("ui/cocoa: capture all keys and combos when mouse is grabbed")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qemu-options.hx | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de96..28aa26ceb508 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2087,6 +2087,7 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
 #endif
 #if defined(CONFIG_COCOA)
     "-display cocoa[,full-grab=on|off][,swap-opt-cmd=on|off]\n"
+    "              [,show-cursor=on|off][,left-command-key=on|off]\n"
 #endif
 #if defined(CONFIG_OPENGL)
     "-display egl-headless[,rendernode=<file>]\n"
@@ -2094,9 +2095,6 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
 #if defined(CONFIG_DBUS_DISPLAY)
     "-display dbus[,addr=<dbusaddr>]\n"
     "             [,gl=on|core|es|off][,rendernode=<file>]\n"
-#endif
-#if defined(CONFIG_COCOA)
-    "-display cocoa[,show-cursor=on|off][,left-command-key=on|off]\n"
 #endif
     "-display none\n"
     "                select display backend type\n"

-- 
2.43.0


