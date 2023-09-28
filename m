Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AF47B18A2
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 12:54:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlodP-0005Zl-FV; Thu, 28 Sep 2023 06:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4635f55f55=oleksandr_tyshchenko@epam.com>)
 id 1qlodM-0005ZX-Qf; Thu, 28 Sep 2023 06:52:40 -0400
Received: from mx0a-0039f301.pphosted.com ([148.163.133.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4635f55f55=oleksandr_tyshchenko@epam.com>)
 id 1qlodH-0006Bo-Cv; Thu, 28 Sep 2023 06:52:40 -0400
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38SA9wAO011832; Thu, 28 Sep 2023 10:52:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3tcf1swbxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Sep 2023 10:52:26 +0000
Received: from m0174676.ppops.net (m0174676.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SAjUUS015355;
 Thu, 28 Sep 2023 10:52:26 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3tcf1swbx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Sep 2023 10:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhPVbTDt/JLGSfgY2Fb+2nVNeH8QQ0CI7v1L/q0Ecc4Q5Y0CLqkReL2sXmD+Cpd1gc69merbTMdWkZ4wzbahPcXzixrSlY1clyQXgfRgx/8RcUGMvcZ+BnFI9Kx/NuftpHF2edrU6I1FRLU4dyCtRKkdxkjzvECwYptyTr6C4oCGqOAsiKdxJ6/Gxv/AA8ju74nOQE2uFiSP5pfQ/hMdird3FjxTgmEGYXdNxbYfFotgBFxmGKODYtqTnYKu0NRZ3j/pjxaRsy3nroNUWQojHVnrpV/vxb7n8aETMPof+HwJ5Qj90DIu+ew2moCnUzt+JScT7b5G6bRPveL37izonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGwylgQM6l7YfiqLvWS/0MnBCwcxB5Tml5WSUtNrPc0=;
 b=MJ7K+BiO6jWJuFvQzRn/q2FIVEDMDouA/K26oL4iYptgFXRZtcb+d3/AdRjGIimPmYJGkGgTENBuNoPu7roNVcRvARbswoKcb8fi6J39QKijfL6azcIlPbzZl6llcKMPEnsms5Za8He2JVNzcu1JjuUybD+Z0m1DxOGk7E6e4t5aM6yWgu/zxp5S2HB7UIly9/dJZn2dKE7C67VyZC8rlFIx62V8ccWd3snZ4FkJ+gCF2pqvso+Cm3h9KanZPIvKRqSC7iNjfumpZvWu1hKmAWtiAYh5Ahzyqp2CRHkwUHdLvOZBYKgJImSQ8llkGqfjHHZadkbkUkyN0RF0d2zKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGwylgQM6l7YfiqLvWS/0MnBCwcxB5Tml5WSUtNrPc0=;
 b=pv9lqFXUcT1HVFpruUsfcr0YBCSBf+y65tK6Z/AbniJfOWTpSga8mMkdXkDAC38QKtMEZtnePncr2el/+dX2GobKuPQrAiO+CorZV9PiXOZgQa49B1eu+JMC+qH+ZsCuUK21sUKGBHbXHKeUrSTz842gO/uHnCQ8oiqLRA+456viLxgQLC5GySzdJYzLNl67TnYmOGjWZNYlTXJ2k8Ur7GaYeExbLS9weCD0yM/ozUItPj2R7fzKmnE9NbQgOFK/qo5BhbhJgQKt5kOiKWUWEFw66GeWeqPYvhvlTj64A/T/+2bWl0uILQLsQOyBT1UXs9cgFuYHUORh80RtQypijA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by DU0PR03MB9636.eurprd03.prod.outlook.com (2603:10a6:10:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 10:52:22 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::ac2a:7470:c441:365c]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::ac2a:7470:c441:365c%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 10:52:22 +0000
From: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To: Michal Orzel <michal.orzel@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Stefano Stabellini
 <stefano.stabellini@amd.com>
Subject: Re: [PATCH v2] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
Thread-Topic: [PATCH v2] target/arm: Fix CNTPCT_EL0 trapping from EL0 when
 HCR_EL2.E2H is 0
Thread-Index: AQHZ8fBhCdaWZzbgkkaAjWdnVjspKrAwD9WA
Date: Thu, 28 Sep 2023 10:52:21 +0000
Message-ID: <9dac67c4-e402-e782-4d78-eaab7bc11401@epam.com>
References: <20230928094404.20802-1-michal.orzel@amd.com>
In-Reply-To: <20230928094404.20802-1-michal.orzel@amd.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|DU0PR03MB9636:EE_
x-ms-office365-filtering-correlation-id: e8f7942f-cdb4-4940-15d0-08dbc010fe37
x-ld-processed: b41b72d0-4e9f-4c26-8a69-f949f367c91d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6hyCLv3swyhwVG1iDDSk6UurtTowyKSpbiO/ydD86jQzYWazZ4gzb2NnZqs/WYSiGpoXriaizrgpZ31r0xRzAn5JDdDjbSMBEBbLOTGgquzP9qR7BV/TP2XMagH+4Q1Bc6v19Hn9ReZl5cli4TideJbe2anqa9m6Nsj/hOWA6N0FlrOB+Kjz9eEeBt2oPt2TjpzivycC3EZYmiqk5mp7ock8ryPB80fhIUhg9VAoWEQOLV4vs5B8SrdckJB8k1wUW8FhGkwI94vsQQGcrcJbEfYEKKeKsYdA2HiIbLiLo7zQmdnUep1xKGiHj/jMWaZbbEjYeHenMw+baXe+slduaF8Y9v3Y66uwj+2Ve7G+zgU60XdcOuuiL/IW+J1kSqO7jsAZFUzOXM9LW44zV+eL7XkPXsSoPaZKnXRIMGiFT3uREZxT3i13xn0DIL3zEw6Hpzk09ZVrcob0M5zAqq5z2xWOctiY0CDsYZCBwbqa2PtmeFgX89sR5Ct0HY1iaBROwp/xK4A+jtEzc6ehIqIgAbN8GNNaYK1uomitXoBTigsJ5lYawbPrqhAbFSNDERP/gFO/M1p+3dcqTw2azbrS7BOGBuUdecjAFyDVt3WINGfLiKkoqLzAwn82qQQ8YI0n50s+esdzq9biBr81lx8WQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR03MB6108.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(83380400001)(38100700002)(38070700005)(71200400001)(6506007)(86362001)(36756003)(6512007)(53546011)(31696002)(6486002)(478600001)(26005)(41300700001)(2616005)(31686004)(8936002)(64756008)(66446008)(4326008)(66476007)(54906003)(66556008)(8676002)(122000001)(5660300002)(91956017)(110136005)(76116006)(66946007)(316002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0tCSndYSXdVRStMSitUa3dsNFJXc0tHcmloWWVtSUpjN1ZvZHdqdVZTTERj?=
 =?utf-8?B?cWZDK3NzWDdmVUN1VktwZmNONzZkQnhpMElBRHRFWlZFOElQcXJEV0VjZjhM?=
 =?utf-8?B?a2Q4d043UEpqNWVNOVB5NWs0ekF2cFJPMnV2S0hab0d1ZER5S0RLS0JZeUlX?=
 =?utf-8?B?RGppa1paTndRWU9TS3pKdDQwcFlVRkxJdFhjSjFhdVlJbVhueWNaNmUyZzJh?=
 =?utf-8?B?TW5DSFZub2ozN1duTDlUMUtNUGRvd1AzdHhhcmV2VzV1MU82bllvNXhwc0xX?=
 =?utf-8?B?ZlhlUXIxQXEwdVNOeXdwU1dWQW5UcXQ0bmNYbS9FeHN5MS95ajdVVmw3Q1JQ?=
 =?utf-8?B?UjIvd29laW1kYTd4V0R4bXQrU0xJNVpLL2pnd2RvQVNucXlZYkp4c3hDOGk2?=
 =?utf-8?B?QTlNdEtidnoyQ2hyWGx1dndRRW1udUxGT1dlQ293bmpUenJ0dWJBN3NxWkVW?=
 =?utf-8?B?OWtTcDdQS3dzek1KNTQvMnRWRjVncDNqR3cyTFpzYmxUak1PLzFkTnV5MTNr?=
 =?utf-8?B?S2M3Q09DS0FuVjNTWDV0UFFXVGVwenhwNEsxUTJ4RWV6UWNQK2x3REhwMFpW?=
 =?utf-8?B?T1JGU3NpSGt1VWtTUkJMSEd2Tm9HTjlvRG5XWEZQZkNiTFJzb20veE9Xbm15?=
 =?utf-8?B?Y3dqWHNaT3FQaythRkNrTUFEbFdaeEEwekZDMk1lK3pOV0RMMUdsOVdCalJX?=
 =?utf-8?B?OGRwRDgxZk9uRnpGWHkvU2gzN2k4WVFZNENGdEliaXI5d0lENTZ1MG1RcTRD?=
 =?utf-8?B?MWF5MEtwSFRwMWV6U1FVSmNaQXU5QmI1QUNIRW5DbWFQbnhESmc5R3dsZWl4?=
 =?utf-8?B?dGFINWtFSVdvUG5ueWl2NkNRVnBEYWFMRFlnS0tXK3U5ZlRNaDRVQ25qYzJw?=
 =?utf-8?B?K1BrQkxaUU53WGxSWEUyaWRvL0xRb1VwWGlYY1lPeGxGbjl0TnRyVWRjcHUw?=
 =?utf-8?B?elpGQktTcXdXYUR5Y09uWkpHb3ZaNjI5c0ZiYkdwZVArNnRQb3picFdWNWxO?=
 =?utf-8?B?d21PNWh0RjFOODhwK1FXcWFvWGwzdnRvMWowRmk1RUNDSkFwKzJ3UXV3NmJK?=
 =?utf-8?B?ZG5IejJIWWhkSE55LzRHM0t2T0ZvTTJ6M1FMa0RqQ1NXZUN0Z2pSSEdYVkFq?=
 =?utf-8?B?aVRZNnREQTJHbFJjdXE0TTcvQVlYNnh4TCt1VFVyTFVVTWdldmtDdDRVdjUx?=
 =?utf-8?B?UkVyVEJiWDRONVZmSUgvRXp6SEliUG1iUEhEdDJ0YyszbUhiS3JENTNRNzcy?=
 =?utf-8?B?VWQ1aXNtaEZucVZOazdXL2Q1WGg5bzZrdVBwOWhWcUVZRzhMUXhXNm1STllo?=
 =?utf-8?B?aFVhaVZTc0NSa2JaNzdZUitvM1puQlNmdmlkdEVhTGplWGtERWZJSHNaalh2?=
 =?utf-8?B?UzA4L0thazRBV3d4VVNSTFhqME05eC9oTVZMRFRhV3RPYis2YVoxaUFTNUx0?=
 =?utf-8?B?RGtlNTFTUUtrSjZjNWYvRTV4MzBvSW11Zk91YXQ4R1p3YzFJazAzeDlDTUNK?=
 =?utf-8?B?NmtneXRkZkloY2RkbVBockY5STlldFZwNmxETmtvN0EwL0wzUnZ2clFxTHlV?=
 =?utf-8?B?ZmtlRXl3WEJpRzJYRDhnYVVMWHhZQ1h0SjlvU25Xb3Rrc1JxUGF4NTdEVmox?=
 =?utf-8?B?eDR2QlJDcS91UFZRT0dCcENFU3B2N0pCZ1ZObzh3cEFMeHpQVjdhcjk5VmQ1?=
 =?utf-8?B?WkhCL3M0dktjcThoSGwxZk83OTFuVUVSQU9yVG9JV1NMRVlBU1ZNcVJEWjI3?=
 =?utf-8?B?c1NhMlp5WEQvZWZuY3Q4RTVtYzBLNElqbWthZUVDeWNXQzM0SElrY3BpcVNC?=
 =?utf-8?B?a00xdTJwWnpGVURIZHU0Nklqa0FDU21HNlJWM3FzaGJsVlBQYWUzQ2RtSWt0?=
 =?utf-8?B?Um5zTmRZVmEwWTBNcGdDSUowaVJkWEJoaEpocW52bHYwZEI4TDZ2SW8xZk5T?=
 =?utf-8?B?TzFDWGdXamJVSlVRT3BDejdpVGxkN3JKUGU2alNaKy9aUHFJVzE2dXljZUZV?=
 =?utf-8?B?bTF3eUJENVhiRmE1bHlIUDBCeTU5a2pBS1ZQdlZTQTIweFp2T3FoYjFHSEc1?=
 =?utf-8?B?ZFVPTmpnZUZlNWxXT2VsU0NPRThFWGRqTUdnOVRXU3dWUHlOU21CMktFVTZR?=
 =?utf-8?B?akJiU2dEYzJDdnp0b0RFdCt2TXRkWm5RbnM4WGpOMW8zakF3QzMwKy96RGpq?=
 =?utf-8?Q?ZDIoius9gj0Rjd+uKHkeE+g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAE3DA9C58F5B446A3610336EFDBAF12@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f7942f-cdb4-4940-15d0-08dbc010fe37
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 10:52:21.9741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+4ZHuTKuTBFXBuEfSEmaI2VWmPgGnFeYuPSHOrIhvAC2XeJmNjfi2aZ3mDcOXdw56sHckSQCh+6TqYtEcZ8Fne5x0Hk9HW9gcR3ICBwdnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9636
X-Proofpoint-GUID: qn1-alA-iNBBbYIaDSNAi4_eRx2bl7jM
X-Proofpoint-ORIG-GUID: qn1-alA-iNBBbYIaDSNAi4_eRx2bl7jM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_08,2023-09-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 mlxlogscore=929 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.12.0-2309180000 definitions=main-2309280091
Received-SPF: pass client-ip=148.163.133.242;
 envelope-from=prvs=4635f55f55=oleksandr_tyshchenko@epam.com;
 helo=mx0a-0039f301.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDI4LjA5LjIzIDEyOjQ0LCBNaWNoYWwgT3J6ZWwgd3JvdGU6DQoNCkhlbGxvIE1pY2hh
bA0KDQo+IE9uIGFuIGF0dGVtcHQgdG8gYWNjZXNzIENOVFBDVF9FTDAgZnJvbSBFTDAgdXNpbmcg
YSBndWVzdCBydW5uaW5nIG9uIHRvcA0KPiBvZiBYZW4sIGEgdHJhcCBmcm9tIEVMMiB3YXMgb2Jz
ZXJ2ZWQgd2hpY2ggaXMgc29tZXRoaW5nIG5vdCByZXByb2R1Y2libGUNCj4gb24gSFcgKGFsc28s
IFhlbiBkb2VzIG5vdCB0cmFwIGFjY2Vzc2VzIHRvIHBoeXNpY2FsIGNvdW50ZXIpLg0KPiANCj4g
VGhpcyBpcyBiZWNhdXNlIGd0X2NvdW50ZXJfYWNjZXNzKCkgY2hlY2tzIGZvciBhbiBpbmNvcnJl
Y3QgYml0ICgxDQo+IGluc3RlYWQgb2YgMCkgb2YgQ05USENUTF9FTDIgaWYgSENSX0VMMi5FMkgg
aXMgMCBhbmQgYWNjZXNzIGlzIG1hZGUgdG8NCj4gcGh5c2ljYWwgY291bnRlci4gUmVmZXIgQVJN
IEFSTSBEREkgMDQ4N0ouYSwgRDE5LjEyLjI6DQo+IFdoZW4gSENSX0VMMi5FMkggaXMgMDoNCj4g
ICAtIEVMMVBDVEVOLCBiaXQgWzBdOiByZWZlcnMgdG8gcGh5c2ljYWwgY291bnRlcg0KPiAgIC0g
RUwxUENFTiwgYml0IFsxXTogcmVmZXJzIHRvIHBoeXNpY2FsIHRpbWVyIHJlZ2lzdGVycw0KPiAN
Cj4gRHJvcCBlbnRpcmUgYmxvY2sgImlmIChoY3IgJiBIQ1JfRTJIKSB7Li4ufSBlbHNlIHsuLi59
IiBmcm9tIEVMMCBjYXNlDQo+IGFuZCBmYWxsIHRocm91Z2ggdG8gRUwxIGNhc2UsIGdpdmVuIHRo
YXQgYWZ0ZXIgZml4aW5nIGNoZWNraW5nIGZvciB0aGUNCj4gY29ycmVjdCBiaXQsIHRoZSBoYW5k
bGluZyBpcyB0aGUgc2FtZS4NCj4gDQo+IEZpeGVzOiA1YmM4NDM3MTM2ZmIgKCJ0YXJnZXQvYXJt
OiBVcGRhdGUgdGltZXIgYWNjZXNzIGZvciBWSEUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwg
T3J6ZWwgPG1pY2hhbC5vcnplbEBhbWQuY29tPg0KPiAtLS0NCj4gVGhpcyBpcyBub3cgaW4gY29u
Zm9ybWFuY2UgdG8gQVJNIEFSTSBDTlRQQ1RfRUwwIHBzZXVkb2NvZGU6DQo+IGlmIFBTVEFURS5F
TCA9PSBFTDAgdGhlbg0KPiAuLi4NCj4gICAgICBlbGlmIEVMMkVuYWJsZWQoKSAmJiBIQ1JfRUwy
LkUySCA9PSAnMCcgJiYgQ05USENUTF9FTDIuRUwxUENURU4gPT0gJzAnIHRoZW4NCj4gICAgICAg
ICAgQUFyY2g2NC5TeXN0ZW1BY2Nlc3NUcmFwKEVMMiwgMHgxOCk7DQo+IA0KPiBDaGFuZ2VzIGlu
IHYyOg0KPiAgIC0gZHJvcCBibG9jayBhbmQgZmFsbCB0aHJvdWdoIHRvIGF2b2lkIGR1cGxpY2F0
aW9uDQoNCg0KDQpUaGUgVjIgYWxzbyB3b3Jrcywgc28gbXkgdGFnIGlzIHN0aWxsIHZhbGlkOg0K
DQpbd2l0aCBaZXBoeXIgcnVubmluZyBhcyBYZW4gZ3Vlc3QgYW5kIGFjY2Vzc2luZyBDTlRQQ1Rf
RUwwIGZyb20gRUwwXQ0KDQpUZXN0ZWQtYnk6IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2Fu
ZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4NCg0KDQoNCj4gLS0tDQo+ICAgdGFyZ2V0L2FybS9oZWxw
ZXIuYyB8IDE3ICstLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2hl
bHBlci5jIGIvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPiBpbmRleCA4MzYyMDc4N2I0NTMuLjU5NTc2
YWExNTc1YSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2FybS9oZWxwZXIuYw0KPiArKysgYi90YXJn
ZXQvYXJtL2hlbHBlci5jDQo+IEBAIC0yNDc1LDIyICsyNDc1LDcgQEAgc3RhdGljIENQQWNjZXNz
UmVzdWx0IGd0X2NvdW50ZXJfYWNjZXNzKENQVUFSTVN0YXRlICplbnYsIGludCB0aW1lcmlkeCwN
Cj4gICAgICAgICAgIGlmICghZXh0cmFjdDMyKGVudi0+Y3AxNS5jMTRfY250a2N0bCwgdGltZXJp
ZHgsIDEpKSB7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIENQX0FDQ0VTU19UUkFQOw0KPiAgICAg
ICAgICAgfQ0KPiAtDQo+IC0gICAgICAgIC8qIElmIEhDUl9FTDIuPEUySCxUR0U+ID09ICcxMCc6
IGNoZWNrIENOVEhDVExfRUwyLkVMMVBDVEVOLiAqLw0KPiAtICAgICAgICBpZiAoaGNyICYgSENS
X0UySCkgew0KPiAtICAgICAgICAgICAgaWYgKHRpbWVyaWR4ID09IEdUSU1FUl9QSFlTICYmDQo+
IC0gICAgICAgICAgICAgICAgIWV4dHJhY3QzMihlbnYtPmNwMTUuY250aGN0bF9lbDIsIDEwLCAx
KSkgew0KPiAtICAgICAgICAgICAgICAgIHJldHVybiBDUF9BQ0NFU1NfVFJBUF9FTDI7DQo+IC0g
ICAgICAgICAgICB9DQo+IC0gICAgICAgIH0gZWxzZSB7DQo+IC0gICAgICAgICAgICAvKiBJZiBI
Q1JfRUwyLjxFMkg+ID09IDA6IGNoZWNrIENOVEhDVExfRUwyLkVMMVBDRU4uICovDQo+IC0gICAg
ICAgICAgICBpZiAoaGFzX2VsMiAmJiB0aW1lcmlkeCA9PSBHVElNRVJfUEhZUyAmJg0KPiAtICAg
ICAgICAgICAgICAgICFleHRyYWN0MzIoZW52LT5jcDE1LmNudGhjdGxfZWwyLCAxLCAxKSkgew0K
PiAtICAgICAgICAgICAgICAgIHJldHVybiBDUF9BQ0NFU1NfVFJBUF9FTDI7DQo+IC0gICAgICAg
ICAgICB9DQo+IC0gICAgICAgIH0NCj4gLSAgICAgICAgYnJlYWs7DQo+IC0NCj4gKyAgICAgICAg
LyogZmFsbCB0aHJvdWdoICovDQo+ICAgICAgIGNhc2UgMToNCj4gICAgICAgICAgIC8qIENoZWNr
IENOVEhDVExfRUwyLkVMMVBDVEVOLCB3aGljaCBjaGFuZ2VzIGxvY2F0aW9uIGJhc2VkIG9uIEUy
SC4gKi8NCj4gICAgICAgICAgIGlmIChoYXNfZWwyICYmIHRpbWVyaWR4ID09IEdUSU1FUl9QSFlT
ICYm

