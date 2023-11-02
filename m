Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50A7DF9E1
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 19:27:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qycNr-0005V0-83; Thu, 02 Nov 2023 14:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qycNo-0005UZ-5x
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:25:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qycNl-0004yK-PA
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:25:31 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A2FkZdd010265; Thu, 2 Nov 2023 18:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=y29DbySuD5XhlPtmypE4KLkE42je9lXf6ckOKqIGJOo=;
 b=VG2IXeIH5c6sJIhdXWFApoOGJmiDMR43zzho8DYdWQsNZhBgouOpCC1p3o/pC+SyGPfU
 Qa5dsVYWmLyL8B34UV95KNR52fxUVdxsRHkovKhVGoqGNZPibwZfAoCaJ75axPPr2d5B
 iishAVGKmD6bzWx0geIRxivU0Kv+hCjki/X+KI5KiCGA47xYljeogmO3+rso107h6mnJ
 yPx3FKSeTXzQI4/hrJgEuAFSV26lCh5xi7xxibBAfrZwdWD29PSI+3Sk6gfmlixNkyh4
 qyy5xXbzej1l6rXgc4AIWBlicGXkDkRsk4st6OySvIjpw7VvZft9o+0UAlFj5xQMmnUr /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuujdcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 18:24:57 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A2H175b009098; Thu, 2 Nov 2023 18:24:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u14x8uh6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 18:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abEuaB479gYXOoNnlpUQ8lwhFAzfGGS6wW8eWYIyJBjTmA2+ZgwSsDbTvSkOYxXJ+yAxM8txjYfwcsRdko2bxKUheTOZoACRLbt3jtSo8cVMR/JNV8AIwkmXDJ0zbalJZJmoaJjjh+gR5sQwWHiClV6vs4Te+uJNWPFaaXuJ85iPs7X833IAwhgmYmfsiIohffCB/L5fHWDFE4n6GWdO9c8C2JXP/xp/GzHTTlSDdDcOPLIxwkj5c8FhOmpHNVbECutsHctQft5sHwKYjWsqVRk5X1sKCJFlnqKkECOEcIyGe4vUuDgk0u/oRXxv13C3RRYdJMuAponIc4UufQwKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y29DbySuD5XhlPtmypE4KLkE42je9lXf6ckOKqIGJOo=;
 b=IUBlR/Hv2qG8s7tQIe99ktMl1qhNI1hx6ibACV8jBlUm466UXqmanK28r0r3cASvlG3aZQebBvAkbayk+lSBmvBXTs0Sag74QYj0YezUHKdMYmYWlJQpZUpgy6WVUEET1C4lyR3RToxBmf5xOd09fLBDQpwx3w/8/hGozX28tNHKPjPr+TXhvBWpxJ7pnJGVLmeZRSAlHPAUSp+c5harmtVSuKtWFXC0jX+Ic1T9VVIgSv6Ai5VwFA8HUXwHCPWG3x4fkOoeJ79VTC76AMf54/Z06EaE0+T5wqisgjnFzonQALMJY9IRbQk+dSz+Ud0tCK8YN/jU2yzV1JJocgl2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y29DbySuD5XhlPtmypE4KLkE42je9lXf6ckOKqIGJOo=;
 b=JvWaAs75rXiL5qP2lIXwgsNxFELdxu3ukbCCEXromfCJ2QgmYXZxYgNX9vymIZWfsukeSC9NhEuSMCHP7CfcAFByOrXynRRhS+okipDm0rVoG+3C4d665tL9Tr/ai8iyUAn6oAATEl3nC/rk/yz9HKcJk6cGwHYcmvjqv0xi2Ak=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 18:24:54 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 18:24:54 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, Omar Sandoval
 <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 qemu 2/3] dump: Allow directly outputting raw kdump
 format
In-Reply-To: <CAJ+F1CKOWYwrjmLoiQRC=s8XBBE-x2qvABNX1bUVgQdtG-+Q8w@mail.gmail.com>
References: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
 <20230918233233.1431858-3-stephen.s.brennan@oracle.com>
 <CAJ+F1CKOWYwrjmLoiQRC=s8XBBE-x2qvABNX1bUVgQdtG-+Q8w@mail.gmail.com>
Date: Thu, 02 Nov 2023 11:24:52 -0700
Message-ID: <8734xo3te3.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0273.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::8) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SJ2PR10MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: d586a28d-60e2-4a62-1a34-08dbdbd102e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q39za0/J7lCaU37InjmZZWxU2xZ/IeaOBgg1CiAUe81QPI1iNVJwYZxc0u6qQzYziZRFSYTxZ1G6Vcrv7XW9330noDTJaIUb5lAqmnp1WF6YAbbsA4epoZe8Lcd227N1/kowbVMFax5FiObmJjaG3JycniPf/zxLtIyrBrn5tglzhIHnP5Agai9YYBBjMwUVclEGq9jfssiXApafFOzRJGr24T+nQa7su4czzalwDkqX6OCp86GU4XKC/X855r+LUXFkLrK37QU4WFXQ8OgCBnpl/Bsy4Ivz/cqwRwlyE2sNYtRsT+HBYM7fDVe5Zq3/2x2gnIGYmYp5UGnJ6iZIdlIasgZtIMg11uKx3wzQ9O24i5pN2Fb/VL5zcjQ7dzlC+HPLXijnJGrtT9uzL2Guh25WMDhnIqG0R5du+Ln0XeyD7hqukrqhgy0BlP6hgUxxcS7dTEMCGYjxp9oMVuxS02GbTe9SCR1/zpx+/T6062R0QFvkCxcLRebzbn+b37gizE8SrlSIk+i8sJZxWQnnE1QmGeQkNUrKh9e9tCmpj4ZXV7KQBHOGifUMj3MWaUwEZZ+LRCq32nHrhE3FrhiMVLj1QMr9O+GkRzcB4ILn3cc20rUlPLj6gZOeyuo3RTDY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799009)(66899024)(36756003)(6512007)(2616005)(86362001)(38100700002)(2906002)(83380400001)(53546011)(5660300002)(478600001)(4326008)(6506007)(54906003)(8936002)(6916009)(66476007)(316002)(41300700001)(6486002)(66946007)(966005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBwelQ4NGpzeDIrUHlEZDMxeHl4NExiWUFkb0dFajdkVmJLUTZlSW82bkth?=
 =?utf-8?B?K3M4SzYzN05zS3VTWmFtMTYyTTF2Zm9vSTdvNldSU3cwVzV0ZmszakhrZFZN?=
 =?utf-8?B?eEhZN2FSclMvU2lqbDVhU1VOWWVzMmw1VkMyUmpRODl1Q1QyWDRUbm12M21x?=
 =?utf-8?B?Nmp3V2Fpby90TnBhUnFES0RjREVNWDF0anVMOEFqQmVLOE1ZSEg1SkplZmtM?=
 =?utf-8?B?OXNnVXl4OS9WK1BkbEdYRVN1NnE0ZXJXNVYwL3FuK01HV29RY3ZMc0FaTjNw?=
 =?utf-8?B?OUc5ZWJwSkpCV1lRSWpWNXJQL3BBeVRxUEFIRjQyYnFSL0g5dWNYaWtGelMw?=
 =?utf-8?B?THB1b2FUdEh0dy9jWWZ6RS9CU3ppUDFISzVOdk5UbnE5UTQrV29xSWpJcEJW?=
 =?utf-8?B?Nm9RekdoMjJhSE9RaWJ5TXl1ZXNnL1dGeUZlaFo3blN1Y3U4TUUxR0NiTzho?=
 =?utf-8?B?Y2hHVU5Id3AwTU4zZmlkN1h3MHUzNlp0c2VoU1pkSHQrSC9JSVFVclg3Qit2?=
 =?utf-8?B?RlptU0ZxaE9tSWFNOTFVbUI0djNESFpvZ3JBUngybzViYm5WUkJYRWR5dkE4?=
 =?utf-8?B?TkxzRW5rYmNuTDgxVlJNblc0QmsrVWE4VjhKK0VkUGJ6cGcrbGdZTEhWYUN1?=
 =?utf-8?B?YWtMUm1qd3hkZHlyRFZmbytUMWRYZjlUMXpnZ0pTVUcyUjF5L1VKUlp5bkc0?=
 =?utf-8?B?WTN3OEFNUXJTNllwOGVPQWVnSE9HaXA5VUlldXF5c3U0RTFveklDUWhsZjJN?=
 =?utf-8?B?Y3pKNFFDbmRxR3pyamUxNHZKa2tHS1lGT0FTY3NIVFVrRDV6NXQ3REdyMlJF?=
 =?utf-8?B?cVVyZEthVGMxNHkxRG9PNDJaY0ZEeG12cWJDYkd2cXlpR0JRQ2FLc09kRTF4?=
 =?utf-8?B?dkZ5dHU2RmFWRmVUcVFzSktOd1FsQlhKcm9ldHo4Szk1YURpbHR6SldRU3JZ?=
 =?utf-8?B?Y3NjdVFnS3JDRWpHTFc1a2wxN2NQRVlwR1RoeHdBQnpwOHh0Si8zcDBpbE10?=
 =?utf-8?B?Tm5ZeElBQTRPQ0hnS2I2UGVmck81MVZhY3BCQ3VhaUYwVDJvOFpLejk2VXNG?=
 =?utf-8?B?NG9Lc2VzN0FnWHpUZDl2cTc1Q25OWG9wS003bjI1SDcvTFhBYlhNSk9yVkhE?=
 =?utf-8?B?TlZpK3IxRHpiNkN0dkV1VlJ0Skk5bGxpcWFLVm1YcFBiVjUzeC9OTGlwMUxE?=
 =?utf-8?B?eVcwTjRselhtZUNnUUcvdVhMc1pJeGtpNEUxOU41NFRnNzNjczBaeFJiK0g4?=
 =?utf-8?B?V3pZNkI3cDFuVlI2UFF1TXA4ZTFmUmFySWNLb3Q2L0g3TEkzT2pKSlY1amxR?=
 =?utf-8?B?SmxjMUdhNHJmWXJwWlNwMnRadFlvVkZCZGFERWYzVEw2ZWlSWk1RYi9wMUcx?=
 =?utf-8?B?bDd4b1ZKUitWOXhJUm1wSi9uYkkvcWpPa21OczBZaDJiQzNWR21HM1M4OXFP?=
 =?utf-8?B?a0ZIYkMxY1BUREwvbHZmRFU0b205ZVpUQmo1VS8wQ0JHRzRrVFdrUzE1RVdx?=
 =?utf-8?B?ZXkySnNlWnJHMExuQzVkQUpick9tQWFDVW02QWphR3BZVlEwSGlra1dPUGFZ?=
 =?utf-8?B?ZmN0VFFzUXBTbzZsd2k2cC8xTFF0SW9vUC9ibUJ3V1ZSYzJuQWxTNnV2MXhn?=
 =?utf-8?B?Z3Nnd1ZJczhMZ0dTM0FseVNnL0tSWHM0NVdHS0M4SFUyalEwWUs4RWFWekVz?=
 =?utf-8?B?bnJ0aDJLdkd2UGRKbFpPUENYWHZzV0Nqd2V2VHB5eDVzdzcyekdlb3lkM1Bx?=
 =?utf-8?B?S3dWTzdCR0QrTmVmak5EaFZyUDcycGIybVcvSHVZSVdRaVFFRjRuUHFvVVpm?=
 =?utf-8?B?cjBWcW14eGdwSFZ6VXJFSFN2SmRoeFZaazdzQVlMc2VEbUgzcE43Mjl1Q1VI?=
 =?utf-8?B?Q1pNNStubjdXalJJa1Z5cFYydDVFdGUzckVSMnM4RTNnSHowUmEwZmFMdW9L?=
 =?utf-8?B?YVZYRFo3K1JLU1hLRDNyNE5lSjVZOVZ6ZTk1N3J3ckVhZEtJdWJSR3FMbHgr?=
 =?utf-8?B?dWxRYXVMUERTZTdXcWhkU2twVk55N3B6RHEvV1dlbEJSOVNvcXBiVE5JczBG?=
 =?utf-8?B?Y3RpMWpLbEJVSHViY2tHeGp2aWIreHY2Z0UxNmIvK2RzTHYvQUJsdjJQNWFm?=
 =?utf-8?B?d1g4dkZYdXF6YnptUzB4SEV4S2tZa1ZrUVVCM1FPTUpiY2pTbWtiaVZITE55?=
 =?utf-8?Q?OtHdfyvZ7Z7RRXc8M4aoOCU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xavlu3P4wXHQddh+wvg34fG8znbxrMXEExQbQ3VdmhiWv9TXZ2Ny11Eohrsx84rrwcYzQtb0usDoLY2wIMVxlmecy7LomRqsW+Jni1jSPt4om39sL3JQf6Fyb2UuENaurltIzqIph88vxDBIbpVM4c4fthX3HaSVG80Vpp0r8RDm0IoYq6NQPUxYOzERsbI4oyO/dIeMOhmW7YKqET7MWW7qYI+kBNbKjoMdBGEf5Y22sP9n9HsQ8J+aqNfAZkqPeGN/olWvP+XUoLZnfdU6MoyE3XJwD9wLB+M5zYwtaSB0AVMU6W7QjvK1tL6070w4EayTXGPTM75RjnvjjTC3HssXJ2ApgUT59uagi+wUSgvzMlAArryGGlwuh+mJBD7VAE+C88P9CaUcg9zILglMUpf5VE2DasNkNcUdRbjHbVChzqoqGTpBEcVB38bEr7vovXkkLaNTCfc0fi/4wOi+wI5Wy4ilIW1xQIqkfiKa/hhQmsCWwZ91bzZbL5hg5QGop8tZ5iHIOr2G5k660uMU+otILPduS/rqi53sOzRMzMF/FRJSx9EmLMZsw7rJ1CmZq5smj+KTP+TPceD0AJP3bnS02MW3BwXbEvnyB32Lmq5z2BB9uCWqJ30+y4/OJuM58Z6Fm+qnxDkF2sfAso2d1vudeRd3wiEm9QP4ltJX9idu3IsMribZTdDm7VaVCw7CIpHODnFgXXYzHwMnE6828zG88gRZVaxw0yq16gkpZ0ATm3Apy9wvrmchg2IgGs/D0ZS+1MvCTnbTulPV0DCCgOIj5cVTxP6nWAfEoS3nU9N8LGcwYQTIl/Gs21RluV0pVSCXQzyy2Pp5tmupVqQShWJccgS3OOgeHGilufjqZUQF8MYG4O5kFvoXW61jg9Y0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d586a28d-60e2-4a62-1a34-08dbdbd102e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 18:24:54.8062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGl3yNVfKkx663axOireSccdD34OGGMNwc+Rjo+Ujx1SL9snx+0ea4TUEFUJSyrm5yHBaqSByUK4b/aq2pWR/NLdubLAN6SaXp0xLVf0yN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_08,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020150
X-Proofpoint-GUID: 8kw3Bw8PKwuLXajpJLKabMHiC7Dap3KN
X-Proofpoint-ORIG-GUID: 8kw3Bw8PKwuLXajpJLKabMHiC7Dap3KN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi Stephen
>
> On Tue, Sep 19, 2023 at 3:32=E2=80=AFAM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> The flattened format (currently output by QEMU) is used by makedumpfile
>> only when it is outputting a vmcore to a file which is not seekable. The
>> flattened format functions essentially as a set of instructions of the
>> form "seek to the given offset, then write the given bytes out".
>>
>> The flattened format can be reconstructed using makedumpfile -R, or
>> makedumpfile-R.pl, but it is a slow process because it requires copying
>> the entire vmcore. The flattened format can also be directly read by
>> crash, but still, it requires a lengthy reassembly phase.
>>
>> To sum up, the flattened format is not an ideal one: it should only be
>> used on files which are actually not seekable. This is the exact
>> strategy which makedumpfile uses, as seen in the implementation of
>> "write_buffer()" in makedumpfile [1]. However, QEMU has always used the
>> flattened format. For compatibility it is best not to change the default
>> output format without warning. So, add a flag to DumpState which changes
>> the output to use the normal (i.e. raw) format. This flag will be added
>> to the QMP and HMP commands in the next change.
>>
>> [1]: https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a27=
46dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  dump/dump.c           | 32 +++++++++++++++++++++++++-------
>>  include/sysemu/dump.h |  1 +
>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/dump/dump.c b/dump/dump.c
>> index 74071a1565..10aa2c79e0 100644
>> --- a/dump/dump.c
>> +++ b/dump/dump.c
>> @@ -814,6 +814,10 @@ static int write_start_flat_header(DumpState *s)
>>      MakedumpfileHeader *mh;
>>      int ret =3D 0;
>>
>> +    if (s->kdump_raw) {
>> +        return 0;
>> +    }
>> +
>>      QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
>>      mh =3D g_malloc0(MAX_SIZE_MDF_HEADER);
>>
>> @@ -837,6 +841,10 @@ static int write_end_flat_header(DumpState *s)
>>  {
>>      MakedumpfileDataHeader mdh;
>>
>> +    if (s->kdump_raw) {
>> +        return 0;
>> +    }
>> +
>>      mdh.offset =3D END_FLAG_FLAT_HEADER;
>>      mdh.buf_size =3D END_FLAG_FLAT_HEADER;
>>
>> @@ -853,13 +861,21 @@ static int write_buffer(DumpState *s, off_t offset=
, const void *buf, size_t size
>>  {
>>      size_t written_size;
>>      MakedumpfileDataHeader mdh;
>> +    loff_t seek_loc;
>
> Any reason to use loff_t over off_t here? It fails to compile on win32
> for ex. I can touch on PR commit otherwise.

I think that was an oversight on my part: lseek() uses off_t.

I see that qemu is compiled with _FILE_OFFSET_BITS=3D64 so off_t should be
64 bits even on 32-bit architectures. So this should be off_t. I believe
the compile error would also happen in qmp_dump_guest_memory() where I
have:

    if (kdump_raw && lseek(fd, 0, SEEK_CUR) =3D=3D (loff_t) -1) {

If it's easiest for you to tweak it in the PR, please do. Otherwise I
can respin the series replacing loff_t with off_t.

Thank you,
Stephen

>>
>> -    mdh.offset =3D cpu_to_be64(offset);
>> -    mdh.buf_size =3D cpu_to_be64(size);
>> +    if (s->kdump_raw) {
>> +        seek_loc =3D lseek(s->fd, offset, SEEK_SET);
>> +        if (seek_loc =3D=3D (off_t) -1) {
>> +            return -1;
>> +        }
>> +    } else {
>> +        mdh.offset =3D cpu_to_be64(offset);
>> +        mdh.buf_size =3D cpu_to_be64(size);
>>
>> -    written_size =3D qemu_write_full(s->fd, &mdh, sizeof(mdh));
>> -    if (written_size !=3D sizeof(mdh)) {
>> -        return -1;
>> +        written_size =3D qemu_write_full(s->fd, &mdh, sizeof(mdh));
>> +        if (written_size !=3D sizeof(mdh)) {
>> +            return -1;
>> +        }
>>      }
>>
>>      written_size =3D qemu_write_full(s->fd, buf, size);
>> @@ -1775,7 +1791,8 @@ static void vmcoreinfo_update_phys_base(DumpState =
*s)
>>
>>  static void dump_init(DumpState *s, int fd, bool has_format,
>>                        DumpGuestMemoryFormat format, bool paging, bool h=
as_filter,
>> -                      int64_t begin, int64_t length, Error **errp)
>> +                      int64_t begin, int64_t length, bool kdump_raw,
>> +                      Error **errp)
>>  {
>>      ERRP_GUARD();
>>      VMCoreInfoState *vmci =3D vmcoreinfo_find();
>> @@ -1786,6 +1803,7 @@ static void dump_init(DumpState *s, int fd, bool h=
as_format,
>>      s->has_format =3D has_format;
>>      s->format =3D format;
>>      s->written_size =3D 0;
>> +    s->kdump_raw =3D kdump_raw;
>>
>>      /* kdump-compressed is conflict with paging and filter */
>>      if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
>> @@ -2168,7 +2186,7 @@ void qmp_dump_guest_memory(bool paging, const char=
 *file,
>>      dump_state_prepare(s);
>>
>>      dump_init(s, fd, has_format, format, paging, has_begin,
>> -              begin, length, errp);
>> +              begin, length, false, errp);
>>      if (*errp) {
>>          qatomic_set(&s->status, DUMP_STATUS_FAILED);
>>          return;
>> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
>> index e27af8fb34..d702854853 100644
>> --- a/include/sysemu/dump.h
>> +++ b/include/sysemu/dump.h
>> @@ -157,6 +157,7 @@ typedef struct DumpState {
>>      MemoryMappingList list;
>>      bool resume;
>>      bool detached;
>> +    bool kdump_raw;
>>      hwaddr memory_offset;
>>      int fd;
>>
>> --
>> 2.39.3
>>
>
>
> --=20
> Marc-Andr=C3=A9 Lureau

