Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EA4738088
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBviP-0003hK-Dq; Wed, 21 Jun 2023 07:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qBviC-0003aO-20
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:09:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qBvi9-0000JO-Jj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:09:19 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35L6i5re002428; Wed, 21 Jun 2023 11:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Fj6NhgyVM14WKVST/+DLB8oXw2jmkPd+QEwRXF4maLQ=;
 b=K+l/lTeFS2ZnlrpTBov3JoZVj8grb4Vx8Yd5KRn6pT2rNzF8BihFnWOdbxc9BHBtAFf6
 jawnoB8qZu6wu+6nVFqUvzRkqlr58UUdrPFHqhwkuwTEhouoAebBCP2W0s1eHrUGXQ0A
 1b6cO1iv5URGJX8QF+tPR1xdNJT4wYZizSUI1DlQH6XhFeevZG0kWqKV/X2+CaUoyXOI
 Ivfq4pVraho00pHRMAw8oQDd5TDKmlXH460OloufMpc4n8RrIR0X8PUZO6VhxU6yX7U/
 iJRfECsyOCX2TT+ZORiNDHORgiReXGIT1pNxWKkBeiCvLrZwRFkXwN30wGnWnnGGW53z YA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etq8kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 11:08:46 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35LB1S1h032854; Wed, 21 Jun 2023 11:08:45 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9396usrd-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 11:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH3gWNQZH29zl3G99AFJMiVe3nRHAxZHcwQSL939FBqWhw4w+U9dNz5/A8lGQDq05WiBfrU4zUCQg5AZuM5EA8MJ+JXepbhlGpcqlz70C/XG0IXm4wdIZNSkHe78PPedVx+eowY+G2RCR51Tx4NY0fs4hoK6SfanF39TXsccIe8pLg3Ccf3iz9l5rHuA2OsYvn2g7/ZuL71EF6GWqvoGEiwXKZNKbTW9QU59hEZg+MVh3Ig/thpv/z9SlEbNaBpUrYng5qiclJIWpft6GjoXTTcRIOC+HKyBjSKfC6pUzDvK8rfpplH4GzjqtCfXi902r/DQyvfAD62ht8fAB76D/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj6NhgyVM14WKVST/+DLB8oXw2jmkPd+QEwRXF4maLQ=;
 b=DutOBp0Eb1EwidVFr0d/XJ00PzZlYRMlp+mMOnwUKQgFC9Jd4H5S9R/Z7tCjplV5vkiV9AxcpPJE46ulOboqErmHPp9ShBfWbPF+3B+JTGQm6BwdHAkbEeNUWiOw42Jw38/MY5z5hg/n/2I2JaCPnHCpvZV+WjZOqVLLZETR/AELqB0Mgm7AC2e6tUriCfe7xXVeC/5hOuY+giELb1mZKh4ux282UEgSEp4HZMzbHty2HNimnwAxOvckBNphDdpxJkY4pt9ukrE+GASq1oAvpPiqDEQBRYlslvLto9JxxyKBOjJXA7EFWS0SnBAsrdCcrfGyYaitBm5a40RzjK3+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj6NhgyVM14WKVST/+DLB8oXw2jmkPd+QEwRXF4maLQ=;
 b=ehG7Hxf97RGSoj/JXSVbAN06JzHm88wC+8aY5vijH4sBBpHeHzd7hFCFVQ+mYV/+bk1WogLUCGn0yg0LHwgOkD4rnKH7f23ja4pwF7mXnQGWhxDolCKTbJ7m41PBjvyyu+dYt8ejBvZWVidnqYsO3/ZSwsXZsvYoOr57vfgHlm0=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:08:37 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 11:08:37 +0000
Message-ID: <6a2dc503-34a2-a129-3932-ab9cd61cf5cf@oracle.com>
Date: Wed, 21 Jun 2023 12:08:31 +0100
Subject: Re: [PATCH v3 2/3] vfio/pci: Fix a segfault in vfio_realize
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, qemu-devel@nongnu.org,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-3-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230621080204.420723-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::6) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CO6PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2b07c8-48b5-4165-8b20-08db7247dcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DM7fZQPq1BEhoZxV559J+5LvXYS7KfouOQXuM6VLDpLbG+8H93cv1EMb5CA8evOqs7BvaFAP6gFg66+phJnI6DmZh1ENOrKcIk+hOA5EZgDDeNub7RqqTq8LEIY04d/QR9YeTTdG3pB7XfLa8NcK6JseeJVOjSr2YZ4SQ7vTZpQqXwKoWw/xewr1H7J9vQLFOEUvlaymXoTTqmSL+BSq69GKc2QjxPJKlELFZYHDl9rbjPsQ3xVA6VbinkiIrFtOvRIhNX/eHmplWWx0wKmHXNVT7Na3l0ulhO/Km/mud0jYq8jRSCjeuzkAi5kSkmCDilV0UmMiVUg4G52ZNadyjzB9NNz9mVgiOS4wlk/Cf4/uNUga0YcMKmv577yruzT+1Rq5p81UGXa0cBwhChf5zeWf4bJvNcUrEEyPqmJnWZ/rg41n6bBEgKBWeDZk2ctoQqAgWj02e3HQEwoqfLRlOnQo4S5wScs39Wmnulvok0+tUrwX8YtMK7IBcVWMWol9s7zTymMZtd9WajYlgIBQk5Qr5wC/Xb+88wQh4+sd/hBdtThugPAFI8hh9DXIzuxxUpDjAfUhHCCZGA8Wfo5hSZZy/L+LZ0Pl7XCeNeWo9TzxbN2ZPUYBZADZBf50l4t0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(36756003)(38100700002)(31696002)(86362001)(31686004)(6486002)(41300700001)(8676002)(5660300002)(26005)(478600001)(8936002)(53546011)(6506007)(2616005)(186003)(4744005)(83380400001)(2906002)(316002)(4326008)(66946007)(6666004)(6916009)(66556008)(66476007)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JqODhHVHllaUhWV081d2FmeTZDbTFWZmEwQVcrNVFUNnFydmdEcUF6dDFU?=
 =?utf-8?B?ZDMyR3dsSlMvREdCYjQ5UzJqMWxrWlJ3QUg3T3dVTVZYeVlPYmpGeUF1d0cv?=
 =?utf-8?B?MFpISHQwRUU2aFVZZiticURKa3k2RU9RK2FnNGF1VG1FSnpkK0FDWGV5dGgy?=
 =?utf-8?B?OHc5enhVWlZJS0REcS9sNHg0Q1VpVGRIYnBvVXFkZUcweTcrb1hVNmVWR1NG?=
 =?utf-8?B?aVFVeDMrNCtaSTdpTWlWOU84Q1dZak9VejdEaWVEQ0cxL056N04xc2F3R3RQ?=
 =?utf-8?B?dDN1c3Bhbms4aE00dUZISE14ZWpJQnEwUGd3dDhtL1FsRHJKSC9mb1hiWDhN?=
 =?utf-8?B?RUQ1bFhXdXcvMFVEMnBHTkhRblhlRDlOaS9QRUhiWU1XZDZGbEovamE0RHZt?=
 =?utf-8?B?dkxOK0xDakUwVzBuYVhBSjNBOSs3M2ZLY0ZkUStqbm5hZWZ2WERjTGhTUE5O?=
 =?utf-8?B?S3VCMmwzMDR0dC9uemM0NDVVa3lXbFRObXhJTTJrU2p6YlQzenFoSXI5Q21J?=
 =?utf-8?B?UmxRRTFaKzVkcFJDTDdGeGNjOFY3eGREamQxdVAwaTZDRjBNd05YeHBobm5C?=
 =?utf-8?B?OVJOTlVraEllSGwvUFNIQ292akJXL0orVzVJQzhVa0ttV0VYRzk1WEIrUDFi?=
 =?utf-8?B?aWVhZTV4cDdvWDVwMnAwOENzNzA5WDhyY1h0L3hjNDZiNm1aL3U5VkpJNTFZ?=
 =?utf-8?B?bHM1TUFFeFZ5cDM3RE9rbWhOVzVGZ3cxUE5KTUh6UnVmd3JFR0FJUVhtUkpQ?=
 =?utf-8?B?czIxMjN1N3dSWDc3UHpudGVNZ2o0SEp1SHllMDhnQ0FjeFBtZVppY0Jad3RQ?=
 =?utf-8?B?OEhsdThiazcvQS9Pd2pkUzdiL2p2NnFwY0IxQlJWVDNxNVkxK1pab25QR2xt?=
 =?utf-8?B?ODJFcnhHMzI5T09YeStIUmdtaTA5UnFjQnNHUVAxam9UWThEdjVRR25kRGxP?=
 =?utf-8?B?cHhDRGw2MGJjVGZFd0dUaEZXRFFGOWZQNTdPWG9Meml3V1gwcFNwekN5SVlK?=
 =?utf-8?B?NTZHVlhTZTROcSsrYjJWV294bEVwUHNhbVNlYnAxNEpFTUxnaHRLaXVOb055?=
 =?utf-8?B?L2RGc1dQQWhCRXV3alp4T3E1Rk9zV0NLSDE4ZFNxUzJ4SFd4MUFWRi92YTNO?=
 =?utf-8?B?SS9ReVlnQXpVRWhhTWt2elVGb0JGeG5kdHhhV0t6VnZRTE1qdUhkVXJFc2F4?=
 =?utf-8?B?eFI4WGhTU21LZkZCbkd5RjhSaDRneUEvU251M3BvUk1zL2pNMTdsTEpRRzYy?=
 =?utf-8?B?Y2lTbHQ2czFiR0Z0c2gydC9zWUU3YnpkY0YxL2J0QnphK3VUNm05dVRIU0Jo?=
 =?utf-8?B?N2xaSWUxeW9sMlFKcThtYnd0bk5GL2NjbmNsUTVKT1UvN3hycnJoWHZIVEFU?=
 =?utf-8?B?dG5EQmZRK0o4Z0NjWnhNY0RESHZ6SkNpWm1xOWxRVi8wdUU5Qk9lM0FYdlpz?=
 =?utf-8?B?Y3k3bGtQbWVxQ3pueVZES3YwanBGRS9MSS9yTjQ5Y2djVkRjaWpsVGsyYVBM?=
 =?utf-8?B?T3JkL2xVdUdUNWN2UjEyZlRlR0djQjgyU2h4RE9iNm11bmVXaFlFNk1OOXpM?=
 =?utf-8?B?cVA4bTNNU3Y1WVAxU0xFOXhKYjNSaUJaNlFWZDRaOTkzYitTQThOdHNjd2Rl?=
 =?utf-8?B?clZxUEE1R0hrV1JkaG9xbmNPTDJmVW00K3pOZ3F0R3QrWUl4UnA4VkdCQWNi?=
 =?utf-8?B?TUtkQjQvN0xCWkFTS2pGaEgyazNvNnljMFM0RXU1dkVtUWZKZVVSRnRldW1X?=
 =?utf-8?B?dkw3NE5SaFhDalRFclovZUMreDJ1RFFoZ2JsOXkwWTk2NHJSYzVWeDc1TnU5?=
 =?utf-8?B?WWZIR25lc3VYYm5TenZianpicXJmMjJtYmN1QnZYdGNqNWRRTk1JNnNlMnIv?=
 =?utf-8?B?bzh3RDlieUJZV1BFdVFlYk9QcHp5d1d0MldVY1h6UDNNclpuM1NXdFR4SWNC?=
 =?utf-8?B?VTBRZjNhbk1kOHpobkJCRjhhVHpKRWZQNy9sY0JHREFtY3hVRk5rWTYwbnNS?=
 =?utf-8?B?Q2NaU05WK1pWc25xb1FuVk14T1BYTFVNMUF6cStNWTBPKzJLSU44T0c4WElU?=
 =?utf-8?B?N2U0RWlUZlRaR012VmJDdHIwaUdCOEF4QjhmZjFWSWFYMEE0K1prdXRCNkF4?=
 =?utf-8?B?RlY2a3JXa0MrK1YyS2V6SHJnWTVXRS93dmN4YjBySnh2YnJQeUV3cnFDZG4r?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L+fclU8/xLBRqM2Z+RLADoITpuphEXbvZ6HLSiTbeghRPG532ZWMby7/KiSr0uAKnQGj0sLPhlz7h9z55qLCJcjXYD43/96r+3cwfG7KkJGk+QQnR8fYWfNNBw9k/eDnRKvxhh+hIKwOBhLVduNe/tUxjzYYAOVer8oYSLYGlhbZaE2Y/uQYGA1Rx11EGy9HzQu7y4FTbU8CnvV1VC19G7RxKRlgtVz5uPZoXfu25RS3vCPeiSUi7DajYiOz1fYgVn8RSWZxx50Aw1hGDnIJ21DckrD+KPJbks3WkFVkJLnks8Mu7m3kWeCAwpkm4GF3/PzXNW3TbbFWc0bLDjE53k2PLe3c2Ag8LdQEFggvuGebI3ANrfA8vPIWZPODBQds+UzacD6CKVpYgkV9LCBxpUnMOJggyfyIA6aHQ8FgK7BHkJpGnvkogEpG5FKRnOw8+BeX/BvdSJQhEqqR0UqNOt7JCpgPQbzssYPa+he6nUp9LB4FfUhEQPIA9hQrxtZJ7rqBFVqo6l8/U5nok4xTvmghwWJ6XJzLP0S1D6lkS7HTMgq6yHUAKa34iY5OTX9xtyyqns2hKbb5fmQl6ka26Krhb0FEcr8Zfp3qhpUNz1IPfPupuiSiTi5Er5WhRoiLYvBKdEQRdMlb8AXN8JBvFom9mnareLoW6suBSix7lm5VEBVIBtNiIyukceU4+KsexLhSbJV0GpaYiY/tLs3QxRzGBZYjTG0fSTKCzoqFWTIXfiRlAKEVpY1RseOQqEYj5XIJdVSWJ1hTWWa+yBCrlR4dmfOVPQrwVbczT33WurWKIvVdoaLHTLCFKl5wojmvbvJBHppoa3c9ENJCOEuPpg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2b07c8-48b5-4165-8b20-08db7247dcbd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:08:37.6236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ME9PtL2kosaQgAn6gEc8BGzNe+YE6M3lztKAvC/Zt0t2ds4gn3jCIkByN+X1la0eraWH6hliQ/yY0L7x9D80tLksXWChYBGIVOsUA/nUoLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=705
 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210093
X-Proofpoint-GUID: XQ8j4s-DrnYzNhLW2xWg7AxOT89FuRIz
X-Proofpoint-ORIG-GUID: XQ8j4s-DrnYzNhLW2xWg7AxOT89FuRIz
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



On 21/06/2023 09:02, Zhenzhong Duan wrote:
> In case irqchip_change_notifier isn't added, removing it triggers segfault.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c71b0955d81c..82c4cf4f7609 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3222,7 +3222,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  
>  out_deregister:
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> -    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    if (vdev->irqchip_change_notifier.notify) {
> +        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +    }

If the first patch ends up being pursued (which I am not quite sure) it should
be folded in the previous patch, as the out_deregister is used starting your
patch 1.

>  out_teardown:
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);

