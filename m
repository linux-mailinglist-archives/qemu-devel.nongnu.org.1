Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 944407971A7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:13:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCvl-0003b6-St; Thu, 07 Sep 2023 07:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeCvk-0003ay-1f
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:12:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeCvg-00078q-53
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:12:11 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 387BBZcM017324; Thu, 7 Sep 2023 11:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Zn81D130YPNexyPVh8rqgfDonuKCv0VQ3XBxeFZSHLI=;
 b=uc8Z/CKNgpYrKHikY6Xcihmr9nCEhaXQRRDtnKeHNQlKgSC60FY1OiSpxX1gzclqt5RG
 kN81B46MUoifLPhZCwoMHzCoTIYulncNO3VX1WVVeJPDF9GQAEPpUeOUuMEATtXtpXoG
 wjN5IHDi9kX7MjgzqG4n2Mqnu+FySZ/vVxKzKLk7/XmC34pKGzPXaBO01d1Xxak1nAG9
 VGpAWXrhoxv1FlvY0FmKDMJQ9ZhYqpsP9/tmNl1CHitZQq0alYi798NIuwB32bHEeuEM
 ytjMUHpTuiPbEGy+wIqL4xmo6y2yeHChnnNpj9iycekAIt/0VNpdI206CQucc0kKo8HS tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sycyar1s4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 11:11:55 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3879i3tB028215; Thu, 7 Sep 2023 11:11:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug7jcn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 11:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwv51DkBoLClRkYnZYfkygVe3Kvi2Waoda0sgqQK9xabdAX4Lldq6IpuWkb7vlihqV/4LuOIMnmaz8T53QuaZlzED0S2BTWX0EXEd4F1GGrkMg7n+OBHSM2U/2mVCs+dK0RkOoxn+ziJW7GyRA1BqeAdtW7rnApT04essFdXHfao53xR3QiCHQiZRb5lLbSsgOHxu06fcRjeUxGI3N5oJoMOtfhWZIjoQnWd9U2uCpMwSvLA+turXynfQBkM1dFUtO/95XjRpcQnTHe/erUITzzRiqTNjVcpaUE16kJnavfOZ7iFDGFevPl2nX4ij8xeuDVlHX8rmEdzhrpmAbha3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn81D130YPNexyPVh8rqgfDonuKCv0VQ3XBxeFZSHLI=;
 b=C+vf0S00yLHoPOfr20QdglbPdACe4u9ofP8uQs8wGGfoSYnI8HUzsvDZurEvMayu4R9EynnF3se9RgjDI9BGGdPSGce0J2XF4GmloP+8LMYL6MkZX1Mo6ff0QABbgiz5vGcoKGPHsreMgSLcx4G7WBpZUHZM7+qXm1pvyQmVaN5L3DT2+mpukqy7yt8ZqvHzwf0DW1d3fLbIvCvVugCT1NhE+hw35WPlao7Pfkk9hNRYz0ytqXuZ+Xi5YwRqOfResmaPr73Z5wTps7k/UIaYvkyf3TJkQH8Rfs/t4zrqzUbp2MRcs0SxfFXGza6wSCqMMKhcbJfLjx+cWLrhH0bYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn81D130YPNexyPVh8rqgfDonuKCv0VQ3XBxeFZSHLI=;
 b=jGlMgGOm05Wf245UC6DMaVNbzWfeGbrccu3JDW3EWxo+poQVq0kefCj7/bY0+xHJWxoJT3aOERqxpwPuhYc+q3qXDJk9rPsaN/sMvT0KRpb4c86dSv+FM3MD2bPQKSQB8JabNUYTG5jQxPivdr4OvqM5FzE+DP0fwz8KbWaF66Y=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 11:11:51 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 11:11:51 +0000
Message-ID: <48540cac-769f-c092-a98e-e6d8ff632559@oracle.com>
Date: Thu, 7 Sep 2023 12:11:27 +0100
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
Content-Language: en-US
To: Cedric Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: d8023646-7222-4713-c41a-08dbaf933c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeXsou8zXrd+5tpYk9f7FUpv/x+ZBbb3R+ef0VhRijJBHWTG3+mSBOq1ybWg2tNmVI7tO8x3XVDQOVACnHvdodN4vSLL3XtACZc8hijdBGN45ZrXG4o9P3XMN1Zu9S0Kryy5/kwEizCmCqRO8Q2A0wZ6zG4zxPOMX8GTdZE1CxhSQ7pEgdu0e4iWufblwfIVbrLvsUtjH/6y7LFiI9tnJhT7HKLSE7jHEPUv0Qa3ODLUlShNfHJSNFcus6W++G7g0xjvFDG7Y/ZU5cmlH0o5ZuIryO9d7Njmxbv5LyyEYGf+wqm3cd03A4QknTrCm8tMcla3LtdMd9uRrTolDY8Q9T7kpMvYUraZ/CAtoiPdtD81UCOeE3nfjq2DOS/+emtI/59XzoDK9PCXWLgOymuF10SJWyxVrq///KyTlfWajbSUuX/QnCYWcfvDXs3q8nqKdhcXJI/hYJyfMkSboUxTVjoqBqQBNAxDokhzQSDsRgWd0JF5M0SBnjPkBUPoQIwPqeKLk/nvtCfJd/BT1O8GcSIM6r8nay0Lhv0HGQAyWSp7MkqkukyO8mV62BlHShntqBqY5g3FtYp0ws9RhFCrs1uqj+bq/20DGU95lcPEt8P/8jhYozWrzLrvyXwYpDaxBKsE2eJDC6/cxAsV+ilxtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199024)(1800799009)(186009)(6486002)(36756003)(966005)(66556008)(6916009)(54906003)(66946007)(66476007)(316002)(4326008)(8676002)(8936002)(41300700001)(478600001)(5660300002)(31686004)(6512007)(66899024)(7416002)(86362001)(83380400001)(2906002)(2616005)(26005)(38100700002)(53546011)(6666004)(6506007)(31696002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SSt1T0pNSFc1U1VwVVpFMFZQbk15Z1hLU1RLTlNBZTlHOGZhZ2EyS20wTHk0?=
 =?utf-8?B?VHNoYXJ5cnBxOEQyRVFYYzZVeCtIQWY5T1lPOHQzQ3o0TTU1b25uSXdaUTli?=
 =?utf-8?B?Rno1QitaQTg5Z1EwaGtjVTBlN1JPMVp0Z3JReUpNMFFZV055bzFTOFlMN3ZG?=
 =?utf-8?B?OTVNa0pLOUxGbDRWTU56c0xCWVpSSDlQMlAzNi9NckloZi91aDhacGl2Tzlz?=
 =?utf-8?B?YlY3RGhnWDd0Vmgza3g0elZyRWc0VFNOaFl0bm5vREpIWnNYTDdOVjU1R2g4?=
 =?utf-8?B?WkFEUWNSbU5ZRldvQXVMZlY3OWNkN2RLbDg2VTVGaUZVMjhUMHNtaXluVi9s?=
 =?utf-8?B?TmhhakZ6OEoxUXZhbWZRbUJaUXY1U1ByKzRLYkZNaWRGVit5N2RHdnplVW9z?=
 =?utf-8?B?M2ZEeXBSdnFsWlg3bnVWVTN5Sm1hL1doK2dQbUIrUjNjS3NqUkpuczI1akJJ?=
 =?utf-8?B?cVlrLzA3aXpaYVJFT1ppTWNPcks4bVNlalNpcXlseE1VZ2tJaDJMUWFBbnNa?=
 =?utf-8?B?M0hkTCtTdVhGN1VtOGcwNitNaitIMnJUY3hRamVGcXl4SE5TSm1zTS9wQkhG?=
 =?utf-8?B?aTI1bmx4NE1UUmU3c08xREZray94QysrU1BMTUZMQTFpbjVhVE5mMFpxbnBT?=
 =?utf-8?B?YkVCZ3hDZkZWaXUzcUdZSVdtSDJ4YWs3VFhiU0piRnZHYmtadFp2amZGQjQ1?=
 =?utf-8?B?bE9vcjJKMUdaTHNsQmNIR3RHZU8xUTNteWVDQ3ArTXlFRkowRDhBZTFiRE1a?=
 =?utf-8?B?bS9GMjJJQTVpbktENDNyZURUczMweGdVQ1pyMk1TVmI4dU02MkxHNStwVlNG?=
 =?utf-8?B?dCtveGxNL1VCdHBqOG52cFQrT2FlanBQVGNKNDJDMXNGSmhtZ0Q2MXNDc2k1?=
 =?utf-8?B?bFNIUGsvYTJCZkpobHVJME5wV3JFRTJCM1dsNjlnOGJtdzAxVzdhRFFaa3lQ?=
 =?utf-8?B?ZXA1cGRpZGtpK2YwSzNpSUJmekM0eVhnQllNajBnRDh1Wmcxb1Z0c3ZFYWFT?=
 =?utf-8?B?UUFyekt5UjFTZjhHVCtVQXdSdys5QnBhN2Z0UXZKTm4ySjA0MjM4c3dUd0Rr?=
 =?utf-8?B?RGFhNTNqS0crbUlGZXN0ckZNclNlZ1RTdUNEQ29wTXU1b0xXVjRaSS96WHo5?=
 =?utf-8?B?SXVWU3UyMDBzbGd2OWxGVEgwL3hBWlNYUXpybExHWHVhd1c1MmVyUUw4c25z?=
 =?utf-8?B?QWp2UjZFM09IVVoxQkV4Y3dGS3JUM3BEVHBRK0NLbHJmb1ByY0FFamZWSnN4?=
 =?utf-8?B?aDBidkswckdqSVpJak9pbml2OS9NV0UwNkVOay80S3h1YTg4LzFFYzRZVEhw?=
 =?utf-8?B?WWxJSXdCMzNIR1hydmJTOWkyUnc3eXZ4ZGo2dUFrdGo2VzdmMFl3aVF2NWUw?=
 =?utf-8?B?dmU2enBZdVFRdmcvdWpsY3JNVWhWc09jZktlbGFrYm5UOWh4SFVPL0wwL2cv?=
 =?utf-8?B?UXdUdkhHd0dOdlZ2K1Z5SFE1MXJucGs3b1c1UnU0cVFvMmJ4Vk9GVnBxOENX?=
 =?utf-8?B?YU9YakJSNjFyVys1eGFvRDdmWUFxejRoRWNNbUhhbG41MDg1TEhGLzNQbmZM?=
 =?utf-8?B?cUJxWnV1VndiU3lXQjVLdTNQTlpFWWcxS3M0Q3pMYTZMTDg3TVRsZ2FjOSs0?=
 =?utf-8?B?a29YQ1UyV1VxaXBuMEdFWld2WFA4SGVGNEZmSHJ2SjFvVWNLWTR1aU5pd1Iz?=
 =?utf-8?B?K0xTYlUyTWoxVG1IS2xyc0FicDBjVTFhQjdZemZINloxRm51OEduakFNNXpt?=
 =?utf-8?B?OTNzNHRrZFVsbEtVVkNEY1A3SWdYMFM4NEtKUUQwZVViVU0wckR6dlNlaWRr?=
 =?utf-8?B?U0Q1aFJLcmJXTllqMHovbXJYNG9ZOXNHRUFmZ2hUY2NsL3Q1ZFhnT1Z4cGpx?=
 =?utf-8?B?YzZDd3E2WnVVaHVGRU83L3U5QU5DUTJyanRXRWVuUzFvaWk2NXgreHczdTE4?=
 =?utf-8?B?QS91aUtrZzZWU0RKSkpGK2VWRDZGcktuZ1FIcXVnU1NabzJUR2l1NXhwL0hq?=
 =?utf-8?B?Ylh3OE1LaE1qNmwwTEQzWjFuZzB0Tmh5c04rWEdNT0c3bzVMZ1ZUckxleEpo?=
 =?utf-8?B?UldBeGh2ZmIxRjNON1NoOVRlREZ0UU5JeVU3a2pGU2ZCWVY5Q3NWclZ2TUtw?=
 =?utf-8?B?a2lmK0kxZnpXZC9LWHhRcTUweFNZODQ0WlZsYWE5UGtSMUFrb3BDZVpmMmFi?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tWyklll1CzIfKnlLqaqRqd+93nSJYZUsjrtV6nphop/cokAVxCDjoDqs0DLRoidZ994OAcOBWmHhPwV7NaqZ9bwHm6ZNPA52sP3ZHjrgtF6w9ffEsoZmLPgKacKzrYOKc/uw1uURIunvuCsuPoKkAcsf/xASdRFifzE/jMhClw4NGHjBjvr8j2588nBZR0S04wMrcncg/9wm3zALEipf0NzOKlOHLaWMmlepGLUPk6IbiOg/Z7FoSj/iYJrd9wvuhzrMnucKedIEUQ5B3ybU+mc125IX6ikMNpZHnIP8Cj1NYIwaJ7malzh59s4Npb8llOl0TZY6TFY5Kciwn7zOVEwp2hDxI3RsG6/j6Zer45KstHLP8Fo98QQo/wo5jACQVeMYKt6sMnxNJhJMb9SG/GtYcBEYRKzp68tNDhSWMOU1j9Pyx97FrU/OFZilYVbTMwy1+x4qcrP1xALXUm+9z/9Ewb/KjUXhg2wqG2IqGIp5FMLY2XOEE9898BHp9+nLsXm++BgH56cM/jcMf9ZBG3Sk0C1DN5p3tz6DfPS0b6hwbzD0cYz2/TvRKRU0DNrSo2JpHdZi2M0xpYkprxWja4ei9JCWZ+0hW5SaPHuE6I4jyjDhb32JmEhYMhuFSxb20+PimWfPF57DkJbcQdADvtK+Pr+XydBN2IDNfHKUp9W0repQ5bX/q1YVwqfI8qtvQd9hSmdDDjdiC26aY6mRFta0rimQFA5QeiOA9dO3ZyD35uUlobF3uM/l1plSs72TXVottvZQxEZHcifBc8gh1j7EVwYMeK5WbwIFX7PDh/jvaWHhxpymydXoKQ1/Vtf+9b5tAgFSmtWK/dgXXhVPi0BrFgaNWDa/AEWV9oCyAmMNUStwr7BcQ5ZEaIO51mNDIyV1xR6vCvnugIoJGTkilKEIn4JPgz/drQEacCPD1pY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8023646-7222-4713-c41a-08dbaf933c88
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 11:11:51.6880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBPWPDP+t9fcYaeSLHufzPsV2LrzIh9AX2+TY4yqUver/TQkDzUA2VdVHPi0d30ZT7Z7GQHRi1Bc3ffrmEGZocvqwrF644X28RSMLKKvnHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070099
X-Proofpoint-ORIG-GUID: kDNjCiDkQ9TmRbcSzPpaJnfIVOqqZBYv
X-Proofpoint-GUID: kDNjCiDkQ9TmRbcSzPpaJnfIVOqqZBYv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 22/06/2023 22:48, Joao Martins wrote:
> Hey,
> 
> This series introduces support for vIOMMU with VFIO device migration,
> particurlarly related to how we do the dirty page tracking.
> 
> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
> provide dma translation services for guests to provide some form of
> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
> required for big VMs with VFs with more than 255 vcpus. We tackle both
> and remove the migration blocker when vIOMMU is present provided the
> conditions are met. I have both use-cases here in one series, but I am happy
> to tackle them in separate series.
> 
> As I found out we don't necessarily need to expose the whole vIOMMU
> functionality in order to just support interrupt remapping. x86 IOMMUs
> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
> can instantiate a IOMMU just for interrupt remapping without needing to
> be advertised/support DMA translation. AMD IOMMU in theory can provide
> the same, but Linux doesn't quite support the IR-only part there yet,
> only intel-iommu.
> 
> The series is organized as following:
> 
> Patches 1-5: Today we can't gather vIOMMU details before the guest
> establishes their first DMA mapping via the vIOMMU. So these first four
> patches add a way for vIOMMUs to be asked of their properties at start
> of day. I choose the least churn possible way for now (as opposed to a
> treewide conversion) and allow easy conversion a posteriori. As
> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
> allows us to fetch PCI backing vIOMMU attributes, without necessarily
> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
> was doing in v3.
> 
> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
> DMA translation allowed. Today the 'dma-translation' attribute is
> x86-iommu only, but the way this series is structured nothing stops from
> other vIOMMUs supporting it too as long as they use
> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
> we've then tackled item (1) of the second paragraph.
> 
> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
> IOVA address space, leveraging the logic we use to compose the dirty ranges.
> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
> addressing limits. This tackles item (2). So far I mainly use it with
> intel-iommu, although I have a small set of patches for virtio-iommu per
> Alex's suggestion in v2.
> 
> Comments, suggestions welcome. Thanks for the review!
> 
Cedric, you mentioned that you take a look at this after you come back, not sure
if that's still the plan. But it's been a while since the last version, so would
you have me repost/rebase on the latest (post your PR)?

Additionally, I should say that I have an alternative (as a single small patch),
where vIOMMU usage is allowed ... but behind a VFIO command line option, and as
soon as attempt *any* vIOMMU mapping we fail-to-start/block the migration. I
haven't posted that alternative as early in the dirty tracking work the idea was
to avoid guest vIOMMU usage dependency to allow migration (which made this
patchset the way it is). But thought it was OK to remind, if it was only be
allowed if the admin explicitly states such its intent behind a x- command line
option.


> Regards,
> 	Joao
> 
> Changes since v3[8]:
> * Pick up Yi's patches[5][6], and rework the first four patches.
>   These are a bit better splitted, and make the new iommu_ops *optional*
>   as opposed to a treewide conversion. Rather than returning an IOMMU MR
>   and let VFIO operate on it to fetch attributes, we instead let the
>   underlying IOMMU driver fetch the desired IOMMU MR and ask for the
>   desired IOMMU attribute. Callers only care about PCI Device backing
>   vIOMMU attributes regardless of its topology/association. (Peter Xu)
>   These patches are a bit better splitted compared to original ones,
>   and I've kept all the same authorship and note the changes from
>   original where applicable.
> * Because of the rework of the first four patches, switch to
>   individual attributes in the VFIOSpace that track dma_translation
>   and the max_iova. All are expected to be unused when zero to retain
>   the defaults of today in common code.
> * Improve the migration blocker message of the last patch to be
>   more obvious that vIOMMU migration blocker is added when no vIOMMU
>   address space limits are advertised. (Patch 15)
> * Cast to uintptr_t in IOMMUAttr data in intel-iommu (Philippe).
> * Switch to MAKE_64BIT_MASK() instead of plain left shift (Philippe).
> * Change diffstat of patches with scripts/git.orderfile (Philippe).
> 
> Changes since v2[3]:
> * New patches 1-9 to be able to handle vIOMMUs without DMA translation, and
> introduce ways to know various IOMMU model attributes via the IOMMU MR. This
> is partly meant to address a comment in previous versions where we can't
> access the IOMMU MR prior to the DMA mapping happening. Before this series
> vfio giommu_list is only tracking 'mapped GIOVA' and that controlled by the
> guest. As well as better tackling of the IOMMU usage for interrupt-remapping
> only purposes. 
> * Dropped Peter Xu ack on patch 9 given that the code changed a bit.
> * Adjust patch 14 to adjust for the VFIO bitmaps no longer being pointers.
> * The patches that existed in v2 of vIOMMU dirty tracking, are mostly
> * untouched, except patch 12 which was greatly simplified.
> 
> Changes since v1[4]:
> - Rebased on latest master branch. As part of it, made some changes in
>   pre-copy to adjust it to Juan's new patches:
>   1. Added a new patch that passes threshold_size parameter to
>      .state_pending_{estimate,exact}() handlers.
>   2. Added a new patch that refactors vfio_save_block().
>   3. Changed the pre-copy patch to cache and report pending pre-copy
>      size in the .state_pending_estimate() handler.
> - Removed unnecessary P2P code. This should be added later on when P2P
>   support is added. (Alex)
> - Moved the dirty sync to be after the DMA unmap in vfio_dma_unmap()
>   (patch #11). (Alex)
> - Stored vfio_devices_all_device_dirty_tracking()'s value in a local
>   variable in vfio_get_dirty_bitmap() so it can be re-used (patch #11).
> - Refactored the viommu device dirty tracking ranges creation code to
>   make it clearer (patch #15).
> - Changed overflow check in vfio_iommu_range_is_device_tracked() to
>   emphasize that we specifically check for 2^64 wrap around (patch #15).
> - Added R-bs / Acks.
> 
> [0] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
> [1] https://lore.kernel.org/qemu-devel/c66d2d8e-f042-964a-a797-a3d07c260a3b@oracle.com/
> [2] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
> [3] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
> [4] https://lore.kernel.org/qemu-devel/20230126184948.10478-1-avihaih@nvidia.com/
> [5] https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
> [6] https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
> [7] https://lore.kernel.org/qemu-devel/ZH9Kr6mrKNqUgcYs@x1n/
> [8] https://lore.kernel.org/qemu-devel/20230530175937.24202-1-joao.m.martins@oracle.com/
> 
> Avihai Horon (4):
>   memory/iommu: Add IOMMU_ATTR_MAX_IOVA attribute
>   intel-iommu: Implement IOMMU_ATTR_MAX_IOVA get_attr() attribute
>   vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>   vfio/common: Optimize device dirty page tracking with vIOMMU
> 
> Joao Martins (7):
>   memory/iommu: Add IOMMU_ATTR_DMA_TRANSLATION attribute
>   intel-iommu: Implement get_attr() method
>   vfio/common: Track whether DMA Translation is enabled on the vIOMMU
>   vfio/common: Relax vIOMMU detection when DMA translation is off
>   vfio/common: Move dirty tracking ranges update to helper
>   vfio/common: Support device dirty page tracking with vIOMMU
>   vfio/common: Block migration with vIOMMUs without address width limits
> 
> Yi Liu (4):
>   hw/pci: Add a pci_setup_iommu_ops() helper
>   hw/pci: Refactor pci_device_iommu_address_space()
>   hw/pci: Introduce pci_device_iommu_get_attr()
>   intel-iommu: Switch to pci_setup_iommu_ops()
> 
>  include/exec/memory.h         |   4 +-
>  include/hw/pci/pci.h          |  11 ++
>  include/hw/pci/pci_bus.h      |   1 +
>  include/hw/vfio/vfio-common.h |   2 +
>  hw/i386/intel_iommu.c         |  53 +++++++-
>  hw/pci/pci.c                  |  58 +++++++-
>  hw/vfio/common.c              | 241 ++++++++++++++++++++++++++--------
>  hw/vfio/pci.c                 |  22 +++-
>  8 files changed, 329 insertions(+), 63 deletions(-)
> 

