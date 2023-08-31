Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F678E853
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbd6v-0006NS-Hs; Thu, 31 Aug 2023 04:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbd6n-0006N8-2b
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:32:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbd6j-0001O0-FG
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:32:56 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a603159f33so47737166b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693470771; x=1694075571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfExW0wvJbL75l+XPekcfEQYMr9eTFc9esyn7jJfCbE=;
 b=d5kejjomt60Fw4zhzXuIALnLQ7q28xWcepRFxxqL2khS6DL2M6PnbY5zW1acSw2k8M
 OvthwGowjfjxvN/s76RSoX2KPOfqsEHNS5AfizFikK7zdLS28W5a5OG2dsB0/dE29yjV
 nzrbaKgvytTwL0PEZ6f+snW0K9CfkA8Ky+XXwdNFEqxg2BFCFVZmNAjPP6RLozybXrIn
 lvzy3TmN4ydKswHISlD3zuBnrjTwEqvyOwz25dTmUYNeLzreW4/joS+wnpQ561XKcSx5
 N11xKiFRf/LyD8u4qehL/dNVLny+P567UnsZMLMIdrAE84POEQJuEMN6iu6Wbus+MQYw
 +xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693470771; x=1694075571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfExW0wvJbL75l+XPekcfEQYMr9eTFc9esyn7jJfCbE=;
 b=JrfEdpKLO5tLNTpqk9070Ku1lGFvDiT0t1YTcLCOhAI+fQqf68Ij45+O9jaG92FiCc
 2xfulyGkUx2Is4I/15AbVCMOLdbJWNVZbWnsIcAtPX98wzOz5moOQqm4vKBS09f1+H4c
 vPpSnJXbw6gN4dXz5Tr1mDVRTK/YFkSYP4MbmJDL8ZvAnMyKK7Ay8enpxdDI6OSJAg8o
 ZV9p8OR46SNL08PU2brUqZKFJtC+o1R3ibAg4QDGtHL1e7vwHfTK33+i6PbCFk/oy/fH
 N09BnJLNtEdDwaxNYfFKd5LQdMWBBytHqC3/xBZzkwHxuU2gFEtxAY+nASC4t3UTDKNt
 aBug==
X-Gm-Message-State: AOJu0Ywlj7RJXWYIdgA2kxFnJFDU6zVO/QbKpI5Sx9IpLv7ODvn1DWL9
 UfzYeL3vv/E6VKrkBKG2b8TM0Q==
X-Google-Smtp-Source: AGHT+IE8Ujf1rgUIpY5+GcQPDS3d4GeZQx/nowansygkfq84pt+u4kU/hMW2Die2RiIgXfvYa2fwZw==
X-Received: by 2002:a17:906:7683:b0:9a5:d657:47ec with SMTP id
 o3-20020a170906768300b009a5d65747ecmr3160536ejm.64.1693470771518; 
 Thu, 31 Aug 2023 01:32:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a1709064ec200b0099bc8db97bcsm494328ejv.131.2023.08.31.01.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:32:51 -0700 (PDT)
Message-ID: <63170abc-187d-5c2e-655e-fd6d0b9266a9@linaro.org>
Date: Thu, 31 Aug 2023 10:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/8] misc AHCI cleanups
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20230609140844.202795-1-nks@flawful.org>
 <ZLe/VG5d6TEdp/MT@x1-carbon>
 <b58779ed-cecb-824b-019e-bc34e6b2258a@linaro.org>
 <CAFn=p-Y4Tw0eY=8yXxnzSA3kzwb36H0oysag=HD_8eMsPNwuDg@mail.gmail.com>
 <ZNDIUzyB9hmt+E1I@x1-carbon>
 <CAFn=p-a5GuQ9mxxTn7T7B2-_5nPq9nw1ucsmJK5WuMOwXg=cSw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFn=p-a5GuQ9mxxTn7T7B2-_5nPq9nw1ucsmJK5WuMOwXg=cSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Hi John,

On 7/8/23 19:37, John Snow wrote:

> Apologies again for the delay. I tested it lightly and it seems fine to 
> me (and in general I trust your commits as they've got meticulous 
> references to the spec, so it'll be easy to fix if something goes wrong)
> 
> It's my fault we'll miss this release window, but putting it in early 
> next window gives us a lot of time for people to notice accidental 
> regressions.
> 
> Thanks for the patches and I hope to see more from you soon ;)

I've been doing some testing (x86/mips), but I don't think I have the
same coverage as your maintainer test suite. Still, if you are busy,
I can merge this series now that we are at the beginning of the
development cycle.

Regards,

Phil.

