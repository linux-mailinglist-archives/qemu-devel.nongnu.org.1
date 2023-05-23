Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8470D1BD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I1V-0004ny-Oc; Mon, 22 May 2023 22:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1Q-0004g7-4O
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:12 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1I-0004Dt-EM
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:11 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-25374c9be49so4271675a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809901; x=1687401901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HE2GeNaiFNy1PaFRDOukmrWos4NXU60+F739Z574TPQ=;
 b=dREdQq8+b3M6kzijsvUqjbiWKjzeC6kc1dXzpdHggTLbPNTPaV49JyBAT/Pf1+99FS
 BquzsteyedrXC3RZSP49GXV7a2JgufZ1ziLW4H1lZpWotaozvnDKDsgMyPv/qgBAyNQk
 +YNsohN2ZRp5nq5WCcV4KXBDq8ygl4bZ3sqB9tMPg+XWQ765GSkfGx1KT4UISx+jGyb6
 uv1FQ81/PSNVcPvstCSt/HLh8uWGnk95CSgSeLW8o8ov7GNIy1y+aJELb2vyBcrFRqw4
 Hnl1rxIorLp62ejkXxVR0WAJK6VZNblZmyU5y46BaQOJALyxsLOYjdUHbP6T5PpO8qnN
 QfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809901; x=1687401901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HE2GeNaiFNy1PaFRDOukmrWos4NXU60+F739Z574TPQ=;
 b=BxN3sA9in2mBYDVbvP2gzZWxz+71W7dH/6rF0lIBhNjeqSHTJiByDMFNDXrKm9pGNn
 /TJN4s35nsRUpK5NkldOU0BpOys+WD7ImgrSJYnbyIwKiYCBuTeaQ3lmSweMRwjdqubs
 2abpHILFlVHWLX7XKf0AoP//gQi2lQouyadEf1OaVMaRPg20JdwPX2SF2a+MQE7rS96o
 X05DUxKNBeBGDUrANAH2tNHqTdN9c1Ydefabl4tEAC0TPtt2V9RRMt658rQXawU9D+sD
 pgajk4HSnIM3rmPy8kbxdzkIGaskr4617CEwLIIKxd7tE9Ob1M1fnveBC/zEvqitL1iT
 uX6w==
X-Gm-Message-State: AC+VfDw7bzQsokASlDk4HuXq1920KzXGCp12wqZmzCqQuGmGWL3lMMP4
 CN5k9SUb1oc2Shto44R+BKpgQWE4qEloZWQzySw=
X-Google-Smtp-Source: ACHHUZ5Zjl1YtaOIjxm11rPetreyEl1mjvvOvAruGOsGe6YkmlMLj/SmS9snTiolHqCMOYDq4Q8YSg==
X-Received: by 2002:a17:90a:e505:b0:255:58c4:fbae with SMTP id
 t5-20020a17090ae50500b0025558c4fbaemr5793670pjy.10.1684809901368; 
 Mon, 22 May 2023 19:45:01 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:00 -0700 (PDT)
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
Subject: [PATCH v5 20/48] igb: Remove goto
Date: Tue, 23 May 2023 11:43:11 +0900
Message-Id: <20230523024339.50875-21-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The goto is a bit confusing as it changes the control flow only if L4
protocol is not recognized. It is also different from e1000e, and
noisy when comparing e1000e and igb.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 946b917f91..bae51cbb63 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1297,7 +1297,7 @@ igb_build_rx_metadata(IGBCore *core,
             break;
 
         default:
-            goto func_exit;
+            break;
         }
     } else {
         trace_e1000e_rx_metadata_l4_cso_disabled();
-- 
2.40.1


