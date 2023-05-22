Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6C170BE8C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14oP-0002nh-OR; Mon, 22 May 2023 08:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q14oN-0002n9-DV
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:38:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q14oL-0000RY-Sq
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:38:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-306dbad5182so3919599f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684759127; x=1687351127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GnKvUH7feHZ2H3rqbQkTcOuBoJdl8RGHnOqdNx7vd4U=;
 b=F8IluaxY7rtoamKg8xyfLjMzwt0m2jVr+iOSOYKjjNhntlgAc8e2jprbIQhyGMknve
 Zol6mhFbIitmG2tEqGEz6L8zWyIJpqsGbEZ21a04GMSuSHj9jxm9UZ5+PRMhcb0d76Ub
 AlmnoOg5afbfUkHE7cG3mCjM0Kvo1JA53174c7kUGPb1G59akM9z65emWZpMaDiho4DA
 pHbAffuFnukWUdzzrFd0jcpVE3Dq6RDE+XygroHE2/orgxqH/uRw9P/PULwfkGaOa27Z
 fHkU/FRXaYmtFdBzQG/cBwAKwMHDpVqWntBF69Pb9c86opyvNSK35qxREPzFI29JoZHs
 k1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684759127; x=1687351127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GnKvUH7feHZ2H3rqbQkTcOuBoJdl8RGHnOqdNx7vd4U=;
 b=ejhNzuvw3PKie4fa1T68/4XdyT440FK+WEBZjSFwsI409abB0Et8lY0/CSo6/fEpEf
 MybfWSBB/dYqRFM6mbMpA4/PJu1ZOpq/yDas5nixi38TMFdVymtBG7XiTTuCBLO4EKt1
 Qv58gKlqY+6bSL9ffr/m3wg1Oh6gnOq5GYjBnEEdd6YnC7EJLrudygPisgYbTVI6ygGO
 DnmnJGdS8kgLQ+LejWLY3qIjtiMdmbzlcfRP4t9jUmwHVxYJHnxk/DmjZ+HZsLoWXx43
 bnRLFParWqoOIHekzgMudkC2Tndfx5LpZr0L/JbVnm/np7FeLdcRJmxZsDNXINq+7jaB
 QGJQ==
X-Gm-Message-State: AC+VfDx/vixZURANvuqoXj2K/FtpzCcxRGdc0hyC3CfjPQOK7XG9F0kJ
 GXOiEpE2LD0zJdbMesBxNTPJMQ==
X-Google-Smtp-Source: ACHHUZ4QXrZGiHYAe8iNrG01eCLCYiuCNL2G/FT1IKMKvzEdU5YF2gsPFpvQzilcIvC4Vx2Kspsd8w==
X-Received: by 2002:a05:6000:45:b0:306:2b40:1258 with SMTP id
 k5-20020a056000004500b003062b401258mr7142166wrx.21.1684759126881; 
 Mon, 22 May 2023 05:38:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b00304adbeeabbsm7582968wro.99.2023.05.22.05.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 05:38:46 -0700 (PDT)
Message-ID: <ccdf88d1-54de-453f-b600-1f0f562aae31@linaro.org>
Date: Mon, 22 May 2023 14:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] util/vfio-helpers: Use g_file_read_link()
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
References: <20230522114943.33024-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230522114943.33024-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 22/5/23 13:49, Akihiko Odaki wrote:
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

Shouldn't this also be NULL-initialized (other picky compilers)?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

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


