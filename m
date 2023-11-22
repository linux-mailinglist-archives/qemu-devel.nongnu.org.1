Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFA7F4F97
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:32:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s0b-0004BC-Mr; Wed, 22 Nov 2023 13:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0I-00049z-2q
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s03-0004Yc-Us
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:10 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso281445e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677856; x=1701282656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSl3SvKqQCH/74SE8sqRcfeJMBZmOK/fR4uLmHCWg/A=;
 b=RRYkkzKzayyDaoNmgqqeRCP0WOQDWX0EstnE52z/+iBWjuvEaiLu7T5XN039aJoCG1
 Xykgg2a3mqKGRMK6ev3p5LwsSTMaVdv4wI736mR8xfAVeGehNvfe5FNCt0Nhncvx/U80
 uQhmvEZljuGQvbtdu4surSHJfWgu/QXMH3BATjyP5dGLlC1umlBm7yRrpcV5Rqv9SoTc
 UVcuSH2Q1olvxWLoF3Dg3/xIiQ9E33Zz/HQ6s/v6aKtZ4KKqameV66a8sewYDikPj0AU
 DVo2FgoH82wRx+Ow3SIcgZ80gwX6n+35fTRrCpgRy7gFpZBD/00hLvLvjCU1UhvyX1rM
 yuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677856; x=1701282656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSl3SvKqQCH/74SE8sqRcfeJMBZmOK/fR4uLmHCWg/A=;
 b=tzG8KAeg50zG7SxiozfSgyFK8/tyjUPF+vssZSrjdLjs2rorPVRwqwoG5zGhALmz/S
 H+n0pFlMA8aJBowR4KSRnySAhXlhfXHfUcg9tM/sitW28DTux5A7AfClb4yUElEKdmnM
 e8uIcfF27pYtyW3C6MbrDpf++HTYD2lseWc4ZLgbdYfS4NEusrnfsNHne9V+f/+V8o3e
 O9dI4qYXjP2dKuZHA6cyiKHJ0bZWzd/Dkq9o5TsNwP6ZqXILZJLPVqpxU1UyCwTbuzvV
 HglMaarnhav6eH7syCHPutP+G4FNtKcbs9YfOTIdxAAluMydHGw53zibWVXWflOEXsMJ
 pO5Q==
X-Gm-Message-State: AOJu0YyD7VoauUotqCKEmaH2LTOLxHRIG0E7zPdNKP1//lid2/eQWscP
 9HUv7H0cwXBtfsEBFrkeWlRgbpN8ZDZY/9nvg0A=
X-Google-Smtp-Source: AGHT+IG+lom2T2L1G6ppR4LSOkVj0+z1J919Ft7QO7x8s0p9VZICGrYQcWydldiJjYb9B55ciEXU+g==
X-Received: by 2002:a05:600c:1991:b0:408:53ac:141f with SMTP id
 t17-20020a05600c199100b0040853ac141fmr2507005wmq.24.1700677856143; 
 Wed, 22 Nov 2023 10:30:56 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c431500b00403b63e87f2sm176451wme.32.2023.11.22.10.30.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:30:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH-for-9.0 01/11] qom: Introduce the TypeInfo::can_register()
 handler
Date: Wed, 22 Nov 2023 19:30:37 +0100
Message-ID: <20231122183048.17150-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Add a helper to decide at runtime whether a type can
be registered to the QOM framework or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 4 ++++
 qom/object.c         | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index afccd24ca7..0d42fe17de 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -372,6 +372,8 @@ struct Object
  * struct TypeInfo:
  * @name: The name of the type.
  * @parent: The name of the parent type.
+ * @can_register: This optional function is called before a type is registered.
+ *   If it exists and returns false, the type is not registered.
  * @instance_size: The size of the object (derivative of #Object).  If
  *   @instance_size is 0, then the size of the object will be the size of the
  *   parent object.
@@ -414,6 +416,8 @@ struct TypeInfo
     const char *name;
     const char *parent;
 
+    bool (*can_register)(void);
+
     size_t instance_size;
     size_t instance_align;
     void (*instance_init)(Object *obj);
diff --git a/qom/object.c b/qom/object.c
index 95c0dc8285..f09b6b5a92 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -150,6 +150,9 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
 TypeImpl *type_register(const TypeInfo *info)
 {
     assert(info->parent);
+    if (info->can_register && !info->can_register()) {
+        return NULL;
+    }
     return type_register_internal(info);
 }
 
-- 
2.41.0


