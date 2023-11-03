Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C8A7E0602
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 17:01:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywaG-0001sR-5G; Fri, 03 Nov 2023 11:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qywa1-0001qm-Gp
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qywZz-0003kH-Cy
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699027165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOuB5/FcgCaoX9Hqa1qgJGLYrjDEGTIOBu+u/Pv3hrk=;
 b=Du7kFzZdED092gmWnwI+PNoJaL74Lp+FAdlrrI1tRIcCqUX3OP8kW9fVWKIEw+HaEbW/rB
 X0n1xY9IMlEWYdTmwWjmJf86tv3y0A6m32Y0Hxtqris5XqA5GMT150hedQdur+tZrMc8Te
 UfeX/QmZpkPUg0Yx8oJxj7AZOpKfxIg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-2WUxjLe1PWOL5dW766nDTQ-1; Fri, 03 Nov 2023 11:59:24 -0400
X-MC-Unique: 2WUxjLe1PWOL5dW766nDTQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so14343125e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699027162; x=1699631962;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XOuB5/FcgCaoX9Hqa1qgJGLYrjDEGTIOBu+u/Pv3hrk=;
 b=n4y3yxz0te9r3uv3oloj9AfIN2fOaZADlrQfwqdg+yv/gS6cnTRJBeNWAN58pLyF7k
 FL6KRMyL+oVkrNtAgETwbYNrwjcC9nvUM237GKCBaO8M05XMqGCvWDSB84Q4cbReT2Lc
 4iSm7FmaDWN4ArTx0vwETvyDN3rFewtcSTnMXZeFTSMC0G/GWUG0ABRxibFY9Li99lwW
 58LA97fKstrBN7zW/Qq3Fl4Qtqv2jiY7+qyGZVgdTKNq10Z+Y2R8+gRrimJehHb686ED
 pZObmjQa+63kpzHbngDtfuTUy2o0ADPxcfBpfi+mwP+G2FbLXnyCxWC23gyYgWTWz177
 xFrg==
X-Gm-Message-State: AOJu0Yz62peX90G9zTnYv0v57fOEsSZl3AkQimD3VRgVb5UTNEB3sWH9
 vp0I0+LJsw77CGjP/RPdM+RohEe5cWS7KxePEjsecX+bF0ajkH5Gy01M/r3/D9RJwTRr/9wRi6G
 YF2S3nzIJ3VtLVkI=
X-Received: by 2002:a05:600c:4f85:b0:404:7670:90b8 with SMTP id
 n5-20020a05600c4f8500b00404767090b8mr19909635wmq.27.1699027162653; 
 Fri, 03 Nov 2023 08:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqoZa/6t5uc3kvX7IvWv9yJkz0aE/Wo1PchvU3dVitaxWsaHpXzdwpa+fKyn7A/w22IDwyFw==
X-Received: by 2002:a05:600c:4f85:b0:404:7670:90b8 with SMTP id
 n5-20020a05600c4f8500b00404767090b8mr19909619wmq.27.1699027162361; 
 Fri, 03 Nov 2023 08:59:22 -0700 (PDT)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c458d00b00406443c8b4fsm2901317wmo.19.2023.11.03.08.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 08:59:21 -0700 (PDT)
Message-ID: <ee9a27a6-732f-4f3d-90ad-9fe059919c7d@redhat.com>
Date: Fri, 3 Nov 2023 16:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] iotests/271: check disk usage on subcluster-based
 discard/unmap
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-8-andrey.drobyshev@virtuozzo.com>
 <90298f38-fe14-4659-87a3-9b4bd2f516df@redhat.com>
In-Reply-To: <90298f38-fe14-4659-87a3-9b4bd2f516df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 03.11.23 16:51, Hanna Czenczek wrote:
> On 20.10.23 23:56, Andrey Drobyshev wrote: 

[...]

>> @@ -528,6 +543,14 @@ for use_backing_file in yes no; do
>>       else
>>           _make_test_img -o extended_l2=on 1M
>>       fi
>> +    # Write cluster #0 and discard its subclusters #0-#3
>> +    $QEMU_IO -c 'write -q 0 64k' "$TEST_IMG"
>> +    before=$(disk_usage "$TEST_IMG")
>> +    $QEMU_IO -c 'discard -q 0 8k' "$TEST_IMG"
>> +    after=$(disk_usage "$TEST_IMG")
>> +    _verify_du_delta $before $after 8192
>> +    alloc="$(seq 4 31)"; zero="$(seq 0 3)"
>> +    _verify_l2_bitmap 0
>>       # Write clusters #0-#2 and then discard them
>>       $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
>>       $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"
>
> Similarly to above, I think it would be good if we combined this 
> following case with the one you added, i.e. to write 128k from the 
> beginning, drop the write here, and change the discard to be “discard 
> -q 8k 120k”, i.e. skip the subclusters we have already discarded, to 
> see that this is still combined to discard the whole first cluster.
>
> ...Ah, see, and when I try this, the following assertion fails:
>
> qemu-io: ../block/qcow2-cache.c:156: qcow2_cache_destroy: Assertion 
> `c->entries[i].ref == 0' failed.
> ./common.rc: line 220: 128894 Aborted                 (core dumped) ( 
> VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec 
> "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>
> Looks like an L2 table is leaked somewhere.  That’s why SCRI should be 
> a g_auto()-able type.

Forgot to add: This single test case here is the only place where we 
test the added functionality.  I think there should be more cases. It 
doesn’t really make sense now that 271 has so many cases for writing 
zeroes, but so few for discarding, now that discarding works on 
subclusters.  Most of them should at least be considered whether we can 
run them for discard as well.

I didn’t want to push for such an extensive set of tests, but, well, now 
it turned out I overlooked a bug in patch 4, and only found it because I 
thought “this place might also make a nice test case for this series”.

Hanna


