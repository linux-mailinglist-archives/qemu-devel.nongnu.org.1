Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1487983DE
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWfx-0006IZ-4M; Fri, 08 Sep 2023 04:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeWfs-0006G6-81
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:17:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeWfm-0004xH-OK
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:17:07 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3888EvF5032612; Fri, 8 Sep 2023 08:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kRS/4vXehHB+IMYaKLdiWYh/ZV3CgqQsFVXzuXi3RUA=;
 b=PV+Oq15zNJYJiMY3H2AIoKnHz/burrP81eXHJr6xa7fHY55tWU/5Q332O4mzsNz334bv
 fxL3ZdJwytOqcPxA5s3d9rr6Jza3Msl5aJefQGb1Ff0I3UaQ5/RCDQT3xloXXLxpTyMp
 2yxp/Q7SopIcKa/oFVCyiT+8LsbVAQWrsAgXjTAbDyDXWU6C/xL/1wiRS1arPWPSr4mV
 17dritaixhFaKH3PPuJ/TYTbphMItAvvNkAhhFB19yUVr/tViZnZx3Hhf56kASZrITsn
 s2lhmjIjA9p02liVtuP6ElH0ksXH6T8bLMDiNgZBp2oSOzIATzl8zT788lAl92MlXY2r nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syywyg04g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 08:17:00 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3888DWqK016801; Fri, 8 Sep 2023 08:16:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3suugf48g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 08:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUb9VyGZ6EIt24KZ/H2bKbEaUZMPbsfV/agJZfipY1QCeccYFe7JREyyOQUG9lz4D8EvOUkcacHq/sl1wfksLfQOTgYS3zwk0PsEJnmXoD/6k2inO7IMwKMfXsNX/hkVFVsJtJtVEc59WYoykqjdml+F526eXbTud3J1BaPdVkCnX8VyOmcCcA1wY2jFpMc+4lvFGHXwGP9mu1bpWKavjDK/j8XrBeImR3kP5V5cnTYwKpR+7+NwLcuy0JAeXRvdl7SB//hCZYiRZi8+wmJGyy/2LjrV6leTvvDIpcGIX7AJOfCISOLAhslCQ8dAFcJtsuQRznjH+gu0UUrDRtKMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRS/4vXehHB+IMYaKLdiWYh/ZV3CgqQsFVXzuXi3RUA=;
 b=NaeEbJkEIBeFncOjyVlenFiswihv/vfif721kZ3Tz1tAUOKBZOgpDuWYKyCMXhhiRaWbJMVwYCJqtfLl87OcLYZ55x02opeTtf9L49/InpMNmrHaqE/tZnKpxJf5GbG4WAQLeAawX5AQWxx7qHnd/JxH5aHDjro9GO7myYmwEd0yrAuGgaa21DY688Dg6pL858tEOQFFrYXcc2Bn1UeBeJv2kLTRllaFBSAFAtoBypCcnrWX2FUd4pxBeK12hHaIt9DwwNA7uoOQF5yALQG7CVG6ALpMc15TlrTcEUC3GnGSqnjCF9aZy8jOv9HANRW5kIxltRjY5HnKYlZeOTUHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRS/4vXehHB+IMYaKLdiWYh/ZV3CgqQsFVXzuXi3RUA=;
 b=tpW8EBSx75uyqefYQ+gX2yJgRiakzV9icOeWvBe3iDi68QsedyBKAWKhjx/6rtoFNxjtLVMgMtg8bMwT0EKNiMEiaBh20elAGQRODUJZJHqkRjbptARFiKmaWiTHHDDRWytPgGFRQaEAXn1Sc1x6geL9yV5/wr9kZOjOcFddgL0=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by LV8PR10MB7992.namprd10.prod.outlook.com (2603:10b6:408:1fd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 08:16:56 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 08:16:56 +0000
Message-ID: <77ff66f4-ef7e-119e-40b3-d7352918166c@oracle.com>
Date: Fri, 8 Sep 2023 09:16:49 +0100
Subject: Re: [RFC PATCH] vfio/common: Separate vfio-pci ranges
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20230908071438.86136-1-clg@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230908071438.86136-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0252.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|LV8PR10MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4237eb-74d1-4c9f-fd51-08dbb043f70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQcSbOb76sdpIDMPZRFH4nPyOau+NEJau80bvjOn+a/d4j+84V0wE8BBuJhnW6mPUOBNbq1b57tEmdlYOdQdhJyGE+PigcVDV3Gg9AWi7uRyw7NvU5ouDeWdY6b/Y61d/FNT/DhMT58C02BY2nuzbLK6Jm13wuv1zkQdOGVgkbpIjTxF1tQyhnj/VtPGoLf7n4BzbGZGTZFWmWzmnS2wzcmD7jBoFWI/TJ/CHPxy3cJ644W2lJ/ctBNpF9Js7q64gyNFRNYjlIfN2CIYxgJY9n9X1T1Xp7O99zPsIKfp/s+PovwQV+GA0S7cBWgcW2EyDwIr+IC2PGYjyEBYtdc/fkhLiWOrenO/o7MXKSQZPaOi6dYVBRJt5CpYTl4JQjxuSMMskxImuBaYutMM5GbP8TQMBdI2Ag0+aELIZQwXkO2gFIUVxwacpRJE7i0Tr7PvWKHgqQVNpYg6KNx+ZSTYpCEZE1bz/XPf95fqQExInRiltKxG19ph1y2pP+NCKC3Fi6eLsGaIOfqzNRB7GR86M8x9gI1GNiYvJK1q7AIM2G0QCctAvB/oxZiRCzVhv0I6X5zKI88/GNiAEP7uhDGEFxEiFmADLKkmOUbXmEzVyX4MDDNriVMVIr/YcVYsllP0abZr7wRfe/j7xH6OVpbEXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199024)(186009)(1800799009)(31696002)(66556008)(86362001)(66946007)(6916009)(41300700001)(316002)(66476007)(54906003)(6512007)(2616005)(26005)(6486002)(5660300002)(6506007)(8936002)(31686004)(478600001)(4326008)(53546011)(6666004)(8676002)(36756003)(38100700002)(83380400001)(2906002)(66574015)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3oxbVZUOWREYitmVVR1M3RXeGNvc2tDY2JDby85bXByWUt4Y3lXcWpJNlBm?=
 =?utf-8?B?UFBSd2orK2pLdXNsSXdDayttM0R1NE9KYlJBSnp6UVFzTU1pN201TTJxQzJy?=
 =?utf-8?B?KzBWOFU3RGlvU21BNjY4Y1pqUlNVcnNSWkpkTTd6RmpNNHdLdjNaSjNnWnYy?=
 =?utf-8?B?b2FQYS9nR0FzbjA4eWFGL0N3SkhNRkxYMkpOd1ZSWEdSVHU2RTJRZUpQRXZY?=
 =?utf-8?B?c0oreVUwK2VoY254SDNmZUROYStjcXFOR0gyd2l1dzVFSVppeUFHMG85NTVq?=
 =?utf-8?B?VkdVMm1LOVQwamdtVUhrSlVqblFUMjkvRjJGY21ncUtlSWtJZlBPczlYQmhE?=
 =?utf-8?B?MVpHZWFGZ1lEQStLanlaOEVpZUl4UUlrbWl4c0p2RGdiUlBUelpXaklQK3ZZ?=
 =?utf-8?B?NkhxZFRRbTRqazZtbE5panY5RW9JdDVkMjRYUTVFUVVkVk5PdmUxR1ZHdTlt?=
 =?utf-8?B?SDFCUmFUL3I0S0tDTUVzcnYxOW5BQy9IbmZsUk14cG9PLzA1TjFHVlo3REk2?=
 =?utf-8?B?amcwbmgwbkhnaUxSSzllbkV1czRhWUVxZTgwYjE2RDdJTXFJVU8rdVRMNDg1?=
 =?utf-8?B?UkJvd0xJWEMxWEQ3L21EV0c5amQ4WlZGSDlMaEN2a0ZZNER4MjNWd3hPbVBI?=
 =?utf-8?B?UmxCWHZJdXBlZzRsOGlLeEloUDJrM0w5K0pjVE9HbTR0WUh0UkVyZjluV1kz?=
 =?utf-8?B?bWdGTURqYTZ5czZHdnRlMG5ZamcwTHhEVkh4dVh3aENZRzU3OVVJUTdtdXlr?=
 =?utf-8?B?SiswZnRqWXZDVjM4VjdoRkM4VWZqd2N6V1UzeDlDMlMzUXFRSU9FeVlLTmtF?=
 =?utf-8?B?VWpRemtHZVNWaE93Sm85Z3lzdlQ5cm5BbUtpQXBYQi9kOVFNb0hoSTZhMXVm?=
 =?utf-8?B?ZHVJTHAvUjNJY1pMZ2x3YXFwT0w5Z3dvSFgwUG4wVVJ0Q21KNktyT1FCMWFG?=
 =?utf-8?B?bXNJTDdzL01aNzVGMFAyZGRJYWdIZlkzb3FPWnNsT2RUamVsLytNSnpBc1pZ?=
 =?utf-8?B?ZlZVZTFXajdkVVhJWVZCTmlaemFqQ3crSE9GS3h2aEZrRGRzaUk5UVk1VkQy?=
 =?utf-8?B?UkxVRDYwYXgxcVJ0QTRYS1dqaHkyR1VtRDBYVEkxcU9MVzZhU1d0TXJ2eEVh?=
 =?utf-8?B?RWcwV2FNaEMvOWc3WEVTU1lJTjJkcEd3dzNDdC9uZmxRODJ4NEFSdFdRNWVM?=
 =?utf-8?B?c1IxVU1KRzBMc25XWW1kbXNPR2hBZjhIekYvbEVLYVZ3UUVnVFp5Z0dueE1I?=
 =?utf-8?B?WWxBS3hCODY4OEtZY2txVVNITkwrckdIOFpHT2Z6VE1sY0xGcjUvZC9UejZx?=
 =?utf-8?B?dGh4OWhXMXp4VWM1NzJHU3B6aW4zQTFNL1dVdFZLaTNDaXN1RXZkS1R4cVBh?=
 =?utf-8?B?dHQ2V0ZSZ2R2NHovMUVhaDNSM1FhOEdDRExsVGMzTVh4cmE0MlhCL0RpL2hF?=
 =?utf-8?B?UjRNVEw2M0NnTmV3U1hXZS9rSmZUQUNLQjRnaWR1bnBkM2Y2R0FWNE4yUTR3?=
 =?utf-8?B?QUVjaUl2Y0crdDJkMUNQMkZLWm5tYTV6VGJLM1VFN0JJdGg1NStxUjF3OW42?=
 =?utf-8?B?T0FiSSszdGM4MjNBbWJINUFNKzVXdW9TV2xMZUwwa2pZblkvMDBwWXhIWkF1?=
 =?utf-8?B?RFl5SlRJMG04S1Rhb2VTUUpGNWRBZFRQVWwyQTdOU0llWFgyUmNuYk1VdDBv?=
 =?utf-8?B?dHZhZ2FrZTBJTndzU3haSFlYNXpwSzc1SGM4U29oZWl2c09RbzVZS294V2hk?=
 =?utf-8?B?enJQRWh0YllDRUNzTFByUG42aElQSkVSZ1g3WFVwdXJ4T21uQ3FxL0MrU05o?=
 =?utf-8?B?azZTWFB5ZWJGOEFFUFpWWldKbExYZ3pCd01naU5RNGZoaUZ0aXFLdXZ5SWhF?=
 =?utf-8?B?c09CYlovcFljcS80d2l5Um44VGJ6RG1UNTBjbnNGT0NZdGZQczRnZjF1SStl?=
 =?utf-8?B?eWt6VnNMTmcvODhsOVZjemtsVndjQWxqZExralNrUDQxd25XZUIwOXA1MGMx?=
 =?utf-8?B?eXNCZEZZdnAwcnc2UmtNY0lIRHR0OTFRYmtha3AxeUlKU3dvRXhzaXpHd1kr?=
 =?utf-8?B?eG9EQ29UaC9xWmVOMWtKODdpM1NsV2NGcC9wQ1U3TW5OQUkrZWsyNUpSMFl3?=
 =?utf-8?B?MHp0Q2pXUTlxTkx0SVMrK0JFMlY1UUtvUEZsb2F0cnd0V0NsQjIraWhScld2?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 629RBGEayAWN7fMJB+LSx3UjLumJPF1kxJmJfNEYRsCkCfE+NWBVJuYkJXZNLUYjudVSElPlASoZXXcHY62sCEv5aqWXgRbucoholzGr499KMWjG7F7Bt7yNU38zmOAhZFX6GrBieLwYI9kGQOhuD9/9MWs5Bk3ZpV8T7tpb7A9JoAIxvROXHwsmIHOiprHMWiGBmve4t3+8n7FvYLqvwyxv3lkkOtYWvJbgZJ/cDzyCkodmIg1VNgeTiDDvVOj2R1U73mxs24/IBu4F4sOsz3iIRQyf3fSukLbCCcepPvPVX4iNl5XhCmyqtM1qHSA1yxTlVAaw70+psOtBwTAE+95VSt0Xet/mw0vr6q5kEFGRnI6C52TCv77fb+lLbBiDTD/XQsaSy8s4ZO2N/TdoC+ygTm2mc4OwQyn8Og4zCJ6uMNAErfE4kYp7NwLC2wyYfvbXAs1kqgzu1+O0KC18yOMR75DlPU2YsIuJ7D2DrnBPdFu82QNfGEFTeXvmsE1yHyCilGVGZ9Ib4aQNiv//FCzeu/eQ2+fHybBmH8XGun5fuJ5pp4H9OWDBT6mrm2ZPKNBE4gsJjl0gMJy1sALGvpdo/YMnkqopblQyj65TwnUETWuvvrVPDhPh3nKZD5z+qc7AfLavcTqdRqK8Q5y9n7MLB9rZ44WJCqeaK/PxhXNvgfbF67IkgxoGWaCh4QCqhXxnhVpZrfTvUSR/HQKmAA6gQzXbd8iUKuUFcA82RKgIdckh3uGTqrIwPZpk1z5X2VkN5yGZsdlHJ63m0XUH/RZflFqpDvkF2VSyFucOnh9Z5cLjuAYn0uDNOtM5Cr2Y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4237eb-74d1-4c9f-fd51-08dbb043f70f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 08:16:55.9758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9/lILcAmLVB5bFRnKbsS/WPxDmMHOXvXANf99gzIZ7WD1X0fenpeOYGjzOA3KlzbaNxALhgxKKH0uHlV4CE2VqRD9vbl7PsWQwqMDKN7D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_05,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080075
X-Proofpoint-ORIG-GUID: PZ7uMsoVRoPCf4vKMdvqzDt3wkUNifcU
X-Proofpoint-GUID: PZ7uMsoVRoPCf4vKMdvqzDt3wkUNifcU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 08/09/2023 08:14, Cédric Le Goater wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
> QEMU includes in the 64-bit range the RAM regions at the lower part
> and vfio-pci device RAM regions which are at the top of the address
> space. This range contains a large gap and the size can be bigger than
> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
> 
> To avoid such large ranges, introduce a new PCI range covering the
> vfio-pci device RAM regions, this only if the addresses are above 4GB
> to avoid breaking potential SeaBIOS guests.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> [ clg: - wrote commit log
>        - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/common.c     | 51 +++++++++++++++++++++++++++++++++++++++-----
>  hw/vfio/trace-events |  2 +-
>  2 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 237101d03844273f653d98b6d053a1ae9c05a247..a5548e3bebf999e6d9cef08bdaf1fbc3b437e5eb 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -27,6 +27,7 @@
>  
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/vfio/vfio.h"
> +#include "hw/vfio/pci.h"
>  #include "exec/address-spaces.h"
>  #include "exec/memory.h"
>  #include "exec/ram_addr.h"
> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>      hwaddr max32;
>      hwaddr min64;
>      hwaddr max64;
> +    hwaddr minpci;
> +    hwaddr maxpci;

Considering this is about pci64 hole relocation, I wondered post-reading your
feedback, that maybe we should rename {min,max}pci to {min,max}pci64 (...)

>  } VFIODirtyRanges;
>  
>  typedef struct VFIODirtyRangesListener {
> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>      MemoryListener listener;
>  } VFIODirtyRangesListener;
>  
> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
> +                                     VFIOContainer *container)
> +{
> +    VFIOPCIDevice *pcidev;
> +    VFIODevice *vbasedev;
> +    VFIOGroup *group;
> +    Object *owner;
> +
> +    owner = memory_region_owner(section->mr);
> +
> +    QLIST_FOREACH(group, &container->group_list, container_next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
> +                continue;
> +            }
> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +            if (OBJECT(pcidev) == owner) {
> +                return true;
> +            }
> +        }
> +    }
> +
> +    return false;
> +}
> +
>  static void vfio_dirty_tracking_update(MemoryListener *listener,
>                                         MemoryRegionSection *section)
>  {
> @@ -1434,9 +1462,14 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
>       * would be an IOVATree but that has a much bigger runtime overhead and
>       * unnecessary complexity.
>       */
> -    min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
> -    max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
> -
> +    if (vfio_section_is_vfio_pci(section, dirty->container) &&
> +        iova >= UINT32_MAX) {
> +        min = &range->minpci;
> +        max = &range->maxpci;

(...) specially considering this check of making sure we skip the pci-hole32 (as
that one is fixed)

> +    } else {
> +        min = (end <= UINT32_MAX) ? &range->min32 : &range->min64;
> +        max = (end <= UINT32_MAX) ? &range->max32 : &range->max64;
> +    }
>      if (*min > iova) {
>          *min = iova;
>      }
> @@ -1461,6 +1494,7 @@ static void vfio_dirty_tracking_init(VFIOContainer *container,
>      memset(&dirty, 0, sizeof(dirty));
>      dirty.ranges.min32 = UINT32_MAX;
>      dirty.ranges.min64 = UINT64_MAX;
> +    dirty.ranges.minpci = UINT64_MAX;
>      dirty.listener = vfio_dirty_tracking_listener;
>      dirty.container = container;
>  
> @@ -1531,7 +1565,8 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>       * DMA logging uAPI guarantees to support at least a number of ranges that
>       * fits into a single host kernel base page.
>       */
> -    control->num_ranges = !!tracking->max32 + !!tracking->max64;
> +    control->num_ranges = !!tracking->max32 + !!tracking->max64 +
> +        !!tracking->maxpci;
>      ranges = g_try_new0(struct vfio_device_feature_dma_logging_range,
>                          control->num_ranges);
>      if (!ranges) {
> @@ -1550,11 +1585,17 @@ vfio_device_feature_dma_logging_start_create(VFIOContainer *container,
>      if (tracking->max64) {
>          ranges->iova = tracking->min64;
>          ranges->length = (tracking->max64 - tracking->min64) + 1;
> +        ranges++;
> +    }
> +    if (tracking->maxpci) {
> +        ranges->iova = tracking->minpci;
> +        ranges->length = (tracking->maxpci - tracking->minpci) + 1;
>      }
>  
>      trace_vfio_device_dirty_tracking_start(control->num_ranges,
>                                             tracking->min32, tracking->max32,
> -                                           tracking->min64, tracking->max64);
> +                                           tracking->min64, tracking->max64,
> +                                           tracking->minpci, tracking->maxpci);
>  
>      return feature;
>  }
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ce61b10827b6a1203a5fe1a87a76d96f25c11345..ab52c6bb7f0c11e51fefef231c108d0c9381547e 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -104,7 +104,7 @@ vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_wi
>  vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>  vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
>  vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
> -vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"]"
> +vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci:[0x%"PRIx64" - 0x%"PRIx64"]"
>  vfio_disconnect_container(int fd) "close container->fd=%d"
>  vfio_put_group(int fd) "close group->fd=%d"
>  vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"

