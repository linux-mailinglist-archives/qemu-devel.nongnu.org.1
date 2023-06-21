Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1537386EB
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBynf-0007kD-OH; Wed, 21 Jun 2023 10:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qBynd-0007jq-J1
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:27:09 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qBynb-0001ye-Is
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=BFe3e2Q8nLY8ACdzQ5gFTTRwZTw7H1MBm7XdMHvFkDI=; b=RGz6/mEBfsBhT6wucTeN/8Xtpz
 XBZDv0ef9KI2s7Zsy9vbBhwjA3XKxmTIbMTCwEAiUA2wbJuWxl/DPWnkWTByVuIWKfxo+rNuE0BB6
 pa+M/WghIan0yjcc2CxgEry7jhwwKeOwK9HhbbMBixmFVkZIvfZvu4dqwxHUuz+mc6Q58YbN6n78s
 Y1N7apkbsPrhlqXn7pPLQYig6gnME/BEnX6tbYzVqgo0TU0uwQvSezQnbNhwgy1RlVXQrs7N16jZi
 2T8QK8X1V4atpa6/p7ngywE97lypfobNyXciCxYSs0Cq//O81rzUC4srHwiqZk1n2XQq/T6tR6PZK
 0iHO+nNT8CYjsaA1JQYRh4yDDB+mpiFi3lMZ68ynFFw+a/czNI9q+xHWs5IrH1v0b0zcbHoBMsI5f
 iGGHyHS48UFWsgqoKHZrHzlzWEdJOsQxLtLNFAVcHA329Fl3Ox2vQLeOJEoNRc1DFehujgFAfFh5U
 nU+mvmmzRF6PV4LsSLeLRU6ZCQkOx9+Gs7jKkpWVQRQy2MpZ1/zM3a2wrA3sU1u5zrm4aBHpovjD0
 12MvVgS34OREWSZODPatCGelh/0pajNzaoy/PgIfRHUW7LRxjQuNujNLHLcX9sIfgBqdI7HQv/4+i
 3t0wC682kEt5QEXlGrZVaFB38ieI7FvlzRokIvEqk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3] 9pfs: deprecate 'proxy' backend
Date: Wed, 21 Jun 2023 16:27:04 +0200
Message-ID: <54432347.sjJ5l9EzYk@silver>
In-Reply-To: <ZJL/P90n4R6ioq0J@redhat.com>
References: <E1q7ytt-0005Fl-JX@lizzy.crudebyte.com>
 <ZJL/P90n4R6ioq0J@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wednesday, June 21, 2023 3:46:39 PM CEST Daniel P. Berrang=E9 wrote:
> On Sat, Jun 10, 2023 at 03:39:44PM +0200, Christian Schoenebeck wrote:
> > +``-fsdev proxy`` and ``-virtfs proxy`` (since 8.1)
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +The 9p ``proxy`` filesystem backend driver has been deprecated and wil=
l be
> > +removed in a future version of QEMU. Please use ``-fsdev local`` or
> > +``-virtfs local`` for using the ``local`` 9p filesystem backend instea=
d.
> > +
> > +The 9p ``proxy`` backend was originally developed as an alternative to=
 the 9p
> > +``local`` backend. The idea was to enhance security by dispatching act=
ual low
> > +level filesystem operations from 9p server (QEMU process) over to a se=
parate
> > +process (the virtfs-proxy-helper binary). However this alternative nev=
er gained
> > +momentum. The proxy backend is much slower than the local backend, has=
n't seen
> > +any development in years, and showed to be less secure, especially due=
 to the
> > +fact that its helper daemon must be run as root, whereas with the loca=
l backend
> > +QEMU is typically run as unprivileged user and allows to tighten behav=
iour by
> > +mapping permissions et al.
>=20
> The fact that the helper daemon runs as root was actually an intentional
> design choice to improve security. When QEMU is running unprivileged, the
> 'local' backend is limited in what it can serve to stuff that is readable/
> writable by the 'qemu' user account.
>=20
> Using the 'proxy' backend allowed that restriction to be lifted, such
> that it can serve files owned by arbitrary users.
>=20
> Yes, the 'proxy' backend is less secure than the 'local' backend in an
> unprivileged QEMU. It is massively more secure, however, than the 'local'
> backend in a QEMU process running as root, which was the only option if
> you need to serve files for many users.
>=20
> IOW, if someone is currently using the 'proxy' backend, the 'local' backe=
nd
> is quite likely NOT a viable alternative.

Depends. Some people just want to dump few files between host <-> guest, th=
ey
should even be fine with unpriviliged 'passhthrough' security model with the
'local' backend.

=46or more complex use cases, you would probably transition to 'mapped' sec=
urity
model with the 'local' backend. That's like transitioning from one file sys=
tem
to another, mounting the two, copying over once, that's it.

> I'm fine with deprecating this. In terms of messaging wrt replacements,
> we should highlight both the 9p 'local' backend, and virtiofsd as the
> two alternatives. The latter is likely the better choice (on linux
> hosts) for many.

OK, I can add that to the deprecation doc, but you don't want that to be
added to all the runtime warnings as well, do you?

Best regards,
Christian Schoenebeck



