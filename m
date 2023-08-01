Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2527F76BFAC
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKv-00048M-B9; Tue, 01 Aug 2023 17:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKp-00043A-EO
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKh-00051Y-Us
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe24b794e5so19789575e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926907; x=1691531707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVfBl55livYW0yWtqiDTvD5GbwIpzCrNuWoNY+Gm1TE=;
 b=H7NPrUp+ldHLolZzwK7aXYphSZ6Mxy8yEXqm4h3NzocqcMiNrsbhfnhdzfVBpeXcOj
 LCcHTsaO3E8lA1QNiea5j3d4DNSI24YwyqCMmMnIxftyTI9HJNYlROW7ewxSB43pleVK
 EJl3CukD2jem/Qsn+cVhkro1zJWSTvFXwKHrkmo4RGDwx/9QlhJNHb5Ft9MOpX8Q4zy/
 qwE/OrJiM0VSoMNRipqZkvC6xuAtUODAx8EA+IgUNbhOajoPgBbCqGv+X2TS2rFZJMs+
 GNz0jbEi/TcnpkP4bGGvak4JaTPZWCjLMDuiVxm+JiIxdrCLKsPV/EJD6Lv6lR41evgb
 y6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926907; x=1691531707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVfBl55livYW0yWtqiDTvD5GbwIpzCrNuWoNY+Gm1TE=;
 b=NmTsEePpoGc9FLcwCIJbUTOeoS+j9gxIAdkgjSS6pVPbCkclZ7TzPEZ97Yjslj0ViJ
 +HjJpSNG91m731M1Lo+7tBbGfo1YZJTDnB8rweJCaWbsRcl3BnQZXxeLEKZIGpXl7XhN
 jYUFd78qLJawdIcPAbX4utBLs9NU4r3kR00zrk+4cFRaIMfog/USCc3MztjWPGRIqBzd
 g6dKwVytuiqDGJIs4etKHN7XjpmbtPBNxqBvCh8X23icKQjALPYVvprnmcE5JN9k59I7
 9loU5jvro3IrJMKoXJUMemxZuMnEKekQetHcfy/8ebr2UwZbNMH+u2omXsjL6TWBcV59
 qFCA==
X-Gm-Message-State: ABy/qLbaGEnyZdjpiqKw/+i3VHn8za5VTH9Klpcq//sfMxAaMLEq2mxM
 TbJJyANkap1+VdknatNs8uJHYphN8hihuEo2RwQ=
X-Google-Smtp-Source: APBJJlFo0eo4a24dS5Z1ME1x8hQV1kKZ/FB/f/h/3Uo62+JYduIfXs5bsd0P5OgMytxjzgLkyXyCVQ==
X-Received: by 2002:a05:6000:1084:b0:317:39e3:7c68 with SMTP id
 y4-20020a056000108400b0031739e37c68mr2874160wrw.18.1690926907801; 
 Tue, 01 Aug 2023 14:55:07 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 y1-20020adfd081000000b003179d5aee63sm9039908wrh.91.2023.08.01.14.55.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:55:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/10] tests/migration: Add -fno-stack-protector
Date: Tue,  1 Aug 2023 23:54:18 +0200
Message-Id: <20230801215421.60133-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A build of GCC 13.2 will have stack protector enabled by default if it
was configured with --enable-default-ssp option. For such a compiler,
it is necessary to explicitly disable stack protector when linking
without standard libraries.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230731091042.139159-2-akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/migration/s390x/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/migration/s390x/Makefile b/tests/migration/s390x/Makefile
index 6393c3e5b9..6671de2efc 100644
--- a/tests/migration/s390x/Makefile
+++ b/tests/migration/s390x/Makefile
@@ -6,8 +6,8 @@ all: a-b-bios.h
 fwdir=../../../pc-bios/s390-ccw
 
 CFLAGS+=-ffreestanding -fno-delete-null-pointer-checks -fPIE -Os \
-	-msoft-float -march=z900 -fno-asynchronous-unwind-tables -Wl,-pie \
-	-Wl,--build-id=none -nostdlib
+	-msoft-float -march=z900 -fno-asynchronous-unwind-tables \
+	-fno-stack-protector -Wl,-pie -Wl,--build-id=none -nostdlib
 
 a-b-bios.h: s390x.elf
 	echo "$$__note" > header.tmp
-- 
2.38.1


