Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D976870BEB4
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14xI-0007xR-B4; Mon, 22 May 2023 08:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q14xF-0007xJ-VX
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q14xE-0002KB-IB
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684759679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLPz/huZWiB8Esj1nGd2WSZKhziikSDCqQenVF3o+oM=;
 b=V3+FG70Fue6ldC85yHbLMdcyN1Dtqo8kTuL7Gtk302D7oSR1AQsf0ajq5skP25u247iXl+
 vVRhxD7zUuq8ycDyYD1O3uzJ+WmtOKZIsUkJDtiDWDh/+ISwNohLIa+aR67OByp8ZQdGM3
 DsdA7RinOYj982bBGruIcW/ECdz+Xko=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-CkDaR0DZOWKAd8_P75h5HA-1; Mon, 22 May 2023 08:47:58 -0400
X-MC-Unique: CkDaR0DZOWKAd8_P75h5HA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f39abae298so42123881cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 05:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684759678; x=1687351678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iLPz/huZWiB8Esj1nGd2WSZKhziikSDCqQenVF3o+oM=;
 b=iGdKstVJ50EY2/KUqsXo+AlU6GKeZJME9bKTkb9ITwLAvTHXXz4HZw9DfGw1ElIimq
 DXXl2DDmI3rak2sSlQOLJkbQYvWPE9zu9fB/8dEcUxMjK4H1VQh3ukrCx98XP84tR2De
 4dOfFkrR73RUyafLSwmwa5LEN7OMG9gDlIiwMu3c3URFv5exTDd9x8cZojvegthPKNTM
 MUtPP7bQXWX0fUTVxK0G0+qo9nM8pj4BIVBChnRokiVPQBz6rz6Jh++pbB2iHoEdPe2e
 5/0ldwyvkohJUtkkcjvN7JfpIP6MkQuI/qV4Jb8Kac7BUMnELwpUXBPaP+roMsR5m+r7
 YFyw==
X-Gm-Message-State: AC+VfDwprhT19+8vhqlC2hrEXnSoFxa9AYYJRenou/qya1ml9ScCO8mp
 D7lxF3NlM+lfm/WBQsV0GfyZBeLHC0T1iWhEKrlIdmmw6iXJPYwNiVb3tAE4lSYIVUtEUZ0EtaR
 qv75Baw69Fog/RIg=
X-Received: by 2002:a05:622a:1043:b0:3f5:a33a:cded with SMTP id
 f3-20020a05622a104300b003f5a33acdedmr18724366qte.10.1684759677827; 
 Mon, 22 May 2023 05:47:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JEJcQ7D7wG4bWJ4Ie3jnlCpXEeG4C1k9TB132Hw917btggfieJ8F6WXNjpdO8Vfp6qGJufg==
X-Received: by 2002:a05:622a:1043:b0:3f5:a33a:cded with SMTP id
 f3-20020a05622a104300b003f5a33acdedmr18724350qte.10.1684759677585; 
 Mon, 22 May 2023 05:47:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 cp11-20020a05622a420b00b003e89e2b3c23sm2012492qtb.58.2023.05.22.05.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 05:47:57 -0700 (PDT)
Message-ID: <9ea8cdbb-08c3-b7dc-107c-763e3f6d79ec@redhat.com>
Date: Mon, 22 May 2023 14:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] util/vfio-helpers: Use g_file_read_link()
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20230522114943.33024-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230522114943.33024-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hello Akihiko,

On 5/22/23 13:49, Akihiko Odaki wrote:
> When _FORTIFY_SOURCE=2, glibc version is 2.35, and GCC version is
> 12.1.0, the compiler complains as follows:
> 
> In file included from /usr/include/features.h:490,
>                   from /usr/include/bits/libc-header-start.h:33,
>                   from /usr/include/stdint.h:26,
>                   from /usr/lib/gcc/aarch64-unknown-linux-gnu/12.1.0/include/stdint.h:9,
>                   from /home/alarm/q/var/qemu/include/qemu/osdep.h:94,
>                   from ../util/vfio-helpers.c:13:
> In function 'readlink',
>      inlined from 'sysfs_find_group_file' at ../util/vfio-helpers.c:116:9,
>      inlined from 'qemu_vfio_init_pci' at ../util/vfio-helpers.c:326:18,
>      inlined from 'qemu_vfio_open_pci' at ../util/vfio-helpers.c:517:9:
> /usr/include/bits/unistd.h:119:10: error: argument 2 is null but the corresponding size argument 3 value is 4095 [-Werror=nonnull]
>    119 |   return __glibc_fortify (readlink, __len, sizeof (char),
>        |          ^~~~~~~~~~~~~~~
> 
> This error implies the allocated buffer can be NULL. Use
> g_file_read_link(), which allocates buffer automatically to avoid the
> error.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

There are a few other VFIO routines computing the IOMMU group from sysfs :

   vfio_ap_get_group()
   vfio_ccw_get_group()
   vfio_realize()

May be there is a possible common routine to introduce. Anyhow, this is
beyond the scope of this fix

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   util/vfio-helpers.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 2d8af38f88..e482ab22e2 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -106,15 +106,17 @@ struct QEMUVFIOState {
>    */
>   static char *sysfs_find_group_file(const char *device, Error **errp)
>   {
> +    g_autoptr(GError) gerr;
>       char *sysfs_link;
>       char *sysfs_group;
>       char *p;
>       char *path = NULL;
>   
>       sysfs_link = g_strdup_printf("/sys/bus/pci/devices/%s/iommu_group", device);
> -    sysfs_group = g_malloc0(PATH_MAX);
> -    if (readlink(sysfs_link, sysfs_group, PATH_MAX - 1) == -1) {
> -        error_setg_errno(errp, errno, "Failed to find iommu group sysfs path");
> +    sysfs_group = g_file_read_link(sysfs_link, &gerr);
> +    if (gerr) {
> +        error_setg(errp, "Failed to find iommu group sysfs path: %s",
> +                   gerr->message);
>           goto out;
>       }
>       p = strrchr(sysfs_group, '/');


