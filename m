Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67745977F8C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 14:15:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp5Br-0005Kq-3e; Fri, 13 Sep 2024 08:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sp5Bl-0005KC-Dx
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 08:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sp5Bi-0001LT-TT
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 08:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726229649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Qejn1uxLtgQbBw1f/FFoVOP4oMMMyewtol+BmBGyD4k=;
 b=ZvnTdMMcw43ENYUtoPPgphVbVAJ6EE/PcvqILoy12sX6TpUE0M1uP/V8RAQZcbTa3KLpuH
 kuhXQtSFbJMnxSu6WhGfQ6/yvFVtzMoHvhcR47ulcw3FoBuW+NwCB0BqfAz0UNJbVpqVz2
 zrP+1HIY+c+iPhtWw1UDekYlHYWGqh4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-dAOD72IkPJe58gPgdQ0t6g-1; Fri, 13 Sep 2024 08:14:07 -0400
X-MC-Unique: dAOD72IkPJe58gPgdQ0t6g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5365b1f0c2bso692887e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 05:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726229646; x=1726834446;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qejn1uxLtgQbBw1f/FFoVOP4oMMMyewtol+BmBGyD4k=;
 b=Zm8gxLRm38EzYsuTORxX0CBjY5E2qgmYfU4RoLg4FUUhLgLPiWilWJTHzlPiGsxjUT
 XnSRc//1b5eLshpFRFu3Ek3ecdRbCM1b3CJLh73N+rEW4HhZe7LVUCFqNH7lMbVO03Tt
 Edoy4XqPC4lojnbbkYgHTvlGix0FBzeoiVtm7r/Mx1Xx4pMylEu0/2X0V1W5ZH6JTW43
 EMVqrcdaMlvbjJNBRqR9NZj4HlFX7oUVJrgFClXUz6o/hHPU/+ur9J8Gtp/Oomh1O/zY
 4CFJlz0pb/9v8s9gKweOuYPWe3nK2pJDGKdcYXRuiW1g2jEL8cpv0nj01hepYA8NgREb
 y2Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrXR1iUL8I8EQE2s3eMCqgb7hjmCXdyswrnUpcIPa0CuZny3cS45KiXx+AGw8KtSSqoASQnNC0L8+X@nongnu.org
X-Gm-Message-State: AOJu0YwBe42h9y52QGiEwClLBKLTX/tT7dbYoc/GsuiXuqSjmQk8Hikn
 B8qdGQ9EtOuoT0vDPZQGW8RzuAiKwlGUS+2/dGlGYM3/D3PPprYm6HXTnCjxkr9Z81Ma/Ef4qfT
 zhPsgBpjNHh3pyopCrby4CUbkwKaDc2IT77PTkGr069T7v126LY4Y
X-Received: by 2002:a05:6512:1242:b0:536:7a24:8e89 with SMTP id
 2adb3069b0e04-5367ff32c37mr1623725e87.49.1726229645861; 
 Fri, 13 Sep 2024 05:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5A5Vr/dDGcWXiZT5zEgFGBFWZPvUqs/3p0RC9zvUmbS1gjeC0pMQ0mmefYUhsxXy9qLqEtw==
X-Received: by 2002:a05:6512:1242:b0:536:7a24:8e89 with SMTP id
 2adb3069b0e04-5367ff32c37mr1623694e87.49.1726229645168; 
 Fri, 13 Sep 2024 05:14:05 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-122.web.vodafone.de.
 [109.43.178.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ce970csm860957666b.159.2024.09.13.05.14.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 05:14:04 -0700 (PDT)
Message-ID: <67a460bd-52e9-4f97-a242-19a759d959d1@redhat.com>
Date: Fri, 13 Sep 2024 14:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
 <Ztq5068xW640qeuD@redhat.com>
 <CAFEAcA-naWfN5sLSJ3uS6VjC3HWvyaGqAk0=B_iqTYgtJOH+ow@mail.gmail.com>
 <87r09wlu87.fsf@suse.de> <87r09nzxaq.fsf@pond.sub.org>
 <CAFEAcA9nHvrm1K=WFQROLDuY-g9F2zk4C0CFk4bqZKc1d5hUFg@mail.gmail.com>
 <878qvvzt8u.fsf@pond.sub.org>
 <CAFEAcA8qvtspX5_aiepUy+61R2Kj+q3bgPJM=N29RtjjqjPH1Q@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8qvtspX5_aiepUy+61R2Kj+q3bgPJM=N29RtjjqjPH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/09/2024 13.46, Peter Maydell wrote:
> On Fri, 13 Sept 2024 at 12:29, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> Specifically, if you don't disable the error-exit when qtest
>>> is in use, then the generic qom-test tests which say "can we
>>> at least instantiate every machine?" will fail, because they
>>> assume that "qemu-system-foo -machine bar -accel qtest" will
>>> at least start.
>>>
>>> It doesn't really seem feasible to me to have qom-test
>>> know about every machine's specific requirements for
>>> how to pass a guest image.
>>
>> Yes.
>>
>>> The other approach would be to standardize on "every machine
>>> type should happily start up with no warnings even if there
>>> is no guest code specified by the user and it would simply
>>> execute zeroes". We already do this for quite a lot of
>>> boards, including some major ones, so we're certainly not
>>> consistent about trying to diagnose user errors in this area.

IMHO executing zeros is also a bad idea ... most of those boards crash after 
a while when the program counter reaches an unmapped memory region.

Maybe we could simply put a "branch to self" instruction on the first 
program counter address in case the kernel/firmware cannot be loaded?

>> Fatal error unless qtest is bad, because we take a different path.
>>
>> Silently executing zero can be hard for users to diagnose.
>>
>> Possible compromise: warn unless qtest?
> 
> That runs into the "tests that pass and do what they're
> supposed to do shouldn't provoke warnings" unofficial
> guideline... Some of these qtest_enabled() checks are
> exactly to suppress a warning.

FWIW, I like the idea of having a error_report_user() function that is 
silent when running with qtest_enabled().

  Thomas


