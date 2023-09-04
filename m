Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD61791B5F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDL-000498-Qt; Mon, 04 Sep 2023 12:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDI-0003tF-B9
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:08 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDE-0007gz-Fp
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:07 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso235630666b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844043; x=1694448843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGuryJTSyoRXnerBPgJM/pgbtWE/XseVwBkj0AvKIlk=;
 b=OCkTZhp+xySDAelll8iDajpzKieCmyBn+f+MwFFAxDyuvalX+IeUHRS80a+dwKlzd8
 J81sJnjEWByMdvS6ZWW05ZP2hmcxcgHB8T6YG9SfRDWMfUFSQ/VOAjKrkoDHlhHgZbaE
 /ccJ8wugRbePMIySRQm4vUaYmZb+mJJvYPBpkYUayIMSeWYALVWVaTK0oh1+biqZUmGn
 pKs66ALKLkyeGkYBfiT8ao7jxIWV9rq5TNnEuwrQ2kLsLEEgVP1uEnRX2jzL5bMctJpz
 MN8CoV0VyOAq6GnNsXoKBfOt82VzIWl/EJaAKWfMCCEEqNizLdSrc/KgWJo0YU88SSlk
 UV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844043; x=1694448843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGuryJTSyoRXnerBPgJM/pgbtWE/XseVwBkj0AvKIlk=;
 b=SHI/BxP7nmBahYjoC4S57eAXD8yoyTlpwqJyjtphhaoZD6zYEQwF62R79WlLbhzhhq
 MqkI/JUc4CPpA+aZpbMZCjQeJkq0S2zyYx+Jq9kKCNAKNa1kB1HIVGdldLWANYLN960e
 zETs85pMlgF9WN8nIdEAVa5LimfUo/bIivrx5tHgtpksRR16Iv4UV8D4mkkbbghnWGij
 pbJS39KlOuiEKLVxPXhACuPraYVNOd1UIRvMomOXHSOctto2HMMG/B9MDqUMVcLLd2Ub
 Zoav05fmB+xRM5t4CIm6iUu7AnfTWSnTBpZkFH4yBV22nvD/BsbLdnLGY2MNtnH561IM
 3N/g==
X-Gm-Message-State: AOJu0YyDPY8w5iC2nfxfWdvg4mp3WX40RgwZj3EbpenARLlDFYZmgjgR
 JVfjrPgn1d7eq04ZQMa7xAAPKw==
X-Google-Smtp-Source: AGHT+IFctjktCRn66SKh+ArcqSx2+yDmhg22Mo3p9kX6yePcrzEtl9cKsGvgyhI7eWXZ9lzfbkkXyQ==
X-Received: by 2002:a17:906:8a41:b0:9a5:d657:47e5 with SMTP id
 gx1-20020a1709068a4100b009a5d65747e5mr7429251ejc.49.1693844043140; 
 Mon, 04 Sep 2023 09:14:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a1709067f8f00b009934855d8f1sm6371229ejr.34.2023.09.04.09.14.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:14:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 15/22] net/eth: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:27 +0200
Message-ID: <20230904161235.84651-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
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

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/eth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 649e66bb1f..3f680cc033 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -432,8 +432,6 @@ _eth_get_rss_ex_src_addr(const struct iovec *pkt, int pkt_frags,
         }
 
         if (opthdr.type == IP6_OPT_HOME) {
-            size_t input_size = iov_size(pkt, pkt_frags);
-
             if (input_size < opt_offset + sizeof(opthdr)) {
                 return false;
             }
-- 
2.41.0


