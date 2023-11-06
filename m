Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8537E1F52
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:06:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxOd-0005nu-BX; Mon, 06 Nov 2023 06:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxOa-0005cs-87
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:03:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxOX-0003dE-ET
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:03:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso30715805e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268627; x=1699873427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1L9VmGyQhU2xkGMEVSpI4IfVFp3akp+nAwSDeWPJyrs=;
 b=LIoO2fuQ9OU9oX1Bhu58CpGkOJ9jlhlkr7CtXH1xJDHbrolk2MmD8MduyFUaXaHBNl
 YyNbNuIZMgI2mymGfLTfJJ7ztjCShWAop2W20ylWQ3xnOzzsQAJn/F2UH/sNNED8K/0+
 F4VXiJ6Nu7Dsjrx3prMHRXGa3+CjnMXi2rMA+r55LCDi78wPOzQcvbsLsqTySsSIDk6y
 05oS6ShTbo3ZZ93bUxdaNh6Tihkrhp1/t/X7FCCAcN/isYQveeltNjZ4QzAmhkNSwUq8
 MK6eM4A0yGuYeCDOjPZkjxARb5O+qI4ofPsiOXGOtQuYRMfWg9XcqIIPKdpPTnFosbLI
 MURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268627; x=1699873427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1L9VmGyQhU2xkGMEVSpI4IfVFp3akp+nAwSDeWPJyrs=;
 b=JusNo9yUYqB4mTyzq3PsbL0ylrh44uJlO8tDASySVpUj1p3QlrFnOCesYk6uCNSdb2
 3C5w/EmLbcibTvqNltoRrrvxWlx+wMjavTj5Yc9fSvKYVddh4uCIERgqN2bVPO1pyRK4
 4/NyuCHFyTywgRANtpdc5KDe6RSG4Afdu/Zzk7I3bp7pCmkxGQYGra5gNmCj6D5Pev2S
 GsOQCxKAhw7fYKp1AhronbiyoklvOIOGKBINQtF72VyXxYL6LyI20RNbVGyAA/qOOghM
 E9R1uNAgDnvHOzSMIl8/VLR/vXzOdVFqebfrLHjE1ySRK5tK62LVEfybzxZzpbW2veQQ
 qp8Q==
X-Gm-Message-State: AOJu0YzFjzyHFmFM6Oz+dJv2V4oHyVLSE4A9Zn+CZ8xmEfaVYDb0Fr+T
 IZwr+PSXnDXgMktF/smT4F9VTmwa4/wVAalKK6o=
X-Google-Smtp-Source: AGHT+IGVsR41OZiJW09UO8f2QQjHedYyrhNpAeIFY/pbatQ8PPEnpOP8OnIgt0CWNcPde4ZS+yy1Rw==
X-Received: by 2002:a05:600c:19ca:b0:406:8c7a:9520 with SMTP id
 u10-20020a05600c19ca00b004068c7a9520mr22789124wmq.36.1699268625910; 
 Mon, 06 Nov 2023 03:03:45 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a05600c46c800b0040776008abdsm11817395wmo.40.2023.11.06.03.03.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:03:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/60] vl: Free machine list
Date: Mon,  6 Nov 2023 12:02:33 +0100
Message-ID: <20231106110336.358-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Free machine list and make LeakSanitizer happy.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230722062641.18505-1-akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 3fb569254a..ff76eb0d07 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1529,7 +1529,8 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
 
 static void machine_help_func(const QDict *qdict)
 {
-    GSList *machines, *el;
+    g_autoptr(GSList) machines = NULL;
+    GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
     machines = object_class_get_list(TYPE_MACHINE, false);
-- 
2.41.0


