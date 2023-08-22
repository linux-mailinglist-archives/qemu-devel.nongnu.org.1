Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E7783B46
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYMFZ-0000if-S0; Tue, 22 Aug 2023 03:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYMFR-0000iL-Oq
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:56:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYMFP-0005iv-6U
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:56:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fef34c33d6so13770965e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692690976; x=1693295776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MRxgtngcnJkoNC9JzxpTAM2uA3icBF7guPsZ8zeIm0s=;
 b=LbeHQY6V0mLgSjRIkJTn9wmuuCw5ABj15sf7kRP5yCMPVDyGMjoerL6JrjthMruq+/
 608LPk7RSj8c9VOEMYEX7yrOTpC/v4LPwF3nE+W3H1W9UTn0QzcviI6RbwrIDPmjuSIM
 0cZCzJFPE22WBVO7Ujdmh3jGgbGw5BRBZm17KuooMyCRoPDfm4rs82P0dFXwLt3bbpeV
 vev1Wzb+44iA26wQV8cyMGevSyxar8yfJV5W8gnD4DddZLnep0sCXB0ERx+I4kFjHFIV
 ky0inAba0s2d9WIcroaTkk/xK+RtUZ8Bn7gze6qIGvQ/cx7XuKlt6r8ofemrOz83nmyR
 ff8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692690976; x=1693295776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRxgtngcnJkoNC9JzxpTAM2uA3icBF7guPsZ8zeIm0s=;
 b=N4aecizZXFBWUrsv1zE357xRWBB3K8r+dMWKoYfxkMdznAb5YH4EzM7QYhLIuqzT7q
 WuAQHa8GGG5sQq5vTugehHdvy7ATKniv29hpNVLAZuPyiPVpPh1VNe+tHDk7S3xi8XEB
 A2NUnauKyI7TAHn6RyIsVvctKklPV8NUwx23XmPdZWjSb+IOW5eAsGYH9XV1Fjd0wJiu
 qukZma37kOsmGt3Bu6CEGM2gr5Zh+b7knZnrLueCaQKTIPDvs/uq2VUSi3uFLZgH6rfJ
 IZTWAhVinVhwHogLsSDpPMtDq/uTWIff/zcKLpKlBaV5crBXJrMRnLyppTtY15L0ybDf
 /5fg==
X-Gm-Message-State: AOJu0YztVXDcX1B+i0jT4569v3bcAO0zRc0+4aN9ivczf3VJNaZKNYzu
 /lP2HLK+xI1xp9XFR1woZQ2AvhtfuQEkB4rdUTj06g==
X-Google-Smtp-Source: AGHT+IFGqfeHCcR3E+TuedOr3b3GkoPcNs8jTKVjPGvshNBqb7cDKr8s0CBnxi0Wsmjc57IdsA23Dw==
X-Received: by 2002:a05:600c:2218:b0:3fa:97b3:7ce0 with SMTP id
 z24-20020a05600c221800b003fa97b37ce0mr6685918wml.26.1692690975764; 
 Tue, 22 Aug 2023 00:56:15 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b00316eb7770b8sm14999786wrc.5.2023.08.22.00.56.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:56:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] docs/about/license: Update LICENSE URL
Date: Tue, 22 Aug 2023 09:56:12 +0200
Message-ID: <20230822075612.36460-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
switched from a git mirror to a http redirect to GitLab (see [*]).

Update the LICENSE URL to match its previous content.

[*] https://lore.kernel.org/qemu-devel/CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/license.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/license.rst b/docs/about/license.rst
index cde3d2d25d..f5f0e25a7e 100644
--- a/docs/about/license.rst
+++ b/docs/about/license.rst
@@ -8,4 +8,4 @@ QEMU is a trademark of Fabrice Bellard.
 QEMU is released under the `GNU General Public
 License <https://www.gnu.org/licenses/gpl-2.0.txt>`__, version 2. Parts
 of QEMU have specific licenses, see file
-`LICENSE <https://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE>`__.
+`LICENSE <https://gitlab.com/qemu-project/qemu/-/raw/master/LICENSE?ref_type=heads>`__.
-- 
2.41.0


