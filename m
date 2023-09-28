Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D97B1EBB
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrGb-0006yF-IL; Thu, 28 Sep 2023 09:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlrGX-0006xg-5u
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlrGG-0004YH-GU
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PuCvu4cl8bH2FCz++KgtnktgWC6ZSObKFR+/mlkoRuA=;
 b=FflYKLt9hikXthksCC1J5MtlKlglaGJczj7kkjFK5W1OZFhe/pHtJdW+p5Q+ZV8f7UMyd+
 nFnqbcf+lRKeia5rflA8cgML8gYhpBh64aqxPSo84kY5EztA7GuYAHSvIHVVEZjPAyazDK
 S6l9OdpdupKx0Tq7hXK7MZg7LLf9iEA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304--6qtVCRDMh-w3tU3Y2ARug-1; Thu, 28 Sep 2023 09:40:53 -0400
X-MC-Unique: -6qtVCRDMh-w3tU3Y2ARug-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4180b3a5119so171479451cf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 06:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695908453; x=1696513253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PuCvu4cl8bH2FCz++KgtnktgWC6ZSObKFR+/mlkoRuA=;
 b=iwn9nWLxocAL4Hm4tFYr8Ti4rJPrfExOwrG39HAMAGXMnZtmSdxW9yS2RPGd4OGFdf
 eiOAob83zHBgFfVAH2ciQ558sZDoqPfoR5y2knZfPGl1XX52sJg/Gjwk2HAbBHwo7V1Y
 MOeWgKZ5xfuVNQsnslcjoLxFsa3BaKDHEQjS5SQsCt8OcWykKJsmg3AUncmPbs/TGYiM
 /VuajBjyFLsz1zZcSIP+LCVSYgPYt/QKUaF7d6qKTBjfxqYZ0/NC+ICuc00Bdy0bZvfK
 b0IlqR63VfOiv2gZPfPTiD92UT8lZ/BOz7OWoP2TR5DclaYe4Ecad/OctUkkeLs2RyZY
 NMDQ==
X-Gm-Message-State: AOJu0YxR1JuU3lVZNk9utCqQukj+Ngx0/mywTEPjCUIuya3ml+UhMKGy
 mpkZR9ku4+9Ff9EoH58ACs8jyQzhBfR4rHGYWzRQBssNHQbceH3tWWGyfhi7jJO0GRSonHnsbw5
 adSQi6wMEr5pFXdk=
X-Received: by 2002:a05:622a:15c3:b0:419:584e:276 with SMTP id
 d3-20020a05622a15c300b00419584e0276mr1512829qty.11.1695908453239; 
 Thu, 28 Sep 2023 06:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxP5BNLyq6fwfFn0ETD8QfHBc9yf8r4+Hn2leJhnzEgiUza69nEgafLWAjxPkc3QJrX5LHUg==
X-Received: by 2002:a05:622a:15c3:b0:419:584e:276 with SMTP id
 d3-20020a05622a15c300b00419584e0276mr1512815qty.11.1695908452953; 
 Thu, 28 Sep 2023 06:40:52 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 jm8-20020a05622a750800b004052f71f79bsm6054345qtb.74.2023.09.28.06.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 06:40:52 -0700 (PDT)
Message-ID: <9a3212d0-f89a-33a9-a82b-53dcc3e4dcf6@redhat.com>
Date: Thu, 28 Sep 2023 15:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] qtest/migration: Add a test for the analyze-migration
 script
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230927214756.14117-1-farosas@suse.de>
 <62c405c9-27f2-a77a-1f94-8d03cf65fff6@redhat.com> <8734yyo22f.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <8734yyo22f.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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

On 28/09/2023 15.32, Fabiano Rosas wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 27/09/2023 23.47, Fabiano Rosas wrote:
>>> Add a smoke test that migrates to a file and gives it to the
>>> script. It should catch the most annoying errors such as changes in
>>> the ram flags.
>>>
>>> After code has been merged it becomes way harder to figure out what is
>>> causing the script to fail, the person making the change is the most
>>> likely to know right away what the problem is.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>> I know this adds a python dependency to qtests and I'm not sure how
>>> much we care about this script, but on the other hand it would be nice
>>> to catch these errors early on.
>>>
>>> This would also help with future work that touches the migration
>>> stream (moving multifd out of ram.c and fixed-ram).
>>>
>>> Let me know what you think.
>>
>> Without looking at this too closely, my first thought was: This sounds
>> rather like a good candidate for an avocado test instead. It's using Python,
>> so tests/avocado/ sounds like a better fit. Have you considered adding it as
>> an avocado test already?
>>
> 
> I intended to keep all migration tests at the same place. And well, to
> be honest, I have given up on avocado. Too unmaintained, incrutable
> logging and last time I tried to use it locally, it was leaving stale
> processes behind upon failure.
> 
> Of course, if that's the preferred place to put python tests I could do
> it, but I don't find it too compelling.

Well, I guess this test here is kind of borderline, since it does not 
introduce new Python code, but just calls a pre-existing python script...
maybe that's still ok for the qtests ... what do other people think?

>>   >+#define ANALYZE_SCRIPT "tests/qtest/analyze-migration.py"
>>
>> Why can't you use scripts/analyze-migration.py directly?
>>
> 
> I'm not entirely sure that's the case with QEMU, but generally build
> directories can move/not be directly under the source tree. The test
> wouldn't know from where to fetch the script.

AFAIK the build system puts a symlink for the scripts folder into the build 
directory, at least I have one in mine.

>>   >+    file = g_strdup_printf("%s/migfile", tmpfs);
>>
>> Please, no static file names for temporary files - tests might be running in
>> parallel, and then you get race conditions! Use something like
>> g_file_open_tmp() instead to create a file with a random name.
>>
> 
> Ok, I can do that. However, if you look for "tmpfs" in migration-test.c
> you'll see that's done all over the place. I'm thinking individual tests
> under glib are never run in parallel. At least for the migration suite.

Ah, sorry, my bad, I thought that tmpfs was simply pointing to "/tmp", but 
in fact it already contains a randomized name. So never mind, I think it 
should be fine what you're doing here.

  Thomas



