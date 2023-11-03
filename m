Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 760667E0A54
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:30:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0nF-0008Ix-O3; Fri, 03 Nov 2023 16:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qz0n9-0008IV-TW
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:29:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qz0n5-0004Sj-Kg
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:29:19 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3G7GA4001891; Fri, 3 Nov 2023 20:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b4m7Zgx0tl/oAG8tI0d+ycANiaDsHrQyUiKE4Nvhdi0=;
 b=y1VKsbloCpMPFGBoGp2Y7GxTIn90xiwJoVpWeknPyqkXlcMv39X3+cYigE9iLoB+w5ut
 C6N64OTP91wZknvWDCRp6pERD4NBnao6CyxC7FZWZWTgXbq8fBOS9QVLnHDw3FaoOl8L
 eWIrDxxXv2u4OtExudPIGhY+HNhdvPsLpD04LTSZfi+ERE4TJhEBa0zMV/y2nP604CKB
 DmqM5Ncl50MRb7IBoONfBjoAI72sOzR/F6Uw9KysaVpc1g0I50uOOGyAKJtBZLDo/WyC
 7Ia4/a34bGyx5L/kD4haDGdGfGP8ZsnALhYcSxnFPhIjVDwZPxj31NWXnLbFPVlLcyTX mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s344x41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 20:29:11 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A3JiYDT020095; Fri, 3 Nov 2023 20:29:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rrgukp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 20:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caimdPqhk+7FHAu+4+SmYZBe2VNyH3n24mOgsU98W2Fgrbrsw1Vj259bCjZJOK3phLUzlyyzxR4OGoT5mfvA2wkjapYuc+lX7Y2lh4qiHv4iQieW3zkb7VtRvuTFZcZrCgZ0kg02ZpSyBsprhoOLUx38tXIw3HGQS0RLbrc+p5N5xzvFRSkOJrL/RrMEDcRsloxxabL5u6FSAa6F9bk/XI6AwZ94hfIXq1kfOUZ3hLXDUuvBLZ6hnBcHzW3ioQI/ZMZ5DWGQ5HJQfgqR60S6XzPjl4QXsJJpBack2khpCSBRt0QYk6m4w5D7kyC4qld9BCPeO/I1ItFou4YaQw/APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4m7Zgx0tl/oAG8tI0d+ycANiaDsHrQyUiKE4Nvhdi0=;
 b=Aqv0hOa5oYS5xNwdJ+C/Y1AlBujibohgiZgJ8Or/zd4FI/XQ66drB2CNZzGn10kid94pGUsy2DC/fNwWweOhBPudcMVmEOyzBwAKH2Et8nGfsFpwX17QfCXNguhR6GvuQ7iGuqutgB6RnyoKGR0xhJvCjK4E1WCeg2Cpg2JWw53KTJXXZM0DeKTSc2yFJxJbDnefEQ9FP9/SdpjluUFMU7nyUcDC2dxhvlNHnWVy64r01nlqHSMIoXQ72XvVNEqo0XqEsx6KdMn/R4mzIOozWoqGaQ8BRlbl5spzACVY9UHaGgaWrt95Qsj+7l96Xj38roxeJ5dhm2rLeUy+Kh0TCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4m7Zgx0tl/oAG8tI0d+ycANiaDsHrQyUiKE4Nvhdi0=;
 b=GNy98E+9JmWXw/TtjyFAlIvjoEJ0uOoUZnsmSbxOPEUb9DZUmjSGNqKabXCKxl0RRc6qwCS+lAnywNvqSgDjYc86kyjuRJjjE3jGWAEghM7G5w9lPBrlhMb/dy2cbijmojVXV5zQV71bndIGWz1b53fqZYjJCP747qNU1yfghsY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by LV3PR10MB7916.namprd10.prod.outlook.com (2603:10b6:408:218::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 20:29:00 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 20:28:59 +0000
Message-ID: <2e365128-2b02-4de0-976b-b4a573ae2d97@oracle.com>
Date: Fri, 3 Nov 2023 16:28:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: flush messages on abort
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|LV3PR10MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: af0d9d20-01b8-4e49-684c-08dbdcab82fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k5hxF8sgmo2HOCG4J2GkG2+EGy1/QX8FqfQtXUemeRHn5SS6Yoe1I+QaEwNJ04uZuumXh+TW1t5hy0TmZ95EDqW7Z3JXwRRcxHQr2cQaGcr6C0DU54KR4ARIX8+CTMPM0842UieYqN3oTGYP5VzQhCBdz67GaqhsmH6yDoHdEJVuAUIb815seZQsf6CQ0tKHC5fp6meIz5En9bNDq3v3yo53NEZlzedd7fvsl9A+TSslv8h9fEPUeuATKIvBYZFtry6Ewjzg+Mrr8aSYkw/3I4O0f5revc937dyDyPiMoXEnKluv8P+T4mH/0GnqbQiFUnE/tKFMqN07GdlAnDWcsoy10LsKcwIAqbSu9+WIBrJCBEWYfcz8ungjqQhzJeVjvhLtEV1T2+3fAb5yhNsGJ9eiafF1zo60IWm6YkeI5eQJS9UjuBy/6bQY7zSwQ+wZvwj5XFNZutWi7GIlbGE53tqaYgsPnDKLm8s1GIpBE6G4Uii7wgiUbt5opiUvHyPIdbA92Pb7529a5pFsl2Z/1/LlEYxpRHSD3GVCseQrMReV6Nzq5sDJP23Qpzi8k0YjIcPdinjW7hWR1fe55VWlYkYbeveP166wE9fWfzGJQ1Vx5ZEKw8P/Xys2aDFsGzs2ejhvS0loC8raDBIGKhqcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(6512007)(2616005)(26005)(2906002)(31696002)(36756003)(86362001)(38100700002)(83380400001)(66946007)(15650500001)(54906003)(5660300002)(4326008)(53546011)(8936002)(36916002)(6506007)(478600001)(6666004)(6916009)(44832011)(316002)(8676002)(66476007)(6486002)(66556008)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFwbWd1RkNVMFhYakVFcGNsWCtmQlJ5QkNvYkl4MStGampZbFZnaVBQSWgr?=
 =?utf-8?B?ZGVpQmd0azAweVZTN3lqM0c5M0QwQlhXUWR0alhMRzgwRkVTV0c4WUwyL0RC?=
 =?utf-8?B?SVNtUFhRY2xsd1VHbmU5Q1lZazQ4bFZnUU52cXlMODVncjJMN1lsVmxSR1VB?=
 =?utf-8?B?ekx0eDQ0bW1yeDRpeXpINVVhQmF1dEdRbjhScUFJVllTNTNFcng0V1FNcnRG?=
 =?utf-8?B?OUxLeS8zZklGY1ZRRHNsS2ZSbzkrbVdQOHBvNXhvMWpJZ0xPd005U2RwYktS?=
 =?utf-8?B?bjZRTmdLbXp0cWJFSUVreHZLU2JBaU5CZC85UVVZYlNuM2dUKzFrMHdqbGdh?=
 =?utf-8?B?c1N0RUdCTlVJcy95WThZaEZGaE5jVHJaTHM0M1o2Q1QySnBQUGpWU0tGR2J4?=
 =?utf-8?B?dXhOLzFMMzQxTHFmTWFBT01jdjdOV0JDdU1lMjFVbTRHejZKdnBoU2pRT2JP?=
 =?utf-8?B?Q3JlTlVEK2tPRzFFdzB6NFY1Y3FRQ25oMU9jSTFyVElUdUpBczIxbzQ1cFRW?=
 =?utf-8?B?emE0azVtb0NLSjBhbUhSZHRTcERWZk9KcHVxTjZrTzRkTTUycW9sbjRoWm0w?=
 =?utf-8?B?TnBLZTVLdWRpbXdaLzhGREcxNERoYWJrNmpoUzUwSU1EVnVuU1QzUkUyaWxo?=
 =?utf-8?B?R1Y2T2VybFZUV05iUm1MYjlTQjFrMmxaRnV2Z2ZEVUVFSzBNdWFNTzVqOTJM?=
 =?utf-8?B?b3pTTFhyVnJzdXhudXJVWnpQNU1aQ2I4bFRoZlJaWXNMdFBIbnRLamRscWpQ?=
 =?utf-8?B?KzJFcVB0cXhOTFpuR0krRFFveDFRL0E4VkdEckt5Qy9pa2I0bDBmK3Vyb1ZI?=
 =?utf-8?B?WVhlQ0FsSmlJaTdteHhNWnhsalJMZDlkMUZvb1NXL0lTdlZtZDgxRHdSTzJ0?=
 =?utf-8?B?Ym5xbGZjVWMrYldoaEJUdzhpaVl4SUhuelQ2SEk4NHlaa1BkbVEva1MydzJK?=
 =?utf-8?B?dHg2SjJyQWJLNTJIL1Y4VXFCWVpVSGJYbS9FSDRQODdnQ21yN3NtRlZHdXRB?=
 =?utf-8?B?d1RyUCtFMnNEZ3JMSGx1NWR6Z1YwL1hVWnI4VVFkTVV2NjFBS0Jwam83Zml1?=
 =?utf-8?B?Nm1HR0hNbGp0TXpzdm5uNjZaRWVUWTZzVHpqckh1bHk3TUtQSzJSMEhvLyt6?=
 =?utf-8?B?emlPQjN5L3ZFbHNHNm0vQ0ZJREJ0WHJzbnVidGx2MjFuZFU0UUJYUWFneWhj?=
 =?utf-8?B?TnlnZ1VHQUgwYUI1T0Y0RGdDMHJjUmJvOVZscHYwQUxLNlNBMDhWVVE5RDZZ?=
 =?utf-8?B?T05mdGhQUVg3OVN1bDdRS3lhQnNkT0YzR1RGQ283STdWMzBqeXFEbVN3UGNs?=
 =?utf-8?B?eklmVkk0Q055TWx6ZDZSdmdHZnRPb0ltRGVxVjJwRWhWZnlLRTlkSFFnTVEy?=
 =?utf-8?B?U2VIWW1XREJha2xlZCtuK3pOcTlYbFA4elFVQTZKdzRKY1pRREduZE56bnVj?=
 =?utf-8?B?bVZhNXNsTEIxR0FVVGRiS2hGd1grbk5zVTRVNWpMbkVoN2Y0cEFFOXNEL3E0?=
 =?utf-8?B?Uit6OFBZd1UrR0kyTSswQU9icnlSUk9VUFFvYnFIZkg5Q0ZYNWU5Rnd4MFpy?=
 =?utf-8?B?ZXJ4eEt4V0RsazZOWllXS081N0cyWTZhTGRxK1RnempLM3VieHZyTUtiYUJs?=
 =?utf-8?B?YTA1NjJ2dVB2RDFUQVp6MjhJSVJkZEdrV1ZBTFBJT2RHUENqRzN4NDVINGt5?=
 =?utf-8?B?QXJtRkZRL3ZpRjRWZUM4N2FiYzlvMGpSSWQ0aHVVeTJsVVErK3gvY0l3b0J4?=
 =?utf-8?B?aWt4RVZ6aUEwY21KMTBGODNZRDE0Y3AySytDd1J1a2o4VjAzS2xZRGt5NUdE?=
 =?utf-8?B?dkx2VFhXZEU3U0VYR1grNjZSTExzWnVvcHo5VXU0OVQ1eUgxVnZEdkY0MEpB?=
 =?utf-8?B?djdFRW5FcXZnemZ5M0RsMnNhZDAybkp0QjRSelpkWldEYU15SUF1Y2s1WUx1?=
 =?utf-8?B?OFhiOGoxT2k5eXpFSTVKVlplRXBtdFRmdlVuRzVrTWZVcUc1ai96QnIzQ1RK?=
 =?utf-8?B?TFk2WkJCM00wbDZrR2lnRjJTSXNxVEFtc3JDZjlpWHkyVitLaTd2M1VReDI1?=
 =?utf-8?B?Q2hzd25KRHp5dytvYUFINnAxUTkyRXRpamhNZFV6T1JxY3N0UFUxKzZUVUJG?=
 =?utf-8?B?Skc1cEFvSmpVb1VteHZ6dDA5cGlveXlVR0ZhVjdTOHF5WUdvQ3V0SnBXTmow?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mX9QP98kTfGz3MTbCfRNkNNcWCva1iew/9S7LXv0qHv9SXUWCR2ktQjb3xxaztkhDbEV8VSE+OMBdt7j0PcUuRJeAAfJkZADh0tqdEI4JMXuKleGi/hwU9OSLM/agY61Oj2T+25B0YPMZl54FkaaBre2vsVbHk35pFhszh7N93KR965g56RrpG+rFOJ/fJ3wfIGHlX/cJM8sMQvSYolTRfLLwDDplwngWYbxLEF2sruvralmtWg7S3usJ7pwVQUm2Xfw8lmkOAnKlkLz/xuCKZPiRv6X/0ukxj2EF4vc2sryQVRTf4ZyAiX1QwwUv4C9jDYo5zai3MXHF8aF0Pmy6DYnLO90dIksMy394CcBo9tcq6YYb0aT4WdjPRPlF7UosidQFaZCgQ35yL9EfLmMC4XV6vQyK88U4menT1EN/kzfSCq8dt/7ssBeNiY4xI0UysP/CxPdxiTxl+X5zuptsJUbCKfuNsWAuMYLJyT6blI3kuK8Zl3h5mEHIlyNXet8eOlwyMU/sAWrM6kHcFfkn13NY2dUiS6Hc9p2MzTxpkRZ6qQntSzSzvqkui5zqPyTtX9r0WPM2hyRvLrNJxnMfCysuJhxR5zKcGUFwvwWNE5MXHWTQP0RO1aGxck+HeOesSkDqXQfxhv9quncFbwpPbLTHSLHj+70rqpocMb/O1L9tR5JcGSZv2qH39kkc0G9gsIuooh+904Q+ubrSMPsqxtgwNdPykxA/0P5rkfMsgeOG5tvLQ6T0TwUUInWK17q34Nd+DWzx2tTQxlI9sIZ/yFnT/KHlX0xjQn8qkYxdP21bpL+Rfh1+QkPFWU+usfRWC2onYgGgqEVKMc1ZyV7JA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0d9d20-01b8-4e49-684c-08dbdcab82fa
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 20:28:59.9236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJGMhXaGAbeCEpEpfG9+vKv+j0ZdNuCqMYL69Jb73tb/E5Rjijhyb7GijgC9Op6P6ComFrnvAw7T8MOGqlZ+PZdTasC/eCdOUUHxmoy0yN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_19,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030173
X-Proofpoint-GUID: uHht8bd5f3wkM4Jx47YeXk_f1vImiPql
X-Proofpoint-ORIG-GUID: uHht8bd5f3wkM4Jx47YeXk_f1vImiPql
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

On 11/3/2023 3:51 PM, Steven Sistare wrote:
> On 11/3/2023 1:33 PM, Daniel P. Berrangé wrote:
>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>>> Buffered monitor output is lost when abort() is called.  The pattern
>>> error_report() followed by abort() occurs about 60 times, so valuable
>>> information is being lost when the abort is called in the context of a
>>> monitor command.
>>
>> I'm curious, was there a particular abort() scenario that you hit ?
> 
> Yes, while tweaking the suspended state, and forgetting to add transitions:
> 
>         error_report("invalid runstate transition: '%s' -> '%s'",
>         abort();
> 
> But I have previously hit this for other errors.
> 
>> For some crude statistics:
>>
>>   $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --after 1 error_report | grep $i | wc -l ; done
>>   abort: 47
>>   return: 512
>>   exit: 458
>>   goto: 177
>>
>> to me those numbers say that calling "abort()" after error_report
>> should be considered a bug, and we can blanket replace all the
>> abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
>> special case flushing the monitor.
> 
> And presumably add an atexit handler to flush the monitor ala monitor_abort.
> AFAICT currently no destructor is called for the monitor at exit time.
> 
>> Also I think there's a decent case to be made for error_report()
>> to call monitor_flush().
> 
> A good start, but that would not help for monitors with skip_flush=true, which 
> need to format the buffered string in a json response, which is the case I 
> tripped over.
> 
>>> To fix, install a SIGABRT handler to flush the monitor buffer to stderr.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>  monitor/monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>
>>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>>> index dc352f9..65dace0 100644
>>> --- a/monitor/monitor.c
>>> +++ b/monitor/monitor.c
>>> @@ -701,6 +701,43 @@ void monitor_cleanup(void)
>>>      }
>>>  }
>>>  
>>> +#ifdef CONFIG_LINUX
>>> +
>>> +static void monitor_abort(int signal, siginfo_t *info, void *c)
>>> +{
>>> +    Monitor *mon = monitor_cur();
>>> +
>>> +    if (!mon || qemu_mutex_trylock(&mon->mon_lock)) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (mon->outbuf && mon->outbuf->len) {
>>> +        fputs("SIGABRT received: ", stderr);
>>> +        fputs(mon->outbuf->str, stderr);
>>> +        if (mon->outbuf->str[mon->outbuf->len - 1] != '\n') {
>>> +            fputc('\n', stderr);
>>> +        }
>>> +    }
>>> +
>>> +    qemu_mutex_unlock(&mon->mon_lock);
>>
>> The SIGABRT handling does not only fire in response to abort()
>> calls, but also in response to bad memory scenarios, so we have
>> to be careful what we do in signal handlers.
>>
>> In particular using mutexes in signal handlers is a big red
>> flag generally. Mutex APIs are not declare async signal
>> safe, so this code is technically a POSIX compliance
>> violation.
> 
> Righto.  I would need to mask all signals in the sigaction to be on the safe(r) side.
> 
>> So I think we'd be safer just eliminating the explicit abort()
>> calls and adding monitor_flush call to error_report.
> 
> I like adding a handler because it is future proof.  No need to play whack-a-mole when
> developers re-introduce abort() calls in the future.  A minor benefit is I would not
> need ack's from 50 maintainers to change 50 call sites from abort to exit.  
> 
> A slight risk of the exit solution is that something bad happened at the call site, so 
> qemu state can no longer be trusted.  Calling abort immediately may be safer than calling 
> exit which will call the existing atexit handlers and could have side effects.
> 
> A third option is to define qemu_abort() which flushes the monitor, and replaces all abort
> calls.  That avoids async-signal-mutex hand wringing, but is still subject to whack-a-mole.
> 
> So: atexit, signal handler, or qemu_abort?  I will go with your preference.

If I go with signal handler, I would also add atexit to flush the existing call sites of
error_report() + exit().

One more tidbit: the signal handler would print pending messages if any of the 11000 assert()
calls fails, though having a message present is less likely in this case.

- Steve

>>> +}
>>> +
>>> +static void monitor_add_abort_handler(void)
>>> +{
>>> +    struct sigaction act;
>>> +
>>> +    memset(&act, 0, sizeof(act));
>>> +    act.sa_sigaction = monitor_abort;
>>> +    act.sa_flags = SA_SIGINFO;
>>> +    sigaction(SIGABRT,  &act, NULL);
>>> +}
>>> +
>>> +#else
>>> +
>>> +static void monitor_add_abort_handler(void) {}
>>> +
>>> +#endif
>>> +
>>>  static void monitor_qapi_event_init(void)
>>>  {
>>>      monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
>>> @@ -712,6 +749,7 @@ void monitor_init_globals(void)
>>>      monitor_qapi_event_init();
>>>      qemu_mutex_init(&monitor_lock);
>>>      coroutine_mon = g_hash_table_new(NULL, NULL);
>>> +    monitor_add_abort_handler();
>>>  
>>>      /*
>>>       * The dispatcher BH must run in the main loop thread, since we
>>> -- 
>>> 1.8.3.1
>>>
>>>
>>
>> With regards,
>> Daniel

