Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F370E1E1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Uzg-0008Up-Ij; Tue, 23 May 2023 12:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uze-0008Tt-B9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Uzc-0001a3-8G
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:36:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6094cb26eso458185e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859770; x=1687451770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/nlgPLhLbIsykS3dfTZmYeBfdaG3SqKteCE5YtDUbs=;
 b=E3OiAtLcYCc+oNau0yNrzuqvE6y6mHF+NR0VFAMvcS06mzBM5ltNJ9usCYHgJ5HrsG
 v/S4B4pQTFG9refhWhSy2P1wHvbQ2xHbVepIkqlQjnleX1LQCwavJMWy6BF9NpBlXk9u
 9b+swkqFc/mG6pdrgKeutw+kmWKFiG8mSpINufCZsEjpDQXDZAnAlgan6aQaRFexttF5
 Nb5ByQ1YlBeB6PCW7cZfkXynAQbi5G2d5FZG25BSlFIboJ+4KlyABGvCy6ZFhgHpJBlu
 2+r/FPPMOuLJzxY7qa9fPaclZYC90X/vEwxzBdcF7FtNwJ+NrUYuWxXmFJhvuh1vhNWY
 rEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859770; x=1687451770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/nlgPLhLbIsykS3dfTZmYeBfdaG3SqKteCE5YtDUbs=;
 b=NWJlpxgGTplqGrvlnCsAcbd4VwtsxXBBpQQXHmxu6mTRDjmhVU3CAIuxH5ePtW7Wq6
 O2x+ezCWwVP+ScwwE9OzQgF4t/Llnm5JmXFtAdeYycDCwbJx5jcco9Ab5tzWNQNGZYjH
 M9SmL4wJP/0Wq+N5o3rocKUXqDulkvVZvnVV7bPkhbl0lKazGMRH1+69r4NgJZ0Hc8yc
 NYNfcHwVTsCfXplfM0uo8dxil65a38w5avOsniwYRsWMu/zH7MQ5rPa2iZX+7r4ONFQV
 gUWrEUs3nHCBuMFco12CfkREHf98cFQRXe57hvUi8cm+VfMLpHdK5el5IH3Oh/ySRG+e
 w41Q==
X-Gm-Message-State: AC+VfDx7is1vMsP6uucPMn1c84oq0eLTryalNt+Ay/bc3ufW5r3Hk/K4
 OBse6kGb91X+6E+TIqcJqn6+Mw1LSaMf5aiInuk=
X-Google-Smtp-Source: ACHHUZ75hO2g2x/kpMNOadKblZKBCbnHwhjCPpNYVeCVi90tTG2bZO7b1AVitERoMEpJoqrf2XWOoQ==
X-Received: by 2002:a5d:50d2:0:b0:2cf:e517:c138 with SMTP id
 f18-20020a5d50d2000000b002cfe517c138mr9579070wrt.66.1684859770636; 
 Tue, 23 May 2023 09:36:10 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a5d6086000000b003064600cff9sm11600325wrt.38.2023.05.23.09.36.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 May 2023 09:36:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH 01/11] softmmu: Introduce
 qemu_target_page_mask/qemu_target_page_align helpers
Date: Tue, 23 May 2023 18:35:50 +0200
Message-Id: <20230523163600.83391-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230523163600.83391-1-philmd@linaro.org>
References: <20230523163600.83391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Since TARGET_PAGE_MASK and TARGET_PAGE_ALIGN are poisoned in
target-agnostic code, introduce the qemu_target_page_mask()
and qemu_target_page_align() helpers to get these values from
target-agnostic code at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/target_page.h |  2 ++
 softmmu/physmem.c          | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index bbf37aea17..660416920b 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -15,6 +15,8 @@
 #define EXEC_TARGET_PAGE_H
 
 size_t qemu_target_page_size(void);
+unsigned qemu_target_page_mask(void);
+uint64_t qemu_target_page_align(uint64_t value);
 int qemu_target_page_bits(void);
 int qemu_target_page_bits_min(void);
 
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index efaed36773..14fcba4fb2 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3347,6 +3347,16 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
+unsigned qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
+
+uint64_t qemu_target_page_align(uint64_t value)
+{
+    return TARGET_PAGE_ALIGN(value);
+}
+
 int qemu_target_page_bits(void)
 {
     return TARGET_PAGE_BITS;
-- 
2.38.1


