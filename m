Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB570D3AD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1LGI-00006n-5O; Tue, 23 May 2023 02:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LFr-0008UZ-Dz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:12:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LFp-0005GF-QU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:12:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f606a80d34so10522635e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684822336; x=1687414336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvgfSp3TjhqQzTM2G/fo+fd/Hd3siY9cL5SrH7t8cjY=;
 b=WbcZ09sUjG+37IQGon9H7EIfRkiDXXksdz1F975KclEMNwL8LMBixytqcMxO5mo6yg
 sR4YkE/6re5LkWSj5cAzjbRxIaqqnTKKHUyWfzRpaEotNP8sN1/GaO9q8A9SwiE/5gbK
 UxpAK+jiD+GxqhjVhwqkV8uZB6voQdyhD63fTUXoi5uWvuO9juolSjw68YIHEOpWF/ZT
 6fhWAvBG2RmiGrOsXc+7jEfotwBCqUqdcUhprWQ1UKtQPhUs7qirhty/fHgfOOWsu2IN
 ShYL3OjJXAJ4uOHuEP+rOqYQkJ4FfVI7TvVKbvCkHgOxZddj0Xkgceke9nypDb+bTnCL
 MtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684822336; x=1687414336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvgfSp3TjhqQzTM2G/fo+fd/Hd3siY9cL5SrH7t8cjY=;
 b=V+kIdXpp5EVOjz9vlQslYszc1YLlR7UoIHob/QxrLgOe/kBgFyBwK0s/zqhvXUmCAl
 5DpZAUb1kE3E4GMpU1rf5xwF76/Vcy2KJTvntzH6tI3iyUjmiXvqPA57prM+M3NHyQk2
 diecPy7dVOpM3rOK55jv7uh+8L+lUald1ZBbQKKTPCQkSNHKUOrXFvfy/l5DiK7GLbCb
 swwMqLkIub0EODva3YQNiW9EOD1Ar/M4AwoK7MpgSs8LNPH2rmoOtDZPaTTw+oxKZWqT
 uJQecPsQUlK3ZF6WFmBXespaNVTrz9suGuuF403FTHcDZduE7MqWGfaXZhUn+1iUDlpW
 fjHA==
X-Gm-Message-State: AC+VfDzhbffFL9E6hSVMrw/mgW7dQ1TcziYn1ZXyvsspj1UZucvTn8A0
 rUJyMGFHD3b7z399/9/mk9YMxlu+7ZKn595xw2U=
X-Google-Smtp-Source: ACHHUZ5cE4L520E/8ZLoZGZSwjsbuoOe3RizPIcQj2NvLWRzvh882NFY0pmP0P2zvwPF2FivgEIf5Q==
X-Received: by 2002:adf:ee05:0:b0:307:a24f:c15e with SMTP id
 y5-20020adfee05000000b00307a24fc15emr8582480wrn.39.1684822336101; 
 Mon, 22 May 2023 23:12:16 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 k2-20020adfd842000000b0030647449730sm9894577wrl.74.2023.05.22.23.12.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:12:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/core/cpu: Simplify realize() using MACHINE_GET_CLASS()
 macro
Date: Tue, 23 May 2023 08:12:04 +0200
Message-Id: <20230523061207.48818-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523061207.48818-1-philmd@linaro.org>
References: <20230523061207.48818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/cpu-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 5ccc3837b6..620312e9a5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -196,8 +196,7 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
      * no need to check the ignore_memory_transaction_failures board flag.
      */
     if (object_dynamic_cast(machine, TYPE_MACHINE)) {
-        ObjectClass *oc = object_get_class(machine);
-        MachineClass *mc = MACHINE_CLASS(oc);
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
 
         if (mc) {
             cpu->ignore_memory_transaction_failures =
-- 
2.38.1


