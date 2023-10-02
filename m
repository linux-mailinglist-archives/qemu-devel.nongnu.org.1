Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A47B4B57
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:14:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCC4-00082S-Cc; Mon, 02 Oct 2023 02:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCBq-0007yk-Jy
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:14:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCBo-0004xd-CH
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:13:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32325534cfaso11309906f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696227234; x=1696832034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gnendYG4hEYZU8X8cNZ2lHcvOxB1yZFw7c3lkST2Ac=;
 b=Q7mluaNlBZk3JsDjUJEbrjTz+oF7vwQToGKtaTUzaprXvibolg5LA1KC9k1ZnKHWZ8
 NkgB7H5tuvT1CJefg4XgdV2iR4zp5HeitguPDjogiqA+KzlBWaozoVyisEI/2wdKA0nH
 fbo6/FsoTu6xQHbeu0xkJezmEcZRvuQblYBet6wDXJLbk09gliHzom8lutSkBOK5hNf2
 gP8G+y+eaXWAd8jVDbh4PcavEORAXkwAuNX3qv7M4tbpBthyksH4Xew8eWu+lfwDm59k
 kpMFryhdGDUlGY+UxZJncK/nGWfAFXn7dongD4LN1dOhE03mkMeZiH+TbavjMI0tlu8u
 EtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696227234; x=1696832034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gnendYG4hEYZU8X8cNZ2lHcvOxB1yZFw7c3lkST2Ac=;
 b=OGDCdhvNBHUw6F85J4kcnhDVWu8ItrBWg48UP3ocg1svsYuJ5ptSvwQSWfTckk2Z3j
 OtmkFMZm8/VLHQ1fKsdT3MDGJ0v55S0PXy7StfLwdmgt6QtQ8DZaL9ThNpZtsrln2sl4
 mBHODOSKsbveSm0S959nAb6qok7raPN3jdw1woYK5g2YrwUKmFwyeU5HP6ZAW1Tz2FRt
 mc9Taa+deqaD5rnmI6ck7ckgKsgwCh+XBKVOQvaKiniTA6pzwxsOJcriL9fLnjbiE9nF
 wVulYYKAjU95GWrQD6O4yzLcBfbg5Oa8v2olsHbCe4MN+m/APThZkNeIULUqcjn4zdBl
 neaQ==
X-Gm-Message-State: AOJu0YztD9XhDkWY82rzdBc5JfHTMmX/2p9k/Vz85IiJTeQDIWB2FflO
 70zqx0NEAWvpwP0wQXJRf+Iu8Mxcna+KEVPWSXQ=
X-Google-Smtp-Source: AGHT+IG5eaGt/m5DiITWdpIioSOv9KpPrJA21F9zNZ3d3MSX1PG/cW9ENSwDfjLac+Nm/JwADfcPJQ==
X-Received: by 2002:adf:e592:0:b0:315:a1d5:a3d5 with SMTP id
 l18-20020adfe592000000b00315a1d5a3d5mr9614639wrm.22.1696227234461; 
 Sun, 01 Oct 2023 23:13:54 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 d12-20020adf9c8c000000b00324887a13f7sm9045393wre.0.2023.10.01.23.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:13:53 -0700 (PDT)
Message-ID: <aa6969c9-52bd-0b12-87eb-b12271c38c56@linaro.org>
Date: Mon, 2 Oct 2023 08:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: add standard-headers to Hosts/LINUX
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230929143012.77128-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230929143012.77128-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

Hi Cornelia,

On 29/9/23 16:30, Cornelia Huck wrote:
> The files in there are updated via update-linux-headers.sh.

So F: or X: (exclusion)?

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 355b1960ce46..95df1f3d8884 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -556,6 +556,7 @@ M: Cornelia Huck <cohuck@redhat.com>
>   M: Paolo Bonzini <pbonzini@redhat.com>
>   S: Maintained
>   F: linux-headers/
> +F: include/standard-headers/
>   F: scripts/update-linux-headers.sh
>   
>   POSIX


