Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81B7DB2F5
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:50:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxL9O-0002hT-Ja; Mon, 30 Oct 2023 01:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxL9F-0002eV-6m
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:49:14 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxL9D-0006z7-4v
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:49:12 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6c0b8f42409so2893144a34.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698644950; x=1699249750;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/NWG403wJIbU9ivTT7Mi0lMuYA38XHvHBvWDVRsrhE=;
 b=fPsH7iaecIU6faG1QIsPeSWVT+N68BtxI3HEllIqZUR7cS2IWLgyT1FidIgRYM9XJt
 8ai+H+kWIHWzPbFBk7ntndJ5v7OpD54uJUQhQ8S1KFd6dyV4kj+3KdqAwmBgvkWxJUOA
 mqhhbYRSnZGIPgkQjK3qagUSBbxXX1ObZZgx+zwbhcmATsGO9WA0J3zlPqCgG7knt2aX
 xucZJZUYyiVwlsN6cb1/7vFNdPG3q6b8YqYwkpFjY1aFOfctRWY8BpJxMRfYzojUF6KE
 ZsriNIE1UJaJiGO/9lAW87DVH5cjI6hMLXl2Q57c7yDTFYe7zEroxYp7eSjC2cjK1Jtx
 3Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698644950; x=1699249750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/NWG403wJIbU9ivTT7Mi0lMuYA38XHvHBvWDVRsrhE=;
 b=R/viH2Z1DxVXiT5bAqJcKW0D4QwNUGWX10T9NHutaurfpH7ihs6uJJeNlIG4Dqyvih
 K4iidj+ww9ThMlCUcQUg/4j9Khbt5HcJe8WFww6eIRScQttbJDpDvLT9wMj91OsLqkU/
 uO1hcXOBTvZozmo3m56smXhkapktip141gTBwYcKSLYLuCEBfG+pFmO7zVdNIQR5eNn7
 dWFtiIxYKwo2yHlFIK6yDPIlck8w2V563YL/K+cDRNj5NNEiVyx3v6eWtC5zSTjldNt7
 s5ctMNGcidt+jxq5rtue2tlhWWLH+kQvloQy8zHc0G2pAzFCvo5GQP11rlHdr08zoQ2u
 jIjw==
X-Gm-Message-State: AOJu0YxegL1oJM5T3CfUIA/J0jNvFNuLj0/A27isRhvadUn4SasFw/QS
 RUFJZH0qJT268GQBuK4qD9Y5Ig==
X-Google-Smtp-Source: AGHT+IG0ZDO20nUxrhQVm28/8m3uYMn1Ryibp0Um91unWKx/vdyHAcklq8vK5Mk7bbs453Hcpyg3Uw==
X-Received: by 2002:a9d:7499:0:b0:6cd:942:25c5 with SMTP id
 t25-20020a9d7499000000b006cd094225c5mr10613783otk.22.1698644950123; 
 Sun, 29 Oct 2023 22:49:10 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 it8-20020a056a00458800b00672ea40b8a9sm5282473pfb.170.2023.10.29.22.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:49:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v6 5/5] default-configs: Add TARGET_XML_FILES definition
Date: Mon, 30 Oct 2023 14:46:39 +0900
Message-ID: <20231030054834.39145-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030054834.39145-1-akihiko.odaki@daynix.com>
References: <20231030054834.39145-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

loongarch64-linux-user has references to XML files so include them.

Fixes: d32688ecdb ("default-configs: Add loongarch linux-user support")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 configs/targets/loongarch64-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index 7d1b964020..43b8a2160f 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -1,3 +1,4 @@
 # Default configuration for loongarch64-linux-user
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
+TARGET_XML_FILES=gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
-- 
2.42.0


