Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F681AD66
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fo-0002GI-9m; Wed, 20 Dec 2023 22:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fc-00021E-Th
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:26 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fb-0000zX-J7
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:24 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67ef18444ecso1895786d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129063; x=1703733863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UrjceR6XG91OWiJuQTkzwn9UFRxtt0kJJUYasU0mE7s=;
 b=w4QhR8vnWchKMD12EQdjW2r8yos4cgTfLbLHj7aLxRABbqCWMnrmBY0U/IiZYVexgc
 FIiCCkV1JXt1lTZgmEffKXKUyWV2gOVDUgCQrBEFlLoSn0HFLmLmlFH7WfFNdRGLhXGY
 vzn0u9c6DeJFsbJRC5i7A7Jk2+evJtb9eU20CsbKbHAKeGP4as+1n1gFg0WgCFYBFSzR
 FljPnlItL9+tAmLAUY0vD2VVXjht0pJmn5yM3YHcxeab2LEusqXEBThI+iL98kQaMkFo
 CbL8lR/S0FcicZwldHoQH2c3LCwOzjlyYGnUKDi//b5Kd9Co0dPi8egZb2f4m6HuZ8Oa
 iCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129063; x=1703733863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrjceR6XG91OWiJuQTkzwn9UFRxtt0kJJUYasU0mE7s=;
 b=CiO8k0ma+34AqKjhn7V6Yrm+oq+3XKHskbjEKP6ydHKerI+6kjMM7z02uk07mIMm7N
 YhA51M2hanxRLxTGG3GMTm4lxZ/KXq/vjP8b/38YZrhd25nb9TYqkV5QgBGG0RIavCKF
 NOxzZ45AQZVBL+gtYsZ6lcVUZVC/JwF2Qi7Q5E8pBWIAIx5cltfLhM4mKy68EReikNsU
 EPQ6aS4KpFaPk61HBye/DiM/wcsAUixqdbbbQm2ng9f11eUvYxBNJtvM7THqlhw8ZzLu
 5kt5tlmJBaQpQLAfSvxWFvGaqMYkewhECAZmClLNblt+ptWxK1duGcOZPmmkfei003Vw
 ROMQ==
X-Gm-Message-State: AOJu0YxQjrQqHU5xccovXB5B4OH1o2IopcAk3i07R2MXuOczqbuEpDVZ
 5800W67RgdH0fjpNdsAdORiZrww+F+IyMpDQHXJiVFbA
X-Google-Smtp-Source: AGHT+IFyKbYFEs6bXuJTbZIjAl42MdujbM9/h+Bic4vZCq47hb+/E0QXkuAplrELCxAVCaJDf40lvQ==
X-Received: by 2002:a05:6214:224a:b0:67f:89a:339b with SMTP id
 c10-20020a056214224a00b0067f089a339bmr16627713qvc.28.1703129062862; 
 Wed, 20 Dec 2023 19:24:22 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 63/71] audio: Constify VMState
Date: Thu, 21 Dec 2023 14:16:44 +1100
Message-Id: <20231221031652.119827-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 8d1e4ad922..a1097bb016 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1683,7 +1683,7 @@ static const VMStateDescription vmstate_audio = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_audio_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.34.1


