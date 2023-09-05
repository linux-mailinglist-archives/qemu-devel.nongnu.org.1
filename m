Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E37A67920C6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 09:40:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdQeJ-0002D6-ED; Tue, 05 Sep 2023 03:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qdQeG-0002Ch-LO
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 03:38:56 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qdQeE-0004Ln-0a
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 03:38:56 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a7d4030621so1168098b6e.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693899531; x=1694504331;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dWuAdMTuOxOmRcFCORjJD4cPbCwJNpmm9CZzM6oj7w=;
 b=UU/hEubH1am9JWu891lObu6DXncHjM3OcZB4Ank+mBG0QpwTBbuclgRiwo7QzrNqJo
 7eC0GBYVzffUTGxZseeRWu9gZqEdWv2bhlnt9G+0xkD+MX+lQ1q08HCKdro/eyPKJc60
 LJfOcbLAHaHrYJuRVm4nJ3G3M6MIdh3KSa/BW1Rpq0dEIlTZ0mKebtCJi/j+3auMfAxr
 VafWEP5PV8DkhgnYRB0EUjbc+M3rimbp6zWWS+20sNeYJN0YDvWskbtvdccFrSQ6mT0s
 n78fHE7sJ/HK94NWtnlEoK5n5kZFxMFRh6UPdTirSagtK45NWdRgpZuwwoVmMaMemtaO
 GkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693899531; x=1694504331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dWuAdMTuOxOmRcFCORjJD4cPbCwJNpmm9CZzM6oj7w=;
 b=bE77ZodQ0KCaNk4Ra3+dAR0C2tatA4Q5FEftlWPXVZOJZ6gVEjwopPb3K7kpyLfjGB
 jCcayt4vbdhYSXNDvd7tgnPiqmEmri8mCQVR13SeYoBgK9qmg0ezdKbKrjPa3SPEfLJ1
 a9lMYIQvynesgP46Lft+exVuNRSoSJM7BusTTyInkH8KofU9oQDaFHyEGCFJjnfkmkA2
 QwPyiCHtW/WA3Oe/GO5JfTzufvBx+0y8ly2b2XYEuwyM9QNJpuR5TjC/QrmQRJTGb+mW
 0y7nfLPz1Sc4uAQOguMXEy6Azox0ZjEGJt2SWp3kSejMDfBVkN3OLrie53Pu/gFwcmBa
 RxHQ==
X-Gm-Message-State: AOJu0YwfZnPRby9RvFr4vwQIq1ihcH2+crssRF8/wfqRH3D8hW5vQVxk
 CHK9kH+6HgmAFhhW6wao2AnJVe9aaRu84UZgaNQxPw==
X-Google-Smtp-Source: AGHT+IH4vkYCUjMlefmVP5BDATntCVOCSlMTML9WOBnRup3/4lK7sw3QitXNhlKxEW4AkZkYz1+eyhJh99cBH6a0YQE=
X-Received: by 2002:a05:6808:1514:b0:3a3:4314:8dc0 with SMTP id
 u20-20020a056808151400b003a343148dc0mr13772643oiw.5.1693899530844; Tue, 05
 Sep 2023 00:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
 <20230823092905.2259418-2-mnissler@rivosinc.com> <ZOZDQVgboMaiZ4x6@x1n>
 <CAGNS4TY2-scz3pu16tUF1bA-FEk+pe86QsgjW8L=qjidw5TqOQ@mail.gmail.com>
 <ZOZx7vMqFRfaIwSp@x1n> <20230824133245.GA1412804@fedora>
 <87edjixb6n.fsf@pond.sub.org>
In-Reply-To: <87edjixb6n.fsf@pond.sub.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 5 Sep 2023 09:38:39 +0200
Message-ID: <CAGNS4TaEL1CapL3NoM4XYVMLOH-heOs=2WHMLHNEz072fcxNfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] softmmu: Support concurrent bounce buffers
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, 
 john.levon@nutanix.com, Jagannathan Raman <jag.raman@oracle.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Sep 1, 2023 at 3:41=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
> > On Wed, Aug 23, 2023 at 04:54:06PM -0400, Peter Xu wrote:
> >> On Wed, Aug 23, 2023 at 10:08:08PM +0200, Mattias Nissler wrote:
> >> > On Wed, Aug 23, 2023 at 7:35=E2=80=AFPM Peter Xu <peterx@redhat.com>=
 wrote:
> >> > > On Wed, Aug 23, 2023 at 02:29:02AM -0700, Mattias Nissler wrote:
> >> > > > diff --git a/softmmu/vl.c b/softmmu/vl.c
> >> > > > index b0b96f67fa..dbe52f5ea1 100644
> >> > > > --- a/softmmu/vl.c
> >> > > > +++ b/softmmu/vl.c
> >> > > > @@ -3469,6 +3469,12 @@ void qemu_init(int argc, char **argv)
> >> > > >                  exit(1);
> >> > > >  #endif
> >> > > >                  break;
> >> > > > +            case QEMU_OPTION_max_bounce_buffer_size:
> >> > > > +                if (qemu_strtosz(optarg, NULL, &max_bounce_buff=
er_size) < 0) {
> >> > > > +                    error_report("invalid -max-ounce-buffer-siz=
e value");
> >> > > > +                    exit(1);
> >> > > > +                }
> >> > > > +                break;
> >> > >
> >> > > PS: I had a vague memory that we do not recommend adding more qemu=
 cmdline
> >> > > options, but I don't know enough on the plan to say anything real.
> >> >
> >> > I am aware of that, and I'm really not happy with the command line
> >> > option myself. Consider the command line flag a straw man I put in t=
o
> >> > see whether any reviewers have better ideas :)
> >> >
> >> > More seriously, I actually did look around to see whether I can add
> >> > the parameter to one of the existing option groupings somewhere, but
> >> > neither do I have a suitable QOM object that I can attach the
> >> > parameter to, nor did I find any global option groups that fits: thi=
s
> >> > is not really memory configuration, and it's not really CPU
> >> > configuration, it's more related to shared device model
> >> > infrastructure... If you have a good idea for a home for this, I'm a=
ll
> >> > ears.
> >>
> >> No good & simple suggestion here, sorry.  We can keep the option there
> >> until someone jumps in, then the better alternative could also come al=
ong.
> >>
> >> After all I expect if we can choose a sensible enough default value, t=
his
> >> new option shouldn't be used by anyone for real.
> >
> > QEMU commits to stability in its external interfaces. Once the
> > command-line option is added, it needs to be supported in the future or
> > go through the deprecation process. I think we should agree on the
> > command-line option now.
> >
> > Two ways to avoid the issue:
> > 1. Drop the command-line option until someone needs it.
>
> Avoiding unneeded configuration knobs is always good.
>
> > 2. Make it an experimental option (with an "x-" prefix).
>
> Fine if actual experiments are planned.
>
> Also fine if it's a development or debugging aid.

To a certain extent it is: I've been playing with different device
models and bumping the parameter until their DMA requests stopped
failing.

>
> > The closest to a proper solution that I found was adding it as a
> > -machine property. What bothers me is that if QEMU supports
> > multi-machine emulation in a single process some day, then the property
> > doesn't make sense since it's global rather than specific to a machine.
> >
> > CCing Markus Armbruster for ideas.
>
> I'm afraid I'm lacking context.  Glancing at the patch...
>
>     ``-max-bounce-buffer-size size``
>         Set the limit in bytes for DMA bounce buffer allocations.
>
>         DMA bounce buffers are used when device models request memory-map=
ped access
>         to memory regions that can't be directly mapped by the qemu proce=
ss, so the
>         memory must read or written to a temporary local buffer for the d=
evice
>         model to work with. This is the case e.g. for I/O memory regions,=
 and when
>         running in multi-process mode without shared access to memory.
>
>         Whether bounce buffering is necessary depends heavily on the devi=
ce model
>         implementation. Some devices use explicit DMA read and write oper=
ations
>         which do not require bounce buffers. Some devices, notably storag=
e, will
>         retry a failed DMA map request after bounce buffer space becomes =
available
>         again. Most other devices will bail when encountering map request=
 failures,
>         which will typically appear to the guest as a hardware error.
>
>         Suitable bounce buffer size values depend on the workload and gue=
st
>         configuration. A few kilobytes up to a few megabytes are common s=
izes
>         encountered in practice.
>
> Sounds quite device-specific.  Why isn't this configured per device?

It would be nice to use a property on the device that originates the
DMA operation to configure this. However, I don't see how to do this
in a reasonable way without bigger changes: A typical call path is
pci_dma_map -> dma_memory_map -> address_space_map. While pci_dma_map
has a PCIDevice*, address_space_map only receives the AddressSpace*.
So, we'd probably have to pass through a new QObject parameter to
address_space_map that indicates the originator and pass that through?
Or is there a better alternative to supply context information to
address_space map? Let me know if any of these approaches sound
appropriate and I'll be happy to explore them further.

