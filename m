Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E87A9858
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcX-000273-75; Thu, 21 Sep 2023 13:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcV-00026j-Dv
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcN-0007hW-0I
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-403004a96eeso12870165e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317853; x=1695922653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YmquttdWOUZO2zoSRHgCppwJQPOrmr0UTW6yGeHagaU=;
 b=BI676u0MTqHGLRDopJUbL8wadSPpaoKQeCR4w4jVyXG781MkEn059Y8tWtSI6/9aAR
 SG3RZww7nrfGymxZd1hJl30m+EtfFrn1VOAck21j/+LaX3cqmqnQgcRQ3HWFUamoqIrU
 p1o7ZeAmz6YOCa8v10oCa3rAZ1tp20zpUnCalrv/8bXX8a0SQGSb0eYJIAhLhZrRrw/5
 0kiaRKd7lzbg6nOTeoUiCsUAgAYbjVqsWbgmyHLPo/YGJLKZnJkpnhSSctjXqvM3hD8b
 R2opYa9WNVR+aX7Pc9NUXVv4jjTTvMiTKdlQ85zV3ceBKCe5Yx6zmD7QqO7RuO6qd1d2
 o/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317853; x=1695922653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmquttdWOUZO2zoSRHgCppwJQPOrmr0UTW6yGeHagaU=;
 b=K5qE90HZTxCJ3T5I11b564dmY5B2ZxRy1A62WC7bEP5V2bfsc6y4sAeLJbDaNU+cg7
 bGe+dej28vf/uugLJzmJQ2+IKDwh3xJqXa4fScdv9OEoIvM9GEn5iq5I82D5y/8fw2Dl
 u9Dsbp8BkaRL7Mx1/k/qV2t/OUb0crwORo39Bb9UxkOYbZ0mFrfQKdtKeH5b/duTMeVI
 wplJEMSXFsFXectSbgHnFG7dRa5ZnrQcDq4l+egwDmEntJobjM0OpVlyNxWWr4XZyWr0
 gi73mO7uifqxL4B86m/gC3dn/X8Owep4mtw2IpuGtYjEWiiZwa3ar5d2RwjldaevAuA9
 csiQ==
X-Gm-Message-State: AOJu0Yzy59ADmS9NiCezt54D1bUjzVgkEwiAXcWmxSyMVPiOgZDVlGe7
 AqBrkoMTM/tJiNqJ85ho60nKnpvMMg7e4xeZrTo=
X-Google-Smtp-Source: AGHT+IHRdIMgjJ08pWCuUzRUHO+oBaUMHgBDO+5UnEoEsTS3jqRoshDGVbli5BNmczPfaJvuJN9sTg==
X-Received: by 2002:a05:600c:a381:b0:3fb:a0fc:1ba1 with SMTP id
 hn1-20020a05600ca38100b003fba0fc1ba1mr5546340wmb.35.1695317853192; 
 Thu, 21 Sep 2023 10:37:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/30] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_client_init
Date: Thu, 21 Sep 2023 18:37:13 +0100
Message-Id: <20230921173720.3250581-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Avoid a dynamic stack allocation in qjack_client_init(), by using
a g_autofree heap allocation instead.

(We stick with allocate + snprintf() because the JACK API requires
the name to be no more than its maximum size, so g_strdup_printf()
would require an extra truncation step.)

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-id: 20230818155846.1651287-2-peter.maydell@linaro.org
---
 audio/jackaudio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 5bdf3d7a78d..7cb2a49f971 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -400,7 +400,8 @@ static void qjack_client_connect_ports(QJackClient *c)
 static int qjack_client_init(QJackClient *c)
 {
     jack_status_t status;
-    char client_name[jack_client_name_size()];
+    int client_name_len = jack_client_name_size(); /* includes NUL */
+    g_autofree char *client_name = g_new(char, client_name_len);
     jack_options_t options = JackNullOption;
 
     if (c->state == QJACK_STATE_RUNNING) {
@@ -409,7 +410,7 @@ static int qjack_client_init(QJackClient *c)
 
     c->connect_ports = true;
 
-    snprintf(client_name, sizeof(client_name), "%s-%s",
+    snprintf(client_name, client_name_len, "%s-%s",
         c->out ? "out" : "in",
         c->opt->client_name ? c->opt->client_name : audio_application_name());
 
-- 
2.34.1


