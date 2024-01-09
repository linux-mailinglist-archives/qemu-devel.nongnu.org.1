Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDB6828256
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 09:45:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN7jM-0004fn-TV; Tue, 09 Jan 2024 03:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rN7jK-0004dH-RV
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rN7jJ-0003NH-0K
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 03:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704789899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FAyA8pwyoAZXvd8xi1gEyEdW7jCyGnrljGoXZOUNmEE=;
 b=VuAUM0z/yyp9dETpnCFKWwHLloLh/+sb3yMhtFrIZaLH8CDewP9Epujb9XZ3MoKh3Wjhdg
 NzF86Gglm02bEGmVQcFXLWjYeujJouxCA4qHOclT7DlUwlShyHJLuaKpt2YH66iOBN1OEQ
 uASVeVeVjrQ1RWRrSu172zBkLmV/uqA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-fOOxaYPBPmyaCCqDs6r3dg-1; Tue, 09 Jan 2024 03:44:52 -0500
X-MC-Unique: fOOxaYPBPmyaCCqDs6r3dg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-557a615aa33so828692a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 00:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704789891; x=1705394691;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FAyA8pwyoAZXvd8xi1gEyEdW7jCyGnrljGoXZOUNmEE=;
 b=YfBVqAKIKCSPTVsfnMTPMq6xpBcym6/JNw1JraLHYv6Ak8RaMdNhuqlpHvnqRI/51j
 PADKx8UrGQA9+bz2AI8InWIp9JtV8oirgt+t4kfVWBn7FX4BtNDAYHin2TVkZ8MUctfv
 2UJVTTJPrMkhpRG/lKzsYO179IZPG9OfRGJzKWsVzRX/VUc3TCzc4d+/X1GusvkerIrJ
 2HO+iTIZgNpE4a1LPGyRlGUu5y7HhXH9Z9nlZ9GngVWXpLSxZfRTaFS8RUpm9aR++qfF
 ConeQ10nUlXRkq2Nd9J7Vt/Zn+QUfNEX0L0gaPQwL2OSPFJ8GYTtfu6CgmCA2c+SgdxJ
 uBpw==
X-Gm-Message-State: AOJu0YyOdAkw0g3Wu0q3LYOYKM74+F6knEFfqe3gkfR6k9lVwYn+yUd6
 xK74Z8eH6ntLernNmOPNY2PWP2/Ol9qmj5DyqW5PXhIezjtfml3/NN9IvKbRsNTAdkMwR8VGcT/
 F48qMXr6w+59Q1LLFVH/Irpc=
X-Received: by 2002:a50:fb15:0:b0:557:1655:b11f with SMTP id
 d21-20020a50fb15000000b005571655b11fmr3018033edq.42.1704789891071; 
 Tue, 09 Jan 2024 00:44:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqh+5EuIZvgyFQFRTLhYnD+mhwiev2anSBq+FuFwwHFzLgoqz94h0z8wnKAk7D4kCGqCN3Yw==
X-Received: by 2002:a50:fb15:0:b0:557:1655:b11f with SMTP id
 d21-20020a50fb15000000b005571655b11fmr3018029edq.42.1704789890789; 
 Tue, 09 Jan 2024 00:44:50 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 a7-20020aa7d907000000b00557a2e4b585sm689911edr.66.2024.01.09.00.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 00:44:50 -0800 (PST)
Message-ID: <a7f57c82-48d7-4a4b-8ab6-4016f48f5be2@redhat.com>
Date: Tue, 9 Jan 2024 09:44:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/qtest: Re-enable multifd cancel test
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Leonardo Bras
 <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-4-farosas@suse.de> <87ttvjoexo.fsf@secure.mitica>
 <ZZuZcCxxIS6j_jHD@x1n> <87frz73nr7.fsf@suse.de> <ZZyrqnk3nJ3WIX8v@x1n>
 <5219f49a-c75d-4c42-86ba-4e4d90e58968@redhat.com> <ZZz6T8YU0_s-kNAt@x1n>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZZz6T8YU0_s-kNAt@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 09/01/2024 08.48, Peter Xu wrote:
> Hi, Thomas,
> 
> On Tue, Jan 09, 2024 at 08:21:53AM +0100, Thomas Huth wrote:
>> Sorry for that :-(
> 
> Not at all!  I actually appreciate more people looking after it.
> 
>> Maybe it's better if we remove the migration-test from
>> the qtest section in MAINTAINERS? Since the migration test is very well
>> maintained already, there's IMHO no need for picking up the patches via the
>> qtest tree, so something like this should prevent these problems:
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3269,6 +3269,7 @@ F: tests/qtest/
>>   F: docs/devel/qgraph.rst
>>   F: docs/devel/qtest.rst
>>   X: tests/qtest/bios-tables-test*
>> +X: tests/qtest/migration-*
>>
>>   Device Fuzzing
>>   M: Alexander Bulekov <alxndr@bu.edu>
>>
>> (as you can see, we're doing it in a similar way for the bios tables test
>> already)
>>
>> If you agree, I can send out a proper patch for this later today.
> 
> Currently the file is covered by both groups of people, which is the best
> condition to me:
> 
> $ ./scripts/get_maintainer.pl -f tests/qtest/migration-test.c
> Peter Xu <peterx@redhat.com> (maintainer:Migration)
> Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
> Thomas Huth <thuth@redhat.com> (maintainer:qtest)
> Laurent Vivier <lvivier@redhat.com> (maintainer:qtest)
> Paolo Bonzini <pbonzini@redhat.com> (reviewer:qtest)
> qemu-devel@nongnu.org (open list:All patches CC here)
> 
> It makes sense to me e.g. when qtest reworks the framework, and we'd like
> migration-test.c to be covered in that same reworks series and
> reviewed/pulled together, for example, then those can go via qtest's tree
> directly.
> 
> If patch submitter follows the MAINTAINERS file it means all of us will be
> in the loop and that's the perfect condition, IMHO.  It's just that this
> patch didn't have any migration people copied, which caused a very slight
> confusion.
> 
> It'll be great in that case if qtest maintainers can help submitters to
> copy us if the submitters forgot to do so.  I think we should do the same
> when there's major changes for qtest framework for a new migration test.
> Would that work the best for us?

Ok, makes sense, let's try it that way!

  Thomas



