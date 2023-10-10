Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D37BFA5D
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBGy-0000IP-Rh; Tue, 10 Oct 2023 07:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGv-0000Bp-B8
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:33 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGt-00078K-Mo
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:33 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b275afb6abso1450779266b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696938689; x=1697543489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxNNJ0+CbtGu/FtriJHh3KhiymL+ByyxtOGep+z6Z6E=;
 b=Cll0BMjaaF+NkJ4dA1sOKeOd6F7VATNi+FbkbuxmL0kCcNHdjWk1n69rpjlQqNQLEp
 tSVrQFuBtM8cWhHEaJ5abF1HiUp+mn+VrT3ygqydR92if9vcMwaFeE2RXdn2cBzd3T7y
 S3vAbKNSz3mJB29D70TpcYl5f1WIAutKHRab5GwYxXGOHT5+KljcwGEG9C780XQZoDnV
 me8pjRyxYDhpotL2k4g2173xTLrpwgt+V9HFU3OOOWsF1V7ssGqVi3TW4IyzOkF3d8MP
 IkggRsS7A9otiFc6g4UCa8AqMa9ZkMSrb19khFD47/jz/ePWQnFMM8D9eBFSGcu6cRBe
 mT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696938689; x=1697543489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxNNJ0+CbtGu/FtriJHh3KhiymL+ByyxtOGep+z6Z6E=;
 b=Vyh6hOZ1lagRgdFlTCwNd6vCU9c92We3XEzNBAigTAtpjOnPlWCfMDSu/e4jsGMXMR
 eKvpT2baix/mWPgu43O2iM69ZotkJc4OG0hOUjyPU9Sc8l2yGPqkbyvqf4W9GAlCEDxE
 JuFsZ45IndJ5wW3gkw6smUFtXlXqKE7E39cpPwt+EUPKTkrDGwZ7d4lNb2umQI7Q31YI
 o/lCfDf4kG8Tdio/lJeaxPPxU8spyG4eFjtXNZNrywyKg478Oeq+Ke1kvbWePxXe4qBp
 NDfZr3beLLOKz3b4/UP3HaBG6+PPMpLOrZmfXb/XE6JW3LbdomRvJ5NV6D25SmEGTBgC
 hp0w==
X-Gm-Message-State: AOJu0YwmBgglJfdrPolHSAKiWf90IrVjpWtKYuLv5HEusvdHuz5nIQZl
 kFqTOBm9PhkLPEMLY2cSxH8is+b3aBNY6MiLt9hONw==
X-Google-Smtp-Source: AGHT+IEVdSBWWIbZq1bBcW+eJaOYv5yqnrsI4Jai3K1wkB1jyVLqefcRcaBANC0uMdj4M02PkvpafQ==
X-Received: by 2002:a17:906:fe08:b0:9a1:e0b1:e919 with SMTP id
 wy8-20020a170906fe0800b009a1e0b1e919mr13143233ejb.4.1696938689797; 
 Tue, 10 Oct 2023 04:51:29 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 p26-20020a1709060dda00b009b2cc87b8c3sm8256010eji.52.2023.10.10.04.51.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 04:51:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 6/6] hw/s390x: Clean up global variable shadowing in
 quiesce_powerdown_req()
Date: Tue, 10 Oct 2023 13:50:48 +0200
Message-ID: <20231010115048.11856-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010115048.11856-1-philmd@linaro.org>
References: <20231010115048.11856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


