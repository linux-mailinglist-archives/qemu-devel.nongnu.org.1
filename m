Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F26977B9AB7
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 06:29:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFy9-0005Wl-Sn; Thu, 05 Oct 2023 00:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoFy7-0005UC-32
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:28:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoFxq-0006fQ-QS
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:28:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so4878815e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696480073; x=1697084873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JyARwz5g+qIO6iCsgXaWy8OpoudmDME00w3m4DWPCAs=;
 b=TIjOEjFjlyXNoPTK5/joPiRIR0Zt8RFx97dTlT6AmOKmCEKTfFl0qpK0odzsZZyEeU
 f7GXfPffRQeC6Yy5PhDdFr65Qt1BRkhgp43vMFDHdNU0k8eWt5El5XHLNEo1dW2yAfWH
 GIsWqNYDmR96yN64jKXfv3B/apgcO9wMW4Th/CYToZI5MR8U/1fZXE11bYMbsx6uV2b2
 Qg2xPVGYHfsh+6eZH07cv9iuXpEwaSw/Zk5rf5L7qOGl2lCuNViFwlxfXaq8yuI01B2Q
 kKfekOVDj205+GUoOMkX6CmQimS2ge+L1uTFsVgrgHgSAWf1WgXGyDEYqSzQG4BQtD1G
 VT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696480073; x=1697084873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JyARwz5g+qIO6iCsgXaWy8OpoudmDME00w3m4DWPCAs=;
 b=VZmqipAXrJDA/l3plDz6hcfhtG3bbLU2nbL8+1RMA+jCqEKlrfIPrhcp7T2HHik4Wq
 dcKScRn0g3RkwZlAIv4LM7WJhOj6WOoOGN8+f4k5r5TMMSBtTlGueEV/NmB5bbZfv2cs
 Mbc+QzfOzDaedIOjuuFdsAqpS6o/gR94r2uBvgLnIDXgmNL6fSd2OVhrhn6IrE2HekoF
 ma4WgTZqY12eMz7KBewwwKDsjwzK5AT9O85VgzuvmCoK3oY9WszXe0aZ4MSr0TKcTL9c
 46/VW+cC8gVvyPtg2Ux8B6Yum47ng9HMyUW2Qed9eOvxR3p3g2VA1qO5uFdhj3QdmSnD
 65yA==
X-Gm-Message-State: AOJu0Yw8OA2lVRAWmNJi2ATYHMDqmzi3lbolvn6NEKX1Vd20RuvP23Yk
 0M2T9bzX/atw0I/ZCQQhm2bdBA==
X-Google-Smtp-Source: AGHT+IFk6V5MxGhQc4AGpCoVUTwXdX4Vi4s+9691AKM+uLvYz2WnPJUMrOX6AZIM+LVBmlt9vLEfuw==
X-Received: by 2002:a05:600c:b59:b0:3ff:233f:2cfb with SMTP id
 k25-20020a05600c0b5900b003ff233f2cfbmr3932702wmr.23.1696480073001; 
 Wed, 04 Oct 2023 21:27:53 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c219100b0040646a708dasm597311wme.15.2023.10.04.21.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 21:27:52 -0700 (PDT)
Message-ID: <5d6eb736-04da-b0e5-0e88-e09fc7c122bc@linaro.org>
Date: Thu, 5 Oct 2023 06:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 10/21] qapi: Inline QERR_INVALID_PARAMETER_VALUE
 definition (constant value)
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
 <20231004173158.42591-11-philmd@linaro.org> <871qeas18v.fsf@secure.mitica>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <871qeas18v.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/10/23 20:15, Juan Quintela wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> Address the comment added in commit 4629ed1e98
>> ("qerror: Finally unused, clean up"), from 2015:
>>
>>    /*
>>     * These macros will go away, please don't use
>>     * in new code, and do not add new ones!
>>     */
>>
>> Mechanical transformation using the following
>> coccinelle semantic patch:
>>
>>      @match@
>>      expression errp;
>>      constant param;
>>      constant value;
>>      @@
>>           error_setg(errp, QERR_INVALID_PARAMETER_VALUE, param, value);
>>
>>      @script:python strformat depends on match@
>>      param << match.param;
>>      value << match.value;
>>      fixedfmt; // new var
>>      @@
>>      fixedfmt = "\"Parameter '%s' expects %s\"" % (param[1:-1], value[1:-1])
>>      coccinelle.fixedfmt = cocci.make_ident(fixedfmt)
>>
>>      @replace@
>>      expression match.errp;
>>      constant match.param;
>>      constant match.value;
>>      identifier strformat.fixedfmt;
>>      @@
>>      -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, param, value);
>>      +    error_setg(errp, fixedfmt);
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> And like the approach, but
> 
>>       if (granularity != 0 && (granularity < 512 || granularity > 1048576 * 64)) {
>> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "granularity",
>> -                   "a value in range [512B, 64MB]");
>> +        error_setg(errp,
>> +                   "Parameter 'granularity' expects a value in range [512B, 64MB]");
>>           return;
> 
> There are several lines like this one that become way bigger than 80
> characters.

Yes, I just realized I forgot to run checkpatch.pl :/

Now done, this is the single patch producing:

   ERROR: line over 90 characters

> Later, Juan.
> 
> PD.  No, I have no clue about how to convince coccinelle to obey qemu
>       indentation rules.

Well this use Python, so we could check the length and split (returning
some tuple) but:

   $ ./scripts/checkpatch.pl origin/master.. | fgrep 'ERROR:' | wc -l
         10

So I guess I'll just manually adapt :)

