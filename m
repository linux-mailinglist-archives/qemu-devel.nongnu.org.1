Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B86791B9B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCRM-0001z7-OG; Mon, 04 Sep 2023 12:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCRI-0001sw-TU
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:28:37 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCRG-0002Io-LE
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:28:36 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50079d148aeso2721299e87.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844912; x=1694449712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMO9Sabs/iEDm+ChlLb7bnpjmC8D0WEcPQCXeXeTl7Y=;
 b=yD0J6cbO1z/x2ouypxEh1jeG8paBFqI4kD5dngU9ByViGXxjB2HQpu4iEVMd0kc9Ay
 TJ7zdmD4PO7W/sEF97e7TCkqG7Q9+9+RgW1gyH65aKoC5h9G2FfGvA9vAHI9pAMgXdpv
 FM4ke3VDhNauxI5E1hI3AgH0jGGRlhB6Oc/omd+Ug1Kw8mBohGi1hBMVaeEBOKu6eytS
 4oUFQALjmjWZ3DdHYZbtK6bT/kqDiIdKsQC0xgyJhEtGxrJRVaDPqnmoG7Zsfgn1jC5Q
 YIENWQCkMfhnAuWj3OgFifjxo7LBcBjYcxOJWsxXJ9Wuz1KAdaIH+EjNVfErXfN8bxB8
 8JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844912; x=1694449712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMO9Sabs/iEDm+ChlLb7bnpjmC8D0WEcPQCXeXeTl7Y=;
 b=lJdlaNZCwR1L3VLeMHO6ygtXm5t0rf+PvdDLBRGnmq5/L8vrcuY5BEgQ5dVQme40pv
 QL6/mRBm63V5LDZNFNc38B4q2BpTXdZzblpdhq+RC3jQXmp9vsc84mG+c+qrdoVbxz06
 IdPUwhnq9MUnUqE5uJm7jIEYHX7nT5jQY7azaqCD/WPfM4witrOaAJfmAIEPg6/lHbbv
 lObJb69bZd31F/DI81OU/Pj6SQHdsKoRGAbxQbWu6S/o6rnTQDW+gy7Ex3VanuIWlRq8
 l/47xsUSF0Xwaondk46ED2v0hvUMB3R8j+KMI/RLhWpDa8OwzKwIdkElbS7kyQrU2sNI
 HmiQ==
X-Gm-Message-State: AOJu0YyG2zOU7kMfSemT7QA0UdMJ+n36AazmsyE5gkl+WnYZzlquxLm5
 ojykrLKrkmh3P1qehMhYqqKS6obuCZx2hUSieMI=
X-Google-Smtp-Source: AGHT+IEVmmsaRC05juICWrXVG9uHkag4w2uehwNRiHl1+sTjNFlxeknar/ekXZhUV7EJEBmXFgrf/w==
X-Received: by 2002:a05:6512:b08:b0:4fe:279b:7603 with SMTP id
 w8-20020a0565120b0800b004fe279b7603mr8729519lfu.14.1693844912164; 
 Mon, 04 Sep 2023 09:28:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 d17-20020aa7ce11000000b00522572f323dsm6000348edv.16.2023.09.04.09.28.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:28:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 1/3] hw/core/machine: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:28:22 +0200
Message-ID: <20230904162824.85385-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904162824.85385-1-philmd@linaro.org>
References: <20230904162824.85385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

  hw/core/machine.c: In function ‘machine_initfn’:
  hw/core/machine.c:1081:17: warning: declaration of ‘obj’ shadows a parameter [-Wshadow=compatible-local]
   1081 |         Object *obj = OBJECT(ms);
        |                 ^~~
  hw/core/machine.c:1065:36: note: shadowed declaration is here
   1065 | static void machine_initfn(Object *obj)
        |                            ~~~~~~~~^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index da699cf4e1..7adc3d4e13 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1078,8 +1078,6 @@ static void machine_initfn(Object *obj)
     ms->maxram_size = mc->default_ram_size;
 
     if (mc->nvdimm_supported) {
-        Object *obj = OBJECT(ms);
-
         ms->nvdimms_state = g_new0(NVDIMMState, 1);
         object_property_add_bool(obj, "nvdimm",
                                  machine_get_nvdimm, machine_set_nvdimm);
-- 
2.41.0


