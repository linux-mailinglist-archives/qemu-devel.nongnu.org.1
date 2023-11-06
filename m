Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 824EA7E28C5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01b9-0008T5-BN; Mon, 06 Nov 2023 10:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01aw-00082V-RS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:57 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01ao-0004Nz-KD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:54 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso6002592e87.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284762; x=1699889562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FyfVKDCKSbX1qCn7TkWmEojEjptuQVtP+7ASpyyGWlA=;
 b=UeTsLrCnVxGEK/w5UMn66GN06CHTupRR1mYGkrm4AGFo474MEjXyLRqyYu6kZM5Nzo
 7uAoVmmOos6ak7KuMutlY3xgVNx4QBkGcjRHQmMHIxv3tr8EbY7x2wQehwCKowfuT7cW
 otDW16PKPSSFg9BeTHrgrExDmGt0F/Xsbbs49WZNAXurldYuzknDQYJ/zeECuGsMhB2z
 NSceld2Me1jmiKqolwrS0nxcoEonwP7LKE/UKCX2a23fTz2M6pnKjtUyQzq5NJXmk6gx
 qOCydbJXgJPWBsRqHusUbm4jqzhD/bUb4m0cErwZsnO0HllDyExyupnN6pIjrdrJYQ1p
 h/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284762; x=1699889562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyfVKDCKSbX1qCn7TkWmEojEjptuQVtP+7ASpyyGWlA=;
 b=Hc+AKVyTl9+T5s2L+uJmHx49kvNYbwuXSS/ey4EKF+X05rLzNFbeRL//OuGm26t0vB
 d86gr+/xvezzrMcbGZFOl3aAdHkRhT1OLZ8THgJarsvMSzQEM7IzKEEpz/rociJ9EYc3
 g765vEaJhRT0L6ne/T4IlxwXU94HOR8jNj1Ge+xukiDAFZ+PZXIhJZxATOeu0k/q5D/f
 h2r0Ba8dAc4fN4dUy+ghjqQkW63nDygb4eqooou1wdcu2nsLLQzdvWmwqFBivNVzQgWh
 ARfekvcxcT67KO8zKGBXuToN0v4LIvde4ACaSkiueh0+3UpmQ6YRhrKwZeCOasXOMXAT
 R92A==
X-Gm-Message-State: AOJu0YyW52CNN5EIErrLNEcigJ7inpJHPvV252UKKx+tcoHQ94zPGA/p
 3LvX7+cKiZTmk2SaBamY7V647eIAtSMocCkif6c=
X-Google-Smtp-Source: AGHT+IHpA+9iodkCC+N81AJKeuqWQ4mEodPKR4+xQGDolCORbisS34N1oAUcEw8UKzhsnX6+5ysoSQ==
X-Received: by 2002:a05:6512:488e:b0:509:d97:c850 with SMTP id
 eq14-20020a056512488e00b005090d97c850mr19935769lfb.31.1699284762704; 
 Mon, 06 Nov 2023 07:32:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] mc146818rtc: rtc_set_time(): initialize tm to zeroes
Date: Mon,  6 Nov 2023 15:32:33 +0000
Message-Id: <20231106153238.1426649-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

set_time() function doesn't set all the fields, so it's better to
initialize tm structure. And Coverity will be happier about it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Message-id: 20231017125941.810461-4-vsementsov@yandex-team.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/rtc/mc146818rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index c27c362db9e..2d391a83969 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -599,7 +599,7 @@ static void rtc_get_time(MC146818RtcState *s, struct tm *tm)
 
 static void rtc_set_time(MC146818RtcState *s)
 {
-    struct tm tm;
+    struct tm tm = {};
     g_autofree const char *qom_path = object_get_canonical_path(OBJECT(s));
 
     rtc_get_time(s, &tm);
-- 
2.34.1


