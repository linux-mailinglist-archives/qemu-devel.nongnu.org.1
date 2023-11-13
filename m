Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D9C7EA2E3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bjx-0001kg-Bg; Mon, 13 Nov 2023 13:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bjr-0001kM-Vo
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:32:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bjp-000312-BL
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:32:47 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHijLD005614; Mon, 13 Nov 2023 18:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=H774ekHp+zBlsMcbLu9eFSmuKiBjDt+1wCStUGlR1o8=;
 b=WVF3eQWj7iBl7JVy3NDKSwOWMCc/jQidW5Bx2WM+vcDMYLtBD1Cd41Fa3fFJYfMVIPSI
 xcAm0tv6AWX8OXldSTjH8VwEs45cbjWu6hBmKuKAiHkrZbEbdmfEHOnhLTbDKgACy92c
 EuHuEURI+1SjtGJIZbcuNj/AzolEULmyfdwilBcY4+s6LeNG2+W47ECNdElV3rm/nL+t
 zObBszgz+8QIJ6JZiJ8SHWM/rY/p4p5My2bfiihHjzv8+8pMhg/ThWj0S9B4hK0TA0kP
 SD4lCgtmVx+kr9Uq7zBwuEVODCn8AodNT9XuOlNqoaVknRSnmO+FXeK0h2bzkrDnqA9c jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n3beqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:32:39 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADHakXY029773; Mon, 13 Nov 2023 18:32:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxqqaptd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoFgnvkNDGd0FZahBU0jkkc4BmQF0fRykcAkElLOMAsz8RWiDeBla8yKyHgtlyFtv5CFqtfntg0ggJVy1TwYvFux/6ZrNshhItGIKKKcHdHsnJxiP8xaKaBW44G7nOoWlmbkpb+BNX4hN0APo0JV6KmpfprmOStbUmwi23uw+ILa3WwopI+/FVRb1DqD2becnKPolFC7gwwgGr6nfU/CilczqkHA8y/FNMAsd5S6QV88cW5q6VbNvCsD7DvV6BfVV8LkaAb8mxR2rU3w4LPvOpcCnHOEyUAaYirgCUb19qDneLXzqt3bsxzHx241KVdQwYoS7HKfRs8iM19j98uMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H774ekHp+zBlsMcbLu9eFSmuKiBjDt+1wCStUGlR1o8=;
 b=d27JAXUQ4fnq8FrEx3/xaBYxmHcLx9YZC0iSmxXNqBGwDJdBzrMRF6OpwOCAKZ7d52hSWvSxDaSokygCgoezr7A0+Wx2UBEOYoOJt0TFEVb9WF28D8sLFQyBujHRLkqzaggltqQ91AhMMesmAmz/fjZ+afud22L/S//ENboYCOFO8mHjTVZa0QknvZtk/6BRWJjYGP5snhlr/IJVDUdV2WDtVfmrm7FzSrQgcahqT9F49JAjYKidPxORpH+PYIhGa85loCd3HIMZ4xi+xez4VOAfciWX49EEcDSxQWfnaQaO90uhzOC5jFCzFgjhvoVCDMjxb10+3IO0bhfg4mxsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H774ekHp+zBlsMcbLu9eFSmuKiBjDt+1wCStUGlR1o8=;
 b=GBo9q1SbnsYT0Y3x4FHSBhBy2FSqbta1qA1WLB3ysCOd1sFp9ieZh6EqL1Z9N/ChqxU6IQRBY1Sd2X3GyMBQSyNZBXND5/+WfWQIwW4S9AiiKf1+daHGyNKfRZuK3SMlJ/qI0DXKZ2XTbgg1amZqP2nYsorpQhm4eHuC1g/a6YU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4735.namprd10.prod.outlook.com (2603:10b6:a03:2d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 18:32:35 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 18:32:35 +0000
Message-ID: <2d5a015c-507a-47f4-9057-b44c5945f768@oracle.com>
Date: Mon, 13 Nov 2023 13:32:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 04/11] migration: preserve suspended for snapshot
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-5-git-send-email-steven.sistare@oracle.com>
 <ZO9swx34WPRS/cJZ@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZO9swx34WPRS/cJZ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:510:23c::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b73ecdd-e4bb-4272-071c-08dbe476e829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9SjpywYQsoo8+UKbSxPd6bBVz7m1JwkXZr62wyLfNlECnWlV1L5kMy6rT1HlHuwP6tVA6xLfQuQRqKrdVTI0s2XhjGPPlbfTco9zay9ZRGJ2y0GzJggyX6/I4kErj6ptCVwM15hA8EPsIjHKbnNecKCw5jvFuiEXlPbxjacoSIJHSipNRkZIk4dfvsxXX4rWX14EYwLRQ/v9eZk6Xsz53vLb9J+5YEMe2kylwKQvWIfkVX8aMMrkMiRONt0a2j4rV5e3I1Uxv9vaUxGSO//tL77MKWX1wabtfdjKnkfHCm4gxpxUphQlPyxfkVs+t3ld5QkYclUyWos9T7nlBQpWEHnxs18jvmdmy/Q8QNNNo475Urm7RcM5lIOw1JRR8TzERHT4Hye/EOkX8wv/CeepSECaT3FrQgxHSkrzp4Ob8sbpfXHSkohbu8o3Ao4EufzIwLMG8OXz60Y4jUruw3OQ0DjzaeAQAUlwH9GSfutYOXWOsknD6fJgdbCxcqXc0AaykuYkhhxSEEtcH1AdMQCNihhmsWhN8RpRDSDIyJRL5HPm2ogIIfhm+lZSt4XbCP3d58sUscQ7l+6VgIYHaSwe2hakKC7mFvkSNBopVLKqM/v7SBmmqMhTJw2fROjZ45/XZ1uZPemaaVThTRoeRW56g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(15650500001)(8676002)(8936002)(4326008)(5660300002)(44832011)(83380400001)(41300700001)(31696002)(86362001)(478600001)(6486002)(6506007)(36916002)(53546011)(36756003)(26005)(31686004)(6512007)(2616005)(316002)(6916009)(38100700002)(66556008)(66946007)(54906003)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmJrQk1VaS9ReHV5MHZsS2hLSW1Fd3VUY1R4ekJQWFBLYURNUlA1WWx3dUpR?=
 =?utf-8?B?SkR3SERJdmVkQkk3TEJIb0lPWVMwMkFtTFBnbmwrQlBtWEFCTVp2Y0ovbS9X?=
 =?utf-8?B?dEdxVXRTa3daK2VKWEhLSEhLbVlrbUFRL2piay8xdk1rTEk2UjllVXkxdWxP?=
 =?utf-8?B?ZWVyaUpKd28vOTEvMGJmSFBoZ3UxQ1IySUwxc3drVVFJVVh5ZmV4NG9Yd0p6?=
 =?utf-8?B?UVYxY1hVWkdiN0dUZE94RVo3eXhiQkdOZGFLTUNyaG0wT2xUQ2I3L3g1em9z?=
 =?utf-8?B?a0FRRFh1QUprbnBwSDBETllFRWU5Um53M0hQMHNFSjRIQm5kcWF5emwzaEJk?=
 =?utf-8?B?YzJ5dWJnKzN4V09wa3F2UVZMWGwwMWpnUktEWlY0bWdtRWx0cmxFVk9nbWFy?=
 =?utf-8?B?MzFjbjhQT2x5OUlqd2F5c3Via29PWG9uWDYxSzlOUTgzRUMrdUl5ZCtrRTBk?=
 =?utf-8?B?WC9SSTROcGR1MW56L0pUM1dEWU95TnZVNVJSSFcxOXgwaWtUbysrV200MFk5?=
 =?utf-8?B?Y3ZPTm5yVGpPenEwc29ER2c0c3oyNnk4R1RweDdNS1BGdGt4ZjNzbzM4cklU?=
 =?utf-8?B?L1hFcmloeWc0ZE9SVTdoaEhEaitFNStVVUFENlRsZUtOeVpySDljUzA4cWZx?=
 =?utf-8?B?VkkvbTc3czdsZDJ6b2l2a3FoRjB5blNxeHljTEdNZ3V0ekxHc3BTOVNhY1hK?=
 =?utf-8?B?WHRTZThpcnNzbGRxc3RESUFFcldPVVJ1ZCtVSmgwcDRVa0J0aGZMSit6Tnpk?=
 =?utf-8?B?aG1hWURGWnZ4Nk1XK0tlRzYyMUF4dWs2VFpXYyswVFFxM1J3em5qUzhtTUZU?=
 =?utf-8?B?THc3TWZoS054Q3JHTVRGQk1ZdGU0OUJ4WHY5d2xFa0tnWi9iSXVoY1FsV2R6?=
 =?utf-8?B?RXpyclpnN2RxM2owbEpDdzJlWTBtSlhuQkExeVBKbENnNElMKzRtaWNWOHAy?=
 =?utf-8?B?L251Nzl5dUJ2L21oQmhJZm12VlBxY2M2RkhlYzN5MVkvSllBSENYOUhqdXNC?=
 =?utf-8?B?b1J4Wkx1ZkFiVVdDUGVQNSsza0pYVXk4NW5iSUIweG9KR2doWDZJUjhHN3FG?=
 =?utf-8?B?NzN5S1JCNXJXbVBBVmpkdUhqaFdHTmJJMlJFTkZGaHJhY2RjNUlWK3N6VUVD?=
 =?utf-8?B?anZES1RiSXpLRVpwZWF3QythWVdKSXVrbHdCOUdqWmRUanFsditQSWRJZU80?=
 =?utf-8?B?NGVtbWRLV1k2K0JlRnBRZDFsS2dmOHRZWFNIS00zVVhkT1VOeUNxTm9mcU1X?=
 =?utf-8?B?eWFZNkI5ejQ2ejNZV2hKbHM3eWZYSXQ4blFROEFWL1Q4eTJ2R0NWUUhpZmRv?=
 =?utf-8?B?YjlOQWc5YUdWUWx4eHJWQmxQOEJEbWdsWjVWQ0YvVVhVcm1od25LRGIxNzlP?=
 =?utf-8?B?YmxIazNVMktrenRZQ1NGWWczVk1zemJRUzVuTmc3Q0RHdXA2U0lCYkJLTkts?=
 =?utf-8?B?bXFZUDgzdUFEWVVVZUdFalBnT3BpMURpTlJuQXMyL1ZMVzR0WnhQVGRhSndP?=
 =?utf-8?B?R3pvSFRaYXRnS0VRdTNQUUVhS2E5ak9WSGdIQlYwKzFjeDM4YmVFRmFWelpS?=
 =?utf-8?B?MlNTZ1F5NFY2MzZuOFRqQlVEelhRMkdkMjREVzd4TGN5eVFsMlFNWG82Z3NF?=
 =?utf-8?B?UzVYTHRxZVBUbWM3R2ZTOHBhS3kzTHEyU3VSYi8xd203NzNLTDNBV2NLYzFu?=
 =?utf-8?B?VnRRRG1jVG5sZkZoVktmNEdGUkNUZHhjWlowV2h3bWdJTTdBcWlwT0Rtb0pS?=
 =?utf-8?B?V012Z2ZPZTlvQlVyK1l0ckZTTXBDNkJvalgvNFFLN1JFTWkrcW5tOFpYL2tT?=
 =?utf-8?B?empqSFF6YW1WdDExSnkxbFE5SzZidXFrM2I3UWJ5d1ZxV0E4dDQ2ZEJVQ0tO?=
 =?utf-8?B?OS9oQXV0TjNYTW5SZ1hpbFVhbFk0eTNKdFVqdURLdUNrNmpDUWQzZFBqNjNy?=
 =?utf-8?B?bnZTVVRaUnRjSlZzT2lsUHJUY0cydjVkbTY5UkI2b2tJYTZDTGwrVm5haWFS?=
 =?utf-8?B?eVZMbFJjTnlPUlI1R0I0eE1aTFZhRUpMZlcyU1lUUlhwUXVqLzJzQ2VrcFFB?=
 =?utf-8?B?ZXl4STAzb0Y4NllGZmRPU3BDVnAyNlQ0bWlhMU1CWnNnU3VmV2ZvSVJYSzFQ?=
 =?utf-8?B?UlpKMzRpYkJqQmtlVXV5bzlNYk5tTE5CVXJGSHRDVFZqc3ozd2t5aEw0WVlL?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SaCHeHb5EuHP4iV+hS9QZwLD4K2w0cHY3DKFbJIMSJ1U2/INbZsKPoi9fjUixL7kYPrC2eDR5D/9Qx/R+APuhXv8KFn3aLzKQlzqzAwCIPAryIwh+qAOhkEflCHvny4ixuYi/H/MW/KZ1/iZ/8fLttGSmy67u3KCIg8d1f1uB2hmRUcatroiyzm145oIT6rl7SLrldHCHqB2A59Z69t1az334xkregs3QI4rByP8VGUdldkW+JELC504y7VJhJqyLJkH7j1lws/JwRrEdw2AagnZfRktOdinyi4x1tA2uSzVeSB+QFDXip2TP/rE4PHs32FtK2LtoLloai0/XFCk7/7RZrkLg0iie9j6InC653bE3wPvh6QLrgZvaYHCEdt6yMjRaJ/xwxQ1VlfiD458uYZKErnjuw9WyGufUUZS2rhGfrTEy6NS/8C9TEzsZVyczyRpioI39ij1zd/4jKmm+a6IeomRE4mY1hONpjJW0n7towOAdIjJO0o+Dgd3AzBvII/g8lUMheGTpyZ38WXpEmi38PiZZ8CyuCnzkj0nLwZV0fSt6n5wyfe84CtJXex2PrT7WcE86yluo2I49ZLxpHbVKJgW+A8/ts8dZuj/J8uLxfDqGnH6ywvWCp3iMmWghOiRKeT626ghsOq9aMGUDH2DIZ1oMSJgH+0lu3L8l7kSdSPLAAd7krPU7Wf0vAQOTvo50Ns+KwXm+XuaAeHx0vy406cxe9TUyBrv2N+VZGNC8qWHijkW5GfqGVRJUB5N9dHAkHKj3Aw7GEqTDenDyg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b73ecdd-e4bb-4272-071c-08dbe476e829
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:32:35.6829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7+G7BZwzrSN5FdYx87EBeHYFINAYn6OnAVzp+b4A7Ru4CAPFtNwFqenIPaBDkbEgZaKS7Au13QBNelVgGYrmuebtrq4b8COlxIMdiLKrpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130151
X-Proofpoint-GUID: 9wWXeFVvlRfXlfYKIN0a-QDoOAOYAKua
X-Proofpoint-ORIG-GUID: 9wWXeFVvlRfXlfYKIN0a-QDoOAOYAKua
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

On 8/30/2023 12:22 PM, Peter Xu wrote:
> On Tue, Aug 29, 2023 at 11:17:59AM -0700, Steve Sistare wrote:
>> Restoring a snapshot can break a suspended guest.
>>
>> If a guest is suspended and saved to a snapshot using savevm, and qemu
>> is terminated and restarted with the -S option, then loadvm does not
>> restore the guest.  The runstate is running, but the guest is not, because
>> vm_start was not called.  The root cause is that loadvm does not restore
>> the runstate (eg suspended) from global_state loaded from the state file.
>>
>> Restore the runstate, and allow the new state transitions that are possible.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  migration/savevm.c | 1 +
>>  softmmu/runstate.c | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index eba3653..7b9c477 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3194,6 +3194,7 @@ bool load_snapshot(const char *name, const char *vmstate,
>>      }
>>      aio_context_acquire(aio_context);
>>      ret = qemu_loadvm_state(f);
>> +    migrate_set_runstate();
> 
> I see that some load_snapshot() callers manage the vm states on their own.
> Take snapshot_load_job_bh() as an example:
> 
>     s->ret = load_snapshot(s->tag, s->vmstate, true, s->devices, s->errp);
>     if (s->ret && orig_vm_running) {
>         vm_start();
>     }
> 
> I assume you wanted to unify the state changes here.  Need to fix the
> callers too?

Agreed. Fixed in V5.

>>      migration_incoming_state_destroy();
>>      aio_context_release(aio_context);
>>  
>> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
>> index f3bd862..21d7407 100644
>> --- a/softmmu/runstate.c
>> +++ b/softmmu/runstate.c
>> @@ -77,6 +77,8 @@ typedef struct {
>>  
>>  static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
>> +    { RUN_STATE_PRELAUNCH, RUN_STATE_PAUSED },
>> +    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
>>  
>>      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
>>      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
> 
> Many of the call sites also starts loadvm under RUN_STATE_RESTORE_VM.  Do
> we need more entries for that?

Agreed. Fixed in V5.

- Steve

