Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 911297E28A3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:27:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01V9-0000Hs-J9; Mon, 06 Nov 2023 10:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1r01Ur-000090-Ug
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:26:40 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1r01Uo-00033e-Ol
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:26:37 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2801d7f46f9so3748170a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699284391; x=1699889191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4LpEv+pwTjdcAwF4xpHM37cbtA1PVwPNrLsJCgrL6w=;
 b=PF390xfAh70UbKYiFiWEnFJZMVs1CBb9qq9QekNeCrVQGpAtQyB7XqSRAbFR8Y09PN
 eA8AUIpJKK8SkPpFWlMjveekPd74T8gqwRw5PFVIDpOmXZ/4NYnNnDm7bWpyPPtBv97Z
 yrkg90jj9RRXNQ7T0LL7oQE05RQAQyUdmuozS0VtF4lynpAJRs5uYWjTRAQhL3gjtmj6
 G20+l1jw/qE/SxhAP8rzjz+wWpKoiI3SBvR86M92ljWFBvze0ufOiaaiEXNzM7UiTPnI
 ZoOm3xmBOjejEZ+lfJsVzNLzbhMKbnd/4pa285p/3S8scNoO5ChlkmWmYoJoQhxvvx/u
 0RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284391; x=1699889191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4LpEv+pwTjdcAwF4xpHM37cbtA1PVwPNrLsJCgrL6w=;
 b=qRbQ9Q7p/DFvNuerjUn3CnpOJUe7z6P9JxJVS57Y8xs4eHCTkXNo/AI5jlhUPhIMZz
 j9srNnDfGxX6duK8fyPlHSN4VZynTpwowUhMvaeDguEOY5QY0TnU/e4f7Zq6WVzYrgFq
 9lbUMGFQ0/pDirHLF//a6YtgiO3ACESIe9G1SW6ICpIVniLZZ6NqbyUukPi08icHc4w/
 5WssIY1d6xYWWzlI+1T1vnY+dQohNWRR0T3U8YiqK4kBUbHInd5B5abgHEwxADzRNw7E
 t9jlf068ggS0Cq1VdZMcXu+j4x27fslBPP5j5Q4HGuk2L2ec/4iDAxZ6YKB2nu2DYibg
 dHRQ==
X-Gm-Message-State: AOJu0YzKav+Wx5DGQjjPe+emzMm0n5BHKRu7oUgCnqvXPxkTdMQ/qqWj
 TWgQR8KdAFH4NPYVgltXDl21a+m3f32SVjhMeppMnzjuH98=
X-Google-Smtp-Source: AGHT+IHneaGbT3C6gj2FjJc2jLmhWR8Zp1CCaLiP6VFe6pRtSFgtNJLd4OfSAHBhhT0X9wtKmfoQIrPkKcM7VPhtP9U=
X-Received: by 2002:a17:90a:f198:b0:27d:60b1:4f2c with SMTP id
 bv24-20020a17090af19800b0027d60b14f2cmr22602053pjb.4.1699284390916; Mon, 06
 Nov 2023 07:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20231021134015.1119597-1-daan.j.demeyer@gmail.com>
 <ZTlSPbh2GnhOKExO@redhat.com>
 <CAO8sHcnh1mqaEchGSwYaFr7+LTau9yQRt_4zVJGrFsroWik3ew@mail.gmail.com>
In-Reply-To: <CAO8sHcnh1mqaEchGSwYaFr7+LTau9yQRt_4zVJGrFsroWik3ew@mail.gmail.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Mon, 6 Nov 2023 16:26:19 +0100
Message-ID: <CAO8sHcmFqcHs=F7GTUj=Avn_K91q5sw97nLKEco=2kpCsMyCxg@mail.gmail.com>
Subject: Re: [PATCH] Add class property to configure KVM device node to use
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-pj1-x1031.google.com
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

Ping

Daan

On Sat, 28 Oct 2023 at 14:07, Daan De Meyer <daan.j.demeyer@gmail.com> wrot=
e:
>
> Anything else needed before this patch can be merged?
>
> Cheers,
>
> Daan
>
> On Wed, 25 Oct 2023 at 19:37, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > On Sat, Oct 21, 2023 at 03:40:15PM +0200, Daan De Meyer wrote:
> > > This allows passing the KVM device node to use as a file
> > > descriptor via /dev/fdset/XX. Passing the device node to
> > > use as a file descriptor allows running qemu unprivileged
> > > even when the user running qemu is not in the kvm group
> > > on distributions where access to /dev/kvm is gated behind
> > > membership of the kvm group (as long as the process invoking
> > > qemu is able to open /dev/kvm and passes the file descriptor
> > > to qemu).
> > >
> > > Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> > > ---
> > >  accel/kvm/kvm-all.c      | 25 ++++++++++++++++++++++++-
> > >  include/sysemu/kvm_int.h |  1 +
> > >  qemu-options.hx          |  8 +++++++-
> > >  3 files changed, 32 insertions(+), 2 deletions(-)
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
> >

