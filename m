Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A27E7FC0CA
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 18:56:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r82IO-0006WH-Jh; Tue, 28 Nov 2023 12:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r82IM-0006Vv-Ew
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 12:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r82IK-00060t-R3
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 12:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701194087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nkug30r8iqaMQMeVWTU8looLB/Oh9v0yht3x+Ht8NE=;
 b=MR0g1K0DbiAyONyVLnKfRrku+7ZLQTFUTbSgORM72tHIG+PVTo8CcI0KC8WW20cTjdkDTs
 WBxb0QRTD4o+oVUR8wVSuF4qcY9FljYQYy9UCsYtQFllGDsu4FOGuNI5BvOdFgeePaUQYe
 D7xBZzo3Br3kGeEmY/usEwnBKh9hCao=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-3zl3dKKOM7WzWgxNuKHSMg-1; Tue, 28 Nov 2023 12:54:45 -0500
X-MC-Unique: 3zl3dKKOM7WzWgxNuKHSMg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67a27d5e4d9so153036d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 09:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701194085; x=1701798885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5nkug30r8iqaMQMeVWTU8looLB/Oh9v0yht3x+Ht8NE=;
 b=m+1k+3sakanfEnRievNyFyINE22OdlY5pLLBo/nUNvI4ILL3Tv2Pio2JEZwphL+qGx
 +P0hGIHI5LmmmVUh+wHsNxC3YckKEs5Lq7n2aVj2txwgrRRVgSPi/thROLu4X3zys7Hq
 eemaiFfRq9o7xV9tc+zAl+QKMF9fDNtWQeg6cFWkXMyciQ/nhx+TV8j1cTNYsxPwVMNh
 l06QQFpf2N6x34XANYDfzZySj7ckcbMg1VvcE6un9a/LbZYVpCbnffVQq4Ud4aXFY60B
 sr2X8ZnUb9kgGF5omeG7j0+RJEmiI6jFCxTrjHOYSZ9MULq2s0JfKOkIjkEL0CrXi/NI
 7V5A==
X-Gm-Message-State: AOJu0YwuAX5ZXwImF8fOPbzoAH4FzUIT4DSHyUfbTGSkeFZ8s/AVH4nr
 aiPSoL+pyRrHACrjFNpvTDKJGKVmp7ROuQNatU94DktRDgVBIQKoO/AH84o0vXa4BQzX4uUuYsL
 wu8m9aMbCoX9gL44=
X-Received: by 2002:a0c:d683:0:b0:66d:9987:68f9 with SMTP id
 k3-20020a0cd683000000b0066d998768f9mr24158431qvi.15.1701194085087; 
 Tue, 28 Nov 2023 09:54:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeUZmzfPY8+n+0DuQ3FL4koxJjWP8KLhf3icJ8StAPN/vMD6edISjuNrPIeSdfauyjaDpXfA==
X-Received: by 2002:a0c:d683:0:b0:66d:9987:68f9 with SMTP id
 k3-20020a0cd683000000b0066d998768f9mr24158411qvi.15.1701194084819; 
 Tue, 28 Nov 2023 09:54:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 dp11-20020a05621409cb00b0067a4b72b6besm1599093qvb.105.2023.11.28.09.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 09:54:44 -0800 (PST)
Message-ID: <ef77ed27-8b95-480e-97da-8e0c53bf3aa1@redhat.com>
Date: Tue, 28 Nov 2023 18:54:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Summit Minutes 2023
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
 <87edgjf2v4.fsf@draig.linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87edgjf2v4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/21/23 18:11, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> QEMU Summit Minutes 2023
>> ========================
>>
>> As usual, we held a QEMU Summit meeting at KVM Forum.  This is an
>> invite-only meeting for the most active maintainers and submaintainers
>> in the project, and we discuss various project-wide issues, usually
>> process stuff. We then post the minutes of the meeting to the list as
>> a jumping off point for wider discussion and for those who weren't
>> able to attend.
>>
> <snip>
>>
>> Topic 2: Are we happy with the email workflow?
>> ==============================================
>>
>> This was a topic to see if there was any consensus among maintainers
>> about the long-term acceptability of sticking with email for patch
>> submission and review -- in five years' time, if we're still doing it
>> the same way, how would we feel about it?
>>
>> One area where we did get consensus was that now that we're doing CI
>> on gitlab we can change pull requests from maintainers from via-email
>> to gitlab merge requests. This would hopefully mean that instead of
>> the release-manager having to tell gitlab to do a merge and then
>> reporting back the results of any CI failures, the maintainer
>> could directly see the CI results and deal with fixing up failures
>> and resubmitting without involving the release manager. (This
>> may have the disbenefit that there isn't a single person any
>> more who looks at all the CI results and gets a sense of whether
>> particular test cases have pre-existing intermittent failures.)
> 
> If we are keen to start processing merge requests for the 9.0 release we
> really should consider how it is going to work before we open up the
> taps post 8.2-final going out.
>
> Does anyone want to have a go at writing an updated process for
> docs/devel/submitting-a-pull-request.rst (or I guess merge-request) so
> we can discuss it and be ready early in the cycle? Ideally someone who
> already has experience with the workflow with other gitlab hosted
> projects.


Reading the Topic 2 paragraph above, I understand that a maintainer
of a subsystem would be able to merge its '-next' branch in the main
repository when CI is all green. Correct ?

It seems to me that we should also have a group of people approving
the MR.

Thanks,

C.


