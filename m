Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26E74CA32
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 05:07:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIhDo-0003u9-Rm; Sun, 09 Jul 2023 23:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qIhDn-0003tn-0E
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 23:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qIhDl-0005Me-EJ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 23:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688958352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bWSEmudsgKsWo050I41kqC5yjyHpwLea9rUVRU7w58=;
 b=BC7LWFu4uVfEJgpB2zay/mmhw5fhWJD/uuaTw0ncymtJEc0QzOVh9wSzmFEzid9Np0uRoi
 6/yvh43x9+AxFR50pWD70oknSv7/vDE4xM46K3qcEYQhvjSkTwAvatUy8xJXLHNBYn1sA2
 UkgnZ43L0UPnUyN1Ssva6txupPiMV1U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-sVqrLI8UMFqnpi_f8XycKg-1; Sun, 09 Jul 2023 23:05:50 -0400
X-MC-Unique: sVqrLI8UMFqnpi_f8XycKg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b704f6bbeaso37401071fa.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 20:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688958349; x=1691550349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bWSEmudsgKsWo050I41kqC5yjyHpwLea9rUVRU7w58=;
 b=DeG3+lrkovM03+/2zc1MbM6okvF7xdQfF4FF2A+e1T7wxzATSGVfzp7Qxf4f+lp6Ho
 ED9aFJSEgFEE+gcTLVZl3qagoMQPYsrfCkM8RtHQSE/wfF3beca6PyPi0cY4fpXxONU3
 Lg8TwWd//stlTEza74xG+kdGvviA/Cc1E4YTJKHzXJ/2tpcQRPp5utp7FogdOF/iAygp
 drEURaaf/X05qgy9CjtXD1aS2aYKI+iMUXKQcAcm8KDZkrYezDE59EXHBowidqS/xB1j
 YNThq55smxcIxB54pvIWPdrPqM7tBzh0g0hA9qvRQXMxReKiS3CFMMWMghjoMcqkBeFh
 fH0A==
X-Gm-Message-State: ABy/qLaLYdIT6t7gT19Xa1NHcLIJIGpDO8zg4WjyfbnlHkBY8Uy8OiWa
 iQ+xN+HBymVlKmSVmIEBp/55JsF5/OCCcz5oIdQ5W04g9qnhwLus1oglKBnkQN9gBBBF8RJRIyk
 IT3o0f/mIgY9kM/N00aEQNxSsXP5BagQ=
X-Received: by 2002:a2e:2405:0:b0:2b6:e0d3:45b5 with SMTP id
 k5-20020a2e2405000000b002b6e0d345b5mr9250515ljk.3.1688958349323; 
 Sun, 09 Jul 2023 20:05:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE93C6nNh862WaUUg6/H9kYlM2bO8FQwxE6AmhBns6LTjkIANtyFhPgbMc/REvBvQ2NBYHTSdrlYV8Qw+8fU0k=
X-Received: by 2002:a2e:2405:0:b0:2b6:e0d3:45b5 with SMTP id
 k5-20020a2e2405000000b002b6e0d345b5mr9250509ljk.3.1688958349032; Sun, 09 Jul
 2023 20:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230628152726.110295-1-bmeng@tinylab.org>
 <CAEUhbmVsHqdauwvgvjNY6R65kDJ017vDQ797YuzX7S_XHgS5WQ@mail.gmail.com>
In-Reply-To: <CAEUhbmVsHqdauwvgvjNY6R65kDJ017vDQ797YuzX7S_XHgS5WQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jul 2023 11:05:38 +0800
Message-ID: <CACGkMEsAVQhbdRabLeGiw25Ox4Ze9WRRP3coSKni5WVqFNqYYA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] net/tap: Fix QEMU frozen issue when the maximum
 number of file descriptors is very large
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Sun, Jul 9, 2023 at 11:48=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> On Wed, Jun 28, 2023 at 11:29=E2=80=AFPM Bin Meng <bmeng@tinylab.org> wro=
te:
> >
> >
> > Current codes using a brute-force traversal of all file descriptors
> > do not scale on a system where the maximum number of file descriptors
> > is set to a very large value (e.g.: in a Docker container of Manjaro
> > distribution it is set to 1073741816). QEMU just looks frozen during
> > start-up.
> >
> > The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
> > 2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
> > doesn't need to manually close the fds for child process as the proper
> > O_CLOEXEC flag should have been set properly on files with its own
> > codes, QEMU uses a huge number of 3rd party libraries and we don't
> > trust them to reliably be using O_CLOEXEC on everything they open.
> >
> > Modern Linux and BSDs have the close_range() call we can use to do the
> > job, and on Linux we have one more way to walk through /proc/self/fd
> > to complete the task efficiently, which is what qemu_close_range()
> > does, a new API we add in util/osdep.c.
> >
> > V1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bme=
ng@tinylab.org/
> >
> > Changes in v4:
> > - add 'first > last' check logic
> > - reorder the ifdefs logic
> > - change i to unsigned int type
> > - use qemu_strtoi() instead of atoi()
> > - limit last upper value to sysconf(_SC_OPEN_MAX) - 1
> > - call sysconf directly instead of using a variable
> > - put fd on its own line
> >
> > Changes in v3:
> > - fix win32 build failure
> > - limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)
> >
> > Changes in v2:
> > - new patch: "tests/tcg/cris: Fix the coding style"
> > - new patch: "tests/tcg/cris: Correct the off-by-one error"
> > - new patch: "util/async-teardown: Fall back to close fds one by one"
> > - new patch: "util/osdep: Introduce qemu_close_range()"
> > - new patch: "util/async-teardown: Use qemu_close_range() to close fds"
> > - Change to use qemu_close_range() to close fds for child process effic=
iently
> > - v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-b=
meng@tinylab.org/
> >
> > Bin Meng (4):
> >   tests/tcg/cris: Fix the coding style
> >   tests/tcg/cris: Correct the off-by-one error
> >   util/async-teardown: Fall back to close fds one by one
> >   util/osdep: Introduce qemu_close_range()
> >
> > Zhangjin Wu (2):
> >   util/async-teardown: Use qemu_close_range() to close fds
> >   net: tap: Use qemu_close_range() to close fds
> >
>
> Ping for 8.1?

Queued.

Thanks


