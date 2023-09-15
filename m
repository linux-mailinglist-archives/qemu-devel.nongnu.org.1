Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 999027A1D7E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:33:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh73W-0005jW-L2; Fri, 15 Sep 2023 07:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qh73T-0005bw-Ir
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:32:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qh73R-0000ud-0E
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:32:11 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38FAvvEJ029176; Fri, 15 Sep 2023 11:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=2Ty4oC5/X2FalJdBgwYDcB/J60GCbdpdGs3Fg1lcNko=;
 b=UxEHPJrIE0a0w14WbiHoewqNAwAx1qUx2Jl5NHtv6A05eU0urttTxiXc1+6wYIO+Mh7X
 wWdp9o+1/P+X7A5i3kAZIdQvTTofnsveP2cQ5FERr91vvPtQir5QHAp2YF+yzFfhJWq/
 HnBgGSwpDNhdC0VbMR1NlkyYPAXiCxBkos8l0GGsufOXY9oGlOl/tROFcSvjm+Y6PKYl
 1hLDgyVJ9Jq9n9ebQuOACS2jUJd/ZDWqMBjzuoArSVNQPuY0pF7rFfE+rShz4Y3wj76l
 1488xg8oE6uOcOUA58v07wbSsJ8TNSOqw5OuMO7iGzzRadCQq1S0TqLkKuQ35bbt1e7X Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rfp1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 11:32:05 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38FBSLfx003095; Fri, 15 Sep 2023 11:32:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f59y7ve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 11:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNtnLj1ykE2cugmFKhBPxu3rUfHJpCxUuMID7WYog10zdJ1GKbJnT7YuXLyrl26w0GU0DMttfKwYS5h6evZI64Vy4kjkEkJx8AC95jGvYymbmAn7hrXZpfVgtW2c2brTIQcFYzHTHrwcfqIK3RsxspZwC3Ea6ldaQXF0XDgmVAkI+TpOu6PA0UXEtmV8aJhFBKtZOpN+bDMjhjWo3CMoIAFc2rGIydDW2jX8sT7N7NZIdpPWlizYlqS141+b+DqObWzv6mokUcfqm9sXZCzR0yZjDGj3BuES/PcSJU1KalSr3udV2DME4gu/S+epkiMM3XxPHKL7KAJCB7dOz2ggdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ty4oC5/X2FalJdBgwYDcB/J60GCbdpdGs3Fg1lcNko=;
 b=lPlKuG/YEnn4am7+W+17RnxhuYtpusjQLpqsrIggP56hvwda9gSMz/VDd2Nc54yKimz+Ct00iZEGQOsyzIXOlXbeG3ACEF0RDA2QQvil3MQEO9Xn08hae8bqrVsFuW9wcvCge3HBPUZ42m3UgsjT7MbaXxvhUeb+y2/jYEmqdVYowGSPgTkzf0B+Rs9hHpqpz0RQy9B1Kr/xGNSScKgWo/uGgN6TArFv0XJSXfaf6eiDxZPNOrin2B1aAxzV55Z4j2jI7M39ls+VxTtPJ9jYkWkdV0W/s7samw+s3aZUHK6u/9jpBgzUDukAfAkoiTFiAUcTevPPbUciy5IPkrvVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ty4oC5/X2FalJdBgwYDcB/J60GCbdpdGs3Fg1lcNko=;
 b=K8V5Z3Sk4tROTkPcezERaKridpiKAywPAfL79oboMJQw2W/amGbyY5YIpO+Hlt2V/R/8zppl16vN32x2O9+suRNNx4Rhe1sO8E74ZYnxkb829DRzJ6ohKiCTH1YsxaE5joKuI329lPBn08ZD1JlmEkU9xvq9PtwWfKWc5MzbZmc=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 11:32:02 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 11:32:01 +0000
Content-Type: multipart/mixed; boundary="------------9S4bMZpAGIM8CRxWPJ1j8Zds"
Message-ID: <e8b7b4d2-7185-9ba6-6122-4fa780a08427@oracle.com>
Date: Fri, 15 Sep 2023 13:31:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Content-Language: en-US, fr
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 lidongchen@tencent.com
References: <ZQCxg+M2IpecRT8w@x1n>
 <20230914202054.3551250-1-william.roche@oracle.com>
 <20230914202054.3551250-2-william.roche@oracle.com>
 <60d3efa1-d2eb-8e11-8909-eb1ef33204c5@fujitsu.com>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <60d3efa1-d2eb-8e11-8909-eb1ef33204c5@fujitsu.com>
X-ClientProxiedBy: LO4P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::21) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: e18ade47-51b6-456b-b7b3-08dbb5df614a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4j4HMSbrBjwb3JcZ+BB7f/UktakOydt/FLERLTFiFI0t2/wCf/uPucPBn3MD5WRjQojTk+mEgTCNIqQgqyxG7Aed28KwaM+iNeFeQsINIQ8JgANCtDRoiOzoH67UCfDHoMKNmMBdipaM43KXUXPZ2CJuwzMyBxuWcNj7xhJip3NDbeO2bKgJ+NcY4mEjHbp88h7MaDMopQ2XZoQXZMxSVSkt1ATojqhjTQh/q7A+HGMfM7ZbEPnSmLiYGLUw7ZClCtqmQI9Q5hNDIyV+Chx5sLs5imO4v0xigwlbXCDqp+e8wZLoOV52LKDWFu1hwbucwJxrUsAcpGMZndgsoM2VUad5/1GP3z8ejH8yDo17yMoynJ8cD3fOT7gc1YHRhm97BH1BfeYmD4OHpB8kOrsXVwKrUw2+zqU3skMEDMzvhUA9ndSosEvQKriRWZXDPYxbCksmVV1eNs+w4OWzLAMFC/Xh+cPlmerjcPUSLLeRLeSNJBS+RFzttV98A36hOnGZBPDRty1JbvtpXkSUYPIcacjaQ6Y3c5teFVX9ND8meQzG/DWdJQgDbnI5pUAevORN7JagTjwQxZbcKXbXZ/ajmHrrNfaVXZ6XEuZXm0glho/tXluJ+yJh8KZ0M4yefx91QQniU4sgKF7KE+fdKx6KjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(1800799009)(451199024)(186009)(6512007)(6666004)(33964004)(8676002)(6486002)(6506007)(2616005)(26005)(86362001)(53546011)(8936002)(4326008)(44832011)(235185007)(5660300002)(31696002)(2906002)(110136005)(41300700001)(316002)(36756003)(66476007)(66946007)(54906003)(66556008)(38100700002)(478600001)(31686004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpFVVVOT2pSMmxJZk5MS3NvZFFLMEc1MFB3bnVudlQ2K3lPUHh6eEJIT2d3?=
 =?utf-8?B?R0djQklnSHk5d25tRzRyc3I5VDgwVjZLL0cxV0tNVFVJdGpNYWZPalBTOW5w?=
 =?utf-8?B?WEsxZWpmSkYwK0thNzhqNXIyWDczeEE4NkZjakc5S1Bzc1dhelhhSW5oUlhr?=
 =?utf-8?B?Ti93NnhTNER5S3Izdk54eWtyUGd2ZW56NENpNG9HOGJoREpNdG40eEd5T2ZM?=
 =?utf-8?B?Qm1DZXZ2alNsRTBqUTNteXhCc3RWRjZYZGNvNkRSMTRJT0g5cVVpeXdFZnVu?=
 =?utf-8?B?UnFtRzBVZXY5TTVQZlZheVB0eDNFN1RwM3FGNTgyR2NTRUpxTnBwaUdnU0Mv?=
 =?utf-8?B?Qmlqcmk5SmlXcDRHRE1UeG9GVUFuWXNCMDNweGUxelZEOTFabmJyajZqS1lJ?=
 =?utf-8?B?eDlLNWl4ZEhRNEZDdGRNTzJRcFRTZXI5NWJ3VFZvUjJ0cGZkUmN3UEo4NmNG?=
 =?utf-8?B?M0dheGRJMEE0cjZuWG1qZnM2K3BqQlJiaElmd0RSWWxrTThLY1hHS2Y4a0h2?=
 =?utf-8?B?RE11cG1KbzQvVjJLK014OEVSSjVYWHova3JTOFpBaEtjNmpVT0JKR0k0QzBj?=
 =?utf-8?B?WnlRYUNKZWorZlFnZmNVdHplOUpUdFdTTGhqUm1keWtJQ3hoaTNZR2JHOGdD?=
 =?utf-8?B?a1FZV0Y1b1ZYZHYyODZSUUVNVVQwUU5GTXZzaHlTZG5Dcm5ENW1zL0Fvb280?=
 =?utf-8?B?ZDd6cjlROC9JQmkxdTJiN0lXcit6dGV4RGtGWmZHWjhjNURiYmVkbXA4YWcx?=
 =?utf-8?B?c1VuMVIzZ2c4SmVENlNGOHAzU0VEY2JmS1hPdmlEYVU3LzFGMDNLNGRON3RT?=
 =?utf-8?B?S2lpbFpTZ1Z4dzdzcDNjd2FzR0JuSGw1VDBhN05sNFIxMFpaZkxWY0hkNjl5?=
 =?utf-8?B?NkM4VGN0L0FQaFpUREl3dVZ0NE54ZnZ3RFM0MG8rMnRCQ1ZFc3YwRDFWWjRC?=
 =?utf-8?B?MDhpVnl3RHdxeVJXcHM1c0lrNGNwOE5oSXhqN1FYOTN3dER1WTdVZ0ZTVjBx?=
 =?utf-8?B?eWdZVWtDU1BwdHgxZGVOYlNNc3p4RUYxN1BGdFFzcnpwcW9ja3JwdFJtZVl2?=
 =?utf-8?B?Sm5hWGpPM0tQbWh0MXV5ejhBWXA0Z2drZ280ZkxNTkdjM08vLzVOQWVycGZF?=
 =?utf-8?B?TGxSVTdKUFdlMGJiUDZ6TnpkTUpsMSt0dDFxNHBzUkRJcEczSHhJbEg3MFNa?=
 =?utf-8?B?ZTJhc0hrZFFId2hDS3VEVjYvYzNmcEl1ZVp2QnVsaHN4SG92d01nYStJR2Fz?=
 =?utf-8?B?THFQeHVRaWx6MkF0YjU1Q0NCYTNsS0tqZDZidnl5UnZ5QW9MdDVBeUZ0SGxn?=
 =?utf-8?B?aHZ3cElWT0JvZG5uQnZMcnQ5eXFSM2RaMy9qeDRnRTNFaDlUNmdadzE0NW40?=
 =?utf-8?B?Mmd5b0tyRUNwS1oyMEFqOTFhNmVKcVViMDdUbW1LVmhBNk5IclBWOHlsaWtX?=
 =?utf-8?B?RVd4Y09XL0tKRXNuNk92RFNCN0RsRjNUTENPMXZTL0RFVldscWVBRlJXTDRq?=
 =?utf-8?B?Qm04anNkZkwzL25xRG80MmI4OXh6OFZtZmRiRXlFT2dHMFZvTC8rVi9xRVY5?=
 =?utf-8?B?NG54VURNMWk3cEdjdE12eFp4TXZ0ek1wVHNTTEFEc3FaMjMwMFlUTktrRlJp?=
 =?utf-8?B?S3d1aHBPRUdmOTlQaDZKNExPN2xvWmV2ZUQ4emVnTXNDK2JqdEl1dFc2T2xm?=
 =?utf-8?B?RjRLSU9KNnNZcmFPcldCZTBxT0JNUVJQaFlXRk1YUThxMHlzQnZuMklLaThC?=
 =?utf-8?B?R0swWU45ZEVXR2RBSEhrNDRBb1ZPOGEyYTRDSC9PU1psTXIySVRDcklKVmsv?=
 =?utf-8?B?R1BVa2RxVHg4NVlBZVFmK015VDl1eXVvSXk2RUZrU2dnWGs2aENIZ3FuYS9W?=
 =?utf-8?B?STlqMXBBS1doS0djOGhrVWJEK1lLZHlhN3BLbHRXcG45NHpZTnJDRE5tNUc2?=
 =?utf-8?B?OGdXK2plWWJMTStCMDIvK1k0NG1GUVBubFZBRHNXYjFVcTl6TGgwZ1RlT1p2?=
 =?utf-8?B?TWhXZUNzeDRFUlhhZ052SkZ2djJ3QzMvNmg1Z1Irb3JieXRHSGl1eGMrcVQv?=
 =?utf-8?B?aHhvZkpxenVnQitZRzd6cHFuZ0k5dTRVVnhFQVpEZUR4UENCTTZBVjFrd2Rs?=
 =?utf-8?B?VURXWmVQbGZPMnArdDRpblJwU0hUVU9FMll0THN0VVZYWTZUVEVHTVhVNXEv?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TIQERcVbFgSm2XWP8JsSfS7Aoe4gGwkUaOnR1i2i4im7M8IVmc5XMZeEVXvIDMIivAe+u0OuzuNiFQFlgo1/KVd39BmLYc2hPRUNC0MCO5p5KjnDWlPb8d2b72bcPLOWuLbfIL7oDEa0QTWA9MMpv3muTbn/cfb4FsYwGWmEMET4hvP4WK3SrdtbQZqXli/48aUNQBDlLrQ1djjytm/agRnnfn+6hJB+xnhaBPyG2xvqh/5IUyfli32VNG//OsUy7T+217qAHJLMObmwx7RofLt7Hc35WVaXw4FROPsM9eByPWIyKeMrxPJwDqpG+IidqK9F1pGoigwj94s6TiGTGHWUxD/rPcEOeamrx3AKA1n0cEbCMbPbYMiXF6sklfHKopZGm2Y2m/KCX2IqzhxrDQ/79999iIyPy0aCpgkgFxT4HYx650tCHdv2OAxoDMODDT62pMQ0jKLDth1/ER7G6Fj1YnaQv5193ajiwxCrg8QerdeMS/5zU+Z9W/TTQnvOTBMogUFNM0LKYAJ5Qm3GukLoH1Ko8yJfnWTbOyWH4LMJySM6LLA2Q1rYJOBuhRZv/9ntT5jmG6IbPL3Bu3Mt91dgro0roWYfttEMPKGWM7aAWmx3r9dEZoXdQwFsBMfyQrsu8ojC9zevPX6I03q0ggmcfiN2l4d0zew8XH6Q0BtEuq5fUXHNmNyM8nHjtEFEvpyuzMTKCFAYxmBpmIBN+TCYzZmw9pkAjhp+DgP0wmQa7lbCjvkQrZljbY1upzvj1PXHJyiOc+p2hqm5cVGwhQWiW9DbuduDqQdpPssKJG84BncPReaxciykmOcZdSSdPlezIbB5b0bnYXizs3JOCw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18ade47-51b6-456b-b7b3-08dbb5df614a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:32:01.8925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vaz5faZmNQFmcTJfm4uFN/7rS66RIYLsBP+cO4NvCv9aptmvfz0AX+dEo81eT8cjK4Axkw7hoNZokZG7vQBcO2r8Uc3oGIFs/zAZ3XkNqSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_08,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150102
X-Proofpoint-ORIG-GUID: wWu6XOpq8RKVaXIDPukJFXkvOCsR9YjD
X-Proofpoint-GUID: wWu6XOpq8RKVaXIDPukJFXkvOCsR9YjD
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------9S4bMZpAGIM8CRxWPJ1j8Zds
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/23 05:13, Zhijian Li (Fujitsu) wrote:
> 
> 
> I'm okay with "RDMA isn't touched".
> BTW, could you share your reproducing program/hacking to poison the page, so that
> i am able to take a look the RDMA part later when i'm free.
> 
> Not sure it's suitable to acknowledge a not touched part. Anyway
> Acked-by: Li Zhijian <lizhijian@fujitsu.com> # RDMA
> 

Thanks.
As you asked for a procedure to inject memory errors into a running VM,
I've attached to this email the source code (mce_process_react.c) of a
program that will help to target the error injection in the VM.

(Be careful that error injection is currently nor working on AMD
platforms -- this is a work in progress is a separate qemu thread)


The general idea:
We are going to target a process memory page running inside a VM to see
what happens when we inject an error on the underlying physical page at
the platform (hypervisor) level.
To have a better view of what's going on, we'll use a process made for
this: It's goal is to allocate a memory page, and create a SIGBUS
handler to inform when it receives this signal. It will also wait before
touching this page to see what happens next.

     Compiling this tool:
     $ gcc -o mce_process_react_x86 mce_process_react.c


Let's try that:
This procedure shows the best case scenario, where an error injected at
the platform level is reported up to the guest process using it.
Note that qemu should be started with root privilege.

     1. Choose a process running in the VM (and identify a memory page
you want to target, and get its physical address – crash(8) vtop can
help with that) or run the attached mce_process_react example (compiled
for your platform mce_process_react_[x86|arm]) with an option to be
early informed of _AO error (-e) and wait ENTER to continue with reading
the allocated page (-w 0):

[root@VM ]# ./mce_process_react_x86 -e -w 0
Setting Early kill... Ok

Data pages at 0x7fa0f9b25000  physically 0x200f2fa000

Press ENTER to continue with page reading


     2. Go into the VM monitor to get the translation from "Guest
Physical Address to Host Physical Address" or "Host Virtual Address":

  (qemu) gpa2hpa 0x200f2fa000'
Host physical address for 0x200f2fa000 (ram-node1) is 0x46f12fa000


     3. Before we inject the error, we want to keep track of the VM
console output (in a separate window).
If you are using libvirt: # virsh console myvm


     4. We now prepare for the error injection at the platform level to
the address we found.  To do so, we'll need to use the hwpoison-inject
module (x86)
Be careful, as hwpoison takes Page Frame Numbers and this PFN is not the
physical address – you need to remove the last 12 bits (the last 3 zeros
of the above address) !

[root@hv ]# modprobe hwpoison-inject
[root@hv ]# echo 0x46f12fa > /sys/kernel/debug/hwpoison/corrupt-pfn

        If you see "Operation not permitted" error when writing as root
on corrupt-pfn, you may be facing a "kernel_lockdown(7)" which is
enabled on SecureBoot systems (can be verified with
"mokutil --sb-state"). In this case, turn SecureBoot off  (at the UEFI
level for example)

     5. Look at the qemu output (either on the terminal where qemu was
started or  if you are using libvirt:  tail /var/log/libvirt/qemu/myvm

2022-08-31T13:52:25.645398Z qemu-system-x86_64: warning: Guest MCE 
Memory Error at QEMU addr 0x7eeeace00000 and GUEST addr 0x200f200 of 
type BUS_MCEERR_AO injected

     6. On the guest console:
We'll see the VM reaction to the injected error:

[  155.805149] Disabling lock debugging due to kernel taint
[  155.806174] mce: [Hardware Error]: Machine check events logged
[  155.807120] Memory failure: 0x200f200: Killing mce_process_rea:3548 
due to hardware memory corruption
[  155.808877] Memory failure: 0x200f200: recovery action for dirty LRU 
page: Recovered

     7. The Guest process that we started at the first step gives:

Signal 7 received
BUS_MCEERR_AO on vaddr: 0x7fa0f9b25000

At this stage, the VM has a poisoned page, and a migration of this VM
needs to be fixed in order to avoid accessing the poisoned page.

     8. The process continues to run (as it handled the SIGBUS).
Now if you press ENTER on this process terminal, it will try to read the
page which will generate a new MCE (a synchronous one) at VM level which
will be sent to this process:

Signal 7 received
BUS_MCEERR_AR on vaddr: 0x7fa0f9b25000
Exit from the signal handler on BUS_MCEERR_AR

     9. The VM console shows:
[ 2520.895263] MCE: Killing mce_process_rea:3548 due to hardware memory 
corruption fault at 7f45e5265000

     10. The VM continues to run...
With a poisoned page in its address space

HTH,
William.
--------------9S4bMZpAGIM8CRxWPJ1j8Zds
Content-Type: text/x-csrc; charset=UTF-8; name="mce_process_react.c"
Content-Disposition: attachment; filename="mce_process_react.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3ByY3RsLmg+CiNpbmNsdWRlIDxz
eXMvbW1hbi5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVk
ZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxhc3NlcnQuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNs
dWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+Cgoj
ZGVmaW5lIFBBR0VNQVBfRU5UUlkgOAojZGVmaW5lIEdFVF9CSVQoWCxZKSAoWCAmICgodWludDY0
X3QpMTw8WSkpID4+IFkKI2RlZmluZSBHRVRfUEZOKFgpIFggJiAweDdGRkZGRkZGRkZGRkZGCiNk
ZWZpbmUgQUxMT0NfUEFHRVMgMQoKY29uc3QgaW50IF9fZW5kaWFuX2JpdCA9IDE7CiNkZWZpbmUg
aXNfYmlnZW5kaWFuKCkgKCAoKihjaGFyKikmX19lbmRpYW5fYml0KSA9PSAwICkKCi8qCiAqIFNl
dCB0aGUgZWFybHkga2lsbCBtb2RlIHJlYWN0aW9uIHN0YXRlIHRvIE1DRSBlcnJvci4KICovCnN0
YXRpYyB2b2lkIGVhcmx5X3JlYWN0aW9uKCkgewogICBwcmludGYoIlNldHRpbmcgRWFybHkga2ls
bC4uLiAiKTsKICAgaWYgKHByY3RsKFBSX01DRV9LSUxMLCBQUl9NQ0VfS0lMTF9TRVQsIFBSX01D
RV9LSUxMX0VBUkxZLCAwLCAwKSA9PSAwKQogICAgICBwcmludGYoIk9rXG4iKTsKICAgZWxzZQog
ICAgICBwcmludGYoIkZhaWx1cmUgIVxuIik7Cn0KCi8qCiAqIEdlbmVyYXRlIGFuIGVycm9yIG9u
IHRoZSBnaXZlbiBwYWdlLgogKi8Kc3RhdGljIHZvaWQgbWVtb3J5X2Vycm9yX2FkdmlzZSh2b2lk
KiB2aXJ0dWFsX3BhZ2UpIHsKICAgaW50IHJldDsKCiAgIHJldCA9IG1hZHZpc2UodmlydHVhbF9w
YWdlLCA0MDk2LCBNQURWX0hXUE9JU09OKTsKICAgaWYgKHJldCkKICAgICAgcHJpbnRmKCJQb2lz
b25pbmcgZmFpbGVkIC0gbWFkdmlzZTogJXMiLCBzdHJlcnJvcihlcnJubykpOwp9CgovKgogKiBS
ZXR1cm4gdGhlIHBoeXNpY2FsIGFkZHJlc3MgYXNzb2NpYXRlZCB0byBhIGdpdmVuIGxvY2FsIHZp
cnR1YWwgYWRkcmVzcywKICogb3IgLTEgaW4gY2FzZSBvZiBhbiBlcnJvci4KICovCnN0YXRpYyB1
aW50NjRfdCBwaHlzaWNhbF9hZGRyZXNzKHVpbnQ2NF90IHZpcnRfYWRkcikgewogICBjaGFyIHBh
dGhfYnVmIFsweDEwMF07CiAgIEZJTEUgKiBmOwogICB1aW50NjRfdCByZWFkX3ZhbCwgZmlsZV9v
ZmZzZXQsIHBmbiA9IDA7CiAgIGxvbmcgcGdzejsKICAgdW5zaWduZWQgY2hhciBjX2J1ZltQQUdF
TUFQX0VOVFJZXTsKICAgcGlkX3QgbXlfcGlkID0gZ2V0cGlkKCk7CiAgIGludCBzdGF0dXMsIGk7
CgogICBzcHJpbnRmKHBhdGhfYnVmLCAiL3Byb2MvJXUvcGFnZW1hcCIsIG15X3BpZCk7CiAgIAog
ICBmID0gZm9wZW4ocGF0aF9idWYsICJyYiIpOwogICBpZighZil7CiAgICAgIHByaW50ZigiRXJy
b3IhIENhbm5vdCBvcGVuICVzXG4iLCBwYXRoX2J1Zik7CiAgICAgIHJldHVybiAodWludDY0X3Qp
LTE7CiAgIH0KICAgCiAgIC8vU2hpZnRpbmcgYnkgdmlydC1hZGRyLW9mZnNldCBudW1iZXIgb2Yg
Ynl0ZXMKICAgLy9hbmQgbXVsdGlwbHlpbmcgYnkgdGhlIHNpemUgb2YgYW4gYWRkcmVzcwogICAv
Lyh0aGUgc2l6ZSBvZiBhbiBlbnRyeSBpbiBwYWdlbWFwIGZpbGUpCiAgIHBnc3ogPSBzeXNjb25m
KF9TQ19QQUdFU0laRSk7CiAgIGZpbGVfb2Zmc2V0ID0gdmlydF9hZGRyIC8gKHVpbnQ2NF90KXBn
c3ogKiBQQUdFTUFQX0VOVFJZOwogICBzdGF0dXMgPSBmc2VlayhmLCAobG9uZylmaWxlX29mZnNl
dCwgU0VFS19TRVQpOwogICBpZihzdGF0dXMpewogICAgICBwZXJyb3IoIkZhaWxlZCB0byBkbyBm
c2VlayEiKTsKICAgICAgZmNsb3NlKGYpOwogICAgICByZXR1cm4gKHVpbnQ2NF90KS0xOwogICB9
CgogICBmb3IoaT0wOyBpIDwgUEFHRU1BUF9FTlRSWTsgaSsrKXsKICAgICAgaW50IGMgPSBnZXRj
KGYpOwogICAgICBpZihjPT1FT0YpewogICAgICAgICBmY2xvc2UoZik7CiAgICAgICAgIHJldHVy
biAodWludDY0X3QpLTE7CiAgICAgIH0KICAgICAgaWYoaXNfYmlnZW5kaWFuKCkpCiAgICAgICAg
ICAgY19idWZbaV0gPSAodW5zaWduZWQgY2hhciljOwogICAgICBlbHNlCiAgICAgICAgICAgY19i
dWZbUEFHRU1BUF9FTlRSWSAtIGkgLSAxXSA9ICh1bnNpZ25lZCBjaGFyKWM7CiAgIH0KICAgZmNs
b3NlKGYpOwoKICAgcmVhZF92YWwgPSAwOwogICBmb3IoaT0wOyBpIDwgUEFHRU1BUF9FTlRSWTsg
aSsrKXsKICAgICAgcmVhZF92YWwgPSAocmVhZF92YWwgPDwgOCkgKyBjX2J1ZltpXTsKICAgfQoK
ICAgaWYoR0VUX0JJVChyZWFkX3ZhbCwgNjMpKSB7IC8vIEJpdCAgNjMgICAgcGFnZSBwcmVzZW50
CiAgICAgIHBmbiA9IEdFVF9QRk4ocmVhZF92YWwpOwogICB9IGVsc2UgewogICAgICBwcmludGYo
IlBhZ2Ugbm90IHByZXNlbnQgIVxuIik7CiAgIH0KICAgaWYoR0VUX0JJVChyZWFkX3ZhbCwgNjIp
KSAvLyBCaXQgIDYyICAgIHBhZ2Ugc3dhcHBlZAogICAgICBwcmludGYoIlBhZ2Ugc3dhcHBlZFxu
Iik7CgogICBpZiAocGZuID09IDApCiAgICAgIHJldHVybiAodWludDY0X3QpLTE7CgogICByZXR1
cm4gcGZuICogKHVpbnQ2NF90KXBnc3o7Cn0KCi8qCiAqIFNJR0JVUyBoYW5kbGVyIHRvIGRpc3Bs
YXkgdGhlIGdpdmVuIGluZm9ybWF0aW9uLgogKi8Kc3RhdGljIHZvaWQgc2lnYnVzX2FjdGlvbihp
bnQgc2lnbnVtLCBzaWdpbmZvX3QgKnNpZ2luZm8sIHZvaWQgKmN0eCkgewogICBwcmludGYoIlNp
Z25hbCAlZCByZWNlaXZlZDogIiwgc2lnbnVtKTsKICAgcHJpbnRmKCIlcyBvbiB2YWRkcjogJWxs
eFxuIiwKICAgICAgKHNpZ2luZm8tPnNpX2NvZGUgPT0gND8gIkJVU19NQ0VFUlJfQVIiOiJCVVNf
TUNFRVJSX0FPIiksCiAgICAgIHNpZ2luZm8tPnNpX2FkZHIpOwoKICBpZiAoc2lnaW5mby0+c2lf
Y29kZSA9PSA0KSB7IC8qIEJVU19NQ0VFUlJfQVIgKi8KCWZwcmludGYoc3RkZXJyLCAiRXhpdCBm
cm9tIHRoZSBzaWduYWwgaGFuZGxlciBvbiBCVVNfTUNFRVJSX0FSXG4iKTsKCV9leGl0KDEpOwog
IH0KfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiogYXJndikgewogICBpbnQgb3B0LCBlYXJs
eV9yZWFjdCA9IDAsIG1hZHZpc2VfZXJyb3I9MCwgd2FpdF90aW1lPTUsIGk7CiAgIHN0cnVjdCBz
aWdhY3Rpb24gbXlfc2lnYWN0aW9uOwogICB1aW50NjRfdCB2aXJ0X2FkZHIgPSAwLCBwaHlzX2Fk
ZHI7CiAgIHZvaWQgKmxvY2FsX3BudDsKCiAgIC8vIE5lZWQgdG8gaGF2ZSB0aGUgQ0FQX1NZU19B
RE1JTiBjYXBhYmlsaXR5IHRvIGdldCBQRk5zIHZhbHVlcyBpbiBwYWdlbWFwLgogICBpZiAoZ2V0
dWlkKCkgIT0gMCkgewogICAgICBmcHJpbnRmKHN0ZGVyciwgIlVzYWdlOiAlcyBuZWVkcyB0byBy
dW4gYXMgcm9vdFxuIiwgYXJndlswXSk7CiAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsKICAgfQoK
ICAgd2hpbGUgKChvcHQgPSBnZXRvcHQoYXJnYywgYXJndiwgImVtdzoiKSkgIT0gLTEpIHsKICAg
ICAgc3dpdGNoIChvcHQpIHsKICAgICAgY2FzZSAnZSc6CiAgICAgICAgIGVhcmx5X3JlYWN0ID0g
MTsKICAgICAgICAgYnJlYWs7CiAgICAgIGNhc2UgJ20nOgogICAgICAgICBtYWR2aXNlX2Vycm9y
PTE7CiAgICAgICAgIGJyZWFrOwogICAgICBjYXNlICd3JzoKICAgICAgICAgd2FpdF90aW1lPWF0
b2kob3B0YXJnKTsKICAgICAgICAgYnJlYWs7CiAgICAgIGRlZmF1bHQ6IC8qICc/JyAqLwogICAg
ICAgICBmcHJpbnRmKHN0ZGVyciwgIlVzYWdlOiAlcyBbLWVdIFstbV0gWy13IHNlY29uZHNdXG4i
LCBhcmd2WzBdKTsKICAgICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwogICAgICB9CiAgIH0KCiAg
IC8vIGF0dGFjaCBvdXIgU0lHQlVTIGhhbmRsZXIuCiAgIG15X3NpZ2FjdGlvbi5zYV9zaWdhY3Rp
b24gPSBzaWdidXNfYWN0aW9uOwogICBteV9zaWdhY3Rpb24uc2FfZmxhZ3MgPSBTQV9TSUdJTkZP
IHwgU0FfTk9ERUZFUiB8IFNBX1NJR0lORk87CiAgIGlmIChzaWdhY3Rpb24oU0lHQlVTLCAmbXlf
c2lnYWN0aW9uLCBOVUxMKSA9PSAtMSkgewogICAgICBwZXJyb3IoIlNpZ25hbCBoYW5kbGVyIGF0
dGFjaCBmYWlsZWQiKTsKICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwogICB9CgogICBpZiAoZWFy
bHlfcmVhY3QpCiAgICAgIGVhcmx5X3JlYWN0aW9uKCk7CgogICAvLyBBbGxvY2F0ZSBueDRLIHBy
aXZhdGUgcGFnZXMuCiAgIGxvY2FsX3BudCA9IG1tYXAoTlVMTCwgQUxMT0NfUEFHRVMqNDA5Niwg
UFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9BTk9OfE1BUF9QUklWQVRFLCAtMSwgMCk7CiAgIGlm
IChsb2NhbF9wbnQgPT0gTUFQX0ZBSUxFRCkgewogICAgICBmcHJpbnRmKHN0ZGVyciwgIk1lbW9y
eSBBbGxvY2F0aW9uIGZhaWxlZCAhXG4iKTsKICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwogICB9
CiAgIHZpcnRfYWRkciA9ICh1aW50NjRfdClsb2NhbF9wbnQ7CgogICAvLyBEaXJ0eSAvIG1hcCB0
aGUgcGFnZXMuCiAgIGZvciAoaT0wOyBpIDwgQUxMT0NfUEFHRVM7IGkrKykgewogICAgICBzcHJp
bnRmKCgoY2hhciAqKWxvY2FsX3BudCArIGkqNDA5NiksICJNeSBwYWdlIG51bWJlciAlZFxuIiwg
aSk7CiAgIH0KCiAgIHBoeXNfYWRkciA9IHBoeXNpY2FsX2FkZHJlc3ModmlydF9hZGRyKTsKICAg
aWYgKHBoeXNfYWRkciA9PSAtMSkgewogICAgICBmcHJpbnRmKHN0ZGVyciwgIlZpcnR1YWwgYWRk
cmVzcyB0cmFuc2xhdGlvbiAweCVsbHggZmFpbGVkXG4iLCAKICAgICAgICAgKHVuc2lnbmVkIGxv
bmcgbG9uZyl2aXJ0X2FkZHIpOwogICAgICBleGl0KEVYSVRfRkFJTFVSRSk7CiAgIH0KICAgcHJp
bnRmKCJcbkRhdGEgcGFnZXMgYXQgMHglbGx4ICBwaHlzaWNhbGx5IDB4JWxseFxuIiwKICAgICAg
KHVuc2lnbmVkIGxvbmcgbG9uZyl2aXJ0X2FkZHIsICh1bnNpZ25lZCBsb25nIGxvbmcpcGh5c19h
ZGRyKTsKICAgZmZsdXNoKHN0ZG91dCk7CgogICAvLyBFeHBsaWNpdCBlcnJvcgogICBpZiAobWFk
dmlzZV9lcnJvcikKICAgICAgbWVtb3J5X2Vycm9yX2FkdmlzZSgodm9pZCopIHZpcnRfYWRkcik7
CgogICAvLyBOb3cgV2FpdCAhCiAgIGlmICh3YWl0X3RpbWUgPiAwKSB7CiAgICAgIHNsZWVwKCh1
bnNpZ25lZCBpbnQpd2FpdF90aW1lKTsKICAgfSBlbHNlIHsKICAgICAgcHJpbnRmKCJcblByZXNz
IEVOVEVSIHRvIGNvbnRpbnVlIHdpdGggcGFnZSByZWFkaW5nXG4iKTsKICAgICAgaSA9IGZnZXRj
KHN0ZGluKTsKICAgfQogICAKICAgLy8gcmVhZCB0aGUgc3RyaW5ncyBhdCB0aGUgYmVnaW5uaW5n
IG9mIGVhY2ggcGFnZS4KICAgZm9yIChpPTA7IGkgPCBBTExPQ19QQUdFUzsgaSsrKSB7CiAgICAg
IHByaW50ZigiJXMiLCAoKGNoYXIgKilsb2NhbF9wbnQgKyBpKjQwOTYpKTsKICAgfQoKICAgcGh5
c19hZGRyID0gcGh5c2ljYWxfYWRkcmVzcyh2aXJ0X2FkZHIpOwogICBpZiAocGh5c19hZGRyID09
IC0xKSB7CiAgICAgIGZwcmludGYoc3RkZXJyLCAiVmlydHVhbCBhZGRyZXNzIHRyYW5zbGF0aW9u
IDB4JWxseCBmYWlsZWRcbiIsIAogICAgICAgICAodW5zaWduZWQgbG9uZyBsb25nKXZpcnRfYWRk
cik7CiAgIH0gZWxzZSB7CiAgICAgIHByaW50ZigiXG5EYXRhIHBhZ2VzIGF0IDB4JWxseCAgcGh5
c2ljYWxseSAweCVsbHhcbiIsCiAgICAgICAgICh1bnNpZ25lZCBsb25nIGxvbmcpdmlydF9hZGRy
LCAodW5zaWduZWQgbG9uZyBsb25nKXBoeXNfYWRkcik7CiAgIH0KCiAgIHJldHVybiAwOwp9Cg==

--------------9S4bMZpAGIM8CRxWPJ1j8Zds--

