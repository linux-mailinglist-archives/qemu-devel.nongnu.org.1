Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00276E4DB
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 11:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRUsq-0004T9-Nm; Thu, 03 Aug 2023 05:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qRUso-0004QL-NG
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 05:44:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1qRUsm-0006jf-ON
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 05:44:38 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 718C53200927;
 Thu,  3 Aug 2023 05:44:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 03 Aug 2023 05:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691055872; x=
 1691142272; bh=ABGF4TTn0eyxqG4AbTh5VrUO2+VcO89Eu6hhnEt7zLw=; b=S
 HAHUqdaGpSzRHDQ87Ct5BmR5Emlgss/5jCmLfeTBYw+H5CJ4XxyfB1brv46k12Qy
 5LmrjmSiZQOK1wKty4DkOrliuqtSDF9szLIV4MWuxjrC+ilFJWgmr7Pa9o1wR7Y8
 u/cod0PoO71mJKa2NSXfjqQLqNy2G+y0BmZ9BK13cZRaN3Y9hZL+XQDd/9LK7vEE
 46k6xl3YyBGzPuOMkjUBfYOPo9/Mw9mBZ4EE+Qg1mUS5nuXhojRBFBC5Yq2BR59e
 0qFeo4R2H2WGsORANDbAewedsYsXsOQ8zPKs9lQXBcL2+cXKZJE+2sruorgnu8mh
 QnUYWGG2Ap3iFwbicYdOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691055872; x=1691142272; bh=ABGF4TTn0eyxq
 G4AbTh5VrUO2+VcO89Eu6hhnEt7zLw=; b=cyjQ+0a4LxeX7YMIHurI7nl1FZXyF
 h7SaGUylgtElV4ZtXZwPNVZW/m6YU/9J0NfSSsTPZh/bxWKLwJvPQ/H3Cu8kVnN9
 c7ZOddXkxUFrFicprw+eJ2uslWvfaODEEoxhhWs926tXy+01aJ+DHDHZXIsSzmL8
 J7ML4vDKX5TWR0q6WEOdfkj9KJ1Oh2B8C5wS/vKEpAv21xX6UXWxR4yBVbJKI5bA
 NyTnE51LiD8k0sg04EkuSdS1aX4ITqOZneoPPg5yJp7Ti9rnn+EfYzqHLQQ9aCmo
 PKgK3GZchzBUpQwQs1ugLTvGW+H87OV/ddYWkL01aNNJ7oGl9PumI1KuQ==
X-ME-Sender: <xms:AHfLZAw8gjSI2kIjj4gDIVAEAa8SFdZXDNwR2Q8p0FMdamzD1YWslw>
 <xme:AHfLZER1bGgaFLEDjnsAwEMWrhKB5ajQFTzbzl94DSQTWLUS-tAVQb_ry1ZPd55gA
 0L3XHudJ1RTgCM9V1k>
X-ME-Received: <xmr:AHfLZCVemfF6mLQxtSZ4F5unkEp9xsqmAT_WlLY8sH6xWw9eCkMG5Q_gy9MY5SOa8ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgddukecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
 ertddtjeenucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgv
 vhgrnhhtrdgukheqnecuggftrfgrthhtvghrnhepjefgjeefffdvuefhieefhffggfeule
 ehudekveejvedtuddugeeigeetffffjeevnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:AHfLZOi_4c0DKEsxwqVUOrCi8GmeYOh4GgweJkriZnmjaROke4SP2A>
 <xmx:AHfLZCDqrNGt1iD_Pt0yukR8g3vsHCnXOKY5IcwOGB25maMMgT0oKg>
 <xmx:AHfLZPILX7fP0IofaDwnJbqTp6k18A2A9CzUhfBgybNrHXYvzYM_gg>
 <xmx:AHfLZG5Eoj1VMtrnr4tUJN1tpWKJtv8cB_RVSB01xl6kKjmaj8n70Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Aug 2023 05:44:30 -0400 (EDT)
Date: Thu, 3 Aug 2023 11:44:28 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Ashutosh Sharma <ashutosh.dandora4@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, k.jensen@samsung.com,
 philmd@linaro.org, armbru@redhat.com, mst@redhat.com,
 lukasz.gieryk@linux.intel.com, alex.williamson@redhat.com,
 helgaas@kernel.org, afaria@redhat.com
Subject: Re: Format type of qemu NVMe virtual drive reverted back to its
 default (512 bytes block size) after performing hot plugout/plugin operation
 on that drive.
Message-ID: <ZMt2_L5_f24IsRO7@cormorant.local>
References: <CADOvtemuUgp322fE6xYrzVp_RNU_jpqOfzd-12ES-jpPoDvBaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BTPQIWbb4Cm5Td9d"
Content-Disposition: inline
In-Reply-To: <CADOvtemuUgp322fE6xYrzVp_RNU_jpqOfzd-12ES-jpPoDvBaA@mail.gmail.com>
Received-SPF: pass client-ip=64.147.123.24; envelope-from=its@irrelevant.dk;
 helo=wout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--BTPQIWbb4Cm5Td9d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 25 16:53, Ashutosh Sharma wrote:
> Hi,
>=20
> I have a virtual system created using qemu 7.2. In that system, I
> attached/hot plugged a virtual NVMe drive. This drive had a default
> block size of 512 bytes.
>=20
> admin@node-3:~$ sudo nvme list
> Node                  SN                   Model
>              Namespace Usage                      Format           FW
> Rev
> --------------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme0n1          ashudev-6f34a1cf_13  QEMU NVMe Ctrl
>              1          34.36  GB /  34.36  GB    512   B +  0 B
> 7.1.92
>=20
> After that, I formatted this drive with 4k block size and it formatted
> successfully.
>=20
> admin@node-3:~$ sudo nvme format /dev/nvme0n1 -f --lbaf 4
> Success formatting namespace:1
> admin@node-3:~$
> admin@node-3:~$ sudo nvme list
> Node                  SN                   Model
>              Namespace Usage                      Format           FW
> Rev
> --------------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme0n1          ashudev-6f34a1cf_13  QEMU NVMe Ctrl
>              1          34.36  GB /  34.36  GB      4 KiB +  0 B
> 7.1.92
>=20
> Then, I just performed the hot plugout and then plugin operation on
> that drive using qmp.execute's device_del and device_add cmd
> respectively.
>=20
> But, after that, the default block size of that drive reverted to 512 byt=
es.
>=20
> admin@node-3:~$ sudo nvme list
> Node                  SN                   Model
>              Namespace Usage                      Format           FW
> Rev
> --------------------- --------------------
> ---------------------------------------- ---------
> -------------------------- ---------------- --------
> /dev/nvme0n1          ashudev-6f34a1cf_13  QEMU NVMe Ctrl
>              1          34.36  GB /  34.36  GB    512   B +  0 B
> 7.1.92
>=20
> So, I just wanted to know why the NVMe format type reverted back to
> 512 bytes, as I just performed the hot plugout/plugin operations only.
> Drive's block size (format type) should not be changed upon
> removal/insertion, right ? or am I missing something ?
>=20
> Regards,
> Ashutosh
>=20

The nvme device (or namespaces) does not have any persistent state. The
only way to specify boot-to-boot configuration is through device
parameters. In other words, if you reformat to 4k, then you need to
change logical_block_size on the device/namespace upon reboot.

The format command mostly exists for testing purposes.

I guess it's a caveat we should be more clear about in the
documentation.

--BTPQIWbb4Cm5Td9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTLdvwACgkQTeGvMW1P
DekF8gf7B+GaALK3GTH2sTwiEkeT4e3jMM1wTyKm2HiozNz4gGoHnQNj+nSCpy0H
dhRwsnTuVeG6tOKMWa+8qp84tuJ/izAgagbYBvpmCiMgbly2uQgXU2vctA799J+j
nm1r5nkZyUM500BHrHThtDeS6lRGnIVlFOBnKf0uWtdgXO13ncvicdI6LqjzL2fq
vi21vc8KCI1zCJCxbiexIUEDiJpKMpd5e0MtTnIdmPQ8wzz7ToiISAyNaG1KqkNy
WbNdZYpoGcGvbr1bGGrvKAZbRjVlarqyt2+rDwUy/F2kypGX9iWSli/F1ccmwHkZ
QdsnA2ZM6bYNEZ0tBhEESAajQ8pbtw==
=EPcT
-----END PGP SIGNATURE-----

--BTPQIWbb4Cm5Td9d--

