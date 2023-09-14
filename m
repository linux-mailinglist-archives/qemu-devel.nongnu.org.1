Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC679F611
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 03:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgalv-0000nR-V8; Wed, 13 Sep 2023 21:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qgalt-0000nC-NU
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:03:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qgalr-0008TX-0F
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:03:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38E10OJt028872; Thu, 14 Sep 2023 01:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VDjMH15QvTorDnQEicGRQUIbqfla0KR8+0o1p10RMSk=;
 b=JBoeIDO4zoTWHkkzoadqKAcQJdgFxV5BfNn9KeVMApQVFgtVxwzopfUjGYBZFdnPvoUP
 CVUELA/vc7Tq/ndDca6Au+oIWZNBGl+ovtwO/eZGBnUlTsqoOQ710fGteLnDz4889h4J
 N+m93g3L20isx3NUhf8wUzBAPtW4juyTT/TpgFCTdWa+u3qEAhPsjYOXSEbZbg8xGI7A
 muPykO+U4S9eNi9aBYHI8Qg1ZgVzboyESVjzAz0NP7NnhcQPXKlKLs2iY1SxDLOtciaQ
 hnm9aUFKtXYWKeChG3M0yxIkB/91sNcoeBVp91/Bu7am/WbMQJBgqK1LRiSZGEUoGl5C qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kbkvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 01:03:48 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38E117OS023178; Thu, 14 Sep 2023 01:03:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f588p9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 01:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXlwRe99uhl1oiIX1V65SNV43zq9nbUETNDMMrgTQ/5hCqhzPZfuhlFrgu8FC4EAnM1ZTR+2FFb1Bru17okdBSw6/xiOiFrAJqlQkqw7OQaaSUEKfkYguLCvxOF9gSXgaaigNj3cLyPQEIixJ7tPSUqkCk3ryeMguHe+JsXBn0B+hO4wq1l0rpiEnFR2aQF4+plspgFU9rGmYLn+lAXs8M7YT3gp9j6+ffuaEvkPQ/Z+oD5HG4gQeAuNn0kDAnv/VySMwPOKsKPFFNUvegmsusLZq3ifucS8oFb7ijkc2+JHeZei9rOXUAGUPcY2nwlDMk/7R75TkH+4vfibA57B1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDjMH15QvTorDnQEicGRQUIbqfla0KR8+0o1p10RMSk=;
 b=EU621zZFEhURdcnsG5PA12ZwlGHjcUJW+3+uy19fd4JHJgDS9zi8GXDkhUAMNtsRrci2IyiloU3Ks66TAduD50NhxS3Rl5HQTcdekomEXz67JflGA5QNV/L7dz9SfbqY55VH5w/O4JH+mmawe8q6DksPxgS9Don3JcpQ8fKD3F6rEZf6Hy2lqN3d3NmkfeVn0yTa+In7PUd4z8E9Bz//Hi/wL++kG22eARULsaKOmwn6XXYb7Jrx50U6eforDAk8N7w0WARzRdOIjtT6uWQ03GG0sJJkK4QGLQwNXoq4WksN9SNsRWdF4nS5ucRjMldwzbYBX8cVSLsICv+ooXXjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDjMH15QvTorDnQEicGRQUIbqfla0KR8+0o1p10RMSk=;
 b=FQLJY65qD2SxtVz0Q1LaqzgS6GWEdAthjJ9A/+dlkI9iGRw54U5SFzHAjQkLXDoYJF1zVIckWvIjJrhRn/zVGRk/wPmoHjOCwk1Eo622jFMKbsGjSpbSSmifCm1e6TpryAB9VvAgSUNM+NUIOK9fNs9VeFY8qsqpc+dOzfNjjj4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DS7PR10MB4975.namprd10.prod.outlook.com (2603:10b6:5:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 01:03:21 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 01:03:20 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 qemu 1/3] dump: Pass DumpState to write_ functions
Date: Wed, 13 Sep 2023 18:03:13 -0700
Message-Id: <20230914010315.945705-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:806:6e::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DS7PR10MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3e2e3b-2bd7-449a-29e7-08dbb4be6368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTryy5K6CHSJ1C4d/EZQfF7rsRatDuZO5fDHXSAMSs9dx5nY2aaLVUhLErxXAbR3uTE5vqgp+huZahw4ILgjYv+a27umZWUoyM+97e74bLpaTPSxgw+8PKQYP6kfcXVmj08CE0Wh0+lzftomTyGgHy+6oFvAwj3RZxBetrv8VG+3EoxIOMTfjwUd5Wscg/sXUFzphYh5ezapoJt+HLf0PxYt3yCNxA+6gverxAL7Z67GMtkOnje7vmgj1PFvQ5gQ+yp8yFfl9CduwBJiPc9RgIR0GwhNdXRDu1fhzXP0FF1bYbpprBgy0NjU0Gt0SEvVGkb1fk3AuTkTNbQjAUXxkAuyrl47eybr+6vhufeS66CIi5cnd8Cm+fbgMNXcqMM7+oJXf+t/LEiEd9eEq3LIEFCBclkTSTThWxtykAxdRRMRGVb9QWnZCATER7ebeoxhhgmFUUN08+sIFCbmJKzEuiqj5YFap0f4J75jttUHt8pl1h3ytX68BcfMNmElTWXGsnhfPq9VBHXZRzG0Aadbaxz65fLV71s8HFQ+z1SvFgxCzkjpOjvH2zXBwpGvRDb0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(38100700002)(5660300002)(36756003)(86362001)(103116003)(83380400001)(66946007)(1076003)(66476007)(478600001)(66556008)(6506007)(6666004)(6486002)(6916009)(316002)(41300700001)(8676002)(8936002)(4326008)(54906003)(6512007)(2616005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PuivxonRHvlwD0tIoMUWdeBoSI07hz3fTLCnf3pVQPri738iM8o+F4rUVUEZ?=
 =?us-ascii?Q?/HkNvodDXS9f6aYvZjTBL4PHwrpdfRM5EaooKvIpd7VzuQYKoGKTa0rIdz5g?=
 =?us-ascii?Q?y6Jn/xh9bCnyxQ1jKzPdDWALtzq3JWGoDqaHBH9NzeXPjOeZSkpll3sYu/kp?=
 =?us-ascii?Q?ok/ogktxHLGGdSUSzPhTYs7CMvkqodLYsQBQImAoCVhhiOHeZUq2pb+3p9lB?=
 =?us-ascii?Q?0f21f9NNi3WoQaouJ1HuNGc1xm62EZ8LihCh11ue27ioF89RQ2AoAEF5jRMN?=
 =?us-ascii?Q?MDjY4osIKBoEIXHFoLdWKf0zCXdfGN3rjABVCupIVW+Nq1mfHDq+oC8g5uUu?=
 =?us-ascii?Q?Z3Jov9hgmHneIJIIVoxlj2LUXwpWWG7vi5MYoCCQlzCVFAAnoeB7YnqF5AMk?=
 =?us-ascii?Q?fusACS6RX5TxemV4qs1/dPwrs2r9XZ6NogX4BcZwvH1+LxnmoCxk5pbWWOJD?=
 =?us-ascii?Q?EhSJI7ea74+frQ06k27jnAW6c2uwvrM7a5B8UZrxvBjccK2PtcHFYELdM49P?=
 =?us-ascii?Q?XLC4r6Q/izM4RJDEwdDn8B1BxdMbY5mMTnbbNZXFKmgI9HWTHAQ/rg1e7ivJ?=
 =?us-ascii?Q?p5mKpdndioDCyC9DkrbfzI//jcLHhnFfsA5ADEh6+rlL0i7kI6Yb4HunDnKQ?=
 =?us-ascii?Q?XQbliztng94nm/aaeNARQy6d8XoUrboRmmXuEP0I8XQLZH41mf8PyJxpKGOp?=
 =?us-ascii?Q?Wmx+T78o/RwpxLhoRChOnrR3uhw0swzfNblpes1meN2SgN2E+TBN2vstWHbo?=
 =?us-ascii?Q?20OtoI5yM+2gb5tTXjwqv+pKsBiw1HmMbzOtdikEkb2mcMoN7qohB3CreILf?=
 =?us-ascii?Q?59SUC1Cbw/Mfh3qrO6S2YWwNGD68W0dd7JkH9LaVu9WCIG68HbDgZIvHO7N+?=
 =?us-ascii?Q?fU0WfxMNJK/yKNn+abzcRG7bYaHC1WpqUw5hMzc7cDBGmskYwaKFRvj0zAGZ?=
 =?us-ascii?Q?BQotma9QVPONeb9K4Ng1u5KeJiCJCbvZuRfAa+x8yMQTu4m5oghsHzEpc86v?=
 =?us-ascii?Q?uBZu2NsM7OV4Ma0svddsROloca0SbeXGZ6XLhAp7+nNv8nnE8vkl3sj76IUx?=
 =?us-ascii?Q?vSqg6DyY6ubl28XLEv7gBROEHzP3K8urVKvUoH3E/ynj4KbOFjbh+/AtRe6b?=
 =?us-ascii?Q?iXq4FH7xVNhf6qtYdCN/1GuhxB5uPRmC6/YYf+KeVRwWYUdKgikZFnYC7sYI?=
 =?us-ascii?Q?RgRRt0oZGcDD4+qBuUljUj9GM82Q7MVJusQTLnYesv6yhqprOlKD4e5Ts6jb?=
 =?us-ascii?Q?x1t+ND1fCP9jYB+ef97RP775xoOjU5dyjY7Excdob0rGTXVpl4xkrA1SCuW7?=
 =?us-ascii?Q?dai04e7bF7qXXJ3EIOtpXiiZVbtp4gIxKC8nXkp7OedOEdEuR0kuprmOhpFR?=
 =?us-ascii?Q?1B9f7zHxbJTIKwt+moEUWazRIs0ogyEPsryL20VRixQJPjgqYAxKTGgTGIWi?=
 =?us-ascii?Q?ZFQc5nJJWqgskkfHNTR6bvFgiSPXs+TQsZGXesvAbU+t/6ihU/WK5eJT0Wvu?=
 =?us-ascii?Q?UwoUxS3rVgWFA2QrIV4ln2EMmFdW19oHkX0nGvPfU6oRvf9ehbSri9GTfV0G?=
 =?us-ascii?Q?HAUk90phUaNSgFiy0ZdHrV3IGnjFLMrjDDcng36XQ001rXrFo26+/K2xsIJK?=
 =?us-ascii?Q?yAS9iSNFxHCLuqAVynBuwHyuoVMIj/Or0Fj6/CRXcYAJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Afhl1qkiA25xguKLwURpP2VLa+UT2QznfDD0Ecj5FZdtk2S628kJe/qsiB9QjCx3hdFnCX1tNJS1gmUKSyjCEEU5jDK+/yQ6gPWMJCpHB+qZWx6dbchsZCraipOCJel+20t59Ax0h6fcpIhrIogdHNmzJLaAAkdZfoLfOj5SxwqP6F7+ZwstlqUZjJh8XjEJ3V2I0gr19U216ESGgg1Y1AILt7x4n/h4oaALj+a6UW5by/xY62VJ2OQecrObHyI1SqEu82l/x4qTr7lcXuedMG6PndCF3n/tvzg93kqUs3MGGtT8JRlvPBhNKOxz3okvJgEN9iWBsmhglL6WYMfrl4QJKguD2NiUgDEmey5fGVcB03i1IL6NL1VrU9wPe6oNKUJ0gNgeN8wqdt9WY99g0NhALLUf8i6cQM8mFl+ikPSU8xIBFfqJEMq7+mXU7BnvlCNCEN1B7ltVtKkEPW7qgTWm6uB/Bu2RLrXD1VE5ic/7AG9yKJ0D0+S4yF0t5R7FJfZ/E8RBagq0NHnwEuZIeVv5F6JQqvLzK0VftoMdjBPq5do1Jbv6TTLgUynKF/vHA3YZezfGUXtKmgkSuCaiom3kXubYwRYzYva6dTx0z2yANbDxxHfylp5rudOqLGbvsQZSIZb4hj8qIUOu72AkrjKjeeA4QkSSBR0o+67WF5O0bqIeHggcCVnqkqTJuyUo2/F0HJgqhAgyYuRVh2XsnvUtC8jg3bHyQm5Kvj1K7vNbWpDzuxHNDOuiIy+qJXChdj7oc5W4xfHPAAVQhVQftSPH5Uku+YMjkWbwJV+s9IYclNaz7Odu3iSXRk8tWlihqABQLfWglA5kFf6aAo0un2cZod/Rfk10JrbDEsW6X3eVfKSW8q0qH5keoKhYkZ5Q
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3e2e3b-2bd7-449a-29e7-08dbb4be6368
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:03:20.9141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr8FrhhkOCGjOMM3MO63/KdVgnk+GUrN+VwHmeAaoyN+aB2L3ktAVAT767lelZE1bVfx+aoVrWBsgjWm8DqAMHEO7lYvBKppTYAyaNmQkws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140008
X-Proofpoint-GUID: 72zAap1s_IPlSvk6vhNl2MsLff7FQHWk
X-Proofpoint-ORIG-GUID: 72zAap1s_IPlSvk6vhNl2MsLff7FQHWk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0b-00069f02.pphosted.com
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

For the next patch, we need a reference to DumpState when writing data.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dump/dump.c           | 40 ++++++++++++++++++++--------------------
 include/sysemu/dump.h |  2 +-
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index d4ef713cd0..74071a1565 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -809,7 +809,7 @@ static void create_vmcore(DumpState *s, Error **errp)
     dump_end(s, errp);
 }
 
-static int write_start_flat_header(int fd)
+static int write_start_flat_header(DumpState *s)
 {
     MakedumpfileHeader *mh;
     int ret = 0;
@@ -824,7 +824,7 @@ static int write_start_flat_header(int fd)
     mh->version = cpu_to_be64(VERSION_FLAT_HEADER);
 
     size_t written_size;
-    written_size = qemu_write_full(fd, mh, MAX_SIZE_MDF_HEADER);
+    written_size = qemu_write_full(s->fd, mh, MAX_SIZE_MDF_HEADER);
     if (written_size != MAX_SIZE_MDF_HEADER) {
         ret = -1;
     }
@@ -833,7 +833,7 @@ static int write_start_flat_header(int fd)
     return ret;
 }
 
-static int write_end_flat_header(int fd)
+static int write_end_flat_header(DumpState *s)
 {
     MakedumpfileDataHeader mdh;
 
@@ -841,7 +841,7 @@ static int write_end_flat_header(int fd)
     mdh.buf_size = END_FLAG_FLAT_HEADER;
 
     size_t written_size;
-    written_size = qemu_write_full(fd, &mdh, sizeof(mdh));
+    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
     if (written_size != sizeof(mdh)) {
         return -1;
     }
@@ -849,7 +849,7 @@ static int write_end_flat_header(int fd)
     return 0;
 }
 
-static int write_buffer(int fd, off_t offset, const void *buf, size_t size)
+static int write_buffer(DumpState *s, off_t offset, const void *buf, size_t size)
 {
     size_t written_size;
     MakedumpfileDataHeader mdh;
@@ -857,12 +857,12 @@ static int write_buffer(int fd, off_t offset, const void *buf, size_t size)
     mdh.offset = cpu_to_be64(offset);
     mdh.buf_size = cpu_to_be64(size);
 
-    written_size = qemu_write_full(fd, &mdh, sizeof(mdh));
+    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
     if (written_size != sizeof(mdh)) {
         return -1;
     }
 
-    written_size = qemu_write_full(fd, buf, size);
+    written_size = qemu_write_full(s->fd, buf, size);
     if (written_size != size) {
         return -1;
     }
@@ -982,7 +982,7 @@ static void create_header32(DumpState *s, Error **errp)
 #endif
     dh->status = cpu_to_dump32(s, status);
 
-    if (write_buffer(s->fd, 0, dh, size) < 0) {
+    if (write_buffer(s, 0, dh, size) < 0) {
         error_setg(errp, "dump: failed to write disk dump header");
         goto out;
     }
@@ -1012,7 +1012,7 @@ static void create_header32(DumpState *s, Error **errp)
     kh->offset_note = cpu_to_dump64(s, offset_note);
     kh->note_size = cpu_to_dump32(s, s->note_size);
 
-    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
+    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
         error_setg(errp, "dump: failed to write kdump sub header");
         goto out;
@@ -1027,7 +1027,7 @@ static void create_header32(DumpState *s, Error **errp)
     if (*errp) {
         goto out;
     }
-    if (write_buffer(s->fd, offset_note, s->note_buf,
+    if (write_buffer(s, offset_note, s->note_buf,
                      s->note_size) < 0) {
         error_setg(errp, "dump: failed to write notes");
         goto out;
@@ -1093,7 +1093,7 @@ static void create_header64(DumpState *s, Error **errp)
 #endif
     dh->status = cpu_to_dump32(s, status);
 
-    if (write_buffer(s->fd, 0, dh, size) < 0) {
+    if (write_buffer(s, 0, dh, size) < 0) {
         error_setg(errp, "dump: failed to write disk dump header");
         goto out;
     }
@@ -1123,7 +1123,7 @@ static void create_header64(DumpState *s, Error **errp)
     kh->offset_note = cpu_to_dump64(s, offset_note);
     kh->note_size = cpu_to_dump64(s, s->note_size);
 
-    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
+    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
         error_setg(errp, "dump: failed to write kdump sub header");
         goto out;
@@ -1139,7 +1139,7 @@ static void create_header64(DumpState *s, Error **errp)
         goto out;
     }
 
-    if (write_buffer(s->fd, offset_note, s->note_buf,
+    if (write_buffer(s, offset_note, s->note_buf,
                      s->note_size) < 0) {
         error_setg(errp, "dump: failed to write notes");
         goto out;
@@ -1204,7 +1204,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_t pfn, bool value,
     while (old_offset < new_offset) {
         /* calculate the offset and write dump_bitmap */
         offset_bitmap1 = s->offset_dump_bitmap + old_offset;
-        if (write_buffer(s->fd, offset_bitmap1, buf,
+        if (write_buffer(s, offset_bitmap1, buf,
                          bitmap_bufsize) < 0) {
             return -1;
         }
@@ -1212,7 +1212,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_t pfn, bool value,
         /* dump level 1 is chosen, so 1st and 2nd bitmap are same */
         offset_bitmap2 = s->offset_dump_bitmap + s->len_dump_bitmap +
                          old_offset;
-        if (write_buffer(s->fd, offset_bitmap2, buf,
+        if (write_buffer(s, offset_bitmap2, buf,
                          bitmap_bufsize) < 0) {
             return -1;
         }
@@ -1380,7 +1380,7 @@ out:
 static void prepare_data_cache(DataCache *data_cache, DumpState *s,
                                off_t offset)
 {
-    data_cache->fd = s->fd;
+    data_cache->state = s;
     data_cache->data_size = 0;
     data_cache->buf_size = 4 * dump_bitmap_get_bufsize(s);
     data_cache->buf = g_malloc0(data_cache->buf_size);
@@ -1399,11 +1399,11 @@ static int write_cache(DataCache *dc, const void *buf, size_t size,
     /*
      * if flag_sync is set, synchronize data in dc->buf into vmcore.
      * otherwise check if the space is enough for caching data in buf, if not,
-     * write the data in dc->buf to dc->fd and reset dc->buf
+     * write the data in dc->buf to dc->state->fd and reset dc->buf
      */
     if ((!flag_sync && dc->data_size + size > dc->buf_size) ||
         (flag_sync && dc->data_size > 0)) {
-        if (write_buffer(dc->fd, dc->offset, dc->buf, dc->data_size) < 0) {
+        if (write_buffer(dc->state, dc->offset, dc->buf, dc->data_size) < 0) {
             return -1;
         }
 
@@ -1644,7 +1644,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
      *  +------------------------------------------+
      */
 
-    ret = write_start_flat_header(s->fd);
+    ret = write_start_flat_header(s);
     if (ret < 0) {
         error_setg(errp, "dump: failed to write start flat header");
         return;
@@ -1665,7 +1665,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
         return;
     }
 
-    ret = write_end_flat_header(s->fd);
+    ret = write_end_flat_header(s);
     if (ret < 0) {
         error_setg(errp, "dump: failed to write end flat header");
         return;
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index 7008d43d04..e27af8fb34 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -137,7 +137,7 @@ typedef struct QEMU_PACKED KdumpSubHeader64 {
 } KdumpSubHeader64;
 
 typedef struct DataCache {
-    int fd;             /* fd of the file where to write the cached data */
+    DumpState *state;   /* dump state related to this data */
     uint8_t *buf;       /* buffer for cached data */
     size_t buf_size;    /* size of the buf */
     size_t data_size;   /* size of cached data in buf */
-- 
2.39.3


