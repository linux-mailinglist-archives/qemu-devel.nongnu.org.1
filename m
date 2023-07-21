Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF0975CA9C
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrRu-0003CR-UP; Fri, 21 Jul 2023 10:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRs-00033v-Cv
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qMrRo-0004nh-ET
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:49:38 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36LBsHB5004497; Fri, 21 Jul 2023 07:49:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=+6llMYzHdp3fRPNmOAVlmXSqEzZSuuZRAKvWho
 1eZlY=; b=UQEIgVPLh4MZD2g/2FsKwHbB6fvcmtf9zyuvz3W0AbyJf3M0lD58lH
 fMmb9Edm0wasP6WELesSfYVFUnFGnywfMQAFF7+5CEmAFDnu6kqB3ZCbAxDLrfrb
 +j34KYb+bctKIjBn4hLB9hfOBhpLeVjr2dF0enID8zpnHisFwzHI8/UqWGxqepN6
 Ug2b3ZzfRiVHFyn34MXar4eftnw+7USYITNEc5tmn2ECeIRGLiZnsyiTi7JZr73w
 etIJsFcTGAB0sw4XsPO5njUojnfZgawBuB0t+XfHcTMqgkRMLyTPoIyyHlRzDEkM
 iLaC732GPIDSz7iZeY/iRv3p+Ndm6B9Q==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rx2jdejxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 07:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9euuYND5wJXb/54Km7hif6LC/TYdLQ0JtJbpMEx/v2g/fRcTbYCTkk0U+2F+2vPHgkiciBOa1UwCluVlRWKh73Jg8BARehDZQePci6ZLbJhCZdOCin8ntO+USBPlxtYNIiMVl4viRsatg7BukTtVOTu71hPNgb8+fSU2xvk0myROcJrqPWhmnLfnehqmG38nhDA5uK9KC6XNL8/rlZP86F1+M5S1vtvBdMRGBGEp7uA9JDmA7XLTOwdSZPdArmK1mV/3lj8rbXAQxT/kdckPpMV7FQvKQVhbDisykMwMd8ntIJ95IXZUK4dR+/aXz4sXYNEKJ6so3dCEwhsuuD23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6llMYzHdp3fRPNmOAVlmXSqEzZSuuZRAKvWho1eZlY=;
 b=m77bM4PT7CZHeCR1ChlzJeAL4U1NhSNrlPHVQS+1fceMZbWkYVmEQ/Lzg2YBc4l6NT/QGl+Y/wa3jWMPxbmY2aaMn2knOdIE/KrmG+5q8XlevtgtwKRJmr7RVvaYee50tvVf4K9akb44sdBNrPWmoNiz6oYoAVIqIr/T4m47r7ZRp//jCNpF7Np7ByXk6Wjrz2IyD7uSypMjXoh6gJ4bAbCJGTZ37ye3DlK4NKdJHGMByq0JW2Haakx/4D8FUOdDmrSOmo51zf1Rgenq9XVIA3he5fqWqXkR7J3Uo0/3SLva4lhQKPFZQ5rosd7Yk3pP1LObCv4MBR0/Rw4Lyz2QRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6llMYzHdp3fRPNmOAVlmXSqEzZSuuZRAKvWho1eZlY=;
 b=YtsBwLijOoreVGjyyhmcCyQYt0BDMuB00n7kZexUQ/WYh4At5Jq/U/mAB2P6PXLYQAzSKTIfBHr2aApolIbUPnLJnd1Mm58INz9naKNQ+t265MVA44Y3eSGJb/8oYkTULkuPuTQOo/WHUwiaXkVgziFWpx2jkaeKyq7+yhTu/8TuT44gSl9R1k2KhdxIxnoj+IJW6/+58sX5iELk1My2/4/CiEg7mulnuCOEGvao27JpzsJiihq5KMgrOtkVz9Swizwr7q5ubrnkpJcGWXwaCFtQRz4Ey7bYW3mJTNPMqgHNJZKSozNS2kihBjQzcBMwEdCpx9Nw4OZkohesu/CKQQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA2PR02MB7561.namprd02.prod.outlook.com (2603:10b6:806:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:49:32 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 14:49:32 +0000
From: Het Gala <het.gala@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Prerna Saxena <prerna.saxena@nutanix.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v9 07/10] migration: modify
 migration_channels_and_uri_compatible() for new QAPI syntax
Thread-Topic: [PATCH v9 07/10] migration: modify
 migration_channels_and_uri_compatible() for new QAPI syntax
Thread-Index: Adm74o9RITolK2NQX0i65VwVxFZA3A==
Date: Fri, 21 Jul 2023 14:49:32 +0000
Message-ID: <20230721144914.170991-8-het.gala@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
In-Reply-To: <20230721144914.170991-1-het.gala@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::17) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4343:EE_|SA2PR02MB7561:EE_
x-ms-office365-filtering-correlation-id: d016f1aa-8665-479d-bbf8-08db89f9b1d1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GsPet6oerRMtPDK4rhhJxVJu+OdI9dBsPVr8cW7Fcl0Etar1ygupeJtjSzMqk0gCca6RIMzQR2et+6V87YHOI7XFK8/YURl8pdRqnHI/rYnvPJro7sqjuIb5j+VrAhcariwYK0yec/hEIItGheDOqlnGar1SkZ6fruvXwYmyAL9Nne5p2OIKtYE6RJj6VGrkn2qsetPFXFc/JfbPYZUn9DfV0IgANU1EDRIFa4LePQ+WywcdLorIEkb8sQs0j4x3PoVLAFzpUDbQ0QvuJeMebXsJypBkluaQpXdrtMcdkZK2esSqPmU1qHZAgIw0wvAIPzxKaCZC/FjJsxBiiFho5HQEdwp+1rMD+sBhZdyemYWAMdJrO4wRRof0NfGC+GsFiiotw+N2xCGhqprWwYrZfElzmXOlaQM/q/4xZ4Y7w7sTW9SpKHDMRMpzAdeDFVJrvhvM6hYc4kQ3V4hz9bFMWu8zn8dHcEem3fOcJ6PjQDxBweHyefCqxRhtMpcQVsRnkZdsJsyyjnXJw91TDz9jIw2J5CRh4akjWjRoxqoA5B2eE6UCHFsdiYsDk1cZLgmLMS1+xSp6yrg5rSY0oflF5L/9rpVmwdKgijla6LDBta+iwZbKhA9LGkRIWe6/bQZ4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2616005)(6486002)(52116002)(6512007)(71200400001)(478600001)(86362001)(26005)(1076003)(107886003)(6506007)(36756003)(5660300002)(4326008)(44832011)(6916009)(41300700001)(8936002)(8676002)(316002)(2906002)(122000001)(38100700002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(38350700002)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVRLOG5FMkUvM2F0WkpWMFd3MS91TDJDZVdVbGpsdU9mdlBvbHIxQ0x2VkhX?=
 =?utf-8?B?RXVoemRySkV0d0tQWmhWK0hsTXE0VVY5b3VUYlR0dE84QmUzZTUvVGhST1oy?=
 =?utf-8?B?VDVhbndXNVcySFZoM0l0SGtUNGlQSEdiOE5HY3VsUzlHMnhXQ200SEltWnRF?=
 =?utf-8?B?L2xmd1NFcGpoUGFES0VKeUhDU3p2NnJ5NWdVN0tFOVFXR016ZjZ4WVBZQ2lS?=
 =?utf-8?B?alN1NFZGdTRIb2JJOTFOZmI0b1BOaEFWRzE3emtWemdJQm9FbGxFUUdRWXdk?=
 =?utf-8?B?R2pSYVRJRTlqdFhaSVNsVEJNYjF4dlp3VVc4cW9GUnl4ckFTYmY1d3hQbzVY?=
 =?utf-8?B?aU1xYzJzcnNOemRYZ05aL2M5ZEs1ZmtzSzBOZzUya3hLYXV1Yk5BSHJ4Y25q?=
 =?utf-8?B?YzlyY3VjN2JXU3N2eCttN2RBT1ZuL1NXSHNxbHY2dlFxMHpDejFpRGUxcWJ5?=
 =?utf-8?B?ZktGS1lMdFNXZDNNRlRidDkxRUlKeHlzV3JYYW85T0pjaXAyRE1wQ1RzSlk4?=
 =?utf-8?B?VGc3L0Nxa3J5ZkZTS3Q5WUJna3dZWmxmZXZ1RUlTV1doYmN2V3ZIWXpNTjNa?=
 =?utf-8?B?LzBsMEwxd2sra04xSDNiSnlZZGVaeDRCWDlWMkdWeUlOT2RDSnIzWmhLZkNR?=
 =?utf-8?B?VThsSmJPeHBuYU9raGVwYk1uK1FxYllkT21jb1A2ZnlHN0dwS1U1dy9vYzly?=
 =?utf-8?B?VkhWZDVGVEFrNUZzMk5mSXc5Wjg1RGdFL0ZuMUZuWndqem9ENHplSFV3cGp0?=
 =?utf-8?B?MFhTSEdvWVZMMU1JdFN1N0czWFhvUVJzeGdjcXQxWWd5VU9NU0RkSU1iT05t?=
 =?utf-8?B?dXBWbVZZaWRPNmZ0M2kwcjBFTlFENFBKZmVFbUpPQVU0RFZnMDFua3BNdU9T?=
 =?utf-8?B?WG1KanJEdUJsOTI1VmEyTnZhSncxMi9UMU5aalJWMmlOckVyKzFOcUlXb0lI?=
 =?utf-8?B?QVBPWUkvV09yMkdGS01ldC81dUNmSlpkSXMzQlNneVJJeDhONUpzSHlBY29C?=
 =?utf-8?B?ZzZGYnpkL3puc2hUSzc1MG1GbVJaNGx1bnRtbG5uZ2UvTXNKQmJ2Sk9maGdO?=
 =?utf-8?B?U2ExcTlrb1dNc2FrSERSOVR3MEIvSlUzd1BxbEYvdjJOZStHZFhWRTc4emFL?=
 =?utf-8?B?eWRRNXlLdjliR2czbUhFTG8rcnNSdGFCSXdieHV2Q2s4Z1d5YnVVNnFJQkJK?=
 =?utf-8?B?czRUV1VMdTM0MjE2Vm5nVlhSbTlRRVltZFJ6RmozVnRhd2Q3aU02c1hkRXNa?=
 =?utf-8?B?REMxU0dEdmgvVEZWU01YUnlaQXVSeElXcFhKZ2ViVThuYkVLaXpHaWd6a3or?=
 =?utf-8?B?aHJCMThEVHRvSGFjbXMzUWhlRktHMHE3VzYzL1JpbWNjQkdpemRUcFFWTWc5?=
 =?utf-8?B?TFJ5a1B0RSt6WGNsU1VIRkRvbmMzS3hpYW9Ea01BNzNzR1NTNUR5bzNRYlFI?=
 =?utf-8?B?WWVyZkhjenJSTWUrdXZ1UjFmTHlkVFhRL2JlNmd5bVNodUUzaGdCbE5YQkRD?=
 =?utf-8?B?VXBPRU5LNUM3N21PNCsvajhQa0lrTys1d01oazZxbTdiNHYxK01IRHVJQjZ4?=
 =?utf-8?B?MC9kOWxlS3ZhU2U4dTM0VVZKZEc5NDFWQXZjQU04RDZHOUk3b0hWMEthSVV6?=
 =?utf-8?B?VmtLL2Fpc0VqMWNsNytjUVZHdFhFalEyT21pbFQ4TVZmTTJqdGxHcWtNbFI5?=
 =?utf-8?B?UithT013NndYeFVOTFpDeGI1c0lmL0doamo5ZHJ4MlUyUFpUL3V5NjJmdzVk?=
 =?utf-8?B?NU9GT2cxRTZQbDJ2bmJ3ZGIwdzZnc2JGRFNCbHo4dzJvRzFmc2ZIbExrblBC?=
 =?utf-8?B?N3ZVSTAxV3RFZzI0ZGo5SE92U1pwa2JKWEpIUWxpN09PVWRRTUQ5TzlmMEdx?=
 =?utf-8?B?cm45bTVScnBuZW1GYk41ZWhvY1dkRHhGeGt2OURDdzM0eTFURkd1UU8xbW9r?=
 =?utf-8?B?MW5adUR0UXE0d2RwK3luYjdiRlQvWEw5dVZ6akdYRHR3WVluVCtGWWtoVERR?=
 =?utf-8?B?bk1BYlZkakoyNSsxTGthWFpWbEdRaWF3UTZod1E5ZWhqT2p3M0k1Vk5MdURB?=
 =?utf-8?B?Sm5uWEoyYnFHcC9sSWV1T1RQMVFaem0zOEx3SUdMb0sxaXlhS0UzR3dIYVBV?=
 =?utf-8?B?ejRncWp2WFBKZlNBZmZDdjlsekFWcGcyazdDY2I5RFgvTWNqc25SYi8wRklE?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56BEF17733B02443B5D22A66FA38514A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d016f1aa-8665-479d-bbf8-08db89f9b1d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:49:32.5729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FXAcWOIN+XhDTjgwEqr6+5jTpY40y5Rd2O07oLMyt5GGXQs8th7kuZXWSZnZO07bcshdf5SnkgsOl6nmei7kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7561
X-Proofpoint-GUID: iOEEb2QRFyG6VipJn9nsqwkI6usSDbyX
X-Proofpoint-ORIG-GUID: iOEEb2QRFyG6VipJn9nsqwkI6usSDbyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_09,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

bWlncmF0aW9uX2NoYW5uZWxzX2FuZF91cmlfY29tcGF0aWJsZSgpIGNoZWNrIGZvciB0cmFuc3Bv
cnQgbWVjaGFuaXNtDQpzdWl0YWJsZSBmb3IgbXVsdGlmZCBtaWdyYXRpb24gZ2V0cyBleGVjdXRl
ZCB3aGVuIHRoZSBjYWxsZXIgY2FsbHMgb2xkDQp1cmkgc3ludGF4LiBJdCBuZWVkcyBpdCB0byBi
ZSBydW4gd2hlbiB1c2luZyB0aGUgbW9kZXJuIE1pZ3JhdGVDaGFubmVsDQpRQVBJIHN5bnRheCB0
b28uDQoNCkFmdGVyIFVSSSAtPiAnTWlncmF0ZUNoYW5uZWwnIDoNCm1pZ3JhdGlvbl9jaGFubmVs
c19hbmRfdXJpX2NvbXBhdGlibGUoKSAtPg0KbWlncmF0aW9uX2NoYW5uZWxzX2FuZF90cmFuc3Bv
cnRfY29tcGF0aWJsZSgpIHBhc3NlcyBvYmplY3QgYXMgYXJndW1lbnQNCmFuZCBjaGVjayBmb3Ig
dmFsaWQgdHJhbnNwb3J0IG1lY2hhbmlzbS4NCg0KU3VnZ2VzdGVkLWJ5OiBBcmF2aW5kIFJldG5h
a2FyYW4gPGFyYXZpbmQucmV0bmFrYXJhbkBudXRhbml4LmNvbT4NClNpZ25lZC1vZmYtYnk6IEhl
dCBHYWxhIDxoZXQuZ2FsYUBudXRhbml4LmNvbT4NClJldmlld2VkLWJ5OiBEYW5pZWwgUC4gQmVy
cmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KLS0tDQogbWlncmF0aW9uL21pZ3JhdGlvbi5j
IHwgMjUgKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9taWdy
YXRpb24uYyBiL21pZ3JhdGlvbi9taWdyYXRpb24uYw0KaW5kZXggYmQzYTkzZmM4Yy4uNmUwYThi
ZWFmMiAxMDA2NDQNCi0tLSBhL21pZ3JhdGlvbi9taWdyYXRpb24uYw0KKysrIGIvbWlncmF0aW9u
L21pZ3JhdGlvbi5jDQpAQCAtMTA0LDE3ICsxMDQsMjAgQEAgc3RhdGljIGJvb2wgbWlncmF0aW9u
X25lZWRzX211bHRpcGxlX3NvY2tldHModm9pZCkNCiAgICAgcmV0dXJuIG1pZ3JhdGVfbXVsdGlm
ZCgpIHx8IG1pZ3JhdGVfcG9zdGNvcHlfcHJlZW1wdCgpOw0KIH0NCiANCi1zdGF0aWMgYm9vbCB1
cmlfc3VwcG9ydHNfbXVsdGlfY2hhbm5lbHMoY29uc3QgY2hhciAqdXJpKQ0KK3N0YXRpYyBib29s
IHRyYW5zcG9ydF9zdXBwb3J0c19tdWx0aV9jaGFubmVscyhTb2NrZXRBZGRyZXNzICpzYWRkcikN
CiB7DQotICAgIHJldHVybiBzdHJzdGFydCh1cmksICJ0Y3A6IiwgTlVMTCkgfHwgc3Ryc3RhcnQo
dXJpLCAidW5peDoiLCBOVUxMKSB8fA0KLSAgICAgICAgICAgc3Ryc3RhcnQodXJpLCAidnNvY2s6
IiwgTlVMTCk7DQorICAgIHJldHVybiBzYWRkci0+dHlwZSA9PSBTT0NLRVRfQUREUkVTU19UWVBF
X0lORVQgfHwNCisgICAgICAgICAgIHNhZGRyLT50eXBlID09IFNPQ0tFVF9BRERSRVNTX1RZUEVf
VU5JWCB8fA0KKyAgICAgICAgICAgc2FkZHItPnR5cGUgPT0gU09DS0VUX0FERFJFU1NfVFlQRV9W
U09DSzsNCiB9DQogDQogc3RhdGljIGJvb2wNCi1taWdyYXRpb25fY2hhbm5lbHNfYW5kX3VyaV9j
b21wYXRpYmxlKGNvbnN0IGNoYXIgKnVyaSwgRXJyb3IgKiplcnJwKQ0KK21pZ3JhdGlvbl9jaGFu
bmVsc19hbmRfdHJhbnNwb3J0X2NvbXBhdGlibGUoTWlncmF0aW9uQWRkcmVzcyAqYWRkciwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkN
CiB7DQogICAgIGlmIChtaWdyYXRpb25fbmVlZHNfbXVsdGlwbGVfc29ja2V0cygpICYmDQotICAg
ICAgICAhdXJpX3N1cHBvcnRzX211bHRpX2NoYW5uZWxzKHVyaSkpIHsNCisgICAgICAgIChhZGRy
LT50cmFuc3BvcnQgPT0gTUlHUkFUSU9OX0FERFJFU1NfVFlQRV9TT0NLRVQpICYmDQorICAgICAg
ICAhdHJhbnNwb3J0X3N1cHBvcnRzX211bHRpX2NoYW5uZWxzKCZhZGRyLT51LnNvY2tldCkpIHsN
CiAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk1pZ3JhdGlvbiByZXF1aXJlcyBtdWx0aS1jaGFu
bmVsIFVSSXMgKGUuZy4gdGNwKSIpOw0KICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICB9DQpA
QCAtNDgyLDEyICs0ODUsMTIgQEAgc3RhdGljIHZvaWQgcWVtdV9zdGFydF9pbmNvbWluZ19taWdy
YXRpb24oY29uc3QgY2hhciAqdXJpLCBib29sIGhhc19jaGFubmVscywNCiAgICAgICAgIHJldHVy
bjsNCiAgICAgfQ0KIA0KLSAgICAvKiBVUkkgaXMgbm90IHN1aXRhYmxlIGZvciBtaWdyYXRpb24/
ICovDQotICAgIGlmICghbWlncmF0aW9uX2NoYW5uZWxzX2FuZF91cmlfY29tcGF0aWJsZSh1cmks
IGVycnApKSB7DQorICAgIGlmICh1cmkgJiYgIW1pZ3JhdGVfdXJpX3BhcnNlKHVyaSwgJmNoYW5u
ZWwsIGVycnApKSB7DQogICAgICAgICByZXR1cm47DQogICAgIH0NCiANCi0gICAgaWYgKHVyaSAm
JiAhbWlncmF0ZV91cmlfcGFyc2UodXJpLCAmY2hhbm5lbCwgZXJycCkpIHsNCisgICAgLyogdHJh
bnNwb3J0IG1lY2hhbmlzbSBub3Qgc3VpdGFibGUgZm9yIG1pZ3JhdGlvbj8gKi8NCisgICAgaWYg
KCFtaWdyYXRpb25fY2hhbm5lbHNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxlKGNoYW5uZWwsIGVy
cnApKSB7DQogICAgICAgICByZXR1cm47DQogICAgIH0NCiANCkBAIC0xNzE4LDEyICsxNzIxLDEy
IEBAIHZvaWQgcW1wX21pZ3JhdGUoY29uc3QgY2hhciAqdXJpLCBib29sIGhhc19jaGFubmVscywN
CiAgICAgICAgIHJldHVybjsNCiAgICAgfQ0KIA0KLSAgICAvKiBVUkkgaXMgbm90IHN1aXRhYmxl
IGZvciBtaWdyYXRpb24/ICovDQotICAgIGlmICghbWlncmF0aW9uX2NoYW5uZWxzX2FuZF91cmlf
Y29tcGF0aWJsZSh1cmksIGVycnApKSB7DQorICAgIGlmICghbWlncmF0ZV91cmlfcGFyc2UodXJp
LCAmY2hhbm5lbCwgZXJycCkpIHsNCiAgICAgICAgIHJldHVybjsNCiAgICAgfQ0KIA0KLSAgICBp
ZiAoIW1pZ3JhdGVfdXJpX3BhcnNlKHVyaSwgJmNoYW5uZWwsIGVycnApKSB7DQorICAgIC8qIHRy
YW5zcG9ydCBtZWNoYW5pc20gbm90IHN1aXRhYmxlIGZvciBtaWdyYXRpb24/ICovDQorICAgIGlm
ICghbWlncmF0aW9uX2NoYW5uZWxzX2FuZF90cmFuc3BvcnRfY29tcGF0aWJsZShjaGFubmVsLCBl
cnJwKSkgew0KICAgICAgICAgcmV0dXJuOw0KICAgICB9DQogDQotLSANCjIuMjIuMw0KDQo=

