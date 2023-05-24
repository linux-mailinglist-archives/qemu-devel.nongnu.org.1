Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A570F320
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kx4-00071u-A0; Wed, 24 May 2023 05:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kx1-0006tN-U5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwz-0006sr-G7
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f603d4bc5bso8702035e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921111; x=1687513111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sD8LkN6PYocK+4LFobiH3Rbgv5aMaPCfkIOTcADWQcM=;
 b=t5ZS5eHH7Za4n9Bz14C1Zm4CppR4RqeHROlfglbpyICimhk6WaMmXbjJo10duj+nXA
 3wN1DafWuiueCU5T59SQG4DDMuzjw2/MAqDO/fRIVr5cbQ9Gge9P5prg0dZyIDsna8AZ
 oSZSHyqX10vODrzBcoDKgggcnum5jpBNtuGlA1RDKn86DDt3jlwJpGzjON+fXq/e/ZO0
 8uYzHuyHKzlS+B4Tg30TcMUOhL+NPV+SCWVRAnG4DDKJ7PTyUSt0G1/T/KwEqNI6DyMw
 rlN2oW120/Y9VbujjsxT9iAPmIbLnIfQVK1jf5q1H7pMNQUj36I3wWltInZX5KDwHPOS
 fsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921111; x=1687513111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sD8LkN6PYocK+4LFobiH3Rbgv5aMaPCfkIOTcADWQcM=;
 b=TSf+R3tNSNxywEst3OmMzvnv24IAc2xC+FwYH7V35fy6S928cojNaSzJEwopysGxDE
 GDixDQs9bDm3mFmqsk3SOuEcAhzJTXjsX2o5fqU5JpmM6XYb2qErajtYklx5Opk8nLS6
 1P7LWumCXwwPX/iTrxuhAhjg84ta9xg0r5L3fRE/FrDo1HRejw/r17ZJnQ/4rXYeqXro
 9f0RkOKFRnbLmWJScB0HxfwzZ3U+/IiBOM5kcGmEGbncUFtpzSJgj+wgHz9MLHCCUq6V
 NYBiMGezobXSmWxWLdy98IqJ2P5iyDjbcyl4NO7caCW6wrvEXJnMQbjcmVT8rT/KA44n
 kxag==
X-Gm-Message-State: AC+VfDzxg1SiflDTnmZ5dHSfB6q4d4OVDCM2bfIVMPvkPizdtG0SooMd
 t43iIzd6RNX9kugqhW5gPp2PjuLNX5O/wxfCiZtgbg==
X-Google-Smtp-Source: ACHHUZ6TBRoEpUcZdsCb3+afqZEto6OBOPDZjVRhqXM21djblChTBXV4PKd+gWdR3x8iES/37Rm9zg==
X-Received: by 2002:a05:600c:3655:b0:3f3:f7f0:2203 with SMTP id
 y21-20020a05600c365500b003f3f7f02203mr11925911wmq.12.1684921111471; 
 Wed, 24 May 2023 02:38:31 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a1c7905000000b003f4289b18a7sm1753181wme.5.2023.05.24.02.38.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:38:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 06/10] hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
Date: Wed, 24 May 2023 11:37:40 +0200
Message-Id: <20230524093744.88442-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Avoid accessing RAMBlock internals, use the provided
qemu_ram_get_fd() getter to get the file descriptor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/virtio-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 538b695c29..74e63bd47a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -135,7 +135,7 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
      * anonymous RAM. In any other case, reading unplugged *can* populate a
      * fresh page, consuming actual memory.
      */
-    return !qemu_ram_is_shared(rb) && rb->fd < 0 &&
+    return !qemu_ram_is_shared(rb) && qemu_ram_get_fd(rb) < 0 &&
            qemu_ram_pagesize(rb) == qemu_real_host_page_size();
 }
 #endif /* VIRTIO_MEM_HAS_LEGACY_GUESTS */
-- 
2.38.1


