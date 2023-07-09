Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A30EC74C655
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 17:49:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIWe0-0004kt-4U; Sun, 09 Jul 2023 11:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1qIWds-0004kb-Ui
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 11:48:09 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1qIWdq-0006Fo-Ah
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 11:48:08 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51dec0b6fecso4577839a12.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688917684; x=1691509684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBLOf9Qg7VaGmT/9GQdvEXAt39OkGpsEWy21D1ZwkB0=;
 b=Cl2Rfh2oNEgaRbVNPpGBzJ/3PtWTjtuYI2bOsTDZloumQvxG5ubxu8hyx2JLoUWRbK
 3c2duTRaQVGLBmY6XhQcBtIN6evNww6Lw4VS1v/swV5YpZRUo0sbuxiYqtesx9Pbc8ow
 fUWYJN+x8xiraBKnfGfuqSXk9O8mSkSnIAfxN0QXrPNItdXvJhBpBjLT1AynDfHvSEV8
 OwHGRFc8Mkv3tVRcqoPVrEO6mXNkt45ZfZymUsAuE6m5AT86x9WXkfEhSmxTttRyl6XK
 47j4EeRqW+K7tYnqrozxguuztnQDTrRku7gkDy3FgJE14AE+bqj9A95v/Q9O1WQa1sF/
 WY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688917684; x=1691509684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBLOf9Qg7VaGmT/9GQdvEXAt39OkGpsEWy21D1ZwkB0=;
 b=WILYIoiLs6lGAfmTSveU2o05G5Cq/m3ss7Xs5+utWgIBR7vDvoXI2jWtkq9K6KhwfI
 a005FCRTIyx+QpMHjrbInodwfmLcUt0NsQCESFKnq0qP/FoQ5eyyiUJlNZWSootw3umv
 eHY5ydpGDjrsbB2RG/1CbQNlsmHl3KPpXoB6FOcXa51/j3Po3nnvFKCuMKFyZvsVV1g1
 s1bKhbquzOKuh6vITDzj9m3d3iGnBKaWOU5a6PJSCzqw5lhAFkOsVppx5d0CCjj5HH1L
 m+CNpjzInCQi2uvhaPs3fN/K49MZaGa9I5E4KmeMXmlWiqj2Or8jqAsctjeKGQ4Ujvcf
 hEFg==
X-Gm-Message-State: ABy/qLYk/hR1CwCp0yiAHYaucmm+2JLXyzO54xiNhovoyMnlWucVM6OA
 slxurzQErljxuwl9vLDrBINl8gMBKWSdWRZsn5I=
X-Google-Smtp-Source: APBJJlH9+kFdpQN/ypDML4wQXRCVAFPYEU19sxIwE+POF4aNb4ng9kVXxkO+55Jc2mTS22DJJTLUkuzB/O2vAuaialM=
X-Received: by 2002:a05:6402:180e:b0:51e:e67:df4d with SMTP id
 g14-20020a056402180e00b0051e0e67df4dmr9063541edy.38.1688917683633; Sun, 09
 Jul 2023 08:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230628152726.110295-1-bmeng@tinylab.org>
In-Reply-To: <20230628152726.110295-1-bmeng@tinylab.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 9 Jul 2023 23:47:52 +0800
Message-ID: <CAEUhbmVsHqdauwvgvjNY6R65kDJ017vDQ797YuzX7S_XHgS5WQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] net/tap: Fix QEMU frozen issue when the maximum
 number of file descriptors is very large
To: Bin Meng <bmeng@tinylab.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Zhangjin Wu <falcon@tinylab.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Xuzhou Cheng <xuzhou.cheng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 28, 2023 at 11:29=E2=80=AFPM Bin Meng <bmeng@tinylab.org> wrote=
:
>
>
> Current codes using a brute-force traversal of all file descriptors
> do not scale on a system where the maximum number of file descriptors
> is set to a very large value (e.g.: in a Docker container of Manjaro
> distribution it is set to 1073741816). QEMU just looks frozen during
> start-up.
>
> The close-on-exec flag (O_CLOEXEC) was introduced since Linux kernel
> 2.6.23, FreeBSD 8.3, OpenBSD 5.0, Solaris 11. While it's true QEMU
> doesn't need to manually close the fds for child process as the proper
> O_CLOEXEC flag should have been set properly on files with its own
> codes, QEMU uses a huge number of 3rd party libraries and we don't
> trust them to reliably be using O_CLOEXEC on everything they open.
>
> Modern Linux and BSDs have the close_range() call we can use to do the
> job, and on Linux we have one more way to walk through /proc/self/fd
> to complete the task efficiently, which is what qemu_close_range()
> does, a new API we add in util/osdep.c.
>
> V1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bmeng=
@tinylab.org/
>
> Changes in v4:
> - add 'first > last' check logic
> - reorder the ifdefs logic
> - change i to unsigned int type
> - use qemu_strtoi() instead of atoi()
> - limit last upper value to sysconf(_SC_OPEN_MAX) - 1
> - call sysconf directly instead of using a variable
> - put fd on its own line
>
> Changes in v3:
> - fix win32 build failure
> - limit the last_fd of qemu_close_range() to sysconf(_SC_OPEN_MAX)
>
> Changes in v2:
> - new patch: "tests/tcg/cris: Fix the coding style"
> - new patch: "tests/tcg/cris: Correct the off-by-one error"
> - new patch: "util/async-teardown: Fall back to close fds one by one"
> - new patch: "util/osdep: Introduce qemu_close_range()"
> - new patch: "util/async-teardown: Use qemu_close_range() to close fds"
> - Change to use qemu_close_range() to close fds for child process efficie=
ntly
> - v1 link: https://lore.kernel.org/qemu-devel/20230406112041.798585-1-bme=
ng@tinylab.org/
>
> Bin Meng (4):
>   tests/tcg/cris: Fix the coding style
>   tests/tcg/cris: Correct the off-by-one error
>   util/async-teardown: Fall back to close fds one by one
>   util/osdep: Introduce qemu_close_range()
>
> Zhangjin Wu (2):
>   util/async-teardown: Use qemu_close_range() to close fds
>   net: tap: Use qemu_close_range() to close fds
>

Ping for 8.1?

