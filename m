Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ADA79F84D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLU-0000aO-Bi; Wed, 13 Sep 2023 22:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLT-0000Zx-3G
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:43 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLR-0000ez-6k
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:42 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-577a98f78b2so324896a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659479; x=1695264279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAwhqBbS3A7jmg0vWZ/EipKlE7I93weu4iFN2PEsO7Y=;
 b=rxGQoRaOpyE5ItWGs8mwxVZ44RLq7XzDkROFIy6h52CdiIg2J2KnD1Gaol9MpYywnY
 6zAG77KRsTAVRbS1SE/IkInoBb0pegGxnx/H0WRtxkdDJaC5aUp34Ye0UObGYPK96dPn
 oik4/7eu23iH2woM3DgwfIaAjraMdbNopiDMfBue1J0bq70svoyhhw79gNvQcaUaIRNS
 G/BeoL/jYwfoxXZB2h1XSB/53N3B8ogLBTy8pYQZjs7aUEpx5bZxgU/STMFUOqJXtfYW
 cE9CIM9HQrq8LGLakGDBSjXsur0OHFzk22VatJNWFheNOR7FvDTvTF0c4WYoFzamG679
 4onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659479; x=1695264279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAwhqBbS3A7jmg0vWZ/EipKlE7I93weu4iFN2PEsO7Y=;
 b=SMEdqiZIQ3vdvIcJw21TrVe9QzBey8XIcAiy3hfObXwdtrlkfzZdtQIIj1YY2ciplD
 KUB9CJxN4Cc/Z1jETxPL8yeqKUP0Eay7oBINPj//fUjmtJbmBVMT2t51u2a2a3KAwF6d
 U3zobXV7mL/FKEvciW9LwXZRV0DEYzntLvgxOd8hnDraUnns+/ylWxeJ5rk1+cRetE/2
 oET8Tj357GrfBMcg2/aIUhK7iCwqI2mbFVaWhMJW9U3K2e3F0R4EYugf1UxVPBes1e4z
 oZtKXKidm9U+bxau4e222FQ9cR51GQR9Y1maY/ebhla2I8kJyCtVKtFpp4bfVLsac9uW
 kKTQ==
X-Gm-Message-State: AOJu0Yx7mJvMJsLZeA3iVH1udi5DnT1Bqh1EMM86o2q3K/IbZ5J+yIX1
 araCIFoSmYER8Jgxl1iwfKAKqkHLlcRvQdNiMGs=
X-Google-Smtp-Source: AGHT+IGxCVgI+rdHskvO/q0BNTxmd+4woysveTSu0rY+zPDa224uIvwtRFfq8VqLdgIKurdSZt40ng==
X-Received: by 2002:a05:6a20:a111:b0:14e:3ba7:2933 with SMTP id
 q17-20020a056a20a11100b0014e3ba72933mr4585116pzk.54.1694659479725; 
 Wed, 13 Sep 2023 19:44:39 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 03/24] qom: Propagate alignment through type system
Date: Wed, 13 Sep 2023 19:44:14 -0700
Message-Id: <20230914024435.1381329-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Propagate alignment just like size.  This is required in
order to get the correct alignment on most cpu subclasses
where the size and alignment is only specified for the
base cpu type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 qom/object.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index e25f1e96db..8557fe8e4e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -220,6 +220,19 @@ static size_t type_object_get_size(TypeImpl *ti)
     return 0;
 }
 
+static size_t type_object_get_align(TypeImpl *ti)
+{
+    if (ti->instance_align) {
+        return ti->instance_align;
+    }
+
+    if (type_has_parent(ti)) {
+        return type_object_get_align(type_get_parent(ti));
+    }
+
+    return 0;
+}
+
 size_t object_type_get_instance_size(const char *typename)
 {
     TypeImpl *type = type_get_by_name(typename);
@@ -293,6 +306,7 @@ static void type_initialize(TypeImpl *ti)
 
     ti->class_size = type_class_get_size(ti);
     ti->instance_size = type_object_get_size(ti);
+    ti->instance_align = type_object_get_align(ti);
     /* Any type with zero instance_size is implicitly abstract.
      * This means interface types are all abstract.
      */
-- 
2.34.1


