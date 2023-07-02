Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB1744CCD
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFsjJ-0005LC-MW; Sun, 02 Jul 2023 04:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsjF-0005Kn-FY
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:46:45 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFsjD-0005Ph-Gs
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:46:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-66c729f5618so2929447b3a.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688287602; x=1690879602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NYdE07Pk1uqrAxPQgeHEWUNoLv+Unns0zMjBSolDwY0=;
 b=3hMbf+g31wle67bfLDy5E3OUI51ufyvqriZeEvZ77xRpqTXgsoqOyI8e30OW1uF1AN
 0Bzo/kxI+RRyTCIaorFqywTlezofHc5BhGw/JroEU2F+IveCfDd/jjvUJ5lReNaARBcJ
 t+FWPg17xN4bZISOdPY/jqwgebv9wyOFvSTl83l5cmoIP0Y/VHlzVXf0jc8peN+iUSz5
 OdSf08qZvn2vLhIf5uH9jd0NFi81v70PHJQGnNgtRtWjIsrmRpYbC34mPMyBzSbsoLuG
 HLpDvB9gyGtAqkuwHCC35dPRA79yBmXbPGKlPVCPX3sEyNP2ewFaOTqB5Pd/LXkqlpiB
 H+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688287602; x=1690879602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NYdE07Pk1uqrAxPQgeHEWUNoLv+Unns0zMjBSolDwY0=;
 b=WWgzgPtgFkGxDgcHegfdRGegjSnSSGJbzkEGyx1OGw8TOpdoNowfAOHDa6ztNLuFPR
 wmOHqEDMJlm1SwvFgGs8o75WGAcxS0KiOgJytwjUn94e3uRrc+yPnLT6DtVb2AVkh9MX
 afaBa9+Pc7rqGIgLScUBsVHnkLKyXdaOmE2WcmOoibbZ7VnCAZMtjI7JosDjcXyxtP+B
 WRy2wBs9nM32MR6z5pAw4BThtQNF86Vzy7s9y+bXEQg2xcTw0dlB4ZkochEurIjPatGg
 iUrX/qo9UFEfB93KBvIbVkO/XvU4ZXT+x59Ngc+Hw8fJ9GisqOOwy8cAIwZmwtB3V8kO
 u+EQ==
X-Gm-Message-State: ABy/qLalk+ZaZwypUv1dWJr7lP7mHs2H+z+mE3t+/qHjrAZgu1kDcP4g
 5icoASMpPq2q9ww3aK+HBb7P4A==
X-Google-Smtp-Source: APBJJlEiOEnWlmfFzumsSQtl6+AhrEbhpMEA1FYdhkfjFOVhT+ot3TuAoaivWAhQDo6vpBv+H/a0/g==
X-Received: by 2002:a05:6a00:80d:b0:66c:6678:3776 with SMTP id
 m13-20020a056a00080d00b0066c66783776mr10024747pfk.7.1688287601923; 
 Sun, 02 Jul 2023 01:46:41 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 k6-20020aa78206000000b0063b898b3502sm12268283pfi.153.2023.07.02.01.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jul 2023 01:46:41 -0700 (PDT)
Message-ID: <b7611765-761d-62e8-a3d5-06a7c0b2f33c@daynix.com>
Date: Sun, 2 Jul 2023 17:46:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] pci: Compare function number and ARI next function
 number
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-5-akihiko.odaki@daynix.com>
 <20230702004344-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230702004344-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/07/02 13:58, Michael S. Tsirkin wrote:
> On Sat, Jul 01, 2023 at 04:01:22PM +0900, Akihiko Odaki wrote:
>> The function number must be lower than the next function number
>> advertised with ARI.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> I don't get this logic at all - where is the limitation coming from?
> 
> All I see in the spec is:
> 	Next Function Number - With non-VFs, this field indicates the Function Number of the next higher
> 	numbered Function in the Device, or 00h if there are no higher numbered Functions. Function 0 starts
> 	this linked list of Functions.
> 	The presence of Shadow Functions does not affect this field.
> 	For VFs, this field is undefined since VFs are located using First VF Offset (see § Section 9.3.3.9 ) and VF
> 	Stride (see § Section 9.3.3.10 ).
> 
> and
> 
> 	 To improve the enumeration performance and create a more deterministic solution, software can
> 	enumerate Functions through a linked list of Function Numbers. The next linked list element is
> 	communicated through each Function’s ARI Capability Register.
> 	i. Function 0 acts as the head of a linked list of Function Numbers. Software detects a
> 	non-Zero Next Function Number field within the ARI Capability Register as the next
> 	Function within the linked list. Software issues a configuration probe using the Bus Number
> 	captured by the Device and the Function Number derived from the ARI Capability Register
> 	to locate the next associated Function’s configuration space.
> 	ii. Function Numbers may be sparse and non-sequential in their consumption by an ARI
> 	Device.

The statement "With non-VFs, this field indicates the Function Number of 
the next higher numbered Function in the Device, or 00h if there are no 
higher numbered Functions." implies the Function Number of the device 
should be lower than the value advertised by the field (for non-VFs; 
this patch does not check if it's VF or not.)

> 
> 
> 
> 
> 
>> ---
>>   hw/pci/pci.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index e2eb4c3b4a..568665ee42 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2059,6 +2059,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>       Error *local_err = NULL;
>>       bool is_default_rom;
>>       uint16_t class_id;
>> +    uint16_t ari;
>> +    uint16_t nextfn;
>>   
>>       /*
>>        * capped by systemd (see: udev-builtin-net_id.c)
>> @@ -2121,6 +2123,19 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>           }
>>       }
>>   
>> +    if (pci_is_express(pci_dev)) {
>> +        ari = pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI);
>> +        if (ari) {
>> +            nextfn = (pci_get_long(pci_dev->config + ari + PCI_ARI_CAP) >> 8) & 0xff;
>> +            if (nextfn && (pci_dev->devfn & 0xff) >= nextfn) {
>> +                error_setg(errp, "PCI: function number %u is not lower than ARI next function number %u",
>> +                           pci_dev->devfn & 0xff, nextfn);
>> +                pci_qdev_unrealize(DEVICE(pci_dev));
>> +                return;
>> +            }
>> +        }
>> +    }
>> +
>>       if (pci_dev->failover_pair_id) {
>>           if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>>               error_setg(errp, "failover primary device must be on "
>> -- 
>> 2.41.0
> 

