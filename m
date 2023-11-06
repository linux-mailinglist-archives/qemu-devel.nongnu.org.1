Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8CD7E2C8B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:00:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04o2-0002tN-42; Mon, 06 Nov 2023 13:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04o0-0002sq-Lm
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:36 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04nv-0002PR-Vh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:58:36 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32faea0fa1fso2667540f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699297110; x=1699901910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBk0h96fdhXpmhym+tL6OJZ4Em9fv1dR5en6dOONc7Y=;
 b=o3HJ5cTe5age5k47XTbZLudSLrOQBuftdUwqCEFsYXVgrdCX0B5JvgvUULZUC3+bU5
 VOT/09Y+43XNnbrOTYPHFzJsGO0s9Bj47ZZcErzFRI9u4ktF6oGusv0aYIZ2QjRi1mIj
 hSM2ANIyLxpJpeg6F+rqYkjqfaOq+C1kl/MxFTcaFwta4L/E7oUn6po66w/tp7mTzaeN
 eEYcKoKVAnFRux/yPXHaIwFXdZidnENxTl0jk7ufiX3amb607ETF1s1x5BVLYFe8sOW9
 7lyHj0HR2ttT3OBdQyXQFloAwG/VgaEpdtuP7NSNuPa0NyOsXXux2ogKNf60Ulma3mVD
 Ifiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699297110; x=1699901910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBk0h96fdhXpmhym+tL6OJZ4Em9fv1dR5en6dOONc7Y=;
 b=uhUy1EeFwHgR1re46cRWl2+R9f1Gv8S+HXpDTLjfLiscf04vtaYZBUzkPC+yHtZ+mX
 g6yLdtITHD/AdHGsas1J3hDJStXHCk0DFNrW10d7M2FrYt/qjtfgKNBB9kffSSvNUsqG
 5We6vPEd4O/Qk31CuaElBHEf/5woBMplKTGGFaCPvlaV4dwKeyvAkbq43yAc7pyJncmv
 9IJrDW/hB7UGu8sVKPMAqzci6PIgUW9tgRm4JuY1ih5DQeajwfEEFWsA4tOL7sRHvPPr
 Ur/RyzqEaMbSqkyg3Drlv/jKmjoxbpTc1AXJA57ONqjGTiFLZh4kk5LV6rt69h8pvKq4
 xSSQ==
X-Gm-Message-State: AOJu0YwyT0Ds+ktB8O94wUXjDzQwkXRd5BqHz2bBntJkhEEjx+uJzqZ0
 0vc12Kyy50JBGJbYYf2Rcudj9Q==
X-Google-Smtp-Source: AGHT+IGBR3KFOX6LjpEix52+LLNcxsjj+KM1mxwPwkHEDsiOI5W1PBrlVYH1Vz2O9ZBFWBpldQPc+A==
X-Received: by 2002:a5d:5a1b:0:b0:32d:8c67:be05 with SMTP id
 bq27-20020a5d5a1b000000b0032d8c67be05mr326766wrb.22.1699297110409; 
 Mon, 06 Nov 2023 10:58:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t13-20020adff60d000000b0032f7c563ffasm323158wrp.36.2023.11.06.10.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:58:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2D0C565763;
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
 Yicong Yang <yangyicong@hisilicon.com>
Subject: [PATCH 19/22] contrib/gitdm: map HiSilicon to Huawei
Date: Mon,  6 Nov 2023 18:51:09 +0000
Message-Id: <20231106185112.2755262-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

HiSilicon is a wholly owned subsidiary of Huawei so map the domain to
the same company to avoid splitting the contributions.

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231013154424.1536392-7-alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 38945cddf0..42571fc1c4 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -22,6 +22,7 @@ fb.com          Facebook
 fujitsu.com     Fujitsu
 google.com      Google
 greensocs.com   GreenSocs
+hisilicon.com   Huawei
 huawei.com      Huawei
 ibm.com         IBM
 igalia.com      Igalia
-- 
2.39.2


