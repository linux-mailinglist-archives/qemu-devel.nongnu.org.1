Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 538EB78415B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQwp-0003pZ-83; Tue, 22 Aug 2023 08:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQwl-0003om-Od
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:57:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQwj-0003Lv-A4
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:57:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso2003343f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692709039; x=1693313839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KhjjdQ1Ys4bOEv37PKKiFG5USj5AdZdDGxvjQEcXZiM=;
 b=A3lFYCRo/XJp4TzjB1BHAOMnXchWuxqsFswZ3dkFeXSMSptDdV5LtBbCEzfDsIOa79
 vojMV0/CntJTVtjGHQpqEzhsUn0YNwZpZYGGbV1/HFj3ucrc7PvOZyYtA9EYRAw4bFv/
 RmctOP4EYIXfWbwv7q6LSGOGpEHOy7wWqz4dXazJHGzJaROnrBisS7Ta4r8afLf2zzeN
 SHV5DNxNnLa5pHdkaDiLe8Nu+z5Mfo8DMGF24x/j06vP/EgtTObgYZNZheMSxKV6f82x
 /lDJx9LT2e5wotF1L26wmahYTwLCLDFmhlOhdCcAB0tNfFabLKpYlYL7o53a4D8aEjT/
 F4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692709039; x=1693313839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KhjjdQ1Ys4bOEv37PKKiFG5USj5AdZdDGxvjQEcXZiM=;
 b=P6vHT+VOuKKMtAAo4PMU/Vy87twOscFDfDatX/LbFggqQXAINh1xXPzyrNvSeDaaiY
 wFgHuVLuz9uNplrYnQwjq2213hlkYqp/isQlC0J35p5Pd+0QdgOmCMi8+YleBbX7kXQD
 nkdriArofk+yZzDPlgEUotWTloSWvxbH91FbU41uZWsSLUluY6neHqvKazhlO1PofzVt
 FtjKQWaGPcsfCIkgHY/C5D5cYDNvGFwBu023uurACcxRJgniOoD04uzxxIEB15sHuzTi
 6grn4hxInttIrfB3tg106tvOY+biABf0QRGeoe638WZn9/QPA0XEj3TOjrc1ULg5f4j3
 eq0A==
X-Gm-Message-State: AOJu0YwfFcEJTQthFjHMnsvY4Zjb4LSCq885q5pD1hOEI1BfOyikmo2i
 /d8UwP8uS1JUsrKvSwc0j6nfishG+40xgQeX40cTCg==
X-Google-Smtp-Source: AGHT+IEO96M1v/rAWm9eybt34iKapyULgioKqA5Sx5ODcfjl9wET4wpmzENzLRVss3qUjfjjZTjbVw==
X-Received: by 2002:adf:f8c4:0:b0:314:d31:f7 with SMTP id
 f4-20020adff8c4000000b003140d3100f7mr7258433wrq.63.1692709039566; 
 Tue, 22 Aug 2023 05:57:19 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 h1-20020adffa81000000b0031980294e9fsm15705570wrr.116.2023.08.22.05.57.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:57:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] docs/about/license: Update LICENSE URL
Date: Tue, 22 Aug 2023 14:57:16 +0200
Message-ID: <20230822125716.55295-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In early 2021 (see commit 2ad784339e "docs: update README to use
GitLab repo URLs") almost all of the code base was converted to
point to GitLab instead of git.qemu.org. During 2023, git.qemu.org
switched from a git mirror to a http redirect to GitLab (see [1]).

Update the LICENSE URL to match its previous content, displaying
the file raw content similarly to gitweb 'blob_plain' format ([2]).

[1] https://lore.kernel.org/qemu-devel/CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com/
[2] https://git-scm.com/docs/gitweb#Documentation/gitweb.txt-blobplain

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Drop '&ref_type=heads' (danpb)
---
 docs/about/license.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/license.rst b/docs/about/license.rst
index cde3d2d25d..303c55d61b 100644
--- a/docs/about/license.rst
+++ b/docs/about/license.rst
@@ -8,4 +8,4 @@ QEMU is a trademark of Fabrice Bellard.
 QEMU is released under the `GNU General Public
 License <https://www.gnu.org/licenses/gpl-2.0.txt>`__, version 2. Parts
 of QEMU have specific licenses, see file
-`LICENSE <https://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE>`__.
+`LICENSE <https://gitlab.com/qemu-project/qemu/-/raw/master/LICENSE>`__.
-- 
2.41.0


