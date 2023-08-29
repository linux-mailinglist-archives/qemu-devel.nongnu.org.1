Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96778D028
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:16:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mu-0000im-Kv; Tue, 29 Aug 2023 19:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nD-0002N3-AZ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:35 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nA-00047p-Rd
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68bed286169so4216879b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346551; x=1693951351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z20DSFbmc8dhdliPZzapqE4smuEONTK8kCxcYuZWd00=;
 b=p7hIiG3RnVruTX5Kht1/OUBzJ3kLWpUfH64ZNLc9glN8yAr1tBmczbqcfrZi81rAqK
 mGljDMpGFVLi+JF4o7yIlZkVtjCYtjrFIL8/BKgbowN3a+F5oOBvZ43VI2bSLQCD4tlJ
 ngM/muLP3dsQV3hsN2ZQ6r5Pgg1dpi8XHFPuv1aMXctK/TNHVgfmCr0ehb+Xce751s9b
 N2q5Vdfk2+3jnMeiIzMYWp7QtMh09am1QEE6pA09f+S1YvEtR0of1PORON8Rz8mRmN8p
 7P955U6JijHk/+Ir4xSGGiwZ908tMGAZjeUfmyWeC3PwaBJaiWUXaluRwzK474/QYrNA
 EjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346551; x=1693951351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z20DSFbmc8dhdliPZzapqE4smuEONTK8kCxcYuZWd00=;
 b=Pl75UeaQO9SAbXCcGckylcjQvyNnb9h4YsK/MI8P2BLZPcpgM+3pKHSEw++aPZoIjV
 186nH4uvFhoWB4yapSLCRkX0BAUVQZ+SXGuWeBWBufCAfRPrtV20eYjWMI3tSZZ/UO8s
 3SMJHW1lHYZ24JJbA8F53M9CusoD5ctE1LyVM+bf9rTXTTso2RzETv1gHcOdTU9kpr/n
 QdMEu3QWJpNIpGrkfeGwI4oails8J6NB0NdPgj1vudVbcQhPlS6a6AlCOwxIKtAd5ig/
 U3WTaRgAbzLYA7qx10J+72kBjlrDRY2hLM0sJRwoxdmz85+39E3B52N4yNzfmm+pxzE0
 39Nw==
X-Gm-Message-State: AOJu0YznazKaeBr4xQDwr5iK7YKsqNp87r9DaB9c4x9PcQwbh9DwvRIm
 C/wK754Ysao+zRxKhb4fcfpGID8FBJU2RJrMugg=
X-Google-Smtp-Source: AGHT+IFYQNo2Fd+skH7UZtJg31nLhPQ8PJ/WCQmGJKy5XegXdZcdA7nZSxGEe+uCW4FePivYPUe0kg==
X-Received: by 2002:a05:6a00:21c7:b0:68a:5cf8:dac5 with SMTP id
 t7-20020a056a0021c700b0068a5cf8dac5mr516153pfj.22.1693346551065; 
 Tue, 29 Aug 2023 15:02:31 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 01/20] tests/docker: Update docker-loongarch-cross toolchain
Date: Tue, 29 Aug 2023 15:02:09 -0700
Message-Id: <20230829220228.928506-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Update from clfs 5.0 to clfs 8.1, which includes updates
to binutils 2.41, gcc 13.2, and glibc 2.38.

See https://github.com/loongson/build-tools

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.34.1


