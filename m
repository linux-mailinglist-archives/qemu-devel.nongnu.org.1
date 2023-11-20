Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 948487F1F54
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:39:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BzD-0004Vo-Ke; Mon, 20 Nov 2023 16:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BzB-0004Px-Qh
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:39:17 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bz9-0004iZ-5I
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:39:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32ddfb38c02so3233970f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516353; x=1701121153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drwtQoQ75QuwOSsjQYja6ApK0ZWyT5mWD40njjZhqyI=;
 b=OCPuesFLnTny55vzGzN+ysvm91sZbnROQwfte0JO5Gk66U7AKVXMKdtwt7N/OmkFys
 cv3pDJEiO/Y3u/ODWVguBZMdXICZHB8Gsl1V37ecb5anAE88UAcJoz45fODwVqBVqyu8
 roMUyJ8vEZWJqHAi0UzqGwOQeRdUgGNL4RSOwoZ7rBMafuaespdfEehdZaTOcu0llogk
 iH9fSkyDBcKfjH9Xc15/AjTn2muCysSPwlaWnKLluoxinrfzRhcM8Qy0cPGE+ule24S6
 1Z9oPYqK6ZwQnIdUPzWhOSPFFT/rZN1Rls4pQ+48xnkPJ5+KVd1igulUJdCc9DBAlrNi
 IIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516353; x=1701121153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drwtQoQ75QuwOSsjQYja6ApK0ZWyT5mWD40njjZhqyI=;
 b=hVYEnA+N0Xq1wEHmW+1JFa5tVArRlmQEUeHIP95nMvKgxhYiLrcWJqekW3/xMlbOp3
 ubaZq7SBc8U3cOwn7YJFh7VSP9N6otrnEK7YMH1PF6VIsRK8vPcqLHWxXnwRR+xS7YVW
 0olmh5X2sNHPK7bxQ/s5Pj/Km803hTFF7SDokAxkb/j+Ex9Nkke8qxojdkEbsYJfonZk
 fa5TM0Z2jzgOAi5wKARr3APkDJ0pv/OBOYQn86IyQ5VffKRa253ge8FZlBqFDPU3apeC
 Hxiu9hAAgQU7FHEhTo27gGq7KvdexYNyENymWWjjSOn4cfjvUZ0/KNF3+ZuUbrPdPMQ1
 2L9A==
X-Gm-Message-State: AOJu0Ywnyb11iKOsqRLHQduXdPYomCXTZaCPagmeKE10AmpDaFHPc6hY
 O1KPfz3HYCwzOIIO80fpsWcHxvD5PTEi3pyA9p0=
X-Google-Smtp-Source: AGHT+IGlloYNr1MwxaUqoXnU7TSPDMnKBL9ArkwJvw2B9RG3kAN7W4RtNgtjSDXrqy/xPyUDAu+ODg==
X-Received: by 2002:a05:6000:18ad:b0:32d:b06c:d30b with SMTP id
 b13-20020a05600018ad00b0032db06cd30bmr6850326wri.55.1700516353594; 
 Mon, 20 Nov 2023 13:39:13 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 r12-20020adfda4c000000b003232380ffd7sm12279698wrl.102.2023.11.20.13.39.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:39:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH-for-9.0 24/25] hw/nvram: Simplify
 memory_region_init_rom_device() calls
Date: Mon, 20 Nov 2023 22:32:58 +0100
Message-ID: <20231120213301.24349-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical change using the following coccinelle script:

@@
expression mr, owner, arg3, arg4, arg5, arg6, errp;
@@
-   memory_region_init_rom_device(mr, owner, arg3, arg4, arg5, arg6, &errp);
    if (
-       errp
+       !memory_region_init_rom_device(mr, owner, arg3, arg4, arg5, arg6, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/nrf51_nvm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 7f1db8c423..7b25becd49 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -336,12 +336,9 @@ static void nrf51_nvm_init(Object *obj)
 static void nrf51_nvm_realize(DeviceState *dev, Error **errp)
 {
     NRF51NVMState *s = NRF51_NVM(dev);
-    Error *err = NULL;
 
-    memory_region_init_rom_device(&s->flash, OBJECT(dev), &flash_ops, s,
-        "nrf51_soc.flash", s->flash_size, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom_device(&s->flash, OBJECT(dev), &flash_ops, s,
+                                       "nrf51_soc.flash", s->flash_size, errp)) {
         return;
     }
 
-- 
2.41.0


