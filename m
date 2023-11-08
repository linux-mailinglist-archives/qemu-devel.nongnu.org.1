Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13BD7E5080
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 07:52:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0cOc-0002WA-Ha; Wed, 08 Nov 2023 01:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0cOU-0002Vj-Q2
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 01:50:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0cOT-0008CM-4N
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 01:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699426227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HeILgklWo5c/K5HmT4p/bqlFrkeIgX1xE2OrWVAW+Ws=;
 b=Qlf3edXIfodr+ZX+BB73JT9TxYScE9qklI+NK2Gp8bRZ6NeAYJiQil5nZ14qn15y+c2f92
 LGnGH9anIuWm4+iKVy9EBBkru0iYDPYUdwot/6OKlDz99LMhuCtEViKROJ3fOsg9e2zvEE
 difs07iLSgUmOKYBJiLKPsecPF3rzec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-43ub48PpN62Tmf_dtkd01A-1; Wed,
 08 Nov 2023 01:50:26 -0500
X-MC-Unique: 43ub48PpN62Tmf_dtkd01A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9CFC3C0E647;
 Wed,  8 Nov 2023 06:50:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEBE940C6EB9;
 Wed,  8 Nov 2023 06:50:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C002F21E6A1F; Wed,  8 Nov 2023 07:50:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  peter.maydell@linaro.org,
 pbonzini@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v2 11/12] qdev: Make netdev properties work as list
 elements
References: <20231030142658.182193-1-kwolf@redhat.com>
 <20231030142658.182193-12-kwolf@redhat.com>
 <87jzr09uxe.fsf@pond.sub.org> <ZUo9EERTaoGvGMtC@redhat.com>
Date: Wed, 08 Nov 2023 07:50:24 +0100
In-Reply-To: <ZUo9EERTaoGvGMtC@redhat.com> (Kevin Wolf's message of "Tue, 7
 Nov 2023 14:35:12 +0100")
Message-ID: <874jhwd9hr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 02.11.2023 um 13:55 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > The 'name' parameter of QOM setters is primarily used to specify the name
>> > of the currently parsed input element in the visitor interface. For
>> > top-level qdev properties, this is always set and matches 'prop->name'.
>> >
>> > However, for list elements it is NULL, because each element of a list
>> > doesn't have a separate name. Passing a non-NULL value runs into
>> > assertion failures in the visitor code.
>> 
>> Yes.  visitor.h's big comment:
>> 
>>  * The @name parameter of visit_type_FOO() describes the relation
>>  * between this QAPI value and its parent container.  When visiting
>>  * the root of a tree, @name is ignored; when visiting a member of an
>>  * object, @name is the key associated with the value; when visiting a
>>  * member of a list, @name is NULL; and when visiting the member of an
>>  * alternate, @name should equal the name used for visiting the
>>  * alternate.
>> 
>> > Therefore, using 'name' in error messages is not right for property
>> > types that are used in lists, because "(null)" isn't very helpful to
>> > identify what QEMU is complaining about.
>> 
>> We get "(null)" on some hosts, and SEGV on others.
>
> Fair, I can add "(or even a segfault)" to the commit message.
>
>> Same problem in all property setters and getters (qdev and QOM), I
>> presume.  The @name parameter looks like a death trap.  Thoughts?
>
> All property setters and getters that abuse @name instead of just
> passing it to the visitor. I don't know how many do, but let's see:
>
> * qdev_prop_size32 uses @name in an error message
>
> * Array properties themselves use @name in an error message, too
>   (preexisting)
>
> * qdev-properties-system.c has more complicated properties, which have
>   the same problem: drive, chardev, macaddr, netdev (before this patch),
>   reserved_region, pci_devfn (one error path explicitly considers name
>   == NULL, but another doesn't), uuid
>
> * Outside of hw/core/ we may have some problematic properties, too.
>   I found qdev_prop_tpm, and am now too lazy to go through all devices.
>   These are probably specialised enough that they are less likely to be
>   used in arrays.
>
> We can fix these on top of this series, though we should probably first
> figure out what the best way to replace it is to avoid touching
> everything twice.

Makes sense.

>> Any reproducer known before the next patch?
>
> Not to me.
>
>> > Change netdev properties to use 'prop->name' instead, which will contain
>> > the name of the array property after switching array properties to lists
>> > in the external interface.
>> 
>> Points at the entire array property without telling the user which of
>> the elements is at fault.  Sure better than NULL.  I'm not asking you to
>> improve the error message further.  Mention the error message's lack of
>> precision in the commit message?
>
> Can do.
>
> At least the input visitor has better ways internally to identify the
> currently visited object with full_name(). If other visitor types can do
> similar things, maybe extending the public visitor interface to access
> the name would be possible?

Yes, there's a need for better error reporting around visitors, ideally
without doing it in every visitor like the QObject input visitor does.
I've thought about it, but only briefly, and without a conclusion.

I figure your idea is to provide a visitor method to get a malloced
string describing the thing being visited.  Might work, but to know for
sure, we have to try.

This could also help with getting rid of the dangerous @name use we
discussed above.

Thanks!


