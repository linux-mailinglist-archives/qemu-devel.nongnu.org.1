Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672C7C80C9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:52:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtJ-0000MW-BC; Fri, 13 Oct 2023 04:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsi-00077x-Ks
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsf-0001ao-UU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-325e9cd483eso1788360f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187047; x=1697791847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQ1Qp6GrDrZ2TiskE1Vd9+zDOLdIt7Jjunoskgap1GE=;
 b=Y4SB7X6C0ADvCKrXTmxtBFzu0VAHnsijONgDBolVSwWYyd8OB5DX6VkPV23NxpXzvg
 2B28uMM2/MY71qH3gPO0sc1zeWGAqv74IRMHJF9rRW9vl+uDqW2QNKKlJHICqKDmjeFr
 L/OlRdYwuuLydaDue9LgrHcvxMCND4YFklvAqo/7Y8DV/G7oNhLSDF8TCO/Mb9LKlNE2
 9EYRscScxs3dWXiTCStE07XlJQne1UV5w/W8qry9VGip5OTGzoeYn3UCn1e4NirN65An
 kLdTlISKZdG2dRPTpoYBUoTU3Ecv8WXtHxb4i5PCcawNNn2EYRvnfZbxLA7MSAeZT5J/
 Ry0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187047; x=1697791847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQ1Qp6GrDrZ2TiskE1Vd9+zDOLdIt7Jjunoskgap1GE=;
 b=ofknJSsYX8tg7FCcH8YVA+eU+iEHhAZU7wuVjsHBih9gXO/7HaWHWw0gBCz+ZMf3+1
 BtDZwscs7ZBMkPZ+6ZArBVLnWAYiwXx+ley73TOI/BXvVEBtAasr/+QmPybikHeeZptu
 /oncqetEaAwwoTEesrU+yE4BrwO3CkfWdIztmqF9StnmsVr0D8/Ez/1F4I0FiUsnw7Ru
 PXKkdcSZmuk9/NqSJ2r9wkWSdncfrMmapKX5i9zl7YPpbHpszXJ0Yx2THAGoim148su7
 lkfKV0/xDFa5WRSf8H+ZkVBV/h0K4GmZDmetm40wTwlRjYQsc5mJP7jlP0OaBmh0vjDn
 G8KQ==
X-Gm-Message-State: AOJu0YxCXmPY4Y+6m4DakSKP2Ro+6yj10XbqfUr7IT6+WOwgTk6UMfQ9
 Np9VdBRHao69AnhYni1Rbb4BrFQNmCeCLXGdF8o=
X-Google-Smtp-Source: AGHT+IEgga8DOsG+mS4l4XO3RVYWOBRU45jWpZ3AzZvdFCWfdsQs0gbgVhMv3cMvdLFNaLE4g6JfAQ==
X-Received: by 2002:a5d:44cd:0:b0:32d:885f:3f8d with SMTP id
 z13-20020a5d44cd000000b0032d885f3f8dmr5369496wrr.52.1697187047039; 
 Fri, 13 Oct 2023 01:50:47 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:46 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390-ccw boot)
Subject: [RFC PATCH v3 71/78] hw/s390x: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:39 +0300
Message-Id: <6e4db77a017893c302d1ed7ba2eb526800f7b629.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/s390x/ipl.c           | 1 +
 hw/s390x/s390-pci-inst.c | 4 ++--
 hw/s390x/sclp.c          | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 515dcf51b5..da2333846f 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -429,6 +429,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
         case CCW_DEVTYPE_VIRTIO_NET:
             ipl->netboot = true;
             /* Fall through to CCW_DEVTYPE_VIRTIO case */
+            fallthrough;
         case CCW_DEVTYPE_VIRTIO:
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
             ipl->iplb.blk0_len =
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 30149546c0..171320384c 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1380,10 +1380,10 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
      * FH Enabled bit is set to one in states of ENABLED, BLOCKED or ERROR. */
     case ZPCI_FS_ERROR:
         fib.fc |= 0x20;
-        /* fallthrough */
+        fallthrough;
     case ZPCI_FS_BLOCKED:
         fib.fc |= 0x40;
-        /* fallthrough */
+        fallthrough;
     case ZPCI_FS_ENABLED:
         fib.fc |= 0x80;
         if (pbdev->iommu->enabled) {
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index eff74479f4..9b8c7ff043 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -66,7 +66,7 @@ static bool sccb_verify_boundary(uint64_t sccb_addr, uint16_t sccb_len,
         if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
             return true;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         if (sccb_max_addr < sccb_boundary) {
             return true;
@@ -224,7 +224,7 @@ static void sclp_configure_io_adapter(SCLPDevice *sclp, SCCB *sccb,
             }
             return;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         rc = SCLP_RC_ADAPTER_TYPE_NOT_RECOGNIZED;
     }
-- 
2.39.2


