Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218679838E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 09:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWHS-0000dy-1q; Fri, 08 Sep 2023 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeWHM-0000de-8e
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:51:49 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeWHG-00066m-QU
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:51:46 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99bed101b70so216963566b.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694159499; x=1694764299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6jHmEdS+QKWv2jRVVcLoGSYA+axVnrBN+SdIWYhFHXw=;
 b=xlgNYczG3Se1KwQLYiwxUtWhjrBdaepRDGCKqaFaCbJGrE/DGqyumyGg0HGJ898eDI
 gazGDC+d6GHt00/B0lvc0JRxunUMcgHO7FBZgmwNK/9QcVfRGRKpfMTe00sb1KPDMQ/q
 loxKwo3QwK6TlI+ECu64BCuAQgHwNBv6N2r9HEaxjgoAZUOScepVzlpKfOIeEEVvQwDF
 mwjfcmZlnQ4K1JHa9oSZyo+3QJyGReyJxqlLB6MI7OWm3DhQQ4oVhCoa0JTG9etme5h1
 BsKTc236BOllhUIhLOh7Olgs8vLtRySNyXoa4kI0ACWRdHWyfXlS1sqPNJsH61cA2xYs
 a/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694159499; x=1694764299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6jHmEdS+QKWv2jRVVcLoGSYA+axVnrBN+SdIWYhFHXw=;
 b=uTTVlSxDTuqAIrFz7md0YTKYRWaxalNaTEkE+2HVbVnGvVTzOraKMsiGMsJAwaTnHl
 y6U2PVo9wIxtmmQ8/zk4uCw1Mzp2xTtcGvCU+LtO/MiurofOPau3lDZZWbOiHjNkHoK/
 FP7RTAgSbNujEBbLep3ZfBpkWz4Vd/FUgBu47GjNBm8i4EtRiqFkxEAOQPmdwPqHuEjb
 XP+wEERDRe9LOUIk9QzeUs1DUoG7kPjdWlTDZeXDxtyo2y+XlwEwU1HNS/XmQjOFWED1
 GBPg2ahDQsuyrKeOEhXtsnaYPSvvwQzWKE7yGLhbOCbuZWTfPl7gYeVl+3n8Dg1Db9wP
 Qrbg==
X-Gm-Message-State: AOJu0Yxquf0fb7kyHkuYMzz0AmiYVx7JhZ6ZIcrqWJrrDEzixduHnbYP
 WcY9NJ0yaGD6xzZYJYW2vr0BRQ==
X-Google-Smtp-Source: AGHT+IFElPVIlLuqqIB1MXTzWmoWShMJYbGO8ePGFj5p+X4L1K3xkYlCHZ59DpwHgvEP/XRE4dL0Xg==
X-Received: by 2002:a17:906:310f:b0:9a1:e613:2569 with SMTP id
 15-20020a170906310f00b009a1e6132569mr1182884ejx.16.1694159499306; 
 Fri, 08 Sep 2023 00:51:39 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a1709063b0900b0099bc80d5575sm635399ejf.200.2023.09.08.00.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 00:51:38 -0700 (PDT)
Message-ID: <440707e4-c855-99ce-0ca3-03250a0bd3d2@linaro.org>
Date: Fri, 8 Sep 2023 09:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1 0/7] Validate and test qapi examples
Content-Language: en-US
To: Victor Toso <victortoso@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20230905194846.169530-1-victortoso@redhat.com>
 <ZPhDkJ+RvPauLfG6@redhat.com>
 <ixihnxsvwqtozpdfb5kavkjymflhdktgiq3bddpqqqjbnwyaid@cjgi7bofphbc>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ixihnxsvwqtozpdfb5kavkjymflhdktgiq3bddpqqqjbnwyaid@cjgi7bofphbc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 7/9/23 20:17, Victor Toso wrote:
> Hi,

>>    File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", line 118, in parse_examples_of
>>      assert((obj.doc is not None))
>>              ^^^^^^^^^^^^^^^^^^^
>> AssertionError
>> ninja: build stopped: subcommand failed.
>>
>> not sure if that's related to the examples that still need fixing or not ?
> 
> This is related to the script being fed with data without
> documentation. In general, asserting should be the right approach
> because we don't want API without docs but this failure comes
> from the tests, that is, adding the following diff:
> 
> diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
> index c14ed11774..a961c0575d 100644
> --- a/scripts/qapi/dumpexamples.py
> +++ b/scripts/qapi/dumpexamples.py
> @@ -115,6 +115,10 @@ def parse_examples_of(self:
> QAPISchemaGenExamplesVisitor,
> 
>       assert(name in self.schema._entity_dict)
>       obj = self.schema._entity_dict[name]
> +    if obj.doc is None:
> +        print(f"{name} does not have documentation")
> +        return
> +
>       assert((obj.doc is not None))
>       module_name = obj._module.name
> 
> gives:
> 
>      user-def-cmd0 does not have documentation
>      user-def-cmd does not have documentation
[...]

> So, not sure if we should:
>   1. Avoid asserting when running with tests

This seems the most sensible option, adding an argument to
the 'command' invoked by meson's test_qapi_files() target in
tests/meson.build.

>   2. Avoid running this generator with tests
>   3. Add some minimal docs to the tests
> 
> Both (1) and (2) are quite simple. Not sure if there is real
> benefit in (3). If we should tweak qemu tests with this, should
> be related to using the JSON output itself, to keep examples
> correct.

IMO (3) is a waste of time.

Regards,

Phil.

> Cheers,
> Victor


