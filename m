Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCED7B44B9
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 01:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmjm8-0004MS-WD; Sat, 30 Sep 2023 19:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjm7-0004MH-HD
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:53:31 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjm5-0007vk-W3
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:53:31 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50435a9f800so22976525e87.2
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696118008; x=1696722808;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvK8BS9ps6tlLgHZB3wvEEtS/WBjeRsiB6ed+WJeDcc=;
 b=g9aHRkxlVa5nA+jhsQT/Zm4B58s8wllcTZLNuRsWjqDF0tfTvKMjDW2nkQaCgS7rf1
 YkP2FTGkJbfhJlqku/1j+u3QF7xhgGSWsnAiWM1OE+FGlSg06SBaTxWe75m34tybrEuj
 kebgsS0HEJCn7vKSNtTWp1JfUr5Mh7bc8qvv8jY7KAGBNopGWu9GPtOyoLFZvNs/+hnS
 5CnTZa26J2Q/GYdrhQMtFobL/sp5RF7vJh7vMBjn6ZYPq83IxyECbYedxYBdnAu/tl3t
 XhZhuwOtiAsKhKn1Dv0Cb622k8m0/chBulI+Jt8Qd855nMAI9LGd6BoCorjPMoJwlFpO
 5MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696118008; x=1696722808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvK8BS9ps6tlLgHZB3wvEEtS/WBjeRsiB6ed+WJeDcc=;
 b=BmiaDya5QCYoWEaPxgbjWeIRbaW+s+GhI8znBEnqFSsGUAOIAVkADuxjOdC7FiRTO2
 iM02h2kTjKKMz1xNw5jbJWyExw0ryrPDtwn12/VcY5/lR+p82SSyXUFkGThSxhclasmL
 tGCASw3hQQe9PhVxGoj9p6lPXyVDyZJ3J/yYQ0XntY1gXk6eeXPEat1TGpPWUqibHCSs
 YybimwR8FOIoqbq0K182VbQTUGWVpaoJZbvYjfiWIA+AIit7aaWYi3zVQzp2hW5PdQGy
 PPYzQFxuqkalvY3soGVkGVbFh5MB9bCN85Fb/7Bg/g4GnbP6XDuh1Q0il/+EVt3NZhcc
 VblA==
X-Gm-Message-State: AOJu0YxoR12NxCVl4FadN5/UwikAK84bboJMoTBc7GvOmKzbv8YtvQKl
 Rp97bmNUm2wx9L41KgVeJVgYBw==
X-Google-Smtp-Source: AGHT+IERyou497UPA6O+bsd/0hugid+ejczsGp74kKQjCABjz8KMWwcjatH0lNBw8TEcuJpRXIWOpQ==
X-Received: by 2002:a19:f00e:0:b0:4f9:586b:dba1 with SMTP id
 p14-20020a19f00e000000b004f9586bdba1mr6379793lfc.4.1696118007916; 
 Sat, 30 Sep 2023 16:53:27 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 h18-20020a197012000000b0050309ea3a62sm4012391lfc.277.2023.09.30.16.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 16:53:27 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH v2 1/2] elf2dmp: limit print length for sign_rsds
Date: Sun,  1 Oct 2023 02:53:16 +0300
Message-Id: <20230930235317.11469-2-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230930235317.11469-1-viktor@daynix.com>
References: <20230930235317.11469-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x133.google.com
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

String sign_rsds isn't terminated, so the print length must be limited.

Fixes: Coverity CID 1521598
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


