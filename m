Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A776BFAF
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKr-0003yv-Ac; Tue, 01 Aug 2023 17:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKW-0003x3-Em
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:55:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKT-0004pD-PS
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:59 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3174aac120aso5658815f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926895; x=1691531695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TL4wONxRCFHb4IRhcbJ760o3oW6V2ATu43JtMkEQRP4=;
 b=lxoqXbW+NbJPwfc8NfnvGZ3d72+SWSU4BhE7uJo44BCFMbryNVzfCSgSUh30WL6JOh
 aZqDHfxhn8Vh7+76H582c5oRZH8aQ8bZbl6prDl1Ess5+opWknKtQqpcF+9Z0c6kfWdh
 V32HRJYUXHnxu6r/gINvGvZVb8OC5GCK45jBegnFgi/QmkC6LGwfRODmeTHikdPHDOuH
 U++Jqs6enVSSX14u7uJq7B19kDrwBiUO0BECUvSU7S/AaI1d/FgsOartT7HR7zXzLWhE
 zIjsRq7Kx0RHvlohOtdYBKz9goInv6mUiY32aUirvK9JWM8VpQ6CY2us4yEohE9q6jbe
 19GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926895; x=1691531695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL4wONxRCFHb4IRhcbJ760o3oW6V2ATu43JtMkEQRP4=;
 b=abnQk3T24aXigOcc51Okbi2ZbHjw30UpII/N7bdGT+ftlXkU0HIMvQzuy/37TXlIGu
 QM7CBx5L5IhBfMrmJqL7lgw87wVwYw37X4alamm0yPdTWo0xYYUM4s628PfvIyRh0RTY
 LsOvJdK3Yq9mVjeDJj9nqgE7iGUqGRvUz+RiNQ34Ea6+J61lTsfU87pX75bKAELLHNNa
 dfDTI3gJxqbxrVrGA+TBY/HIJAxSV1Wu1D3/XBkz134Are7CUQ039O/xGSlI31fHBN+n
 rigZe1gcVkspxVx3O/fqUAddQl8lpm8gvHJL/iDunZhpCihYeS6dedvCeojVy9On07tZ
 L68w==
X-Gm-Message-State: ABy/qLbinylo9NPKpLwVV69A8bXrB2YNoO9l0aBTVG0f+nAHi8qiBqi4
 r6FysEY0AElyGElbVFGB7v9b/FIc/KjDb+SdE5w=
X-Google-Smtp-Source: APBJJlEdnDgakixjizoYz4e3fDaZ/qW3txxFwJVuRt1xsf31ds1X+UOcLb+mEj9vKU3pEZsI7G+sZw==
X-Received: by 2002:adf:efd1:0:b0:313:ebf3:f817 with SMTP id
 i17-20020adfefd1000000b00313ebf3f817mr3121670wrp.22.1690926895154; 
 Tue, 01 Aug 2023 14:54:55 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 k14-20020adfe3ce000000b00317643a93f4sm17063951wrm.96.2023.08.01.14.54.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:54:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 05/10] ui/dbus: fix clang compilation issue
Date: Tue,  1 Aug 2023 23:54:16 +0200
Message-Id: <20230801215421.60133-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
References: <20230801215421.60133-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../ui/dbus-listener.c:236:9: error: expected expression
        Error *err = NULL;

See:
https://gitlab.com/qemu-project/qemu/-/issues/1782#note_1488517427

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230726151221.515761-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/dbus-listener.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 02fc6ae239..30917271ab 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -232,7 +232,7 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
         egl_fb_read_rect(ddl->ds, &ddl->fb, x, y, w, h);
         dbus_gfx_update(dcl, x, y, w, h);
         break;
-    case SHARE_KIND_D3DTEX:
+    case SHARE_KIND_D3DTEX: {
         Error *err = NULL;
         assert(ddl->d3d_texture);
 
@@ -249,6 +249,7 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
             dbus_update_gl_cb,
             g_object_ref(ddl));
         break;
+    }
     default:
         g_warn_if_reached();
     }
-- 
2.38.1


