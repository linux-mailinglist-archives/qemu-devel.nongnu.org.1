Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B05370D18C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:45:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1R-0004Op-Fb; Mon, 22 May 2023 22:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1B-0003tn-BU
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:58 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I19-0004Bc-Pk
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:57 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-25275edf6caso3085474a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809894; x=1687401894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lPHc0Jv1dItKRVtmSHw1HkrDI8da/P/hu7YgBVFsJk=;
 b=dNl3d6vjrW99FxZnwvJG9hv717abngzu7RX7vN+76/7voGxQ9FbxsNrT7AckI07MKm
 GSVqz9bparN87oF5DarvakQVA5QO3cxdUuh5Ad/zi9c6UxrMswZneoajxgIzfGTBLtUv
 3UoDGu7SD0ncb3YD9NqcWaLPNbZT04LmBebi1UbwaVsvjbkc9DKr7h6hpROMEncckgb5
 JQepFiLYVr1u+SaAPHUpAemt1Mk261FcZU9RoNjnmvZN6+atKdpejo3HapJ+3KBlvosC
 4UUKGSi1ZWWlc84gunk2Eb1hLlarEIT9XasZB0dYOJZgW7tnrYACpXdRl25zbWNqKi9k
 u1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809894; x=1687401894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lPHc0Jv1dItKRVtmSHw1HkrDI8da/P/hu7YgBVFsJk=;
 b=F/ToeEzFLmL9xCT467F+0nmKvOLQsIVZZotyJTyxK3R/CtMObINnkrQQq5vAlsHrL+
 jzOd3OajOGBlXLqMO1wavqokWK0vYB4f9x0POlgE1KEOfCvFGQ81EK+WXPR6+6CWxg17
 4btJAq3NRn+JuRcKW1c/4vpTLfIuqBQY1g0y9/AuEJw+AKZkHUtOqXg9NJtVw0h9Cn8t
 5/EB7qK2eo4lBTPNiD64tajtP7bU9/FH4SqiV1XT9rJ1Vov9YwrfdhomiFcklp1vO+wt
 yeSiySJZSqQ0J4R+BbYKMu25ANeDpOG3q/gKy3GrW8y5HPmeehzWaLlvEhMmUmcM+fFY
 +ylQ==
X-Gm-Message-State: AC+VfDzeTZnQ8a3/cDiAANjN0/EL8ahfKbbPjMbA5thA0aWxjPiIARzI
 qgWxyz7MO8Xc/ymZAX/EeaaAAg==
X-Google-Smtp-Source: ACHHUZ56ff+Ix4T9/7UTlrEYhRwqL7tlNPb3MaKyjMY92e0U+Ye1jL/El/fJjVDbhsTCs7/MEMPekQ==
X-Received: by 2002:a17:90a:6d47:b0:24e:3752:194f with SMTP id
 z65-20020a17090a6d4700b0024e3752194fmr17156537pjj.21.1684809894512; 
 Mon, 22 May 2023 19:44:54 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:54 -0700 (PDT)
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
Subject: [PATCH v5 18/48] e1000e: Always log status after building rx metadata
Date: Tue, 23 May 2023 11:43:09 +0900
Message-Id: <20230523024339.50875-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
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
 hw/net/e1000e_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 38d465a203..6a213c0224 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1244,9 +1244,8 @@ e1000e_build_rx_metadata(E1000ECore *core,
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


