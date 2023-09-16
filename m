Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476297A32B5
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:44:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3k-00066N-Ut; Sat, 16 Sep 2023 17:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd35-0005DZ-Vn
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:56 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd34-0000V6-1g
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:55 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-564b6276941so2688922a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900512; x=1695505312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DUsW3Z1l6kI6dnJslOCZY121JffUsDAYF90PScLnzY=;
 b=uhsPD95JHTksHy0DLfDZ/XyRJmkBqnSvQ+EUYdiPCcHbdELfOz0XqGvNgwAxdzLnID
 kgz3SqymcHLmfw62V0liHTNlwkjUV5+GMc78ftPsvP3xO2IMcA5yPecTybKO1NPRn+SK
 uU33mi7tj1UaIZMRtkvhx3IHViakCkXpMS5IUQVpmH/hDODE2Gvl3uuYlj81AMH7KE36
 DBoy3Bbjp4ODG1C6Dx4RCj6qbT66i7oMThjuDbiQyEGN/kXA+WV5PhTRVTvWGurgII0y
 +GscDfz8gpKqitC2dCtq8g/9h3kC7tY/FzH9FXuJFutZsKfZu6sam4rid+oxgFRr9808
 f1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900512; x=1695505312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DUsW3Z1l6kI6dnJslOCZY121JffUsDAYF90PScLnzY=;
 b=UQzJB8njWUoG9G0yQ3z83sF7mKSoc3SoA8zj0B7qNQXzTN9gh+vfPIYqpDPRypT5jA
 EK8jMXpBeH+KuU+9RHQHdcjNCPBheJ4rg89BYGQUykNtxDrR2m4E9Ezr6dwC5TdBsub8
 IzkvYXdpIH3eqAZdr/Tf8hJLL0XbL55ekY1Y/G7p+vKXTjRYcv2LoLTh+lq9RtVjBGIV
 t6TU4PofanIaUPJkili1cZBGP5uqTF7iN7VauJuiOPbokk6DNkW00g7Q+v20TbS4lHnc
 Mn1qH85pWNuSMrCtz9LVsbSj6hz3VV9QI7yGtAnHOAh6DseWlH7BVzGebXDuh5tvasgE
 AvHg==
X-Gm-Message-State: AOJu0Yx6SESQXnVBu9FNg1m3GtzCKezBlOLH0OLRUyHq/Zc4A4nhTK4o
 1KpfGUhJQNszkYoxEjpJJmvuuqQ8OCnNDbwuCD0=
X-Google-Smtp-Source: AGHT+IH6pAw+2ERuJixeICy7lX0U58F6kdjrYudhRL6K2lzLJMYtnuckRbq55JtiGGEDiMvWs7DksA==
X-Received: by 2002:a05:6a20:f384:b0:14c:c393:692 with SMTP id
 qr4-20020a056a20f38400b0014cc3930692mr5850011pzb.7.1694900512245; 
 Sat, 16 Sep 2023 14:41:52 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 28/39] accel: Rename accel-common.c -> accel-target.c
Date: Sat, 16 Sep 2023 14:41:12 -0700
Message-Id: <20230916214123.525796-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We use the '-common.c' suffix for target agnostic units.
This file is target specific, rename it using the '-target'
suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-6-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/{accel-common.c => accel-target.c} | 0
 accel/meson.build                        | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename accel/{accel-common.c => accel-target.c} (100%)

diff --git a/accel/accel-common.c b/accel/accel-target.c
similarity index 100%
rename from accel/accel-common.c
rename to accel/accel-target.c
diff --git a/accel/meson.build b/accel/meson.build
index 76f3cbc530..fda3157a6e 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,4 +1,4 @@
-specific_ss.add(files('accel-common.c'))
+specific_ss.add(files('accel-target.c'))
 system_ss.add(files('accel-softmmu.c', 'accel-blocker.c'))
 user_ss.add(files('accel-user.c'))
 
-- 
2.34.1


