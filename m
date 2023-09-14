Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E604A7A0EE1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:22:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsps-0001rJ-CN; Thu, 14 Sep 2023 16:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qgspq-0001qc-C8
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:21:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qgspl-0007cs-R9
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:21:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EIdJ0R022271; Thu, 14 Sep 2023 20:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VeYVs25j6d0dhp+w6LxWlf7wClVLvRto5l3sb7l4EOk=;
 b=VoWi5ba59KNb+obyOf+dCd0DyUC4I9xctxBwf1QYzw1InmQ7SMQAacR9xvNUBa3vMeIQ
 0yw/H3dzi3ARV72+hoPCb5W6TASo1x2301MRLAMGrId94XH16TidP9IBEl+ijdsyGGkW
 drH3NC28GNa6ktGLdDWvegqAvycoBLltdjG9WnXv0nURHdHXVFi42LZj00CyYMP4G/Pp
 iRw+SfOw8zN1w1UmiHvZAQ7POJ+W5jdCWV/TE4QQv6mLgIMSy0LDEYyGIBDNyYd83erz
 wBipCy7Gd6xBHVkkv0QsbOn3x5xhbWjA0oz0ECOKkMadQSdCxZiZcWk1+XoSzlK403si UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hed3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 20:21:02 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38EKAcZD007428; Thu, 14 Sep 2023 20:21:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f59xaym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 20:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ9Vw7DOLyGGtseY1pCr74N54AmyAoohJH/IK5O+eR3J6njBHBnMz4GaawZ0wltScWZ1pmVWJS8PSP4XbfqOYTiLBr7sC1A+klLArdyEZ/LE+t7uPgZCV9X5H7ArCNrPI79E/DmrleznK4QrmPFBhq3+8+EZf8ZOBcgJDPElS78Rl0zSqVoMPOWqAxcvqtYTOaixcnNHkCGzdz3hhzNO8YM0AX4lHpkJZO44YKnYzC1bvVq0v04e7hxIk3QjTQsZvPureLDMieWCwTgJKU0e0IwGeWtNlML0deEFCbE5hxUrJK1L7NiWJibhOAKCzUa8kTxeuQoGA3WTXzK0b4GvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeYVs25j6d0dhp+w6LxWlf7wClVLvRto5l3sb7l4EOk=;
 b=gzr3/lOyqOpzPRsSe2YjjUusMqwjwISM3nfh/xaUHV6tp0ud5SL5UyE0rHED+347acozdoAUbDnzJr/sxMP5jYPG6WGR5A8s8JGvwqcCP5dGDkr5+F+C9xYng7gtYKTEKVOylYu5RbYyP+Lk/03x/u2RICVnMeOLvWJv8y85SzJdEqNhNRyOv/7Xc0rIvxKO54FUCVFH0oD+VfpVVPnbCfUDj0HaIXtDn1X5HHAIbr0HDUhN8hDcu3IUw6aFaprKVg6ZwiwkKUUK7p5ZI6sXAn8vUY4+pTRvk5y/120SakzXGyOVYPrDmzrhT2byfVPCDCtjOeUJaPP8NBmH3rsGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeYVs25j6d0dhp+w6LxWlf7wClVLvRto5l3sb7l4EOk=;
 b=anwGy4ZAeIjpYksjukSu36OsFrksoAZyjUyVsyuKtNOOBPKvv7Tyfy/vDufN2uaUWISqBMahV515Y03ruF8R4f8o8lgGhxZpq9rIEJeX4I1yCK4zgty4iY731vMaD2HhrJ+mHtE/uDXRzlmwYdl17L4dDVU/JYJ6fKxZtjFgdpc=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by PH7PR10MB6674.namprd10.prod.outlook.com (2603:10b6:510:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 20:20:59 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 20:20:59 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: pbonzini@redhat.com, quintela@redhat.com, leobras@redhat.com,
 joao.m.martins@oracle.com, william.roche@oracle.com
Subject: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram saving"
 phase
Date: Thu, 14 Sep 2023 20:20:54 +0000
Message-Id: <20230914202054.3551250-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230914202054.3551250-1-william.roche@oracle.com>
References: <ZQCxg+M2IpecRT8w@x1n>
 <20230914202054.3551250-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|PH7PR10MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 856b5a13-027b-4eca-2814-08dbb5601bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkDWHtiIO8XJtqL+5Vhv/HkfDQIRlJt6djsTZ6pYSJYtfC16z+QSLFqkPK6yeOrr/8277THzxHdiYTkTieelyg9MrfTjKrVIzJNHw8+CQrziWo+/hoX3IRskXQGGlYNWRa1IFVOzfabMnJLfJHpH5wg93LDaMjVVDlfk8VMPFA3ZWyhf8QM6lS3/tT3xut0HPdUWpBcvwf3lIqxAXg1xmNSu84qcbe/m63iq0re0XNKfH763o7A+mPmusCEmHiHXRy8IFUjjuexUd+mBaOOQ+0IqhIyxeLjSOLZRvhXcMkgWcpiTc9s83S9Wyll0ONZ1C9jpJS0vCy5bU3tydecZTY3DFxAD/bojWzp2iS3r5sbWQ4WEOmA4um65J4wiQ6goB2OJC+FIIsjzNCt4hYvTJdxY1+R+DxIh9hvfRj3/s+bLyUIwT20cqbPn0g2mqus6XuQKVrKop99tYR2m0vgtFdJXSjGqbmk+ZRxaVyydvqwjoCW2Ts+By0fYBPfwGK2HV0BLaoNeWDFCuGMfAiZb3hXe1unGyzoFbpq1EMFaE5WyObVsMKGJ6hBiK/+UBTYJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(6486002)(478600001)(6506007)(1076003)(86362001)(38100700002)(6666004)(36756003)(83380400001)(2616005)(6512007)(5660300002)(8936002)(26005)(4326008)(8676002)(41300700001)(66476007)(66946007)(316002)(66556008)(107886003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R05U+cuk0GRkpfVTDoqTaelDO3FtN/ayNZPUxhph/2LpfG+H0pR3EvkQPA1q?=
 =?us-ascii?Q?/GRzkx30y40GpXGS8NtqhFeUyzhiw1M7p45ZthpSUd+H7bfE70vQMlhKAt/q?=
 =?us-ascii?Q?JbTnxWLq1VyMLpm5lL7XVhdCvORBYCNcAicDlE8Abql3/h4etBBgakitSy1a?=
 =?us-ascii?Q?Qxu04G4a4Z6vfL0SaiExGf5i/6XetmYkx96ZHAgAprOhdBZZ517k4VqBSx5w?=
 =?us-ascii?Q?Ki0w4kKerBDdXrBjX1RvdKW8pihWDJhuF0xB8BfKpY2fnlzNLv2tyZtX8JxH?=
 =?us-ascii?Q?UKy86+t14IqNzCLhKyX/3DUeHjeQuNClHZx0gHI0cYORHp/j4UEDe2cusDWI?=
 =?us-ascii?Q?npAb3oquCacMjgVFb7dpBGPbUlmpSeL71+9gW05Y/XYu6PGSYhYoZ5ultNCX?=
 =?us-ascii?Q?VoqbTz2x4x/9bRdCjrx9wEh0drjWhbaFiLhr3fzVPtcoXTgmS+fWNULDBLlL?=
 =?us-ascii?Q?FTshDRh+WCeS7SQ962KbryKRJj1/W9z/gyIg1DbKH1I766en/S5FPEFQZrlp?=
 =?us-ascii?Q?MD+hVK8pbU2Pw2Igx+HTngJ/3d/WfNjSwbARWI7ugnfFWPdeY7Tj3dOibpXQ?=
 =?us-ascii?Q?SGBy0/Qc10bbY6d2/gpEGydx6whV5zcCPBG+gCHQWmI0goQHCZJ+2jFTB6iZ?=
 =?us-ascii?Q?F9ZVwtJATezcZsCOr7gc3eGCFIPFY4ASfGlA6pa3AARNvF5xqMiqoX/UJsfy?=
 =?us-ascii?Q?VgEWYTO2nqTswktNDZFlAw13qbllh/Eyyf6WvUMMTtI/B+8NbLuNt+3kJXao?=
 =?us-ascii?Q?Ey/aTA7KkLcMvWWVU1j6cl7shTu+AzafIIk9RRv8VI0VP+CLXzm9VNZF0REl?=
 =?us-ascii?Q?+efrrHWIoIp7kQPcOD1BPFqpFFDg0RwXBjOG2NHiCZgUC2fkJYhnCr/OpJAo?=
 =?us-ascii?Q?az1hylecAt7hiUAU5suakxx3BLfcOrTq5fSuPIBX0pstoMhzrKCzKhUg8Axs?=
 =?us-ascii?Q?hILLns55MwnYfOUw/VuaWMUq+de84dFI3yIT+dNYq4ZEuru9x3p1F2/L3c+O?=
 =?us-ascii?Q?JMKuSPPatDwGfDKJ0j52MrElVFNAMi5ED3SwqMEBmS3UjTKHmF4XC/+uM3Lj?=
 =?us-ascii?Q?XrPj0T/igDZJEY+rUW/sZNj4s3NRwQ0KqiwoWIu5iqeOqEkYno75Y0vSOfna?=
 =?us-ascii?Q?WdMQAdUHWnWa3t056XrftxzUfv4dDFfN+eKcW3xPHC1vWC1AbfHM7K8O9pEf?=
 =?us-ascii?Q?K4fnpmzwqBJ6Dns6cht4QzjWZnFJ4ErvHmQcUpFj1N6vMlqFC6vv3OqvRLgO?=
 =?us-ascii?Q?tIAE/tObuAB3S08BFqPBhZzqiH7NXmmRlEa4vDQnuWfEl2it2vC2LgBscgLi?=
 =?us-ascii?Q?ke2XJE7cEs5dXWA5a+mI4QD67QL0c9O6LvcN0XNAjAlHtKZ1cN11iUAK4IR4?=
 =?us-ascii?Q?PEtki0p5LKLgXtXNyz7i3TEzv/BAVz6ut8+I2IXCTrD3FAWHBHl8bjG7EbQa?=
 =?us-ascii?Q?mEWyN+Ugc7Vx4YxmXCr75xQ50mJbEtbEtcEkW10ZvuxDx42ajluFXjQTZWwE?=
 =?us-ascii?Q?UtawQE3aukRbYGU3gS6nArP+TOYC965igoAv/Oe/MSQ7DoV1oWiu6xFRDd1M?=
 =?us-ascii?Q?i2bgxcitWbkvL7tNbmqn/nxf7YL2SMiqpoTLoGq7PDUn7qkGYGqxLYLhQgwO?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bJkCoip3C0Zca2xPpmRz9Kowuvs4DtUhHc7vrQEwzqVl56XPDfe381t7yyjexeVTxzCUhXJdQ7vptv9QZKG2wXYIEmUHvSBQDMdjiTWHZR4E2AacAjYei/SKrD1nXUObyndeGZS2SXMXKbBNE7TxGQ8OOzTJB52npbOd0VQQi8DogCMara/hgeS0IOm2rUBA3NUVfjBuHIWSpLBj/khwnecCMurdYtKU4ZY9Y1ApKaMBISugHlJH8PqdPu/yjhayR4/FLgqvsZw/B36Hx7ktKjrsYGE4IGSZEIjheV3J9dkmpNpylCMcWyMukNgvN87tBJPv2mW19v5eKVMjX18zgmHYjHkCHg/YpYUvUKTXg/6qbkKiUJdVJ6LCUZAk1ay8dJeyoK2es6HFkYaUlURpIQeXS4KX1XzATuCvlOy73FaPMIZmWHSqbt6kjG2nRRIhG+anDYzH8eL/fIMefXYclNabXKY7+hEDmoEMaCAWd6+kzP/q2SOGfR+MhFSYSSZuKKQQzYDXO/LbENfwjvq0q1oW1NuJIIE7kG9DlpGMiWyeSE8bQX6caqW/vN0Y5/pbvoAw3JEeu1acuDLgI4Q6QnWnMcLE/wLtYPXdZSqu5bd284uvjboDewgBQDg5fW7/NISnmDcFB+sDE3tyxK5kP80c57zmzd0fx1tWn8twgQwgy0viJw9/PUIixnGpDNZCDDCnm0R5bmV/O1ItPCFHAS3yFhIPBlD8vMmpNPx5zPcwokr+3GMhYwYxohKfyUHT7KX/yfmrRuBW15rBQQYdzg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856b5a13-027b-4eca-2814-08dbb5601bc1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:20:59.1219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPwUu38cI4l9rY6pnuu3xHyIkIUjJEUZZizzKQHftQvFyOT77Cy7Mpj62LqlbtLsf82pwTNLGN5AgpfCa7qr8yIvH8LwvjcElGzQTITlKqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140177
X-Proofpoint-ORIG-GUID: QWcacGoZc5JeicYYswTST-iSxwOhj4Pr
X-Proofpoint-GUID: QWcacGoZc5JeicYYswTST-iSxwOhj4Pr
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

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c      | 14 ++++++++++++++
 accel/stubs/kvm-stub.c   |  5 +++++
 include/sysemu/kvm.h     | 10 ++++++++++
 migration/ram-compress.c |  3 ++-
 migration/ram.c          | 23 +++++++++++++++++++++--
 migration/ram.h          |  2 ++
 6 files changed, 54 insertions(+), 3 deletions(-)

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
index 9040d66e61..fd337f7e65 100644
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


