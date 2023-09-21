Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD167A937A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 12:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGeT-0007Tu-El; Thu, 21 Sep 2023 06:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjGeR-0007Tk-AV
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 06:11:15 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjGeM-0004N0-01
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 06:11:14 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5041335fb9cso1379424e87.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695291061; x=1695895861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WdBNLwoZvReC9Wr5bWYLwE3r6NJ5QVT0NSNAoaqxZpQ=;
 b=yXq8pTCxgrqVNq+ZYRVDrlC807uHc8wC3Oa3v9CoLYAAAfWAG2C6vvsw14qCOizi6X
 vfB4iEQqdVics1+JpwY8RXXevx6cR8e+YP2Yj9HfNPfZ0qkEpykDE0s74NgudZVrqMvK
 xbc0EGaYSjgq5lgUgadxoBTqRUoCX4dAPn9cgSM3rGtM+HspqWkgg3TBcHD4E26c9wYt
 Wni+pV4ae9yuBp6cKz2q9ZLOqbGlb94kEd4YUnhldrEolaseIlWPrxkMqRDpyT/EHQCK
 PtWPDKxeXXynzBprKx5mqqHty0qGlS15gZQ7VcP2EHNpMmA5Kdq7GRNBtKk0omBlxnJ/
 vIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695291061; x=1695895861;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WdBNLwoZvReC9Wr5bWYLwE3r6NJ5QVT0NSNAoaqxZpQ=;
 b=PO4iBrRJKPK8l5ebhGMUTEsDqJAQG4DEl37gHibLjoDBnNeBXxBdn7TcvunDsGyJOw
 qSw2REjiM2pVzCsAxu3LXFw5EchIAM8Ob4j92BsVu7GK5cCZAQw7LzNiHI9EjGzZa+iE
 dJQdfemKmvz2TY4E34DWshxDs1WOo5ZPqJ09n+YmAiWDhssagN+enHYpjsqbPW3PJERF
 Xus6bIxYCf6Wx+e770Cbmfb0aSX38pTaB6mFibsbtz3JlttY8E7Hsz+KYyYu/i/euDwD
 epgZ7iVap6SYQLflMEpsNK02BpJey9zXjFBbavhfdXF+Udge3260pqc5Y/H+oIxFFXac
 Y7BA==
X-Gm-Message-State: AOJu0YwC+eZvoorBO37ShPibF4AncXcSkYFV8PWFuGhCm+IcuUkw8ao8
 94GEogkXR2rhHjuak0M99Ub+aw==
X-Google-Smtp-Source: AGHT+IHgvPijKAUGO4/owTWR9HkQ1usXCc0BY9UUId4efCUqtR/vr8GYCoztr9Rnx5s9zpEldN5yUg==
X-Received: by 2002:a19:651e:0:b0:500:903f:6084 with SMTP id
 z30-20020a19651e000000b00500903f6084mr3897195lfb.63.1695291061518; 
 Thu, 21 Sep 2023 03:11:01 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 w10-20020aa7dcca000000b005309eb7544fsm619392edu.45.2023.09.21.03.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 03:11:01 -0700 (PDT)
Message-ID: <0a4b2ef4-8184-b887-af8a-542315e671fb@linaro.org>
Date: Thu, 21 Sep 2023 12:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] amd_iommu: Fix APIC address check
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230909162355.384982-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230909162355.384982-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi Akihiko,

Adding Peter.

On 9/9/23 18:23, Akihiko Odaki wrote:
> An MSI from I/O APIC may not exactly equal to APIC_DEFAULT_ADDRESS. In
> fact, Windows 17763.3650 configures I/O APIC to set the dest_mode bit.
> Check only the 12 bits that are known to be fixed for I/O APIC-generated
> MSIs.
> 
> Fixes: 577c470f43 ("x86_iommu/amd: Prepare for interrupt remap support")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/i386/amd_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 4655cd801f..3ac0d0098d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1268,7 +1268,7 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
>           return -AMDVI_IR_ERR;
>       }
>   
> -    if ((origin->address & AMDVI_MSI_ADDR_LO_MASK) != APIC_DEFAULT_ADDRESS) {
> +    if ((origin->address & 0xfff00000) != APIC_DEFAULT_ADDRESS) {
>           trace_amdvi_err("MSI is not from IOAPIC.");
>           return -AMDVI_IR_ERR;
>       }

Could you add a definition? Maybe:

  -- >8 --
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 6da893ee57..85d491e585 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -210,6 +210,7 @@
  #define AMDVI_INT_ADDR_FIRST    0xfee00000
  #define AMDVI_INT_ADDR_LAST     0xfeefffff
  #define AMDVI_INT_ADDR_SIZE     (AMDVI_INT_ADDR_LAST - 
AMDVI_INT_ADDR_FIRST + 1)
+#define AMDVI_INT_ADDR_MASK     ~(AMDVI_INT_ADDR_SIZE - 1)
  #define AMDVI_MSI_ADDR_HI_MASK  (0xffffffff00000000ULL)
  #define AMDVI_MSI_ADDR_LO_MASK  (0x00000000ffffffffULL)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9c77304438..093b4fb18f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1252,7 +1252,7 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
          return -AMDVI_IR_ERR;
      }

-    if ((origin->address & AMDVI_MSI_ADDR_LO_MASK) != 
APIC_DEFAULT_ADDRESS) {
+    if ((origin->address & AMDVI_INT_ADDR_MASK) != APIC_DEFAULT_ADDRESS) {
          trace_amdvi_err("MSI is not from IOAPIC.");
          return -AMDVI_IR_ERR;
      }
---

?

