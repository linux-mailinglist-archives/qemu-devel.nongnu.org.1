Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0BC73FA19
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5pg-0007L1-SJ; Tue, 27 Jun 2023 06:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qE5pb-0007J0-Ig
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:21:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qE5pW-00012V-UI
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 06:21:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R8DkCA026016; Tue, 27 Jun 2023 10:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VELeF1Szw5N8sEjUVQIqouGnMocKCDerFWKVL/Q/Pac=;
 b=RhYYqaAnUJqj+XA5yxYuzPyxIpTzbgdYqYs63nX080lDSZVRU+0+HJy3bVnfK3XemlyI
 G04TAMPQ9/3GyaJO0YzsexRE3EXVIblvczdD8ILuuhKsZ/eiD7/1D53Do/bScmjo3R+I
 D0DBLNJnI3pR+Dps5H0CrkpTK+RrvTeSLY0al1/xt5q/Xzgy5oogc8e3ojfbFRTweDmb
 xd2gV6Va5ll35eaffl/6sh60K6Txpdifjyk2tHJA/DOj2Uz9Xi50GFO6JkZUzm+JpjWI
 H46O7zk9bfqlZe4+dcIoCxSpMTW9WbXuGX3HR22PtWOUYM3D86mIpfshCtHGbBe4Bx+B AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e2v92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 10:21:45 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35R9fNeh013086; Tue, 27 Jun 2023 10:21:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx4hhqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 10:21:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2aG19C7hK8K7EduqbVrvUhsjdv42ckzh9s7isv8DnsCqCIfVM2Mkp8aqNuMo9d9OHvjZttOO85yuyMK02jPqx/epfAnviEKDPeJJHkyWBhOfecByyWkgtEoGprl/PkpEZsGZSpWHiIObCZKQfKhtmRuP2UVdP/y1up4kqOoiFohUcJJ009m8u5j4U0AFSeH7je/ftggcyk/h3GvAm+Bhh3uDPmo+oHzypSof63UPyscv9qDnVl3/4zgo4qOE6tVxzfvO2M9kl/bfhE4GGlPXJ9nlldX9x6vduvvmDNF81XVFeJzuR0l5np3ueQt+eY/FPal96uwZPPbPHZX2ppHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VELeF1Szw5N8sEjUVQIqouGnMocKCDerFWKVL/Q/Pac=;
 b=Xep8XUvxKa/pEOaB2vDbXwMrSAF/FENrZeeyrYJf9uQhSZVL1wDJWNMa1nZXn5zHojjysCVNSZDONkFllgjQaOk0eGZt2vqAFVAxTkuqU96R5gAfNLc3zSXU82ng1+YJuS4Xs50KvSiv10rR5DZoDpfZHRkgYppI4HQZkCmZsYtg9XkBh54sAwqS3j0YV9Pj2PGH7qrpWrsKAGlPCej6GK2BhnCccavvdJCUBb1+Lef3DZJsv7UdzTftE8kR1iw+MGcXxlkc6THOkU0grb58OhFU71h5Fqa0XWObeeADDBh+hDnAdZntMVXxMCaXWHn7Es+hn/8sqyZHV0WyCe89GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VELeF1Szw5N8sEjUVQIqouGnMocKCDerFWKVL/Q/Pac=;
 b=NPQUv/kxCTXZLCJgakc4cRTNxCI8Z07aDhzrS5PdQd8jyYc48bpbJX21+EhP3SFoXBP6665DyvfHUNaNgdPKw33gThR3MC3IQHgVegjP3042mdl9goggegTtYTot5PRnOG+5S5tClkeh5zCnGKaofmNtNksQslMuru/Qrt1/FP0=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 10:21:41 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 10:21:41 +0000
Message-ID: <8ef7f136-54ce-16dd-60fd-fb360b012646@oracle.com>
Date: Tue, 27 Jun 2023 11:21:36 +0100
Subject: Re: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-2-zhenzhong.duan@intel.com>
 <88aa1fc0-edf4-a98e-0cbb-fcf312b3b19e@oracle.com>
 <SJ0PR11MB67441D1922E854785F2FED3D9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744837FBCEAB1F9060BBAFD9226A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7e1567f1-aa79-cbeb-3c1a-20594f1942cd@oracle.com>
 <SJ0PR11MB6744DB25CF81FF634B82FF7A9227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744DB25CF81FF634B82FF7A9227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1b0342-5427-4ecc-eb4a-08db76f84c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M20GvMHc9Eb0N1572bc2Zo9R91MCcoeolJhG+owsAu/cgtxh8iDUwoBfsReCXG+KAX74v5eOA1OHo05iRDahnLzkdZAZth2FXFJtF2bY1K+Lz0kY5mqg5V9nsU1/hRyFOvPhzbjKIGBUFZvIm/g0z2US/owLWHAvDoCw5rfzr2bSM3ANdmnlREfbha1lgkn6h7ccnSHTnJzNjwW8gH5IGlK0rVSp2PYV/wI3VtJrebvOBRnapI9V+CjVH/IVQiS9KaTtupq6MY5GdCu79ra7jb8MmO6q7rMQshjFLy0w4yUb0Fqyql1lMrWmgkqeqPQRggM+A0rsfGT0mmHbYHC/gFa0Js3gV+icfGQqlxW/zPwG4koi6FKBCHoBgm7OfuBYk4fSeuqQsDEjd5ga59XtAAaKjwAJ0dTaQ8lesejQry8dJU1JVHB9luh6f29i1GrNS25QMgjAEuCb+hZTFnp7q1JbKyangQE/4z/aKM1lcLhII0O4fsaSTZWXFgQh7sRHbHk7rbHja10qqTTpLOBTooE9tE3PGauwxe8wR4M6XQApiO25c31tDCgo2oobV8H+QC79h9ypf+mMCSRovsB/ozUf5fxwZkGt8ulO/pTdwfbBGEV1jdZ7ZXxmYO8Ly6DQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(38100700002)(36756003)(31696002)(31686004)(86362001)(2616005)(54906003)(6486002)(6666004)(41300700001)(66556008)(66946007)(66476007)(316002)(8676002)(8936002)(6916009)(26005)(6506007)(6512007)(4326008)(186003)(2906002)(478600001)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3FRQ0FMME0wWVVpL2NRcndvU2NKMnM5NjN0RiszRzZtYXJKV1JIRDNhVWVJ?=
 =?utf-8?B?dityRGVCSWlsMXlqNzBBRVJ5djZuNjZMVkRPcjN5bWZrREl2SWpDbG8xNmxH?=
 =?utf-8?B?RGgrZWk2S1BaeFdUdGUrV29jMEVKdndpU0dHVytZR2dSblpwWnZyb2JzYnhN?=
 =?utf-8?B?ZC9DelRtZ1VPeVRkT3FEZWREMEFZaGNqanFVei93RG1xWWZuRFUybDVLVFo3?=
 =?utf-8?B?LzJPV0ZlYjJLN1BjaUliVGRhcXNBMkVpNTNKOTlzMTdKbDJCZVBFV3FFZktx?=
 =?utf-8?B?OTFLdVEyc3VCYlJ2czl3L2lyaHppckFqZ0twcXdwV3Jickl6R0NyeHVidG1j?=
 =?utf-8?B?MGNxSFhla2NERTRVblRtK1Z4NnJ2TXAzOWw3RS8wZFBJbStTUk5mZ09sUnVi?=
 =?utf-8?B?bnNEcFJjYW5MWm9CK2hTQVViYkxGSWd2ZzNxY1FVSUFDeVc3YUhTU1l2NlVK?=
 =?utf-8?B?c1pQTm5EVGVHMGwzbHhtQWF6cnRMaU53TlFRZzN4UFVqRnVsWTdOSE0yZHZz?=
 =?utf-8?B?Uk12SGFTT3h4enRSL0gyb2d0aEcrd01uUk1SM01ONEJWZURxUG9hQUZzTFlU?=
 =?utf-8?B?YzgwOWJGd1RURjdzOHh6VmZibkxjUTNUQjB1ZVZvS2xydEVhRDYrak1HazZN?=
 =?utf-8?B?RXp6TGhnOWk5RjdpNkJ3VmY2QUFvamNVOXU5d0NtV1NsU0JtOUZtbkZrNzB6?=
 =?utf-8?B?dEdteEtiYVVCWGJSODRKOHNWUkMvQlBLZnlGRGh2NWphbENPWitxZ1dEbFUr?=
 =?utf-8?B?bVoyenIwY0JQcmhWU3UybXRUNGZta05hckFlRFQ4b1dhUHJ1Q2JnanNpL2Vq?=
 =?utf-8?B?KzJGbmF1elVveWdEajljdHdYMG1aTllCSE1hNkN3U3ZZb3BMeHVkK2Fld1Np?=
 =?utf-8?B?aUVTTi9WQjJ0VGlSK1ZZUC9TaWhMUHJkaVNKbDg4cy83N3k5QVJVVEZjMVlh?=
 =?utf-8?B?VGFnc1BrSFZGR1YzYm9NSk1SeGE3TmVTVVh0Ym9iYkUxZEFSaXQ5ZUFBZ3dh?=
 =?utf-8?B?dFppVk1HNnNCbmRUVnJqd0JiNE1pcm8vOEkvTzhBZ0JveUhHWTRFVDYrN0M1?=
 =?utf-8?B?cndpcDhDMDdHcmZZckNDZ1RIdUVWb1VIVU1kc0tFbGI0ZnVYUkhrZ1k1Y2gx?=
 =?utf-8?B?UnR3dFdqTWYzbGxhOU5JNEtFNk11OVc1ZkphWnFwVVQzMWdtV0I2MWRKNzVj?=
 =?utf-8?B?V1Z6cW12UFJOM29RM2JaK3pBTkx5RzY5RWo3a3FCZFN2VitLTXJkb3drSkNj?=
 =?utf-8?B?QjBlVnY4L0JJdjJJTHVpQWlld2pXcW5tbzZvT0pEamJnd1ZwZmFMREdtRDRu?=
 =?utf-8?B?STJBUzJIbzhGdFBQU0o0NVF2SkVyekxvVWM1UUpoa0FDampkWERWTVZQQTNp?=
 =?utf-8?B?TmxmQmp1RjVBRCsrYXhVUlRWblQ1b3EvN2tBZWFaL1VHT3ZpS0JyY2Z2cGFw?=
 =?utf-8?B?QWovbDR6SzZCRXNYbDU4UXk0ZFcvc1ZsRUhzQnp4d2RNenF0Rk9iR3M5Y0J0?=
 =?utf-8?B?NU1yUjR1NHY4ZFFMbHRPMmNkN2F5cWNMcEVkYzlqSEtNSUV5NWo1Mkt0Nlls?=
 =?utf-8?B?MGpuWHZScUNFTVJFdUZkc2RyZjFaRHpBMEhtTTNydTl1UzdHQzZGaHVEMmUz?=
 =?utf-8?B?S01rMG1uY3M0ZzJyckdkdmxsWUFQT3I1MjNKdmM0ZkF1djJSSEV3UXpiRUFB?=
 =?utf-8?B?S0NBMkRuTStnRnhQZjRrNDZHKzhta202dVdscGVBb0FkTkVBMlRlS1ZSSVRj?=
 =?utf-8?B?NmxLM2xQTUZaTUMwd2FOUHVDeFh3M3pxS2lmbzNOVXgzN3JySUJMakVhbEVl?=
 =?utf-8?B?ODZQRWFsK2J6RFdsa1dkZGVld3J3TWhVUjFCaU9Na2l2ZjY4NDJzM2toQ3B2?=
 =?utf-8?B?akdJL3ROcjVyenNzYndQMXYySllpS3RlcXUzMDJYOG9ISUYyZkd5SUwwNVNY?=
 =?utf-8?B?bzVDeUtWMXhIYis0U3NqK2xRRCsxTDVBQzluMFk0L0dwRFR1SmtjMjliRGt4?=
 =?utf-8?B?dVJEZzd1TEU5RmZneFEzN3Ird1BpMWNCeURlSncvN293MjFjTk92ODNmdWVm?=
 =?utf-8?B?WWxqREI5aHJ5UjFIanE0ZjFJR3dIZWJJQ0hmQlRnOGdtZVRUL3FMMC9lUVR6?=
 =?utf-8?B?cnpack9FUGZkYmFJOHdlQUFSUTh1U3dabU9hK3VNZ3ZyZVlrRjh4bVpjMHR0?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JqE05JBio09nvRqKKlKTaY5sDRrjQdk2XO28pv/lxPbosdxlr7bZI8PMyfLYVwJKLCrRMBT/rPYxFuIVDTic8+47joL/59AlsipFVULPdbZ/wm3ySb87Pv2lqH5/FilR6800wxJkwRbJEPtam0S1o5pRFVm/HE8Ob1719gMPpglIpme/fzOVjD+KA3qntwINKFOTb/rnx4LzQsjS3qcNdNrxWZtNWsZZHrlCokhWUdqe6j+OZl5F1Ygm1LhPKrr5TuF2fWgUIdL1JtE5DfQd0HB7yxyRW7JnWQki4/dXYcAsKQD3MMBA48wHR4tt1gaYhjiHkeDmu76c/WA3guNHn5fwezd0fiqXfpCKtsiVAvCP1FCXHX2Qkd+fEnd30ju/+mrex24rTUQLNqkBHTXGdVNRLrLo33fFtZM1J7CgjSlk6sArUwZLRKAcA9VDKpTwgM2UnLGqAuBOwAUzlioBJrVzI17Dju3MKr5Jf9vWc76dScOGabuQJF5+WzMkCWIuFVa4lgvXTf+ssakTYn0Dqw8u8SDQDoYNZxAUgKLAP3dVsAgD6P3En+EyuqRrfxcxgLqjD+k8JSAXhe8NVOkjhnn6jgpvcr7OFU6QGUYkjDlqSSYNu9ESHn4dAHljp/OjKFVsjhQRQoswB9GPMxm+uwJatf2ce6plfy5LbicTqjBilD5ClW5Y5ToIteyYp3hXTuRlbse5rU58AEnbw0UGBNh4/Twhgx46mFsS2IVQEaxg3nixB1fjxlPX1k/L4sucHdd6+uI4h0OPqiUYgmoMgvSHsiPk1Z0WNYAow/Q2oVRqgg4MNyiUPHU5YFkiFiOBKG4PQeX+VCE1qvFyEWtZlw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1b0342-5427-4ecc-eb4a-08db76f84c8c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 10:21:41.3412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKWyvhLYlajLxEcMS3IXTXEPWQ/VtW8mRrSzWWpwMoBd9KLmjg4qCn+EQKClKPF3sXTnRbhkIxo7Q8v9Rx7rTBBRYK//M5hYUcpNt/rIPl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=428
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270095
X-Proofpoint-GUID: 6kAve-EKHLU143p2meyJO7R0v4phlLiA
X-Proofpoint-ORIG-GUID: 6kAve-EKHLU143p2meyJO7R0v4phlLiA
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

>>>  out_deregister:
>>>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>>>      if (vdev->irqchip_change_notifier.notify) {
>>>          kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
>>>      }
>>> +    vfio_disable_interrupts(vdev);
>>> +    if (vdev->intx.mmap_timer) {
>>> +        timer_free(vdev->intx.mmap_timer);
>>> +    }
>>
>> But this one suggests another one as it looks a pre-existing issue?
> Yes, it's another resource leak I just found.
> Not sure if it's better to also merge above change to this patch which is targeting resource leak issues,
> or to PATCH2 which is targeting out_deregister path, or to create a new one.
> Any suggestion?

In general they are all bugs in the same deregistration path, but each resource
is not being teardown correctly. I tend to prefer 'logical change' per commit,
so there's would be a fix the irqchip_change notifier and another one for
mmap_timer teardown. Both with the Fixes tags that introduced each bug. Unless
everything was introduced by the same change in which case you would do
everything in one patch.

