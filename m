Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E1280100D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 17:25:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r96J4-00023m-5O; Fri, 01 Dec 2023 11:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r96J2-00023O-2J
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:23:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r96Iz-0001oX-CK
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:23:55 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B1GJu6j025412; Fri, 1 Dec 2023 16:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SMKVizHDC5ar6M58L6yU5DmDJdr9H8QSpPhASlsaBf4=;
 b=QnO4L3t4GDlFOXpJaPsrsf/JtOjLBRRIyRjljsDx/GUti0stZWdhfPGcxbsrJk4Go3Rb
 TPXWvoweFUPTifoKW1VIS/hy5Tzf/bsuX/5kEXyAvxp4r9Sv+WvPCfhX1t4FXXbfTfsy
 OTr1eN5g5A5SOxeHNGz5zMns4FVMsMDISFo0eTx2hP70/NcuZKd1QGiLcGfO6/wzWntm
 okiQMWnsTmmQRuyDOxJXmfJaBCn+b84YtSiCAI4Xh4DroaB+2DDID9nRbF1/4bHyTOSd
 /YVZ/vE2O4ERqkfHZbQ1PoTHg5Ig2OYp8YYAUS21g8il8FzhY3Vzt0nbNpbk22W5W99g 9A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqhgd07em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Dec 2023 16:23:51 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B1G4t36027234; Fri, 1 Dec 2023 16:23:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cc1pn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Dec 2023 16:23:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhQa2FLkBwh0jpnyYPvmusgGZloTBAGyewhf0KD0rD9Rjfow5lUvOfyjrw7D4v07IK6SSvJX+6ySO+yz+yZHJ1pS90gsxV4OS58aQpfjVkrBHrhaeoyRZQdWuMO+rDhThCQUONhwgP5FXS3Ca5exbjmldY/QBdsMFQ/mA8vgToBcw7STgdfVXOn/PhsAYh1a1t7ofvJhZ2gCcoM/jsBnNGVRhGABRH5PKC9ab8t5vVQPrdUTE8+J0vxBbM32E+ljKGNucbzB9QAVYCv92F+OQaKTeD78zDZVxSvbAEAidA6KaAuZO0eh0/eINDCN78j1XczQalT7D/reBW/ZKJovhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMKVizHDC5ar6M58L6yU5DmDJdr9H8QSpPhASlsaBf4=;
 b=ip9H68L3V13rIIIc0zn84tmUdyJX6O9dkJnaZzRtlgUVFkqP9mh+7pMxX5MAZ+lvnRCpkgkL+RCf1mCq4E1OhKj79Zbew1eKbNTFlV8l+vcLZl30MbB8ZOHj8i+tKTQ2kcRRb6NwnCqLmJ9kYijyojGrGiFhstbQ+xzoNH599ipFjWvPDkd9eg5kVQt1sRlQDI5mJOjVO/s8TrrNjcAtXV9HVJi9R78ARZUhbkoUIOrSXpNvZFyuKsuEN8MLXfU2zr38/aiPNJCsXt+5jVlt5JeyRmKIhxic/dx0rnUu4PFSC/7C9Vg5kH882que2NJSbYJlhGx6YLm/WmspbraCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMKVizHDC5ar6M58L6yU5DmDJdr9H8QSpPhASlsaBf4=;
 b=zYXFdxvct7evbyIaMa/UyrUByKeh/yiZOld5PBxj/jY/SqF6RaJPmKqkzr7oasLOKc8GcuD1w/EGL9Uq1g9OYDhhNiaCiAbiQh84iqKH6QY2V64ZEe264Wnhk79KQbF1Y0FLRXPh6mUHkKfRKCeZPCYWzSqq1tO7evT1/CKt6nU=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by BLAPR10MB4849.namprd10.prod.outlook.com (2603:10b6:208:321::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Fri, 1 Dec
 2023 16:23:38 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::f3e1:362d:53d0:9f87]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::f3e1:362d:53d0:9f87%7]) with mapi id 15.20.7025.021; Fri, 1 Dec 2023
 16:23:38 +0000
Message-ID: <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
Date: Fri, 1 Dec 2023 11:23:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZWkVbiQNl16hC1LW@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0329.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::34) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|BLAPR10MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6d6728-7e26-46ce-f15d-08dbf289dfe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Agwr5ot2i07szWqFD96kfiEwrI6oR4tO3682fVXBg3TVJoFLAzQ2KvRGu3zN/4x3DfiedM/tTQKCcnAlUcLFyn13ObAVIJlU1oFlio4Rzf3SRqffCuHrkmIcdQ+oY+6Fhv/jvm20RHBLdhDpzCVsBhuIdmCHc49R/0xXNIRAZZqQQVKlXE6T6V/vjfB8vWXh0noYqc5I6Mymx5WESIu1IFldA0czmAtylDa1PDkVHocbvGHsvsULB/dwK/y4YLS9EY+PIpHq24JLnJHnzWnyJldmC3Ti+hoawEkJLYTvIa3du26RpXdwKMfEuNa0RnmNv0E00NZD6tKyyliZIRUIDAhgj5lOqc89Xoj5/M8I5oLc+bM13ZAg02gDwFJUyMVbU1XUON53Je9ZZDzXZYxd1MX8O3JQNlociC6JUHnLKOL5dPgv5hlyY/wDt39HgDs4diO266cqzmQvj2J1vZk1VsB/aqIi/4KGzVKPw8GJkQgmI9MyVVpYJ3eYVJ5Wo03NNdJE4n+/KHkJIhHHPdmHuIrQQlP/EVt5vLwVwELRXxw7kY1n7qLPFygdHrRFXu/PW5Z/ontF07PzipvJ/MBOLwIcQxI/ybOat8N0v1fU5l3JXUizxzXk8+1K0Yi5FvCGfn6WO1YizjPYtnBRq8lyaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(6506007)(53546011)(26005)(36916002)(6512007)(2616005)(15650500001)(38100700002)(31696002)(86362001)(36756003)(2906002)(478600001)(6486002)(44832011)(5660300002)(83380400001)(8936002)(8676002)(4326008)(41300700001)(6916009)(316002)(66476007)(54906003)(66556008)(66946007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlB5ZjlxeDd3d3IvSmxDQzhkRDR4SFZRTTBlb0hKSmtRY0Q5cGVyd0hyRk1y?=
 =?utf-8?B?azM5NWJzTTcrb3hRL0NmTit1ekd4dllaUEhzcUhCVHdVaUpsdEtGU08zZkNU?=
 =?utf-8?B?d3o0N2dDcFRweHU3dGxKRkJJOHFnN0x5NlNhTnY3b2Rva1F5Q0hzTlJMSjRD?=
 =?utf-8?B?N05abzVpMWhtRERaZ0M3dkM2UFkrbnRmL3JZRGswNHlTOVlGLytiNnF2SDRY?=
 =?utf-8?B?WCsvUUo5dmlqR2IvdjUvb25qN2MzUVUxUlArbFgrcUNFdTViT1U0NEROOTEw?=
 =?utf-8?B?aG1lbXhkOVk5STVHRTQ1S2E0a3c3dEN3VG9qclJxQ1ZZMTlJK2JmSm5tb1VS?=
 =?utf-8?B?ZVRRSUJ1dDNMQUpiRlVrWUhVZFBKdGMyV2oxb3N0aXdSb0E4bG1mVWJ1RHlL?=
 =?utf-8?B?MW9YYzJPTWRWZVZMV0RPLzRDSzloTWFrV1NBTEw3Zm82SDFEOCtpdFpnY2Ft?=
 =?utf-8?B?eW9oK2dLdlJDZ05tekt0QVQ4b0NMVVZVdjVCbFU4bE5KN0h3SlFMYzV2YWZh?=
 =?utf-8?B?TVpjeUlhOFBUaTJ5c3U4ZUJJOHhzTnNrT0hIRGt3RlM0R2VkaWdvK2dwTkg0?=
 =?utf-8?B?bzkxQ3Z6RG51QVVuL2RHZmNvbFM5TEpaY05ucUs1ZzdFV29nVnNxU05XUUh1?=
 =?utf-8?B?ckMzaTdKU1JKTDhNczBJcTZ0ZHhDSy9FbnRBb3lkbUpOcWVIWW9VWWhta3hR?=
 =?utf-8?B?Wk5haUhVc0txNFJxMFVxdDNaTG9hTXluc1R6OHU3NzJoTk5hSXJPZ1VmTzBL?=
 =?utf-8?B?OS93c3ozTHcya05ITG9iWTJ1Vk9JSnJ2L2FNeGxKSnk3VWhwM1ROVGx2eTdF?=
 =?utf-8?B?eTQvVFVWYzEzZkF5cjlJWmtUWlZreGhCSnZ2N3pEQ0ZFR3BvZmlVM0s3VXVw?=
 =?utf-8?B?d3VMK0haWm1tdHZNQ1FENEt6amtheklSYURqeHV6dHNMQzJzc01CenFnL1BN?=
 =?utf-8?B?a3ZuMmh4d0VmNEVSckFUNjNCUzM5QXNjd3NiRDNqeVRqQ3gzelFvcmlqZFpJ?=
 =?utf-8?B?UC9Fc3JLRGVIUll6RGdsUnZMKzdQU01FRGsrWTNBbk93RXpsSzBudTBkOXpt?=
 =?utf-8?B?WHhOMTVaTFl0WWt4VWlidTUyMFZlUjZMajNac3lRaWd0TXdVK1NDRVNIRFds?=
 =?utf-8?B?QkFsSHBhZzk5Z3p4OWt2bDMzSGV6Nm5vbEJLZUNOQkdWWElHT1pqL290SlRX?=
 =?utf-8?B?QS93VmdjNnFQeThMU25GcmN0OGltcytRckoxM3g3RzBzK1pUZ3ZuUDE1Vks0?=
 =?utf-8?B?RUZtd2xsYktBb1k1Z1IyUk9uTTVFQ0t3NlVLWjN0c0hOV1AweEJYY1FEOHRq?=
 =?utf-8?B?b0tqYXdoL0xHSlJBZDJyeTJTTmZxY2Njbm5aOGVNY3l0T3B5OTJ2Z2hwTmpZ?=
 =?utf-8?B?UExSZXBhNTVHRkxkVGxSZVdqWUZlYUFVTU50L2dZbk42dlQvY2p4bE15a0VU?=
 =?utf-8?B?dmphYjZQdW9CblR2WEM0S2J4dWZPL0krWWVBenlRVjdHZmJOU2J3S3Y2bXZ0?=
 =?utf-8?B?VXVNRFRXV2xtNC9lVzNUM25ReTQvcmRCYWRlKzFvK1U4cERyOFRGOURPK2Jh?=
 =?utf-8?B?NklIekZOQmtGNWhOUFlSRDVEWjRmdFIyNDRqeGZvWnVnL3hGZ1FOczBNSldK?=
 =?utf-8?B?R0pQREJzKzlCRk1MNHBHN1I1d0VQNk5XM0dIUEozTkZHTzM3NE5BYzZwdVVn?=
 =?utf-8?B?L3d1ZmQ3bWhncXFUN2V2Vk42Rmg1SDJtS1I1YjFHTmpHa2pWUlRpd3RlOSty?=
 =?utf-8?B?L3dIbUpPL1gyRDVpeVI1RWVLbnR4YnJiS0haNVZhd2JhNGV5WldFY2RxUEQr?=
 =?utf-8?B?ektUZW93aER5L2lPbXJxWmNncEtZSnExVXM4VDlXOUlEeEQ3OWI3S25McENq?=
 =?utf-8?B?K3FDM2hQVlhneXpxbkc5ZHIxQWtXRHlUWThjdnJ2TmhabUtEbWlNdTN2VHR3?=
 =?utf-8?B?c1ZEL1hZL3VyZXBERFowVFFYQi9EQkoxY0J0L0pUWjRjNXBUMlFBTHdORGYr?=
 =?utf-8?B?Lzd2V1drb2V0aTVqUFdXd1hhWUl4UWMzdFBlcTBYeWxLYTN1bDRQc29wd0RU?=
 =?utf-8?B?dzlXSmlJcU1rY0hVY3FXSDcrcDQ3K1FERHk0UGNKUEduS3JJUVI3TjBzUm1R?=
 =?utf-8?B?WjR4cmFFbWZvM25aRGlZT2dPeEpBOGY3ZjRzcmljQTV0YzFUUzVQMUh5RHRW?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bRMjp2Ne2WN/MlW90d0WyEuDfE4tSpSrgBLSA+CDz8j01IzPz4pNUI+v/el49UspzoyNabwWOAvIT+My1sUkNzIJinYL4FUfXmAPM6eMK8Qwk2dZZzg+rYyo+JpHFlbJ4r2yAxl9ExnVSNYX9/wXsG7/RqF7a7L7peD1BNy84Xz0/7a1IDNM4KVirKr5iXHCek8vtyJuwwrHtjQdJBd5yn3zdLu/h0P3TpaxhcKWpHxR9BmFzrZ5CAp/UnYk2aX8cWixdNhgLriLnEgQEs+Tegn8MSnNBy+6yaHmrjU9dcJ1YUfCQLQVqz+Uugsk5G6awTCV/BMojCEgrDrCUCS4Kyr5gXCassoGyv8K1YDmtPl2dd6LDTBNLjQ2sJVX1Ybbyyby/DbOxhhgxSpRGTc4gjj2/isu2Bgrh6fv9jjMmYJ8AnF2ajZkK5gUhql6uJUMnQrXZKgvjEf+AyH4Vfb4dAF5D8Q3o+t5YNAleu5uNU/DGKQsl68EPV0GdJFT/560hxh+wgiFY9V0z6Lo/TVqg5TCyqO/rXbmHxO/nrgJuWLwTyrjkms2dU2vN/AMWrd85z0MHB/MUHVMe6Pe99TqOXXGEHIZbckvMtNbNZ8ZcA8ajRR32imOYdl7HInAkHi1FSBRjBMzGdQJ5iw3QZW9rvtjI4LLm5CQiZV5qDMOiIficyHGWUhwJqanhK9RfNICStdOH8cOpYDQ3edtx0lH+uLawq5ESHsvOgkWLRcFBXnUYacNDuwm6IUfoeLDI5ppPOmqY5dH0WZ9Kajnvo+24iSp3Mx6HYrRgJeJlxcMbMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6d6728-7e26-46ce-f15d-08dbf289dfe2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 16:23:38.5605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9VW2OQ+3R3gSWLavqXwpasNjy01MijHhRwyZcnI4Hv5p+opZ49KIpSvvm2n+tGo9nJNMhPDzxUMgK/QVQZgph1qol8aFRfdIQHYhLWs/Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_14,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010112
X-Proofpoint-ORIG-GUID: y6kwv7MUEyEQiwVDWRwxCpCVGi6psQXO
X-Proofpoint-GUID: y6kwv7MUEyEQiwVDWRwxCpCVGi6psQXO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/30/2023 6:06 PM, Peter Xu wrote:
> On Thu, Nov 30, 2023 at 01:37:18PM -0800, Steve Sistare wrote:
>> If the outgoing machine was previously suspended, propagate that to the
>> incoming side via global_state, so a subsequent vm_start restores the
>> suspended state.  To maintain backward and forward compatibility, define
>> the new field in a zero'd hole in the GlobalState struct.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  migration/global_state.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/migration/global_state.c b/migration/global_state.c
>> index 4e2a9d8..de2532c 100644
>> --- a/migration/global_state.c
>> +++ b/migration/global_state.c
>> @@ -25,6 +25,7 @@ typedef struct {
>>      uint8_t runstate[100];
>>      RunState state;
>>      bool received;
>> +    bool vm_was_suspended;
>>  } GlobalState;
>>  
>>  static GlobalState global_state;
>> @@ -35,6 +36,7 @@ static void global_state_do_store(RunState state)
>>      assert(strlen(state_str) < sizeof(global_state.runstate));
>>      strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
>>                state_str, '\0');
>> +    global_state.vm_was_suspended = vm_get_suspended();
>>  }
>>  
>>  void global_state_store(void)
>> @@ -68,6 +70,12 @@ static bool global_state_needed(void *opaque)
>>          return true;
>>      }
>>  
>> +    /* If the suspended state must be remembered, it is needed */
>> +
>> +    if (vm_get_suspended()) {
>> +        return true;
>> +    }
>> +
>>      /* If state is running or paused, it is not needed */
>>  
>>      if (strcmp(runstate, "running") == 0 ||
>> @@ -109,6 +117,7 @@ static int global_state_post_load(void *opaque, int version_id)
>>          return -EINVAL;
>>      }
>>      s->state = r;
>> +    vm_set_suspended(s->vm_was_suspended || r == RUN_STATE_SUSPENDED);
> 
> IIUC current vm_was_suspended (based on my read of your patch) was not the
> same as a boolean representing "whether VM is suspended", but only a
> temporary field to remember that for a VM stop request.  To be explicit, I
> didn't see this flag set in qemu_system_suspend() in your previous patch.
> 
> If so, we can already do:
> 
>   vm_set_suspended(s->vm_was_suspended);
> 
> Irrelevant of RUN_STATE_SUSPENDED?

We need both terms of the expression.

If the vm *is* suspended (RUN_STATE_SUSPENDED), then vm_was_suspended = false.
We call global_state_store prior to vm_stop_force_state, so the incoming
side sees s->state = RUN_STATE_SUSPENDED and s->vm_was_suspended = false.
However, the runstate is RUN_STATE_INMIGRATE.  When incoming finishes by
calling vm_start, we need to restore the suspended state.  Thus in 
global_state_post_load, we must set vm_was_suspended = true.

If the vm *was* suspended, but is currently stopped (eg RUN_STATE_PAUSED),
then vm_was_suspended = true.  Migration from that state sets
vm_was_suspended = s->vm_was_suspended = true in global_state_post_load and 
ends with runstate_set(RUN_STATE_PAUSED).

I will add a comment here in the code.
 
>>      return 0;
>>  }
>> @@ -134,6 +143,7 @@ static const VMStateDescription vmstate_globalstate = {
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32(size, GlobalState),
>>          VMSTATE_BUFFER(runstate, GlobalState),
>> +        VMSTATE_BOOL(vm_was_suspended, GlobalState),
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
> 
> I think this will break migration between old/new, unfortunately.  And
> since the global state exist mostly for every VM, all VM setup should be
> affected, and over all archs.

Thanks, I keep forgetting that my binary tricks are no good here.  However,
I have one other trick up my sleeve, which is to store vm_was_running in
global_state.runstate[strlen(runstate) + 2].  It is forwards and backwards
compatible, since that byte is always 0 in older qemu.  It can be implemented
with a few lines of code change confined to global_state.c, versus many lines 
spread across files to do it the conventional way using a compat property and
a subsection.  Sound OK?  

> We used to have the version_id field right above for adding fields, but I
> _think_ that will still break backward migration fron new->old binary, so
> not wanted.  Juan can keep me honest.
> 
> The best thing is still machine compat properties, afaict, to fix.  It's
> slightly involved, but let me attach a sample diff for you (at the end,
> possibly working with your current patch kind-of squashed, but not ever
> tested), hopefully make it slightly easier.
> 
> I'm wondering how bad it is to just ignore it, it's not as bad as if we
> don't fix stop-during-suspend, in this case the worst case of forgetting
> this field over migration is: if VM stopped (and used to be suspended) then
> after migration it'll keep being stopped, however after "cont" it'll forget
> the suspended state.  

Cont changes state to running, but the VM is broken because wake was never called.

> Not that bad!  IIUC SPR should always migrate with
> suspended (rather than any fully stopped state), right?  Then shouldn't be
> affected.  If risk is low, maybe we can leave this one for later?
> 
> Thanks,

Thanks for the patch.  I am going to save this as a template for adding compatible
subsections in future work.

- Steve

> ===8<===
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index cf2c9c88e0..c3fd1f8347 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -470,6 +470,8 @@ struct MigrationState {
>      bool switchover_acked;
>      /* Is this a rdma migration */
>      bool rdma_migration;
> +    /* Whether remember global vm_was_suspended field? */
> +    bool store_vm_was_suspended;
>  };
>  
>  void migrate_set_state(int *state, int old_state, int new_state);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0c17398141..365e01c1c9 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -37,6 +37,7 @@ GlobalProperty hw_compat_8_1[] = {
>      { "ramfb", "x-migrate", "off" },
>      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
>      { "igb", "x-pcie-flr-init", "off" },
> +    { "migration", "store-vm-was-suspended", false },
>  };
>  const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>  
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 4e2a9d8ec0..ffa7bf82ca 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -25,6 +25,7 @@ typedef struct {
>      uint8_t runstate[100];
>      RunState state;
>      bool received;
> +    bool vm_was_suspended;
>  } GlobalState;
>  
>  static GlobalState global_state;
> @@ -124,6 +125,25 @@ static int global_state_pre_save(void *opaque)
>      return 0;
>  }
>  
> +static bool global_state_has_vm_was_suspended(void *opaque)
> +{
> +    return migrate_get_current()->store_vm_was_suspended;
> +}
> +
> +static const VMStateDescription vmstate_vm_was_suspended = {
> +    .name = "globalstate/vm_was_suspended",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    /* TODO: Fill these in */
> +    .pre_save = NULL,
> +    .post_load = NULL,
> +    .needed = global_state_has_vm_was_suspended,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(vm_was_suspended, GlobalState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_globalstate = {
>      .name = "globalstate",
>      .version_id = 1,
> @@ -136,6 +156,10 @@ static const VMStateDescription vmstate_globalstate = {
>          VMSTATE_BUFFER(runstate, GlobalState),
>          VMSTATE_END_OF_LIST()
>      },
> +    .subsections = (const VMStateDescription*[]) {
> +        &vmstate_vm_was_suspended,
> +        NULL
> +    },
>  };
>  
>  void register_global_state(void)
> diff --git a/migration/options.c b/migration/options.c
> index 8d8ec73ad9..5f9998d3e8 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -88,6 +88,8 @@
>  Property migration_properties[] = {
>      DEFINE_PROP_BOOL("store-global-state", MigrationState,
>                       store_global_state, true),
> +    DEFINE_PROP_BOOL("store-vm-was-suspended", MigrationState,
> +                     store_vm_was_suspended, true),
>      DEFINE_PROP_BOOL("send-configuration", MigrationState,
>                       send_configuration, true),
>      DEFINE_PROP_BOOL("send-section-footer", MigrationState,
> 

