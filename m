Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C252F81A085
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 15:00:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFx6n-0000pk-0O; Wed, 20 Dec 2023 08:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rFx6k-0000pK-0W
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rFx6i-0001x2-92
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703080770;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAXMOqkG3JVWZx8ndWRWE2iZ1NBCt+shYdJ60Oj6CIk=;
 b=AvkDybxv+DNcoFVnlFPP8xVi7xOqQFNjGa2iHtoASh5Bht51kYH1WNNUGF5SUqChW3eQuv
 9nC0H9O9l6lHOPEc8ekL4zZLOMXWDHiGDcDi7vTmP6CPh1Np1W5lCWBhYev+C9nWGy/56Y
 +V4IfRO56C3wIycg1rmGgrdQ7TGCYi8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-eBGnks85NWuvt-FnDR5Hkg-1; Wed, 20 Dec 2023 08:59:28 -0500
X-MC-Unique: eBGnks85NWuvt-FnDR5Hkg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d1ffbc3b8so15677125e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 05:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703080767; x=1703685567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aAXMOqkG3JVWZx8ndWRWE2iZ1NBCt+shYdJ60Oj6CIk=;
 b=iktgHOYp3/Tahjx3vNfWOjBOaWmUmxVEWLETNNgLcCLRb9TxN4wbtBZEwh/khwN5vy
 tbvSz5kcLQapq991v8Wi9cQX3mYPsTDn5yXFRl3bjQq3sHd9Lr68Vo4p/5IPBJsrxiw4
 mFL3zOuFAl9hqLfOZnP7WkSt07zOYOKLn0mbPhJcWQ/4Hjo+xabShj+9bU0qLllLPctt
 ptlcTHi6T5Lk3XQOKyhiB6cbVsQCxJ20PvDe4EMbpAas6PZDyxejhO9vrfbijmI2T1Bw
 jwGYWCO8gJrIddux2bmN0/fnmgecHlayS51VKgo1TIUwWtr4rBIkr5Zhs8wwYeZrUxja
 hQTw==
X-Gm-Message-State: AOJu0YwY5o0lef5eA51Aj+OXCgrQKF63Dniq17u1hYoUqfN7eNA6fd55
 BTbNSpV87mH67aqbJQ47Ptk3huESdnk5OKj1lRlCVWuoI0ooEg2F1OjF03Sg1V75DJmG8sSioiT
 Xs6/TYRHZTPCzvvc=
X-Received: by 2002:a05:600c:3588:b0:40d:1930:d1de with SMTP id
 p8-20020a05600c358800b0040d1930d1demr1347558wmq.373.1703080767203; 
 Wed, 20 Dec 2023 05:59:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAsSrSqOoiokVzNGXpPvjMNsGMK/fWnUZprErZuAmNySotFCzl7WYbQE/bECFvSjX+Cov8cQ==
X-Received: by 2002:a05:600c:3588:b0:40d:1930:d1de with SMTP id
 p8-20020a05600c358800b0040d1930d1demr1347552wmq.373.1703080766862; 
 Wed, 20 Dec 2023 05:59:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bg5-20020a05600c3c8500b0040c4c9c52a3sm7576278wmb.12.2023.12.20.05.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 05:59:25 -0800 (PST)
Message-ID: <26ed00e2-0f55-42fe-b601-ef4dada285ad@redhat.com>
Date: Wed, 20 Dec 2023 14:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Replace basename with g_path_get_basename
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Khem Raj <raj.khem@gmail.com>
References: <20231220135302.932039-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231220135302.932039-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cédric,

On 12/20/23 14:53, Cédric Le Goater wrote:
> g_path_get_basename() is a portable utility function that has the
> advantage of not modifing the string argument. It also fixes a compile
> breakage with the Musl C library reported in [1].
>
> [1] https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/
>
> Reported-by: Khem Raj <raj.khem@gmail.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/container.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 688cf23bab88f85246378bc5a7da3c51ea6b79d9..8d334f52f2438d05f632502e07ffd4dc2ec76cb5 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -869,7 +869,8 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>  
>  static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>  {
> -    char *tmp, group_path[PATH_MAX], *group_name;
> +    char *tmp, group_path[PATH_MAX];
> +    g_autofree char *group_name = NULL;
>      int ret, groupid;
>      ssize_t len;
>  
> @@ -885,7 +886,7 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>  
>      group_path[len] = 0;
>  
> -    group_name = basename(group_path);
> +    group_name = g_path_get_basename(group_path);
>      if (sscanf(group_name, "%d", &groupid) != 1) {
>          error_setg_errno(errp, errno, "failed to read %s", group_path);
>          return -errno;


