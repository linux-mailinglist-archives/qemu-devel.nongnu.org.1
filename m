Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7381A5E4
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 18:03:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzxQ-0003Cw-Ak; Wed, 20 Dec 2023 12:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rFzwy-00031m-U9
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rFzws-0004nT-Il
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703091684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/5POCAtg47nzQUQRrkRHrtQ1PNbAQBl2558GYwjRjw=;
 b=fc1BfsDOXCsvdRnrf1UL7pfC35PXR0pI3NltenfcX+0oZTyVekhIMSNRcaUzTYESum9hLg
 2vaQ1HfQzITxjNjiWG6lztdarcGoGGy1zScqvJkVIHTIwQUVBDutZsOyvOOElGpTgY3B7Y
 ebi5ZXQhSMqu+ynqxu29+s3kHt1ur90=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-BVL9AOIvNWK0460OciGQBw-1; Wed, 20 Dec 2023 12:01:23 -0500
X-MC-Unique: BVL9AOIvNWK0460OciGQBw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40c3f0f88e3so45277045e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 09:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703091681; x=1703696481;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/5POCAtg47nzQUQRrkRHrtQ1PNbAQBl2558GYwjRjw=;
 b=QtROdT6FxpN0uWisXEMinR+AqskSK0ijvnJITZPL3q8/YADhMQo9BKrPxKgRAXpw+B
 Ob1t1MtMDsTUsC7edkqjIyUFMeOBAY38ODA1Xq5rrVHM2xOl5gpNYmJSyko7VNH96nnn
 UMnBrn9vdqgWLLkF6UT1iBVaDc8mBwb9MXZVS0pBjY5DpwMiaFQQLoLKcp76gtV7oa+M
 QIRwbuFijfx0cSbhw6ntEoGyceCKgu5iL3ZmkwMhi1np6owfleVcOK9g6Er810Da2/+h
 et7caM+Kb2sVgyPRL49JcPhhk28YHbjB4AJW/Z6uJWL2q+YTvsXrodG3lup5QxqtNw5E
 3uaA==
X-Gm-Message-State: AOJu0YxTt50oaNmRSfZbYPw7XyeG7DR7S7TsY0D0M8sC/jsVynq9iIEB
 /+TWN+ff3KSPvNhHRsa+FQQpXdDKo8C+lOkjUS9qpxCyLU1IwFDhNE3QXkeUbx7hApACd3jZLUS
 IJCOKZs1Y18wQqd+iqS4NPmwrU5wzf8j53d8qkvWnmPZd+GqB6RFI+wpSqw3KJ9VlOVW1
X-Received: by 2002:a05:600c:511e:b0:40d:3712:2d2e with SMTP id
 o30-20020a05600c511e00b0040d37122d2emr650969wms.170.1703091681449; 
 Wed, 20 Dec 2023 09:01:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN4qhCKG5wfpHSVzjpLirf064AHqdb3KfUzDnFIGiB3qWLPS3/urozyoEYb1rrwfff0sDFWQ==
X-Received: by 2002:a05:600c:511e:b0:40d:3712:2d2e with SMTP id
 o30-20020a05600c511e00b0040d37122d2emr650943wms.170.1703091680825; 
 Wed, 20 Dec 2023 09:01:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 be8-20020a05600c1e8800b0040b397787d3sm8439587wmb.24.2023.12.20.09.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 09:01:20 -0800 (PST)
Message-ID: <4f953afd-07be-483a-b50d-31aac5ff2743@redhat.com>
Date: Wed, 20 Dec 2023 18:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Replace basename with g_path_get_basename
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Khem Raj <raj.khem@gmail.com>
References: <20231220135302.932039-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231220135302.932039-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/20/23 14:53, Cédric Le Goater wrote:
> g_path_get_basename() is a portable utility function that has the
> advantage of not modifing the string argument. It also fixes a compile
> breakage with the Musl C library reported in [1].
> 
> [1] https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/
> 
> Reported-by: Khem Raj <raj.khem@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


Applied to vfio-next.

Thanks,

C.


> ---
>   hw/vfio/container.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 688cf23bab88f85246378bc5a7da3c51ea6b79d9..8d334f52f2438d05f632502e07ffd4dc2ec76cb5 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -869,7 +869,8 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>   
>   static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>   {
> -    char *tmp, group_path[PATH_MAX], *group_name;
> +    char *tmp, group_path[PATH_MAX];
> +    g_autofree char *group_name = NULL;
>       int ret, groupid;
>       ssize_t len;
>   
> @@ -885,7 +886,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>   
>       group_path[len] = 0;
>   
> -    group_name = basename(group_path);
> +    group_name = g_path_get_basename(group_path);
>       if (sscanf(group_name, "%d", &groupid) != 1) {
>           error_setg_errno(errp, errno, "failed to read %s", group_path);
>           return -errno;


