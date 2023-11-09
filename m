Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A1A7E6BC6
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:55:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15VP-0001xt-PO; Thu, 09 Nov 2023 08:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5677a8076b=leonid_komarianskyi@epam.com>)
 id 1r15VL-0001Tb-Uq; Thu, 09 Nov 2023 08:55:32 -0500
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5677a8076b=leonid_komarianskyi@epam.com>)
 id 1r15VI-0004Fl-Le; Thu, 09 Nov 2023 08:55:31 -0500
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9CDBSv020945; Thu, 9 Nov 2023 13:55:21 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3u8bpe3wp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 13:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmdXMkPLhSTPhm1j4NBNWrCmhcEMCOic/i/OqI2KMTQ/klbpv2ovjyks0LFjsG118AEhdDpG6YWz89z94kksXS6usb8qwKWPa6Y+0h4L2Y5YxzHatTu2YuAUhm//64Q0k5ReldehcTawZY75SqmB9KkZ6usWvCaPs0lfn691daEkizbkYDy0Vg6sCxdA5dhhp2KNvAVUCx6/rHZ7+FsfXk9uRm7rRC4/mdJLZ7XdMUdpZxTk92aRxo1XCzc/9YiVtgos4kaTeBOfuV8Vy1dkusYUkD+erzQ3w8gJkvKxg5VyVKX9OWfSHdtzi7OfnAQ32P0HV83b8pIGcB0SI60TdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ3Leke++wbGnkkLpKiEn9TC+ZukJztOt9csrbf8U2I=;
 b=avTsJfyt4GzDtbUBX8/4hXnxG9Q0te7M1e7F87gEVjNyiyivqXjnXhf1TMGv6k2Yzntvz3RkV5bSrAFZAE0thXdeTRCvXL54Jx5A8RhA1bZP2xSSAktYup2WwZTcoMg52iZgspdFcP2rFcuWsUbOD7LBHRpttUp3N37QKzNBx5Ges0SQntsB9IEJsdeI4+CK8S45FE9kdyQpCKc9QVEmiiqsixAllECQnC8ZUDsVMPPElOfSwmUhqzaXzbj+EVoJrWKEUPNnRLTX+y0yRr4ZC4r4RZOWtYjJ4bHOpZFRBTvup5rd4o73QI1RfW4Z6qzNyg4FrCoMLMa8dBymzNOomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ3Leke++wbGnkkLpKiEn9TC+ZukJztOt9csrbf8U2I=;
 b=NhOP/jSMUSlWxxa5G2o6HweS/jTJKN7ojlubrl/0zx4xK9z6s8DENm3pDfOmxdtoCPpWfsinpmaF11D1dwsMGjz61l/ySO0Ut8tKF3ZmpQgpttwIcYthv8MPb6iYBcJ84sfVSwHNFZuH6Uuswd+zBYY6SMY5IeQRSMKoC3STBZXQia/73qgm26V+Po6nnyZ+q8JZNbXKkTLfZ4xdUSmuPAk0ApH4WS1ql8dko1g0gg6aGBctTd1YkvPCUbc9eucQZE96ovfgRTknaiIdmq50Ia8RI0Rn2oYwpEjmo1r6TrC7kUbl2kssKGlrR00JSaLm3Dsrb7kbsykn0dIOYs0Ylw==
Received: from AS4PR03MB8676.eurprd03.prod.outlook.com (2603:10a6:20b:58c::8)
 by DB9PR03MB7338.eurprd03.prod.outlook.com (2603:10a6:10:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 13:55:18 +0000
Received: from AS4PR03MB8676.eurprd03.prod.outlook.com
 ([fe80::3779:1a8d:a31f:95a3]) by AS4PR03MB8676.eurprd03.prod.outlook.com
 ([fe80::3779:1a8d:a31f:95a3%2]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 13:55:18 +0000
From: Leonid Komarianskyi <Leonid_Komarianskyi@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>, Dmytro Firsov <Dmytro_Firsov@epam.com>,
 Leonid Komarianskyi <Leonid_Komarianskyi@epam.com>
Subject: [PATCH v2] target/arm: Add overflow check for gt_recalc_timer
Thread-Topic: [PATCH v2] target/arm: Add overflow check for gt_recalc_timer
Thread-Index: AQHaExRfPMvujsWDHkC+f/nKYA3iTw==
Date: Thu, 9 Nov 2023 13:55:18 +0000
Message-ID: <20231109135439.1297135-1-leonid_komarianskyi@epam.com>
References: <CAFEAcA_koyJSR_7kF6TByA_rm2nJQr-8UnXrtu3JqwgpqUEctw@mail.gmail.com>
In-Reply-To: <CAFEAcA_koyJSR_7kF6TByA_rm2nJQr-8UnXrtu3JqwgpqUEctw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR03MB8676:EE_|DB9PR03MB7338:EE_
x-ms-office365-filtering-correlation-id: 1129b834-b61f-4666-7ca2-08dbe12b8203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ly9f63Oz5eTp/0H+SNsiZcjm7mOuj8MqGFKobeOMVT/Ujr29E8JuqNLnUK9leVuM0U7wISgvjG3b15GdFrgYKMRYK2Xt/GQt4Obb2qBD8hI3pgPg0JcaKLzCwWj/xdgwWxC/RORO3gh9ZvS36KOGflVHlr7oHUVO6bRyb50QVl+IVvAAAb2tS5BlNqtWJ8uY9zEE9VqQOR2vDYYGXAGOfNT0qe6S9NMEaGPBRRxJAesMjdXzAHZEcR7G5p2L4EMf6voSLvEddmE3vV58WauTpJ1pr1IdcDYWX1sIxlf+9CPlVeEM2PqfnyKtVmkwUa2I9oZMbCFyYzhczpusX+HUkiBZETLvpm9E6KdiShsV76YAdMIaKdTSUFiH+HDty3wHLoQeE3lIbNeB2JhMVp5i3uqaHgCurKmSnbkhv+brbHT5+hiUUD556EHB5XgSn1pD4z5LL9HKQ5wA4bXVhPmikGCU230LkbE2YdGXjmfR4GK5xQDtzSAt3fWTc+Il9dHLfaJEYFwwelINzCga68EfrHDKsb0VkymX3WcgM+YCx79ZdLernIQN3ZnK/GDs9XGd5RLKaFJrezev/bzpWlaNdAG8aC5Iid/BBX8CGihuhgPQa9gdn7tI1ZN2iVgdUbr9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR03MB8676.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(2616005)(38070700009)(1076003)(107886003)(6506007)(6512007)(83380400001)(41300700001)(76116006)(66476007)(91956017)(66556008)(66946007)(66446008)(54906003)(64756008)(316002)(6916009)(122000001)(5660300002)(36756003)(86362001)(8936002)(4326008)(8676002)(38100700002)(71200400001)(478600001)(6486002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r3glH+io5okLw0tXC9An7dPSoe5ZHqLGwdUGrDwN3NxOU8XmkLx6sUq1R+?=
 =?iso-8859-1?Q?YrIPZecBrGPcr/JteOFwnJ/aA5X68N6VcpeFQr9yU80PIHRCh0JagQz01M?=
 =?iso-8859-1?Q?J30CbTssQkHmixLBbliXOe+7q9jYS/2AHZISMt61Bz35z53FHm63kaBaxN?=
 =?iso-8859-1?Q?2f6t20kRvR+ukCOrg59xhSC3B2m6in6iwy5Oc/1L9bhTlKPnfuusbrDW4n?=
 =?iso-8859-1?Q?xHXgsDAjZqsWnrL3F2HL5o4rx8fQ7V48LoQNBfp4jeMxdPDD/vJLJB32vx?=
 =?iso-8859-1?Q?cw28QazZ26p8lCycYyAodzMcEpKJoemtwSNOKjDY8xRyxVP79XizfIX08H?=
 =?iso-8859-1?Q?q6Ozpu4AlJzAWJdeTP5Q/+Nl39KaHQxMluYSP2O9sJXrzSvbrdl6dKsJLb?=
 =?iso-8859-1?Q?CUrZEnW9jpE3H/XeN7MCOJvA68YVS70HqEUaTM6Pu3PGGHIUW2w7atwWQg?=
 =?iso-8859-1?Q?NAbbrGmGmnrgnPXPjnRCVlM+ZOsJVbfJnSUgAai5DwSIM4HFyO7sPHQs/o?=
 =?iso-8859-1?Q?hUEMrBCQo5kE09KRTtLj9VpiDqHDGagLEuKLrbvDGlHFFzGWxd73D6FkKu?=
 =?iso-8859-1?Q?hAjVnpEsA29KgcARHHCdknSc9Hi7QobX/OlRr0yk6aqy5nDUgaNOOIEP/9?=
 =?iso-8859-1?Q?Cc2zdq/KwSOdifnmQ1fQ8PWmZABVu0rgM7xM1Xtp3jWfBC/SHCKzrPMrac?=
 =?iso-8859-1?Q?t9l3vxi+jyFslDWkIxYvBGnJEhE2mTa681PSRn7ZusAv5SN3yumILuSrL1?=
 =?iso-8859-1?Q?DBDLMXmka5Nbha1JR9qLa/oFBRdArtTY6IETu0OLWhoJZZSkJT11aRp+DE?=
 =?iso-8859-1?Q?IDsTwymcorvo8zDTfrScZcd2ZcEE30MKSSsjg4Nb+ZUl6EMWalI01H4j3+?=
 =?iso-8859-1?Q?VeGAj7G1qsdM4id/7+6OUBfkiVpYW7/EYhS0ZR3snJOfE9oEFEPrlswlYg?=
 =?iso-8859-1?Q?iR09691ts5SbhAio0NCgqFkNSqgR4NhZ8HllWUVm1e/Q7iEgHdWzN5HnMQ?=
 =?iso-8859-1?Q?lX8JW7U/kUu7yOo4GJTQLdwKlrTS0zu70hSQ6GAxASQcYfeDPnu1/kvj8V?=
 =?iso-8859-1?Q?G112RROJegdRFvKmo7ctGb439zlUgcRzZ+B2u/JXUHkoumNZ8ur6klNQme?=
 =?iso-8859-1?Q?PA4ufFW4u7+8TbTrt7jdJlNpAYu2iA4x1q1GYWMrzFU/hNBAUh3gijrgyJ?=
 =?iso-8859-1?Q?x44q0G+ePHxNpyWDANOb6su4SoXm9T3M/EcBwYTniTSQvNNHW2AV9aUI0E?=
 =?iso-8859-1?Q?GpqH92C5cWLHPrjJsTZuIsHtlQ9kq3PCguoDgph5TiwkPyo3kAWssb0YIv?=
 =?iso-8859-1?Q?DmEcwTckAAy1/vp27LvZvRw3eDqiW1j8He4uAqxuJMFUMlXih3jWEnjB+U?=
 =?iso-8859-1?Q?JW3l8zBslR+tWjhUd4NdgsFJx3z7Zm+PE3ETe7wvKBIcfziX4OkyBKEsmQ?=
 =?iso-8859-1?Q?gEWKZSD1mgZ+66SRlF7/8OaFsDiYBJORCjwvHQSK6Vayp01YCt35ktyCO/?=
 =?iso-8859-1?Q?VFy1ieNHmYzrLT3BOPBx57+bVKzdkM+cZlFvPU1Y4ez6jt5La+KfZN6Kq+?=
 =?iso-8859-1?Q?r0+lNP6cIzXFo8Pm/s0i3qf36DDmeujdDueIEI0E1AiS+9NqUv1nL7okkz?=
 =?iso-8859-1?Q?m3Q64EHmyMZM7ytyT+WtUw+meWv1V6+jM/XEaPpeB4Lm6E8I83QW0xiOv5?=
 =?iso-8859-1?Q?YWgT118mAZccbTM2mU4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR03MB8676.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1129b834-b61f-4666-7ca2-08dbe12b8203
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 13:55:18.3896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPcqqk/PQT1fpjlSkQJeMJ7JWdYzEY4Np0xQBR5ADoIiMdNXIRzIw5F1YuyYP0VPSOYTPTdPkDd81sX/JdOUDJ2ZO//yhtEBfDQKSwiTj4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7338
X-Proofpoint-ORIG-GUID: dzMiTWCy6VRW-3xc7aDSbKbpqK_2mumY
X-Proofpoint-GUID: dzMiTWCy6VRW-3xc7aDSbKbpqK_2mumY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=811 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090105
Received-SPF: pass client-ip=148.163.137.242;
 envelope-from=prvs=5677a8076b=leonid_komarianskyi@epam.com;
 helo=mx0b-0039f301.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

If gt_timer is enabled before cval initialization on a virtualized
setup on QEMU, cval equals (UINT64_MAX - 1). Adding an offset value
to this causes an overflow that sets timer into the past, which leads
to infinite loop, because this timer fires immediately and calls
gt_recalc_timer() once more, which in turn sets the timer into the
past again and as a result, QEMU hangs. This patch adds check for
overflowing of the nexttick variable.

Suggested-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Co-Authored-By: Dmytro Firsov <dmytro_firsov@epam.com>
Signed-off-by: Leonid Komarianskyi <leonid_komarianskyi@epam.com>
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3b22596eab..b4aaa2965b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2665,6 +2665,16 @@ static void gt_recalc_timer(ARMCPU *cpu, int timerid=
x)
         } else {
             /* Next transition is when we hit cval */
             nexttick =3D gt->cval + offset;
+            if (nexttick < gt->cval) {
+                /*
+                 * If gt->cval value is close to UINT64_MAX then adding
+                 * to it offset can lead to overflow of nexttick variable.
+                 * So, this check tests that arguments sum is less than an=
y
+                 * addend, and in case it is overflowed we have to mod tim=
er
+                 * to INT64_MAX.
+                 */
+                nexttick =3D UINT64_MAX;
+            }
         }
         /*
          * Note that the desired next expiry time might be beyond the
--=20
2.25.1

