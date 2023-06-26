Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D215573DE7F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:10:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDl1u-00086a-2U; Mon, 26 Jun 2023 08:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qDl1Z-00085e-IP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:08:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qDl1W-0006V5-Lx
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:08:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QBOdlp012177; Mon, 26 Jun 2023 12:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Qa7U4C7Sqjbx9KTk78qf1vxpHd3VpNAIyow2NdY9A7w=;
 b=JjtWNpEwtQ8/+DmvPgZqw5gnuaq1CnJFmFH3R0TIM5jjD9P6S35Y64x/pXabGBAvCT+x
 lae+75FBc3Jk3VjXOHvBsH3jrC59vnm1sdG+3Os6E5H9SINmppH6cbDLHOP/G/O6nWML
 xaNmB5EE3XyYNXdVBcQB+48/MxeJqS8e6pvRWVgtuAA+q49M3PS1DUu7Y5txbTF6iYFT
 Rm9+utsRDsj6ar+po4LSkmJbLLE463RWXSKS8bX54U3zAm80lgzxPkfU8t6bGn5p/VuR
 Fd9MXfX6kJUnh3nHBVdzYFvRCTUTQXhoCge1R6ofcJUp40fQK5MWHRyvef/jvtuHxT0m xQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30tkr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 12:08:45 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QC4j29005097; Mon, 26 Jun 2023 12:08:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx906qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 12:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPE+W+jsoKGG7jF4h0Tf0grpXH8AzO2rR6XUjAOzODctlej/1Vepf7zbjx9NSa0eG9xbXTcVhaMOEHDpmSHbBudUbb1bPKApcr+9CRO2OagL7J/NLmD0WNvwEaAdn1Pz8R8lw9XQxm9ZLkvPt4xOkamuv9jVPPP+3wpzjHxhlo+CFi9GivLE2ifQcBlP0wtCfMEj1vYxAk5HM6aW/SHtpR++Sitn2sDFUWU2wqELGTfSNlOCZ1ZfAzEGxs6tgDBZn/R36odghJHlwsJCTCEqb/eXs2F36axSex1vDgdq/qN5pX3EjqxlrcXv9+mVo1SoFVSU+eXpYP1D0m4KumS14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa7U4C7Sqjbx9KTk78qf1vxpHd3VpNAIyow2NdY9A7w=;
 b=n+yqdEAFmBT3bBa4T+XT0CMnLcSw1dTaXQ9JvuixyJbM4Yek4JBYl0Vp3x8MlkjprbVvRTnaA1AD4e+AkBK3z0YWXHWaCGaNq5TzZcvNCvKX2YljmZPR+7trux1B5WRX5tJ/rys/8m65f91uoyBTTlYtEKTaksbub3UEM3s1D8TJDY6zlqFjsTYIVv1Ix2ewxnB/T87dtmOwxKANSzBms0nOAS7ixPkJLQnUrwVlK8oJj1xjMM06qLcUr5KPwIdicRRrYoAcvWUkrP8fwAd93p8F9fkd8tsFeJayZ5NYRcX/WB7C+oDGspZxXvrNWytPojdrLsOPbkowwQFdmPKFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa7U4C7Sqjbx9KTk78qf1vxpHd3VpNAIyow2NdY9A7w=;
 b=H5SP0YrOyMiUkA0ubAjiyk7Kbb5VAYBoaO02aPcfmkkT6bJ1BoPXvHAfyqSyVqpY2u/LxqQ92ciHzC+krOOqKRrBmC2mVj86j0cM5i6+9F+j3uPyZSc6s7OiXxIBC6F4giVcviCJgYRvWtvdkSctoa7mZMRlQFHD2Kk9lzmYZik=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MN0PR10MB5935.namprd10.prod.outlook.com (2603:10b6:208:3cd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 12:08:41 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::917c:eeb4:5b13:a1ef]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::917c:eeb4:5b13:a1ef%2]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 12:08:41 +0000
Content-Type: multipart/alternative;
 boundary="------------WOx2W01rDaTFKwr7I9d583Fa"
Message-ID: <f7ec13ba-25bc-e145-396f-48005a225f17@oracle.com>
Date: Mon, 26 Jun 2023 08:08:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] qmp: update virtio feature maps, vhost-user-gpio
 instrospection
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
References: <20230609132040.2180710-1-jonah.palmer@oracle.com>
 <20230609132040.2180710-3-jonah.palmer@oracle.com>
 <20230623013300-mutt-send-email-mst@kernel.org>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <20230623013300-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BL1P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::27) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MN0PR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aae1858-413e-4024-ab3a-08db763e14c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5KsCovXY6TpEJUjlpdGP2SOAz9+fdFTAdHswTrI73VTlCUIXKOtIHddEwMd0EUIVKa2xyRaWGPLv6eHInFeShMMSFA91MMfnInR88mPL98qRQNAVmBStlLkwJZbM3KkQDz4hqK1iA1EYXM+HaoMEvSiPKjaz90CMb5KN9CQSH/Zatmoo99g1GPWTEsKrKhh0GAeXONzgBixABXF8024wUKq9k3tm3UIyGfIPYC1MZ6xRHdS2DwFG6xEbQm3oyF/1TbVMwKnrDzvXgZDNbD1ENWschWaw6Jc7fHoPJeJCg8S6rZxVUJCwzU+Us4o7mDAwCDVTYp2rMvDWENCn7StTigma5xJJ6Pu1z6sMukSrfwWj4hxYjQhA8MwI369khoDdQVvj0XJaacDOeIgo8q8vH7bv4eTT0W5gYXj9lk16nuAVKDIfMW+bWP1i6TsiEU1V7M6sOu+JmIHPgAEwgyMP6F+EbH+eFiKWyGtAdjGHPK4dtTYMk4MaTjmCGjRxFojM8LoZMGqpDB6fCMS/wFhuO6NH0Zc66+3vE5UGABZWEFJXzKHBNsxfN0x+fksXDWg+7jdcNxjns2NW2e4oAky0/4CRTWn5VjfuEBZUV6MHXNRmm8E2VAWy4lRGjyoBnE4OOR+neq0P6iysqU3bUvxng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(30864003)(6486002)(33964004)(6666004)(38100700002)(2616005)(83380400001)(6512007)(6506007)(26005)(53546011)(186003)(41300700001)(31696002)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(15650500001)(44832011)(31686004)(7416002)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlBCL3ZKaDJXT3oxbHZIenk3ZzNZeTN3VEVVSkNQMEp5MFIyeko2OHYvYm50?=
 =?utf-8?B?VWY0MGgwaUh3aHp3bHNMUTNHR1BNUGdYWGpiZHh4OStSOVBhQzJ3NXBqeC9T?=
 =?utf-8?B?MUxYd3daV1BObitjb1ZRd3ZYTjdEQVRGeDVqY2ZZaXBZUGE2KzhWUER6cUxT?=
 =?utf-8?B?Wm4yYVQrY2lIYlZlLzgrdzgvZTFHWTBvMkVvL1JDNUcxNWZsbzgyM1dmYnZJ?=
 =?utf-8?B?c1pnVXR3dkdYekVZMXFsVTJiWUxUWWl1bFNQWXJSUW9aMTlxTm9mMGNETVFr?=
 =?utf-8?B?RW9aMnVYQVpPK1hyQUNxY1lYUjhXcXNESzBRYVdKS3MwakRXOXU1TFdUSXR6?=
 =?utf-8?B?SlpXNHdNVjViWWdwN0szTXZsWjN3QjZkWmpsemxWK2pqeURBUitTLzh5a2dp?=
 =?utf-8?B?bFBDVVR1enRrMklvVUswdkZNYXVGVlJ4dHo3L0o5dHl6SWc0ZVBTeHVZRzFr?=
 =?utf-8?B?dGZ2K05jRTJHUjVHc3FiVHU2eExvaE5XN0x3cy9ZUjlTZHNjTDYzb3VDZTVl?=
 =?utf-8?B?Tm1pWW1OVXFsY1RFNmhsNE5mMGlYWTdwOHNENzVUR3AvQnVmYjRJdkpVUE95?=
 =?utf-8?B?M3dRVDRGZzd4WUZGU2pqYUZHRVJkV3N4L3dqVU4wa1NVVXIzdlBkb2Qxbnlq?=
 =?utf-8?B?ZzN0dEVwbnFVVjFiek8zMHRUTVlqN2VTN21GRjBIcjhDV0l5d2l2bjhwcHl3?=
 =?utf-8?B?T1cxWlVDOTB0UWF6UmlRa3RWZlJYM0pJRThFblFsUGdYZ09aTW5CWktXcWhL?=
 =?utf-8?B?NS9LT2Fkb0Rvb3hqMk8vYSt1REl1cWVmU0hvaElSVi9FWkFBY0N2TDNWOW4r?=
 =?utf-8?B?bW5WWGE1Y3BOSnI4UCs4ZmlvT1pQd085amJRRDA5cE9QcGwwR1FJNW9QS1Zy?=
 =?utf-8?B?bk43dDQzdGJqdVFoSnhMRFk0VEpXQkY4M01XMG1yejF5ZFFMTFZuVjg5OE1R?=
 =?utf-8?B?OW5aWFFkdGlJZDFGaWdybzBrSVdSckcvVlJtaW5QTnpjYnIvTWtTbks1eDcy?=
 =?utf-8?B?aTNyRHlhaCs2cHFsSmw4WVNrM3FlOWV4Z1FxMjlCcWN3eUsvV0RFZDdjN1pW?=
 =?utf-8?B?c2tmZGRnWnJSc3plTzI3OU1sckRDVGhOMTdCQWt6VWNOOUoyU1FqNmluUmJz?=
 =?utf-8?B?eVVKSXRJRCttLzJheDB2cUlhak1BWHBETkYvTTNwZnZ0UUthL0l6dVlQbVR1?=
 =?utf-8?B?RHRBSjIyVmVGYUtQU1ZQN2xnbTg2bm9VN2huSnJ0d2djWVY0OGUrVDVWcFpE?=
 =?utf-8?B?dlNzbmJvNElFN0plc3c4TGRoVnpNOXEweDhMRk5LZWFUTVNSQVNkZjJXMGRZ?=
 =?utf-8?B?SDFNSWRnMXhWRzVPSUNIbzZqR0tWeVoxa3d1ZEcydGVFeXlWUlMxYkYwRExz?=
 =?utf-8?B?eG81eDZDOFByblZ2em81am1rd1FCVlhCaEx1RW9YVlI1bVJHVGF5NDN5VDRz?=
 =?utf-8?B?Q09LcHZWakVhWlNWK2JZQlJMdzNTZER2WHVFZXdZSnBERDMvV0FDZWI5SWh3?=
 =?utf-8?B?UDVJSlJlSUJudXFaU1FseFVPYWluSVVjc1lYb1pLR2hlY1cvMXRQUy84UTFs?=
 =?utf-8?B?WnA5cVI1K0RLT3lURTFPaTRiOEpUSEJwaTkyYzJ1NGxGbnNXUmcvb0pXUEVo?=
 =?utf-8?B?YlNGQVlOTmd4bDFoN0xtV1RXMHdYc2hWN2VuODR6UlRRdXlTTVpZbm56TDVo?=
 =?utf-8?B?RU5PQUxhSzlwQ3g1eVByOERRalh5ZTBydWEyNGZtZXkvR0w4b1B3Ymk2Z2lZ?=
 =?utf-8?B?aXNxYXhiTlJmRkZKQ3RXblRoZStWM25iNkVxNTJvRGZXaEo0MlpXeFVsR013?=
 =?utf-8?B?Q0doYUxXM0kwdVN4NHFnYUlKM1VZQnJtRW03Y2hRNzVYd2Z4VThSYWVLRWlT?=
 =?utf-8?B?VnFEVFdqVnVhV0lrTldBV2RJaDFNTHBTMzJUQ1BHQ0dObGl1MFhLbkF6RVFK?=
 =?utf-8?B?NGlZTDVpbGNJQkp0azZEbTM5VzlnSGErMGkrTmpycHk2V2NRbEtKZlMvSGRO?=
 =?utf-8?B?TjQ0YWNNSytxbXdhbTIrZ1htYkllT092M3BpMkZGV0dNbEdaWEJFbFh3MjI5?=
 =?utf-8?B?a2Ntd0pUU0xxNE5xaDRrZFlLcG5ZZ010cVdOMUUxYlpDY1Q3MUNYS0dlNG03?=
 =?utf-8?Q?TiWvxUCOVnOGsNqNPb5dE3znA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KbiqXoZN/ECqGzgj7VMWCo4pNZJVgicsqBCLx4YwqErAy/oLlBKUJwz8O+rse2AxYSCy3AYvJ0IgNTvYFOcYCXLExoaVqbwZmPL5CTbUqew1ejC/zsHqpOuuRhuAcwYVehaZzfhcIs/RnzefOx2+XidK8g0iNyZrU128OaE4zjs1CpHI24bQG6tCNB2XpjrB6BubFqApl5m5f3NNvnc2jSKGiHnVA+7KhL1QXebSh3kvYMVfUlIXHoDXXjC/jcCGI7pYclFaP/eQ/wGC3YJBhJU+yRst4J1kZnp56aYz/EQUAEhYMT5ALh7oeeqG2mLK+IiD3u2/9ac0bWOWTwYIqvAwuQHuXIIim2UbJDzRUfANf7PCD6uK/qRfWFzNZcozjXklt/fSq10fkYffUzl3p7z59blA9LJ3hjmu1dpGqkaMiq9PtqdfdPuhKydyTwZ1b1c2TweeARt/n7BeKYTQbQth1iSuiVm5K5yIcmnou4kNOgBc9a0NVPCYrRfufTW9e567f4ey3wtOWpI3tiEht+yUCTvJH3jDNxc7veELe25Q4N362bRGZSjwajkhG6MUNAVRCUIvj6xt/6c/AWOJDGt9RF7NIoGOlYFRYsjrbvPtXiuKqsxE+xXXEbblEuRQLyRIbOSCiJQ1wqUnQYZlmJ2kfL6j9NHtjlxJG+AgYsN3YCpaDBwGntUAtX29SszQ2bQeJpMV8hmp3k4sjiS2c+xn+OqcY0yoZs7CJnvGfyGQRiVkNBBU5W5AdpVkU1Z1X39eMsvEHVDRT0z1Pt0U+2Y5MK2nV5Z/H+10Bd7d2uHwpzxTsTtxOup1+aLKWvEMTElJRiPll1ACEwMLSHR+JGF3lrWV5ADdIwjCWwMRH7cW6/SddaA/Z7hnRr3L/j7f
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aae1858-413e-4024-ab3a-08db763e14c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:08:41.2884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLT3fuToMuBUhFd8LO3JJuSvl+yQ7erZkIdWw+yIMfEJI+ACH1aUXyNZfmRSdW+cB6s7ClR3TDh8mEtMRqIfJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_09,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260109
X-Proofpoint-ORIG-GUID: xhMn4hm6aGrVd21v9hWAPbG-N835sAAl
X-Proofpoint-GUID: xhMn4hm6aGrVd21v9hWAPbG-N835sAAl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
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

--------------WOx2W01rDaTFKwr7I9d583Fa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/23 01:43, Michael S. Tsirkin wrote:

> On Fri, Jun 09, 2023 at 09:20:40AM -0400, Jonah Palmer wrote:
>> Add new virtio transport feature to transport feature map:
>>   - VIRTIO_F_RING_RESET
>>
>> Add new vhost-user protocol feature to vhost-user protocol feature map
>> and enumeration:
>>   - VHOST_USER_PROTOCOL_F_STATUS
>>
>> Add new virtio device features for several virtio devices to their
>> respective feature mappings:
>>
>> virtio-blk:
>>   - VIRTIO_BLK_F_SECURE_ERASE
>>
>> virtio-net:
>>   - VIRTIO_NET_F_NOTF_COAL
>>   - VIRTIO_NET_F_GUEST_USO4
>>   - VIRTIO_NET_F_GUEST_USO6
>>   - VIRTIO_NET_F_HOST_USO
>>
>> virtio/vhost-user-gpio:
>>   - VIRTIO_GPIO_F_IRQ
>>   - VHOST_F_LOG_ALL
>>   - VHOST_USER_F_PROTOCOL_FEATURES
>>
>> virtio-bt:
>>   - VIRTIO_BT_F_VND_HCI
>>   - VIRTIO_BT_F_MSFT_EXT
>>   - VIRTIO_BT_F_AOSP_EXT
>>   - VIRTIO_BT_F_CONFIG_V2
>>
>> virtio-scmi:
>>   - VIRTIO_SCMI_F_P2A_CHANNELS
>>   - VIRTIO_SCMI_F_SHARED_MEMORY
>>
>> Add support for introspection on vhost-user-gpio devices.
>>
>> Signed-off-by: Jonah Palmer<jonah.palmer@oracle.com>
> Thanks for the patch! Some comments:
>
>
>> ---
>>   hw/virtio/vhost-user-gpio.c |  7 ++++
>>   hw/virtio/virtio-qmp.c      | 79 +++++++++++++++++++++++++++++++++++--
>>   2 files changed, 83 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
>> index d6927b610a..e88ca5370f 100644
>> --- a/hw/virtio/vhost-user-gpio.c
>> +++ b/hw/virtio/vhost-user-gpio.c
>> @@ -205,6 +205,12 @@ static void vu_gpio_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
>>       vhost_virtqueue_mask(&gpio->vhost_dev, vdev, idx, mask);
>>   }
>>   
>> +static struct vhost_dev *vu_gpio_get_vhost(VirtIODevice *vdev)
>> +{
>> +    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
>> +    return &gpio->vhost_dev;
>> +}
>> +
>>   static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserGPIO *gpio)
>>   {
>>       virtio_delete_queue(gpio->command_vq);
>> @@ -413,6 +419,7 @@ static void vu_gpio_class_init(ObjectClass *klass, void *data)
>>       vdc->get_config = vu_gpio_get_config;
>>       vdc->set_status = vu_gpio_set_status;
>>       vdc->guest_notifier_mask = vu_gpio_guest_notifier_mask;
>> +    vdc->get_vhost = vu_gpio_get_vhost;
>>   }
>>   
>>   static const TypeInfo vu_gpio_info = {
>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>> index e936cc8ce5..140c420d87 100644
>> --- a/hw/virtio/virtio-qmp.c
>> +++ b/hw/virtio/virtio-qmp.c
>> @@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
>>       VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
>>       VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>>       VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>> +    VHOST_USER_PROTOCOL_F_STATUS = 16,
>>       VHOST_USER_PROTOCOL_F_MAX
>>   };
>>
> OMG I just realized that by now we have accumulated each value
> in 4 places! This is really badly asking to be moved
> to a header. Not sure what to do about the document yet
> but that will at least get us down to two.
>    

I can add this in another patch as a part of this series.

>> @@ -79,6 +80,8 @@ static const qmp_virtio_feature_map_t virtio_transport_map[] = {
>>               "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
>>       FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
>>               "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
>> +    FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
>> +            "VIRTIO_F_RING_RESET: Driver can reset individual VQs"),
>>       /* Virtio ring transport features */
>>       FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
>>               "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
>> @@ -134,6 +137,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
>>       FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
>>               "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
>>               "memory slots supported"),
>> +    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
>> +            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
>> +            "device statuses supported"),
> status - there's only one per device

Will change, thanks!

>>       { -1, "" }
>>   };
>>   
>> @@ -176,6 +182,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
>>               "VIRTIO_BLK_F_DISCARD: Discard command supported"),
>>       FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
>>               "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
>> +    FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
>> +            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
>>       FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
>>               "VIRTIO_BLK_F_ZONED: Zoned block devices"),
>>   #ifndef VIRTIO_BLK_NO_LEGACY
>> @@ -299,6 +307,14 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>>       FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
>>               "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control "
>>               "channel"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
>> +            "VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
>> +            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
>> +            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
>> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
>> +            "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
>>       FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
>>               "VIRTIO_NET_F_HASH_REPORT: Hash reporting supported"),
>>       FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
>> @@ -469,6 +485,48 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
>>   };
>>   #endif
>>   
>> +/* virtio/vhost-gpio features mapping */
>> +#ifdef CONFIG_VIRTIO_GPIO
> Where's this coming from?
>
Ah, this should probably be CONFIG_VHOST_USER_GPIO instead I believe.

As for the other two...

>> +static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
>> +    FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
>> +            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
>> +    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
>> +            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
>> +    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
>> +            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
>> +            "negotiation supported"),
>> +    { -1, "" }
>> +};
>> +#endif
>> +
>> +/* virtio-bluetooth features mapping */
>> +#ifdef CONFIG_VIRTIO_BT
> Where's this coming from?
>
This is coming from... nowhere!

My apologies. I forgot to check if any of these virtio devices were
actually being declared as objects (via. OBJECT_DECLARE_SIMPLE_TYPE).

I will revert these changes for virtio-bt & virtio-scmi and be more
careful to check for these in the future. Thank you for pointing this
out.

>> +static const qmp_virtio_feature_map_t virtio_bt_feature_map[] = {
>> +    FEATURE_ENTRY(VIRTIO_BT_F_VND_HCI, \
>> +            "VIRTIO_BT_F_VND_HCI: Vendor command supported"),
>> +    FEATURE_ENTRY(VIRTIO_BT_F_MSFT_EXT, \
>> +            "VIRTIO_BT_F_MSFT_EXT: MSFT vendor supported"),
>> +    FEATURE_ENTRY(VIRTIO_BT_F_AOSP_EXT, \
>> +            "VIRTIO_BT_F_AOSP_EXT: AOSP vendor supported"),
>> +    FEATURE_ENTRY(VIRTIO_BT_F_CONFIG_V2, \
>> +            "VIRTIO_BT_F_CONFIG_V2: Using v2 configuration"),
>> +    { -1, "" }
>> +};
>> +#endif
>> +
>> +/* virtio-scmi features mapping */
>> +#ifdef CONFIG_VIRTIO_SCMI
> Where's this coming from?

Will revert this. See comment above.

>> +static const qmp_virtio_feature_map_t virtio_scmi_feature_map[] = {
>> +    FEATURE_ENTRY(VIRTIO_SCMI_F_P2A_CHANNELS, \
>> +            "VIRTIO_SCMI_F_P2A_CHANNELS: SCMI notifications or delayed "
>> +            "responses implemented"),
>> +    FEATURE_ENTRY(VIRTIO_SCMI_F_SHARED_MEMORY, \
>> +            "VIRTIO_SCMI_F_SHARED_MEMORY: SCMI shared memory region statistics "
>> +            "implemented"),
>> +    { -1, "" }
>> +};
>> +#endif
>> +
>>   #define CONVERT_FEATURES(type, map, is_status, bitmap)   \
>>       ({                                                   \
>>           type *list = NULL;                               \
>> @@ -625,6 +683,24 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>>           features->dev_features =
>>               CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
>>           break;
>> +#endif
>> +#ifdef CONFIG_VIRTIO_GPIO
>> +    case VIRTIO_ID_GPIO:
>> +        features->dev_features =
>> +            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
>> +        break;
>> +#endif
>> +#ifdef CONFIG_VIRTIO_BT
>> +    case VIRTIO_ID_BT:
>> +        features->dev_features =
>> +            CONVERT_FEATURES(strList, virtio_bt_feature_map, 0, bitmap);
>> +        break;
>> +#endif
>> +#ifdef CONFIG_VIRTIO_SCMI
>> +    case VIRTIO_ID_SCMI:
>> +        features->dev_features =
>> +            CONVERT_FEATURES(strList, virtio_scmi_feature_map, 0, bitmap);
>> +        break;
>>   #endif
>>       /* No features */
>>       case VIRTIO_ID_9P:
>> @@ -640,18 +716,15 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>>       case VIRTIO_ID_SIGNAL_DIST:
>>       case VIRTIO_ID_PSTORE:
>>       case VIRTIO_ID_SOUND:
>> -    case VIRTIO_ID_BT:
>>       case VIRTIO_ID_RPMB:
>>       case VIRTIO_ID_VIDEO_ENCODER:
>>       case VIRTIO_ID_VIDEO_DECODER:
>> -    case VIRTIO_ID_SCMI:
>>       case VIRTIO_ID_NITRO_SEC_MOD:
>>       case VIRTIO_ID_WATCHDOG:
>>       case VIRTIO_ID_CAN:
>>       case VIRTIO_ID_DMABUF:
>>       case VIRTIO_ID_PARAM_SERV:
>>       case VIRTIO_ID_AUDIO_POLICY:
>> -    case VIRTIO_ID_GPIO:
>>           break;
>>       default:
>>           g_assert_not_reached();
>> -- 
>> 2.39.3
--------------WOx2W01rDaTFKwr7I9d583Fa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>
</pre>
    <div class="moz-cite-prefix">
      <pre>On 6/23/23 01:43, Michael S. Tsirkin wrote:</pre>
    </div>
    <blockquote type="cite" cite="mid:20230623013300-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Fri, Jun 09, 2023 at 09:20:40AM -0400, Jonah Palmer wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add new virtio transport feature to transport feature map:
 - VIRTIO_F_RING_RESET

Add new vhost-user protocol feature to vhost-user protocol feature map
and enumeration:
 - VHOST_USER_PROTOCOL_F_STATUS

Add new virtio device features for several virtio devices to their
respective feature mappings:

virtio-blk:
 - VIRTIO_BLK_F_SECURE_ERASE

virtio-net:
 - VIRTIO_NET_F_NOTF_COAL
 - VIRTIO_NET_F_GUEST_USO4
 - VIRTIO_NET_F_GUEST_USO6
 - VIRTIO_NET_F_HOST_USO

virtio/vhost-user-gpio:
 - VIRTIO_GPIO_F_IRQ
 - VHOST_F_LOG_ALL
 - VHOST_USER_F_PROTOCOL_FEATURES

virtio-bt:
 - VIRTIO_BT_F_VND_HCI
 - VIRTIO_BT_F_MSFT_EXT
 - VIRTIO_BT_F_AOSP_EXT
 - VIRTIO_BT_F_CONFIG_V2

virtio-scmi:
 - VIRTIO_SCMI_F_P2A_CHANNELS
 - VIRTIO_SCMI_F_SHARED_MEMORY

Add support for introspection on vhost-user-gpio devices.

Signed-off-by: Jonah Palmer <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com">&lt;jonah.palmer@oracle.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Thanks for the patch! Some comments:


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 hw/virtio/vhost-user-gpio.c |  7 ++++
 hw/virtio/virtio-qmp.c      | 79 +++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-gpio.c b/hw/virtio/vhost-user-gpio.c
index d6927b610a..e88ca5370f 100644
--- a/hw/virtio/vhost-user-gpio.c
+++ b/hw/virtio/vhost-user-gpio.c
@@ -205,6 +205,12 @@ static void vu_gpio_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
     vhost_virtqueue_mask(&amp;gpio-&gt;vhost_dev, vdev, idx, mask);
 }
 
+static struct vhost_dev *vu_gpio_get_vhost(VirtIODevice *vdev)
+{
+    VHostUserGPIO *gpio = VHOST_USER_GPIO(vdev);
+    return &amp;gpio-&gt;vhost_dev;
+}
+
 static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserGPIO *gpio)
 {
     virtio_delete_queue(gpio-&gt;command_vq);
@@ -413,6 +419,7 @@ static void vu_gpio_class_init(ObjectClass *klass, void *data)
     vdc-&gt;get_config = vu_gpio_get_config;
     vdc-&gt;set_status = vu_gpio_set_status;
     vdc-&gt;guest_notifier_mask = vu_gpio_guest_notifier_mask;
+    vdc-&gt;get_vhost = vu_gpio_get_vhost;
 }
 
 static const TypeInfo vu_gpio_info = {
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index e936cc8ce5..140c420d87 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_RESET_DEVICE = 13,
     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
+    VHOST_USER_PROTOCOL_F_STATUS = 16,
     VHOST_USER_PROTOCOL_F_MAX
 };

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
OMG I just realized that by now we have accumulated each value
in 4 places! This is really badly asking to be moved
to a header. Not sure what to do about the document yet
but that will at least get us down to two.
  </pre>
    </blockquote>
    <pre>I can add this in another patch as a part of this series.
</pre>
    <blockquote type="cite" cite="mid:20230623013300-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">@@ -79,6 +80,8 @@ static const qmp_virtio_feature_map_t virtio_transport_map[] = {
             &quot;VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform&quot;),
     FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
             &quot;VIRTIO_F_SR_IOV: Device supports single root I/O virtualization&quot;),
+    FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
+            &quot;VIRTIO_F_RING_RESET: Driver can reset individual VQs&quot;),
     /* Virtio ring transport features */
     FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
             &quot;VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported&quot;),
@@ -134,6 +137,9 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
     FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
             &quot;VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for &quot;
             &quot;memory slots supported&quot;),
+    FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
+            &quot;VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end &quot;
+            &quot;device statuses supported&quot;),
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
status - there's only one per device
</pre>
    </blockquote>
    <pre>Will change, thanks!
</pre>
    <blockquote type="cite" cite="mid:20230623013300-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">     { -1, &quot;&quot; }
 };
 
@@ -176,6 +182,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             &quot;VIRTIO_BLK_F_DISCARD: Discard command supported&quot;),
     FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
             &quot;VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported&quot;),
+    FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
+            &quot;VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported&quot;),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
             &quot;VIRTIO_BLK_F_ZONED: Zoned block devices&quot;),
 #ifndef VIRTIO_BLK_NO_LEGACY
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">@@ -299,6 +307,14 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
             &quot;VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control &quot;
             &quot;channel&quot;),
+    FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
+            &quot;VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications&quot;),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
+            &quot;VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4&quot;),
+    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
+            &quot;VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6&quot;),
+    FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
+            &quot;VIRTIO_NET_F_HOST_USO: Device can receive USO&quot;),
     FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
             &quot;VIRTIO_NET_F_HASH_REPORT: Hash reporting supported&quot;),
     FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
@@ -469,6 +485,48 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
 };
 #endif
 
+/* virtio/vhost-gpio features mapping */
+#ifdef CONFIG_VIRTIO_GPIO
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Where's this coming from?

</pre>
    </blockquote>
    <pre>Ah, this should probably be CONFIG_VHOST_USER_GPIO instead I believe.

As for the other two...
</pre>
    <blockquote type="cite" cite="mid:20230623013300-mutt-send-email-mst@kernel.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
+            &quot;VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines&quot;),
+    FEATURE_ENTRY(VHOST_F_LOG_ALL, \
+            &quot;VHOST_F_LOG_ALL: Logging write descriptors supported&quot;),
+    FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
+            &quot;VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features &quot;
+            &quot;negotiation supported&quot;),
+    { -1, &quot;&quot; }
+};
+#endif
+
+/* virtio-bluetooth features mapping */
+#ifdef CONFIG_VIRTIO_BT
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Where's this coming from?

</pre>
    </blockquote>
    <pre>This is coming from... nowhere!

My apologies. I forgot to check if any of these virtio devices were
actually being declared as objects (via. OBJECT_DECLARE_SIMPLE_TYPE).

I will revert these changes for virtio-bt &amp; virtio-scmi and be more
careful to check for these in the future. Thank you for pointing this
out.
</pre>
    <blockquote type="cite" cite="mid:20230623013300-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static const qmp_virtio_feature_map_t virtio_bt_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_BT_F_VND_HCI, \
+            &quot;VIRTIO_BT_F_VND_HCI: Vendor command supported&quot;),
+    FEATURE_ENTRY(VIRTIO_BT_F_MSFT_EXT, \
+            &quot;VIRTIO_BT_F_MSFT_EXT: MSFT vendor supported&quot;),
+    FEATURE_ENTRY(VIRTIO_BT_F_AOSP_EXT, \
+            &quot;VIRTIO_BT_F_AOSP_EXT: AOSP vendor supported&quot;),
+    FEATURE_ENTRY(VIRTIO_BT_F_CONFIG_V2, \
+            &quot;VIRTIO_BT_F_CONFIG_V2: Using v2 configuration&quot;),
+    { -1, &quot;&quot; }
+};
+#endif
+
+/* virtio-scmi features mapping */
+#ifdef CONFIG_VIRTIO_SCMI
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Where's this coming from?
</pre>
    </blockquote>
    <pre>Will revert this. See comment above.
</pre>
    <blockquote type="cite" cite="mid:20230623013300-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static const qmp_virtio_feature_map_t virtio_scmi_feature_map[] = {
+    FEATURE_ENTRY(VIRTIO_SCMI_F_P2A_CHANNELS, \
+            &quot;VIRTIO_SCMI_F_P2A_CHANNELS: SCMI notifications or delayed &quot;
+            &quot;responses implemented&quot;),
+    FEATURE_ENTRY(VIRTIO_SCMI_F_SHARED_MEMORY, \
+            &quot;VIRTIO_SCMI_F_SHARED_MEMORY: SCMI shared memory region statistics &quot;
+            &quot;implemented&quot;),
+    { -1, &quot;&quot; }
+};
+#endif
+
 #define CONVERT_FEATURES(type, map, is_status, bitmap)   \
     ({                                                   \
         type *list = NULL;                               \
@@ -625,6 +683,24 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
         features-&gt;dev_features =
             CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
         break;
+#endif
+#ifdef CONFIG_VIRTIO_GPIO
+    case VIRTIO_ID_GPIO:
+        features-&gt;dev_features =
+            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_BT
+    case VIRTIO_ID_BT:
+        features-&gt;dev_features =
+            CONVERT_FEATURES(strList, virtio_bt_feature_map, 0, bitmap);
+        break;
+#endif
+#ifdef CONFIG_VIRTIO_SCMI
+    case VIRTIO_ID_SCMI:
+        features-&gt;dev_features =
+            CONVERT_FEATURES(strList, virtio_scmi_feature_map, 0, bitmap);
+        break;
 #endif
     /* No features */
     case VIRTIO_ID_9P:
@@ -640,18 +716,15 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
     case VIRTIO_ID_SIGNAL_DIST:
     case VIRTIO_ID_PSTORE:
     case VIRTIO_ID_SOUND:
-    case VIRTIO_ID_BT:
     case VIRTIO_ID_RPMB:
     case VIRTIO_ID_VIDEO_ENCODER:
     case VIRTIO_ID_VIDEO_DECODER:
-    case VIRTIO_ID_SCMI:
     case VIRTIO_ID_NITRO_SEC_MOD:
     case VIRTIO_ID_WATCHDOG:
     case VIRTIO_ID_CAN:
     case VIRTIO_ID_DMABUF:
     case VIRTIO_ID_PARAM_SERV:
     case VIRTIO_ID_AUDIO_POLICY:
-    case VIRTIO_ID_GPIO:
         break;
     default:
         g_assert_not_reached();
-- 
2.39.3
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------WOx2W01rDaTFKwr7I9d583Fa--

