Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E748CBAB8
	for <lists+qemu-devel@lfdr.de>; Wed, 22 May 2024 07:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9eeD-0006xT-1B; Wed, 22 May 2024 01:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9ee5-0006wN-TA
 for qemu-devel@nongnu.org; Wed, 22 May 2024 01:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9ee3-0006cy-Qx
 for qemu-devel@nongnu.org; Wed, 22 May 2024 01:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716356169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R0VbEL2i6Je+9K+x4HjxhowD6hdnCDziXeCi0mb6/lg=;
 b=g8foLMBwfT5xRb1fETg/BP3DynyX7MVNOvQzQK1xG7XVhFvSj5a0GCm1EnFd1YbRHVplL3
 AOfAcazvTiCSbczTq7iGWHEVcRXoT5oTl2cXU5RaWeVdGvDzV/CxZojUz+n8i5xDjAJ9iu
 GA4rzokFjAK+iscIJwplZ9JNBsdhy/4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-LfMUkH90NCaR9UeOYc-gSg-1; Wed, 22 May 2024 01:36:07 -0400
X-MC-Unique: LfMUkH90NCaR9UeOYc-gSg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43df64b7bd6so10529191cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 22:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716356167; x=1716960967;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0VbEL2i6Je+9K+x4HjxhowD6hdnCDziXeCi0mb6/lg=;
 b=jzb8eQ04OW3kYVUa+Wp7EJOaYd2FJ0IjI12rZCfeJsAUygeriE08RcbNRjmRpKzXjw
 7mAz/RHlQiXc5Tqfg4tEf4/H76xNJMN6u9Yovb2RRnklNhWDUjhYYtgRA/GpsNpQCQhH
 N3UhTsxYJopoeLJXaMrY/uAKR8iA9tvE7xgf3rfGwi8z91rEV5NFyP/u/Qi1PF7JAoB7
 ZmoqeuvRaRvXLtWOo2FQmRtZoRopjIT1hvPsCRf/qssoX43kHkoRfda+TXju3WB1iyzX
 +KctyRdVU/vh2ffJtoXv9RdgwcFlBDbSHI9xjG4+OqGhvfECOXhLmFv/OusTnre0vOcU
 l6TQ==
X-Gm-Message-State: AOJu0YzVF3Io5RqOvIgi6SxVGeijOrppcapyviXyyE61+BAbbDK/VBDq
 T1e39JVw5cxkj1TS87tt///VH8O0xPMXejMhFdNRdlRM+dNhjK/U+lPUncfmQfFCnRyZ8feqqJv
 C6g+mgNAk6AQbuAdrhZWGm8Z7TW8z0F2DgDfn7C+CIXwj8Ef2Hi8r
X-Received: by 2002:a05:6214:21e1:b0:6a1:55de:7a23 with SMTP id
 6a1803df08f44-6a841a4f316mr189546916d6.6.1716356167291; 
 Tue, 21 May 2024 22:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRQrIzRZp/zq328lZtxynMy10GtYgW/C5Pdc3eskyIsDnxFoYTqoneO2amg7c2a1/T/EizGQ==
X-Received: by 2002:a05:6214:21e1:b0:6a1:55de:7a23 with SMTP id
 6a1803df08f44-6a841a4f316mr189546556d6.6.1716356166824; 
 Tue, 21 May 2024 22:36:06 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1ff4f2sm130492526d6.134.2024.05.21.22.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 22:36:06 -0700 (PDT)
Message-ID: <3d437c79-89c0-4268-941f-0f97eb6d05b2@redhat.com>
Date: Wed, 22 May 2024 07:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/38] tests/qtest/migration: Add a test for the
 analyze-migration script
To: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231017083003.15951-1-quintela@redhat.com>
 <20231017083003.15951-11-quintela@redhat.com>
 <87wmnnic86.fsf@draig.linaro.org> <87bk4zjpt2.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87bk4zjpt2.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/05/2024 14.46, Fabiano Rosas wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> From: Fabiano Rosas <farosas@suse.de>
>>>
>>> Add a smoke test that migrates to a file and gives it to the
>>> script. It should catch the most annoying errors such as changes in
>>> the ram flags.
>>>
>>> After code has been merged it becomes way harder to figure out what is
>>> causing the script to fail, the person making the change is the most
>>> likely to know right away what the problem is.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> Message-ID: <20231009184326.15777-7-farosas@suse.de>
>>
>> I bisected the failures I'm seeing on s390x to the introduction of this
>> script. I don't know if its simply a timeout on a relatively slow VM:
> 
> What's the range of your bisect? That test has been disabled and then
> reenabled on s390x. It could be tripping the bisect.
> 
> 04131e0009 ("tests/qtest/migration-test: Disable the analyze-migration.py test on s390x")
> 81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py for s390x")
> 
> I don't think that test itself could be timing out. It's a very simple
> test. It runs a migration and then uses the output to validate the
> script.

Agreed, the analyze-migration.py is unlikely to be the issue - especially 
since it seems to have been disabled again in commit 6f0771de903b ...
Fabiano, why did you disable it here again? The reason is not mentioned in 
the commit description.

But with regards to the failures, please note that we also had a bug 
recently, starting with commit 9d1b0f5bf515a0 and just fixed in commit 
bebe9603fcb072dc ... maybe that affected your bisecting, too.
(it's really bad that this bug sneaked in without being noticed ... we 
should maybe look into running at least some of the migration tests with TCG 
on x86 hosts, too...)

  Thomas


