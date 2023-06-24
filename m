Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1D573CB5B
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 16:23:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD49n-000204-08; Sat, 24 Jun 2023 10:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD49k-0001za-UY
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 10:22:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD49j-0007C4-Ba
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 10:22:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-311394406d0so1523708f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687616545; x=1690208545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+21lC+HOQ8qNUuDYixtokmJmiBo7Avq8JzwolirhIw=;
 b=oWfPeMYBI2esyVOHHcKGVQanwudcOSsjsFYTnCp2/j5UkhTs1KmIkbvbPY9Jo17lQ6
 cWycPQuiH3zQZjPsiAiW+CrnXcCrHW6+wcBFviwwgKCBhinbTuhm27k4vvCzU/1w+SgT
 B/IMD0phxuogU7Puzehfmw+VvZoi2iALcG+6qYuJQ3w32HYCwp5TEUzuARYWzl2kS8Jn
 +P3RQ5Z3UwSOolApXXxqeYseVD92PnrXftE6yB6f9o3Jr6kE3uqQ1Kzft0pqnQz+GnK7
 CII3WyJHi4THlWoSG6y6U9FeX4jV72QrXlFmWiqSQRDcp4uF8V3ad+UI4Q3OCclaX+MN
 jkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687616545; x=1690208545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+21lC+HOQ8qNUuDYixtokmJmiBo7Avq8JzwolirhIw=;
 b=OiumV7qQw4TS+PDgqBmDW2AdOm5qLaSfvvcCLGeyJEkMOGK5qESroV6zHbZtvoD0R1
 +42e1B7Xozk/8hdDBk8IYVNMQdKJlLKL2uEE9NFLfPhXnYyAVRvQTa+TAxpB1g1mbGey
 +Fx5JXaBh9CXavax3fYKCdsX3fpC3Mkl8itVIR6YK+v1X6tBnQhraQAIeyyJuLwfsT+Q
 11hSM9NScnvOyGaNBxT7TOSZPi1YE73M/vstlYg9vE8sfiS1mr8COti29Kavw12l0ljF
 pxJgv6jEGsc5KGG52O5+eAhkX2L7eDD6BNrT+gMFQQXxoyb9kHrfITLxMa8flLC+trFV
 7HdQ==
X-Gm-Message-State: AC+VfDwDoxCyoqxGsNsd1A0AfhOt9pdyQRGgJWxc3pA8Fh6ytaz5gFG5
 otS6gT2Yq2bG1zLU1wfnckg/usW5j/FlC+yO9irt0g==
X-Google-Smtp-Source: ACHHUZ4/1FH9PZA9VdR7tRA0HUPsxcUuZOjk+7f/owPi5vboDaaHvInS5xxBXy6IA82wdvZ2lvjMBA==
X-Received: by 2002:adf:f74f:0:b0:307:9b66:f512 with SMTP id
 z15-20020adff74f000000b003079b66f512mr18409505wrp.19.1687616545505; 
 Sat, 24 Jun 2023 07:22:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a5d674d000000b003113513f491sm2203583wrw.114.2023.06.24.07.22.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 07:22:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 1/2] docs/devel/testing: Update the 'Docker Debugging' section
Date: Sat, 24 Jun 2023 16:22:10 +0200
Message-Id: <20230624142211.8888-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624142211.8888-1-philmd@linaro.org>
References: <20230624142211.8888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Since commit 93cc0506f6 ("tests/docker: Use Fedora containers
for MinGW cross-builds in the gitlab-CI") the MinGW toolchain
is packaged inside the fedora-win[32/64]-cross images.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/testing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 203facb417..e85e26c4ca 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -558,7 +558,7 @@ When CI tasks, maintainers or yourself report a Docker test failure, follow the
 below steps to debug it:
 
 1. Locally reproduce the failure with the reported command line. E.g. run
-   ``make docker-test-mingw@fedora J=8``.
+   ``make docker-test-mingw@fedora-win64-cross J=8``.
 2. Add "V=1" to the command line, try again, to see the verbose output.
 3. Further add "DEBUG=1" to the command line. This will pause in a shell prompt
    in the container right before testing starts. You could either manually
-- 
2.38.1


