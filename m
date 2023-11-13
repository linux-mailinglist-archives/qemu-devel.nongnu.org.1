Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D74667EA3AE
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:22:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cUl-0004C2-D1; Mon, 13 Nov 2023 14:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2cUf-000497-RZ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:21:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2cUc-0003If-To
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:21:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHiOBS022247; Mon, 13 Nov 2023 19:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=20InjxsJ1IfFcjGES1Cc6++KAa0LBvQf2qvU7+Qh2WU=;
 b=vQOmSEYW1SfNEGyV3+rOh9s8+O4RJixngrqiuk1aJXjh3KTHS8EOO+YCg1TpibKbj5b6
 X6sBR23vIZFvmleBft8H0eYSY3eobaXVkG1Vf1JlErhVp6FnvUqrvHwfwFDl41tGqHPv
 1GsVUKp/o7DqQwVz1F5kersmyiky7USSvXzWynu5D7xNqDX+H4A+ujiot5FHMx+kLUUG
 nptSDrTLt++h1bfloFh9eL4/J8+xJj6wJ/Pnn7s+lSfUtXJ9aH+N7/e3tkYe+fm2ceFs
 nrLXyuxy7Ljzsu32kAPKER7XiqmrtKu1MzyZrWcrIv/V7wLtKn+DTTwAMUOen/+qSBf4 vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stkjen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 19:21:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADIaipK004499; Mon, 13 Nov 2023 19:21:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k25ata-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 19:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFvnwPMNyUT4fsinoJlo1vrMFEbrBEUHp8VYJ1am+nTIxHUtYHnQfu1li7/0oQ9fODmkuSVmdYOzqlBnhzaboTkxIPUKTqVqY4Jrc7oEORqqIlIJj9pX8HJnKUz2pzq2nkrdj98jbvff6VrpyP8yz6H6aQCl562Da6nwTvPxku9rG4zy1kg1epaTrau1webTnMPfRdU2Z+5H8L1EX+RMJuVei2MXts9Q8rIvxx8cZWl/hyI9q1I3b4eEsKk4m5Vc37rijMUHZOrHSDMwFc8AZfZNfnfYhrwMs5PCJ6zBC65MaBSKY0nuxffCSg0l37VjArD7CkhgmCofOrX2Q1PbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20InjxsJ1IfFcjGES1Cc6++KAa0LBvQf2qvU7+Qh2WU=;
 b=mgPlpdU3jp2olAIXx3IAj6FzAipuvEk85np0sJym28YvaW8xksDL/FV9bgrG9xd7n7ttOWvyCjnVLNRVqxoPqe7FLJyLcS+3NNOp37Ou/Ka0pmJmwG+qf0XosgTx1FfsWePez4OQRW1x7Gn0CCetKUpY2w99QmOdJ/RIAh6ABAhucv2HrHGyoKyx6+tfk462sVRxJX1BJyUpQNAxe8d4kZfCODBEMT0F2gN/xFnWTThS1BzeP76ownk8vDlEM9g5vq1OhgxE8vYGUwpnFLZY3eLQwmkp5IciBL25UKlrXz8Y3DrrkjUFvN5me0DSylTE0qaHyFaJ4qtbmYrmrz7c+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20InjxsJ1IfFcjGES1Cc6++KAa0LBvQf2qvU7+Qh2WU=;
 b=xMR97f+0ym/zhZ3INsvjsRq+6scWiBpOM5zzWqA/DE1i0OntS7qKtE34J4opLpcoR5Wq1mRjw/51t7fNXwa0o81g09WbXf0qiCYbhxFtSSnP1V/bzcZLG2MCG+AoTCrQU4BXkyAgmG59jbcaPNoXVV+PK6qAyUN2C0rg8Mbgsjo=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 19:21:00 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 19:21:00 +0000
Message-ID: <91278b60-2cbf-48fe-b35b-6d03ccc2d85c@oracle.com>
Date: Mon, 13 Nov 2023 14:20:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 07/11] tests/qtest: migration events
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-8-git-send-email-steven.sistare@oracle.com>
 <ZO91uYBncX3VE0D6@x1n> <f42c8267-5885-442d-a2dd-a57a77d5efe1@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f42c8267-5885-442d-a2dd-a57a77d5efe1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7900abee-13cc-4383-3915-08dbe47dab89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUtsoeoUhJjPjILZMRUoHqQ2k08F2URg+aBdG2SSe0pxCFUkusxH94f+TYO1w7h+R5HH3njdgj/oKRnJfKE+y6JiGg2sJYuBmQtmfGTwq8ZgYGmtPqcrE0LIdQeuUGOiBhHwd2bkstEpu2Ztr1M7phl8/hdgx09ZJSjdUIMy98+9//qGu1k+i91fNQ7LNaAtFbsr5gi0pG/ohrOJoUwgFVKGSwfTWsvKRpIGDGUNqFXEwSViaM4IMUEshXcOg7RQ1kai0e3Pg0+Hq6yL8YeLTfzE0VN+wg/kN5FghE2XqBdo9dF4gfoTmodU1ruS7w543/Tng4HfeECf4NsWePRrTxTcZORZCzJthglEsi7rP/HnTBulzJqO9seN0Gk5dDpIk9IjOnCqUyxAC4jEeQ1/37TpMzN4jWUOrEUZiyhfuoWIpkbwagOnckHp7G/pSZBT2biUvFf8gLs9S5oDq8XyfgZSCJCcdeZ9FqQqsVUC95JH4y37rOw0janNBPS6C/cBQJIHChw+ZzhFJpq1zdSaYS8ZkN3nIxE02ffMHYO8Dj6+irlqa07NFisD4C+ivOQhhxo8zhDRmmV+u1sb0PF4bypDc//XOV4sb6zqZjrofZtCJZgdCPqV14HTzUz9ZyF4pziY6WLDte0uBD5zWrwF+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(41300700001)(38100700002)(66946007)(31696002)(86362001)(66476007)(66556008)(478600001)(2616005)(6512007)(26005)(6666004)(6506007)(36916002)(53546011)(83380400001)(6486002)(4326008)(8676002)(8936002)(44832011)(5660300002)(316002)(36756003)(54906003)(6916009)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVB0QXJPTHRhYW54c0V3SGYxbzJkNWdnak82OTF5cVp0MDNiQ3JKRWx6UXNL?=
 =?utf-8?B?a2FOSWduVlVtby9ycmZyOUJUYWRPQzJydmY4Y3Q1SmZ4eU04cjFWUkIyczU0?=
 =?utf-8?B?cVhUUHZOOStmaCt0Vk1ILy9zU21mU0FEMkcxT2pSZ2tIOWdoa1VLUGlla1Na?=
 =?utf-8?B?T203TGxPa09Yd0l0Z2syazM4Uko3K28yYzgxL2FSeUhRd3NZRDY0VkZKTUw3?=
 =?utf-8?B?a3RTR1dnWm5xK0FwVndENWwzU0hCek9Ibk50MlRINk1tc0ZEcTFEN1ZrT0Zk?=
 =?utf-8?B?aFc3c1dhSithcyswSStmTnExUUc5UW16YTl6TTdRREcveTUvTUxkSEo3NHQr?=
 =?utf-8?B?UllyT1N1WUwycmF5QWxrSFBESC9DcGtDeFlaVVhvRUUxYTlKT3BrV1dlTXIx?=
 =?utf-8?B?RmI3SFZ4a2hOVFMrYU10ZU9wekVjYTYxVXlGZHhuSXlOaUZOdE92Vy96VjlY?=
 =?utf-8?B?TER2WkZocHdIcytjOVZ5M1NpOE9XZnBmbnJQaHQzQmgvcTVOSysvU1BzdHUw?=
 =?utf-8?B?RXJBOTc5cVNnVGtIaUh2TFJQcThUY3lFZzFmRU9DSGI1NXI3QjNkcGFmWVRh?=
 =?utf-8?B?eXoyQUZKQTNQMkJ5UStRblRNMTAvVW0rRUp1dGtmamZwMkxKS0VhZ25KbEM3?=
 =?utf-8?B?TUx6a0xmTGJxSHVGRk80VG9iOG9iU25xRjB3TG1rWWJnTUNjTTVYT0hLQTlk?=
 =?utf-8?B?WE1QdG1IK09XSnhwU0VWaTRjSXBCS0h2b1dzaFZMUDVMTnVlaVhkYWh2NFU1?=
 =?utf-8?B?TVpWK1BndHhOMGdlbGxBekFiQjZ4TjhoUEVNMXUreDJybm9OSFpTRVQydUh1?=
 =?utf-8?B?K1BEalVFQW1vR2YvY3l0OElUTllpZzFNNGhRU2xUZVQ5N3dkQzZORXIrRldF?=
 =?utf-8?B?UlFTM0hYRmVvTWQwa2pHNlVHQjNXak5DN0N2MC8veTV2R0xiSFE0S3ZUZDkr?=
 =?utf-8?B?eWVVRFFoem8vSVRHRktpQjM2MmZ4bUxxY2lpYWxHdkpVL25oWmtwa2VqUlhz?=
 =?utf-8?B?MDBlYVpERi94d05DOTNzUjEwZUJaUTVOcjRSMHVYTnFteENXenU3Zldjc1Bu?=
 =?utf-8?B?ekh6SGxmaGNXVVkxbW9nNnh3blczbE9WSEdwK3piTjBLSlhtZWpEVEFoOS9o?=
 =?utf-8?B?VTJySk0yUGRQYVR6d2R3N2NSVE5PT2ZlQnVWamU5cGY2dmZMMzhtSktKUHRH?=
 =?utf-8?B?dldMOFM2eXlTZHNXenpIM2RFNFJibE96MEt6a05mLzJ6RTFDSXhBclFQZjAv?=
 =?utf-8?B?UFdhdUNCWis2T25wd1RIQkpyQTZ3cHBUQ0p5UkVVNG9xYUNBZEdLcmM2VjIz?=
 =?utf-8?B?UmV1TmhDZ1FEaldqU25na3dnTXFWanBRUzVqeWhSKzhzeVVwU251QVFxTFhq?=
 =?utf-8?B?L3gvQjlHSnJSS2ZyeDFTbXNGYnZLQzdBZ1VxZUJxYUJlQ2hwVEdZWVIvbmtS?=
 =?utf-8?B?NDVMOVV4NjhuWUFRMW5PWHRVN3JjWElqREJmNXF2QTA0bCt4dmZXRVJ2UFIy?=
 =?utf-8?B?NE0xTGUxQmhaNDExVkMzbEdhT1A5KzF6T1Q4QkhOemNCbXYwK2RZdUVMT3Q5?=
 =?utf-8?B?Z1I2QTNram9xeWx2RmdLeHRuMzZFWnRaRDZFTFV5QUcxblliUE4rTEpFUjhT?=
 =?utf-8?B?a2dPL21DVXM3NGZLWHN4Y1JqajlLQzZwek9EMmNHNHhNV0ZyVlBMQjdwdllI?=
 =?utf-8?B?a2hRbXBlbUFtVkRWUUdHUVV6ak0vYmZsU2dKbHZRL3dRY2FWUTM4VFk0aGQ0?=
 =?utf-8?B?bXlNUjBuWWpzSEMxYUs4bVJoSFpXN2N4VVlaemtUVUhKVGV1cm9yclVJT0Fl?=
 =?utf-8?B?U1VEeS9Gd3pTdTR5bEdhV2JxbU1qZ2NaVVpmSDVMVFJ4aUN4QmVMMEhFOGZH?=
 =?utf-8?B?bE5UREx1V0R6RlpFUG05aEZKcUowOGZkOXRPYkMzSFVRUnpoejdmVWxlS0xi?=
 =?utf-8?B?ZEduY3ZwcGZzd0Rac3cyQVJJVTdES0NUMmVicDUrTEJIcXp5b3licEVJMEpt?=
 =?utf-8?B?T2FvK21VcHA3Z0ZTL05GWnBVY3BoTHREZzA1akppTThhb0xYSndrbCt4Sk9B?=
 =?utf-8?B?RW0vY2lsOVZabXV1TmxKZnYwSjlIY3FJT2V5WmxlV3ViYW90VGhzcm9JaStN?=
 =?utf-8?B?TWFZanpMeHVnci9hL0RVUWo0SkpiYlpFN1RtZTlKbi8ydWVxaTh1MUpFQlpU?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /tliQuexdJvwK6TEz4Zt0IWK3h4tyAuu5+EPAXR7NCbs6Yg0O6f/lRlJhFhlgiFo+2FGzr/zOSUOfINMi5z3QvtI1vkf1pLycV8b6VXH8zDvLMBon+bsCZsEsnG/EMp0XfcAtMy/nZb/VLosWyxNoHNwvjPHItm2UKhwdpk0vXwR2mfYkJOBXErHzBrGokEeSrsbTq0OgK3/5SwxbxL81bRHoj+ut+PtEa6GhVhrouWjekBAuiFdrSDeKjHgbTzocUCf/QThhdxi4uRVLuNS/iI7gY7/0eXaM+GdWA4YJpZJYYJ4V4c0MMoqavzpQwgCuvyc+e7/iLwQrh0C29w0K4zEg1VIR2mw9hxpB3GN7y2SwYzfIxRc+HC5SeG8cZ6+kOfWDgRlbRzyuvqeyxyh5hDB6uBYkXh20V4rcT/Bi2D09fTmC+vjC5kyeiGzqPuZbchQbeIyPZnbkyUTYYXEQGKDvNtd25bnkeEJUazGWx4xYpSi7fB6zR8gDHdammGP4AbZ6E9dCO4p5A7K4y3hHCBYYWbRI6ssg44k6tjAp2KkZpc7h7Mu30jXjiaZToIi8CWTiI/5ghl4ZgKDaezeJKHq0Bs2+U7rQKoMael6vysnzZMrj/+lvClK0uYtiNmdtAHNUXfYLhGaEmVO/CR44XSZ0nJO/OtjMBpoo2qfRCFIZT0x+rJUgBjRHEe8NtipvHReWTfjKdBmkuSsxI0axNSeFI/tkzo/GYeIF/xlBaLD3l3UYuzYDPTSLQpVDNd+l0VI0cad3XTLcMPrPX4GkQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900abee-13cc-4383-3915-08dbe47dab89
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 19:21:00.4439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSUMK2CWRs600DYgWyj+RYs3lDYVrl9dg71nYbw3UYqpoDZoj0zIkbDfWhLsKLi4mq0zkWh2AA1mhO/im+9F5nwTN3lkDDluL39HATAeeww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130154
X-Proofpoint-GUID: avOb_aO3q19veMOobC3raShlrgC9GfZm
X-Proofpoint-ORIG-GUID: avOb_aO3q19veMOobC3raShlrgC9GfZm
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

On 11/13/2023 1:33 PM, Steven Sistare wrote:
> On 8/30/2023 1:00 PM, Peter Xu wrote:
>> On Tue, Aug 29, 2023 at 11:18:02AM -0700, Steve Sistare wrote:
[...]
>>> +/*
>>> + * Wait for two changes in the migration pass count, but bail if we stop.
>>> + */
>>>  static void wait_for_migration_pass(QTestState *who)
>>>  {
>>> -    uint64_t initial_pass = get_migration_pass(who);
>>> -    uint64_t pass;
>>> +    uint64_t pass, prev_pass = 0, changes = 0;
>>>  
>>> -    /* Wait for the 1st sync */
>>> -    while (!got_src_stop && !initial_pass) {
>>> -        usleep(1000);
>>> -        initial_pass = get_migration_pass(who);
>>> -    }
>>> -
>>> -    do {
>>> +    while (changes < 2 && !src_state.stop_seen) {
>>>          usleep(1000);
>>>          pass = get_migration_pass(who);
>>> -    } while (pass == initial_pass && !got_src_stop);
>>> +        changes += (pass != prev_pass);
>>> +        prev_pass = pass;
>>> +    }
>>
>> Here won't it start to wait for 2 iterations every time instead of 1?
>>
>> Note that previously we only wait for 1 iteration as long as not the
>> initial pass.  
> 
> I don't think so.  Both the old and new code require at least a transition from
> pass 0 to 1, and pass 1 to 2, to return.  With the old:
>   when initial_pass becomes non-zero, done with first loop
>   when pass changes again, done with 2nd loop

OK, you refer to count of iterations that call usleep(1000), not pass count.
Yes, the new code may call usleep(1000) twice instead of once.
args->iterations at the caller is at most 2, so this is a tiny difference.
However, I could improve it like so:

static void wait_for_migration_pass(QTestState *who)
{
    uint64_t pass = get_migration_pass(who);
    uint64_t changes = (pass > 0);
    uint64_t prev_pass;

    while (changes < 2 && !src_state.stop_seen && !src_state.suspend_seen) {
        usleep(1000);
        prev_pass = pass;
        pass = get_migration_pass(who);
        changes += (pass != prev_pass);
    }
}

- Steve

>> And I think the change will double the counts for below..
>>
>>             while (args->iterations > 1) {
>>                 wait_for_migration_pass(from);
>>                 args->iterations--;
>>             }

