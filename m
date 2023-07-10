Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B674CF26
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:53:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIli6-0006aV-1x; Mon, 10 Jul 2023 03:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIlhy-0006Yr-NS
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:53:22 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIlhw-00083w-Lq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:53:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b8b318c5a7so31589035ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688975599; x=1691567599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JB6YNiJGNowsZL/EjX5yiOmACmJrsnBT9ZlNf58v6lc=;
 b=xN9Li9kMyqlCjZbTp1CF5G9W4td45IQIyw19xotCocJwN5vvw279Pic/wFdou2pjCO
 A9/fMtAh9MFnl9dZDZXl5RZRzkpltGzDdcuscMXPRPcYlsDMY8Y6KNaRhJ5/+MfZvy9u
 NzvKSb6AuBy3RypQFcIY9rskwrvObFYoJ2uKtTxv7dyEfn5r+UxLRUCaJYCZorFMKSbe
 sY/bBmd0IlbrCB/UxvZr1dUPZPVSXQv50x+bDsuFnlk5pDi7wqNLaDvdvmZsfn5CR1gD
 Kj0EPn5aT2ZZQFryckyMPRMqxjnBWFYGQVtOlq0ibfzeB8SkQhJtxpvUCX+oMsEhoZ8T
 HkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688975599; x=1691567599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JB6YNiJGNowsZL/EjX5yiOmACmJrsnBT9ZlNf58v6lc=;
 b=amH1Qk5weIupZ5DXjV+2hHkEx+hiX0R8g6W/haNMYwNE0U9O5WzkzqwFkSeOnFaLdZ
 m41j4PRHapbDlOomT7OEkpnStu83wnGVM45bDTd8ZMyUwty3wPBc/9EdjjM4cgoTpUU1
 NMAtV/qGoYEvMl3tZjTnukvc2FnzKiuAB7LnaX1YJ1xPkDz2SwkYgNNac1Wlx9+DhLIv
 Gxqyd88HhR7voGjU2L4fWS1itHRlV9h180e8TNkrZs1CCodE0+l0VAfjkG0FWrqSmsd7
 GVc8vLA6KbBStNMXrT0ItQXZLPKaqH6Z9DLz52wAihWFYR4vRoAyoDxCg4ii1Tw+duPR
 WvCQ==
X-Gm-Message-State: ABy/qLYPLC8LcNNJFeETsmE6yJvZ6vvpNpYDkWVnkZYuxBPBxLaiIBzM
 fUKfbFwNxNab3jk/kNm4JgKJiA==
X-Google-Smtp-Source: APBJJlFk2bH4so9q+UGx9hnKmQqTpQ83v67C3JHIP9hm6DHmYiCnXaOt5gVHbvKc9hIKXx+iWEEhhg==
X-Received: by 2002:a17:90a:ac0d:b0:262:ec13:d3a with SMTP id
 o13-20020a17090aac0d00b00262ec130d3amr13662386pjq.28.1688975599056; 
 Mon, 10 Jul 2023 00:53:19 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a17090aba1800b0026302348ee4sm5679810pjr.30.2023.07.10.00.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 00:53:18 -0700 (PDT)
Message-ID: <f46049e1-dabf-9038-ca12-386ff5a77442@daynix.com>
Date: Mon, 10 Jul 2023 16:53:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/2] pcie: Specify 0 for ARI next function numbers
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230705022421.13115-1-akihiko.odaki@daynix.com>
 <20230705022421.13115-3-akihiko.odaki@daynix.com>
 <E8241AB3-F645-4697-A5AC-9B6BC897B432@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <E8241AB3-F645-4697-A5AC-9B6BC897B432@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/07/10 16:51, Ani Sinha wrote:
> 
> 
>> On 05-Jul-2023, at 7:54 AM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The current implementers of ARI are all SR-IOV devices. The ARI next
>> function number field is undefined for VF according to PCI Express Base
>> Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF should
>> end the linked list formed with the field by specifying 0 according to
>> section 7.8.7.2.
> 
> Section 7.8.7.2 ARI Capability Register (Offset 04h), I see only this
> 
> Next Function Number - This field indicates the Function Number of the next higher numbered Function in the Device, or 00h if there are no higher numbered Functions. Function 0 starts this linked list of Functions.
> 
> I do not see anything specifically for PF. What am I missing?

It's not specific to PF, but in general the linked list of Functions 
needs to end with 0.

> 
>>
>> For migration, the field will keep having 1 as its value on the old
>> virt models.
>>
>> Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
>> Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
>> Fixes: 3a977deebe ("Intrdocue igb device emulation")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> include/hw/pci/pci.h | 2 ++
>> hw/core/machine.c    | 1 +
>> hw/pci/pci.c         | 2 ++
>> hw/pci/pcie.c        | 2 +-
>> 4 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index e6d0574a29..9c5b5eb206 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -209,6 +209,8 @@ enum {
>>      QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
>> #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
>>      QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
>> +#define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
>> +    QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
>> };
>>
>> typedef struct PCIINTxRoute {
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 46f8f9a2b0..f0d35c6401 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -41,6 +41,7 @@
>>
>> GlobalProperty hw_compat_8_0[] = {
>>      { "migration", "multifd-flush-after-each-section", "on"},
>> +    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
>> };
>> const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index e2eb4c3b4a..45a9bc0da8 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -82,6 +82,8 @@ static Property pci_props[] = {
>>      DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
>>      DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
>>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>> +    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>> +                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
>>      DEFINE_PROP_END_OF_LIST()
>> };
>>
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 9a3f6430e8..cf09e03a10 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -1030,7 +1030,7 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>> /* ARI */
>> void pcie_ari_init(PCIDevice *dev, uint16_t offset)
>> {
>> -    uint16_t nextfn = 1;
>> +    uint16_t nextfn = dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? 1 : 0;
>>
>>      pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
>>                          offset, PCI_ARI_SIZEOF);
>> -- 
>> 2.41.0
>>
> 

