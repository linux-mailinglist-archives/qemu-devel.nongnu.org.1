Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DE77283E
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1b6-0001RW-DK; Mon, 07 Aug 2023 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1qT1b1-0001Qh-Ng
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:52:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.dzieciol@partner.samsung.com>)
 id 1qT1aw-0005EN-1v
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:52:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230807145220euoutp021a275a5f571c077f0410f4983afc4036~5IXlStFud2209422094euoutp026
 for <qemu-devel@nongnu.org>; Mon,  7 Aug 2023 14:52:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230807145220euoutp021a275a5f571c077f0410f4983afc4036~5IXlStFud2209422094euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1691419940;
 bh=ET8p61JLYi16g0Nmy8HtYEPZzEUufGPsN68IuRu36uM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=aFNdg0+HuCoMJEdDKUNcNRUQkxqmWxF388SLyx4BlPLxEQVyDci+zkS8DAr/upJJI
 Ia5Qo/j+jxDeSzRa967z+bUzpVUdLsdC88gqissIPHRKIeGLDhH6HpE637QaK7dBHZ
 Jsp3+z3QwKJbHeg+Et2kIUZP8bKMr5ZhmTiQNru8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230807145219eucas1p2816439c8fb5a5d0e750236ebfa0da715~5IXk8izFq1195711957eucas1p23;
 Mon,  7 Aug 2023 14:52:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id CB.99.11320.32501D46; Mon,  7
 Aug 2023 15:52:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20230807145218eucas1p2fcddd593c963ea1d08cdbeb0b525d757~5IXkV2o--2115221152eucas1p27;
 Mon,  7 Aug 2023 14:52:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230807145218eusmtrp2cd119befa5a7368b98628dcc5a97a22f~5IXkVTOrO1517215172eusmtrp2i;
 Mon,  7 Aug 2023 14:52:18 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-03-64d1052395bc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 13.CD.10549.22501D46; Mon,  7
 Aug 2023 15:52:18 +0100 (BST)
Received: from AMDN5139 (unknown [106.210.135.112]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20230807145218eusmtip17cdffb9d7a9bde712fcb8fbf41b8b084~5IXj2DZt-1828518285eusmtip1a;
 Mon,  7 Aug 2023 14:52:18 +0000 (GMT)
From: "Tomasz Dzieciol/VIM Integration \(NC\) /SRPOL/Engineer/Samsung
 Electronics" <t.dzieciol@partner.samsung.com>
To: "'Akihiko Odaki'" <akihiko.odaki@daynix.com>, <qemu-devel@nongnu.org>
Cc: <sriram.yagnaraman@est.tech>, <jasowang@redhat.com>,
 <k.kwiecien@samsung.com>, <m.sochacki@samsung.com>
In-Reply-To: <7f1ea2a7-aef1-f090-01ab-218747b167c6@daynix.com>
Subject: RE: [PATCH v10 0/7] igb: packet-split descriptors support
Date: Mon, 7 Aug 2023 16:52:17 +0200
Message-ID: <000201d9c93e$c36323f0$4a296bd0$@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: pl
Thread-Index: AQFQQwJuFg0rRZptX9p0sOFXSIx5ggIQh+nQAeUV6e2w0koHQA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87rKrBdTDDYsl7X4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFFc
 NimpOZllqUX6dglcGU/nn2Uu2MtXsXyFfAPjE+4uRk4OCQETiS8XLrJ3MXJxCAmsYJRobv7C
 CuF8YZRYtOM5M4TzmVGitfUUG0zLj8VtUFXLGSU2/3wAVfWCUeLvpyWsIFVsAqUSC7sPMoHY
 IgKeEg9vbGcHsZkFciXuPX3J0sXIwcEpYCex7k41SFhYwEni1OVFLCA2i4CKxJLbzWBjeAUc
 JfZ+fMYIYQtKnJz5hAVijLbEsoWvmSEOUpD4+XQZK0RcROLGoxZGiLVOEsduzAS7TULgAYfE
 qh3fWUH2Sgi4SPx7rgjRKyzx6vgWdghbRuL/zvlMEHYzo0TPJRGI3h5GiUf9p6AS1hLL74OC
 hQNomabE+l36EGFHiRUPbzFCjOeTuPFWEOIcPolJ26YzQ4R5JTrahCCqdSS+bZrJNoFReRaS
 x2YheWwWkmdmIexawMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDtnP53/MsOxuWv
 PuodYmTiYDzEKMHBrCTCO+/J+RQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2J5OFBNITS1Kz
 U1MLUotgskwcnFINTGZPfxg/r8haGuqdpe90oly0SW2X6d8Jm1jne66pnT47lz3e3j+iwemU
 h9V503dr/l7QzawXMt6cs3Lz0bf7pstyi1657CkgLn/o6Qv3ffc4T/YVKFxezxUUwXHf1zny
 3dQdL9rdKlouyP8z7rJtfb/2oGTOu+2f5p7wv67OLV9k8k5mWuGUXjXbpx+zq0/OnTz1gOH+
 vi/TZmhydl7cJ7Xk25oLtbseORmtXLJ4qnCtmXPD+V+S3+pZeGz+S5Z8rVjG/vjKAfdDnv+F
 c9yyGB7UZp1nrq9wveo+oe/NsqcXrSz91ihUnf3K+zUtNn5ex7vri1oLy2tFpDcVCUQKvXUQ
 NXP/fiF8k0hFwDQ3eyWW4oxEQy3mouJEAB5B/juqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7pKrBdTDPY/Nrf4fGotu8WyS5+Z
 LBrnz2G12Hr1B7vF8d4dLBa9m14wObB5nHh7kNXjwqNzzB5Prm1m8ni/7yqbR9+WVYwBrFF6
 NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GafO32Ar
 mMdXce3QTPYGxsPcXYycHBICJhI/FrexdjFycQgJLGWUmD1xKxNEQkpiX89/dghbWOLPtS42
 iKJnjBLzb2xlAUmwCRRLbLzRxghiiwh4S7xff4wZxGYWKJRYdPw8C0TDMUaJq9c+AyU4ODgF
 7CTW3akGqREWcJI4dXkR2BwWARWJJbebWUFsXgFHib0fnzFC2IISJ2c+YYGYqS3R+7CVEcZe
 tvA1M8RxChI/ny5jhYiLSNx41AJ1j5PEsRszmScwCs9CMmoWklGzkIyahaR9ASPLKkaR1NLi
 3PTcYkO94sTc4tK8dL3k/NxNjMAo3Hbs5+YdjPNefdQ7xMjEwXiIUYKDWUmEd96T8ylCvCmJ
 lVWpRfnxRaU5qcWHGE2BfpvILCWanA9MA3kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp
 2ampBalFMH1MHJxSDUwOklOUPAW9ns8J+NC5LS109mz9K6KvC/1DBfSUeDSauja8UHD8t/us
 uex997ebf5S9y9rc+ulY5c2+fey102bOPavQInRwVnnjbKvDJkcf2zAeP32lTTI+xOGyy7LT
 MrKzb4TN3rTt1sbTWRH7Z2lJNhq+XiO5rmrjuuXJLowXbHaq1bZkP9/5caV4fZlZTZd34mrO
 nR22J4M76u46fI4xqf4koftaSGtH1HF1nfWb1pkftAx64TN5sX6RiuuNtzsyH7vobt2s3Djt
 784jeyoneL+LOcH5fNpm0Sv/X3lflFBztrG4r1nKVF1pKLKN69xB/cXbe6Ievav+NsFJjlNd
 RD/azT7Drlw3a0WT5QklluKMREMt5qLiRADUSYfNSwMAAA==
X-CMS-MailID: 20230807145218eucas1p2fcddd593c963ea1d08cdbeb0b525d757
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f
References: <CGME20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f@eucas1p1.samsung.com>
 <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
 <7f1ea2a7-aef1-f090-01ab-218747b167c6@daynix.com>
Received-SPF: none client-ip=210.118.77.12;
 envelope-from=t.dzieciol@partner.samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 PDS_BAD_THREAD_QP_64=0.999, RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

It's been a while since review was done and nothing happened with those pat=
ches since then.

As I understand from guide: https://www.qemu.org/docs/master/devel/submitti=
ng-a-patch.html=23is-my-patch-in I should wait. Is that correct?

-----Original Message-----
From: Akihiko Odaki <akihiko.odaki=40daynix.com>=20
Sent: wtorek, 30 maja 2023 04:49
To: Tomasz Dzieciol <t.dzieciol=40partner.samsung.com>; qemu-devel=40nongnu=
.org
Cc: sriram.yagnaraman=40est.tech; jasowang=40redhat.com; k.kwiecien=40samsu=
ng.com; m.sochacki=40samsung.com
Subject: Re: =5BPATCH v10 0/7=5D igb: packet-split descriptors support

On 2023/05/29 23:01, Tomasz Dzieciol wrote:
> Purposes of this series of patches:
> * introduce packet-split RX descriptors support. This feature is used by =
Linux
>    VF driver for MTU values from 2048.
> * refactor RX descriptor handling for introduction of packet-split RX
>    descriptors support
> * fix descriptors flags handling
>=20
> Tomasz Dzieciol (7):
>    igb: remove TCP ACK detection
>    igb: rename E1000E_RingInfo_st
>    igb: RX descriptors guest writting refactoring
>    igb: RX payload guest writting refactoring
>    igb: add IPv6 extended headers traffic detection
>    igb: packet-split descriptors support
>    e1000e: rename e1000e_ba_state and e1000e_write_hdr_to_rx_buffers
>=20
>   hw/net/e1000e_core.c     =7C  78 +++--
>   hw/net/igb_core.c        =7C 730 ++++++++++++++++++++++++++++----------=
-
>   hw/net/igb_regs.h        =7C  20 +-
>   hw/net/trace-events      =7C   6 +-
>   tests/qtest/libqos/igb.c =7C   5 +
>   5 files changed, 592 insertions(+), 247 deletions(-)
>=20

Thanks for keeping working on this. For the entire series:

Reviewed-by: Akihiko Odaki <akihiko.odaki=40daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki=40daynix.com>


