Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E354D791B51
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:16:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDU-0004vj-FP; Mon, 04 Sep 2023 12:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDS-0004pi-4X
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:18 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDP-0007jL-Pa
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:17 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9a5e37a39ecso222712566b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844054; x=1694448854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqyVChgV4Vj161YIUXKzjrwgE8pMJ/b2rFt1vVL3b7M=;
 b=pCCsATJL3H4tkq+4Dj3YzwlVBYwfaHMhjpDGU42h4wEOkXFBs8nKP9JzF8eCX+waEM
 ljqfe56qr+rCQDnsBKAsjWLMR/u9OnzxEOyFAwxYG82/GbOq8megdNkrd3AoRp6TGjZg
 H12hiFwxGywlB2+trbsCKDmwRr5DEdM/T0g3MhYnGB2M1azBa2XxNjenOW3Wd3kyvd/f
 d/05fICYAUPyHyx1jpZZMPHiToJUHpCyOglYdzWAWsgbBzA1K8u2xDEH83FhU8rjYbPX
 0BVC8I9L9IIFjYSySHloBxpZIBqv6M4YMsoW/p5YYpZVjsub12NCj35SiJwXr2nw4iq/
 7QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844054; x=1694448854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqyVChgV4Vj161YIUXKzjrwgE8pMJ/b2rFt1vVL3b7M=;
 b=jpRmZkSN7sZ0as8p9j1mHrniZ11siHqR1ENwQOJFXOAnSydg5ych52SlHrgLXFbR4D
 N1vK5bZfsiqgNmR06moWqFCdw0znREoZDsQlnIhJdF9ozaPSooke0Gxi65cuFNN8cjBn
 ziqlUlU79Fa/pWJ63KqbNuQHDQAy45BkP8DcwNSSAk7FdCWiPv+yQ2R0jK704p9FCpL5
 C2A0JSetwx0iFzXExv5uL+QUWi7wr0kHLPtS8zjUyHLYKppIBhheci78aTM5oXauR4mV
 9WJC/U8PgmkiZJk9SP51RM8+wp/HAwdN3S8hVIa5QoRmRirfLnZ18+SxsgGvlpv5WDRD
 vgdA==
X-Gm-Message-State: AOJu0Yx+HiVqb+jkwHDVClLhATESjTHAI6COBGlA9ISC68NiTTsnLlXG
 wr6EppwqCB1tr/J8LF4e6e3D7Q==
X-Google-Smtp-Source: AGHT+IEtI93n0+LO4ipS7jujxWbzWQJp1S61r0NEJ7yE2SZZNfFMfAB6hk3FkNbvcutR2DdNBtF5iw==
X-Received: by 2002:a17:906:1daa:b0:9a6:5696:3879 with SMTP id
 u10-20020a1709061daa00b009a656963879mr1888248ejh.65.1693844054414; 
 Mon, 04 Sep 2023 09:14:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 p27-20020a17090635db00b00991d54db2acsm6338492ejb.44.2023.09.04.09.14.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:14:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: [PATCH v2 17/22] util/vhost-user-server: Clean up local variable
 shadowing
Date: Mon,  4 Sep 2023 18:12:29 +0200
Message-ID: <20230904161235.84651-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Fix:

  util/vhost-user-server.c: In function ‘set_watch’:
  util/vhost-user-server.c:274:20: warning: declaration of ‘vu_fd_watch’ shadows a previous local [-Wshadow=compatible-local]
    274 |         VuFdWatch *vu_fd_watch = g_new0(VuFdWatch, 1);
        |                    ^~~~~~~~~~~
  util/vhost-user-server.c:271:16: note: shadowed declaration is here
    271 |     VuFdWatch *vu_fd_watch = find_vu_fd_watch(server, fd);
        |                ^~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/vhost-user-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index cd17fb5326..5073f775ed 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -271,7 +271,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt,
     VuFdWatch *vu_fd_watch = find_vu_fd_watch(server, fd);
 
     if (!vu_fd_watch) {
-        VuFdWatch *vu_fd_watch = g_new0(VuFdWatch, 1);
+        vu_fd_watch = g_new0(VuFdWatch, 1);
 
         QTAILQ_INSERT_TAIL(&server->vu_fd_watches, vu_fd_watch, next);
 
-- 
2.41.0


