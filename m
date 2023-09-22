Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9607AB4F6
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIl-0008Mq-Mw; Fri, 22 Sep 2023 11:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIk-0008Lb-1m
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIi-0002oA-L8
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrSO+Hs9yQZxcMhy+G9BaGpwPutEpMTpch02fxbPNas=;
 b=IrW8f6m5n+OobKRX/qKwI0Fv5zUqwyLVpf5s0bNpy6hYCc7fjSbyhjB4RzLltxuMK49Z3k
 w7ymh2Zf9mTW89A2h70Z/9YJAwMvOt3Hx3vW+e80CdARvvjpPNWdq3l2K5Lzh/o8Vk4hPs
 NfKJrcryQl3qrHtjC/0ohKCwmiu6m18=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-MTFSTXTcPhqRl5YlULKnLQ-1; Fri, 22 Sep 2023 11:42:38 -0400
X-MC-Unique: MTFSTXTcPhqRl5YlULKnLQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402cba95486so17804475e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397356; x=1696002156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrSO+Hs9yQZxcMhy+G9BaGpwPutEpMTpch02fxbPNas=;
 b=s1xu4LLMCoBRtlJlIBtbKxfo9K6KmHc6lAhMu92A3g7nVl6hudN360gOt5Svf3bgtj
 WJRNb/U9cz8EBbixugNl78YkARb5kUA8Ju/VgQbukRmm02TfQJTFYmmGpVQK1FIgbAWU
 usaCpnPlGOc4RyoDpT9Cs+FHYV+U11Ket4s+GAQ6d938/pGbh9KBRGFXmXFnX+1MrO70
 90Wu0PRaEbN5jKY4cLhKQplNnZWWjlNPnXkM5j+7QQO3Iav+xC0OLY5kIGClv/xn+Oqd
 aYM7yxpGpM3ZEESXC+ZKDmhzqytYfUteYXbZ5dm5Zl8dEb7jztsXlIR5Gvf7dWKezneZ
 EHdA==
X-Gm-Message-State: AOJu0YxhuPy/WT0pQ2s2Io2oCBw3Piw7qw+D8aocV0Nv3gjP/gfwJBfE
 DG89M44vZLyrOgBIoZEjEV5cmnPqwXKHQR50LBb3MyEUjP+TPZv6qHQDHbEe+koh4JpPjT6bHqo
 AH/8fSQlQxTVi2Qu4zgGAD5cKyA874f87ILNPg0aid5eqhtb36CY4lnR2sT+oAHqG/3XDzLVBG0
 8=
X-Received: by 2002:a05:600c:1da9:b0:405:3a65:1b4c with SMTP id
 p41-20020a05600c1da900b004053a651b4cmr3314794wms.6.1695397356701; 
 Fri, 22 Sep 2023 08:42:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU9KGbGLxWyMfZnyUoJ3MdMOiQ/jtXaGyHNFBHjyGd4Jl1CCBdFFgBS8Jgol4vxmB8EJS6YA==
X-Received: by 2002:a05:600c:1da9:b0:405:3a65:1b4c with SMTP id
 p41-20020a05600c1da900b004053a651b4cmr3314778wms.6.1695397356349; 
 Fri, 22 Sep 2023 08:42:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a1c7912000000b003fef3180e7asm7869578wme.44.2023.09.22.08.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 3/9] qemu/timer: Add host ticks function for RISC-V
Date: Fri, 22 Sep 2023 17:42:22 +0200
Message-ID: <20230922154228.304933-4-pbonzini@redhat.com>
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


