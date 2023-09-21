Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDDA7A91C9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 08:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDAv-00081J-K5; Thu, 21 Sep 2023 02:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qjDAt-00080p-Re; Thu, 21 Sep 2023 02:28:31 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qjDAr-0001gg-JG; Thu, 21 Sep 2023 02:28:31 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-452749f6c47so305603137.1; 
 Wed, 20 Sep 2023 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695277708; x=1695882508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2GHiOFmgK0sbJOX0zD/Xwh3liM7qcIa1JTlcPvtnHk=;
 b=BaEPoNzPu2sRyHAqCLKB+Ccs1VR2xDODOj394AqwsRuz/jqAU6WYLcZ3nvvxHeyb+w
 mpNkJnOyWy7nAWF/3kScQMOOuw53aFcq8/koUNnlGpWZReuVxhU/dw8CdVV3o19Xrp7p
 1tL75GwadQqa397/uBVVJeAfvTK08WauOhJ3ATA07WmSG3i+uow25gWqEa1CvYg2iGkl
 1CftBs2W0V8v/ZMXZCUiwGeXVfhEhlo75T0Us8GKNTcmKLA5AUF19Jj1c7K/0XCSH4dx
 S2A52NdapsS6mEl2Z5HRKx8DS93uel9ax8dIcj/kKs+oB6y+bobsFhFd9q+g8m/i+3rb
 O+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695277708; x=1695882508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2GHiOFmgK0sbJOX0zD/Xwh3liM7qcIa1JTlcPvtnHk=;
 b=EQi9Hbp2eOwcr4BjWzktWNQk5xWpWXlb4Fm+H4zcTim4L8Qp/pNSrA/h3fCbMWYf+v
 VdHj6o+UMIQ2ejyOQ0ISfZ0mHuUdonmEYo+ksCyIjt8YB0bjcmAKGaF3beY0DJb1qoWK
 UeKyvX1H7W7LxX5bitzhMsumlgRwTFnwCSWMKcx7AHRRwVrbAwY547GP5zOPgQswP8BT
 LJzg67OyY5xAZTJRROdKgaJ48g8Sj7CRk14VCtnx5J3wgxkXePDSroMVeccekjumAVG3
 oX9ZYIg9/XW37nXbYJDegBv9tvNJzRcXU5ngAmK7FZglNoKFx2qvhQf1k7HQb6/Dd7Ax
 fxpg==
X-Gm-Message-State: AOJu0Ywbg9raURCerxlji1pWzUZgQYO0vJnwkfY0iAGMmMg3uupq5GbZ
 t/R4VKon0vrOu9tILTadelayljevJl5vU9B3g3w=
X-Google-Smtp-Source: AGHT+IHsvtdr4KzydwqKp8oGIZuvgBHq7ZvcnLBQ/A9LT1Cf/BvNSk18ijkZzdB+KMQ4lu1yZDwzxFr5sE/+6M7MpSY=
X-Received: by 2002:a05:6102:151e:b0:452:bfe3:8941 with SMTP id
 f30-20020a056102151e00b00452bfe38941mr221010vsv.21.1695277707672; Wed, 20 Sep
 2023 23:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-2-alistair.francis@wdc.com>
 <20230915161937.00005da0@Huawei.com>
 <CAKmqyKP87E2qByL48oZNcbt6=7qV6EOarhqopEF5YJ=yxby9=g@mail.gmail.com>
 <20230918112846.00002d71@Huawei.com>
In-Reply-To: <20230918112846.00002d71@Huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 21 Sep 2023 16:28:00 +1000
Message-ID: <CAKmqyKM_EGsxTLHDniAPov8w=D7eGeQVmDNwe_aHy1kmgLgqTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] backends: Initial support for SPDM socket support
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lukas@wunner.de, wilfred.mallawa@wdc.com, jiewen.yao@intel.com, 
 qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, hchkuo@avery-design.com.tw, 
 cbrowy@avery-design.com, qemu-block@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Sep 18, 2023 at 8:28=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 18 Sep 2023 13:16:01 +1000
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > On Sat, Sep 16, 2023 at 1:19=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 15 Sep 2023 21:27:22 +1000
> > > Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > > From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > >
> > > Great to see you taking this forwards!
> > >
> > >
> > > >
> > > > SPDM enables authentication, attestation and key exchange to assist=
 in
> > > > providing infrastructure security enablement. It's a standard publi=
shed
> > > > by the DMTF [1].
> > > >
> > > > SPDM currently supports PCIe DOE and MCTP transports, but it can be
> > > > extended to support others in the future. This patch adds
> > > > support to QEMU to connect to an external SPDM instance.
> > >
> > > It supports way more that that these days.  I'd just say 'multiple'
> > > transports.
> > >
> > > >
> > > > SPDM support can be added to any QEMU device by exposing a
> > > > TCP socket to a SPDM server. The server can then implement the SPDM
> > > > decoding/encoding support, generally using libspdm [2].
> > > >
> > > > This is similar to how the current TPM implementation works and mea=
ns
> > > > that the heavy lifting of setting up certificate chains, capabiliti=
es,
> > > > measurements and complex crypto can be done outside QEMU by a well
> > > > supported and tested library.
> > >
> > > Is this sufficient for usecases beyond initial attestation flows?
> >
> > I believe so.
> >
> > The SPDM responder would be in charge of doing all of this. For the
> > rest of the discussion the responder is the software on the other end
> > of the QEMU socket.
> >
> > > How does measurement work for example?  We need settings from the
> >
> > In a basic case the responder can generate measurement data. For
> > example the responder can return digests of the firmware. Now there
> > won't actually be "firmware", but the responder can still return
> > measurement data.
> >
> > if you are trying to test an existing product, you could fake it and
> > return the same values as a real device. Otherwise you could return
> > example data.
> >
> > > emulated device to squirt into the SPDM agent so that it can be
> > > encrypted and signed etc.
> > >
> > > Measurement reports often need to include the status of various confi=
g
> > > space registers + any device specific additional stuff - not sure
> > > what is defined for NVME but I suspect the list will grow, particular=
ly
> > > when tdisp is included.  There are some things called out in the PCIe
> > > state as must haves, like any debug features must be reported.
> >
> > So this is probably the hard part. How can the responder measurements
> > change based on configuration values set by the host.
> >
> > Just for completeness, the idea would be the host would set some state
> > in the NVMe controller for example. Then we would expect the
> > measurement values to change.
> >
> > That's trickier, but we could extend the socket to communicate state
> > like that. So when a measurement state changes in the QEMU model, we
> > relay that to the responder. Which then changes the measurements
> >
> > > Also we need a way to mess with firmware revisions reported
> > > as those are likely to be checked.
> >
> > That seems like something you can do via command line arguments or
> > configuration settings to the responder. This is separate to QEMU
> I'm not convinced it is because QEMU is emulating the firmware behavior
> and that may well change with version.  Still it's just more metadata
> to push out from QEMU to the SPDM instance.
>
> My gut feeling is you'd just add an interface for the whole measurement
> record coming from QEMU.  No need to be clever with sending only small
> subsets of info and building the measurement.

That also works. libspdm delegates the measurement work anyway, so
it's easy to handle either in the external socket wrapper or in QEMU.

>
> >
> > >
> > > I'm not sure that model will work with the spdm-emu approach.
> >
> > I don't think there is anything specifically in the socket approach
> > that limits this from working. It comes down to passing information
> > from the QEMU emulated device to the SPDM responder. That needs to be
> > done either way. It probably is simpler to do if libspdm is included
> > as part of QEMU, but that brings along other complexities.
>
> Agreed that we can do this with an external agent.  So do you think
> we can persuade dmtf tools lot to allow interfaces for this purpose
> or are we looking at a fork of the spdm-emu examples?

I think that depends on them. We can either convince them to add
support, which doesn't seem impossible. Or we can just fork it.

It's worth pointing out that other tools besides spdm-emu can be used
here. It's a pretty simple transport protocol.

>
> >
> > As you pointed out in my original RFC, the complexity of configuration
> > a responder via the QEMU command line will be very difficult. I think
> > it's simpler to keep the responder outside and QEMU and just pass any
> > relevant data to the responder as required.
>
> I'm not sure how bad the interface would actually be.
> My expectation is that we aren't going to need to emulate the
> full flexibility of SPDM - for example we can keep to only the
> required protocols etc.  As such, what do we need to pass in
> beyond the cert chains?  We might provide options to do the more fun
> stuff, but mostly defaults shoudl work.

There are a range of configurations:
 - The supported capabilities
 - The asym algorithms
 - The hash algorithms
 - DHE, AED cipher suits
 - Measurement specs
 - Certificate chains

We could go down the route of saying "this is what the device
supports" and not letting users customise it. That is more like
modelling a real world device. That's handy for users attaching a
device, but not as useful for testing guest software (like the LInux
implementation).

If we keep this external (as in this series) we can allow very
customised implementations to be used, which will help test guest
software. That will allow software like EDK2 and Linux to be
thoroughly tested and even allow fuzzing or automated unit tests.

That doesn't preclude us from integrating libspdm directly in the
future though, if we want to just hard code the setup for specific
devices though. Which might end up happening when we start seeing real
world hardware that we want to emulate that includes SPDM support.

Alistair

>
> >
> > >
> > > Anyhow, I think we need to have gotten a little further figuring that
> > > out before we merge a solution.  I've been carrying this on the CXL
> > > staging tree for a long time because I couldn't figure out a good sol=
ution
> > > to the amount of information that needs to go between them.
> > >
> > > For those not familiar with the fun of libSPDM it is a pain to work w=
ith
> > > which is why Huai-Cheng instead connected with the demo app.
> > >
> > > Any more luck getting a reliable build to work?
> >
> > Yes!
> >
> > libspdm is now packaged in buildroot:
> > https://github.com/buildroot/buildroot/blob/master/package/libspdm/libs=
pdm.mk
> >
> > You can now build libspdm with openSSL provided by your distro as you
> > don't need to access any private openSSL APIs any more.
>
> Great.
>
> >
> > The hope is we can continue to march towards including libspdm as a
> > standard library in distros, which should make the entire process
> > easier.
>
> That is indeed good either way.
>
> Jonathan
>
> >
> > >
> > > >
> > > > 1: https://www.dmtf.org/standards/SPDM
> > > > 2: https://github.com/DMTF/libspdm
> > > >
> > > > Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > > Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> > > > Co-developed-by: Jonathan Cameron <Jonathan.cameron@huawei.com>
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > [ Changes by AF:
> > > >  - Convert to be more QEMU-ified
> > > >  - Move to backends as it isn't PCIe specific
> > > > ]
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > Alistair, you sent this so I think your sign off should be last
> > > + some indication of Wilfred's involvement would be good?
> > > Probably another Co-developed-by
> > >
> > >
> > >
> > > > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > > ---
> > >
> > > I've looked at this code too much in the past to give much
> > > real review.  Still a few comments inline.
> > > I'm very keen to get a solution to this upstream, though I think
> > > we do need to discuss a few general points (no cover letter so I'll
> > > do it here).
> >
> > Yeah, I should have included a cover letter. V2 will
> >
> > Alistair
> >
> > >
> > >
> > > ...
> > >
> > > > diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> > > > new file mode 100644
> > > > index 0000000000..2f31ba80ba
> > > > --- /dev/null
> > > > +++ b/backends/spdm-socket.c
> > > > @@ -0,0 +1,215 @@
> > >
> > >
> > > > +
> > > > +int spdm_socket_connect(uint16_t port, Error **errp)
> > > > +{
> > > > +    int client_socket;
> > > > +    struct sockaddr_in server_addr;
> > > > +
> > > > +    client_socket =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> > > > +    if (client_socket < 0) {
> > > > +        error_setg(errp, "cannot create socket: %s", strerror(errn=
o));
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    memset((char *)&server_addr, 0, sizeof(server_addr));
> > > > +    server_addr.sin_family =3D AF_INET;
> > > > +    server_addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> > > > +    server_addr.sin_port =3D htons(port);
> > > > +
> > > > +
> > > > +    if (connect(client_socket, (struct sockaddr *)&server_addr, si=
zeof(server_addr)) < 0) {
> > > Wrap the line.
> > >
> > > > +        error_setg(errp, "cannot connect: %s", strerror(errno));
> > > > +        close(client_socket);
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    return client_socket;
> > > > +}
> > >
> > >
> >
>

