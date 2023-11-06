Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CD47E2C84
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:59:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04o0-0002rc-11; Mon, 06 Nov 2023 13:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04ny-0002rH-2N
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nt-0002P5-VE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32f8441dfb5so3330639f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699297108; x=1699901908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWjpS4SxyhpG8vcouNGxzG6/OAkqKjRKLB6d8VxGNzw=;
 b=qcI1SZxPeTfW+rh4U4Xo/hL+SQDRnHs4l4g3ghanxAmpeoEvlVLrRLlA6Ef/Rb+d7Z
 ArcJsllrvmjlesW1elieXcbXRLu3Fi9PPNjW5uz/ekJDM8ozfDUHazgUUOX79hGrlPnU
 tJqI/G4ktct8ut42MCToU7wxRfjI7jiJhgbgNhWaY6jyz6nxRcsjDrk71wKKCm379mIX
 8rj9COOiw9XoYWix+9ZMpsVlUEq+73fP6Bb7r9+FMULL0ibwMztWzQFsJeP/1brjfL+u
 0H9tPxLszjQJLhPE7gOHLXqCgHZ66CYuYYsjGyyjSxNUvRMFUa531HzlRTJxQN7dEsj5
 FfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297108; x=1699901908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWjpS4SxyhpG8vcouNGxzG6/OAkqKjRKLB6d8VxGNzw=;
 b=MUa7xlD9J6aJSiPqcKAKfeZLrxT18IbxeRRHIZh1kftWMvEm8btAjE0hAjO9lkvI1P
 Ao1GyyCJPVlpKjGNkDGRVLELt+tLPbU28LTNm8E53r0tGVhlBOwNnOnhKl86NEwy1mHK
 lyMvcfL0ED5d7qfdDPVN/mDLIJbd2tivJ+/PptQfLcKs0+j54MTfCSsyz85gVaxAfG/U
 YhcXHAbCJrDRDQ4qgt4bSDUBCx3wu2eUOnp25Ko4thJczLDLEMNrK06VzR3toou2ecQd
 9ur2IG5gLS213VsgR2ypO2Z/l8jJKRFVnXp+7xPpWriJushpALDjovogz3ezTV1gWvVm
 otwQ==
X-Gm-Message-State: AOJu0Yx2d2LdMJvI6IzcIMWI6NmleZan5UM00OC3xQOwJT5LGmf1jisg
 6JsHx3oZKm76UEMSYtJ7p3TdAQ==
X-Google-Smtp-Source: AGHT+IGUFplPNCH4jr6UIkMihayOcQPS6n1ePrvdl0aHgCW7Iyi7vH/ohNFX26aI5v7Y6iQZlSVBbQ==
X-Received: by 2002:a05:6000:1209:b0:32d:9d3a:d8c0 with SMTP id
 e9-20020a056000120900b0032d9d3ad8c0mr21565736wrx.60.1699297108460; 
 Mon, 06 Nov 2023 10:58:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k4-20020a5d6d44000000b0032dc1fc84f2sm327003wri.46.2023.11.06.10.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:58:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1989365762;
 Mon,  6 Nov 2023 18:51:14 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 luzhipeng <luzhipeng@cestc.cn>
Subject: [PATCH 18/22] contrib/gitdm: add domain-map for Cestc
Date: Mon,  6 Nov 2023 18:51:08 +0000
Message-Id: <20231106185112.2755262-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-Id: <20231013154424.1536392-6-alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

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


