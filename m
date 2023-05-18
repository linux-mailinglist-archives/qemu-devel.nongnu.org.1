Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A07085F8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgMy-0007bf-Sh; Thu, 18 May 2023 12:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMr-0007Yw-0n
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMo-0006OS-Lu
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f423ac6e2dso15006815e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684426836; x=1687018836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hn+zKX2ZU5kJ7IFfmWrHts4Msqz+nCT2HShGHhdqu5E=;
 b=PVY9M8FFvBQzKOxMngZxYlBngSF8TKBY70X94t0LWOykD0FMMQhpgMIc9yqSkjT0r8
 egkIiyo+PWznWBc0uz/e/GGK0Ra0LwIx6rHAwknGCIDlpdhTg0tlRLMfWRLyupdJpgL6
 ZLvEkpdB4uViqcpdu+Z36dhYayROG/2EZPAGloE+5AW54n8X+KBt1EgWXY0nI6shvLk3
 SHNEjBLC8NV1hBrHdCqm18TWCL7z7Q8nRuEO2XnR52Ae/D8z82ZjXr94o/LaCb6gv9Tf
 gCGTRV3N1L/AVfu54uzgbX05NCAfWhnXtUF8RzAeozOrJLM53OFC9OLPaJbCUMFn2T4e
 b1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684426836; x=1687018836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hn+zKX2ZU5kJ7IFfmWrHts4Msqz+nCT2HShGHhdqu5E=;
 b=hXtIlBWDATPEPW68RIKzmZLNPkwfyM8WtrHCsOKvJmZ2huYAKEjncYNP+Dzugej180
 8yKzaJmQsNbU+NFnvUpljZ8aLWKsEOngZv+IKoKwMhNDTZ9gIk99b1uoF1RhYjZSgpSf
 xbT8I/Y22+8RNWCObPPVFLUvD7CHJjdvp/R7FYB8cgF76f1v2h340iuMaUhhJHVQJ75Y
 0y+hPvbctTGPVFzKXxtliBYlhocDGWjOXUuNSt+tZDfasARCwllgHn/EARL2AEcypp1B
 Z4dh0VJibDNUnGG7fysHNC9KPk00ZxZj5foPjnSxjSLuLsADD8fiWCewNpjt/YumKgtr
 tTdQ==
X-Gm-Message-State: AC+VfDxfbU6gZu1ivUFDxMcBjougj2BZIiMReK5O41A1Mw4FRgwhuLuL
 8L2EJOVZjq7kGbBPbWx8pTFa1TY4FcTyldMkXYianw==
X-Google-Smtp-Source: ACHHUZ47EwLfiIf78/APLnPtdRxV697QarkvPGswTFmoIySQt2U04ywhAmYsTa7EnOEApqeXghZ2Vw==
X-Received: by 2002:a5d:4988:0:b0:309:4289:91c9 with SMTP id
 r8-20020a5d4988000000b00309428991c9mr1882856wrq.17.1684426836297; 
 Thu, 18 May 2023 09:20:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a5d61d2000000b003079c402762sm2634267wrv.19.2023.05.18.09.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:20:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BC471FFBE;
 Thu, 18 May 2023 17:20:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 3/8] docs/devel: remind developers to run CI container
 pipeline when updating images
Date: Thu, 18 May 2023 17:20:29 +0100
Message-Id: <20230518162034.1277885-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518162034.1277885-1-alex.bennee@linaro.org>
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Ani Sinha <anisinha@redhat.com>

When new dependencies and packages are added to containers, its important to
run CI container generation pipelines on gitlab to make sure that there are no
obvious conflicts between packages that are being added and those that are
already present. Running CI container pipelines will make sure that there are
no such breakages before we commit the change updating the containers. Add a
line in the documentation reminding developers to run the pipeline before
submitting the change. It will also ease the life of the maintainers.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230506072012.10350-1-anisinha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 203facb417..8f18052ba7 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -485,6 +485,12 @@ first to contribute the mapping to the ``libvirt-ci`` project:
    `CI <https://www.qemu.org/docs/master/devel/ci.html>`__ documentation
    page on how to trigger gitlab CI pipelines on your change.
 
+ * Please also trigger gitlab container generation pipelines on your change
+   for as many OS distros as practical to make sure that there are no
+   obvious breakages when adding the new pre-requisite. Please see
+   `CI <https://www.qemu.org/docs/master/devel/ci.html>`__ documentation
+   page on how to trigger gitlab CI pipelines on your change.
+
 For enterprise distros that default to old, end-of-life versions of the
 Python runtime, QEMU uses a separate set of mappings that work with more
 recent versions.  These can be found in ``tests/lcitool/mappings.yml``.
-- 
2.39.2


