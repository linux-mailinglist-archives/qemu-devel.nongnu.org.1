Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3317C5071
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWgj-0008Aq-MA; Wed, 11 Oct 2023 06:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgi-00089h-7U
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWgf-0007ek-EB
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:43:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso62265705e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697021011; x=1697625811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3iJ/Q4kLUmKoxSHeooZspyIFZM2wlJ6x5Q8adgv7bVI=;
 b=KXDO/TWvUMIEJSSVShYe4JA54qR6qOapaJJOHUCaqUzLWXerUNVUPnX6kbC7Q6D9vx
 RTt1rgEY+vfOhYnjG7quRbs786dccVibEODdbvcB33fFCXuSDu3HKUB16bj3BUv7w7p+
 3/lIsJMcaNxZ/v1PTotyyMnRLEcAbzRM5G0L+iaAebpUOb+gDF8uHm5vdHOxQzIuZIQp
 H56F0J/9ASQ5gGUDHPLAANbkHpJZOIzhSplVG5M2Rf8Fpc4sxW4jcWXGVilnT3V9+xC9
 zff5XAUOvuWgmXGhwEvgMTNNS2amFFdXXrUBVn/w2oWcbZYSkCwTpFjqqDadi/IB5EFt
 zu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021011; x=1697625811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iJ/Q4kLUmKoxSHeooZspyIFZM2wlJ6x5Q8adgv7bVI=;
 b=qKUlrKQWxjMo5972E3D0+TlSb7NW+q1pRCJeJ0lX0tkK/IQwfORgKZOYIgx2xXTSnT
 C+yKpJ1pYU0CoYcnlHAbE6N0a3YUI8zhzZVbiB7KJhrZfB/DdaubVr6fmwaFVX4ocXQB
 fnK0cQmZqrBK7znexyq7a70eAsuWDrkOwsNY1CAI7a5abJ8o3DHPnCZczH3PEGLHLBo8
 LXMmmqlgFjRC9uAFoOsBmmrQV46iZBqyFCeYv2Rm2qOds83sAcScLhzTXJwdGAhkZ7pg
 HyL2NtjNseV4mxf69FvPUJl9VbysqW+vIjIoMWeYljWC1Z5x2cLFBk0pgn+qnLkjPh+2
 SpkA==
X-Gm-Message-State: AOJu0YxCPOtoMVWe281Z0tg5Y/PLLr+FDEm1LfW0XV+LDxAab3grybwR
 NJ9P+GwkgMAKHInOaUf6uFFfdw==
X-Google-Smtp-Source: AGHT+IFhwbue8IGkQOGAdpTOyEDyLuEbeCs937AdMwNMYNXI1fMZdKpiJBBm84iV3vkYUluHeTP7Pw==
X-Received: by 2002:a05:600c:231a:b0:3fe:f667:4e4c with SMTP id
 26-20020a05600c231a00b003fef6674e4cmr18428821wmo.12.1697021011102; 
 Wed, 11 Oct 2023 03:43:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a7bce85000000b0040596352951sm18871220wmj.5.2023.10.11.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:43:30 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D06BF1FFBF;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 25/25] contrib/plugins: fix coverity warning in hotblocks
Date: Wed, 11 Oct 2023 11:33:29 +0100
Message-Id: <20231011103329.670525-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Coverity complains that we have an unbalance use of mutex leading to
potential deadlocks.

Fixes: CID 1519048
Fixes: a208ba09bd ("tests/plugin: add a hotblocks plugin")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-26-alex.bennee@linaro.org>

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 6b74d25fea..4de1b13494 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -69,8 +69,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         }
 
         g_list_free(it);
-        g_mutex_unlock(&lock);
     }
+    g_mutex_unlock(&lock);
 
     qemu_plugin_outs(report->str);
 }
-- 
2.39.2


