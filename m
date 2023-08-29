Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C85BD78C6D4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazKi-0007RG-TF; Tue, 29 Aug 2023 10:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazKf-0007Jq-KA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:04:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazKa-0004Jk-CF
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:04:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401da71b7faso3650605e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693317870; x=1693922670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZluBv3ZsZLi8BXaodZIPuq9uHBXhttlV4DCK3478qAs=;
 b=Qf/zYfaC388G6cnrFPZ1bgOAP9MnIaWxZxunLTATC33U11wmb37jJv0Jn5jPagzV1x
 EJC0LqMXwl9AdntnV9NCci8ajji/fQjt6kxFIMc5lXRr75RqZfcdQz1BYD8bwUSSSBX6
 6HmYjhp4DBsld/CBqYJXHJKV58kexZiBWFZ2XRDHEgChluuYOASLfz/VbbPRKR/BmfFH
 XBeGA/lnnlmBFb/X4uZpPUp9OLjg1O7Y+pnHQq3gyMzdJuh/lPgY38m6y0G4j3xlE9dI
 EM99WYOCvCWFgMg4gxjYddC9DN9Cn4ThREsAE9FmWgU1ZmV0r0MHl3yctP+xubs5Wdg4
 JPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693317870; x=1693922670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZluBv3ZsZLi8BXaodZIPuq9uHBXhttlV4DCK3478qAs=;
 b=VZuayXhJip4yvlfXjqNI6ebixzfCe6HPeu7yce9hH04S0T73I1NIP12IsgM31X++4t
 0dRIx9WkjMf9cAYL8tUL7+Ln1gLEvmiKihF1sTpzhQSnWXcaBiRsUnI7/J/3Rq/lWDAV
 ZFCSIvPlPfSrp3WVAFCzLWaUkY/e3zcG75t/Uog11FHsgteIZJlv2ohxihDGTURaSFra
 bwL/xCAnN+me8EOpDTCltEuCEUPAyAi7JC4/rtP/lN2H+/f1lhNiaQHUlAX0OdSxyDS4
 s66vf3PGWv5fhSNdJ+vKalAyV9q0rCJi+dnmB9BCS/gXvCSBh9bhP4Gk39OFZryWpPxh
 DNUw==
X-Gm-Message-State: AOJu0YymftvFkgdqrz6gU/CKiPtHN2E+f3ARXbIzFcIpyM/l7rsW58Sp
 Jfac0qqvDWZpWjl79/hUSpjLaQ==
X-Google-Smtp-Source: AGHT+IH2XZ0w9LCL1pDSf24dLGCa6pDRKjo6NNDxY1sbh0nHg/wZ2HRfw4lNUMAEe+JXVZGvijrggw==
X-Received: by 2002:a05:600c:c5:b0:3fe:1db2:5179 with SMTP id
 u5-20020a05600c00c500b003fe1db25179mr22411661wmm.19.1693317869773; 
 Tue, 29 Aug 2023 07:04:29 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b00401b242e2e6sm15127408wml.47.2023.08.29.07.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:04:29 -0700 (PDT)
Message-ID: <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
Date: Tue, 29 Aug 2023 16:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org, Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829093909-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/8/23 15:48, Michael S. Tsirkin wrote:
> On Tue, Aug 29, 2023 at 02:14:51PM +0100, Peter Maydell wrote:
>> On Tue, 29 Aug 2023 at 12:40, Marcin Juszkiewicz
>> <marcin.juszkiewicz@linaro.org> wrote:
>>>
>>> I am working on aarch64/sbsa-ref machine so people can have virtual
>>> machine to test their OS against something reminding standards compliant
>>> system.
>>>
>>> One of tools I use is BSA ACS (Base System Architecture - Architecture
>>> Compliance Suite) [1] written by Arm. It runs set of tests to check does
>>> system conforms to BSA specification.
>>>
>>> 1. https://github.com/ARM-software/bsa-acs
>>>
>>>
>>> SBSA-ref goes better and better, yet still we have some issues. One of
>>> them is test 822 ("Check Type 1 config header rules") which fails on
>>> each PCIe root port device:
>>>
>>> BDF 0x400 : SLT attribute mismatch: 0xFF020100 instead of 0x20100
>>> BDF 0x500 : SLT attribute mismatch: 0xFF030300 instead of 0x30300
>>> BDF 0x600 : SLT attribute mismatch: 0xFF040400 instead of 0x40400
>>>
>>> I reported it as an issue [2] and got response that it may be QEMU
>>> fault. My pcie knowledge is not good enough to know where the problem is.
>>>
>>> 2. https://github.com/ARM-software/bsa-acs/issues/193
>>>
>>>
>>> In the comment Gowtham Siddarth wrote:
>>>
>>>> Regarding the SLT (Secondary Latency Timer) register, the expected
>>>> values align with the ACS specifications, registering as 0. However,
>>>> a discrepancy arises in the register's attribute, intended to be set
>>>> as Read-Only. Contrary to this intent, the bit field seems to
>>>> function as> Read-Write. Ordinarily, when attempting to write to the
>>>> register by configuring all bits to 1, the anticipated behaviour
>>>> should involve rejecting the write operation, maintaining the value
>>>> at 0 to uphold the register's designated Read-Only nature. However,
>>>> in this scenario, the write action takes effect, leading to a
>>>> transformation of the register's value to FFs. This anomaly could
>>>> potentially stem from an issue within the emulator.
>>>
>>> Does someone know where the problem may be? And how to fix it?
>>
>> I don't know enough about PCI to be sure here, but it sounds like
>> what you're saying is happening is that the test case writes all-1s
>> to some PCI register for the root port device, and expects that where
>> some bits in it are defined in the spec as read-only they don't get set?
>>
>> Which registers exactly is the test case trying to write in this way ?
>>
>> I've cc'd the QEMU PCI maintainers.
>>
>> thanks
>> -- PMM
> 
> 
> yes, this is a bug.
> 
> 
> static void pci_init_mask_bridge(PCIDevice *d)
> {
>      /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS and
>         PCI_SEC_LETENCY_TIMER */
>      memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 4);
> 
> 
> note there's a typo: PCI_SEC_LETENCY_TIMER should be
> PCI_SEC_LATENCY_TIMER.
> 
> But the express spec says:
> 	This register does not apply to PCI Express. It must be read-only and hardwired to 00h. For PCI Express to PCI/PCI-X
> 	Bridges, refer to the [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.
> 
> 
> So, only for the pci express to pci express bridges, and only for new
> machine types, we need to override the mask to 0:
> 
> 	d->wmask[PCI_SEC_LATENCY_TIMER] = 0;

Ah right. So smth like:

-- >8 --
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 881d774fb6..c73de617e0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1241,2 +1241,5 @@ static PCIDevice *do_pci_register_device(PCIDevice 
*pci_dev,
          pci_init_mask_bridge(pci_dev);
+        if (pci_is_express(pci_dev)) {
+            pci_set_byte(d->wmask + PCI_SEC_LATENCY_TIMER, 0);
+        }
      }
---

?

