Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6D87A1D84
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:35:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh75G-0006d7-Kl; Fri, 15 Sep 2023 07:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qh753-0006YL-SB
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:33:50 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qh750-00013J-7T
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:33:48 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6c0c6370e5eso1141806a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694777624; x=1695382424; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ijOM8VfOUXr3c2eCJaJGkmALfZvR+BzwIaIrghshqQ=;
 b=Oe0ksUj20VKFarOYBbgLipOCYg1viabbX3T0+JfaK6tEOsiMxHIv29zz+tUjA3xLRH
 26aR4dujMh99A/rn8wp0zEvctx153MLfCorXws8o8MH0y9CrT8uwsZSIiKfBqXTUSAhx
 Z9Z4F9EFmpxlYp1EbbJHxnKUtzKRBxYaIslXrK58aqFRXjPYCXnNybfevk+Mfg/toQlZ
 VsFLD6/sburWf1spZo09AQWin+eNzvEvGbWiJFrznaeAgK37niyQfnPlCCw0cw47czTG
 nSOnBQ8WAnUlGGHg3QCF9pByQWPXNVZYCGRc5NayfHjKC1SGqoTLXdLCL6N9gYlqUpHx
 YoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694777624; x=1695382424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ijOM8VfOUXr3c2eCJaJGkmALfZvR+BzwIaIrghshqQ=;
 b=Tkj03Gl4Xi+IKqVKHiKGJuAgo9DvFn6kYdveengSlP3ci8dNNdcY6CYAqOhsCrqgDN
 T2Z7KgXU3RwF1NGbNiflF5R2ggK3s21DE6u/aD5Um/gm9Iw6fZN8vaCCPnaW1xNWTtCm
 WDYGzMWITyYdW9/aNQLNPXahrskcrx6032VgItfuAuPzF5ASsxzKUYzpSbPyruenuz7e
 P7f1lnyvU4bEQI+8xO8HwmuUjPMh4dvuXFxhxRbnhCw5GmFUhe3Rzi0+cWoumzezHpOr
 ef8RjdF8ZJ1lZphzsu5MTm1Yks9YlmHvIt8hmgMgRAh7fU+7Q4+mtzpZdjIGbKDkMera
 gZ6w==
X-Gm-Message-State: AOJu0YxgfrwNwu2Z/J4WXaB8QRteuYlofjWvkuT2ElfyIC5pfqkXbIbj
 3q4QwXkqaGKbY8yyXMs5CJkaUFa6jkdNaXLwXH0mCkcvwVM=
X-Google-Smtp-Source: AGHT+IHp0a/NxU+kbPDZ5GidUGAgiF20/2pWFKz7LrqFQ/1pXpvmyVnwboMIHoGw7RdTSCQiU+l+ZP8q9hZK62zDRLU=
X-Received: by 2002:a9d:7588:0:b0:6b2:91c9:8e1e with SMTP id
 s8-20020a9d7588000000b006b291c98e1emr1243706otk.2.1694777624538; Fri, 15 Sep
 2023 04:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230914175835.382972-1-tfanelli@redhat.com>
 <ZQQplEOUE2GhBL07@redhat.com>
In-Reply-To: <ZQQplEOUE2GhBL07@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 15 Sep 2023 07:33:32 -0400
Message-ID: <CAJSP0QUA--fpGAjj9JJ2BW7VSunw6mb7=8NDmTt7+k71OOAd1g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tyler Fanelli <tfanelli@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32e.google.com
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

On Fri, 15 Sept 2023 at 05:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Thu, Sep 14, 2023 at 01:58:27PM -0400, Tyler Fanelli wrote:
> > These patches are submitted as an RFC mainly because I'm a relative
> > newcomer to QEMU with no knowledge of the community's views on
> > including Rust code, nor it's preference of using library APIs for
> > ioctls that were previously implemented in QEMU directly.
>
> We've talked about Rust alot, but thus far most focus has been on
> areas peripheral to QEMU. Projects that might have been part of
> QEMU in the past, and now being done as separate efforts, and
> have bene taking advantage of Rust. eg virtiofsd Rust replacing
> QEMU's in -tree C impl. eg passt providing an alternative to
> slirp. eg the dbus display in QEMU allowing a remote display
> frontend to be provided, written in rust. eg libblkio providing
> a block backend in Rust.
>
> The libblkio work is likely closest to what you've proposed
> here, in that it is a Rust create exposed as a C shared library
> for apps to consume. In theory apps don't need to care that it
> is written in Rust, as it is opaque.
>
> The one key difference though is that it was not replacing
> existing functionality, it was adding a new feature. So users
> who didn't have libblkio or whom want to avoid Rust dependancies
> didn't loose anything they were already using.
>
> If we use the libsev.so we create a hard dependancy on the Rust
> sev crate, otherwise users loose the SEV feature in QEMU. Right
> now the sev crate C library is not present in *any* distro that
> I can see.
>
> If we treat 'sev' as just another opaque 3rd party library to be
> provided by the distro, this creates a problem. Our support
> policy is that we usually won't drop features in existing distros,
> but that is what would happen if we applied this patchset today.
> We did bend that rule slightly with virtiofsd, but that was already
> a separate binary and we followed our deprecation path before
> deleting it, giving distros time to adapt.
>
>
> If we rollback the curtain, however, and decide to expose Rust
> directly to QEMU we could address this problem. We could bundle
> the dependant Rust crates directly with QEMU tarballs, and
> generate the FFI C library as part of QEMU build and static
> link the library. Distros would not have todo anything, though
> they could have the choice of dyn linking if they really wanted
> to.
>
> If we directly exposed the notion of Rust to QEMU, then we are
> also not limited by whether a Rust crate provides a C FFI itself.
> QEMU could provide C FFI glue for any Rust crate it sees as
> useful to its code.
>
> This all forces us, however, to have the difficult discussion
> about whether we're willing to make Rust a mandatory dependancy
> of QEMU and permit (or even welcome) its use /anywhere/ in the
> QEMU tree that looks relevant.
>
> We've already queried whether Rust will actually benefit the
> core QEMU codebase, or whether we'll end up punching too many
> holes in its safety net to make it worthwhile. My opinion is
> that we probably shouldn't obsess over that as I think it is
> hard to predict the future, it has a habit of surprising us.
> Your patch series here doesn't demonstrate an obvious safety
> benefit, since we have existing working code and that code is
> not especially complex. Once we open the doors to Rust code
> in QEMU though, we will probably surprise ourselves with the
> range of benefits we'll see 2, 3, 5 years down the road.
>
> IOW, we shouldn't judge future benefits based on this patch
> series. It is great that this series is actually quite simple,
> because it lets us focus on how we might integrate Rust more
> directly into QEMU, without worrying much about the actual
> code being replaced.
>
> > This series looks to explore the possibility of using the library and
> > show a bit of what it would look like. I'm looking for comments
> > regarding if this feature is desired.
>
> My summary, is that I'd personally be in favour of opening the door
> to Rust code as a mandatory pre-requisite for QEMU, at the very least
> for system emulators. Not because this particular series is compelling,
> but because I think Rust could be more beneficial to QEMU over the long
> term than we expect. In terms of consuming it though, if we're going
> to replace existing QEMU functionality, then I think we need to bundle
> the Rust code and natively integrate it into the build system, as we
> have recently started doing with our python deps, to detach ourselves
> from the limits of what distros ship.

I support using Rust directly within QEMU.

David Gibson looked at Rust's operating system and CPU architecture
coverage a few years ago:
https://wiki.qemu.org/RustInQemu

Please update that support matrix to check that depending on Rust in
core QEMU code really works everywhere where QEMU is supported today.
This is probably just a formality at this stage since Rust has become
widely used over the past few years.

The library approach worked well for libblkio but the overhead of
creating a separate shared library and shipping it is significant.
When QEMU is the only user of some code, then it should definitely be
part of QEMU. Also, when QEMU needs early access to code that isn't
widely available yet, then bundling it inside QEMU until packages are
available also seems reasonable to me (I think we already do that for
libvfio-user and maybe other libraries).

I would prefer it if we minimize Rust wrappers for C APIs and instead
focus on using Rust to build new subsystems. Writing and maintaing two
sets of the same API is expensive and I hope we don't get bogged down
keeping C and Rust APIs in sync. That said, I think there's an
argument for wrapping core QEMU APIs needed for device emulation (e.g.
DeviceState, PCIDevice) because of the security benefits of writing
new device emulation code in Rust.

Stefan

