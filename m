Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5AE7737D7
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTECn-0006J0-IQ; Tue, 08 Aug 2023 00:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECk-0006Fd-8t; Tue, 08 Aug 2023 00:20:22 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTECi-0007Ol-Qv; Tue, 08 Aug 2023 00:20:21 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686d8c8fc65so3583747b3a.0; 
 Mon, 07 Aug 2023 21:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468419; x=1692073219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NkBpMBe9n8g61NkrM9I4iqzckfo5RUNpu9gQwNEYYs=;
 b=AuKP4fNMZw9PdNYpsMNWfJVw5sP0EH/YDQ0KFIfhJfUyj5QGj3sWCG/cql0ahMpAJZ
 lYJj+SexriE1hvxBZpwa1ejiDKMsKPWjktGooLb/BTwCHCdSnSvgovtCNMyAKe9R6VZC
 rTPQNbDnPl0YnVoIQ25YVe0+49NrOWREDVM7EB3D5u4yJk9Gw6wyMnI1xeDcS6bnnhTO
 G4YHQHbs+tFekYAE7QZnSTinp5fPCyV8pdcHkapIzqUNEDDSZTL5nwK4ZR6fyc2Ohsu2
 QhXUnSE/TVp/Mw7bUqZ82EglpALzkP1Nik2VJEaHNeje1seczR1MuZa1gLD4vQzqgyGR
 Sl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468419; x=1692073219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NkBpMBe9n8g61NkrM9I4iqzckfo5RUNpu9gQwNEYYs=;
 b=VNpPzyZF9fNkkfFQAxiGivI9d15eXHZYN340XyR2CN3l4ogKVZ/EksRCOYE6iKJFNR
 dktBfNSrZ2OqRH1v01DzRUFYahmC0GVlPu+6I1o8fy3MekxREJubTb5L6sA7vBQ8Nloc
 PUt39G4E6bG6nb0Sfud+Oy/FCvfR/rmKceBJW7uuT7eN5osgt9U1gcQt04911+384MTV
 okmkjc9mha6U+Yz7evPeSrxWt6We+uJuri+RmzxZR4UOoWBIz72613Aflne5bc2sQxoR
 mZyYz5JcXh3aQ4c7l+DVUdxZHJ5PDK1DsbXeJbLTQyReFWp4WbA7Tmp0A+HB1OE4f1wO
 +DbA==
X-Gm-Message-State: AOJu0Yz8MsOu4oq8IxaC4kDIxfzbbumXrMF01XCi2adoq4GSvbL3JP2c
 M8d8wv2JdfMTansWDt/BpBQ=
X-Google-Smtp-Source: AGHT+IGeCsKU8suknRBw1yuVyzr4F+D0xLM3/kNAKSyBcv94R5PRAzqSSTaWWpB2BPxr8z+Fi/X19A==
X-Received: by 2002:a05:6a20:8428:b0:13e:e450:f4c9 with SMTP id
 c40-20020a056a20842800b0013ee450f4c9mr12577530pzd.44.1691468419140; 
 Mon, 07 Aug 2023 21:20:19 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v2 02/19] ppc/vof: Fix missed fields in VOF cleanup
Date: Tue,  8 Aug 2023 14:19:44 +1000
Message-Id: <20230808042001.411094-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Failing to reset the of_instance_last makes ihandle allocation continue
to increase, which causes record-replay replay fail to match the
recorded trace.

Not resetting claimed_base makes VOF eventually run out of memory after
some resets.

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Fixes: fc8c745d501 ("spapr: Implement Open Firmware client interface")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/vof.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 18c3f92317..e3b430a81f 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -1024,6 +1024,8 @@ void vof_cleanup(Vof *vof)
     }
     vof->claimed = NULL;
     vof->of_instances = NULL;
+    vof->of_instance_last = 0;
+    vof->claimed_base = 0;
 }
 
 void vof_build_dt(void *fdt, Vof *vof)
-- 
2.40.1


