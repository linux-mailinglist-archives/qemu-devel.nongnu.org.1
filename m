Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BA477AAF4
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzj-0007qx-A1; Sun, 13 Aug 2023 15:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzh-0007od-FA
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzg-0002PR-0M
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe426b8583so37457695e9.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955798; x=1692560598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ab1IvE3iWruWgD8FlAhi9ghHGvE08UiOYtOTrfrC7KI=;
 b=N75i4Pt5P6ophRwVt+gScX6o1dgnFr54Ev66g+dPPujxuPtPI/cltE67z0CmiaNbUN
 DiqJOjEn+MDQksxBy9lvyK9iOXmRn4VXYpbGDoRF11NJgz6EkKY8Qu5eDWGGr3ZCTs/t
 +Jm4tQVlM3aiIdKx84C2vnLzFOGCN/R4+zjY/PjAGNKaes0oOr7Wl5AHTkvKn8QGM6ZS
 79UR+vO2DE1V9eiyep2BAhbOxmeNTV4SwajiBeBdjUwfkzUcor4Wfe4zT7dwhZkQV4Cf
 8uzV3ERo+0+GMaZpNyXgPUbiF3HtRkfyIXS++iJvvZbtYIT2hsCFrv37uVuX4JQT9eN4
 DgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955798; x=1692560598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ab1IvE3iWruWgD8FlAhi9ghHGvE08UiOYtOTrfrC7KI=;
 b=htGUVAqeQQequGhMAh6/0UEym3Yum9aLwE5pLUYMYQKLZgOByFX7o/qI53seBsonbG
 D2/BbBB7kzzPnDoR00LfyUdtc5tjjSRi8dZ+QGcNBrfu/Csswarq4H0nJP/kY4U+UMAU
 WYJceCH+9xbKoKV1lY9DqyLAQVH3qP7dU6gtBOtlIEnOXlclblUCb4Dlm2O5U92eNSy0
 BgVUFO2q95ETSJYddo5Sqwc/PEisRoeMGUs/540fNB1wVlWGakVr5JrobdZYiUNb7AAB
 ak3Cyl1ZI4MpgDcFAUQZnhrmby/stI7Ct1ubwoMPvCCCkLQl1met4sM3mL6/H0RvfnrT
 V6+Q==
X-Gm-Message-State: AOJu0Yzz1wDAlIObkgKwjetYBfZ93h4b9sKf7ei0SjqXM1dO9jZBInQu
 zEdD5r27ghspWfKPK+OWnGW4HhXGrLo=
X-Google-Smtp-Source: AGHT+IGc0Y7Q98C8JqYXv/4PQ0GTwqQkfRNXvIaQY4djlXWdK5ECC3XIZrY4Murj5Obxkk01er1Msg==
X-Received: by 2002:a7b:c40d:0:b0:3fb:415a:d07 with SMTP id
 k13-20020a7bc40d000000b003fb415a0d07mr6084497wmi.36.1691955798087; 
 Sun, 13 Aug 2023 12:43:18 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:17 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 15/32] Implement target_to_host_fcntl_cmd
Date: Sun, 13 Aug 2023 10:41:36 +0200
Message-Id: <20230813084153.6510-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Implement the stat conversion functions:
target_to_host_fcntl_cmd

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 9eb01bf664..2ce235d5da 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -170,3 +170,11 @@ abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * fcntl cmd conversion
+ */
+abi_long target_to_host_fcntl_cmd(int cmd)
+{
+    return cmd;
+}
+
-- 
2.40.0


