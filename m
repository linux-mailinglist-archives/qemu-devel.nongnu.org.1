Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE57E41CA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:26:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N00-0004Dm-Q8; Tue, 07 Nov 2023 09:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzr-0004Bv-Db
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:03 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzl-0007Xm-W1
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso49307815e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367036; x=1699971836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDHFJerErM6xeZ3usM1xoRVcULOAJ0pzTqiA9XHIBaQ=;
 b=HZFRFXp0wF86z52t+Dys8iV09jCCLHp26buOGkEcGsqcHXe9/GMyRZL8VI2gzzC+c3
 +Z009xaUWQo2zo+3wFutIEY5NZb47CvJYXryiKMgVzsbzlH/nrRBWYy7t5GqQnrTXZFu
 pWDCzafzJPhESClPwXEcFmBxln9sOwTnQ+93kNkumyxjyKa84l5Zlhnk2uI6MqsstI1B
 EvLbiDKpE/El1FHPGupHMMmybcNJtu+0Mcx15bkmBnJ/YzdJP16KsD3v/enqvquVmzwr
 alGJ6rzlqosB6fYd8l9Dy6uyUtEtIv7jDQizJ9rdNtfLruUHPyDozZbiUdWWoelRNLvK
 OQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367036; x=1699971836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDHFJerErM6xeZ3usM1xoRVcULOAJ0pzTqiA9XHIBaQ=;
 b=ETjwR06RzWWs+q4fOupn1KKWATmbr7O7nfzc71gZD+hvoKEBXtyP9wvDhgsYtKmc4P
 eZV6PllFQUEZwxSa99yJl1Nlcw27KjhaTUPtdahKP1Pmslsj7vmUZGCF9BmNceRVkd9H
 BRV4Hh0LbUjoGskGECLs37TKrAyrj3t6lpg6csUQXNNn3OWRpwb+1MOywsvxix+RnsR+
 0t5439S0DDWBHzx9t3egKpAahQkx1cEGQizQIYYdCgsLSY48DONmR28GHXarLQ3rt7Zp
 GVGVcqUpv3h312MQsMw3suC4W06YAQKKyK1vyOd2ZZ8njcBs2F72iWylTgJg9eiXKQnY
 7dlw==
X-Gm-Message-State: AOJu0YxhMBFvYVAtnzoDZ+ejyBLp/rf7hn3m7M9BcVCForpkoIt78g4X
 8K8ICQtGfcArmXVv2JQw177p8/7bNe7MrkohQ1aXQg==
X-Google-Smtp-Source: AGHT+IEWSkYYzVtB6ObTIcoALU5XKaTGtZH1iIk9LzRizmL5ccvoNh2TVvdNk9WwkrB09TrizCPlHQ==
X-Received: by 2002:a05:600c:1ca1:b0:405:1bbd:aa9c with SMTP id
 k33-20020a05600c1ca100b004051bbdaa9cmr2113233wms.34.1699367035718; 
 Tue, 07 Nov 2023 06:23:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o25-20020a1c7519000000b003fe1c332810sm15497725wmc.33.2023.11.07.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B563B6572D;
 Tue,  7 Nov 2023 14:23:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 01/23] default-configs: Add TARGET_XML_FILES definition
Date: Tue,  7 Nov 2023 14:23:32 +0000
Message-Id: <20231107142354.3151266-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

loongarch64-linux-user has references to XML files so include them.

Fixes: d32688ecdb ("default-configs: Add loongarch linux-user support")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231030054834.39145-6-akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[AJB: remove base32 from list]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-2-alex.bennee@linaro.org>

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


