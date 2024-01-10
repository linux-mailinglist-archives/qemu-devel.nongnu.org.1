Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2776829D78
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 16:22:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNaPC-0004gg-Dm; Wed, 10 Jan 2024 10:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNaPB-0004gS-3J
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:22:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNaP9-0006GZ-55
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704900125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMNesO/uKeBaOKargm9HGvs62hGZ+V7XjIUPz0llCC8=;
 b=hz5Lfzc/T37cl37lWaoZXTs28uOgu6BdC/lo7h5HsP8yVgW4Lay+1gZEMLDReZHHZKXYGR
 X6bFkco+67nEPYaIvqEUjQiwZjv0aT5O1TOoCC3LG+c+jbArYXeXW29KBB2oGQ06hLKKSs
 isp2UQyFW69YaxFX4OafHS7jvEgwiyU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-QiXWEOmYP5i5ZSHkS6TLIg-1; Wed, 10 Jan 2024 10:22:03 -0500
X-MC-Unique: QiXWEOmYP5i5ZSHkS6TLIg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7817253831cso635684885a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 07:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704900123; x=1705504923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IMNesO/uKeBaOKargm9HGvs62hGZ+V7XjIUPz0llCC8=;
 b=nMKJJGFxClBtlQ/xo3BWCPUSkrWrh0PDP4qb96PFdOp+1/3efWzs510Q6h9bv6tX0b
 oHZadHKgfKMCqhEQj+oBzzkPQvzU+jJI5a+DgxE9gY9BzZ5t3nr/nXi3o4DfSF0pfDBN
 jTZZMAfed+d5CXF+vEzJ23Rcb67b5hz4yTDd3V0nzYQgNbotkjUYMYv2g2Z0g19SIzAM
 Dxeecg9nfoewayGcAtpw3ICEXFiUjUzICMJDfeYE6jCUnCpUjYmGW2Vs5v1FBo/IktCE
 Vwebcw3ZHoSsPiy1AjG3SrGk1o+VhzhZHWwzzBGbmk9BKvkzAMUbuBqlxN9H+mBaQhwn
 5SFA==
X-Gm-Message-State: AOJu0Yx/zsEErcYRDUx08aTLPTMn15/jWeAeM9fEOFPQLuvlKMOqsOQV
 jLpv7FStxRTn6gWSSP7EOphVQEvxzobHYifVtG2t7Ly5uNT5dGW+1e6WSULcgdHxx+aOq1lTrLy
 FzdsyDXhaTqow75g/oj48Cm8=
X-Received: by 2002:a05:620a:2719:b0:783:3423:c76d with SMTP id
 b25-20020a05620a271900b007833423c76dmr1509699qkp.1.1704900123167; 
 Wed, 10 Jan 2024 07:22:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8HXUjE6KFjNoNWajCloQpJxbj9GpqxJxrXLbFYPKrBwMoyzwWf1f4NASQ+k13w+XuZFXgew==
X-Received: by 2002:a05:620a:2719:b0:783:3423:c76d with SMTP id
 b25-20020a05620a271900b007833423c76dmr1509679qkp.1.1704900122837; 
 Wed, 10 Jan 2024 07:22:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s9-20020ae9f709000000b007811da87cefsm1657603qkg.127.2024.01.10.07.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:22:02 -0800 (PST)
Message-ID: <8f357390-5a65-458d-875f-7c5c11ce8abd@redhat.com>
Date: Wed, 10 Jan 2024 16:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] docs/migration: Reorganize migration documentations
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com> <ZZ0kpnT741chs1np@x1n>
 <1644d352-7ced-4ddc-90a8-8190fe863e87@redhat.com>
 <ZZ4C08Jrb-76WHW9@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZZ4C08Jrb-76WHW9@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On 1/10/24 03:37, Peter Xu wrote:
> On Tue, Jan 09, 2024 at 02:21:26PM +0100, Cédric Le Goater wrote:
>>
>>> A few things I'd like to mention alongside, because it's documentation
>>> relevant too, and I'd like to collect if there's any comment.
>>>
>>> I just mostly rewrote two wiki pages completely:
>>>
>>>     https://wiki.qemu.org/ToDo/LiveMigration
>>>     https://wiki.qemu.org/Features/Migration>
>>> I merged all the TODO items from Features/Migration into the ToDo page,
>>> while kept the 2nd page mostly clean, just to route to other places.
>>>
>>> I had a plan to make:
>>>
>>>     https://qemu.org/docs/master
>>>
>>> The solo place for migration documentations (aka, QEMU repo the source of
>>> truth for migration docs, as it's peroidically built there), making all the
>>> rest places pointing to that, as I already did in the wiki page.  While I
>>> kept all the TODOs on the wiki page (not Features/Migration, but
>>> ToDo/LiveMigration).> Fabiano / anyone: feel free to add / update /
>>> correct any entries there
>>> where applicable.  Also if there's any thoughts on above feel free to let
>>> me know too.
>>
>> The Wiki has some limited value, the changelog for instance, but the rest
>> is a bag of orphan and obsolete pages doomed to bit-rot since it is slowly
>> being replaced by the in-tree documentation.
>>
>> The info in the Features/Migration page is redundant with what we have
>> in-tree, a part from the CREDITS. The TODO list could be some file under :
>>
>> 	https://qemu.org/docs/master/devel/migration
>>
>> It would be easier to find and it would keep the Wiki to a strict minimum.
> 
> Thanks for the suggestions.  I agree that we should minimize the wiki use,
> especially on docs.  It'll be nice we use a solo source of truth for the
> docs, always accessable via qemu.org/docs, and also makes it easier for us
> to ask for docs altogether as patches when new features are merged.
> 
> I see that most of the ToDos for the other part of qemus still use the wiki
> page, even though they're indeed mostly outdated just like the migration
> ToDo before I updated it.
> 
> IMHO one thing that the wiki services well for ToDo is that it allows easy
> & frequent updates on the projects, without the need to require a review
> process like most of the patches being posted on the list.  The wiki page
> still maintains a diff, and IMHO that may not even be required, as a
> history record of a ToDo list may not help much in most cases.
> 
> The other issue regarding ToDo is that, some of the ToDo idea (or when
> someone frequently updates with details on a project of an ongoing item)
> may not be mature enough to be mentioned in an official documents. So even
> if some can be considered to be put together with the qemu repo, there may
> always be some that may not be suitable, then we will still need some place
> for those.  I still don't know what's the ideal way to do this.

OK. I see how you want to use the wiki for the TODO ideas and it makes
sense for mid/long term projects which are not mature enough to be
mentioned in the official docs. That said, I think we should mention
not supported features, incomplete modelling, etc. in the official docs,
which is a bit different than a TODO, I agree.

We also have a [feature request] label under gitlab and some issues are
tagged with it. I wonder how we can consolidate the 3 sources : wiki,
gitlab, https://www.qemu.org/docs/master/

Thanks,

C.


