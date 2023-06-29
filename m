Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9574229D
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnLf-00016F-OA; Thu, 29 Jun 2023 04:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qEnLd-00015z-AP
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:49:53 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qEnLb-0002Vw-9z
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:49:53 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b74faaac3bso372010a34.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688028590; x=1690620590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I2GZNBLrSB7/oNKqW+3GxQWiaJdjUTm/jQXBpuEczVo=;
 b=zbidCj8VTaPYTurhbfo6Udrizh5G3xZcM5cFkfkfD/SJq68YtLe4W08yUBnaBrYrvU
 QBhatVphkTdeZKTMWPhYe+zodGlrcF+Er9dEt9CWszL3bvyLtq3rB8l59XVqbt8ge/Wv
 xNfOOBMC5s0R/csYlX6VDtqB+ttnFt4Xr7GSwqqYd5hciPqLBx5M7bCNFhul6C6qtjY3
 fHbIfa9fIhFqri3Rq0PTsN4fwKznqiYF92UpTAK8EiLaSo5ktMTrgJUfgA5yFwLN2X2f
 t/jOjGDs4gzduEReHTO4AqjMoLg3cnYfrd5F4fUylSBxYoaw6IfGI6dB4TYOH7TmQryV
 GW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688028590; x=1690620590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I2GZNBLrSB7/oNKqW+3GxQWiaJdjUTm/jQXBpuEczVo=;
 b=ECY/FjD9XWkK+fqq6EqX/0WkY/FcspEkLCmem4veDNOtQ2u9Mscr9rbnGPuLq2pmdW
 8jyInbH3dVennr0Mvc6dgzs7xc/dJ5yXmQDlaoQZccTS2n0yjTAavzLhuanHMiP8/FM1
 tCzEeOBGY6c95JelHfY4smCZtNhyJRlhb3zTyzHHwlaqWBJounT/T4KhQVQnVf61iP0V
 KxRcIboRSs5vIlyo98w1JP+ixCyXGArwijJa6afOqJmxv2I87GbQziIJ0pAGaiNrP2Hq
 qX2L0GHqINNj+KhXtkQqTOlI5Rk2AXR7Cxa+mdiN3d/WXi+X1YyuFZec52QojJHlkkSQ
 dLAw==
X-Gm-Message-State: AC+VfDy1nbI9CU9Jcj5LPWKaX/YWHkaMElLvbIEfGd5cT3mLNRNLcVYI
 0GXkBoYvfBzwo3qjuGbFZ54LYA==
X-Google-Smtp-Source: ACHHUZ4HUy9X/T+NSZGxFAY4zuUOx11gcA7g7nCSHac/zbO7wVBbtNYrK8G1hA/0fZsiukKhmampRw==
X-Received: by 2002:a05:6808:f92:b0:3a3:7505:7038 with SMTP id
 o18-20020a0568080f9200b003a375057038mr1625320oiw.45.1688028589756; 
 Thu, 29 Jun 2023 01:49:49 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d26-20020aa7869a000000b0063d2dae6247sm6126350pfo.77.2023.06.29.01.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 01:49:49 -0700 (PDT)
Message-ID: <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
Date: Thu, 29 Jun 2023 17:49:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/06/29 17:05, Ani Sinha wrote:
> 
> 
> On Thu, 29 Jun, 2023, 12:17 pm Akihiko Odaki, <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/06/29 13:07, Ani Sinha wrote:
>      > PCI Express ports only have one slot, so PCI Express devices can
>     only be
>      > plugged into slot 0 on a PCIE port. Enforce it.
>      >
>      > The change has been tested to not break ARI by instantiating
>     seven vfs on an
>      > emulated igb device (the maximum number of vfs the linux igb
>     driver supports).
>      > The vfs are seen to have non-zero device/slot numbers in the
>     conventional
>      > PCI BDF representation.
>      >
>      > CC: jusual@redhat.com <mailto:jusual@redhat.com>
>      > CC: imammedo@redhat.com <mailto:imammedo@redhat.com>
>      > CC: akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      >
>      > Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
>     <https://bugzilla.redhat.com/show_bug.cgi?id=2128929>
>      > Signed-off-by: Ani Sinha <anisinha@redhat.com
>     <mailto:anisinha@redhat.com>>
>      > Reviewed-by: Julia Suvorova <jusual@redhat.com
>     <mailto:jusual@redhat.com>>
>      > ---
>      >   hw/pci/pci.c | 15 +++++++++++++++
>      >   1 file changed, 15 insertions(+)
>      >
>      > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>      > index e2eb4c3b4a..0320ac2bb3 100644
>      > --- a/hw/pci/pci.c
>      > +++ b/hw/pci/pci.c
>      > @@ -65,6 +65,7 @@ bool pci_available = true;
>      >   static char *pcibus_get_dev_path(DeviceState *dev);
>      >   static char *pcibus_get_fw_dev_path(DeviceState *dev);
>      >   static void pcibus_reset(BusState *qbus);
>      > +static bool pcie_has_upstream_port(PCIDevice *dev);
>      >
>      >   static Property pci_props[] = {
>      >       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>      > @@ -1190,6 +1191,20 @@ static PCIDevice
>     *do_pci_register_device(PCIDevice *pci_dev,
>      >                      name);
>      >
>      >          return NULL;
>      > +    } /*
>      > +       * With SRIOV and ARI, vfs can have non-zero slot in the
>     conventional
>      > +       * PCI interpretation as all five bits reserved for slot
>     addresses are
>      > +       * also used for function bits for the various vfs. Ignore
>     that case.
>      > +       * It is too early here to check for ARI capabilities in
>     the PCI config
>      > +       * space. Hence, we check for a vf device instead.
>      > +       */
> 
>     Why don't just perform this check after the capabilities are set?
> 
> 
> We don't want to allocate resources for wrong device parameters. We want 
> to error out early. Other checks also are performed at the same place .

It is indeed better to raise an error as early as possible so that we 
can avoid allocation and other operations that will be reverted and may 
go wrong due to the invalid condition. That should be the reason why 
other checks for the address are performed here.

However, in this particular case, we cannot confidently perform the 
check here because it is unknown if the ARI capability will be 
advertised until the device realization code runs. This can justify 
delaying the check after the device realization, unlike the other checks.

> Show quoted text
> 
> 
> 
> 
>     Regards,
>     Akihiko Odaki
> 
>      > +    else if (!pci_is_vf(pci_dev) &&
>      > +             pcie_has_upstream_port(pci_dev) &&
>      > +             PCI_SLOT(devfn)) {
>      > +        error_setg(errp, "PCI: slot %d is not valid for %s,"
>      > +                   " parent device only allows plugging into
>     slot 0.",
>      > +                   PCI_SLOT(devfn), name);
>      > +        return NULL;
>      >       }
>      >
>      >       pci_dev->devfn = devfn;
> 

