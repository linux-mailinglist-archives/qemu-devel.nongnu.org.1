Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3B37BD73B
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmib-00067B-3C; Mon, 09 Oct 2023 05:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmiR-000667-1Q
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:38:19 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmiO-00043M-E9
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:38:18 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b9a494cc59so729283866b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696844294; x=1697449094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tnUqaRizBEh6TzdG7Z41NpBrnY2ZidNh4EJJ54nnPF4=;
 b=IQuTYzFe3HH4hIbUakDLbgVXJOcIFy1W2k+kEsg/ZG0Qj/Bmu2yCo3CDQ+GSoW2O4R
 CH8QEMiH7PbqZ7hxpnO2An0BT/c5Wketfie5+ppg2FXGJfHlj5nn3JTAWmnr/y9C/fLh
 mg29oWoxrwR3SUK/6nGBq0F7vp1zjssfLUTeA12BPedL7IYnWIWzYIrNtYELThpXXvit
 FyWQSUy/SoHjLAfZP19MlYpt4I0HEct7ysU7lqQu8i4CD+Qpq8+s96YFFFH4W/C5rb5p
 NbG2x4EffTlpMT+PoPIdUdfKKKuCLtRa/BOWrHK3BZ9gmlxcO0yDEdL536QAiw67NF1s
 Xlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844294; x=1697449094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tnUqaRizBEh6TzdG7Z41NpBrnY2ZidNh4EJJ54nnPF4=;
 b=NcQLDTgK+vNafzhTnpmfA34KPm1/AU3Tnhdyy4oesa8F00DhpAvIRE9jMle+upTaKr
 6DhuPfW+dc+PHL+DmNe+UP3GfyAM9SE4tTxnhzce6f/Eawju+OJIg7l5AyKWgoMMBDFQ
 9gKVLLFjAT8q0ASpCfJwfh5rIJbNnvM4NnthV2C4QHiwPBWdgRVLjYH4jt3BEC5WHIoI
 Kmyh/btelGVCm91Et8R++HtHrrLsuKxEQr87HXAYX+UQSaWsz/I7W5khJXhi54Bh4GNe
 trCcCArU4AEdPOK90A9ifI8SUoSWrdJ63aHB1+Uwm6XggHZpJNUaRjwnYyMWEnFjihpZ
 vAaQ==
X-Gm-Message-State: AOJu0YwGdrlcHufU3ts+nLVa53xxWQW5HDpVfe/mUkBYXlknjckl3P64
 tyrqR6vUMXPdpSLrgd8x4tudTViAd1fBFbfjBzs=
X-Google-Smtp-Source: AGHT+IE2dex5NvMXUaseTfudHAkvgq9o14p9SCEo79dP3n1D1EBGQ+QkSzusvubAbFcayXKWhwOwYg==
X-Received: by 2002:a17:906:1daa:b0:9b8:b683:5854 with SMTP id
 u10-20020a1709061daa00b009b8b6835854mr12633596ejh.61.1696844294618; 
 Mon, 09 Oct 2023 02:38:14 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 u13-20020a1709060b0d00b009ad87d1be17sm6525247ejg.22.2023.10.09.02.38.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:38:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2] buildsys: Only display Objective-C information when
 Objective-C is used
Date: Mon,  9 Oct 2023 11:38:12 +0200
Message-ID: <20231009093812.52915-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

When configuring with '--disable-cocoa --disable-coreaudio'
on Darwin, we get:

 meson.build:4081:58: ERROR: Tried to access compiler for language "objc", not specified for host machine.
 meson.build:4097:47: ERROR: Tried to access unknown option 'objc_args'.

Instead of unconditionally display Objective-C informations
on Darwin, display them when Objective-C is discovered.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Emit 'false' (Akihiko)
---
 meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 3bb64b536c..567c1c9add 100644
--- a/meson.build
+++ b/meson.build
@@ -4074,8 +4074,10 @@ if 'cpp' in all_languages
 else
   summary_info += {'C++ compiler':      false}
 endif
-if targetos == 'darwin'
+if 'objc' in all_languages
   summary_info += {'Objective-C compiler': ' '.join(meson.get_compiler('objc').cmd_array())}
+else
+  summary_info += {'Objective-C compiler': false}
 endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
@@ -4085,7 +4087,7 @@ summary_info += {'CFLAGS':            ' '.join(get_option('c_args') + option_cfl
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


