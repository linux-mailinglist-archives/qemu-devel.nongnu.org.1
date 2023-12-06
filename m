Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0E180765D
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:18:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvVy-0006HP-Pl; Wed, 06 Dec 2023 12:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvVq-00063L-B8
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:16:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvVk-00028e-Mt
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:16:42 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EYoYs014818; Wed, 6 Dec 2023 17:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lAcPUWX5mXNjCTMb/b+pmofH3SLBdGdUqRn6eyL4sZA=;
 b=kUQAb/Zvvb67bGxi79Ja5mZGwVePj06CBTkuwLaLsTxyKhV7b46Q2+bt/kHk0hs7lcyA
 hge6MbpC7f0B77Rs3rjW9vOat0TKivolsxENDIzHopP3fkjLYJBKdd6e5IjpgWdTa/Iq
 TdWz3fKIZfm6Szop2ddTJzGyXGkDQW8k7vhZy/aIrWGE5866l3YmDbJlu9gu4hWmMaJ0
 7cDI8y8RCcB9vwbgN7JTCQM/KbI2n8mFJjxKCZgOVj+xFp69SFxLFC/P4SsCfsRy3yX1
 BxhcNgYPtWuvRV2gp1iER+s53uQGVxfa0bWSfwlpfxd0GYu6rqTxmhdfiOz+zadxjAdB wQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda1xnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:16:35 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6H3A0k037902; Wed, 6 Dec 2023 17:16:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utanc6ymt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:16:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa4uy9NrkdDn6ezvweK+WEb0EuLVsbx9O4vh/ds71lSEC4XeRG9qrjuwBTe9869CGNfMdDDDYA+rBpbYWiahZbKrRWPzzDbexr5OnDJXQmDso5FcQr4RjHGxCJLsTafjcuSykXIvLjbGMBS+JiN5K1aMG1v4QgsNtG+Da8wLm61VmiBKIaOeZjVT2lLBwx+wi4cjxCECHWcmiYz5z0kYB7/CuzRgkWUkQ33EAfp1HyIHr1+/ZNHibumKi2crdv4QMGdg9qzYCrekT52kATxVxP+6rPvazKNLUpn9+hIWdnDij3aGp4Ojfmpo2WnGep5jzx6y1QkOXElPHkifIuzB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAcPUWX5mXNjCTMb/b+pmofH3SLBdGdUqRn6eyL4sZA=;
 b=aD2hK5HfQASSS+ikZvmN/XQ6H1NRVdALcSVM1MDf71R1le8vfVVSgeSwCg7hu5Vhq/Be1KR1FRYnRk9ljs6GiuG1OOZn/FWjWKerq/TWbXfMul8yIDsJplJy7pqAKzDMuuh/3Sd3ra5kj8QGAvErnzAkzV1ECYk6bahed9VEKVbjIbdF5iM9W99mIzDc3ruwZuuj+YFXEspLiUqfrDqkWYP6Jf+BseRCqGSNTp86fpbJPg3TbUYQqaK/APPF1wbK7yHndN+spa2XGV9I0ulbx3aPERUR8dFsOD5CVeNNSjTDOtYJhkvwA3H0QJgwPKQaD6uhEcD5kvXmozmeWkFifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAcPUWX5mXNjCTMb/b+pmofH3SLBdGdUqRn6eyL4sZA=;
 b=y8Di4lVmAw5JJRkzbCDXYpCw5sfGa1X//8ZHop+li9oLxJrjYyfcvlOdszeeAfEsxfAyI7Z7i29dXWVaGX5cGg5lefw2K20IJFLL0cihzkBPQZlKgj5Dy1QBv4xG/HmCnfA4i+V+Tub3QQZAeBBp8yLrO9+c99yfD/gGUjDWzhs=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW4PR10MB5840.namprd10.prod.outlook.com (2603:10b6:303:18b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 17:16:32 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 17:16:32 +0000
Message-ID: <35661417-e759-4333-98ce-33c228aaedeb@oracle.com>
Date: Wed, 6 Dec 2023 12:16:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 00/12] fix migration of suspended runstate
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701882772-356078-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1701882772-356078-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::11) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW4PR10MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 39da34da-6d8b-42d9-eca0-08dbf67f1783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hA1CSHh6HpbAjnchCP3dEKgG1f8t9QzdkI2sAVXapUV2PhWfxyVScHOIBvtXFH2xwq+wYsvQEQV/2sErq0+Rs7VqPh6lOCrdQMqzBTptkNHeyyukFuRs5mMUy6PH9mowwljthkm6BNDTnMviI0gLrtmCCT9NUlM4rhRb4apZlMAYeKghlvzivY+ROzVLO3F5qtAhp0uayaFgLUOfVpBMJO9KJaM9i5vNW6FcdtBsVSio/dI+3iG3lQE5EtbVicLgVrwIb9MIIKU7jKJloPirXQ1AP/gWhavZq7LZGG20cR6G4SbFU9rc6UjC9Wh+DSwC4yxvLdwTyi5vbTqE7P1wGGfQMRwU40RnbzW5yN2UMfsie0NldVUj652K4Dj68raFRsZs9jCqFHo1uE4JnJPbN90K2/1G1RjuBo6lVIwYd4Pgz4H+aeRCvgavF6D374KafkSRrpegZWECLjZUCsWpuT+6kkwAYBCUEtR5Qvaunfw8pr3KBr4uIqUzFC3zPXL8MenYuxRotxFtp+7F7A+mZkre1c2Mmx8784Ofmh9Tm2FHRza35kFprfbXWTSFH5a4kipKMSTBv5qHywvmsBjLhu099GRUjXHk4bOot16T+KNhlBDS/rf4HF98eJN06JQSJhaw+2KnPkGsgK9sSoqWwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(8676002)(6512007)(5660300002)(44832011)(36916002)(6666004)(36756003)(2616005)(6506007)(53546011)(316002)(6916009)(66556008)(66476007)(54906003)(478600001)(6486002)(66946007)(41300700001)(4326008)(2906002)(15650500001)(38100700002)(26005)(31686004)(31696002)(83380400001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEE2aUdnU25DS3k5RTFQTmlqVUtHQW9XK3d1YnE4dGpqVjhRanhQQXFlYlU4?=
 =?utf-8?B?cDY0b3pERjJXTTA0b0hxTG42RXpQVkcrVEQ0TlNIWGVMMWY5YkpNQjdoeGZ6?=
 =?utf-8?B?UUxGQ0crNmRmVmpIdjJPa2FJdVNmVC8wMVdrQ0VqaWdjL1I2OG5ZdnU0cjNu?=
 =?utf-8?B?VzFwdjEvdmthemYrN05YZ25mSzA2TVQwZDgzVXUxTld1Y3dZbE5rMnlmZmNC?=
 =?utf-8?B?aG9GZGdmM2djUHdFd3gzaURyRHZpMkttRVRHVUJXWlovdXFGUEZEUHZvT0dj?=
 =?utf-8?B?OTZ0ZUkxWTF2NHpMdzdodGtLZ2hjRTJOZllxcVMrczEwQml0Tjl2eGtzS2Iy?=
 =?utf-8?B?UUFIVWJmZVB1MHZTaWg5aVI2YXNUNkVKVEtxRCtYYjNtMzhtOEFpbGNJZlUv?=
 =?utf-8?B?Um5PK25nNFh3a0xRb2xXb1NVeXJ0WUZoa1FEcTQxNGJCVUJxUmFHMG9PWXcy?=
 =?utf-8?B?OCtlNzNZTWNoTkljZjUyMGQxa1Jadnk3QkdYTFFjc2pEUm0rQ09rRW1nU1o5?=
 =?utf-8?B?MGhONnZuVjZQUExxNk5pd216MUJhTTlNUDdZd2JCSUhMMHE4bWdEbW1Ibk8w?=
 =?utf-8?B?U3JsQVdnU3d0NnhiaWhDNTZGSHF4ek9KYnNmbktWOGdaSkVFcm40WTY0ZFF6?=
 =?utf-8?B?VmZRbkl3R3JLVkNabEN1OFlBbmRpQ0J1T0xvanNlbS9vYVNGL0F4RUxzNCt0?=
 =?utf-8?B?MHBrcldKaHVtaDFBSHdjbU9CMWd5b1k3K0xHMFc5Nm01TVFrWWd0TGljK0Za?=
 =?utf-8?B?YndINW8vcnFySnFFWW1MY3ZWZjI0UEJ5djVtY3JpSnh3VFM1VWphMWJCT0Zj?=
 =?utf-8?B?OUk3ZTQ3K3NuUnIxTjRLSndnZTdBSTRrbURqWktHd1pkWEFFVXlvYWpmcVlL?=
 =?utf-8?B?L2RPTTU4MTU2djU4RndYKzM4WG5jNTBaLzlSVlVLRTZyS1JSM1g3ejVlVG1N?=
 =?utf-8?B?YytaQXYrOUFsR3dpZy9ERi82a0tPNlN0VEszb2RPK2VMOVFLMm9hR3NmZGdP?=
 =?utf-8?B?MkwwZk10eks0aXZ5Y081OHV1MHhweEhqTk5qY1hJQ1Jyb0RQRzVlU3c2NGZ0?=
 =?utf-8?B?anUzTzdtV3Z2Y3VhRUVVU2dYbWJMb3Bad21FWndEZWdtR1BLcmtWYVQxeWQ2?=
 =?utf-8?B?eERacFUzOG9IUHZrTk9BVjZWTmd3SzNCWDJUV3IyVXgwZDFRWVpPbnVLZFNV?=
 =?utf-8?B?THhTMHdFa0crMkRtQkFOc1I1dlkrRVhYTWovR24xRkpxZllOZW9velVmMUpk?=
 =?utf-8?B?Wmg2ZmdqdDg2SUFVa0sxUTlEVWg2VVhQd0F3TnZPcExTdkRmbW5PRDFQbm5S?=
 =?utf-8?B?aC9STFVyendJMllUUUtEdHFVT2dnTE0xYXVnSTB3ZmZQcUlFNGRZYlpOVC9L?=
 =?utf-8?B?SThWTG9UelkrR01sbTJ3Z21FM3UxZ3ZNTGtUSmsrRFRRbk9iQzAweldVVGxx?=
 =?utf-8?B?Q3hzZkJIMEZsRk5kSE12QVAwbkx0ejNCU2xRaHh3Q0dPMHNSeERTRXJZQnd6?=
 =?utf-8?B?SnhEblExZlhwSGNYbk53SmcvV0lxRmZUV2t0SXgyblRXbGlzNkJwTXBscWlt?=
 =?utf-8?B?RHRBdEVnd25QOHJjcUxEcTM4WSsxdklmWHNLclBUZjdUTWczSFE2eUc3Rm1t?=
 =?utf-8?B?dlJGSy9KNm5xK3NCaFVEeWZnd0pRWWdRRXNXSmhES2NyVnd2N3FseDVOeDNn?=
 =?utf-8?B?c2IrT2VlbE45RktGRUdSMWpCSnk4blJSTDBuYmU1M3ZxZS9hekJlVDR6SGJV?=
 =?utf-8?B?czljekpTRFRYSlR4cHg4TVp3a3YzTE5zQUlzbVU3V0Q4ZzB0Y1F1dDM4WW92?=
 =?utf-8?B?S0pBU2FscGpwM3FiS2R1ZFZBR0hwMFJrWmNEQ2xqbGlKS0hMYktveHZPMmVw?=
 =?utf-8?B?SmJNTGJoekdUamtQSGZqbk9VK2cwd3pSb3k4bkpDMHhaSWJoOUpiQ0VwdUNY?=
 =?utf-8?B?MkVwOGVuMDdSSU8rWEQrMGxsUW96Q1VJUlFqb3VERGlDNzVvNzdBczA1dEQr?=
 =?utf-8?B?UWluVytBWU5mMGd6dmZoNm9CbFF4SnN5NkxpT0FXMmZraFZPN3ZBUHdnWWty?=
 =?utf-8?B?STlkYkEwY1p2QVlvb1FWcDR2YWtBNW1iRm9Ib2lCTE1QeElyUHdjdWU0L3d2?=
 =?utf-8?B?b0U2allVU1duZzJ2aDJzWnpTVG9KMXpDVUxuaFZUSFJOK2RVdkRrRklVUmRS?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PFfACBTS/q1VYKwXUY6Y9mW0ddvahLSj0IP8w/0t0gwaGMy3cOfA4RJ+rN8N+iGzkant0Dst+jwrEcpommG7JI8TKT/78dvhsLVNBTwc4bROXNr3i64+xOmgrJ7AYiCJ4RdCku1Nj+g/jiQPL8afHtFI03fVLQkTekjs7nwIxWe3W4LehgPa+mFyHuCAkb/4AESceWQl2hi2u12EXOWVEwN5NA6Pr6+oyg1f4ewVw7B/MscKJ5H0bQTLrk2w9w+HvbBlDBs++v+kj+jraCD6KB4W1cmnh18/Wo8UDdo02AHMTGUcal+HENxh46tB1vnU5NlGJ2R7gfIBaJzBKT1YWh6XQJIiIgbKNjhzeTIXw/iVSPecfvtCpWaRSa7yInL6RDTXfPwiQQvJoChjNIBn6mtzi6zjX/N2SkpmsJTl9xllBDwdW6j4OU31Rk4+N5F2tgpo+DUbSuFCCV5wE42x+PfdSy10MF4KYxtp9WA+i/b4FkWX+amjnc7GfgYhepH8ym4hMWGVBnnn41+i99AMQSJJ1AGNh2H5GkvCLn47QBAtP6A2rtuQKAqdN8hB2giCDehLlOTwiOMy32lwFylkPQshRNWVSjsJ6g1S3R3uDk1yLqs/JQ3m8iykqnOKrt2m+lX5mUx8AZLcCHXY0EIhUsOWhT0BEILz+E1s6Hn88oda9y9AFKpLRQsVMplquqDSrvV+ZsUCjNEVagNmI8xUbYud4jb0npNi6XqayBgi5ReiSqte1nSKg19CJvWwF7UfgQsa5duKWfUyXgGm3Al/HNedrFbVeaXnByzAzzhiSq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39da34da-6d8b-42d9-eca0-08dbf67f1783
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:16:31.9943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOxX7RTXfgfD4+VCf/H+gMuTx/1jskzQxy8pMWVAh/sFVDDadxKD/49JSGfn/nP8Dlg6MABqD30XOR3OVIlS5MOwkPCf1YuZ3TWB8jWoBBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060140
X-Proofpoint-GUID: VeWzUu_JHDM7vXabBTI-BpfLeZ6STu3n
X-Proofpoint-ORIG-GUID: VeWzUu_JHDM7vXabBTI-BpfLeZ6STu3n
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

Gack, there was cruft in my send mail directory.  Please ignore this threaded series,
and I will resend.  Sorry for the noise.

- Steve

On 12/6/2023 12:12 PM, Steve Sistare wrote:
> Migration of a guest in the suspended runstate is broken.  The incoming
> migration code automatically tries to wake the guest, which is wrong;
> the guest should end migration in the same runstate it started.  Further,
> after saving a snapshot in the suspended state and loading it, the vm_start
> fails.  The runstate is RUNNING, but the guest is not.
> 
> See the commit messages for the details.
> 
> Changes in V2:
>   * simplify "start on wakeup request"
>   * fix postcopy, snapshot, and background migration
>   * refactor fixes for each type of migration
>   * explicitly handled suspended events and runstate in tests
>   * add test for postcopy and background migration
> 
> Changes in V3:
>   * rebase to tip
>   * fix hang in new function migrate_wait_for_dirty_mem
> 
> Changes in V4:
>   * rebase to tip
>   * add patch for vm_prepare_start (thanks Peter)
>   * add patch to preserve cpu ticks
> 
> Changes in V5:
>   * rebase to tip
>   * added patches to completely stop vm in suspended state:
>       cpus: refactor vm_stop
>       cpus: stop vm in suspended state
>   * added patch to partially resume vm in suspended state:
>       cpus: start vm in suspended state
>   * modified "preserve suspended ..." patches to use the above.
>   * deleted patch "preserve cpu ticks if suspended".  stop ticks in
>     vm_stop_force_state instead.
>   * deleted patch "add runstate function".  defined new helper function
>     migrate_new_runstate in "preserve suspended runstate"
>   * Added some RB's, but removed other RB's because the patches changed.
> 
> Changes in V6:
>   * all vm_stop calls completely stop the suspended state
>   * refactored and updated the "cpus" patches
>   * simplified the "preserve suspended" patches
>   * added patch "bootfile per vm"
> 
> Changes in V7:
>   * rebase to tip, add RB-s
>   * fix backwards compatibility for global_state.vm_was_suspended
>   * delete vm_prepare_start state argument, and rename patch
>     "pass runstate to vm_prepare_start" to
>     "check running not RUN_STATE_RUNNING"
>   * drop patches:
>       tests/qtest: bootfile per vm
>       tests/qtest: background migration with suspend
>   * rename runstate_is_started to runstate_is_live
>   * move wait_for_suspend in tests
> 
> Steve Sistare (12):
>   cpus: vm_was_suspended
>   cpus: stop vm in suspended runstate
>   cpus: check running not RUN_STATE_RUNNING
>   cpus: vm_resume
>   migration: propagate suspended runstate
>   migration: preserve suspended runstate
>   migration: preserve suspended for snapshot
>   migration: preserve suspended for bg_migration
>   tests/qtest: migration events
>   tests/qtest: option to suspend during migration
>   tests/qtest: precopy migration with suspend
>   tests/qtest: postcopy migration with suspend
> 
>  backends/tpm/tpm_emulator.c          |   2 +-
>  hw/usb/hcd-ehci.c                    |   2 +-
>  hw/usb/redirect.c                    |   2 +-
>  hw/xen/xen-hvm-common.c              |   2 +-
>  include/migration/snapshot.h         |   7 ++
>  include/sysemu/runstate.h            |  16 ++++
>  migration/global_state.c             |  35 ++++++-
>  migration/migration-hmp-cmds.c       |   8 +-
>  migration/migration.c                |  15 +--
>  migration/savevm.c                   |  23 +++--
>  qapi/misc.json                       |  10 +-
>  system/cpus.c                        |  47 +++++++--
>  system/runstate.c                    |   9 ++
>  system/vl.c                          |   2 +
>  tests/migration/i386/Makefile        |   5 +-
>  tests/migration/i386/a-b-bootblock.S |  50 +++++++++-
>  tests/migration/i386/a-b-bootblock.h |  26 +++--
>  tests/qtest/migration-helpers.c      |  27 ++----
>  tests/qtest/migration-helpers.h      |  11 ++-
>  tests/qtest/migration-test.c         | 181 +++++++++++++++++++++++++----------
>  20 files changed, 354 insertions(+), 126 deletions(-)
> 

