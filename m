Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C6F738078
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBviO-0003dx-An; Wed, 21 Jun 2023 07:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qBvi5-0003a6-Sq
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:09:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qBvi3-0000Da-EY
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:09:13 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35L6iEHo006361; Wed, 21 Jun 2023 11:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pRy7aDFDbQJEPrcQofOF/QNcWsL1mKYMth+xsswe7hI=;
 b=CDpr12hEv6cNqg8Lsi+hKE4sdpvkUEc6GRkoNHDoWcUFjFgUP/6GieFccrh9R5pyQDFU
 u8wBJMl8FXaSOrp9K3VotAEGNbQjtmOfYlOWYjKQOetlAVxDgtGO4tT0jXti5i1HA5KH
 7yAQarVFugPDhMbsjvTvX6cv5S+I6/2gHw+NtAGU6AiCwN/LhfVS3nQWoChcZfIeaXO5
 lMADqmbd2eXHxGG8c/rzpVbU4hGcp/mGWNLw1HjqYDut23bVoepHM1xd/QJr+dVbTzL3
 TuZFNq7nPjvNYPlZXCjGy5BXs2qUQZuXwLAFwjKXvsi93OPCGwMYPSayZ5I5b0d6acZz nQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa74gw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 11:08:45 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35LB1S1b032854; Wed, 21 Jun 2023 11:08:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9396usrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 11:08:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkeySKqHnKmwjOoCMreC69qFA351oinmpUccYNTVgt7fIsT9rCiHCaNa92WevHZsaEd0sx+AKHvpPuWLV9NY+b0u80gFckAapLcYP5VrFKIANqX4mxmf5mrQWmW1WBtm72H5+i/9KxfN/thPMCNTCmVWT0HR7kgDwt/veyJW57B1NFuLeB1AXVv1KXc6y733k3LM77RMo6xd9pyazsZ2o7T4tn72Y79qZnee0n0WfaPKuzyG6CEcgp78rkAkbUAWlMg7A07sg6uTlbeVue5lm7v97hv9JOJ/JAuF3vOJKiTIunBLiZlK9yXUGvh6RhWr/DAik3ALmBWAJhmzE6DyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRy7aDFDbQJEPrcQofOF/QNcWsL1mKYMth+xsswe7hI=;
 b=LbunLbqmHjLbB7Ptrjo+BnDm3tfCGGuvBEsm0yxIkSCmIA1uMIU5pSrjYCYelQ6kdskkzxmVvyBMUnIHXmUJ8oWJZY33x1wElzfmKRsfGCFMLSHzzprfoE2euHdAEDAizLrQdDo0cw1PQywU+ifUVMgDk+qU7l+gMaV7dD6pCize7VnRoZck1puoiAL9Up3PLOJnhg1qEnINHy7vCFY1wixf72R62bCUUT5yEgZimzgdsrATt0D3IEQBx7cuDnWwzEGkKXwD5M5hQ+ao1Tl1/zTkruSm2G7h5QaKADkzaGG8K10CzN7tiTl7iQRzb8kzBkipPQ7Z67YfqsTeblg5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRy7aDFDbQJEPrcQofOF/QNcWsL1mKYMth+xsswe7hI=;
 b=FB2uw24r9ZOX9HePfxHPqan8G6p4YzK9VK5gDRVpmIZhre7rH5es84dCqWwQ5daJ/45TSHN2fd5PdPpuSm97AheWPpLFjEJyWtFkpx0hu5GhpBiL0iNeIr6dUSLKWedWfTJg9EJcoEmvOTF7+k+uuHjlnf607mBHLqoB66eVU08=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:08:29 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 11:08:29 +0000
Message-ID: <88aa1fc0-edf4-a98e-0cbb-fcf312b3b19e@oracle.com>
Date: Wed, 21 Jun 2023 12:08:22 +0100
Subject: Re: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, qemu-devel@nongnu.org,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-2-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230621080204.420723-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::10) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CO6PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c05848f-e822-484f-bd37-08db7247d7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Coz9nP1CaoROnE/pP+w8AEYf3X5ub3l9VQuLYapgllBt3qESoHwZ9gwgOWM2EaFwoBlIb58jefevQKdsOI75ER9WtEff11xXLgceER13wz7dlQt2r3GWzBGfs47t7Y3loDD+mggK1YqUniYO4HyWKPa5fwQT8u/18rYGPUqAlnirYfORlk2oIlSBlUr5+DI0DfhfEC0uJM87ofxrnyR5fRpLCpbfk+QcDfqSPOjJ3IXqGFoTn7WKdtQ5uNzI+Jvngh0EOQY6bzCNLKlR0yUynDcuz8OKA98OFli4MgmGqdRvLveAVEFdskLepJCcF/RasEP1Gu/KZIjC2lhlSmFDDE40Wg9d8Xn5N6jfY48sVQfTpvlx4rfFxlmPnulx7rQALfDccBTFCRHa55/1e31GWHFLWpKBgRWBiWzxfZC+jKuD+f4ZptJ1mud3tGaQvh73v247SEUFRf3w0ZQV09n3BDmuGDurW0eDsuSTCYNyeYV8J4KjNzRe6JT5yzfrflMpuTzzYS3vNmjeOi0fuvfoQxqZdNDIl5xQ6olQpYjXKM1kZMTAbFVohgITSovplPxJp5kxOGGqsN23NxNie3Du5ZhP5OY1I8e/usn4tdKjb65SVAaP/4AXxmmM0CNTyS5/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(36756003)(38100700002)(31696002)(86362001)(31686004)(6486002)(41300700001)(8676002)(5660300002)(26005)(478600001)(8936002)(53546011)(6506007)(2616005)(186003)(83380400001)(2906002)(316002)(4326008)(66946007)(6666004)(6916009)(66556008)(66476007)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBIaFh1cEd3eHlBOGFtZ2pRUWFVSGRsZ0FMQW9LVVhTMzg5enJMRWxSQnFv?=
 =?utf-8?B?MWNSWUZrbGdoYTZRRWFZS1ZlN3RISml3bVU4Sk1aYmU2Z1prUXhsRVdGY2E1?=
 =?utf-8?B?OWR3RHpVSFZFMmx4VUdCdDMzL3dzQzkxNnZxajcwdTBqOGdvandSWGJXUkhP?=
 =?utf-8?B?MUlVTkM2R29leG5HWUNiclJ3ZFNrcjVmOTVrRTJmcWI5OFhLcW1DQmFhUS9Y?=
 =?utf-8?B?OFhCYmdUVTA0ZEpPZkY1LzlOeFcyVUswV1k0Uks5WlR0MGp1dXVITWNqQUNF?=
 =?utf-8?B?aXVCNDhqNGZZWnArQ0xNcjRWMjFNcEt0ZXAzbnFEZndhcmsxbUdBdmxrTnJk?=
 =?utf-8?B?cXh3TnN6a1B6N1JwT2k5NjFkbXI1VXFQbjBXMjkxcUZKdkdySDRVeUM4VUZQ?=
 =?utf-8?B?d1RqTXNPdHBLR0xEQldNWG1yRVJIZG5UNmdLZ29EVWNSUzA1emwwbThBVUdw?=
 =?utf-8?B?WmRwUktCc2xOQTVqNllibUxWdjFJVE5mNnhody9ZYkRzVlFMTzBqS01LQVJ5?=
 =?utf-8?B?NHVzRGJWS2NURU9pSWVvSUZuNm9wV085eC9tbEdUSk81SUpINWdxMVc5djhF?=
 =?utf-8?B?d1hralpNT0k2dDhkTDhEYkVBUi9Wd2c4Vk02SW5STGRhdUJhWU1nN0VVNVNG?=
 =?utf-8?B?WjhrcWxWb0wrYXI5OXVHL0M3SE92dEJPWXo0T0JKbmNtV0twSlkxMzAxWi9E?=
 =?utf-8?B?MFdDVCtIUmMzZU9WbGZGcUNPcW5OSW11cndKZFFCbXU4YVR3MVZtU3hkWHlt?=
 =?utf-8?B?clpDUVVsSnQzeDJ1QUJGeGZqazROQjc2K0lzUG53bk1rdi9oMll1ZVZOS2Z3?=
 =?utf-8?B?ck5GN04vUTlUNkJIa3RjMXVmMHhnMUI3N21ITytXRGpMWDJQck9ySngzSzBn?=
 =?utf-8?B?M1FSVDRvTHdRekdqYW5EK3RJQzlZSWFXQnVQYjJBRk9DbGtIblh4OGZROXpM?=
 =?utf-8?B?M1Zvam9jTkdLcW5DL3orQnBZd0N5OHJKYXhFejNMR2k0dnZvUW1hM2gzRHBK?=
 =?utf-8?B?UHFxbTNSTE5yUTBaa1gzUGl6ckExREFUdFRVRlVCV3p2K3NXOGZRRHVmMWQr?=
 =?utf-8?B?UTc4YWhxcmtYZDVWVGtqODlzZzA0L3FFcmgwTXVSSnFYQVRzdmswRjBkQUJk?=
 =?utf-8?B?TVUvang0WkNpdXhyNEpSdTlFR2dWUzNSWTFlbi9mbnQrcDVsZ1pPY1lQc2tV?=
 =?utf-8?B?ZHFJVUxYbmoySXZpVG51dHdFUVhnbS9oa3JjQWozUm9seEVxblJhejZWK1Nn?=
 =?utf-8?B?TW1mRHBCSGI3MzFUR3FrWmxHNHd0S1dDb1NSbHNGbFY1RCs3K2I1NWJHbENT?=
 =?utf-8?B?a1g0a3d2ZUQ2RmlIK1U4dlp2SHArcVFCbnRqcVgxNU55cEY3MkZMMTZlbGU0?=
 =?utf-8?B?bUNtTmdsdW1QVG9qdS8rdjNOK3BVV09GVHhVeHl0cWlIaElpTjMzSEFzdjFm?=
 =?utf-8?B?WDV3V2tVME5sSVlaU2Q0a2NKeEV1S25GTGprbEJCRzY1RElvZXFQTisvMks4?=
 =?utf-8?B?Z1V0clVZS053TVJ0T2pxaE91S0lnVTc0NG0xU1Yxek1DWE9zZWJQdVhQVnBj?=
 =?utf-8?B?NThwR3ZFVWhiZTJNZ2NZclpmRjNvMHYyUjU5S0VPMmkyR2tkMjFXb0RaSjhu?=
 =?utf-8?B?clNwNmVCVXhtS1RiZ05yK0tkcjFMTWMvc1VUV2NZbTJvLzFZZW9HbXJ5V3hy?=
 =?utf-8?B?dGhEVVBSU21wTEFZM0lPZUpKa1R2cGFVNXI5U0JadDZsS1dJbW9NL2JLeGFS?=
 =?utf-8?B?Q0wvZ0I2SWJ4Sisvb0NaUzRpSFZEd0thelkvckx0bjQxNzdVaEI5RW1Fd1ly?=
 =?utf-8?B?MCtieW8vVWlBdU9iTGdWTFdvNkJWMWUrQlBBcHdCeitOTEdFdS9VQ1NpV0li?=
 =?utf-8?B?bVk2SnpDOU1EMlM3ckJ6RFREcjRsOG45QnZTWkpSTjgwN3pVYVo3bmI1dEhP?=
 =?utf-8?B?ZWRvUEpRR3Bhd2JQaENpN29tc0tSR0ppK1U2ZmY5VlFlQUtRUmFhMGdFK0JW?=
 =?utf-8?B?U05KSFhhSmZsSld4K1FnV1ZsckFjV09PMEVVeURKRnBFaWR6ck5QdERVSzFJ?=
 =?utf-8?B?cDlUTmp6OVF5M1g5T2hnL1czekxvUG9LdHVWWFRPeU5XcGRSQVVOaGs5ZFFq?=
 =?utf-8?B?VENpN1VkdUY0WFVQei8yTUZPR1ZqeFNBelM2eHVPVTkrTGdDWC9BbVBBY2t5?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XXaIwrsUKvAW+XmR/+a27ttB4y6Khj13Owxfygr4IYW11eiifRl+2Jt9iTy8PadjYQ+ZbcJL73n6zfavHCvUgmutZTCH7GW+XXcrD6Y8dRAxG4vGryPILZ59vdyw3xLNAHUeBh1SXSahR4wQJNB1mHNXR+prb5nQcl26OLrNxh96DuFI1syr65/pE1FxM/1a2eUv87be+U9ft4sXK2Ll7KdUATSrl3RL/QqSx4WBSDHs+J+UxSl44EUsAcVPw6wuPnahOK2yBftsUVI3M7RGcoFy1sDj+GPSONCmeu9v5d3WrlLvTO1L41WCCUMH4ZQMEFxdqBH99ZLLKKogh7ks3UxfV9G3aLFPFTJixRW81dSshJ1vmbkSZ7HhwOdmLusc5+nagLd0fBIE3S90F7WiN5mqgNZlEpGqa8joiaXo/kgZs9jSrPnTXEvs+mOPQy/OPs0HbS0BrVCoKSKzOt/hhS+O8thiFk+9GdbdE/9pDahVqjUY++9kHWdk4X3jQXNJHKGJSIwZHbyPC0WC1dSrRkI6gQs4CtIVfgiVt0/XsN8ZtiroPokmzwIJOa5tXdzf3kZrJthXbvdJOQ7PSAn591VpqMOk72RCOCex6A2RbW51tg973PwgkB4Gye8A59ac7XQNex2JawQoJlHHLhXpLErRPaZNgom+/6fDiZnBGKykmggxnDGKAgsbwTTXhgnsT1Smf3DArK6HcWJQXlu10F2fwFTw5EYzIsA6//RVWYbMOlXILLhDxs5LpmtAhKFn/9Pmq+7yGI5j0/GrgoCYKTReB+n/ZytcBNT+f5z5Q45u8i5liB7q62uHSA/P/U7UiDMZgeKkkC/pFj/N8SJptA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c05848f-e822-484f-bd37-08db7247d7b8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:08:29.2480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh0zY79/3eOpQcsTzdpY0nmKSnh6bWcPc/RFeeaEp1a3rwFOj7I3FaolT0mLIzNTU+fKOvQf8TLn1gMGbhiFmXL+qj0S9IraNBoI57x9Eoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=854
 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210093
X-Proofpoint-GUID: -QX-hzfHZsJcuQUHj4MzKmm8n-_dXYt0
X-Proofpoint-ORIG-GUID: -QX-hzfHZsJcuQUHj4MzKmm8n-_dXYt0
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 21/06/2023 09:02, Zhenzhong Duan wrote:
> When adding migration blocker failed in vfio_migration_realize(),
> hotplug will fail and we see below:
> 
> (qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,x-enable-migration=true
> 0000:81:11.1: VFIO migration is not supported in kernel
> Error: disallowing migration blocker (--only-migratable) for: VFIO device doesn't support migration
> 
> If we hotplug again we should see same log as above, but we see:
> (qemu) device_add vfio-pci,host=81:11.0,id=vfio0,bus=root0,x-enable-migration=true
> Error: vfio 0000:81:11.0: device is already attached
> 
> That's because some references to VFIO device isn't released,
> we should check return value of vfio_migration_realize() and
> release the references, then VFIO device will be truely
> released when hotplug failed.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de12..c71b0955d81c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          ret = vfio_migration_realize(vbasedev, errp);
>          if (ret) {
>              error_report("%s: Migration disabled", vbasedev->name);
> +            goto out_deregister;
>          }
>      }
>  
This doesn't look right. This means that failure to support migration will
deregister the device. Migration "realize" should not condition as to whether
your device finishes the realize. Maybe the fix is elsewhere?

