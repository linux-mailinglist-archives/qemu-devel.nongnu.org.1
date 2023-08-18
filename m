Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A3780EB5
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:12:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX18D-0006D6-6S; Fri, 18 Aug 2023 11:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX17w-0006Cj-CO
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:11:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX17u-0007Yv-3C
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:11:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe2ba3e260so10045375e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692371459; x=1692976259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkt8qeBW+o4jPjnQtmwyry6dtMA1gn9lr1yNsAxm/7I=;
 b=dBO3ez6iXfKSZWQ9wwStyk0pXwuQHhLJpRoDydIsRRXRLNiipDgtZ9u/kcCOv6mL25
 M6ziks3ZBJAd/8dIhUA0XDQAihq0LJxDYqKz76lX6+BxVB5VmcpI0pyGC4kcS5uQ50vA
 sM8K/c2ZFm0uP+8EpFuvVAcg11dRklvNSwtm673WVmC+UqaAyMPs7+1BCi19KzWJ3XIA
 y9j6l3RH0zGNGhP6w6n6DgoJupJia+6SxTxGksv5DxswgbbI3st9FLIoM49J7PMGRpUv
 AvHkBZfo4mjm3lzM9LVcLPa5ifl2oFa8XYtlxmc1XJCI0K6hmmvan7GVJ2Z5zdCVsXne
 F3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692371459; x=1692976259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkt8qeBW+o4jPjnQtmwyry6dtMA1gn9lr1yNsAxm/7I=;
 b=OjtOzXvHwZy/HWIKFLOWNBOkPYpR+/ufqKKBW4lQQCyfih5NGbJ4+JxwTlfUwalC7d
 BcRY7mMWnKdplAQ7g3It7YtIrT/H1tRVp2tQXRAe7mzO4V31xfEOFRcx4r7x9GDERRMM
 oiWsDH8vl5PhfUEGJee64pHF7lW/HFYLkSQ4vkdxom80UT9cpK9LHrvmcoCpvX5heMDA
 85cLLTXt/6VButfM9c37E9LBapNN8J4iIygqaKeQ9UaafYHhM5RkDRyFpL4Xo/b10a5G
 NhAXlxXm6hGUgfh9cn9Ht32rREN92okmvkkwSw57WNx1zX0apes3qSmZmhAZC2v6EW0C
 AeTA==
X-Gm-Message-State: AOJu0YxeJ6Go1BYJk9qAfmE1l9z0XYKEMtyhhs7BaUvAixapWiuPFf0J
 ckNYv9SKqrRdLm+5iSJtYDTvruVY6QJdXeol/Rg=
X-Google-Smtp-Source: AGHT+IGvAmojPG58h09GVWaC11785t7b8un9f4G1FDITviLgCZnMtKKSOXAoS9Jcnax/kEyUdyADJw==
X-Received: by 2002:a05:600c:365a:b0:3fb:b008:2003 with SMTP id
 y26-20020a05600c365a00b003fbb0082003mr2369243wmq.38.1692371459453; 
 Fri, 18 Aug 2023 08:10:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b00316eb7770b8sm3097631wrc.5.2023.08.18.08.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 08:10:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] ui/spice-display: Avoid dynamic stack allocation
Date: Fri, 18 Aug 2023 16:10:55 +0100
Message-Id: <20230818151057.1541189-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818151057.1541189-1-peter.maydell@linaro.org>
References: <20230818151057.1541189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Use an autofree heap allocation instead of a variable-length
array on the stack in qemu_spice_create_update().

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I was a little unsure about this allocation given that it's
in the display_refresh callback, but the code already does
a g_malloc() every time it calls qemu_spice_create_one_update()
so one more presumably won't hurt.
---
 ui/spice-display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 3f3f8013d86..0e2fbfb17c1 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -189,7 +189,7 @@ static void qemu_spice_create_update(SimpleSpiceDisplay *ssd)
 {
     static const int blksize = 32;
     int blocks = DIV_ROUND_UP(surface_width(ssd->ds), blksize);
-    int dirty_top[blocks];
+    g_autofree int *dirty_top = NULL;
     int y, yoff1, yoff2, x, xoff, blk, bw;
     int bpp = surface_bytes_per_pixel(ssd->ds);
     uint8_t *guest, *mirror;
@@ -198,6 +198,7 @@ static void qemu_spice_create_update(SimpleSpiceDisplay *ssd)
         return;
     };
 
+    dirty_top = g_new(int, blocks);
     for (blk = 0; blk < blocks; blk++) {
         dirty_top[blk] = -1;
     }
-- 
2.34.1


