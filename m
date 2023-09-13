Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EFA79E2DE
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:02:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLlG-00050H-4D; Wed, 13 Sep 2023 05:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgLlC-0004zu-GW
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgLlA-0001DO-4D
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694595727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slLPdvZwGLgcsnZnsC8K9w2N/TZJ4yvIEAk6TSfFTMw=;
 b=A4iRFEQvudnOmYgUGvEMvlSGP/qk2ldf6/Cn2i+pGfQp+N68n5Nx3lONY2d1CR8l2rsxFF
 wRlOMU6rsft7+qfLa4eNN8puKQj4kcs3RzUMAdAzrKXilhTs+HkLfoOsHLKkGFDZ1L5iuT
 3LUu5Ir5rNew6+rMJd92//BTOn6GaVM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-edqGPZH1O_SJXh8QYj4lIw-1; Wed, 13 Sep 2023 05:02:05 -0400
X-MC-Unique: edqGPZH1O_SJXh8QYj4lIw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-402493d2997so47138605e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694595724; x=1695200524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=slLPdvZwGLgcsnZnsC8K9w2N/TZJ4yvIEAk6TSfFTMw=;
 b=g4AwyBKPnicidAqtFr74Ojscohkpd8+XPljhLSnWRwHZUHKQfVKe65mHxGBGTWF5q1
 WWdrGvudZEQLEkq+lPn06o1L4YDC6ba8jzXKd4JIVCJvB1c0eyUfFwH4rbout6G8vOYI
 K4FAhSL0M5O71tV/12nmmIzCwTR1lOV++aP1xPWvY4Af7g441ZXYTDAo709OLUAnAZF6
 Bw9YRn3d2R2UYkXBU+0sq+Hg4Ox4JTlQm7XgiL1xC320AKDPvLA70SwxaD9y1SKfLAjT
 xLGugMYVG52Q25+5R0rUCzBdaBl/Iw8WDjqxWDPnLtq2+M0SrlDr7jOUtSEZ6FIxLShj
 yevw==
X-Gm-Message-State: AOJu0YwguY9o/H+8KNjPlyMTXp6n1GZsedPQjBSVLriIHs+Nr0zzXOF4
 jCGpigDd+tcSGWqBmak+MWDHfnoTuoVofUmyuUso4d9iFTqA2kTE2SLKIiIj7tRHi3hW9rQqF+R
 9vbE4PtMxypmSdkA=
X-Received: by 2002:a1c:f701:0:b0:400:46db:1b68 with SMTP id
 v1-20020a1cf701000000b0040046db1b68mr1498568wmh.35.1694595724651; 
 Wed, 13 Sep 2023 02:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZuIdbWZuk8ijbewFn8uAsr7n1tCPmUhqaefXnrEircZ5TYuQx+wt4bUG8NTMPMZOuS65GRA==
X-Received: by 2002:a1c:f701:0:b0:400:46db:1b68 with SMTP id
 v1-20020a1cf701000000b0040046db1b68mr1498544wmh.35.1694595724354; 
 Wed, 13 Sep 2023 02:02:04 -0700 (PDT)
Received: from [10.33.192.218] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a05600c0b5700b00402fa98abe3sm1390242wmr.46.2023.09.13.02.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 02:02:03 -0700 (PDT)
Message-ID: <2a8bc661-5fb0-f514-3ae5-4c6c9acb935f@redhat.com>
Date: Wed, 13 Sep 2023 11:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] ci: fix hang of FreeBSD CI jobs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
 <5cbb92ab-f8b5-4d03-5698-06d0a0b7cfda@redhat.com> <87ledatq3s.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87ledatq3s.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 13/09/2023 10.48, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 12/09/2023 20.41, Daniel P. Berrangé wrote:
>>> This addresses
>>>     https://gitlab.com/qemu-project/qemu/-/issues/1882
>>> Which turned out to be a genuine flaw which we missed during merge
>>> as the patch hitting master co-incided with the FreeBSD CI job
>>> having an temporary outage due to changed release image version.
>>> Daniel P. Berrangé (4):
>>>     microbit: add missing qtest_quit() call
>>>     qtest: kill orphaned qtest QEMU processes on FreeBSD
>>>     gitlab: make Cirrus CI timeout explicit
>>>     gitlab: make Cirrus CI jobs gating
>>>    .gitlab-ci.d/cirrus.yml       | 4 +++-
>>>    .gitlab-ci.d/cirrus/build.yml | 2 ++
>>>    tests/qtest/libqtest.c        | 7 +++++++
>>>    tests/qtest/microbit-test.c   | 2 ++
>>>    4 files changed, 14 insertions(+), 1 deletion(-)
>>>
>>
>> Series
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> Alex, will you pick these up or shall I take them for my next PR?
> 
> Queued to testing/next, thanks.
> 
> Do you have a patch to disable the borked avacado tests? Or maybe I
> should just include Philippe's fix?

I thought that Philippe mentioned that he wanted to provide a patch that 
disables the broken tests?

  Thomas


