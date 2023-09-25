Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC477AD7F6
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 14:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkket-00014n-LM; Mon, 25 Sep 2023 08:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkkem-00014A-8D
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 08:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkkek-0004ZN-0z
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 08:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695644739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IMoByVuonv8m7pqGso/3ISzs+SbpywGjzbixO8mWIs=;
 b=S2iqheqAeEbCIjJ2CpPJ6+9o9P/M7gFIxQ37CDEztqIcOyIQVwpMVk4hNkzaUC7aNcp9qF
 p0dYHJXX+QBrl67WmxQAEDJc9sQcI4KpcPYgenLi9iZGVvGW/I1ksiKJOWUkWlRniTbEPQ
 0vLTtr1llQR+9ZiPcqMibabd4eSDy7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-Evs8R68pO_CTlUB6nB8aHA-1; Mon, 25 Sep 2023 08:25:37 -0400
X-MC-Unique: Evs8R68pO_CTlUB6nB8aHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8081F101A529;
 Mon, 25 Sep 2023 12:25:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4296F1005B90;
 Mon, 25 Sep 2023 12:25:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3619B21E6900; Mon, 25 Sep 2023 14:25:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: James Bottomley <jejb@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  "Daniel P ." =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] tpm: add backend for mssim
References: <20230109161532.6892-1-jejb@linux.ibm.com>
 <20230109161532.6892-3-jejb@linux.ibm.com>
 <87bkduwxv7.fsf@pond.sub.org>
 <eaf68b96049efd85f1a42dee4f6c1fdd2f45716f.camel@linux.ibm.com>
Date: Mon, 25 Sep 2023 14:25:36 +0200
In-Reply-To: <eaf68b96049efd85f1a42dee4f6c1fdd2f45716f.camel@linux.ibm.com>
 (James Bottomley's message of "Mon, 25 Sep 2023 08:15:50 -0400")
Message-ID: <87il7y5tj3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

James Bottomley <jejb@linux.ibm.com> writes:

> On Fri, 2023-09-22 at 08:00 +0200, Markus Armbruster wrote:
>> Found this cleaning out old mail, sorry for missing it until now!
>>=20
>> I think we owe James a quick decision wether we're willing to take
>> the
>> feature.=C2=A0 Stefan, thoughts?
>>=20
>> James Bottomley <jejb@linux.ibm.com> writes:
>>=20
>> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
>> >=20
>> > The Microsoft Simulator (mssim) is the reference emulation platform
>> > for the TCG TPM 2.0 specification.
>> >=20
>> > https://github.com/Microsoft/ms-tpm-20-ref.git
>> >=20
>> > It exports a fairly simple network socket based protocol on two
>> > sockets, one for command (default 2321) and one for control
>> > (default
>> > 2322).=C2=A0 This patch adds a simple backend that can speak the mssim
>> > protocol over the network.=C2=A0 It also allows the two sockets to be
>> > specified on the command line.=C2=A0 The benefits are twofold: firstly
>> > it
>> > gives us a backend that actually speaks a standard TPM emulation
>> > protocol instead of the linux specific TPM driver format of the
>> > current emulated TPM backend and secondly, using the microsoft
>> > protocol, the end point of the emulator can be anywhere on the
>> > network, facilitating the cloud use case where a central TPM
>> > service
>> > can be used over a control network.
>> >=20
>> > The implementation does basic control commands like power off/on,
>> > but
>> > doesn't implement cancellation or startup.=C2=A0 The former because
>> > cancellation is pretty much useless on a fast operating TPM
>> > emulator
>> > and the latter because this emulator is designed to be used with
>> > OVMF
>> > which itself does TPM startup and I wanted to validate that.
>> >=20
>> > To run this, simply download an emulator based on the MS
>> > specification
>> > (package ibmswtpm2 on openSUSE) and run it, then add these two
>> > lines
>> > to the qemu command and it will use the emulator.
>> >=20
>> > =C2=A0=C2=A0=C2=A0 -tpmdev mssim,id=3Dtpm0 \
>> > =C2=A0=C2=A0=C2=A0 -device tpm-crb,tpmdev=3Dtpm0 \
>> >=20
>> > to use a remote emulator replace the first line with
>> >=20
>> > =C2=A0=C2=A0=C2=A0 -tpmdev
>> > "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote'
>> > ,'port':'2321'}}"
>> >=20
>> > tpm-tis also works as the backend.
>> >=20
>> > Signed-off-by: James Bottomley <jejb@linux.ibm.com>
>>=20
>> [...]
>>=20
>> > diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
>> > index 535912a92b..1398735956 100644
>> > --- a/docs/specs/tpm.rst
>> > +++ b/docs/specs/tpm.rst
>> > @@ -270,6 +270,38 @@ available as a module (assuming a TPM 2 is
>> > passed through):
>> > =C2=A0=C2=A0 /sys/devices/LNXSYSTEM:00/LNXSYBUS:00/MSFT0101:00/tpm/tpm=
0/pcr-
>> > sha256/9
>> > =C2=A0=C2=A0 ...
>> > =C2=A0
>> > +The QEMU TPM Microsoft Simulator Device
>> > +---------------------------------------
>> > +
>> > +The TCG provides a reference implementation for TPM 2.0 written by
>>=20
>>=20
>> Suggest to copy the cover letter's nice introductory paragraph here:
>>=20
>> =C2=A0 The Microsoft Simulator (mssim) is the reference emulation platfo=
rm
>> =C2=A0 for the TCG TPM 2.0 specification.
>>=20
>> =C2=A0 It provides a reference implementation for TPM 2.0 written by
>
> Sure, that's easy.
>
>> > +Microsoft (See `ms-tpm-20-ref`_ on github).=C2=A0 The reference
>> > implementation
>> > +starts a network server and listens for TPM commands on port 2321
>> > and
>> > +TPM Platform control commands on port 2322, although these can be
>> > +altered.=C2=A0 The QEMU mssim TPM backend talks to this
>> > implementation.=C2=A0 By
>> > +default it connects to the default ports on localhost:
>> > +
>> > +.. code-block:: console
>> > +
>> > +=C2=A0 qemu-system-x86_64 <qemu-options> \
>> > +=C2=A0=C2=A0=C2=A0 -tpmdev mssim,id=3Dtpm0 \
>> > +=C2=A0=C2=A0=C2=A0 -device tpm-crb,tpmdev=3Dtpm0
>> > +
>> > +
>> > +Although it can also communicate with a remote host, which must be
>> > +specified as a SocketAddress via json on the command line for each
>> > of
>>=20
>> Is the "via JSON" part in "must be specified ... on the command line"
>> correct?=C2=A0 I'd expect to be able to use dotted keys as well, like
>>=20
>> =C2=A0=C2=A0=C2=A0 -tpmdev
>> type=3Dmssim,id=3Dtpm0,command.type=3Dinet,command.host=3Dremote,command=
.port
>> =3D2321',control.type=3Dinet,control.host=3Dremote,control.port=3D2322
>
> Yes, I've verified that the dot notation works as well.  However, I
> thought QEMU was calling all stuff like this JSON notation?  If not,
> what do you usually call it? "json or dot notation"?

Our terminology is a bit fuzzy there.  We commonly say "dotted keys"
(although that's just the part left of the =3D strictly speaking) or
"key=3Dvalue,...".

>> Aside: I do recommend management applications stick to JSON.

[...]


