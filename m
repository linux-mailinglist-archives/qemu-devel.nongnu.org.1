Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A78437F3904
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 23:12:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5YxF-0005SY-DI; Tue, 21 Nov 2023 17:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5689374ac6=volodymyr_babchuk@epam.com>)
 id 1r5Yx7-0005Qk-AB
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 17:10:45 -0500
Received: from mx0a-0039f301.pphosted.com ([148.163.133.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5689374ac6=volodymyr_babchuk@epam.com>)
 id 1r5Yx5-0001XZ-HI
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 17:10:41 -0500
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALJcd19031085; Tue, 21 Nov 2023 22:10:31 GMT
Received: from eur03-am7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3uh0hhgrv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 22:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUOq1e9rFmqX20JqI3pK1zHqn6YN2bSdWeGGNk2rQ2cvNkYu0vvxgJ3JX9a+87qYBHtY1FJmcov3pMa6jFtmCa7hMCVDHt2mN/FY3W3RJcYpWFH7Ln6AhxLa8ErjeERCcDHlZGOCvO6G3fQyKvtpQIzoeGoWlh4WvUu1dhcNezc8exz9N6KojzqrWSHVFNjMFnkUicEY91Vahu+SZONCf/l3KvJLsEUGkJqr7Xra3wWYJBCxlKR5Pcr2bmub4a2XFzAMzvJhmpHTedM4r1XGQVscbO38vuGqJgoTV80/UqtCDXdBxq10Vj05Uyu9y46jHoxmGQi9nE9LmSZBJmuNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vrab7xD6Eb8Yy+PVTHXjPTBXOVSjkFLDtFkuUQqPiD0=;
 b=S0DE88RduRQ7FmX1TUZV53s1xNaAHtzBn5ju4/n7bj/KaO5QZkCU5UT+Vk5nDR8JiCHcDMwbCk3Q2eEECbe3hfI7JTDa1ejxFsn4YpENBaR1dh5w9IocPgLhGddx5Yq/muPSJfpn9jRjCnX9/j5d0s0Z2kpQec57yECDYWya9a/kHOwZ81mdYBnm47Uc9jM4rqdmY4KyGpODAojo/RYEylzpdW7n5dgP4g7Vm6zzEO1nKtDZ2BcEVxfke6M9Yr70/SixeQB1v/+1JppVBbSZD4g1/HqzfuCsMM95fuZWy3ZdEYYBxr6M4uTdqHBBoKr8sqeYKaoh1GqQh2nypCbsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrab7xD6Eb8Yy+PVTHXjPTBXOVSjkFLDtFkuUQqPiD0=;
 b=mlMEafKSFoiHm669Aaxfb4YJ/PzB4blriXVecTexUNFsKxhxKsvhCgW8YFnx45H0lrNQBefDyfQVVE9NMFZpBXfx2HB+2aMNJBhbQxasvzcu/Y7f4uoTNs19EWVqjqmBoxjjvgroeAVc5M2bayxsrAn++q2/Q0bhe9dBj3HH1RORjYngE1cR2ci2VDf2vORAn2Iqw4Ia+ObrG215wZwAA5i+m6uyTtuvCDDmut62phQYnLT3vn+zn1hu8iCSBhogeB/sBtp2gkjom5nGBrSVW85QXADOlBGz6BMGaQC6WpROdaxe2K7Ik4fW8V20Z6F2Vl1ntTPTRgZuYqyNYjEMhw==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by DU0PR03MB8836.eurprd03.prod.outlook.com (2603:10a6:10:40c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 22:10:27 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%6]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 22:10:26 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Stefano Stabellini
 <sstabellini@kernel.org>, Julien Grall <julien@xen.org>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>
Subject: [PATCH v2 0/6] xen-arm: add support for virtio-pci
Thread-Topic: [PATCH v2 0/6] xen-arm: add support for virtio-pci
Thread-Index: AQHaHMeHsz+LK34jDkSrorKu2BdzqQ==
Date: Tue, 21 Nov 2023 22:10:26 +0000
Message-ID: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|DU0PR03MB8836:EE_
x-ms-office365-filtering-correlation-id: ad540bce-8d8b-43b6-036a-08dbeadeaa62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S9K6JSOQl6scQC7YX/Fvb0M1MCUTEONhaunE4ftTImENBpd2QgfmQ8Vf4+I1xjL38FTa56vrD4qsqvEf7+GA9qMLht0Pv2rPobKyEHycxn2LsuO08YrS2zS1tzYFvC0y3dt6koyql31oLPdb4gF+RPKCpJggRXUVIrayVnljAGDt9JmZJTFWoaDgzQDESxbn4EehY1lyg7bavczwPoQFEl3phbKrf+xNYOU+car1P08HN6pRN1PNLDFB5GiLwqSWRbOGcA+QM64dGPCdi0GNb1gy5PtX4XGpSGGVM6dJwz8jIkczPSpHAa4iW/aW7S6zCFhp2Fgo5Y5/VtD4bdNdKLIugCh8sRQBgiau82Py+8jFtfBgr0ngvITKEl12rlPHooBJ4blBMwF8kx+ErfSvUB9vvxbZaqhtwM5TgMfbJAVanIwd5NJ9dI3N/Wg24gH9rUuyIeWdm6J52mZXvNF79YMtaGdzfiapOrt/LMKuCiLLpnKjsNAQNQLf7i2d9dBVPH/Dp18CXfw978qSWseptk790Io9x+xGSxhoyYf3M1WSbQzOheb3Pv3J5mDRzrIPXgueZ2k1HgyGLB48DMTNW7A2TIW3o4WCn7HjH9nq+HfJ4j7VsWauaUY/IyS1S1+c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(86362001)(36756003)(5660300002)(2906002)(38070700009)(122000001)(6512007)(2616005)(6506007)(55236004)(6486002)(83380400001)(71200400001)(1076003)(107886003)(478600001)(26005)(38100700002)(91956017)(66556008)(66446008)(316002)(66946007)(6916009)(64756008)(54906003)(4326008)(8676002)(66476007)(76116006)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HnpvZTEcRg3MMMhQVoTzHFkciKPw8VmnwAZvLJNNRSxS5hVod1mu0MARnd?=
 =?iso-8859-1?Q?No6efHtj5RpDmDMCECVjGrksC8E9UmpQhBWk8Q/wlSMzZMpJb0ZTRN1G21?=
 =?iso-8859-1?Q?VkVI72LnCgnIurEoZqOSZfGfD3J/D3CMZGhi7mI9em7KEyzZadwxw56AN8?=
 =?iso-8859-1?Q?eZk09H+ZIMZScbp3PWmRP8kii4xlhS/EEnTXtkyIyYF4qZnx+j0M7PB1fQ?=
 =?iso-8859-1?Q?VuN9YQgJPh2kBiLWP18nMKuhRldlY5vT/oaXT95Q9BKk9mj5iIY3GzN2d8?=
 =?iso-8859-1?Q?U76eJB9MJoT8SJfYD571xUyWboGQKDJjxNMGSP4lAPrUj4O/YjTQ+PUBDb?=
 =?iso-8859-1?Q?OyMwsdZdja65D1T4FVSWoeDATerNeembruKLVxBcNHsR/N2u+0/WxFSoGw?=
 =?iso-8859-1?Q?RryB42IK7NfrjyOs/gCI6C8QsS5Ro/SoZzDdbYJYC+hdymKV/Ys/IegUnC?=
 =?iso-8859-1?Q?9+UdhK44sYPBKEEv9o5B3z2DYo6SH+I9p/eE57hOeaRFsXYIyLG0wnTzI0?=
 =?iso-8859-1?Q?FUK3ABf53xC9lIx2NT4Yim5Kb8LmadkLmdTYDKrdtltiIcHqba1hBg+BYI?=
 =?iso-8859-1?Q?NAKjTA780R0fdf6dnfOfgfVOkuDYTJNi8oCGlFzslyTho8bP2tJcoDFIKi?=
 =?iso-8859-1?Q?JF3PCp4/jha3wZ0FY2IRBrHygzAiLfWVmeJIKiIe2RguBPsADmIbSu4NOE?=
 =?iso-8859-1?Q?G4SwE1PMuJasB2FN3uyppKNuDtcCSqn6okL16qN/AvMnBeTW6BIJ/TFeq8?=
 =?iso-8859-1?Q?Gpypr9D0koqdcKIlhOmlNv4epBJOCWpTHQBXmiChZUPqMbtH91Lf5U/1ZI?=
 =?iso-8859-1?Q?e1YM3uNbSPCIgsWEuAcbISov4NYCWx+xs2imRDxpg2TH2v87luWFbzRQJU?=
 =?iso-8859-1?Q?zQhZOqx5SFih4rBkuftgG8+K6IKFLI7gJBXilqNwrlBqZ2fCfG9nOWo0y+?=
 =?iso-8859-1?Q?zVV9Wdm3vf8r+h7oSzPsk9mEjX+n+tFDGYyJv1c6LqzH6H8KFny61mCGaM?=
 =?iso-8859-1?Q?Pjkojcf+17rcENOpMIJ0FDJu9AKZhrm7WL/5jgjgE80vUWWQS9fTDLkR6m?=
 =?iso-8859-1?Q?fPxlG5j/EdoJhjF8wRF/1zVVK46TIXkgY9YjIsb1YHdCO2kBpOWyDqq5V0?=
 =?iso-8859-1?Q?QkEEwkT2ThL8dnaBujHbN7StntADZHqZyC7TVPdGfgBgrw+Ytx2RCEC3Lg?=
 =?iso-8859-1?Q?PrMHisVgAhdZQxnH+vzmK2KK7/ik0qdGqosFP/viuJeVxA0FNT2K+g2/jV?=
 =?iso-8859-1?Q?tQORUzvycJrcdgNExRNkdyprcv7a+nWhc6uHoiWaauJhyokHBo+zMTr2+1?=
 =?iso-8859-1?Q?X9mKEHuK/vk9Na6XtJdlVjjHHSVGsz6LODwXVOW2qsS6tNdlIl6OyTUySo?=
 =?iso-8859-1?Q?0COWAfZCjEqFvlL0cp8xpVzO2/Mi6739OXo3FgnEnF12nUw2ZW5ZLFOj8L?=
 =?iso-8859-1?Q?vUde+42VHbXJZ6gu/Q3f8wOS3JFUggXwffxgDPUTfM8fnZePEmVEbr1iZR?=
 =?iso-8859-1?Q?Jv2lvrQm/AaGdmWlfSI6N3KuBj/yy4tq6QItpYkHVWGKR+vbwh8j3x0/eD?=
 =?iso-8859-1?Q?JXnm0TyVG5rLH5pjoAbr2YxddpWJ4m2LxrQbZDgx7ZrdtTip5Ie3SRHr1m?=
 =?iso-8859-1?Q?Nm5TKa+VFjyr3PouYjZmS2fL4LCC2aFNXK+4HGkc2CokwSjiIhC/4UiQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad540bce-8d8b-43b6-036a-08dbeadeaa62
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 22:10:26.5172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4+Uj0uCZNWQzYzKFsGY4s4VYEcyhL8bEGAAXXTi2y2GVjtihrsy+c/UxSCVrPBNtddwS4F4Hl5BrjByHfVU9bVOt5bA6xloaaYb9q1cDPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8836
X-Proofpoint-GUID: tRWQtc-kl_b6RAjRjmMnCUKidwvfjyom
X-Proofpoint-ORIG-GUID: tRWQtc-kl_b6RAjRjmMnCUKidwvfjyom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_12,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=852 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210173
Received-SPF: pass client-ip=148.163.133.242;
 envelope-from=prvs=5689374ac6=volodymyr_babchuk@epam.com;
 helo=mx0a-0039f301.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello,

This patch series adds the basic support for virtio-pci for xen-arm
guests. The main changes are in "xen_arm: Add virtual PCIe host bridge
support", while most of other patches are required to make QEMU work
as device model in a non-privileged domains like driver domain.

Changes v1->v2:

 - Removed "xen-bus: Set offline if backend's state is XenbusStateClosed"

 - Included David's patch as it is the pre-req for "xen: backends:
   touch some XenStore nodes only if device..."

 ---

David Woodhouse (1):
  hw/xen: Set XenBackendInstance in the XenDevice before realizing it

Oleksandr Tyshchenko (3):
  xen_pvdev: Do not assume Dom0 when creating a directory
  xen_arm: Set mc->max_cpus to GUEST_MAX_VCPUS in xen_arm_init()
  xen_arm: Add virtual PCIe host bridge support

Volodymyr Babchuk (2):
  xen: backends: touch some XenStore nodes only if device...
  xen: xenstore: add possibility to preserve owner

 hw/arm/xen_arm.c                 | 188 ++++++++++++++++++++++++++++++-
 hw/block/xen-block.c             |  19 ++--
 hw/char/xen_console.c            |   4 +-
 hw/i386/kvm/xen_xenstore.c       |  18 +++
 hw/net/xen_nic.c                 |  20 ++--
 hw/xen/xen-bus.c                 |  18 ++-
 hw/xen/xen-hvm-common.c          |   9 +-
 hw/xen/xen-operations.c          |  12 ++
 hw/xen/xen_pvdev.c               |   3 +-
 include/hw/xen/xen-backend.h     |   2 -
 include/hw/xen/xen-bus.h         |   2 +
 include/hw/xen/xen_backend_ops.h |   7 ++
 include/hw/xen/xen_native.h      |   8 +-
 13 files changed, 278 insertions(+), 32 deletions(-)

--=20
2.42.0

