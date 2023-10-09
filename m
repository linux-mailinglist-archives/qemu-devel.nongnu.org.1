Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 641B57BD352
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:25:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjgl-000314-5G; Mon, 09 Oct 2023 02:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpjgj-00030o-3C
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qpjgg-0002jA-UO
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696832658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ffZOZnE5EvpBeKiQTeS2R8NrpFMF1hyvTYLB3adB7IY=;
 b=Lrwclqu6jLKkl9yasuHxFTxyL41+IiB6LGKW2SjBtPcU1twno2Me4hZk063u05iJyIvngr
 mkDTOYLLbnBmzURJ2QTq5n0wP0X6ZFhofWlKUrPqBgB48X5NQE5iE3zlgNtVGsCigMkKXF
 FIP6P5ycCWsB0cpuGRGBv5G/mR0uqRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-fpsxO0cwOjKgvdsp_jj8sQ-1; Mon, 09 Oct 2023 02:24:16 -0400
X-MC-Unique: fpsxO0cwOjKgvdsp_jj8sQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C279081172A;
 Mon,  9 Oct 2023 06:24:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1DFE10EE859;
 Mon,  9 Oct 2023 06:24:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77CEB21E6904; Mon,  9 Oct 2023 08:24:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Thomas Huth <thuth@redhat.com>,  QEMU Developers
 <qemu-devel@nongnu.org>,  Gerd Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [v3] Help wanted for enabling -Wshadow=local
References: <87mswvg683.fsf@pond.sub.org>
 <12397ede-8e20-cb55-b759-d2fbf7732f46@redhat.com>
 <884f4d8c-4ee4-3ee2-ff62-5d7166a75adb@redhat.com>
 <CANCZdfpU1eCM0fatVBuQJW9bLzTZfvp3HNQ=2Kfz9ni90PbmEg@mail.gmail.com>
Date: Mon, 09 Oct 2023 08:24:14 +0200
In-Reply-To: <CANCZdfpU1eCM0fatVBuQJW9bLzTZfvp3HNQ=2Kfz9ni90PbmEg@mail.gmail.com>
 (Warner Losh's message of "Fri, 6 Oct 2023 13:08:38 -0600")
Message-ID: <877cnw71pt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Warner Losh <imp@bsdimp.com> writes:

> On Fri, Oct 6, 2023, 11:55 AM Thomas Huth <thuth@redhat.com> wrote:
>
>> On 06/10/2023 18.18, Thomas Huth wrote:
>> > On 06/10/2023 16.45, Markus Armbruster wrote:
>> >> Local variables shadowing other local variables or parameters make the
>> >> code needlessly hard to understand.  Bugs love to hide in such code.
>> >> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
>> >> on polling error".
>> >>
>> >> Enabling -Wshadow would prevent bugs like this one.  But we have to
>> >> clean up all the offenders first.
>> >>
>> >> Quite a few people responded to my calls for help.  Thank you so much!
>> >>
>> >> I'm collecting patches in my git repo at
>> >> https://repo.or.cz/qemu/armbru.git in branch shadow-next.  All but the
>> >> last two are in a pending pull request.

[...]

>> >> More warnings may lurk in code my test build doesn't compile.  Need a
>> >> full CI build with -Wshadow=local to find them.  Anybody care to kick
>> >> one off?
>> >
>> > I ran a build here (with -Werror enabled, so that it's easier to see where
>> > it breaks):
>> >
>> >   https://gitlab.com/thuth/qemu/-/pipelines/1028023489
>> >
>> > ... but I didn't see any additional spots in the logs beside the ones that
>> > you already listed.
>>
>> After adding two more patches to fix the above warnings, things look
>> pretty
>> good:
>>
>>   https://gitlab.com/thuth/qemu/-/pipelines/1028413030
>>
>> There are just some warnings left in the BSD code, as Warner already
>> mentioned in his reply to v2 of your mail:
>>
>>   https://gitlab.com/thuth/qemu/-/jobs/5241420713
>
>
> I think I have fixes for these. I need to merge what just landed into
> bsd-user fork, rebase, test, the apply them to qemu master branch, retest
> and send them off...
>
> My illness has hung on longer than I thought so I'm still behind...

Get well, and looking forward to your patches!


