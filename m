Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F9275D611
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 22:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMxC0-0005uP-Bp; Fri, 21 Jul 2023 16:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qMxBy-0005ty-0h
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:57:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qMxBr-0004IP-H9
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 16:57:37 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36LEFxKn017479; Fri, 21 Jul 2023 20:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+eiDLft7eJoK3z5DyEkV5rXY/VYzGW52pKW+9ofu7k4=;
 b=IxSqcLUpu6p7YIKS29wdXyYSo+BmHp5U03s8DtjuRWJ7TchLdVSGw3BzyymnGrnVu4Mg
 vU9Ah/CPxpMcgGwFpBLtUB73zRcyYmMEOu18RbezpB4ha0ivyjZ8iGUZog94q1D58UPm
 bWWhsbXBqmzfNZSUfqr/B0KAWSyLFvDapPFhnXy+Q6KCmU589a8MTw2Tls+YLW+LfkeO
 uZBiA5u5B9AmOIdkZ1xha+UYbVJsekVj+fPULCI27tAEQyk6pFhEeN3YtnyDdl7otA1y
 MBMhsrUiDvVXhnwk//VhaXbz+A+g7x0S8AI5PmwpqAYctgWQ5PuhCTbvOLQZSEaXHqLl ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88vwfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jul 2023 20:57:25 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36LIrXIq007860; Fri, 21 Jul 2023 20:57:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhwa8jxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jul 2023 20:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTCF4MYaaH/iqCP2NxlgdUwJ/Wi2937FRnumuZkiTZd0bNlb6rxaeiCiZT2rzDYrfZH4zT5X9O9zZLQmg2p34mjV4C/dWLQIJojDsLIsuZdkOuuNSgTIhwE3Tvo00Rvq8TnH1b+d51s0Zw9bu7j2jm5PNZZ6R5qI/Fj30aUw3Yj5F15ZqvZwYrFi/B0j/bAFX62IiYXQFplhUVn7CdN1t/+Ez+DqLSaY+2HmdHI2mLQuAK62y388qj4lUv9V5egkJvc/1biJQ6DGVGAhfsmOS67vfg5XPLaxLcnWxBuN2/XPxCxFbe7WSQdzUXi8Z63zdkDxB++74/DZo/ss3SjchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eiDLft7eJoK3z5DyEkV5rXY/VYzGW52pKW+9ofu7k4=;
 b=lQzOkbbvC7pQuatjDcDpl6DeODdIKmNjmfI/+h4wfZO22C6QA/3bLCkbb17C9DrJclWxcwdDX+KUboxm/vR8tZu9bgSGf3LMfDylFNrxAqq4JXURhbY0jnNlF90CVTqCFfONylWOMlArFlsJR+aAmE+g03Fh6TjJwUQJP3O4LZupctVj3RXHD8ws5PNvOUQPHSZeTw5jitjZKuSKyhRNxo2tO8rqxHK+eeKgisnSf1U+07C/vNIxGzF34W7FbGoCqJh7ylE4IXFconPyEGB/VSYkCtpDkAdaqhpwy1Krb1uH60V2B6xzI8rkfEUB7m/wR8OPEdCznWMHa5S8ld59dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eiDLft7eJoK3z5DyEkV5rXY/VYzGW52pKW+9ofu7k4=;
 b=V0HkjyYvTD423sQPbJXCx36hZ7SmxABC4PNJqEnyFD2jUKPwlKuCRlJ5jdcW446cTbNWXTHgp/GBAknRtEHHKqtj0MgpJsxEPtYIMcI4eOnTNnvN6SD3ti1tEZNbv/IkErGM5PHl85ro9EgwsmlDcgHqoLnAw/i0gXsooRMqQI0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 20:57:22 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a%5]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 20:57:22 +0000
Message-ID: <4db50fe5-f985-7b22-3055-1cca394345c2@oracle.com>
Date: Fri, 21 Jul 2023 13:57:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] Reduce vdpa initialization / startup overhead
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pei Li <peili@andrew.cmu.edu>, Jason Wang <jasowang@redhat.com>,
 peili.dev@gmail.com, qemu-devel@nongnu.org
References: <20230418225638.1467969-1-peili.dev@gmail.com>
 <CAJaqyWebSowMMWh+HCjj7tmbA3Ey6C69T=SPA4k+6fd_-GjfoA@mail.gmail.com>
 <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
 <CACCFcFr8rYbM3OF8Hk=WnS7mAUv49aTsYHWnMwkMVg8SWRhp+Q@mail.gmail.com>
 <CAJaqyWeOuUDKyXd7QAOUhMb-6G+P_q_X4Nz7K+QSJwqdE8UO2Q@mail.gmail.com>
 <20230718065500-mutt-send-email-mst@kernel.org>
 <CAJaqyWc-ubCuC=vLZkPzvm3=0f755TA4BroXswQ=Qv3Y1qx8fw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWc-ubCuC=vLZkPzvm3=0f755TA4BroXswQ=Qv3Y1qx8fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0089.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::30) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 62da0b54-0f91-4372-e05a-08db8a2d144b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJx8/3Q99IbtOkeeGGNRSz0CfZ6NGpKzACZt72FawBKRwE2HuqhMRvlDLgunxBG/dD8IL6RGAwCcjJzrzl51s4p93XuxFYplsy64hTt0wWb/ylMX9jZS0+NN7haV7u9GMOCnR2Mk4IetqQT085CiCTwBX9rCezziCg1spNvTwtro1wipWiRAtJ/0cEwQtZf9oJsKwysFyf5WUVQL5W78ZzZP8ctKhy67xP+/JbLS0RAmpL7r56q5nZ+h4Lnlyw/nue3XkL+jMDvTipnbVCXE8kvCTMdpZgQR0XxJ2L39aegXcob4DVOCplfG0821KikKPWnunIrjhbCEAscFUS2X7nyT9RkO2zApPN4P4W41e/iLb6k3BCVIwvlYP+l/koJcHOgjaSWYJHAyauIhxRKFaqU31yVeYLeH6ukhKd0J7mmU9NE5iTSI8X99ObrZf3k35yY+kGQ7gRZLyWhc6S/pICCneG0M+Dxa/sKSqgrdabk81qPtY7dLXdJHIJPhDpLQ1Ol6uiJKao3mg0xPoufvqtiE7mvjLOBG0CixVdso4v+hLQPyteuKk/eVZirEmEpUhPPbvds0o6imC5LVsu8WUZZATV8pau+jGIDgFjBvwsuOX3RkFlUQrjK5JbcxrGhd+/ni+MYbo+QRCS4Bz1E/3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(6666004)(8676002)(6512007)(36916002)(6486002)(54906003)(110136005)(966005)(5660300002)(41300700001)(8936002)(66556008)(4326008)(66476007)(478600001)(2616005)(316002)(66946007)(53546011)(186003)(38100700002)(6506007)(83380400001)(26005)(86362001)(36756003)(31696002)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlOelpUd1ZibjBCYWJNQldiTis3VkNEditSK1IvL2Qwc2ZHVkFJanQyV2Rw?=
 =?utf-8?B?WmZxdG1QWmNrdERQWTlDMytwakNNRHAvd0xwMVBCemN1S2pBNnN4aHZtYXdE?=
 =?utf-8?B?MkwxRVNsdENqNlFJWVNnZjdKaSs3NWErSTlMbExMdFkra0tabEovNG1UcXVq?=
 =?utf-8?B?TkI5anYvck9wODZGQXlWZEJta1dtczZmN092WmYrS081b0pFZm9UVlpzRXY3?=
 =?utf-8?B?aXNSSkpGV2s5TkpKdzZaN0ovYUdiNUlpYzNJYUM5MEFtQ1gzRGRkYWlYc1lK?=
 =?utf-8?B?L1Zob2NNREkwVVpldHhPdi9aL1ZiVzdhVkFqQTNLNXdVK1dITTBGUlp0d0ZH?=
 =?utf-8?B?ZnpEZU9hTGM1alNBRmV1eWJ6dXVjOHpUM0tWdDRoYmhaZkwxN3RhVGpyTUlr?=
 =?utf-8?B?MGlneGx3MjZTb3FqajR6cTRxRWxIQm5YNTd5dG5MY004b1ZwQ28yRzRhekg5?=
 =?utf-8?B?Mm1DN1ZpbXIzYUxjSGdZNUZJSHZMRWY1TFBrOW1JOElUMGZFQ3g3N1dxUjZz?=
 =?utf-8?B?WE5TOFdHL0RmMElWTnhEUnc5eU05d3d4Wm84U01oV1hRNUVhZDh5MlRrYzlR?=
 =?utf-8?B?cDVLYWZVOW4ycE4vTHFiSlJsTDBYY2FjTU85eDI5NEJwRkEvMkJidzRadDA2?=
 =?utf-8?B?NWthWjlYMW52WWFWMlordlJBNGdiS2hsR2Zlek5tNXNXcGFhcXdiOG5UaU9C?=
 =?utf-8?B?Ymc0MUVhalIwZm02SVBDVGhpcjAzMVZsTG9YWm5mdnN4TTE3ZVBveEJEbXhM?=
 =?utf-8?B?SWxNYWc3a094cVVRcWlTYU5tSTRvT3BHU2dYaHJHVTdZd2xNQkpwODlhdTdr?=
 =?utf-8?B?K1czTGZkaUpITWxQNDBiVjZmT2hoVmhxQTNiSW1BRlljQkdyZlJDVHhGZFZy?=
 =?utf-8?B?d1d1Z2d4ajJUMUJ0MG9PL1NFQmtuS2NsbVcwZC9EOWQ5ZHV2eUs5dTNNelkx?=
 =?utf-8?B?ZXlEQk5pdTA3NWt4SVZsRk9tVGtyMVRacGxLMFpDWU1yU3BZU1pXcVN1cmFF?=
 =?utf-8?B?c2JaMnJ4NmhrRzY0UnhFNUhIdnZKbDZVcjMvd1ExcHdOMnZPWTY5ZFVkTklJ?=
 =?utf-8?B?WDZBbjNTWm9WNExhQS9WTG1jZ1pNblBJd2s1VThvZXhFTUdNZUJuVVNlY0JM?=
 =?utf-8?B?Ky9CSXd3Y0JFYUxXZWZrbzJMYnMra2IraTh1ZjBFbVJYaVcxazQvYTdXdm50?=
 =?utf-8?B?OHFxVW5LbElJWituMVEzb0RQd2VWMm9pc1VNQ1VXUWJUcjA1WjE2NStuR0xX?=
 =?utf-8?B?ODdGUlExc1hHTXdKVmVGbjF6OXZBb3d3dTBhMm1ERitTdVFvUVRhejFrZ1JT?=
 =?utf-8?B?bis1alBQUVVTRnpBcjkzN3VUcnBoZ0V5dUp0WHVOamt4Mm5qZWJjNWxpSkd3?=
 =?utf-8?B?aXErdFE3aDdZdllncFZKMXNmampaTTVOOE9BZmwwUG5FOWt1ZjJ6ZHNEZUlN?=
 =?utf-8?B?THordXJjc1RtVkJ1bkNtaTJ5TVBtOE1mSVcxV0RGSFhBaytxWFBMZW4rbDFT?=
 =?utf-8?B?NkErM0xSZm41ZHV3bFg5SU1MbTZBTTh4ZEdtZnpzd3NJWFZLekE2bDBxcEN6?=
 =?utf-8?B?ZkgvYm1wdXRPZUN6ZXNHbGN4Y0p3YjVIV081SWxyOTlkcEwxR3o1WWtBK2FU?=
 =?utf-8?B?elovU0tXSy9XM2hCdVB2dmEremxVekNSdkh1K1ZIUlVYM1lldnBTdmFnRGZB?=
 =?utf-8?B?RXoySDlqYWtHMDJQWURvUG8xb3lydVRSSFY4Vlp5MW10elo0Y1F4TWFtNXpN?=
 =?utf-8?B?dXRia0NtY1k2aU9CcEZmZEw5dHV4OEhaK2x2QkpWeHh0alVGMmhxVXdPdXNT?=
 =?utf-8?B?dEZ2VkVKMlNwai9JRER6cmMvS3FFdUg3a0JHQnFWTkprR0dlZlBENjNXcE1K?=
 =?utf-8?B?WEFhUGxhSUIwVU55OXdsT0Y5VjhyNnJOSDlhSldQYUJxT2djd0doU3I2VkNr?=
 =?utf-8?B?U3NSRXd3QkZ4eWdqRXBISHM1SXJVU2tLcnF3RjFIbjRMQzR6dWtGMHRBSE0w?=
 =?utf-8?B?Z25xSHk1UFZmdUtzb21sQlNFVksySFJ2b1pIQ2I0NGxhN1ZmSjdtK0VSNjBB?=
 =?utf-8?B?V1cvaE9yYVQ1ZGlMc1BWNllWeFd1S21tdzRaN0JjeDh2RnNVWTFHTm10VnJt?=
 =?utf-8?Q?CxXMBrm1HmZYFBJDWmwU06tkB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zZ9z/virR3JvjWx/PiRiV01Ciu1lx1eRYsshBtyRV22TwV3+CjOhxuUVWTPiHTOE/9VyCb51rLMyTW2k84dOS6D2f1Vg9Z0BoligGwGPdryD+7v08JLtTObgGkCHy+JWN5iucFPQbu3OcQqqQ+6ePV1so3gaqyOsooynXhxrIDr0I0xy2sqmz5GxwOCTIZCu+mC0iNdWeQIFuaMfPx7P7OtLfIcF0eZndT7+DXoRA3iEGDdiPIuCmptysaqSJkpGt1UnItG5H3cK5X/vtRQCHdp4ag33i8GkGCBbnahxPxzhqg8CGs+QKkJrxNbKRe2ECJ3dVaKU/bK9oIkhp+Q/AZxXdUr6TG9wxAkXdkAgPti371hlsEWup3ZJaf+mq6YiOx/rD2f7B1zobFa/ScBuNmDBjUdnZWqm2JNHXWT7op6lGvunJMSubZHQzppQQ1wiiRMqDiyJYn1QuaZ4L5k5AsWsBXvApRk2i41iEdCrOmLaTt4oSUSmH51SkbachKixUf3PdsNxdU7CT3uWaGm2SvDYpYrN6TpIHpyV2Exl0K6LVsFeW0QYY1nVs/h48Op3I4/RKYQ5YmqpiYuURw5/Z6WddSpsf8JQkoH8KelQtm2rCA7zLJ7Jxvz1l6hrsGtGN3i6jP6BQ3Pa0tNfHKirwSuI/HO7gTAPwzJtVNMF2UsHacoVWf63Pl9qB5xqYSvSol7whebntNyRkTdUFn5vcOzYfyHztGmYbrMrEciC2W5EXtmVbK3bgbc4NTf3eZp05v82NWt72L7vHkIW05pNYj9RILHMw8pXCj254W4MH/CyTg5lTdXOLTBV8Dd4WTOg7MnD00kGmNYbOk+4g6MdMg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62da0b54-0f91-4372-e05a-08db8a2d144b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 20:57:22.3718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEwb4TXAvdDAk04AUf0XvcQh7sEdcuhYNrCbKWkwBgRBpDf3lf9ARe4s8d0zFS2ZN77yO8hHiSLclelsnU4LKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=918
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210185
X-Proofpoint-GUID: hhIpW6j5QkmAMO8omyxxFfQxKpL4E5hT
X-Proofpoint-ORIG-GUID: hhIpW6j5QkmAMO8omyxxFfQxKpL4E5hT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 7/21/2023 3:39 AM, Eugenio Perez Martin wrote:
> On Tue, Jul 18, 2023 at 12:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Thu, Apr 20, 2023 at 10:59:56AM +0200, Eugenio Perez Martin wrote:
>>> On Thu, Apr 20, 2023 at 7:25 AM Pei Li <peili@andrew.cmu.edu> wrote:
>>>> Hi all,
>>>>
>>>> My bad, I just submitted the kernel patch. If we are passing some generic command, still we have to add an additional field in the structure to indicate what is the unbatched version of this command, and the struct vhost_ioctls would be some command specific structure. In summary, the structure would be something like
>>>> struct vhost_cmd_batch {
>>>>      int ncmds;
>>>>      int cmd;
>>> The unbatched version should go in each vhost_ioctls. That allows us
>>> to send many different commands in one ioctl instead of having to
>>> resort to many ioctls, each one for a different task.
>>>
>>> The problem with that is the size of that struct vhost_ioctl, so we
>>> can build an array. I think it should be enough with the biggest of
>>> them (vhost_vring_addr ?) for a long time, but I would like to know if
>>> anybody finds a drawback here. We could always resort to pointers if
>>> we find we need more space, or start with them from the beginning.
>>>
>>> CCing Si-Wei here too, as he is also interested in reducing the startup time.
>>>
>>> Thanks!
>> And copying my response too:
>> This is all very exciting, but what exactly is the benefit?
>> No optimization patches are going to be merged without
>> numbers showing performance gains.
>> In this case, can you show gains in process startup time?
>> Are they significant enough to warrant adding new UAPI?
>>
> This should have been marked as RFC in that regard.
>
> When this was sent it was one of the planned actions to reduce
> overhead. After Si-Wei benchmarks, all the efforts will focus on
> reducing the pinning / maps for the moment. It is unlikely that this
> will be moved forward soon.
Right, this work has comparatively lower priority in terms of 
significance of impact to migration downtime (to vdpa h/w device that 
does DMA), but after getting the pinning/map latency effect removed from 
the performance path, it'd be easier to see same scalability effect 
subjected to vq count as how software vp_vdpa performs today. I think in 
order to profile the vq scalability effect with large queue count, we 
first would need to have proper implementation of CVQ replay and 
multiqueue LM in place - I'm not sure if x-svq=on could be a good 
approximate, but maybe that can be used to collect some initial 
profiling data. Would this be sufficient to move this forward in parallel?

Regards,
-Siwei

>
> Thanks!
>
>
>>
>>>>      struct vhost_ioctls[];
>>>> };
>>>>
>>>> This is doable. Also, this is my first time submitting patches to open source, sorry about the mess in advance. That being said, feel free to throw questions / comments!
>>>>
>>>> Thanks and best regards,
>>>> Pei
>>>>
>>>> On Wed, Apr 19, 2023 at 9:19 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>> On Wed, Apr 19, 2023 at 11:33 PM Eugenio Perez Martin
>>>>> <eperezma@redhat.com> wrote:
>>>>>> On Wed, Apr 19, 2023 at 12:56 AM <peili.dev@gmail.com> wrote:
>>>>>>> From: Pei Li <peili.dev@gmail.com>
>>>>>>>
>>>>>>> Currently, part of the vdpa initialization / startup process
>>>>>>> needs to trigger many ioctls per vq, which is very inefficient
>>>>>>> and causing unnecessary context switch between user mode and
>>>>>>> kernel mode.
>>>>>>>
>>>>>>> This patch creates an additional ioctl() command, namely
>>>>>>> VHOST_VDPA_GET_VRING_GROUP_BATCH, that will batching
>>>>>>> commands of VHOST_VDPA_GET_VRING_GROUP into a single
>>>>>>> ioctl() call.
>>>>> I'd expect there's a kernel patch but I didn't see that?
>>>>>
>>>>> If we want to go this way. Why simply have a more generic way, that is
>>>>> introducing something like:
>>>>>
>>>>> VHOST_CMD_BATCH which did something like
>>>>>
>>>>> struct vhost_cmd_batch {
>>>>>      int ncmds;
>>>>>      struct vhost_ioctls[];
>>>>> };
>>>>>
>>>>> Then you can batch other ioctls other than GET_VRING_GROUP?
>>>>>
>>>>> Thanks
>>>>>
>>>>>> It seems to me you forgot to send the 0/2 cover letter :).
>>>>>>
>>>>>> Please include the time we save thanks to avoiding the repetitive
>>>>>> ioctls in each patch.
>>>>>>
>>>>>> CCing Jason and Michael.
>>>>>>
>>>>>>> Signed-off-by: Pei Li <peili.dev@gmail.com>
>>>>>>> ---
>>>>>>>   hw/virtio/vhost-vdpa.c                       | 31 +++++++++++++++-----
>>>>>>>   include/standard-headers/linux/vhost_types.h |  3 ++
>>>>>>>   linux-headers/linux/vhost.h                  |  7 +++++
>>>>>>>   3 files changed, 33 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>>>>> index bc6bad23d5..6d45ff8539 100644
>>>>>>> --- a/hw/virtio/vhost-vdpa.c
>>>>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>>>>> @@ -679,7 +679,8 @@ static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
>>>>>>>       uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
>>>>>>>           0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH |
>>>>>>>           0x1ULL << VHOST_BACKEND_F_IOTLB_ASID |
>>>>>>> -        0x1ULL << VHOST_BACKEND_F_SUSPEND;
>>>>>>> +        0x1ULL << VHOST_BACKEND_F_SUSPEND |
>>>>>>> +        0x1ULL << VHOST_BACKEND_F_IOCTL_BATCH;
>>>>>>>       int r;
>>>>>>>
>>>>>>>       if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
>>>>>>> @@ -731,14 +732,28 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
>>>>>>>
>>>>>>>   static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
>>>>>>>   {
>>>>>>> -    int i;
>>>>>>> +    int i, nvqs = dev->nvqs;
>>>>>>> +    uint64_t backend_features = dev->backend_cap;
>>>>>>> +
>>>>>>>       trace_vhost_vdpa_set_vring_ready(dev);
>>>>>>> -    for (i = 0; i < dev->nvqs; ++i) {
>>>>>>> -        struct vhost_vring_state state = {
>>>>>>> -            .index = dev->vq_index + i,
>>>>>>> -            .num = 1,
>>>>>>> -        };
>>>>>>> -        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
>>>>>>> +
>>>>>>> +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOCTL_BATCH))) {
>>>>>>> +        for (i = 0; i < nvqs; ++i) {
>>>>>>> +            struct vhost_vring_state state = {
>>>>>>> +                .index = dev->vq_index + i,
>>>>>>> +                .num = 1,
>>>>>>> +            };
>>>>>>> +            vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
>>>>>>> +        }
>>>>>>> +    } else {
>>>>>>> +        struct vhost_vring_state states[nvqs + 1];
>>>>>>> +        states[0].num = nvqs;
>>>>>>> +        for (i = 1; i <= nvqs; ++i) {
>>>>>>> +            states[i].index = dev->vq_index + i - 1;
>>>>>>> +            states[i].num = 1;
>>>>>>> +        }
>>>>>>> +
>>>>>> I think it's more clear to share the array of vhost_vring_state
>>>>>> states[nvqs + 1], and then fill it either in one shot with
>>>>>> VHOST_VDPA_SET_VRING_ENABLE_BATCH or individually with
>>>>>> VHOST_VDPA_SET_VRING_ENABLE.
>>>>>>
>>>>>> The same feedback goes for VHOST_VDPA_GET_VRING_GROUP_BATCH in the next patch.
>>>>>>
>>>>>>> +        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE_BATCH, &states[0]);
>>>>>>>       }
>>>>>>>       return 0;
>>>>>> This comment is previous to your patch but I just realized we don't
>>>>>> check the return value of vhost_vdpa_call. Maybe it is worth
>>>>>> considering addressing that in this series too.
>>>>>>
>>>>>>>   }
>>>>>>> diff --git a/include/standard-headers/linux/vhost_types.h b/include/standard-headers/linux/vhost_types.h
>>>>>>> index c41a73fe36..068d0e1ceb 100644
>>>>>>> --- a/include/standard-headers/linux/vhost_types.h
>>>>>>> +++ b/include/standard-headers/linux/vhost_types.h
>>>>>>> @@ -164,4 +164,7 @@ struct vhost_vdpa_iova_range {
>>>>>>>   /* Device can be suspended */
>>>>>>>   #define VHOST_BACKEND_F_SUSPEND  0x4
>>>>>>>
>>>>>>> +/* IOCTL requests can be batched */
>>>>>>> +#define VHOST_BACKEND_F_IOCTL_BATCH 0x6
>>>>>>> +
>>>>>>>   #endif
>>>>>>> diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
>>>>>>> index f9f115a7c7..4c9ddd0a0e 100644
>>>>>>> --- a/linux-headers/linux/vhost.h
>>>>>>> +++ b/linux-headers/linux/vhost.h
>>>>>>> @@ -180,4 +180,11 @@
>>>>>>>    */
>>>>>>>   #define VHOST_VDPA_SUSPEND             _IO(VHOST_VIRTIO, 0x7D)
>>>>>>>
>>>>>>> +/* Batch version of VHOST_VDPA_SET_VRING_ENABLE
>>>>>>> + *
>>>>>>> + * Enable/disable the ring while batching the commands.
>>>>>>> + */
>>>>>>> +#define VHOST_VDPA_SET_VRING_ENABLE_BATCH      _IOW(VHOST_VIRTIO, 0x7F, \
>>>>>>> +                                            struct vhost_vring_state)
>>>>>>> +
>>>>>> These headers should be updated with update-linux-headers.sh. To be
>>>>>> done that way we need the changes merged in the kernel before.
>>>>>>
>>>>>> We can signal that the series is not ready for inclusion with the
>>>>>> subject [RFC. PATCH], like [1], and note it in the commit message.
>>>>>> That way, you can keep updating the header manually for demonstration
>>>>>> purposes.
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> [1] https://lore.kernel.org/qemu-devel/20220413163206.1958254-23-eperezma@redhat.com/
>>>>>>
>>>>>
>>>


