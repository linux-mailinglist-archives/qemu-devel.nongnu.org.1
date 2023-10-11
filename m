Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992107C572A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaOL-0008Gh-V4; Wed, 11 Oct 2023 10:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaOD-0008G2-H7
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaOB-0006di-Oj
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697035242;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+9VEHC+wZQY2Dh3oiJLt4LGNY2XBzm4MeIxGGEiOyPk=;
 b=Mrvqgf7GM2nfOq33lGHJAlL9j2Y0mqTHa/+QdR/WweS0wdjzAu7CKAP/+9q1YrUjo8CmOy
 Sv6YbRoh7rqj1fbkBVmKWK80//2F6aSwv0zUSib69YlwFUUsW65DvHccPe/Dy5k4V4FDpR
 VSvIX1Ag3e5ynEvF8XLwhuO6rNhxnYI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-q-yCFUGfMESBS8GCzIf1Hw-1; Wed, 11 Oct 2023 10:40:31 -0400
X-MC-Unique: q-yCFUGfMESBS8GCzIf1Hw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so4956652f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697035230; x=1697640030;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9VEHC+wZQY2Dh3oiJLt4LGNY2XBzm4MeIxGGEiOyPk=;
 b=pOmGt68s6Bpr86w88LoZLb7W4rIJ6WhSWqeOFBy4xZEDKJKtylyXnMpKKoAuGtqIoc
 8NXyml7Am9o6VWp0CD9N13HURKqMBc4FjAavxBl3X91/1k5Y3aJrU5l7ZvW4aJJkA7oZ
 sAiW/uo2KBDMijrlbjmJEYIdhCdhBN2yqIN4DoyD2u/nkK8iVB9z5C1o+9DcLRWTEq6J
 pIHZ/gef5V29o0LQ1BAJAV8MShqjYnUlMK1pWu/b4zUga9aGHvXEQKlZ2MXzzXMz37ds
 mWc/dG/4E4J4d42dODYQf+yXeqkrB6gf7kKDKupWcRrEy9Gd7NnXPKduzPV1W94wTk1c
 /N0w==
X-Gm-Message-State: AOJu0YxCfH+HL/oYf66YdUqtSNDcS2WATdIMzIqhtCG9WDlreI1IuRpr
 g/l3W164fc0CPn1eTjAr8JtUQ6ybSWB9wAZWbz9mACDyO4E9QZOIw0SSNDRYaXQhOUCMioS67cE
 9PrbL7Q3AJe0ZQ2Cd2rk+f1s=
X-Received: by 2002:a5d:4c4a:0:b0:322:478b:2be9 with SMTP id
 n10-20020a5d4c4a000000b00322478b2be9mr19300338wrt.25.1697035229876; 
 Wed, 11 Oct 2023 07:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqEM1kIVQEeCX9Sl/DeS4QHkRbB9yl17zeDF+u8D1RhUerZmisxZWPCNfvOP6I4wf9f3FQGA==
X-Received: by 2002:a5d:4c4a:0:b0:322:478b:2be9 with SMTP id
 n10-20020a5d4c4a000000b00322478b2be9mr19300314wrt.25.1697035229532; 
 Wed, 11 Oct 2023 07:40:29 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c20d300b004075b3ce03asm3532393wmm.6.2023.10.11.07.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:40:29 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  =?utf-8?Q?Marc?=
 =?utf-8?Q?-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qtest/migration: Add a test for the analyze-migration
 script
In-Reply-To: <9a3212d0-f89a-33a9-a82b-53dcc3e4dcf6@redhat.com> (Thomas Huth's
 message of "Thu, 28 Sep 2023 15:40:49 +0200")
References: <20230927214756.14117-1-farosas@suse.de>
 <62c405c9-27f2-a77a-1f94-8d03cf65fff6@redhat.com>
 <8734yyo22f.fsf@suse.de>
 <9a3212d0-f89a-33a9-a82b-53dcc3e4dcf6@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:40:28 +0200
Message-ID: <87v8bd6x43.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> On 28/09/2023 15.32, Fabiano Rosas wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> On 27/09/2023 23.47, Fabiano Rosas wrote:
>>>> Add a smoke test that migrates to a file and gives it to the
>>>> script. It should catch the most annoying errors such as changes in
>>>> the ram flags.
>>>>
>>>> After code has been merged it becomes way harder to figure out what is
>>>> causing the script to fail, the person making the change is the most
>>>> likely to know right away what the problem is.
>>>>
>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>> ---
>>>> I know this adds a python dependency to qtests and I'm not sure how
>>>> much we care about this script, but on the other hand it would be nice
>>>> to catch these errors early on.
>>>>
>>>> This would also help with future work that touches the migration
>>>> stream (moving multifd out of ram.c and fixed-ram).
>>>>
>>>> Let me know what you think.
>>>
>>> Without looking at this too closely, my first thought was: This sounds
>>> rather like a good candidate for an avocado test instead. It's using Python,
>>> so tests/avocado/ sounds like a better fit. Have you considered adding it as
>>> an avocado test already?
>>>
>> I intended to keep all migration tests at the same place. And well,
>> to
>> be honest, I have given up on avocado. Too unmaintained, incrutable
>> logging and last time I tried to use it locally, it was leaving stale
>> processes behind upon failure.
>> Of course, if that's the preferred place to put python tests I could
>> do
>> it, but I don't find it too compelling.
>
> Well, I guess this test here is kind of borderline, since it does not
> introduce new Python code, but just calls a pre-existing python
> script...
> maybe that's still ok for the qtests ... what do other people think?

I agree with adding it to migration-tests.
We can create a different test if necessary.

Reason for that is that this script is very useful (not enough) to find
interversion compatibilities.

We never found that it is failing after the release is done,  So testing
it continously is much better in my humble opinion.

>>>   >+#define ANALYZE_SCRIPT "tests/qtest/analyze-migration.py"
>>>
>>> Why can't you use scripts/analyze-migration.py directly?
>>>
>> I'm not entirely sure that's the case with QEMU, but generally build
>> directories can move/not be directly under the source tree. The test
>> wouldn't know from where to fetch the script.
>
> AFAIK the build system puts a symlink for the scripts folder into the
> build directory, at least I have one in mine.
>
>>>   >+    file = g_strdup_printf("%s/migfile", tmpfs);
>>>
>>> Please, no static file names for temporary files - tests might be running in
>>> parallel, and then you get race conditions! Use something like
>>> g_file_open_tmp() instead to create a file with a random name.
>>>
>> Ok, I can do that. However, if you look for "tmpfs" in
>> migration-test.c
>> you'll see that's done all over the place. I'm thinking individual tests
>> under glib are never run in parallel. At least for the migration suite.
>
> Ah, sorry, my bad, I thought that tmpfs was simply pointing to "/tmp",
> but in fact it already contains a randomized name. So never mind, I
> think it should be fine what you're doing here.

I am changing that in a series that I have to rebase.

Stay tuned.

Later, Juan.


