Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AAF7FA7BB
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:11:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f67-0007TN-Cl; Mon, 27 Nov 2023 12:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f62-0007Rq-Rn
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f60-0004dY-53
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b2ddab817so31259025e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104910; x=1701709710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Li9u/apX2z/hqU6tBl3/yWCNm5priiBHrKq1erqDx8=;
 b=kf87bU9mvZgbYN2EfFtERGWyuazWVtB8zn5oSJZ1DteR+fYzbIakHkeD6JNHglvgTk
 RQdZoJWzEhdmUakaCYPhQsZdJrrViTV1Wm+/TkykLGGsT8EHUEUJVbSf6B0RmuwOFP1L
 91eC6iF7FP0J/pmTJd1GWoLfoeg95e1Fzass752K1tOJ6cZ+1JkUtIIAV7hHn6DRvHVw
 GbtbqJybgNPniRAhPGWMj2gUDm/RnaPut/U8FqFxMS2lFQ+Y1cIVxFQ0IvPcr/R62UFK
 2ElsjyFFhNxk9OKy3Dj6NEKGec9fzCgLUMDOWL5SV67qVHJ1E6CFqbaV4MmlQTNWh/sG
 5hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104910; x=1701709710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Li9u/apX2z/hqU6tBl3/yWCNm5priiBHrKq1erqDx8=;
 b=OMgwnu6dSIhhelCEj0UeZ7rssIXSdk3PZhCgxZmJ/bJ7ieKD/S3COpDOh+TY4e7K5T
 jV9XBc+qAptsbnLtGIJi0fHjCM2OkGNIKk4+2cV2sXhI1vNk5PpkMaQdm34bygkGEK5f
 F7Ri56M1awAqI+uDUL3ijo+OW4JYk01F3Ix3VhvLinHHExmrpntkhGbI17FNJLQWra0y
 +J4xMVfCea36XxVlxv9j03iiREPf5sIlcHc5FM3MAUWHEntrn6e1IlYqa/HE8pwRxOLA
 c++4t1OcgRJWn9PQnBVXw38gYoqIVQarxT4QptXGhf9yy5GnwF5dz9NybManys1QmxR0
 B1bg==
X-Gm-Message-State: AOJu0Yxdzy1RNzJ2b5DzjCWsz18mYtS4cZrMn6I3xndJ5/vetfMSsnp3
 YH1yru4ug1epNp1byZT2y+wClbYsoGaaVCP6TRA=
X-Google-Smtp-Source: AGHT+IHidsQlkcjdo/msC76Qscrt63c2ufhA+Ni8HzenWAHzajm1R6IbjsqIATUbcXvieKEUneRPSg==
X-Received: by 2002:a05:600c:4749:b0:40b:35aa:bfdd with SMTP id
 w9-20020a05600c474900b0040b35aabfddmr5570219wmo.27.1701104910703; 
 Mon, 27 Nov 2023 09:08:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] hw/nvram/xlnx-efuse-ctrl: Free XlnxVersalEFuseCtrl[]
 "pg0-lock" array
Date: Mon, 27 Nov 2023 17:08:19 +0000
Message-Id: <20231127170823.589863-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Commit 0be6bfac62 ("qdev: Implement variable length array properties")
added the DEFINE_PROP_ARRAY() macro with the following comment:

  * It is the responsibility of the device deinit code to free the
  * @_arrayfield memory.

Commit 9e4aa1fafe added:

  DEFINE_PROP_ARRAY("pg0-lock",
                    XlnxVersalEFuseCtrl, extra_pg0_lock_n16,
                    extra_pg0_lock_spec, qdev_prop_uint16, uint16_t),

but forgot to free the 'extra_pg0_lock_spec' array. Do it in the
instance_finalize() handler.

Cc: qemu-stable@nongnu.org
Fixes: 9e4aa1fafe ("hw/nvram: Xilinx Versal eFuse device") # v6.2.0+
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231121174051.63038-6-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/xlnx-versal-efuse-ctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index beb5661c35f..2480af35e1b 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -726,6 +726,13 @@ static void efuse_ctrl_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq_efuse_imr);
 }
 
+static void efuse_ctrl_finalize(Object *obj)
+{
+    XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
+
+    g_free(s->extra_pg0_lock_spec);
+}
+
 static const VMStateDescription vmstate_efuse_ctrl = {
     .name = TYPE_XLNX_VERSAL_EFUSE_CTRL,
     .version_id = 1,
@@ -764,6 +771,7 @@ static const TypeInfo efuse_ctrl_info = {
     .instance_size = sizeof(XlnxVersalEFuseCtrl),
     .class_init    = efuse_ctrl_class_init,
     .instance_init = efuse_ctrl_init,
+    .instance_finalize = efuse_ctrl_finalize,
 };
 
 static void efuse_ctrl_register_types(void)
-- 
2.34.1


