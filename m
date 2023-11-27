Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86F7FA7A1
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:10:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f6B-0007UW-QW; Mon, 27 Nov 2023 12:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f62-0007Ro-R7
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5z-0004dM-JL
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:33 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b4744d603so7695495e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104910; x=1701709710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+2uI5wNmH21FhUP7Rp19KQf2tC2ID75lHpAU974IEJI=;
 b=AtfBv7jqq4qRnRVCPjqzs7KQ/sj0tM6xMueJTMWjApWbO3HpVvp8tYhUmAFyxLVTiN
 Gav5Of/qOidOTJ39JedLMNJfUSzZFx1SH8IFig2dJaBLL2L0Dz0G9TochBE3ml4gsDHR
 U1hVLsnnY5ux2qFVDce6WlVOjqM2+WPreqgumVXi2sbdHcp8fNfcGtms8dyw/shpYZaa
 Vv5na606WWtr6Qk7shDxZNYJ3wIxyTm1vGdTj1HDrO2fu0BBxhFagJm7TriYZR1VGTsD
 SLYVVFTPZan+kvh8nR9D0DCccATpeOEoCHccSTuJm+7QEJlrhViL2K0ZAf9H2cwnG97/
 iBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104910; x=1701709710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2uI5wNmH21FhUP7Rp19KQf2tC2ID75lHpAU974IEJI=;
 b=edKELDlBHh+6DAHkGMojGGXA3nwgcH+JlmGTgk+d9gOa/v/NFH/r/VgiWCqE5h9wR0
 q6m3B77runfTrJftGLZBXzE3FAKIEL5JkapABFjASCYdVITVA7yg8APm0kvSAbcZr5Sk
 V3dNrLbc+C+4KGQ06G390+S3zaUC1pW8rGZ88Aa10wCu3NFK9i8s4serLDGeM76ta5IC
 tYhduweW1CTNpbGSYFz5vOfMStEFBFPYAMWGbXNxBl7LbDd0FXRzp3PxBvNA09UOhKnY
 GRKSCBVG3CaAvJj8wgUXqr9YhwdRVBto6o0d+iXs8k9nMAJoy0X8CHjkjTf514GbJ3d1
 tFVw==
X-Gm-Message-State: AOJu0Ywz/OIr77S29AfgkZv/yQM5jnoXk6O6VYp/6dtCLHDC4toCT8ul
 m2EqogLo2W7MHk9OeGiaqY9v8DpAOpzYN06L2Vk=
X-Google-Smtp-Source: AGHT+IFib3sAWbW3EY9wIWkCdeDuxGzhtZVy6NqjbxaO+bm8oTjqcjaZlmsqP3RodjV5IetviPlLUQ==
X-Received: by 2002:a05:600c:1f8c:b0:40b:2baa:6a0d with SMTP id
 je12-20020a05600c1f8c00b0040b2baa6a0dmr4811964wmb.1.1701104910300; 
 Mon, 27 Nov 2023 09:08:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/13] hw/nvram/xlnx-efuse: Free XlnxEFuse::ro_bits[] array on
 finalize()
Date: Mon, 27 Nov 2023 17:08:18 +0000
Message-Id: <20231127170823.589863-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Commit 68fbcc344e added:

  DEFINE_PROP_ARRAY("read-only", XlnxEFuse, ro_bits_cnt, ro_bits,
                    qdev_prop_uint32, uint32_t),

but forgot to free the 'ro_bits' array. Do it in the instance_finalize
handler.

Cc: qemu-stable@nongnu.org
Fixes: 68fbcc344e ("hw/nvram: Introduce Xilinx eFuse QOM") # v6.2.0+
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231121174051.63038-5-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/xlnx-efuse.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 655c40b8d1e..f7b849f7de4 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -224,6 +224,13 @@ static void efuse_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void efuse_finalize(Object *obj)
+{
+    XlnxEFuse *s = XLNX_EFUSE(obj);
+
+    g_free(s->ro_bits);
+}
+
 static void efuse_prop_set_drive(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
@@ -280,6 +287,7 @@ static const TypeInfo efuse_info = {
     .name          = TYPE_XLNX_EFUSE,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XlnxEFuse),
+    .instance_finalize = efuse_finalize,
     .class_init    = efuse_class_init,
 };
 
-- 
2.34.1


