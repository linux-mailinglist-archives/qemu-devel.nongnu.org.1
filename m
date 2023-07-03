Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA2745DC9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:52:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrK-0007ph-UQ; Mon, 03 Jul 2023 09:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0007TJ-Sd
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJqy-0005fp-GQ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso18343015e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391870; x=1690983870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiQlfRY8hx1yBgb3vRhqIt9YmNckd07v2P9mNQ4jgVg=;
 b=Po6kbvGTvKxsnURztTdT020UjaPCZfHnfdHEfbQnt7dsmximvpIBb65QPKrjecIuo8
 w5Eck8ftlfMySe7IY9OOpgkjYyjtuiXr9H8ZVHGw36rMQggW+Yv4TWYK1V4tQ2xpz9X4
 brJalduftFake2E7JlO9It88D5y77l6aYylfDdu8vDbw/voRnjwPUBiHFkYvWccmeERZ
 eK4Y8rYpCd8+Qp7UMQu9KQyMSC0mI9QUGNvK2N8h8MnidFefl05BO+6YotvXQeagqnJw
 5aV0ndhg5SsGj6iTNWvT+WO0Kjldp5JnUCCY8oTopSVlL7MZ7OkMECkGi13pL+4rccks
 YsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391870; x=1690983870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiQlfRY8hx1yBgb3vRhqIt9YmNckd07v2P9mNQ4jgVg=;
 b=bj9QqOjKx212fcrvCBgyWEIKHmmdwWhKCktI9yMSxwvoqkuf8RHOpy63zZ8o46MPb5
 ph9tHKM9JELXnWaJ7iDjXp2FcL19C94XQrST4eOnmrE0J4tvPNPASSyvUPJ2h2mBreVq
 CXqw1k2vfMDDDrxF4FVDCMniB4Vwtb6DtOjT4oWTPyGv8+A+4892OsYKjipDm+jX/Ac7
 FQTAfFtrYoNBAzGdD391zkYyGBX35oNhJtk9FDEygVcNLO0Wtq281xfKWu1fsDP9xC4r
 ekxQF5aW8Hl0ZR42Ab5B5ub1mGKTMPpRAXegoJoDpdPQIOI5HmOcthTfd2VlC3AQDGj2
 64lg==
X-Gm-Message-State: AC+VfDyS190eZs1WgR17NeIRN2cyAG6TX6zQew0s3QsqsUt1HmM75NOf
 r29kaxOMdCwlzezO60NY6SdGTChVWCLR/GlUw7I=
X-Google-Smtp-Source: ACHHUZ6TmNvEiGZfFF4y02iCvlU7DbIV7lR3kSo2i8MivChqFMD+/UMrTgLA6qsrjvnOqtiyGdfGbw==
X-Received: by 2002:a05:600c:2148:b0:3fb:a6ee:4cec with SMTP id
 v8-20020a05600c214800b003fba6ee4cecmr7893652wml.33.1688391869940; 
 Mon, 03 Jul 2023 06:44:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a7bcb95000000b003faabd8fcb8sm20974977wmi.46.2023.07.03.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 498411FFBF;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 04/38] docs/devel: remind developers to run CI container
 pipeline when updating images
Date: Mon,  3 Jul 2023 14:43:53 +0100
Message-Id: <20230703134427.1389440-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-5-alex.bennee@linaro.org>

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index e85e26c4ca..fb651eae11 100644
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


