Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479D75B041
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTt5-0000Rj-Mx; Thu, 20 Jul 2023 09:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMTt0-0008P3-EQ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:40:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMTsv-0007iw-Je
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:40:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso7030755e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689860400; x=1690465200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DRrgGaK4499eQnTXxA7i4eBm2jqNxI3pZ6DqAFd+B+I=;
 b=iMh61LnfN/Mt2eo8gjReN7kwcrGkOEJp/fU56edS/gAlymLcYYmshMsMVdyZN2Jgmy
 lm+aMMtB/iTsYWNYBvDRa4rQ/rdivttBxtQc7U38rA12kT3b5X4LZMHhoMCnaFG6V110
 aEuHUOWIkuE4q75NyNpYXeVe/28M4WwXNxC3nH/2IRKU5ScUj7oVd3hbJ8iZPZJqIy/4
 qxcskcLn0c/iuscAQ21DHpFC4aW9/pubRGMlrNALObKOYnrBc1ZW5lzKqSufS2s3QUuX
 MbDuuIACwCTRTpZQbjp9y8RBiSghirI1OffesTrdpogDO0AqpZdBcwWUhq3XyQzbFfSx
 wzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689860400; x=1690465200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRrgGaK4499eQnTXxA7i4eBm2jqNxI3pZ6DqAFd+B+I=;
 b=HXFA4MbQ3VL8DfNCxxXS+o+GLotyjm4bDoES7bJf9Q+v0TJKV52S5PP1eXH5G3QpEe
 btvBZR3K67xoI6yeSkxyaxtbKy6bYohQNQqUR48PGZVza3MFjIRymjlSmBp//ORewMI/
 MGIG725O8eOooCMIhysTXuINGbI0ADE6oLlR5kEpbL/f9UaeUEKL+dCwcmlndHOBWBHN
 MvTjhFPUFd7Nt/pVjD3Yoy7FQWA5JDIn3zGjUUyFAT42UU1QIJ8ZGPDSug+E8oqMecQ9
 3qR4vcAcbQfoUfWiq51V15xyLWn3VymcWswQCacr4gPgc46IXpYq4DgdPclp/RsgG9aZ
 SgZg==
X-Gm-Message-State: ABy/qLbFRvdZG4jXsPMHJNqbLu8mmJFLEIC2NU9SmbUhXJ/yx1/avEfm
 n7/geJJTx13FtzEVQc+qDJGtVSdZuMinkhgT5Jo=
X-Google-Smtp-Source: APBJJlEN25HS0RbugkrYYU9GIRfjldGtOtI7/YzIyvWSYJrMajPRX1aRrO5mO5LqGzca93ZPMALwGg==
X-Received: by 2002:a05:600c:acf:b0:3fa:99d6:4798 with SMTP id
 c15-20020a05600c0acf00b003fa99d64798mr1930806wmr.37.1689860399720; 
 Thu, 20 Jul 2023 06:39:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.214.178])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a7bca4a000000b003fc00702f65sm3926582wml.46.2023.07.20.06.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 06:39:59 -0700 (PDT)
Message-ID: <17a385cb-00cd-8680-6649-0a4ca284939e@linaro.org>
Date: Thu, 20 Jul 2023 15:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/6] qapi/block: Tidy up block-latency-histogram-set
 documentation
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com
References: <20230720071610.1096458-1-armbru@redhat.com>
 <20230720071610.1096458-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720071610.1096458-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 20/7/23 09:16, Markus Armbruster wrote:
> Examples come out like
> 
>      Example
> 
>         set new histograms for all io types with intervals [0, 10), [10,
>         50), [50, 100), [100, +inf):
> 
> The sentence "set new histograms ..." starts with a lower case letter.
> Capitalize it.  Same for the other examples.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/block.json | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


