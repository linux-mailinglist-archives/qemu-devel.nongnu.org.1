Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E64747033
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGecQ-0006N8-ET; Tue, 04 Jul 2023 07:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGecN-0006Mt-SA
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:54:51 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGecM-0000lM-6x
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:54:51 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a1d9b64837so4252508b6e.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688471689; x=1691063689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=If1ZJDHQA9S5mpoWEHIy54myeZb9bk2qyIFlmPg6gTQ=;
 b=Ri22Q7OX4vPURfxnA3vHpJsr7ndVoG9fXd8GSBbsaKX0mHHN3gEXwOVQTeD4t1/UzY
 L97XbYW6R/j7BXin0a5QRW5WUCYG+6bI9LRnvx7vojQ7IV+MInXv9RpnX2UeBGRDJ99F
 9/G8GczVEGS19ItydDRGvm+xjSlJjG+/renRbnxXSSG8gjzQ4GH0Cos7lxXhaR4pma1D
 gNPadRrWFmIsHNvxKDTIEK7YA094jtx1TYvLNBcAraPZJ0tUqXhCgYBaboLR0hRuEtHX
 RNrxzwY7JupTvNTxJpMg8eh6lA1ND4yVBJJnkzfpyTk0zlNvhVU2w64iOvDDS+QK1T21
 QwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688471689; x=1691063689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=If1ZJDHQA9S5mpoWEHIy54myeZb9bk2qyIFlmPg6gTQ=;
 b=JhYjzzSPJiqZYv3m7FmfGAhmPEz/7A2haAaqxOHKSb+Khwoi0phH/+TtSQ8N7A7Vmz
 0vv9DI/+5P+RXbqOrDH7Rl+a/lWfWXCyhnpI8YiutKXYEczNhobZWCcLlVpcXXnotZo4
 naI45Qw/tJkB2DWCrkQdONqel6Oc1ULHaCiz1THvffDcn7jhPGvnCKxN/Wv3QM4GOaYu
 dVAEWKij9FUCSmifgJmcBRZd4y9J7FI9xLbaGjZ3cHIiHqoAejxeXilCngoMfhH1DpeB
 nGBXT03p/irFv88FSXB+CAaWFs0pUe1jOvAy3OxrInJUyS9IHYiOdswcNBR8EmhTHGo4
 V0/Q==
X-Gm-Message-State: ABy/qLaciuXXdUlZ74ipqxVCneLnNUHY1+ERzUDsrZFp2bSSZh9V2bx7
 xT4ANmlXqB+JDjmxDmJsyxZ0BA==
X-Google-Smtp-Source: APBJJlFJ88Ly7Ed80c5AUSHWOd8c7bkL55cU7rmxM+1lEXLjaY5wd7qJLAmXMvEbjAWyODANSvy82A==
X-Received: by 2002:a05:6808:1a17:b0:3a3:a8ce:c659 with SMTP id
 bk23-20020a0568081a1700b003a3a8cec659mr7119188oib.1.1688471689214; 
 Tue, 04 Jul 2023 04:54:49 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a17090acb8f00b0025edb720cc1sm17023532pju.22.2023.07.04.04.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 04:54:48 -0700 (PDT)
Message-ID: <7356dc51-588c-f2f8-22d9-c8193bae9309@daynix.com>
Date: Tue, 4 Jul 2023 20:54:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 5/6] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: jusual@redhat.com, imammedo@redhat.com
References: <20230704112555.5629-1-anisinha@redhat.com>
 <20230704112555.5629-6-anisinha@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230704112555.5629-6-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
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

On 2023/07/04 20:25, Ani Sinha wrote:
> PCI Express ports only have one slot, so PCI Express devices can only be
> plugged into slot 0 on a PCIE port. Add a warning to let users know when the
> invalid configuration is used. We may enforce this more strongly later on once
> we get more clarity on whether we are introducing a bad regression for users
> currenly using the wrong configuration.
> 
> The change has been tested to not break or alter behaviors of ARI capable
> devices by instantiating seven vfs on an emulated igb device (the maximum
> number of vfs the linux igb driver supports). The vfs instantiated correctly
> and are seen to have non-zero device/slot numbers in the conventional PCI BDF
> representation.
> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> CC: mst@redhat.com
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
> index e2eb4c3b4a..47517ba3db 100644
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
> @@ -2121,6 +2122,20 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>           }
>       }
>   
> +    /*
> +     * With SRIOV and ARI, vfs can have non-zero slot in the conventional
> +     * PCI interpretation as all five bits reserved for slot addresses are
> +     * also used for function bits for the various vfs. Ignore that case.

You don't have to mention SR/IOV; it affects all ARI-capable devices. A 
PF can also have non-zero slot number in the conventional interpretation 
so you shouldn't call it vf either.

> +     */
> +    if (pci_is_express(pci_dev) &&
> +        !pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI) &&
> +        pcie_has_upstream_port(pci_dev) &&
> +        PCI_SLOT(pci_dev->devfn)) {
> +        warn_report("PCI: slot %d is not valid for %s,"
> +                    " parent device only allows plugging into slot 0.",
> +                    PCI_SLOT(pci_dev->devfn), pci_dev->name);
> +    }
> +
>       if (pci_dev->failover_pair_id) {
>           if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
>               error_setg(errp, "failover primary device must be on "

