Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2FF723136
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gek-0005WS-QR; Mon, 05 Jun 2023 16:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6GeA-0005Rr-RF
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:17:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Ge9-0004pL-7G
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:17:46 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ae69ef78aso4784314f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996263; x=1688588263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqHP+ACwW6wlV9WaaBwpTVFPiAOZs5jstBjfl3MoDtA=;
 b=KselGk6Uh4/RuUxfukMs0FdFMKgnkZzaWjcdD+02UF8x6BBvq1rZrlp3wYz3DXYSAW
 Cup8RGjcO/FncpMi0x7h+LdXMP+Qgi0dsS9Ip2OKbralhteaLxNKmCq3GlhjG74smrGD
 btBUBLMEn5XOF4lBApArLU7tQDZCWErJBixF41sgcresfdrrlGW6Puxxr8XCuIQlK4WO
 NhnAHuTza+LF2YeA/ihTSxf2syhKxZH20u6jne/S3fN72nES7eaoS7LIQdBHnTCjf3zC
 9Di93eEMduBZHlWuc1IWKiw+1rDOez0upgwM8hkxZbPFaYj+BHO67zbywWrHxIu0U48x
 IJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996263; x=1688588263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqHP+ACwW6wlV9WaaBwpTVFPiAOZs5jstBjfl3MoDtA=;
 b=RmHO3cczuMoKeyi/hyXNWOvHTgW8PamHQriZB/fukQHM5xbz9gFYXGTf8aSvOFxxdv
 dVUgQ98bmeUJUw1usMMtXHagvnleFFEgfLDhvMl4Yfzd9wdZe5dgOD7KSxT9JswvfWyv
 vBGxtlwG5mpUJZZLP1LlKtuEg55AtW9E02/OnnTIMDDkhqbsVA0fXNZwuzxk1kOvynqF
 n2/WsZ1JCEZ24EiWxNu3AcBknAsC26FGkhB8/HiFJdK+oobMERVfHlmfSuW/wgqYl0uT
 +CWXqcdY3S61XTnukQPuP9CvGuO7A8o7x1IrdySktWB/4T8cazHhHO0j7F5YAvoCuL5U
 UzTQ==
X-Gm-Message-State: AC+VfDwHoWznq/rDrUtZwa0U9EwllX3MYOYyDKjdPo8j+3T615bcxkgY
 DsXrzou4dI4XJsQ8Ef6gXyo9Zw==
X-Google-Smtp-Source: ACHHUZ5Kvu7KMd6DZhhep/+cHxzkSx1XWo9NlUp0vgYTlUiwYI/HcYMx/Vds+KaVtWr2GUtmXNSceA==
X-Received: by 2002:adf:dc4b:0:b0:307:5091:5b96 with SMTP id
 m11-20020adfdc4b000000b0030750915b96mr6613847wrj.22.1685996263252; 
 Mon, 05 Jun 2023 13:17:43 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a5d574a000000b003047d5b8817sm10674097wrw.80.2023.06.05.13.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 13:17:42 -0700 (PDT)
Message-ID: <10e57610-dbda-6eb6-a6da-ed088670458a@linaro.org>
Date: Mon, 5 Jun 2023 22:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH RESEND v2] hw/i2c: Enable an id for the pca954x devices
Content-Language: en-US
To: Patrick Venture <venture@google.com>
Cc: cminyard@mvista.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Hao Wu <wuhaotsh@google.com>
References: <20230322172136.48010-1-venture@google.com>
 <ZBtwxzc7xpazByqK@minyard.net>
 <434091cb-08d7-15f5-e4ff-5fa867abd3e8@linaro.org>
 <CAO=noty3aAas_vT_dvB8knPg498nWs72KsFfkcB7TX2L8bXxQQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAO=noty3aAas_vT_dvB8knPg498nWs72KsFfkcB7TX2L8bXxQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Hi Patrick,

On 31/5/23 18:34, Patrick Venture wrote:
> 
> 
> On Wed, Mar 22, 2023 at 2:40 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     On 22/3/23 22:19, Corey Minyard wrote:
>      > On Wed, Mar 22, 2023 at 10:21:36AM -0700, Patrick Venture wrote:
>      >> This allows the devices to be more readily found and specified.
>      >> Without setting the name field, they can only be found by device
>     type
>      >> name, which doesn't let you specify the second of the same
>     device type
>      >> behind a bus.
>      >>
>      >> Tested: Verified that by default the device was findable with
>     the name
>      >> 'pca954x[77]', for an instance attached at that address.
>      >
>      > This looks good to me.
>      >
>      > Acked-by: Corey Minyard <cminyard@mvista.com
>     <mailto:cminyard@mvista.com>>
>      >
>      > if you are taking this in through another tree.  Or do you want me to
>      > take this?
> 
>     Since I have to send a MIPS PR, I'll take this one;
>     to alleviate you and the CI minutes.
> 
> 
> I don't see this patch yet, did it got lost in the shuffle?

I quickly tried to test the patch before sending the PR and it was not
working, so I dropped it; but since it was a busy day I neglected to
post an update on the list. I apologize for that.

Revisiting the patch, the problem is trivial, a simple typo:

  +static Property pca954x_props[] = {
  +    DEFINE_PROP_STRING("nane", Pca954xState, name),
                           ^^^^
  +    DEFINE_PROP_END_OF_LIST()
  +};

I'm queuing this patch again with s/nane/name/.

Regards,

Phil.

