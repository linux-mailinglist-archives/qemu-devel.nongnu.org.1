Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D97744774
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVr-0007UI-Gv; Sat, 01 Jul 2023 02:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVp-0007Tk-4P
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:17 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVn-0007Ed-Ae
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:16 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f766777605so4300595e87.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194513; x=1690786513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6W2wZouwSAQes85QIyt+CMmBwG3afd8TW13hztwuFc=;
 b=FUVbFDLBybRye6pzlItxbV0rtborrjKewfnQqcCsFdk2Q7D+wvBXouE6vkAj7zLwMj
 3XLGMViIh5QnLgIPLushqE8Tl9ls3Bqngm1oyAaqe+03L6B+wlLxn/YHkl/AwpcdA/yb
 r8ZP+Lcto4lAznfsJO6wQCm18JdlG4LKzr41vSCN+H1OvPrkL4rmQIuq+Fs1D0HW4s9Q
 ksHJEEjt290Sdt8HFZv3Flfw/gz5FBb54phnzMGQPSvGcvjScR7q/Gx+PciRB/0EX/c3
 oPBXUIUQoe8Gl4D6x1htgLPO0DEMc6RM+WgrM8LXQX2id0+xf0w/WuN0B/aAgnarNpkn
 Q7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194513; x=1690786513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6W2wZouwSAQes85QIyt+CMmBwG3afd8TW13hztwuFc=;
 b=N2Z9gjE6Bzbr2nHDgvZb8U9EhJbVCu7cYgCU4+oqLNHNNFRzBMG2uGmISox2mpBA+2
 OJ8L8STD83Nd14BWwhmvfJk8W/c6bAXehQEDvtEDb5deV7JGvdaSv1U3DXokHZHOyzu6
 c/98O7F+p7mXgM7k8PDPP8gg4rt1FsgtyaPLFsbsp15DaS69LmmTtbTSTFQIEr8hY94x
 /6Rh/SPDeWE2RF6QVFB72ZRSkTokKcYhAS/Qo98nzxaMefBuu8LbsI3tzSqqdBGisZPM
 RR8sONR3QfXn60xwNRCzWE3h9XuWoRMtlFB6Kp+jhArIUKWtOsf9GWf0jCjD4L/H9kW9
 rt6w==
X-Gm-Message-State: ABy/qLZ8BjFGTyRpzfH7FZZlmmu9e2OtQVl10zVpbX1U2YibQu/bzQZM
 /ZJcQjXEpfXV8FRp3J8dyxgeJU6WAcKwoeneyOaBvA==
X-Google-Smtp-Source: APBJJlEHz2B56xpkbysoeIwGebj9CbytYBnFPPLR1GWQsbtq1Ppv5j52oqFXkbwwIl/izIQQSybSpg==
X-Received: by 2002:ac2:4ed4:0:b0:4fb:52f1:9ab4 with SMTP id
 p20-20020ac24ed4000000b004fb52f19ab4mr3082622lfr.50.1688194513426; 
 Fri, 30 Jun 2023 23:55:13 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 01/11] ui/dbus: fix build errors in dbus_update_gl_cb and
 dbus_call_update_gl
Date: Sat,  1 Jul 2023 08:55:00 +0200
Message-Id: <20230701065510.514743-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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

Add some ifdefs to avoid an unused function and unused variable.

Fixes: de1f8ce0abb8 ("ui/dbus: use shared D3D11 Texture2D when possible")
Co-developed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <336f7697-bcfa-1f5f-e411-6859815aa26c@eik.bme.hu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 ui/dbus-listener.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index e10162b279..0240c39510 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -177,6 +177,7 @@ fail:
 }
 #endif /* WIN32 */
 
+#if defined(CONFIG_GBM) || defined(WIN32)
 static void dbus_update_gl_cb(GObject *source_object,
                               GAsyncResult *res,
                               gpointer user_data)
@@ -203,11 +204,14 @@ static void dbus_update_gl_cb(GObject *source_object,
     graphic_hw_gl_block(ddl->dcl.con, false);
     g_object_unref(ddl);
 }
+#endif
 
 static void dbus_call_update_gl(DisplayChangeListener *dcl,
                                 int x, int y, int w, int h)
 {
+#if defined(CONFIG_GBM) || defined(WIN32)
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+#endif
 
     trace_dbus_update_gl(x, y, w, h);
 
-- 
2.34.1


