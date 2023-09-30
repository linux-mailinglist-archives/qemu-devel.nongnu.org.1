Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DB7B449F
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 01:41:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmjYk-0006xC-Ut; Sat, 30 Sep 2023 19:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjYi-0006wx-BD
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:39:40 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjYg-0004od-L4
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:39:40 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-503f39d3236so23812844e87.0
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696117176; x=1696721976;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92fSRc4tFlSTM5OlZs0crcqNCe9FLrZqT3dnztjQ4gQ=;
 b=CnZhoL6jAWLcjLvBYwVvnOOI1t9KkmazzIZHZ3UF67FdxmG0hMFf5NWwAGJAAJPUtH
 ecXgneR/LdtXpGQxR6xkGs6/F90akni51yorMeeqAteIxzuBUF1H2xbXHP+j7WHynTo9
 259yB8Kx5nSpeVdfr1HBtFEtgQOjUA/q6/PF17JuFw81pyd4IPmQIWqAJ/O1kN34j74g
 sKpmAZGckEtO4zUxtoOfXkjk6+ylKv1sgEdybtQuC/K2iB3hzITSgGCmhOI5m1kK0n9g
 7mepOZNhfqfHcAyf6EGt6phgchD6nwzZnvs23IHx4jDhN+4BxPF5ZEvexPDjoihCHtEi
 ITwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696117176; x=1696721976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=92fSRc4tFlSTM5OlZs0crcqNCe9FLrZqT3dnztjQ4gQ=;
 b=j/OtumPoWHWxCt1o3E4diO7xRjrIiwMccTiT30Mg804jsMwgiwO7RwF72vcK2UzWtY
 F1dd377LdnZ0Rp9Lh9A3pIGQWesd29USqM3WfX4khme4R/EJObdZDPwbQPqnJw23h5HJ
 87AhokMCkT035YnfokdPOjIK2l3DhqD8NUJYQ4eS2G2jUsxpz7Z8jJVcG4YM7EjzGLRq
 8xoBsav8wNq4Ve9pY9YD5MiMHiCJUH00TlKu/Y4K2yigMjRTmO6qg4SdkYnzsVu3x6ts
 kBlaU87S/3CF6NLHts50w8WlaqqwzXRzo95U3sf9KDmF0lbSMfoiTj0xCgA/v/QPd1kf
 RTHw==
X-Gm-Message-State: AOJu0YzWQgFNm1AczGv63LcsBTDoy81297HYPz7BcuVUukGdBdNZK2aW
 JN8BZEKOEcsCu3my0R9Ji8G53Q==
X-Google-Smtp-Source: AGHT+IHw2+8Ja38PjhChd0rvd+Yr0dfH3EQrsgR9HvQw+jej0/ku6+/DWiIxuU0HEzYt8FQ7MhaiSQ==
X-Received: by 2002:a19:e051:0:b0:4fe:711:2931 with SMTP id
 g17-20020a19e051000000b004fe07112931mr5573403lfj.22.1696117175635; 
 Sat, 30 Sep 2023 16:39:35 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 c19-20020a197613000000b005033948f108sm4013429lff.272.2023.09.30.16.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 16:39:35 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH 1/2] elf2dmp: limit print length for sign_rsds
Date: Sun,  1 Oct 2023 02:39:21 +0300
Message-Id: <20230930233922.9969-2-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230930233922.9969-1-viktor@daynix.com>
References: <20230930233922.9969-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12c;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x12c.google.com
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

From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

String sign_rsds isn't terminated, so the print length must be limited.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 5db163bdbe..6de5c9808e 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -478,7 +478,7 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
     }
 
     if (memcmp(&rsds->Signature, sign_rsds, sizeof(sign_rsds))) {
-        eprintf("CodeView signature is \'%.4s\', \'%s\' expected\n",
+        eprintf("CodeView signature is \'%.4s\', \'%.4s\' expected\n",
                 rsds->Signature, sign_rsds);
         return false;
     }
-- 
2.21.0


