Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E53D07A0EBA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZY-0002u8-Sj; Thu, 14 Sep 2023 16:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZW-0002tF-Bo
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZU-0001Up-IU
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:18 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e742a787so926058f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721855; x=1695326655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWanWC67jhmn9FXRwvcRc23eY0xLvKm6663P3+ePW3g=;
 b=FinilrS1rMObO5Zmw+dqO2sBU1gV9CJNvtH34RAFwg1PJ/vmJSxowekIi2uMGftGtK
 Pf3friyQMPAk+8BrBHwOtE+Ofjk6KD4oLBxNLEYoSc3xpzkrFbEH6ES0h2OdI7kQP2pF
 KleFkRnA7/oMEM7ScGxJhhnCVpV4no/ipp7vk5VIAOjXG5UZY1OvuyCbevDmDbP7VsjG
 WuRK3mvtM9Ok5iVUEyua/eFbwPtPaQDF3hhOHNQFhadgFEnuaa2agY5hQGx/tOTm8sI6
 AGBVqNp3YpMCcgpqtqzhG+BEqEv+6kEZAkDdYIrfTMD6lifymE2+t4fxBVq6SKPvk8It
 UXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721855; x=1695326655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWanWC67jhmn9FXRwvcRc23eY0xLvKm6663P3+ePW3g=;
 b=tpfIFJaSXOxdAf7uCoCkhOYOAQ9UEqoMSOb2Al/8h7658X0S4TWaa9/E8mroBGonac
 JJTaQSya3eqICQtaFCPopWG7gfJ4pflsLRaHVrVfqTExreRvhbXQ7KD3bZQM+iJt/ua4
 gqKbk6yQeToARuuYi+on22HA2ZTcXoBdacHF/9tqwcU3UNlJiXSzRHVvFqaurbk/LkO9
 YLkWPsHyQaOkYwt5u9VxGiooJCzbH8VtbofRf5c9HFkGn7yfDGPddwtZViZrIZdy47N1
 IFga83QR4t31aB95Eh0JBPkmsMF69HAlRYELEhi4lcNf8+chxNuxPH1C7NtcD8Nbzq3Q
 hAJQ==
X-Gm-Message-State: AOJu0YzsaENDoOFeSFNEK7dcNP5HwL8/8x2PpjIbHS3oWlsXQZAVg5Ur
 JCUAVR4bxYU+lCRboWF7WW4io4K/0AM=
X-Google-Smtp-Source: AGHT+IF5ynM9qOJSx+Tv+PQu6QzgksME0yEB5PYY4MWDcvw5EYEGD7M2Pz9JaO1l3QVK1zwAT5ip6Q==
X-Received: by 2002:adf:db44:0:b0:317:417e:a467 with SMTP id
 f4-20020adfdb44000000b00317417ea467mr2345066wrj.6.1694721854790; 
 Thu, 14 Sep 2023 13:04:14 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:14 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 07/23] bsd-user: Add bsd-mem.c to meson.build
Date: Thu, 14 Sep 2023 23:02:26 +0300
Message-ID: <20230914200242.20148-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.c   | 0
 bsd-user/meson.build | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 bsd-user/bsd-mem.c

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 5243122fc5..6ee68fdfe7 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-mem.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
-- 
2.42.0


