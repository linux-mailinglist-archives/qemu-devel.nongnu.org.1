Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C00830768
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 14:57:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6PZ-0000q0-IX; Wed, 17 Jan 2024 08:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6PX-0000iW-EG
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:56:55 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6PV-0008Cn-OF
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 08:56:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e86a9fbd9so13883085e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 05:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705499812; x=1706104612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tX0Wn3FsK+LlbKYrZIPiRnarBaM6iF5GJpGxtz00ILc=;
 b=vylh+cDwJlxBS0Iu1RwIxka3AE2DcVg9YKG2pF7ml3GqZ0aT3yNDfv6ARnzSJd/BM6
 XgIGqMxxF3qKF9aWPlKkstlvSZnvWSw/uzVa/EcysN7y6eMSg/EHXWBnPZKL8h8YBmdW
 EjdQxVEpnU5nd6J4BrPnweEJQrfKmKUoPCuxDGhBiDoMU5Uvas0Yu4chcgAOnIEGxlE7
 4n6UROQXY7GPC6Y872kO3d6Vi8CehhCHBlyc8LPZTiApgdURfy/ERlBMjTna1Kwhczw0
 ++ARpXPejYCkepR3GisAlA66Lg9DSkP24PVaasdkLQgXOMiCxmyH+3NTwy6bZRH4RrtO
 8aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705499812; x=1706104612;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tX0Wn3FsK+LlbKYrZIPiRnarBaM6iF5GJpGxtz00ILc=;
 b=un+IUqdSH3UCd/RXaPY9ubcAdAicASfNWF8so1ZYLEMFGbhC8JiL0RcIImgASSACtk
 Zb/WYRUPa2QNgimBFY4WQY6f/OhE1ylPSXgeK0NqCEZmm1+0CMLZCNij7M4atiGrE6Za
 qAD0IRUIEIFkm6fQStRXRswRleWdA7f/e3sf6pat1ZO2iwpGrrIFqPHqVC41D5kiKy3m
 Mhu2gmDISjvFqpeEGGw3OvsZut0KPearbVxQPUaOaCzOSlirfVNE0QRdQ+IUKACN/y7Y
 2w1lz4eWj7FDXHGOJUyL4mWrHS5cC3hlIQRGoCtnIivwcPI/37upHKbqZf+t//lv+/Um
 NFPA==
X-Gm-Message-State: AOJu0Yxr64bwunseegmSphF+dhmwHLDUXONvhnNTm69WHG75JQH5IhRx
 +kHmsK5rcbAM68Xy4IoKJorqYaetWjnQ2mdFEAnKHoykZnk=
X-Google-Smtp-Source: AGHT+IGvjOQRN7NlgagacDbBwHyDMrN8v20OH82oC3sA6R3aUZzt+oCOSE9gePUIOwKCpYKzroWqPQ==
X-Received: by 2002:a05:600c:2315:b0:40e:52cf:3c2c with SMTP id
 21-20020a05600c231500b0040e52cf3c2cmr4828635wmo.73.1705499812121; 
 Wed, 17 Jan 2024 05:56:52 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b0040e4733aecbsm22527615wmq.15.2024.01.17.05.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 05:56:51 -0800 (PST)
Message-ID: <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
Date: Wed, 17 Jan 2024 14:56:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Avoid multiple definitions of copy_file_range
Content-Language: en-US
To: Manolo de Medici <manolodemedici@gmail.com>, qemu-devel@nongnu.org,
 bug-hurd@gnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Manolo,

On 17/1/24 13:31, Manolo de Medici wrote:
> It's already defined as a stub on the GNU Hurd.

Meson checks for this function and defines
HAVE_COPY_FILE_RANGE if available, see in meson.build:

   config_host_data.set('HAVE_COPY_FILE_RANGE',
                        cc.has_function('copy_file_range'))

Maybe some header is missing in "osdep.h" for GNU Hurd?

> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..05426abb7d 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1999,7 +1999,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>       return handle_aiocb_write_zeroes(aiocb);
>   }
> 
> -#ifndef HAVE_COPY_FILE_RANGE
> +#if !defined(HAVE_COPY_FILE_RANGE) && !defined(__GNU__)
>   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>                                off_t *out_off, size_t len, unsigned int flags)
>   {
> ---
>   block/file-posix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..05426abb7d 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1999,7 +1999,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
>       return handle_aiocb_write_zeroes(aiocb);
>   }
> 
> -#ifndef HAVE_COPY_FILE_RANGE
> +#if !defined(HAVE_COPY_FILE_RANGE) && !defined(__GNU__)
>   static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>                                off_t *out_off, size_t len, unsigned int flags)
>   {
> --
> 2.43.0
> 


