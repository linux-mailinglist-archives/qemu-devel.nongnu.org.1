Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F3A09CE8
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 22:16:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWML3-0000W3-QC; Fri, 10 Jan 2025 16:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tWMKy-0000Uj-FH; Fri, 10 Jan 2025 16:14:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tWMKw-0002Vq-Ce; Fri, 10 Jan 2025 16:14:36 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ALBxYe029153;
 Fri, 10 Jan 2025 21:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=wkMs6C7sK8sOJ2wiBqwjDD3q4UylJA1RmKTNBANxBA4=; b=
 UsdsBT6DYxi8SCD3YhXzuzVLPIHNfep0btsfqdOy6GYWKknRzyOinmMyDpTaMwqn
 ssqcj4VlTYkbk2XEEyDsRRycocxGjt8A9Sprva+iv8qdN2roADL40CuPARehldk+
 DYN3DWkRozy7dtg99cNfizXZCkbJUUIG9gh/3hQcbUdVEiPKjosQDN8BtycQEC6E
 7TtFUvfTsEdjqiR6WpvE3Ew6aOZxcFZ4doGDAGcvcXEiobQAFT9Z6Y+YzOwVWQjA
 ZEABfaYk9Br7BensD3s953fHP51pjbRfxOECebUY/LkOIroxiZXfmKvmMa+XVTRC
 pIBQ6ZcvsYxYXm2dncJELQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk0c34y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 21:14:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AKUL49027457; Fri, 10 Jan 2025 21:14:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xued5mxn-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 21:14:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knDHO3wXVPctYI1qm2/d1SmwkudbAGdVbwVyzAP2u6hwzMUBv0N2Cn6clCDTb/i6bMtCdy1qClcZpZPF4HCs3jgulEzErr6VMPXS1KzQvOaGf3mvkUfP01ZQR2VsfvgML8czI+7OceH9Ylpa/SynchuxNsktuX21KS4OGDfrS5sg4KcyvjD2YLq7L6QA5dvMNYjhIjEcqpBWvEqCEAFiVOz4LzthAmvIdQsDEVThjl/vb1JWk8QSqIR+4s+C9JWAV0bU+Vzre64GYDU/DJPYtmX+BfJa2Fo5UVWTbyG6adAzB95xu93UyHmbTNPIuKl4IAmgjPwlhN2EDMLHYSPb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkMs6C7sK8sOJ2wiBqwjDD3q4UylJA1RmKTNBANxBA4=;
 b=svxIaU3sj2gLu+hO6p15j8QVgXSdX1HaIR7VHl+g6Dx1RaSgQySdFQKLCvLfcjyFGVGPcUus9mhRwtHB4wOMjfTyo1dmYhNnGKvNwvaNcF6VZoWM8rE26w+3laNtojMSENoQ6iD/7+F8Df57XJwRy2/pCTawp8yB2neySsNyRyBPYFV8YmxrsWjQV8/aLNSxev8E9P8EvofAs7glV5hXgAi5sYzVTYY4n94Uci4v1aYQJd5N6jERgsy2iBCsjhhvVFYwD6EgOd49dxOcjIPf6d+lKhEmqWdREHxH0k2o6pOK9VPWtBYKwLtMovCem97T4+fSKQ6iZfLmikV/0JI25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkMs6C7sK8sOJ2wiBqwjDD3q4UylJA1RmKTNBANxBA4=;
 b=m+ELgm+pteZNydPt1H5fUBJsCIg3IEZtH/+zOCGqY5lMk1WEXx5nQ/4/kVjAxJpRgD61Slm+RmL4uyER7vTAO3HqS1+yw45j++OPiixPtFLoM1YE0VjFZ/OylmtHpEBTtGoxtF8QvPl0bGL+ds5aQpBRXLc7UrdQgH6U07kqm6U=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BL3PR10MB6113.namprd10.prod.outlook.com (2603:10b6:208:3b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 21:14:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 21:14:24 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: william.roche@oracle.com, peterx@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v5 6/6] hostmem: Handle remapping of RAM
Date: Fri, 10 Jan 2025 21:14:05 +0000
Message-ID: <20250110211405.2284121-7-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250110211405.2284121-1-william.roche@oracle.com>
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20250110211405.2284121-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BL3PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: c293fe0c-6b39-46ac-de1f-08dd31bbc1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XntNov/0NkoXMF0w3NBZfzaEhhIR+vKklU/52b0FV432syXSGC61/0HqCk9w?=
 =?us-ascii?Q?acpg/2SiCkk6xBSp0WeGG8TIiIwBJ6iVu1jIkI8oeCNyL9HmJdvUme7NFhBT?=
 =?us-ascii?Q?UvQT6MvVlyWKdYwQ7F3Pw9IB5KpXyoaDRsJMuKm/nDf0gcYRizUR33LldKav?=
 =?us-ascii?Q?jFQdn0zHTrIpmgoicWoZS6l2+eeO9OGSiK2UJpv9zBSMTFDFM8IoulbL40Eo?=
 =?us-ascii?Q?X7d17/5jSjWzF8gMyqxYo22rwCiIHVEUe7UJIPXpgUh2zHJTcw0WZKa1dpUp?=
 =?us-ascii?Q?SGYMHahNqTX6W2pX1nDPX5gnY7KCy5NEzCmW2v6Xyywn49j/u2wJcBBRu2zy?=
 =?us-ascii?Q?H/0paSfQ+k2lsCL8qeV0MWLXOjRd9wcLgPgkCsC11T8gKe1Pna7p0mMGPV7B?=
 =?us-ascii?Q?nFJiAyx9M2AfN/O4gqO+qFdd1VnrTP9w1xR4VzVLEj/golpStQaotO6RR8ww?=
 =?us-ascii?Q?D3pGwJHez4slVZsQ06vXhVvfoWA5vei4zBOisJz0qdXBezgqYy5KqqG3C5CJ?=
 =?us-ascii?Q?qMVMYuweAHkn0DbUeGQ1k5TBBXtJ4vlzFY7Cv37cM1n0gCSaJSGpnHXFDu51?=
 =?us-ascii?Q?CXToAd1JEs5rBlG6niEKbWXVmY+7XLJ504fMq3J51y704QI1OnthrrwiIlGq?=
 =?us-ascii?Q?dMcJld/W0QKgR1TzA4M0tIyfSWS8ksTSpDaTSWLIIFlJ8UJndaKpa6JHf0qm?=
 =?us-ascii?Q?XHblALmH5CrxmkK34aX5iemdXVckxlxSr/2G5kv3PI53ReE8TFHgmSxYnJfy?=
 =?us-ascii?Q?Tys+vQzWrV9l+e62+AgerLXxN6yzgBWDcIe2yHwWVRu+f6sDMvz653oE843n?=
 =?us-ascii?Q?JPai5hTK1qUr1dZwWvcQR/moCTieMgwWP0qqYiIm4m63k6dx2pLApURZCTo5?=
 =?us-ascii?Q?pdLPmFofwVdF62oU1M1P8vfhm2FHjIrZsVKOGEFlGuoI1jqyOkDuVS4M6hUw?=
 =?us-ascii?Q?XSf/jB00CRetRmWsMRVHj5Lya+xko0XOtLPnS9FxEyc3jjtpxFvRmIJ6aX1g?=
 =?us-ascii?Q?SgFz4A953aJXZ200c7DkecKC0dcf8QLEjMhJaJTyyvElYWntFJNJADRLYC3j?=
 =?us-ascii?Q?R38OZI/EB0s4KXDkG9bCT4yySgcZObHC29vMmxfmfWAya7/InPNlZk2YlNKJ?=
 =?us-ascii?Q?QP5ILvkP5LQlborMB9g9Bpr7Tyaee4R/pHM5w92q4ExZOlkB5ElXxE4iYGcH?=
 =?us-ascii?Q?XvtBJBiqkb4MrdqTXgXN0bLlqocotHzsNFOYA2ZZemaEzyGJLd9m0SFaCy8K?=
 =?us-ascii?Q?EuIMTJB05dqASiTiXq5yKKPYU/tyd14B8i4ZuLRu/20JocVW7O6N283WdgHC?=
 =?us-ascii?Q?8djNymDM4vmJeOgkdppAzOkKwGH8YnkKoxrHZfZWG7CbWu2rgmcTTQhnYlxk?=
 =?us-ascii?Q?BBaV4yGO2JWFr5Lkv9KYEm13orAs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?64+ou7+DUKGHErgYyTFf+IlP1QZWeM1Ce8dr+lNzFgbaDDZ88AiV/6SeOhHN?=
 =?us-ascii?Q?/xJnLiT2QzkVD5sAKpA3vmrD2LIluYPNRPeA7fY6dJ9InStZx6iZ8rslbDBQ?=
 =?us-ascii?Q?PmOWUksASOhNAdLASoyRX7lWUGZQmiNFv3892RPpBBXoQ5haAxZuMatUBOtI?=
 =?us-ascii?Q?0V2Rn1ZZyTeQ9Cdij+l3mFcz990bIZnVuh0d8dOntJDSJTjl+EYgcDS7JUyG?=
 =?us-ascii?Q?cbNw8T20KltU72yPMvjams4+1GvInw5BcShREtvauyODyweSHtKuISrzFPwx?=
 =?us-ascii?Q?oMgjDcdf+I8zcunf5eWYQj3xVIr0O7Q6PaWERJFeQC9dzuV0YMJwk3mu5UKs?=
 =?us-ascii?Q?13tznu/kB47V0UPChUVSsP96v0cNOGTpjei09As4yKvJVjsm9VeXYlfOWr/f?=
 =?us-ascii?Q?FnAYvWbMOFoCLByEyqVWnSZEMiJv9vH8oJQ8XngIuD30dOj0dFMmiP86in9o?=
 =?us-ascii?Q?aq6a+a33Ipwxrf5j7yKmm8DeyaSGViQo9RD3FmB3hTkfKcRbT6dQyETKxwtv?=
 =?us-ascii?Q?vNMeFvvnxUC4GnxVcIEzSjsrdlCKC3G7LKq/BV+X7mdGBQBo9QXYeIK2Fy/q?=
 =?us-ascii?Q?4VeMJwVMh5Achwi2bzyQoXvfP/HkrR6p7eMynXZf9+RgyGJP6iWCS+AR6ibW?=
 =?us-ascii?Q?fi2kMNBkwIxczCpZPrHYBRTA5iNxmyrvcCMYYFlKgqiYJ8PTIbBPNc0VerK+?=
 =?us-ascii?Q?wbXAgasWgLv7T8nPFvFr6nNeHiknXUVdIaAYR3QZ/ODV/EPELxwDXh9fRVUD?=
 =?us-ascii?Q?pyRc0RZDnhvLJA0xJUe12GAigzTHnfLFj6caHoSUvQCE3P2d4vplmIoVeb2/?=
 =?us-ascii?Q?2IgMYjJk23p6IlRAvTtfj15KNkfgqZhv3OqxvXV2w79aheCA0vHO4LkhePZN?=
 =?us-ascii?Q?5x9l5UysV8QY6KbTRzOc0o5zjPJWmWGXDIWV0msv5wVNtvUDp/8lDHEa8myY?=
 =?us-ascii?Q?IlfQuWuIZIozK4r0w3QpCLB3yKbTitmBhUWy9KeH/4Xk1uks55xvEfANx+G9?=
 =?us-ascii?Q?oUNbUXhPYbsB9wZzYAQ9O1cc7mMUGJJC6rRplA5VG/bLMT2H8CMNeQLCNrCY?=
 =?us-ascii?Q?3oJ+y18HAytm08bqDMBLzDr1Oxu1+iFm8QWy6Z2h9dXomN18M6F6WIC06Uh8?=
 =?us-ascii?Q?dkuKD3b9YeEOqLFGEX/nJ+NPB/ouhY7UNT2U+Esazj5Kvk2CKwd/4qVpi4rp?=
 =?us-ascii?Q?W64hdXtMyi+ibONRrjRB6NWmXmy1RG7iWrDMiiNVP7Bo1cyTajQcOOxRCpnQ?=
 =?us-ascii?Q?7y7es9BOwtZTA4dv0fTDr2kBZ7FJlQKB9sTtEC8FdsMoc603dRcD+UsyY9ng?=
 =?us-ascii?Q?EThIcFGnUEILgTQ9kPq2TlyCmnOLCJYDDQT65JpDkJ0Hc03n0+exdM2hSbsc?=
 =?us-ascii?Q?Kp+RoKLcPIe1Nz4OAaDNUqJj/LyonLGfCX7s5I5g5Q3nN7hQ/HU8WjUclpmh?=
 =?us-ascii?Q?GMCd7Jq78pX4PzDdjPEHJAriu6rEe8+Ow8N68C6gUbSHl/5rRQcxNordffPC?=
 =?us-ascii?Q?ht8IbmONkBq/veaQim4DUfzPnb7jCT6Ro9Hc1jPMR7ims1FyW2KuYgillQok?=
 =?us-ascii?Q?/NH5Gs/lmarGnNAL4R2FK4Dp+7i6PS6FdsQo+8VJloTEoih5TwizQyFiqh4C?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ThzyUfUVsp5j8bzmjghNQh3BbKy5AC4KykcMM2I7KuPHW0nyY4mstJe4+zxh8JSAz047iYq+UVBxzbbi2jaPeaaxzWXquSwrp4AEmkVPw3EJwv1kj4+yRYXFPYUM75tnze/kA7tA62rPb3zZwQ7sn55u+KaD+08t6MNYe5PgRmxjMmz/CCdRddJ96lHwCrz4mt1bEkiPbxmCIcyoQbD4YPd/K64X2jSJ4tXjBpOqDgCl67guzbCuzOIIZtkQCm11Mi9CPYuVcsz7xzOAM7HZWulihgWmvM476kEY3En11qCYRE5FPnVEBWE3AzYU5WSXRV6ur0ZdGgQ9d2dmaboUN7fZHRStPjXUa5zXtnI/YxQ4bgG4DW0MkUHDIKZWSodikN4MEdRtvLURlalDOvVqwwdk6Bqs+XLdIHKgUvEy/8D8r6SBIFtkdsx2+Eanl29QHTE0OJut3n9KXx6cJxV4m/mpKLL9NI2LOfUty9qhZJkRhNFENgkQWicObdxUUAxh+81lyLcTuqla3OPgndCTal2OTR6ZTGCx+mT9RF1y7aoqwcARiCiiAfq0EgLBVm7Sglhb3vQ4mlPDjfWcx/64zg3fhG9CRLuYjXCTvK8dVW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c293fe0c-6b39-46ac-de1f-08dd31bbc1f9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:14:24.0900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEYuU667FoIUe77J1Hu3ck66SZiSDjJoehnJPgcu3oGLqLIIzE9izS8WQ3rLuWGet+OY4RqzSWVnb9zP3IotCHQQZd1uS2nUfDjp7Daf85o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100163
X-Proofpoint-ORIG-GUID: tANY9DuXCRva5u45w-eaQ_bEXLJMBqE4
X-Proofpoint-GUID: tANY9DuXCRva5u45w-eaQ_bEXLJMBqE4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: David Hildenbrand <david@redhat.com>

Let's register a RAM block notifier and react on remap notifications.
Simply re-apply the settings. Exit if something goes wrong.

Merging and dump settings are handled by the remap notification
in addition to memory policy and preallocation.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: William Roche <william.roche@oracle.com>
---
 backends/hostmem.c       | 34 ++++++++++++++++++++++++++++++++++
 include/system/hostmem.h |  1 +
 system/physmem.c         |  4 ----
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 46d80f98b4..4589467c77 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -361,11 +361,37 @@ static void host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
     backend->prealloc_threads = value;
 }
 
+static void host_memory_backend_ram_remapped(RAMBlockNotifier *n, void *host,
+                                             size_t offset, size_t size)
+{
+    HostMemoryBackend *backend = container_of(n, HostMemoryBackend,
+                                              ram_notifier);
+    Error *err = NULL;
+
+    if (!host_memory_backend_mr_inited(backend) ||
+        memory_region_get_ram_ptr(&backend->mr) != host) {
+        return;
+    }
+
+    host_memory_backend_apply_settings(backend, host + offset, size, &err);
+    if (err) {
+        /*
+         * If memory settings can't be successfully applied on remap,
+         * don't take the risk to continue without them.
+         */
+        error_report_err(err);
+        exit(1);
+    }
+}
+
 static void host_memory_backend_init(Object *obj)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     MachineState *machine = MACHINE(qdev_get_machine());
 
+    backend->ram_notifier.ram_block_remapped = host_memory_backend_ram_remapped;
+    ram_block_notifier_add(&backend->ram_notifier);
+
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
@@ -379,6 +405,13 @@ static void host_memory_backend_post_init(Object *obj)
     object_apply_compat_props(obj);
 }
 
+static void host_memory_backend_finalize(Object *obj)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+
+    ram_block_notifier_remove(&backend->ram_notifier);
+}
+
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend)
 {
     /*
@@ -595,6 +628,7 @@ static const TypeInfo host_memory_backend_info = {
     .instance_size = sizeof(HostMemoryBackend),
     .instance_init = host_memory_backend_init,
     .instance_post_init = host_memory_backend_post_init,
+    .instance_finalize = host_memory_backend_finalize,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 5c21ca55c0..170849e8a4 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -83,6 +83,7 @@ struct HostMemoryBackend {
     HostMemPolicy policy;
 
     MemoryRegion mr;
+    RAMBlockNotifier ram_notifier;
 };
 
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
diff --git a/system/physmem.c b/system/physmem.c
index b8cd49a110..306e71861d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2205,7 +2205,6 @@ void qemu_ram_remap(ram_addr_t addr)
 {
     RAMBlock *block;
     ram_addr_t offset;
-    void *vaddr;
     size_t page_size;
 
     RAMBLOCK_FOREACH(block) {
@@ -2215,7 +2214,6 @@ void qemu_ram_remap(ram_addr_t addr)
             page_size = qemu_ram_pagesize(block);
             offset = QEMU_ALIGN_DOWN(offset, page_size);
 
-            vaddr = ramblock_ptr(block, offset);
             if (block->flags & RAM_PREALLOC) {
                 ;
             } else if (xen_enabled()) {
@@ -2236,8 +2234,6 @@ void qemu_ram_remap(ram_addr_t addr)
                     }
                     qemu_ram_remap_mmap(block, offset, page_size);
                 }
-                memory_try_enable_merging(vaddr, page_size);
-                qemu_ram_setup_dump(vaddr, page_size);
                 ram_block_notify_remap(block->host, offset, page_size);
             }
 
-- 
2.43.5


