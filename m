Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E717AB4F9
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:43:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIj-0008LT-Ud; Fri, 22 Sep 2023 11:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIi-0008KN-0c
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIg-0002nn-F0
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXr0dDzaioo9uY5bLIe7ScF/gjUT2yjP9YjbogdmloQ=;
 b=gE4EMh9MWA/LGdam27TNhwgheAKaoivdrGpgH6k20yR9DFICIwDWqJLKgOyqCDmRGl3WRu
 l9uvEXPugk0nqOybi53GaGvH8ga4k6mElGwjHnA3pP5Q+DotN9eWkNbEChQkemx0NQ7oAe
 hvOraAL5woknS0NMVhhpSbtj/d+DeNw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-ndXJE3MMNv-JM6aJe62ryw-1; Fri, 22 Sep 2023 11:42:36 -0400
X-MC-Unique: ndXJE3MMNv-JM6aJe62ryw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32153a4533eso1540614f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397354; x=1696002154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXr0dDzaioo9uY5bLIe7ScF/gjUT2yjP9YjbogdmloQ=;
 b=Jyd0n05LmJN6DZtaCdzfN1N9y0PK/uojWcSvZPluxx/RQ46wgoT/twtr/Z8BlpBkoA
 I3RKdBWLYx2ryHMArjmc61B9m3SFBUpPt7AzXKovE3X7oJQrnwKHkW2phcr7qsKXJkCg
 iET2CHzD+G2tZs+nmBdl2RbduhHSrEew9aU+UTItg+AyKTVcK/v9T1qhrtJ4+ZQ6f+Nh
 xT7ln5QnsTuRe1ubKjlJIQAlYmDjzIZrsKict1AwM1Z+yD9rI0U9yzCyPGYiYb1LoJCd
 pOOtmbJtxA1UeQDAj2cG+yux2YEIUMhCVZD/2+CCHpbGaye3ecdjwfMBrb4ReJzNM7cZ
 W2FQ==
X-Gm-Message-State: AOJu0YzDXdnJzspiDrZbYR80kjKr+2VpLO2OeHFecCUt+Jiy++U4j0Xi
 a0UdzvqJgV2/V0r9PtDDhV/9iLLnbN7mlVdiXwpBBPTvc4i8/A+tTMv8+PN3uH27bZtdduZkQTs
 aAcStBr6Ac5xBhj8W6v87hfoG+fgzfCPC0YsPi3z44EThjSRytkYZEbEGMfoNx89LiDR8yhQ15X
 Q=
X-Received: by 2002:adf:e78a:0:b0:319:7bec:4f31 with SMTP id
 n10-20020adfe78a000000b003197bec4f31mr63270wrm.10.1695397354720; 
 Fri, 22 Sep 2023 08:42:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElUq3wsuglnbZZwXXz0TjE7gjDmHqopvrpvIVthbnJ0D663NnFECJl00yKI96ph/EUnXTeyw==
X-Received: by 2002:adf:e78a:0:b0:319:7bec:4f31 with SMTP id
 n10-20020adfe78a000000b003197bec4f31mr63244wrm.10.1695397354238; 
 Fri, 22 Sep 2023 08:42:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a056000010b00b0031c52e81490sm4763698wrx.72.2023.09.22.08.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: [PULL 2/9] target/i386: Export GDS_NO bit to guests
Date: Fri, 22 Sep 2023 17:42:21 +0200
Message-ID: <20230922154228.304933-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
References: <20230922154228.304933-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Gather Data Sampling (GDS) is a side-channel attack using Gather
instructions. Some Intel processors will set ARCH_CAP_GDS_NO bit in
MSR IA32_ARCH_CAPABILITIES to report that they are not vulnerable to
GDS.

Make this bit available to guests.

Closes: https://lore.kernel.org/qemu-devel/CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com/
Reported-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Tested-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Message-ID: <fde42d81ce454477ca8e27d5429a190b7366fe86.1692074650.git.pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d48607b4e1e..f9e51a9d87e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1155,7 +1155,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "pbrsb-no", NULL, NULL, NULL,
+            "pbrsb-no", NULL, "gds-no", NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr = {
-- 
2.41.0


