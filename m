Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD0B7C8D03
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 20:21:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrMmC-0006sn-P2; Fri, 13 Oct 2023 14:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qrMls-0006sT-U2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 14:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qrMlq-0001AJ-T1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 14:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697221220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRgcC/jr4OUXmVQkqLZQPbH6J1fTDItFEdSk9cowwag=;
 b=f7sMFBsyPWNtYu3RSZ1i6vkpTpbxxvDVuML6T6KB9ytfaXdTuHztdZVSoFVp7vlfGGXtjR
 gfIhNv3g4idvYUv7CcCmmlxBrKp0piQ/mOyBFmRo/Bnid9+sY7kovibMyAUsVlh5nDLKbb
 QigUiR/z6x9i9Kly6LHL8GodJ1GZ2cE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-a7W0Vs6RO8qyverM1pTnGg-1; Fri, 13 Oct 2023 14:20:18 -0400
X-MC-Unique: a7W0Vs6RO8qyverM1pTnGg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7740c0e88ffso274006385a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 11:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697221218; x=1697826018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RRgcC/jr4OUXmVQkqLZQPbH6J1fTDItFEdSk9cowwag=;
 b=O0pd3JfDmO0bI5+Z+MebBaYK8ehsc/S7943ETj+wycwSm5+j/WeLiGg9PiwLpdrKpi
 1izVeyKUINyW6wOXL1rCKpen29uRt62OjdxLnfAwqczvz7v1CsPyC0fZwRh6MT1OjIAA
 RC7/GcOkaAKoL74dNJZ7fnv3WtSaUUhoCbZRmgdEtgPKZ6gUC81zDmWSXxIpg+va7g0j
 oYy+opYItsA9+2UYlNX1aRyrunrCjjkUu7V852xcxF7BuLOWMksbGM+zu7ACx4r0Hrpl
 sKBAwvm+8W1j72xxUMQqS3x2esUBsEHHkV1FuODbcI+NxYbM9bfFXy1+eXEUQ6is+ObL
 Sx8w==
X-Gm-Message-State: AOJu0YyQEdJXLKkOJOxgH25/9uM4S5z6i59mUDKJJLob93H9yNrbdu03
 AFXM7bIl3FV7F8EVDq8KjIlzvyJSy8XQUhP2YubC9O2jZxU0f2IOxcsoJ/ZeSNbNnz5m8ANqYGw
 Nv2e6uWaDkT/BL6c=
X-Received: by 2002:a05:620a:414f:b0:775:7fdc:42c1 with SMTP id
 k15-20020a05620a414f00b007757fdc42c1mr35567103qko.13.1697221218303; 
 Fri, 13 Oct 2023 11:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnPHaTVhgGs6vRD5GaBrDg17KbsndpzypbjUB9Svh7ERGS+EfQTCWk4DdvsMoCK90hhaBhlQ==
X-Received: by 2002:a05:620a:414f:b0:775:7fdc:42c1 with SMTP id
 k15-20020a05620a414f00b007757fdc42c1mr35567084qko.13.1697221218016; 
 Fri, 13 Oct 2023 11:20:18 -0700 (PDT)
Received: from ?IPV6:2600:4040:7c46:e800:32a2:d966:1af4:8863?
 ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05620a13d400b0076d6a08ac98sm824924qkl.76.2023.10.13.11.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 11:20:17 -0700 (PDT)
Message-ID: <60c1bcc0-9b96-4c37-afee-484ffbe40431@redhat.com>
Date: Fri, 13 Oct 2023 14:20:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, philmd@linaro.org,
 berrange@redhat.com, marcandre.lureau@gmail.com
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
 <20231005155448.GA1342722@fedora>
 <bdca3b98-7c22-4732-adfc-dc51c93c5eca@redhat.com>
 <CAAjaMXZb1Les+5Q2uhtpm1dgCm11qfs=Rfcq-6dUvQJj2+HQ3w@mail.gmail.com>
Content-Language: en-US
From: Tyler Fanelli <tfanelli@redhat.com>
In-Reply-To: <CAAjaMXZb1Les+5Q2uhtpm1dgCm11qfs=Rfcq-6dUvQJj2+HQ3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Manos,

Thanks for the heads up, I was using rust 1.71.1. Will update the series 
with 1.72.1

Stefan, Philippe, or Daniel: is there a specific policy for the Rust 
version we should be developing on for crates in qemu?

Tyler

On 10/13/23 2:09 PM, Manos Pitsidianakis wrote:
> Hello Tyler!
>
> With Rust stable 1.72.1, I get:
>
> error: unneeded `return` statement
>     --> tests/launch.rs:103:26
>      |
> 103 |         VcpuExit::Hlt => return,
>      |                          ^^^^^^
>      |
>      = help: for further information visit
> https://rust-lang.github.io/rust-clippy/master/index.html#needless_return
>      = note: `-D clippy::needless-return` implied by `-D warnings`
> help: replace `return` with a unit value
>      |
> 103 |         VcpuExit::Hlt => (),
>      |                          ~~
>
> error: could not compile `sev` (test "launch") due to previous error
> warning: build failed, waiting for other jobs to finish...
>
>
> When doing make.
>
> --
> Manos
>
> On Wed, 11 Oct 2023 at 06:11, Tyler Fanelli <tfanelli@redhat.com> wrote:
>> On 10/5/23 11:54 AM, Stefan Hajnoczi wrote:
>>> On Wed, Oct 04, 2023 at 04:34:10PM -0400, Tyler Fanelli wrote:
>>>> The Rust sev library provides a C API for the AMD SEV launch ioctls, as
>>>> well as the ability to build with meson. Add the Rust sev library as a
>>>> QEMU subproject with the goal of outsourcing all SEV launch ioctls to C
>>>> APIs provided by it.
>>>>
>>>> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
>>>> ---
>>>>    meson.build                   | 8 ++++++++
>>>>    meson_options.txt             | 2 ++
>>>>    scripts/meson-buildoptions.sh | 3 +++
>>>>    subprojects/sev.wrap          | 6 ++++++
>>>>    target/i386/meson.build       | 2 +-
>>>>    5 files changed, 20 insertions(+), 1 deletion(-)
>>>>    create mode 100644 subprojects/sev.wrap
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 20ceeb8158..8a17c29de8 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -960,6 +960,13 @@ if not get_option('slirp').auto() or have_system
>>>>      endif
>>>>    endif
>>>>
>>>> +sev = not_found
>>>> +if not get_option('sev').auto()
>>> When 'sev' is auto, then it won't be built. That seems strange. The
>>> auto-detection part is missing! I did you test this on a system that
>>> doesn't have libsev installed system-wide?
>> My testing environment had libsev installed system-wide. Thanks for
>> pointing this out.
>>
>>> I guess the auto-detection would look something like:
>>>
>>>     cargo = find_program('cargo', required: true)
>>>
>>>     if not get_option('sev').auto() or cargo.found()
>>>         ...
>>>
>>> That way 'sev' is only built automatically on systems that have cargo
>>> installed.
>>>
>>>> +  sev = dependency('sev',
>>>> +                   method: 'pkg-config',
>>>> +                   required: get_option('sev'))
>>>> +endif
>>> If you update the auto logic, see the documentation about fallbacks to
>>> subprojects for optional dependencies:
>>> https://mesonbuild.com/Wrap-dependency-system-manual.html#provide-section
>>>
>>> It might be necessary to add dependency(..., fallback='sev').
>> Noted. Thanks!
>>
>>>> +
>>>>    vde = not_found
>>>>    if not get_option('vde').auto() or have_system or have_tools
>>>>      vde = cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],
>>>> @@ -4331,6 +4338,7 @@ summary_info += {'libudev':           libudev}
>>>>    # Dummy dependency, keep .found()
>>>>    summary_info += {'FUSE lseek':        fuse_lseek.found()}
>>>>    summary_info += {'selinux':           selinux}
>>>> +summary_info += {'sev':               sev}
>>>>    summary_info += {'libdw':             libdw}
>>>>    summary(summary_info, bool_yn: true, section: 'Dependencies')
>>>>
>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>> index 57e265c871..5b8d283717 100644
>>>> --- a/meson_options.txt
>>>> +++ b/meson_options.txt
>>>> @@ -204,6 +204,8 @@ option('sdl_image', type : 'feature', value : 'auto',
>>>>           description: 'SDL Image support for icons')
>>>>    option('seccomp', type : 'feature', value : 'auto',
>>>>           description: 'seccomp support')
>>>> +option('sev', type : 'feature', value : 'auto',
>>>> +        description: 'Rust AMD SEV library')
>>>>    option('smartcard', type : 'feature', value : 'auto',
>>>>           description: 'CA smartcard emulation support')
>>>>    option('snappy', type : 'feature', value : 'auto',
>>>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
>>>> index e4b46d5715..e585a548fa 100644
>>>> --- a/scripts/meson-buildoptions.sh
>>>> +++ b/scripts/meson-buildoptions.sh
>>>> @@ -161,6 +161,7 @@ meson_options_help() {
>>>>      printf "%s\n" '  sdl-image       SDL Image support for icons'
>>>>      printf "%s\n" '  seccomp         seccomp support'
>>>>      printf "%s\n" '  selinux         SELinux support in qemu-nbd'
>>>> +  printf "%s\n" '  sev             SEV library support'
>>>>      printf "%s\n" '  slirp           libslirp user mode network backend support'
>>>>      printf "%s\n" '  slirp-smbd      use smbd (at path --smbd=*) in slirp networking'
>>>>      printf "%s\n" '  smartcard       CA smartcard emulation support'
>>>> @@ -440,6 +441,8 @@ _meson_option_parse() {
>>>>        --disable-seccomp) printf "%s" -Dseccomp=disabled ;;
>>>>        --enable-selinux) printf "%s" -Dselinux=enabled ;;
>>>>        --disable-selinux) printf "%s" -Dselinux=disabled ;;
>>>> +    --enable-sev) printf "%s" -Dsev=enabled ;;
>>>> +    --disable-sev) printf "%s" -Dsev=disabled ;;
>>>>        --enable-slirp) printf "%s" -Dslirp=enabled ;;
>>>>        --disable-slirp) printf "%s" -Dslirp=disabled ;;
>>>>        --enable-slirp-smbd) printf "%s" -Dslirp_smbd=enabled ;;
>>>> diff --git a/subprojects/sev.wrap b/subprojects/sev.wrap
>>>> new file mode 100644
>>>> index 0000000000..5be1faccf6
>>>> --- /dev/null
>>>> +++ b/subprojects/sev.wrap
>>>> @@ -0,0 +1,6 @@
>>>> +[wrap-git]
>>>> +url = https://github.com/tylerfanelli/sev
>>>> +revision = b81b1da5df50055600a5b0349b0c4afda677cccb
>>>> +
>>>> +[provide]
>>>> +sev = sev_dep
>>>> diff --git a/target/i386/meson.build b/target/i386/meson.build
>>>> index 6f1036d469..8972a4fb17 100644
>>>> --- a/target/i386/meson.build
>>>> +++ b/target/i386/meson.build
>>>> @@ -20,7 +20,7 @@ i386_system_ss.add(files(
>>>>      'monitor.c',
>>>>      'cpu-sysemu.c',
>>>>    ))
>>>> -i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-sysemu-stub.c'))
>>>> +i386_system_ss.add(when: 'CONFIG_SEV', if_true: [sev, files('sev.c')], if_false: files('sev-sysemu-stub.c'))
>>>>
>>>>    i386_user_ss = ss.source_set()
>>>>
>>>> --
>>>> 2.40.1
>>>>
>> Tyler
>>
>>


