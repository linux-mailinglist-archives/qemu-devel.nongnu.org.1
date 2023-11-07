Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F17E41E5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:35:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N9j-0003iR-T1; Tue, 07 Nov 2023 09:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9Z-0003dn-Ch
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:07 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N9O-0001T3-6Z
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:03 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c518a1d83fso75595701fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367616; x=1699972416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6yF0jXdeAMVEVevSk9oydLlQVep3u0TFDo33ugqv0g=;
 b=cjnau86P9rbDn2b1N0neXrq7+bhkrIaCCZpejorhfCAPm2IVFa4DYDcB0E9TWRUJFG
 c4+N01SixQ0ohhb9IPC/JDE1bHhkz7jx3jTMFuZWL8dDiaoeDL7hePuytS28+ATUTK72
 CcwHh7ro6LQU5Z2cIJ7wZCwMw3bTOQFI5+jagKZVjffv4iCGwgWlDshFxLDgAZLqx8+g
 3HHfBjE9wR26M/w2kMLWh2O0Jl+u6/dsUWGZhqa+v6+JQ8YV6JqrZ410rOcfDF9lS9iY
 7FzTD7GwMNpwpFsUwDfen70QMzdGS2QdRbAd/2cxh1/cPJ4iyB4qC4S5cvoHvnJ/YvZO
 Djeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367616; x=1699972416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6yF0jXdeAMVEVevSk9oydLlQVep3u0TFDo33ugqv0g=;
 b=Nph14oob0Q5+BjoGiYYnjGtbyqJYZIwjcXFrJR7fnsOMnMT7s+wKPTibDfznVAcX5I
 QZAuBs8HHCrRfv1IJfSv7apZjZTYmTVshE3T1dKUtk9sR8c8dMg32dlY95n474bq8mRc
 LEKsQc/uVymUzE6TmUARhmAhhodkJu0TFtLzrEOhu4K7pZRLGxZmk3TQ6s7HTNQw8iBy
 gXmfDC3Aqa+OYRiZwwVLOOSGHORqFlR4F6Q1K2fzk8RYaOLBv0hkk1HxjJ4Y6cx26TJ9
 sekEZLYZhxZEZ68KF1XuLClnJBRoOeEQFw0pvDxJNgOqRsAvEEglHIDPgR/OpKo96r2b
 beCA==
X-Gm-Message-State: AOJu0YwUu9DxUGDrG8FNifWnCMZdvJc6tr2UiuhrwAkMTDjDy6pMGKzk
 xkPXPI8VBAz2E4mvwYlSffc2KJJTTaP3KKH7aaAtKA==
X-Google-Smtp-Source: AGHT+IHLX1iXUAtLeTBI6fUcIWuPVWwfAiZ4XelIFs+h2iJ751VCEjD7eiZzD9Rt0m/nOEi6XgDSzg==
X-Received: by 2002:a2e:90d7:0:b0:2c6:ee98:de83 with SMTP id
 o23-20020a2e90d7000000b002c6ee98de83mr12235888ljg.46.1699367616363; 
 Tue, 07 Nov 2023 06:33:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ha7-20020a05600c860700b004080f0376a0sm15474080wmb.42.2023.11.07.06.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:33:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4EA3C65766;
 Tue,  7 Nov 2023 14:23:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: luzhipeng <luzhipeng@cestc.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 19/23] contrib/gitdm: add domain-map for Cestc
Date: Tue,  7 Nov 2023 14:23:50 +0000
Message-Id: <20231107142354.3151266-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
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

From: luzhipeng <luzhipeng@cestc.cn>

Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
Message-Id: <20230628072236.1925-1-luzhipeng@cestc.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-19-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index e676da8d47..38945cddf0 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -12,6 +12,7 @@ amd.com         AMD
 aspeedtech.com  ASPEED Technology Inc.
 baidu.com       Baidu
 bytedance.com   ByteDance
+cestc.cn        Cestc
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 crudebyte.com   Crudebyte
-- 
2.39.2


