Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9569E59B7
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Dec 2024 16:30:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDoN-0006cr-RD; Thu, 05 Dec 2024 10:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJDoG-0006Vu-Nt
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJDo9-0005fz-Bv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733412622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+tPTDgLinHsfPqWn+mOs+RK/sRDK415QYzsnCGXLwdY=;
 b=iaBIt9KKZfyMx8PxreXzpHqUTqOTG5v8KSXs2fdQDEz1ASDVuXb8sKG61/vG5MyvcLTTW+
 DDYxmJOr2ZFT6ALK1iwDisukvb8yLPxoHv5Y8ptQCJZk6ML9jzKxv2rtOHwHCk0r4I41LT
 aN5rI9L+VhC/aZzTNQaX75ES5zY3+3A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-YjJNR_K9Oa68uAtHOKcHdA-1; Thu, 05 Dec 2024 10:30:20 -0500
X-MC-Unique: YjJNR_K9Oa68uAtHOKcHdA-1
X-Mimecast-MFC-AGG-ID: YjJNR_K9Oa68uAtHOKcHdA
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4669be6c87aso17157681cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733412619; x=1734017419;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tPTDgLinHsfPqWn+mOs+RK/sRDK415QYzsnCGXLwdY=;
 b=Bi2MDKK5QPIF6rIm0+AO77PW0LZH2ilagC8dFYfKR8EBuCpXwOynBeMEHh0ww9V0zI
 GLpnr9AlomcULeeUny8zltoJdqJDjPVYwYnAIX8VXKtyX1nc3n5ZI8/BF6lqE62BiQ2Q
 CNOtp50H2nOQqe6qMcVhkqI6wk2zRXIu68vm6EiPOtvOwwJakkB5OXfH8Au80yTuembb
 mXq3nl1nOosQCczYjoyJ1ZzBK7TBN489yFHyyh73M5GeDLKISh4HAfc8p6LmI1e5rrnG
 vmH10M+PPLSEpGXieLSF7f68ao/ll6upKhPjMp/LmDLfWdCo0aioE41BsHLr9qE4X0lX
 qlLA==
X-Gm-Message-State: AOJu0YyaNBTD3uEcI02n4r713hkQ05VMV+y5NG7Hak0+4MIBr+dMpRrf
 xR0N/UQrgcB/R8c/K5s1lmbZFuS5H/qaG4jx3Zx2ancfoFapkTZqtJ0SEGmFcNJlqCo3mkd+tl+
 WZLE3Fkc3tpEV2J27q34e1UWv9I/gMKWO7Qk0f5D+NqHC4Xf/pWs+
X-Gm-Gg: ASbGncvYCUgC/w0pIZsKxlf8zAIaSHVHwuaGValoi4VqNX2tSdpeolSi7OZK4VvaTWN
 5cQhaSIzoQVTirxWoe+0R0qLHoXvy8wkmGFFjunj0Kh5DsyB3nXIo30UyVmYf6t7XdDkOA0Pl8v
 gcDmbQvyqr7nNR3ynGe93J1DJfCk+hf/zkUK7pHSG/835dUAiwLRJrZcwdKAHXmWHXcapPbRFOP
 lZFrWX2xTfoAlvRpzqporth7tVaCcSufHJnZdV02UIzE0l8PWNC
X-Received: by 2002:a05:622a:308:b0:466:a0cf:b06c with SMTP id
 d75a77b69052e-4670c6fcc56mr211627751cf.56.1733412619356; 
 Thu, 05 Dec 2024 07:30:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9avNw992Fx/1ywXKckLhJa1t1yNcx5Y7hukXZ2eu973yuJuDOadoa8PW6IXXesFqUAKlTCg==
X-Received: by 2002:a05:622a:308:b0:466:a0cf:b06c with SMTP id
 d75a77b69052e-4670c6fcc56mr211626941cf.56.1733412618852; 
 Thu, 05 Dec 2024 07:30:18 -0800 (PST)
Received: from [10.20.9.127] ([144.121.20.162])
 by smtp.googlemail.com with ESMTPSA id
 d75a77b69052e-467296efea0sm8900501cf.37.2024.12.05.07.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 07:30:17 -0800 (PST)
Message-ID: <1da970e8-1708-48ef-87c4-1099d23e8909@redhat.com>
Date: Thu, 5 Dec 2024 16:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 09/13] i386/fw_cfg: move hpet_cfg definition to hpet.c
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-10-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241205060714.256270-10-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/5/24 07:07, Zhao Liu wrote:
> HPET device needs to access and update hpet_cfg variable, but now it is
> defined in hw/i386/fw_cfg.c and Rust code can't access it.
> 
> Move hpet_cfg definition to hpet.c (and rename it to hpet_fw_cfg). This
> allows Rust HPET device implements its own global hpet_fw_cfg variable,
> and will further reduce the use of unsafe C code access and calls in the
> Rust HPET implementation.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/i386/fw_cfg.c        |  4 +---
>   hw/timer/hpet.c         | 16 +++++++++-------
>   include/hw/timer/hpet.h |  2 +-
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 0e4494627c21..965e6306838a 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -26,8 +26,6 @@
>   #include CONFIG_DEVICES
>   #include "target/i386/cpu.h"
>   
> -struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};

This breaks if you disable HPET, which is why fw_cfg.c defines it.

You can do something like

diff --git a/include/hw/timer/hpet-fw-cfg.h b/include/hw/timer/hpet-fw-cfg.h
new file mode 100644
index 00000000000..234a49fc92e
--- /dev/null
+++ b/include/hw/timer/hpet-fw-cfg.h
@@ -0,0 +1,16 @@
+struct hpet_fw_entry
+{
+    uint32_t event_timer_block_id;
+    uint64_t address;
+    uint16_t min_tick;
+    uint8_t page_prot;
+} QEMU_PACKED;
+
+struct hpet_fw_config
+{
+    uint8_t count;
+    struct hpet_fw_entry hpet[8];
+} QEMU_PACKED;
+
+extern struct hpet_fw_config hpet_fw_cfg;
+
diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index d17a8d43199..6f7fcbc3c60 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -60,26 +60,12 @@
  #define HPET_TN_INT_ROUTE_CAP_SHIFT 32
  #define HPET_TN_CFG_BITS_READONLY_OR_RESERVED 0xffff80b1U
  
-struct hpet_fw_entry
-{
-    uint32_t event_timer_block_id;
-    uint64_t address;
-    uint16_t min_tick;
-    uint8_t page_prot;
-} QEMU_PACKED;
-
-struct hpet_fw_config
-{
-    uint8_t count;
-    struct hpet_fw_entry hpet[8];
-} QEMU_PACKED;
-
-extern struct hpet_fw_config hpet_cfg;
-
  #define TYPE_HPET "hpet"
  
  #define HPET_INTCAP "hpet-intcap"
  
+#include "hw/timer/hpet-fw-cfg.h"
+
  static inline bool hpet_find(void)
  {
      return object_resolve_path_type("", TYPE_HPET, NULL);
diff --git a/rust/wrapper.h b/rust/wrapper.h
index 285d0eb6ad0..82381e43472 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -62,3 +62,4 @@ typedef enum memory_order {
  #include "qapi/error.h"
  #include "migration/vmstate.h"
  #include "chardev/char-serial.h"
+#include "hw/timer/hpet-fw-cfg.h"


but you will have to use unsafe to access it since it's a "static mut".

Paolo


