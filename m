Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8761F7312CA
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 10:55:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ikG-0004PN-0R; Thu, 15 Jun 2023 04:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q9ikD-0004Lo-DC
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 04:54:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q9ikB-0005as-56
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 04:54:17 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35EJww8l009905; Thu, 15 Jun 2023 08:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=20ndioUS7Zrs85U5Ses5kJxsSJtS/1OmD83YosKyxWI=;
 b=ndz61TsGe6+REGpUmV4cFpr9Qq6ERvJUsceuFlEf7jyAewp6hcr4uWb6bOU6//ziC0BP
 bavBWK237wpVweKQctOXcD4wNIcevGz0qP2PwPAvxjfy89qEM46V6xAepkoexU9+9D1W
 2eCVflmfzaK2hGAflkeSPJ46FV1O4Fny6X3jTbnqVFlXeHEcxiyo9nk2lGIpvBoqpZGe
 gD0gyCanQs4Mbj0fTfgjUsFLn4gfjJ9RQJLMJv/u87ybZmrP6qiPetxNya3zV5rkPcNP
 hqJ8hiRd2cde2j0HjEfxRsR4UX8oQsAl/iuXMNGKhIaxCCgojQqweba+fV18PNvKftUU rQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bsksn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 08:54:10 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35F7UDwc017707; Thu, 15 Jun 2023 08:54:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm6csdy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 08:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoGymtqC+79gllJdI/Ut7IY1B3OdXHn1+VPzz86GGio0yiDpNbj2BsP3CHkU4gNc3EWusphHRNM+iKR0Ia7P5dwp6EUu67AGH44X13XMNM7YM2TxvV+hoWvwfCajlb8O6K21s5eM/polvIksyANp+xLLHLHeC6vo67AAEQZCGXwQ0YwlbFKTPWbZwNPX0wQ5I7w23JkVGIkDjV2QWYEKX+0nbDH9wHPrmxfn+ZWJyLzmr7p8rrXhduZtvF0K1XUK21RBSk9yHTOJLsyzLefFiRL0D5pZig63U0nEL6QPKEYHBQJ8HcSzmm47lDGohOzJbBmwnVTwaEIKuVWYa2ov+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20ndioUS7Zrs85U5Ses5kJxsSJtS/1OmD83YosKyxWI=;
 b=Yixt3DQQpUC7rklFwBkETaT6Z7aXu0KW0o8DgxkWdsQar9fD/zCa9wlQqwzDj0a5jEh1JowrnFuP0ufQr5mf1op9cqslr3e7i/rs0sofGjQ+E7VPTWRDaoik8Mtba4kXl2qPTVtSFIxB9s91qCC7cc6qYOBNdr+ch+uLjht6zQquoPOKY2+RhCQudcN7JLAIIZWlT/LM082EkMKfn6L0BlKIY6hL6doHA6GmE88aC2eEUiRIDeo8oxEE5Bp3mvYSlFBjEIMnhFm6oMO/FJVdUOScSYEro8yHM1A2bp6Xn7r12oIvTH3h+fLainaj/95XHmZvuKiUzDmfCV2gyfCeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20ndioUS7Zrs85U5Ses5kJxsSJtS/1OmD83YosKyxWI=;
 b=xI7ExCReFTbw19bVIaDWWDKDjeJ2Ez0ylnIJtXeTT7EntNUGvm5TXyeXhsRZapFNqvkTCUFrN6n9xtwMlEmOcOSeThvDGfEMb3RAVH2nCEUDOpLraHe/IuFhW1cAGTTmtGp57AXLoiCK535exUn/YGbZPI4llhZ5jup9nqb35BA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ0PR10MB5631.namprd10.prod.outlook.com (2603:10b6:a03:3e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 08:54:07 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%4]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 08:54:06 +0000
Message-ID: <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
Date: Thu, 15 Jun 2023 09:53:59 +0100
Subject: Re: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, qemu-devel@nongnu.org,
 chao.p.peng@intel.com
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230615081851.326816-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0590.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::6) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ0PR10MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e847be-616f-451d-aaf7-08db6d7e1341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pn08a4tNDKAOKBioFqb5FC2Iex42el1/IrjItZFLv4s+xTWve2WN/ZAjDfYnGHV4LhKcvMhg3Kos7zxE7woTrLUM8oC11mR/mMMKl2WvAwp/4ref21AjiOOvYGeMFaBK+PCyGNkNc0Nyyq25obufDLC0IydD+lWq7g//VRUpbPvyg8JVv9v5xpt+gbwCmh+TC9gAPT1m2KQavZxEszOx4DGLR/hcJybHh2Hr9nB1x9bfScQfjEOgILzJObAjJgxIoM3ikTBmqYYsfmI9MuMD6K6NxiZLWYh4qAn0YvNxp+KQ2UMRZIXvRF/pnRl1pDQ77KlwfvIF0xrfrZxXbWn+0L1IBO8Dbe6ABUYgmuW+vNzvFkMxd3LBWxq99/ZLoJEuP/NADkjm0tYl7JE51+dbH/5162U/6YJs8LdSjyYVIFGb1AfLN2f9oJSj+7Rvzl6qtZilPh+sqXdgL+hY0tLwnbejQ5kIbhgqXY5qDxNpDsB0BmjC5qRXWBO4DvI1NKmvt6NO5Vy0z5HHumAIaLC3IdTVZF2tn5aERoDA8OK7t9QYdfFQgLkX0M4+dLJY0wW4UqIyEO6SXMqKOY/XlcQVg1/ACL2iUHAI/dedZMqpTkPlIo6DwFHq07fHhYizZq3zGQ/ywfcLCxsUSaL1lc0LvQF5qFJY0QSaacoIhhRVp4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(31686004)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(8676002)(41300700001)(66556008)(66476007)(6916009)(4326008)(66946007)(83380400001)(2616005)(53546011)(186003)(6512007)(6506007)(478600001)(36756003)(26005)(2906002)(6486002)(6666004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZPdFl5elhJWStUZy8waFlmMHhSc3kvQ2hZRHZydHJnMXhDR0J3bEM3VEdE?=
 =?utf-8?B?WFBoYWZjdFFqcGVDUmRjY210WE0wekFhclQzNW5HMnVZL3pRU3pxN21QOGlW?=
 =?utf-8?B?Q3czeTlSWnhmMkpiOXBCNm9lZFZwR0p5QVpkRnNHc3czTjFVRDU0b2ZEcWtW?=
 =?utf-8?B?VG5rTE5zVHh4cnVhV3lrZHdJVmp3QVdGYmFCc1J3T2FoZ2ppNWhGTnkvbElZ?=
 =?utf-8?B?c1ZXUEU2bUtKd1NpRW80Sko4aWhVb1BWb3BObjBYT1JKVW4rbmZHTDdvUEMw?=
 =?utf-8?B?MmZpaUdCL1ZEcDltZnV1OTZ1SVFiYmxuTkUzMXgwNjRqNXNCNzZLenVucWp6?=
 =?utf-8?B?R3NKMnk5VjkyWUlhK0VXbTg0VUlQc3dmRFJaVmNBRmdSaFMwYi9TaDlKNlha?=
 =?utf-8?B?VXVVdnp2YnRiTHQvUjMxNzFtb1k5bjk2alhSZElYM2U4L3lRaGx4ZkpzTGZr?=
 =?utf-8?B?R0ZzRGhtL1NRbG5teTVrZUlKMzRMb3RRUVRGa25QZlNJWkxqNHpUV2MxenIv?=
 =?utf-8?B?bTRicVd3SkV2ODNvRkNET05INitySFlud1NUMGlWR2RRc3R0MzhyajRzSDBw?=
 =?utf-8?B?V2Z1czBvQ1dTczlDR3pFamJiS1JKcWFIZ0IwNXRvL3pGQyt3NFVIQnpRdWFn?=
 =?utf-8?B?T2hBdDhDcDJONkJYTXlwZHQ5ZHk0djVVUlJQNzBEN1BwYkFlNzd0NEtIZXhH?=
 =?utf-8?B?c2FXRncxMnZYOFNjbkRLRGM1Yk5LMzlRZTlrRDVNRmpTb2dGUHBzYnNrWE1q?=
 =?utf-8?B?NzdEZ3IwME9PK0xJZDNEdzYreGF5QWNSRFpBeGVZNHdSdmJzbDdTbEJPZ2JM?=
 =?utf-8?B?bCtlV3BCT28weEZ4TWVNME02VHVWTXJPWjhGZTJUZG5aYzhXRnRpSk4wcFJ3?=
 =?utf-8?B?Ylo1aDJCL3Z0ZWQxemFOLzBUcWptY3dFQWttUHduRURmb2h1T01vNWM4Q0dQ?=
 =?utf-8?B?MUU4ayt3N3RnK1c0cmcrZVpNUXpqWnFhQnF1S0JTVHdIcDRhemFZOFkzbHJn?=
 =?utf-8?B?a2FWQ0xsYjlvbmJhdnlZUW0zVEFSYSt6UFNJbGpLdWpwUGlFT2hiWVdkem9q?=
 =?utf-8?B?elFLcGpwUTJyNGUzMG1LUm9nVVFxNmVqQlBDMzhFUEJiak1hcGZwUDltNURt?=
 =?utf-8?B?ci8yMkw3bmd6RmlQVWNJNEdDRDM5TXpNQVh5dTFoOWFtbm13bGtrbUFlOFJq?=
 =?utf-8?B?cEt5QmV4elpOckM4MWRsMGJnUVdCeFRibDZJNlNQZ2pUbUJUeXIyTTVIaFQr?=
 =?utf-8?B?bmNQd0dhcmZtTEljOWFEelhXTTd6OEM2bk4xUmE1Q1o1eS8xUHYxNzM4dFdv?=
 =?utf-8?B?WFFvTUsyUHprRUkrRUl3NUNaQkhzTkltVWZRRXZzT2lZUnk4SDN2UmkzZjcv?=
 =?utf-8?B?QVJIdnFvY1lRR0ZNdkRuRGYxckJyeGUxclUwanFsMkdZZFFkTFdQbmVPVmtZ?=
 =?utf-8?B?ZXpoTC9nV2E5cWpEV2IvRE9KblhLanB6VGo4MmVTbzJ6SW0xcGV5d2ZyWWFu?=
 =?utf-8?B?U1pES1NKcW43L3pGMXk0NmtDQlBQQWZkcEhydHhPdDNDb1lMVW4xb2dLb0p0?=
 =?utf-8?B?L1dIMDdGOFk3dU5FYmJQQ0tud3ZGLytnUTBCU3JIUTVsbEE1d2ZhMmhRTk9y?=
 =?utf-8?B?N0N0Nys3RlNUWUFRYUpOK0puZFM5cmxQdTVsQVpWd0JSREkvVzB4d2dydzZZ?=
 =?utf-8?B?K0VURkp4WjhEUlpZUVM4WWpWN1RldE5LUkJCaUtQYTZ1WUpGL2IzZytrb1g2?=
 =?utf-8?B?VUdCdG9JSGNNU1hQNHc0K01Kd3JhRUZFWVZOMUxtQkdwUzR6RnNYRUV0R05U?=
 =?utf-8?B?T3JQNEcwVWk0cDE3T0RQWm1FaUYrY3B2a1Y3Z2hVVGhDT0pwRUxCV2k0OUli?=
 =?utf-8?B?NGwySWwxdlRBRHplWkJZRlU4Z2tPd1NOV1FFN3A4Q2FPeHhkRXlDendnQzhJ?=
 =?utf-8?B?Qjd6UUVzbEFmdWZnTTFXWWFXWDJmVCthbzl3UWVsRDgrR2NMS21Hd0NGeDJr?=
 =?utf-8?B?Si82M1AyRE56N0pkZS9kdkttakVWeEFoMXFqOFlEY0R1TS9RekJEK1EwMFI3?=
 =?utf-8?B?TE9vck94U1FoNUIvRGxSWUF0aXFYNDdGcnRGMzltNSs1RFZjeDVNdjBnNUp4?=
 =?utf-8?B?RmhWUGV2YWMyNUJxeDI3NmxjZG1TUGlkVWNwY3dTRjVNM0hFZ2JWMkJvVjAw?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KXjfLs9ZhF3P4U3nyS50QCe6ccxtIUzMfqMdd6V4OfqM5cdG1u36BAQrJBxupBfkBDSwMTIcJL3cc8Go6MaWWfCXF+wIVpSSrDQlLvrHJaWz0XqBtC4CmAyUpYBwc1eJ74fCQQ9OIaqRYcoMRbyLce5Ldvs1sTJppNWGAlQP6W250yy0lAok0Qh/eBkS73ZvQf6XgJnVM2naMlFGMBcwr3gX3Wm6SRsAFaOiwEj4WY3GqUI6vDLhIRtPV68EquDw2zMdS1HZtTTLWOXmFWuI6z3m10BP6D2xs3y6OeBmlfqh/+8YFV9QcLcKwKBl5iYmuqbgsxP5+nQQm4BCeI+0QtCeolmuRFuOVi2hiPYWkAKpmhUKaOBj1Q72iCoGaU01XtO5xoCr/hnLE0jlOB6/4Y+315EfuQf04OWPBNH/2x0E26KTonTfGG7S80l4BEKc53GRuQoNt8WuHXCBhsVBvJfTmCtaoNdM75KCM545NyZflHfWaNJ0cCZke9FKMdLV9v+QigBAUMUOVLmtyHMvBvmjb0aJzAA1tMUCUqbQ/z2sX82PVO6ZtAdgPeCMiD34443JigNVQ5vbEsINjoj1IrtndspxcEAQgux3hoZsBb+EEZdCy60SknpwPgnqTekFE5KEEwETyqY9K9M7T7odGWlnnvBi6gBdBw8yGOvYv2GUTDot4/R2P1cbS8x6kMzS0YXdyxW0xC0j6KIPP9Fzt4XTphPtR2SFLYzg2Ptrrq7H0uQNInv1lli6uJm81J1q8Nz4YgPMqBIyhNZwCCyrMyCIVy0gI4at2cAoRooHhgOjvj0g5DpBPnRQItkcA+ra
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e847be-616f-451d-aaf7-08db6d7e1341
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 08:54:06.2449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YzS+ZakqyroaHaroJna4M/CsjBo5771SNIs6XKR45VW75x1g9mfHPVRPCsQvCg7sgfMzl1qmus457Bo9fk/oww1ArRmP+nbKIDP7jD1uSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_05,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=876 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150075
X-Proofpoint-ORIG-GUID: zpAXh17tx600WKbZrJNqsScdCXGi3LJO
X-Proofpoint-GUID: zpAXh17tx600WKbZrJNqsScdCXGi3LJO
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



On 15/06/2023 09:18, Zhenzhong Duan wrote:
> We should print "Migration disabled" when migration is blocked
> in vfio_migration_realize().
> 
> Fix it by reverting return value of migrate_add_blocker(),
> meanwhile error out directly once migrate_add_blocker() failed.
> 

It wasn't immediately obvious from commit message that this is mainly
about just printing an error message when blockers get added and
that well migrate_add_blocker() returns 0 on success and caller
of vfio_migration_realize expects the opposite when blockers are added.

Perhaps better wording would be:

migrate_add_blocker() returns 0 when successfully adding the
migration blocker. However, the caller of vfio_migration_realize()
considers that migration was blocked when the latter returned
an error. Fix it by negating the return value obtained by
migrate_add_blocker(). What matters for migration is that the
blocker is added in core migration, so this cleans up usability
such that user sees "Migrate disabled" when any of the vfio
migration blockers are active.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c    | 4 ++--
>  hw/vfio/migration.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fa8fd949b1cf..8505385798f3 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -399,7 +399,7 @@ int vfio_block_multiple_devices_migration(Error **errp)
>          multiple_devices_migration_blocker = NULL;
>      }
>  
> -    return ret;
> +    return !ret;
>  }
>  
>  void vfio_unblock_multiple_devices_migration(void)
> @@ -444,7 +444,7 @@ int vfio_block_giommu_migration(Error **errp)
>          giommu_migration_blocker = NULL;
>      }
>  
> -    return ret;
> +    return !ret;
>  }
>  
>  void vfio_migration_finalize(void)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 6b58dddb8859..0146521d129a 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -646,12 +646,12 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>      }
>  
>      ret = vfio_block_multiple_devices_migration(errp);
> -    if (ret) {
> +    if (ret || (errp && *errp)) {

Why do you need this extra clause?

>          return ret;
>      }
>  
>      ret = vfio_block_giommu_migration(errp);
> -    if (ret) {
> +    if (ret || (errp && *errp)) {

Same here?

>          return ret;
>      }
>  
> @@ -667,7 +667,7 @@ add_blocker:
>          error_free(vbasedev->migration_blocker);
>          vbasedev->migration_blocker = NULL;
>      }
> -    return ret;
> +    return !ret;
>  }
>  
>  void vfio_migration_exit(VFIODevice *vbasedev)

