Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB5E7C80EB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:54:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqU-0008RU-5t; Fri, 13 Oct 2023 04:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq4-0007kw-GG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:08 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpz-0000tV-Qr
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:07 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so1760571f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186882; x=1697791682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4gw7XfCng/pPIYOdpD4tTHsV5X4/sDiig4GoXsUofE=;
 b=W+ZewEU88YKdIgVudjmTEowhvSMnNkXGAWVj6RTexsEWIotp/hX2fkrD2uFKANnPfs
 Hbg3ds+X6yWlHFPNUuisntUhZVvhHaf7QExMXPBbWelSd7JcqZEoyCR77597V8sDlIqK
 XlZt7t7HxSZkmAsyolrQBtdrz1RKUKWQLtk7GJmAZg0Wg+gs+YCH9kSv2PmGHM9WWZ+D
 uJLMK3C0l/nIZCkF9QlUy+PjQDlLecjlGWJMS+xx0Liv25ZWgsfPZ7FTIdZZu6wZt2ab
 OQODo6HbUQVDxoQ4MNiEWZFUqJCqQDFFkeEgFeT2czlelWSwZurXlquZPY21dDHYVOet
 bJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186882; x=1697791682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4gw7XfCng/pPIYOdpD4tTHsV5X4/sDiig4GoXsUofE=;
 b=Rh+ZHA8LpBjjoad45f58f5qOUkTR4kFCbKW8BxZCgVc4gEvnLAqhOxKWNnmqLJItQW
 EyPcBmr38XAhfNOCyDw78EQSCf9d0ly4J796dvrCZ7xWY2GGCZoe/hIUXGoYFO2MuGQE
 B1PUHDteVKVehMesnrAGki/MfJd1ycvWDYInJBQ1vZu7OPaZq+ZmA/Ns8cW56q2pjUmX
 59KjAjcUjHQuJu7iq8Met3ZoOaGnPSFzw2voQp7K8JY8fh0yLe6SAqwh6tjNCxJ5chfW
 EPYPIFulWiTFgV1P6BJISGah+/an6nnP4A0zFvTRod+KUIuyHsqAkgup8dIGrQIYVgpT
 Arxw==
X-Gm-Message-State: AOJu0Ywqy5sI61wfthH6apd5grbMk4qpZsjBMERprEyyunGsQMJTS0JP
 XxoV35fIuvW0izkWLI0OsMpN5Nn6Y7v7I2TyRcM=
X-Google-Smtp-Source: AGHT+IEXFJf0Ni/SpF/OrJbHkACjA4ir1UAWMfdXxkCy/5LGFRxHW8tHmjFthusrEkUldxpnCv7h0Q==
X-Received: by 2002:adf:e9d0:0:b0:313:e8b6:1699 with SMTP id
 l16-20020adfe9d0000000b00313e8b61699mr22615701wrn.55.1697186882278; 
 Fri, 13 Oct 2023 01:48:02 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:01 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH v3 28/78] target/avr: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:56 +0300
Message-Id: <31bde56c5db68438ddbfc2a69eadc47ca323d1f3.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/avr/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index cdffa04519..2043677745 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2773,13 +2773,13 @@ static void avr_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         }
         tcg_gen_movi_tl(cpu_pc, ctx->npc);
-        /* fall through */
+        fallthrough;
     case DISAS_LOOKUP:
         if (!force_exit) {
             tcg_gen_lookup_and_goto_ptr();
             break;
         }
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.39.2


