Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C274B7DF904
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:42:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybgh-0005gy-2o; Thu, 02 Nov 2023 13:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybed-0003F7-R4
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybea-0002jp-1J
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4081ccf69dcso13977675e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946726; x=1699551526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WxwZDBnTWEjluaiES2WHOUMnNxEIF8yiiLOlaYQXymk=;
 b=YX1PuR3VKDXeTglGqVx6fQAUuBLH4eIgAkezV38UROt8KtsOckIO4kAAgbdFPy3z/+
 maJiOCR/sA1av2GC4rYidQcvY64uyPWKvlLE+lsRuj540scoJtnfPrCTlXLpYHYVMvMO
 Sa+dtK6cqg24/0e4OO39r7xkJghsGqggIiA8EGBSO/ikIFbfKh41hMytKnt+gMEXId9g
 9ziyO0vL7Dr6wDdV1f/sk5qHpxvp+w+JXnIS4PDUz1Pm8EYP9V17NALDtIPR98BCEc4Z
 z4UaLKl64+s/SLrulxtB0aOPg2+JeXYf2JsDG/Y0jkGWr0zm4eRPXT25hCX2ltNjCR2i
 G1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946726; x=1699551526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxwZDBnTWEjluaiES2WHOUMnNxEIF8yiiLOlaYQXymk=;
 b=is/FeZSz551HwJWe6UyNR3ovgi/kLip/8NJzISdxs4jzHPXv/uI7pA1VUHpP0mE6n5
 1ftNnom3A3RLDPWV/yIcskQ2t7oWc7XWdIhaBB3EWI34ck/nUfRulaf5pydFNUOGa5bD
 KrdYE2xggB5zd09eT/4f9MTS3wHkkDUCsYtpjg0jgFhKIxl9rck2mKNBTLqr0JCYIY3R
 t875c+F4WoMsnu1GLCJNovOvZieZ2hiks00NNEjYyvCI5V4KJezK/DXhwpZVKL8AGja1
 CXHJp/I+r1O65UEHlITywYNeULma46xN3uTu8go4mxzfAEhHlGLocxSA/vU1Z52+9Qg1
 cyug==
X-Gm-Message-State: AOJu0YxD+yx4zr/hXDzhgpuyEcn2f/yhTyDbXu/g4rs/vBWV1NCYHcH1
 IvEFiEXXJr7ze8euyYRDXJamAE/7/iL41mre5zo=
X-Google-Smtp-Source: AGHT+IGSMkAnu0f2SPyhnT/eCc9YQgF4B9hMzZpsJ8DMF+XqicdXjCENoOMlbvFKo13H2x9Rk6YiTg==
X-Received: by 2002:a05:6000:186e:b0:32d:9d03:29e6 with SMTP id
 d14-20020a056000186e00b0032d9d0329e6mr550540wri.27.1698946726304; 
 Thu, 02 Nov 2023 10:38:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/33] MAINTAINERS: Make sure that gicv3_internal.h is covered,
 too
Date: Thu,  2 Nov 2023 17:38:18 +0000
Message-Id: <20231102173835.609985-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Thomas Huth <thuth@redhat.com>

gic_internal.h is already covered by the "ARM cores" section.
Let's adapt the entry with a wildcard to cover gicv3_internal.h, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231027060709.242388-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 397c3967f6b..8e8a7d5be5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -687,7 +687,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/intc/arm*
-F: hw/intc/gic_internal.h
+F: hw/intc/gic*_internal.h
 F: hw/misc/a9scu.c
 F: hw/misc/arm11scu.c
 F: hw/misc/arm_l2x0.c
-- 
2.34.1


