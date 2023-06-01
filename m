Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE3D71E380
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ksF-0005kh-9R; Thu, 01 Jun 2023 12:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ks4-0005j8-O2
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ks2-00039B-JE
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685635789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6+AfhYhEOO/tPARKGnGtVzM1/nav++6B7wlZRNoKIY=;
 b=PPPjThqsP2Tq8NTResDdIOMzmQouAxVdhC4Xnn95ajzNuKJQzAKCps7umOJQlmaBWdRcvm
 znd/+CgiUeRUTEIulAoe5k7F4Yj7u/bTsTCkmv6O2uripeOqRH6sS6xVaf26UTdAZiUYs2
 /R0/UYRuQ2dH12IZ0TK+jm0L92TYL5o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-XTVWjZYbMSqNXQo2CJvCVw-1; Thu, 01 Jun 2023 12:09:48 -0400
X-MC-Unique: XTVWjZYbMSqNXQo2CJvCVw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-514b8d2b21fso779606a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 09:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685635787; x=1688227787;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6+AfhYhEOO/tPARKGnGtVzM1/nav++6B7wlZRNoKIY=;
 b=IDFE5hfuTTi9c1w8clDolgjOqNrDZ7kyLbFrrkldxsN9/O4+rIJFex++x9XUlFKgK9
 MkE/Z9fFi0aTihiYY4dEkQi+n/cScNws+IjM38bWyMi549YIZHynKyiH6kKamwDjRg7E
 Abr0oby4rm3AFeQwqX/hCyKvCibnJqJiMK+4UZHWbVmgm8/H16oVo6AGqBg4W1FYNMm9
 pYM669l1aMnQjlkbSQGnhfPHfib5Yeff82Cmb4rlLBLc+PtUeG8qyk153rRw8T9tLiCF
 KbrHKQLRnpWucLs18oL5AYQHKGVIaDFEERMe5XNGhwUeXM5iQgMcyOCg225ysKguSUxB
 DssA==
X-Gm-Message-State: AC+VfDxx6mk3u2Y2+tmPCtF7S6k7aR9Hba4MrX2rvBS/w0tAvTQUaT5x
 QU3XaoL8vX40bktwtqsg81VIp9DLyogisv78nLZCliN1YdiJ7ubSqhy1URVF8Cf33ZtOGTg28gs
 bSZaaAk+lpF+I5F4=
X-Received: by 2002:a17:906:da8e:b0:966:5035:6973 with SMTP id
 xh14-20020a170906da8e00b0096650356973mr8680908ejb.50.1685635786855; 
 Thu, 01 Jun 2023 09:09:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eH0D2/55B880RIigpRHaHpM2SWFhu7pCa2IEOff646IU9G1HxnzzabS82/jHcVHj0smgJuw==
X-Received: by 2002:a17:906:da8e:b0:966:5035:6973 with SMTP id
 xh14-20020a170906da8e00b0096650356973mr8680894ejb.50.1685635786573; 
 Thu, 01 Jun 2023 09:09:46 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 la11-20020a170906ad8b00b00965f5d778e3sm10770314ejb.120.2023.06.01.09.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 09:09:46 -0700 (PDT)
Message-ID: <7c02b1c2-1636-24d9-8466-3bcc6c88acbd@redhat.com>
Date: Thu, 1 Jun 2023 18:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: quintela@redhat.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com> <87a5xjs6ob.fsf@secure.mitica>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
In-Reply-To: <87a5xjs6ob.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 01/06/2023 14.33, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
...
>> On a test machine this reduces execution time from 13 minutes to
>> 8 minutes.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Hi
> 
> I have a different idea to get the migration tests faster.  Namely, just
> stop letting enter the completation stage until we are ready to use it.
> 
> I need that functionality also for vfio migration, so as I have to
> create the patches, can we put on hold the last two patches and give me
> a couple of days?

A couple of days are certainly OK ... but could we please avoid being stuck 
in the current situation for many more weeks? The slowness of the migration 
tests are really slowing down my turnaround times, and I think they 
contribute to the timeouts of the Travis CI tests that I'm currently facing, 
and likely also contributed to the issue that the QEMU project ran out of 
Gitlab CI minutes again last month (which is thankfully mostly hidden by the 
new private Linux runners, but some things like the Windows runners were not 
available anymore). So I'd appreciate if we'd rather get a speed up here 
merged rather sooner than later.

> Thomas, do you care if I get the whole sets of patches through the
> migration tree? 

That's fine, please take them through your tree!

  Thomas



