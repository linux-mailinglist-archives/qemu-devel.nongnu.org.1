Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE987A4FB3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHQk-0008VK-JU; Mon, 18 Sep 2023 12:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiHQi-0008Ui-Q2
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:49:00 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiHQa-0004mT-6m
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:49:00 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230918164846usoutp02e80e0c862fd7a3cb28bc0b2aa061b123~GDDPdwlCp0498904989usoutp025;
 Mon, 18 Sep 2023 16:48:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230918164846usoutp02e80e0c862fd7a3cb28bc0b2aa061b123~GDDPdwlCp0498904989usoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1695055726;
 bh=shmBaHiVOVZa3ItvXY0JPmIRPpY+fJBo7n+JJv2KX74=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Ukq+jIhlFcS+BzHoy7tMvF5kvVpVH41OIOLl/vzvhXmc1O85Ch8USFGsVrg9j+HHZ
 BjjnYvQ6Ppu1hmBKbG2afTc8cw5Pk613iVOUFFI3kMQ494VY/UHBT2kpg/84p6zP3p
 omeC1IaYkqF8/6bH4m3LlH+BWNxLKyojZI9rcNPc=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230918164846uscas1p127e7d48e9bfeb939759a52328fd38c73~GDDPWsaMS3185331853uscas1p1g;
 Mon, 18 Sep 2023 16:48:46 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id B4.31.40279.E6F78056; Mon,
 18 Sep 2023 12:48:46 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230918164846uscas1p2870a2837b0359d0933ae0338fc004c76~GDDO8KCyu0546005460uscas1p2F;
 Mon, 18 Sep 2023 16:48:46 +0000 (GMT)
X-AuditID: cbfec36f-241ff70000009d57-8f-65087f6e8903
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 11.F3.28590.D6F78056; Mon,
 18 Sep 2023 12:48:45 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Mon, 18 Sep 2023 09:48:45 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
 18 Sep 2023 09:48:45 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2 4/4] hw/cxl: Line length reductions
Thread-Topic: [PATCH v2 4/4] hw/cxl: Line length reductions
Thread-Index: AQHZ5/b4iRU+wvqh40y8tLg81n60brAhRWMA
Date: Mon, 18 Sep 2023 16:48:45 +0000
Message-ID: <20230918164844.GB3331103@sjcvldevvm72>
In-Reply-To: <20230915170418.21337-5-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5179E97EF135024F997C6AC02403F1F5@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djXc7p59RypBrv/SVisWniNzeLwxjNM
 Fk/+fWe0+P/rFavFmhXCFsd7d7A4sHm0HHnL6nHn2h42jyfXNjN5vN93lc1jwtSlLAGsUVw2
 Kak5mWWpRfp2CVwZ12+vYS+Y1cFYcf1tO0sD44KkLkZODgkBE4nLiz4ydjFycQgJrGSU+H7y
 HpTTyiQxa/ZZli5GDrCq6fcDIOJrGSVuv+5hhXA+MUpcOfaaBcJZxihxfPp+dpC5bAKKEvu6
 trOB2CICRhLvbkwCG8ss8JJR4uvtu2AJYQEriWUv9rBDFFlL/PryHq7h3Jo9TCA2i4CqxPYL
 D8BqeAWMJY4fWQRWwyngKPHq7WdWEJtRQEzi+6k1YPXMAuISt57MZ4J4TlBi0ew9zBC2mMS/
 XQ/ZIGxFifvfX7JD1OtJ3Jg6hQ3CtpM43doNNUdbYtnC18wQewUlTs58wgLRKylxcMUNsI8l
 BM5wSFye8xAq4SLx4+41qGXSElevT2WGhF2yxKqPXBDhHIn5S7ZAlVtLLPyznmkCo8osJGfP
 QnLSLCQnzUJy0iwkJy1gZF3FKF5aXJybnlpslJdarlecmFtcmpeul5yfu4kRmJhO/zucv4Px
 +q2PeocYmTgYDzFKcDArifDONGRLFeJNSaysSi3Kjy8qzUktPsQozcGiJM5raHsyWUggPbEk
 NTs1tSC1CCbLxMEp1cC0i5eFUfJ6+0V/+6wlB46d5P3TeX2LTe2f4Prtl2vNks3nmDdLXPNb
 fD/Tduo20e7vP5mU4orqS17/cQxLTfNoK1gYFPZLMri69Nc0vaK6DWWmHeskFvpwp9eFr97U
 /X3+pE3lIbMy8/Q0F7wVduXIvXpPvnXhiaPHDr44s0i4i3/+ZS5F9xsfU1xuuyfP63kvzDq1
 44Mrz+46/1v7za0dd+cxHjsS8WrVyqC9mdO+t7q2F5lJzf+u+i2F7eulwE+Chl2qprsLxS9V
 7NmrVaW2g/nRjpI3sb8euBtxfyxi4Cq/5qMXyK5gsKhEsfH8d/Ecsxkbv1xpbLqvdWDZ8n/b
 XzAXPtWu0ZqtEHOwrUaJpTgj0VCLuag4EQCl0Q3muwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWS2cA0STe3niPV4P4eK4tVC6+xWRzeeIbJ
 4sm/74wW/3+9YrVYs0LY4njvDhYHNo+WI29ZPe5c28Pm8eTaZiaP9/uusnlMmLqUJYA1issm
 JTUnsyy1SN8ugSvj+u017AWzOhgrrr9tZ2lgXJDUxcjBISFgIjH9fkAXIxeHkMBqRomlLe/Y
 IJxPjBJbjn5ihHCWMUqs/LgLyOHkYBNQlNjXtZ0NxBYRMJJ4d2MSWBGzwEtGia+374IlhAWs
 JJa92MMOUWQt8evLe7iGc2v2MIHYLAKqEtsvPACr4RUwljh+ZBHU6tOMEp29H8G2cQo4Srx6
 +5kVxGYUEJP4fmoNWDOzgLjErSfzwWwJAQGJJXvOM0PYohIvH/9jhbAVJe5/f8kOUa8ncWPq
 FDYI207idGs31BxtiWULXzNDHCEocXLmExaIXkmJgytusExglJiFZN0sJKNmIRk1C8moWUhG
 LWBkXcUoXlpcnJteUWyYl1quV5yYW1yal66XnJ+7iREY16f/HY7cwXj01ke9Q4xMHIyHGCU4
 mJVEeGcasqUK8aYkVlalFuXHF5XmpBYfYpTmYFES590x5WKKkEB6YklqdmpqQWoRTJaJg1Oq
 gWmz5/QUVq93PvzAmL9wuPaZo95UA3lGztM+zfKJ1/paTwt4vy5fkf1uMaeTe7FfXeDG/erL
 +P5FHzovLlPWEWcsonLh2d03t6OmNG46+vayyszsNX+fNaeuSZN7pC7PdiHj/A4RNZ9Josum
 Kc3OObbnzoqn+gzz5KfkLIht2X4o70nKssT0t/13Ln1KbeNsTVU+XWJhlixsaJn24CeT28Zy
 XaG70mpPhX/NCNmlq/9DzOtvqFB9oqaf0Ffl+/p1fcufStTdsW70TK5+41+SrZOp94xFYOv+
 s5ufS1yOfzc3iD9G0cVEyHvnuZCW/jV/5zT1znutnn4o9Jmy5pszj2rC8k+d5eaY11wa/3mf
 EktxRqKhFnNRcSIA18HWIloDAAA=
X-CMS-MailID: 20230918164846uscas1p2870a2837b0359d0933ae0338fc004c76
CMS-TYPE: 301P
X-CMS-RootMailID: 20230915170627uscas1p1fc329ca937e09b2953d2b243fb88e07e
References: <20230915170418.21337-1-Jonathan.Cameron@huawei.com>
 <CGME20230915170627uscas1p1fc329ca937e09b2953d2b243fb88e07e@uscas1p1.samsung.com>
 <20230915170418.21337-5-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=211.189.100.12; envelope-from=fan.ni@samsung.com;
 helo=mailout2.w2.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 15, 2023 at 06:04:18PM +0100, Jonathan Cameron wrote:
> Michael Tsirkin observed that there were some unnecessarily
> long lines in the CXL code in a recent review.
> This patch is intended to rectify that where it does not
> hurt readability.
>=20
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

One minor comment inline. Other than that, looks good to me.


>  include/hw/cxl/cxl_component.h |  3 ++-
>  include/hw/cxl/cxl_device.h    |  5 +++--
>  include/hw/cxl/cxl_events.h    |  3 ++-
>  hw/cxl/cxl-cdat.c              |  3 ++-
>  hw/cxl/cxl-component-utils.c   | 10 ++++++----
>  hw/cxl/cxl-events.c            |  9 ++++++---
>  hw/cxl/cxl-mailbox-utils.c     | 21 ++++++++++++++-------
>  hw/mem/cxl_type3.c             | 31 +++++++++++++++++++------------
>  hw/mem/cxl_type3_stubs.c       |  5 +++--
>  9 files changed, 57 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index 3c795a6278..e52dd8d2b9 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -175,7 +175,8 @@ HDM_DECODER_INIT(3);
>      (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
>  #define CXL_SNOOP_REGISTERS_SIZE   0x8
> =20
> -QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZ=
E) >=3D 0x1000,
> +QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
> +                    CXL_SNOOP_REGISTERS_SIZE) >=3D 0x1000,
>                     "No space for registers");
> =20
>  typedef struct component_registers {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 51cd0d9ce3..007ddaf078 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -192,7 +192,7 @@ void cxl_device_register_init_common(CXLDeviceState *=
dev);
>   * Documented as a 128 bit register, but 64 bit accesses and the second
>   * 64 bits are currently reserved.
>   */
> -REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byt=
e accesses */
> +REG64(CXL_DEV_CAP_ARRAY, 0)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
> @@ -361,7 +361,8 @@ struct CXLType3Class {
>                          uint64_t offset);
>      void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset);
> -    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_=
t *data);
> +    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset,
> +                          uint8_t *data);
>  };
> =20
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *dat=
a,
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 089ba2091f..d778487b7e 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -92,7 +92,8 @@ typedef enum CXLEventIntMode {
>      CXL_INT_RES      =3D 0x03,
>  } CXLEventIntMode;
>  #define CXL_EVENT_INT_MODE_MASK 0x3
> -#define CXL_EVENT_INT_SETTING(vector) ((((uint8_t)vector & 0xf) << 4) | =
CXL_INT_MSI_MSIX)
> +#define CXL_EVENT_INT_SETTING(vector) \
> +    ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
>  typedef struct CXLEventInterruptPolicy {
>      uint8_t info_settings;
>      uint8_t warn_settings;
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index d246d6885b..639a2db3e1 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -60,7 +60,8 @@ static void ct3_build_cdat(CDATObject *cdat, Error **er=
rp)
>          return;
>      }
> =20
> -    cdat->built_buf_len =3D cdat->build_cdat_table(&cdat->built_buf, cda=
t->private);
> +    cdat->built_buf_len =3D cdat->build_cdat_table(&cdat->built_buf,
> +                                                 cdat->private);
> =20
>      if (!cdat->built_buf_len) {
>          /* Build later as not all data available yet */
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index c8d632d540..915c208209 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -240,7 +240,8 @@ static void hdm_init_common(uint32_t *reg_state, uint=
32_t *write_msk,
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT=
, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_2=
56B, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4=
K, 1);
> -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, POISON_ON_ER=
R_CAP, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     POISON_ON_ERR_CAP, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
>                       HDM_DECODER_ENABLE, 0);
>      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] =3D 0x3;
> @@ -263,13 +264,14 @@ static void hdm_init_common(uint32_t *reg_state, ui=
nt32_t *write_msk,
>      }
>  }
> =20
> -void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *w=
rite_msk,
> +void cxl_component_register_init_common(uint32_t *reg_state,
> +                                        uint32_t *write_msk,
>                                          enum reg_type type)
>  {
>      int caps =3D 0;
> =20
>      /*
> -     * In CXL 2.0 the capabilities required for each CXL component are s=
uch that,
> +     * In CXL2.0 the capabilities required for each CXL component are su=
ch that,

It seems we always leave a space between CXL and 2.0 in other
places.

Fan

>       * with the ordering chosen here, a single number can be used to def=
ine
>       * which capabilities should be provided.
>       */
> @@ -448,7 +450,7 @@ void cxl_component_create_dvsec(CXLComponentState *cx=
l,
>          default: /* Registers are RO for other component types */
>              break;
>          }
> -        /* There are rw1cs bits in the status register but never set cur=
rently */
> +        /* There are rw1cs bits in the status register but never set */
>          break;
>      }
> =20
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index d161d57456..10a4531904 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -170,8 +170,10 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxl=
ds, CXLGetEventPayload *pl,
>      if (log->overflow_err_count) {
>          pl->flags |=3D CXL_GET_EVENT_FLAG_OVERFLOW;
>          pl->overflow_err_count =3D cpu_to_le16(log->overflow_err_count);
> -        pl->first_overflow_timestamp =3D cpu_to_le64(log->first_overflow=
_timestamp);
> -        pl->last_overflow_timestamp =3D cpu_to_le64(log->last_overflow_t=
imestamp);
> +        pl->first_overflow_timestamp =3D
> +            cpu_to_le64(log->first_overflow_timestamp);
> +        pl->last_overflow_timestamp =3D
> +            cpu_to_le64(log->last_overflow_timestamp);
>      }
> =20
>      pl->record_count =3D cpu_to_le16(nr);
> @@ -180,7 +182,8 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxld=
s, CXLGetEventPayload *pl,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventP=
ayload *pl)
> +CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
> +                                   CXLClearEventPayload *pl)
>  {
>      CXLEventLog *log;
>      uint8_t log_type;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 02f9b5a870..3977af23f1 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -366,9 +366,12 @@ static CXLRetCode cmd_identify_memory_device(struct =
cxl_cmd *cmd,
> =20
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
> =20
> -    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MU=
LTIPLIER);
> -    stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPAC=
ITY_MULTIPLIER);
> -    stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACIT=
Y_MULTIPLIER);
> +    stq_le_p(&id->total_capacity,
> +             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->persistent_capacity,
> +             cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->volatile_capacity,
> +             cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
>      /* 256 poison records */
>      st24_le_p(id->poison_list_max_mer, 256);
> @@ -396,13 +399,15 @@ static CXLRetCode cmd_ccls_get_partition_info(struc=
t cxl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
> =20
> -    stq_le_p(&part_info->active_vmem, cxl_dstate->vmem_size / CXL_CAPACI=
TY_MULTIPLIER);
> +    stq_le_p(&part_info->active_vmem,
> +             cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      /*
>       * When both next_vmem and next_pmem are 0, there is no pending chan=
ge to
>       * partitioning.
>       */
>      stq_le_p(&part_info->next_vmem, 0);
> -    stq_le_p(&part_info->active_pmem, cxl_dstate->pmem_size / CXL_CAPACI=
TY_MULTIPLIER);
> +    stq_le_p(&part_info->active_pmem,
> +             cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&part_info->next_pmem, 0);
> =20
>      *len =3D sizeof(*part_info);
> @@ -681,8 +686,10 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
>      [FIRMWARE_UPDATE][GET_INFO] =3D { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
>      [TIMESTAMP][GET] =3D { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> -    [TIMESTAMP][SET] =3D { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDI=
ATE_POLICY_CHANGE },
> -    [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED", cmd_logs_get_suppo=
rted, 0, 0 },
> +    [TIMESTAMP][SET] =3D { "TIMESTAMP_SET", cmd_timestamp_set,
> +                         8, IMMEDIATE_POLICY_CHANGE },
> +    [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED", cmd_logs_get_suppo=
rted,
> +                              0, 0 },
>      [LOGS][GET_LOG] =3D { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>      [IDENTIFY][MEMORY_DEVICE] =3D { "IDENTIFY_MEMORY_DEVICE",
>          cmd_identify_memory_device, 0, 0 },
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 1658e0cc59..c5855d4e7d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -197,10 +197,9 @@ static int ct3_build_cdat_table(CDATSubHeader ***cda=
t_table, void *priv)
>      }
> =20
>      if (nonvolatile_mr) {
> +        uint64_t base =3D volatile_mr ? memory_region_size(volatile_mr) =
: 0;
>          rc =3D ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_ha=
ndle++,
> -                                           nonvolatile_mr, true,
> -                                           (volatile_mr ?
> -                                            memory_region_size(volatile_=
mr) : 0));
> +                                           nonvolatile_mr, true, base);
>          if (rc < 0) {
>              goto error_cleanup;
>          }
> @@ -503,7 +502,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offse=
t, uint64_t value,
>      case A_CXL_RAS_UNC_ERR_STATUS:
>      {
>          uint32_t capctrl =3D ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL=
);
> -        uint32_t fe =3D FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL, FIRST_=
ERROR_POINTER);
> +        uint32_t fe =3D FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                                 FIRST_ERROR_POINTER);
>          CXLError *cxl_err;
>          uint32_t unc_err;
> =20
> @@ -522,7 +522,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offse=
t, uint64_t value,
>                   * closest to behavior of hardware not capable of multip=
le
>                   * header recording.
>                   */
> -                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node, cx=
l_next) {
> +                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node,
> +                                    cxl_next) {
>                      if ((1 << cxl_err->type) & value) {
>                          QTAILQ_REMOVE(&ct3d->error_list, cxl_err, node);
>                          g_free(cxl_err);
> @@ -1061,7 +1062,8 @@ void qmp_cxl_inject_poison(const char *path, uint64=
_t start, uint64_t length,
>          if (((start >=3D p->start) && (start < p->start + p->length)) ||
>              ((start + length > p->start) &&
>               (start + length <=3D p->start + p->length))) {
> -            error_setg(errp, "Overlap with existing poisoned region not =
supported");
> +            error_setg(errp,
> +                       "Overlap with existing poisoned region not suppor=
ted");
>              return;
>          }
>      }
> @@ -1074,7 +1076,8 @@ void qmp_cxl_inject_poison(const char *path, uint64=
_t start, uint64_t length,
>      p =3D g_new0(CXLPoison, 1);
>      p->length =3D length;
>      p->start =3D start;
> -    p->type =3D CXL_POISON_TYPE_INTERNAL; /* Different from injected via=
 the mbox */
> +    /* Different from injected via the mbox */
> +    p->type =3D CXL_POISON_TYPE_INTERNAL;
> =20
>      QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
>      ct3d->poison_list_cnt++;
> @@ -1211,7 +1214,8 @@ void qmp_cxl_inject_correctable_error(const char *p=
ath, CxlCorErrorType type,
>          return;
>      }
>      /* If the error is masked, nothting to do here */
> -    if (!((1 << cxl_err_type) & ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_=
MASK))) {
> +    if (!((1 << cxl_err_type) &
> +          ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK))) {
>          return;
>      }
> =20
> @@ -1361,7 +1365,8 @@ void qmp_cxl_inject_dram_event(const char *path, Cx=
lEventLog log, uint8_t flags,
>                                 bool has_bank, uint8_t bank,
>                                 bool has_row, uint32_t row,
>                                 bool has_column, uint16_t column,
> -                               bool has_correction_mask, uint64List *cor=
rection_mask,
> +                               bool has_correction_mask,
> +                               uint64List *correction_mask,
>                                 Error **errp)
>  {
>      Object *obj =3D object_resolve_path(path, NULL);
> @@ -1462,7 +1467,7 @@ void qmp_cxl_inject_memory_module_event(const char =
*path, CxlEventLog log,
>                                          int16_t temperature,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_erro=
r_count,
> -                                        uint32_t corrected_persistent_er=
ror_count,
> +                                        uint32_t corrected_persist_error=
_count,
>                                          Error **errp)
>  {
>      Object *obj =3D object_resolve_path(path, NULL);
> @@ -1502,8 +1507,10 @@ void qmp_cxl_inject_memory_module_event(const char=
 *path, CxlEventLog log,
>      module.life_used =3D life_used;
>      stw_le_p(&module.temperature, temperature);
>      stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
> -    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_=
error_count);
> -    stl_le_p(&module.corrected_persistent_error_count, corrected_persist=
ent_error_count);
> +    stl_le_p(&module.corrected_volatile_error_count,
> +             corrected_volatile_error_count);
> +    stl_le_p(&module.corrected_persistent_error_count,
> +             corrected_persist_error_count);
> =20
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) =
{
>          cxl_event_irq_assert(ct3d);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index f3e4a9fa72..56d60b4fd8 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -23,7 +23,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEve=
ntLog log, uint8_t flags,
>                                 bool has_bank, uint8_t bank,
>                                 bool has_row, uint32_t row,
>                                 bool has_column, uint16_t column,
> -                               bool has_correction_mask, uint64List *cor=
rection_mask,
> +                               bool has_correction_mask,
> +                               uint64List *correction_mask,
>                                 Error **errp) {}
> =20
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog lo=
g,
> @@ -35,7 +36,7 @@ void qmp_cxl_inject_memory_module_event(const char *pat=
h, CxlEventLog log,
>                                          int16_t temperature,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_erro=
r_count,
> -                                        uint32_t corrected_persistent_er=
ror_count,
> +                                        uint32_t corrected_persist_error=
_count,
>                                          Error **errp) {}
> =20
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t le=
ngth,
> --=20
> 2.39.2
> =

