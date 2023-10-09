Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C07BD68C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmLH-0004Qp-NF; Mon, 09 Oct 2023 05:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmL8-0004Jd-8k
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:14:17 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmKv-00088H-CB
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:14:13 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b9ad5760b9so730475166b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696842839; x=1697447639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yx1jc4fsXtyskYvqmOgQaEMaNKS/xmLOt8Z+Gi2lC+o=;
 b=GVHr8ynh2mWxiAGrFXaWxh4w/VtNhYm4Sk49VEVkiQy6HE6rSXTEH7viUgbfH8k/Lu
 aET9Z5XxdbJJhfrgRb7SThzkw66Xx43dhIMZ+NEMAZHkZREwDHd2e9OqaLtxA8tZ3gcg
 W3PF9Jq0PQL/qd15FHjw6pEsvczupgbrm4rcklpA80OjiRG3FS4A59pwM0AIyiCYHn7P
 sbq7o6qaTerbFd7xVp5UZPDueNDrKOXttEjDBluIHPPjdyUzydIcwrMM2SOHt5GdmIxL
 KiIqb9+Cv0ipfgPAibFr/h+rDSY4duNOZeAGrybF+XfVUyGI/jsC89I1142hfkSuNalG
 O8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696842839; x=1697447639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yx1jc4fsXtyskYvqmOgQaEMaNKS/xmLOt8Z+Gi2lC+o=;
 b=OpupA+jc1CCxf4Ju2aoBkOKFKGrZzFE63nigiR4T8ciUPlbScRiwFlrpSXme6dameB
 g8d8M3HziL6KHIwYUsb1wDLmucisCpa6nRHFKeFzUtJioRjIezGoBCxy0MIcl3hifwc6
 mm2KRTQP50eOnvSqDCPHtbGl9LfforjiBsV7FijgctxTaScZ95Q0QNBL/k/HhHCsOjnP
 Xsj9t3dcRTauMs1b5ydnl4Khk8D5AifqXur69Elv4JSps5rOwYhergxY+jIXByLvK9Tg
 v2RDRAGBz5kS0lCmpjfavG2GbjQji6a81xKuSfWDdkOv2E2VsuU+RTvQS6NIbh+UNW/T
 UJzA==
X-Gm-Message-State: AOJu0YxTOb0E4PwPr1kJdATcSisd5nGHVYO4os25nfKG3JSor29Z+Y2g
 iLE6kpfgH5DV6/+BLbAm3qw7b0IAMImmJmgrp8M=
X-Google-Smtp-Source: AGHT+IF6J1BIB/zh31MKn6x8IzPzo/rQzxy6DKAFQY5jtiOHkeeGo0C1P/FviVfdut/LOMfCuSBd4A==
X-Received: by 2002:a17:907:2ccf:b0:9b9:b12c:133e with SMTP id
 hg15-20020a1709072ccf00b009b9b12c133emr10568208ejc.76.1696842839358; 
 Mon, 09 Oct 2023 02:13:59 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 d15-20020a17090648cf00b0099cd1c0cb21sm6435381ejt.129.2023.10.09.02.13.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:13:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] buildsys: Only display Objective-C information when
 Objective-C is used
Date: Mon,  9 Oct 2023 11:13:56 +0200
Message-ID: <20231009091356.48713-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When configuring with '--disable-cocoa --disable-coreaudio'
on Darwin, we get:

 meson.build:4081:58: ERROR: Tried to access compiler for language "objc", not specified for host machine.
 meson.build:4097:47: ERROR: Tried to access unknown option 'objc_args'.

Instead of unconditionally display Objective-C informations
on Darwin, display them when Objective-C is discovered.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 3bb64b536c..da1a9a7228 100644
--- a/meson.build
+++ b/meson.build
@@ -4074,7 +4074,7 @@ if 'cpp' in all_languages
 else
   summary_info += {'C++ compiler':      false}
 endif
-if targetos == 'darwin'
+if 'objc' in all_languages
   summary_info += {'Objective-C compiler': ' '.join(meson.get_compiler('objc').cmd_array())}
 endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
@@ -4085,7 +4085,7 @@ summary_info += {'CFLAGS':            ' '.join(get_option('c_args') + option_cfl
 if 'cpp' in all_languages
   summary_info += {'CXXFLAGS':        ' '.join(get_option('cpp_args') + option_cflags)}
 endif
-if targetos == 'darwin'
+if 'objc' in all_languages
   summary_info += {'OBJCFLAGS':       ' '.join(get_option('objc_args') + option_cflags)}
 endif
 link_args = get_option('c_link_args')
-- 
2.41.0


