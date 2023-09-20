Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B67A8FFD
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 01:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj70P-0001O0-NM; Wed, 20 Sep 2023 19:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qj70N-0001NX-NM
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 19:53:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qj70L-0003Je-7f
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 19:53:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38KKJ0HP003969; Wed, 20 Sep 2023 23:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hI3Om5d9SbLQRpmi6J1x5iGukeOEHserbUHygRbxZFc=;
 b=VAAQQaX/NP4Ub4ESQvm6XQzXDDcvfL/29lSSpQs7Sy/pBJcMWM0EROo3yvnpV7gxaZGs
 21wVSuK+KJDxGEJUSXR6ENP76DqSPoL/JiV9bBCwnRQXtDU9xalVi+zP4vApFXsXNQA/
 w2GqsdgXXr5QFUcSCNDBmU5cQgqKHW2gOvz1Z05OIg9ksPN5fIOpS+IhHgQT6HyA8MWy
 MNpCK20iLrEWtsHb60hZpbjREozpQ4RGERd4yo0rCRBRyB98mtnoyWGnlv39nA2rf7HR
 hClozZqJdzcDFQ0KvtAq8TPRIdg66NYRvWaGxf/Wldng9DQDnDFyWGjwBL9wfDl15SF2 Pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53530m62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 23:53:10 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38KLUXvJ027258; Wed, 20 Sep 2023 23:53:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t81f4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 23:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqXRHrZ3HTsdMQksM008vsbRh9BDkV12LtjWOVXcYvg077ZZiPa/UVQRgXQh5FzrWTV+oV/r7zZuA2OwtlooMHlpXudfJC6OiLl93AsLhx5GgT1aZ0yLP1eFl/vgNkURtV1m/cYUDtzLxiUuv3EQmY1o9jnS2u0y+QBLqLVbFlMFOFGjqnaCmmH9TEkUhcjSUMK8bzwt54GIJQ+RD5Sn9IZ6eyN8ER7eWw8m1wtJnS4TDsosXFr7hV2Fp/uBxyX3bGuRyOSFO5/pCQV6gh97K+3OUd4i4uEhDQgPtJdUXln56aOf1uJH8eSNAH0bah23E0E6GTKXdPKjTnZMW4/u9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hI3Om5d9SbLQRpmi6J1x5iGukeOEHserbUHygRbxZFc=;
 b=jxToadxuDF4xtHT03aomYBd5Oyqos9+BkzKgP6L9GhLBZ0603PnfFVR/gaUwg5dUKccJHQq2TMeT+quMmV8Zx0yPjs+B/oy9btcmqoMpVYG/HAanfz79KUS4XuJVfLEdYWi3TL9i1m0L4dJStjfIcxZTEZ8m1Df9FobjaiRsdbc/UARjvsrW53enhG80Rz2E4el9lcFt7NdL/QyvmAmqpBgHLaiDcoOG+ykEtAh0s6iSlMY3Tlns7YgW3SHQRMSRyU/0MxvRj2QdfNVUdI04W7xS/9EbVjB6uy0avkv+GxkL95JmngOTdRTxYAwNX0s8KLiL5eeA3LuAYijLBKyXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI3Om5d9SbLQRpmi6J1x5iGukeOEHserbUHygRbxZFc=;
 b=X1hCHqJdD0PnqQS7AbBsxy+3+5f9lYWUpy+9dekNXA2RInq07yfVo72033ICHI4VkbkXQ7AqecMIoO+7UZoh3pbbLFjOnc/hgIkAPeZ/eI8C/fP4Ro/QmPbEBb93fMZAvZ//TnPISlYz9UvXq2XTO8+8JIaVgMtBDIjbcOl0hME=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by PH8PR10MB6480.namprd10.prod.outlook.com (2603:10b6:510:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 23:53:07 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 23:53:06 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com, lizhijian@fujitsu.com
Cc: pbonzini@redhat.com, quintela@redhat.com, leobras@redhat.com,
 joao.m.martins@oracle.com, lidongchen@tencent.com, william.roche@oracle.com
Subject: [PATCH v3 1/1] migration: skip poisoned memory pages on "ram saving"
 phase
Date: Wed, 20 Sep 2023 23:53:01 +0000
Message-Id: <20230920235301.1622672-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230920235301.1622672-1-william.roche@oracle.com>
References: <128792ce-e3aa-a357-5e96-a4d8211193d6@fujitsu.com>
 <20230920235301.1622672-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|PH8PR10MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3231ee-0bea-457e-2ecd-08dbba34bc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8My0fQbKC3VywmGmDUo7msvpx8+Cfs0vCfzCJHwlxkr4FkGksNpOjmiHznLHVgSCIdnXGShHqQB/nVUQKjZPqigVjdfTLGZK/Q88kOftP8krVGHxS5okzNSeZNkhiXpGaOMD4ROyZCzlzoxkpeJ/O9dKckCgYSsUO0Q267wfg6tWE/J8wNrewiozqlOxk4nbJvCheGKmsW96Gnw2SMwiqCp6z5T8ZcxiTNH2XUZDLwBMbUDAPEfK8hheVJG80v3m/FtR1PvImveVqLlmmpdrCgR5RsHrqzp6SjGfL4J5U8fb8SQg0geN3lsTJUodn6Wwt9hL9qdUdV1PiYNOoRjoloGFZoNzEkIthC1O+7dIfPwAtKogXWZFMpaXEwiKoCda4FLaAuFECIwMALPMB65ksHlzLj0rsW7y5FOGsuePygAQQCTExCj+G3KYsu58WztJ1rODb3gfTAl6VTbLZBSipoDK0jD59yZWrF38FZc9w8N2DNV8TTXMNVkMXVOxxucdnAjK9yGGoeI4RM0PZE4W0EMuJOvT7TH1/lgVYPvHK9bBc5AGUeFPS0+dC9/aL2W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(478600001)(6512007)(26005)(5660300002)(83380400001)(4326008)(107886003)(2616005)(2906002)(316002)(1076003)(66476007)(66556008)(8676002)(66946007)(8936002)(41300700001)(38100700002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMGCf9bUg1lKMKf6E6PAZlGWQQfOJBUXPfAUMVWtlPjA/C69Nj4jtX/qyy82?=
 =?us-ascii?Q?KRhNpTz5A5la9+gvSSOb5rPWNDWLPNrYHnizNCUgM29Rz0uCMnEDdulB0VLF?=
 =?us-ascii?Q?VUVkT8Jv9Q9LAeC2H3RdVAsz2+BHWkat+444Vh6Iqgf+LFoW77tK91FMrO4A?=
 =?us-ascii?Q?Qbt3nRNduYgrLrLsJ4n2eFRuAFOH7ptvq8aCB2+FFRGNzzoHXckjQmOHlFFv?=
 =?us-ascii?Q?Map/fEVH6IArSfkuYnxyyfplfEDkSmqIigUSl44HTMBKNqYJ2WqFZB5muz+Y?=
 =?us-ascii?Q?ihBJfJqXjKWAkpDHyvqKnMo73KUC2eVezrJl1cpGKQVJn/SsVKxrHbSyEjKa?=
 =?us-ascii?Q?pHi3ypXCrx8AnNTqkijvTMFhJs3y3DOtbtw4h+R4OQHrMJ+A4YR5fBcvBZmq?=
 =?us-ascii?Q?dCu1DPVWEiDRrB9iIUqpk+BfueqqDjdx9iKtLM5nQjr3f3mCyzd81bM+mOOt?=
 =?us-ascii?Q?bsDpAw2o24DLvGpb2weDLva5fIqu5hVrTt3zGyYtmqIQCbVOuPR0vZpdul8g?=
 =?us-ascii?Q?3VhmddKHfBVS42BSHEfhZHC9RoSp/CSwOe26Fs7XyPT9dMMDkF2/4M2C+Did?=
 =?us-ascii?Q?QIX7WKylUMqsNVU0kazYi5XtuabXKQ57VhMvdNhARxPCsBEA2ooz3Nt+EGG5?=
 =?us-ascii?Q?8uuSaARBDxaPOnHcg6QepaegqYG74V+wZikaSsrG395EN9B+0rKHOlm+oMRX?=
 =?us-ascii?Q?NKzSqWOCWLDDl3xpyflhnTXHxhgyLfSbZE3bCkbI5jAxtFiEJLd2L2bmd0cj?=
 =?us-ascii?Q?AtP3q5EnpcofDTZgDvCTk6IDqeN7IZwDtEpYE4ZPpAFeAeQEg/YQdqohJjs7?=
 =?us-ascii?Q?Z2rvNFs1GpdxgPwQmUsItRC5jTjZkD4hBwMhRaFRn02grDJigUTgoFAVrQ4/?=
 =?us-ascii?Q?yMy9P6QDaVe+u2Rb/MbBhz7pd19/ekbDt5J56ZymZE7cqcpZ84fRueBjRfKR?=
 =?us-ascii?Q?M+YRLPFwm2OW/qaw9Ia49mVwilVWcJFTkWG0I+ztB6qckmzcu2qc3ZfKFd/7?=
 =?us-ascii?Q?tHGTVTq17+PtUKBomHIP8y8yX67NA0fBc4flJ1e5Udw/U88k6fZ3gCylrd/B?=
 =?us-ascii?Q?PQECdbnS+JhxOYeD9lHZvzfl6ttqSBSHWhr9sih1j8nXQRb9TUGcadqNOw3U?=
 =?us-ascii?Q?93GKJUXXvsFw6ZEoCW4plzJtxiiDKBbaq1IJwBgRlzBB5J8pnmlkqH96Yuh/?=
 =?us-ascii?Q?9v2oIAHJWqwfnBqmmZKE8p0mFtBXESREtvk9pl4tA6kL4v0c8fjlGKSdRtxt?=
 =?us-ascii?Q?KRrfxIEmLl9TIpdRhMC70x6JmUbuscPBuE409cosM6FifWoI95Sq4YzQKryp?=
 =?us-ascii?Q?U6RDU8Ol5GvEXAf+ieggEGsSkNotDbKHGLfdPRIk5TBXW3IE+bVqDBhOLDBP?=
 =?us-ascii?Q?O+Ob/1Tyg6ioJF4TMQ1qS0muQVCYSSZZkI7WIq9Epsf6tOofHEuttqxigbH/?=
 =?us-ascii?Q?wbBX3mf60csjSn/OjH8btGlwwobNAUHiuh/S7LqhKkCjydd1ggrObye07hDN?=
 =?us-ascii?Q?3LnABgLPL8dk7eJvJP8jNdYeehGtuhYUFV+8zLvxZkzeDiFEsOLX72IcKGzg?=
 =?us-ascii?Q?kVVGhSjaGX9pHNC+m9W38u7/b++pxuwXJFqC08UmDUsyUqtj6bGtUkrrdzAo?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 25N1ugJ2bRW1ZLnReSsV5JKL0d1R++C9Y8HlvQ/xrBGLTHBJ+55CQr8yRnUynXvxz5tWAtElzFaiW6Og3YNQfp2xi32MTjqvniwpdmgsU8cPemsvSziNkYO7XLteiEVvHliObFNsDDNOoNIA2cdaoPG9KZNymF+l5dTvnNdrrp5RiewhKyDn1cenQnnsbuPlJyb/WeiJZwC6F1pJ/Udo6H7rMGmlO5+XrS8KyMmAgK16+avN0Z/1G7VQ8aqGPsJAR0kgB0gEURoxt0m3+6jhaRnfnF0iNKMuJwsfVrCEfDpSrYEO4B76Ph2+NWmkGhjra3DBjTuIZO+v0gad5rn4wR7/BWHlvGp3rF2AvOxul+/mVKfLUvGtAbjLuh/x8h1wPCl3WbVD7O3cjoQJvwm9Fo+TC52ZUkSvTMTS/OFMGEJjPFD2OKGE5jHYHmjqkjyOOpxr4QwDVwv5U15wdfjPqZkbQ3QuIFLFU1cUaJXkjT3BawKJRbgItTYT17otdYhCL1KfVqdsMksplSbZHe7jLku+AndoIt5L0R7Seb4U2wlXkFwntRWajm+/CVZfYtS1MP4EswQp9vi6FKo5wseuijCpNHS64BtMXS7zDYHHM/1xDuvejireMU9Od9bA/5Z2s1bPkq8Z5u18g3rP6mE6PqCtAb+ajijKrJ6hdEO7Tw5jD4xdQ/dWdYHMic5vCvY1EKzEeHqqLoG+pWh+9Qx0zV7uHHpZAGkrLPxG8leuy6H0BWtRG6ahjKHcRKp6FsphO8JK99i5ZlIdkijV4cIZyteQZy51SATd/rEZ32KMP2eZ5d3gHeVe9tEhX2d3FqZF3En/q2NtDVNtvlBaRoQgoA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3231ee-0bea-457e-2ecd-08dbba34bc91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 23:53:06.8975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E59s2raY3omlX4L4ij0Ra7khWPF04AaaXm2X0GGXWi+Vuc2wKGdGS4/H6bQnd+ImYOWYe9gt5hPJu7GTlOzivfugt/HAf4X3tdnzxCFiIsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_12,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200200
X-Proofpoint-ORIG-GUID: 0PbzrV7eNrozBio5WfOwzAWcCzczl8Hp
X-Proofpoint-GUID: 0PbzrV7eNrozBio5WfOwzAWcCzczl8Hp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
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

From: William Roche <william.roche@oracle.com>

A memory page poisoned from the hypervisor level is no longer readable.
Thus, it is now treated as a zero-page for the ram saving migration phase.

The migration of a VM will crash Qemu when it tries to read the
memory address space and stumbles on the poisoned page with a similar
stack trace:

Program terminated with signal SIGBUS, Bus error.
#0  _mm256_loadu_si256
#1  buffer_zero_avx2
#2  select_accel_fn
#3  buffer_is_zero
#4  save_zero_page_to_file
#5  save_zero_page
#6  ram_save_target_page_legacy
#7  ram_save_host_page
#8  ram_find_and_save_block
#9  ram_save_iterate
#10 qemu_savevm_state_iterate
#11 migration_iteration_run
#12 migration_thread
#13 qemu_thread_start

Fix it by considering poisoned pages as if they were zero-pages for
the migration copy. This fix also works with underlying large pages,
taking into account the RAMBlock segment "page-size".

Standard migration and compressed transfers are handled by this code.
RDMA transfer isn't touched.

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com> # RDMA
Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c      | 14 ++++++++++++++
 accel/stubs/kvm-stub.c   |  5 +++++
 include/sysemu/kvm.h     | 10 ++++++++++
 migration/ram-compress.c |  3 ++-
 migration/ram.c          | 24 ++++++++++++++++++++++--
 migration/ram.h          |  2 ++
 6 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ff1578bb32..7fb13c8a56 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1152,6 +1152,20 @@ static void kvm_unpoison_all(void *param)
     }
 }
 
+bool kvm_hwpoisoned_page(RAMBlock *block, void *offset)
+{
+    HWPoisonPage *pg;
+    ram_addr_t ram_addr = (ram_addr_t) offset;
+
+    QLIST_FOREACH(pg, &hwpoison_page_list, list) {
+        if ((ram_addr >= pg->ram_addr) &&
+            (ram_addr - pg->ram_addr < block->page_size)) {
+            return true;
+        }
+    }
+    return false;
+}
+
 void kvm_hwpoison_page_add(ram_addr_t ram_addr)
 {
     HWPoisonPage *page;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 235dc661bc..c0a31611df 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -133,3 +133,8 @@ uint32_t kvm_dirty_ring_size(void)
 {
     return 0;
 }
+
+bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr)
+{
+    return false;
+}
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index ee9025f8e9..858688227a 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -570,4 +570,14 @@ bool kvm_arch_cpu_check_are_resettable(void);
 bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
+
+/**
+ * kvm_hwpoisoned_page - indicate if the given page is poisoned
+ * @block: memory block of the given page
+ * @ram_addr: offset of the page
+ *
+ * Returns: true: page is poisoned
+ *          false: page not yet poisoned
+ */
+bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr);
 #endif
diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 06254d8c69..1916ce709d 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -34,6 +34,7 @@
 #include "qemu/error-report.h"
 #include "migration.h"
 #include "options.h"
+#include "ram.h"
 #include "io/channel-null.h"
 #include "exec/target_page.h"
 #include "exec/ramblock.h"
@@ -198,7 +199,7 @@ static CompressResult do_compress_ram_page(QEMUFile *f, z_stream *stream,
 
     assert(qemu_file_buffer_empty(f));
 
-    if (buffer_is_zero(p, page_size)) {
+    if (migration_buffer_is_zero(block, offset, page_size)) {
         return RES_ZEROPAGE;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 9040d66e61..21357666dc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1129,6 +1129,26 @@ void ram_release_page(const char *rbname, uint64_t offset)
     ram_discard_range(rbname, offset, TARGET_PAGE_SIZE);
 }
 
+/**
+ * migration_buffer_is_zero: indicate if the page at the given
+ * location is entirely filled with zero, or is a poisoned page.
+ *
+ * @block: block that contains the page
+ * @offset: offset inside the block for the page
+ * @len: size to consider
+ */
+bool migration_buffer_is_zero(RAMBlock *block, ram_addr_t offset,
+                                     size_t len)
+{
+    uint8_t *p = block->host + offset;
+
+    if (kvm_enabled() && kvm_hwpoisoned_page(block, (void *)offset)) {
+        return true;
+    }
+
+    return buffer_is_zero(p, len);
+}
+
 /**
  * save_zero_page_to_file: send the zero page to the file
  *
@@ -1142,10 +1162,9 @@ void ram_release_page(const char *rbname, uint64_t offset)
 static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
                                   RAMBlock *block, ram_addr_t offset)
 {
-    uint8_t *p = block->host + offset;
     int len = 0;
 
-    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
+    if (migration_buffer_is_zero(block, offset, TARGET_PAGE_SIZE)) {
         len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
         qemu_put_byte(file, 0);
         len += 1;
@@ -1182,6 +1201,7 @@ static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *block,
  *        > 0 - number of pages written
  *
  * Return true if the pages has been saved, otherwise false is returned.
+ * TODO: hwpoison pages fail RDMA migration, should be handled.
  */
 static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
                               ram_addr_t offset, int *pages)
diff --git a/migration/ram.h b/migration/ram.h
index 145c915ca7..805ea2a211 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -65,6 +65,8 @@ void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 void ram_transferred_add(uint64_t bytes);
 void ram_release_page(const char *rbname, uint64_t offset);
 
+bool migration_buffer_is_zero(RAMBlock *block, ram_addr_t offset, size_t len);
+
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
-- 
2.39.3


