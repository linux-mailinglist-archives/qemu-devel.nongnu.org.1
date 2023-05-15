Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6188703EAE
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyetB-0008T7-9Y; Mon, 15 May 2023 16:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pyet7-0008Sb-So; Mon, 15 May 2023 16:33:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pyet5-0005K0-Mc; Mon, 15 May 2023 16:33:45 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FJrv1C002991; Mon, 15 May 2023 20:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=HVg+Sul2eCNqaO2sgAcNp4IGLn6anE+wMYSapCSgDK8=;
 b=H/K5Gc8Pg6AELutLs3PkAed+rdFHMFX5H1DI/xjfyfTsZm/7B1kBCGRzDieaiPzGbdID
 On3YlNMwM0X1Wa4t/EkdWrdDs22TTrbGHPp9Q+QInZZhSxtKJ6JZazyXZxqRNJS9oY83
 VMopZUv0lNnl69wjOtxyoCVWIBfhJga6w7GOxmCNBZS907JhEmb/J5exJP1hmu/2Qpjq
 JyR0VKDq/r85OmnnUgtgI/0kDUsmkMp9Osl+siEu0DgnI7ktjwUpO+wQNPNUgPCroFTK
 upJaZZgQemKgayFj88i7IVhTAERBbLuC6kUdeTBgmd5Uw8+sLIQ0+vJzepQj5UKhLTyc Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdh9n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 20:33:37 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34FKJtOv023163; Mon, 15 May 2023 20:33:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj102x7t4-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 20:33:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy9/vnZOsxxcesOr1BNN4zV0QpyZPRfbtELh4ts+8UrnmJRGDrK8MHoUXC1zQJj6G+p8kTsYNVY9H3SxPCJ74ULT+RDDdWNk7RQ/D5UZfumnKywpDuSnW0CAb84TS1mH6jjL9JgkGNyRieSBxV1dZS1NtnXXsXxD06XsrgOiI37eDeG6SmaJS1dWJXopa3P/dHJSUpZnXuiBWpRaJAaiNY740pgUUuIKE6Jm6ObtVa0LT4vK3Wt9j5y4BC2BpxSFSDmNJMGv/MJFAC8ksu99E9V9LuKMs5wH8icZ/hMYbvuq0cMdAElWrswtGM8CEKXL4bs6nMPJqTbgUAZt2MAasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVg+Sul2eCNqaO2sgAcNp4IGLn6anE+wMYSapCSgDK8=;
 b=jYoZa91vTyCY9OHeNSR/H0rrGr82Tusse+gBCYJnEaYOjTQHBpzaLVCUPgWjCg3/wbkeP6uzksrxD5XhEcc/iuMtyGv1q5OEg2ebJGFTlJYh6T6eWykQxcxKqNAprGjuO6DsQ336cx40X+pqdrUESBRZBXwYRrhg12oThV59JOIdvxfNDd1rtGK9jPf5TkMSLc7D0tpWrMeV4cZp0UrwXZ8skC4hep9x/ntOYKYBshsrcddl+BsA2l6scCDnou/P7N7JthzYcZyaJFtp4gE3ucICmrkunrkZOF02sq3Dm3kx6k301ekJEsuV6wYfntFkOp/rNWHkAbD2N+lzSy7xWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVg+Sul2eCNqaO2sgAcNp4IGLn6anE+wMYSapCSgDK8=;
 b=jynXgpeZXpBXqk5jKkshGTEMF/cl0u70bp6GCdiNNyI44Y3GFSqDbk2pv5aab1vX9tGFIMeLeIriM5Kha3r/XkYsXy8hEzUXNL+QiH8m7FD3c3KAlhIVXjkZi6to8EZ3TN9KCeJkQeYua1vV2OiIk4hw5QFxILWlxul5J4bx7IU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:33:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:33:23 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, ani@anisinha.ca, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Cc: boris.ostrovsky@oracle.com, miguel.luis@oracle.com,
 eric.devolder@oracle.com
Subject: [PATCH 1/3] ACPI: bios-tables-test.c step 2 (allowed-diff entries)
Date: Mon, 15 May 2023 16:33:09 -0400
Message-Id: <20230515203311.2139-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230515203311.2139-1-eric.devolder@oracle.com>
References: <20230515203311.2139-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: e00a566f-cb51-4b93-0fa4-08db5583a0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwoAyLcYNqa6YS3R9TUdxnAENldbsmk94XHdDRYlleUI+KTJpqnT/VV4n9fVRvaT0FABRHzZuAhdY2P2F6WlT/d5/9Qh6oFW3AZ/icVU3TQUe8T/EVd4FILBD549DeneJxP3w8ANJ7KLAiiaK+NDyTacy/jUmdQs3qtHNKHbOIaQKTSQ9Ha0DsCa32GiSiPpZ0spP+i3juGPYrzyUGaK9IauZfTMDVaZANuYVQPKq3Fev0kX+ifzjL0CVuvNQP8JWO1VUv+ZTAafJ7UHJOGkby9C2xypyigmczhU13RryFsCAvLciipALSRSgggBO/ZAWVA4eLV65j91KZS+dIDPE6FC/EX3YMDD0ai5SP8WDH1XzftLikT0leC3mNVdwuRDtN6vPY4izEpNT3KRy60khtu/RUxNtj1tuRMSFgWLE+9dv1dNxqzyn5zWDUHlB6yjI76/eEH5+WcyN0H0r8iaQ+mHoo3Auh4GQgbO27u3/WtEjgOKwQoPzjd1cFPzJCRzueflLXcBcsN3XkloAx5pAbPO4xOHOBpWQUKXyMcUtTC06G/VulESs+4RTrnqE+26ucVsBE/SRQmHvccHvzsn0dbBqhOY8KIb+U8CoqG3Hr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(86362001)(478600001)(36756003)(107886003)(186003)(6512007)(1076003)(26005)(6486002)(6506007)(6666004)(316002)(921005)(38100700002)(41300700001)(66476007)(66946007)(66556008)(4326008)(7416002)(5660300002)(8936002)(8676002)(2906002)(4744005)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aJoXb/Kz08Wchm/r5Ie6Bf2FbSi36/Oi8dh6+Jx+5I3L09Ilv6xo/RPnLQ0s?=
 =?us-ascii?Q?vnPRDqxpnGbk5lpWPZ+NZW+jQtuds/qf9CW0XKVyUz/n7aZpddr5orvLU8sX?=
 =?us-ascii?Q?Vr7YmfXU7XactnIHibHgKLLkCYFXqTnf6SW4ODuIs7ncXy1I1vuenSfQw6+7?=
 =?us-ascii?Q?OGVAkBwYnqg2dueIp5pIwfMcVSAh/qMRuurd7hYph8LPt3Vrzin4cAaQm5Ih?=
 =?us-ascii?Q?SzUFMmDHPOHaHRwV9KbD3c8+apW3ohwf8AZHnkWCASWWXJP7c/GYP8nzJqll?=
 =?us-ascii?Q?j2HbzFUxcPcGn/eNlLsT+IuqbMRxQJqJulB4MaabVQ9aHHnAcv9fceMWt9Qf?=
 =?us-ascii?Q?6RDzHrafGSkzXYLKzsc/ISd94W2Mj1vvEhrF++S9pwRXizb0dV79B9xrNcsr?=
 =?us-ascii?Q?C4D8xTEn9yGlPWZhgU5EPyrsAIeVQpxtI7fmYTyf3HvqQoC+YW1c8GYy4cI8?=
 =?us-ascii?Q?NS8Api2wm4DYXJyQ+zj7sgesYUHvKrTvnIFIWpF8Etn6u1fLjxJURh6vfV7Z?=
 =?us-ascii?Q?H05D2QLHH3mfDRZrHHq2/0KdSiV0FTsmYGZ8tSxqc8CxdA2Oqt6dzSv+nlXJ?=
 =?us-ascii?Q?lxW8I7L3Fou29/ewGgCde+/IdISwLVqxtbI4NkfNcQOlhgZwb781KiaweLoi?=
 =?us-ascii?Q?xqvXupXWkYsxPAARpSqEXj5xQ2KWuUAh3qLnpB6L7VBDy2VDh0ITVmm1+xMq?=
 =?us-ascii?Q?KWIG1d1I5UGkwHl4lpZiSAapv6lbi3fXZFrnXwpb8/suK+JgE6ZcA+LAxhiv?=
 =?us-ascii?Q?DqF2RCkXEIQEqv99QlPI1P4ERx5OhuJOdj3DMeitAnQIKn/Hug/NKR5DKIYw?=
 =?us-ascii?Q?qdI04BeM6t79+HB/I781n6vwJCQ+AGfAOgluo272tjOpX3/8QPbK4wOA+E3x?=
 =?us-ascii?Q?I5GtIl6C46mzVY+/gUZwLDdIqRDa8oT6CGnFcIdTEfqsAw1yie8IlJKib8BN?=
 =?us-ascii?Q?k986GCDXiY9aOBWCwf3CZBXZA7zSaaJCS383v4UsyZwTXNJBdSeaxRR0cF2v?=
 =?us-ascii?Q?PXPkTbhHVF+H81D9MQxJ2k5Ub2O1wkh/PD4aqon3uCmf1907OiiQcHHh/NJx?=
 =?us-ascii?Q?6BH6pQYK4pm+IkpAQ/ywgdDJ1LBO3L6QJ5vPeP1vudwPtj6R6pNw9SnU41xl?=
 =?us-ascii?Q?GVv4s6pys6GOz3hPb9C/F95bkNU+4GidS/PXY2IdadKOfVDJ8/WmnpVgSDS4?=
 =?us-ascii?Q?3Nx5UqeKyBRobcyq7CtDvnCU7ltnWi2oN/iQkkg593fBZtGfdXJbh6xYYKaX?=
 =?us-ascii?Q?kktQALj+x7P0xfSGdh+TNxoADAFKsQ6ZO5hqWrxpWI8274xKqVn2VRfF0OXl?=
 =?us-ascii?Q?XSiiK19aWJJIC4TCnPBIrxm+RqFEtO2Z2jP63dDeyPegQDxuW5vlYe/BAuqR?=
 =?us-ascii?Q?hr0KOAnyNoGjr7I1bECP5BiroK7w/iaWjVWRvDG44iI3tHfhlBMBQGQXrCUc?=
 =?us-ascii?Q?/nxe56SVkOCLEFN2oVd44mjVdMcosq3EO8BebDydP0WBVp3ITEIvsSGhGrHg?=
 =?us-ascii?Q?+ViUGhlQ7QvLTBB6W4GLNSIi+xEv4khNhAIa3JLS7Ytpdj15dcnSANsW6Oje?=
 =?us-ascii?Q?+VzMTJK1AMnncZKQOfx92hM9MEHrAZJVjzYqBBd3+wt6lfDgZYhCPwOHSKdi?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UChC2ltVtNKKj5FM9LWBrjC26Dlo5JEgMuBNKeH5hEIdbVd7AzuiowuTKsGGQktKKnrVEXwUQ44mbLN4ODbjXGYwe21u2C1tELyVwyRZpHgHjOEPHpHALGYjdkpWdNl26/ajGQaVGGXCtWtI05Qw0BT0z2o3/v/FFcN4Joj8rkQwHHqpaQ8VkL3zj4VeLYF07ikNVRZ/whNXnUepNAu3OCtHUrkBfa6IKobNNeqAUXZjJYN+el2m6KjKUVDeiYBCJQubR9LopqT1TjitBoi9pG4F+I0uiwOaxOIi3HJAwfZVLrQaMqPgPXdKSdrRqayJCwH6Fo2MItY3DXM4uXYFtrfsaHtC4xAO+xyyHVHxzossP1pVTwBDcnOKmxTmFALR51DmPTEa364xEvWy5y48w5SG9kv7u2mQEb8NpMwusq5ZtNsDN16pZ0vtPbcAr2W90ANqVWetRRAi0LyZBhFgET0rXsE4G3cx52SO/ZpNivGdagGZACxxYe8thH1RE/4VeTxNmbi+A8jqoTI1HHcryfw0N1z9YSo74gqAAPRrCfSu4Vhf2VJr86RvQdMVTcWm2oBBuhmx0alS7co+8/IVZ8NK9VkoGcm5P2dDphntRGRfmc1QGWfAjU+IuQqw1yHo/E9DS0SitbPOHhbt1Wjx2mBHfbYdiZlJqi/bfjldOT6KOZG718IyiWAAPWYeE+MvVeGXQK9gjprurKS2ad8qvPVY2kJLRi88JV/s7RxhL6JfhVYbfBr6go1kQWt1F7d0pAQ/r/92/L7HQ+TKr1nWFJPQr43+lzQdPrMxkli7s3tapgs15fYDZKC2K7x+9uqEDdnbb41ECvcgII9ue3jGFdj7ecx9eUjDj104Wvrof4Fj+BQbadWq6Ri6+D2CXwNnDpQUscglndMIyCDavxWjiQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00a566f-cb51-4b93-0fa4-08db5583a0c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:33:23.1314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM+RyLgm6dJPhpFOceOhhMzPfwEFtjZ/8xkAqUm+9GP9ee1VQpjpW+WEon06HiaxB+qASdmZgwB4rmWrnmjGfMs7/cmUQ6Ku/0JZd5Fny+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150170
X-Proofpoint-GUID: iz_tGmff-RLzdMCaEksK7KxDc57Rv16x
X-Proofpoint-ORIG-GUID: iz_tGmff-RLzdMCaEksK7KxDc57Rv16x
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Following the guidelines in tests/qtest/bios-tables-test.c,
set up bios-tables-test-allowed-diff.h to exclude the
imminent changes to the APIC tables, per step 2.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..1e5e354ecf 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/APIC",
+"tests/data/acpi/q35/APIC",
+"tests/data/acpi/microvm/APIC",
+"tests/data/acpi/virt/APIC",
-- 
2.31.1


