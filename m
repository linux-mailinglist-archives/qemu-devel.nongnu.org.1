Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A986823354
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:35:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL588-0003YD-PG; Wed, 03 Jan 2024 12:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL57w-0003T6-CH
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rL57p-0002No-PA
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:34:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so111700485e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303231; x=1704908031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aeln3++ASlFUfIwMVf5xyvW2uMLaZ4UxQn5nypBC6DU=;
 b=U4drxGlJ/tkZXc9hvZ3os6xuYTZJF5h49z3k8E2J+jUzucL7Sk9MvZv9AAPAyT7R+9
 tT2dswG0KJ2kD4qBWjbtVOmeatZY46+0ij9eWc3imoGgPWsArqLR54wxqnUEMAE4urvM
 tumWUWjG9SN3lQ6Sd3HzO3IYHQ12M1rWOE1r2/PNCuDww8365ae18SgVchmtYpVYd9n4
 c0jE5BIiJw9ScQJlRsZB6mIQeXjkyaWKD4maFnj6FrLlgqjP20+uBlL2krhA7awdHB5b
 cfusSNoaOqDJ+haTpVpXM90oG5KeIsSySZ8Qh85r4K6WQeuzd5lBNQVu9etTBKgZpc0N
 RVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303231; x=1704908031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aeln3++ASlFUfIwMVf5xyvW2uMLaZ4UxQn5nypBC6DU=;
 b=K344hPBa9iAcdIZP5RtNhJc3ISkz3dGIEtqkF8v+kODzqRWzaTGKzXjoEOa3BNNULp
 MyPd0/nCckGhBVgdzQ0JqrmQQbjOtqImiVa3PhGY3cex0GvidfCwpoLjDZa7JS9/alcc
 d2NHSojmrew8PG4Lgct5HSHWN72JffiGB8QRs6VDr02NDR4sSejoA/Xrd19I7UpwD8nv
 eXUptj1rP5EVx0+UrpRujFyG38hqfWZYBGQ+Xcc4xZZXBj+vyNOAXUh1jlVKtrdfSs+H
 nSIkMde1jgnpGskDCqpVz4Jei7f3xTEOgJ3O1J4TxJRLiQ2tPmcTpKpBiKuUPofg434E
 h0fg==
X-Gm-Message-State: AOJu0YwddX65vjK3Wg9rv8rr1CUnu7rBTAzUdYvhpRHnVPX+kfL+Vkr9
 gyRRhEXYKqpntxHOckfY5R7AxdwQKT7FRg==
X-Google-Smtp-Source: AGHT+IHtCR4hmp3Vukr9hzN46Gz71ep8bM3kzLyD4gCRhfkpq3Ia3b7dQ3Ru8mfmCaqnt5tCeWxVgQ==
X-Received: by 2002:a05:600c:68d7:b0:40d:5941:f16a with SMTP id
 jd23-20020a05600c68d700b0040d5941f16amr3530996wmb.273.1704303231484; 
 Wed, 03 Jan 2024 09:33:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 je2-20020a05600c1f8200b0040d934f48d3sm750166wmb.32.2024.01.03.09.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 09:33:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 93F3B5F932;
 Wed,  3 Jan 2024 17:33:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 03/43] gitlab: include microblazeel in testing
Date: Wed,  3 Jan 2024 17:33:09 +0000
Message-Id: <20240103173349.398526-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103173349.398526-1-alex.bennee@linaro.org>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

This reverts aeb5f8f248e (gitlab: build the correct microblaze target)
now we actually have a little-endian test in avocado thanks to this
years advent calendar.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91663946de4..ef71dfe8665 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -41,7 +41,7 @@ build-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs
-    TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
+    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
@@ -61,7 +61,7 @@ avocado-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     MAKE_CHECK_ARGS: check-avocado
-    AVOCADO_TAGS: arch:alpha arch:microblaze arch:mips64el
+    AVOCADO_TAGS: arch:alpha arch:microblazeel arch:mips64el
 
 build-system-debian:
   extends:
-- 
2.39.2


