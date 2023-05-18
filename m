Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A187085F5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:22:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgMz-0007du-G4; Thu, 18 May 2023 12:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMs-0007a4-2x
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMp-0006Oo-Db
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f423ac6e2dso15007015e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684426838; x=1687018838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9bOCy8hfslLOFUbFXGRnstMdv8Rmiyu6+GL3b7wJvQ=;
 b=Sf9UO7H/kY0lxXEeBowCMMlrjC81mkfrexk2c2Iu7Tzo1adQSi5nhwPNUVrjiALdwB
 VjSvzHND6xbyjgWnzHoa2hlvFRZ+3H41vtyfD0RhNDMMxLCds/eHEZULe/QslIgG1+BA
 OGI2OhsG83leqpV7RVCRA54C9QUH1T8ca6dDIAuID8SRL8rdJm3DnXNPLMwxLQ5Gq+yt
 KaLYoMmhOQrTlBfg+e3eVEy/WNTWp93VRBp54IDZ/y9u3u8HFPk4veNGJmjRGtM9PbO4
 Zs5gquLMxJb4IR97EV2jLfciODpNwYGS10CSBJb/toFux7bH2bPHpG5CJrKAqZA+znWe
 Axrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684426838; x=1687018838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9bOCy8hfslLOFUbFXGRnstMdv8Rmiyu6+GL3b7wJvQ=;
 b=lQjhzDFmibxRxtVkp8z1A7BIccfgr6X4wG6jXLzdMLeaOMO+vvHV0geNnMnoT1ahx/
 MVkr3TYga40kg4AwNoO4T+tfXzKJ1IJSXFvE+Ov46vMVN83/wXPEcjqnGe1gfphdNBdv
 7jGw7aFVtxHTeXRh9+1aKzsSEG78WZuGZ9ascSjIfS9OeXJXu3G/cPtFcbOyaKrE3/n9
 vpkZ4OVgU6xuUVy5WqFR3FLN2yEakbCldHGh6j6kqO3tA2pdBqTj0ZdAzGml/Xt9pRNO
 0y1utRCelvj3iINehLso4vkTzEkmaRXgKky5FollNoy03Vafs7z157IqlLtKD5CH2FMf
 A5cw==
X-Gm-Message-State: AC+VfDw7uPO3+g+lCRNQmqdMAX5N8gkpKNlKJjJo1V6mfCOpbkHJ4Pjs
 yN6OAfyT9zUIgH8Xz1w3art55A==
X-Google-Smtp-Source: ACHHUZ5niRyCRrdvz48kXHl2VLwfv8iEXJaLiFeFbRaEOUVxJQiRFd++xhRIZhzAuRjVoi16COBDkg==
X-Received: by 2002:a7b:cd8c:0:b0:3f4:27d5:a6dc with SMTP id
 y12-20020a7bcd8c000000b003f427d5a6dcmr1988921wmj.31.1684426837950; 
 Thu, 18 May 2023 09:20:37 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g23-20020a7bc4d7000000b003f4290720cbsm2477307wmk.29.2023.05.18.09.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:20:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 11D371FFBB;
 Thu, 18 May 2023 17:20:35 +0100 (BST)
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
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 8/8] docs: add some documentation on avocado logging
Date: Thu, 18 May 2023 17:20:34 +0100
Message-Id: <20230518162034.1277885-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518162034.1277885-1-alex.bennee@linaro.org>
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
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

While we have fixed the logging to go under the avocado name space we
might as well mention the useful "--show" option and the streams you
can use it on.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 8f18052ba7..77402a0daf 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -983,6 +983,31 @@ of Avocado or ``make check-avocado``, and can also be queried using:
 
   tests/venv/bin/avocado list tests/avocado
 
+Logs
+^^^^
+
+Avocado collects anything logged under the 'avocado.*' name space in
+the log files for a given run. You can also use the ``--show`` option
+to dump selected logging streams directly to stdout:
+
+  .. code::
+
+   tests/venv/bin/avocado --show avocado.qemu.machine run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
+
+There are a number of useful streams you can select.
+
+.. list-table:: Avocado Logging Streams
+  :header-rows: 1
+
+  * - Stream Name
+    - Contents
+  * - avocado.qemu.machine
+    - VM lifecycle including the launch command
+  * - avocado.guest.console
+    - Serial console interactions
+  * - avocado.guest.ssh
+    - ssh interactions
+
 Manual Installation
 ~~~~~~~~~~~~~~~~~~~
 
-- 
2.39.2


