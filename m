Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8101674E468
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3JV-0000Fo-An; Mon, 10 Jul 2023 22:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3JS-0000FJ-I7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3JQ-0000cK-QH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689043270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRcUoRxyWEhX+vC8T0yULaDNBFdtl1yQ0DZOsfxcSBo=;
 b=FV40y8UbW53w0iwXcWQNLm8Q6IgBofPrTT+9l5ZOT02BXRpM7rmHi/dus2HyTByi4LlLX5
 5TViSbBEZ9WZbYqhPl8oHYelgIrSziY0Ry/E9S+X3Mq4RYjQ3J2bgrSDm4JbD56+4L7o6+
 G8E3RXPKKUWCMOZmBYy4thpnAhpSIDE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-ABaA2cBKNVWf_GIKKPThJQ-1; Mon, 10 Jul 2023 22:41:08 -0400
X-MC-Unique: ABaA2cBKNVWf_GIKKPThJQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b70c46f121so36161631fa.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689043267; x=1691635267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRcUoRxyWEhX+vC8T0yULaDNBFdtl1yQ0DZOsfxcSBo=;
 b=WgPzjjBhPH10NQirMBC29b/mA9l8qbemWRH5vrLn4Hl9DQWpCqrbo4QDr0vedzHGAp
 LNrQB1moW9dec6l2l2bRkGYEfFZUeVQffgtC5Fl4UZf/NZH1TcEnbLMGV9N4cGEsKauM
 u6NJWrDC0xxWR62w4zumvGXgfhRhejfsLP51PBulsJYk/3b/WAt4o0fMCa6FTiPr/6LM
 Je9QHSrgs8T79SDDM+IQeeqFY4nJBqe0NP9kyifUSDp8oh0V4P2ruiag+evgBSaYV84X
 beA41jodnosrGTj0XRp5hMT9Ianrnvy1yyXrpRTxjERJhAysX6RS5z+JxdxhKSs4a31i
 axcw==
X-Gm-Message-State: ABy/qLZHEbd2aYJiSmmvRvXf28fMcabnPGa1xJO9C2qKvmyRC1FQQYba
 h7aSRXIbfNQqWAEnWZwn1G4S9xdsrvAN1N3Vkr1ivKMNJIYj/+dOKk6abpQE07p0Uo7RjckoEQ5
 afi5zy6qX8lf0826WVV0BALrLNXW5vz8=
X-Received: by 2002:a2e:9846:0:b0:2b7:16ba:89ea with SMTP id
 e6-20020a2e9846000000b002b716ba89eamr6222355ljj.26.1689043267457; 
 Mon, 10 Jul 2023 19:41:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPG2r046QuatErfpP5GdVgDSxV/vZS3diEKK7GTFGkKWi/By/jID/BvNyZPD5GhPNFayXEewqulOFDDq5i++M=
X-Received: by 2002:a2e:9846:0:b0:2b7:16ba:89ea with SMTP id
 e6-20020a2e9846000000b002b716ba89eamr6222325ljj.26.1689043267174; Mon, 10 Jul
 2023 19:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230628152726.110295-1-bmeng@tinylab.org>
 <CAEUhbmVsHqdauwvgvjNY6R65kDJ017vDQ797YuzX7S_XHgS5WQ@mail.gmail.com>
 <CACGkMEsAVQhbdRabLeGiw25Ox4Ze9WRRP3coSKni5WVqFNqYYA@mail.gmail.com>
 <87mt04b8pp.fsf@pond.sub.org>
In-Reply-To: <87mt04b8pp.fsf@pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jul 2023 10:40:55 +0800
Message-ID: <CACGkMEv8nbhANL0uhX8wH3hZWApvbAG46qvCVjG4OjUj3t0SuQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] net/tap: Fix QEMU frozen issue when the maximum
 number of file descriptors is very large
To: Markus Armbruster <armbru@redhat.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Zhangjin Wu <falcon@tinylab.org>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Xuzhou Cheng <xuzhou.cheng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Mon, Jul 10, 2023 at 2:07=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Jason Wang <jasowang@redhat.com> writes:
>
> > On Sun, Jul 9, 2023 at 11:48=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> w=
rote:
> >>
> >> On Wed, Jun 28, 2023 at 11:29=E2=80=AFPM Bin Meng <bmeng@tinylab.org> =
wrote:
> >> >
> >> >
> >> > Current codes using a brute-force traversal of all file descriptors
> >> > do not scale on a system where the maximum number of file descriptor=
s
> >> > is set to a very large value (e.g.: in a Docker container of Manjaro
> >> > distribution it is set to 1073741816). QEMU just looks frozen during
> >> > start-up.
> >> >
> >> > The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
> >> > 2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
> >> > doesn't need to manually close the fds for child process as the prop=
er
> >> > O_CLOEXEC flag should have been set properly on files with its own
> >> > codes, QEMU uses a huge number of 3rd party libraries and we don't
> >> > trust them to reliably be using O_CLOEXEC on everything they open.
> >> >
> >> > Modern Linux and BSDs have the close_range() call we can use to do t=
he
> >> > job, and on Linux we have one more way to walk through /proc/self/fd
> >> > to complete the task efficiently, which is what qemu_close_range()
> >> > does, a new API we add in util/osdep.c.
> >> >
> >> > V1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-=
bmeng@tinylab.org/
> >> >
> >> > Changes in v4:
> >> > - add 'first > last' check logic
> >> > - reorder the ifdefs logic
> >> > - change i to unsigned int type
> >> > - use qemu_strtoi() instead of atoi()
> >> > - limit last upper value to sysconf(_SC_OPEN_MAX) - 1
> >> > - call sysconf directly instead of using a variable
> >> > - put fd on its own line
> >> >
> >> > Changes in v3:
> >> > - fix win32 build failure
> >> > - limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)
> >> >
> >> > Changes in v2:
> >> > - new patch: "tests/tcg/cris: Fix the coding style"
> >> > - new patch: "tests/tcg/cris: Correct the off-by-one error"
> >> > - new patch: "util/async-teardown: Fall back to close fds one by one=
"
> >> > - new patch: "util/osdep: Introduce qemu_close_range()"
> >> > - new patch: "util/async-teardown: Use qemu_close_range() to close f=
ds"
> >> > - Change to use qemu_close_range() to close fds for child process ef=
ficiently
> >> > - v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-=
1-bmeng@tinylab.org/
> >> >
> >> > Bin Meng (4):
> >> >   tests/tcg/cris: Fix the coding style
> >> >   tests/tcg/cris: Correct the off-by-one error
> >> >   util/async-teardown: Fall back to close fds one by one
> >> >   util/osdep: Introduce qemu_close_range()
> >> >
> >> > Zhangjin Wu (2):
> >> >   util/async-teardown: Use qemu_close_range() to close fds
> >> >   net: tap: Use qemu_close_range() to close fds
> >> >
> >>
> >> Ping for 8.1?
> >
> > Queued.
>
> There are review questions open on PATCH 4+5.

Sorry, I missed that. I've dropped them from the queue now.

Thanks

>


