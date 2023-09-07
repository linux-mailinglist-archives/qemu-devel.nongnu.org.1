Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B92797191
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCaw-0000CY-7w; Thu, 07 Sep 2023 06:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCau-0000C4-73
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCar-0004qy-W5
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso8728725e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694083836; x=1694688636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hS+d+xDE7ab+3Ts35wM0NjR7BehB229Silm4f3RZJWI=;
 b=RuhRR2N4QqewP1vXRiBZNU8IbwFky/VbKvHTgm/Zrl4XiiofvfIC5Q3N1zPZkIQcs0
 U28zoYIAK9CLL5yUU8SxCGCQduR1Bu0hdWwQt8xjjUQ2SWdSI5pafBOIZ7zOE3wMujyC
 wdYfM7dh1vbNrgDEMzJH89DERYPDXSabvDaTIHVXJelh8LeUNgdSgKQ//tnKvJ1Qd4pQ
 q7B6+s+ZS42Hz/+t8rh2SVGvJYZQKuQ7oWOH77/84Eg+CK/eMxV1bXr4olJRiYsyK6wj
 RgYfgQXJUc5exWb3+Xgq/9R4x+rJZVRZjnhiJNUDxi4ntHsDIBFafCixSpDjFKGp+KZe
 WQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694083836; x=1694688636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hS+d+xDE7ab+3Ts35wM0NjR7BehB229Silm4f3RZJWI=;
 b=Siv8T92KWqfUrvzDGK8pNPd/NrokurTuvpFykh3O915m93VWzUSyLGvVTvfX1v46D4
 nO4G1E+SeTjDU/1Pwh0zmbRW+Qt5iadv2lyiyZWTOdvvhVLO7MdpWTGPBd5rYyq0FMcu
 vE/CAn9ehRGclsVD0nN16JoPyzXymhZbRfu+9Lts6ITAWu+5ro709oHvHjslVPi2z+TP
 W5M4FL1Mbt0vnAP13oPqou7DcvG++ByBs7JGy9BdRPJMvrNVkwkLMPBSw0nMoW9hzyrX
 GvE1UnxBq2qg5pglu4d61d/LsVhLNFEQkEgP5411ops0b0dYV+67uqwfB8pEa8Xu8hyL
 S8Nw==
X-Gm-Message-State: AOJu0YwbPqw/XEVGXqkyEf2zOmWuC7whu8yw3uAE7zRhQuZmDOZmIV9q
 QnjKPd01ea57Kv3b9s5AVOD0bytfSj2Z++UHlnI=
X-Google-Smtp-Source: AGHT+IEZ8XfPbZoR5wOjT3B5i+LPHIErZQHpfSpRz0BDJVBaltiqDfbpY+v2kHFF+2jReQU6oytrEQ==
X-Received: by 2002:a05:600c:2611:b0:401:dc7c:2490 with SMTP id
 h17-20020a05600c261100b00401dc7c2490mr4140589wma.0.1694083835912; 
 Thu, 07 Sep 2023 03:50:35 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-226.abo.bbox.fr. [176.131.222.226])
 by smtp.gmail.com with ESMTPSA id
 m12-20020adff38c000000b0031ad5fb5a0fsm23018749wro.58.2023.09.07.03.50.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Sep 2023 03:50:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] contrib/plugins: Link with GLib
Date: Thu,  7 Sep 2023 12:50:04 +0200
Message-ID: <20230907105004.88600-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907105004.88600-1-philmd@linaro.org>
References: <20230907105004.88600-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

This fixes on Darwin:

  ld: symbol(s) not found for architecture arm64
    "_g_string_append_printf", referenced from:
        _log_stats in cache.o
        _log_top_insns in cache.o
        _append_stats_line in cache.o
  ld: symbol(s) not found for architecture arm64
    "_g_string_free", referenced from:
        _g_autoptr_cleanup_gstring_free in cache.o
    "_g_string_insert_len", referenced from:
        _log_stats in cache.o
        _append_stats_line in cache.o
  ld: symbol(s) not found for architecture arm64
    "_g_string_new", referenced from:
        _log_stats in cache.o
        _log_top_insns in cache.o
    "_g_strsplit", referenced from:
        _qemu_plugin_install in cache.o
    ...

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Note LIBS was unused.
---
 contrib/plugins/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index b2b9db9f51..e9173972eb 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -26,6 +26,7 @@ SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
 # The main QEMU uses Glib extensively so it's perfectly fine to use it
 # in plugins (which many example do).
+LDLIBS += $(shell $(PKG_CONFIG) --libs glib-2.0)
 CFLAGS := $(shell $(PKG_CONFIG) --cflags glib-2.0)
 CFLAGS += -fPIC -Wall
 CFLAGS += $(if $(CONFIG_DEBUG_TCG), -ggdb -O0)
-- 
2.41.0


