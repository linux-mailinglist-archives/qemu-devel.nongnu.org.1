Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80482A017
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 19:09:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNd0X-00074A-1L; Wed, 10 Jan 2024 13:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rNd0U-00073j-LD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:08:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rNd0S-0007xc-QY
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:08:50 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40AHtxag013171; Wed, 10 Jan 2024 18:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NmoJ/vVkw2XML/EM7tF/28GRGjqS7TPfCH85T7OoOn0=;
 b=IXi/TI749a6MgqzMRMDELEJrotIPOWome7h61A4+/Ex3jbls9BFY+JLa4KccG3Bnsn9K
 oTBM/OFalEr/psE9LM7YeqrNaxZjhv2Va7Eb/EhHs2q19kG61hpN1g3+aOIWDGJeHm4c
 /TIevR/gZOuuTyi/JhHd98pBdaaLH9TF+Te4JLgOWZwrg/eJpBzMwcRt7yYuRSg4/QdL
 o8MueMfXDh+ULB34CRRXIfQ2gzKcvAZvEOAQmr6xhiDbTBOAA6mjvic8obzcURGZm6FJ
 gAVJKRDgXHNVn2qUaxg+8vWXjMdHAXVRrvSoT9LE1YnqtCx8fTYRyNA5F0z2QNu7JuYo MA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhs1x10jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jan 2024 18:08:47 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40AHJBhG030303; Wed, 10 Jan 2024 18:08:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfutp04dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jan 2024 18:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOpMsYcV1u1zr2Rpqbr8apcDX15qZnMVkUvK1Y4PsJOkMEAvJKJaZ6l18inyIz53FFKMeYzt8G37IWA0Hd0flkt2iuSHi3kzg77aJZYDzXE7vy6O5f2eaQi0VG1b1N4t3xjEjZ7yRYuOsclMHq6ShBhb5rNQorxxzBnhyFabPikiP3mf8jxEJeKn3OrVuyTSxpiSYc7dbozbogZQWGJyqGd+bE69PR4rsGaHZIBMFsxu3c0XST7wT/NfSUo2u3c3KNnhqSlcbF2U2f7+TaEdaVec3SnlyZIl6PVbeu/UlCZjq1mZDAyELVfRH14cvybibYWYnoKlNk8k5bUx43w8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmoJ/vVkw2XML/EM7tF/28GRGjqS7TPfCH85T7OoOn0=;
 b=FSnOYAdq4yCIw3L27Hv8onZBQVHOOOHXa7yfQOFECK5u1UcMz8ApbHNV+I83a+9hQj2rjxUSIqqr9gnIlR2enBJviVr/ou+ulchCpjGStb/xdrAsUfOO6MtMvmQSwQhbf2Sj1xqOsiC3oFOR3DqkGtlaahauN0uSOQuscQDKIF3n5wLhg3DlKuu9aFS1XVIbP6ehBysPH0BgYObzWW/S5oQSO53o3mVyZpKaJ0Dlv8ihhR4U7lBFAvQEv/ktHfzwEo+YE20ogM78ex67VM5Ix5Q9V+eeVXHeKkWctu9AXzlNwNXjpilSau59uq+m5alVLfgUDY9VAkPAl61LzRMq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmoJ/vVkw2XML/EM7tF/28GRGjqS7TPfCH85T7OoOn0=;
 b=pkdBtqv74Vn7DoZM1JdIawRRug/vrTX8JEoG72bBpeVgcWozR8mMIXQNbg8EKoao4JHwNX9M1ssm+W/1YWax2UrnrzwSuzPAIZroIGoWZpFD23DQGjtHap+K10jztvLoMy+sfvdneBnhyak1G7OWsg5bjIsn/2O33ABmy0JUYdQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS0PR10MB7479.namprd10.prod.outlook.com (2603:10b6:8:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 18:08:44 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 18:08:43 +0000
Message-ID: <94e1241e-e355-4e96-b86a-e0218a7589c6@oracle.com>
Date: Wed, 10 Jan 2024 13:08:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] migration: notifier error reporting
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
 <1702491093-383782-3-git-send-email-steven.sistare@oracle.com>
 <ZZ5E2ubl9XRdXDmh@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZZ5E2ubl9XRdXDmh@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:a03:54::25) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: f917f59d-5ca4-4681-b107-08dc12072e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blna2mrXlO6W6StNjpnMoyvfzx6W774tla8xRKszCeEVy28SIloddlpc2UFIS/eDxiX29q1aW6xpnXdeL+G5jkQoS8Ad//MfqyijoCiYhxuKoZPyL0nXdo2oQfJ+g+1fvqzA7UGLwIS5fofyT4J98dwCAbBqq9YN19gBrPlWWz1PAJAFurbvUcFEHKsQ2KRnAToiGCz6QojmXiYr0x3TBkvDGhmkeHm2bHVqYr09JP0V0TBgHcVv/4tpHb+n2ubfnE/8MUEshUbYJNz8/rXUvGN0SqMelHbMxex1fCZAVQ9D7zN8HCrgMKfAuajjiOn9AvPJHwTNhgPHEHgQgpEUnTXPZPrtnIhsBFaStndxNSy3AFqdHb7frgZ3dAuKoFd5miKCNxwcyMIUnwgQhfzDK7rsErrtgBz7fO3iQhmor1PLYeiAwoYZAppCj4/5C1rmYv/waGSGKxAXb46i2bxGeFx2le1TND5BVanRnOsQnJy1jLAculku4cs6iPjeaqUnTALkXMvMUWIxzK7pxEHZhazyffYYqbBUTtAD9JzGCrNDbSMOtALgccFCKhHQLyn1DVlMUEJIqzk0e8NFaKo81bz/DoD0GUDIwsF5+sO453lpuA7H1wiwjdhcx8l0eeHtFwZxXmOdCLQOLwtU0YDKAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(66899024)(7416002)(5660300002)(478600001)(4326008)(44832011)(38100700002)(66946007)(316002)(66476007)(66556008)(54906003)(6916009)(36756003)(41300700001)(6512007)(31696002)(6486002)(8676002)(36916002)(6506007)(53546011)(2616005)(86362001)(26005)(8936002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NSt3NHA4T0JsbjE1bHhkVGVSVnpSa0hnMklYTDN3ZjJmTk5oSDg1ZkM2R1dp?=
 =?utf-8?B?YzR0c25pVU95YTRZc09NTHNiTUFVL0V4MERhYk9TdEJ0MTFMbUN6Y3Y2Lzdk?=
 =?utf-8?B?STBIWFBMczRQenA5d2RpQVlPNlJML2VrQWNmeHZDNzJoNHVUaGR3aDlOVDJs?=
 =?utf-8?B?MnZ5Ymx1T3NzclJjOEYwVTNtMFN5ajViOE1WSjAxUHJFN2NhOHAyVDBSeUNG?=
 =?utf-8?B?Rlh1cDNWYnU0U1RyKythbWxyMHVQblBSVittYVJHWWUwRmpMNyttYWNsMXlR?=
 =?utf-8?B?M1pQYlVraVpwaVNNV2NxVFNGbEN2WGFrMDlYK2F4Nysva3RPdzcrd1N5NFdu?=
 =?utf-8?B?aGdMaDhCVHFQZFNtcEpzVHFCYTBhbkNhUUlFQmxOZWtkTGdnZUluUGlJeXl4?=
 =?utf-8?B?RHBxb1FEd1JtUFdGT2dSMUpSOGRVRFZvb2NqQ0RxaGZaMm9KVm10UzJxQXZz?=
 =?utf-8?B?aE14dDhvTDlON2w2VzJxWUVKMnJMY1psSFRPbS85UkEwUkRzc1dvN1FsbHM0?=
 =?utf-8?B?ZHBBbnFQa3FiQVFMb3FxYnVhalpXR2FCc2wwaWl1a0JlOVNReFdTaDBpYWpz?=
 =?utf-8?B?RzMxK2RSUzd3Wit5VWVDVTl6Z2dqdXN0SWNubW1PanoreVdUdFdOKzJONm41?=
 =?utf-8?B?WEpyRlJOUGRWTnVVbUI4Y0ROVmd0SnFSb1Ztb3psQjRDdHJ0bmY2RHkvelY2?=
 =?utf-8?B?MzM5c1R2eUkxRVhyTHpURmMyWDBxUGt6Zktkbnd3Yy82NCtIUVRGNk5LcXdT?=
 =?utf-8?B?SFIxRWRYdmM1RGlSL1d1VktYdTYrbnVMZkU0VE1GWWdLaFJ6WmVIVmpSNy9P?=
 =?utf-8?B?SUlkZkprK1B2c0tncEFzSEYxK20rTndFTmc3eHZia2p3T0lPOVl0NHZWVHhx?=
 =?utf-8?B?T2NpSlFTM1dINUpUc294eTIra2VEbVFCZ3dSaHVGbmh6dTBFTERRd0x1VkRv?=
 =?utf-8?B?KzVyUXNLdXVmQ1NkcFI4a3dzM01kRWQySXNnUTRmVWdrYlE3dU5SeXBid0lU?=
 =?utf-8?B?T0tNSmJvcWdpNnkyYkNpQ3l4OUh4RFdJMGl5OE5wb0NIUWFvK211R2VYY1Ar?=
 =?utf-8?B?N1AzSzJZK1dETS9oNUxnazVOMlZyc3kvdCtqZU1Ma0lGRC85bDgzTWpvalNs?=
 =?utf-8?B?Z1BmZ3RhTHpCbjVHMy9qWVhMUFRWeHZNVzdsZlM4blZOQzA4MW1PRlVackVF?=
 =?utf-8?B?MTZVUm0vOC80T1RSNlZHbkxSY1RNd3N4QlhqRFAweDI2dDhwbDVZZ0Q2a0lF?=
 =?utf-8?B?aU5xait1V25Yd2llVDVsbzU0OWRadE9MNldRY2JSaVp6NExYNTZscEMySVZz?=
 =?utf-8?B?b09kNlpmbStXRzNMaDB1eXdvcEgvSVMrSXlyZ0VteVVoVUl2SWVjK09DbzRQ?=
 =?utf-8?B?Y2xOUGtFbTdsN3VDQ3dMZGN0ajdKR2M2RlRQQVIzN2Q0NSs2QkhMa1lOUjJr?=
 =?utf-8?B?QTBPcGhXTEFza3ptcWZ0QkoxODFTUG93QUxKc29WSW5vUVJweWs2M25kUW9T?=
 =?utf-8?B?R3l2VEZ5M1N6Qk1uZVc2ZERNKzk4L0E0R2RNS0ZhZWR5V0lYRzZzSFpyTXVp?=
 =?utf-8?B?UjdLWFhhY3ladjJpd1dtUXIvc0Z4L0R2aG1zR2tlem5PcFcvSkREVjVISFpn?=
 =?utf-8?B?R0wrUFhXRjFDc3NPNnRheFRTM2hJT2RDYWx2emFzTTJFeFNab1hTR3NER2dD?=
 =?utf-8?B?RTh4RDFVV2FXM1J4eWtZOVFMb2dGclFEV3BDTmp6VXkrTWpLOFFRSVAzSXBG?=
 =?utf-8?B?Rmg3UzVEQXVMLzVIZXNGalp1aXA1Vnl5OG02M0tPc25LU0JqWGRzZ2VudWs5?=
 =?utf-8?B?eW1Xdzd6NnFDenZGWXY3ajJuUWZEek1QUFE0Vk1Gb1hPcE9kVGZaN24veCs2?=
 =?utf-8?B?Tk9aczNtOW5KWWZhZldySDRoM0FXaGE5VEhJaW85aXgzV2dXRWhHRFd2NjBG?=
 =?utf-8?B?T2pvd05idHNjekEvMm5Sc1J0SG9uS3FvRWJQeGRjNm0vbnJIR0lhRWEyMXEr?=
 =?utf-8?B?eWVtTUNTSW5oYjRYZTRBd2wvbyttZUJ2QjFxMlRtZ0o5cUZGRFRPYmhocFNa?=
 =?utf-8?B?L2Q1TkFnaXNOMUt4Z1JOMjZUZW40TGE2RnhLbVZlWnJLZU5Yc0ZPQnA3NXVy?=
 =?utf-8?B?UVdvL2IrL0JMc2hnM1FyVVJyTHVlZmRIckxtWUlRL0NSRHhPanpuRnFTS055?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uWu/Mn3AXzrAVOVAeNh/4uMW/H1gd/myxIAjTfTqwfKAnXBSZEbGXs/GqYcle04VUmQa3xrOGK3tmZRNKPukL5lvOqyclNkQBzeVz1Vu5EjQkTjAlzBuVLWtGvwxMPJnE4SYzhA+CpK5jflsSU+Nte0Si+MgVfXLmO/W8P7pf3lSr7oRquR0XR77L01SD8FMqHJaRZaMESRy8LqjOPkOCQ1ORwMHIHFJ35ukCha3h7eq4+Vf71BqmcagFknV7TKedcq0Cx4EZgO+lMD64WQh2F9evxuKZwea/WRM2PbNDCgmdusdqKk6afJmfa/nsdsHTwZjZH49wv4gTFaP/5Do6GyLkzucgcnfAc2HrT9JLpN9yDRAoOY4KMePk7+NqFdhMALE1KHRPT+/qYyKCjS0Icb5uvSRvnZIHVx4uGjLvw7SQRJPVuhSA2GS4O4D0NgMIskAsyu65sBhonV2VHXv2Bdd1H2cwQTecQrVBzgKmw0S7IzNnQIBJqL74qh/SBXz+EDyN1FSToHnmKhkbylc6Gjj2Xj7u9mZHOvmX0WJAcNrIWgugCO+/G7EWdiCtkfbjhU4AX1ORIq0vw9XsvjqJ65YFr4+pnucvYa7fMGUoZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f917f59d-5ca4-4681-b107-08dc12072e76
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 18:08:43.5640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVhe3t4+Of9WFYDXaNelb69kdZt8XNWs1s50x9grGjQzELAQGiRFuAS+vKhJVszcMrka2aieOY5H7qbHgJ51UhKtHMMVV/U09rjU16bxQk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_08,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100144
X-Proofpoint-ORIG-GUID: lv2e76E49R_4JFEesNPE86caF3IZSNp_
X-Proofpoint-GUID: lv2e76E49R_4JFEesNPE86caF3IZSNp_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/10/2024 2:18 AM, Peter Xu wrote:
> On Wed, Dec 13, 2023 at 10:11:32AM -0800, Steve Sistare wrote:
>> After calling notifiers, check if an error has been reported via
>> migrate_set_error, and halt the migration.
>>
>> None of the notifiers call migrate_set_error at this time, so no
>> functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/migration/misc.h |  2 +-
>>  migration/migration.c    | 26 ++++++++++++++++++++++----
>>  2 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 901d117..231d7e4 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -65,7 +65,7 @@ MigMode migrate_mode_of(MigrationState *);
>>  void migration_add_notifier(Notifier *notify,
>>                              void (*func)(Notifier *notifier, void *data));
>>  void migration_remove_notifier(Notifier *notify);
>> -void migration_call_notifiers(MigrationState *s);
>> +int migration_call_notifiers(MigrationState *s);
>>  bool migration_in_setup(MigrationState *);
>>  bool migration_has_finished(MigrationState *);
>>  bool migration_has_failed(MigrationState *);
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d5bfe70..29a9a92 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1280,6 +1280,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
>>  
>>  static void migrate_fd_cleanup(MigrationState *s)
>>  {
>> +    bool already_failed;
>> +
>>      qemu_bh_delete(s->cleanup_bh);
>>      s->cleanup_bh = NULL;
>>  
>> @@ -1327,11 +1329,20 @@ static void migrate_fd_cleanup(MigrationState *s)
>>                            MIGRATION_STATUS_CANCELLED);
>>      }
>>  
>> +    already_failed = migration_has_failed(s);
>> +    if (migration_call_notifiers(s)) {
>> +        if (!already_failed) {
>> +            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> +            /* Notify again to recover from this late failure. */
>> +            migration_call_notifiers(s);
>> +        }
>> +    }
>> +
>>      if (s->error) {
>>          /* It is used on info migrate.  We can't free it */
>>          error_report_err(error_copy(s->error));
>>      }
>> -    migration_call_notifiers(s);
>> +
>>      block_cleanup_parameters();
>>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>>  }
>> @@ -1450,9 +1461,10 @@ void migration_remove_notifier(Notifier *notify)
>>      }
>>  }
>>  
>> -void migration_call_notifiers(MigrationState *s)
>> +int migration_call_notifiers(MigrationState *s)
>>  {
>>      notifier_list_notify(&migration_state_notifiers, s);
>> +    return (s->error != NULL);
> 
> Exporting more migration_*() functions is pretty ugly to me..

I assume you mean migrate_set_error(), which is currently only called from
migration/*.c code.

Instead, we could define a new function migrate_set_notifier_error(), defined
in the new file migration/notifier.h, so we clearly limit the migration 
functions which can be called from notifiers.  (Its implementation just calls
migrate_set_error)

> Would it be better to pass in "Error** errp" into each notifiers?  That may
> need an open coded notifier_list_notify(), breaking the loop if "*errp".
> 
> And the notifier API currently only support one arg..  maybe we should
> implement the notifiers ourselves, ideally passing in "(int state, Error
> **errp)" instead of "(MigrationState *s)".
> 
> Ideally with that MigrationState* shouldn't be visible outside migration/.

I will regret saying this because of the amount of (mechanical) code change involved,
but the cleanest solution is:

* Pass errp to: 
  notifier_with_return_list_notify(NotifierWithReturnList *list, void *data, Error *errp)
* Pass errp to the NotifierWithReturn notifier:
  int (*notify)(NotifierWithReturn *notifier, void *data, Error **errp);
* Delete the errp member from struct PostcopyNotifyData and pass errp to the notifier function
  Ditto for PrecopyNotifyData.
* Convert all migration notifiers to NotifierWithReturn

- Steve

>>  }
>>  
>>  bool migration_in_setup(MigrationState *s)
>> @@ -2520,7 +2532,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>>       * spice needs to trigger a transition now
>>       */
>>      ms->postcopy_after_devices = true;
>> -    migration_call_notifiers(ms);
>> +    if (migration_call_notifiers(ms)) {
>> +        goto fail;
>> +    }
>>  
>>      migration_downtime_end(ms);
>>  
>> @@ -3589,7 +3603,11 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>          rate_limit = migrate_max_bandwidth();
>>  
>>          /* Notify before starting migration thread */
>> -        migration_call_notifiers(s);
>> +        if (migration_call_notifiers(s)) {
>> +            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> +            migrate_fd_cleanup(s);
>> +            return;
>> +        }
>>      }
>>  
>>      migration_rate_set(rate_limit);
>> -- 
>> 1.8.3.1
>>
> 

