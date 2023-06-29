Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2AF7429D7
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtnD-0000mU-3J; Thu, 29 Jun 2023 11:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEtnA-0000mK-SM
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:42:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEtn7-00048W-N9
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:42:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TE7imb013920; Thu, 29 Jun 2023 15:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=LkwtuhCc1k5GfGPYrXqFQmuxN4iA44iXHbM24FYwjaA=;
 b=NkQ0t1zVxCBj0iA10ElCVrwdQSAr8V6tCOnQ0o/batt2CjQV1O4jt/mRRG+VxwJbq7K8
 SK5lSTN0ydP7JZDYONsiHt3wzPwm5ZL7ahnPJk7V1HFUelo1qEp4FQ7B3dJ901Yk+0OW
 2BlV5Qut+GJgMpmtm0FCM1osECl96pbNqk+GFBq28rGx2u2Mxnz66aDI5Bc5EPNvO4jB
 YqYx+O+loRpc6sUaJPb53zo+w2XPx5H6BjDDDTNVVJA3S6khAuzt5tyoJgO9PywUQuC9
 6acZrEknd4vR5KXpR/ZWIF7YnkrmJYaqm3DNotH6UgGgoJ8y08klMpRI5DyfUv5W50i+ 8Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93cs8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 15:42:33 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TFTJQp008581; Thu, 29 Jun 2023 15:42:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx7je6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 15:42:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRpdUOczIPkmGxIR7X7s7N9KaPYVNlD8c1MxrVQUlLoqrunZ6eMEGpg0ne45i2bVTmDWYt3BCUiaYY2H3SKJx49blC12buZ6R2BjqrmfZ4gw80RTHMrryhsRduUdD3Ji4vMSRaa+ON13xJLQ1uXnbbmvt2PSwVqkVomEn5JZCyBtnFkdDUihLLswKcIrUYkd9x5p7LfVc6/bQA1cJm6n/B/ziIM+ZBnyaMoWk6TcXFjfTNR5pgwBYmGEzCuxYrbaNOIKCDdmAgBpvbHQMaqhPTfBai0DeC5YsUm8dIWc3CrDIE3ww3aFrcznl1QS2WI47LI5qy14xPpNosYh7GfcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkwtuhCc1k5GfGPYrXqFQmuxN4iA44iXHbM24FYwjaA=;
 b=bWS4w/g9QkNt0HvxOPQneL+DIlQ4ahvqb2zXkRQQ80a/FfkTTyygWs6WwZjW6XZIUBcT44ZfQAebe2R9ly6vM+qoG6Ez1q2l3gcVQsCeKr5YBk3dNYZAc2I6nTckuFLScsWSftLplaHCQQyPmp3KLxmo0d8Ykn2r5kg1KzfMusX5EXKtlotWvrOoyyeih+fqsOxRDSnfrPgF1qIn4BA2GpSWkxq1DUGlmvZWgTnhIViE6jCza5lfOhnnEhb/D53p/JtIitc+nJ1sbM9YpM0nD8etl2O1gjP1DEwLb4excgU95XWoCsEZoKJVG6HJsNgVJ7BkduYz+LEOu/RoAw89Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkwtuhCc1k5GfGPYrXqFQmuxN4iA44iXHbM24FYwjaA=;
 b=yDBpVJ0M3GIPK9wTk9hgo1UM67A7bqpfXokAkYyQWLjKknPz0bMYjUOl6jRMfC4H0AMo0wQ1yZAB5vXgwF5MG4tUOkxdXURIh2bw61Za7kw++3uNmmCwwboXNTWqbQ/qgbCOLFKxwGycX6AdLerzLk+/IXni2SBBgFMrWC9haNw=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 15:42:28 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 15:42:28 +0000
Message-ID: <8032e407-2aad-b39e-a6d2-bc2828360e73@oracle.com>
Date: Thu, 29 Jun 2023 16:42:23 +0100
Subject: Re: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-6-zhenzhong.duan@intel.com>
 <9aa97ee7-ee54-a2d3-2cde-36b1a1d1241d@oracle.com>
 <8c9e8103-d194-5e8f-eaa2-1cc16bfb3c9a@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <8c9e8103-d194-5e8f-eaa2-1cc16bfb3c9a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BY5PR10MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 820fcb9e-1683-4bb2-28df-08db78b771aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnfgBlcCwSDiNwHtN301FTbL6hKmldZyGhfce/AXX+nA5qBlhIWQunh6aIpX6bC/QtvS+XvkKbiv1SJnDMaJ7KfSRgeGHVj0vonJu2mUsIyjHPWXHo44QoJiZ5qQkBQ7UQ7NNGVBWWd2anpOHOuPv+iJgPlNXN5JYzyOxODCi+n6QHw0ISlTuifXmbU7DywiOhh/mQWW66PnMOeipUUeNqaWfMXKQ7Cc8n5SQdYEO326itljZoOIcbSnYyMwDOzZlovZWRKWbX78IYT/HToi4tbSR/9jVOtUc4ZYuVmEHrwS7POV7QURp4yWqeRS+pI3w8axXSyJZGF0pRah+Bxcr7MoAhl/tjtK5rUjvdK1mBBJqhE4bDegWrQHP9XEGuXqRsLH83HDfn9g+tqJVeMAPWQNpFsQMWgdl+QurO96Z/E12pUnuTeeC4K8PCXXnSNjqFh1NW9CBN5mnFbsxNqWVzocRtWKy6qTLIIjoT+LgZnbnZqwQ48DAMqzgy5Tf6HIOshzSU6WBPGv6+/Tf7pYw2D4pEd7xf+hnQgti6hBy3zOgqqybCpJ5JDqCfZHMD5mJeVpBeoAScMa4f2Qzdf8h3mG4qIxG0H4PzDZ/iO3FBRq6KEwvqMaGBrr8Anw2Rca
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(53546011)(36756003)(41300700001)(478600001)(2906002)(6486002)(6666004)(110136005)(83380400001)(6506007)(186003)(2616005)(26005)(6512007)(30864003)(66946007)(5660300002)(316002)(31696002)(38100700002)(4326008)(66556008)(8936002)(86362001)(8676002)(66476007)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5aZnBHdUdrSlBzUmUvcmVUb1BUWmVEWTlBUUd1QjB1SzI4dDZWaWJQTVNm?=
 =?utf-8?B?d0RDVjYwUUd3NGxVaGFJdENTQkJLWm9LR253SHdYOXRyNzNJdzlGNGdrRkcz?=
 =?utf-8?B?SVBFMExHb1pXRTMzS0hKMExEbjBSYkMxSllQMmZaM0VpVnVjamcwYStXU2Zx?=
 =?utf-8?B?akVLd0h2djBzano1YXBNdW1tNmFubHlKNm1YQ1N5ZVdYSFg4OWpEalZ1d2hV?=
 =?utf-8?B?U2NLdHRIR1EwS0ZWeCtNS2VqN3IzSjVWa1BXNjl4R1ZDOG1md05RbjZLOVJs?=
 =?utf-8?B?NFNjNkxod3N4Z3VZdEpGb2MvZ0xUTk1HZFEyS01wZW1USkMxWExoYXJHb1VQ?=
 =?utf-8?B?bUt1OXZuRnhJZis2UTRTKzR2VWc3VHJlY0ZRT0ViN3ZuNW9sQnh0bG1jZlZS?=
 =?utf-8?B?Z3lDdXppY2hkbmJQRC85VnhWMzFNTTRzeEYwM0JZclFGVDByWkxxRVgydzZB?=
 =?utf-8?B?bEU2M3JMSFVVeHFCUUNPZ2p2bXlXbWhneFgyaVdORzZYT1NjN2lxa0NSZStZ?=
 =?utf-8?B?TjNXU1laL21rVXNVNEh5aC9NanBZSC9uQnBTc212V0N2a1RmT21hVmYxcDRl?=
 =?utf-8?B?aW1wOHVMckl6Z1dMZ0tZSzZ0c1dOWnh4L2RBbFNwQ3dWbmpxdGF3RXdHQVcw?=
 =?utf-8?B?TzFmV2Roajg4a3cwVWVXWWtLVTkzMzY3RGtNcU1nS1ZGRXh4Nms1TmFiOFln?=
 =?utf-8?B?SWlVV3JUTUxjcGo1RHRja3JNQXBCaWt4OGNoZEo2dWZ6aHRYV3FEYnZwS2xZ?=
 =?utf-8?B?WjdqWEhXSWVaSTZvNXE0UjNUZ01oY0M3QkxjeTZFV2NQTFBtb0QvOTJJVVhj?=
 =?utf-8?B?NFVNdVZmQWpDWFQwMWFQaXVQWU5uelo0OGRJTkZ4bUQvY2hXS0ZIb0NYWUs2?=
 =?utf-8?B?eGlWUmxUT2Y1TFNreGJwb2xLNkoxVDhvUEtXblZ2REU3emU5aFpMZHl4SGw0?=
 =?utf-8?B?MmdiNXUrcmdmdDk1clJKVkV5NEF0eFdaNDlRM3ZUcVdSL3dTeU1iQW50YnhL?=
 =?utf-8?B?ZDhxN0p6VHYzOUVBZ2tLNnNORyszMi8zd3BxeDZORjQxejZYdHh4c2huUDZZ?=
 =?utf-8?B?c1JTQ1JYU3oyeDM0Uy9YbWhJL01ZUEtoWDRUR2hVR0JWa056ZURubmtmVUtB?=
 =?utf-8?B?VnBQY0hiZXY3K3FFNVFHVG9OeS9MOXVkSlJjdXZ4RlBJNm50aFZ0azJydjhD?=
 =?utf-8?B?S0ZqRXQrdlFnOXEwRERVNk1pbHZ0T0NCTWJscHN6UndIOWx4d3NIaG16bVBt?=
 =?utf-8?B?Q0huSDd1YXkzbDRTYXdCR2NRRzQwcmlHY3YzWVQvL2NUNTV1ZmNrK2lMc0Rj?=
 =?utf-8?B?TncrWFIvQmdMamlvUGoxRlgxRjFvUSs0N25id2pPOUluaUJJdC9rSVJDNnhR?=
 =?utf-8?B?bWN0dk5LcG11UTJRV3gybzdzTFhoaUZWY3VYbmtIVXBmRDRHM3lPMnlMZjkw?=
 =?utf-8?B?bzdWT0FwcndPbXVtOXlRUVJRVnpVaFBkY1dQeGdjelI3ZzJTQ05wdEpxUGp4?=
 =?utf-8?B?dlQyZlIzcmhoK3Nsa1pTZkRZbXBSbFRQZWZBaFRpOFpVN1A4RmMrdUlvRkd4?=
 =?utf-8?B?Zmo2ZUhSMXhoOGZXNHc5aUNYOXh1cW5hS1ZFQ2EvdG9jQnJuTHRGTWdFTytV?=
 =?utf-8?B?Q2dhY2NTQWx0ZThJUmRuUFNVM0ZnUTg3SjBYOC92clYwNlBWMDhZY3F1ZHNp?=
 =?utf-8?B?cnovRWIwbTBBOG9LY0FHeFZLd2t6UzByWHpnamxyMUpyM0pGU01kVVJQYnRv?=
 =?utf-8?B?MnFrdmhpRVJtS1hkUXRzZkppMSttWGdnRUhKVTJLM2dsYWVoN0dBa3ZJZXpm?=
 =?utf-8?B?SlZsTjBPUDBZV3AxZk42ekZqOG42dVdWZkZZV2hheUxDV1dmK2sxSGV0ZW5h?=
 =?utf-8?B?ZFQ4QXhaYXFHVmZCRDhGTEhWZ0ZnVkdpdk5Nb0FKMzFmMDJnY3pjTnl4empi?=
 =?utf-8?B?amtOQUM5bmI5ZGZYSysrU0ExcVV3bTJldXBZUUk2SUpTNlljR3hUR2Zvc3Y1?=
 =?utf-8?B?b2YyMDJTZnh2Q3JVb055RnNsZ3RlK1FoekNZdmJRWnJCY0VhWTQwcDZpZmVR?=
 =?utf-8?B?NVVqczd4R1UrdGcyVVc5TTRVTlNHN2ZPaElRa1lYSmNHbEtDWjdRZEhNbnV5?=
 =?utf-8?B?Q1p1SnFwczVUcnZBdWcxeWFwbEdlUmtxT1F1WU9IWjZoUk5SQVVhSXQrbGRp?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qrovRwkAmPhy3gJ/3T9UZ8N4RiSh3brTZNHEOmHl7rjRvfvpr1WOII6Kz2yFKROOK0VZLF8DVyAc6ExQxRuEqNlJDgvSgpouj+zEzsKEzRviFfxyey7TEHpzZLA1soZTcBLlwzRnsJLvY5jtHr5J7jX5LI2zi6OMlV4RMsDYdZOJFsNsINd0LWru0xVEsrmX1jUe2buXnI61FUvxZwKPerc0trFzswA10atvg0Rkx2xXsVcoShq514SmYULtPNm05YYYA3nTd3UVCZ+0Q/7L6u317yZC0oLpmAmNPd4O0ipuvRauZRhJHcuXAGaV2GpPOyRoFO2U+vZWmDZUD5W1XdOlKpZykYe1HUlLfU702mjvWelyYBuLzJmNomSep7veOo+uxQ94rmc4f6dqz7GeHq83IG+KQeiXgSi7fIQby7YfrWxzhIiAzfTcX8xwkt7XQDzPPtKR267MOdZzMbQvPFR4nWTljWld6YXuYeCio4OJ5IWUCH1VsC0VUpOa4Qoo09CMUs/ruHo1S6LmzHO9AArNbVV7GXifINTIR3hhgMLV3zIPDf3FsyJdUy5ftxX6mDsrMh3mjhQdpsjkHn6qXpevgFBlxQbmjkV1cB1cwoImsLgZhJQLchi0k2Y0q8ek4U9Vkyc9oraDDrXc9gd+96k0+VFwFrOCgB1GZajqHSYI8m2wAaZDI5sfNMfHr/o9AlZWjOmZox4rGPbnqThq+t765lMU8TsXZ9iFLvFcsJFWjIZSYfXCQAn3oQWvdAGB0lDijKqlSU2daUDA0fGK0cvMAhMFwFYfLUnZr5R9YZB97PQ78M6M5s5W9QE4M9ilvl+sxJPcg2nT3HgAx50tJA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820fcb9e-1683-4bb2-28df-08db78b771aa
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:42:28.6114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsx4eXw2H9+k0oUjZuLTUKCQRlB0dJFfZa+bqtJ56YAp2SjW/92JtaIpRy9hJAISDdibAs0enAKTCizOeCztiEsF+BBqeO3mWJXK86nBVi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290141
X-Proofpoint-ORIG-GUID: F-GgCJLX7NL71rgOzShnO_kTsdXSkBi8
X-Proofpoint-GUID: F-GgCJLX7NL71rgOzShnO_kTsdXSkBi8
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

On 29/06/2023 16:20, Avihai Horon wrote:
> On 29/06/2023 15:44, Joao Martins wrote:
>> On 29/06/2023 09:40, Zhenzhong Duan wrote:
>>> This patch refactors vfio_migration_realize() and its dependend code
>>> as follows:
>>>
>>> 1. It's redundant in vfio_migration_realize() to registers multiple blockers,
>>>     e.g: vIOMMU blocker can be refactored as per device blocker.
>>> 2. Change vfio_viommu_preset() to be only a per device checker.
>>> 3. Remove global vIOMMU blocker related stuff, e.g:
>>>     giommu_migration_blocker, vfio_[block|unblock]_giommu_migration()
>>>     and vfio_migration_finalize()
>>> 4. Change vfio_migration_realize(), vfio_block_multiple_devices_migration()
>>>     vfio_block_migration() and vfio_viommu_preset() to return bool type.
>>> 5. Print "Migration disabled" depending on enable_migration property
>>>     and print it as warning instead of error which is overkill.
>>>
>> I am not enterily sure we need to keep "Migration disabled". Perhaps we should
>> just derisk from error to warning and use always the same error messages.
>>
>>> migrate_add_blocker() returns 0 when successfully adding the migration blocker.
>>> However, the caller of vfio_migration_realize() considers that migration was
>>> blocked when the latter returned an error. What matters for migration is that
>>> the blocker is added in core migration, so this cleans up usability such that
>>> user sees "Migrate disabled" when any of the vfio migration blockers are active
>>> and it's not intentionally forced by user with enable-migration=off.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>   hw/vfio/common.c              | 66 +++++++----------------------------
>>>   hw/vfio/migration.c           | 30 +++++++++-------
>>>   hw/vfio/pci.c                 |  4 +--
>>>   include/hw/vfio/vfio-common.h |  7 ++--
>>>   4 files changed, 36 insertions(+), 71 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 77e2ee0e5c6e..c80ecb1da53f 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -362,7 +362,6 @@ bool vfio_mig_active(void)
>>>   }
>>>
>>>   static Error *multiple_devices_migration_blocker;
>>> -static Error *giommu_migration_blocker;
>>>
>>>   static unsigned int vfio_migratable_device_num(void)
>>>   {
>>> @@ -381,19 +380,19 @@ static unsigned int vfio_migratable_device_num(void)
>>>       return device_num;
>>>   }
>>>
>>> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>>> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>>>   {
>>>       int ret;
>>>
>>>       if (multiple_devices_migration_blocker ||
>>>           vfio_migratable_device_num() <= 1) {
>>> -        return 0;
>>> +        return true;
>>>       }
>>>
>>>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>>>           error_setg(errp, "Migration is currently not supported with multiple "
>>>                            "VFIO devices");
>>> -        return -EINVAL;
>>> +        return false;
>>>       }
>>>
>>>       error_setg(&multiple_devices_migration_blocker,
>>> @@ -403,9 +402,15 @@ int vfio_block_multiple_devices_migration(VFIODevice
>>> *vbasedev, Error **errp)
>>>       if (ret < 0) {
>>>           error_free(multiple_devices_migration_blocker);
>>>           multiple_devices_migration_blocker = NULL;
>>> +    } else {
>>> +        /*
>>> +         * Only ON_OFF_AUTO_AUTO case, ON_OFF_AUTO_OFF is checked
>>> +         * in vfio_migration_realize().
>>> +         */
>>> +        warn_report("Migration disabled, not support multiple VFIO devices");
>>>       }
>>>
>> Perhaps you could stash the previous error message and use it in the
>> warn_report_error to consolidate the error messages e.g.
>>
>> bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>> {
>>      Error *err = NULL;
>>
>>      if (multiple_devices_migration_blocker ||
>>          vfio_migratable_device_num() <= 1) {
>>          return true;
>>      }
>>
>>      error_setg(&err, "%s: Migration is currently not supported with multiple "
>>                       "VFIO devices", vbasedev->name);
>>
>>      if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>>          error_propagate(errp, err);
>>          return -EINVAL;
>>      }
>>
>>      ...
>>      if (ret < 0) {
>>      } else {
>>          /* Warns only on ON_OFF_AUTO_AUTO case */
>>          warn_report_err(err);
> 
> I'm not sure this warning is needed.
> If I remember correctly, I think Alex didn't want migration error/warning
> messages to be logged in the AUTO case.
> 

Hmm, ok, I missed this from the previous discussions.

So today there are migration warnings in the current code. (even in the AUTO
case). So if we want them removed, then this patch would then just remove the
"Migration disabled" all together (in the two places we commented).

The rest of the cases already propagate the error I think. And the AUTO case
will always be blocked migration and see the same printed messages elsewhere.

>>      }
>> }
>>
>>> -    return ret;
>>> +    return !ret;
>>>   }
>>>
>>>   void vfio_unblock_multiple_devices_migration(void)
>>> @@ -420,55 +425,10 @@ void vfio_unblock_multiple_devices_migration(void)
>>>       multiple_devices_migration_blocker = NULL;
>>>   }
>>>
>>> -static bool vfio_viommu_preset(void)
>>> +/* Block migration with a vIOMMU */
>> I meant in the previous version to put the comment on top of the caller, not on
>> the definition. But with the new code structure from Avihai the error message
>> further below... it will look a bit redundant.
>>
>>> +bool vfio_viommu_preset(VFIODevice *vbasedev)
>>>   {
>>> -    VFIOAddressSpace *space;
>>> -
>>> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>>> -        if (space->as != &address_space_memory) {
>>> -            return true;
>>> -        }
>>> -    }
>>> -
>>> -    return false;
>>> -}
>>> -
>>> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
>>> -{
>>> -    int ret;
>>> -
>>> -    if (giommu_migration_blocker ||
>>> -        !vfio_viommu_preset()) {
>>> -        return 0;
>>> -    }
>>> -
>>> -    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>>> -        error_setg(errp,
>>> -                   "Migration is currently not supported with vIOMMU enabled");
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    error_setg(&giommu_migration_blocker,
>>> -               "Migration is currently not supported with vIOMMU enabled");
>>> -    ret = migrate_add_blocker(giommu_migration_blocker, errp);
>>> -    if (ret < 0) {
>>> -        error_free(giommu_migration_blocker);
>>> -        giommu_migration_blocker = NULL;
>>> -    }
>>> -
>>> -    return ret;
>>> -}
>>> -
>>> -void vfio_migration_finalize(void)
>>> -{
>>> -    if (!giommu_migration_blocker ||
>>> -        vfio_viommu_preset()) {
>>> -        return;
>>> -    }
>>> -
>>> -    migrate_del_blocker(giommu_migration_blocker);
>>> -    error_free(giommu_migration_blocker);
>>> -    giommu_migration_blocker = NULL;
>>> +    return vbasedev->group->container->space->as != &address_space_memory;
>>>   }
>>>
>> nice consolidation
>>
>>>   static void vfio_set_migration_error(int err)
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 1db7d52ab2c1..84036e5cfc01 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -802,13 +802,13 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>>>       return 0;
>>>   }
>>>
>>> -static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>>> +static bool vfio_block_migration(VFIODevice *vbasedev, Error *err, Error
>>> **errp)
>>>   {
>>>       int ret;
>>>
>>>       if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>>>           error_propagate(errp, err);
>>> -        return -EINVAL;
>>> +        return false;
>>>       }
>>>
>>>       vbasedev->migration_blocker = error_copy(err);
>>> @@ -818,9 +818,11 @@ static int vfio_block_migration(VFIODevice *vbasedev,
>>> Error *err, Error **errp)
>>>       if (ret < 0) {
>>>           error_free(vbasedev->migration_blocker);
>>>           vbasedev->migration_blocker = NULL;
>>> +    } else if (vbasedev->enable_migration != ON_OFF_AUTO_OFF) {
>>> +        warn_report("%s: Migration disabled", vbasedev->name);
>>>       }
>>>
>> Perhaps you can use the the local error to expand on why migration was
>> disabled e.g.
>>
>>          warn_report_err(err);
> 
> Same here.
> 
> Thanks.
> 
>>
>>> -    return ret;
>>> +    return !ret;
>>>   }
>>>
>>>   /* ---------------------------------------------------------------------- */
>>> @@ -835,7 +837,12 @@ void vfio_reset_bytes_transferred(void)
>>>       bytes_transferred = 0;
>>>   }
>>>
>>> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>> +/*
>>> + * Return true when either migration initialized or blocker registered.
>>> + * Currently only return false when adding blocker fails which will
>>> + * de-register vfio device.
>>> + */
>>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>>   {
>>>       Error *err = NULL;
>>>       int ret;
>>> @@ -873,18 +880,17 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error
>>> **errp)
>>>                       vbasedev->name);
>>>       }
>>>
>>> -    ret = vfio_block_multiple_devices_migration(vbasedev, errp);
>>> -    if (ret) {
>>> -        return ret;
>>> +    if (!vfio_block_multiple_devices_migration(vbasedev, errp)) {
>>> +        return false;
>>>       }
>>>
>>> -    ret = vfio_block_giommu_migration(vbasedev, errp);
>>> -    if (ret) {
>>> -        return ret;
>>> +    if (vfio_viommu_preset(vbasedev)) {
>> The /* Block migration with a vIOMMU */
>>
>> Would go above, but I don't think we need it anymore ...
>>
>>> +        error_setg(&err, "%s: Migration is currently not supported "
>>> +                   "with vIOMMU enabled", vbasedev->name);
>>> +        return vfio_block_migration(vbasedev, err, errp);
>> ... as the error message when placed here makes it obvious. So the comment I
>> suggested won't add much. Unless others disagree.
>>
>>>       }
>>>
>>> -    trace_vfio_migration_realize(vbasedev->name);
>>> -    return 0;
>>> +    return true;
>>>   }
>>>
>> I think somewhere in function we should have vfio_migration_exit() being called
>> behind a label or elsewhere from vfio_migration_realize (...)
>>
>>>   void vfio_migration_exit(VFIODevice *vbasedev)
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index dc69d3031b24..184d08568154 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3209,7 +3209,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>>       if (!pdev->failover_pair_id) {
>>>           ret = vfio_migration_realize(vbasedev, errp);
>>>           if (ret) {
>>> -            error_report("%s: Migration disabled", vbasedev->name);
>>> +            trace_vfio_migration_realize(vbasedev->name);
>>> +        } else {
>>>               goto out_vfio_migration;
>>>           }
>>>       }
>> (...) Which then void the need for this change. Perhaps your previous patch
>> (4/5) could come after this refactor patch instead ... where you would fix the
>> unwinding error path inside the vfio_migration_realize() as opposed to
>> vfio_realize().
>>
>>> @@ -3257,7 +3258,6 @@ static void vfio_instance_finalize(Object *obj)
>>>        */
>>>       vfio_put_device(vdev);
>>>       vfio_put_group(group);
>>> -    vfio_migration_finalize();
>>>   }
>>>
>>>   static void vfio_exitfn(PCIDevice *pdev)
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 93429b9abba0..3c18572322fc 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>>>   extern VFIOGroupList vfio_group_list;
>>>
>>>   bool vfio_mig_active(void);
>>> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>>> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>>>   void vfio_unblock_multiple_devices_migration(void);
>>> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
>>> +bool vfio_viommu_preset(VFIODevice *vbasedev);
>>>   int64_t vfio_mig_bytes_transferred(void);
>>>   void vfio_reset_bytes_transferred(void);
>>>
>>> @@ -252,8 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>>   int vfio_spapr_remove_window(VFIOContainer *container,
>>>                                hwaddr offset_within_address_space);
>>>
>>> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>>>   void vfio_migration_exit(VFIODevice *vbasedev);
>>> -void vfio_migration_finalize(void);
>>>
>>>   #endif /* HW_VFIO_VFIO_COMMON_H */

