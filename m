Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2444726692
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wT5-0008Dv-El; Wed, 07 Jun 2023 12:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6wT2-0008DR-9L
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:57:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6wT0-0001mG-0r
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:57:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EXSQP013828; Wed, 7 Jun 2023 16:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mP+lxfXIpXoB650PYOXxok+5q6bwRr4EeOX/GUTGJi4=;
 b=lYUe//mzbMvM06DvJul4rqtfalQsvMY0qT9/VuzIyXrAMgnu3+WutUo7K2/3+eAPD6ir
 FOfbHmHPVFw/op8ppQkG0jc55JCY4KX8zpHSuZo6FTQ82PCCc3EXTZEjLZju93Yu+sPz
 +mo5uwnHN4ATgj/0LaIfCVqK0PTOh5rhwWuQ12+y0JTAUL+C8Ef3Tjez++centQ3eN8m
 qjwG5RiTRhby6cc0mHuwHqY3HBm+1a99/6BuhpCEhjbzAVXmumxYFcD9OKtDii8L3NBn
 Q9BflF7DWyrZCTvxyRhe/KT1g38VvJ6x0pG18P1IKSBTcZhhRK+b7GLZZgb9Z/CtxjfG nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uta5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 16:56:58 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357FTNUP036692; Wed, 7 Jun 2023 16:56:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6k0wpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 16:56:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAfWh63XqJ4nr1/qjCazMGPtTxuQEPSoc5urbgpq8rOBn3aNTJIAjihuY7TIQp4zi1PQuSBA4EoQ5uiirH/LijxZ0AQnK7BOxhhlhv/rfsgL/4ATQwKoBPtFXVw6HwfRRUzfB2s2lGN0xrVmCmmeSb1+8glXutVENZfg1ZQCGVYUY42RtCokEvmxf+RV7tGZ1GjqmXg8AzDxAf8iuoAVFk0aRf4GvuNdrP+P08T3JwYAE1FBwikUsumhFbXRjnmuKZJhWBtXaiAm2vdSaB8uMBTh+6SXkiSeEpv+aBT7Q+f8WJKeL8Z7/BJ+RnaKYyTeNv74Ej4KASn7GydEmbqAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP+lxfXIpXoB650PYOXxok+5q6bwRr4EeOX/GUTGJi4=;
 b=jtm6Y6FhidzpouhmsfwgISCQJvEItXTh/qYp5RWCcPSHiGWGg4veV0IJtNb3gZ6R/mssaUW3GAKIKFczqEkB/53qpiZEQNfaSlzps9ABQd5NGygq6k35+Lz485k9EX2NbbTyZCKectQYHdDT46zrEvho0nwrAJ/ZfYwHgB8Fp9NA/cR3FJNnZlZwMihUoqXbI+Im/+ZmhOJ0uTDd0qQhoDrn+DEIoU0GPBlzW5DD23f79z++st82qkLyz5uPmQNKBOQN7IHoahlJzlfkdxFdGJKiEOzZXgaUP/NNw8X2kQ8LsR4ady3XH2WlMwfJi/xWGJyVPrL6fL6rzKsvP25Ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP+lxfXIpXoB650PYOXxok+5q6bwRr4EeOX/GUTGJi4=;
 b=uLqspxas/Z14x8Op1LMBEr26mKT2d0Knis0W0zwm1N+ETSNu1VJU0Mnep8RYHeqSWobLJC9I5AxtIMnfgrnKoGGmRm7SpC34BJAe9prp3QzKSN5gbqh3wOR7u2Wflia8MmDlvl7Ioxoy2HgYabmL1XYQqNwNqZnz/Mku0JBqIAs=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:56:55 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:56:55 +0000
From: Jag Raman <jag.raman@oracle.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
CC: QEMU Developers <qemu-devel@nongnu.org>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, Kanth Ghatraju <kanth.ghatraju@oracle.com>,
 Karl Heubaum <karl.heubaum@oracle.com>
Subject: Re: [PATCH 0/1] update maintainers list for vfio-user & multi-process
 QEMU
Thread-Topic: [PATCH 0/1] update maintainers list for vfio-user &
 multi-process QEMU
Thread-Index: AQHZmVj1iCPsQA9hdEqPNwMhehsn/69/i+gAgAADeIA=
Date: Wed, 7 Jun 2023 16:56:55 +0000
Message-ID: <0244DA46-96EF-4390-99F6-48ED96FF8F76@oracle.com>
References: <cover.1686153256.git.jag.raman@oracle.com>
 <CAJSP0QWBYHY9g1dGSZYgwVJ6cojfJquK=q1ePcFzvZwkYxx7Cg@mail.gmail.com>
In-Reply-To: <CAJSP0QWBYHY9g1dGSZYgwVJ6cojfJquK=q1ePcFzvZwkYxx7Cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR10MB4013:EE_|CO1PR10MB4594:EE_
x-ms-office365-filtering-correlation-id: 37ac6731-ecd2-4afe-6a4f-08db6778333d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ol90cJsCWsFkSdYgxTdrk4elEBirXbeIA4RZOS6zpnwjo0IbWdmonNVXv6QqBf98BeDvDYrU4BEGZ9/7fEUnaNCR0iuiWBFuIiIOusVbIUAMdnpmGmAJdEi8ByYH2umI0gLGfPuSk15Ua5hMkfmufIBGXSZ/RqK+AYAOwRbPRmIS/RG6tl6CR4zSEBRTaaCuwEmgRl0/ATIlT15F1S+CfrT3INeNQsIs52e0HIyHJLD3fdAOY0DgOCOq7GF2c4hbqxj5PFgDXm8I3Shw3pUpXrXrNlY+ZP0dOFTHYHXi6+HcWQQqScPQWkwtg9a+io9cMVzUdljGQXc/p3TmDv/0SLOg1t6+2QrAbumoPzZGDAIscSNWT9gOd/uvU2XF0s0U+avi3oDSSA4Tie3fgUxYumbVI5rZPqIhyoU8D/K9ydVrs+sm+iKL/jQr6MSTJf/9a/IhUouYJV6kPJAO5ZlZVkggRgUlOeaNHckjGGq9xM5A+0DDRppT21FFrmbjmlE+P+dGo8Lrj0U2TXUKj0mvMeEk0y8IQetyG310qXW8Zrhh9qjvUGx8XBfuo9RicGqnBSNCjxLh+GZvEFizTWTZpREKVuI+Nqdi7NXWYatU2obcQnm82mfS5ExuoL6lXQeoV3asnIxf78AUcP59Ljw2hw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(83380400001)(33656002)(54906003)(478600001)(8676002)(8936002)(41300700001)(122000001)(76116006)(66446008)(66556008)(66946007)(66476007)(316002)(38070700005)(5660300002)(86362001)(91956017)(64756008)(38100700002)(4326008)(6916009)(36756003)(6486002)(15650500001)(71200400001)(4744005)(2906002)(44832011)(6506007)(6512007)(107886003)(53546011)(186003)(2616005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d6GfHSvD05BH00isXWXGeFToZ7nutkCsrbGDzibl9YizEMv9F0bUPyuydLdR?=
 =?us-ascii?Q?upPnu28T1kREdrb8QJBlTJ1MXcByxNfSmFT8f4G+4EpPJbxNwxUdjZF/lBHx?=
 =?us-ascii?Q?Lvpm4YpXvyb46mMlFxeuNnrnqVukJQzDxApc2O6FmzTmWDrXvDrJBNUUZ5/V?=
 =?us-ascii?Q?EGRTYYMDEBAY36GRF6ocke2O8JstRRcQdcd8l7KuXtMcviEZv1GjeHd6nHW4?=
 =?us-ascii?Q?csunEXWAMdI8R+2VX5dcREdX7MPr5AfliQOWrxPc/LLYT6Pa3BMlnw9umv78?=
 =?us-ascii?Q?EZH1NFU8hUXXL6KYgfQRuYTAt8idiofcNjPS8RTZq5nRQyloOIFPI2IAjrk9?=
 =?us-ascii?Q?earibUeqk55DqCilolD68l9bWIsSLIsMkyj1pBjKUfzYemjs7oDhvqJws9N3?=
 =?us-ascii?Q?O17KSCQbomQ97uP1bxqph07t2HqrVS0GzEwr3v2zklOYjtV0372S7xr7XT9D?=
 =?us-ascii?Q?a9c3Yq+ELbZf63BAibgt6D7GNyHnv+IsgRzi0vS+vOvGa/yUYTxYkOrdULyz?=
 =?us-ascii?Q?O7qZum9slefaSRyu2dksoGT4BuMo4qO5Ihi55K6dungdf/WD2NccfyQVuDpK?=
 =?us-ascii?Q?w5lUQDDQxPhfk0tFVps3W6GMuG5yxoUdr4PMIXLfhEFfiXiGyg5KorM1c1ou?=
 =?us-ascii?Q?VZAELKYaW4J9Z5WbOJsfH4W8qjVxArGoPD/wjfF9ItSslUcL7wulpcqUKwvc?=
 =?us-ascii?Q?OV/EzKMLwrX2qJDswzIv/EcPwYtEJGUWLGBFuMooB96bzR4BM833wFW0qUui?=
 =?us-ascii?Q?C35O4dfanx3cip+N7MGtcmHzPJoRBhd3yR61Tg92nvFfrO/JJPzHA6xPk/vb?=
 =?us-ascii?Q?6EP4+xxsvFdwVi4sF+YanMd11CRm6a6TrH9ps16Ol/E2li5RsPmPbiwDwWk5?=
 =?us-ascii?Q?eebkVBf6fTex8+vTA3krltg7WSeGstLJznFH608hdFNOTRfL0Y4Jn4rJTEpt?=
 =?us-ascii?Q?UKmXK2CqfReEcyeMs/mI1thkmcj8870Y8x5z+MhZz/fNC6h2413ttedZocI+?=
 =?us-ascii?Q?nWgEBw7spesaUJAfznH2GOfHsKgb9CymmZu2SS5UHd6cB/lAFzaOE3zDVEQY?=
 =?us-ascii?Q?ZDcnhA0mgiNqLIR48FgJ0DnO+SUD/dtrBM0lBTOBLJnV6P2+Zue6gF/mESZ5?=
 =?us-ascii?Q?CPSQ8RTQklDvtsiZkQuxo5dQ3/wJJEFZkE37N8O9sUqTWNifC+QslZV+R8KK?=
 =?us-ascii?Q?tIS+SeL3qDSzsfnGlLXP4980AUbokmVfxJsY2FHHNay7bhey60AYAfVVaDmA?=
 =?us-ascii?Q?R0QVhINAVKeWMDl7b2jD2rQkpnJMLHesfdBu8XiiCIikwYGjaJGlyyr7s7au?=
 =?us-ascii?Q?2q/1jWt0S9lmqDZfIwCxgg641xj81AI5O+U9pw5fB3T6idkMEiiFcPXEX69M?=
 =?us-ascii?Q?r+/FRI4aNWfOr/k2y5T6FhsdcrCq8bKfgcCfPP5lZl1AXgUjOVwLuvWHMDwh?=
 =?us-ascii?Q?C35NourSSE3E1UVehhJyXeldSCKfIa4l2+mpPd/3wLwdBrFB0GGKdylSWeez?=
 =?us-ascii?Q?NQ1uO5HUh42xG8imeEn5gdYIe+IOnoFPlElwIiWzNPGjNnpPrD9X0MaI54dK?=
 =?us-ascii?Q?tQ1GJtycUa6kpDFbjKzakRoCcp4/aI5tnoTSUjSFqMStU6CtzzPt6Ivh5H4x?=
 =?us-ascii?Q?+2afOdT/PHfHrMIqGpivJFE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FA2D1E9AE8A694186AF272AD34F5F06@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lfUVDQKGaZp5of7Np6xK/IhLJEd9mQ4NA5S5l1OiaJpZn4iKdNq0bGMFRfM6x0wgIHWRBv2YuqnyLQlnEjopjYAwb7RucVe7EdBaPvmKG7BTM5K3eAQ5DqJ1TPxZ14L9NpWWLMczxR8BYYPdrNieVo28nioCH8CO/5NRmg0M+hDlVMhjT6p5aNcCwXgw0JcU+Y970RIDlPAgHXlfRVjMIs/Sf3BzwFolD0S3ssNiWmnyuG6XbcBOcMzqqWOXlrDVkFWJbQLUH2P2dfaky9HGAXLBpg1OwHsaR8HXJVRcRLWsoPIYqNh/kTCDEffnj/894bxzISLh28QdezMFg20Xn0LCwJeod3eSfCZD7eafm23+jGV2NJHL1tp3BwS2YycNPQXgEC8NuNBlBn7pUutjPsgKTz3q3VsLPlQs8Lg1NcarnFJpT3CskcOM8zR7oIWktTI9k0sHAKGNG+Q0ic3ZIw7MpjoMdKZSVfsk1V2dNqYOmrTJ01yvnxmaCCznUOIs2kuHC6ET5Z/RqMidQCz6wtLWGMW/0pD6jSAcyMJam0CLsAplO9594ByNqW+DBgLseFp02cXoXqO02dRMhD5oFDGataIccjtwZf8GKMiDH3pPARoXDLXoWXfkux2pPD3YbTzzC1YUR2WVseWYbgPM9vwB47kslV47G8p2aEYucHnO/A1RhZcaby6ZHN1tKzmDR/ZA85pNLR6gOqQ9RxCLwNVCooHMABXRuwCSdzL9tdwoVlPt9j8kTjXGdMdYm2SRakk7YxTC21y67SkQFtyJEg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ac6731-ecd2-4afe-6a4f-08db6778333d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 16:56:55.5909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68QyTitPZrle64QmPr6v+k2zYEtIHZAe2RKeEzYc/NflOuU8vAc6RfF1xJQRJ3FRSahTUQp357+tDGZM/HbbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_09,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070144
X-Proofpoint-GUID: gJHrJZ7JocHM9G50IzDaHwi2bgCmVGjC
X-Proofpoint-ORIG-GUID: gJHrJZ7JocHM9G50IzDaHwi2bgCmVGjC
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On Jun 7, 2023, at 12:44 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Wed, 7 Jun 2023 at 11:58, Jagannathan Raman <jag.raman@oracle.com> wro=
te:
>>=20
>> John Johnson doesn't work at Oracle anymore. I tried to contact him to
>> get his updated email address, but I haven't heard anything from him.
>>=20
>> Jagannathan Raman (1):
>>  maintainers: update maintainers list for vfio-user & multi-process
>>    QEMU
>>=20
>> MAINTAINERS | 1 -
>> 1 file changed, 1 deletion(-)
>=20
> JJ's last email to qemu-devel was in February 2023. Since he no longer
> works at Oracle, his email address is probably no longer functional.
> Therefore, I think it makes sense to remove him from MAINTAINERS for
> the time being. If he resumes work in this area he can be added back
> with a new email address.

I got it, thank you!

>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


