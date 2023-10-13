Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7D87C80CF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqG-0008BG-1u; Fri, 13 Oct 2023 04:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpq-0007gc-U1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpo-0000q3-2Z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so1748497f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186864; x=1697791664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YbJ+XnM6I8FiRcFI2e93CK9heTfJrD2tl3I1Sx8RmQ=;
 b=KbABenpCNfRFWoeWG7lMOZdaeaHabLBGE1wBYsLQcDzM61a93WB0sMca8gU9hGOc4l
 hHEBxaAqO3BI+ZF2eoe5k8SWKbDhoei2xLUJ+3I43aCRzq4gX9i4yUa9nsq4ALpaPgEt
 bBKBISYBTPIFYuXEqTAVNTtsHCfwsaD8INoDSkK3rqHzkbJ9n0b/KCUSE56G1uDGFALt
 HrXzZr0SON9Baz20ZjntXgzrYuh2RVQTDBgoWW07p19938mZgfIxksyjwrKYHTDTHhNa
 EDgzcowfW/YkBhjFyGSFHqp0ghn7qboC76CPNanh70MHxaGo02jdXkSmhJavxQL9h5a8
 4ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186864; x=1697791664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YbJ+XnM6I8FiRcFI2e93CK9heTfJrD2tl3I1Sx8RmQ=;
 b=MHSE8x5RW1yE8PeK3NxluJHbrxXSQrxCY1aufmxH2rhMzSD/NdHBcgr6PnVP0foBIz
 srzxhjD+CR87J9FNVWJisJuHzXpiW6dxLIn/7N2EyXikzisml2aQ6I1JbWdOn2tTttQB
 j10E74MpYwRv39O2AbTYJdrdAr5esfwGHSUpcLAD/QQAfqKcv4whtaREhKx0lHMyygh/
 a9CTHsKylT0v7Sk9RTrloqK9eSPO5SONFXhaUKW419RxhPMLrkdChl7C1eRhxsASUsli
 TTJWhVykNLryXZDD6EmO9mm0aBVo5O3mAm61REiz8D4fCxjYq5RjPFwq+xWWxopHwJCN
 W92g==
X-Gm-Message-State: AOJu0Yydrq3fjs379fDqcHfEGANqG9032GhDreHzdK9mdFijMfS2If0m
 EsyHzuTN+wxNCX+ys0nRqUDiogxJNfaQkhh184w=
X-Google-Smtp-Source: AGHT+IGAoeuUz+F2HBvtzKVdOgpyH8VQH7BKKoUGEgWMgF3azmKDFypt/umvAaKPFYffGrqQJrXyEQ==
X-Received: by 2002:a05:6000:1245:b0:32d:8eec:96a5 with SMTP id
 j5-20020a056000124500b0032d8eec96a5mr4002028wrx.42.1697186864744; 
 Fri, 13 Oct 2023 01:47:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:44 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [RFC PATCH v3 18/78] ui/win32-kbd-hook.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:46 +0300
Message-Id: <701a79b3378e108e01043a41ce1ed55bdf61d1d8.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 ui/win32-kbd-hook.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/ui/win32-kbd-hook.c b/ui/win32-kbd-hook.c
index 1ac237db9e..3c5c3fc597 100644
--- a/ui/win32-kbd-hook.c
+++ b/ui/win32-kbd-hook.c
@@ -26,19 +26,12 @@ static LRESULT CALLBACK keyboard_hook_cb(int code, WPARAM wparam, LPARAM lparam)
 
             switch (hooked->vkCode) {
             case VK_CAPITAL:
-                /* fall through */
             case VK_SCROLL:
-                /* fall through */
             case VK_NUMLOCK:
-                /* fall through */
             case VK_LSHIFT:
-                /* fall through */
             case VK_RSHIFT:
-                /* fall through */
             case VK_RCONTROL:
-                /* fall through */
             case VK_LMENU:
-                /* fall through */
             case VK_RMENU:
                 break;
 
-- 
2.39.2


