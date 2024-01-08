Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B557826BE7
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:54:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnHH-0003Ot-Do; Mon, 08 Jan 2024 05:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnHF-0003Od-VX
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:54:41 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnHE-0005o3-2i
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:54:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d858c56cbso22592745e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704711278; x=1705316078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FjAJl9ozJLHoqNnVuqdi7pxmCZAU0/prJld4KC2Y11Q=;
 b=LVoLwPMrbRpxmx0uATYplM2JZQ3YPZozSk5GZ5a7JULoqe/hKRPHbD1aHaxhClmJov
 fjqrPZM+sTTsnjDC0LLOu/s0kk5Hb6HlttBQZlKAZeLj3oyr3wvOTlPxRIQ28D7FZB6g
 /M9mV8OeYSxehzsyChaFuz/h3/5fVE9POiB7EsDN6FKXcJbR1mL/BFZHauNRpKqOFUfV
 X7vyWxKw+dn5HE88NLfa8ivQ9NIfR6w/JtxJBny9ENP3ii58wCebR7XmfnjLDOKQfdaX
 dKuN3FYaVn/UT8juMNjP3hPRVJrrVwcM4yO2jMwPyNsLR/YCNSO6JE2Dve1ROqN5ggfE
 N7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711278; x=1705316078;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FjAJl9ozJLHoqNnVuqdi7pxmCZAU0/prJld4KC2Y11Q=;
 b=mbyVVXlR0frCYEbnw8bOmzniHRaWwNblGcETs9tANEyveR+92UE/73t7w14V/OaFh+
 VvJPaPN3dO7O2Rr/6vafxUy7hRDPeL6L0Hu+lCOFdntvi/rAF8KSBvgXGTxZClBftuKw
 PyvqSM6axLzkxLKzROiaRJdovaiHoE4/jDVebDC0xH39YSGALUJV2Py1I/U8Ysvspexw
 QZnecyOOH3Pb+qdL/9jvOdEyq/V0It4q1WTbv0YEWCrnWo67mbf6HY8FaKEgJdVGb+7s
 LEkpb0oyzGGJPoeYNx8PjgHT3kL8RqVPaFEq9lkjJ5xrjmphQ4iK41LxkWsgvzN3i19l
 eD/Q==
X-Gm-Message-State: AOJu0Yw3oOA36bEjxspTKw2c9QHE9+tknw+25BqlrA7H8NHrjWAjP5qE
 i3lleeNzPLviM0UNrqsznujSEpGqeWJxBQ==
X-Google-Smtp-Source: AGHT+IEfKu0NVJSUBVLzroGKPhStVcNQenuvFcBMoD+BMqlN0MoTokeS22ozxEYgl+8wvkLUv36eXg==
X-Received: by 2002:a05:600c:3b99:b0:40e:4179:d060 with SMTP id
 n25-20020a05600c3b9900b0040e4179d060mr1383700wms.65.1704711278137; 
 Mon, 08 Jan 2024 02:54:38 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 c12-20020adfe70c000000b003373fe3d345sm7433674wrm.65.2024.01.08.02.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 02:54:37 -0800 (PST)
Message-ID: <38019096-96a1-464d-824c-951a053c4e21@linaro.org>
Date: Mon, 8 Jan 2024 14:54:34 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/33] linux-user: Fix sub-host-page mmap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x330.google.com
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

On 1/2/24 05:57, Richard Henderson wrote:
> We cannot skip over the_end1 to the_end, because we fail to
> record the validity of the guest page with the interval tree.
> Remove "the_end" and rename "the_end1" to "the_end".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index fbaea832c5..48fcdd4a32 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -643,7 +643,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>                                  target_prot, flags, fd, offset)) {
>                       return -1;
>                   }
> -                goto the_end1;
> +                goto the_end;
>               }
>               if (!mmap_frag(real_start, start,
>                              real_start + host_page_size - 1,
> @@ -690,7 +690,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>               passthrough_last = real_last;
>           }
>       }
> - the_end1:
> + the_end:
>       if (flags & MAP_ANONYMOUS) {
>           page_flags |= PAGE_ANON;
>       }
> @@ -708,7 +708,6 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>           }
>       }
>       shm_region_rm_complete(start, last);
> - the_end:
>       trace_target_mmap_complete(start);
>       if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
>           FILE *f = qemu_log_trylock();

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

