Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4979FC48
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:46:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgg6T-0004xh-8F; Thu, 14 Sep 2023 02:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qgg6J-0004w4-3U; Thu, 14 Sep 2023 02:45:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qgg6E-0007Ei-7X; Thu, 14 Sep 2023 02:45:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id ED9205C0657;
 Thu, 14 Sep 2023 02:45:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 14 Sep 2023 02:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1694673907; x=
 1694760307; bh=Gy097/RytwXGNZkyUWIM71lYsTIPAH1HMh+nAleZvP8=; b=m
 l0kTd3C8S5bNNGBcAZniP5ZXLpbzF9kjuyZ4fa8n7s519oPRgsKQSgW8vnFDYqD+
 ZQweXyCHnB4cDUSg5ojPMqszu8fHvWlfn08OMzo8/ZuLhOwrfPOrXUazyv2W/lkT
 EdToI93SNVt0fIafHNokvkD7oci+HSf5GCmcGsOaXAipSzy8QpItbRZWO6xqxB/k
 VgmAf7P0HB2c0sesBfGQuhJtqgH7gpmBZL2cdfl2q3xbdAdVKdp9mEdrod52Jv9z
 00knUW4GV9FhZHqGD0jg68a+7sdG6Hs0qVf9men/eeLs5GCL3cTk8fhkCgST17tD
 r+Ys9YQkFc/34A3KPT56Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1694673907; x=1694760307; bh=Gy097/RytwXGN
 ZkyUWIM71lYsTIPAH1HMh+nAleZvP8=; b=B5gvjVs8M+uMbb7sVQURcDB/EyN62
 PB2kHHwqRbvcmEzReQpdDlvAAXN/sF6eLd+BASotsia3jB9t47ZvnpSsaktSRPbI
 B9yy5cypB9FtPCU96HfUKtm8gKaYONMfzQIggWObN5X94EOpqAZIQbW00p1ag+x2
 wJVMvr6Q/0V+7XU1bQJm/0iqGTpJu96PM/xMwkNtiqI7BYl852G3wrG18YjZ1/1c
 toS2HY6VGTuDppsbqeGRpapB4YU2OH4wVYHeJRGYszvjRbSpZMsOMenB651OXl8a
 +le8nl2zFTNJ3oxqMwI8ft31q620ywkszKm5SJIJj+S76PDs/B4ydEjcQ==
X-ME-Sender: <xms:8qsCZTlG45ptRevdW0tglKLwYnTrU0-4uUjs1Ppj-N921Et-eTd2Fw>
 <xme:8qsCZW04XpaTG2Q3cuejkfrEIghZH7wp4wpgx9C9sVL2g5z4d-KYXVUfUxN5wBWIA
 ZkVInPaa4f-MK2hIsg>
X-ME-Received: <xmr:8qsCZZpMrC6tMr9hH1wp0oEdSsvPrtr5SdkknW1aGv_jvUuNkwGYQT3a1xE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiledguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:8qsCZbllChtTrBU8thEf6wVMUK5jCvi4XmtlF1_g2seNZsQtx01anA>
 <xmx:8qsCZR1KoUubauM3c_ry3xw-KbozWkX1Fj4jmPc17HNyoW0VnMKwJQ>
 <xmx:8qsCZas45RVXpoAbtmw3XjynhiCWePe2jXTpx5-vQp3ezG0usuIzCg>
 <xmx:86sCZQ1MJLacPvJ_BzCsEc-wivtJBO9wNYyHtI_cRxHYD5EaCncSvA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 02:45:06 -0400 (EDT)
Date: Thu, 14 Sep 2023 08:44:59 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 1/5] block: remove AIOCBInfo->get_aio_context()
Message-ID: <ZQKr62RXhpBWkI_R@cormorant.local>
References: <20230912231037.826804-1-stefanha@redhat.com>
 <20230912231037.826804-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="81uW9M3yYwgvZt0B"
Content-Disposition: inline
In-Reply-To: <20230912231037.826804-2-stefanha@redhat.com>
Received-SPF: pass client-ip=66.111.4.27; envelope-from=its@irrelevant.dk;
 helo=out3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--81uW9M3yYwgvZt0B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 12 19:10, Stefan Hajnoczi wrote:
> The synchronous bdrv_aio_cancel() function needs the acb's AioContext so
> it can call aio_poll() to wait for cancellation.
>=20
> It turns out that all users run under the BQL in the main AioContext, so
> this callback is not needed.
>=20
> Remove the callback, mark bdrv_aio_cancel() GLOBAL_STATE_CODE just like
> its blk_aio_cancel() caller, and poll the main loop AioContext.
>=20
> The purpose of this cleanup is to identify bdrv_aio_cancel() as an API
> that does not work with the multi-queue block layer.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h                |  1 -
>  include/block/block-global-state.h |  2 ++
>  include/block/block-io.h           |  1 -
>  block/block-backend.c              | 17 -----------------
>  block/io.c                         | 23 ++++++++---------------
>  hw/nvme/ctrl.c                     |  7 -------
>  softmmu/dma-helpers.c              |  8 --------
>  util/thread-pool.c                 |  8 --------
>  8 files changed, 10 insertions(+), 57 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 539d273553..ee7273daa1 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -2130,11 +2130,6 @@ static inline bool nvme_is_write(NvmeRequest *req)
>             rw->opcode =3D=3D NVME_CMD_WRITE_ZEROES;
>  }
> =20
> -static AioContext *nvme_get_aio_context(BlockAIOCB *acb)
> -{
> -    return qemu_get_aio_context();
> -}
> -
>  static void nvme_misc_cb(void *opaque, int ret)
>  {
>      NvmeRequest *req =3D opaque;
> @@ -3302,7 +3297,6 @@ static void nvme_flush_cancel(BlockAIOCB *acb)
>  static const AIOCBInfo nvme_flush_aiocb_info =3D {
>      .aiocb_size =3D sizeof(NvmeFlushAIOCB),
>      .cancel_async =3D nvme_flush_cancel,
> -    .get_aio_context =3D nvme_get_aio_context,
>  };
> =20
>  static void nvme_do_flush(NvmeFlushAIOCB *iocb);
> @@ -6478,7 +6472,6 @@ static void nvme_format_cancel(BlockAIOCB *aiocb)
>  static const AIOCBInfo nvme_format_aiocb_info =3D {
>      .aiocb_size =3D sizeof(NvmeFormatAIOCB),
>      .cancel_async =3D nvme_format_cancel,
> -    .get_aio_context =3D nvme_get_aio_context,
>  };
> =20
>  static void nvme_format_set(NvmeNamespace *ns, uint8_t lbaf, uint8_t mse=
t,

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--81uW9M3yYwgvZt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmUCq+oACgkQTeGvMW1P
Del9hgf/VZwh2QW+QT0QyXutSYipURnZd+/QMM5g3+GR1Rwr+pLUEdAocE4ltVBG
Nvz4xF+8W6XiB/IakMovGA4QI1ZTCCSCEHuGW4W7+YDRh6ju+eFp3uiMTZi4TpRo
JKOnNasDXDLmBGgtOoapwpD6SNsIsJhpOJi+RtazQzf+mS/QtOrXiqRq238Y8TAz
40mTKVPfFnk8Vc1yXrKvGr7GlFr0o7xamsD/3m/5syS0FfNgi9XVHwSIbrv7k9Se
rxkM/nsErraR8sfBEw0Jz5Hlcct58BSimwcvdD8YAdD7Ed4PefkV9WEIrfUIZrrQ
Gszfo0VjPivThVH9ZsZY4kmjVLjU0g==
=KcHi
-----END PGP SIGNATURE-----

--81uW9M3yYwgvZt0B--

