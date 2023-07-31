Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C897A768C70
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 08:58:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMpZ-00061N-GV; Mon, 31 Jul 2023 02:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qQMpV-00061B-Mb
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qQMpT-0000mA-Ds
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 02:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690786588;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CRe0SYHyHG1XPHspl8ifyDtr79+vrVyqb02L8tj5QoY=;
 b=UCc2EjyW0xWcemWa8A1sPggunD4bepM2zFI98enJ+8AEdgV8bzmcMfBqGtBZ08UIfABiGd
 2+1nolLJnv4zEZH7ypxzZJKcjxfwcOPATvXflb0RH154DWDX1G0HyPimQsnn+2pzDDZAjw
 gnqltTrUctg1w8n7P57EG7NtflJhdlw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-xTROk1gKMq2gXXocODaMFg-1; Mon, 31 Jul 2023 02:56:23 -0400
X-MC-Unique: xTROk1gKMq2gXXocODaMFg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31701b27d19so2051357f8f.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 23:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690786582; x=1691391382;
 h=mime-version:date:reply-to:user-agent:references:message-id
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRe0SYHyHG1XPHspl8ifyDtr79+vrVyqb02L8tj5QoY=;
 b=eZ5o6MQJN20oAHEY4+2rp2pvRVMGXJQqYcoB8Ltw+/qYaE66U55sfA+e5ioEk+vUTk
 oUd7UlDY8AZclPcKrPTP8VY4ce+O1ZWA/vK9SXdHhFTYXU7fHln+sNFo998UbRKw3jmY
 kRqikCVwekPBublDc6T8cxsAOLfDEJXTfbt8qXXoB9OPiTLqaXFh2Qs5jj3DW1GOMXtl
 LnscqUpx5N7sozDV+oUsTBqUgmsfoaMB6U9fadrSYFgVG1ycmndXNGlem7DmMOxVLy21
 yrg3rjU5tt48WZx0NcPe5SEFsF7gVFpJar8404HQvcK/LeqXXelw1UM3H5iRyFQUZ3Rt
 1SPg==
X-Gm-Message-State: ABy/qLYEHYIseysYhSx3goACmmz8LuaT81J+Vvw0//0oAodCXQPlBjOB
 Wj2j2z2r3UqV9PSu/tuoYPQhTCWfhrhbMtDacs6y5vBR0n0bcIQdRqWFH57eexPaUVwU6AEDToi
 0orM8qhsPnuO70qg=
X-Received: by 2002:adf:f7c2:0:b0:317:a499:72c8 with SMTP id
 a2-20020adff7c2000000b00317a49972c8mr1158096wrq.1.1690786582303; 
 Sun, 30 Jul 2023 23:56:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7rL6TRetkWwizUI8ZWNFaQF7ogIM35O/6YjOhp08qh1eS4d3x6YqL/gjiyTfRKigbWZNpbQ==
X-Received: by 2002:adf:f7c2:0:b0:317:a499:72c8 with SMTP id
 a2-20020adff7c2000000b00317a49972c8mr1158078wrq.1.1690786582006; 
 Sun, 30 Jul 2023 23:56:22 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l7-20020a5d5607000000b003143cb109d5sm12038890wrv.14.2023.07.30.23.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jul 2023 23:56:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 00/26] Migration PULL 2023-07-24
In-Reply-To: <30ff28d1-abc5-a416-b44e-59abd3881fa4@redhat.com> (Thomas Huth's
 message of "Mon, 24 Jul 2023 15:28:47 +0200")
Message-ID: <87v8e9fm3d.fsf@secure.mitica>
References: <20230724130639.93135-1-quintela@redhat.com>
 <30ff28d1-abc5-a416-b44e-59abd3881fa4@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 31 Jul 2023 08:56:20 +0200
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Thomas Huth <thuth@redhat.com> wrote:
> On 24/07/2023 15.06, Juan Quintela wrote:
>> Hi
>> This is the migration PULL request.
>
> Maybe it would better to use "PULL" instead of "PATCH" in the subject?

Grrrr.

Resending.  Thanks.

>> Now a not on CI, thas has been really bad.  After too many problems
>> with last PULLS, I decided to learn to use qemu CI.  On one hand, it
>> is not so difficult, even I can use it O:-)
>> On the other hand, the amount of problems that I got is inmense.
>> Some
>> of them dissapear when I rerun the checks, but I never know if it is
>> my PULL request, the CI system or the tests themselves.
>
> I normally peek at https://gitlab.com/qemu-project/qemu/-/pipelines to
> see whether the problem occurred in one of the last staging CI runs
> already ... or I push the master branch to my own repo to see whether
> it reproduces with a clean state. That often helps in judging whether
> it's a new problem or a pre-existing one.

It don't happens for master branch at the time.  It only happens with my
changes.

But the change previous to that one runs well.  That one always fails in
the block layer.  And the changes on that "series" were only for
migration-test.c, so it shouldn't break any other tests.  No other files
are touched.

Yes, in the PULL request more files are touched, but the tests I was
doing on CI there weren't.

I have no clue what gcov is adding to those tests really (I know what
gcov is, not what gcov is trying to do on that test.)

>> This (last) patch is not part of the PULL request, but I have found
>> that it _always_ makes gcov fail.  I had to use bisect to find where
>> the problem was.
>> https://gitlab.com/juan.quintela/qemu/-/jobs/4571878922
>> I could use help to know how a change in test/qtest/migration-test.c
>> can break block layer tests, I am all ears.
>> Yes, I tried several times.  It always fails on that patch.  The
>> passes with flying colors.
>
> Can you reproduce it locally by running "make check-block"?

No.  make check with all architectures under the sun works as expected.

I have learn my lesson here, and know I have to terminals open.  One
compiles x86_64 natively and test natively.

The other compiles aarch64 and test it using TCG.

(I do more tests, but that is run after each patch got reviewed and
integrated for the PULL request)

> The tests/qemu-iotests/tests/copy-before-write test seems to be doing
> some things with snapshots ... maybe that's related?

It could.  But I am not changing that.  I am only changing
migration-test.c.

As Daniel answered on list, problably it is just a race that changing
timing makes it more probable.

Later, juan.



