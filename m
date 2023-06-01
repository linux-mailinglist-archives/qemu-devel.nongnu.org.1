Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F10719521
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dOV-0006Qb-9s; Thu, 01 Jun 2023 04:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q4dOO-0006P1-OC
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q4dOM-0007Og-PJ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685607039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crZAgDw92Muex9r9sgpBdNMSBIrRTxxmxmCcsHJIpP8=;
 b=DjEGv5G542d7HfzxgvMb1cDNqMTDrE9PiwxaS831Y5zfIQjJihOr1ubvevUSQbCF9om4ak
 u9MMRp6stLJqeSYFpB3xD7H7TLl7juCEdPDb3IOqWpzXucpcojmdd9n6NVrBrH9NQmIYDf
 uBuZ9K7NcLWDsNVFbmkGsZGNMdZJHyA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-Ita1UV_jOiG3JZZsZFXA4A-1; Thu, 01 Jun 2023 04:10:38 -0400
X-MC-Unique: Ita1UV_jOiG3JZZsZFXA4A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af4f9678f3so4760421fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685607037; x=1688199037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=crZAgDw92Muex9r9sgpBdNMSBIrRTxxmxmCcsHJIpP8=;
 b=Fz8oad/zgzI4K/IXyjMOPY76tWEfVY12pCJT8c+rWz/EeXF4JXIC8pcwTT1+gLkoy9
 WcsfSsFWRy2bmp2KrACavSoe3cVtwlt2JUn3haMhbhUavZ2m+w1w72ef4ONninV7373i
 HW51uChfK9l/6Ew58Nku05j/K//iL5vPkCKSAW8l5ID3l5aLOS2IiCz0+HPamv+phTXH
 B+p0wEtFgi4e2KUR+nBMCvb0tajvdtII3DzTYiEumY1hgeDhdxZD8R4EqIuOWSQWfiPO
 VfYX38iwQ8hnwfnkf1Gyfo9n1eJ6Guv3jrHjCfE73EM5t2ArmGljFuqKNyFjqD5YxZnF
 eEdw==
X-Gm-Message-State: AC+VfDxRTT+x8JihShL4WFSwbzO0hLqGZ+6crbGNayAx7rD1S/hmjiAW
 fUBVp1lBEVy59FNEXJntUgAvNvs0q3yIIsAl8Qsn3mxYJi448aJ3gechX/QuEnRkc+8UFLLj1ep
 jcaiQreNBsdCfFyg=
X-Received: by 2002:a2e:9955:0:b0:2af:237b:ced4 with SMTP id
 r21-20020a2e9955000000b002af237bced4mr4406155ljj.9.1685607036941; 
 Thu, 01 Jun 2023 01:10:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EGjVyRd3H8bWp5TFU0SqBADfyS/3UwiP79cfZwdyY6QlWbjQTXqaz00MqZvQZ4CibQQkTmQ==
X-Received: by 2002:a2e:9955:0:b0:2af:237b:ced4 with SMTP id
 r21-20020a2e9955000000b002af237bced4mr4406140ljj.9.1685607036614; 
 Thu, 01 Jun 2023 01:10:36 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:e1ec:6307:c799:c188?
 (p200300cfd72ef7e0e1ec6307c799c188.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:e1ec:6307:c799:c188])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a056402019000b00514b3a2008esm2626775edv.2.2023.06.01.01.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 01:10:36 -0700 (PDT)
Message-ID: <391cb112-80da-e8b6-6561-d62adb4a26ba@redhat.com>
Date: Thu, 1 Jun 2023 10:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Using json: in common.rc's TEST_IMG
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <CAJSP0QX5XFw81XrHHn9p1pX+1y7tc+xMJLVx9YgRsMCkUwjW7Q@mail.gmail.com>
 <CAJSP0QXpxyVPXieK9W4h+NxK4KNkOvnFD4KvuDMcZ9PLx9Sfvw@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJSP0QXpxyVPXieK9W4h+NxK4KNkOvnFD4KvuDMcZ9PLx9Sfvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31.05.23 21:09, Stefan Hajnoczi wrote:
> Another issue is that 145 uses $TEST_IMG as follows:
>
>    SYSEMU_DRIVE_ARG=if=none,file="$TEST_IMG",driver=$IMGFMT
>
> That doesn't work when json: contains a comma, since commas need to be
> doubled up to escape them. This fails:
>
>    $ qemu-system-x86_64 -drive
> 'if=none,file=json:{"driver":"io_uring","filename":"test.img"}'
>    qemu-system-x86_64: -drive
> if=none,file=json:{"driver":"io_uring","filename":"test.img"}:
> warning: short-form boolean option '"filename":"test.img"}' deprecated
>    Please use "filename":"test.img"}=on instead
>
> This works:
>
>    qemu-system-x86_64 -drive
> 'if=none,file=json:{"driver":"io_uring",,"filename":"test.img"}'
>
> Maybe it's simply not possible to use TEST_IMG=json: in qemu-iotests?

Probably not as-is.  None of the tests has been written with that in 
mind, and many have been written at a time where TEST_IMG was basically 
always a plain filename.  We’ve had a lot of churn in the past e.g. to 
separate TEST_IMG_FILE out from TEST_IMG, and I suspect if you want 
json:{} to work, that would be even more churn.

Admittedly I don’t remember how it’s to be done, but looking at the code 
(common.rc starting from line 274), it seems clear what other protocols 
do: If $IMGOPTSSYNTAX is true, use a dotted-key-value syntax; and 
otherwise, make use of the protocol prefix.  Now, "io_uring:test.img" 
doesn’t work, because while bdrv_io_uring has .protocol_name set, it 
doesn’t implement .bdrv_parse_filename(). file-posix for example does 
(see raw_parse_filename()), and all it does is to strip the protocol prefix.

So I think you should be able to get the non-IMGOPTSSYNTAX case to work 
by adding a trivial .bdrv_parse_filename() implementation to each blkio 
driver, which just strips the protocol prefix, and then use 
"io_uring:$TEST_IMG_FILE".

Hanna

> The alternative is to always set IMGOPTSSYNTAX=true and then find the
> test cases that fail because they contain non-IMGOPTSSYNTAX commands.
>
> Stefan
>


