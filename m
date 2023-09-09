Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA6F7998E9
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 16:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qez7u-0000PV-RK; Sat, 09 Sep 2023 10:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qez7r-0000LC-If
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 10:39:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qez7n-0006G7-7m
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 10:39:54 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 389EPjco013527; Sat, 9 Sep 2023 14:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=98slzcNuziIRMg5+uRuFPJ4qylV3QSTNukaUeFZYpA4=;
 b=0HW84w3kciPJU50yfHxwL3UpoSpw2PEDST/VEQYVltvxvB5BpvNe0zUqZbQkAkW2m2+v
 u/09USq17/YkePx07tHw8YZfLQPNVMprzUBTmj+sXZWLxdfjqZNeNuxw1un8OEUNdn5H
 CcGaTcC/RH92R9Vee5KBlSEzjL/Ts1I/P2HPzIxMaWDPT3LfhRvuas10Ps1bJXXAO4PC
 cV4F0r1RXE9BLWWp+C05X3tzamo85I2RgrFl6LKYedQzXZXarjupF5U/duNoD8cErP09
 FrsMEGnwyX00hpTI4ij3cCcvg76aMvH5V6x60Jtq0RVaZBz9pj/0GF5F6v5LJT+ku6sv 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0tf9g0at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 14:39:46 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 389EKOc4007764; Sat, 9 Sep 2023 14:39:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f52n880-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 14:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6KC2li0XJNWgVeZkd1c/ZhsZmGTCT5HPVhx4ur67Z9H8GqsR9z/d3TlkxeHNIpb6XZSN+Tiw2N3UgeTpt5OIUQQ3XU+MRfBzc3PVZTBuO/GgPdLD2Un56O8dwax3UxQ8KQr85WBfvRfA6UdUHQmzyEMCwuetsLgoYHnTx6q3MCfUlLju3JAt+X903FC48gxU3Nb9KIE68pEm0hKtG9bO7OBJ00hk7vrvoQUxpUkg3P55tqoVs1HBIZ4gDfrVVzvyFjFYguy7xozgJQWIYuxKXVLdb9Hlpk59F599IPmvyMUnfIVKzywxJJtdwPO/i4NS4sokwj46cYudzZEgrdkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98slzcNuziIRMg5+uRuFPJ4qylV3QSTNukaUeFZYpA4=;
 b=jJhth//dkamDh3ChB3QuLcVkD2igZ75HqCMZ5SrnMWNbnC44b23HruIXRn7xPoV8zmmaNuYdjshkId6Va39HPR0+c51Qzqf8eGzqfOd+JpJeaSqmUNbhzwdvKtY36xoDgEU0k2093GH//ZV6N8WJLMu5KEsKBTN4XwdOqqkOgTP2a36evmSQzt0V91vymcHwBHWByPD5mFyFBwUylQEzAy2yQYyjDAo666vzwFFify/ZQoffp78gdMpeXdkRlonSoTjeROCWPxWrRskVLujH/B5dXXz3syURKkcdBXDNyM9lra3bJe/ikU6OJHKYVb4d1NvZ4dsKr343Nvd1nd934Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98slzcNuziIRMg5+uRuFPJ4qylV3QSTNukaUeFZYpA4=;
 b=q/6zNPYKxTIPIXGF+CviVCWK5FUoop+a7C4fdQkjhKbabWmce1FsCWtDjepqTrsgdO+ILD7XnsG7B/TdQ26vbHvUe7BHlQK6eQFOM/IXc47TZMbwKayt1/h2OWWkgpAMeQoBdjo33ldiVyCKBSVd1dXvSZewKwkslPUI1FLoCdc=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB7837.namprd10.prod.outlook.com (2603:10b6:510:304::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Sat, 9 Sep
 2023 14:39:43 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 14:39:43 +0000
Message-ID: <d97aff01-97e2-19d3-6508-aab36218fac9@oracle.com>
Date: Sat, 9 Sep 2023 15:39:36 +0100
Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230908092944.47589-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0224.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:238::23) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e9237e-b2f4-4af6-8bb2-08dbb1429ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCmrOkJWZXd5+/jj/mzH3Rps6DfQ5ZUsWsDO//cIXNd8mxIrRGlul6ZBs6Q1D5INS82eFou0btXucF7erltiqTktpO4aYIzmiT1P5fuk/XKW75+82JM2j71e8wRnT/xR6QRXKNlljQOA3T5I1jZ2x2DKsphmfUK7u8ULUY/jRgtHX0WW3CX8rqE/a3yWlNgR4+uxBlTDZyx1l0NPiaTNstdo3IZP7kQIMZUXsDYRBgm/gr35kGLD5L0batQpO1Plg+PHYIIZPyVZ4uU3cG3rxMmioRE23fQ0LJrC088fHemO+H+eRoOOgjFq44lJjM6IhHvBXuDbT9ehozRlREvLe+6rGMfrR0s6tyW5GdRAPMTzXXpYKTCsU+hfzoaVX7Oy05KR1pFPTnw6B3EMfuaqxcZj0GrUNfDzAbWcMRg5XuCKGeIW9DnW72d2kjCq3Be5lILL6qx0Lz1aJUnAV4X3ruoTKYBopcnvBL1/At0C4oa0RpzXIryjGxPZ5JEh8B7n8q4YyVH0tZZUxB0dCWryXM2aWFtcl4uvQzOwbVS6rGjcmbYQYQJIxv0rTTeD9vxShWZ70nNesQMRdTzWfVUk/+oV8sNKOw5D9O9pjhj4PWbrA+gDNtGKfg5iVxhW7Wit09lSk7Z3aOEkrBi5KZt7GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(53546011)(6512007)(6666004)(83380400001)(86362001)(31696002)(38100700002)(66574015)(36756003)(2616005)(26005)(31686004)(316002)(6916009)(41300700001)(2906002)(8676002)(4326008)(54906003)(8936002)(66476007)(66946007)(66556008)(478600001)(5660300002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjN0dWZ6Z2JWT21XTDlENURqTzlZSVFtMXZVZWN4eWNFQVBYWSt1OHdzVlN2?=
 =?utf-8?B?ZXowekNSbllwbXNvUjhxRlY4MWdpc0xtbDN3bk40dFNWY1cveGt6Zi9CNjJB?=
 =?utf-8?B?TEk4Vzl0N1A2aE1QZnlabForV3B0dm50dG85VHNnU0U3NzduNWY0QWNpbUZG?=
 =?utf-8?B?WngxQXN2d1Mzd0pHelBSUnRoa2dZUkl6QXZYTEhoWGhKRkFPZ0cyZFdJd1Jk?=
 =?utf-8?B?ZEIwM2xvWWdRcEI4UjZEYVV6NkErL24wU01EMk5iOVJ6OS9ZS0JOMkJ0WWJn?=
 =?utf-8?B?K2JWcjkxMTBncW5semkrU25ZS1NhdkpHeHhqYnUrL204YUN0SlFsMEQvNW9t?=
 =?utf-8?B?a0ZFQWVELzVJN25tc3ZCUG5TaWJheXFCdDlDVGlpSlU5R0hTY00zTFVMdnBN?=
 =?utf-8?B?Rlh5enhNL29MelEzWm1nRi9KbThkTllsenI5UGU4b2I2ZlVmU1puT2VhWmZQ?=
 =?utf-8?B?MW04VEVNRnJHb0NpNXpaT3BRenhyMGEvS3pWbXZoQUd6TDRDVzQ5eXhGM0hN?=
 =?utf-8?B?YlBMdEdhQXpkNnVQekplaUpHYUJJeVJTVk1qVG90QUcrSHJpczdzNUpDL0Fu?=
 =?utf-8?B?NkdQOUR1NmxCUHJKakNnOWZNOU5PQmR0QTRXUmVSZXRlOWNGVkZ0Q3pETkxl?=
 =?utf-8?B?TEZaeklXWmR1emFxKzd3aEZzU2Vwa3lTWnYyT3J3NXNnNUNWVXpWS3RtaXM4?=
 =?utf-8?B?N3VPZ2oydDZaVjBEOWRndmRzVjBiVlkreWMwbnpUVkQySUNBRExNaFE3YWJI?=
 =?utf-8?B?NHdadUdmRDdnYUlWbmUyYUd5UlRuYnM4ZVBTUUpnN3JHMWtQT0Y3UU8yQTdU?=
 =?utf-8?B?ZlhUSlZDaWxLV1FnYkxpYno1NzVraWptTXhlUlIrUXcwUEdoaWhsM0h3TXRX?=
 =?utf-8?B?Zk5paHM3ZzFlVitwYVdUZjJqUWlTblZSS0paY2JiczdSdVNXVEkzcXdEZStH?=
 =?utf-8?B?SVpkN0wyMjJXQkZ3RjBGR0UwTHp0UzFCQ09BUkVsUE9ScHdmb09jTXZ2Q3Ix?=
 =?utf-8?B?VGV4cTZUVTlrN1VsYlJCTFNPVFlta21aRW5lQ2ZmMU1OSEZHMGZhQ0hQdGda?=
 =?utf-8?B?QkFiMmxWYkRJMzVyNy9OTXR2R3VxMHU0eUkvcDE1cDJFS2ZadUZuZnZQMDVn?=
 =?utf-8?B?YjkwVEx5VGUvMXBxVDRmaWhGMCtGZmN0OEhjVGhVdmRwa1ErWnpFMklQN2sx?=
 =?utf-8?B?RzBrcFdTNVV4MGlDRUZBRjZYV2dDL00vSVBab3l1Q2NvR2F4L3Q5TE80NUZM?=
 =?utf-8?B?cFVtL2QvVEZEcXFPUnEzUE11THU5RG83eXdjUlhJK3pyZmd2ZktJS2lUSklr?=
 =?utf-8?B?cGVoMzdxcmxFZlNTelp6VmhtdENnTmpISHlIWHhJYkJsc3RLTTBKMW9paXU2?=
 =?utf-8?B?NmlYQUE1TTlGdUdXQVhtSzY0eVZzR0dnM3E2OXJjZm5MY2ZPRFVGT3ZhWndx?=
 =?utf-8?B?TWRHVkthQUo3NHdiQlh6dkZQS2pVSTZqWEJMb0tUb2QwRlVIaEFIUXpEdVNp?=
 =?utf-8?B?aE1lbHZMdkpVeEdjVmdLSXI1N01iNmlGTFBlVjFKSm9NYTVScENlK0lDY0ZC?=
 =?utf-8?B?dW1OamxGaW9jTDVibDZKYmY0aDlISHNCMDZqemMweXY1eXRZVldrdjc3S2xN?=
 =?utf-8?B?RXBCcEczUWdvVzRYU3dKK29mZytDUXhub3lFU0tXeWI2aVJ1eWgxT0l2SENv?=
 =?utf-8?B?aTJRUTZRSS9EdW9HSy9MdjNEWmxlL3JjUnR6R1pZZkxINm5oKzBXNGxidGdM?=
 =?utf-8?B?OE9FNnJwamNLdkZLZE1OV0tOUmkyajFuZDRRdFRsVFlEcFo0Si9QU0xFUDNo?=
 =?utf-8?B?YWt3ZitpNmJ4SnlHUEpxSzRBNmJWYS8raGlLK1E2bW96NDVJT2V0bVNXSG9L?=
 =?utf-8?B?RXY2MDM5WDE5dW92U1FhR1lkWlZWMkNyVVdGV3FkUFV0eUVPUFdGcCtsWlpo?=
 =?utf-8?B?NUcvcDY4dGRGMTR0c0dLY3NBY1lVbVpUSHdJb3pFRVM4cFYyaGFMcExRYXNM?=
 =?utf-8?B?MFFiQmpCOFhpaDJTM2NIRVU5SDRNMWRuTGlCcWJHNjYxaWx0N3Niem9JMlor?=
 =?utf-8?B?aGFUOHVXRVpzelhLV1RnaXlNcWxJMStuaDRNZnFUNytXSWpUZWcramVpWFFo?=
 =?utf-8?B?Q3p5aUxSOEVvUjdkQkoyU1RNYmR3dldIczVuMGpUUEx4VE5taldML2pvSEl3?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7y4Pv3OyPemlUSUoJKDLrQCV06nhSyEwWeM0l7+EoSBA+m1aIbkBRPkg+fSpl5oX9tz8pVb1CIPdjwQe8bGQsOCWhWc/AkKxExUy0tu48+ZZXk6IJxu1/DMy9nr8uJ2P9QT4Qtut/M0jsp4QYhRR1yfP6AL82VabD5YNXiPZzA3dCCMDXpGdp5RUUqs7/76xzdPqFcipsJiWOWKG8jqgAOydbmnsjPE6R3nilWCyr833fcrZnWbCg+m+c6cWHIzpKMqeC12eYjFNZQc1upkaj8Sn2MBRyr6DUdU5QeDbaC5uxDiMmGyvIPYO9F6FNjWJ2v4ElaGkdQc+oTR1YmokeXO5Klfc/3OBbVcgvrJVDAht+QrqSIkJU9G6mY8y1oMxMjem2w5DD+gDouwzTwghP1SpoxL3uj9rCH+PCIgSsUYo84UnzjjdapvsM5CfMiJPuTybbB5zu/3M1humBDQfnyoFTs0d8F6aIg46m0T7vkWoBShbAU/v+EfTosk5Yw43OHNMxDfuPBcDoLvSMICqjaCbtTx8xenvtyqbO2mkqgo394rhrXMFtbqegvJWouXvIa63gmNICAzz/vfoIQmwzJ7HDmEwOqw28vqAeOGi0M6qpF82HypXDy2YzN/toGBp5AhhQ9UU3Qn1ziVydw3VzojPkJ0w9NoSoFoU51o8u8dFcC5+bcUQdxuWwIrqUopEMbUuqFrOk0BAB9xArPKOQntDSbf3vrmev2Ry7Xg6V+/sGDUXJCbnILwSIO/TxipvEUgR8L/d7hLkDyJTl3xAZEN3i4DwTvXBoZ067xL/zPU+k1t0q9dex91VThO6z+Q4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e9237e-b2f4-4af6-8bb2-08dbb1429ad9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 14:39:43.0281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jp4jBHWBmgZQ5K1uuT5MfQjMZM6Uo0w2ubIw8dkAj4m+q3B61dhd/a0wUFy608Xyx/lRNvjF4OZPfQrAW8sI1ZPfKxbEFJ13xoShJxxZ0/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090133
X-Proofpoint-GUID: -RPJPB3bKNAAKdBG5Q92TqvK9Yd-vfG7
X-Proofpoint-ORIG-GUID: -RPJPB3bKNAAKdBG5Q92TqvK9Yd-vfG7
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 08/09/2023 10:29, Joao Martins wrote:
> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
> QEMU includes in the 64-bit range the RAM regions at the lower part
> and vfio-pci device RAM regions which are at the top of the address
> space. This range contains a large gap and the size can be bigger than
> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
> 
> To avoid such large ranges, introduce a new PCI range covering the
> vfio-pci device RAM regions, this only if the addresses are above 4GB
> to avoid breaking potential SeaBIOS guests.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> [ clg: - wrote commit log
>        - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

This should have a:

Fixes: 5255bbf4ec16 ("vfio/common: Add device dirty page tracking start/stop")

> ---
> v2:
> * s/minpci/minpci64/
> * s/maxpci/maxpci64/
> * Expand comment to cover the pci-hole64 and why we don't do special
>   handling of pci-hole32.
> ---
>  hw/vfio/common.c     | 71 +++++++++++++++++++++++++++++++++++++-------
>  hw/vfio/trace-events |  2 +-
>  2 files changed, 61 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 237101d03844..134649226d43 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -27,6 +27,7 @@
>  
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/vfio/vfio.h"
> +#include "hw/vfio/pci.h"
>  #include "exec/address-spaces.h"
>  #include "exec/memory.h"
>  #include "exec/ram_addr.h"
> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>      hwaddr max32;
>      hwaddr min64;
>      hwaddr max64;
> +    hwaddr minpci64;
> +    hwaddr maxpci64;
>  } VFIODirtyRanges;
>  
>  typedef struct VFIODirtyRangesListener {
> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>      MemoryListener listener;
>  } VFIODirtyRangesListener;
>  
> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
> +                                     VFIOContainer *container)
> +{
> +    VFIOPCIDevice *pcidev;
> +    VFIODevice *vbasedev;
> +    VFIOGroup *group;
> +    Object *owner;
> +
> +    owner = memory_region_owner(section->mr);
> +
> +    QLIST_FOREACH(group, &container->group_list, container_next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> +                continue;
> +            }
> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +            if (OBJECT(pcidev) == owner) {
> +                return true;
> +            }
> +        }
> +    }
> +
> +    return false;
> +}
> +
>  static void vfio_dirty_tracking_update(MemoryListener *listener,
>                                         MemoryRegionSection *section)
>  {
> @@ -1424,19 +1452,32 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>      }
>  
>      /*
> -     * The address space passed to the dirty tracker is reduced to two ranges:
> -     * one for 32-bit DMA ranges, and another one for 64-bit DMA ranges.
> +     * The address space passed to the dirty tracker is reduced to three ranges:
> +     * one for 32-bit DMA ranges, one for 64-bit DMA ranges and one for the
> +     * PCI 64-bit hole.
> +     *
>       * The underlying reports of dirty will query a sub-interval of each of
>       * these ranges.
>       *
> -     * The purpose of the dual range handling is to handle known cases of big
> -     * holes in the address space, like the x86 AMD 1T hole. The alternative
> -     * would be an IOVATree but that has a much bigger runtime overhead and
> -     * unnecessary complexity.
> +     * The purpose of the three range handling is to handle known cases of big
> +     * holes in the address space, like the x86 AMD 1T hole, and firmware (like
> +     * OVMF) which may relocate the pci-hole64 to the end of the address space.
> +     * The latter would otherwise generate large ranges for tracking, stressing
> +     * the limits of supported hardware. The pci-hole32 will always be below 4G
> +     * (overlapping or not) so it doesn't need special handling and is part of
> +     * the 32-bit range.
> +     *
> +     * The alternative would be an IOVATree but that has a much bigger runtime
> +     * overhead and unnecessary complexity.
>       */
> -    min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
> -    max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
> -
> +    if (vfio_section_is_vfio_pci(section, dirty->container) &&
> +        iova >= UINT32_MAX) {
> +        min = &range->minpci64;
> +        max = &range->maxpci64;
> +    } else {
> +        min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
> +        max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
> +    }
>      if (*min > iova) {
>          *min = iova;
>      }
> @@ -1461,6 +1502,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
>      memset(&dirty, 0, sizeof(dirty));
>      dirty.ranges.min32 = UINT32_MAX;
>      dirty.ranges.min64 = UINT64_MAX;
> +    dirty.ranges.minpci64 = UINT64_MAX;
>      dirty.listener = vfio_dirty_tracking_listener;
>      dirty.container = container;
>  
> @@ -1531,7 +1573,8 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>       * DMA logging uAPI guarantees to support at least a number of ranges that
>       * fits into a single host kernel base page.
>       */
> -    control->num_ranges = !!tracking->max32 + !!tracking->max64;
> +    control->num_ranges = !!tracking->max32 + !!tracking->max64 +
> +        !!tracking->maxpci64;
>      ranges = g_try_new0(struct vfio_device_feature_dma_logging_range,
>                          control->num_ranges);
>      if (!ranges) {
> @@ -1550,11 +1593,17 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>      if (tracking->max64) {
>          ranges->iova = tracking->min64;
>          ranges->length = (tracking->max64 - tracking->min64) + 1;
> +        ranges++;
> +    }
> +    if (tracking->maxpci64) {
> +        ranges->iova = tracking->minpci64;
> +        ranges->length = (tracking->maxpci64 - tracking->minpci64) + 1;
>      }
>  
>      trace_vfio_device_dirty_tracking_start(control->num_ranges,
>                                             tracking->min32, tracking->max32,
> -                                           tracking->min64, tracking->max64);
> +                                           tracking->min64, tracking->max64,
> +                                           tracking->minpci64, tracking->maxpci64);
>  
>      return feature;
>  }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ce61b10827b6..cc7c21365c92 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -104,7 +104,7 @@ vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_wi
>  vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>  vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
>  vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
> -vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"]"
> +vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>  vfio_disconnect_container(int fd) "close container->fd=%d"
>  vfio_put_group(int fd) "close group->fd=%d"
>  vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"

