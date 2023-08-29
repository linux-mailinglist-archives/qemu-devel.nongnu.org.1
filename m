Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69278C68B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazES-0003w9-MP; Tue, 29 Aug 2023 09:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazEL-0003vU-UK
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:58:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazEJ-0001Xu-5T
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:58:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fee5ddc23eso41404195e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693317480; x=1693922280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dI48J8SoHimgplt2FnUKM3DtalYyZUKtKzKe95SXVD4=;
 b=L4Lx234hk+1p1DHQG1US44IwzVCG7iek8QoN877HSyrl0E8zLOFVtIkrJYwWW0cKo1
 OypNxonNo+AWzuIBtGd1iTcG1Q4SE0li5oIXH2a0zZRhgAsmyuqdBtf1cBbkGv0AcvhF
 DATwDgXc6p2gvTPLkJLEJp2pxgk9XZE8+O7848TpwDIEAs7fJLjmy0XzJQ2Bqa7ys0KJ
 FW5PLYlP1zGHYmrEIvND0SGtTWMYTykmUXvQb2HmFwynDolwgjeHvq+BzeoKoIrz0zDs
 /afsQ8MjHzYLA+i1GM9THqhRlEHC3+bahjkpCkwwttqEkGRNl9JbpBsNw6tnEi9zMhOI
 uADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693317480; x=1693922280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dI48J8SoHimgplt2FnUKM3DtalYyZUKtKzKe95SXVD4=;
 b=iY9g2FQxQg9uH7wHH5UceDer4+HHDzHrFUBV4lCjybbyDdwghI9rUZzgDtidxsdcJZ
 NWF/xgdq9buA/Tpsdix20N5j7Fb73Bzy/zCctj7TFFQNDCH9Sp17X5y9oTJ/8uBOgRfV
 p5outYZlpgWkwk8oFmkp49GGarYok7INcUvucG0GrJgBIUfBLozVgXs49LsrA2xLnwLR
 r6bfWgV5N9vNKFkPEvqfrvSUgefp3cIAUZLbua6Ojkz/3U5hMtXud6AxCg/EEUQ9+BzW
 qfNbPqpctyI5ICHEIJuHDHUcU2yf/GpIx+QvovY3TVZq4SklVePWvwvoM8Sl+4imyKgE
 dt6Q==
X-Gm-Message-State: AOJu0YwySBannF3TCKXWB/Ea4JWm7Y2u+s1wL2T88A+GSMWE4VmMz9R6
 /cuozm+IdCimC2KM6zKjuJm/fw==
X-Google-Smtp-Source: AGHT+IEPrhkJsLTl4PDTL/kkZ6TmHQeV0okk2nT9iioYNd3xLdAOTIB4hJ6OZzrIL7fbTkmdUQv5LQ==
X-Received: by 2002:a05:600c:364a:b0:401:4542:5ed8 with SMTP id
 y10-20020a05600c364a00b0040145425ed8mr11109833wmq.0.1693317480415; 
 Tue, 29 Aug 2023 06:58:00 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 t16-20020a7bc3d0000000b00401c9228bf7sm7572955wmj.18.2023.08.29.06.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 06:58:00 -0700 (PDT)
Message-ID: <c3c6bab4-27e6-8812-2dc5-3d22c1ef16a5@linaro.org>
Date: Tue, 29 Aug 2023 15:57:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Gowtham Siddarth <gowtham.siddarth@arm.com>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 29/8/23 13:39, Marcin Juszkiewicz wrote:
> I am working on aarch64/sbsa-ref machine so people can have virtual
> machine to test their OS against something reminding standards compliant
> system.
> 
> One of tools I use is BSA ACS (Base System Architecture - Architecture
> Compliance Suite) [1] written by Arm. It runs set of tests to check does
> system conforms to BSA specification.
> 
> 1. https://github.com/ARM-software/bsa-acs
> 
> 
> SBSA-ref goes better and better, yet still we have some issues. One of
> them is test 822 ("Check Type 1 config header rules") which fails on
> each PCIe root port device:
> 
> BDF 0x400 : SLT attribute mismatch: 0xFF020100 instead of 0x20100
> BDF 0x500 : SLT attribute mismatch: 0xFF030300 instead of 0x30300
> BDF 0x600 : SLT attribute mismatch: 0xFF040400 instead of 0x40400
> 
> I reported it as an issue [2] and got response that it may be QEMU
> fault. My pcie knowledge is not good enough to know where the problem is.
> 
> 2. https://github.com/ARM-software/bsa-acs/issues/193
> 
> 
> In the comment Gowtham Siddarth wrote:
> 
>> Regarding the SLT (Secondary Latency Timer) register, the expected 
>> values align with the ACS specifications, registering as 0. However, a 
>> discrepancy arises in the register's attribute, intended to be set as 
>> Read-Only. Contrary to this intent, the bit field seems to function 
>> as> Read-Write. Ordinarily, when attempting to write to the register 
>> by configuring all bits to 1, the anticipated behaviour should involve 
>> rejecting the write operation, maintaining the value at 0 to uphold 
>> the register's designated Read-Only nature. However, in this scenario, 
>> the write action takes effect, leading to a transformation of the 
>> register's value to FFs. This anomaly could potentially stem from an 
>> issue within the emulator.
> 
> Does someone know where the problem may be? And how to fix it?

Commit fb23162885 ("pci: initialize pci config headers depending it pci
header type.") sets PCI_SEC_LATENCY_TIMER writable; it seems to be a
mistake (and bsa-acs is doing the correct testing).

Can you try this quick fix?

-- >8 --
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 881d774fb6..e43aa0fb36 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -894,5 +895,4 @@ static void pci_init_mask_bridge(PCIDevice *d)
  {
-    /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS and
-       PCI_SEC_LETENCY_TIMER */
-    memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 4);
+    /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS */
+    memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 3);

---


