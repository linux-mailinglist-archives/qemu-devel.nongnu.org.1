Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3E81C713
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbP2-0005BR-Tl; Fri, 22 Dec 2023 04:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbP0-0005Ai-6P
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:06 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbOy-0002Uw-Bl
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:05 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d267461249so1000778b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703235663; x=1703840463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvABOATJauSvkSqTnUfEfpb2YY1wUplxC8fyiFfoJNA=;
 b=BH1vDfg3sW66a5dscHJnKp3SlamjS7TDWRjuC2cxksXYkOHeMzQ34WHDYK7ZRj565z
 4kggpQo0v7z4rFFJpNZiIc5SMSNrAzhC13Kwy8H2S61jKuy5N0wiX8lxbPguRIrXsJcz
 Cl3dx5jXChWplwUgjLq1PM2K7KL+mjO98De8YXJb7l0FulBAQ9JDmZ9h2mloCqRZOjST
 GnMoJm8Al5c2cbY+SbS3SkoU4+cCm86T31O3gnbU5b9WFcP7DF56NyWkeF8o43guh+oH
 PN8Y0/cdOOCMPrRez2KhvH78P+PlAnuaQ7y21fWZN5+n0yQRLVY5nHNZ/rkzJwvdUF8b
 VxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703235663; x=1703840463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvABOATJauSvkSqTnUfEfpb2YY1wUplxC8fyiFfoJNA=;
 b=D4vajeyUbO4eTlDwePoISW/XBw5XWG9ICbFrGp9BFtugzlm7TszPsxmPaNk3I/a6Pv
 YqMKVbZqf2BGYMUoQNzP5rXroGXLtPFMq4P0ZQ03LOF9vpYtz+UmGs6+fIn6Gixs8HD6
 F0V/tjDwR2BuHXYU3/pQbKmwe6iq4jhcfKlohiNVhT+XUe1dKnrgWgV0X4vjNJbbW7cl
 6cIrtei0Bm/T+bKWMWWyVEYr43zl236/GniKcrX26oQkVY4tDT8H5FoVhRFRm+rRDEdt
 zoF0/V5+LLeV5zv9Urw0A3P/WAFSocMkEAyfrEqe6UWWWeKMDSNDEa6apYMLeQmiJsWp
 TJqA==
X-Gm-Message-State: AOJu0Yw/CSO7kauiIokGVIiwjY1X6fK4E8rEmCnr5KQeeuGTDWhwblRT
 4tWaIYys/mMAjIt70r/KDbQ=
X-Google-Smtp-Source: AGHT+IGhWtEpqol/n70fWOtQPCv/l5/XQatLGGrbIXg+l4DVfnjYUXFwCLt1N6LEeqYA3c5Rp0nxYA==
X-Received: by 2002:a05:6a00:993:b0:6b2:baa0:6d4c with SMTP id
 u19-20020a056a00099300b006b2baa06d4cmr732656pfg.33.1703235662524; 
 Fri, 22 Dec 2023 01:01:02 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 01:01:01 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] hw/cxl: fix build error in cxl_type3_stubs.c
Date: Fri, 22 Dec 2023 18:00:48 +0900
Message-Id: <20231222090051.3265307-2-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Fix build errors in cxl_type3_stubs.c due to a the incorrect definition
of the qmp_cxl_{add,release}_dynamic_capacity functions.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/mem/cxl_type3_stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 1b54ec028c..d913b11b4d 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -68,14 +68,14 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
 
-void qmp_cxl_add_dynamic_capacity(const char *path,
+void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
                                   CXLDCExtentRecordList  *records,
                                   Error **errp)
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
 
-void qmp_cxl_release_dynamic_capacity(const char *path,
+void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
                                       CXLDCExtentRecordList  *records,
                                       Error **errp)
 {
-- 
2.39.3


