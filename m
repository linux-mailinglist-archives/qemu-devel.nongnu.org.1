Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB178F5E1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqbW-0004fa-Af; Thu, 31 Aug 2023 18:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqbB-0004a8-AQ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:57:13 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqb9-0003Au-5O
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:57:13 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bcfe28909so151988866b.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522629; x=1694127429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6ajozl3I8cZhElfB+2XmFUmgwvrNnndLTvZEZRsKzQ=;
 b=qbs72Wtgr5wleqqxACB2kg5jrFwIOtIYweM0AmXR0vGNhP0RPJuaQ1zHjixnJlcc0y
 844xTw+Bm09WwmFFT1MarqvxiZaYwKRJkYPCjlgkjT9nZRkUiLax91TCwR0MTGAxVLPK
 GutDeGUHzxkG/JXcOov15ZeDBvFeRgHbPywwxmmFLawRKKv3Shl2teTxmW+nfl96e2F+
 fb6sfHSegvd+Ur1k1uX2YkQk/h60FhC68VLcLXjqPOBzvOxHnXvWrdOeZvkSdVRkI6RB
 4LhkdingWREmc0V0GkI5BLyhZiz+Xx0cXE9wmlyY2Ouu/XLnCmheREakmlInOABXbf4b
 UX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522629; x=1694127429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6ajozl3I8cZhElfB+2XmFUmgwvrNnndLTvZEZRsKzQ=;
 b=PPMRSjdh4p3NS/52RWrMSrHksJLw4Ul6XEhnA2bHq7mg0+vV1gzQsgxNe+bneJ6L+1
 1OCJzu25CKmAkxt8+cdlB/tu4ug6k3Vq0ByY+kUnNoeK3f7tCP4JROU9cVwN2MNKGr5h
 zFyVe5eMzkInjjAYrIClCu6JAC57Oscukv8yfvt5Hb/sTNVR9FhKWAvd0Jz0Y7085AND
 ye3yq/13NYd1bMQtl9ATJ1ae2kdR1gwjSXMp9hGFVPdxfJjhwfoYAQcdponmwUxmbJFB
 UWW77q+yKQkMXuu1NSpUrh058aM7NIrSXxn+XvAWsOxb9l+t2TSzEGW5LJiTfnuqJaJo
 z6RQ==
X-Gm-Message-State: AOJu0YwkFlql4pbtsCIdXHX5HKivFDpajDI/H1Ro7cFHsDtuakF7QyFb
 hcZd3He0KJ9qeNbzeYZCn0lfzmoXrR3PiMdb0yQ=
X-Google-Smtp-Source: AGHT+IFrf6r+rU1QpvLTztuLMlCNJoY1gopaeWx3eI3SP/jE5CFGIWJiR7gl0wuWKgSl/P74y5+MVA==
X-Received: by 2002:a17:907:7804:b0:99b:5574:7d0f with SMTP id
 la4-20020a170907780400b0099b55747d0fmr439332ejc.23.1693522629667; 
 Thu, 31 Aug 2023 15:57:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 dt22-20020a170906b79600b0099d959f9536sm1273599ejb.12.2023.08.31.15.57.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:57:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 10/11] net/eth: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:56:05 +0200
Message-ID: <20230831225607.30829-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  net/eth.c:435:20: error: declaration shadows a local variable [-Werror,-Wshadow]
            size_t input_size = iov_size(pkt, pkt_frags);
                   ^
  net/eth.c:413:16: note: previous declaration is here
        size_t input_size = iov_size(pkt, pkt_frags);
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/eth.c b/net/eth.c
index 649e66bb1f..cf030eed7b 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -432,7 +432,7 @@ _eth_get_rss_ex_src_addr(const struct iovec *pkt, int pkt_frags,
         }
 
         if (opthdr.type == IP6_OPT_HOME) {
-            size_t input_size = iov_size(pkt, pkt_frags);
+            input_size = iov_size(pkt, pkt_frags);
 
             if (input_size < opt_offset + sizeof(opthdr)) {
                 return false;
-- 
2.41.0


