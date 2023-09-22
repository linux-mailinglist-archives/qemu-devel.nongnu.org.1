Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE017AAE23
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVv-0004kv-GK; Fri, 22 Sep 2023 05:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVf-0004iS-IP
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVc-0003ML-Rv
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrSO+Hs9yQZxcMhy+G9BaGpwPutEpMTpch02fxbPNas=;
 b=gxhxIscZieVwFFOEDRUnKmab6sCmLwr0ljT178m8teQSfVWKGO5BIjCg7OPGd6oyBJC6nb
 d7hR24HAYT6UgqrqKLf+Ki/+GOd/wY3ayNXmEq+cxeP4iKR5f75xdC90JEulvn2LFp4yft
 8Ivoy/KppSd2py8unfFsUVtta/hQglE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-XNtslg6oNUePoiaGumePrg-1; Fri, 22 Sep 2023 05:31:34 -0400
X-MC-Unique: XNtslg6oNUePoiaGumePrg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40478e6abd0so14088715e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375093; x=1695979893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrSO+Hs9yQZxcMhy+G9BaGpwPutEpMTpch02fxbPNas=;
 b=MapV1R4i4+7iipe47Ce9PKJeZzixEJI5flZkTSfbRna1A3o8r5qIdzTxwmqarmKmpK
 a2y5smdL3Buq6YCxWb/gvdlVN76J/zCf13PuwQOePOEPWQMQHQakWDYWMeMQSw7lmB/l
 H1Wp6ACfP6PL20+AZg02bFUZYPfOlKNu0Gw4zCA9pTDSnFlddlspJZKS9t3Q1tO5eD7a
 WRZQ2ZC0IECLu53FkpaajvucAhJmi/TT+lPxnf/YHrpYOtP/B2AWWyeRD43mgGfuv9UX
 GRjjX1C/NRlQDA/fEwNt0Ji/LQ1Owm2UJCxukiD6NyQJog0mFKfMjPGF3VxYYe8QeBnH
 PIxA==
X-Gm-Message-State: AOJu0Yz8spJLmSBDvPHtxaL8rKJgSOiMyWRXIEzZmCeWFbRq51SCBDJi
 zry7cfA41EOBhZTOPw8/uqNSfqZ3zUOfQfTA8wW76m9Qbp0F60nBuBQ9ERmfCaKT90+KyC+NdC3
 MpOSNV4NmT6qFKS+rX2+3qwaxUK9INKliyGXuF3Ec7Mt+QE7vhdU+wxfuR5tYhwN2w/2IQ6on+z
 c=
X-Received: by 2002:a5d:638a:0:b0:321:6fe4:d4eb with SMTP id
 p10-20020a5d638a000000b003216fe4d4ebmr5768023wru.2.1695375092996; 
 Fri, 22 Sep 2023 02:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa+EQpr8RImb02/nGcCyGx1vTnb2G7B0Cj+sGYpUhQA9gsv3viohBf22PrMHHi5TxEtGR8Gw==
X-Received: by 2002:a5d:638a:0:b0:321:6fe4:d4eb with SMTP id
 p10-20020a5d638a000000b003216fe4d4ebmr5768013wru.2.1695375092693; 
 Fri, 22 Sep 2023 02:31:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a5d6b51000000b0031980294e9fsm3961523wrw.116.2023.09.22.02.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 03/12] qemu/timer: Add host ticks function for RISC-V
Date: Fri, 22 Sep 2023 11:31:16 +0200
Message-ID: <20230922093126.264016-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20230911063223.742-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a91cb1248a..9a366e551fb 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -979,6 +979,28 @@ static inline int64_t cpu_get_host_ticks(void)
     return cur - ofs;
 }
 
+#elif defined(__riscv) && __riscv_xlen == 32
+static inline int64_t cpu_get_host_ticks(void)
+{
+    uint32_t lo, hi, tmph;
+    do {
+        asm volatile("RDTIMEH %0\n\t"
+                     "RDTIME %1\n\t"
+                     "RDTIMEH %2"
+                     : "=r"(hi), "=r"(lo), "=r"(tmph));
+    } while (unlikely(tmph != hi));
+    return lo | (uint64_t)hi << 32;
+}
+
+#elif defined(__riscv) && __riscv_xlen > 32
+static inline int64_t cpu_get_host_ticks(void)
+{
+    int64_t val;
+
+    asm volatile("RDTIME %0" : "=r"(val));
+    return val;
+}
+
 #else
 /* The host CPU doesn't have an easily accessible cycle counter.
    Just return a monotonically increasing value.  This will be
-- 
2.41.0


