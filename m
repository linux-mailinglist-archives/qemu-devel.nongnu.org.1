Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B4758A13
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 02:27:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLv1N-0007il-7O; Tue, 18 Jul 2023 20:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qLv1I-0007ic-Ja
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 20:26:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qLv1F-0001h8-SY
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 20:26:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ILedmU031165; Wed, 19 Jul 2023 00:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=l7T0TdQpJqe1TcmPdB/7nMtGajuCZY+QwpwK+WaeOWs=;
 b=MUuDX7TfG+lMZlXS5GqHjAmlv0tt6cuzUaVU900WvTTk0Q8gI5HIeahHqu9dsvsXVeee
 DvqKalks+NPz4Oi+G2UbIYKhKP0bXJPYeqPCqRhWOAUWvS3JFSCe6/cy5ELpjnD5hy6D
 IO69RWNYmTfNooalA3Vj3tXE753cVHAIKjiasgciMKOMjSWTgvMQg4GQVAiIgZcOb6p2
 X5rCd2pf+cQIWcfPZdHOWRgSnvo8OcAas8CknPvxOa9ZJNJ357MTcRdxilEARVn+VBiK
 ptr0kI+dAGyFcH/0lCRL1tEoQe2ZvdqWwfw/PCm117s1k6vlx2zqRcK9pmpEZFnoGdaG 1Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run786a15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 00:26:11 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36IMUk83019287; Wed, 19 Jul 2023 00:26:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw6ebwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 00:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5U3h8tZhxRIoNbfYELQTRY0AVNlpICspfptNal+/YakfUp/yylnAlRVMouRZyaN2w5x6CTHfYLarMDG+qi6nmfBX4CBmUFalvbdtnu8xPNP9utlfn/iDnRM6JgNiQJ0TG9EOZOF8WpI/m/lugjMt49O7udGjTS5gFez/9MPOgbksmRyYGiquPwEy2NvPEW/lJBQiMwiOF9uOf8W/l6/kFQbqa+uzMn5nZ+hwXXbiDMMgXvpzJS0h2oOvkqtfeFtpvwKFOkXtEMafen7MQEiG1vuTGezgCqLcwThpEwMtPTx+7vbYHH7Hctuj5S7UqwHNm/PeDx+pozvRBfCC0ilLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7T0TdQpJqe1TcmPdB/7nMtGajuCZY+QwpwK+WaeOWs=;
 b=Go44pEFKRwsP4OYWCAjmVNXNdVMa1XhvmHSiZoe7ml4PiWsOkdxsEUAHkJwBhVTyf9218CDK4iu4FdYhtYhb9ZC9vqZLLY5AhGEheSLZferiblfc72IyOq4Ls6ORo9kXq26PFzHL7sxrapwVjaKz3WGAQBeQDQF408pL7lrBAvltw8UP+pUEM8AodPPCppmAHH1BcQpsgS2umBJSn7i5hNaAdpZVnfxy8xNMFnxmd4C5kUCSKTO1tLBT8lTuRyWgZs/dm35rKajvoV9+GRuoo/fYQdiTTaAVYB25Z34AW/6mRkdqlTO+/bxufNAXCADXZZVjWsjL+rpONrPcMLx5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7T0TdQpJqe1TcmPdB/7nMtGajuCZY+QwpwK+WaeOWs=;
 b=zTtGwThVLGTjsxuc4likdgIk1dhEeyYk8TCOoYvwkbSIY6NRm0H4VBSrozbkVWG45jf4WWFZIu8XlROPnft9IqSp10nKyT/yeCbC7e5r6hfecgHBYyfu4b9rwsqQTAOthMqZWjk5mBaeYbVHLdBoc0DUH+eA9LoXMesiJRM7P/A=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by LV8PR10MB7965.namprd10.prod.outlook.com (2603:10b6:408:204::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 00:26:08 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::c89f:f0e5:c5bd:aae5]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::c89f:f0e5:c5bd:aae5%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 00:26:07 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 joao.m.martins@oracle.com, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened
 format when necessary
In-Reply-To: <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
Date: Tue, 18 Jul 2023 17:26:05 -0700
Message-ID: <87edl4d9wi.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::24) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|LV8PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: fa22a53f-f7d2-4169-eaa4-08db87eebed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8p2tZQzgJDV7kqXmFEqwNR8wmGbljOAgn3aju9yL8khDCC2YCcdCenxiETbuBFqE7iEOgdb6Y2l3pW7kv5DakM/b4rkgBWEaaZcjRX7tNjhfNgtHpsPiCqgP3XnxONOWGfYZhRJ4EOLIhfbslGrH31etdJRhkUkDGcjX9MpbBah1bLol3G5Fpnu46S9d6Ksj7qaUh4WtQhsJ350lYRBJE3cVFQtKICEj6bVKWwerdzb/p1DqkOxt7xKwPRGhbyZ0rmQbWxXXKg+hvRN3/lkjD2mZEzdb6f0GEfQue3mcYvrhXdtJwzv3Oud/oARqtQEjQZBCQf6N/rkHZak8v0wUuEHQEYIzTLnjLPbX6GJorKNgSFAWcCJxz/PjmcRn808pD2SWYfK2JAIwXaN8YTFV6UP1tbkaTAcdlouREpk92YI4yi2G8hQoK/9135uv8Z+zkyhI1jldNDIAf0f836bzSCvmUTgV7/1iv3wRwS/6WOipKadKrAEykECCYJSTtL94yxDmM1D/pE7f01uyPQ82sn0XhynOJNcotSJhCf+oyXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199021)(2616005)(478600001)(186003)(83380400001)(53546011)(6506007)(66899021)(966005)(6512007)(4326008)(8936002)(8676002)(41300700001)(6916009)(2906002)(86362001)(6486002)(316002)(66476007)(36756003)(38100700002)(5660300002)(66556008)(54906003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpDNXVTdjZYdFVNWVFtOGpNZTRvTnZ6c0ZNYzBTTkczb1h1RS9zRUYwdy91?=
 =?utf-8?B?V21QNkxzSnhNYytNVnNtWEMvZmNPRjZWeXBsNUV1M0pMTURjM3NUb2N4Z1RN?=
 =?utf-8?B?T09FOU51T3pDMWFNbExaL29EVG0rRzkyOXhBeksrdGFjUHVCeW5oQlNMU0NC?=
 =?utf-8?B?Zkc0b0N4NmtvUHBIWTJPdGFUY1FWT01TNXNITzFLOG10OEtJUTVPcGg2V0NL?=
 =?utf-8?B?b0VjaVptU2JqMEJDVC94b29POHFzQldWUXR2RGJtd3lZaFRTUjRjUy9ua0Zh?=
 =?utf-8?B?Z3Z4M01IditDdzRVTnQ2M295dTBlaW9kaXdJdmVETTExcHF0MTFjbHRIS1VE?=
 =?utf-8?B?aW4xTnhsaHE4MndxbW90aUlpTGYyMFpJK0ZITm9EMThCK3VTTjNPbzlNcEx0?=
 =?utf-8?B?elRTR21TbFRJeTdDSTZHallDd0IvT1h5cWRUT255MXpnQkN5ck1FaXdCakRq?=
 =?utf-8?B?OVc4Y2hOUTFieWFhZWhZeWh4YWkzV05KQkk4ZXZVa2I4UDgwcWg4VDE3MUl0?=
 =?utf-8?B?TVRFaENWVjI2Q2pKdzNNbHIzWHRIRDlBSXR2N1J5VHBrOFFZTUpJaGRpOXN5?=
 =?utf-8?B?clI0YnhmMnRQeG80YUpMV0h6blMwVXFZOFlQK043MlA1dGVNR291UmdmN290?=
 =?utf-8?B?L2I3NXdTeFBCTE9UeU1HRWFSNmhVZHdMSlZDSGgvLzMvRUlhVGVCRGpob21S?=
 =?utf-8?B?RGxBaVpSWkhRbkppNzBacXJlcXhOajl0alBYWTRvZ0ZJazRYTEE5VUwxenZG?=
 =?utf-8?B?dy9qZitYa2hWYndVd2liTmlyMkZvVTdtQmtKc2xuTXA5T3Mzb0xPUFZvQ2ZJ?=
 =?utf-8?B?M2VianFYMDhERHg3T2c0eitiTDA4UEdtOUZWNklhVFExeGkvRUw3QS9yWHhJ?=
 =?utf-8?B?MCtYVnFhUnp4cmgwdzhnOXJSMExUZ1BvcktvaVZGWnZTQklYUmpGTUgvTW14?=
 =?utf-8?B?eTJVaDRMWWhzdlV3cUVnV0RtK1hiSFJGRi81VDN2Y0N0dW4zUllha2hWUkZo?=
 =?utf-8?B?b09RM2NQMW9nbGlkN2lIOXU2Z0EyNDUwbjVwV2puZURaSnlObjNNYmY4bFdM?=
 =?utf-8?B?bkdPWEY5bmlzeG5rcGFVKzNxTXZMbEsyYXBPenFlTk10ZFErYXJJOWRXc0tB?=
 =?utf-8?B?N3VEOEpGUjBqOU54N0YrdjVrYVIvVWlGYnY5MWoxSVJSR2doRkpreTZBR0M0?=
 =?utf-8?B?NWgyUXJyKzZVdzN0N2ppVmxGNld3MHBJdGhYUkcwVGwrUFNlRDl2Zm04NU1R?=
 =?utf-8?B?ei9iKzE1bWRadzI5WndhVGtKRUhSdjZxRTIxSHYvbDlqenIxOExuL3hBVzYx?=
 =?utf-8?B?TVViZmpublFhVUFZYlJGOWs5Rmx1NDhwUktNOEVrWDFmeEdUKzIya0ozNURF?=
 =?utf-8?B?YmRyL0pGSUJKR3JnaXZabXFWSGw1N0l3UmR6cUE0ZGRwM2tIZk5vU0tuMm9Q?=
 =?utf-8?B?WjB4c1VHVUdiRmdBMllJMUJBQ1hqUzZVWGFhU0FSRDZBa2x3KzZtNUJPYjFx?=
 =?utf-8?B?UzFNSkc5VklncStaUnBBdVFOVDVKMlQvVXIzZlBRMzJxY0V4M3ZDaHA5Q1F3?=
 =?utf-8?B?V29DZ3k5ZFRTRGVCMG9ocHcweHdBZHdWOTJOOSthVzJlY3dMdWwzUHpPdEJD?=
 =?utf-8?B?bFZQdTZRUk5WSDJkZTV1dVZOK2t6WGtkMTBWSHJaMWJjWEdGOUJscEhKYXl4?=
 =?utf-8?B?TVJTMXRjbU5wb1hIcHRsdXRCYTdYN2JFd1dNaG1zRTU1dDZTRW1RRjkxYmp5?=
 =?utf-8?B?U25nQnZWRGJRZHhkS2tMMS9OOG9HTkYxa0FyS2wvc0wyMzF3eGEzamNMeWNR?=
 =?utf-8?B?eko5VC9xbTVlN1dERXVTNEJZTXBwVnhuaWpCMFpBQ1lXbnlycFhFZFY4M0w3?=
 =?utf-8?B?dlpNRzdFTGZjc3hvdmROR2o1RWx1WlovRjhFK0VOUEVCQzU5VTlXLzVHcGhS?=
 =?utf-8?B?bEZ1elRZTjhzdE55NGNWbHFNaHFSV1lXZ3ppbHgrRGEzTTgrZnoxTStJdE9w?=
 =?utf-8?B?VlgyTUtQSnFtbVhLRWphWi9QVHR1K1kzcmpSZ3ZYeEVXdmpFSUY0VEowR2d6?=
 =?utf-8?B?cHJtYUZ3UmprRloyb0QyWXM2ZzE0Q1d4Zk1ESlRKcUxZaHNiUlpsdk9LUkU2?=
 =?utf-8?B?eXhBVDh1L1BZQ08vRmpwa1JZTC9GV2hQbWRjYUh3cm1NVSt0a1RQVzJGdlhP?=
 =?utf-8?Q?CGN4DTxQc/SfiQ0WP2SBykQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f7k+qGePvln8c+H1qnfVZBpECmMyJdkrkU6F2Hg6nQnJXxYsumWqABzbZosa/QuKqag2n3r9U7OLx+3lE0owCC/hEKzgWmrGwmRvLrCZ6txGIKuBre0yTLOEVKu4fRYM/UybD4zi0LzkRbXAqwvvf0lNGC6ilOkTlzByIL9rcblfiFhfQmM8yPkCf7aEmUQ1hDAUwuZVo9yQzHQ4ehvYOZnMw1UNBOWH5Usq0kVYRr4Cw8cjPvNdS+1WPQkUfND/6pW9Jf5diyFvh/e0KU8cqUJAxfFAAo9RxdSRxbSVtSV+VRxZG7Qc4LyG/eVc9tffHvstvC6SFTBGEjRCs6adgkbusjQoT+YinoYliv+JyaPd9XbFq0FfNMWR/VFqBTn/pHdfBZIYk1mFhPP42Hmp9VeXcQ1uklK2yOhNottLC8wExKR2N6OdHK026IFRM9shlU8Z6ZbC3q4GCNt+hg+4aIK6hyRMCan9LTjwye17fx1xQjPzrwu95DGarCgIZY7FmNygvA8qm4kFMUtUJarq3GBUdggxAfuOZqJEGrinJ+dA6r7ENzHTAirVLx9x7Ov4izj0k9BWewGHGvKuXsI8bPiizx30LUuNcLCfRULfqFkCy4CmWLj05Z1/TNO5CR/GEnkHRNWhKjrTdv557MHWKNEezswhA+cxa96yjzUBUvKYQQ948m73YEtdTsJYmpiKSGFdnI+aiYTQOdW8oB9T+5t8etRhTz9LOwZSBc0eRKuhWnDTFpjIUnkI8VrVO4o+yiCz8rtdxNnPjaVJ7BQFnTl1UWD3cGGBDY+iT6BSCoO9gC7JJ2aSQyp8L2wTnQGTysP9jX0SdrRfc9LsXeYuQzGozdxSK9V53+2OHse4qoq0ZSbeDW3V0f2P5xrcFaJy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa22a53f-f7d2-4169-eaa4-08db87eebed9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 00:26:07.8891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOdDinq5I1mSqZJfKLbLRMNFYYCAcMheYBfZajfKQ73zepH6tWgl8X5dl2fscLNVX3Rq/RUdJzjNQQtESF4QYxqvtZBlBJ3xww5vqBKdv7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190002
X-Proofpoint-ORIG-GUID: lcvIURQST6gXj1pMpj2a48iEB7xqBUr5
X-Proofpoint-GUID: lcvIURQST6gXj1pMpj2a48iEB7xqBUr5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0b-00069f02.pphosted.com
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
> Hi
>
> On Mon, Jul 17, 2023 at 8:45=E2=80=AFPM Stephen Brennan <
> stephen.s.brennan@oracle.com> wrote:
>
>> The flattened format is used by makedumpfile only when it is outputting
>> a vmcore to a file which is not seekable. The flattened format functions
>> essentially as a set of instructions of the form "seek to the given
>> offset, then write the given bytes out".
>>
>> The flattened format can be reconstructed using makedumpfile -R, or
>> makedumpfile-R.pl, but it is a slow process beacuse it requires copying
>> the entire vmcore. The flattened format can also be directly read by
>> crash, but still, it requires a lengthy reassembly phase.
>>
>> To sum up, the flattened format is not an ideal one: it should only be
>> used on files which are actually not seekable. This is the exact
>> strategy which makedumpfile uses, as seen in the implementation of
>> "write_buffer()" in makedumpfile [1].
>>
>> So, update the "dump-guest-memory" monitor command implementation so
>> that it will directly do the seeks and writes, in the same strategy as
>> makedumpfile. However, if the file is not seekable, then we can fall
>> back to the flattened format.
>>
>> [1]:
>> https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a2746dbf=
9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> I am a bit reluctant to change the dump format by default. But since the
> flatten format is more "complicated" than the "normal" format, perhaps we
> can assume all users will handle it.
>
> The change is probably late for 8.1 though..

Thank you for your review and testing!

I totally understand the concern about making the change by default. I
do believe that nobody should notice too much because the normal format
should be easier to work with, and more broadly compatible. I don't know
of any tool which deals with the flattened format that can't handle the
normal format, except for "makedumpfile -R" itself.

If it's a blocker, I can go ahead and add a new flag to the command to
enable the behavior. However there are a few good justifications not to
add a new flag. I think it's going to be difficult to explain the
difference between the two formats in documentation, as the
implementation of the formats is a bit "into the weeds". The libvirt API
also specifies each format separately (kdump-zlib, kdump-lzo,
kdump-snappy) and so adding several new options there would be
unfortunate for end-users as well.

At the end of the day, it's your judgment call, and I'll implement it
how you prefer.

Thanks,
Stephen

>>  dump/dump.c           | 30 +++++++++++++++++++++++++-----
>>  include/sysemu/dump.h |  1 +
>>  2 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/dump/dump.c b/dump/dump.c
>> index 2708ddc135..384d275e39 100644
>> --- a/dump/dump.c
>> +++ b/dump/dump.c
>> @@ -813,6 +813,13 @@ static int write_start_flat_header(DumpState *s)
>>  {
>>      MakedumpfileHeader *mh;
>>      int ret =3D 0;
>> +    loff_t offset =3D lseek(s->fd, 0, SEEK_CUR);
>> +
>> +    /* If the file is seekable, don't output flattened header */
>> +    if (offset =3D=3D 0) {
>> +        s->seekable =3D true;
>> +        return 0;
>> +    }
>>
>>      QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
>>      mh =3D g_malloc0(MAX_SIZE_MDF_HEADER);
>> @@ -837,6 +844,10 @@ static int write_end_flat_header(DumpState *s)
>>  {
>>      MakedumpfileDataHeader mdh;
>>
>> +    if (s->seekable) {
>> +        return 0;
>> +    }
>> +
>>      mdh.offset =3D END_FLAG_FLAT_HEADER;
>>      mdh.buf_size =3D END_FLAG_FLAT_HEADER;
>>
>> @@ -853,13 +864,21 @@ static int write_buffer(DumpState *s, off_t offset=
,
>> const void *buf, size_t size
>>  {
>>      size_t written_size;
>>      MakedumpfileDataHeader mdh;
>> +    loff_t seek_loc;
>>
>> -    mdh.offset =3D cpu_to_be64(offset);
>> -    mdh.buf_size =3D cpu_to_be64(size);
>> +    if (s->seekable) {
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
>> @@ -1786,6 +1805,7 @@ static void dump_init(DumpState *s, int fd, bool
>> has_format,
>>      s->has_format =3D has_format;
>>      s->format =3D format;
>>      s->written_size =3D 0;
>> +    s->seekable =3D false;
>>
>>      /* kdump-compressed is conflict with paging and filter */
>>      if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
>> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
>> index e27af8fb34..ab703c3a5e 100644
>> --- a/include/sysemu/dump.h
>> +++ b/include/sysemu/dump.h
>> @@ -157,6 +157,7 @@ typedef struct DumpState {
>>      MemoryMappingList list;
>>      bool resume;
>>      bool detached;
>> +    bool seekable;
>>      hwaddr memory_offset;
>>      int fd;
>>
>> --
>> 2.39.2
>>
>>
>>
>
> --=20
> Marc-Andr=C3=A9 Lureau

