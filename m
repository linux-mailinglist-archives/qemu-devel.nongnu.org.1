Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C43567A46F5
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBV5-0003hM-7b; Mon, 18 Sep 2023 06:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiBV1-0003em-Ny; Mon, 18 Sep 2023 06:29:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiBUx-0000dC-QD; Mon, 18 Sep 2023 06:29:03 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq1Dq24N2z6HJhy;
 Mon, 18 Sep 2023 18:26:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 11:28:47 +0100
Date: Mon, 18 Sep 2023 11:28:46 +0100
To: Alistair Francis <alistair23@gmail.com>
CC: <lukas@wunner.de>, <wilfred.mallawa@wdc.com>, <jiewen.yao@intel.com>,
 <qemu-devel@nongnu.org>, <kbusch@kernel.org>, <its@irrelevant.dk>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <hchkuo@avery-design.com.tw>, 
 <cbrowy@avery-design.com>, <qemu-block@nongnu.org>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/3] backends: Initial support for SPDM socket support
Message-ID: <20230918112846.00002d71@Huawei.com>
In-Reply-To: <CAKmqyKP87E2qByL48oZNcbt6=7qV6EOarhqopEF5YJ=yxby9=g@mail.gmail.com>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-2-alistair.francis@wdc.com>
 <20230915161937.00005da0@Huawei.com>
 <CAKmqyKP87E2qByL48oZNcbt6=7qV6EOarhqopEF5YJ=yxby9=g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 18 Sep 2023 13:16:01 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> On Sat, Sep 16, 2023 at 1:19=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 15 Sep 2023 21:27:22 +1000
> > Alistair Francis <alistair23@gmail.com> wrote:
> > =20
> > > From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw> =20
> >
> > Great to see you taking this forwards!
> >
> > =20
> > >
> > > SPDM enables authentication, attestation and key exchange to assist in
> > > providing infrastructure security enablement. It's a standard publish=
ed
> > > by the DMTF [1].
> > >
> > > SPDM currently supports PCIe DOE and MCTP transports, but it can be
> > > extended to support others in the future. This patch adds
> > > support to QEMU to connect to an external SPDM instance. =20
> >
> > It supports way more that that these days.  I'd just say 'multiple'
> > transports.
> > =20
> > >
> > > SPDM support can be added to any QEMU device by exposing a
> > > TCP socket to a SPDM server. The server can then implement the SPDM
> > > decoding/encoding support, generally using libspdm [2].
> > >
> > > This is similar to how the current TPM implementation works and means
> > > that the heavy lifting of setting up certificate chains, capabilities,
> > > measurements and complex crypto can be done outside QEMU by a well
> > > supported and tested library. =20
> >
> > Is this sufficient for usecases beyond initial attestation flows? =20
>=20
> I believe so.
>=20
> The SPDM responder would be in charge of doing all of this. For the
> rest of the discussion the responder is the software on the other end
> of the QEMU socket.
>=20
> > How does measurement work for example?  We need settings from the =20
>=20
> In a basic case the responder can generate measurement data. For
> example the responder can return digests of the firmware. Now there
> won't actually be "firmware", but the responder can still return
> measurement data.
>=20
> if you are trying to test an existing product, you could fake it and
> return the same values as a real device. Otherwise you could return
> example data.
>=20
> > emulated device to squirt into the SPDM agent so that it can be
> > encrypted and signed etc.
> >
> > Measurement reports often need to include the status of various config
> > space registers + any device specific additional stuff - not sure
> > what is defined for NVME but I suspect the list will grow, particularly
> > when tdisp is included.  There are some things called out in the PCIe
> > state as must haves, like any debug features must be reported. =20
>=20
> So this is probably the hard part. How can the responder measurements
> change based on configuration values set by the host.
>=20
> Just for completeness, the idea would be the host would set some state
> in the NVMe controller for example. Then we would expect the
> measurement values to change.
>=20
> That's trickier, but we could extend the socket to communicate state
> like that. So when a measurement state changes in the QEMU model, we
> relay that to the responder. Which then changes the measurements
>=20
> > Also we need a way to mess with firmware revisions reported
> > as those are likely to be checked. =20
>=20
> That seems like something you can do via command line arguments or
> configuration settings to the responder. This is separate to QEMU
I'm not convinced it is because QEMU is emulating the firmware behavior
and that may well change with version.  Still it's just more metadata
to push out from QEMU to the SPDM instance.

My gut feeling is you'd just add an interface for the whole measurement
record coming from QEMU.  No need to be clever with sending only small
subsets of info and building the measurement.

>=20
> >
> > I'm not sure that model will work with the spdm-emu approach. =20
>=20
> I don't think there is anything specifically in the socket approach
> that limits this from working. It comes down to passing information
> from the QEMU emulated device to the SPDM responder. That needs to be
> done either way. It probably is simpler to do if libspdm is included
> as part of QEMU, but that brings along other complexities.

Agreed that we can do this with an external agent.  So do you think
we can persuade dmtf tools lot to allow interfaces for this purpose
or are we looking at a fork of the spdm-emu examples?

>=20
> As you pointed out in my original RFC, the complexity of configuration
> a responder via the QEMU command line will be very difficult. I think
> it's simpler to keep the responder outside and QEMU and just pass any
> relevant data to the responder as required.

I'm not sure how bad the interface would actually be.
My expectation is that we aren't going to need to emulate the
full flexibility of SPDM - for example we can keep to only the
required protocols etc.  As such, what do we need to pass in
beyond the cert chains?  We might provide options to do the more fun
stuff, but mostly defaults shoudl work.

>=20
> >
> > Anyhow, I think we need to have gotten a little further figuring that
> > out before we merge a solution.  I've been carrying this on the CXL
> > staging tree for a long time because I couldn't figure out a good solut=
ion
> > to the amount of information that needs to go between them.
> >
> > For those not familiar with the fun of libSPDM it is a pain to work with
> > which is why Huai-Cheng instead connected with the demo app.
> >
> > Any more luck getting a reliable build to work? =20
>=20
> Yes!
>=20
> libspdm is now packaged in buildroot:
> https://github.com/buildroot/buildroot/blob/master/package/libspdm/libspd=
m.mk
>=20
> You can now build libspdm with openSSL provided by your distro as you
> don't need to access any private openSSL APIs any more.

Great.

>=20
> The hope is we can continue to march towards including libspdm as a
> standard library in distros, which should make the entire process
> easier.

That is indeed good either way.

Jonathan

>=20
> > =20
> > >
> > > 1: https://www.dmtf.org/standards/SPDM
> > > 2: https://github.com/DMTF/libspdm
> > >
> > > Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> > > Co-developed-by: Jonathan Cameron <Jonathan.cameron@huawei.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > [ Changes by AF:
> > >  - Convert to be more QEMU-ified
> > >  - Move to backends as it isn't PCIe specific
> > > ]
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com> =20
> > Alistair, you sent this so I think your sign off should be last
> > + some indication of Wilfred's involvement would be good?
> > Probably another Co-developed-by
> >
> >
> > =20
> > > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > --- =20
> >
> > I've looked at this code too much in the past to give much
> > real review.  Still a few comments inline.
> > I'm very keen to get a solution to this upstream, though I think
> > we do need to discuss a few general points (no cover letter so I'll
> > do it here). =20
>=20
> Yeah, I should have included a cover letter. V2 will
>=20
> Alistair
>=20
> >
> >
> > ...
> > =20
> > > diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> > > new file mode 100644
> > > index 0000000000..2f31ba80ba
> > > --- /dev/null
> > > +++ b/backends/spdm-socket.c
> > > @@ -0,0 +1,215 @@ =20
> >
> > =20
> > > +
> > > +int spdm_socket_connect(uint16_t port, Error **errp)
> > > +{
> > > +    int client_socket;
> > > +    struct sockaddr_in server_addr;
> > > +
> > > +    client_socket =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> > > +    if (client_socket < 0) {
> > > +        error_setg(errp, "cannot create socket: %s", strerror(errno)=
);
> > > +        return -1;
> > > +    }
> > > +
> > > +    memset((char *)&server_addr, 0, sizeof(server_addr));
> > > +    server_addr.sin_family =3D AF_INET;
> > > +    server_addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> > > +    server_addr.sin_port =3D htons(port);
> > > +
> > > +
> > > +    if (connect(client_socket, (struct sockaddr *)&server_addr, size=
of(server_addr)) < 0) { =20
> > Wrap the line.
> > =20
> > > +        error_setg(errp, "cannot connect: %s", strerror(errno));
> > > +        close(client_socket);
> > > +        return -1;
> > > +    }
> > > +
> > > +    return client_socket;
> > > +} =20
> >
> > =20
>=20


