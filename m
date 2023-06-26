Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B23273DBC2
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:51:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDird-0002MS-Uk; Mon, 26 Jun 2023 05:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qDirc-0002MK-79
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:50:28 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qDira-0005rW-A1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687773021; x=1688377821; i=lukasstraub2@web.de;
 bh=2gyt0efEMGmdq8I9e6Chc7TncPc3Whgpg9hQvMcLEyY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BLJAN42WSxisNpZnXAWjL1bjlp4ezf9xBq/J9awtxdrzGfrFN3SDt+S5lWWUDLhCp5OyegR
 Mz1uYHbXsbkUYOoKhuaFIHEq/ratoqwTS7wFXi5ow5mDV719RRAa1i9cg9eBzb+3180ntpCUy
 u7odlmTEYwnW4HfkOpFWxD/wjCoD/UxI7eIFwjT80sb+urMc8kDWwcIqHcOFwwZCaLB1M3WaJ
 MP6UYnUwq7JtGG0K1fEJMnRyvBgWoNz9Sm0Y7ppxE3ABfucExSz2enrUC7RvhNegd30XHU51r
 305nES79z4JSgyMPOID2mh5kh9zYqA/9es1R9mGHAtsN9YKe9R1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian.usb.local ([82.207.254.108]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdHE-1qU8iP0DTI-00KwwI; Mon, 26
 Jun 2023 11:50:21 +0200
Date: Mon, 26 Jun 2023 11:49:16 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Felix Wu <flwu@google.com>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: Tips for local testing guestfwd
Message-ID: <20230626114916.45355529@mobian.usb.local>
In-Reply-To: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
References: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jBGZHp2bkts57nSVLxug1TI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:5ASuRfcF6Ttg1K4i8My1+8eJtk2EJeqU8gG40N77rep31DS6hn9
 S2J7+01Mj13a6UrykJwbOmuUGp0BY/jVwGFPM5TRqwMHi4thiyrR8scl9RVHKgOU/Xo23TJ
 EfyjwIMYrx9ySBqnXTHR8YyFLGSpROHBIlBem0K4CVHrf50twUVJp9JHLzHa3Haij91aU5s
 FwXz00cNaWs8pRcPz7yXQ==
UI-OutboundReport: notjunk:1;M01:P0:ucO08WH8Oo0=;v8c5UvBjDulVeCRXpY+66oztMmR
 sUJEqL1pv2CFck4iy7/5DNejo3gEndwxgfp6oxvBohl9FIvPeeAVIhRqgMSZvFazcMlYswYnZ
 C5+95IiHUFUxwlThR3xpxCvvunlawXBY0Ui4tYo2nI85rc1vfCVLEzg7yrhiGHBbKOoQcK0WB
 1sPyeVoQS4C9DTk6ja28FVR5kPCcAulh1jYf12s1ComQfVkzA8AApvz6ch+pJosXutY+q2H1E
 sRvbqqU6Q0jftglnc2qaV32fbSuzDGqxi9mfnp1JrZANQ15YE6vSDmBV10oXHa8nhCAxldmI5
 VyBZEXZ2rv7pn5lTURfbP3cO6OhU5Fvqz9fYSujhHwz+OyyOMVmIfZ2QUQ/tG3B+RDuCBQJpk
 ng9G/TYklAowvmG0/EqhLUB+V1ivA65oIF+SuSrG42fCixZTuQSFW/SYqdVArWG7tP4OAYWah
 5wDK045+e9E7qiTvJa32N20rZ+5JdvhvNVodOXzrgDQspHGm/NUrbxmKaBeoxxyp3J4jqIcVR
 4qYYs1b8somgTm0yAdu7PQ/0JDb+QE4ID59ktOwqwrFtdg6b/78bpaBtqTWxWBxu7d9Wdt+OH
 CMeGw/riPRDLwAAHcTDgyuOK7DWxuYWGksFxRknQc4AbS6skHKLUhD+3CRIuisPu3A6fjQPz7
 M24VzFwJhnlGMcY+VWfv9fMV9itnDHmfeC7cVl+5Mj75wchNP2rKHbq1GAT5Q3/541XbAzPbY
 8OBs8UMH0hUlTwbS0CcAyvy6QqUN+n+kYvkFHq4vyz2rQ9mC25HQz8vEBw0pgqSYeDVAw/sDX
 hHTrRA1tnr/4H3B3DrEfbHECdbKgCURiQWgIEVoKisA2evUMf41S4EA3rYjxNQ0+6SliH166k
 Dsmkt0kLgmPvywswPuax3qOCDDaJzSBHom6UecaYVRFA8OyCmXypEd0HQK3pNZ92sf4wA7Ofs
 OmdhjoS3LF7OXXMMU/gUfMmQ8Ew=
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

--Sig_/jBGZHp2bkts57nSVLxug1TI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

CC'ing SLIRP and net maintainer.

On Sun, 25 Jun 2023 22:58:36 -0700
Felix Wu <flwu@google.com> wrote:

> Hi all,
>=20
> TL,DR: I am working on QEMU ipv6 guestfwd feature and finished coding, and
> would like to learn the best practice to test it.
> Context: in slirp side this task is tracking by [1].
> Currently, I have done following:
> i. made char parse + guestfwd functions happy with ipv6 address.
> ii. enabled debug print and made sure the ip and port are inserted into t=
he
> forward list in libslirp.
> To sufficiently verify it's working, I do have three questions:
> 1. I want to forward a port in the guest (OS in QEMU) to a port 22 on the
> host OS, and ssh from guest back to host,
> does this sound reasonable? If this is not a good idea, what method is
> recommended?
> 2. I want to understand what ip I should use. Currently I have following
> formats for the QEMU invocation in ipv6:
> ```
> guestfwd=3Dtcp:[::1]:1234-tcp:[my:host:ip:from:ifconfig]:22
> ```
> I know the general form is `guestfwd=3Dtcp:server:port-dev`, where
> server:port is for guest, dev is for host.
> Adding [] in my implementation will let QEMU know it's ipv6.
> Is the aforementioned invocation correct? Or in this case [::1] is the
> local host address and I should put qemu address
> for it instead?
> 3. Is there a default ipv6 address for QEMU instance? I think I need it in
> the invocation.
>=20
> Thanks in advance! Felix
>=20
> [1]. https://gitlab.freedesktop.org/slirp/libslirp/-/issues/67


--Sig_/jBGZHp2bkts57nSVLxug1TI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSZXx0ACgkQNasLKJxd
slimBRAArqjJJvStbShnMg1LcdHBYutM6gfbjzMPPFR7NSJZ8slUjMwD/5pIU6ec
pRzwKyTzEILGt7A3ad0aXc4NrCYZiz4/peruDcTB1V0PuDjxrXCFxIx2CNH1ipk0
9FPjq95xI+YiY85iVpPaBkQMUkhgbeuqsrCPfZk20OM6PoTLVwtzMwTOIck485hW
UlYw7r+NlSpiplg+/Oz27eFOkUy6ce/8JG6+1mzzpYJlrJTcbBHMZpfzU9q8A1AZ
11XlNsr4vBKUz57lw4WsqJo5cBgvjpMUxRzpDl6zZIpMdkNlHovI76HFaVQkhYuR
4RjS/C3qOTNpkeWmDQKJyFxXXa/eZg3DfITTfQjrOheQbkcUegvVJwx4LejtxLTH
B6RbZkUbDiz5BbOIQHyQonstoEbwFp24UYtR9t8JRAuf7PTmk/r5mKe4FTkRaTF0
6r6cpeiEbQVWEV0T9v0rSKb5HXOaRN/xmhKmIiZNGqr9q1i4gPBfnqJdSUs75ZJx
VfI8A326vcXJbHnChgFbz03zs63q0WoiaUoGKX/csBqChndI59UUAteX9bWZfQff
M+Zwpxh7B+qksTR04nsJKiCGzQWPGch2s4mhFy7NjjB6dBW4tM5z6UYjllH+hPK6
dBhBb5kvVdtUCM3Kg+COeva/Y1RfZ4j+7onmeFQA+KVvhLUECQA=
=6URw
-----END PGP SIGNATURE-----

--Sig_/jBGZHp2bkts57nSVLxug1TI--

