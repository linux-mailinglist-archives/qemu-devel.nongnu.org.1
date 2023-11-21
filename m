Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8C7F3634
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:39:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5VeS-00044Q-E0; Tue, 21 Nov 2023 13:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5VeE-00042c-Vo
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:39:01 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5VeC-0005EO-AM
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:38:58 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-544455a4b56so8210118a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 10:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700591932; x=1701196732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UrZSVg/nTM9xK0ktYvJg5LD2s73DYTlBxJ3sJbKjRlc=;
 b=tUcXSRiMQX3MX6xKVW3xYSQt6epqec3PcAFH75XIX/gfhrPx8uw4a4KctlOvowQDRQ
 McJ7jST5t5PZ3/9TBPDq0d5VaTmjILU/ovLJfloCJDIOs+i2kaIWGejIAABwMRUBbWPJ
 eK2jEOLtlf3pMDVjCMuuzzgpsn6ut7y8oO+aUNgmguDYBn4CHF+RlpO+CJ4z4MkX/FH7
 T0zICHazF4uDtANPX1IYxa/pVTzIOqCe4b/Uf+aHcCZYX0RicxFWPVJycO7wJ1/2S6wc
 gsSAyh9QNnMcUW58ivZJ+KOyfYS6odQLGLuDVVu9MFTTB7MqYIBzlcBuNhv4CX3LeX3F
 /XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700591932; x=1701196732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UrZSVg/nTM9xK0ktYvJg5LD2s73DYTlBxJ3sJbKjRlc=;
 b=fKZZnrBtlae+QEAm0/0Xn3JPLoV5KfXX/ijzo8mOeoWWSFuZgQlw7F4vZmW4n+pHU3
 ONtJwF5DzeX/zgpaLK/0zCVDLHYmwy6kuXDGyxwpnd68nPyWe+Nnw/VGcMb7ZDIMZk0+
 /bbhPrWZmL4MAiZaQn/tSJo+JLVxhSsZJK2m8iex4OjTbYMqkGoWMjrvLeEgm+LC/tUv
 XbgqVJC3asHjOh7rL4geq6hFby6G7mi4pVV67/ZC62D3yTg++m/huOPCdGCRlKYkzCD4
 YiivaSNVRB5hnYR/w+Hyuf0CZp9yI96QUwATTFjRGhJtcTcJ1k5Wryza8BMeFJYwcsCJ
 rqcQ==
X-Gm-Message-State: AOJu0YwMbwrBRWat9N5ph9YxjFHsDBnl/Om5spMa1P3jQKQlOcfB0GCH
 r9ho4V4+6U3vmj3XpSGdLzasyA==
X-Google-Smtp-Source: AGHT+IGL1Eun1k/KnVoVsD47q1M8R91a4krwebnL1da9euJ3/pfEzDOq8YMqQJ7JtjdXbo7ASiWrXg==
X-Received: by 2002:aa7:d1d9:0:b0:548:4dc2:7832 with SMTP id
 g25-20020aa7d1d9000000b005484dc27832mr151714edp.23.1700591932219; 
 Tue, 21 Nov 2023 10:38:52 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 h23-20020aa7c957000000b0053dff5568acsm5211379edt.58.2023.11.21.10.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 10:38:51 -0800 (PST)
Message-ID: <9c7b820b-3c36-4d39-953b-1e2ba0db63a6@linaro.org>
Date: Tue, 21 Nov 2023 19:38:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/27] vfio/pci: Introduce a vfio pci hot reset
 interface
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
 <20231121084426.1286987-9-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231121084426.1286987-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Zhenzhong,

On 21/11/23 09:44, Zhenzhong Duan wrote:
> Legacy vfio pci and iommufd cdev have different process to hot reset
> vfio device, expand current code to abstract out pci_hot_reset callback
> for legacy vfio, this same interface will also be used by iommufd
> cdev vfio device.
> 
> Rename vfio_pci_hot_reset to vfio_legacy_pci_hot_reset and move it
> into container.c.
> 
> vfio_pci_[pre/post]_reset and vfio_pci_host_match are exported so
> they could be called in legacy and iommufd pci_hot_reset callback.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/vfio/pci.h                         |   3 +
>   include/hw/vfio/vfio-container-base.h |   3 +
>   hw/vfio/container.c                   | 170 ++++++++++++++++++++++++++
>   hw/vfio/pci.c                         | 168 +------------------------
>   4 files changed, 182 insertions(+), 162 deletions(-)


> @@ -2485,166 +2485,10 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>   
>   static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
>   {

> +    return ops->pci_hot_reset(vbasedev, single);

At this point vfio_iommufd_ops.pci_hot_reset is NULL.
Worth checking for non-NULL before calling.

>   }
>   
>   /*


