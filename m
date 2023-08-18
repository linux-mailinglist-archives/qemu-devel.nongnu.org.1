Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDAD780FB4
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1sE-0005J7-47; Fri, 18 Aug 2023 11:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX1sC-0005Il-GU
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:58:52 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qX1sA-0004wa-Ad
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:58:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-317f1c480eeso961391f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692374328; x=1692979128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiLjnG2DY03Yn8ZcFWzWxO2i88SwNhYf8beW+L7aAF8=;
 b=ZcraEF7Otpa9r+c4gjxjJ0ZKZB9NuCnPbo8DRkN5+7IHbEbTsivD+A8jXe4ScS3iD+
 FbUfyTNDGrPs3qxaU1DpKrX7rOWMkb9XBX7OUvgoJZEPuw+MkevpkjH7neJwIjNCwBbE
 F3R6Qwlu5uyo5nf/M+O0SPkOH1X870miIa/Pm5rzkWN7VkGbgvdadYI7lo3OnWDVLfLS
 1n/7HFV/oJq+Bre3EzI7yits04+lJh3DwXgkhj8fwGh8cokLZvI9WaYEEdYM2kBTgQzw
 WPImbvzhdbKKBllk3iEHl5a+reXUd3LX1Wg6hk5ZIKH7TDl4prKOXqZZyWzFTbCm3UBu
 Nrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692374328; x=1692979128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GiLjnG2DY03Yn8ZcFWzWxO2i88SwNhYf8beW+L7aAF8=;
 b=TaFuBHfdTAlEc58Qq8N8P6czWbYZ+RLpXhRJqvOEWeau9syoVO6IHd+epahGZwS0Sn
 50S8+CgJz7upOzm3Ey5O14YXnYAA0LFgzMvuRVpaq433mwEvIE72oN0gN4Ls4vc/w9gO
 eIgUpp6MS4OmFeZDa68M7g1AhydnDhyx4STyOMrpY4bus6gG+dR5LvrInw2ib1GC6atA
 jgWYq/DyYrftzhWRFS6pPDLVGjP0prZB152sDWJPr8ve/ZbE607yPDKuF2oYaA4F1G1Q
 S5flK4887r6vnfGVFDZtByeS9Yg8sQt1B6m5JQMLz6bQADhu7AT28f5ec2Bq00cAad8G
 eYRg==
X-Gm-Message-State: AOJu0Yz0B1mr6Fq5pTbI05xTly0hZZphiYcA99gguYMEQ5sZDvqCviqN
 WsHYqmnM/3U28I26xZlLNDiRn3M47QMwmGtgkGY=
X-Google-Smtp-Source: AGHT+IFcvXwOeyX1gml07wwECoRmqLU3TxUezM3bRCMBGWeSqNGgBLBl1pY40uA4tAOpUYIsez3niw==
X-Received: by 2002:adf:f186:0:b0:319:8a5a:ab5e with SMTP id
 h6-20020adff186000000b003198a5aab5emr2304939wro.38.1692374328298; 
 Fri, 18 Aug 2023 08:58:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a7bcd95000000b003fbb346279dsm3275702wmj.38.2023.08.18.08.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 08:58:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH 1/2] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_client_init
Date: Fri, 18 Aug 2023 16:58:45 +0100
Message-Id: <20230818155846.1651287-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818155846.1651287-1-peter.maydell@linaro.org>
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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


