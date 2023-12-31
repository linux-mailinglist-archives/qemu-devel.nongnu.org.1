Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9C820AA3
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:54:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUq-0007uV-1w; Sun, 31 Dec 2023 03:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT8-0005Ia-Nc
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT6-0000sR-6f
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pb8pqm50dJTTIpyL+onLWX5kDgeSbjuS9jBiomDaQLc=;
 b=InMAJwczRMMjSbJoRAMubwuP6VtvfKQ9Qd8FpB1YHsQ97KVql6kx38PF9qCrMj4Xx9Z8bn
 kM7YH5HqFaXsb/FM/8GFZR7+epltLhnvwZQhCM1w4uHWM7Qfkgwq56IOBuRiYGdlGzF7dO
 Rtl2Mj3GuG+w+dxtKpvA0Rx0S7N1/IM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-OKzJ0o_uPki23xBxNu0Glg-1; Sun, 31 Dec 2023 03:46:45 -0500
X-MC-Unique: OKzJ0o_uPki23xBxNu0Glg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-332ee20a40fso5740725f8f.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012404; x=1704617204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pb8pqm50dJTTIpyL+onLWX5kDgeSbjuS9jBiomDaQLc=;
 b=kKuXEkpLUjrmGtwCA1ZX9JDdb2p4QgL17u52crJwSdhiyC71vgGDlalV01zQIqgBUr
 vKyFMkmaH0vTMBdJ2Cy7R46Q6NJ45l+iRgzePWzvjSy6mnTHhC3IxOuKy6C4FhC1uD0M
 XBvjWT6yHLQ9PuAUubARnod2e3YXSGvf5FBkf0gr3ZSnKbb72/DZ36uDTd/5pvGtavh4
 VpVHwCEdG32IGCGXIDusobCELHx6Uz6Ef8tlpWESexurcKGOigrEPL51R5gDNLZ/HCMB
 Je76OsYQDHn1YARZjmPhR86q18q0qijLRuPfIFQM2KawxVHXf0lOlwwysnr39dVTSQYx
 Nwjg==
X-Gm-Message-State: AOJu0Yyv4K2BfgCMcYnyaY4Bw6Qrvob6LQMcMGp9yltA1RH29TudxpR9
 44C1GQ2dx8UAl0L0Udx0cPwUjirTK02KXpjshTJl5hZQbW4v0iqKUcRKJ7gS0yLPnwxPjgs8GWY
 GQih3f5TlR40BOPNkKphQ6nqTE34COGRDItLO4AiQ/2xk74moD6Yscn6brY0dZc8CeKGTMcU24z
 q+pOlmLQA=
X-Received: by 2002:a05:600c:35c7:b0:40d:87cc:4acd with SMTP id
 r7-20020a05600c35c700b0040d87cc4acdmr138192wmq.148.1704012403833; 
 Sun, 31 Dec 2023 00:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1aXSC+q0IW6EaiTCnBXiqA3uPhfehubuEzkgL9Xhb9vJrq3HnXbwX1FZ28seemIMZLIMntQ==
X-Received: by 2002:a05:600c:35c7:b0:40d:87cc:4acd with SMTP id
 r7-20020a05600c35c700b0040d87cc4acdmr138184wmq.148.1704012403407; 
 Sun, 31 Dec 2023 00:46:43 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a05600c474b00b0040d760c37b2sm8160732wmo.21.2023.12.31.00.46.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/46] meson: always probe u2f and canokey if the option is
 enabled
Date: Sun, 31 Dec 2023 09:44:55 +0100
Message-ID: <20231231084502.235366-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 21335055ef8..7344e363826 100644
--- a/meson.build
+++ b/meson.build
@@ -1828,12 +1828,12 @@ if not get_option('smartcard').auto() or have_system
                       version: '>=2.5.1', method: 'pkg-config')
 endif
 u2f = not_found
-if have_system
+if not get_option('u2f').auto() or have_system
   u2f = dependency('u2f-emu', required: get_option('u2f'),
                    method: 'pkg-config')
 endif
 canokey = not_found
-if have_system
+if not get_option('canokey').auto() or have_system
   canokey = dependency('canokey-qemu', required: get_option('canokey'),
                    method: 'pkg-config')
 endif
-- 
2.43.0


