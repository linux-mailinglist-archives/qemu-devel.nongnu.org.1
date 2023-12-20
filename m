Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA981A53E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:34:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzVj-0004yJ-QP; Wed, 20 Dec 2023 11:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFzVO-0004vy-96
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:33:11 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFzVL-0006Z0-Rb
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:33:10 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ba53596119so1569501b6e.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 08:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703089986; x=1703694786; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hzBM5PUnKq4RzpN7brysqbSbKojs8/MC5lfccwuTVBw=;
 b=M/lZXZy0BShaz9+3xzYzDqXA2unNoNQNohXfKZcDTwyJGEqV5D5LBIg0QnYLKtKrC7
 zqctM+CBVyGP5Xt+dIbmzaoDJs8WT/M9x593wXV3O7cZimruDM/IIxcFnT6sX19nS/cv
 RkdtWA70at9LutdsNplLqPAXe0vChtNlAXltrWEtQ19DgFlb1dV+lZUElQtYUwN+iuWb
 hlpnH3uWGTXUERnAkmEzB0pmnyNE1imyJr3eWdG64Xw+6bMzgBWSDlnxNoBPe53spTXq
 Yp2HaHgVPrOCeTlLYTgxG87I85CSwub/0xhjnuF/aKhWGOZVeXoN5dnRJTlJx47iZ7MC
 4LUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703089986; x=1703694786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzBM5PUnKq4RzpN7brysqbSbKojs8/MC5lfccwuTVBw=;
 b=fyABn8yTwWA+UiIBO1Yy9XkaQJIkqwqffms9h6zWOV3hNMW5BuC12PNZJ27hwXMmO2
 KWYWI8qEYBrvx52G+yvwnIEpHgkO7l0T3FvrAlxgfYGGCT/OwiMBM6gKIGNcyw97cdNC
 J9T+I/9Md2QjRmqXWXeOd3Gi5M0Lwb6bdHe/vkWPEof2JL6IVYodHx/xe7fFU+hNviI6
 AM3thgupF7fw2ufUkuk06eVEufk0SKUqcGdZOtG5VyJWp/hvPHoKZGPKaXrM30DeJjcv
 2BHik2xBR5ksbSUx2my2h6Sq72AlzdYWTp54+5fLgWB1gCBkHDFHGOcAF/OcjmlWWsEl
 vY7Q==
X-Gm-Message-State: AOJu0YyZz6JeWialGfmIeZDv1KONDedfkD5GibfUrJPP2VnUuCqJno4g
 Snw1bGDQqtjz0aT2LSNiXCT74+e9HT6SdZNUhKw=
X-Google-Smtp-Source: AGHT+IGXmFzJ8g7QpzKcoRTbgvywbDK8jgEwvWmqZSsff2Zg8sQtwfV1MCyXmRtqjxok7X0M8+8FDtgCe/GoLR18LA4=
X-Received: by 2002:a05:6808:13ce:b0:3b9:de4e:222f with SMTP id
 d14-20020a05680813ce00b003b9de4e222fmr14944205oiw.4.1703089986101; Wed, 20
 Dec 2023 08:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20231220160237.843113-1-stefanha@redhat.com>
 <170308870249.47564.2031507210923112269@amd.com>
In-Reply-To: <170308870249.47564.2031507210923112269@amd.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Dec 2023 11:32:53 -0500
Message-ID: <CAJSP0QX8GHtwRta9KP2NakMQ68-pCutO0KQNjpfhgMo9NWEE-Q@mail.gmail.com>
Subject: Re: [qemu-web PATCH] Add QEMU 8.2.0 release announcement
To: Michael Roth <michael.roth@amd.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22b.google.com
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

On Wed, 20 Dec 2023 at 11:18, Michael Roth <michael.roth@amd.com> wrote:
>
> Quoting Stefan Hajnoczi (2023-12-20 10:02:37)
> > Cc: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  _posts/2023-12-20-qemu-8-2-0.md | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 _posts/2023-12-20-qemu-8-2-0.md
> >
> > diff --git a/_posts/2023-12-20-qemu-8-2-0.md b/_posts/2023-12-20-qemu-8-2-0.md
> > new file mode 100644
> > index 0000000..c7cdd8b
> > --- /dev/null
> > +++ b/_posts/2023-12-20-qemu-8-2-0.md
> > @@ -0,0 +1,29 @@
> > +---
> > +layout: post
> > +title:  "QEMU version 8.3.0 released"
>
> 8.2? :)

Oops! Please touch it up when merging.

> > +date:   2023-12-20 10:00:00 -0600
> > +categories: [releases, 'qemu 8.2']
> > +---
> > +We'd like to announce the availability of the QEMU 8.2.0 release. This release contains 3200+ commits from 231 authors.
> > +
> > +You can grab the tarball from our [download page](https://www.qemu.org/download/#source). The full list of changes are available [in the changelog](https://wiki.qemu.org/ChangeLog/8.2).
> > +
> > +Highlights include:
> > +
> > + * Arm: New CPU types cortex-a710 and neoverse-n2
> > + * RISC-V: KVM AIA Support, Virtual IRQs and IRQ filtering support, and vector cryptographic instruction set support
> > + * 68k: The Macintosh Quadra 800 (q800) emulation now can boot MacOS 7.1-8.1, A/UX 3.0.1, NetBSD 9.3, and Linux
> > + * HPPA: New HP C3700 machine emulation and 64-bit PA-RISC 2.0 CPU emulation
> > + * LoongArch: New CPU type la132 (LoongArch32)
> > + * Tricore: New CPU type TC37x (ISA v1.6.2)
> > + * New virtio-sound device emulation
> > + * New virtio-gpu rutabaga device emulation used by Android emulator
> > + * New hv-balloon for dynamic memory protocol device for Hyper-V guests
> > + * New Universal Flash Storage device emulation
> > + * New Xen PV console and network device emulation
> > + * Network Block Device (NBD) 64-bit offsets for improved performance
> > + * dump-guest-memory now supports the standard kdump format
> > + * and lots more...
> > +
> > +Thank you to everybody who contributed to this release, whether that was by writing code, reporting bugs, improving documentation, testing, or providing the project with CI resources. We couldn't do these without you!
>
> Thanks for writing this up. I ran out of time yesterday and am working
> on the announcement email now. I'll plan to merge your summary into the
> email and then push the resulting highlights to qemu-web if that sounds
> okay to you.

Yes, that would be great. Thanks!

Stefan

