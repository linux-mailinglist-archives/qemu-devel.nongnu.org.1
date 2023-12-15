Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4843814BF6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 16:40:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEAHG-0000Av-I9; Fri, 15 Dec 2023 10:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rEAH7-0000AW-BR
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 10:38:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rEAH5-0007a7-Jd
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 10:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702654729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dStootaGo0hdyo0MQdEBs9nguqkwS0fib79MF49dz24=;
 b=RuUwdxxcEmvA+7mccd2gVqj0BfIBoStTzVqI7Iv4KGitCU0aDhSVCLJ1zK3yxS2KxyH8iL
 l+xka7Y5SrJr8gyuBTYVjY2RMRX0WAk9TP1i88YTTZTV3s+CNdWayVfOWV5+Q+RbDd8i3O
 Rk2Ky1AFxoXDN2WlQ/3K6L5PRjwtvzY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-vbpl8bMzPR2NUifgUcvN5Q-1; Fri, 15 Dec 2023 10:38:48 -0500
X-MC-Unique: vbpl8bMzPR2NUifgUcvN5Q-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-589ce3eb26cso1052683eaf.2
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 07:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702654727; x=1703259527;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dStootaGo0hdyo0MQdEBs9nguqkwS0fib79MF49dz24=;
 b=ee2kxbi8TatQ0N6ynCRc4H9qJCT/K4L36ZbRvI7Em9jzulkHUnFuu5f3ETmItPDSY+
 a4Feut+eKvry3iZxKLPV2uZd/n3VT6QmdYZjXgnUlIILVPJvAF+XDA/JKH88/+VeNk14
 RE9uMcl/Taj6r33Vdfc6MLyz2LZCqn9+7+2nk2Z28WVwi3OzcXowzZjFNcKXPge9/wcs
 WGE6vXraG40R6Nh70xV5QFSqJfdouPzWgoLarIbCME48iXjWf//YfRsBcnxvPA/mnJ6Z
 1kwuXotq+me6LQfId+vO0ogc/+J7MupeE7O3Zz5yioNYz4nxKiAAL9M/xRcxjwZ3MJfu
 R/oA==
X-Gm-Message-State: AOJu0YwptvNAf8OmtLNaCKlF03fEGTXso4H9hlyMMZ7Flj46FZsoMKA+
 Lm3fxkUjxwcg1dltMujnwLZdh6WfDgC5N6BBtREZLleaPpozQmym4ECm/wTAQKoidcfl2andKJ+
 JO+oKw9bgSRGLviZcimEveBw=
X-Received: by 2002:a05:6358:7296:b0:170:17eb:2039 with SMTP id
 w22-20020a056358729600b0017017eb2039mr15199616rwf.34.1702654726553; 
 Fri, 15 Dec 2023 07:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKE2zaJpPC9fRN6snwpNkAKR5viXVyMzA7rug54Nlac0m9QNuNujKc0ZutsYeDx575/bPiCQ==
X-Received: by 2002:a05:6358:7296:b0:170:17eb:2039 with SMTP id
 w22-20020a056358729600b0017017eb2039mr15199583rwf.34.1702654725763; 
 Fri, 15 Dec 2023 07:38:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a0cf789000000b0067ef5732d09sm2506960qvn.50.2023.12.15.07.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 07:38:45 -0800 (PST)
Message-ID: <a699fa76-a60e-4141-880a-87ca16bcecf9@redhat.com>
Date: Fri, 15 Dec 2023 16:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: Include libgen.h for basename API
Content-Language: en-US
To: Khem Raj <raj.khem@gmail.com>, qemu-devel@nongnu.org
References: <20231212010228.2701544-1-raj.khem@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231212010228.2701544-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hello,

On 12/12/23 02:02, Khem Raj wrote:
> Glibc has two implementation one based on POSIX which is used when
> libgen.h is included and second implementation is GNU implementation
> which is used when string.h is included. The functions are no identical
> in behavior. Musl C library does not implement the GNU version, but it
> has provided a declaration in string.h but this has been corrected in
> latest musl [1] which exposes places where it was being used from
> string.h to error out especially when -Wimplicit-function-declaration is
> treated as error.
> 
> | ../qemu-8.1.2/hw/vfio/pci.c:3030:18: error: call to undeclared function 'basename'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> |  3030 |     group_name = basename(group_path);
> 
> clang-17 treats this warning as error by default
> 
> [1] https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
> v2: Add missing link for [1]

Thanks for the fix. The upstream code has changed though and I think we
should be using g_path_get_basename() instead.

Could you please rebase ? Or I will do it in the QEMU 9.0 cycle. This is
too late for QEMU 8.2 anyhow.

Thanks,

C.




> 
>   hw/vfio/pci.c      | 1 +
>   hw/vfio/platform.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c62c02f7b6..f043c93b9e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -19,6 +19,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include <libgen.h>
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 8e3d4ac458..a835ab03be 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -16,6 +16,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include <libgen.h>
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
>   


