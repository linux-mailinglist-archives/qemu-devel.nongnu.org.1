Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29561748E71
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 21:54:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8ZC-0006q7-Dt; Wed, 05 Jul 2023 15:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=0550481815=mikechoi@meta.com>)
 id 1qH6UF-0005b2-Aq; Wed, 05 Jul 2023 13:40:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=0550481815=mikechoi@meta.com>)
 id 1qH6UC-00073X-3v; Wed, 05 Jul 2023 13:40:19 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365HZaJP026734; Wed, 5 Jul 2023 10:38:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=s2048-2021-q4;
 bh=lDFFquyq3ulM0I8Cua61yQcYO1HwaZ4gpNZ+8ReAOG8=;
 b=mQqHS1B7wYN3mu7p1wuHVcGnJvVec/hS91e0PEQ4yxju9nEYIF6vjDEI4gMF57JZi/JT
 OtD6Qoy8zp5z3ofR4IGZHhmDa1eKGkvOnNuNV7QVlz1P4x/voQk/jE3GslhdD/QaCA9r
 sZdemwDB+/P4hYKGKlsEKvBXKXzGwXiQLiW4F+/WE7CC6n24ZW8EFWD6IhtipSGSaZfn
 5WYELp1cTxAo/m5FM4owOQJ2aFLfLpQeGWVi2vb2hG4fXKh8RjeK7YuBlXQuzhQC7u4E
 kexB9Rq8tclNKhV0Sv4CGPhCWUixHm3dugv2WD+qAYC68inOOdOTORjDOmpf2e3SZLqH Rw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rn167w3wj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 10:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5yFo1aMihFaLSbo9mQCvUHks2FJTebVU7Rcp6ucWedQ60g4vvHdAMFMCQQ3MWfa5x1zabfDmOt5mxy13Ov0vJUU59dm2GNmdLgkUkS7wY5+aHPcu7xTOQVL7PZ9ZfmfVBk6lh1f2ywnOfYTDrpVZr7IM+UNWSLs5qrX0OwpmisubNO940gTUIrO+AtMEjZcqPMKrZGuXl0vosxJ+dFEEUpUsy4nWXMQvDYesiYJtneUaTeyfdVi7EPB/elszP3AVMzNEBNtuDJc0BOkKtPSV/pOvuCC3tFd8iUa41Ly+X88sUVlR14mld4sazg327UZ3r3wr1yvrzmjDO4V31wfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKgHprbCdQvRoy+2p/BWjB5tDszT0WDTEUdRR0Bwt+M=;
 b=iUzJVaFbH756D/LHiKXCdQ52hJ/5vC8DeZNHsu32SY5pHhortc74Fu55FxE6uHo9ZNrQd1NuYPvpkdUhA9ADs+d0lWAiFcVeUuVSgL7hRVIf08b3fBqip3SddrQZ1OvVVl4pbwU+TPmvQX2kPicnCfSYUQpUJ3oS3JRrL6NWcLR0fMI9vAqzLt/LcfWVxxXbjngcl2QJNOGJut03jhZpx/VlqUhPhUkfx/pNIygs3I0dvPCtWkTUxwMGbEuxLvUM+g6FTXKDKzWPFufOM44wFvkDaRDF6ZMcwxW6sMMXAOg+DY9HMZBcdHgiNBL0RnHZPbe5UBN/BJ4vOYoNvzknxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3555.namprd15.prod.outlook.com (2603:10b6:a03:1f5::32)
 by SA1PR15MB5138.namprd15.prod.outlook.com (2603:10b6:806:232::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 17:38:16 +0000
Received: from BY5PR15MB3555.namprd15.prod.outlook.com
 ([fe80::70c6:7728:4fdb:c983]) by BY5PR15MB3555.namprd15.prod.outlook.com
 ([fe80::70c6:7728:4fdb:c983%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 17:38:16 +0000
From: Mike Choi <mikechoi@meta.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Sittisak Sinprem
 <ssinprem@celestica.com>, Bin Huang <binhuang@meta.com>, Tao Ren
 <taoren@meta.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "andrew@aj.id.au" <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "srikanth@celestica.com"
 <srikanth@celestica.com>, "ssumet@celestica.com" <ssumet@celestica.com>,
 "thangavelu.v@celestica.com" <thangavelu.v@celestica.com>,
 "kgengan@celestica.com" <kgengan@celestica.com>,
 "anandaramanv@celestica.com" <anandaramanv@celestica.com>
Subject: Re: [PATCH qemu v5] aspeed add montblanc bmc reference from fuji
Thread-Topic: [PATCH qemu v5] aspeed add montblanc bmc reference from fuji
Thread-Index: AQHZrntLMDXgpN7yl0exm1uEY1IYSq+ppLMAgAHMwbU=
Date: Wed, 5 Jul 2023 17:38:16 +0000
Message-ID: <BY5PR15MB3555BD84850525E4FF17E086AF2FA@BY5PR15MB3555.namprd15.prod.outlook.com>
References: <168846918238.25928.7102858062933368556-0@git.sr.ht>
 <3cda00c1-54f8-57db-8992-3cafa97d4564@kaod.org>
 <CAE+aGtX9qcaPXhEYyqDuW_PLsKY9bVXhWiWb=oMT+5X-AXg3zg@mail.gmail.com>
 <ad5ea665-dce2-46d3-de14-558db8694eb5@kaod.org>
In-Reply-To: <ad5ea665-dce2-46d3-de14-558db8694eb5@kaod.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3555:EE_|SA1PR15MB5138:EE_
x-ms-office365-filtering-correlation-id: 35a65553-4fb6-45d5-36b5-08db7d7e9d3a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XzIV0eljcs9ujqJpskiAakE0OuYkl/4FRdLd60l/ufRDOtSFJgHu/3KJd2iP3+cEkZMtblqgef62mEK/cm/dRR3V96Upg6mFav36+L+6/6Dq4nb2EjjCkpwBhnBeazCO5akASDOq4KdEEx5qaDGdBskOiwGcvhnuoCb6se1v9BrfByuxewUrZjwQaABZqB9fn3NsJ7lVHEVAFdwVnd04wXnwYE1fIm3lbsjsV2LPiQOUCqvSMdrfxK23L54XJPiZXhYbwNhLAQjyEpNRlmIDQRf7nVhPGP3yJQTYfMUwqttiaPp+Og5ggirWAQfNQU7FfDl6GTFp4yri9e7jg7cdDOxieJusloxPb4S4LIU6gfPPWUiQN7rtgm0s1n8iulDtQ+m5mAi2dGs0xuIhtwHMdxJu/QhdGVqM84b3gARaxUPyyDrMfbRQ8hU+2SoRdgYaD6jL5Y9jzb7sq8VcMD5CI8+GgNjnrBvjgqoqQbiHQs6HKpPJCMZPjkon7tb3hRXmzrP8GLSxkTro4hp8vFhomInjPODmt76ojzfEhtA7CNHXI+7d/2ILuGdkCZZx6zNeOBIDr8BRbnwCgiotI6/yEoNsqQOBaGOEC7kBO3n3Qd4aIfITNh5m9RwyVppQXE0F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR15MB3555.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(6506007)(478600001)(9686003)(71200400001)(86362001)(186003)(66556008)(38100700002)(54906003)(66476007)(53546011)(64756008)(6636002)(4326008)(66946007)(66446008)(19627235002)(66574015)(110136005)(83380400001)(76116006)(7696005)(122000001)(316002)(5660300002)(8676002)(52536014)(8936002)(7416002)(9326002)(38070700005)(30864003)(41300700001)(2906002)(55016003)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDBCc2l4YWZ3RS9zNTEvNE91Q1kvZHJpeFFqRExpbW91MUNKWHhTR1AwQURr?=
 =?utf-8?B?bklsd1FEM3hjQjlhbVlNVTk2L0dtZ2xVQk5PTHFZNE9jaVUvYzNnbUR6cXJj?=
 =?utf-8?B?djRzeE5UbGhGbGJOK3Nwd1k4Q3J6YWtRd2ZGbUtrWnFCc1JFZlZ6UkMya1Jl?=
 =?utf-8?B?UE1FQWQyQ1pkeDY3RWxUYTJMK1RTSzA5UURtKzlHYzhTbTJYMzVzOCtEREZV?=
 =?utf-8?B?dnhpUkY0YnF5dVZ3dzJwQkFHOGNXM3FrVUlaTm9aNXk0eEw5dUp0c01zVGNh?=
 =?utf-8?B?d1lCcGNyeUJycDFjSEhiWXUxd3hoTlBTZnNmUGRmc1lNdWdGQ0pUT1hhWEY0?=
 =?utf-8?B?WWNQMXZNeUlsM2NOZlpiVWUrZ2pXTEFGV0JFVS82T01EZ0gzMVB5SUZycEt1?=
 =?utf-8?B?aUErK1B3MDhiMlJ6M1pBU0Q0TWZSdzNObVJEODBYb2RoU1hWanBWR0l3dkdB?=
 =?utf-8?B?UUEyUU9GZWJ4YjlUZU1rVUtzK3JsQk05OURTSm84RTZtNnZVMzRtSTVhd1hR?=
 =?utf-8?B?cDhnOFZqNTBQTU8weHgwNXB6YmoveFdzUHpFSzJZNXhJTDBBaUxFcnJyNm1H?=
 =?utf-8?B?TWRVa2FFa3REbU9wcDU0ZHc1dWc0aEdvNGtqUGN1K3poczhOdkwvbUZzWnVy?=
 =?utf-8?B?a1RxMjFOTko2aWNDWVFsOFVNOE9iSS9oMkdvdDE5Um92Sno5TGJrUWZSSHEw?=
 =?utf-8?B?d3dVTkdoZE52YUhxR01LY2JUMUtzd2sxM1ZpUWF6OTlYL0EzaHlKOGY3dUJU?=
 =?utf-8?B?ZmJwNS9kSXpHcDZOdDQ2V0VsakphY2JaVnA0WlhGRU1WMmFNeUxLWTUxVVBp?=
 =?utf-8?B?R3k3ZUJycW92ODlWNExreW5rajJzWjdzMi9qZkRWQUI3WjlaeW45YXkxbzRQ?=
 =?utf-8?B?R2xlNG1QMFVlcFArcEd0aE1MOUxrTXR0T20rMFpkbm50TEF3RFNtZkI5VjJp?=
 =?utf-8?B?RDJ3L1dWVkFmSjI3OEtReFlHWFcyUG9GcHlDbDYySUtqSGhvMnR1TWFmZTNl?=
 =?utf-8?B?d3d6Njk2cnpVM0crRVNscWhHZTZiRnZ0ZVJpaHBxTXI0N0tnOFA2U2UxSTVY?=
 =?utf-8?B?WDJQZFRpNTQ1ekV1MjIyemtOUmZNazFHbHZYdHpZTDE5UVpQL3JGd1hqMTVE?=
 =?utf-8?B?eWNadzVyS00xcy9nYm4wRHhkeU9tRHJ6ZmVTL3lwemdDbGlndmFQd3JkRTNK?=
 =?utf-8?B?TVdYVjJ6aEpxVmZJd1h5S0ZpRlRVUUNIcEYyRkRTL2dtenpocEV2cW9OWlNl?=
 =?utf-8?B?STM2djlIMmp6NDYwTHBLMDNwZlVHbkhWcGtnT1NzWTFucjZFNmk2VG9KMlNq?=
 =?utf-8?B?Kzg1YjVxbHpoWU0ydFRoQlkyc3ladWZVZkFESmo1dTFMaUpJTnBiS3FjNkVn?=
 =?utf-8?B?cklndG9YWUt5V1NjODlhSmxVSTVzYUpWNERtbmpIdFRIQTI5V21mM2Q0LzZw?=
 =?utf-8?B?ZUdXQVZVMTlRKzVQcENhcUJNVndjcFFpVys5T0gvdjdNdDcveTdaQnA5cFJS?=
 =?utf-8?B?MkFCVmR0ZWlHVUEzeHM3K05zWXZzNmRBNVpveHUxTGU4ZTVVa1l2MzZ5WTAv?=
 =?utf-8?B?am9TQzBrRzBHN3RLL3g1Y0F1ZTRONFZmY0J0b2tUVGsvQUg2cEwvSy9kRjIz?=
 =?utf-8?B?TU8rcGN3TWtsQVJOekcrYUxyWFEwQS92b1VxN2RzZjBVUWU5Zy9yY3FxMkE1?=
 =?utf-8?B?M0xMY3JJOWlPREVRQ3kyMFFMM1J1d3ZMSk1tSjVtcXFxbEk1VVZZNVJzVXVh?=
 =?utf-8?B?QjZsbTZRWDRpaWdnMkFpK0MvOURvZ3lseDhTTHkwcGd4dEJ1L0pFWitXS0xq?=
 =?utf-8?B?cWN4a0xTdDlWeFBQMWIvRWlRVzRjTUx4eDBJaURCalpCS09TZFl4T2JZWE1y?=
 =?utf-8?B?ZkZ6bUhYSFpZZ29wYThWLysrcnVZeGJjU2Z6V3pCRFcvOWloWHd3THVIRzMr?=
 =?utf-8?B?MW9jcHdWeS9xMjZic2dyVVZhZjg5UUMySERnaVpyYm1OSGxwYk5pQTg1Sldt?=
 =?utf-8?B?alpicTNlTFZrM0NCZWUyY05YM2pDSW1hSDBmM3JZOGEzU1hpeWVBSTdQODh2?=
 =?utf-8?B?YVY0eVd2ekU2U0VEZEJHb3pNRG9jcERtZEUveHl2Slg2SVA4eUZnSHBDWmty?=
 =?utf-8?B?LzE1Y01BZmZqdEppQzRtVUI0TXNjYWpxL3ZvRmhQbm00Wk5zYkFqVnREN24y?=
 =?utf-8?Q?hVxXlbC0ovoJMtrLrjohUyo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR15MB3555BD84850525E4FF17E086AF2FABY5PR15MB3555namp_"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3555.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a65553-4fb6-45d5-36b5-08db7d7e9d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 17:38:16.0206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDlPBxnHs6TxAUcPX5bHac+8DVRbAlWtCGuPcGtImP7v91OiIlW/WOINvxW5/M+I9MGE/o+pJotpWzutCY/RnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5138
X-Proofpoint-GUID: wQ05kuO796BU3G9Yq0YfoVZov0oKzBfW
X-Proofpoint-ORIG-GUID: wQ05kuO796BU3G9Yq0YfoVZov0oKzBfW
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=0550481815=mikechoi@meta.com;
 helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Jul 2023 15:53:12 -0400
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

--_000_BY5PR15MB3555BD84850525E4FF17E086AF2FABY5PR15MB3555namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgU2l0dGlzYWssDQoNCk1pbmlwYWNrMyBpcyBub3Qgb3Blbi1zb3VyY2VkIHlldCwgYW5kIHdl
IGFyZSB1bmxpa2VseSB0byBiZSBhYmxlIHRvIHVwc3RyZWFtIGRldGFpbGVkIGRhdGEuDQoNCg0K
ICAxLiAgV2hhdCBpcyB0aGVzZSBGUlVJRCBkYXRhcyBmb3IsIGlzIGl0IGZvciB0ZXN0aW5nPw0K
ICAyLiAgV2hhdCBvdGhlciBvcHRpb24gZG8gd2UgaGF2ZSwgc2luY2Ugd2UgYXJlIG5vdCBhYmxl
IHRvIHVwc3RyZWFtIEZSVUlEIGRhdGEuIChJdCBpcyBzdGlsbCBPSyB0byB1cHN0cmVhbSBzeXN0
ZW0gY29uZmlndXJhdGlvbiwgYnV0IE5PVCB0aGUgYXJyYXlzIG9mIF9mcnVpZCBkYXRhIGFycmF5
KQ0KDQpUaGFua3MsDQpNaWtlDQoNCg0KRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9k
Lm9yZz4NCkRhdGU6IFR1ZXNkYXksIEp1bHkgNCwgMjAyMyBhdCA3OjA3IEFNDQpUbzogU2l0dGlz
YWsgU2lucHJlbSA8c3NpbnByZW1AY2VsZXN0aWNhLmNvbT4sIEJpbiBIdWFuZyA8YmluaHVhbmdA
bWV0YS5jb20+LCBUYW8gUmVuIDx0YW9yZW5AbWV0YS5jb20+LCBNaWtlIENob2kgPG1pa2VjaG9p
QG1ldGEuY29tPg0KQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUu
b3JnPiwgcWVtdS1hcm1Abm9uZ251Lm9yZyA8cWVtdS1hcm1Abm9uZ251Lm9yZz4sIHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZyA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiwgYW5kcmV3QGFqLmlk
LmF1IDxhbmRyZXdAYWouaWQuYXU+LCBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PiwgcWVt
dS1zdGFibGVAbm9uZ251Lm9yZyA8cWVtdS1zdGFibGVAbm9uZ251Lm9yZz4sIHNyaWthbnRoQGNl
bGVzdGljYS5jb20gPHNyaWthbnRoQGNlbGVzdGljYS5jb20+LCBzc3VtZXRAY2VsZXN0aWNhLmNv
bSA8c3N1bWV0QGNlbGVmb3Igc3RpY2EuY29tPiwgdGhhbmdhdmVsdS52QGNlbGVzdGljYS5jb20g
PHRoYW5nYXZlbHUudkBjZWxlc3RpY2EuY29tPiwga2dlbmdhbkBjZWxlc3RpY2EuY29tIDxrZ2Vu
Z2FuQGNlbGVzdGljYS5jb20+LCBhbmFuZGFyYW1hbnZAY2VsZXN0aWNhLmNvbSA8YW5hbmRhcmFt
YW52QGNlbGVzdGljYS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHFlbXUgdjVdIGFzcGVlZCBh
ZGQgbW9udGJsYW5jIGJtYyByZWZlcmVuY2UgZnJvbSBmdWppDQohLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCiAgVGhp
cyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQoNCnwtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KDQpP
biA3LzQvMjMgMTU6MjcsIFNpdHRpc2FrIFNpbnByZW0gd3JvdGU6DQo+IEhpIE1ldGEgVGVhbSwN
Cj4NCj4gdGhlIEZSVSBFRVBST00gY29udGVudCwgSSB0aGluayBmb3Igbm93IGRldGFpbCBzdGls
bCBiZSBjb25maWRlbnRpYWwsDQo+IFBsZWFzZSBjb25maXJtLCBDYW4gd2UgYWRkIHRoZSBkZXNj
cmlwdGlvbiBpbiBRZW11IHVwc3RyZWFtIGZvbGxvd2luZyBDZWRyaWMncyByZXF1ZXN0Pw0KDQpX
ZSBkb24ndCBuZWVkIGFsbCB0aGUgZGV0YWlscywgYW5kIG5vdCB0aGUgY29uZmlkZW50aWFsIHBh
cnQgb2YgY291cnNlLg0KDQpDLg0KDQo+DQo+IE9uIFR1ZSwgSnVsIDQsIDIwMjMgYXQgNjoxOeKA
r1BNIEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmcgPG1haWx0bzpjbGdAa2FvZC5vcmc+
PiB3cm90ZToNCj4NCj4gICAgIE9uIDcvNC8yMyAxMzowNiwgfnNzaW5wcmVtIHdyb3RlOg0KPiAg
ICAgID4gRnJvbTogU2l0dGlzYWsgU2lucHJlbSA8c3NpbnByZW1AY2VsZXN0aWNhLmNvbSA8bWFp
bHRvOnNzaW5wcmVtQGNlbGVzdGljYS5jb20+Pg0KPiAgICAgID4NCj4gICAgICA+IC0gSTJDIGxp
c3QgZm9sbG93IEkyQyBUcmVlIHYxLjYgMjAyMzAzMjANCj4gICAgICA+IC0gZnJ1IGVlcHJvbSBk
YXRhIHVzZSBGQiBGUlUgZm9ybWF0IHZlcnNpb24gNA0KPiAgICAgID4NCj4gICAgICA+IFNpZ25l
ZC1vZmYtYnk6IFNpdHRpc2FrIFNpbnByZW0gPHNzaW5wcmVtQGNlbGVzdGljYS5jb20gPG1haWx0
bzpzc2lucHJlbUBjZWxlc3RpY2EuY29tPj4NCj4NCj4gICAgIFlvdSBzaG9vdCB0b28gZmFzdCA6
KSBQbGVhc2UgYWRkIHNvbWUgZGVzY3JpcHRpb24gZm9yIHRoZSBFRVBST00gY29udGVudHMuDQo+
ICAgICBXaGF0IHRoZXkgZW5hYmxlIHdoZW4gdGhlIE9TL0ZXIGJvb3RzIGlzIGdvb2QgdG8ga25v
dyBmb3IgUUVNVS4NCj4NCj4gICAgIFRoYW5rcywNCj4NCj4gICAgIEMuDQo+DQo+DQo+ICAgICAg
PiAtLS0NCj4gICAgICA+ICAgZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QgfCAgMSArDQo+ICAg
ICAgPiAgIGh3L2FybS9hc3BlZWQuYyAgICAgICAgICAgIHwgNjUgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gICAgICA+ICAgaHcvYXJtL2FzcGVlZF9lZXByb20uYyAg
ICAgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgICAgID4gICBody9hcm0v
YXNwZWVkX2VlcHJvbS5oICAgICB8ICA3ICsrKysNCj4gICAgICA+ICAgNCBmaWxlcyBjaGFuZ2Vk
LCAxMjMgaW5zZXJ0aW9ucygrKQ0KPiAgICAgID4NCj4gICAgICA+IGRpZmYgLS1naXQgYS9kb2Nz
L3N5c3RlbS9hcm0vYXNwZWVkLnJzdCBiL2RvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0DQo+ICAg
ICAgPiBpbmRleCA4MDUzODQyMmExLi41ZTA4MjRmNDhiIDEwMDY0NA0KPiAgICAgID4gLS0tIGEv
ZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QNCj4gICAgICA+ICsrKyBiL2RvY3Mvc3lzdGVtL2Fy
bS9hc3BlZWQucnN0DQo+ICAgICAgPiBAQCAtMzMsNiArMzMsNyBAQCBBU1QyNjAwIFNvQyBiYXNl
ZCBtYWNoaW5lcyA6DQo+ICAgICAgPiAgIC0gYGB0YWNvbWEtYm1jYGAgICAgICAgICAgIE9wZW5Q
T1dFUiBXaXRoZXJzcG9vbiBQT1dFUjkgQVNUMjYwMCBCTUMNCj4gICAgICA+ICAgLSBgYHJhaW5p
ZXItYm1jYGAgICAgICAgICAgSUJNIFJhaW5pZXIgUE9XRVIxMCBCTUMNCj4gICAgICA+ICAgLSBg
YGZ1amktYm1jYGAgICAgICAgICAgICAgRmFjZWJvb2sgRnVqaSBCTUMNCj4gICAgICA+ICstIGBg
bW9udGJsYW5jLWJtY2BgICAgICAgICBGYWNlYm9vayBNb250YmxhbmMgQk1DDQo+ICAgICAgPiAg
IC0gYGBibGV0Y2hsZXktYm1jYGAgICAgICAgIEZhY2Vib29rIEJsZXRjaGxleSBCTUMNCj4gICAg
ICA+ICAgLSBgYGZieTM1LWJtY2BgICAgICAgICAgICAgRmFjZWJvb2sgZmJ5MzUgQk1DDQo+ICAg
ICAgPiAgIC0gYGBxY29tLWRjLXNjbS12MS1ibWNgYCAgIFF1YWxjb21tIERDLVNDTSBWMSBCTUMN
Cj4gICAgICA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVkLmMN
Cj4gICAgICA+IGluZGV4IDlmY2E2NDRkOTIuLmJiYjdhMzM5MmMgMTAwNjQ0DQo+ICAgICAgPiAt
LS0gYS9ody9hcm0vYXNwZWVkLmMNCj4gICAgICA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiAg
ICAgID4gQEAgLTE4OSw2ICsxODksMTAgQEAgc3RydWN0IEFzcGVlZE1hY2hpbmVTdGF0ZSB7DQo+
ICAgICAgPiAgICNkZWZpbmUgRlVKSV9CTUNfSFdfU1RSQVAxICAgIDB4MDAwMDAwMDANCj4gICAg
ICA+ICAgI2RlZmluZSBGVUpJX0JNQ19IV19TVFJBUDIgICAgMHgwMDAwMDAwMA0KPiAgICAgID4N
Cj4gICAgICA+ICsvKiBNb250YmxhbmMgaGFyZHdhcmUgdmFsdWUgKi8NCj4gICAgICA+ICsjZGVm
aW5lIE1PTlRCTEFOQ19CTUNfSFdfU1RSQVAxICAgIDB4MDAwMDAwMDANCj4gICAgICA+ICsjZGVm
aW5lIE1PTlRCTEFOQ19CTUNfSFdfU1RSQVAyICAgIDB4MDAwMDAwMDANCj4gICAgICA+ICsNCj4g
ICAgICA+ICAgLyogQmxldGNobGV5IGhhcmR3YXJlIHZhbHVlICovDQo+ICAgICAgPiAgIC8qIFRP
RE86IExlYXZlIHNhbWUgYXMgRVZCIGZvciBub3cuICovDQo+ICAgICAgPiAgICNkZWZpbmUgQkxF
VENITEVZX0JNQ19IV19TVFJBUDEgQVNUMjYwMF9FVkJfSFdfU1RSQVAxDQo+ICAgICAgPiBAQCAt
OTI1LDYgKzkyOSw0MSBAQCBzdGF0aWMgdm9pZCBmdWppX2JtY19pMmNfaW5pdChBc3BlZWRNYWNo
aW5lU3RhdGUgKmJtYykNCj4gICAgICA+ICAgICAgIH0NCj4gICAgICA+ICAgfQ0KPiAgICAgID4N
Cj4gICAgICA+ICtzdGF0aWMgdm9pZCBtb250YmxhbmNfYm1jX2kyY19pbml0KEFzcGVlZE1hY2hp
bmVTdGF0ZSAqYm1jKQ0KPiAgICAgID4gK3sNCj4gICAgICA+ICsgICAgQXNwZWVkU29DU3RhdGUg
KnNvYyA9ICZibWMtPnNvYzsNCj4gICAgICA+ICsgICAgSTJDQnVzICppMmNbMTZdID0ge307DQo+
ICAgICAgPiArDQo+ICAgICAgPiArICAgIGZvciAoaW50IGkgPSAwOyBpIDwgMTY7IGkrKykgew0K
PiAgICAgID4gKyAgICAgICAgaTJjW2ldID0gYXNwZWVkX2kyY19nZXRfYnVzKCZzb2MtPmkyYywg
aSk7DQo+ICAgICAgPiArICAgIH0NCj4gICAgICA+ICsNCj4gICAgICA+ICsgICAgLyogUmVmIGZy
b20gTWluaXBhY2szX0kyQ19UcmVlX1YxLjYgMjAyMzAzMjAgKi8NCj4gICAgICA+ICsgICAgYXQy
NGNfZWVwcm9tX2luaXRfcm9tKGkyY1szXSwgMHg1NiwgODE5MiwgbW9udGJsYW5jX3NjbV9mcnVp
ZCwNCj4gICAgICA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIG1vbnRibGFuY19zY21fZnJ1
aWRfbGVuKTsNCj4gICAgICA+ICsgICAgYXQyNGNfZWVwcm9tX2luaXRfcm9tKGkyY1s2XSwgMHg1
MywgODE5MiwgbW9udGJsYW5jX2ZjbV9mcnVpZCwNCj4gICAgICA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1vbnRibGFuY19mY21fZnJ1aWRfbGVuKTsNCj4gICAgICA+ICsNCj4gICAgICA+
ICsgICAgLyogQ1BMRCBhbmQgRlBHQSAqLw0KPiAgICAgID4gKyAgICBhdDI0Y19lZXByb21faW5p
dChpMmNbMV0sIDB4MzUsIDI1Nik7ICAvKiBTQ00gQ1BMRCAqLw0KPiAgICAgID4gKyAgICBhdDI0
Y19lZXByb21faW5pdChpMmNbNV0sIDB4MzUsIDI1Nik7ICAvKiBDT01lIENQTEQgVE9ETzogbmVl
ZCB0byB1cGRhdGUgKi8NCj4gICAgICA+ICsgICAgYXQyNGNfZWVwcm9tX2luaXQoaTJjWzEyXSwg
MHg2MCwgMjU2KTsgLyogTUNCIFBXUiBDUExEICovDQo+ICAgICAgPiArICAgIGF0MjRjX2VlcHJv
bV9pbml0KGkyY1sxM10sIDB4MzUsIDI1Nik7IC8qIElPQiBGUEdBICovDQo+ICAgICAgPiArDQo+
ICAgICAgPiArICAgIC8qIG9uIEJNQyBib2FyZCAqLw0KPiAgICAgID4gKyAgICBhdDI0Y19lZXBy
b21faW5pdF9yb20oaTJjWzhdLCAweDUxLCA4MTkyLCBtb250YmxhbmNfYm1jX2ZydWlkLA0KPiAg
ICAgID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgbW9udGJsYW5jX2JtY19mcnVpZF9sZW4p
OyAvKiBCTUMgRUVQUk9NICovDQo+ICAgICAgPiArICAgIGkyY19zbGF2ZV9jcmVhdGVfc2ltcGxl
KGkyY1s4XSwgVFlQRV9MTTc1LCAweDQ4KTsgLyogVGhlcm1hbCBTZW5zb3IgKi8NCj4gICAgICA+
ICsNCj4gICAgICA+ICsgICAgLyogQ09NZSBTZW5zb3IvRUVQUk9NICovDQo+ICAgICAgPiArICAg
IGF0MjRjX2VlcHJvbV9pbml0KGkyY1swXSwgMHg1NiwgMTYzODQpOyAgICAgICAgICAvKiBGUlUg
RUVQUk9NICovDQo+ICAgICAgPiArICAgIGkyY19zbGF2ZV9jcmVhdGVfc2ltcGxlKGkyY1swXSwg
VFlQRV9MTTc1LCAweDQ4KTsgLyogSU5MRVQgU2Vuc29yICovDQo+ICAgICAgPiArICAgIGkyY19z
bGF2ZV9jcmVhdGVfc2ltcGxlKGkyY1swXSwgVFlQRV9MTTc1LCAweDRBKTsgLyogT1VUTEVUIFNl
bnNvciAqLw0KPiAgICAgID4gKw0KPiAgICAgID4gKyAgICAvKiBJdCBleHBlY3RzIGEgcGNhOTU1
NSBidXQgYSBwY2E5NTUyIGlzIGNvbXBhdGlibGUgKi8NCj4gICAgICA+ICsgICAgY3JlYXRlX3Bj
YTk1NTIoc29jLCA0LCAweDI3KTsNCj4gICAgICA+ICt9DQo+ICAgICAgPiArDQo+ICAgICAgPiAg
ICNkZWZpbmUgVFlQRV9UTVA0MjEgInRtcDQyMSINCj4gICAgICA+DQo+ICAgICAgPiAgIHN0YXRp
YyB2b2lkIGJsZXRjaGxleV9ibWNfaTJjX2luaXQoQXNwZWVkTWFjaGluZVN0YXRlICpibWMpDQo+
ICAgICAgPiBAQCAtMTQ1Miw2ICsxNDkxLDI4IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9tYWNoaW5l
X2Z1amlfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+ICAgICAgPiAg
ICAgICAgICAgYXNwZWVkX3NvY19udW1fY3B1cyhhbWMtPnNvY19uYW1lKTsNCj4gICAgICA+ICAg
fTsNCj4gICAgICA+DQo+ICAgICAgPiArI2RlZmluZSBNT05UQkxBTkNfQk1DX1JBTV9TSVpFIEFT
UEVFRF9SQU1fU0laRSgyICogR2lCKQ0KPiAgICAgID4gKw0KPiAgICAgID4gK3N0YXRpYyB2b2lk
IGFzcGVlZF9tYWNoaW5lX21vbnRibGFuY19jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9p
ZCAqZGF0YSkNCj4gICAgICA+ICt7DQo+ICAgICAgPiArICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBN
QUNISU5FX0NMQVNTKG9jKTsNCj4gICAgICA+ICsgICAgQXNwZWVkTWFjaGluZUNsYXNzICphbWMg
PSBBU1BFRURfTUFDSElORV9DTEFTUyhvYyk7DQo+ICAgICAgPiArDQo+ICAgICAgPiArICAgIG1j
LT5kZXNjID0gIkZhY2Vib29rIE1vbnRibGFuYyBCTUMgKENvcnRleC1BNykiOw0KPiAgICAgID4g
KyAgICBhbWMtPnNvY19uYW1lID0gImFzdDI2MDAtYTMiOw0KPiAgICAgID4gKyAgICBhbWMtPmh3
X3N0cmFwMSA9IE1PTlRCTEFOQ19CTUNfSFdfU1RSQVAxOw0KPiAgICAgID4gKyAgICBhbWMtPmh3
X3N0cmFwMiA9IE1PTlRCTEFOQ19CTUNfSFdfU1RSQVAyOw0KPiAgICAgID4gKyAgICBhbWMtPmZt
Y19tb2RlbCA9ICJteDY2bDFnNDVnIjsNCj4gICAgICA+ICsgICAgYW1jLT5zcGlfbW9kZWwgPSAi
bXg2NmwxZzQ1ZyI7DQo+ICAgICAgPiArICAgIGFtYy0+bnVtX2NzID0gMjsNCj4gICAgICA+ICsg
ICAgYW1jLT5tYWNzX21hc2sgPSBBU1BFRURfTUFDM19PTjsNCj4gICAgICA+ICsgICAgYW1jLT5p
MmNfaW5pdCA9IG1vbnRibGFuY19ibWNfaTJjX2luaXQ7DQo+ICAgICAgPiArICAgIGFtYy0+dWFy
dF9kZWZhdWx0ID0gQVNQRUVEX0RFVl9VQVJUMTsNCj4gICAgICA+ICsgICAgbWMtPmRlZmF1bHRf
cmFtX3NpemUgPSBNT05UQkxBTkNfQk1DX1JBTV9TSVpFOw0KPiAgICAgID4gKyAgICBtYy0+ZGVm
YXVsdF9jcHVzID0gbWMtPm1pbl9jcHVzID0gbWMtPm1heF9jcHVzID0NCj4gICAgICA+ICsgICAg
ICAgIGFzcGVlZF9zb2NfbnVtX2NwdXMoYW1jLT5zb2NfbmFtZSk7DQo+ICAgICAgPiArfTsNCj4g
ICAgICA+ICsNCj4gICAgICA+ICAgI2RlZmluZSBCTEVUQ0hMRVlfQk1DX1JBTV9TSVpFIEFTUEVF
RF9SQU1fU0laRSgyICogR2lCKQ0KPiAgICAgID4NCj4gICAgICA+ICAgc3RhdGljIHZvaWQgYXNw
ZWVkX21hY2hpbmVfYmxldGNobGV5X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpk
YXRhKQ0KPiAgICAgID4gQEAgLTE3MDMsNiArMTc2NCwxMCBAQCBzdGF0aWMgY29uc3QgVHlwZUlu
Zm8gYXNwZWVkX21hY2hpbmVfdHlwZXNbXSA9IHsNCj4gICAgICA+ICAgICAgICAgICAubmFtZSAg
ICAgICAgICA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJmdWppLWJtYyIpLA0KPiAgICAgID4gICAgICAg
ICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9BU1BFRURfTUFDSElORSwNCj4gICAgICA+ICAgICAg
ICAgICAuY2xhc3NfaW5pdCAgICA9IGFzcGVlZF9tYWNoaW5lX2Z1amlfY2xhc3NfaW5pdCwNCj4g
ICAgICA+ICsgICAgfSwgew0KPiAgICAgID4gKyAgICAgICAgLm5hbWUgICAgICAgICAgPSBNQUNI
SU5FX1RZUEVfTkFNRSgibW9udGJsYW5jLWJtYyIpLA0KPiAgICAgID4gKyAgICAgICAgLnBhcmVu
dCAgICAgICAgPSBUWVBFX0FTUEVFRF9NQUNISU5FLA0KPiAgICAgID4gKyAgICAgICAgLmNsYXNz
X2luaXQgICAgPSBhc3BlZWRfbWFjaGluZV9tb250YmxhbmNfY2xhc3NfaW5pdCwNCj4gICAgICA+
ICAgICAgIH0sIHsNCj4gICAgICA+ICAgICAgICAgICAubmFtZSAgICAgICAgICA9IE1BQ0hJTkVf
VFlQRV9OQU1FKCJibGV0Y2hsZXktYm1jIiksDQo+ICAgICAgPiAgICAgICAgICAgLnBhcmVudCAg
ICAgICAgPSBUWVBFX0FTUEVFRF9NQUNISU5FLA0KPiAgICAgID4gZGlmZiAtLWdpdCBhL2h3L2Fy
bS9hc3BlZWRfZWVwcm9tLmMgYi9ody9hcm0vYXNwZWVkX2VlcHJvbS5jDQo+ICAgICAgPiBpbmRl
eCBhY2U1MjY2Y2VjLi44Y2M3M2Y4M2RjIDEwMDY0NA0KPiAgICAgID4gLS0tIGEvaHcvYXJtL2Fz
cGVlZF9lZXByb20uYw0KPiAgICAgID4gKysrIGIvaHcvYXJtL2FzcGVlZF9lZXByb20uYw0KPiAg
ICAgID4gQEAgLTE2MSw2ICsxNjEsNTMgQEAgY29uc3QgdWludDhfdCByYWluaWVyX2JtY19mcnVp
ZFtdID0gew0KPiAgICAgID4gICAgICAgMHgzMSwgMHg1MCwgMHg0NiwgMHgwNCwgMHgwMCwgMHgw
MCwgMHgwMCwgMHgwMCwgMHgwMCwNCj4gICAgICA+ICAgfTsNCj4gICAgICA+DQo+ICAgICAgPiAr
LyogTW9udGJsYW5jIEJNQyBGUlUgKi8NCj4gICAgICA+ICtjb25zdCB1aW50OF90IG1vbnRibGFu
Y19zY21fZnJ1aWRbXSA9IHsNCj4gICAgICA+ICsgICAgMHhmYiwgMHhmYiwgMHgwNCwgMHhmZiwg
MHgwMSwgMHgwZCwgMHg0ZCwgMHg0OSwgMHg0ZSwgMHg0OSwgMHg1MCwgMHg0MSwNCj4gICAgICA+
ICsgICAgMHg0MywgMHg0YiwgMHgzMywgMHg1ZiwgMHg1MywgMHg0MywgMHg0ZCwgMHgwMiwgMHgw
OCwgMHgzMiwgMHgzMCwgMHgzMCwNCj4gICAgICA+ICsgICAgMHgzMCwgMHgzMiwgMHgzOSwgMHgz
NCwgMHgzNSwgMHgwNCwgMHgwYywgMHgzMSwgMHgzMywgMHgzMiwgMHgzMCwgMHgzMCwNCj4gICAg
ICA+ICsgICAgMHgzMCwgMHgzMSwgMHgzNiwgMHgzNCwgMHgzMCwgMHgzMSwgMHgyMCwgMHgwNSwg
MHgwYywgMHgzMSwgMHgzMywgMHgzMSwNCj4gICAgICA+ICsgICAgMHgzMCwgMHgzMCwgMHgzMCwg
MHgzMSwgMHgzMiwgMHgzNywgMHgzMCwgMHgzMSwgMHgyMCwgMHgwNiwgMHgwYywgMHg1MiwNCj4g
ICAgICA+ICsgICAgMHgzMywgMHgzMiwgMHgzMSwgMHgzNCwgMHg0NywgMHgzMCwgMHgzMCwgMHgz
MCwgMHgzMywgMHgzMCwgMHgzMSwgMHgwNywNCj4gICAgICA+ICsgICAgMHgwZCwgMHg0MSwgMHgz
MCwgMHgzMywgMHgzMSwgMHgzMywgMHg1OCwgMHg1OCwgMHg1OCwgMHg1OCwgMHg1OCwgMHg1OCwN
Cj4gICAgICA+ICsgICAgMHg1OCwgMHg1OCwgMHgwOCwgMHgwMSwgMHgwMSwgMHgwOSwgMHgwMSwg
MHgwMCwgMHgwYSwgMHgwMSwgMHgwMCwgMHgwYiwNCj4gICAgICA+ICsgICAgMHgwZCwgMHg0ZCwg
MHgzMiwgMHgzMiwgMHgzMSwgMHgzMywgMHgzMiwgMHgzMywgMHgzMSwgMHgzNywgMHgzMCwgMHgz
MCwNCj4gICAgICA+ICsgICAgMHgzMCwgMHgzMiwgMHgwYywgMHgwMywgMHg0MywgMHg0YywgMHg1
MywgMHgwZCwgMHgwOCwgMHgzMiwgMHgzMCwgMHgzMiwNCj4gICAgICA+ICsgICAgMHgzMywgMHgz
MCwgMHgzNSwgMHgzMCwgMHgzMSwgMHgwZSwgMHgwMywgMHg1NywgMHg1NSwgMHg1MywgMHgwZiwg
MHgwMywNCj4gICAgICA+ICsgICAgMHg0MywgMHg1NCwgMHg0OCwgMHgxMCwgMHgwNiwgMHgwMSwg
MHgwMCwgMHgwMCwgMHg5MSwgMHhkYiwgMHhiNCwgMHgxMywNCj4gICAgICA+ICsgICAgMHgwMywg
MHg1MywgMHg0MywgMHg0ZCwgMHhmYSwgMHgwMiwgMHgwMiwgMHg2MSwNCj4gICAgICA+ICt9Ow0K
PiAgICAgID4gKw0KPiAgICAgID4gK2NvbnN0IHVpbnQ4X3QgbW9udGJsYW5jX2ZjbV9mcnVpZFtd
ID0gew0KPiAgICAgID4gKyAgICAweGZiLCAweGZiLCAweDA0LCAweGZmLCAweDAxLCAweDBkLCAw
eDRkLCAweDQ5LCAweDRlLCAweDQ5LCAweDUwLCAweDQxLA0KPiAgICAgID4gKyAgICAweDQzLCAw
eDRiLCAweDMzLCAweDVmLCAweDQ2LCAweDQzLCAweDQyLCAweDAyLCAweDA4LCAweDMzLCAweDMw
LCAweDMwLA0KPiAgICAgID4gKyAgICAweDMwLCAweDMwLCAweDMxLCAweDM2LCAweDMxLCAweDA0
LCAweDBjLCAweDMxLCAweDMzLCAweDMyLCAweDMwLCAweDMwLA0KPiAgICAgID4gKyAgICAweDMw
LCAweDMxLCAweDM2LCAweDMzLCAweDMwLCAweDMxLCAweDIwLCAweDA1LCAweDBjLCAweDMxLCAw
eDMzLCAweDMxLA0KPiAgICAgID4gKyAgICAweDMwLCAweDMwLCAweDMwLCAweDMxLCAweDMzLCAw
eDMwLCAweDMwLCAweDMxLCAweDIwLCAweDA2LCAweDBjLCAweDUyLA0KPiAgICAgID4gKyAgICAw
eDMzLCAweDMyLCAweDMxLCAweDM0LCAweDQ3LCAweDMwLCAweDMwLCAweDMxLCAweDMyLCAweDMw
LCAweDMxLCAweDA3LA0KPiAgICAgID4gKyAgICAweDBkLCAweDQxLCAweDMxLCAweDMyLCAweDMx
LCAweDMyLCAweDU4LCAweDU4LCAweDU4LCAweDU4LCAweDU4LCAweDU4LA0KPiAgICAgID4gKyAg
ICAweDU4LCAweDU4LCAweDA4LCAweDAxLCAweDAxLCAweDA5LCAweDAxLCAweDAwLCAweDBhLCAw
eDAxLCAweDAwLCAweDBiLA0KPiAgICAgID4gKyAgICAweDBkLCAweDQ2LCAweDM1LCAweDMwLCAw
eDMxLCAweDMzLCAweDMyLCAweDMzLCAweDMxLCAweDM3LCAweDMwLCAweDMwLA0KPiAgICAgID4g
KyAgICAweDMwLCAweDM1LCAweDBjLCAweDAzLCAweDQzLCAweDRjLCAweDUzLCAweDBkLCAweDA4
LCAweDMyLCAweDMwLCAweDMyLA0KPiAgICAgID4gKyAgICAweDMzLCAweDMwLCAweDM1LCAweDMw
LCAweDMxLCAweDBlLCAweDAzLCAweDU3LCAweDU1LCAweDUzLCAweDBmLCAweDAzLA0KPiAgICAg
ID4gKyAgICAweDQzLCAweDU0LCAweDQ4LCAweDEwLCAweDA2LCAweDAyLCAweDAwLCAweDAwLCAw
eDkxLCAweGRiLCAweGI0LCAweDExLA0KPiAgICAgID4gKyAgICAweDA2LCAweDAzLCAweDAwLCAw
eDAwLCAweDkxLCAweGRiLCAweGI0LCAweDEyLCAweDAyLCAweDhhLCAweDAwLCAweDEzLA0KPiAg
ICAgID4gKyAgICAweDAzLCAweDQ2LCAweDQzLCAweDQyLCAweGZhLCAweDAyLCAweDUwLCAweDQ3
LA0KPiAgICAgID4gK307DQo+ICAgICAgPiArDQo+ICAgICAgPiArY29uc3QgdWludDhfdCBtb250
YmxhbmNfYm1jX2ZydWlkW10gPSB7DQo+ICAgICAgPiArICAgIDB4ZmIsIDB4ZmIsIDB4MDQsIDB4
ZmYsIDB4MDEsIDB4MGQsIDB4NGQsIDB4NDksIDB4NGUsIDB4NDksIDB4NTAsIDB4NDEsDQo+ICAg
ICAgPiArICAgIDB4NDMsIDB4NGIsIDB4MzMsIDB4NWYsIDB4NDIsIDB4NGQsIDB4NDMsIDB4MDQs
IDB4MGMsIDB4MzEsIDB4MzMsIDB4MzIsDQo+ICAgICAgPiArICAgIDB4MzAsIDB4MzAsIDB4MzAs
IDB4MzEsIDB4MzMsIDB4MzYsIDB4MzAsIDB4MzEsIDB4MjAsIDB4MDUsIDB4MGMsIDB4MzEsDQo+
ICAgICAgPiArICAgIDB4MzMsIDB4MzEsIDB4MzAsIDB4MzAsIDB4MzAsIDB4MzAsIDB4MzgsIDB4
MzYsIDB4MzAsIDB4MzUsIDB4MjAsIDB4MDYsDQo+ICAgICAgPiArICAgIDB4MGMsIDB4NTIsIDB4
MzMsIDB4MzAsIDB4MzksIDB4MzcsIDB4NDcsIDB4MzAsIDB4MzAsIDB4MzAsIDB4MzIsIDB4MzAs
DQo+ICAgICAgPiArICAgIDB4MzcsIDB4MDcsIDB4MGQsIDB4NDIsIDB4MzAsIDB4MzIsIDB4Mzcs
IDB4MzQsIDB4NTgsIDB4NTgsIDB4NTgsIDB4NTgsDQo+ICAgICAgPiArICAgIDB4NTgsIDB4NTgs
IDB4NTgsIDB4NTgsIDB4MDgsIDB4MDEsIDB4MDQsIDB4MDksIDB4MDEsIDB4MDAsIDB4MGEsIDB4
MDEsDQo+ICAgICAgPiArICAgIDB4MDAsIDB4MGMsIDB4MDMsIDB4NDMsIDB4NGMsIDB4NTMsIDB4
MGQsIDB4MDgsIDB4MzIsIDB4MzAsIDB4MzIsIDB4MzMsDQo+ICAgICAgPiArICAgIDB4MzAsIDB4
MzUsIDB4MzAsIDB4MzEsIDB4MGUsIDB4MDMsIDB4NTcsIDB4NTUsIDB4NTMsIDB4MGYsIDB4MDMs
IDB4NDMsDQo+ICAgICAgPiArICAgIDB4NTQsIDB4NDgsIDB4MTMsIDB4MDMsIDB4NDIsIDB4NGQs
IDB4NDMsIDB4ZmEsIDB4MDIsIDB4ZWYsIDB4YmEsDQo+ICAgICAgPiArfTsNCj4gICAgICA+ICsN
Cj4gICAgICA+ICAgY29uc3Qgc2l6ZV90IHRpb2dhcGFzc19ibWNfZnJ1aWRfbGVuID0gc2l6ZW9m
KHRpb2dhcGFzc19ibWNfZnJ1aWQpOw0KPiAgICAgID4gICBjb25zdCBzaXplX3QgZmJ5MzVfbmlj
X2ZydWlkX2xlbiA9IHNpemVvZihmYnkzNV9uaWNfZnJ1aWQpOw0KPiAgICAgID4gICBjb25zdCBz
aXplX3QgZmJ5MzVfYmJfZnJ1aWRfbGVuID0gc2l6ZW9mKGZieTM1X2JiX2ZydWlkKTsNCj4gICAg
ICA+IEBAIC0xNjgsMyArMjE1LDYgQEAgY29uc3Qgc2l6ZV90IGZieTM1X2JtY19mcnVpZF9sZW4g
PSBzaXplb2YoZmJ5MzVfYm1jX2ZydWlkKTsNCj4gICAgICA+ICAgY29uc3Qgc2l6ZV90IHlvc2Vt
aXRldjJfYm1jX2ZydWlkX2xlbiA9IHNpemVvZih5b3NlbWl0ZXYyX2JtY19mcnVpZCk7DQo+ICAg
ICAgPiAgIGNvbnN0IHNpemVfdCByYWluaWVyX2JiX2ZydWlkX2xlbiA9IHNpemVvZihyYWluaWVy
X2JiX2ZydWlkKTsNCj4gICAgICA+ICAgY29uc3Qgc2l6ZV90IHJhaW5pZXJfYm1jX2ZydWlkX2xl
biA9IHNpemVvZihyYWluaWVyX2JtY19mcnVpZCk7DQo+ICAgICAgPiArY29uc3Qgc2l6ZV90IG1v
bnRibGFuY19zY21fZnJ1aWRfbGVuID0gc2l6ZW9mKG1vbnRibGFuY19zY21fZnJ1aWQpOw0KPiAg
ICAgID4gK2NvbnN0IHNpemVfdCBtb250YmxhbmNfZmNtX2ZydWlkX2xlbiA9IHNpemVvZihtb250
YmxhbmNfZmNtX2ZydWlkKTsNCj4gICAgICA+ICtjb25zdCBzaXplX3QgbW9udGJsYW5jX2JtY19m
cnVpZF9sZW4gPSBzaXplb2YobW9udGJsYW5jX2JtY19mcnVpZCk7DQo+ICAgICAgPiBkaWZmIC0t
Z2l0IGEvaHcvYXJtL2FzcGVlZF9lZXByb20uaCBiL2h3L2FybS9hc3BlZWRfZWVwcm9tLmgNCj4g
ICAgICA+IGluZGV4IGJiZjllNTQzNjUuLmI4ZmJkZDA3MzQgMTAwNjQ0DQo+ICAgICAgPiAtLS0g
YS9ody9hcm0vYXNwZWVkX2VlcHJvbS5oDQo+ICAgICAgPiArKysgYi9ody9hcm0vYXNwZWVkX2Vl
cHJvbS5oDQo+ICAgICAgPiBAQCAtMjcsNCArMjcsMTEgQEAgZXh0ZXJuIGNvbnN0IHNpemVfdCBy
YWluaWVyX2JiX2ZydWlkX2xlbjsNCj4gICAgICA+ICAgZXh0ZXJuIGNvbnN0IHVpbnQ4X3QgcmFp
bmllcl9ibWNfZnJ1aWRbXTsNCj4gICAgICA+ICAgZXh0ZXJuIGNvbnN0IHNpemVfdCByYWluaWVy
X2JtY19mcnVpZF9sZW47DQo+ICAgICAgPg0KPiAgICAgID4gK2V4dGVybiBjb25zdCB1aW50OF90
IG1vbnRibGFuY19zY21fZnJ1aWRbXTsNCj4gICAgICA+ICtleHRlcm4gY29uc3QgdWludDhfdCBt
b250YmxhbmNfZmNtX2ZydWlkW107DQo+ICAgICAgPiArZXh0ZXJuIGNvbnN0IHVpbnQ4X3QgbW9u
dGJsYW5jX2JtY19mcnVpZFtdOw0KPiAgICAgID4gK2V4dGVybiBjb25zdCBzaXplX3QgbW9udGJs
YW5jX3NjbV9mcnVpZF9sZW47DQo+ICAgICAgPiArZXh0ZXJuIGNvbnN0IHNpemVfdCBtb250Ymxh
bmNfZmNtX2ZydWlkX2xlbjsNCj4gICAgICA+ICtleHRlcm4gY29uc3Qgc2l6ZV90IG1vbnRibGFu
Y19ibWNfZnJ1aWRfbGVuOw0KPiAgICAgID4gKw0KPiAgICAgID4gICAjZW5kaWYNCj4NCg==

--_000_BY5PR15MB3555BD84850525E4FF17E086AF2FABY5PR15MB3555namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1854612458;
	mso-list-type:hybrid;
	mso-list-template-ids:159823278 2078941978 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:20.25pt;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:56.25pt;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:92.25pt;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:128.25pt;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:164.25pt;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:200.25pt;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:236.25pt;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:272.25pt;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:308.25pt;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi Sittisak, <o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Minipack3 is not op=
en-sourced yet, and we are unlikely to be able to upstream detailed data.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:-15.75pt;mso-list:l0 le=
vel1 lfo1">
<span style=3D"font-size:11.0pt">What is these FRUID datas for, is it for t=
esting?<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margi=
n-left:-15.75pt;mso-list:l0 level1 lfo1">
<span style=3D"font-size:11.0pt">What other option do we have, since we are=
 not able to upstream FRUID data. (It is still OK to upstream system config=
uration, but NOT the arrays of _fruid data array)<o:p></o:p></span></li></o=
l>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Mike<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">C=C3=A9dric Le Goat=
er &lt;clg@kaod.org&gt;<br>
<b>Date: </b>Tuesday, July 4, 2023 at 7:07 AM<br>
<b>To: </b>Sittisak Sinprem &lt;ssinprem@celestica.com&gt;, Bin Huang &lt;b=
inhuang@meta.com&gt;, Tao Ren &lt;taoren@meta.com&gt;, Mike Choi &lt;mikech=
oi@meta.com&gt;<br>
<b>Cc: </b>qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;, qemu-arm@no=
ngnu.org &lt;qemu-arm@nongnu.org&gt;, peter.maydell@linaro.org &lt;peter.ma=
ydell@linaro.org&gt;, andrew@aj.id.au &lt;andrew@aj.id.au&gt;, Joel Stanley=
 &lt;joel@jms.id.au&gt;, qemu-stable@nongnu.org &lt;qemu-stable@nongnu.org&=
gt;,
 srikanth@celestica.com &lt;srikanth@celestica.com&gt;, ssumet@celestica.co=
m &lt;ssumet@cele</span><span style=3D"font-size:12.0pt">for
<span style=3D"color:black">stica.com&gt;, thangavelu.v@celestica.com &lt;t=
hangavelu.v@celestica.com&gt;, kgengan@celestica.com &lt;kgengan@celestica.=
com&gt;, anandaramanv@celestica.com &lt;anandaramanv@celestica.com&gt;<br>
<b>Subject: </b>Re: [PATCH qemu v5] aspeed add montblanc bmc reference from=
 fuji<o:p></o:p></span></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt"><br>
<br>
On 7/4/23 15:27, Sittisak Sinprem wrote:<br>
&gt; Hi&nbsp;Meta Team,<br>
&gt; <br>
&gt; the FRU EEPROM content, I think for now detail still be&nbsp;confident=
ial,<br>
&gt; Please confirm, Can we add the description in Qemu upstream&nbsp;follo=
wing Cedric's request?<br>
<br>
We don't need all the details, and not the confidential part of course.<br>
<br>
C.<br>
<br>
&gt; <br>
&gt; On Tue, Jul 4, 2023 at 6:19=E2=80=AFPM C=C3=A9dric Le Goater &lt;clg@k=
aod.org &lt;<a href=3D"mailto:clg@kaod.org">mailto:clg@kaod.org</a>&gt;&gt;=
 wrote:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; On 7/4/23 13:06, ~ssinprem wrote:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; From: Sittisak Sinprem &lt;ssinprem=
@celestica.com &lt;<a href=3D"mailto:ssinprem@celestica.com">mailto:ssinpre=
m@celestica.com</a>&gt;&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; - I2C list follow I2C Tree v1.6 202=
30320<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; - fru eeprom data use FB FRU format=
 version 4<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Signed-off-by: Sittisak Sinprem &lt=
;ssinprem@celestica.com &lt;<a href=3D"mailto:ssinprem@celestica.com">mailt=
o:ssinprem@celestica.com</a>&gt;&gt;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; You shoot too fast :) Please add some descript=
ion for the EEPROM contents.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; What they enable when the OS/FW boots is good =
to know for QEMU.<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Thanks,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; C.<br>
&gt; <br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; ---<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;docs/system/arm/aspeed.=
rst |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;hw/arm/aspeed.c&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 65 ++++++++++++++++++++++++++++++++++++=
++<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;hw/arm/aspeed_eeprom.c&=
nbsp; &nbsp; &nbsp;| 50 +++++++++++++++++++++++++++++<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;hw/arm/aspeed_eeprom.h&=
nbsp; &nbsp; &nbsp;|&nbsp; 7 ++++<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;4 files changed, 123 in=
sertions(+)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; diff --git a/docs/system/arm/aspeed=
.rst b/docs/system/arm/aspeed.rst<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; index 80538422a1..5e0824f48b 100644=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; --- a/docs/system/arm/aspeed.rst<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +++ b/docs/system/arm/aspeed.rst<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -33,6 +33,7 @@ AST2600 SoC based=
 machines :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;- ``tacoma-bmc``&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;OpenPOWER Witherspoon POWER9 AST2600 BMC<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;- ``rainier-bmc``&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; IBM Rainier POWER10 BMC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;- ``fuji-bmc``&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Facebook Fuji BMC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +- ``montblanc-bmc``&nbsp; &nbsp; &=
nbsp; &nbsp; Facebook Montblanc BMC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;- ``bletchley-bmc``&nbs=
p; &nbsp; &nbsp; &nbsp; Facebook Bletchley BMC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;- ``fby35-bmc``&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Facebook fby35 BMC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;- ``qcom-dc-scm-v1-bmc`=
`&nbsp; &nbsp;Qualcomm DC-SCM V1 BMC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; diff --git a/hw/arm/aspeed.c b/hw/a=
rm/aspeed.c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; index 9fca644d92..bbb7a3392c 100644=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; --- a/hw/arm/aspeed.c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +++ b/hw/arm/aspeed.c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -189,6 +189,10 @@ struct AspeedM=
achineState {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;#define FUJI_BMC_HW_STR=
AP1&nbsp; &nbsp; 0x00000000<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;#define FUJI_BMC_HW_STR=
AP2&nbsp; &nbsp; 0x00000000<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +/* Montblanc hardware value */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +#define MONTBLANC_BMC_HW_STRAP1&nb=
sp; &nbsp; 0x00000000<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +#define MONTBLANC_BMC_HW_STRAP2&nb=
sp; &nbsp; 0x00000000<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;/* Bletchley hardware v=
alue */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;/* TODO: Leave same as =
EVB for now. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;#define BLETCHLEY_BMC_H=
W_STRAP1 AST2600_EVB_HW_STRAP1<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -925,6 +929,41 @@ static void fu=
ji_bmc_i2c_init(AspeedMachineState *bmc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;}<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +static void montblanc_bmc_i2c_init=
(AspeedMachineState *bmc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; AspeedSoCState *soc =
=3D &amp;bmc-&gt;soc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; I2CBus *i2c[16] =3D =
{};<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; for (int i =3D 0; i =
&lt; 16; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; i2c[i]=
 =3D aspeed_i2c_get_bus(&amp;soc-&gt;i2c, i);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; /* Ref from Minipack=
3_I2C_Tree_V1.6 20230320 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; at24c_eeprom_init_ro=
m(i2c[3], 0x56, 8192, montblanc_scm_fruid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; montblanc_scm_frui=
d_len);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; at24c_eeprom_init_ro=
m(i2c[6], 0x53, 8192, montblanc_fcm_fruid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; montblanc_fcm_frui=
d_len);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; /* CPLD and FPGA */<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; at24c_eeprom_init(i2=
c[1], 0x35, 256);&nbsp; /* SCM CPLD */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; at24c_eeprom_init(i2=
c[5], 0x35, 256);&nbsp; /* COMe CPLD TODO: need to update */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; at24c_eeprom_init(i2=
c[12], 0x60, 256); /* MCB PWR CPLD */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; at24c_eeprom_init(i2=
c[13], 0x35, 256); /* IOB FPGA */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; /* on BMC board */<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; at24c_eeprom_init_ro=
m(i2c[8], 0x51, 8192, montblanc_bmc_fruid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; montblanc_bmc_frui=
d_len); /* BMC EEPROM */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; i2c_slave_create_sim=
ple(i2c[8], TYPE_LM75, 0x48); /* Thermal Sensor */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; /* COMe Sensor/EEPRO=
M */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; at24c_eeprom_init(i2=
c[0], 0x56, 16384);&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* FRU EEPROM */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; i2c_slave_create_sim=
ple(i2c[0], TYPE_LM75, 0x48); /* INLET Sensor */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; i2c_slave_create_sim=
ple(i2c[0], TYPE_LM75, 0x4A); /* OUTLET Sensor */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; /* It expects a pca9=
555 but a pca9552 is compatible */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; create_pca9552(soc, =
4, 0x27);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +}<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;#define TYPE_TMP421 &qu=
ot;tmp421&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;static void bletchley_b=
mc_i2c_init(AspeedMachineState *bmc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -1452,6 +1491,28 @@ static void =
aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;aspeed_soc_num_cpus(amc-&gt;soc_name);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;};<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +#define MONTBLANC_BMC_RAM_SIZE ASP=
EED_RAM_SIZE(2 * GiB)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +static void aspeed_machine_montbla=
nc_class_init(ObjectClass *oc, void *data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; MachineClass *mc =3D=
 MACHINE_CLASS(oc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; AspeedMachineClass *=
amc =3D ASPEED_MACHINE_CLASS(oc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; mc-&gt;desc =3D &quo=
t;Facebook Montblanc BMC (Cortex-A7)&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;soc_name =3D=
 &quot;ast2600-a3&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;hw_strap1 =
=3D MONTBLANC_BMC_HW_STRAP1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;hw_strap2 =
=3D MONTBLANC_BMC_HW_STRAP2;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;fmc_model =
=3D &quot;mx66l1g45g&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;spi_model =
=3D &quot;mx66l1g45g&quot;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;num_cs =3D 2=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;macs_mask =
=3D ASPEED_MAC3_ON;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;i2c_init =3D=
 montblanc_bmc_i2c_init;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; amc-&gt;uart_default=
 =3D ASPEED_DEV_UART1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; mc-&gt;default_ram_s=
ize =3D MONTBLANC_BMC_RAM_SIZE;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; mc-&gt;default_cpus =
=3D mc-&gt;min_cpus =3D mc-&gt;max_cpus =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; aspeed=
_soc_num_cpus(amc-&gt;soc_name);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +};<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;#define BLETCHLEY_BMC_R=
AM_SIZE ASPEED_RAM_SIZE(2 * GiB)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;static void aspeed_mach=
ine_bletchley_class_init(ObjectClass *oc, void *data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -1703,6 +1764,10 @@ static const=
 TypeInfo aspeed_machine_types[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;.name&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D MACHINE_TYPE_NAME(&quot;fu=
ji-bmc&quot;),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;.parent&nbsp; &nbsp; &nbsp; &nbsp; =3D TYPE_ASPEED_MACHINE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;.class_init&nbsp; &nbsp; =3D aspeed_machine_fuji_class_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; }, {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; .name&=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D MACHINE_TYPE_NAME(&quot;montblanc-bmc=
&quot;),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; .paren=
t&nbsp; &nbsp; &nbsp; &nbsp; =3D TYPE_ASPEED_MACHINE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; .class=
_init&nbsp; &nbsp; =3D aspeed_machine_montblanc_class_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp;}, {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;.name&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D MACHINE_TYPE_NAME(&quot;bl=
etchley-bmc&quot;),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;.parent&nbsp; &nbsp; &nbsp; &nbsp; =3D TYPE_ASPEED_MACHINE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; diff --git a/hw/arm/aspeed_eeprom.c=
 b/hw/arm/aspeed_eeprom.c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; index ace5266cec..8cc73f83dc 100644=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; --- a/hw/arm/aspeed_eeprom.c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +++ b/hw/arm/aspeed_eeprom.c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -161,6 +161,53 @@ const uint8_t =
rainier_bmc_fruid[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp; &nbsp; &nbsp;0x31, 0x5=
0, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;};<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +/* Montblanc BMC FRU */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +const uint8_t montblanc_scm_fruid[=
] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0xfb, 0xfb, 0x04, 0x=
ff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x43, 0x4b, 0x33, 0x=
5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0x32, 0x30, 0x30,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x32, 0x39, 0x=
34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30, 0x30,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x31, 0x36, 0x=
34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33, 0x31,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x30, 0x30, 0x=
31, 0x32, 0x37, 0x30, 0x31, 0x20, 0x06, 0x0c, 0x52,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x33, 0x32, 0x31, 0x=
34, 0x47, 0x30, 0x30, 0x30, 0x33, 0x30, 0x31, 0x07,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x0d, 0x41, 0x30, 0x=
33, 0x31, 0x33, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x58, 0x58, 0x08, 0x=
01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x0b,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x0d, 0x4d, 0x32, 0x=
32, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30, 0x30,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x32, 0x0c, 0x=
03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x33, 0x30, 0x35, 0x=
30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x43, 0x54, 0x48, 0x=
10, 0x06, 0x01, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x13,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x03, 0x53, 0x43, 0x=
4d, 0xfa, 0x02, 0x02, 0x61,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +};<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +const uint8_t montblanc_fcm_fruid[=
] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0xfb, 0xfb, 0x04, 0x=
ff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x43, 0x4b, 0x33, 0x=
5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0x33, 0x30, 0x30,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x30, 0x31, 0x=
36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30, 0x30,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x31, 0x36, 0x=
33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33, 0x31,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x30, 0x30, 0x=
31, 0x33, 0x30, 0x30, 0x31, 0x20, 0x06, 0x0c, 0x52,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x33, 0x32, 0x31, 0x=
34, 0x47, 0x30, 0x30, 0x31, 0x32, 0x30, 0x31, 0x07,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x0d, 0x41, 0x31, 0x=
32, 0x31, 0x32, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x58, 0x58, 0x08, 0x=
01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x0b,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x0d, 0x46, 0x35, 0x=
30, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30, 0x30,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x35, 0x0c, 0x=
03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x33, 0x30, 0x35, 0x=
30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x43, 0x54, 0x48, 0x=
10, 0x06, 0x02, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x11,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x06, 0x03, 0x00, 0x=
00, 0x91, 0xdb, 0xb4, 0x12, 0x02, 0x8a, 0x00, 0x13,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x03, 0x46, 0x43, 0x=
42, 0xfa, 0x02, 0x50, 0x47,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +};<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +const uint8_t montblanc_bmc_fruid[=
] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0xfb, 0xfb, 0x04, 0x=
ff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x43, 0x4b, 0x33, 0x=
5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0x31, 0x33, 0x32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x30, 0x30, 0x=
31, 0x33, 0x36, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x33, 0x31, 0x30, 0x=
30, 0x30, 0x30, 0x38, 0x36, 0x30, 0x35, 0x20, 0x06,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x0c, 0x52, 0x33, 0x=
30, 0x39, 0x37, 0x47, 0x30, 0x30, 0x30, 0x32, 0x30,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x37, 0x07, 0x0d, 0x=
42, 0x30, 0x32, 0x37, 0x34, 0x58, 0x58, 0x58, 0x58,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x58, 0x58, 0x58, 0x=
58, 0x08, 0x01, 0x04, 0x09, 0x01, 0x00, 0x0a, 0x01,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x00, 0x0c, 0x03, 0x=
43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32, 0x33,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x30, 0x35, 0x30, 0x=
31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03, 0x43,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +&nbsp; &nbsp; 0x54, 0x48, 0x13, 0x=
03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0xef, 0xba,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +};<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;const size_t tiogapass_=
bmc_fruid_len =3D sizeof(tiogapass_bmc_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;const size_t fby35_nic_=
fruid_len =3D sizeof(fby35_nic_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;const size_t fby35_bb_f=
ruid_len =3D sizeof(fby35_bb_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -168,3 +215,6 @@ const size_t fb=
y35_bmc_fruid_len =3D sizeof(fby35_bmc_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;const size_t yosemitev2=
_bmc_fruid_len =3D sizeof(yosemitev2_bmc_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;const size_t rainier_bb=
_fruid_len =3D sizeof(rainier_bb_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;const size_t rainier_bm=
c_fruid_len =3D sizeof(rainier_bmc_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +const size_t montblanc_scm_fruid_l=
en =3D sizeof(montblanc_scm_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +const size_t montblanc_fcm_fruid_l=
en =3D sizeof(montblanc_fcm_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +const size_t montblanc_bmc_fruid_l=
en =3D sizeof(montblanc_bmc_fruid);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; diff --git a/hw/arm/aspeed_eeprom.h=
 b/hw/arm/aspeed_eeprom.h<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; index bbf9e54365..b8fbdd0734 100644=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; --- a/hw/arm/aspeed_eeprom.h<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +++ b/hw/arm/aspeed_eeprom.h<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; @@ -27,4 +27,11 @@ extern const siz=
e_t rainier_bb_fruid_len;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;extern const uint8_t ra=
inier_bmc_fruid[];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;extern const size_t rai=
nier_bmc_fruid_len;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +extern const uint8_t montblanc_scm=
_fruid[];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +extern const uint8_t montblanc_fcm=
_fruid[];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +extern const uint8_t montblanc_bmc=
_fruid[];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +extern const size_t montblanc_scm_=
fruid_len;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +extern const size_t montblanc_fcm_=
fruid_len;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +extern const size_t montblanc_bmc_=
fruid_len;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp; &nbsp;#endif<br>
&gt; <o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR15MB3555BD84850525E4FF17E086AF2FABY5PR15MB3555namp_--

