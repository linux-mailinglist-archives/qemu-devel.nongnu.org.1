Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D2673E25F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlMZ-0005wZ-Uw; Mon, 26 Jun 2023 08:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLV-0002uh-3G
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLT-00036e-E3
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKvBYl51urE4Jt5rZyA5rOqZcY4rCot88Ld8XbjXNhc=;
 b=DrPbrQxHamZ0eYZrsxVbpjnuXz9voIktTY84AB3GcKm13Ayr6s8A2EUSaYwyTvkpOoLtdn
 iYMs/KI84v31ppe9FTCvwGkUz5JyfELMlhqd5Ef2oBq94PTdSltZyIibukHcgSveSW0wLX
 UgOugC2Tv6ud8Nf9OFK/TcGGz1QAzqw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-vNZs2RZtPuSv4V6GaX5b2A-1; Mon, 26 Jun 2023 08:29:22 -0400
X-MC-Unique: vNZs2RZtPuSv4V6GaX5b2A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f8757ca7c6so2523714e87.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782560; x=1690374560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKvBYl51urE4Jt5rZyA5rOqZcY4rCot88Ld8XbjXNhc=;
 b=gBrjBiDejAJjo30iCsdq2Efp95o3p8io2/j4fVhGwvIkT2jC0OcHBTx/rtPpEsEcNw
 FsgCooBp87lXGH3+bYodwLvBtX9fltQ8OEdgIGwCVO7mWpYY/pf65MEY9/df/iMcMlK5
 ahiP5A6KoZmuYJFFPlV94l93d1V6p6/dloPCr6DNaabGvWoffLz0iyf7LyUYA3EDmk/Y
 v1e7Lv5LRUTWWY1OsBpC3q46GUKsfBEBrKYwxLvmL7Ht50S6NbKAgn4bd5eFULl2U0wY
 Ia6pHGMnsViNlHiydzw0q39medsdttGVACJkoPxk0LzysjtPempPvL8AcEpofe+Ib4si
 6V9A==
X-Gm-Message-State: AC+VfDx0Qs7PwuUrqnO3FLMMMT0BVnD1j/lG0zwhk6TbmfC6Wdx873ZA
 X9lpczMkc/e73DQf77iHs1tzqceFh07YxGJdFq2F1Pkk1XmWPWJwAJbPfSGSkp77sds/1M8h/r1
 Ys/4N+vbG46zQ1PyRYIgeQAGV62GctDO4chaRHhQ6GH2/OxZIhsAZ8tAIIykYxmVMPoxk
X-Received: by 2002:a19:f201:0:b0:4f7:42de:3a8f with SMTP id
 q1-20020a19f201000000b004f742de3a8fmr15213748lfh.56.1687782560120; 
 Mon, 26 Jun 2023 05:29:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5u8ibGwdlGts4s5tEUNGfJyMIPLrYbofF3G8vJfo3oIK+wpX1pk+awYS7fsmTh5RJEvligGQ==
X-Received: by 2002:a19:f201:0:b0:4f7:42de:3a8f with SMTP id
 q1-20020a19f201000000b004f742de3a8fmr15213725lfh.56.1687782559197; 
 Mon, 26 Jun 2023 05:29:19 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 m21-20020a7bca55000000b003f4248dcfcbsm10495757wml.30.2023.06.26.05.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:18 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 zhenwei pi <pizhenwei@bytedance.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 29/53] cryptodev: fix memory leak during stats query
Message-ID: <a1f85cff902f3260d85c74ec11d4c4b182cead80.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: zhenwei pi <pizhenwei@bytedance.com>

object_get_canonical_path already returns newly allocated memory, this
means no additional g_strdup required. Remove g_strdup to avoid memory
leak.

Fixes: Coverity CID 1508074
Fixes: f2b901098 ("cryptodev: Support query-stats QMP command")
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230503115437.262469-1-pizhenwei@bytedance.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 backends/cryptodev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 94ca393cee..7d29517843 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -522,7 +522,7 @@ static int cryptodev_backend_stats_query(Object *obj, void *data)
 
     entry = g_new0(StatsResult, 1);
     entry->provider = STATS_PROVIDER_CRYPTODEV;
-    entry->qom_path = g_strdup(object_get_canonical_path(obj));
+    entry->qom_path = object_get_canonical_path(obj);
     entry->stats = stats_list;
     QAPI_LIST_PREPEND(*stats_results, entry);
 
-- 
MST


