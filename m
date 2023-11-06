Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 607377E2C5C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:52:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04hB-0006C9-TP; Mon, 06 Nov 2023 13:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h6-00066E-Fx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gs-0000wo-Uh
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40839807e82so29787895e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296673; x=1699901473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33/OTwiED227CSIHrsxnwyK8KaSwVMt/PQqEs48aCOg=;
 b=UHw44YCoEBwWNni1lDQLOvmKyUxei6hATa0hKFJigWrFt8v77u/WJX0Le8G5EYjdFC
 vtmJgNiDQO7VUyJ4WUujuikWEKYetzLcZHpz41MOk2bm/0ape5aYK6QAp1/gre5Y27Lf
 2rwHZx8gDWGp1IoO5LUz42e/rkdGeqiwXrxLZE34Pignc/wPPyyWRfrMFZm8r8RTp0ix
 Sao2AiFxiYxAK9y0dzwCqYG2SAPPPMC4WmOU/0o99w2nER0b32O87B0xJ6wGPgoHlonj
 wJggbP7iDaZ652Lcrj3I/MdyDBIAL2JwsL0AfllToFHcpt3CrkZcS3j1M9huUgmOBveH
 9A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296673; x=1699901473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33/OTwiED227CSIHrsxnwyK8KaSwVMt/PQqEs48aCOg=;
 b=NHNj5oPle/7cfAKmC/TmuRsoaH+q8E0m2RrIHNrtJTZXZvJBHrRwrvZsLVTqrUg6S1
 I9UhmunVG+Cytaq1nnuFyB2RJOplGOtCRO1Ytv6jjYqBUPYq3Y/vKWn2lcNcjTDj3fGw
 y8dgCfc7NnPukiG5ipzmJY2fZNjKokkb8LTtBU9i4/i7LNUE37ehqXCScEkncOQd8U2P
 /7fjGfZI/ZlhGWNGvaAZ9q7iDcoa/c6KeSiq1LSN+wR6Fc/CgAj6/TcWSUbaAwMhCI/3
 wLjeWKixHDI3kFMlD891DMRGFf6PSyRhDexsP0VmJbzEi0q3LMLEKwxuHQ2bSEK6MqVM
 oYSA==
X-Gm-Message-State: AOJu0YzDWaZnOjjatW9kmUnEm+EvVF2AhggWQ0EtXZodNTDvieGfa3pv
 V36VasOn7Plb3OZ7NJ1ja3D1cw==
X-Google-Smtp-Source: AGHT+IHWUvGepd79PZ17MnpM5nZR05WBB/7t1rKycp+p12y9cUy6bFsmalFq4xRWD8xIFEHFERK9QA==
X-Received: by 2002:a05:600c:3b12:b0:406:45c1:4dd with SMTP id
 m18-20020a05600c3b1200b0040645c104ddmr441140wms.14.1699296673461; 
 Mon, 06 Nov 2023 10:51:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c348100b003fe1fe56202sm13473371wmq.33.2023.11.06.10.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9458E655DF;
 Mon,  6 Nov 2023 18:51:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 01/22] default-configs: Add TARGET_XML_FILES definition
Date: Mon,  6 Nov 2023 18:50:51 +0000
Message-Id: <20231106185112.2755262-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

loongarch64-linux-user has references to XML files so include them.

Fixes: d32688ecdb ("default-configs: Add loongarch linux-user support")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231030054834.39145-6-akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231103195956.1998255-2-alex.bennee@linaro.org>
[AJB: remove base32 from list]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configs/targets/loongarch64-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index 7d1b964020..d878e5a113 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -1,3 +1,4 @@
 # Default configuration for loongarch64-linux-user
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
+TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
-- 
2.39.2


