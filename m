Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A571D7DBB62
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:06:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSu5-0003gq-H6; Mon, 30 Oct 2023 10:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxSu3-0003gR-BA
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:06:03 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxSu1-0003dJ-QQ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:06:03 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9adca291f99so674650166b.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698674760; x=1699279560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IkXEWEGJQZpyBOgODpAT/RhgAmFnMM2kcNoD2lbHv0Y=;
 b=NQygav9q+Uoj3FZHLN3mJrRFt6+JTPoCRAKu27uCtCueL8FIBpRgGWjhVOmDQfv6Lg
 MEFEgcQmL+kL3MAGZkJEzo8FB+vYUFlIR8Nro5mNJ37dZioBL6kFb0En6XtXVLcYr3Ri
 7IHhRqZ1mghumh19kHoMJeTGlE61859MA8XemMCilcmDcjaHB5GMgF1TmhGqX8gAOG5X
 vbsDMvjOnX4FdUDRd0ipfjkeEHWL4Ovp8vrIYo9xpaXDl7lENHi448bPSqRBi1ze4LJq
 OsgkZYnJq8hbw0z3XOIBMsZcjCvH3Wxsdo6AaFjBsH3U7ns7FAokFyVn/BlbK+g5atQE
 Ww3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698674760; x=1699279560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkXEWEGJQZpyBOgODpAT/RhgAmFnMM2kcNoD2lbHv0Y=;
 b=LxBwV3BOV72Wh2ZUJMl6SYWjs6yxWrNqu5+aLoE9n7ZGp6OmH49JZ0JuOZW3WjVS53
 J4e7uAxshjkPex8AbrJsFklZgd6L7lMgizLL/CB5KZefOYhq9toScT4+TvSeEqL1mF7y
 pAPL1Hey7HZYSSZdCbswS+fKurD10cxtjOfOkNJTsxNx7nrOJ4Smc1S1rbwWdB/THlwZ
 /zzyiBAe7WxjRomgzq40CudiRFdREIVumr3lHzJsHUYYNKascbDJMkOkLqGg+jKiCQuF
 LL6tUs1QHx0tkmrZkyc2i1+sC6bQwyc09Zg9X3ZbwUko4g26sUH7AeqILNQ8Jb9cKqDO
 VnLA==
X-Gm-Message-State: AOJu0YwIUx2MsPagjeduLXRh019ofp3wQGgyyHmvdIRNRfkmlwPz0enC
 QK/Hr8dnSUNvmxQdCqtthKW+mQ==
X-Google-Smtp-Source: AGHT+IFRpjmqni5Zb4C2eWqoOmrlC5Oy7hIMwXUGZlOCsJkjpF9QSJijYSjlPuLYl73Ghvu61igwiA==
X-Received: by 2002:a17:907:3fa3:b0:9c5:1100:9b8c with SMTP id
 hr35-20020a1709073fa300b009c511009b8cmr7964992ejc.56.1698674759831; 
 Mon, 30 Oct 2023 07:05:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a170906228700b0099bd5d28dc4sm6093345eja.195.2023.10.30.07.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 07:05:59 -0700 (PDT)
Message-ID: <473f2bd5-ebd4-00be-b8dd-c046505da9d8@linaro.org>
Date: Mon, 30 Oct 2023 15:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/5] dump: Improve some dump-guest-memory error messages
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
References: <20231030133712.2822276-1-armbru@redhat.com>
 <20231030133712.2822276-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231030133712.2822276-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.441,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Markus,

On 30/10/23 14:37, Markus Armbruster wrote:
> Zero @length is rejected with "Invalid parameter 'length'".  Improve
> to "Parameter 'length' expects a non-zero length".
> 
> @protocol values not starting with "fd:" or "file:" are rejected with
> "Invalid parameter 'protocol'".  Improve to "parameter 'protocol' must
> start with 'file:' or 'fd:'".
> 
> While there, make the conditional checking @protocol a little more
> obvious.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   dump/dump.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/dump/dump.c b/dump/dump.c
> index a5e9a06ef1..d888e4bd3c 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1812,7 +1812,8 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>   
>       s->fd = fd;
>       if (has_filter && !length) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, "length");
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "length",

Per commit 4629ed1e98 ("qerror: Finally unused, clean up", 2015):

  /*
   * These macros will go away, please don't use in new code, ...

Instead we can use:

            error_setg(errp, "Parameter '%s' expects %s", "length",

> +                   "a non-zero size");
>           goto cleanup;
>       }


