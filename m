Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E5170D192
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:46:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1O-0004Mg-B1; Mon, 22 May 2023 22:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1E-00040E-Fr
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1D-0004DI-12
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:00 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-25332b3915bso5025765a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809898; x=1687401898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2Xk6+qjjMdGcLMNk1n1iHvDadY8txV8RKxLFqzRA+8=;
 b=5nFjYtn/uJ9YyfVl1NZ47QWO0v5HHBtPGdTWBNDm8cahhKvSAmlBUkSDNFHDTI7sBU
 3OifBMhkM1qmgd5V+snQOIzayLInFxHXwL0P0ELQuCUFBwA3HbX8L3DF1EAtO+NaIGqa
 vJ4UOPxRnlgWQe4TUQCPvQPpCZbqcmPHyo6qd+GVN1RlKNoHK+HfrrJxqPBAwhxeeS5n
 Wivvd3ASomx+cTS3PhZLEOdbjRQLjC6c2LckG7Svc5SvLkg9SgBFtfPJ0MCr1hblGfo9
 PZHBQQzoRW8Rp7ISSWxwVd6ood3+SxpT+5Zhlv7oA+Mux0loTnWcGUwd4iWSOI/gwJ1N
 gvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809898; x=1687401898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2Xk6+qjjMdGcLMNk1n1iHvDadY8txV8RKxLFqzRA+8=;
 b=KvfB29pgU+Z6sCi1YfLE2EbkAneyl/Ia8t5Nw2GBxBG81L3EntYDSbYiL3yf7K8EuM
 LTiZLX1ztBS+vL57x+cI/yVFlUZl487AdJ6TvfRs20qXsmw27Rdivl0nBLcldXqayQYc
 i9L/2isRX0pe0wLI8ZGDJ+CL+V/iuKd5dJgdDOQ9W+GV5ej5ClBaNvXP4ccNmS2tyfoJ
 jLeRCECbTt4ecMNKyttsTa8TWJWLZ/bIb1o2WHCdYsncN37I2E6jD95G/LvcuRLKDiD1
 aEshTt9eilvIgusdpsn1yPypwU0IOHsdW4FrBDZ5Js98ipMuUqSIxdUPkgOqXwVvAExm
 iSNg==
X-Gm-Message-State: AC+VfDw5WjGnAjKdnsRbvxlljUXM0lI1ove2n4XLLHcbfsNQwEdXLJW+
 yyFCydSf/XI2Gm90M9zS7s3rq4Dhx5SBHngon1w=
X-Google-Smtp-Source: ACHHUZ7DEeOD5t00yAqSJQINNegT7PNRpxYVD4oMhku42ifCGhbL8XCH9SKUT+3FH46H/okzf7TIMA==
X-Received: by 2002:a17:90a:4fe3:b0:23d:286:47d3 with SMTP id
 q90-20020a17090a4fe300b0023d028647d3mr10999644pjh.40.1684809897902; 
 Mon, 22 May 2023 19:44:57 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 19/48] igb: Always log status after building rx metadata
Date: Tue, 23 May 2023 11:43:10 +0900
Message-Id: <20230523024339.50875-20-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Without this change, the status flags may not be traced e.g. if checksum
offloading is disabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/igb_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 209fdad862..946b917f91 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1303,9 +1303,8 @@ igb_build_rx_metadata(IGBCore *core,
         trace_e1000e_rx_metadata_l4_cso_disabled();
     }
 
-    trace_e1000e_rx_metadata_status_flags(*status_flags);
-
 func_exit:
+    trace_e1000e_rx_metadata_status_flags(*status_flags);
     *status_flags = cpu_to_le32(*status_flags);
 }
 
-- 
2.40.1


