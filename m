Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD757B871D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:01:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6At-0001oe-TE; Wed, 04 Oct 2023 14:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6Ar-0001o2-AN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6Ap-00034F-Jv
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696442439;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c22eJGiLfE6cNCuRGROSC+yMUkIXpL1asGbsDpfm/3s=;
 b=Ej7mfmbTsK8bO6c3Tsj8/8fl8G9wbkLuK1tuI3pbSQQDdFN7cj1dp+avyvmixdDW7HIV3u
 jmHAj40HxQ1a1qQLlzlT/upVBaUfWLW3ZpD19O+bZli/KyUl/R9j2QzLBFIc6m0IhF9LNK
 Eub+61IdG6bx51vnHQJyIbkIOYSVKgg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-jeNYLgHmP-G5lYo14nwhiA-1; Wed, 04 Oct 2023 14:00:37 -0400
X-MC-Unique: jeNYLgHmP-G5lYo14nwhiA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so413105e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 11:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442436; x=1697047236;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c22eJGiLfE6cNCuRGROSC+yMUkIXpL1asGbsDpfm/3s=;
 b=QDKe/7YlN8ueR0TKjS1HAV1UA9kvG1onsuCh3kyPAUaPpgND7iQTgBKRfj1sCdhyUQ
 bEkLp0cYaVJE6far4XbMXs9ZNX5eN3jw3gwIBsLFMiC5CmYIOPs2NlE3YzSmfyPBtjcY
 vl1wdmNxHLltcvrMUV+xA6oGzZrYQefSyAGOyy14T3eH7V5fxISSzPSI7LYTVdcL9CYG
 zqllcKjOHCSbd2xiWlsVq1ZuXWDL5Gjj9VArdtW3YITFU0qTkM7E1VzgZ4/yOFmuM1no
 HkwPyTnrq+6Dj8pIk4/RxHsCO6OHd2rdYdsRpUPIZonFCTKTYP92Ikp/dDwIZocdCso5
 e5Qg==
X-Gm-Message-State: AOJu0Yy9IPyM5Bn41fGn7pijYlLpU62PwcUMlayJNLefNO/1sUGxNxGL
 qzbEVdUWAWw2a+WkWkBpujNT61nX1C7cLUBKA2ujGaNMOKwEvYzd8qFvHWMlxwVuZLxbBvkvF39
 RWGVIYjzEFm7yEsY=
X-Received: by 2002:a7b:c4d6:0:b0:406:7074:301d with SMTP id
 g22-20020a7bc4d6000000b004067074301dmr3385531wmk.11.1696442436467; 
 Wed, 04 Oct 2023 11:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsqo97rxun2GilS1BtTXKvq1oWgu+J539Xnh62vj0XA1AeJf1Rld2NYEZ4zbp644yaUMnb4Q==
X-Received: by 2002:a7b:c4d6:0:b0:406:7074:301d with SMTP id
 g22-20020a7bc4d6000000b004067074301dmr3385508wmk.11.1696442436081; 
 Wed, 04 Oct 2023 11:00:36 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z23-20020a1c4c17000000b00405935b417asm2089702wmf.2.2023.10.04.11.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 11:00:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org,  leobras@redhat.com,  Li Zhijian
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
In-Reply-To: <ZQnojJOqoFu73995@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Sep 2023 19:29:32 +0100")
References: <20230918144206.560120-1-armbru@redhat.com> <ZQnRKjo0M50BRbZh@x1n>
 <ZQnojJOqoFu73995@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 20:00:34 +0200
Message-ID: <87bkdes1x9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Tue, Sep 19, 2023 at 12:49:46PM -0400, Peter Xu wrote:
>> On Mon, Sep 18, 2023 at 04:41:14PM +0200, Markus Armbruster wrote:
>> > Oh dear, where to start.  There's so much wrong, and in pretty obvious
>> > ways.  This code should never have passed review.  I'm refraining from
>> > saying more; see the commit messages instead.
>> >=20
>> > Issues remaining after this series include:
>> >=20
>> > * Terrible error messages
>> >=20
>> > * Some error message cascades remain
>> >=20
>> > * There is no written contract for QEMUFileHooks, and the
>> >   responsibility for reporting errors is unclear
>>=20
>> Even being removed.. because no one is really extending that..
>>=20
>> https://lore.kernel.org/all/20230509120700.78359-1-quintela@redhat.com/#t
>
> One day (in another 5-10 years) I still hope we'll get to
> the point where QEMUFile itself is obsolete :-)

If you see the patches on list, I have move rate limit check outside of
QEMUFile, so right now it is only a buffer to write in the main
migration thread.

> Getting
> rid of QEMUFileHooks is a great step in that direction.

Thanks.

> Me finishing a old PoC to bring buffering to QIOChannel
> would be another big step.

I want to get rid of qemu_file_set_error() and friends first.  We should
handle errors correctly when they happen, and go from there.

> The data rate limiting would be the biggest missing piece
> to enable migration/vmstate logic to directly consume
> a QIOChannel.

As said, that is done.  I have three atomic counters:

- qemu_file_bytes
- rdma_bytes
- multifd_bytes

We do the rate limiting adding that 3 counters.  The only thing that
QEMUFile does know is increase qemu_file_bytes when it needs to do it.

> Eliminating QEMUFile would help to bring Error **errp
> to all the vmstate codepaths.

Yes!

See the last problem on the list where they couldn't use
migrate_set_error() in vmstate.c because that breaks test-vmstate.c.

>> I always see rdma as "odd fixes" stage.. for a long time.  But maybe I w=
as
>> wrong.
>
> In the MAINTAINERS file RDMA still get classified as formally
> supported under the migration maintainers.  I'm not convinced
> that is an accurate description of its status.  I tend to agree
> with you that it is 'odd fixes' at the very best.

It is not exact, we wanted to get rid of it.

> Dave Gilbert had previously speculated about whether we should
> even consider deprecating it on the basis that latest non-RDMA
> migration is too much better than in the past, with multifd
> and zerocopy, that RDMA might not even offer a significant
> enough peformance win to justify.

The main problem with RDMA is that it uses a really weird model for
migration point of view:
- everything there is asynchronous (nothing else is like that)
- it uses its own everything, i.e. abuses QEMUFile and QIOChannel to try
  to look like one, but it fails.
- Its error handling is "peculiar", to be friendly.  See this series
  from Markus to make it look normal.

Thanks, Juan.


