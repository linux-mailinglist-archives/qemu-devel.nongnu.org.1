Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A687BD799
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmtC-000332-Nd; Mon, 09 Oct 2023 05:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmsL-000246-A1
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:36 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmsI-00060a-Fb
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:32 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so7426948a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696844908; x=1697449708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMMxlES9nAQ+sONyZQnmh1EZ23km32jDSkIWikw2cps=;
 b=UEEaVzD07CeGQ7jVjLoP2R9Tg/6ON/l5f4TGcenBCSbzShSkbqD4FGANhF5LmRlvl+
 hVRzZXPr71BqvZoojL7dS+AktUMZc1fxsXY2pp4/JuHZOjIiDVdzK2UNbV2FFl3bHi8y
 4hooNcQuByZDSvgzkt6GFKYW4lvOxJ4XIBuFPVJ+ydh/0vivtfsmpMI4d09PzXKcaMaI
 nOFiFJTT7BetbSkdwycsWcpSY+gUjUiCBikWdGTn8wpGpzUFQcPd634RX/P6Vfo6qWvh
 8dNFwe70lqZrqmjgH9JTkMxqT/Luu6a3PYWkP+oAkZDOhVtP48/DDWmQMuXmXJ1acg/9
 1fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844908; x=1697449708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMMxlES9nAQ+sONyZQnmh1EZ23km32jDSkIWikw2cps=;
 b=dPLUdkP1znb5m/Eu5ZQTzcYZN3kCfzynfNM5VmrAL0QwxJae7ag+Mpv9Df4HcMZDn4
 X5zupUHvO1tNCe2Uz9kwbjr0uVgXNwy9vYA6/8qW4n1kXeugKJwVrpBK+LRhTHpYwlLe
 dw61xtinrvZu4krFVg29T7IAiulCi7TB8qFUZFKcXMxCbM8tsRilNAswLdRpjWh9nLEn
 WXLCTNbziYiD/dOZCh5i9J7iWRV8Y7C1GSKluDV/NyZk12E7eJrbujkZJYNQPu9n/o90
 c0y7H5vNgyQhGtzlOrHERe3kAdRRj6tgLn2SkXrAXGRxtIsk09UV3vSQNC4SJ3eUUNQ7
 YuSA==
X-Gm-Message-State: AOJu0YyJd9Fg1lauGow/aIXvXbPnY7p0nfOyYcLxUUblczagqBn2aCN5
 oqz4HkFPQK4A/QfHai1Pf8xG0pO0oDv6vxt6ueg=
X-Google-Smtp-Source: AGHT+IGvydoVoxast+lAgpjHngYlJ65W9UyuHqYUyeDyD0jCm4FT0MIYOwjFiQeq7dEB5qQ+NeDCHQ==
X-Received: by 2002:a05:6402:1b0b:b0:527:3a95:5bea with SMTP id
 by11-20020a0564021b0b00b005273a955beamr12741105edb.32.1696844908700; 
 Mon, 09 Oct 2023 02:48:28 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 d5-20020aa7ce05000000b005346a263bb1sm5831257edv.63.2023.10.09.02.48.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:48:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 6/6] hw/s390x: Clean up global variable shadowing in
 quiesce_powerdown_req()
Date: Mon,  9 Oct 2023 11:47:46 +0200
Message-ID: <20231009094747.54240-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009094747.54240-1-philmd@linaro.org>
References: <20231009094747.54240-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

  hw/s390x/sclpquiesce.c:90:22: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      QuiesceNotifier *qn = container_of(n, QuiesceNotifier, notifier);
                       ^
  hw/s390x/sclpquiesce.c:86:3: note: previous declaration is here
  } qn;
    ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/sclpquiesce.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index ce07b16884..a641089929 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -78,12 +78,10 @@ static const VMStateDescription vmstate_sclpquiesce = {
      }
 };
 
-typedef struct QuiesceNotifier QuiesceNotifier;
-
-static struct QuiesceNotifier {
+typedef struct QuiesceNotifier {
     Notifier notifier;
     SCLPEvent *event;
-} qn;
+} QuiesceNotifier;
 
 static void quiesce_powerdown_req(Notifier *n, void *opaque)
 {
@@ -97,6 +95,8 @@ static void quiesce_powerdown_req(Notifier *n, void *opaque)
 
 static int quiesce_init(SCLPEvent *event)
 {
+    static QuiesceNotifier qn;
+
     qn.notifier.notify = quiesce_powerdown_req;
     qn.event = event;
 
-- 
2.41.0


