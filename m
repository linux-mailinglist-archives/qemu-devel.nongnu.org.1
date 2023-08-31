Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4829178E7F3
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbd0r-0002Sh-5B; Thu, 31 Aug 2023 04:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbd0S-0002Ri-CS
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:26:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbd0O-0000OL-BF
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:26:23 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so397302f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693470378; x=1694075178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+jXVyInESpzQKys/y6VP2hRYIOpnct3i37wlJEhQUrk=;
 b=riAMrmxgaIN5squ9fvYNYFDbuOTRPqsq+8DkWKBp9Z19Ul4jUUuqkhdy+E3o6F4/cz
 IqL/wWe0tk/n19z4X0UOjiyYsdnRJgY5clViM3FF0nYbqVAkzx3e39fWHSnxiqGVSZV5
 97wAQ7Tqhz0XpK+ZrVVahM4Swrol2Or7gUm5DXkk4Ip91jcxJ9pLYXtGeGj1F4YTz5Qv
 IC4yYBZYIEC412yPSRl5izO/bmGhbRcnBg+cSd72xlJvB5ZNm8BFmXctkulKMfU8KkuO
 AaUm3USF8a+NtDhqnemNS8sO1jcdh3UOUBV/8BVvJo+3ggzymiSp0Fa+fZXiS6sosycx
 CLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693470378; x=1694075178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+jXVyInESpzQKys/y6VP2hRYIOpnct3i37wlJEhQUrk=;
 b=Uyx8Kow9oXxIegJY/5RmGRRxw4d6A0gu+tH84m9zIl30eFX1+jo1HyslrV3qM3fYkx
 B0Alj/tpRaJ+zBFFJEhqkvWe/NQ4rsxtbSmeIallvSLmCEgmdA+KP8I/VVV9d5Kz4HhM
 BgC/aAnv2ewVvh45cgOH3XSD+0C1851StcPzyALVe52aSO7A7i8tut/oQdAZ5E7pW99h
 CfUY2/Vib8nBP1WF0Sxzxa6KqWj18RLLonDl77cuTSBlDQEfh6XhW7XWy0Zzz0nszQte
 8QsmveL5iRTStSU93HCpw6E9Jpj2O3Szm/EwEupX6zKaEHPIY1/cziM5n7QClA210sgk
 Xw5g==
X-Gm-Message-State: AOJu0YzudE5ir1OKbPhghLy9v8WJvBbdtVNIRa7XeTrZaFpdAKitfPuu
 5YglUpkJDMW7KrMkC+nTa4QwRA==
X-Google-Smtp-Source: AGHT+IGMK3iAXa4EZolTk/giC0XScKexO4HNokm0lqxOSXVbuDxN+dbmpAqcsic81FIaibDNeisRDg==
X-Received: by 2002:a5d:628a:0:b0:317:5168:c21f with SMTP id
 k10-20020a5d628a000000b003175168c21fmr3218958wru.31.1693470378548; 
 Thu, 31 Aug 2023 01:26:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a05600001c200b003196e992567sm1379672wrx.115.2023.08.31.01.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:26:18 -0700 (PDT)
Message-ID: <358c92fd-8384-97b6-f47c-0ba60bd024af@linaro.org>
Date: Thu, 31 Aug 2023 10:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] util/iov: Avoid dynamic stack allocation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block <qemu-block@nongnu.org>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20230824164706.2652277-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824164706.2652277-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc'ing qemu-block@ (I suppose this will go via a block tree)

On 24/8/23 18:47, Peter Maydell wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Use autofree heap allocation instead of variable-length array on the
> stack.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Usual "only tested with make check/make check-avocado" caveat.
> 
>   util/iov.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/iov.c b/util/iov.c
> index 866fb577f30..7e73948f5e3 100644
> --- a/util/iov.c
> +++ b/util/iov.c
> @@ -571,7 +571,7 @@ static int sortelem_cmp_src_index(const void *a, const void *b)
>    */
>   void qemu_iovec_clone(QEMUIOVector *dest, const QEMUIOVector *src, void *buf)
>   {
> -    IOVectorSortElem sortelems[src->niov];
> +    g_autofree IOVectorSortElem *sortelems = g_new(IOVectorSortElem, src->niov);
>       void *last_end;
>       int i;
>   


