Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A07475B6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiMn-0000bi-9M; Tue, 04 Jul 2023 11:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGiMl-0000bY-5J
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qGiMj-0008Pv-L3
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688486096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNHrYYWRc2EqjLlmGE/4xOjf57OuHQoOgIqxlDLIl8Y=;
 b=KwGoLiIIM3hSsDRAGgqG38DEKg/7BCmaja3z3j1YpK1e0egg9OLwuMhz7lnal7KehFXiAL
 ensn2Fe9tqghYt0SI8re/wP7nf1p+txdJ55TDz5oNJjMJ1kgrmk/atOnof+BQute/GEx5s
 qUozypkNRTe0GcoZaDtuSzK1h5ij9XQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-FUHFz9itMoay8rg3TwFLOg-1; Tue, 04 Jul 2023 11:54:55 -0400
X-MC-Unique: FUHFz9itMoay8rg3TwFLOg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-635dce11cb0so56372646d6.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688486095; x=1691078095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NNHrYYWRc2EqjLlmGE/4xOjf57OuHQoOgIqxlDLIl8Y=;
 b=kdyHecHQCLRlrcZ2Crqz8mdPiW2hVzLg1Rb4TBBi0/9CRyv28Rf1Nlfp4905sGAK8+
 foL3TgAdSlj6CWWD1/jjWBuzxuy3XzXZ/xfaPQENrCBlZn0Vf4p7Sz9VAaQppX1khbCC
 eskYvT2Q4EnawpM9jjWybYL1eLIEQ8x2lchqb+OJxhw+75kEnW+0jtaKkFGxCPKTtaha
 Htdn9RN3XKSw7OWi3SI0H9nzkctsEwuNC2OnmS/yk6gZOaLiPBv63sy2rtTBq2BPlc0Q
 FvTqsR2XsT6sDZDRZElvDJCdr2aAJBmxcqYKUIaYKmzuTmrH4PXGSnv/ajistzH3uYL/
 tvLw==
X-Gm-Message-State: ABy/qLYSruoP0Ed/zZWMHV8HdwcbPzneCnBHQfjRIjG9L/xk/yarzvVC
 J3Xgo95uJfaWtko7gq4zqILEd8DfFxaFH0FB1wfr0X/ZNV5BuPdAyAcvuOAp6WfA6qd5sAnyf16
 GnAvxG/g5gjETjuc=
X-Received: by 2002:a05:6214:d69:b0:630:2117:9628 with SMTP id
 9-20020a0562140d6900b0063021179628mr17892068qvs.8.1688486094890; 
 Tue, 04 Jul 2023 08:54:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGyV/pTKX5VVHz+KLRRE1Fm40bzjKI5+Kn97pywo/ts6Qw4TFgO0B1S8mmhlayNewyDnWRHjA==
X-Received: by 2002:a05:6214:d69:b0:630:2117:9628 with SMTP id
 9-20020a0562140d6900b0063021179628mr17892053qvs.8.1688486094620; 
 Tue, 04 Jul 2023 08:54:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 g10-20020ad4510a000000b0063623c266easm6487472qvp.3.2023.07.04.08.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 08:54:54 -0700 (PDT)
Message-ID: <4795eb6d-7409-0e1b-9c17-ad31718e3170@redhat.com>
Date: Tue, 4 Jul 2023 17:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230704133927.24677-1-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230704133927.24677-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hello Avihai

On 7/4/23 15:39, Avihai Horon wrote:
> vfio_realize() has the following flow:
> 1. vfio_bars_prepare() -- sets VFIOBAR->size.
> 2. msix_early_setup().
> 3. vfio_bars_register() -- allocates VFIOBAR->mr.
> 
> After vfio_bars_prepare() is called msix_early_setup() can fail. If it
> does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
> allocated.
> 
> In this case, vfio_bars_finalize() is called as part of the error flow
> to free the bars' resources. However, vfio_bars_finalize() calls
> object_unparent() for VFIOBAR->mr after checking only VFIOBAR->size, and
> thus we get a null pointer dereference.
> 
> Fix it by checking VFIOBAR->mr in vfio_bars_finalize().

Did you see the issue by reading the code or did you actually crash
QEMU with a test case ?

> 
> Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> 
>   Changes from v1:
>   * Assert VFIOBAR->size and set VFIOBAR->mr to NULL to make the code
>     more accurate. (Philippe)
>   * Small reword in the last paragraph of the commit message.
> 
>   hw/vfio/pci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab6645ba60..bc98791cbb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1752,9 +1752,11 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
>   
>           vfio_bar_quirk_finalize(vdev, i);
>           vfio_region_finalize(&bar->region);
> -        if (bar->size) {
> +        if (bar->mr) {
> +            assert(bar->size);
>               object_unparent(OBJECT(bar->mr));
>               g_free(bar->mr);
> +            bar->mr = NULL;
>           }
>       }
>   


