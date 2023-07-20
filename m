Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6224D75B2BB
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 17:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMVc8-00014t-Iv; Thu, 20 Jul 2023 11:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMVc4-00014c-17
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:30:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMVc2-0004NL-8O
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 11:30:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3143b72c5ffso804069f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689867040; x=1690471840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KEaKX3kEy5qA3NPRdPTosgOCxlc9h8BoFXR4F0s/e1o=;
 b=X4IZJAAE5hPvy5+XRUQuar8PIbqOBSUhvIKGdRIKVJKzvkIJjPemhhHqtw0mGaxCHi
 pXE7AltbFsYFn/fXJF92y6iA19YF4wFBIzu8nGNSbGP9obAJWnTMYZWXEyElcpfZtIKX
 7E+GK0yJoUdmUURHvGuw6gPyUL4qyhztazxKgWnfC0iLF1JcDdmUpT3SyPBtV+ieHZh3
 cF6Zet1eQgTWnQyovNS+86RV3WeDZ+w+NxMinUDTn/MWgQZNJEZ32zkTWHZ4qJccNTc4
 n2ONP1Ej/UP9SQ+00vhGQk3vM8fWxUD5d+asz3g8Ny6Xzu7eWZcOlWjvsgMvA8izoiie
 RL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689867040; x=1690471840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KEaKX3kEy5qA3NPRdPTosgOCxlc9h8BoFXR4F0s/e1o=;
 b=TDbnpPfZjqFbe2jS3BpWWDGizOuE+tmOjceOhz6LLfd7K/S9zm1QP72tHIi1erYWO2
 gkM/fJu00B9rC/ITMWwrgXcYaHhWrc9g1CM9luWsDn0O5+e+XdjhIKYJ8FmG/WAPUY0+
 ME5y4ELpQF7vwrSnYJjUuNXs4P6LyAtF7Op2o4bboyWV5WdZwr7Q9xKMlpQ6so9Z7ryS
 /sLIE06LgmzUqHUJU0ePxriYI2aDNtET61v9G5bjIqM7haDHP+LNyytUb9w2of5A/QDl
 u931FdCG7+GRx76lAB2cHKI0lx3ufqelfOGoj5rYYcR4jlaHe4fCFyUYzX6gqPbuGsIL
 Jk+w==
X-Gm-Message-State: ABy/qLYUCYO93+UbfnH0FicFcqtzux8Bsqt109cX8Z8ZWpB2kYEW2CeT
 7AVR8pGkTpX/eNjxbG29YM/RToz/PAZ5TIAmWYA=
X-Google-Smtp-Source: APBJJlFUb1+N1ssNCCl0Dl3E0G660h7dwSOHQjVCQv46Z0406LQx0eAzuDFLA2yTMKfdG9mZq0jvmg==
X-Received: by 2002:adf:ea43:0:b0:314:358a:64d5 with SMTP id
 j3-20020adfea43000000b00314358a64d5mr2633767wrn.13.1689867040245; 
 Thu, 20 Jul 2023 08:30:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a5d5484000000b0030e56a9ff25sm1627957wrv.31.2023.07.20.08.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 08:30:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-8.1] scripts/git-submodule.sh: Don't rely on non-POSIX
 'read' behaviour
Date: Thu, 20 Jul 2023 16:30:38 +0100
Message-Id: <20230720153038.1587196-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

The POSIX definition of the 'read' utility requires that you
specify the variable name to set; omitting the name and
having it default to 'REPLY' is a bashism. If your system
sh is dash, then it will print an error message during build:

qemu/pc-bios/s390-ccw/../../scripts/git-submodule.sh: 106: read: arg count

Specify the variable name explicitly.

Fixes: fdb8fd8cb915647b ("git-submodule: allow partial update of .git-submodule-status")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 335f7f5fdf8..bb1222c7727 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -103,7 +103,7 @@ update)
         check_updated $module || echo Updated "$module"
     done
 
-    (while read -r; do
+    (while read -r REPLY; do
         for module in $modules; do
             case $REPLY in
                 *" $module "*) continue 2 ;;
-- 
2.34.1


