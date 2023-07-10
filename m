Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F5574CCA1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 08:08:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIk3n-0002Bb-RI; Mon, 10 Jul 2023 02:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qIk3m-0002BS-23
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qIk3h-0001bv-36
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688969254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyghLe8ySD12gm6LLOQqPPVb1CaqSNfRd4Yr5D8+m5o=;
 b=TbuI/HT8zVlAEgkiHyDFEqNJhiYTcx1Pmrip7HZIwEQ17M6/A79S9bOrYzc+IA3cftCmNG
 g1PUbiYX5NoHuF9DlT3e5DXsFuwjkGS4qjLVzItPs/MIk+uj40rAU6sSYcaP22o3fCeqR2
 UeCoygZTAjSZZI+xgA8VZv2oMtpBfAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-idIsnCRNOP-NXj0w2mrn2g-1; Mon, 10 Jul 2023 02:07:33 -0400
X-MC-Unique: idIsnCRNOP-NXj0w2mrn2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AE91858290;
 Mon, 10 Jul 2023 06:07:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5A2E2166B27;
 Mon, 10 Jul 2023 06:07:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E131F21E6A1F; Mon, 10 Jul 2023 08:07:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,  Bin Meng <bmeng@tinylab.org>,
 qemu-devel@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Zhangjin Wu <falcon@tinylab.org>,  Claudio Imbrenda
 <imbrenda@linux.ibm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Kevin Wolf
 <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,  Xuzhou Cheng
 <xuzhou.cheng@windriver.com>
Subject: Re: [PATCH v4 0/6] net/tap: Fix QEMU frozen issue when the maximum
 number of file descriptors is very large
References: <20230628152726.110295-1-bmeng@tinylab.org>
 <CAEUhbmVsHqdauwvgvjNY6R65kDJ017vDQ797YuzX7S_XHgS5WQ@mail.gmail.com>
 <CACGkMEsAVQhbdRabLeGiw25Ox4Ze9WRRP3coSKni5WVqFNqYYA@mail.gmail.com>
Date: Mon, 10 Jul 2023 08:07:30 +0200
In-Reply-To: <CACGkMEsAVQhbdRabLeGiw25Ox4Ze9WRRP3coSKni5WVqFNqYYA@mail.gmail.com>
 (Jason Wang's message of "Mon, 10 Jul 2023 11:05:38 +0800")
Message-ID: <87mt04b8pp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Jason Wang <jasowang@redhat.com> writes:

> On Sun, Jul 9, 2023 at 11:48=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wro=
te:
>>
>> On Wed, Jun 28, 2023 at 11:29=E2=80=AFPM Bin Meng <bmeng@tinylab.org> wr=
ote:
>> >
>> >
>> > Current codes using a brute-force traversal of all file descriptors
>> > do not scale on a system where the maximum number of file descriptors
>> > is set to a very large value (e.g.: in a Docker container of Manjaro
>> > distribution it is set to 1073741816). QEMU just looks frozen during
>> > start-up.
>> >
>> > The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
>> > 2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
>> > doesn't need to manually close the fds for child process as the proper
>> > O_CLOEXEC flag should have been set properly on files with its own
>> > codes, QEMU uses a huge number of 3rd party libraries and we don't
>> > trust them to reliably be using O_CLOEXEC on everything they open.
>> >
>> > Modern Linux and BSDs have the close_range() call we can use to do the
>> > job, and on Linux we have one more way to walk through /proc/self/fd
>> > to complete the task efficiently, which is what qemu_close_range()
>> > does, a new API we add in util/osdep.c.
>> >
>> > V1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bm=
eng@tinylab.org/
>> >
>> > Changes in v4:
>> > - add 'first > last' check logic
>> > - reorder the ifdefs logic
>> > - change i to unsigned int type
>> > - use qemu_strtoi() instead of atoi()
>> > - limit last upper value to sysconf(_SC_OPEN_MAX) - 1
>> > - call sysconf directly instead of using a variable
>> > - put fd on its own line
>> >
>> > Changes in v3:
>> > - fix win32 build failure
>> > - limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)
>> >
>> > Changes in v2:
>> > - new patch: "tests/tcg/cris: Fix the coding style"
>> > - new patch: "tests/tcg/cris: Correct the off-by-one error"
>> > - new patch: "util/async-teardown: Fall back to close fds one by one"
>> > - new patch: "util/osdep: Introduce qemu_close_range()"
>> > - new patch: "util/async-teardown: Use qemu_close_range() to close fds"
>> > - Change to use qemu_close_range() to close fds for child process effi=
ciently
>> > - v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-=
bmeng@tinylab.org/
>> >
>> > Bin Meng (4):
>> >   tests/tcg/cris: Fix the coding style
>> >   tests/tcg/cris: Correct the off-by-one error
>> >   util/async-teardown: Fall back to close fds one by one
>> >   util/osdep: Introduce qemu_close_range()
>> >
>> > Zhangjin Wu (2):
>> >   util/async-teardown: Use qemu_close_range() to close fds
>> >   net: tap: Use qemu_close_range() to close fds
>> >
>>
>> Ping for 8.1?
>
> Queued.

There are review questions open on PATCH 4+5.


