Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F6A73EE3F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFI-0002de-Tz; Mon, 26 Jun 2023 17:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFF-0002b8-DR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFB-0004sY-95
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fb10fd9ad3so11223735e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816772; x=1690408772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnP8f96S0GKF3CO1A0jcmqKih6bOlzq38Er4YTCNWjo=;
 b=YVlOodutlBDwNkn+K8PQ3of4v1XKSAxgWQHSonMQUz3IVM9G5YINa1G71SPkul3aa9
 R8EP5dOcYhWMOAXIxdFFxa15XCo/XGRtAPqEO9rok8IydlTG8L2uWcoLpg+BIGdO9AvC
 8oaj0GV9bFHRp6MG+wXmKENzjfYAEzBXrgcLcX4t7DOh+72r1MsHIQcC/NL9B9g9CKd9
 8hJp7psSa1PXUOSCrIKzGb8hlMt6gicTdcceCkEPegDhjKFscUViCZY+AmlHrHpU7hCg
 hzcyMdR9OYy/uqjZAJxqvmyIPyb57c7oVbKjD8gP0aNMDgN/Vt4s6/SypnpGisf/3KNL
 Gr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816772; x=1690408772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnP8f96S0GKF3CO1A0jcmqKih6bOlzq38Er4YTCNWjo=;
 b=Uh9z8rtxrZA2DDuIpmVMhck9IFCHqc7XFr+Rogo7AtvIUV5iy8xmzKj0xuHEXU0wz9
 uITvAVJ+E4c0S9yXq0/VWLO9PCqYagECmXsWZirnOXzY6eRiKOit+P4WcWMm9yZsleDK
 A0NFkt7KvGuwB1awm79r3CH1qArLVru/299YzTGbOiI2OomrKWWtHTnkBhC9J/OyLt4H
 m1SOlZ2bLpXL93BmlyYzN/JuqL42l+xvX0nXI9yOjlzP9dsW/ebLzOy32CzJ4nCToGJ2
 5EK04gIEeLL0smlX7tddMuza2UZu3R4H7x7P7fE+fsftqyat/YzoZe4AFlfLiI5G7qzB
 jKSA==
X-Gm-Message-State: AC+VfDzh2czbAxPT/jaWl+LupzygLhYkGrvpy2K7Z/peou7LDD25poo2
 fuqqH90BY3Eo+TEiDp28U2yYKA==
X-Google-Smtp-Source: ACHHUZ6bBXsnXQi9BzYI73Vlanme1LzwJzymgqmCpOdhNNCHZHjq3u0xC7OnmQW7le+a5q3TimVk9Q==
X-Received: by 2002:a7b:cd1a:0:b0:3fb:7184:53eb with SMTP id
 f26-20020a7bcd1a000000b003fb718453ebmr646459wmj.18.1687816771886; 
 Mon, 26 Jun 2023 14:59:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a5d5611000000b0030c6751a49dsm8364016wrv.115.2023.06.26.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9E39D1FFC2;
 Mon, 26 Jun 2023 22:59:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 07/26] scripts/oss-fuzz: add a suppression for keymap
Date: Mon, 26 Jun 2023 22:59:07 +0100
Message-Id: <20230626215926.2522656-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


