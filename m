Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD6072316C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:29:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GpI-0001V5-M5; Mon, 05 Jun 2023 16:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6GpG-0001Ty-Ow
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:29:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6GpF-0002Oq-6A
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:29:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f736e0c9b1so21791485e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996951; x=1688588951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bEqFddXWAEXoZehEXARKfpx30Lgtov16XGmnOy5+2S8=;
 b=BPWdpqR30tM1Mr/ljk6VKY8oN4AG1LHDXKWm27hUKQ/FJaCqMrF7idimgnXdTj/lnl
 6bpOY/bshyS7QAYYFmGwGBVt/Frt1Vld35dgJqETDUR7qckj1NdROYwOY+WtDhhtAWnp
 bxVgipSn1Go6R0UGGpzLMv4nDs+qDcTkVuAlER9yb7iPe7NOppXML3XrBO7Zm27eF71U
 QpMSCNESgdvWNbNBJKEplh6J2lJ7TWhMzsxhGpnolbEhvS+6ejmvigyNZFsnfeDZllcK
 K4HkHVVEy1/YYec5v54e8xPB9aAiaSjlmP80xHZM37zbGWuDXtLJgsc1H3/kLgyEuY85
 J5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996951; x=1688588951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bEqFddXWAEXoZehEXARKfpx30Lgtov16XGmnOy5+2S8=;
 b=Fj91HLalKxpbREuVevfKc2L9rU4iCdNgeIJP5rkOmebaKb1HrzbsEnUJmN7y85Zzmq
 obo7pXGG+Zr75wsZ0/IAv/TVWFG7RbmJ+Hn99bHw2Thl7NRERoBCcQLDSGj7mmqk/K0/
 0SzipAixTiQadd9fnSBjBgq/WdNVa9RvBC5a5aD+9m939rbMJbWLubR06BSJc2M/2IjK
 R8V0DwSIoi/Rf0AgTB7+6vXblOjczPd5zbfHxxlSQJV7X0F42FAbX3unyjK8e4nRRFfQ
 zRVBHqbp7AcucCTwvyp5B3pXUgW2ygEAxzuO3u2LpHopkRoria5NQu+vtCeEyn2EUs+L
 IdaQ==
X-Gm-Message-State: AC+VfDxmcui+UkzEGqY4t4MNhSYgbdxk/l0H9oY7RQhLIiodzp9GSjVD
 jfr6pa4Prw0X9PuwqdQIfqn0cA==
X-Google-Smtp-Source: ACHHUZ658vvI5uwmPvW4gMwUoEL8LxHm/KxLLvD0B1MKQIusKaNJy0mFBBts5Z7UQ+39TYrRc/7mSA==
X-Received: by 2002:a05:600c:284:b0:3f6:3bd:77dc with SMTP id
 4-20020a05600c028400b003f603bd77dcmr203280wmk.23.1685996950915; 
 Mon, 05 Jun 2023 13:29:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a5d6185000000b0030af05fce4dsm10689420wru.77.2023.06.05.13.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 13:29:10 -0700 (PDT)
Message-ID: <97194b58-3f9c-e351-a439-87b2bfed5674@linaro.org>
Date: Mon, 5 Jun 2023 22:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC PATCH 1/2] bulk: Replace !CONFIG_SOFTMMU -> CONFIG_USER_ONLY
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230602225811.60152-1-philmd@linaro.org>
 <20230602225811.60152-2-philmd@linaro.org>
 <7913570a-8bf6-2ac9-6869-fab87273742c@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <7913570a-8bf6-2ac9-6869-fab87273742c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 3/6/23 05:49, Richard Henderson wrote:
> On 6/2/23 15:58, Philippe Mathieu-Daudé wrote:
>> CONFIG_USER_ONLY is the opposite of CONFIG_SOFTMMU.
>> Replace !CONFIG_SOFTMMU negation by the positive form
>> which is clearer when reviewing code.
> 
> CONFIG_SOFTMMU should be reserved for the actual softmmu tlb, which we 
> *should* be able to enable for user-only.  It is the only way to handle 
> some of our host/guest page size problems.  Further, CONFIG_SOFTMMU 
> should go away as a #define and become a runtime test (forced to true 
> for system mode).  Pie in the sky stuff.

This would be:

   bool has_softmmu(void)
   {
   #ifdef CONFIG_USER_ONLY
       /* TODO: implement */
       return false;
   #else
       return true;
   #endif
   }

?

> It is quite likely that all uses of CONFIG_SOFTMMU outside of tcg/, 
> accel/tcg/, and random bits of include/ should only be using 
> CONFIG_USER_ONLY.

I see.

Thanks,

Phil.

