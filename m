Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44D7E2F64
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 23:04:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r07he-0000O7-3A; Mon, 06 Nov 2023 17:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r07hb-0000No-Kl; Mon, 06 Nov 2023 17:04:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1r07hT-0006LW-KD; Mon, 06 Nov 2023 17:04:05 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A6FkumJ008867; Mon, 6 Nov 2023 22:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=nBpc7ltGTTryJ17ec//n0X+dvRU2vgCrVl5VDB2SGtA=;
 b=errQ4+AH3hjWFpKSORiagDe2+L1jM4YA5FgyRth/RHY+5FEfWA6QEMRwdT8FkO1Ln9Gk
 4cxInU6UeyrIMBrwsqSXCA+Qf241E3fSKCnpPYStewGj987PJ3r7m0geelB3fpFEwPkP
 MGNwih9ddXYn7RiFydntRnqUKHVoBexQlUp0BLe7Tigm7dF1MDrhn6EbX6rvAyqzg+jb
 HCCVM7LpuQDg3OgRcmgv7D0uWRXrqgW/OPDlBpeM3jzBHkq8T+QgnEmE+PhIsLTOtitn
 iUEQSWfzz6rqzdZBmRjbxm1ocIGyYCW7wC2mF3jjctYhRuqBm9r2RlMeOdX8lZwbi2CT YA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5ccdvh7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Nov 2023 22:04:00 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A6Ld0Zf023638; Mon, 6 Nov 2023 22:03:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u5cd5mf8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Nov 2023 22:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXrAPaJEoGoKlC1gCsQy8mSwtSVmP/FbKbn6q5iuSxq1VTVxb/pxyA/zJWH1LuzMeJ+/EZ3z+zmK3DUx36gJG+97IYPn4AEI+OFD3Erz08CDM1pWFigjGJqmqUQ5qsdnC+Wc9eSPb5gtMd9N85rQJnA83GZgQpjiNDodwd7rIuzjckD0xqiTlzGtwdW9H223nJAupu3WuMA6HNMiksUrdQDQcfU7HS2aZKxDwDlxC5MWddmHAS4MXFUDvZaDiFLxLF83NFSCnohJF78/ktAwruCZwpxWTZU0l0aoHtjsN5ZuATtIIQKK1wsfWlIQx95/CKUBuaTb3GlmO2hmSgN8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBpc7ltGTTryJ17ec//n0X+dvRU2vgCrVl5VDB2SGtA=;
 b=PqsURWqEujd0g7JpXmvNRozMaiaiFcNoJ1V6GhzN1FwZW9BioNeG1vydrz18NUiy382fPg6CoWRPd2K5xuVR9+mMT2fDw8ldZjr0DhWV3ATlrneVxi0A3Brr0XnKZwf+sPjUqzpvCrzE3pUHo/VxIbygCnT3hIGw3LTmx5F10PUQs0Uf63KOZqEsGwvnaYAHbsvmDDPmxMy1ZwEK/xCISlCkAGcxSCYPO7YGhuRYVIzul032fetm9xlIjCoJZrpJS8EH/hVtR13HoPR0soLPkjX8gFPk1huU99Rf++o+F1iB3dojQxb9c4HcrlIDPRArzvq8EJHz5QkeVpc/DWqU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBpc7ltGTTryJ17ec//n0X+dvRU2vgCrVl5VDB2SGtA=;
 b=ajDwpi2c4pnP7jZPdkPiofRlAI5QCRll50p8db4MTNUlaX2+oqSBRDnD+CLaOqPAnpKcmviTYeWxfhDEwHNyWiYJgwaeZNGILPmk2UysfTIsdF1xmN0I4Xuc6Vm/GMsHvGu1iCLXoN5ldLHCGr4B59h8nAYfpNMFjoFYPf+ScTE=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by DM4PR10MB6790.namprd10.prod.outlook.com (2603:10b6:8:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:03:36 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a7ee:d2c9:c03e:6ec2]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a7ee:d2c9:c03e:6ec2%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:03:36 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peterx@redhat.com
Cc: lizhijian@fujitsu.com, pbonzini@redhat.com, quintela@redhat.com,
 leobras@redhat.com, joao.m.martins@oracle.com, lidongchen@tencent.com,
 william.roche@oracle.com
Subject: [PATCH v5 1/2] migration: skip poisoned memory pages on "ram saving"
 phase
Date: Mon,  6 Nov 2023 22:03:18 +0000
Message-Id: <20231106220319.456765-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106220319.456765-1-william.roche@oracle.com>
References: <ZS6ksf8o7dJ8mzUe@x1n>
 <20231106220319.456765-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|DM4PR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 7441a500-a0d3-4bcf-f95f-08dbdf14398c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsv++fTYHyYTTLRQC9zf2vErxm6Pzw4dqoDGX4XihuNbIreFDKmbo5nbEkIxgF/+a93KTVFT477sZXss3iyln8RIBujARk/XDJBI+Dw7Nz0uBHh3NkUf1trjMS1LRL+869i4vlWfs2YV6fzbeMVfqjcFp9v2V1ZFzz/SxZOZNohXzmLVprqoXMOJc91NJOgyAxdFk+f9Ph7ePCj1PgdrhPXzZMuyRaXziaVo+Q4ZQaBekxQPeqg74fl9K6SMMLnKgFBQjV0wBMqSw7W97HBk2hXwo7TaOl+u4OHYAb1+nEvk0NVmd4qHKWz9DsYyt46OLs/hksOEn58CSTaYqu0hlBMwp5CVOlHDDNH8663StJi/st5HVH7WkIOvy7LlaQe8zu1ipfY5t3m7DVuFjHip50/moBdli3Wu1w+RD7CeQjBIOBw7lYOXMVKFxJx0kt5x31RVbuyN53HneoG3jhWbbx1a77mHHfVFdiQjuf6CEUV4EFXgITW6qBK4KwmOPHFeh99/cVSY4VpXEIQZ9Lbgeppp+cd7tOjVFNqjjC0aBw0LR6zK7NadC4gdG3zswb1Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6666004)(6506007)(83380400001)(6512007)(107886003)(1076003)(2616005)(66556008)(2906002)(86362001)(41300700001)(36756003)(5660300002)(8676002)(8936002)(4326008)(66476007)(66946007)(316002)(26005)(478600001)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSuxygaTxVuba35axRYHv8EzAVxbTwniJcW4h5cH2ntxYH7GMUgRdGbMVVQy?=
 =?us-ascii?Q?gVbJE3KQXM6578pzIPraV6LFPUK7kPZpzRa8LRXNlSqcY8ANzBmwEL8A8GGy?=
 =?us-ascii?Q?+G6Lzz+Xo1qz22ZpbUx3i+/E/v28rJkJ9bjScXUcpxS3ml/N4HaBD/z2ZCmv?=
 =?us-ascii?Q?0FKYY3s2Al72V/9lqdRw5SJfttaKZDhpqPqPeWG3G7NTn55rl8kUb2+nEXqr?=
 =?us-ascii?Q?A8PWwpkVpllnzVXfUSIlTRPGY29GBAwVl6ROp1W4VBH4VJpmWQFoFFSNgQr5?=
 =?us-ascii?Q?ERyld1FRiKzAapbXGdTexnLHMJpdsPtteEMjZvQLQuigsnUmQFc9NeGjrl1G?=
 =?us-ascii?Q?MB09m1eQijXq4t2mnpCTivb4tNagEAkTqmRGA14Cj1zesg9pc1XoEhbMNuDY?=
 =?us-ascii?Q?/dY3m5xoEEj1QBqkCjpbSagLnAPVh9jtBNiuGZLIeKGM4nsUvzlMHdxB2t4o?=
 =?us-ascii?Q?x+2y9pKPSs27LB9wWuaiXmGRerf294SWZ9fNBUwFL35ZOv4wmE9FxRIV7NDX?=
 =?us-ascii?Q?pJS4XUVA07hkK22hTm21OEQlSIVn5JJpA72VNmqLTYvksPLBcEgX601CMDxl?=
 =?us-ascii?Q?YtF1vvxwhkzMBHpDeDHy/q00r2E6h05kv8vB2zuyRWQrGpSw0S2225PZeMea?=
 =?us-ascii?Q?lRdMNd1U0XLLAJjhmyxuQTZwBtywZ2IZxny3sN4E7qLPR15NkoD9iOqFfc0A?=
 =?us-ascii?Q?hSMOpcaEyudlP0HbV03X63HugNnsU56Myl1h6DGjN+BtynDOh42Na7bfSEBj?=
 =?us-ascii?Q?BZffTM0uhr3yJDvWta6nPF1Hz1fm6L50L0nPLpn0S5tD/OcV7S31gtu82wPJ?=
 =?us-ascii?Q?Co5vYhP2p4+vreeAqQ6A78PletdC+ZD5g+yaUaqtHKu6OAEmR/eZzmfVKesp?=
 =?us-ascii?Q?rFDE1h5p0GHbbC69xlpi54QhOGO9aVJhtiophGMFxhd0GNa7sYP1HA6qeA4m?=
 =?us-ascii?Q?B5BLqaIC2s1779qsm9LjzlGD5kq9eT8lW2yig8CFDGwCtAGs1IYgD5DanQ9l?=
 =?us-ascii?Q?rhEarxy2YJ9RZeibvm0bnopTnEMpE3xhSB4EmoPM4lu1nw4uA3lRSlK4EOga?=
 =?us-ascii?Q?NU1qsE/a7Earq4xLa4Ouhylep+VZndCE4gOsz9/mZR7rYJ0t6UaGX86Leh1q?=
 =?us-ascii?Q?ZD4hWkMviCT1h6gm9yJELZsvDlrMgc13OHNNC1EwZrvmh5gxuHYPrVb60cQH?=
 =?us-ascii?Q?t2mwvELuDb8VLY8f6I/t+wLabDtsJzd8k6XXz1OwDH64Q8o0TNC56f77DUOj?=
 =?us-ascii?Q?lec18o/BSLKAn0545gzN7Q8bgRZhqVCvBAJzxpxD1BgH0hCJ2czXcSg7RMXx?=
 =?us-ascii?Q?sEmxVlDGo6e0Ka+aB8T7PDhXYqV35qSFf4OtD36gur3QdS8LkvWe8/Ab0gff?=
 =?us-ascii?Q?S6DF+dR9uw/+OWv6oz+t5e4Z7d84AAi23rKMdFwNh1cn08Mro9D4IiU/nYWN?=
 =?us-ascii?Q?Ja7bn9XJemR8xdc4Reai5M5Bk4T4CyoyJ5eXyJSAKxChEr8HpiomczRdgDjI?=
 =?us-ascii?Q?rNyV/1yWClg4uEcq+QdGnV4/1sewtoMdrhxnvKI6+wlaM5XYLzK4unbpbeKm?=
 =?us-ascii?Q?qYMQZDKJlheYyHQRcnullr6NxxOhJm6HaDLxXOIDBStbbrwT1kkyKECKoYrY?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ptf8uNsi4cMVWnY7cPeVBVnxMeQV63TGqxUWAhqiXrh7ITrMUnToVJ3FmM2n7KGw9Tl0v31TX55omgvzUaeHSwq+us7/FRn0/GKihCEe7HdNyO7HALveqEqaJkloAj+pruUBwiJ531j4nzEpLjaKlP/HHzNWxuUqPyJ7fEVM7AJcFa3rYe+J6Z7b5xJm3Sx/pfZpxHR37ky3+d2s01VpSAGfNWbd7qPh2vAheVAGXo/LaMouzET9ZTsVj4ZrTpA3z8VY/HhHG854DdJa3LgusU/ZVEHbFhmbP6EAW+yfV3FJvkfiz9FVrI326WxPOmo7D9JdQTMQyMjw7TpLwiB2Ockhx6cYjllWgobwVeOfbjr3DPi9W8Shl6KSviOwb+OR24mFRLsk8oUkebUNgY3vgkMhnWBwnVp1shaLtjHpQbN50qtcw6bNtnsGvR/bNNB61R3/Bz2e55WkChmeOnmPDN/yy9+Ktk9Y2ulkmitkIzGKojhUFUryX+3k7Zi31UVXK9oY+bkdpp8WtXnGl46dhLbna1ACPgWAHTz3eQ17lyO4U6+EDTEwW8pA9wkCSLJs7J7Erx3nmGmbRUk33xNsvIJaxqflYttpUbfhDkF0zJrr7/cGHd3ZRDR2iSnzWgDDTtP7RDdA3ObgkLrfgC+U646SZ5PbQXlPUmg8LQWAQaE2+Tuj3ZIP9JeK0D9frfwcJIAOwDTm/xkQ8ioyYVD6WFTCIniX7JNFZHC1eoFYbysRNOB8Np0r4Z1csxiVobWFgKeUYS0pxg4BW910pP/0UmXbBT0EKpDxft3t4vEhPO7bQQwUGuCCWmUmsGNKAnwiUV5uyYKr8IKVYYFE0hVHw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7441a500-a0d3-4bcf-f95f-08dbdf14398c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:03:36.2131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSt1cSye3GbiIqyqBQ8MU2x+YabGIXK7ET5u3aUNv3HbhacIchLYzLPlP95JKb+mFGB8kiH5pTpX+zO38FoOJh8bW1hPgsf0gJBI1239YOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060181
X-Proofpoint-ORIG-GUID: 7ZRQnjWNHY0e1Oh0tBRhevtzcavI392S
X-Proofpoint-GUID: 7ZRQnjWNHY0e1Oh0tBRhevtzcavI392S
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
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
#4  save_zero_page
#5  ram_save_target_page_legacy
#6  ram_save_host_page
#7  ram_find_and_save_block
#8  ram_save_iterate
#9  qemu_savevm_state_iterate
#10 migration_iteration_run
#11 migration_thread
#12 qemu_thread_start

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
index e39a810a4e..64c0b37823 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1149,6 +1149,20 @@ static void kvm_unpoison_all(void *param)
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
index 1b37d9a302..17774fa5ef 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -124,3 +124,8 @@ uint32_t kvm_dirty_ring_size(void)
 {
     return 0;
 }
+
+bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr)
+{
+    return false;
+}
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 80b69d88f6..66937f9dfe 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -539,4 +539,14 @@ bool kvm_arch_cpu_check_are_resettable(void);
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
index fa4388f6a6..a7772a08a2 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -35,6 +35,7 @@
 #include "qemu/stats64.h"
 #include "migration.h"
 #include "options.h"
+#include "ram.h"
 #include "io/channel-null.h"
 #include "exec/target_page.h"
 #include "exec/ramblock.h"
@@ -214,7 +215,7 @@ static CompressResult do_compress_ram_page(QEMUFile *f, z_stream *stream,
 
     assert(qemu_file_buffer_empty(f));
 
-    if (buffer_is_zero(p, page_size)) {
+    if (migration_buffer_is_zero(block, offset, page_size)) {
         return RES_ZEROPAGE;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 8c7886ab79..5fd4d27854 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1107,6 +1107,26 @@ void ram_release_page(const char *rbname, uint64_t offset)
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
  * save_zero_page: send the zero page to the stream
  *
@@ -1119,11 +1139,10 @@ void ram_release_page(const char *rbname, uint64_t offset)
 static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
                           ram_addr_t offset)
 {
-    uint8_t *p = pss->block->host + offset;
     QEMUFile *file = pss->pss_channel;
     int len = 0;
 
-    if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
+    if (!migration_buffer_is_zero(pss->block, offset, TARGET_PAGE_SIZE)) {
         return 0;
     }
 
@@ -1154,6 +1173,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
  *        > 0 - number of pages written
  *
  * Return true if the pages has been saved, otherwise false is returned.
+ * TODO: hwpoison pages fail RDMA migration, should be handled.
  */
 static bool control_save_page(PageSearchStatus *pss,
                               ram_addr_t offset, int *pages)
diff --git a/migration/ram.h b/migration/ram.h
index 9b937a446b..d34ba79d36 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -65,6 +65,8 @@ void ram_handle_zero(void *host, uint64_t size);
 void ram_transferred_add(uint64_t bytes);
 void ram_release_page(const char *rbname, uint64_t offset);
 
+bool migration_buffer_is_zero(RAMBlock *block, ram_addr_t offset, size_t len);
+
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
-- 
2.39.3


