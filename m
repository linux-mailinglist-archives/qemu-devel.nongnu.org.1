Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7FE7A21FD
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARQ-0003HR-EL; Fri, 15 Sep 2023 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARE-0003BG-Vg
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARA-00028l-Rr
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-402c46c49f4so24495645e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790531; x=1695395331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMQxsOgidH8JNyNS7YPwfWsbNLccXwZv2/CWQGcUMy8=;
 b=W644bBizRMluPyKZRu/chDhan7+dqmqoqkM+ZB1kh/NhYVTDeONnC/9kMekabPOuGu
 Bhhf5nYHtcOSC9bFm/65Jr6c0mU38Qo5BJ+DGY7Hb7P3ub/8WgGARfZzlwqeWgeG3XH9
 4dhRfnjRTgeB/DWoojkMa0kFkawhoopBJglbftMaLwwsYos/8NQihsqJvW07TjDWG6jF
 Mc6BGS+x3+ALsmEEF2V3a2jeTXoCrS0KxBZ9wkSI/tSXJw3DIPumkDll24SQt0ogP/Ms
 2hiUZFWqx7tkNsoElZ+4t//cmsi6p+sWi6PJtcyLuKf+Qv3OAgbCDxwjFJCWty4LBCUw
 2x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790531; x=1695395331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMQxsOgidH8JNyNS7YPwfWsbNLccXwZv2/CWQGcUMy8=;
 b=LkeOPD1R4M4BA7uZjPYrVJdRL0UBx8fQa2xAA4npaQo0h5WFhFQ1tvIopskkQQhib2
 YHB1AMrHKoYlbZLh1QxZu4RerQN5EXZ5l+rwUOTHASGy1ZqaNS9ZrOIm7L29+ycZL2j0
 NU8fKt4O9wsnfhRfaovPfT3XeXjQaqYC+GnyaaReJlEB3PiY046i9A7bCS/MFzXWJWgJ
 0b0yglZQP7Plwad75My87O8f1+YqncUcmbfr8mnsxOBHJVcCO0dxJ3AQeCV+CIsxTgR/
 NhRfIhj8qjmHEA6rNPOTEpAP9vRwAvF75NKpAAKlnHzu7F2JfRaQcLZYj4hV3ZdQj/8w
 ceSg==
X-Gm-Message-State: AOJu0YxYmLSAXSFiocSEYDS9aTMOwGV13m5GimMAMv02HjSuXbgbzO6k
 WJp/R4x8wbVo6LKUFGa3ufVCTg==
X-Google-Smtp-Source: AGHT+IGiM2IwRSXhiKlWQssP/kYJ0aUYhEy5A83UiLM1p01tpLsVeg2YC2Sh+pZ4200dO5JBa27p/A==
X-Received: by 2002:a05:600c:378f:b0:401:d258:ad26 with SMTP id
 o15-20020a05600c378f00b00401d258ad26mr1706401wmr.19.1694790530952; 
 Fri, 15 Sep 2023 08:08:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a7bc045000000b00402be2666bcsm7728075wmc.6.2023.09.15.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 48F3D1FFBE;
 Fri, 15 Sep 2023 16:08:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 3/9] tests/docker: Update docker-loongarch-cross toolchain
Date: Fri, 15 Sep 2023 16:08:43 +0100
Message-Id: <20230915150849.595896-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
References: <20230915150849.595896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Update from clfs 5.0 to clfs 8.1, which includes updates
to binutils 2.41, gcc 13.2, and glibc 2.38.

See https://github.com/loongson/build-tools

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829220228.928506-2-richard.henderson@linaro.org>
Message-Id: <20230914155422.426639-4-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 9d957547b5..b4bf265717 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -20,7 +20,7 @@ RUN apt-get update && \
         git \
         python3-minimal
 
-RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2022.05.29/loongarch64-clfs-5.0-cross-tools-gcc-glibc.tar.xz \
+RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
     | tar -xJC /opt
 
 ENV PATH $PATH:/opt/cross-tools/bin
-- 
2.39.2


