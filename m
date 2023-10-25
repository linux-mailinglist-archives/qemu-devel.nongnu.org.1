Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E97F37D61E8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXm1-0008LJ-9Q; Wed, 25 Oct 2023 02:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXlv-0008Gw-0i
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:53:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXls-0006vz-QC
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:53:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so44892475e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216819; x=1698821619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0NCUL+cpRhXf2m5J3/0i62r4P+oaEOwVGx0UuDtmlk=;
 b=K4qZpJIkre7sXUTA+wl7lGh+6C9etY8ekwFXKAypBKnOB25WTtJFXK4DO4MWEbNAPU
 UYpscmJgDstOGxxFNfRGoM6F6fzkiunWzFMHbRnao8X141g6eFsD35BUuKk5SA1mMbIV
 Zi4EOBrKOUuFH8Y9ENVz+hvCTGD8spr9ix6Vhxgruuyq4oCnA9E9dtrU/IUzjZiGsvNP
 /DAlTX/cEqZVfp8o75kDIHnYqfHuH72vpwDBXPPQFjQMTOZam/FAm2kP6KDBHVGyldoo
 dR4TIdOU4NjMELtrS73/2RFNqOyJoaQ9Fh1QyhAKt+iIXrjtDvSMd4wn1qT/ct8LTm29
 K9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216819; x=1698821619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0NCUL+cpRhXf2m5J3/0i62r4P+oaEOwVGx0UuDtmlk=;
 b=Ut2Yi13IjO8A7cFvO544mj2TAXXjXkYT5pTqbbK+GXA3mHIwXidyi5iwdusPJUkOVD
 lt4kvoF6KafYarEiahVffj3v92PXZW7E3PSvbTZm3BagRFB/sZg+yAPOdOO+UFSts5Z9
 XoQxuZLu+zUQk8aIw647V7YdZ/MaiN5Q5sqAVkkcqaLpiHD3Oa+BU4iCyawafE3HcgFc
 l+ET4yq515u2vCKD6Fm4xkkR14S9FwX7dcyOcuO0zyijdVt0Rq11JburFz89D7Ac307p
 o3Rlz/07ZBMTafrNhUHW7O/yYDTPpytS5Q56HR+Ku3IZ5xyiVwR6KWnEz2myUaeQhr31
 WWgA==
X-Gm-Message-State: AOJu0YxpvVh4o1F8P5CdRisnFag1ZABcqjdLqtuAECWYRvOeJtduNcCF
 DFnp9JGMRqkp7Iu6Q38PZpjZ1U/ZotiZZOFmaPE=
X-Google-Smtp-Source: AGHT+IGBMJOFm0i6VfAnj5YJCjUtSiBk9IT5ZnALDPV4qPex1GavAeeNGULPLfh/8H7DNvW5foxSww==
X-Received: by 2002:a05:600c:4f86:b0:408:f9ce:56c5 with SMTP id
 n6-20020a05600c4f8600b00408f9ce56c5mr7535464wmq.24.1698216818884; 
 Tue, 24 Oct 2023 23:53:38 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c471300b00405959bbf4fsm13936071wmo.19.2023.10.24.23.53.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:53:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH 03/10] hw/arm/allwinner-r40: Remove 'hw/arm/boot.h' from header
Date: Wed, 25 Oct 2023 08:53:09 +0200
Message-ID: <20231025065316.56817-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025065316.56817-1-philmd@linaro.org>
References: <20231025065316.56817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/allwinner-r40.h | 1 -
 hw/arm/bananapi_m2u.c          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 72710d3edc..6e1ac9d4c1 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -21,7 +21,6 @@
 #define HW_ARM_ALLWINNER_R40_H
 
 #include "qom/object.h"
-#include "hw/arm/boot.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 74121d8966..a7c7a9f96d 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -26,6 +26,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
+#include "hw/arm/boot.h"
 
 static struct arm_boot_info bpim2u_binfo;
 
-- 
2.41.0


