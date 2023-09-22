Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA217AA99B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 08:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qja63-0005EE-8G; Fri, 22 Sep 2023 02:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja5j-0005DY-Kc
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:56:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qja5g-0005Bl-1V
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 02:56:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LIsokl008313; Fri, 22 Sep 2023 06:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ijUoI21UGwVDXnyq83lnQ2Eo0ySprE9R35vkNC/ce6U=;
 b=F9Hv60xy0Lctbc3jb0C6NUBW1Ekknva1Zw0mHR/433gk99vYshRB7Vb/rBxaPn9Io5+p
 y72j94gIYmBVcnTYJNelIY5U0S6n2NJUUXpOkEudsJLADMnZzxsb7Fa6Fv7onHUHYCyH
 bn04FrWTlyFpuUDiUtp/StS+ydh6hsvjcj/9ffyyB6Q63xrgrFyrFl7eamK4xH3+jUnh
 kDx9+9DBlNJO8ydABsvqQcXqC1/QzlFlkdZuT2qwa1qsyufTFPETiOaDWALTj9DEN0ua
 4WjTRqsebqVkGmGANivYsjMybIK5Cplux6VXb8MO09vsJ9UC1UyQDTd1IhF3RYCOrbiP oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvs210-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:36 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38M5tR1t029722; Fri, 22 Sep 2023 06:56:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t8uhcbqym-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 06:56:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS1LXPHapBKlhdkfBO4ZAHirBXZdqMGWCkPBVycEfwwwQ8giVXFUbQzNw1Ca/i4P5U0qfnHz5eJkQDSLl/dLpSSChWkoJgiaKeE39DrhtIs/r4xgSfHX6288ptTUlKX8L4MXqOQ4dN+LfpAf5+ZkgffxgB0edU0UM5fElXwzRo5hMZIuOVfQhKOXDurir74YBiKs8XO4JavCpFNM+oM7tLEVwU3qcGYY4qxaehI6N+3wh7OLpelq+91u75+LeRlF378d/hZKBIeABuOcg8FsO/XQfjn2N/MfKUENugfiUJZaBKENGm3CAboh3tPjNEQ63b5yhzTt4FzMNAQ9FsI8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijUoI21UGwVDXnyq83lnQ2Eo0ySprE9R35vkNC/ce6U=;
 b=Ve32Fhgd5K340dC1PtmH6RKg+PtOftoxVV3b0OhXqIp1uNf9jkFIz67MFMDxIbbPkaWYaZomylGb7uFP2nTSaidMLJCegPE6WE0D+AZzZg/EGwhtpSR7jqiACtVOubLMVW33Thml7g3rOkTNsEA79r0jHgiq7cZYRYGs4RbJPmADPw6b9vdxMp13aq4W1Gvq9oN1d6KDRwPUdK4Qd4KzhRuu+xPiKyY6wrEiQF8I8QeYxq7l8cj1KeC/ZauokJynDTBUf5CGDH1cy35sGbf38LdrPDywEwPxc5ypwPLiPEGmPBkGxz6GlFYB+H2Zi56X63E5lT4P9hW180fT6O+LZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijUoI21UGwVDXnyq83lnQ2Eo0ySprE9R35vkNC/ce6U=;
 b=LVdYY3DGbttjZNjfRr39DGOMa6106jsxIzG50RVyk4YeFnjG40tUcGikal8AhSVf2Qg8WKqRAffroWMqGz+XvI5Ew0Koodvpht4Ap3acSsowUl86uakG3LxyR+RE1tjkHT45gfuX3nPLEG0SX4Qnxt0mI09Nggx4tBJACURhwD0=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by IA1PR10MB7419.namprd10.prod.outlook.com (2603:10b6:208:449::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Fri, 22 Sep
 2023 06:56:33 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:56:33 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: [PATCH 1/4] multifd: wait for channels_ready before sending sync
Date: Thu, 21 Sep 2023 23:56:22 -0700
Message-Id: <20230922065625.21848-2-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|IA1PR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d74098-275d-4750-f589-08dbbb390e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uyOYslNusgX6nSdPu+upDHpEiz6stmcREH0c8eWrH+hfbyzDGBsgo8kGaRvyp1P78B7dA+lCTPYqx8oSM/fyeZBYs2OQeY/BsHwvvg7C9TCBU0TQ3GsxbivPJKl/bXu2qjcB9gYLBxk+UJO6qY4+9nMVdSKXpkzWikC+lWzw0nnstCbA23s17apCwVCOOQttOgDebTLvHMHBjChJ/3vzhOe857iGQhgAPDS7sWvePytUaP07npyNAd9YCatWqkYSR2c6acS718iUFzUqINxLCZKAb/cC8Hw6kD5mD8o7iubwDfjMUPpFLgbGgXTctkM7KE/dWJFHTxqYoGr1t8igtDw7hXyxq+WKl3cHAcpV4xU8lrfWH2kNo+ob9aF62n+j2+L0Nf3fDDNvjJluzpLq0rLpemaXXVcnGHE9JRvCogPd7uF95A9BtSu/WfL0khsYHN3ULhugNzLYKlCjdNKsoInb6Ig/+AW32WDBqNJhVAVxWj3t731ePbfdGn8JQldiBgSsR62xHDcp0TRbQ9mMd0dDNDnA4CXpMfSiZXHwpL5nS8scmZnNrjm+05i9UXaq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(186009)(451199024)(1800799009)(478600001)(44832011)(5660300002)(8676002)(8936002)(4326008)(6512007)(6506007)(6486002)(2616005)(1076003)(83380400001)(6666004)(36756003)(316002)(66476007)(66556008)(66946007)(41300700001)(86362001)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vBxSrl/Mk3HRQubQrcyaAOR3RcB0TGbs9OGU/dDb6qm3w5t9SoapFomtO1Dy?=
 =?us-ascii?Q?4jnPaSpzYF/iu3VfWtofIrhFy7m/4We1YYOqs2AGj+g0v9zQGYSpAedrsWqq?=
 =?us-ascii?Q?MgUXm4GgFxo+Kg0BPEKeV2Xx2wyydFJFs5gP35OralG7akaaeAMZ1TQ0B63Q?=
 =?us-ascii?Q?1EOcoBZCJCHf3beiQafIJs4oP29THCrKuNn4G4VEYembXYXZyeZvfHfZGMlD?=
 =?us-ascii?Q?nDbouoRYluzs8mjLSKRjgcW8h4gDGJefbiMmO3BJdooox9Lkg8SldAMfzs/i?=
 =?us-ascii?Q?JkzibmxvtjGds6qxtXrx+84fVZwtFNuH8L4E6F2CnC1cVZg5dC6dCNYNjCoz?=
 =?us-ascii?Q?Co3l5ssCp+Tnv73zqaDgd+fB/g8dzj26SA8uo/j8y1Kuy7WZSbUDFbeg3EMK?=
 =?us-ascii?Q?FFKd3Mt6uX+iawfUWo+A6XfnkQvLdSaqjQKCdk3zqSQ0bDv+dCORVsKauZGd?=
 =?us-ascii?Q?fLNvjteMtMhnR9bo7vsCajdm7orA4sEMgqaGW0hngRFvWiF/qp8AuwRv3nb+?=
 =?us-ascii?Q?NvIGNqZvlaMRrM1ChjlchWbPtXB94873PDYMebqIzjEn/av+g4Inda56510d?=
 =?us-ascii?Q?R9X9E3Ax9fVIBHFDDusfUnzwe1YdaOrx5ckbptZ8J8Y3z6Q8sjH30XYHz8jr?=
 =?us-ascii?Q?pP3IRLkk3RNsiQI33j3XGFdIE1HjVFO8Z/AVREtcuSCTZspXmM2X4uKjGC+E?=
 =?us-ascii?Q?uez1+Lz6Sn4PRyf2QDleVurK6ftopJgBtQyIp34iiqdJdx+iW46enX7edKtV?=
 =?us-ascii?Q?uSIKlWiiCiKAy6o4OVfmprANwke6IER0xWc44q0cX7coSsxg1fzKQBUyABc9?=
 =?us-ascii?Q?s8rOdrxLK0nk68iSQTSoZYfMfVQu+EgMX3XibG+0b6dqj/1jBs6IW7tdeJGb?=
 =?us-ascii?Q?Mjyc+e2xiJTLrDaC1wx9HzNELAWU5Z4E2Q7taVFy9ToZ6Rkj4P28ZRw62Dxj?=
 =?us-ascii?Q?jnn7P6u+clyltWcFhZc1XWDpUMvetLd29FrDt7wzxOmDpUZtZB4T3O6O8b33?=
 =?us-ascii?Q?9HlTX9juJtkpKwuK36z3CNXgZVS5RHjn/zmxGcTj4OgIKFoN/ByqGjKnUB4R?=
 =?us-ascii?Q?UQ2EUKw4rF7Yl48lH1itcvyBUFio1PAIWX5i3kymwk21G9FdgWmtO1CdqKaJ?=
 =?us-ascii?Q?6sF72qcGbCRQcWC/JP0Er5LI3pZDJTzpWzYNHyV9C8nniy/tTeUjR2Nt7RDD?=
 =?us-ascii?Q?LipknqYer49eMCHffDPEGkeIks3O++L0N5rr/HYNxGGdyCUSkgU0crITxsma?=
 =?us-ascii?Q?VNQBYI9g/NAeE1YkUZ7MWymeKrrym7sZH9bGIzOaZQtwx4VVWCv86b2Iv2/N?=
 =?us-ascii?Q?tL7+svNMaNXOQ0fAGDfdTaeGfeRcOALjqaOdo6mbHdRi/lRSucu1c6VUGG2A?=
 =?us-ascii?Q?XK0RnL8QZxOrBJMspU/j4dNG7FIksXu4O1PEj2VP0oRC/ddqWk7FHOaGzqv5?=
 =?us-ascii?Q?jQ61BkhRxgT+3nLoskIGXSXf2FH/fRP8F1zeCWMqJZdsLR0+vyLORqRKsQEY?=
 =?us-ascii?Q?HjIuBaLewKHgBUj4N+WhvKkVuRQA0XH0Vx/iCvDMzyRCphSUoE4VL0wRia3G?=
 =?us-ascii?Q?Z1ZWcyoDIhA5oAs/fo1XqSiRyndsDcNrTaItcJ5z3pcmyyphPSdHj8eoMpdW?=
 =?us-ascii?Q?843/YRZZLfs/zYpqe0vYuATvWnUMNYCwujq+wzlPH8lajwJSZ3jKTFg5FPP0?=
 =?us-ascii?Q?SwckIg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +p9Qr6c+Ga0guNZad1ojZWdWA7RhYg4nCEX+1bZXFlnEcSA7ZASruf4EAznxanF6T4KTyvLmcfTFMMJx9hPHZrbCk5QfBohiQ22/fXd221QdDnzWtF45Q4YmrZh38rkSdaAgnucnhOFQrarAzMuGNJ3f+NYglMDr333uawJYIdNl9DJBsdEqvdLOkDQHGXEf3LPY4UgMSaHK0uwvPduDvXk7ajIIU9/mf5cTZVHy1lfnlgvv2f+WCDV5KLTy8tLwqHFqDaYJ5AtR85ZcGqe3Onl6jYoIo45ajKD9SdwiyvsGMZ2OyGd6R9lRoL76xZA1qDKAFGr78p3t8EoukBRB83nqBa2wwydMKDVLrEKKapGgcEBCHiNAiGesNMaL+P1C1LIKgSTqKIMtWTsM/GT/bOLYzwHAqAnDzeMz7wp3OuCGBVuP+a55ddoh+PYvtSL6sZUp7hfSJqWIY0TwyGgXzDon5Mg555HAoCB/hvwqcOrS4k99TJ2ukdIn6/Qnv0pmNJtN0Enzw8aSbv/PTxOj5MQR6EeDYdFN2z/9HCZ8glu6PiS4m2cvUIpgwsMpulgn1ruEK91CjhVdbc6mpWnPPZMRi2kTannZEP27aup4pN+v2Xunir1IyZcxGbPQD1wKm+3V4n3pnfk1bGJMw71qqSmvRliLqt4b5EFx/bjtvg9kyYpGdF8TVlZwgtGC+8dsk3Uct8QDRVC51eDiTkDgHI5/+l7DDUV/JjEzUCwMaM93V+idbo+JKO6054z+qpmlBdeKlfBOcsKfadaqp8/O8Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d74098-275d-4750-f589-08dbbb390e42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:56:33.1551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OevhbVl8z9Ik1g8Ud7PhXCz5i39CqbpMcPmz+67CvepX0TgYFzIELDxVQhgh5Vk2rMD91dhlzg8UYroLcnVVYJKkSjLAeGU6LgS2f1t+F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220056
X-Proofpoint-ORIG-GUID: 3DRzYZYn_OijL_sB0AaEcl4578Ood0zB
X-Proofpoint-GUID: 3DRzYZYn_OijL_sB0AaEcl4578Ood0zB
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0a-00069f02.pphosted.com
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

In multifd_send_sync_main we need to wait for channels_ready
before submitting sync packet as the threads may still be sending
their previous pages.
There is also no need to check for channels_ready in the loop
before the wait for sem_sync, next iteration of sending pages
or another sync will start with waiting for channels_ready
semaphore.
Changes to commit 90b3cec351996dd8ef4eb847ad38607812c5e7f5
("multifd: Fix the number of channels ready")

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0f6b203877..e61e458151 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -595,6 +595,7 @@ int multifd_send_sync_main(QEMUFile *f)
         }
     }
 
+    qemu_sem_wait(&multifd_send_state->channels_ready);
     /*
      * When using zero-copy, it's necessary to flush the pages before any of
      * the pages can be sent again, so we'll make sure the new version of the
@@ -630,7 +631,6 @@ int multifd_send_sync_main(QEMUFile *f)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_sem_wait(&multifd_send_state->channels_ready);
         trace_multifd_send_sync_main_wait(p->id);
         qemu_sem_wait(&p->sem_sync);
 
-- 
2.34.1


