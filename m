Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED69870535A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyxKs-0003QS-8y; Tue, 16 May 2023 12:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1pyxKm-0003JN-Uo
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:15:35 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1pyxKi-0000G4-0M
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:15:29 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20230516161525usoutp01248ba9eaf531d8bc676241e1354ff35e~fq9boFRZA0240702407usoutp01H;
 Tue, 16 May 2023 16:15:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20230516161525usoutp01248ba9eaf531d8bc676241e1354ff35e~fq9boFRZA0240702407usoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1684253725;
 bh=S9ITLPCpE/dPue0KRCyeZd6Ue227rUYGCwJpVfMJFpg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=QxwX4gF87Bo/x0wPu/9/C+zYDXZfNDr/j7oyU6RhocV1cN4ZtcJB8g3LlcZo6ok54
 QbMy0X1a07en1z5aDya75KerJ4Q7gHHDqn8J5xQzqnbbn1Vj1YDyPGn53swwVIoJoC
 BnIsK5utgTZWpuBk88fvyxC6LxW+9NIP+lO3Smlo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230516161525uscas1p23ce43e8b779a3563a5af663e19171dff~fq9bgh6YM0755207552uscas1p2F;
 Tue, 16 May 2023 16:15:25 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id 53.E9.42611.C1CA3646; Tue,
 16 May 2023 12:15:24 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230516161524uscas1p1bba689b7fe90149e8d899b249d04bea0~fq9bKdJ-B0243702437uscas1p1h;
 Tue, 16 May 2023 16:15:24 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-72-6463ac1c0545
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 49.AB.64580.C1CA3646; Tue,
 16 May 2023 12:15:24 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 16 May 2023 09:15:23 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 16 May 2023 09:15:23 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, Zeng Hao <zenghao@kylinos.cn>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, "Adam
 Manzanares" <a.manzanares@samsung.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, "nmtadam.samsung@gmail.com"
 <nmtadam.samsung@gmail.com>, "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [PATCH 2/2] hw/cxl: cdat: Fix failure to free buffer in erorr
 paths
Thread-Topic: [PATCH 2/2] hw/cxl: cdat: Fix failure to free buffer in erorr
 paths
Thread-Index: AQHZdFQtKsjWjVfGuEKvcsMg4GMDpq9dr+yA
Date: Tue, 16 May 2023 16:15:23 +0000
Message-ID: <20230516161523.GB2139482@bgt-140510-bm03>
In-Reply-To: <20230421132020.7408-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <11E9A459FA6C9C44A2F9E87E1CF452E7@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djX87oya5JTDHb8MLNYfXMNo8WqhdfY
 LA5vPMNk8f/XK1aL5xOfM1ksXfKI2WLOmQcsFmtWCFsc793BYrFjYxeTA5fHzll32T1ajrxl
 9djS+o/Z4861PWweT65tZvLY/PoFs8f7fVfZPKbOrg/giOKySUnNySxLLdK3S+DK+L1zIVPB
 Ha2K1q42pgbGTfJdjBwcEgImEr3HWbsYuTiEBFYySiybvYENwmllkng14x5QhhOs6MLeD8wQ
 ibWMEh/eT4Wq+sQosWvKUXYIZxmjxJ9Fu9lAWtgEFCX2dW0Hs0UEjCTe3ZjECFLELHCVWWLe
 il1gc4UFgiQedN9lhCgKlvh2aRMzTMOdNb/BbBYBVYkpJ46D2bwCZhL3J1wEG8op4CDx79YD
 dhCbUUBM4vupNUwgNrOAuMStJ/OZIO4WlFg0ew8zhC0m8W/XQzYIW1Hi/veX7BD1ehI3pk5h
 g7DtJLacvAVla0ssW/gaaq+gxMmZT1ggeiUlDq64wQLyjIRAM6fE58stjBAJF4l9Z25BLZaW
 mL7mMgskhJMlVn3kggjnSMxfsgVqjrXEwj/rmSYwqsxCcvYsJCfNQnLSLCQnzUJy0gJG1lWM
 4qXFxbnpqcVGeanlesWJucWleel6yfm5mxiBqe30v8P5Oxiv3/qod4iRiYPxEKMEB7OSCG9g
 X3KKEG9KYmVValF+fFFpTmrxIUZpDhYlcV5D25PJQgLpiSWp2ampBalFMFkmDk6pBqbab+J/
 qoVvePr8sbXf0nx7NV/IyQNNZze3TIq7ueWRtkH/gnmm7w0S6yI8jb1OLHos6LaswyZjgh/7
 85UajdMjfzq/17eQ+8WT8vGX8S0eTSOGlWFXphfLd1rm5rp7B3V9X5eaE5QrK/nzt8Zi9hcm
 JW0e+0Pcyks6UveeX8flfu7Aac+izcVsa5sbIrQyV9/ItZv48+1Me6OZNVXfHja67Ctbr/Tu
 o8V1/rQk1nn7pnzXuaP7t7DY+tGsTpMXBa/iHh84x/U+tS/G35yhvVh+j7Ti/P02CqapLK96
 BP6luWZvfnZMbhJPk6T0S/++D/VMu7XPv16f8/TR23rNM5L1z0Xr4prYNz8+svDATyWW4oxE
 Qy3mouJEACok9WncAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWS2cA0SVdmTXKKwdnvCharb65htFi18Bqb
 xeGNZ5gs/v96xWrxfOJzJoulSx4xW8w584DFYs0KYYvjvTtYLHZs7GJy4PLYOesuu0fLkbes
 Hlta/zF73Lm2h83jybXNTB6bX79g9ni/7yqbx9TZ9QEcUVw2Kak5mWWpRfp2CVwZv3cuZCq4
 o1XR2tXG1MC4Sb6LkZNDQsBE4sLeD8xdjFwcQgKrGSVOzp0G5XxilJi2uI8dwlnGKLGl7Swj
 SAubgKLEvq7tbCC2iICRxLsbkxhBipgFrjJLnDn+iBkkISwQJPGg+y4jRFGwRMf5g6wwDXfW
 /AarYRFQlZhy4jiYzStgJnF/wkWwoUICpRJzl55mArE5BRwk/t16wA5iMwqISXw/tQYsziwg
 LnHryXwmiB8EJJbsOc8MYYtKvHz8jxXCVpS4//0lO0S9nsSNqVPYIGw7iS0nb0HZ2hLLFr6G
 ukFQ4uTMJywQvZISB1fcYJnAKDELybpZSEbNQjJqFpJRs5CMWsDIuopRvLS4ODe9otg4L7Vc
 rzgxt7g0L10vOT93EyMwMZz+dzhmB+O9Wx/1DjEycTAeYpTgYFYS4Q3sS04R4k1JrKxKLcqP
 LyrNSS0+xCjNwaIkzusROzFeSCA9sSQ1OzW1ILUIJsvEwSnVwGR6+6dysXIs46dvYvX2W5cf
 ZFx6MDD34ozvWu5aK1673F62+e+66NUKlcwpXt26HZVagROm3NecI+z3bo/fqvbZfKsj8/yP
 LJ3oMJHJadnWd6YvJ+zaEZ625e2dmT9nmytu5dH5Hh8YzxBbGJ+VLN6zznnT3tWfu+PjJnHF
 2+7hWH3TdPY19ouFO0+EnhLifih+9uFs13/Tf7mz7/gaJal0/EYed77Huy1/FTYseaIpsVNW
 r4+5cM8m3lM3F/9uYjfNc10Zs95CPuVNCe+ver1A14yjuhFSc6z+CgXpBX8M/6ousOO3Rqim
 863/KofltiQviNQJk/V791CsaLGXmDnLsa18q+LFp/1+eXFdS58SS3FGoqEWc1FxIgA+lUfC
 ewMAAA==
X-CMS-MailID: 20230516161524uscas1p1bba689b7fe90149e8d899b249d04bea0
CMS-TYPE: 301P
X-CMS-RootMailID: 20230516161524uscas1p1bba689b7fe90149e8d899b249d04bea0
References: <20230421132020.7408-1-Jonathan.Cameron@huawei.com>
 <20230421132020.7408-3-Jonathan.Cameron@huawei.com>
 <CGME20230516161524uscas1p1bba689b7fe90149e8d899b249d04bea0@uscas1p1.samsung.com>
Received-SPF: pass client-ip=211.189.100.11; envelope-from=fan.ni@samsung.com;
 helo=mailout1.w2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 21, 2023 at 02:20:20PM +0100, Jonathan Cameron via wrote:
> The failure paths in CDAT file loading did not clear up properly.
> Change to using g_auto_free and a local pointer for the buffer to
> ensure this function has no side effects on error.
> Also drop some unnecessary checks that can not fail.
>=20
> Cleanup properly after a failure to load a CDAT file.
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-cdat.c            | 33 ++++++++++++++++++---------------
>  hw/mem/cxl_type3.c           |  4 ++++
>  hw/pci-bridge/cxl_upstream.c |  3 +++
>  3 files changed, 25 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 056711d63d..d246d6885b 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -108,6 +108,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **=
errp)
>  static void ct3_load_cdat(CDATObject *cdat, Error **errp)
>  {
>      g_autofree CDATEntry *cdat_st =3D NULL;
> +    g_autofree char *buf =3D NULL;
>      uint8_t sum =3D 0;
>      int num_ent;
>      int i =3D 0, ent =3D 1;
> @@ -116,7 +117,7 @@ static void ct3_load_cdat(CDATObject *cdat, Error **e=
rrp)
>      GError *error =3D NULL;
> =20
>      /* Read CDAT file and create its cache */
> -    if (!g_file_get_contents(cdat->filename, (gchar **)&cdat->buf,
> +    if (!g_file_get_contents(cdat->filename, (gchar **)&buf,
>                               &file_size, &error)) {
>          error_setg(errp, "CDAT: File read failed: %s", error->message);
>          g_error_free(error);
> @@ -129,9 +130,17 @@ static void ct3_load_cdat(CDATObject *cdat, Error **=
errp)
>      i =3D sizeof(CDATTableHeader);
>      num_ent =3D 1;
>      while (i < file_size) {
> -        hdr =3D (CDATSubHeader *)(cdat->buf + i);
> +        hdr =3D (CDATSubHeader *)(buf + i);
> +        if (i + sizeof(CDATSubHeader) > file_size) {
> +            error_setg(errp, "CDAT: Truncated table");
> +            return;
> +        }
>          cdat_len_check(hdr, errp);
>          i +=3D hdr->length;
> +        if (i > file_size) {
> +            error_setg(errp, "CDAT: Truncated table");
> +            return;
> +        }
>          num_ent++;
>      }
>      if (i !=3D file_size) {
> @@ -139,33 +148,26 @@ static void ct3_load_cdat(CDATObject *cdat, Error *=
*errp)
>          return;
>      }
> =20
> -    cdat_st =3D g_malloc0(sizeof(*cdat_st) * num_ent);
> -    if (!cdat_st) {
> -        error_setg(errp, "CDAT: Failed to allocate entry array");
> -        return;
> -    }
> +    cdat_st =3D g_new0(CDATEntry, num_ent);
> =20
>      /* Set CDAT header, Entry =3D 0 */
> -    cdat_st[0].base =3D cdat->buf;
> +    cdat_st[0].base =3D buf;
>      cdat_st[0].length =3D sizeof(CDATTableHeader);
>      i =3D 0;
> =20
>      while (i < cdat_st[0].length) {
> -        sum +=3D cdat->buf[i++];
> +        sum +=3D buf[i++];
>      }
> =20
>      /* Read CDAT structures */
>      while (i < file_size) {
> -        hdr =3D (CDATSubHeader *)(cdat->buf + i);
> -        cdat_len_check(hdr, errp);
> -
> +        hdr =3D (CDATSubHeader *)(buf + i);
>          cdat_st[ent].base =3D hdr;
>          cdat_st[ent].length =3D hdr->length;
> =20
> -        while (cdat->buf + i <
> -               (uint8_t *)cdat_st[ent].base + cdat_st[ent].length) {
> +        while (buf + i < (char *)cdat_st[ent].base + cdat_st[ent].length=
) {
>              assert(i < file_size);
> -            sum +=3D cdat->buf[i++];
> +            sum +=3D buf[i++];
>          }
> =20
>          ent++;
> @@ -176,6 +178,7 @@ static void ct3_load_cdat(CDATObject *cdat, Error **e=
rrp)
>      }
>      cdat->entry_len =3D num_ent;
>      cdat->entry =3D g_steal_pointer(&cdat_st);
> +    cdat->buf =3D g_steal_pointer(&buf);
>  }
> =20
>  void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index abe60b362c..7647122cc6 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -593,6 +593,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **e=
rrp)
>      cxl_cstate->cdat.free_cdat_table =3D ct3_free_cdat_table;
>      cxl_cstate->cdat.private =3D ct3d;
>      cxl_doe_cdat_init(cxl_cstate, errp);
> +    if (*errp) {
> +        goto err_free_special_ops;
> +    }
> =20
>      pcie_cap_deverr_init(pci_dev);
>      /* Leave a bit of room for expansion */
> @@ -605,6 +608,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **e=
rrp)
> =20
>  err_release_cdat:
>      cxl_doe_cdat_release(cxl_cstate);
> +err_free_special_ops:
>      g_free(regs->special_ops);
>  err_address_space_free:
>      address_space_destroy(&ct3d->hostmem_as);
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 9df436cb73..ef47e5d625 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -346,6 +346,9 @@ static void cxl_usp_realize(PCIDevice *d, Error **err=
p)
>      cxl_cstate->cdat.free_cdat_table =3D free_default_cdat_table;
>      cxl_cstate->cdat.private =3D d;
>      cxl_doe_cdat_init(cxl_cstate, errp);
> +    if (*errp) {
> +        goto err_cap;
> +    }
> =20
>      return;
> =20
> --=20
> 2.37.2
>=20
>=20
> =

