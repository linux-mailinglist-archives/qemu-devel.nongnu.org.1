Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB074008A
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGZ-0000jO-Uc; Tue, 27 Jun 2023 12:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGQ-00007E-Rg
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGK-0005pr-Mw
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-313f61890fbso1935886f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882191; x=1690474191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnP8f96S0GKF3CO1A0jcmqKih6bOlzq38Er4YTCNWjo=;
 b=P6UlGJmT+TbDaUgumTWmmGYJX8XbOZZvbmobWDrKapo7Q1Gd0aq9Kdu0njqoXDtCMI
 DkMHBiNb8M6Snqr+7mq3CW+qNFhFe0Cha1uvId9WRQtbYZEJdlFcDW8u0HDLjF+dSh09
 ecHuiQITg7Oql0YyASU5zh4ZnF3Oe+xNk7dYeoMfzcspup1dKJGLtedSeYd7u38HN9/d
 4APQ+cO0GNiHpgKvm+gHvcpvA0y2NArEbIYZMe1aF08GGjr7xmPTbpB/8RvJ0/DM661s
 oNxhdOm5sDRVFWxlJpHJ5wBRhuEKN/27oLmIIFgWPJVmh8bgglXyCQnBEgyFIbO1gMqZ
 sPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882191; x=1690474191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnP8f96S0GKF3CO1A0jcmqKih6bOlzq38Er4YTCNWjo=;
 b=M1CSzTaxxpmIWevgqYekNzPVy8hd8gk92UQkaGSAH9WPw2nO/Tdjbfw4pWwlabYKPL
 duVoMiH505Wvsb2eaR8rCJVu8bbZ6fSJ79N7K7sW7PXNvBAdTCGncql4IK8j8+kfgx1W
 +VTqSPL7U0ZBM/4XrSv+Kxqka/6ar3nYBSFAMUQXLxUOAFkzlctbpUKD/n2S/ACwpUmS
 fY0kuAWNakHUQpJmE6Fw0NDWedKx/hy6An2OGZQc7jSx+IlPt8vd0GEbXllsf/GiuVf8
 L0Y+2WZYG9SnLE5/FyP0J+n0nKj8R13oAJwkb+DOD4oifjxfiSwByyg8cA0Scw/yBHBq
 HHIw==
X-Gm-Message-State: AC+VfDyModi9n/3q3U/GA5GNhAtyeyHyyjAEtMnHT/dYpFtlBWdzBxaL
 0hwCnodd6Mfon1FvO61pBNFKdw==
X-Google-Smtp-Source: ACHHUZ7dKRR+3nYYOmQvFV/xzSFJACtghDcKEN+LqlLuu1Ow0PP1/tZi4+9s+nMcVlxpGE44aLWeMA==
X-Received: by 2002:a5d:4fd2:0:b0:313:f0e3:2fdc with SMTP id
 h18-20020a5d4fd2000000b00313f0e32fdcmr5074710wrw.2.1687882189255; 
 Tue, 27 Jun 2023 09:09:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a5d4f8d000000b003063db8f45bsm10820461wru.23.2023.06.27.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A2E891FFC3;
 Tue, 27 Jun 2023 17:09:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 07/36] scripts/oss-fuzz: add a suppression for keymap
Date: Tue, 27 Jun 2023 17:09:14 +0100
Message-Id: <20230627160943.2956928-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

When updating to the latest fedora the santizer found more leaks
inside xkbmap:

  FAILED: pc-bios/keymaps/ar
  /builds/stsquad/qemu/build-oss-fuzz/qemu-keymap -f pc-bios/keymaps/ar -l ara
  =================================================================
  ==3604==ERROR: LeakSanitizer: detected memory leaks
  Direct leak of 1424 byte(s) in 1 object(s) allocated from:
      #0 0x56316418ebec in __interceptor_calloc (/builds/stsquad/qemu/build-oss-fuzz/qemu-keymap+0x127bec) (BuildId: a2ad9da3190962acaa010fa8f44a9269f9081e1c)
      #1 0x7f60d4dc067e  (/lib64/libxkbcommon.so.0+0x1c67e) (BuildId: b243a34e4e58e6a30b93771c256268b114d34b80)
      #2 0x7f60d4dc2137 in xkb_keymap_new_from_names (/lib64/libxkbcommon.so.0+0x1e137) (BuildId: b243a34e4e58e6a30b93771c256268b114d34b80)
      #3 0x5631641ca50f in main /builds/stsquad/qemu/build-oss-fuzz/../qemu-keymap.c:215:11

and many more. As we can't do anything about the library add a
suppression to keep the CI going with what its meant to be doing.

Message-Id: <20230623122100.1640995-9-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/oss-fuzz/lsan_suppressions.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/oss-fuzz/lsan_suppressions.txt b/scripts/oss-fuzz/lsan_suppressions.txt
index 02ec0a6ed5..7d90c280d0 100644
--- a/scripts/oss-fuzz/lsan_suppressions.txt
+++ b/scripts/oss-fuzz/lsan_suppressions.txt
@@ -1,2 +1,5 @@
 # The tcmalloc on Fedora37 confuses things
 leak:/lib64/libtcmalloc_minimal.so.4
+
+# libxkbcommon also leaks in qemu-keymap
+leak:/lib64/libxkbcommon.so.0
-- 
2.39.2


