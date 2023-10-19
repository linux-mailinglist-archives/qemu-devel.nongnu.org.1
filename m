Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136987D0405
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaTj-0004tN-QF; Thu, 19 Oct 2023 17:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTh-0004pK-At
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTe-0000zx-BV
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so1209495e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750564; x=1698355364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLXDjIaupUgxBWcovEKwWLwxqxZJkA8MyfX0vWTG4sA=;
 b=W8U7RJuTBni/24xwk1KWFZewMYeqdu+ljkZwRE1xMT13ZEYtDyf2R6scLDNQolluJk
 DO7/UjtwIlHlVNKXDVMYwOvRlOihpqS3tAULP+T3/UbrTPajAq9NBekhdT83/q6PP84A
 FS5V1Ni6VPL0UbutS0heUsAvDqCHrgFbw7RwYm/+iyb2F9DbelyuqNIhMOsBXBvw+Q/m
 iodD7jqR+ThqAf3VeyOCNtlNYnjCA3JuN0fxUe/EsMkxJuimDxWpIHSqFh8roWMyqhOh
 gZT699fUZ8XppmfDyjYBudioNrWEu6xln25nfLrA59X6l/1Yt31wV865fHwLqAcuF3rq
 DeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750564; x=1698355364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLXDjIaupUgxBWcovEKwWLwxqxZJkA8MyfX0vWTG4sA=;
 b=TPn+7kERj5tj2rLswtGHFddAJ2iDG44ZK3q8isvbZDb1Bi9Alk5b4jC0PS0cYDmNpb
 UoEUJO/MfurePJ7xHLSXQ2VZmFfbSh/Km8TE05+xM49yEq5kWUx9CHT08/J5jsEqRuyg
 pek2ILKd4g4sHqlUbtdGvwMnGKlVpiu+VHtutlnd75eeM7KcbcQJKFJbiXkYp0O0wcxn
 0ekTuF5Bosh+omf/fAiNUG2tIlvFyDNpxS3MtjVO2+0F2vj/IaazSa6KoNxbdYx0Jvzg
 A/DK0pFyIggmCH0eMh8HPuM406pydfChJTvD71uZYcC2XA0DB3NOU2HJJDS6izSZI104
 nvuQ==
X-Gm-Message-State: AOJu0YwH80m7RGblW4Q2i69v8ULkrmNbPwsJHfqZ9LVUWALEeznBCVpY
 OssM3HBEmDEKbHbBAKT8rsGhB3f6E/MSlJC56T5r5A==
X-Google-Smtp-Source: AGHT+IEOcJK8dKggDrYSN1/CBfodHlzJxxz8DarzN8l9LegkAmP9LiYVmpOy3zYulExt8SgbwAZkPw==
X-Received: by 2002:a05:600c:15c1:b0:3fc:dd9:91fd with SMTP id
 v1-20020a05600c15c100b003fc0dd991fdmr46703wmf.40.1697750564618; 
 Thu, 19 Oct 2023 14:22:44 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a5d452d000000b0032d8eecf901sm233470wra.3.2023.10.19.14.22.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 40/46] hw/virtio/virtio-pmem: Replace impossible check by
 assertion
Date: Thu, 19 Oct 2023 23:18:05 +0200
Message-ID: <20231019211814.30576-41-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The get_memory_region() handler is used when (un)plugging the
device, which can only occur *after* it is realized.

virtio_pmem_realize() ensure the instance can not be realized
without 'memdev'. Remove the superfluous check, replacing it
by an assertion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231017140150.44995-2-philmd@linaro.org>
---
 hw/virtio/virtio-pmem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index c3512c2dae..cc24812d2e 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -147,10 +147,7 @@ static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
 static MemoryRegion *virtio_pmem_get_memory_region(VirtIOPMEM *pmem,
                                                    Error **errp)
 {
-    if (!pmem->memdev) {
-        error_setg(errp, "'%s' property must be set", VIRTIO_PMEM_MEMDEV_PROP);
-        return NULL;
-    }
+    assert(pmem->memdev);
 
     return &pmem->memdev->mr;
 }
-- 
2.41.0


