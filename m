Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0059737516
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBh2p-0001Fv-Bp; Tue, 20 Jun 2023 15:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qBh2n-0001Fl-7I
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qBh2l-0001Rm-OR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687289372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eM+Qf0qJ/FsoHGQzFubuTMhV0VqegC4ZVJ/dklyzg+E=;
 b=XnP9kD3bqYQ2RMDhzEOgWWuY9VjgCk3lREk9PIrCyBSxjI3dn0HC+dWgaRvdYT0Bl9rYFL
 CORy02tL78NvZBZ5mCr1tY6AweTYkvYY9gCvP1Jh9srLi5RCQ4LOHFv/qJP7UkNu2wME1n
 JGI/COok8RvOHIBcOjsOFjzCEFWpUcQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-zQcQg7EJO_-02j8JAyyJWw-1; Tue, 20 Jun 2023 15:29:31 -0400
X-MC-Unique: zQcQg7EJO_-02j8JAyyJWw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4ec790b902bso3935319e87.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 12:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687289369; x=1689881369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eM+Qf0qJ/FsoHGQzFubuTMhV0VqegC4ZVJ/dklyzg+E=;
 b=PMX12BlnJEv0ve+855nSOxeeQyL5eOo1HxUWIR/MjqtJlM/ftmwh0ws9z83PRmhDNh
 WoIfNKPRgV3Y60ubreUUIZMrAPOZHLJxhkS0LgVwW2CD2EG2xSsNxjbGFD5s5Z7RTb3l
 0xAWvP5OvMUGPxv6gF+oDwhkkABcZQO5k1i62z2qDIqxotGAa0VlawITIvHtOUvt4jwY
 UzyYgfP88/I3TvX7dXSxQxIf4fhs0MiNAhcmo987WCnDFuQAI52/31bgGjSG0C0j6IQi
 HZjfQ9D1ElHd47pzi5vKehTQK1f6ITqh7vEPQrg2MgemICkt+Tv26wjmjPMg10rDc7LR
 P6FA==
X-Gm-Message-State: AC+VfDxI6gIiNcRvN/qCn6P5sjmF/w/dNboL4KqoZpRL1xDw6Qqo0m6e
 QgJxWI35OiOqc5XNMQA/eyZEvrjarr7IVtAbEkk4GVuxeAbFXLyqfkWB9jP6yPYUyJuvU0Hfioe
 i734e+9U3oMIpC9Y=
X-Received: by 2002:a05:6512:288:b0:4f6:924:8fa3 with SMTP id
 j8-20020a056512028800b004f609248fa3mr8079161lfp.58.1687289369445; 
 Tue, 20 Jun 2023 12:29:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5q+st8aGsCvPKqITMAHWFbCPXKbmnikliacaM5CdGcmEvibBTmgQQiOcE6K1nSjgaWto/z0Q==
X-Received: by 2002:a05:6512:288:b0:4f6:924:8fa3 with SMTP id
 j8-20020a056512028800b004f609248fa3mr8079152lfp.58.1687289369039; 
 Tue, 20 Jun 2023 12:29:29 -0700 (PDT)
Received: from [192.168.253.2] ([37.171.229.63])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b003f9b3829269sm6254072wmq.2.2023.06.20.12.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 12:29:28 -0700 (PDT)
Message-ID: <43fe7106-78c0-c431-aab6-395158f131e8@redhat.com>
Date: Tue, 20 Jun 2023 21:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/42] migration-test: Be consistent for ppc
To: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-2-quintela@redhat.com> <ZJG9utW5qi04ZM7s@x1n>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <ZJG9utW5qi04ZM7s@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/20/23 16:54, Peter Xu wrote:
> On Fri, Jun 09, 2023 at 12:49:02AM +0200, Juan Quintela wrote:
>> It makes no sense that we don't have the same configuration on both sides.
> 
> I hope Laurent can see this one out of 40s.

I had some luck...

> 
> Makes sense to me, but does it mean that the devices are not matching
> before on ppc?  Confused how did it work then..

I agree we need the -nodefaults on both sides.

It has been introduced by
fc71e3e562b7 ("tests/migration: Speed up the test on ppc64") (Thomas)

I think it works because destination side doesn't check for what is missing.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Thanks,
Laurent
> 
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   tests/qtest/migration-test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index b0c355bbd9..c5e0c69c6b 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -646,7 +646,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                         "'nvramrc=hex .\" _\" begin %x %x "
>>                                         "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
>>                                         "until'", end_address, start_address);
>> -        arch_target = g_strdup("");
>> +        arch_target = g_strdup("-nodefaults");
>>       } else if (strcmp(arch, "aarch64") == 0) {
>>           init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
>>           machine_opts = "virt,gic-version=max";
>> -- 
>> 2.40.1
>>
> 


