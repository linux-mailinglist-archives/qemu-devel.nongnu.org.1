Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D279C75C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxLw-0000Lj-HQ; Tue, 12 Sep 2023 02:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxLu-0000KK-5b
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:26 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxLr-0007St-0H
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:24 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-565334377d0so4469617a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501902; x=1695106702;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Owf73A2jtbtMsGA7cBmEhb5GKITEmhQO9JJT6nRhMFY=;
 b=E+cfDBW8+2iR6ZccePdKoc7BKP7W+xZknkljYGnh5vClRN5vXbG36cgEH2XKKlEYTu
 G6BH7KOAvUkjDiEeXleoUjwBzl6SGfASGKco15EF8e2Jxnk86NjVcZ14lfkgsaKIEAml
 BFsvL0nFNd2rjZXdOmX5xIIoiBGFzCuFbTs2Mp87gGNUH8AuB34Uvp8U2ubDZLspVLfY
 /C9BP+ki0q/levhRAWSoUNVe9SYgPD1h5XU+yNvXDPnqlUr28idNxW0KKOIKQ+I9rtSB
 1ikqB2/Q2XDEilCMXdJyrliqR4Htyu9+f4bd0z89h2cb6cGvrzkdAcp2hB88nfDlT2G+
 21wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501902; x=1695106702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Owf73A2jtbtMsGA7cBmEhb5GKITEmhQO9JJT6nRhMFY=;
 b=lO5hbqW4lbKTyBfo3WV3fJcPm4MqBWD9/71osRQJtZXjkXs+1OpcG13mcbcAaew2na
 uWsocHmT5k5P28n6iN7g3utrnmo82MF0/ozFOiNIOiitxqS87pu4ZqbxKhWieXqiLNai
 NLgqrFFPazV3e7kV3DTXG94MqjorxeIMdRXEWaY6Q5Pggw3UIL9bBxUAyNDrw8+IlcPA
 +CqvgBz2OLGNHtFbbgkjlOjd+DxekdBCrHOeYPnMv3ubwZ8RMulZCTi/wa/AAGrEIIdt
 DDQM6vGfHi+HQHISx0Hu0LHwtNKWZDdY34OeqozejPdqBMwDL5U1BwvBS5Gp1b+fyyA1
 Sbpw==
X-Gm-Message-State: AOJu0YwFlqMyG2lNt4NzKiWaQeMtBtosStG6VRapH5SLY7k17f504Nbq
 Aol50iMVj/kzRUJh64igXyX1pw==
X-Google-Smtp-Source: AGHT+IHSF8ORWAyNs5qL+G5QIsSfyYVf+7q8gZ2v36J4GETyOEJt+GNOPOlubty2FlDSCSI2uRFOzg==
X-Received: by 2002:a17:90a:2ac5:b0:273:cec7:23ee with SMTP id
 i5-20020a17090a2ac500b00273cec723eemr11088426pjg.37.1694501901805; 
 Mon, 11 Sep 2023 23:58:21 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/11] gdbstub: Fix target.xml response
Date: Tue, 12 Sep 2023 15:57:57 +0900
Message-ID: <20230912065811.27796-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912065811.27796-1-akihiko.odaki@daynix.com>
References: <20230912065811.27796-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

It was failing to return target.xml after the first request.

Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 349d348c7b..384191bcb0 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -396,8 +396,8 @@ static const char *get_feature_xml(const char *p, const char **newp,
             g_string_append(xml, "</target>");
 
             process->target_xml = g_string_free(xml, false);
-            return process->target_xml;
         }
+        return process->target_xml;
     }
     /* Is it dynamically generated by the target? */
     if (cc->gdb_get_dynamic_xml) {
-- 
2.42.0


