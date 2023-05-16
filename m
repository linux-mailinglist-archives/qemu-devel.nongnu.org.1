Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB357048C8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:15:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqlO-0005w3-Lt; Tue, 16 May 2023 05:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pyqlL-0005vC-Q8; Tue, 16 May 2023 05:14:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pyqlJ-0000Yp-Am; Tue, 16 May 2023 05:14:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G6ToWc006916; Tue, 16 May 2023 09:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=cH/bXGyiPapn4m3fPR9iGc4ieel5rjQ2s/v7CTXz3bs=;
 b=HdoxejBeK98/N3lPJjTbvJrs0wSerk79VIU5cPnVhqrNu7MKk7ngiQIQqCqlkMJwCmHV
 2Zi+FO8BTAtBGtRZKXC/3lTlwZgXxuQAVQg8Yxa4d2du6+1Dmy7CePfEwllzEdPgTdtr
 HmtuvjZxrLhoGfStdpxXNp1WLRpE6RokA3j/bjQ8Fe7LrZ4BkQK3z7h3YXi1SsFPd7Lf
 /uY1wc0vkXA8P+Jy/4vMYxpDKD8fWugjW7Nl3YDNICug2USHcYf44jrAfMDsHTp1dPjx
 srPeiWoedwSHZdIDw1fb0xFRlFH24ONzUa98z/YQbgHzbcE9ftXYHDoBuxOE/uOCTh7I qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj25u2env-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:14:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34G8AUPA038900; Tue, 16 May 2023 09:14:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj109tc8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbwncoORwNwn3MfR4SpVTExOl1SZfybRjLmFE40GjtvGsqsEZgfEy4jzZGOIAT3O05urPMbgCwJ6Tnyw3m11LIiAsqVXk01Sqm9tkAGvuLuf7gIABhSGuscbX7gXizCCu7VueUNrsbfFMnlt4iir3YFKz1WGBjuCqNnYsECHNwIdp/7anZeGSYounYljKsN6Uvbx8pCD65VtxAsAj4b7Kf6IYtAlcy3ZuvK/8octNgmrWly4mcD3j2/cd1wdCOaLmJfkYM2s+s8Bf136ygVC5n2Kc9GRdU2L+wOOXbHyJKgvqTU2wQJ0nVHb7Pq5fnSUeHMqf76S+A6Ewj2lLwhZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH/bXGyiPapn4m3fPR9iGc4ieel5rjQ2s/v7CTXz3bs=;
 b=k1ucrSX75EEHAGpStuAAqaBS+3VkcDyD0fBXAOeDAAjhCWwJfvxiKcokMUxC5+LBk9flBX7Sf7K4NQduCmykkv22iBykfNuNxeYacS7HAHbIlaYAtF99KdhheKYCUMHxDZ/oxqjI5wLU8EGINKUd+teicXovAihByaslqNzqWKX3c/BH6S79pyVhavSePlXksKRipTl3sGShsDPvpgERsaYCdTIrwWWQ9h006P7/vuJP7yyG7jPEjwtIQrTv25EEu8JqBlsjJOD5d+UgVsq0EVjYBtfqtZXTOUdIEdlV/FaScwWkgR0LZHKfGaNqMtpSrQBYkW1dZF/ZpzZJn0oCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH/bXGyiPapn4m3fPR9iGc4ieel5rjQ2s/v7CTXz3bs=;
 b=buxtMpkfug5qhEvsaLqJF3HxsalBMLP/KlEhjtr0A7IRYqmXzwqvmgrnYoGTx47TC/HyUrot34yz6dvzmeSeDUgbdczxNE06BsbEtHntXsmIRx/06TvHT+0EM+oZRHmByDfhb3/bcjmt49tL2llXp3IqWhxOJyhUo8/Qt/5njwY=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Tue, 16 May
 2023 09:14:00 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::738c:b283:c54:57c0]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::738c:b283:c54:57c0%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 09:14:00 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John Snow
 <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Eric Blake
 <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 01/16] migration: Don't use INT64_MAX for unlimited rate
In-Reply-To: <20230515195709.63843-2-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-2-quintela@redhat.com>
Date: Tue, 16 May 2023 10:13:53 +0100
Message-ID: <m2fs7w4p0u.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0443.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::23) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 7274676a-dba4-4a4e-7838-08db55ede2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX4W1LF0+5iDfXeaYUHXAF2Ntx62fTaBONIk50mjuNSHWf8wkVq8S0DqxWaLXpxzp54Q7ZJ8UxauaJsVIQcRErrrss2X88bgMQcFjddureCm5rQ1Y7c/yD4Oxd3VnkbShwhpwUOKLhaERidqSgcu0ZOJxSmaN4KVG2m9EOv4mDGf6rocDg6eJv+VyrNyP6Yk55MnpOTnluxXNmbEHr3r91YujNA9rgw3u83ieMdBYk4iMAXd3H+KP1LHUWEfbbRgr4weOtJhpJ6BtTLU0I1nJ+JO/oLLp9Bw+AU2cqeX3tG+n7ED7gM+eXbn4mcRw93WIPnWVj28PjF/fnpaKD5/NhnZio3pg9KXzkokGbYF5WPR/SoJa4RSc46e0pR8VmCwocrtwwt+TVXr/goEsvoFql9D+CEzq6B+aF8y64SYz4isutTVk51B6LH3+YwzWpZhWqkB+ja5P7CPC1Xbmp0Or4XD6tLrhdMRPf+RaJKOMV2lWU0fdIYh2YFcRgnyEmzd/LSaAR2OPEpmFqgZI5JWIL3HpaFLKi5qJEV+pWYK5kVrexx2LWXh5ZYd53b8v30u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(4326008)(36756003)(2906002)(7416002)(44832011)(8676002)(8936002)(5660300002)(86362001)(41300700001)(66476007)(66556008)(316002)(66946007)(54906003)(478600001)(6666004)(6486002)(186003)(26005)(6512007)(6506007)(83380400001)(2616005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I1E6MlSpqdgDK0V5TRoqurYZ9Sx8BO4eJQnVFve6SOxHr1MuH6I0EPbAvprZ?=
 =?us-ascii?Q?KOvC9mWc62EXI04kkbRtXeMqDEnAFBt/x+/DAicUXX1CQppYZZdJtdgp4cmN?=
 =?us-ascii?Q?VVEX8J1CyrnA3BJbD08lFIHHP3WahbEdVkgK76eoraREs/sGujwLDooe34SU?=
 =?us-ascii?Q?wCLHp9IuOSO7XEHCZZb8nuhUL4TBoj0XYUkQNoX1Mg38h6jAd3IBekLixe5S?=
 =?us-ascii?Q?NEfsjg6LeU++oKtyJ+eDOWz6jHPKDc7dbCFXsIygpjNB4OgbJtnrs2zC6tog?=
 =?us-ascii?Q?19B1fR43Hi9STJG+Dk9FHim4h1OGttZxuNTPQzabHttn5yXAQO4JNBwz2jmQ?=
 =?us-ascii?Q?/leTWLeG6DVBYItdhlvQ8NGwuu45hG3SOtfaFHKVK5C7z7kn4K1mQIfsIX+O?=
 =?us-ascii?Q?dhbU/+HtArv8uWQR7Q1Vlje31so2sl7SqEnDvwrC0rfFYNUSIgdrarifpNhI?=
 =?us-ascii?Q?l4At5AsImnVAe5TNZf1yILHnOxebxbILhJpfzM2xlQZ/EwFhx1em3u9sCOZg?=
 =?us-ascii?Q?oA+wmVGqZqlnchCYOJa1uxuCbZ0GbJZmlH20lNz4weLm+2GBIu46IaqbvK08?=
 =?us-ascii?Q?Bb11eirv+KeG3nuhRoYrz0y66Prm/qnTJFGUqGbOJT6Y8jEj7ZnCQMsGfomR?=
 =?us-ascii?Q?R7LzW9ol2WR5khUJXoK+ay0QO+RnM4huzWq6xXmaUfRdKAIHmnyF5b8ixpcQ?=
 =?us-ascii?Q?VToTFbjCJuMBMxgMP0yrtJmty9dZw6PWHIJ9WJ1td5GQbOLAVuXxquowGHwG?=
 =?us-ascii?Q?8Gys88ez6BnUX850IQyHezhLfwGDjQ7kmGZ/0WxbdTdjvfyfYd1rGUo9dEZ7?=
 =?us-ascii?Q?XWFHuwaG+PQ0zQtd9Cqh9Ty3TvsxW9fSE2fp3NugOq8xHp23QI5EE0yw/ZhB?=
 =?us-ascii?Q?eN3mRl9CbFqE9X4s0njMBoJMJ3qIb457rIIlvnfStqZl/jSpjeyrJnjqVoAg?=
 =?us-ascii?Q?eEn9FkM0uL5Jh7QUYwY7b7Ld3pgSu4Y3qq9uP7L589WroHjDedAzlwqrWcsa?=
 =?us-ascii?Q?xsGz4qmRHfWlRLjAiR4hnFyL5I9cr7SVldDF13fkmqWmRCrVQlhdkX3+9BEr?=
 =?us-ascii?Q?jHBMQI7FUUJbS5R8TFh3yYbaRQpwsuDTv3E5cKaoQchOXHiylEO8vgWnyVJ3?=
 =?us-ascii?Q?EWnZrqmbIIv1Yrt8lEGk9FTFCTqxEp+yPMTxyEz1jjrluW4qFFE48+mbawoO?=
 =?us-ascii?Q?jkAwvrt9ismhhf5CUAgSR8mOIZpwyEpilhMQLx8ozeKYYSVDTiFR5O7tpta7?=
 =?us-ascii?Q?ikaw+/uLNCnmtR/IviDOn4gB5FZPsAPbMnbxooKCyoklhKHyzqyEE84cchfg?=
 =?us-ascii?Q?I1ayrbYjeUxGCSnS2PcPvR69w+c6fr0Tb6j6C5ZdCK6wjgbtVBrvmzfg/JPK?=
 =?us-ascii?Q?0M0oBFSAZq3YM1VxEbUvigfxdP+xMky7tXPjc9Gl+CFILi9dLXmVW3bHTfKG?=
 =?us-ascii?Q?xIgABfrIVwA0lZhzmpkaVNtK04Qk7kuRVdgb2r2e9H95cyms7/j2MsOKcttX?=
 =?us-ascii?Q?CSoltoC9FwTgT9/5AzefcZ9Vlu7B9WHfYMrsx9bqZOeleK99wsQrX+rWNLsM?=
 =?us-ascii?Q?B078nKxv5QdZ/ziY1TkJWgH0I3msN4Tzb4UfP8M6S0ikUz4vdOUEokFuI+0q?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PxHseqBchtRmpUohbFyWTl7bM9xudxUoeiHoNbqS5NwPrMleaZCgXV+pJleV?=
 =?us-ascii?Q?HdNM1pIidHBkz0tuBFb6ZA1YZWz4BBHjDgMY+612BMl+RadFt81+9e6m9+tF?=
 =?us-ascii?Q?Ptp1g+gXTINmNkdMBPraOED9HI/eA9hsixi/F4kDBdA9JOV2BEhTIxrTtTH/?=
 =?us-ascii?Q?V45DM5MhH8/PuEsn/y58jZbHJh+PUywW58Av1l/xkPWhwKvyRaAJ1WYC4/gN?=
 =?us-ascii?Q?UTL3BWl/J59wwMYVyemrTbWQVAC04y2NsriPTzXd/nzA2I+wwzbHAF5FxeEh?=
 =?us-ascii?Q?giUhFl/y/HZBLarzhnU8XkHUSlPJrP8f97Ypegi6nHALugCZGJCpI/2FDSBA?=
 =?us-ascii?Q?DFx1gesVxhf4JdKSKHy6aGaZ5/SvQZhDBUJRPzLBouiYsss4VgsB/MX96fJu?=
 =?us-ascii?Q?m4I02eztk9ZF6/+7WzruOe7YjNZMTZaoVYvzWcsT24C9O4HPzD/t7IUCC1af?=
 =?us-ascii?Q?CKAYBQ/z2DEFKe2gfFlpRBubvoIxn9+YNRs5bv8XSyKCJ0o0vI/goObx1AOZ?=
 =?us-ascii?Q?g2zfUA3bQXsXYJ8B+ICPzY2eAJg4JDZiZYfk+yjqEj5efs8UOVUcVCUh/c7q?=
 =?us-ascii?Q?R7Hw4vJDn5KHehRZnZuFf5xvo6nHXMx1m2ejxTAeaTPgBBfApwUoowF+SuuN?=
 =?us-ascii?Q?fklp7aVFPO8HoUwK0ZmTXveRD9ON0uFx39ceNWkwBxIsAUhqeiY0EAO4Mip5?=
 =?us-ascii?Q?De2dfK7CJ1nocAJ1x6Ptt6P0USGxtwKyb0LRmF0bXbB9YYYLnqVIgl5M8MmJ?=
 =?us-ascii?Q?3ctEoldO9vU5FzhIaXi8//30fD5AhyssaxMJn3gNTYh1j20Jh131/H7V8Gnp?=
 =?us-ascii?Q?ho//uRZjmKlvB4KXPC7sEiCHPHRlj/pkKDoj9eCWTO1kWlNg7ihlkpy/1ahW?=
 =?us-ascii?Q?eWHpyIoP8zOmU4DyHB22aqUl1prwmndNUu8rEk/4uKBJThEZHlBqwpowdKXr?=
 =?us-ascii?Q?tdmZtEeEIZw+O1haYriPjeWtYIF8fbGOYJhpSxAyzJ5XQhifkKvnz+2UJ5IQ?=
 =?us-ascii?Q?+4pfPaVNKFW3eHiHiCZeqDOJvA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7274676a-dba4-4a4e-7838-08db55ede2b4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:14:00.3630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F1D13HHxyq0Jt33NlgXxhPqPKRigvPhMq4dVrN7nXvdaPAgnIKZBPijrPq7GQG8ypLUCm0Bc6hKXWJn34udF7wZqXwtWoXZO2Dp6kaHVMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160078
X-Proofpoint-ORIG-GUID: gPTh5M92B8y_rjVZqiNNWiu5KwRDkBF_
X-Proofpoint-GUID: gPTh5M92B8y_rjVZqiNNWiu5KwRDkBF_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=david.edmondson@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> Define and use RATE_LIMIT_MAX instead.

Suggest "RATE_LIMIT_MAX_NONE".

>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration-stats.h | 6 ++++++
>  migration/migration.c       | 4 ++--
>  migration/qemu-file.c       | 6 +++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index cf8a4f0410..e782f1b0df 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -15,6 +15,12 @@
>  
>  #include "qemu/stats64.h"
>  
> +/*
> + * If rate_limit_max is 0, there is special code to remove the rate
> + * limit.
> + */
> +#define RATE_LIMIT_MAX 0
> +
>  /*
>   * These are the ram migration statistic counters.  It is loosely
>   * based on MigrationStats.  We change to Stat64 any counter that
> diff --git a/migration/migration.c b/migration/migration.c
> index 039bba4804..c41c7491bb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2304,7 +2304,7 @@ static void migration_completion(MigrationState *s)
>                   * them if migration fails or is cancelled.
>                   */
>                  s->block_inactive = !migrate_colo();
> -                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
> +                qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
>                  ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
>                                                           s->block_inactive);
>              }
> @@ -3048,7 +3048,7 @@ static void *bg_migration_thread(void *opaque)
>      rcu_register_thread();
>      object_ref(OBJECT(s));
>  
> -    qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
> +    qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
>  
>      setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>      /*
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 597054759d..4bc875b452 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -27,6 +27,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/iov.h"
>  #include "migration.h"
> +#include "migration-stats.h"
>  #include "qemu-file.h"
>  #include "trace.h"
>  #include "options.h"
> @@ -732,7 +733,10 @@ int qemu_file_rate_limit(QEMUFile *f)

Given that qemu_file_rate_limit() is really a boolean, could it be
declared as such?

>      if (qemu_file_get_error(f)) {
>          return 1;
>      }
> -    if (f->rate_limit_max > 0 && f->rate_limit_used > f->rate_limit_max) {
> +    if (f->rate_limit_max == RATE_LIMIT_MAX) {
> +        return 0;
> +    }
> +    if (f->rate_limit_used > f->rate_limit_max) {
>          return 1;
>      }
>      return 0;
> -- 
> 2.40.1
-- 
All those lines and circles, to me, a mystery.

