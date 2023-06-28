Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB87415E4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXU4-0005xU-Sy; Wed, 28 Jun 2023 11:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXU2-0005xF-Us
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:30 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXU1-0007wy-E4
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:30 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991ef0b464cso205879766b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967607; x=1690559607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMlsZi72Q+9JyexsNovmnwH/F2Yz55mMGgFcrNGHUZI=;
 b=MCkqT29eRFZPRqkA78wBDHdCjibnoIDMu51OXAT7Xkit0ILYD7J1Z1vJz1gaW6UXlo
 sdTTikxGyNiRk7sijVV/3X9j8imRi6kBUynEf8WqPCV3qnO6Y218Q42Ls2NAcc3AbPKc
 /OjwAfcAOCQV7nxv4IFGJOEYrUrMB6xV5agyjOpsWEQ/069XDI/duH0X0FvurPTS+TxO
 zo8t8G87M4GtX6mK7cdX9FJs988vF7FdEG2FAvb4Bur3aZMvY8gqGZpt3jfFJvjofZ1Z
 ipXoZ3jlCHnMksxt1fDorfR3TKrCgFLyJbb/46vh8B4f7NMXp2LM9AS6FaO/MdEgjKle
 VPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967607; x=1690559607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMlsZi72Q+9JyexsNovmnwH/F2Yz55mMGgFcrNGHUZI=;
 b=cDe4dveSZoYOOQZdkK0o/Yrp2B2XScS/28F/oUTHRSX0+hbRsPKdbxVLSVqW8xbFKf
 nnYlrqd2ewDVvZP2NOns8LUNyfSXxKLZDCfRbE6AhcoZZP3XZsJ0R982Cn8wV8yELKMR
 CbHDnMD+zApJmir27/uCazaMgeNYRq5QdcnPOynykVmvNTOs3bjLrdGNbfvvtDzw3YYi
 dTTNgIutauBcJVUzDRoAFViQ2BVEKUcjaCjzTBkh8ZYiDRsl7HOgeq9ySxws3sfK2HJ4
 TlMMIUIfxBj48ZJrDnoQMnX9BYtQ8xnh+M/XAo91vGIJd0JfuNP1PqBGI+KVRuz5Wm6J
 HxcQ==
X-Gm-Message-State: AC+VfDydnMffm1rJtsZ70LntI5seEIuQTZdXw8yxYgY7IXJMNM2wjdm+
 5/llzW+5r5xaX7+jhezDxdF+Cbt7P7OWbL5AlRA=
X-Google-Smtp-Source: ACHHUZ5w5KYEpkoX+wi+EXmlnlnxtm5NocqyezynOZSulFT5MqbNr6NsTaFajz9BoX+TLFdbAiZYgw==
X-Received: by 2002:a17:906:478a:b0:966:1bf2:2af5 with SMTP id
 cw10-20020a170906478a00b009661bf22af5mr1408012ejc.22.1687967607607; 
 Wed, 28 Jun 2023 08:53:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 ss26-20020a170907039a00b0098e422d6758sm4432799ejb.219.2023.06.28.08.53.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:53:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/30] docs/devel/testing: Update the 'Docker Debugging' section
Date: Wed, 28 Jun 2023 17:52:45 +0200
Message-Id: <20230628155313.71594-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230624142211.8888-2-philmd@linaro.org>
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


