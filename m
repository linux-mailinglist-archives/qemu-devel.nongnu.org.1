Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 049077758B6
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 12:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTgou-0005gb-U6; Wed, 09 Aug 2023 06:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.devantier@samsung.com>)
 id 1qTgos-0005gH-3l
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 06:53:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.devantier@samsung.com>)
 id 1qTgoo-0002zS-Tq
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 06:53:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230809105323euoutp02b601d1d41fd5e8552bc29e50b730cc1f~5sZiS2wz_3081830818euoutp02L
 for <qemu-devel@nongnu.org>; Wed,  9 Aug 2023 10:53:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230809105323euoutp02b601d1d41fd5e8552bc29e50b730cc1f~5sZiS2wz_3081830818euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1691578403;
 bh=7CiOnuX6LXBJGvy0g6iB3rnO0LwYwzwzEIFq4DuZNrM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=byMzMRknSF7L55wcGwQVT/mvCQwOO7fNyv32nVSpc6dmczGtFYvD5cwEGBVuJSVD7
 g2Wg0pIZyzEuXgoN6ZnktoCGEi6UVfImipXdyGaveuY6Hqd2CbWEa100vRgXo3v+WE
 7QFZ2j6iLnLmtMIKo3U56pRqOxyiANjJhCDDevSs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230809105323eucas1p18d4b107ecfe7bd049acd0e935c151a38~5sZiKXeHM2591425914eucas1p1N;
 Wed,  9 Aug 2023 10:53:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 35.B5.42423.32073D46; Wed,  9
 Aug 2023 11:53:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230809105323eucas1p1fd05e895ed22de2549510fbeaaf6ed3b~5sZh7k38Z0660406604eucas1p1M;
 Wed,  9 Aug 2023 10:53:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230809105323eusmtrp24ce003a57af32f238254245223402030~5sZh2McPa1326413264eusmtrp22;
 Wed,  9 Aug 2023 10:53:23 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-7f-64d37023c491
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.7B.14344.32073D46; Wed,  9
 Aug 2023 11:53:23 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230809105323eusmtip2aaa0df66417b72d0edfdb1ec4e872ab3~5sZhs5Q133049930499eusmtip2R;
 Wed,  9 Aug 2023 10:53:23 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 9 Aug 2023 11:53:22 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
 ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Wed, 9 Aug
 2023 11:53:22 +0100
From: Jesper Devantier <j.devantier@samsung.com>
To: Klaus Jensen <its@irrelevant.dk>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Keith Busch
 <kbusch@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Klaus
 B. Jensen" <k.jensen@samsung.com>
Subject: Re: [PATCH 0/2] hw/nvme: two fixes
Thread-Topic: [PATCH 0/2] hw/nvme: two fixes
Thread-Index: AQHZygtQoz3eL0UoQkGiPUnfTIARD6/hupEA
Date: Wed, 9 Aug 2023 10:53:22 +0000
Message-ID: <eshzxkosbsw2vhzfntui6pxwq54klkczqsyc332ki6erujkgjd@aatntiwk4zaw>
In-Reply-To: <20230808151611.81933-4-its@irrelevant.dk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.248]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACBFC46816158946A8912AA064990430@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djPc7rKBZdTDM7f17LYf/Abq8WkQ9cY
 LWa9a2ezON67g8WBxePcjvPsHptWdbJ5PLm2mSmAOYrLJiU1J7MstUjfLoEr49ukqUwFH5kr
 Dk6/wdTA2MfcxcjJISFgItHVfZmti5GLQ0hgBaPE0kddjBDOF0aJzXeWQ2U+M0rsn/acDaZl
 4sN5LBCJ5YwSJza/ZIWravl3HipzmlFi2ZEljHCTd638xgLSzyZgILHnyCowW0RAReLpv71g
 NrPAZkaJA82iILawgLbErB932SFqdCRWT/4MNIgDyDaSOLzfHCTMAtR6b9NfVhCbV8BX4vPq
 mYwgNqeAucSsjhawkYwCshKPVv5ihxgvLnHryXwmiBcEJRbN3gMNATGJf7seQr2mI3H2+hNG
 CNtAYuvSfSwQtpLEyT+roc7UkViw+xMbhG0pceHKGqj52hLLFr5mhrhHUOLkzCfggJAQWM0p
 sXPhGagFLhIrZpyCWiws8er4FvYJjDqzkNw3C8mOWUh2zEKyYxaSHQsYWVcxiqeWFuempxYb
 5qWW6xUn5haX5qXrJefnbmIEJp3T/45/2sE499VHvUOMTByMhxglOJiVRHhtgy+lCPGmJFZW
 pRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamCSqztsFqJ2c9aUZfr1
 vg9D5lySWvWAbRv3wcTSq5wzsgtn3figtOLvle/qtft+vN7LcLtwM5PSh52zWYReG4kc8LEP
 9V/eH58y9cUV4a0zsg7cuNmbefbSp/sfF818LZ10X2VGr9+5xgkhPi/Y1LdEy6SytEyPsOCs
 YtiVlsp280RF7cGUQ63Wj0wK9exeGJwz5AjcrDxfTzd97jOFI0p/0yT0f66XmrIlN1ta2S/f
 xjLBZvNKnYk2r9atVsiuPZyZwh2n0vuwakFGPVdrf2FdieA8uU+XfwQtO6ypv9zJkvtu5Yc/
 CtsWTVk3U8H0RqOZ59Wj06XSRP1u+/c/Ntxa8PX977c26vfPfPBucFyixFKckWioxVxUnAgA
 3ghLIqkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsVy+t/xe7rKBZdTDFp/ilnsP/iN1WLSoWuM
 FrPetbNZHO/dweLA4nFux3l2j02rOtk8nlzbzBTAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
 Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8W3SVKaCj8wVB6ffYGpg7GPuYuTkkBAwkZj4
 cB5LFyMXh5DAUkaJd/u/M0EkZCQ2frnKCmELS/y51sUGUfSRUeLDmZ3sEM5poI61p6GcFYwS
 L6+uZAFpYRMwkNhzZBWYLSKgIvH0314wm1lgM6PEgWZREFtYQFti1o+77BA1OhKrJ39m7GLk
 ALKNJA7vNwcJswC13tv0F+wKXgFfic+rZzKC2EICZhJvH00BG8kpYC4xq6MFzGYUkJV4tPIX
 O8QqcYlbT+ZDfSMgsWTPeaiXRSVePv4H9ZmOxNnrTxghbAOJrUv3sUDYShIn/6yGOllHYsHu
 T2wQtqXEhStroOZrSyxb+JoZ4jZBiZMzn7BMYJSZhWT1LCTts5C0z0LSPgtJ+wJG1lWMIqml
 xbnpucVGesWJucWleel6yfm5mxiB6WTbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEV7b4EspQrwp
 iZVVqUX58UWlOanFhxhNgWE3kVlKNDkfmNDySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
 UrNTUwtSi2D6mDg4pRqYWkM0VWcGeJZLbTp7w0ZUo72kyrPi8+IXK6sWapg7d+xcU7TVkvm6
 PbvCo8eHbxhNTNSc71P8f75sEtPpkzHPo/NZxL/K3XGyrt39OtVpaszfcOnFGl6qBhVrSg6I
 nTP1dPHnsSzg3Rv16er/okMiL1qu7r3Ad26F0r9Av/wJsUe+PyoOnnH4zRfuOyLTEgxi+j4K
 X3+j/Wz/35yt3rf0npczxeqnpkt83H3jsW7mrzRjobOuSvLLfnRucjO8kGF8mPUqI8c1zndq
 BvH8mzoc0n65Md48enCH1A+nwIsei5kOSygEf5t737j95IyV/4zWzVeIr2S5c/R4VYHqlUfd
 1p9+lN1jN4zMml3f6jBfiaU4I9FQi7moOBEAyqJwILADAAA=
X-CMS-MailID: 20230809105323eucas1p1fd05e895ed22de2549510fbeaaf6ed3b
X-Msg-Generator: CA
X-RootMTR: 20230809105323eucas1p1fd05e895ed22de2549510fbeaaf6ed3b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230809105323eucas1p1fd05e895ed22de2549510fbeaaf6ed3b
References: <20230808151611.81933-4-its@irrelevant.dk>
 <CGME20230809105323eucas1p1fd05e895ed22de2549510fbeaaf6ed3b@eucas1p1.samsung.com>
Received-SPF: pass client-ip=210.118.77.12;
 envelope-from=j.devantier@samsung.com; helo=mailout2.w1.samsung.com
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

On Tue, Aug 08, 2023 at 05:16:12PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Fix two potential accesses to null pointers.
>=20
> Klaus Jensen (2):
>   hw/nvme: fix null pointer access in directive receive
>   hw/nvme: fix null pointer access in ruh update
>=20
>  hw/nvme/ctrl.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.41.0
>=20
>=20

Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>=

