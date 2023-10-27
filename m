Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D54797D8E22
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 07:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwFML-0008Du-Tz; Fri, 27 Oct 2023 01:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qwFMH-0008DH-3l; Fri, 27 Oct 2023 01:26:09 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qwFME-0004lE-Hg; Fri, 27 Oct 2023 01:26:08 -0400
Received: from [192.168.68.112]
 (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.136.142])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CD9EB20038;
 Fri, 27 Oct 2023 13:25:53 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1698384356;
 bh=5M6omcZ1++I5xXaxt2ZIw3e2GzEoErjFk0+NchsSNVM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=IfX9KgEzbKDHJ2TwdNAWtJuAoHfZdfqRf+7U8uer0dSK8lFyJ0kF9DiVcehxA4kZw
 v0Pzr8QHjRQjL8t8XFfaQN9c4v/TnDqdqrvwAu097MSkHzF2P1a0KMTaZ9WC0BQQrx
 2zA0bmLy4FP/N+Kf9MPIPiFJEk+y3AO6ZPVuOdeu718ozpvO6qdjgc2fzmQqvk+pTN
 ao4MFJVIlbOwQLzPZY3uEZSHbE0Y2Dj5kFp5gwxr6SZp20VX/ftrSI27ZyYmzxMYXS
 yWhgiGyDzo8yHXKna09AhlrheUp/AEEhGGJn8iHbqOpQJdEBJr/9Fkraji0wf+c4pu
 XivfHZFgY3YBg==
Message-ID: <6976919f53a8643d23903d05d3642083da5f9421.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 06/10] hw/fsi: Aspeed APB2OPB interface
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ninad Palsule <ninad@linux.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 joel@jms.id.au,  pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com,  thuth@redhat.com, philmd@linaro.org,
 lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 27 Oct 2023 15:55:47 +1030
In-Reply-To: <8269cf50-05d1-4f57-8fc8-0a074721a0df@linux.ibm.com>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-7-ninad@linux.ibm.com>
 <c1aace06-0eab-4805-b58d-e108b53158dc@kaod.org>
 <1b83521d-4885-490e-b8d7-1d760de5c173@linux.ibm.com>
 <58deedee-a291-4d73-a3f1-09ea16c953f0@kaod.org>
 <8269cf50-05d1-4f57-8fc8-0a074721a0df@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, 2023-10-26 at 10:27 -0500, Ninad Palsule wrote:
> Hello Cedric,
>=20
>=20
> On 10/24/23 10:21, C=C3=A9dric Le Goater wrote:
> > On 10/24/23 17:00, Ninad Palsule wrote:
> > > Hello Cedric,
> > >=20
> > > On 10/24/23 02:46, C=C3=A9dric Le Goater wrote:
> > > > and the fsi_opb_* routines are useless to me.
> > > We are trying to keep the separation between OPB implementation and=
=20
> > > interface hence we have all those fsi_opb_*. I feel that we should=
=20
> > > keep as it is so that future extensions will be easier. Please let me=
=20
> > > know.
> >=20
> > Well, I can't really tell because I don't know enough about FSI :/
> >=20
> > The models look fragile and I have spent already a lot of time trying
> > to untangle what they are trying to do. Please ask your teammates or
> > let's see in the next QEMU cycle.
>=20
> I have decided to go with the approach you suggested and it looks much=
=20
> better. Fixed it.

I intended to reply to this before Ninad sent out v7, but life
intervened.

If we can't justify it with the code we have now I think it's right to
pull it out. Add the code to support the things we're trying to do when
we need to do them. As long as we don't do anything that precludes us
from adding that code later (and I can't really imagine how we'd corner
ourselves like that).

We should bear in mind I wrote the initial models several years ago in
the space of about a week while I was trying to learn FSI (and more
deeply about the QEMU bus and address space modelling). I think I was
doing that to unblock some CI due to the introduction of the kernel
driver for the Aspeed FSI hardware. The models were pretty rough -
prior to all this review the code reflected my hazy understanding of
the problems. I didn't get time to remove the complexities introduced
by my misunderstandings, and now it's been so long that I'm not much
help with fixing them.

Andrew

