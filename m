Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABBB7523E4
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJwRB-0006iJ-Rh; Thu, 13 Jul 2023 09:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qJwQk-0006ep-4E
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:32:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qJwQe-0001uu-8X
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:32:23 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6689430d803so464231b3a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689255132; x=1691847132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AVb5HfXuGgun3v6HQkMveBBCS9Vi/v1+B8ArdC8o3PY=;
 b=gUO65TLbz99Hm5jbdhoO24rm3YUF0iXhtHqkt0NcsCyu+S90+0emZe+3LoLYrJKHS/
 WRjbiju5G+M7pIsytIJ0YAVpYxZPLX3sr2NHk4x9tKC+TTozmU2m3Z8gAfDJJrLRBtSC
 eyWXnyw+BuXz+qGszOSF4EkQ084RorhsyRdJAyX52B49fKVO5nYp9wneOuCiUlLonUKV
 PYEPuNwPwNssM3EW7Yhu3IsC/fjf0M0TqHBp/xlJ5pjLgyZuCTYKzjiGddWY+zcdC39f
 w7Qw/fy9IiMq+70Pmh3yX8lsx9jrGAUlZMbRtKN7wZsJRM+1Baa4rCO/+BYnX/MYdGRG
 L02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689255132; x=1691847132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AVb5HfXuGgun3v6HQkMveBBCS9Vi/v1+B8ArdC8o3PY=;
 b=hngVeNgHpQUBC2cVOESiSwvJ5j9D3yHg/xOnmXwI+zu1qIkw8Lw9zto9KNEqwg09eW
 EaaxwXZ+3/Oonskv/jFCMKXyyPzzD2IdNNYnacxR+kJv66rm8v0ArYiQqEgBtIKrok28
 4rxzGBeAS/o6JWK6gTj0XGNw+SZ9p3elqyu3QMi7ywIjd1ZRubGo0+atwxuwZdVU8rOP
 FwuHjx1q4S8mwkblnoadt2wmd+91/R+yPi2+0cUsoY4RHKEUXC/m9Nu0RgMQVrYnSI3i
 Yf0n3c0sgHGIrHcQcY/L4Ajl39MyRc1rfYBYJeOViswq17dJmMIRDCPaFw45luNIIOpf
 UcKQ==
X-Gm-Message-State: ABy/qLY33vzmsPjXOoYmrkvP4xgO/CO5NEGxCm29zUA8qdjMEUnneVRK
 AxEon57thDbm8nOqwnzxadX76g==
X-Google-Smtp-Source: APBJJlEfJsIUPMSXgJutim2aeiJe1XdiEzlXY6Hibmxu7eQE8s72M/1oCFbXP7azbC5bkc0zBCwhjA==
X-Received: by 2002:a05:6a00:3913:b0:67e:bf65:ae68 with SMTP id
 fh19-20020a056a00391300b0067ebf65ae68mr1308431pfb.3.1689255132342; 
 Thu, 13 Jul 2023 06:32:12 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a62b415000000b0067b24701daasm5395400pfn.86.2023.07.13.06.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 06:32:11 -0700 (PDT)
Message-ID: <5369af1f-4e69-2d2f-431f-dcf1157f4b21@daynix.com>
Date: Thu, 13 Jul 2023 22:32:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/pci: Warn when ARI/SR-IOV device has non-zero Function
 number
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
References: <20230712112732.18617-1-akihiko.odaki@daynix.com>
 <20230712073523-mutt-send-email-mst@kernel.org>
 <e8be9581-2308-7fe6-f407-2ce54557dbd0@daynix.com>
 <20230712075420-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230712075420-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/07/12 21:06, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2023 at 08:50:32PM +0900, Akihiko Odaki wrote:
>> On 2023/07/12 20:46, Michael S. Tsirkin wrote:
>>> On Wed, Jul 12, 2023 at 08:27:32PM +0900, Akihiko Odaki wrote:
>>>> Current SR/IOV implementations assume that hardcoded Function numbers
>>>> are always available and will not conflict. It is somewhat non-trivial
>>>> to make the Function numbers to use controllable to avoid Function
>>>> number conflicts so ensure there is only one PF to make the assumption
>>>> hold true.
>>>> Also warn when non-SR/IOV multifunction was attempted with ARI enabled;
>>>> ARI has the next Function number field register, and currently it's
>>>> hardcoded to 0, which prevents non-SR/IOV multifunction. It is
>>>> certainly possible to add a logic to determine the correct next Function
>>>> number according to the configuration, but it's not worth since all
>>>> ARI-capable devices are also SR/IOV devices, which do not support
>>>> multiple PFs as stated above.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> I am not really interested in adding this stuff.
>>> The real thing to focus on is fixing ARI emulation, not
>>> warning users about ways in which it's broken.
>>
>> What do you think about multiple SR/IOV PFs? Do you think it's worth/easy
>> enough to fix SR/IOV code to support it? Otherwise it's not worth fixing ARI
>> since currently only SR/IOV devices implement it.
> 
> There's nothing especially hard about it. You can in particular just
> assume the user knows what he's doing and not worry too much about
> checking. Creating invalid configs might also come handy e.g. for debug.
> The important thing, and that's missing ATM, is giving management
> ability to find out TotalVFs, VF offset and VF stride, so it can
> avoid creating these conflicts.
> 
> For igd maybe we should make VF offset and VF stride just 1 unconditionally -
> I have no idea why it was made 2 ATM - could you check what does
> real hardware do?

The current igb implementation match with real hardware. It is defined 
in the datasheet*, section 9.6.4.6. I don't know why it's 2 either.

* 
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82576eg-gbe-datasheet.pdf

> 
> Yes, warning at least is handy for
> management debugging. It shouldn't be hard I think, but the
> logic does tend to be O(n^2). Maybe add a flag to check,
> and management developers can use that for debugging.
> 
>>>
>>>> ---
>>>>    hw/pci/pci.c | 59 +++++++++++++++++++++++++++++++++++++---------------
>>>>    1 file changed, 42 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index 784c02a182..50359a0f3a 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -2124,23 +2124,48 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>>>            }
>>>>        }
>>>> -    /*
>>>> -     * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>>>> -     * associate only Device 0 with the device attached to the bus
>>>> -     * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
>>>> -     * sec 7.3.1).
>>>> -     * With ARI, PCI_SLOT() can return non-zero value as the traditional
>>>> -     * 5-bit Device Number and 3-bit Function Number fields in its associated
>>>> -     * Routing IDs, Requester IDs and Completer IDs are interpreted as a
>>>> -     * single 8-bit Function Number. Hence, ignore ARI capable devices.
>>>> -     */
>>>> -    if (pci_is_express(pci_dev) &&
>>>> -        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>> -        pcie_has_upstream_port(pci_dev) &&
>>>> -        PCI_SLOT(pci_dev->devfn)) {
>>>> -        warn_report("PCI: slot %d is not valid for %s,"
>>>> -                    " parent device only allows plugging into slot 0.",
>>>> -                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
>>>> +    if (pci_is_express(pci_dev)) {
>>>> +        /*
>>>> +         * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>>>> +         * associate only Device 0 with the device attached to the bus
>>>> +         * representing the Link from the Port (PCIe base spec rev 4.0 ver 0.3,
>>>> +         * sec 7.3.1).
>>>> +         * With ARI, PCI_SLOT() can return non-zero value as the traditional
>>>> +         * 5-bit Device Number and 3-bit Function Number fields in its
>>>> +         * associated Routing IDs, Requester IDs and Completer IDs are
>>>> +         * interpreted as a single 8-bit Function Number. Hence, ignore ARI
>>>> +         * capable devices.
>>>> +         */
>>>> +        if (!pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>> +            pcie_has_upstream_port(pci_dev) &&
>>>> +            PCI_SLOT(pci_dev->devfn)) {
>>>> +            warn_report("PCI: slot %d is not valid for %s,"
>>>> +                        " parent device only allows plugging into slot 0.",
>>>> +                        PCI_SLOT(pci_dev->devfn), pci_dev->name);
>>>> +        }
>>>> +
>>>> +        /*
>>>> +         * Current SR/IOV implementations assume that hardcoded Function numbers
>>>> +         * are always available. Ensure there is only one PF to make the
>>>> +         * assumption hold true.
>>>> +         */
>>>> +        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV) &&
>>>> +            PCI_FUNC(pci_dev->devfn)) {
>>>> +            warn_report("PCI: function %d is not valid for %s,"
>>>> +                        " currently PF can only be assigned to function 0.",
>>>> +                        PCI_FUNC(pci_dev->devfn), pci_dev->name);
>>>> +        }
>>>> +
>>>> +        /*
>>>> +         * ARI has the next Function number field register, and currently it's
>>>> +         * hardcoded to 0, which prevents non-SR/IOV multifunction.
>>>> +         */
>>>> +        if (pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
>>>> +            !pci_is_vf(pci_dev) && (pci_dev->devfn & 0xff)) {
>>>> +            warn_report("PCI: function %d is not valid for %s,"
>>>> +                        " non-SR/IOV multifunction is not supported with ARI enabled.",
>>>> +                        pci_dev->devfn & 0xff, pci_dev->name);
>>>> +        }
>>>>        }
>>>>        if (pci_dev->failover_pair_id) {
>>>> -- 
>>>> 2.41.0
>>>
> 

