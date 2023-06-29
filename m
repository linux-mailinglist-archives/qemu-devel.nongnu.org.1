Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B67420A5
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 08:48:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElR5-0002nC-E5; Thu, 29 Jun 2023 02:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qElQv-0002mZ-ET
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:47:13 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qElQt-0004Xr-Gu
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:47:13 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6b74e2d8c98so323106a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688021229; x=1690613229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RLUv3JkR/493FEh/mC3hqC02p+R4kbf0Ivsten6bGqQ=;
 b=Fyx4OsXucnnd2Duq4cleL5g3rlwP2qmMT9kyURSoQeogOHulQvn0O3an+XkEcDuyJ1
 u8oQRCHceoAiFC0Nq2nEgPtXFVyDzP8VHl7Nf5v4RYnTGr8KDn7k2Hs1FotSxh7bHbyD
 trGSnRGsthxKqZWih/lAbiLtAxYbY0EFireOflYhPdC2xY9HTr5fIF6Rta+bX8FtAd3y
 IZQ7UJh/7j9RuyBkw9sfD+h7rtk5tQNeDz8O3fePtASScNziVg0SXqdcYMjcweXPAtAm
 oQNKQm2pdoF5n4VF8C9u1Br1dJySiwoeKSgI4jd1B6Dg6VN5lkJHnJOn1PdnhUtMdi/Y
 3WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688021229; x=1690613229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RLUv3JkR/493FEh/mC3hqC02p+R4kbf0Ivsten6bGqQ=;
 b=Bm6L86uVM2csCDTikP9NlAimMdzfyT2HBegbeEZsXhbWbRBhnC53+edEhLS7TkZ6jd
 nMidwuz8u10PM7t+m/cmw7W9xJ6TL2VcR2b7f7KqLU6tpiQaMagQYvVhx9voIAg+UbvA
 nqfYyYj4R2AOiAI78uapDj7KdyAdoYX3E1DU//Teb+fgbi7RzdsyI+iL0ZqaU/UTuh/q
 ia5goG7l+SLvqmEoDqmWOLNi9IoP85qadHZPGcXrMRXE5BfmGKD8QVeNQ+lT9Bmy03J6
 xgwItQuj/sjQfY7Ly9VjTssBdXKy/up5HN0XVcEpErOjRqYlRRhSjhROzdxLkaEVBXzA
 WXHg==
X-Gm-Message-State: AC+VfDyzfVDeF2+qfEGI5UU1rrrOM7n/CvmDAP4WY5i0txEe7ljS6Swe
 8Yq4ltcgal2aaiVehUi2oyo5Ew==
X-Google-Smtp-Source: ACHHUZ5ugAeoJln3/kXwY55iMWCZj0hM0Xv2Y4ouAMqq5u9qtbr6+SRyNHbYkvhMte8jKocEN6lk4g==
X-Received: by 2002:a05:6808:984:b0:3a3:6506:2ec2 with SMTP id
 a4-20020a056808098400b003a365062ec2mr4210516oic.35.1688021229134; 
 Wed, 28 Jun 2023 23:47:09 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 g7-20020aa78187000000b006687da3db65sm7857013pfi.75.2023.06.28.23.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 23:47:08 -0700 (PDT)
Message-ID: <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
Date: Thu, 29 Jun 2023 15:47:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: jusual@redhat.com, imammedo@redhat.com
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230629040707.115656-6-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x331.google.com
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

On 2023/06/29 13:07, Ani Sinha wrote:
> PCI Express ports only have one slot, so PCI Express devices can only be
> plugged into slot 0 on a PCIE port. Enforce it.
> 
> The change has been tested to not break ARI by instantiating seven vfs on an
> emulated igb device (the maximum number of vfs the linux igb driver supports).
> The vfs are seen to have non-zero device/slot numbers in the conventional
> PCI BDF representation.
> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> CC: akihiko.odaki@daynix.com
> 
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> ---
>   hw/pci/pci.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e2eb4c3b4a..0320ac2bb3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -65,6 +65,7 @@ bool pci_available = true;
>   static char *pcibus_get_dev_path(DeviceState *dev);
>   static char *pcibus_get_fw_dev_path(DeviceState *dev);
>   static void pcibus_reset(BusState *qbus);
> +static bool pcie_has_upstream_port(PCIDevice *dev);
>   
>   static Property pci_props[] = {
>       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> @@ -1190,6 +1191,20 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                      name);
>   
>          return NULL;
> +    } /*
> +       * With SRIOV and ARI, vfs can have non-zero slot in the conventional
> +       * PCI interpretation as all five bits reserved for slot addresses are
> +       * also used for function bits for the various vfs. Ignore that case.
> +       * It is too early here to check for ARI capabilities in the PCI config
> +       * space. Hence, we check for a vf device instead.
> +       */

Why don't just perform this check after the capabilities are set?

Regards,
Akihiko Odaki

> +    else if (!pci_is_vf(pci_dev) &&
> +             pcie_has_upstream_port(pci_dev) &&
> +             PCI_SLOT(devfn)) {
> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> +                   " parent device only allows plugging into slot 0.",
> +                   PCI_SLOT(devfn), name);
> +        return NULL;
>       }
>   
>       pci_dev->devfn = devfn;

