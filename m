Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 789CF79D335
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:07:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg42o-0005EI-BS; Tue, 12 Sep 2023 10:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qg42m-0005Cf-BB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qg42i-0006RZ-Pr
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694527621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOgiTIOF28SLWPKO6C1Q4IH7CcK5sMErRNGmjD6VAEs=;
 b=h2BCuI4AsvUU9PX7tPSmKKS38DYhG1gizmQDN60eBgE0TFNApSHv8BEdCnJOsWHSwDgU9W
 zv+AXBfIpgJOWcDpsxHnlCqtBp5OilPkoRz6ImF0PTqCOtXN84++IQQF41TqA026AP4L+o
 zfhwE7GHLJMYlejIl4jsPdC1QW6JWwE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-faf36xYRMGGeAs7gp4sNjA-1; Tue, 12 Sep 2023 10:07:00 -0400
X-MC-Unique: faf36xYRMGGeAs7gp4sNjA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41362ffd32aso66417061cf.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527619; x=1695132419;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WOgiTIOF28SLWPKO6C1Q4IH7CcK5sMErRNGmjD6VAEs=;
 b=R2Oxp6nILBGbG7l3HEWmv6fkAKyza+nEZiG7zCzpE7lbvbuhc+Ebh42RxpPJRxa40i
 T7laQUbDffoqo7X0M6dx0PxDziCcwMgHgviC6CBGBEee7hhZrygk8SQ3HxAi5+slPaYD
 VxToK+oMxNarIKvJsJz8dg4aujUcqgATGjDqPqYqQIkMSgLAGCErKwfUBPr1F+jUE47/
 XyYrJAgmJnPzdG1pDwZRffuRWgwrI0cPugyHbPKM/48bfVA9vAZccXmoyjZhnxeQnA5p
 3E1yjQmN/FHHDNG4wMOSpabQUdW16KKJRexl2YOPOIel3QxDBpN/Sj2LoJWO6+fTSo8E
 CgXw==
X-Gm-Message-State: AOJu0YyBem1w1dsKTkTixjrBAP3vWHvYbc3zSMbf+cgyO2XPjHwCEGLq
 iBCUwkzsKFzzCjElYVOQQPfgY4s22LjB+7vTELVdjHxbsaYAjWqA1ucD70BP9ac1ZHJMKwIHcml
 ES38HzpadqtvoDvw=
X-Received: by 2002:a05:622a:349:b0:412:21cb:e9b with SMTP id
 r9-20020a05622a034900b0041221cb0e9bmr17034681qtw.34.1694527618642; 
 Tue, 12 Sep 2023 07:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiZC8IodPQg7OpJf14idF9v0gH6aTDg2tHxT0cmmX3VyS2AcSAcTee7ev1LJmh6IdlUQU5Sw==
X-Received: by 2002:a05:622a:349:b0:412:21cb:e9b with SMTP id
 r9-20020a05622a034900b0041221cb0e9bmr17034646qtw.34.1694527618189; 
 Tue, 12 Sep 2023 07:06:58 -0700 (PDT)
Received: from [192.168.100.28] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 z17-20020ac84551000000b004108f6788a6sm3335209qtn.41.2023.09.12.07.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 07:06:57 -0700 (PDT)
Message-ID: <479c6698-2f32-6771-b758-28d85f100963@redhat.com>
Date: Tue, 12 Sep 2023 16:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/qtest/netdev-socket: Raise connection timeout to
 120 seconds
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230912133310.60583-1-stefanha@redhat.com>
 <ZQBqqu9NNygDhBAM@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <ZQBqqu9NNygDhBAM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
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

On 9/12/23 15:42, Daniel P. Berrangé wrote:
> On Tue, Sep 12, 2023 at 09:33:10AM -0400, Stefan Hajnoczi wrote:
>> The test still fails intermittently with a 60 second timeout in the
>> GitLab CI environment. Raise the timeout to 120 seconds.
>>
>>    576/839 ERROR:../tests/qtest/netdev-socket.c:293:test_stream_unix: assertion failed (resp == expect): ("st0: index=0,type=stream,connection error\r\n" == "st0: index=0,type=stream,unix:/tmp/netdev-socket.UW5IA2/stream_unix\r\n") ERROR
>>    576/839 qemu:qtest+qtest-sh4 / qtest-sh4/netdev-socket                            ERROR          62.85s   killed by signal 6 SIGABRT
>>    >>> MALLOC_PERTURB_=249 QTEST_QEMU_BINARY=./qemu-system-sh4 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_IMG=./qemu-img /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/netdev-socket --tap -k
>>    ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>>    stderr:
>>    **
>>    ERROR:../tests/qtest/netdev-socket.c:293:test_stream_unix: assertion failed (resp == expect): ("st0: index=0,type=stream,connection error\r\n" == "st0: index=0,type=stream,unix:/tmp/netdev-socket.UW5IA2/stream_unix\r\n")
>>    (test program exited with status code -6)
>>
>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1881
>> Fixes: 417296c8d858 ("tests/qtest/netdev-socket: Raise connection timeout to 60 seconds")
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> That bumped the timeout from 5 seconds to 60 seconds to
> cope with intermittent failures, which was a x12
> increases. I'm concerned that it would still be failing
> in largely the same way after that, and possibly we are
> instead hitting a race condition causing setup to fail,
> which masquerades as a timeout.
> 
>> ---
>>   tests/qtest/netdev-socket.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
>> index 8eed54801f..b2501d72a1 100644
>> --- a/tests/qtest/netdev-socket.c
>> +++ b/tests/qtest/netdev-socket.c
>> @@ -16,7 +16,7 @@
>>   #include "qapi/qobject-input-visitor.h"
>>   #include "qapi/qapi-visit-sockets.h"
>>   
>> -#define CONNECTION_TIMEOUT    60
>> +#define CONNECTION_TIMEOUT    120
>>   
>>   #define EXPECT_STATE(q, e, t)                             \
>>   do {                                                      \
> 
> I'll add
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> but with the caveat that i'm only 50/50 on whether this is actually
> the right fix. Doesn't hurt to try it, but if 120 seconds still shows
> failures I'd say we're hitting a functional race not a timeout.

It can also happen if the first QEMU (server) crashes. Do we have some traces from this side?

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Thanks,
Laurent


