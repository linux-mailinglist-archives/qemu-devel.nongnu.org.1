Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D707A32B2
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2k-00054Y-Hb; Sat, 16 Sep 2023 17:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2g-00053n-PX
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:30 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2f-0000Pu-9B
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:30 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a88ef953adso2225756b6e.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900488; x=1695505288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3wrIxgr2m5oHMVkH4v8wSAkRBNGt7xc6AFyiVFHwxo=;
 b=GU7et89vQoNgQXej9+v+sycADnrLUqdz6cEuULq923fa/Suf5HHK3SR0m3Sm58M9AZ
 ncuDOmsJV3zbGaKYfUlw4G3y3tohWuNywY57Ps5+CNLlOyawCWFp6o8w9No3ZWPCcZaq
 spwTw7/Z9UIbmtiq2GCs3jB72LldprzUBgI7uT4RxUeNjEGvr957Fkny9HW8jFi3+d6u
 omuTaSjb4oItUSqXskhtTD46SLFQT/9mQ9ZeQ3YPJJVV0/cqRAwRos2Rrl0AO/Yg031i
 CFlfE4CkX0+/Vl4GTqN9Sk23DYOivY1FFkhbKYpm1mGY6HS7xmXkn6GYE1F+1u+EFbwi
 fTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900488; x=1695505288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3wrIxgr2m5oHMVkH4v8wSAkRBNGt7xc6AFyiVFHwxo=;
 b=NgNgN9azCh/pvYP96xp/QTH98ezXmvW22Fyjc8LT2JVG1shxz/a84GUlyulLAlrqja
 U+yuRv/KLb6H/3mG6FUjYLlMFeMdpqx7Mv+apq77XDgmGxlZkNP//wwg5mxZNEHyOpXa
 NCxWC75dOmG50DWIASitvrXLv9ukFjglKcTViCFdU8YMuHDY6x/sRYWPnxZYfJdZa2/h
 sf4nEAr4nh9JjkScpd5/mC+aVa97HFRnxWNMWfM5wkvZciYVy6XWAbUo4/OXLuGYlUGz
 yEbjYyUvD9BFs94kM0eYoq2f7NW4TeyTfKHcx5adnMWTwy2Hq6SCSBnCwlix748GJ0aq
 K9sg==
X-Gm-Message-State: AOJu0Yx1voF9TVBHXe8XPDe+x+mHfIZIy53qprotWc+SYx/GSppy6k60
 XP3sze1JEtn5pktWa8Hxg/n5mzpjJMnnjh4TlIM=
X-Google-Smtp-Source: AGHT+IHpIsUeX0tfLcrOYHX7LdBPICenQ7KnkwDxe3btiFqtI3XPVN465PHmMYQcadyuJ0zt9sRpkQ==
X-Received: by 2002:a05:6870:b4a6:b0:1bf:9fa2:bf8e with SMTP id
 y38-20020a056870b4a600b001bf9fa2bf8emr6918969oap.1.1694900488113; 
 Sat, 16 Sep 2023 14:41:28 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 03/39] qom: Propagate alignment through type system
Date: Sat, 16 Sep 2023 14:40:47 -0700
Message-Id: <20230916214123.525796-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Propagate alignment just like size.  This is required in order to
get the correct alignment on most cpu subclasses where the size and
alignment is only specified for the base cpu type.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


