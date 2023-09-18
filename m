Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FC7A3FA5
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 05:17:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi4kW-0006fb-0I; Sun, 17 Sep 2023 23:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qi4kT-0006f5-UZ; Sun, 17 Sep 2023 23:16:34 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qi4kQ-0008Qo-AG; Sun, 17 Sep 2023 23:16:33 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4526d872941so216525137.1; 
 Sun, 17 Sep 2023 20:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695006988; x=1695611788; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLTeAtxePfm9LYnqKOamKIC7+UbJrDYto6h39v3k/h8=;
 b=lQ0d6RRL2QG2kYHKx5vH5Tdf2IFmA4O5lm3NEfX+QNZIis+gG80B6oUObUWrMM012h
 9XHzwi2SV/tGD9W/dNOAXAtvlTl19+Mk/stxnNKOnjURZd2CNcGzAQtIQgBzltD0Xfmg
 UPL1Gxqe87Z/HzpFgZAp7N3HPZVIC5l15i+D1wMAmY1WJALr4AA5Vp4KOsf3B3FSU0jW
 xwGyuyWVs8ENw3SSLsp+gAZYr+QTIg9+gAw0LXI8vdQo08ebEXTllA1zzOu/47/A0fRG
 xS8XHPiwDXLW6wBqrgRUBbrpaSs74IyVa4Ecq8sFpvyi87af2e6QNTVNfyQi/MDhBBYD
 szvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695006988; x=1695611788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLTeAtxePfm9LYnqKOamKIC7+UbJrDYto6h39v3k/h8=;
 b=CmbK8S1xlbxLHOsLjSJjesgD6IUnRN5e61zJ9FWk343JqqX9RIfVXS/OZdtGcd/ljK
 UB7UXFhZtmDMSZd1OHCM98x/WcvoRQB/u64zLdQpOwny9slj2AYLwMq1gGz3Qb1zBxLH
 GzFBGjb0pPHalWtHIdpfP/59DCz7AnLVrnuUPHzEbTlkDAll/hvIEPJxPa2IFJll+U39
 oi1Sbd+6YnNUJ3dJKLICKQeI25OiK6Pcv2QYt5YJQM9VCEYYiuZj4hDicHxsprD4FACq
 3Op1x5PDv6lDKnxqkpQqo1FVbRF4gyLk1jqvnRE6mfdmdjogQQGglF9cFwvisjr7Z9VN
 3tzQ==
X-Gm-Message-State: AOJu0YxNC3mgXZlT1OzGqWZqGdLsK8rDq7ujAVOkSHhQlLbtZ3WSpzBI
 8JHIWTQ3fkFCGNF9QOWmSVh8ff1/eTGjpkK2Qpg=
X-Google-Smtp-Source: AGHT+IHlD7X2YS26RLCTqURgKd7IawFyej7YISQOXFar4lCcZH99UXsBn763Z6tuK3+l272dcwnhQvjc8udqgNAqpBw=
X-Received: by 2002:a67:e697:0:b0:452:5912:da3c with SMTP id
 hv23-20020a67e697000000b004525912da3cmr3241689vsb.23.1695006988434; Sun, 17
 Sep 2023 20:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-2-alistair.francis@wdc.com>
 <20230915161937.00005da0@Huawei.com>
In-Reply-To: <20230915161937.00005da0@Huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Sep 2023 13:16:01 +1000
Message-ID: <CAKmqyKP87E2qByL48oZNcbt6=7qV6EOarhqopEF5YJ=yxby9=g@mail.gmail.com>
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

On Sat, Sep 16, 2023 at 1:19=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 15 Sep 2023 21:27:22 +1000
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > From: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
>
> Great to see you taking this forwards!
>
>
> >
> > SPDM enables authentication, attestation and key exchange to assist in
> > providing infrastructure security enablement. It's a standard published
> > by the DMTF [1].
> >
> > SPDM currently supports PCIe DOE and MCTP transports, but it can be
> > extended to support others in the future. This patch adds
> > support to QEMU to connect to an external SPDM instance.
>
> It supports way more that that these days.  I'd just say 'multiple'
> transports.
>
> >
> > SPDM support can be added to any QEMU device by exposing a
> > TCP socket to a SPDM server. The server can then implement the SPDM
> > decoding/encoding support, generally using libspdm [2].
> >
> > This is similar to how the current TPM implementation works and means
> > that the heavy lifting of setting up certificate chains, capabilities,
> > measurements and complex crypto can be done outside QEMU by a well
> > supported and tested library.
>
> Is this sufficient for usecases beyond initial attestation flows?

I believe so.

The SPDM responder would be in charge of doing all of this. For the
rest of the discussion the responder is the software on the other end
of the QEMU socket.

> How does measurement work for example?  We need settings from the

In a basic case the responder can generate measurement data. For
example the responder can return digests of the firmware. Now there
won't actually be "firmware", but the responder can still return
measurement data.

if you are trying to test an existing product, you could fake it and
return the same values as a real device. Otherwise you could return
example data.

> emulated device to squirt into the SPDM agent so that it can be
> encrypted and signed etc.
>
> Measurement reports often need to include the status of various config
> space registers + any device specific additional stuff - not sure
> what is defined for NVME but I suspect the list will grow, particularly
> when tdisp is included.  There are some things called out in the PCIe
> state as must haves, like any debug features must be reported.

So this is probably the hard part. How can the responder measurements
change based on configuration values set by the host.

Just for completeness, the idea would be the host would set some state
in the NVMe controller for example. Then we would expect the
measurement values to change.

That's trickier, but we could extend the socket to communicate state
like that. So when a measurement state changes in the QEMU model, we
relay that to the responder. Which then changes the measurements

> Also we need a way to mess with firmware revisions reported
> as those are likely to be checked.

That seems like something you can do via command line arguments or
configuration settings to the responder. This is separate to QEMU

>
> I'm not sure that model will work with the spdm-emu approach.

I don't think there is anything specifically in the socket approach
that limits this from working. It comes down to passing information
from the QEMU emulated device to the SPDM responder. That needs to be
done either way. It probably is simpler to do if libspdm is included
as part of QEMU, but that brings along other complexities.

As you pointed out in my original RFC, the complexity of configuration
a responder via the QEMU command line will be very difficult. I think
it's simpler to keep the responder outside and QEMU and just pass any
relevant data to the responder as required.

>
> Anyhow, I think we need to have gotten a little further figuring that
> out before we merge a solution.  I've been carrying this on the CXL
> staging tree for a long time because I couldn't figure out a good solutio=
n
> to the amount of information that needs to go between them.
>
> For those not familiar with the fun of libSPDM it is a pain to work with
> which is why Huai-Cheng instead connected with the demo app.
>
> Any more luck getting a reliable build to work?

Yes!

libspdm is now packaged in buildroot:
https://github.com/buildroot/buildroot/blob/master/package/libspdm/libspdm.=
mk

You can now build libspdm with openSSL provided by your distro as you
don't need to access any private openSSL APIs any more.

The hope is we can continue to march towards including libspdm as a
standard library in distros, which should make the entire process
easier.

>
> >
> > 1: https://www.dmtf.org/standards/SPDM
> > 2: https://github.com/DMTF/libspdm
> >
> > Signed-off-by: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > Signed-off-by: Chris Browy <cbrowy@avery-design.com>
> > Co-developed-by: Jonathan Cameron <Jonathan.cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > [ Changes by AF:
> >  - Convert to be more QEMU-ified
> >  - Move to backends as it isn't PCIe specific
> > ]
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Alistair, you sent this so I think your sign off should be last
> + some indication of Wilfred's involvement would be good?
> Probably another Co-developed-by
>
>
>
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > ---
>
> I've looked at this code too much in the past to give much
> real review.  Still a few comments inline.
> I'm very keen to get a solution to this upstream, though I think
> we do need to discuss a few general points (no cover letter so I'll
> do it here).

Yeah, I should have included a cover letter. V2 will

Alistair

>
>
> ...
>
> > diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> > new file mode 100644
> > index 0000000000..2f31ba80ba
> > --- /dev/null
> > +++ b/backends/spdm-socket.c
> > @@ -0,0 +1,215 @@
>
>
> > +
> > +int spdm_socket_connect(uint16_t port, Error **errp)
> > +{
> > +    int client_socket;
> > +    struct sockaddr_in server_addr;
> > +
> > +    client_socket =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> > +    if (client_socket < 0) {
> > +        error_setg(errp, "cannot create socket: %s", strerror(errno));
> > +        return -1;
> > +    }
> > +
> > +    memset((char *)&server_addr, 0, sizeof(server_addr));
> > +    server_addr.sin_family =3D AF_INET;
> > +    server_addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> > +    server_addr.sin_port =3D htons(port);
> > +
> > +
> > +    if (connect(client_socket, (struct sockaddr *)&server_addr, sizeof=
(server_addr)) < 0) {
> Wrap the line.
>
> > +        error_setg(errp, "cannot connect: %s", strerror(errno));
> > +        close(client_socket);
> > +        return -1;
> > +    }
> > +
> > +    return client_socket;
> > +}
>
>

