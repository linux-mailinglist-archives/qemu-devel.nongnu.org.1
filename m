Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D5749D52
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOuN-00020b-Pn; Thu, 06 Jul 2023 09:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHOuJ-000209-Pe
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHOuH-0007dC-Kv
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688649623;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=icAVjLxwKScX48migOjn2d027x7L/2UaM75D0rWHYmo=;
 b=EKh0Rl2hpdFFHt/48PQQmnfzxONIv5V16E32sg8Xlz2XaUpTvNyEj32DMQBVs6xIRLjn7G
 ddkeDWXVQH+CDI3wioE/Helh7k4ercMXUxCqyaYmmowyxAEwJvp3exeARbzFfK4Ym51J4p
 DBycVXyXGt0y3RXM+mToWd57mYYlQ2g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-PrVAtFnLPvuCR-nntgWyBQ-1; Thu, 06 Jul 2023 09:20:22 -0400
X-MC-Unique: PrVAtFnLPvuCR-nntgWyBQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa979d0c32so4085055e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649621; x=1691241621;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=icAVjLxwKScX48migOjn2d027x7L/2UaM75D0rWHYmo=;
 b=JihDX9pGl4LYqyuNGb1FFixo7J40Bic8V7nT3v81CwBeNJLEEWB9hSh2qNM4ElUXXi
 tZ8gdhKLzP8YF9/Rl3tXgrGkJxe+/J9BmSFsHcOrq94kmJWdolNhkY+GJD0nUm5BY7D0
 LJ/shBNN/uF/IBRm1Lcp4IBSo+H6th9jHG92SycjmUr5nkngLGBoUJBSJ3yZa/dzsLfq
 483Z6CDXlekJ5dIatpHcKLuhBIEj/9Uo/G0f0OmzXVDnllu60IkSJjW9zMi+F32M6/zE
 9phDER+xTyv9Ow0O/M2JZraWI2lOkAohto9YB4qnaGJSp4iRE/6kWOIjtFnbyYPBkMma
 psVw==
X-Gm-Message-State: ABy/qLY5bCHlFIIYcttEK5Gp8dzw/TCUeiEo/laavatZFStOu1KuvVly
 VSetwHStr1HOQLh8lvw29BPif72DkWX+G0uM0fyKsip4yXCwqYSlimnlpi2DnuVWQg1hMene84n
 i6ehZFxPOJpO/NtU=
X-Received: by 2002:a1c:f70a:0:b0:3fa:d167:5348 with SMTP id
 v10-20020a1cf70a000000b003fad1675348mr1352799wmh.1.1688649621179; 
 Thu, 06 Jul 2023 06:20:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFN8lOHy6eZOyDgyluF5rOFo1qRcw1WDsAMDQzTBqnPCncBZCvmJlm8WC7RJiRldmlOALvQKw==
X-Received: by 2002:a1c:f70a:0:b0:3fa:d167:5348 with SMTP id
 v10-20020a1cf70a000000b003fad1675348mr1352781wmh.1.1688649620838; 
 Thu, 06 Jul 2023 06:20:20 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c020a00b003fbc90e030csm2111918wmi.37.2023.07.06.06.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:20:20 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peng
 Tao <tao.peng@linux.alibaba.com>,  Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
In-Reply-To: <6cceb935-1830-2984-7529-59d1f8881d34@redhat.com> (David
 Hildenbrand's message of "Thu, 6 Jul 2023 10:31:53 +0200")
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-2-david@redhat.com>
 <87jzvdbgv1.fsf@secure.mitica>
 <6cceb935-1830-2984-7529-59d1f8881d34@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 15:20:19 +0200
Message-ID: <87zg496uss.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

David Hildenbrand <david@redhat.com> wrote:
> On 06.07.23 10:10, Juan Quintela wrote:
>> David Hildenbrand <david@redhat.com> wrote:
>>> ram_block_discard_range() cannot possibly do the right thing in
>>> MAP_PRIVATE file mappings in the general case.
>>>
>>> To achieve the documented semantics, we also have to punch a hole into
>>> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
>>> of such a file.
>>>
>>> For example, using VM templating -- see commit b17fbbe55cba ("migration:
>>> allow private destination ram with x-ignore-shared") -- in combination with
>>> any mechanism that relies on discarding of RAM is problematic. This
>>> includes:
>>> * Postcopy live migration
>>> * virtio-balloon inflation/deflation or free-page-reporting
>>> * virtio-mem
>>>
>>> So at least warn that there is something possibly dangerous is going on
>>> when using ram_block_discard_range() in these cases.
>>>
>>> Acked-by: Peter Xu <peterx@redhat.com>
>>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> (at least we give a warning)
>> But I wonder if we can do better and test that:
>>   * Postcopy live migration
>>     We can check if we are on postcopy, or put a marker so we know
>> that
>>     postcopy can have problems when started.
>>   * virtio-balloon inflation/deflation or free-page-reporting
>>     We can check if we have ever used virtio-balloon.
>>   * virtio-mem
>>     We can check if we have used virtio-men
>> I am just wondering if that is even possible?
>
> Now we warn when any of these features actually tries discarding RAM
> (calling ram_block_discard_range()).
>
> As these features trigger discarding of RAM, once we reach this point
> we know that they are getting used. (in comparison to default libvirt
> attaching a virtio-balloon device without anybody ever using it)
>
>
> The alternative would be checking the RAM for compatibility when
> configuring each features. I decided to warn at a central place for
> now, which covers any users.

I think this is the right thing to do.

Patient: It hurts when I do this.
Doctor: Don't do that.

O:-)

Now more seriously, at this point we are very late to do anything
sensible.  I think that the normal thing when we are configuring
incompatible things just flag it.

We are following that approach with migration for some time now, and
everybody is happier.

Later, Juan.


