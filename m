Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FEE76BFA6
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKW-0003vr-KQ; Tue, 01 Aug 2023 17:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKP-0003us-Lh
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKM-0004oA-St
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso67415925e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926889; x=1691531689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2T0C73iE5ucC0JEX55ofVhBEJhpXpDWRqJBs1hHB9OM=;
 b=Jr7ar/mI1dtCR/bozchalPpeVUjRXpIfX2wlc16mP395CJW4BHHkLTVys5+fcKMwIj
 98Ltl+VUMQ/efUpjA/cDvMkSJ6EBvsh3OBiCLx1fntVza/na/vlsU4mnw422tTRKAzME
 VN9ZNEGHVlLEDlB9VaDUC313bt6jYZ0ybxRgDxvpjByxm28+lK578g+RwAj1BLoH4/P9
 tvX9YqNOinpzcGF68bOUxSxxjx+kRIwVccoRbfXFh8u0uZIwPCSbKolSt0asXYm2jKxN
 Ua2ahlJJaM/lMwsa/QJQFFBLTalkzO+NpuW8BXObXVTMSeePU4cqEtCAI/TzmtCOu18R
 KlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926889; x=1691531689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2T0C73iE5ucC0JEX55ofVhBEJhpXpDWRqJBs1hHB9OM=;
 b=Di2RgdN3I/siKkhfymbewoZACDndehaco0W3a12DRAGmaQCC5icC/Rq4pFaq6OAzBT
 NPbVhXOZfRjkQc2b4X094zFKHO+BQj7JASbVYPOwgOU3Ntno8rk60ksKXY2k/b2UkJ6E
 a2k7JjnGkwpIUYR7f/NJuuP1WecT4CHEcYWcvyBgE5Cg8OAobo9+ZonMdzYtTQYP1Ai/
 Hx9Lg6I+aCLY61wgXReapUD1w3oGxGnPhDlw7+GFi2fAj6cuwFvq37hbufBhvDHIKu6V
 tZw08vVnrvl78Pl8tAaNopHH2g5JlMnsa5iNRlFDdruPBJfHXgsi/DFuOdN/Apm2HYaY
 mwgg==
X-Gm-Message-State: ABy/qLbQzIkeJXJXmpp4qkS7BdVJp6rATU75e6WNFZok1kqHL1NuUbAG
 ydhQ23ExmJi0WwI2phe5Yvtili/zXc5vfewpYOo=
X-Google-Smtp-Source: APBJJlGx0GQu/kJzMsRkPrLUpUXcFy76gbW5ZuasP3buXLVYol/EL8ZNlLt0LsjWsJToo/RnsZSomg==
X-Received: by 2002:a05:600c:22d1:b0:3f5:fff8:d4f3 with SMTP id
 17-20020a05600c22d100b003f5fff8d4f3mr3742936wmg.7.1690926889328; 
 Tue, 01 Aug 2023 14:54:49 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 t8-20020adff048000000b00317878d83c6sm14990064wro.72.2023.08.01.14.54.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:54:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/10] ui/dbus: fix win32 compilation when !opengl
Date: Tue,  1 Aug 2023 23:54:15 +0200
Message-Id: <20230801215421.60133-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Marc-Andre Lureau <marcandre.lureau@redhat.com>

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1782

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230725112540.53284-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/dbus-listener.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 68ff343799..02fc6ae239 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -338,6 +338,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     return true;
 }
 
+#ifdef CONFIG_OPENGL
 static bool
 dbus_scanout_share_d3d_texture(
     DBusDisplayListener *ddl,
@@ -399,7 +400,8 @@ dbus_scanout_share_d3d_texture(
 
     return true;
 }
-#endif
+#endif /* CONFIG_OPENGL */
+#endif /* WIN32 */
 
 #ifdef CONFIG_OPENGL
 static void dbus_scanout_texture(DisplayChangeListener *dcl,
-- 
2.38.1


