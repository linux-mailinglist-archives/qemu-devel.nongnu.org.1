Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E17007C8CCF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 20:11:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrMbZ-0000bO-Rs; Fri, 13 Oct 2023 14:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrMbY-0000Xr-IC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 14:09:44 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrMbW-0007qS-H9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 14:09:44 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-991c786369cso388752066b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697220581; x=1697825381; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4px+ZIxw1I3ooxhMa5NOZ3zUqZDCYF8sm4Lz9eWIAOU=;
 b=qPAoZY5rjM9EIul8k/Gbqh9SR3uur4IbY7cEhjASlFPlrtbRrRyiMBYQ4lrQ/fMo0I
 xzSVm37HSOtg2QC9Lt6gcUY8KTj2FXRW/6mR2AOKylmMSwTmGx7kFbjLPsuBQiiq3EGt
 gQla5XJVyfl6hkPE+I+yaazcJugxksej6wR+pvO01pKxFQWM7C40wgkcQcZeN49LxliM
 hVzh+eSI/WJzH/cJJmF8kVxtVz9QwgSKzE7mjzojVGwx+Eu1jGm0DoRR+DzHgThI6D/U
 rablKifYsIz2NizeNq5FKFqeFB+cCzorwmxvQ2sr+7BYqEot2LPFLNpxIXynGkYk5WVE
 7ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697220581; x=1697825381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4px+ZIxw1I3ooxhMa5NOZ3zUqZDCYF8sm4Lz9eWIAOU=;
 b=osYjn6VgQ54p/H72iFtYzE/RqUavWGsY0aXy1wT1wVuWokjC3HAZ+YGVlvGF63jA7u
 j4dUjNdcNhVrxn6jR7hF+qbxTCjhT5U/8qOeqLD1ZjGKRS5hvXC7RN1LVO0mItrE/E3e
 FVcHZ3ZRnvzDRCD0t0pPT4ru8+11XVzIeeNprTh4PBWPgjsYJTPvAo6riEBBBH2JGCgC
 SHgs0PPbmbZNSV8TnZGIlh/OiIuNXNOghtboSPvIqkyZhgRdGJ1hSBO/t1+qYoVUZiSM
 UCGrwTfPO9LjeqEQF9HczSEGlcBVqFkhgMQpVVd9uXR9sJPLzZvkxdb/5tt6sUs/tfz1
 LjCA==
X-Gm-Message-State: AOJu0YyyZDRUnCd12KnTN+ZkBo2qne+9YllCx2dU61/IGaCa1kUC4gb2
 SG+YFGQ1xGvWCmh/sJaYjC6+IhdW7RdXzQcouow+iA==
X-Google-Smtp-Source: AGHT+IFJLJjatms+TBP/+LfriVpGUFmu9ns7OyXwwTmf6e7CweaVnetCWiVBLVKsa1gfeA0BUkQl7RtdFdHW6G/psac=
X-Received: by 2002:a17:907:7859:b0:9b2:ba73:65c9 with SMTP id
 lb25-20020a170907785900b009b2ba7365c9mr23594069ejc.51.1697220580573; Fri, 13
 Oct 2023 11:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
 <20231005155448.GA1342722@fedora>
 <bdca3b98-7c22-4732-adfc-dc51c93c5eca@redhat.com>
In-Reply-To: <bdca3b98-7c22-4732-adfc-dc51c93c5eca@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 13 Oct 2023 21:09:24 +0300
Message-ID: <CAAjaMXZb1Les+5Q2uhtpm1dgCm11qfs=Rfcq-6dUvQJj2+HQ3w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
To: Tyler Fanelli <tfanelli@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, 
 mtosatti@redhat.com, philmd@linaro.org, berrange@redhat.com, 
 marcandre.lureau@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RAZOR2_CF_RANGE_51_100=1.886,
 RAZOR2_CHECK=0.922, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Tyler!

With Rust stable 1.72.1, I get:

error: unneeded `return` statement
   --> tests/launch.rs:103:26
    |
103 |         VcpuExit::Hlt => return,
    |                          ^^^^^^
    |
    = help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#needless_return
    = note: `-D clippy::needless-return` implied by `-D warnings`
help: replace `return` with a unit value
    |
103 |         VcpuExit::Hlt => (),
    |                          ~~

error: could not compile `sev` (test "launch") due to previous error
warning: build failed, waiting for other jobs to finish...


When doing make.

--
Manos

On Wed, 11 Oct 2023 at 06:11, Tyler Fanelli <tfanelli@redhat.com> wrote:
>
> On 10/5/23 11:54 AM, Stefan Hajnoczi wrote:
> > On Wed, Oct 04, 2023 at 04:34:10PM -0400, Tyler Fanelli wrote:
> >> The Rust sev library provides a C API for the AMD SEV launch ioctls, as
> >> well as the ability to build with meson. Add the Rust sev library as a
> >> QEMU subproject with the goal of outsourcing all SEV launch ioctls to C
> >> APIs provided by it.
> >>
> >> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
> >> ---
> >>   meson.build                   | 8 ++++++++
> >>   meson_options.txt             | 2 ++
> >>   scripts/meson-buildoptions.sh | 3 +++
> >>   subprojects/sev.wrap          | 6 ++++++
> >>   target/i386/meson.build       | 2 +-
> >>   5 files changed, 20 insertions(+), 1 deletion(-)
> >>   create mode 100644 subprojects/sev.wrap
> >>
> >> diff --git a/meson.build b/meson.build
> >> index 20ceeb8158..8a17c29de8 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -960,6 +960,13 @@ if not get_option('slirp').auto() or have_system
> >>     endif
> >>   endif
> >>
> >> +sev = not_found
> >> +if not get_option('sev').auto()
> > When 'sev' is auto, then it won't be built. That seems strange. The
> > auto-detection part is missing! I did you test this on a system that
> > doesn't have libsev installed system-wide?
>
> My testing environment had libsev installed system-wide. Thanks for
> pointing this out.
>
> >
> > I guess the auto-detection would look something like:
> >
> >    cargo = find_program('cargo', required: true)
> >
> >    if not get_option('sev').auto() or cargo.found()
> >        ...
> >
> > That way 'sev' is only built automatically on systems that have cargo
> > installed.
> >
> >> +  sev = dependency('sev',
> >> +                   method: 'pkg-config',
> >> +                   required: get_option('sev'))
> >> +endif
> > If you update the auto logic, see the documentation about fallbacks to
> > subprojects for optional dependencies:
> > https://mesonbuild.com/Wrap-dependency-system-manual.html#provide-section
> >
> > It might be necessary to add dependency(..., fallback='sev').
>
> Noted. Thanks!
>
> >
> >> +
> >>   vde = not_found
> >>   if not get_option('vde').auto() or have_system or have_tools
> >>     vde = cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],
> >> @@ -4331,6 +4338,7 @@ summary_info += {'libudev':           libudev}
> >>   # Dummy dependency, keep .found()
> >>   summary_info += {'FUSE lseek':        fuse_lseek.found()}
> >>   summary_info += {'selinux':           selinux}
> >> +summary_info += {'sev':               sev}
> >>   summary_info += {'libdw':             libdw}
> >>   summary(summary_info, bool_yn: true, section: 'Dependencies')
> >>
> >> diff --git a/meson_options.txt b/meson_options.txt
> >> index 57e265c871..5b8d283717 100644
> >> --- a/meson_options.txt
> >> +++ b/meson_options.txt
> >> @@ -204,6 +204,8 @@ option('sdl_image', type : 'feature', value : 'auto',
> >>          description: 'SDL Image support for icons')
> >>   option('seccomp', type : 'feature', value : 'auto',
> >>          description: 'seccomp support')
> >> +option('sev', type : 'feature', value : 'auto',
> >> +        description: 'Rust AMD SEV library')
> >>   option('smartcard', type : 'feature', value : 'auto',
> >>          description: 'CA smartcard emulation support')
> >>   option('snappy', type : 'feature', value : 'auto',
> >> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> >> index e4b46d5715..e585a548fa 100644
> >> --- a/scripts/meson-buildoptions.sh
> >> +++ b/scripts/meson-buildoptions.sh
> >> @@ -161,6 +161,7 @@ meson_options_help() {
> >>     printf "%s\n" '  sdl-image       SDL Image support for icons'
> >>     printf "%s\n" '  seccomp         seccomp support'
> >>     printf "%s\n" '  selinux         SELinux support in qemu-nbd'
> >> +  printf "%s\n" '  sev             SEV library support'
> >>     printf "%s\n" '  slirp           libslirp user mode network backend support'
> >>     printf "%s\n" '  slirp-smbd      use smbd (at path --smbd=*) in slirp networking'
> >>     printf "%s\n" '  smartcard       CA smartcard emulation support'
> >> @@ -440,6 +441,8 @@ _meson_option_parse() {
> >>       --disable-seccomp) printf "%s" -Dseccomp=disabled ;;
> >>       --enable-selinux) printf "%s" -Dselinux=enabled ;;
> >>       --disable-selinux) printf "%s" -Dselinux=disabled ;;
> >> +    --enable-sev) printf "%s" -Dsev=enabled ;;
> >> +    --disable-sev) printf "%s" -Dsev=disabled ;;
> >>       --enable-slirp) printf "%s" -Dslirp=enabled ;;
> >>       --disable-slirp) printf "%s" -Dslirp=disabled ;;
> >>       --enable-slirp-smbd) printf "%s" -Dslirp_smbd=enabled ;;
> >> diff --git a/subprojects/sev.wrap b/subprojects/sev.wrap
> >> new file mode 100644
> >> index 0000000000..5be1faccf6
> >> --- /dev/null
> >> +++ b/subprojects/sev.wrap
> >> @@ -0,0 +1,6 @@
> >> +[wrap-git]
> >> +url = https://github.com/tylerfanelli/sev
> >> +revision = b81b1da5df50055600a5b0349b0c4afda677cccb
> >> +
> >> +[provide]
> >> +sev = sev_dep
> >> diff --git a/target/i386/meson.build b/target/i386/meson.build
> >> index 6f1036d469..8972a4fb17 100644
> >> --- a/target/i386/meson.build
> >> +++ b/target/i386/meson.build
> >> @@ -20,7 +20,7 @@ i386_system_ss.add(files(
> >>     'monitor.c',
> >>     'cpu-sysemu.c',
> >>   ))
> >> -i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
> >> +i386_system_ss.add(when: 'CONFIG_SEV', if_true: [sev, files('sev.c')], if_false: files('sev-sysemu-stub.c'))
> >>
> >>   i386_user_ss = ss.source_set()
> >>
> >> --
> >> 2.40.1
> >>
> Tyler
>
>

