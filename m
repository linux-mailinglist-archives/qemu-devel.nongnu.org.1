Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C534735999
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:33:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtU-0001dJ-CW; Mon, 19 Jun 2023 10:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsp-0000eE-KJ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsn-0002Fw-3T
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f8fe9dc27aso22162115e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184968; x=1689776968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7NGVfS5DtDEvRzAeh2tIxqusOp/nBTZ4y0VaCfreOUI=;
 b=TCecmzQ4uI3qKX4AN5uhqRdKZG+kTZf30LuPRxPDu0EUVIHu8xrBCIzDfZSOcSmu8A
 dif7ri655s3d/7jRapMFbFZNTazLVW3GgNvPy2mfUfLBx5u/s78QWwQGDG28fthjymOl
 XvjuQ0vmvu2RBg3WkUAGTszn7FHLKnYKqOJdX8d2anUxvLfJnzuox5rbTExjq0OpikIi
 7fBUVIm8vU6HxUsms+UP9xKSrnCRIuRzz0CU1CF6bXWMBul2DJmouX/eXuGuTmaJHIoL
 ImxKH0PUlLA5fWXWKahH5vkY8GUfI/0SoUZEe8/wicf7zGpTJv8Z3LnNA3y8e+CDkF0d
 6Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184968; x=1689776968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NGVfS5DtDEvRzAeh2tIxqusOp/nBTZ4y0VaCfreOUI=;
 b=SdQWA011HnIykvJdt24paOogfOQAd2Tue5jV3pebJlsXQL2tltT4uCyJRTexQT1Ykb
 dgENguSgI4t2UB8o2xtBJXaAZGk5BIaDwFesdFFHZ+g+JeH9NP8XlHu2LmGHCQmHZUO3
 nzZg7663ysDCjQ1FdXXZNLJSfRUZOB/fJxzYzrJB07hQ1vzSD62ldsH1OsYyEcHZzGjx
 zyKLgm9teiycoMppXl/Ip4NcRII8dECabmHp1FmsXDkP4PMt8L98ju2WOkaSHL1lxpV5
 wZwhNAPzBKgkgSIpclNRxnH6z0tmxYpfeBTFCBeX00AGCtdXGnLhrMl+JPCGMNk5MCWi
 y9FQ==
X-Gm-Message-State: AC+VfDwRae3Ope1d5mdDw/2O09Jt/Tn6ypc3+sHXkhZ52d3FhuZNQswD
 gvxD7WK26YuO4VMkfdUhtd+/tZOoIM5EGO7R5ec=
X-Google-Smtp-Source: ACHHUZ5lcOOztqfqkWW1+Te0Lxs2aZbO7/4c0EEbuh4VXtDfQNbZe9cIo/UKQ8HqcIs5kKaMWzJ5Hg==
X-Received: by 2002:a5d:6844:0:b0:30f:c22f:e901 with SMTP id
 o4-20020a5d6844000000b0030fc22fe901mr5526912wrw.26.1687184967734; 
 Mon, 19 Jun 2023 07:29:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/33] hw/sd/allwinner-sdhost: Don't send non-boolean IRQ line
 levels
Date: Mon, 19 Jun 2023 15:29:06 +0100
Message-Id: <20230619142914.963184-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

QEMU allows qemu_irq lines to transfer arbitrary integers.  However
the convention is that for a simple IRQ line the values transferred
are always 0 and 1.  The A10 SD controller device instead assumes a
0-vs-non-0 convention, which happens to work with the interrupt
controller it is wired up to.

Coerce the value to boolean to follow our usual convention.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20230606104609.3692557-3-peter.maydell@linaro.org
---
 hw/sd/allwinner-sdhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index 286e0095098..1a576d62ae2 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -193,7 +193,7 @@ static void allwinner_sdhost_update_irq(AwSdHostState *s)
     }
 
     trace_allwinner_sdhost_update_irq(irq);
-    qemu_set_irq(s->irq, irq);
+    qemu_set_irq(s->irq, !!irq);
 }
 
 static void allwinner_sdhost_update_transfer_cnt(AwSdHostState *s,
-- 
2.34.1


