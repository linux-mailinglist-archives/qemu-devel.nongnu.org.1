Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4377ECD1C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 20:34:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ld7-000543-Qn; Wed, 15 Nov 2023 14:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3Ld5-00053u-37
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 14:32:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3Ld0-0006nM-PR
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 14:32:50 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFI9FOI018616; Wed, 15 Nov 2023 19:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+hMv9wxIjas1ju7fE72+CWTOO4iTrlLEZ4U0pzcZRn8=;
 b=kfrt8BSTdg4gXQO8t3bV0vgCZhF76dTJWEgmqKMhvjUZ7b+nI1c1rzgl8WuowJVe5008
 XCsIOHZbKgQrjM0BAKTmRrJvLO47j95JBvODmQ7EzL65iJu7RtDOO04JdDHy1Gxx0u8A
 h5/UZkVBamRNIPOZX3wJWMkI6g7DUI6oLAyZ5OQLafOv06bvB1s8QRUV0J3WFfOgXJ6E
 LDeA2Xva/4t3UjqyZypMVqn+hm8gfoI+CAXjS2D4BZNW8xF1FUwreiVNEv9f/tcP2Qqh
 T2v980UHtBmVDlzN/6ZmWCHyfLfwaQRkWsGWjsklwUbVd6WaJ8tIS6vq6uOQtzGuflEg og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjsf1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 19:32:37 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AFJRWGH006827; Wed, 15 Nov 2023 19:32:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxh3n97g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 19:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJk62+bMFTvX2OsrmT75wdBDRIbrZh1PTEYp2Gq3QtG2Er7VQtNT0exZYQhH3UDzyYcKUM4mETQmMuvZu7/uBG3GAkYWv2BgKjYtETyT+GZEWM5uP9xxaw80oq3T6AI6T1D/zCrl2+Icr+qyanegueyvLMDS18XguBt17KRD0AWW0XqNBVaU5oRFsex0SoNSxk2K4TC/QpnlmEgmRHXL1pcL+wEJIIphT37nn3ubCiwrkggLHogtmviguCqf/dp/Bb3x2CKugZ9BNvu1EUoRdDQLAuXvt/ioHH/S7H3We7r25cE2KRK3VGskMhbbmW27lKNe3sVdC/HkznoKTzh8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hMv9wxIjas1ju7fE72+CWTOO4iTrlLEZ4U0pzcZRn8=;
 b=A201I7qa53pVKBxiJMgouq40W6Tgv2e31aq+NfDxtbRaVAo882gcNQNcrkllIhNIqrkPOKG+BFElDeVgjmWg+aggqQk0KllDNqqth+cS0EDSEKKk4wiFUqlOUOV0SiusNetZeQHDrbdR/AJVYQlC7RdAvTR8nhUn+OQyCkCW0LBZNpjbcx9UE9trc/DJbUHCttVMkX53hbLozGyYZbQtIYDsgnv9bmCDeK/jxYBHvrNZ8Uihkt2MbBhQKgJT2WJPgi11X+pa7jtd/1sjysS6iJQrsW+NG+XHd8r3d3tff+B4BVgugZh9CwK4kyN0wI2hQxJD8HqPb0wDD6DFY65X8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hMv9wxIjas1ju7fE72+CWTOO4iTrlLEZ4U0pzcZRn8=;
 b=uWYbS1mwQZAIFGt2smkL/ROf975FbQkuW/K2EP83iIKuUyNN/RHqB1UMUQjdohXAUPEGPDrUqgzUbH+IRb0OQtpwpQDVyguj9Degva4QVcaEr9svcy+lp05uStv+NQZ8z2kjq3I9/L43NEWsi4TaB7Y0OMTfPmkxcnJpo/hvCyw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BN0PR10MB4823.namprd10.prod.outlook.com (2603:10b6:408:12d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:32:34 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 19:32:34 +0000
Message-ID: <09d6eaf3-be63-4f78-baef-310070b07da4@oracle.com>
Date: Wed, 15 Nov 2023 14:32:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/40] tests/qtest: migration: add reboot mode test
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20231102114054.44360-1-quintela@redhat.com>
 <20231102114054.44360-26-quintela@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231102114054.44360-26-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BN0PR10MB4823:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b2fe7c-b015-4d49-6799-08dbe6119dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJ/K0mSRwQmZ/dxA1N6+HKO5iov0/Os4uavhR+6wjxr+vbQDWWYPyNFmr3nP82tjeHa3gK7juFRXNB3FZzvJIQbQsNgx53RwJl0mrkabaKUI3ZHJ7ge366zkZZPFk/UIxgMpai5nwHsAEgeplEpHWKDK0BsZWaYw6y7rhfU56EeVnyXnSgwOhB9qwoOHOBuhuu4I2IL6ZQUVvUYE90ZiBq7L/g8xeb33NHwyrzLCX1nmye8k82K2RmC9AkJ4NhYBymE0nrvkJyNE3DopNwOsicl6XmGnp8hR8GnKvGyX8Px5bMxhoKNXc0iyJAi+yU+gCw29wdyeOtTtTnM2yqLy6jMQLNTGC/9SzmRb/W22PyYcS93LLLuboQW/vf8OA9KNJtVGQ3GSG+QCur3GGO2dNioQwXi6OoA3HX6gW5993ubzTikoisJ8ViFDVSDj0w5oXUauZpG5aIM+rjX4Jy+3GMYwoC8vscgsm1OhpjCArHBGfKiOsUGLFqQB+syXLs7dNud5luLmtTBUCm20b/E0XnFaf188Xne5EpHtriybCmqrZBwqHo70SuT0tpyCfvDB8Tv84h2x2CQ9nismtmjv+Lz6d96V+CIjomBtkevwKHnktFDYnzkhH0Zgc8y9JVy/n6cOkbLyPdzd/rJQSVwcGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2616005)(83380400001)(38100700002)(26005)(6512007)(478600001)(6486002)(6506007)(31696002)(53546011)(36916002)(86362001)(31686004)(6666004)(316002)(110136005)(66556008)(66476007)(66946007)(8676002)(8936002)(44832011)(5660300002)(41300700001)(36756003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ErYVVQUndHRVFjNHZ2MHlja0FQSVhkZkFlS09scnVoVmdCVGZoWGZUQ1dC?=
 =?utf-8?B?UVlVSlNsVHFSalRoeW8ya0hvblNZWXVjekxVamI1RTNZc29uUG5ubytGanRH?=
 =?utf-8?B?YTNIZVJFUlQ4cmZhK3BkWkI3cWZSVEo5K2orMCtyckwzWUlHTlBtc2pGSVAx?=
 =?utf-8?B?eFN2Mzc1SkJqRHVwSCtQdk5DSC9zWkNmQTM2aytmaDkwdjBUUjhqNWFGdkZx?=
 =?utf-8?B?RmJIUkZGYmtsSEU4azkreldsaUM5T1N3aTJFWk1Dc0o4TEYxZHVGYmNEZnZK?=
 =?utf-8?B?eWU5MkhFbVo2L0RjZUsrNkI4NjU5ZW9vYXc1cWN5T1V2WitBTEdqWmtIalJP?=
 =?utf-8?B?cFJqNkVEKzNmZmN4WHY1RE5Oa0JZaDRHdUswWTBua09oUWJoQ3d1cXlZQjNY?=
 =?utf-8?B?b0crbmtxeDlZd21tcWhuZTk2UEFUSFNEM2V6UnoxdDdLZmJRcWxCMHdTSTJI?=
 =?utf-8?B?MlROSWJ6NVJqUHIzSjJBL1FvT0pVditZVmEySm5OdzVyUjNRWEVuRVQ3ak5J?=
 =?utf-8?B?ZlBjMGd5bHp2U2NXTnRYTnRiTmNMOVhlUm5maUk3cVUvcEkwZ1VNekIrUWQ1?=
 =?utf-8?B?UlIrdHVNaS9sbEFtZGpQV2Z6RXY4aU1tNklpYUx2K3Fvak5HUjRYVVp3WjZn?=
 =?utf-8?B?NDdPTm4vYVB3bUNFclZsdjcwaDZrZklYYUdHZ0FrM1BjNHNqQmNGSnJOUmU4?=
 =?utf-8?B?dVFnbFZLUUlta2NxaDdsKzZodTJ6TTF2emxuRjF1MUtiQ1gvV1lIbmNER2FU?=
 =?utf-8?B?dDRyUHUxcXlRL3dXeW1oOFpxZG1NclN0UWI1ZkRRRzk0bTQ0ZnpvRUJ1TTYw?=
 =?utf-8?B?ajYxK2FOdEMzUWVmd3ZkRlJKT2VlWHVEYTRsYStJSC9TMGJVeEhIaWY2SEVT?=
 =?utf-8?B?U3Y2Y2YwcUFReC9rNjBIQ1FIZXp3cSthNzlvRmx5Wm00M1d5S2w2c0ZJWGRR?=
 =?utf-8?B?Y052bUhZU3MxTzJCb29qNm9STTdnSW5FdVBMSmJldmlZdzRQejF0TzNnbUlr?=
 =?utf-8?B?bWVYMnF4V2ZDZFVWZ1RUTWZLRExlbk5NZDBlc0QrdWJVOEZPb09hNXVIejFz?=
 =?utf-8?B?blFNdDA4RnBXRHhmWE9xVjkzMDc3dFhIdUM5MkdVa0FJdmdiLzJ2bjVyWWc4?=
 =?utf-8?B?Nk9COVVRbFRlNXBMbC9XOW1WcE4zczlzOEhzTUgwOWE5Y1FvUWVyMnc3NHda?=
 =?utf-8?B?MlNxc1FOcHlxMDlRaFVBRzBvTXVmZzNDcHZySnM2NGdrQTI3dVM3M2gvR2tx?=
 =?utf-8?B?Y0FybVpKcGV6TXUrU2p3UGtpREkzSkdTNHA1Um9ESVdJSWZRSlZvYkdDY0VL?=
 =?utf-8?B?emZIYXJEQmtPbnJJV0hMeGc3bnY2OWF2TGhhUmI2ZzRxc1RyeWZSNkM4RU5m?=
 =?utf-8?B?a0UvQTlXdWJjL256SjI5UDZuTFIvbkFYUWJpSzFQMEFBa09hU2Z4NVU3QmlR?=
 =?utf-8?B?ZHRGamJXRDI5N2hwcVFaSWM3cmt0M1kxMk1KK2pVOGQ3RnkreEVOclljbk1O?=
 =?utf-8?B?dHkyN2JGQnBRMytXU0tla0dTVXlqYXRpc0luV09PclVaMDVRTStGMkVjRjdO?=
 =?utf-8?B?NDMwSi92TmJNZS9nQVpLNW9jSjhaNzBoZTNobURhbUNScGI2aU5YRXEyWVpZ?=
 =?utf-8?B?ZzBpVmRSWmYzOHdmZngxQmhxd01vM1lwWWlBN0l1UDR4UFN6MCtKcUIwVXls?=
 =?utf-8?B?VExoN0xMdjVIYkJNVWdtVE1JUzJjVDhhbW11emNLd2JucnhDM21GS1lSaGl6?=
 =?utf-8?B?aEtqWlBKWEZqbnlkMTBJYXRIdzZpMzEzLzJlOG1GMEoyeDQrNFpqTThXNEZa?=
 =?utf-8?B?SHB0WWR6dHdmK1ZtQVExUy9lRVdPSzNpL2dUeUpxbTRydFNTUzRESkRIMUhy?=
 =?utf-8?B?aS9xbkxBbGZ6bi9iNWtZZGRocGdYOFV1eVNtcW5kTnplSWk2YjRlVWZGUVQy?=
 =?utf-8?B?NjFDeXR5MG5mL2JQdktpcW03UEdCZitWSGJ6bCtGTnFPbVdoanJIeG5QTTlN?=
 =?utf-8?B?NTBGNVlZNmQ5MjE5RVZvZjBhaTFicVIzU0xDZGVJRnQyNk9FSGVTL29HTWIx?=
 =?utf-8?B?VlpKRy96Y241R3NPQzR3RTNyc25QNEd6TGNEL25IR2FlWDEyWTlDbzJ6TUV0?=
 =?utf-8?B?eFFoZDZ3L2MwUnR1bzdzV2FXMmhIRG0xYllQNlZkT3pKR3E5L2p2djB6MHd3?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uR51uUXRh0taVlFZR/oP4upLmAAtCW43/tj17Pajt5tZ11i9Dpls0szcfRwdBnPreL8o6ouENvOlZg9z6QLEdefY7O5/qR6Aq/RtpOmLNQ4OePARPF0Ob0XAgGft4yMqb6qV7xbH2uV6EKLG3FoWeThC0gyWVN5Dzy7BbxTBHdFirsDi9dO5Lo23nNUMiMo6NTsNkqIm8HaFRFVlwo+Vds8psKioOjIHUIiDc8hypMrls9RjkpOaGrlGK7e7gCaTTd+xGLulo5PIX1rhrpzNmP4tuK3nvBFSrT7sNNVkU4ntf+lEBa9Mue1VhdDl6DauOCprpHXJLt1LtQfYIen2sFYerC14OAVg0nCjjrw0JXHdCwJrH5Z6vg7H7nq7IrRIMvrAABLrCA9L85gqa5shq+BsqH5T0UM8cKB5PaJ+EKwtHrWilPKhGcV4JIGXbAROR4meNTV3T7YshL49Wu1fmfRO01F3PxkiiNoY0w3l/eKLX5I2aWW4Y6N08YbhPNyH0MG+uInNfGEXQ5hD63EXItWmKBXpzRzl6Lat3TMYo+pCGkPmsUocG/qmoLLXCb/k/8Ws6yBoue8iIbDM90hJ0F+QxxZlx2aZo+3jRyvJEezJ/KZJ8EQWsInlcycCfNxo/1WGJOJ/gRLnocLkYI0pnHFxp8VohkE1zF6vKRqQjOPYuwB5pdsvKiQLSTICEEASht1dZJIKXe4OrDqbXfkuqY0wfBZHU8aZ2C9bBeTZxWqU12mPmTbUxrKbbNFtw6JLcv9pMZGrgLETgKZ5ROj2X791P8pKmxTZtAj0OJyw6ik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b2fe7c-b015-4d49-6799-08dbe6119dee
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:32:34.3660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgJrcEHB0VgQHGGr59vYxYVD0kXK9Xh+E25csDBbfefRZS/AGTpOijlzUgIgO5qLUYWSZav8AEiaObFuqB73O2ukOiPOj7dU2y0agvv1AyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_19,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150154
X-Proofpoint-GUID: DQy7TMMdF-qYLeZqLHdRJ6kUBdGpbrm5
X-Proofpoint-ORIG-GUID: DQy7TMMdF-qYLeZqLHdRJ6kUBdGpbrm5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/2/2023 7:40 AM, Juan Quintela wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> [ Maintainer note:
> 
> I put the test as flaky because our CI has problems with shared
> memory.  We will remove the flaky bits as soon as we get a solution.
> ]

How about disabling the test for CI instead (which Fabiano suggested):

    if (!getenv("GITLAB_CI")) {
        qtest_add_func("/migration/mode/reboot", test_mode_reboot);

That immediately buys more coverage.  A fix for CI requires more thought.
If you agree, I will submit a match.

- Steve

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-ID: <1698263069-406971-7-git-send-email-steven.sistare@oracle.com>
> ---
>  tests/qtest/migration-test.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index bc70a14642..b7ebc23903 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2026,6 +2026,31 @@ static void test_precopy_file_offset_bad(void)
>      test_file_common(&args, false);
>  }
>  
> +static void *test_mode_reboot_start(QTestState *from, QTestState *to)
> +{
> +    migrate_set_parameter_str(from, "mode", "cpr-reboot");
> +    migrate_set_parameter_str(to, "mode", "cpr-reboot");
> +
> +    migrate_set_capability(from, "x-ignore-shared", true);
> +    migrate_set_capability(to, "x-ignore-shared", true);
> +
> +    return NULL;
> +}
> +
> +static void test_mode_reboot(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    MigrateCommon args = {
> +        .start.use_shmem = true,
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .start_hook = test_mode_reboot_start
> +    };
> +
> +    test_file_common(&args, true);
> +}
> +
>  static void test_precopy_tcp_plain(void)
>  {
>      MigrateCommon args = {
> @@ -3096,6 +3121,14 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/precopy/file/offset/bad",
>                     test_precopy_file_offset_bad);
>  
> +    /*
> +     * Our CI system has problems with shared memory.
> +     * Don't run this test until we find a workaround.
> +     */
> +    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> +        qtest_add_func("/migration/mode/reboot", test_mode_reboot);
> +    }
> +
>  #ifdef CONFIG_GNUTLS
>      qtest_add_func("/migration/precopy/unix/tls/psk",
>                     test_precopy_unix_tls_psk);

