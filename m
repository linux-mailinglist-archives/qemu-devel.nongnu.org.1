Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C47C54B9
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYrc-0005Gj-Hn; Wed, 11 Oct 2023 09:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYra-0005GD-Hm
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:02:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqYrW-00085y-47
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:02:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so67270745e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697029368; x=1697634168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vQ2azcHWEBmyaFPuAc4znsqXfbmO/Gytw7rVgC+KCkw=;
 b=XtSVic69YpEkJwcEl9m+wgXpSrXXheKiEcGNF8PXSJCcPJDYwxM9QsSUzNqeELlrYY
 ota1gjUABqoMA5ddP7AW/K8OZvP69mT5EsBX+NSVQ04FLUqEyO1XCoG5v5b5UTov1ByT
 qOmzB3jMClebcBkwliFOfMr4fTtSLx954blPqa9FIK3uH1+sVcgbdEtCzExYuOgAtoVs
 UqLxOaoOUau/1E89kqCVLIkXiIad02d6uBbxHAIIcBzGbo6j1pOHttB9SPWAAAttAll6
 PanwKvjbs2kiaDxdPtTc/R4YL9pQ1z5xP57QfbI4Yt2fi6JkqjoWQbzXG48b7mu5uNH/
 Pt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697029368; x=1697634168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vQ2azcHWEBmyaFPuAc4znsqXfbmO/Gytw7rVgC+KCkw=;
 b=CXdNXvuIVlCMK8F6ZQwsapjnjE4RK/HOSCwrBF0XpoUllDZ5xDFLmljyODl7gU6BOh
 z6f1C0CK9agDrdFpX133oRXLJRSE22UE73daTFPfg1gR9ZJ2PmptY8f/OOFfymKNpI+T
 8dSG2BKuLjwZnqhmgdjh6pdt1YVF0YwGemD8fbs3G3YlxoQtqciBSseREVyIX3Xkpgoy
 PeN3pVeOTDXk5b/V9NMRMmYvvzwvHLik0uYDQfDcxtd5LEl4BDQqZN+J8f7eQ1TlPvZv
 yYwRv2NliIYOmz4qpL7U1dBhb34kwfdkTBx+1OOUq6BRLdNeyuYGv4ZRw31AAmYdzTuX
 eQ6Q==
X-Gm-Message-State: AOJu0YxE5B8iTErhdJ4ez8NVwWc53UTMMBulyxlPy49yv1+c9iuJ4/3O
 u53r1c73KvrVFT2z/USCEXSoYw==
X-Google-Smtp-Source: AGHT+IF3Ap/dMooIG4GXKKWqIu29cJZ/P3DZYX4L/Y6uScirAMxva9Is5em4qqiZDrwy66qcWFjOew==
X-Received: by 2002:a05:600c:c9:b0:405:3dee:3515 with SMTP id
 u9-20020a05600c00c900b004053dee3515mr19530656wmm.27.1697029368088; 
 Wed, 11 Oct 2023 06:02:48 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 4-20020a05600c248400b004060f0a0fd5sm16768168wms.13.2023.10.11.06.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 06:02:41 -0700 (PDT)
Message-ID: <6e3a76ea-af1f-4e45-62b5-32425b6b541f@linaro.org>
Date: Wed, 11 Oct 2023 15:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] vfio/pci: rename vfio_put_device to vfio_pci_put_device
Content-Language: en-US
To: clg@redhat.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, chao.p.peng@intel.com
References: <20230922025223.1091821-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922025223.1091821-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi,

On 22/9/23 04:52, Zhenzhong Duan wrote:
> vfio_put_device() is a VFIO PCI specific function, rename it with
> 'vfio_pci' prefix to avoid confusing.

Why not, but what about the other functions?

$ git grep -F '(VFIOPCIDevice *' hw/vfio/pci.c | grep -vF ' vfio_pci_'
hw/vfio/pci.c:51:static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
hw/vfio/pci.c:52:static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, 
bool enabled);
hw/vfio/pci.c:53:static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
hw/vfio/pci.c:117:static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, 
Error **errp)
hw/vfio/pci.c:175:static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
hw/vfio/pci.c:212:static void vfio_intx_update(VFIOPCIDevice *vdev, 
PCIINTxRoute *route)
hw/vfio/pci.c:260:static int vfio_intx_enable(VFIOPCIDevice *vdev, Error 
**errp)
hw/vfio/pci.c:314:static void vfio_intx_disable(VFIOPCIDevice *vdev)
hw/vfio/pci.c:372:static int vfio_enable_vectors(VFIOPCIDevice *vdev, 
bool msix)
hw/vfio/pci.c:416:static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, 
VFIOMSIVector *vector,
hw/vfio/pci.c:588:static void 
vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
hw/vfio/pci.c:595:static void 
vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
hw/vfio/pci.c:609:static void vfio_msix_enable(VFIOPCIDevice *vdev)
hw/vfio/pci.c:660:static void vfio_msi_enable(VFIOPCIDevice *vdev)
hw/vfio/pci.c:732:static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
hw/vfio/pci.c:754:static void vfio_msix_disable(VFIOPCIDevice *vdev)
hw/vfio/pci.c:788:static void vfio_msi_disable(VFIOPCIDevice *vdev)
hw/vfio/pci.c:802:static void vfio_update_msi(VFIOPCIDevice *vdev)
hw/vfio/pci.c:1263:static void vfio_disable_interrupts(VFIOPCIDevice *vdev)
hw/vfio/pci.c:1281:static int vfio_msi_setup(VFIOPCIDevice *vdev, int 
pos, Error **errp)
hw/vfio/pci.c:1491:static void vfio_msix_early_setup(VFIOPCIDevice 
*vdev, Error **errp)
hw/vfio/pci.c:1573:static int vfio_msix_setup(VFIOPCIDevice *vdev, int 
pos, Error **errp)
hw/vfio/pci.c:1630:static void vfio_teardown_msi(VFIOPCIDevice *vdev)
hw/vfio/pci.c:1645:static void vfio_mmap_set_enabled(VFIOPCIDevice 
*vdev, bool enabled)
hw/vfio/pci.c:1654:static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
hw/vfio/pci.c:1682:static void vfio_bars_prepare(VFIOPCIDevice *vdev)
hw/vfio/pci.c:1691:static void vfio_bar_register(VFIOPCIDevice *vdev, 
int nr)
hw/vfio/pci.c:1717:static void vfio_bars_register(VFIOPCIDevice *vdev)
hw/vfio/pci.c:1726:static void vfio_bars_exit(VFIOPCIDevice *vdev)
hw/vfio/pci.c:1746:static void vfio_bars_finalize(VFIOPCIDevice *vdev)
hw/vfio/pci.c:1810:static void vfio_add_emulated_word(VFIOPCIDevice 
*vdev, int pos,
hw/vfio/pci.c:1823:static void vfio_add_emulated_long(VFIOPCIDevice 
*vdev, int pos,
hw/vfio/pci.c:1906:static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, 
int pos, uint8_t size,
hw/vfio/pci.c:2036:static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, 
uint8_t pos)
hw/vfio/pci.c:2046:static void vfio_check_pm_reset(VFIOPCIDevice *vdev, 
uint8_t pos)
hw/vfio/pci.c:2056:static void vfio_check_af_flr(VFIOPCIDevice *vdev, 
uint8_t pos)
hw/vfio/pci.c:2066:static int vfio_add_std_cap(VFIOPCIDevice *vdev, 
uint8_t pos, Error **errp)
hw/vfio/pci.c:2148:static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, 
uint16_t pos)
hw/vfio/pci.c:2196:static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
hw/vfio/pci.c:2291:static int vfio_add_capabilities(VFIOPCIDevice *vdev, 
Error **errp)
hw/vfio/pci.c:2678:int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
hw/vfio/pci.c:2746:static void vfio_populate_device(VFIOPCIDevice *vdev, 
Error **errp)
hw/vfio/pci.c:2829:static void vfio_put_device(VFIOPCIDevice *vdev)
hw/vfio/pci.c:2865:static void vfio_register_err_notifier(VFIOPCIDevice 
*vdev)
hw/vfio/pci.c:2892:static void 
vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
hw/vfio/pci.c:2924:static void vfio_register_req_notifier(VFIOPCIDevice 
*vdev)
hw/vfio/pci.c:2958:static void 
vfio_unregister_req_notifier(VFIOPCIDevice *vdev)

> No functional change.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3b2ca3c24ca2..b2d5010b9f0e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2826,7 +2826,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       }
>   }
>   
> -static void vfio_put_device(VFIOPCIDevice *vdev)
> +static void vfio_pci_put_device(VFIOPCIDevice *vdev)


