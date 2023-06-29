Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 744DF7424EE
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEplQ-0006xn-4W; Thu, 29 Jun 2023 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEplO-0006xK-0d
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:24:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEplL-0008PS-QH
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:24:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TAoUAw023508; Thu, 29 Jun 2023 11:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=h/hfcee7Gg54nW7xld/C91P5S9gV06Jemhabu6WL2kw=;
 b=xTARJ4P4RI6IfGodShraiqm1a4xdN/oG4I62VarGmKa1xck1Tg++WDNgu/lSsfDTrdFH
 nkjkzPOwAH/1DhUa04Lst+fWZ4OrdsGrEhAehOkcJ5G/Y6MWEf3kOtbAl9HFw6hzRuv9
 SMHRBUdgZOLNUhIy3gwEisoe3VM64W3+yWwVwWkfceE4z54xt9k2tZ7c0oQxqPwObmUh
 V18HBEAJVdeZp1WZu0/ysk546Ng1tVzYvVvj2ZbIfsNRxY5hN7W+i85tYIXKUsEmnqPe
 y2tE962adX5b/Mdu4n89oStEsYQtioBnWnaU7yAHATf4KzW368/+nKf0pA1Ti0exR4QW 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdkpaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 11:24:30 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TAxgYS029658; Thu, 29 Jun 2023 11:24:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx78vha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 11:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbFaLE3jZMH47OC9b6tiIhYN+U1C0Jj1IMquMYkasJ2usTa0jmP0QIpsM6Q/DC0Z/LlQvqoIiUEkRL8TZlWLi1bsVY0lmli02EPOG2ywtEv4VL+mff5lIKeSNtHtiXpnN5kALRFeCoT5Kw7jg6DQrKUeD8sqCD3QlNEWwA7Ij73bMuOYDqZIingoG63Tupw7kSkairdBMAtrXNZxNU6HH2BMXDho2O2HpPrnp9+TI9Wvp95eRYA5iOtT0Ozhs2XbJF9xSH3BjOCYPr0RP1n4zkP1mypvCB9s7uBBEznWs+wP25XWNe0/yuJiBzIaufpUzDHfpGCykH51UXTj98LtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/hfcee7Gg54nW7xld/C91P5S9gV06Jemhabu6WL2kw=;
 b=bRypM1UtlT7WIDj7btQPyPm1N2Ky18Cik2eipSUqOCgUp9WW1w2cpKCEjbaFswqAjOcbdkaleaNIEpHGcKKdilCSQxkEtKsTwpYaUNPrpCP/cZNEz6x6LLqHjbvGisvwx9VPIHssopFAKopBoV3Ql5Vx9acphIcbwYEQH30NgVf3GpI4+QwbRSu77f5wKP8n8Ts7w+ls5RCuJOtiwZ0FbmnLdE6vAKlxcm0cZYy5Wy85yQQRvMxHaYJbURIQ5w+eNo0TWJ14s8V9qSxLbkLzqoHMM5/b/245Wd9T/JC5MyKevGP4xa5qVmC+vM6JDu6iLIDfWGHMXvinUHp1qOHxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/hfcee7Gg54nW7xld/C91P5S9gV06Jemhabu6WL2kw=;
 b=o+QJP45YZaroc98XC2JTsh/3PZuw2nMyunmL6Z6+rh5XXND3dM0h5MDljD5L8kiE+1qddiG44lQ2AL9i/pU6WXRKoxwyoEeMa1HaHEs8lCWn8DVxNvg+Ly2MNgHWMPXid28iscoGnvjMNVvQ6t4OWNpWgitbnwmMZCUYoKLNz4Q=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 11:24:27 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 11:24:27 +0000
Message-ID: <29b6ecd3-d0a1-c914-9bba-cb99d95acd8d@oracle.com>
Date: Thu, 29 Jun 2023 12:24:21 +0100
Subject: Re: [PATCH v4 3/5] vfio/pci: Disable INTx in vfio_realize error path
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-4-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230629084042.86502-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:208:1::45) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b5f5f6-b7c7-449c-11ff-08db7893662a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbqPz0zwVtQM+AIpauz8Z5bKTgwBAsu258FqNYeH4eduLfmOG8sWUr+9phUBpSHN40OqthAPZx8opBuU+0sJCMpCNBoWn8oUtJJpK1djgfYszIktSHQqPtpja7NyhnllEkMNt4JCh9J7GDgmUB1N4hVhmYDhFnM1bd7I+sALl02V9QPBrgKs2esHxln8MdUf20JIzGs35zb+03SZPdDEa8IHzZmBMjwqa4GvLwxK4VScP1TRXKC40wbIs2oLBDc2kNUSkO5HhYVESWjXF4ywPlgOxWYMBaWHUniVX14Txxh0FEB5274+W78nV3eGByDJ6ChHF1BpkhLyIqZujmMLtImqjuoG37xFywNeuU/yGTIxd0Cph3s9APJEjK1mzq+mCx+bDhUsbJJj0rRqi3Enwb5Iuyh7mkigEqVBqGuP3CVDdIKSrLd7ambPK9GE6KXGAFT6OPQ4pkSFCBHDZ607jQtZBepn6V7BvHVu4WMxDJ2E7CXbpnQiZ0E2O5YI2JnvAeDo+4+k+rIGflVY2IYYQ3CoYUOOIAJP4EtdHhkxLAFHCP//YsKeZudRC4Z9vwEM+UJZr6AG82mFAb9LKPe2ZAFvgSZe0SWFT/8eTy/y0loPYG0pV+buxxKvUWFuZiA+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(6512007)(6666004)(2906002)(186003)(6486002)(83380400001)(38100700002)(2616005)(6506007)(53546011)(26005)(86362001)(41300700001)(31696002)(478600001)(316002)(36756003)(66556008)(4326008)(31686004)(66946007)(66476007)(5660300002)(8676002)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVlwYWdPNEd2T0hTdC9QUXplRk5obFdqank0REMyTWdhSW9qZ1UxYzBFRnNw?=
 =?utf-8?B?UDd1dUlkYTZPMGRvNW9NQlo1UkhvSmRPK3orSVpXdDFDNU96RlNPU1pQanpX?=
 =?utf-8?B?R295c3NYTlhyNHVvMUE3dDVHVjFScmFad0VodGJCbDUzQmRLTHBTQ3JETU0v?=
 =?utf-8?B?ZDYwWHozS09GWk8zQXYvb2lTTHdKbTNyejRGWmtGWmVWaGZrWGVuSENDNzZH?=
 =?utf-8?B?azVFbFVjNngyam1GQ0grY3dUdllTSzFKYXBycjVoRFJEZWhOTkgvajJ1bEJi?=
 =?utf-8?B?YTh2TTR1aUdvNFY0VGJEVzZnTlVlR2NJSm5CRURoNFFXcHVlWWd1OXcrdGNs?=
 =?utf-8?B?T2dITW5xOWJaczBrVnRKVWp1c2h2TUtrTW1VaGtPTTNnK1UrSXh0MFJxcXBD?=
 =?utf-8?B?Ylp5MFNBdFVGQXRmYnBwT3RTYzRDMTM3enZROCt2dmx1eVN4SWVtVmt2NGRR?=
 =?utf-8?B?cm1iRmJlVGZTdHRTQVRpWmxpRkJ2ZGpHdWNvUzJKTUp4SFFXZjY4UXBSQlIv?=
 =?utf-8?B?QW40VVd4bHBDbjNHZUVxaTNyS00rcllac2RpbmVpeDdPdHRTRzQ3V3FKUjc5?=
 =?utf-8?B?cVNKU3puR2hUQUQrY3VjMzk5UVhrTnFiUXB5OXdyYXNZYWRseDJwSTFhdWNJ?=
 =?utf-8?B?Q0w4K29CTjFWeFlwVmphVGRSK2o5cjROam5TWWVUTUJnY0hoeWpaUHR1d1pq?=
 =?utf-8?B?YTdQbXJaZVRBOFcwRGlpSlBYSEYvVlYxL2FNaXkrSWhpc0tZNTZ1RWpESnN0?=
 =?utf-8?B?TVVuRlpWdVRSd1RseVMzQ0cyZy9acXgzYWY1SmNKSnhib2V1dTlyTmdod2ND?=
 =?utf-8?B?V3BSNTlOOVpTdi8yM2pkOFJpQkZKbmFTR3BFZVUxWXZpZnZCZ1orclYrUE9H?=
 =?utf-8?B?Z3FmakpPczg3L3luTVpiTkszM280anVCZzVYQ3h2WE5LbTVQZThPQmJBaDBN?=
 =?utf-8?B?T1RVandRUEVrSjQzVHpRcjI4cGZXK0NBaVVtWDJOdmppQUpCc0Y3N21HMkJn?=
 =?utf-8?B?TFNaLzhpcTNUNjZ3N0ovMHIwcDBwcGVEc3hUbmpnOENoTDUxK2NPUGE4Y3N3?=
 =?utf-8?B?MTEyeVpHZXUyRGh4MmZlbFI5ald4eVdMVzVDNUZkbFp4T240WjVRWkdWazVU?=
 =?utf-8?B?VU95S1g2RUl3QS9yV21uc1JaVXM2c21iYW5GNHJKUFN6dHZHektPWUdWYmRU?=
 =?utf-8?B?cjAxZEZZZEU1WCsrMUVUdkhvQU5aV0FZcHZDQnRoTXdhb1EzelIySGRBNGNz?=
 =?utf-8?B?aTI0RmI4RHVCMlJFUXdxMk43eVc5Y0hxcjlZVUZnYjdNYXlPT0JwQy80TlFv?=
 =?utf-8?B?bVhzREpuTkJFbE82czExT29sL3lzbVJIMGZ1d09rSWMxeVhMOHY2emN3Vzlk?=
 =?utf-8?B?N2FCWWVWRVpVUmNxWHpnM2JacjBpOW5jN2hZTlZKUldLNFhVbGRWWU5OVURv?=
 =?utf-8?B?Smgwb3VxbEd6Z3RqUXlrVEg5M050bmY0OWd1L2NyMWlIdGFOOUc4VUxxUWF6?=
 =?utf-8?B?c01jY3I1dTJWYmZsZ3V0OStRMk94WmFKR3NxdDhhY1dqTjM4bUdBMWVnRGt4?=
 =?utf-8?B?dFM5aEVodU9uMzR3L2JmNFVaV3VrQ3hQWHJOSTZLdUNCdGltYjl1UDA3YnFa?=
 =?utf-8?B?WVVjeTZGS21iWjFJRGZWbGxKMXlJd3owZUpsNE1GT3pMVDk4YkF5TnFXYnFN?=
 =?utf-8?B?dFZXME9INjJYNTFyMWNrRUNXK2FUWWwyYjdUaGhkdy9wV3IrYnNLVkczYkdE?=
 =?utf-8?B?bG9OOFdIdExFMFd2eVNEdmk2eWlIMjdKRkFsUmRiLzU1amVkdlVMWGhucDkz?=
 =?utf-8?B?OUFCMnlmak5kSmozeVVVNDhUMkVlOWtBbDlqaG5udEFJWCtyT2dNR3F6Y1dk?=
 =?utf-8?B?dXFidENKdm1IaU02M3dsbjVrbTkyelQ5YWVPWkEwanVMYk9DSnFsZGdSQnhI?=
 =?utf-8?B?ZFBWWVF1L1Bsb015RVZNSHV0RDBQQmdEMGdISmcvUWJsdmNQd2RQcDlhcVkw?=
 =?utf-8?B?NTJoK2N4dlkzMVFkNnZOdDZNNzVnYlZ2aVpqeVVpOGJvNDFTWmtNbDFGVmRB?=
 =?utf-8?B?TE1DRERySEdDTHp3TTE3QU9iaXplS3FTeXE0dWZHMG0zaHE4aW4wY2liUU1K?=
 =?utf-8?B?Rk05NTJyTE5sTUtOb1dOamtlK2MweFpsc1hNcVF2NGQ2Vy84QkREaDlwcTdG?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j1Oz6NNQuei481Uq3hy59IQrD51U2uoRGTi1uQ47sTnyafCTAf/8vNX1zeosrayBVeqU8x1bqb3xVsyUuDjbvirv4lJ+3XKYiTDeUmg84Cet/H8j33Vh/+xKiA8YS2YmarjCaD7+Xh+xFiGLPiV71AJVHkM0TT2kGTIOg0pKDcIFC1a/TYnz0PW96krHoWbz3/2QacoFrFODMSR6EHJVucuTe39MleU+vsqSveN83gCDgZ5ZwyaO5WAEzOc2QbNyp2KYdfIPjfHv4nM2sOKXlcfIRxCSoC3RMcuFMomYz20d6T3T6ovT52VFRBe8rEtZkH4b4SLUdn+9OQtBAHg6/1plpAxm9ySoUc5q5iRys73I+rT93Og4cUAOt7elTWgEW+nrTm/SNk1miLVOFgtf3cZGjHmkK4Gn86fTV9mSAfr7HbcfKKr2QMAeegRRyRF2t3DdVdHniFSwz05hO9ZRjRrNsCTJdmwYPUFTchlkeks4B1/dVeUsPOHXHgEtDv/3gFk+IUn1FyzxIGpjVJJXEFsgWHGNTZSrT5IpcmRNRtZPOfA8pbJZDcLk74HrNDWcopvGYHF1DRylToAQ8oMmI/3HcRDnIngk0qrBFCNvjy2xCBWvyxtdInDN1t8GvnMy9kIPrSMT+ClKo0jf5kxrjQbRbtQADXwpMZTkEfoPUtjbRb/PO1403vX00od/TglIP6vmVIZO2Aj6nyaLIvO4p8viSWyXWpUVTZWbdLyI5OoaGUbeKopx3/hvDPgdaNEStjiWGv3KmHawB6YUtohtL6fBIMNWUiXAqgBfbCGEEOfhwOlnNB+IJgbN0jkN891BMbDOJ9cum6+010DcjMv0iw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b5f5f6-b7c7-449c-11ff-08db7893662a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 11:24:27.4224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItKJOx95CoM/MR1sVG1KiswV1nSWLewmVvcLWf3sDF7o51ob1YcmJS81QhK5RGV0JfVeVAyBTV9Y5zfikodNSKQJYEFhKvBLZHezvpYCbdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=599 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290102
X-Proofpoint-GUID: uUwd6MXajAMjtUyrk9rWvEzuY7o7XlND
X-Proofpoint-ORIG-GUID: uUwd6MXajAMjtUyrk9rWvEzuY7o7XlND
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 29/06/2023 09:40, Zhenzhong Duan wrote:
> When vfio realize fails, INTx isn't disabled if it has been enabled.
> This may confuse host side with unhandled interrupt report.
> 
> Add a new label to be used for vfio_intx_enable() failed case.
> 
> Fixes: a9994687cb9b ("vfio/display: core & wireup")
> Fixes: b290659fc3dd ("hw/vfio/display: add ramfb support")
> Fixes: c62a0c7ce34e ("vfio/display: add xres + yres properties")

Sounds to me the correct Fixes tag is the same as first patch i.e.:

Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Looks good, but see some clarifications below.

> ---
>  hw/vfio/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab6645ba60af..54a8179d1c64 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3167,7 +3167,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>          ret = vfio_intx_enable(vdev, errp);
>          if (ret) {
> -            goto out_deregister;
> +            goto out_intx_disable;
>          }
>      }
>  
> @@ -3220,6 +3220,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      return;
>  
>  out_deregister:
> +    vfio_disable_interrupts(vdev);

You are calling vfio_disable_interrupts() when what you want is
vfio_intx_disable() ? But I guess your thinking was to call
vfio_disable_interrupt() which eventually calls vfio_intx_disable() in case INTx
was really setup, thus saving the duplicated check. The MSIx/MSI in realize() I
don't think they will be enabled at this point. Let me know if I misunderstood.

> +out_intx_disable:

Maybe 'out_intx_teardown' or 'out_intx_deregister' because you are not really
disabling INTx.

>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>      if (vdev->irqchip_change_notifier.notify) {
>          kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);

