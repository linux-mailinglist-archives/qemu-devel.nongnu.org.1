Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAF380489F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 05:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAN7d-0004WQ-Pz; Mon, 04 Dec 2023 23:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1rAN7b-0004W8-J7
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 23:33:23 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1rAN7Y-0002c4-OT
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 23:33:23 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231205043310epoutp04575e9cfa7a2fbb09443bd4a520773940~d1VPGyHbp3071530715epoutp04W
 for <qemu-devel@nongnu.org>; Tue,  5 Dec 2023 04:33:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231205043310epoutp04575e9cfa7a2fbb09443bd4a520773940~d1VPGyHbp3071530715epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1701750790;
 bh=eB6avhzVD9hIk+rPFxZ3z8Q0a6AdrvNV2H+V1Uy0B+M=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=JyRjXz1RSwEr/8bQ03LPy0fGhliMV/i297n3k0HCWGPRBylyYYpZuPK180OX3XVTY
 xL+8gm1FvROrTGugONcyGJx6+s+rFxBsABq0/ZvO3Wswhx7ml3Ph6ZWVCnsQo3HQs1
 GjCeLs1EFs99xYivAGCUCubTEK2fvJEpsyMtSP34=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231205043309epcas2p4cb8e2b3b32add967ca5bb560a76b930c~d1VO01QHq2648926489epcas2p45;
 Tue,  5 Dec 2023 04:33:09 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Sknhh6c7Dz4x9Pp; Tue,  5 Dec
 2023 04:33:08 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-67-656ea804c342
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CB.07.18994.408AE656; Tue,  5 Dec 2023 13:33:08 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH-for-8.2?] hw/ufs: avoid generating the same ID string
 for different LU devices
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 qemu-block <qemu-block@nongnu.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1f537ae8-c3e6-4213-b2c7-b9398b8e1f64@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231205043308epcms2p8388efa83cf97d7c6da3c9bc37e6a9d4e@epcms2p8>
Date: Tue, 05 Dec 2023 13:33:08 +0900
X-CMS-MailID: 20231205043308epcms2p8388efa83cf97d7c6da3c9bc37e6a9d4e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmmS7LirxUgwtrTCxeHehgtFizQthi
 1rt2NovjvTtYHFg8ds66y+5x59oeNo8n1zYzBTBHZdtkpCampBYppOYl56dk5qXbKnkHxzvH
 m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
 pRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnPHt8gqVgHlvFk5lf2RsYp7J2MXJwSAiY
 SPy/JN/FyMUhJLCHUaLx2zSwOK+AoMTfHcIgprBAisS5y5VdjJxAJQoSc7Z1sIPYwgKaEtPX
 T2QCKWETUJc4vdAcJCwiECOx9NgxNhCbWSBL4uOtS8wgtoQAr8SM9qcsELa0xPblWxlBbE4B
 O4l/R7dC1WhI/FjWC2WLStxc/ZYdxn5/bD4jhC0i0XrvLFSNoMSDn7uh4pISp749ZoWwpzNK
 LPhvCvKVhMACRolfzdOhGvQlrnVsBDuCV8BXYs3Dp2ALWARUJXZePsoECREXifOtPhD3y0ts
 fzuHGSTMDPTu+l36EBXKEkdusUBU8El0HP7LDvPhjnlPmCBsFYnFzYehQSwlsWF3KETYQ2L2
 9FfMExgVZyECeRaSVbMQVi1gZF7FKJVaUJybnppsVGCom5daDo/a5PzcTYzgZKflu4Px9fq/
 eocYmTgYDzFKcDArifDOu5WdKsSbklhZlVqUH19UmpNafIjRFOjPicxSosn5wHSbVxJvaGJp
 YGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QDk1iPQ6L3a3+b8n0z12bc+RU5
 h2NGpffhCNljH4ODVme4WjMtFZjJJBM6Y1uX4TPDyIa7C1p9PD7le/OuyTA2839ZL1hlInf0
 OcPG+zUf2Zj5tpf1LP8t9GviDYvXe1e9X5lrdzqix73K+VP8ZlneVeylJ1e7LfbiqVQw3/aw
 mSFyyf7pLyfv3rM0uzQocClH9vKzTFuDxY6ITLPcohWz+M4/gWuvtKTuqXT9nhfiVBuy+4mz
 6/boXZluLVceZmQ+KOk4rXBA9VxtdCr/Zr9tXtO074fz+au1p32a4JnL9kT+5MQmpwjL0gbG
 5vs+Mj+Z/m8Mkdr3lS/lq9wxzYJrF/Lk8hyelsbl/ZFZ9KJZiaU4I9FQi7moOBEA13YTcP8D
 AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231204165101epcas2p3ed3c9102682beb57ceed403189b33ef5
References: <1f537ae8-c3e6-4213-b2c7-b9398b8e1f64@linaro.org>
 <20231204150543.48252-1-akinobu.mita@gmail.com>
 <CGME20231204165101epcas2p3ed3c9102682beb57ceed403189b33ef5@epcms2p8>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout4.samsung.com
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
Reply-To: jeuk20.kim@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 4/12/23 16:05, Akinobu Mita wrote:
> QEMU would not start when trying to create two UFS host controllers and
> a UFS logical unit for each with the following options:
>
> -device ufs,id=bus0 \
> -device ufs-lu,drive=drive1,bus=bus0,lun=0 \
> -device ufs,id=bus1 \
> -device ufs-lu,drive=drive2,bus=bus1,lun=0 \
>
> This is because the same ID string ("0:0:0/scsi-disk") is generated
> for both UFS logical units.
>
> To fix this issue, prepend the parent pci device's path to make
> the ID string unique.
> ("0000:00:03.0/0:0:0/scsi-disk" and "0000:00:04.0/0:0:0/scsi-disk")
>
> Fixes: 096434fea13a ("hw/ufs: Modify lu.c to share codes with SCSI subsystem")
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

Thank you!

