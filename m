Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 482857D3E49
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 19:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quz1X-0002bV-TF; Mon, 23 Oct 2023 13:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1quz1J-0002b0-00
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1quz1H-0002mL-66
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698083234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j7SYw79g2I5E6DmXc6G5L42Qoa1cEEOV4NCaPwvJ6UA=;
 b=AKNjw+agOAWRZTxR5DILhHbXjkRaVOfIgtdJoWwayoR3rB2KEoI0WRK+oXxZO47cglHahV
 dQ7LrWAz+4InYNradXyosxj2JSeeaVyKAqkR/QVfSqJup1QpLxXnTqTxnBhdq7aoO06MQL
 neyYPy2QpnUQR/o7770sYkMqoijV1yE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-c-NCg_KMP8OcgzX7WqUwOQ-1; Mon, 23 Oct 2023 13:47:12 -0400
X-MC-Unique: c-NCg_KMP8OcgzX7WqUwOQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6557c921deeso54279506d6.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 10:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698083231; x=1698688031;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j7SYw79g2I5E6DmXc6G5L42Qoa1cEEOV4NCaPwvJ6UA=;
 b=erAtZ7jWb0oilZEvvhJU1Bx+oed4zJiXEXHrtwPKc1sGY7jvmFRlTg7S85hq7o5I9P
 8nYSmaY3rqEAcit9F3GxsRaxCMggzzkl9S6fxhY+k3XXcFDzXdA9el/BFW8eo+gPGCYU
 sundgvEaMuAWbFMmR/VTFlAgk8p0CKBAfz4r7NjcFxo+wDWZQaOcMaaJLC5Vvj/+TFj/
 xBjKd+3no7WGAvxsilLWAtBSPjKr8WRrb2dAPbvfZSxLweiPVoAAoLXxg0mdD9+PDFho
 PYwTPmG5+GYbETnb8hQ0tzSq0tzZhlw9qMeuxx0d+wdCbrEkPFAaUr0iO6ZKjxjOmN4K
 tc2Q==
X-Gm-Message-State: AOJu0YwQQ39GMBQX1zJgU/jhFUBOmE3q9/Qog2BgWRNdcRf8x7OqG+Oo
 lwEuOV9EmOY8UD8t+OjMXrDvenD1aaFJ5mmrz1TlERT3/sXF3QxbVGofg4IUlZuLOqoouD61X/E
 zYYozf9J0PZckG9Q=
X-Received: by 2002:a05:6214:21e8:b0:66d:237d:8f75 with SMTP id
 p8-20020a05621421e800b0066d237d8f75mr11610029qvj.35.1698083231637; 
 Mon, 23 Oct 2023 10:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyMU1JlLxWNkYFETpMI1Ir2FieoH1U1ibOHiZHlQZAfjE1MkUU0V+vf8MGfYrhofU8JDKfNQ==
X-Received: by 2002:a05:6214:21e8:b0:66d:237d:8f75 with SMTP id
 p8-20020a05621421e800b0066d237d8f75mr11610014qvj.35.1698083231433; 
 Mon, 23 Oct 2023 10:47:11 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 m17-20020ad44d51000000b0066d04196c39sm3029642qvm.81.2023.10.23.10.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 10:47:10 -0700 (PDT)
Message-ID: <d3118b33-920c-4a1d-993a-ef17aab2489a@redhat.com>
Date: Mon, 23 Oct 2023 19:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/snapshot: Fix compiler warning with -Wshadow=local
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20231023144402.103139-1-thuth@redhat.com>
 <87zg09jr7b.fsf@pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87zg09jr7b.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/10/2023 17.26, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> No need to declare a new variable in the the inner code block
>> here, we can re-use the "ret" variable that has been declared
>> at the beginning of the function. With this change, the code
>> can now be successfully compiled with -Wshadow=local again.
>>
>> Fixes: a32e781838 ("Mark bdrv_snapshot_fallback() and callers GRAPH_RDLOCK")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   block/snapshot.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index 6e16eb803a..50adf5381e 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -629,8 +629,8 @@ int bdrv_all_goto_snapshot(const char *name,
>>       while (iterbdrvs) {
>>           BlockDriverState *bs = iterbdrvs->data;
>>           AioContext *ctx = bdrv_get_aio_context(bs);
>> -        int ret = 0;
>>           bool all_snapshots_includes_bs;
> 
> Blank line between declarations and statements, please.
> 
> I'm not sure we actually need the assignment.  Proving we don't looks
> like a poor use of our time, though.

I stared at the code for a while, and I think we don't urgently need it. But 
I'd still recommend to rather keep it to render the code more robust for 
future changes (imagine someone adds some code that changes ret in between, 
but does not return on negative values...)

> I recommend to move the assignment from here...
> 
>> +        ret = 0;
>>   
>>           aio_context_acquire(ctx);
>>           bdrv_graph_rdlock_main_loop();
>             all_snapshots_includes_bs = bdrv_all_snapshots_includes_bs(bs);
>             bdrv_graph_rdunlock_main_loop();
> 
> ... down to here.
> 
>             if (devices || all_snapshots_includes_bs) {
>                 ret = bdrv_snapshot_goto(bs, name, errp);
>             }

IMHO this would look best in my eyes:

         ret = (devices || all_snapshots_includes_bs) ?
               bdrv_snapshot_goto(bs, name, errp) : 0;

I'll send a v2 with this change.

>             aio_context_release(ctx);
>             if (ret < 0) {
> 
> We lose the symmetry with the other three while (iterbdrvs) loops.  Do
> we care?

No, at least I don't ;-)

  Thomas


