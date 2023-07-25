Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC037610C5
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFFF-0001Ut-Ki; Tue, 25 Jul 2023 06:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE8-0000IK-8k
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE5-0007Vp-Mh
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fc04692e20so52686205e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690280707; x=1690885507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LicjyZN3b/YUo5rE9Rcv6mrB/LPasqs2dSTgyc7oBvU=;
 b=JgA3qk/RdInWcQKiQ0PPOOOrSkEaeSLJBucMWy7/HIn+Y001VkNGy9sk3qnojVFypD
 7QE/SqE6zlGUBgvCumB6ozGVAseucr4Dat82QHPjGInn7A+Do4exeOHn67x1B9Xwo2qs
 DuTIk+Vd4tqQz+FjLBNgIPO9i4uTNIQ1wfcO/woVQR/vWmkoYJaoTdNL9wc862wYcSoU
 cbEkUlpPZmnH7HCYJE9G3xbx9RTOsXRE51oGvPmmw7fZkzZboq6wd7xut3eO9YtQFUoD
 Zc5Q7wapBM8Z56y/dXMu2LpXlvnONc9tU9Vp7FVTYR5DWZICyFWIE0hNK8fW+3zhKiPU
 5ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690280707; x=1690885507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LicjyZN3b/YUo5rE9Rcv6mrB/LPasqs2dSTgyc7oBvU=;
 b=MVyDlEK89ktJ5x9o26htlsRkNfz7gh0K+2D9aZNHbZ7XqW2UMEhvver8KqTbvb1oC7
 6vPjZxwrDMEcV8QwwzJBHWXyE4uOCquR7Z/iRmssdkHwc6M9++yQ2+NaWr5vuUWJtRmC
 MB6dLtowuuHfiqAWuDGKOZ41Q74P/uRoLiVLbkStTwizx5C+0MYBKuiyuQfgxGtEIxXa
 UBac25QvchTpgXZd/YJydSlNCOUwFArFAqKX6hCQUFPk0CjGUPNrsZSGEwQaAOV7nL5K
 u0XApK3wTKo7dzbAJdlp6wB27aM3FkQTTCPPDHs/4KhYyQW/SFc0FcXOUrliiSFriHq4
 APrQ==
X-Gm-Message-State: ABy/qLYPWzNKasjJ9qixQPIX3rwjEGJuatnU+W4NJLrReVbdPIUofZIp
 YeDL4UQaIABUY4675D9vCeVksn/Wn0+5/BsUTc8=
X-Google-Smtp-Source: APBJJlFlcM0awL6uLv7XbsPrWdV4ht5R8RwSXx5sF7xvVC0A5kbian6Ur/yoKcKImqnvp8MwyL8CTw==
X-Received: by 2002:a1c:6a13:0:b0:3fb:b3aa:1c8a with SMTP id
 f19-20020a1c6a13000000b003fbb3aa1c8amr9888741wmc.16.1690280706906; 
 Tue, 25 Jul 2023 03:25:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c211300b003fbc30825fbsm12567185wml.39.2023.07.25.03.25.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:25:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] For curses display, recognize a few more control keys
Date: Tue, 25 Jul 2023 11:25:02 +0100
Message-Id: <20230725102503.2283907-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725102503.2283907-1-peter.maydell@linaro.org>
References: <20230725102503.2283907-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Sean Estabrooks <sean.estabrooks@gmail.com>

The curses display handles most control-X keys, and translates
them into their corresponding keycode.  Here we recognize
a few that are missing, Ctrl-@ (null), Ctrl-\ (backslash),
Ctrl-] (right bracket), Ctrl-^ (caret), Ctrl-_ (underscore).

Signed-off-by: Sean Estabrooks <sean.estabrooks@gmail.com>
Message-id: CAHyVn3Bh9CRgDuOmf7G7Ngwamu8d4cVozAcB2i4ymnnggBXNmg@mail.gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/curses_keys.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/curses_keys.h b/ui/curses_keys.h
index 71e04acdc75..88a2208ed18 100644
--- a/ui/curses_keys.h
+++ b/ui/curses_keys.h
@@ -210,6 +210,12 @@ static const int _curses2keycode[CURSES_CHARS] = {
     ['N' - '@'] = 49 | CNTRL, /* Control + n */
     /* Control + m collides with the keycode for Enter */
 
+    ['@' - '@']  =  3 | CNTRL, /* Control + @ */
+    /* Control + [ collides with the keycode for Escape */
+    ['\\' - '@'] = 43 | CNTRL, /* Control + Backslash */
+    [']' - '@']  = 27 | CNTRL, /* Control + ] */
+    ['^' - '@']  =  7 | CNTRL, /* Control + ^ */
+    ['_' - '@']  = 12 | CNTRL, /* Control + Underscore */
 };
 
 static const int _curseskey2keycode[CURSES_KEYS] = {
-- 
2.34.1


