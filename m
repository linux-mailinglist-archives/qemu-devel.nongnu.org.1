Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C69CE82BEF2
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:09:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFM0-0006Fp-J3; Fri, 12 Jan 2024 06:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLE-0005fY-GC
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:48 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLC-0008Vo-KP
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:47 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33694bf8835so4842729f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057485; x=1705662285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1ozQPEBd1dKPWzoEBMApjvUdBiZRtdGzBUR3OVCvdU=;
 b=YvvRUU9uHeF2xKCs3LcnaYYDhvaXq5Vsr1Bihdd5tugHURZHyylho6ihD30eOfpzgL
 oruCNHRXqGbAcbbK/6xsK5VLw1HzdIe2/DUjLHzfp3iUgoSj9SY8AXIFPDTOGQUILkic
 x2NDc1GqiLexPTczkYXQ/zfhBfdS/BKTBYXlIAi/WL6A3rqbJM6zvfMyroABOdVJ1qx1
 tLFRkSHxulpHayo9/sP1wzsUpJ+F0W6Bxm1NxRZ2/9ScaLIRkmQLp3K1FsP9V/bfCRSX
 yJvuY5FSonzpL5/3X4oFPR5sYjO601JxM0ZZW4k7F4U6ndPwqbINplD6jdPsgjjeE3+h
 84sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057485; x=1705662285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1ozQPEBd1dKPWzoEBMApjvUdBiZRtdGzBUR3OVCvdU=;
 b=sBUJdXynsKuSt16TpxEWGY/z1fNnhthI04Ves2IdGe8IhFUyzyHg7qSlou1CiZuSX+
 JTe9GiKFKCzVGpm5tJYj/Ejch2fUiFlvZhOiuLPXIXNOEV/TC95n7xwI+ms1uK7J7W1T
 Jawp8t2mJo39Gg/26CpYOgWI1gDNNxCoFNWLmcb4HNcxk8oOXYzPFMlJeYLbFg+HDdHy
 g5D7/nu9Wq/m4xcWIfdOafnNzW7QTch4oeHVq80VwyGp/IClgn+XkQ0YhaCmTj357ZuT
 soi5vykV1cIYEFWdqsmwicwZ9u+y4KGtYi+wC52MrThUGgpubqGgwLYb3l4KwNyg3p63
 zORA==
X-Gm-Message-State: AOJu0Yx4ixrLynU2xTLQXq4KkufkqSsiIOp98SwnRRib+d4ETIURsVlM
 KDwDWwvBO6yWiKYpJpb5OIbrwnINnFIkp57x8VE3OYITfnc=
X-Google-Smtp-Source: AGHT+IH1geP+ILK1Kc2X16uBqlodTriIDqYfZeq41Q8SSxBGGbYQlXeePH+lPL7xLgyuE9kNekj5Og==
X-Received: by 2002:a05:600c:21d5:b0:40e:5aeb:1beb with SMTP id
 x21-20020a05600c21d500b0040e5aeb1bebmr648473wmj.179.1705057485108; 
 Fri, 12 Jan 2024 03:04:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p19-20020adf9d93000000b003378ea9a7desm2717199wre.33.2024.01.12.03.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 248235F760;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/22] qtest: bump boot-serial-test timeout to 3 minutes
Date: Fri, 12 Jan 2024 11:04:25 +0000
Message-Id: <20240112110435.3801068-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The boot-serial-test takes about 1 + 1/2 minutes in a --enable-debug
build. Bumping to 3 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230717182859.707658-9-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-9-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b3b2e3857bd..6d89bac722b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -6,6 +6,7 @@ slow_qtests = {
   'test-hmp' : 240,
   'pxe-test': 600,
   'prom-env-test': 360,
+  'boot-serial-test': 180,
 }
 
 qtests_generic = [
-- 
2.39.2


