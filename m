Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445F47427BE
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:53:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErP6-00017X-74; Thu, 29 Jun 2023 09:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qErP2-00017B-PY
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qErOz-0004pJ-IJ
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688044175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4iL2L51R706kRINayTApCsU6VaO9jOu+xP4HiK45Sa8=;
 b=Mj9fisOas1j8K1XT+MT1VK2DUT/XpqbeYPfhY9zy83DHaBD9t817Gmn2BFmMXJgNOTtFJl
 KnM6GlG/FemS3t0Z9PCFHhh5+gClV37GyDwhsjgsS4a1NTa+t3dnrn4m+MRRvYL4QVcrGP
 veRjF2kgUK8jPNUaM/Mu+fT5YB2vF2I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-XXgImOAtMNiIZU2Nywzs6w-1; Thu, 29 Jun 2023 09:09:33 -0400
X-MC-Unique: XXgImOAtMNiIZU2Nywzs6w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fab61bb53bso625441e87.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688044172; x=1690636172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4iL2L51R706kRINayTApCsU6VaO9jOu+xP4HiK45Sa8=;
 b=VhBqbu+OiI4pWcrIDcztPHaR+S6BdiOJLODUNg/NGLgio/aIUA77NeEU0tkBfnC2tx
 fJdO7iebsfb1wxFCErofUw9x80H4OHiiXtnutPyRd2PMCrWFWKEfv4oj2jQO2j9Os1vx
 MfFfHduEvoQtM1JeaSKVxMCn3ROGzyXYPanRDXG68/t/S7xsxNVniyMOmVHxoL35zL/I
 T08Nld6l43IaRrGPSvDTg9b5UPTC0E8ykRWynNXR+whXDHCdYuoj5bMHGzTErdSLJgbr
 h5Ygg61lJv1cNJpGoejySpArejXbCtNjnt7qQZJWFkVQWlG/qC7AWED6rMB5kHI6LVCG
 UVBQ==
X-Gm-Message-State: AC+VfDwn8+LamtzY2Sa+CRUZ8EsX01L6rBlQlOHoIZfxkWD6D7OpY0S0
 0sNMGkhHS+gm4Y0+uHhf4tXaIjUKWrCciwdrLNFSqMzJWNNx2DtDY17Yp5l4AGotpJfYmiKhzpc
 FZ3mpOtFm/KgzOns=
X-Received: by 2002:ac2:5e2e:0:b0:4fb:91c5:fd38 with SMTP id
 o14-20020ac25e2e000000b004fb91c5fd38mr3076694lfg.0.1688044172072; 
 Thu, 29 Jun 2023 06:09:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Xs4wIqFJLnwKO29MiinVLhhiAgC19qsVu4QmMIolBc5GKZUqS8mu5tKwjG9tu7cs+1DPJ7A==
X-Received: by 2002:ac2:5e2e:0:b0:4fb:91c5:fd38 with SMTP id
 o14-20020ac25e2e000000b004fb91c5fd38mr3076675lfg.0.1688044171769; 
 Thu, 29 Jun 2023 06:09:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 x11-20020adfdd8b000000b00313ecd3714csm13045133wrl.19.2023.06.29.06.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 06:09:31 -0700 (PDT)
Message-ID: <32af1e45-bb9a-e20a-cf1b-5f1e07b9f6a3@redhat.com>
Date: Thu, 29 Jun 2023 15:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/5] vfio/pci: Free leaked timer in vfio_realize error
 path
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-3-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230629084042.86502-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/29/23 10:40, Zhenzhong Duan wrote:
> When vfio_realize fails, the mmap_timer used for INTx optimization
> isn't freed. As this timer isn't activated yet, the potential impact
> is just a piece of leaked memory.
> 
> Fixes: ea486926b07d ("vfio-pci: Update slow path INTx algorithm timer related")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 48df517f79ee..ab6645ba60af 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3224,6 +3224,9 @@ out_deregister:
>       if (vdev->irqchip_change_notifier.notify) {
>           kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>       }
> +    if (vdev->intx.mmap_timer) {
> +        timer_free(vdev->intx.mmap_timer);
> +    }
>   out_teardown:
>       vfio_teardown_msi(vdev);
>       vfio_bars_exit(vdev);


