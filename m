Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C608B1A36
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 07:13:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzrPD-000250-5U; Thu, 25 Apr 2024 01:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzrOy-00022x-HT
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 01:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzrOu-00013V-0u
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 01:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714021922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m7aN9cWRPqq8TlS4zwAFjvc4xU7XygYlyz2LPqgYFNY=;
 b=MFC1LnorB6RBcVUivGBDe9uVzTbIp7tvQ4Lbsyb/+cEseHgXUKi7Y0dd05EJrEFvf46lcr
 cDfd1HwzU+WoW1QoSfiGUSiY+6a2SXnWBJLb01q8J76khPaUuv4c9DU8npPe+xskDzNqed
 9wO4zW8NN92OvzjzLw68Sl0fyp0b5Ig=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-8qN1sQUaM_SaRNi2QqCJUw-1; Thu, 25 Apr 2024 01:11:44 -0400
X-MC-Unique: 8qN1sQUaM_SaRNi2QqCJUw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51affa83f97so416141e87.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 22:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714021903; x=1714626703;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m7aN9cWRPqq8TlS4zwAFjvc4xU7XygYlyz2LPqgYFNY=;
 b=BKKHAbT4d7csKrE6NqKOyK8En3fYgMBFTAoSafVtys1e8CooClphmmA1gj/HOW0uCr
 23I7FvRNp+Sbmbb7wwW9xFFXmdNQfMVU/POsycbFV2eoFqVuwZKx19C4zM5UXvamHF5s
 n20zwWe6q/5Jr7jk/633e3Jx9ymd7wqiS4XQoLkHU4Z2KrR7DYny4Y3MtV9Kw+LDEp0w
 vFYdxwRffl2kV+bahhBzpiCaSAhGT5HwqcQAkHKKeP7oscAelV+EGQ5AsCQclehN+0Va
 SPhgKU3AuKPAih4pFkhYks0DtAE06wo//rVH7nLXVzn6ofF/i2VVUEftoul7hwIPbAaW
 9WTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbvQizvu/7GJkpQ0DIKNJbbitgIwHevax6dvwnNwmdy5159WyqtePr+oXcC3HnlP4OQiWYSA7+legHSRe6NLZUMOB7oLI=
X-Gm-Message-State: AOJu0YxCteLXOjdU33O4J4TylN6iDM/Rk7+4VWSl66w0I8pfKvrzeghc
 VDtMlb7MwEiu+0MVw+ILo4B8LA4J/RJa9HotrQgzunpFFpyhq6uGuwlo4lC9wit+zDXaylP6Don
 9QaN18VPYSK0IacRdwWHa/FEhmLPM0AKkbyAXGaAWaECuW7dgD7q5
X-Received: by 2002:ac2:5dd4:0:b0:51b:962:4dd0 with SMTP id
 x20-20020ac25dd4000000b0051b09624dd0mr3542315lfq.3.1714021903372; 
 Wed, 24 Apr 2024 22:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3vAAqKzFCmLdzDgKKUf54maj17wouIxVQyoXwYWoBl9HkgTc+YHtZgpQt0TnfvHXzYUFVUA==
X-Received: by 2002:ac2:5dd4:0:b0:51b:962:4dd0 with SMTP id
 x20-20020ac25dd4000000b0051b09624dd0mr3542300lfq.3.1714021902889; 
 Wed, 24 Apr 2024 22:11:42 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-130.web.vodafone.de.
 [109.43.177.130]) by smtp.gmail.com with ESMTPSA id
 h3-20020a170906260300b00a559965b896sm6473951ejc.202.2024.04.24.22.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 22:11:42 -0700 (PDT)
Message-ID: <91090e7f-4972-4473-8378-402c43116dba@redhat.com>
Date: Thu, 25 Apr 2024 07:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] CI job updates, header cleanups and other misc
 patches
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424075735.248041-1-thuth@redhat.com>
 <d4b2c78e-c8d4-465c-a47e-53aa49efeb06@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d4b2c78e-c8d4-465c-a47e-53aa49efeb06@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
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

On 24/04/2024 18.21, Richard Henderson wrote:
> On 4/24/24 00:57, Thomas Huth wrote:
>> The following changes since commit 13b1e9667737132440f4d500c31cb69320c6b15a:
>>
>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into 
>> staging (2024-04-23 17:35:57 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-04-24
>>
>> for you to fetch changes up to 8f29bab03ea22694a127ee33edeb4ce99eeb124e:
>>
>>    target/s390x: Remove KVM stubs in cpu_models.h (2024-04-24 09:45:02 +0200)
>>
>> ----------------------------------------------------------------
>> * Update OpenBSD CI image to 7.5
>> * Update/remove Ubuntu 20.04 CI jobs
>> * Update CentOS 8 CI jobs to CentOS 9
>> * Some clean-ups and improvements to travis.yml
>> * Minor test fixes
>> * s390x header clean-ups
>> * Doc updates
> 
> This introduces a failure in the migration-compat-x86_64 job:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/6707154868

It wasn't failing for me:

  https://gitlab.com/thuth/qemu/-/jobs/6702058896

And according to the diffstat of my pull request, it's only touching test 
files, docs, and s390x stuff, so I somehow fail to see how it could 
influence x86 migration at a first glance. It also looks like the job is 
running on opensuse, and not on CentOS or Ubuntu, so it should likely not be 
influenced by the changes in this PR.

Could you please hit the re-run button of that job? If it then passes, we're 
likely rather facing an intermitted failure that might have been introduced 
earlier already...

  Thanks,
   Thomas


