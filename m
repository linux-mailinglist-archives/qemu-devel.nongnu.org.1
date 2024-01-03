Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204F82312C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 17:20:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3xh-0004GP-KN; Wed, 03 Jan 2024 11:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rL3xf-0004Fv-Ev
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 11:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rL3xe-0004LD-1C
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 11:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704298755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=212ITiRxNjcGyHWymbYilt7MUtvaXcO4GXxvBCj/JcQ=;
 b=CYmMa/+im6Xt1G8Wgp5i2W6LIuVCnjKpO96fhdXf4TnCro/SBOhJFktFLn+B6e7SmphNju
 TkJENNd9Nj01zjn/Z4fY4tGRLWJBQRlT1ZjfwshPg0j+Ad4hjRzWLG+8BlZw4yXUhx8zCc
 Z8PvNiIPtWhJ4ywqK+8fukqw9alCBH0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-oA1mhxngPomK3lmdnK3xtA-1; Wed, 03 Jan 2024 11:19:14 -0500
X-MC-Unique: oA1mhxngPomK3lmdnK3xtA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d8f402742so7821695e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 08:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704298753; x=1704903553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=212ITiRxNjcGyHWymbYilt7MUtvaXcO4GXxvBCj/JcQ=;
 b=Rpmn4RxNQSv1puwb+62oNpQvJdOt5hXwDYjEvP05Sn8KiouhgO0UEYkh1m6dLo4oPc
 33MobbGAkdQhnVbYSn3YGqiyZLzKcmAJtaSq4IyB1v/s2QC/BKUc29pXTMrNj+oBC86O
 HSQwu/h7Ja/HSfd+3Eefsoo4fu+bgp0GaHKBaG1oKxMZEg7fHAjkDmjXe9xecaN+iU6K
 90+/ErnQy8Ip7fgsXlleI3+67FqGOli1ULgiQvmN8lx6jmYQDuYEOFCHnRfkiRBpBnF7
 ON+aZeAjMJmdBJH1m6QwpMtktWZoaipeUgELyf8QjXTp66fvSptcbFCkDKqDtUgsgKCI
 ez2A==
X-Gm-Message-State: AOJu0YzuuCUkXOOFBUCOwwmf+FopCDtaJrl5PrkBFh+aqkxlapp/X7Ok
 LhTM3hMnDVwFjUUGo+Bq29TaiXUbx5kjZt864Evzn2UV8ndzdU6divJ5rCUeWuzxAwzsdfJdVNu
 4nQZp7dkWA0vfjmGGko50/qQ=
X-Received: by 2002:a05:600c:21c3:b0:40c:2b24:325e with SMTP id
 x3-20020a05600c21c300b0040c2b24325emr11023779wmj.184.1704298752988; 
 Wed, 03 Jan 2024 08:19:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBJ8czDuGcFQQzylQH65TYgXCL1Z7pOs3IfEml9LiA7VNBy2A/ad6DuoGP1JV9HTKULb2CKg==
X-Received: by 2002:a05:600c:21c3:b0:40c:2b24:325e with SMTP id
 x3-20020a05600c21c300b0040c2b24325emr11023775wmj.184.1704298752679; 
 Wed, 03 Jan 2024 08:19:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a05600c475500b0040d1746f672sm2778098wmo.14.2024.01.03.08.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 08:19:11 -0800 (PST)
Message-ID: <5fc10365-1a0e-4bb0-85f5-c48794dae973@redhat.com>
Date: Wed, 3 Jan 2024 17:19:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: fix iteration over global VFIODevice list
Content-Language: en-US
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20231229203854.8281-1-vr_qemu@t-online.de>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20231229203854.8281-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Volker,

On 12/29/23 21:38, Volker Rümelin wrote:
> Commit 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
> introduced a global VFIODevice list, but forgot to update the list
> element field name when iterating over the new list. Change the code
> to use the correct list element field.
> 
> Fixes: 3d779abafe ("vfio/common: Introduce a global VFIODevice list")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2061
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric
> ---
>  hw/vfio/common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 08a3e57672..3ba892d7d3 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -74,7 +74,7 @@ bool vfio_mig_active(void)
>          return false;
>      }
>  
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>          if (vbasedev->migration_blocker) {
>              return false;
>          }
> @@ -95,7 +95,7 @@ static bool vfio_multiple_devices_migration_is_supported(void)
>      unsigned int device_num = 0;
>      bool all_support_p2p = true;
>  
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>          if (vbasedev->migration) {
>              device_num++;
>  
> @@ -1367,13 +1367,13 @@ void vfio_reset_handler(void *opaque)
>  {
>      VFIODevice *vbasedev;
>  
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>          if (vbasedev->dev->realized) {
>              vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>          }
>      }
>  
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>          if (vbasedev->dev->realized && vbasedev->needs_reset) {
>              vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>          }


