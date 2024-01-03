Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B194822E6E
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:33:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1MC-0001mu-Bn; Wed, 03 Jan 2024 08:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL1M1-0001mO-QH
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:32:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL1Ly-00078z-0a
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:32:17 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403DNx2R027431; Wed, 3 Jan 2024 13:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IC3clM15yrPAdKzVgSibongqY4AWieI1OQ6fdxMwYB8=;
 b=JD7InBXns2vR6egu5S7RExs9/z9ZtwvmUimU+3v8dfz4/9gBgB6TDENX4n17OKHlUCdl
 9I7BAfVjvyiP8ak2yKpDnSGXFLaoxuuB/CicyoUsyrCh85XFf261b9bbw1JOuO6j7at5
 /RA4cUFu4qn/fFExN5XRbrvyhazJs/QFw7EEEUnbrY2+xGdB/qeBYpJAtoEAe3nd2d8+
 M2hSN40HXGNFVZQnWY56vk0bjAHS7SgEhiIT+Iiiq+StEDxytykMGGfBBGnkifm9L+G9
 iPux1m0qLFDrww3rzc7m9xmWPP4kVIKJIlyklEu+PM7h+YOccdDHtE6tzSsxRiqwFut2 JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu4xxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 13:32:09 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403DVrZk002582; Wed, 3 Jan 2024 13:32:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vd7un2tbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 13:32:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF5XracmqotYHrdMGEd3VhWr/lTmwv5hq2W2kd5bfHCxJgOpzAmT9lfjzOEL49D3tPDWb0RDFj8CLhmlsaQ0ttBVKESd3Cs5HjJJ9AH/66IkQMSbUbl1FG4iDV7LNO+NwOPuTZ7cjdIsmFXfXxU3hIUlTQ5Aec5utH2MQh5fBTtenbEKLIm3meB3Hp4fkYHYS5B9dsNAM2FcM5upLKN764C1rzJmEAtxWcUGzwQSttd5dKqmf66vl1chMfPxx3GKnHCAqKT17Ymcn/RJzIzv/5LyiwNaSbwkOb3XKtirhaRxPXDyJ2xrGW6SEmOdFS15Qf+jSFo5/078o6FP/NzVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC3clM15yrPAdKzVgSibongqY4AWieI1OQ6fdxMwYB8=;
 b=YUMdhWRZxX9riaCsd614KLEuik3BMxR2PRCbDJVPGhnKM5r4G02bg0qwKfD5IGizZNii/tz7bhBzVuYlrkEz0tm6wzzlXCpWZmD+aycv9Kw4E06oUJQ57iBx2CUGctATL+8A/MRsG2TLrcLzE6A3W6ZGzxDZCHpy8VGvQVH6M0y3kqXZS6YyiGEtRNtungTjfwcl7V/I+0oS4vTg0vpXRkfnknijZGQ7MSXN3sIFJGaOAhcB0bKgKeWKmU4v+ZyqNXXIL78kxP6V0ynAYdgSYO7IZrHwclZaFnwJNLBKi9UNv3DnvKWkYchKZK7cAIqQZPvq7mw6kpIE9STbhCL8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC3clM15yrPAdKzVgSibongqY4AWieI1OQ6fdxMwYB8=;
 b=WcEDOG9DWCcvotzYPuXXNyC6+wtov7RM4IjHUZjB0vlaKA3XJfCs/IWqM9Zu+JuVkIRjYUFLSSSt5Sqj0gw7TByOkPxGr5PkauEtkBPQRynbqyBwqBmoGkeFoZXhuJGwuvugX9+XHz8SaEv2h0xNpipXZ4/zzo9bSxLAek/+19A=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Wed, 3 Jan
 2024 13:32:05 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 13:32:05 +0000
Message-ID: <c28ca43b-8e78-48d2-acba-27009a910d89@oracle.com>
Date: Wed, 3 Jan 2024 08:32:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <87bkaiig2s.fsf@pond.sub.org>
 <9d613137-24aa-4323-aee1-0d38b91339c5@oracle.com>
 <87sf3ta31i.fsf@pond.sub.org> <ZZVcpG8j4qrEYCvS@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZZVcpG8j4qrEYCvS@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c2cfcb-0364-487e-b06a-08dc0c60602f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/0C4Jx/TipO7SDhK7phfbtmMWdyIy/THqpsYHi717HrFR2BQFh8HgQ21GDfHKOR+ZCde1HUCSIbnraf0h7Juy7ZkqJbk3YCV0H4jr7GK3GhZUtrHu/lNZOfkPAwzCKN8Koe+hT4CsRtJVAIWoOMxY6yaZ2PEQcPeVkkhgrAj7eTPPC2fZD/vrjauq3r22CwCNhNuYn33GdTFrlGwd7FGr2UpFp/Nh0lH9L69n+qhl7wD864fjnWITyMeNpXay1dvy2Q+ZfCfPND+RBpedBYEsJ5HCE+UWD0wvfE2s/+rKM6WyGJlX2QdtrDNvnOk5EYyX7iCFCiG2YmD27SprFNyF4H8cHPS7+co+gonKq3RiYyL6JFamLnn4ObXlswkb0CbblKyNAUyQoha16nTph8y/udrvZyzfgBogTWFGHuAivgQbuEtf72JmC8Xz7JTYXfaS/BFRtIdooywiKqJnqnEZomwKSBWLQve4UXIspY1AMlxB8Y8Zce+S/nXniuw/cpIlQ10K3LAS2ZUUd2AQGgDObiQ7nf8lz/OX37XqUiITbRf9v8tLjb7RLUgmQVRbQwsw3RJBMPGsDIIaSgW7eWZ+aHLHhHF1py/hHhzHdsofmBWsjdHK9Hoav/P+aQInujHsJvGk/LFNJ/zNKEqKcvjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(8936002)(8676002)(44832011)(110136005)(54906003)(316002)(66476007)(66556008)(66946007)(4326008)(478600001)(6512007)(6666004)(36916002)(53546011)(6506007)(26005)(2616005)(5660300002)(7416002)(2906002)(41300700001)(558084003)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRMYWVWb2JJVnJ3bmFCbzBxZ0k5QVI5ODNiR25lUStwMk84bFRlR2V2eXZ2?=
 =?utf-8?B?UUlJaWxGRnBzb0NaUHM0RlFCcUVGb21KT0NDL2tnNDVZa1RIMzB2SDJGK0xL?=
 =?utf-8?B?NExpSmR5bTkvdDdweGNnUTZiSzVuVEdROE9TNm1vVmFaUHYrNk13eTRGWklT?=
 =?utf-8?B?TzhjeXdjMW1rSmhteGYwM0ppK0JrdWNuL3dTTHk3dFo5bWZ4TkZGSy9rOXB1?=
 =?utf-8?B?SWpwVUJiUXY4V1IwY1lRb3BINVhwYXkrWXRBTnQ5UlVFR0NwREJicm41YTRL?=
 =?utf-8?B?a2dKNkIyNlFwMEVoUXlWVEtUY0dEdy9qbHV0OUVHdDdhV2orbytXcm1zcWRt?=
 =?utf-8?B?TDFJV2pMWFNuN0FUOU1NWCtQaFR3OFhWc1FjZ2g4K2pNK2RuL2pKRTdVUkFW?=
 =?utf-8?B?Qi8rRjBUS2VpeTVBWS9hc1hyOW5RdG85ajlRRDFoc0tUM0ZwaFRxRkNrWjN1?=
 =?utf-8?B?TTduNjk5c1U5Y3dQZmdDcUNjWHRxS3MvOGdhV0ZoMDRybmJ2N0NmcWFVM0hm?=
 =?utf-8?B?UGVCckNGa0tTTGsyVDB3OFVtWEF0elRZV3ZmMDdVWjFwQkY5cVZENm5hUm9H?=
 =?utf-8?B?cUJSRlFZS1d5NHA4VWQ1eStSeXM5S2FaWUg5MmVabkxsSlZJdk00elJiU2p0?=
 =?utf-8?B?SHZFWTR1VU1WL0duVnBvaWNBRlNkYVNTVnlKN2wya0pSbmRRV1pydVVxTHZn?=
 =?utf-8?B?ZG1QSGUxb1NJYU9tVHNYVGJSN3hjN0J1M2tqVFAxdDRieTNQOStCQm9Pb1JV?=
 =?utf-8?B?eFdpSE1KYk1RMWdwVkFKRjY1c0cxbkl4V1RLK1NSdXQycXR5ejhFTk5pQ1J6?=
 =?utf-8?B?cys4c3RlYzUvUEVodGhuMjV4MkNXZ1p2ai9XRXVPSXR5Rk1HMmlhNVBVc3ly?=
 =?utf-8?B?cXRkK2p3aS9COXA3aHVEcEdHWWRZd1g5WnhibWVTMkFLOHF0OFpoR1Z0OFZr?=
 =?utf-8?B?Tk1GZDRaczZGcXgwZzk3ZjNtOUN4ZnZsQlR3eVIxUklqS01PZGcwU2N4OFVG?=
 =?utf-8?B?Wjk4eTZoaUdJdjBOTG5BdzR0MmdvTUg2VzlOTXVGeTR1S3o1QWpDbUxOVGNY?=
 =?utf-8?B?L0VYNnNKamJrUkc1eTg4NEhIV2tXNDBNS0ZlTStTdmRhTUtUeE02dVZhbkQ4?=
 =?utf-8?B?WW42MUM0QUhuTXh2Wk9TSkVWZmdUQ2xRSTZjVVJLMlVJc1RtdVZjZDEveFFq?=
 =?utf-8?B?UVR3QmgrcWs3bkNWNEFMbFJ6QkxIZ1R2NjJQN21Md0NRMWtDTEF2KzRsV1Jh?=
 =?utf-8?B?T2FvOVdZNmNicVFobGNPUCtLUGNKTEl6VFJZb2U4WVByUWR2VWVyUURiVkpS?=
 =?utf-8?B?dU5HdEplQXBVak40M1JRRFR0VUtYVWZEOUVJU2pzSjNRK09YUGU5VDRFa0lj?=
 =?utf-8?B?Nkl0N0pUc00wMC9hQ2dqNktUaEg3WmdSVmR1MFhFNThGZ0MxODVGaFVjVVNh?=
 =?utf-8?B?Tm1ndDBtNW1GR3lBSjVTK0s5MVdKNnNVU25sY2NvQ09kcC9xTTEwY0h6aktv?=
 =?utf-8?B?VmFpS1FPd1oxT3NlaXNCVllCZUNaWmt6WGFidi9CSW5nTEJidlNnaDV0bThL?=
 =?utf-8?B?c2Z0MUZDbnE0Uk9UaGJ3MXdoZG13UmxDWFZ5TDZ6NDExd2JhcjliVk5SRWhj?=
 =?utf-8?B?U3NsbVVFTWhSK242UkIyWTc0aUJDRCthVlFYa1c3a2hQVVJzMVpldWdrWFRN?=
 =?utf-8?B?Sy8xSVZ0QWRzSkpTZUNKOHJQWDNWWnk3VlEvenArUjlxcWJ0YzhRVmpGbEJ2?=
 =?utf-8?B?NzU5TzZyWFlzVk90Wlo2K0VtU3BGTk13UXR3OG16dkp1NEc4M0ordVBpWmRn?=
 =?utf-8?B?eU01UVBQWVhuMnVWamw0RkdocDk5YUFvZ0lzbG01MWU4TVNSUVNFK0J1bFNY?=
 =?utf-8?B?K3EwUlhzZGxWUC9UdDZocmxrVHNEN2FZdDcwRUNhSlF5dm9za3dvSHF0YzNq?=
 =?utf-8?B?MlZiNCsweERTdmJ6aDdNMGpSWlhJNkFVbm42UVRhaStlKzJNZEd2aFZMZnBo?=
 =?utf-8?B?S0xmS01oN28ya1lYRFdDSWZNMW94dm9HbXNnVjUrSEtWV0YwNWNpdlMzQzhx?=
 =?utf-8?B?QjR2TU54TXFndWJ0dUdNeTBZY0l0UktoSm55dVAxdVlMcVhoV0ZCeXJPV0ha?=
 =?utf-8?B?NVM4UENiWVh0WlVvc3c3dUZhczlHVVZvSUFMUXlycWZHTkd4SHRIdzlVWVhB?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5fMZ0CkqLoLl+VbvVbaFrUI5iAFysEr5L8Oav2wP3Z0hNiAyDT7Ff5yvzBHauml2kWPQ2mj4RI/7mm8VZqF4u86u6Wb3qUEkufB97LyhnOgWlnFVMC8cErSsSqE7J0pNMOnePb+VpoGPHCsUpMY0Ir1YrPSGt4mdj+4kp4R6IGqIw73UOhapPrYAPj1v9M/j+WM6RtObxuTyAkAN7i56ulUsg5FraeekYYfRHPE4v4VoqzqC3nbXP6G4CUViaeVJmPhVyW0EW7OeTjnOiCx58v52JCu6u12H/HQHF7aLTKqfwNppJMxG5QCAeZTdGailUoiCGFlod17/4j0pUzEHuU+nREDARmMbx2MgSwOuwW1PYlwTnqwQLJ27gjiqtkWL2t1w19m+xA1jgRfPFvEICkheRW7l/lgADgWmBxR/h1PAOrvTNukLlAMUWvoA0duIq0lXFckok0GCqOQqeVkNqRgGFJmxvb+wAsuEl0vKPCEokJLws30n7cJ3GxgeS39H181aqn9XO2EITp9oe2xAjN3l+1jXM0d3MgxD3CjhLeBFI7Xem6izslKRgu/yby8fWsSFKxOHSeM176ZqPMNTm9fus/Y6fpWDFZlQ932Bp+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c2cfcb-0364-487e-b06a-08dc0c60602f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 13:32:05.1991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrGY0Tn0r6QnyHBiqr0/qAZZacit/bd9S1+mjznHjDJf8sUr3jGeg4rPFr51RDfV4mWZtyEMYmRvebu+OvSeRWBia86LwtxJ+/MsR3x1qsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_06,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0
 mlxlogscore=726 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401030111
X-Proofpoint-GUID: sSMwWUNZANjIgM5xa8dHdYkVRN3QK498
X-Proofpoint-ORIG-GUID: sSMwWUNZANjIgM5xa8dHdYkVRN3QK498
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

On 1/3/2024 8:09 AM, Peter Xu wrote:
> Steven,
> 
> The discussions seem to still apply to the latest.  Do you plan to post a
> new version, with everything covered?

Yes, today, thanks - steve


