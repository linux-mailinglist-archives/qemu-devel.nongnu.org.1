Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFAB705359
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyxKJ-0003Hg-E2; Tue, 16 May 2023 12:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1pyxKG-0003HB-VD
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:15:00 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1pyxKB-0008QG-Hy
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:15:00 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230516161447usoutp0200ba3570f202bc1253a2411cbfe36d59~fq844W-rB1679816798usoutp025;
 Tue, 16 May 2023 16:14:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230516161447usoutp0200ba3570f202bc1253a2411cbfe36d59~fq844W-rB1679816798usoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684253687;
 bh=K4rpJpoqAeXt8HedMEHnFOzeuG0FX2LpLghWBvJWMmc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=loRl4VzjU7KkjY/FilePpbuMBg9m6DnI2n1ygFggux9CnAEn1f4USDH7PQovEptte
 gNWg74bAw8Ga9Z7v1vcQHUjnbfbZ/TTMW4gzerymmHEKtvUI2+695Us5DDa/O0D8q8
 4kt4RPNXqrUBvZMLyLlBv7OPXoj37FH821YOetu0=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230516161447uscas1p1f5f033809ad8d72938fbddcf39b75878~fq84rb4A_0075500755uscas1p1j;
 Tue, 16 May 2023 16:14:47 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id 8F.46.62237.7FBA3646; Tue,
 16 May 2023 12:14:47 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230516161447uscas1p2655c105517bf73bdfc55bb972ed3693f~fq84RFYOj0757807578uscas1p2X;
 Tue, 16 May 2023 16:14:47 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-e8-6463abf732af
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 1B.F1.44215.6FBA3646; Tue,
 16 May 2023 12:14:47 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 16 May 2023 09:14:46 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 16 May 2023 09:14:46 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, Zeng Hao <zenghao@kylinos.cn>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, "Adam
 Manzanares" <a.manzanares@samsung.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, "nmtadam.samsung@gmail.com"
 <nmtadam.samsung@gmail.com>, "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [PATCH 1/2] hw/cxl: cdat: Fix open file not closed in
 ct3_load_cdat()
Thread-Topic: [PATCH 1/2] hw/cxl: cdat: Fix open file not closed in
 ct3_load_cdat()
Thread-Index: AQHZdFQmWtxYf0IZVEaMU8QImtL/669dr7sA
Date: Tue, 16 May 2023 16:14:46 +0000
Message-ID: <20230516161438.GA2139482@bgt-140510-bm03>
In-Reply-To: <20230421132020.7408-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0F519E5BF9774445A55F48224984E11D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+69vb3cWT3UBl7Uf6gsBN3q93IHjpBtJlcxDhNNFrPomnIF
 YkFs7cAlBIxiSFerqJjQWj4USYGCokSpgzoKG2U2moA2pcLEpYsI7ZwG5UPErVzJ+O933vM8
 7/Oc5DCk/FfJCiYn76igy1NrlTRL3frt9f1PJ5s0metrWldxTYMOxDXW+miuu9VLcO9nxiTc
 s/JnBHe17k+Su+QdoTiHfTnXe7qd4tpbjUQayzstw1L+ZE9YwreVzpH8kK+D5oO+mwR/c3yU
 5F+4HtF8hbU4g9nHbs0UtDk/CLp1qd+z2TVXGsn814pCb79fWoI8y4woigG8GUq6H9BGxDJy
 3IDg7VCnVDyUEnC83CRZUI2+OkNHWI6bEdhqtCK/QuC5uEk01COo6J+eF9E4HlzG2/OswBvh
 b/85FBGR+BEJVfY781uX4z0wEhhBomgv1M2YiQWDc8BFGhHDUPhjsIcVkbEMfwaVpU3SCEfh
 NOh+0UZGGOEYmPzdMW8lcSwEgtWEWDoaLls7SJFjYO7OU1rkeHgy+Vwq6lXgr7hAR6JInAod
 40fE8Vqorx0nxdho6KsMUqI1DrrsfiryFMAnosB1bfhD1tdgtV1HIq+Ed8P1RGQnYA00vmTF
 sRaq69o+7EmB2tlrxFmUYFnU2rKokeX/RpZFjSyLGtUgSSOKNej1uVmCflOeUKDSq3P1hrws
 leZw7g3030+7N9ed344CgZcqNyIY5EbAkEqFbLdZkymXZaqP/SjoDh/QGbSC3o1WMpQyVrbh
 iz6NHGepjwqHBCFf0C3cEkzUihJiu4Pb85cpzN1t6ZlNMFegdFoaylr93XmTKeWf20UToeda
 w6nCnl6nacmB5IkY65nQtoK+0ODF91Wss99yI5zh3WvqfGzzFH5TX+n8MiVpSP0gMFA+ebqf
 X79sNKE4aUfcFcWbdjtz/fOi/V0qW/yp5sumI8FqN0eVDWTbBhPXOXz+j1xJhmIzPzURdIeW
 ymcubfHx4RzhDWs9tyq9qirR9SRYRMX0bmFrx9I/iTukfHrVuTGpYw3pKY/rO9i1c8qVLGvw
 nmUfNu0nsn+ZYBRLEzvdXb37pg7eVd5nZ9ifUjMaju3KqDa37HIllw0Mqqdnp7Hnq93BP7zf
 Rh//WUnps9Ub1pA6vfpf6DTX69gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWS2cA0Uff76uQUg9+7WCxW31zDaLFq4TU2
 i8MbzzBZ/P/1itXi+cTnTBZLlzxitphz5gGLxZoVwhbHe3ewWOzY2MXkwOWxc9Zddo+WI29Z
 Pba0/mP2uHNtD5vHk2ubmTw2v37B7PF+31U2j6mz6wM4orhsUlJzMstSi/TtErgyFixexVzw
 VaTizKUb7A2MJ/i7GDk5JARMJF586mcDsYUEVjNKLDyv0cXIBWR/YpR4OKOdCcJZxiixYNth
 sCo2AUWJfV3bwWwRASOJdzcmMYIUMQtcZZY4c/wRM0hCWCBE4sGtB4wQRaES/ztWMcI07Ly8
 D6iGg4NFQFVixVsRkDCvgJnEzNbV7BBXlErMnvQAzOYUcJA4/H4L2EhGATGJ76fWMIHYzALi
 EreezGeC+EBAYsme88wQtqjEy8f/WCFsRYn731+yQ9TrSdyYOoUNZC2zgJ3EnteFEGFtiWUL
 XzNDnCAocXLmExaIVkmJgytusExglJiFZNssJJNmIUyahWTSLCSTFjCyrmIULy0uzk2vKDbK
 Sy3XK07MLS7NS9dLzs/dxAhMCKf/HY7ewXj71ke9Q4xMHIyHGCU4mJVEeAP7klOEeFMSK6tS
 i/Lji0pzUosPMUpzsCiJ876MmhgvJJCeWJKanZpakFoEk2Xi4JRqYGK00Nx9nF1ev4B3Q3Hj
 KuPgTY+ma2zX0tZlrZ2jbLq8TD3xI8OH65s/Pky2LV2jaSwboX0349dEFffjPyPv3AjL6M6r
 lZU0mm291CIx46LoC+4HzhKFr7baf7sqMUckgnFd+/QTPDd5haQFgWFq+WY5+92tieIV3Nqz
 PkjwTq01lj8vVPV+v3tYrmjmD9uHr78fc1L5vqGi29b2l6Fw5dkzW/Q71/d90Hq6IKiccZ69
 avDad+5dE9mdv4gd7vHc8iB7qfx36dKZLdmvhbz3neBJZA4xuW26cXXuvysl/XoLOVbbzrhR
 uT1kp3WyZ/EEwxvs7+qZbv/6oX+jJkiiI93uZVet4xLGyLfKTMeVWIozEg21mIuKEwG4w/9M
 dwMAAA==
X-CMS-MailID: 20230516161447uscas1p2655c105517bf73bdfc55bb972ed3693f
CMS-TYPE: 301P
X-CMS-RootMailID: 20230516161447uscas1p2655c105517bf73bdfc55bb972ed3693f
References: <20230421132020.7408-1-Jonathan.Cameron@huawei.com>
 <20230421132020.7408-2-Jonathan.Cameron@huawei.com>
 <CGME20230516161447uscas1p2655c105517bf73bdfc55bb972ed3693f@uscas1p2.samsung.com>
Received-SPF: pass client-ip=211.189.100.12; envelope-from=fan.ni@samsung.com;
 helo=mailout2.w2.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 21, 2023 at 02:20:19PM +0100, Jonathan Cameron via wrote:
> From: Hao Zeng <zenghao@kylinos.cn>
>=20
> Open file descriptor not closed in error paths. Fix by replace
> open coded handling of read of whole file into a buffer with
> g_file_get_contents()
>=20
> Fixes: aba578bdac ("hw/cxl: CDAT Data Object Exchange implementation")
> Signed-off-by: Zeng Hao <zenghao@kylinos.cn>
> Suggested-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Jonathan Cameron via <qemu-devel@nongnu.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> --
> Changes since v5:
> - Drop if guard on g_free() as per checkpatch warning.
> ---
>  hw/cxl/cxl-cdat.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 137abd0992..056711d63d 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -110,29 +110,18 @@ static void ct3_load_cdat(CDATObject *cdat, Error *=
*errp)
>      g_autofree CDATEntry *cdat_st =3D NULL;
>      uint8_t sum =3D 0;
>      int num_ent;
> -    int i =3D 0, ent =3D 1, file_size =3D 0;
> +    int i =3D 0, ent =3D 1;
> +    gsize file_size =3D 0;
>      CDATSubHeader *hdr;
> -    FILE *fp =3D NULL;
> +    GError *error =3D NULL;
> =20
>      /* Read CDAT file and create its cache */
> -    fp =3D fopen(cdat->filename, "r");
> -    if (!fp) {
> -        error_setg(errp, "CDAT: Unable to open file");
> +    if (!g_file_get_contents(cdat->filename, (gchar **)&cdat->buf,
> +                             &file_size, &error)) {
> +        error_setg(errp, "CDAT: File read failed: %s", error->message);
> +        g_error_free(error);
>          return;
>      }
> -
> -    fseek(fp, 0, SEEK_END);
> -    file_size =3D ftell(fp);
> -    fseek(fp, 0, SEEK_SET);
> -    cdat->buf =3D g_malloc0(file_size);
> -
> -    if (fread(cdat->buf, file_size, 1, fp) =3D=3D 0) {
> -        error_setg(errp, "CDAT: File read failed");
> -        return;
> -    }
> -
> -    fclose(fp);
> -
>      if (file_size < sizeof(CDATTableHeader)) {
>          error_setg(errp, "CDAT: File too short");
>          return;
> @@ -218,7 +207,5 @@ void cxl_doe_cdat_release(CXLComponentState *cxl_csta=
te)
>          cdat->free_cdat_table(cdat->built_buf, cdat->built_buf_len,
>                                cdat->private);
>      }
> -    if (cdat->buf) {
> -        free(cdat->buf);
> -    }
> +    g_free(cdat->buf);
>  }
> --=20
> 2.37.2
>=20
>=20
> =

