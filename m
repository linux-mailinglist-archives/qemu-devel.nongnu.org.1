Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49557821823
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 08:54:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKZao-0003ET-Fd; Tue, 02 Jan 2024 02:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKZan-0003EL-36
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 02:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rKZae-0000op-So
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 02:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704182011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+to6rLHY4Y6uREodACU2Juio6cqC/ZDA6clxC61XDcI=;
 b=LBboaeR31CyDG1/VBDd00nRASpSPUGNJ4fLLYpIxtQjgbNOsChlEjckWepcJqRHoCwEJqu
 rQHfZ7z9heF1luYyt/dui6USISdUeX2DRb9608HVevUIta4kvN+iGcLVP6Fi22D6XvsvUe
 SfiW8ut/nkGphNTfTC9EMefnYa+qEsU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-97TCSzekNGO9NUfVcD7olg-1; Tue, 02 Jan 2024 02:53:29 -0500
X-MC-Unique: 97TCSzekNGO9NUfVcD7olg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-680139b198aso156825296d6.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 23:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704182009; x=1704786809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+to6rLHY4Y6uREodACU2Juio6cqC/ZDA6clxC61XDcI=;
 b=RoGTWP/MLQW4v/HmQJLdXju+WuEgKczhfHelkUYkD4hGigXoNYZMuYwt+yASz6MiGL
 AvhVfCtnLLICrUXhJV0/nIwb2B27t4WyYcg8iO0ddGo7zfJpyAZXnerhXQPv+r71KDa8
 sOPvCZk8hMURFE0bp/OqzZnbcwrRcZFwC4TF1/q1RPg8Xk4/ao3sjQZ3AMzKW6klWbTe
 u87jEvYFssxAn4C7gOypFg99hn5EEyhD279xgBVdZ+ax37EAJddymVZPiNY1Itk872+E
 CZ2wbOeNxJlhExJwxj5fWAjWsYJxUcueGS1i2L6/R+mpmoEp47htm6fDUXHLhn4g/P51
 dqeg==
X-Gm-Message-State: AOJu0Yw1E8zoa6WQMUaVLgczEWRMJD5k2NdTYdaCq2LTXoog+yywkA6r
 XidlwASzjO+Vfzy135bDuzq9tcMM6DN66XTdO8doTV+Pted6YcWh9XOgaMBzEhffU29IrdowtKU
 hHdJxzekgMXiTK/Ll1GqOjDw=
X-Received: by 2002:a0c:f889:0:b0:67f:c4ab:dd with SMTP id
 u9-20020a0cf889000000b0067fc4ab00ddmr14777443qvn.70.1704182008848; 
 Mon, 01 Jan 2024 23:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHxG++IIRQ45I2pd6AYfQGMFNVHiWgZUBee51kJ6uCTLCVmL1OYbaP26kk7ZSTtZ8/WJPG/w==
X-Received: by 2002:a0c:f889:0:b0:67f:c4ab:dd with SMTP id
 u9-20020a0cf889000000b0067fc4ab00ddmr14777441qvn.70.1704182008589; 
 Mon, 01 Jan 2024 23:53:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a05621412d800b006805bd3058asm4939868qvv.75.2024.01.01.23.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jan 2024 23:53:28 -0800 (PST)
Message-ID: <553a56f1-04cc-41b0-b880-cc0586d62d30@redhat.com>
Date: Tue, 2 Jan 2024 08:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: fix iteration over global VFIODevice list
Content-Language: en-US
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20231229203854.8281-1-vr_qemu@t-online.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231229203854.8281-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.246,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/29/23 21:38, Volker Rümelin wrote:
> Commit 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
> introduced a global VFIODevice list, but forgot to update the list
> element field name when iterating over the new list. Change the code
> to use the correct list element field.
> 
> Fixes: 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2061
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 08a3e57672..3ba892d7d3 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -74,7 +74,7 @@ bool vfio_mig_active(void)
>           return false;
>       }
>   
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>           if (vbasedev->migration_blocker) {
>               return false;
>           }
> @@ -95,7 +95,7 @@ static bool vfio_multiple_devices_migration_is_supported(void)
>       unsigned int device_num = 0;
>       bool all_support_p2p = true;
>   
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>           if (vbasedev->migration) {
>               device_num++;
>   
> @@ -1367,13 +1367,13 @@ void vfio_reset_handler(void *opaque)
>   {
>       VFIODevice *vbasedev;
>   
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>           if (vbasedev->dev->realized) {
>               vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>           }
>       }
>   
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>           if (vbasedev->dev->realized && vbasedev->needs_reset) {
>               vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>           }


