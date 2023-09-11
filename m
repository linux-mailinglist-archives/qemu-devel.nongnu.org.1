Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03879A786
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfekp-0004Us-5C; Mon, 11 Sep 2023 07:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qfekn-0004Ud-1H
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:06:53 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qfekk-0003Ct-Jr
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:06:52 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57129417cecso2241935eaf.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694430399; x=1695035199; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbod+3tvmCjABFNnQLcqUjLtIr20NLZTWIdQIs+rprU=;
 b=W2wjSbPbugLAQFHOk6OSAaOoAYAqhLeTBFqF4jfOpk0J0ll3efbm2t6FFy9pJ3pLpk
 QfJTMFOqU1NF9J8ggimYsDDlhcF+ATY0gvNsW4cmwK28Pn16bvyc9hsj5Kqoe5NVRSLo
 pffq6J7GARj02VrLyhQe6YjpnQtSY1f8pwczMKQw/kNInZZsAZU3xiNOVJgyKSczopOz
 coNXDyuFSefoovDDpATeddsSegK1qj5RMs5VfP/KOgHWZI6QahE0y4miTmVSoIT0cFgk
 a8Z8TzM07pTP0V98pc2aN0tzuPQZFMhknHf98yo0zoSgXx56qiF9jpYrf8PICBi3baV3
 1+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694430399; x=1695035199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbod+3tvmCjABFNnQLcqUjLtIr20NLZTWIdQIs+rprU=;
 b=w0qAFLWawBFI/KWZhaqDewNADG8XcORaNIZsSvQGC4v9O1WHw7sLnM0NUCLvjIlsgT
 gJJ9h2+IpZiu0wGoxNLXIK7M2NU4ctXPIZm5i7MALhaf+XL6mT19YJy+/V2vrvRfJlPG
 kVKrN6fHBTDFTbju9xzF196xU0a15Sfd5Y6C8KHKpTkiqPkGiIJMJ0YnxnLJzzep1Mee
 Av0ypc4Mcn7RocY3nMYdfbhaNJvQKse2RDpZzpazv7Z97riajRVrIkewg6XMckXQjsek
 KxNxlITuOO0TOzIJQic/jutYqrJxHyz76P4g4LpjFOKGzivJTb4/IV3NbAYyZo99E4Mh
 zI2w==
X-Gm-Message-State: AOJu0YyEw7cr60s6RR5sA1WoKu17RZvhj6SlLb9F7oFATJXtW+JWE+Pn
 IawsV6N/MOqAeiIqQAwyHb7nntfvznXsknXquCE=
X-Google-Smtp-Source: AGHT+IEeYCNGQdmPs2fWI0nuAxC31wDi1T8IclwYM15TFYRXJFEtuL0MKrtfFtTO31fbL5UBwM2bkeSYe2VVZ2v1PfI=
X-Received: by 2002:a05:6871:283:b0:1bb:7f1d:10f5 with SMTP id
 i3-20020a056871028300b001bb7f1d10f5mr6453442oae.20.1694430398989; Mon, 11 Sep
 2023 04:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <CAJSP0QX4QgxG-3dbv6oa6_81MWJkYKTT7T05D5hCtFiG=mLi7Q@mail.gmail.com>
 <93be81d9-3f96-51e2-4b20-74ce99e56ae1@linaro.org>
In-Reply-To: <93be81d9-3f96-51e2-4b20-74ce99e56ae1@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 Sep 2023 07:06:26 -0400
Message-ID: <CAJSP0QWAzj9G=xzzXyzmTdXNWMfySyuZGpgpj5w32-5ML3mYJQ@mail.gmail.com>
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, 11 Sept 2023 at 06:10, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> On 8/9/23 17:47, Stefan Hajnoczi wrote:
> > I wonder how it passed CI?
> > https://gitlab.com/qemu-project/qemu/-/pipelines/996175923/
>
> The conditions are:
> - x86 host
> - both system / user emulation enabled
> - KVM disabled
> - debug enabled
>
> We have jobs with 3 of the 4, but none with
> all the 4.
>
> Is it worth test it?

I think so.

Kevin: Can you confirm your configuration matches what Philippe described?

Stefan

>
> >
> > Stefan
> >
> > On Fri, 8 Sept 2023 at 11:02, Kevin Wolf <kwolf@redhat.com> wrote:
> >>
> >> Am 07.09.2023 um 17:44 hat Stefan Hajnoczi geschrieben:
> >>> Applied, thanks.
> >>>
> >>> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 fo=
r any user-visible changes.
> >>
> >> Something in this has broken the build for me, it seems to be the
> >> linux-user binary that doesn't link any more:
> >>
> >>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in=
 function `cpu_x86_cpuid':
> >>    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:6180: unde=
fined reference to `kvm_arch_get_supported_cpuid'
> >>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in=
 function `x86_cpu_filter_features':
> >>    /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7158: unde=
fined reference to `kvm_arch_get_supported_cpuid'
> >>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu=
.c:7159: undefined reference to `kvm_arch_get_supported_cpuid'
> >>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu=
.c:7160: undefined reference to `kvm_arch_get_supported_cpuid'
> >>    /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu=
.c:7161: undefined reference to `kvm_arch_get_supported_cpuid'
> >>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:/ho=
me/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7162: more undefined =
references to `kvm_arch_get_supported_cpuid' follow
> >>    clang-15: error: linker command failed with exit code 1 (use -v to =
see invocation)
> >>
> >> In case it makes a difference, I'm using clang on F37.
> >>
> >> Kevin
> >
>

