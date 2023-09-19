Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680E87A67EF
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qicXQ-0006E3-3Z; Tue, 19 Sep 2023 11:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qicXN-0006DV-G2
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qicXL-0004Sz-RQ
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695136874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7CO/lb7KilwnXJPE+0AB114X6X5LX606QVNzF6aWrI=;
 b=eR5X72l9Efigvp/V75IRZ7rqUmAKrEJd+X5p/zU8Plev3AsJxNoYWbHrzaZ9QtBuSyZHm1
 Ro9zn96Y2wrwVsPw0kq0HohaSBQQuntSB8Ub1LTxlZFXJqyClDFJIPoaFoFizvQpl47DDI
 PE/ZzutKCr43x0enwwA0xonwwV6xAZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-mt8nQYHUMAu3mW9QKynEnw-1; Tue, 19 Sep 2023 11:21:13 -0400
X-MC-Unique: mt8nQYHUMAu3mW9QKynEnw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4051d5b2d87so2310625e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136872; x=1695741672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/7CO/lb7KilwnXJPE+0AB114X6X5LX606QVNzF6aWrI=;
 b=aP/1vqcY7hdjoIwes4KH2zDxKjCzzvBz0jNZWFVQi1XGGpuFRtfV5b969qNMUCzm1L
 QX4tQHlsT3qpsHgNNzq21tB/BM2ExcEM1BBEyXaljhHcfnDx92rErWepXCrF7xs1t82Q
 6G2f8zs2nFsU28hlfj8uO4qXL7jealgHLVFBqZLWP26AysErCySJUpscTrsz3cQGMU90
 fM2PyGBWFaCRgVSAKU4wNwWWggjtwLJeLQkuf82CQO/ausizX6il7uYbD1/ZcnNenDRL
 1TvbiY6oSylIA6smrwqn5uuWcyLq24FMGFtpGEs5bYqWhkW1YFMRlpx8dXUQoFFIEpjp
 b6Gw==
X-Gm-Message-State: AOJu0YzBOttcf3sD4A0rU1qjI1ioSgmJphtsz/STkNtcUkRw4rmkQuWs
 CiJaBeMSbffgN5a2AMPAWS0T0SgC6FvKUpMj7MCTkx6kHplTjHtfcOvqXNuJJt/+KDXAhJE4Xkn
 jrsVcZ4wEfpgsa70=
X-Received: by 2002:a05:600c:21ce:b0:401:519:d2 with SMTP id
 x14-20020a05600c21ce00b00401051900d2mr97451wmj.23.1695136872322; 
 Tue, 19 Sep 2023 08:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/QpktyHSkVGXQaQWLJXKprxaw8J/WpinvrIhr0d9xuQgAD1Zk1Sev5BxFDfpcoHNgGD7eHw==
X-Received: by 2002:a05:600c:21ce:b0:401:519:d2 with SMTP id
 x14-20020a05600c21ce00b00401051900d2mr97428wmj.23.1695136871938; 
 Tue, 19 Sep 2023 08:21:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a05600c014b00b00400268671c6sm15597979wmm.13.2023.09.19.08.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 08:21:10 -0700 (PDT)
Message-ID: <51e23d99-3077-3884-b79e-fce5605d1ca2@redhat.com>
Date: Tue, 19 Sep 2023 17:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] vfio/pci: enable MSI-X in interrupt restoring on
 dynamic allocation
Content-Language: en-US
To: Jing Liu <jing2.liu@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, kevin.tian@intel.com,
 reinette.chatre@intel.com, jing2.liu@linux.intel.com
References: <20230918094507.409050-1-jing2.liu@intel.com>
 <20230918094507.409050-5-jing2.liu@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230918094507.409050-5-jing2.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/18/23 11:45, Jing Liu wrote:
> During migration restoring, vfio_enable_vectors() is called to restore
> enabling MSI-X interrupts for assigned devices. It sets the range from
> 0 to nr_vectors to kernel to enable MSI-X and the vectors unmasked in
> guest. During the MSI-X enabling, all the vectors within the range are
> allocated according to the VFIO_DEVICE_SET_IRQS ioctl.
> 
> When dynamic MSI-X allocation is supported, we only want the guest
> unmasked vectors being allocated and enabled. Use vector 0 with an
> invalid fd to get MSI-X enabled, after that, all the vectors can be
> allocated in need.
> 
> Signed-off-by: Jing Liu <jing2.liu@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
> Changes since v1:
> - No change.
> 
> Changes since RFC v1:
> - Revise the comments. (Alex)
> - Call the new helper function in previous patch to enable MSI-X. (Alex)
> ---
>   hw/vfio/pci.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 0117f230e934..f5f891dc0792 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -402,6 +402,23 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>       int ret = 0, i, argsz;
>       int32_t *fds;
>   
> +    /*
> +     * If dynamic MSI-X allocation is supported, the vectors to be allocated
> +     * and enabled can be scattered. Before kernel enabling MSI-X, setting
> +     * nr_vectors causes all these vectors to be allocated on host.
> +     *
> +     * To keep allocation as needed, use vector 0 with an invalid fd to get
> +     * MSI-X enabled first, then set vectors with a potentially sparse set of
> +     * eventfds to enable interrupts only when enabled in guest.
> +     */
> +    if (msix && !vdev->msix->noresize) {
> +        ret = vfio_enable_msix_no_vec(vdev);
> +
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
>       argsz = sizeof(*irq_set) + (vdev->nr_vectors * sizeof(*fds));
>   
>       irq_set = g_malloc0(argsz);


