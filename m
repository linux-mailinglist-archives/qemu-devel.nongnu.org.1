Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA427ADD9B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkp67-0003ZK-LN; Mon, 25 Sep 2023 13:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qkp65-0003Xi-Bi
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:10:13 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qkp62-0002Hb-Il
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:10:13 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so8077285a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695661809; x=1696266609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kAar/o8/27Z3wn0/J0m8KQfB+/EQDpGstCSYUtBOlw=;
 b=l+YnjRNZ8tta9e7IVarGtHFJCK3FsC9A6s9HAD/IRDdGLWxaz5PwG6VDKanqPuvWvx
 HsavQooM+RoW4L4IQqmzYcuVTO5Bayw8PGg7rwSR9+sbkYhfoYjwKiU6N8C++fZ/qDjT
 WrZcDu7IWgmhRHHEn5wZzPqahMiy002mxeSbmi0eq/+EckLLrhQFpJgmyBtCWqvPkQJT
 T63jmVbK2ImvLrM+FY7hoKwr6jV4fzG9ZIstNXDM2pge2lvpCDD+wRr0e9ZvChuawm8/
 WXs6LdFMFtFLl9FoajcyDi3TztkEgEGNLXlVL4eRcME3fv87MNGyFW+Ihuma/FnIziN7
 2KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695661809; x=1696266609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kAar/o8/27Z3wn0/J0m8KQfB+/EQDpGstCSYUtBOlw=;
 b=vmCDAc4zXLnY/RNS1d7E60zVkd+6ZmQoXlnStIPuCi0BuVvoCA++sS/4un8rpM1n0y
 adil7YE0NAOz2xyx6n/1l8H1lSMpH7uZDRhY4axFshhP1c5uNRFVL2GNaRpz5NOgl5zm
 i4SgXBzHSxb+S9QbKsHx8PZ7lCW7yzZ+ybU04v828bfFbi/4ibvKa8gX7R/a5z+zmF3G
 CxmVVYD/0WSgI2FH8pJfQ7+2doFGk8WrWMwOP8kFVi+pMgKwfYljPPqKdR8zKKAgmzOK
 d33IMS4/R1k+/E9ZD7vkn94INNHm7QfDSJCxsIaIxmQtvg7W1hmfggoe0vu7cQW03x4z
 ZJRQ==
X-Gm-Message-State: AOJu0YwOpqePXZsNz0T6m9FfEJJewJ4lnpEMDl6WenWGkzUIqIicDbgb
 twpdKMjQqSrv/9KX9/hYj25yiz1ceoNFwwcxAoOgmQ==
X-Google-Smtp-Source: AGHT+IEx7wde8/DEuxxeuRDZgr/UNpiMRMbpI8VTq6AURCRtpp9ZcIf++jF2EFNZK/QX7LXRCEyQNtVLtbLLGB1fUqY=
X-Received: by 2002:aa7:dbc3:0:b0:530:bd6b:7a94 with SMTP id
 v3-20020aa7dbc3000000b00530bd6b7a94mr6266756edt.24.1695661808794; Mon, 25 Sep
 2023 10:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
 <20230925144854.1872513-9-alex.bennee@linaro.org>
 <908ae9aa-11fc-8584-bd60-e269a1026e37@redhat.com>
 <87cyy6rylx.fsf@linaro.org>
In-Reply-To: <87cyy6rylx.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Sep 2023 18:09:49 +0100
Message-ID: <CAFEAcA9_dkh-2HcXCxXUj3aBhcZFx5OaEn-q-6swpUkQOE9ykQ@mail.gmail.com>
Subject: Re: [PATCH 08/31] configure: ensure dependency for cross-compile setup
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 qemu-ppc@nongnu.org, 
 David Hildenbrand <david@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 25 Sept 2023 at 17:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 9/25/23 16:48, Alex Benn=C3=A9e wrote:
> >> If we update configure we should make sure we regenerate all the
> >> compiler details. We should also ensure those details are upto date
> >> before building the TCG tests.
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>   configure | 2 ++
> >>   1 file changed, 2 insertions(+)
> >> diff --git a/configure b/configure
> >> index e83872571d..a95e0f5767 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -1788,6 +1788,8 @@ for target in $target_list; do
> >>             echo "HOST_GDB_SUPPORTS_ARCH=3Dy" >> "$config_target_mak"
> >>         fi
> >>   +      echo "$config_target_mak: configure" >> Makefile.prereqs
> >
> > This in practice is not adding anything; if "configure" changes then
> > Makefile's dependency on config-host.mak will trigger a configure
> > rerun anyway.
> >
> > If you want to add it, you should also add it for other config-*.mak
> > files.  However, I'd remove this line and just change
> >
> > -# 1. ensure config-host.mak is up-to-date
> > +# 1. ensure config-host.mak is up-to-date.  All other config-*.mak
> > +# files for subdirectories will be updated as well.
>
> Peter ran into a mismatch between config-host.mak and
> tests/tcg/foo/config-target.mak in his build system so it didn't get
> picked up at one point.

I did, but looking at the timestamps on the two files, the
problem wasn't that one file got updated and not the other:

$ grep CONFIG_PLUGIN build/x86/config-host.h
#undef CONFIG_PLUGIN
$ grep CONFIG_PLUGIN build/x86/tests/tcg/config-host.mak
CONFIG_PLUGIN=3Dy
e104462:jammy:qemu$ ls -l build/x86/config-host.mak
build/x86/tests/tcg/config-host.mak
-rw-r--r-- 1 petmay01 petmay01 549 Sep 22 16:38 build/x86/config-host.mak
-rw-r--r-- 1 petmay01 petmay01 159 Sep 22 16:38
build/x86/tests/tcg/config-host.mak

(both newer than 'configure' itself by about 10 days.)

-- PMM

