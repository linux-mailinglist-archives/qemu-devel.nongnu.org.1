Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159477A32A1
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3r-0006ui-Dc; Sat, 16 Sep 2023 17:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd37-0005Dp-JY
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd32-0000Ur-JH
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:57 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68cbbff84f6so3074847b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900511; x=1695505311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrUTbAqq5Rh4+S6dQa7CskGzlO2N+g4ynCNykCd/g2Q=;
 b=YvzGujSWH9m1mPq1d6wTquDp8a9Jy+Usp6wJcDRbhmFaEegu1iRGbc3JQnOqMgECVc
 XiJp/9loeTk9YySqzIelb8fvLR0JcrQRkwPgsxAVQgUIJH21JO++1WuEXZ6+ZYdpxbWW
 T+uZGPy+BQKOAqE6R6ZW33gctzsBT+75HLKJgM2OtbtSFr58awi7OiGH84bbfN19ciWz
 TP91OdSG/5arOoGM58Nevl5n4xM3VXxbXuTu6Ujkvf93YLUalQfskOK4cZXkaPqwgbOH
 t359JSXDArx5PgDKpIYwTf8ZzMc8WVKhXopjmUDAJNeBalUAF+FSHf+fw1DeakrwFtx2
 P7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900511; x=1695505311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrUTbAqq5Rh4+S6dQa7CskGzlO2N+g4ynCNykCd/g2Q=;
 b=hbztMprcQ7pGDzPe0xodk7WqtfyNyN+YIZ6dheG7cX30QfjeJG/optaq2HxFm7Itx6
 UKwgAW1sgUc3HTloiLuTpdaY/FIZYdDP/JWSpRmCNW4lkFBWDQIzcL+7/T7Or9X0DJdH
 KF9SxTK/xqGKagjysYkrSLfpk7+wekg6cNH1xUa7T7rEmlnljOqhuaM8A47+zq93Q5um
 npOddNbicRIvRplrJpSLbfzzCfiV5c6s32NBGUI7ZbnR8VbfRH3fxhruXNRXBLbXHOE7
 g7tkr9iib/eFvlUxm+MhWsoDrHU6Yo/Uk3wRwW1d3BtuIUMHbKVaT5eXCNBiOfmhPiYp
 HkIA==
X-Gm-Message-State: AOJu0YxrF8b4GGIeyRkgTbs+4IhJQQ4XSQ2enDxj4kDuheUYXjoMeNu6
 l2URLgWidfpfAdXboSVOQzaX+fyEXC3MNAw9NSA=
X-Google-Smtp-Source: AGHT+IFHuJeXBnIA13HT1F83cM5mf7IoThrDjCVyXKl2fvTWv0Y05qqpGr4DYmu7oNiDw2g3hlwn0Q==
X-Received: by 2002:a05:6a20:4413:b0:13f:13cb:bc50 with SMTP id
 ce19-20020a056a20441300b0013f13cbbc50mr7892023pzb.25.1694900511377; 
 Sat, 16 Sep 2023 14:41:51 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 27/39] accel: Make accel-blocker.o target agnostic
Date: Sat, 16 Sep 2023 14:41:11 -0700
Message-Id: <20230916214123.525796-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

accel-blocker.c is not target specific, move it to system_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/meson.build b/accel/meson.build
index 638a9a03ba..76f3cbc530 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,5 +1,5 @@
-specific_ss.add(files('accel-common.c', 'accel-blocker.c'))
-system_ss.add(files('accel-softmmu.c'))
+specific_ss.add(files('accel-common.c'))
+system_ss.add(files('accel-softmmu.c', 'accel-blocker.c'))
 user_ss.add(files('accel-user.c'))
 
 subdir('tcg')
-- 
2.34.1


