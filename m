Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D317E28C3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:33:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01bA-00007O-Dg; Mon, 06 Nov 2023 10:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01aw-00082U-RE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01ao-0004OU-Km
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:53 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so29055415e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284764; x=1699889564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QiKPJfj6026HtJyHgqnn8HlAlq2ojaeDiEbXyPDrg7Y=;
 b=HFVPB0TMFU74PbywsMIr4XgMECKYpELpb1YXdtqsFqjzl6+kiiVwIYPV1DPfvUvn7T
 aQpmRTLECJwoT8RVcLfZhBBrBeDdabUxYpIyJ1lWLI+NaNi5v8EakMTvzEcDHbTlbQmA
 dqeVJXBBx4cjPVtgwigC8txWMiWGuU+xV4qWD496apX8Nw2l7PV1VWZHEeX8idK2bD7N
 kxZ3tge2o22k1zYxNW0eGLqEOlee2CZcpDN7uiWO6mlOTrs6yM83Q/RmbI6qkZIhl9F3
 dFiB+KVQqinAS/ufwblB5JJIf0N1n1/bcYxBhlK69WmFUIEWXV8fOj9NRu+uXf7sKc+U
 Ma3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284764; x=1699889564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiKPJfj6026HtJyHgqnn8HlAlq2ojaeDiEbXyPDrg7Y=;
 b=ejWOov+5mGef1L9b1uRytiwSkzueFRIpaUIPtI7V4slvgKHYgSv5yxv0Kqm5SyLyIl
 0KenYAjtZUNEPq++vAU1mzdQun9/8nOgeFNpMZcZblR4Y1pTQ6712pi/RM/ZTtVR0DLr
 w8VVTQJfVNr/sv3I9e4wjYdK26DH868MnMpxsjYx/XW0xNQlZ4AARRPhQ60zOmGO/g1+
 s8XiuKH36DMhPcAyZY1+ikfPTsvsVgGcxAH2qAywj4oIU7iWMs9o9IpXeOOUoxVK680R
 U4QmJk0q+FU6FbIseZtXcJdTsugUlLDLwU3FTbYxI4xbcff36S6DulWjHuMobcwssMnc
 tTNw==
X-Gm-Message-State: AOJu0YwcBGHUKpOtRyIlM5GITueE2y7komq7/i8Szvr3DNG33IvMPWcv
 wBclW2dBRX/QDqOvJAo3o4CcFqohDMiTYsZYI24=
X-Google-Smtp-Source: AGHT+IEsr5rVh7k45aW+bVkiTPIq1IYuFX9hCrjFFIJighT2uIfH9gzgMG+b/KHNCgB9aLvEXqtfWQ==
X-Received: by 2002:a05:6000:4020:b0:32d:b06c:80b2 with SMTP id
 cp32-20020a056000402000b0032db06c80b2mr23849710wrb.0.1699284763905; 
 Mon, 06 Nov 2023 07:32:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] io/channel-socket: qio_channel_socket_flush(): improve
 msg validation
Date: Mon,  6 Nov 2023 15:32:36 +0000
Message-Id: <20231106153238.1426649-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

For SO_EE_ORIGIN_ZEROCOPY the 32-bit notification range is encoded
as [ee_info, ee_data] inclusively, so ee_info should be less or
equal to ee_data.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Message-id: 20231017125941.810461-7-vsementsov@yandex-team.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 io/channel-socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 02ffb51e995..3a899b06085 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -782,6 +782,11 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
                              "Error not from zero copy");
             return -1;
         }
+        if (serr->ee_data < serr->ee_info) {
+            error_setg_errno(errp, serr->ee_origin,
+                             "Wrong notification bounds");
+            return -1;
+        }
 
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
-- 
2.34.1


