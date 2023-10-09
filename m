Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E567F7BE30D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNp-00040C-0E; Mon, 09 Oct 2023 10:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNa-0003qc-3u
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNY-000388-Ls
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:05 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399DaBN7001999; Mon, 9 Oct 2023 07:37:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=oRryHDDogfIGs6ux2dgBolOpYfIp3H9lPy70JbXBM
 hs=; b=e8bSyPPg/KpEa89dSWTIz656LpPWsZPIAGTA0ENrDePA5qwE+vLoTX8JM
 4Jvaf1advM+ctICdE+6VRkaPTyAdTG6CMaYN5eMV2F7onVUNuBXFgVqMR/AFw8/P
 5hEaoqldN7NE0LPUx6IOwJmiKJMVe/zG/cE+hqqzAeGDdfT5rFSsdfeX7FgmuJik
 ctLf+Egn6Sj19PSuYWi/6FO+AUscx1t/G7U7zExh6V33+dnKzPjs2gwG5SgK50vK
 O77Wp3mHjPmqVB5VohKmsarnSiFNXUNnO8CqxoOQ/GhFvoxgQKC2XFu3Pyi3Z8Jt
 I1f6QRHxU4dHhN8v9v/qanuIjZtug==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv02tm8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUOAj5OxUxU8nrCOjeJcryFGPGLN/O9ZF4H8bn0VxmeIixruJiM57o8psWZFPUArRNeLeabAhifruH1f5qAuwFV1iTUbHxWSXk69q6K2BdYN8cXkJYf/W1s6qBUdHFCDOL+rw9o7q8Ze0afM8rJMA2BpC/nfGXGXBqCHD2NeFbeINn742MkdbILRpGSK2QWfLvnHniYz7Hx4WllL6ddL/eGN+L2+4qZ2TXPpP1FDENbywfwb2YojgAijYPj4jCcD8j9nlJHt4IHOP2x7VFPPlnonSU0cvpWqCYhTvPiu5qn765OKejLhpVF78MPR4oOlU6kj33oV/hnyb0zxgzwSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRryHDDogfIGs6ux2dgBolOpYfIp3H9lPy70JbXBMhs=;
 b=JS2qsSS/nlq6eRuAh/GDmrGLuYbHrsjEti0mQrHSYvyjGAc3J+RQPLJ/CLg213VX4s+uscp3XswEZZPmh0ZFCmzVQ6a/iZKYRXTpp4xG/JudKd1xotr/rpHj7m+3ekYd/+cODlXUs5vT5oyKLgloonMMox7HCOjvbWxbJovVNhorxkmZ0o0zRYgfU4u0GPZDcdc9kAefyHDEa2Rv/XYrNNFCsnc1iRvNbO4n+3OU4NKJjDmrmkZ6uZ+lW54wTXE6VSnAHX9k7fRPBcIVZ7mm0DUnGXBDgDbB3bR8cdvAWqRZiH9QX3Mf1HwWooljcWgutKj3lM9NOX+ClzEP93FTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRryHDDogfIGs6ux2dgBolOpYfIp3H9lPy70JbXBMhs=;
 b=krz43n0ub/Ok5IlTvueDtLFBTEPPW01EWHhPOdZfTemAluXO0c+zRO1CVJXcFirJ/Nsp6NvYSG3GdbmQ0V0vX/s/SZmTUdA6Cllm41DLZpPBNVcz5NkLcwD6tNwvdXCJ71KnfAdXIMhHtYWkYTT1egtr+JNVFK4o+gjRp69fD/BnUA/eME/bXc2+kovI9t9rXn3z+njinQVUMrJsS1V0ulQ8XkMG18HiJcoxUDS6ZJJSNSdHayEd7MrO4Zq29CGwDBVp0P8ejS/Q42tCw0ftyjjAUvj++67MD+XPcA0X4AzpX75zuw3v9+lZl3UsyvU1snrQuti33QvpsLv80096oA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB7888.namprd02.prod.outlook.com (2603:10b6:408:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:37:01 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:37:01 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 10/10] migration: modify test_multifd_tcp_none() to use
 new QAPI syntax.
Date: Mon,  9 Oct 2023 14:36:15 +0000
Message-Id: <20231009143615.86825-11-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231009143615.86825-1-het.gala@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BN0PR02MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b4692d-6d5c-42ef-81dd-08dbc8d53306
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiBIyK3APyVkIGiJxwLLUqneCpIOnzZI/k56wWw5vGpv2uXPbE0o4+7xwxZaJs0tX5LkodQbMkwBK7W3TW5tFFGv7dZK9SEThoqejKydjZFH61sQvLZKIr+QAMk05Lk8N0ql1gOdaDDCW+jeie87eeUJkE30a4fjNWhyWHGjvEPmLMuqHMbRSK+C38XdkKLoIfYQnoJ4BID/DeBTbZNMntEFBq6eSx0fKNWzNBmtH8NR5gyN76wWXF0IkFjF5kDfggQlL+PtplhV7I/kBWCdkTLIayj8hRkdpt/BiXPp7iB1OchJtFVvFzv9CgMPc0cdCiR0ME12pOeO6BntnVBVxydn7iJoB4aQwyWmt/j4XvikZZVx6o01iXF3m0yo5l7FxskVVAOyT0mt+SCKyvmku7TTrMd5a+332gfI0JEGaRzetLVICrMiBRV6LDlhvDxUerxr0BHhbYpqS1ov4wa8rm3xW53foKCykBcRAINkeClLDho/iIic6RPXBddu2U87PnfSt3fpUurZv4qB0v/2G+Vuxb5UeJiPBVq/HQwII8Me3NRNzsSZf8htBQxLCkI5tKj/5QPj2GuEj56OJe0TcpF+Wr75aYoL1GULGnZn9UBS5GzxruaN3Z0FEKd2Yu2W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(1076003)(52116002)(26005)(2616005)(38350700002)(38100700002)(86362001)(36756003)(107886003)(83380400001)(4744005)(6506007)(2906002)(4326008)(478600001)(6512007)(8676002)(6666004)(44832011)(5660300002)(6486002)(41300700001)(8936002)(6916009)(316002)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dtShxeLk5dP3OX4a95aEOPv/+wXE0HFHI8saCZyVX6fIo+En3akJFrPriVH8?=
 =?us-ascii?Q?1UYSdMhhw90uVUY4FgavwKAZP6mCDZjLCcOkMU2C/CIF/bZySMthnQXm4IsF?=
 =?us-ascii?Q?4wBYWMqbVS6KsR5bQcFFCgH4yga9Q7yDlD76XlWwL8K7WVZBMFOStfh5b/j7?=
 =?us-ascii?Q?2UJEfEnD58+XAzDbcQhI9Q7PXYq0n1Hdg7UAnQ3c2NX+ET+7KRZA8P6AzGjL?=
 =?us-ascii?Q?fzf8xIV79sFbFezJjaqujnI2GiCh/itVFsU7dM2wCPTkt1VZnpKX5gs6iZn6?=
 =?us-ascii?Q?YelQkrZbQ4Yugrt1we9BWdyJpQS+Nw9Pz6WJDKzjEXCUSlpUVnUNYHnLKuzh?=
 =?us-ascii?Q?yyLukppv3b9Fcg/OJx7vUDzMRoHmTYau/SnP/4tyMMWmHIezT/rR4hTeYmZa?=
 =?us-ascii?Q?DUJn52jiSnT/YaK/rEffn3wEfySvNfkAAYC9WJ13VvA+CA2Z7WwooHoIkVAt?=
 =?us-ascii?Q?D7MSmyxPiyrCGC3lOK7FXKEAFZTMHE87gzO5QbjY/p3UrD05q+Cl4Ceh55rR?=
 =?us-ascii?Q?fqur4khahQrKlU0pqqBzQoXpS8dVMz8kztttrzFfLxPqkWhfvUFW1c4TW4yb?=
 =?us-ascii?Q?LhqFLAeJCQl5HWiQryC3caD3qCQA7D6EZnKJc6VH4mSNilKI9NXb71rpBgua?=
 =?us-ascii?Q?FbI2NsAymuCUBg4PSM+V+U9+dRf9/FUk5s8mjQc2UMGVLllig0S3ttLAN8HM?=
 =?us-ascii?Q?8e8tDfFHF9L4Qh/dClcLaMMDWl0qW38/wVpgjDglzNKTVFSh8aExBfO/CiCg?=
 =?us-ascii?Q?uB78zNorn7CTx9uIkh2GZ+cWWhD4nzNTxk5TZ1dkDL/sMOr34v9cTM57bOg+?=
 =?us-ascii?Q?zKhSGrpFuzY8ZiGJ5ClXLdcTV+OJDY21BHGLVArnqEfR7qtVrOnFvMnkkamd?=
 =?us-ascii?Q?1gyG1/Ux2S4PIlOi8YjZM7+iY+FrhzQswqMOkOtiqvrE0uu3Lbm3Qed/KAGz?=
 =?us-ascii?Q?oyFIFg1extDZTErBP03oAN+/0hOOWVIXuXV3wSyd+ccwSEdOZ89GGUtFZRO8?=
 =?us-ascii?Q?ap1aBn7etiVI8QUYOQYWTT4ZSgU4tujske04mqnDEqVafkuVFC9m/qo5K4UN?=
 =?us-ascii?Q?u4OVvyU8gjsi9Fg4Jm+vNaYyJhJLb1Fwa5pmWmCRx0lrj2SghHaLYdiDYeVs?=
 =?us-ascii?Q?FGRFhacizMTohIUxsq0uX6M7FNHPqI0lZUx/ryZ7awrZRfPZ51+DDZmSSOhr?=
 =?us-ascii?Q?/9+wAijSrbVunPtfSVKAL7CWgLLPH3wv91FBaBKS2lV/6TZHCzV0LLPDGzzb?=
 =?us-ascii?Q?D8x9FDsoRY05PLgjgJhd6dsafSegKN+J6tan2kaktJTn3zPpC3ZmExyml8Kp?=
 =?us-ascii?Q?YtVAe/wiBVxysyl2nd3tgWDYV334600zTMC6qVFK3xYd70gq44Iwf32GW1Re?=
 =?us-ascii?Q?7aLCj8yPLIp6oTrV5ZMCJbEkg3HNhxJf3fC/Kgq0fgYVUhDYZOb4Pjywdscz?=
 =?us-ascii?Q?f4/1q4imeqe+DqhxO2LEFN5tjO71ZWxQoz0XXVXHIrqA1Nprx5eWz929Hu4L?=
 =?us-ascii?Q?l+4W1rXf/rDhDtYcUS7sjQEZwhn8Kf0hSmFvdm68+qL2LdVYfQqXQwXLzBXp?=
 =?us-ascii?Q?hVvpSevfj+HsmDKlgtwzTb6vWCJ7IlzGv+QTOnwby74h+w+J1xGkwdOcCi94?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b4692d-6d5c-42ef-81dd-08dbc8d53306
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:37:01.4058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09h5rJi2kOSetLuGgTnWglGT5ezohpAPUDtHW+kinNrXjEyb6lSVx9NbimwH+TGq8yYj4jLsyPdPe07YKwyQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7888
X-Proofpoint-ORIG-GUID: SWPsBW3rPsmhFYMN-lPinAic35WtyADm
X-Proofpoint-GUID: SWPsBW3rPsmhFYMN-lPinAic35WtyADm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

modify multifd tcp common test to incorporate the new QAPI
syntax defined.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 46f1c275a2..7a72e1ef03 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2205,7 +2205,12 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
 
     /* Start incoming migration from the 1st socket */
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+                             "  'arguments': { "
+                             "      'channels': [ { 'channel-type': 'main',"
+                             "      'addr': { 'transport': 'socket',"
+                             "                'type': 'inet',"
+                             "                'host': '127.0.0.1',"
+                             "                'port': '0' } } ] } }");
 
     return NULL;
 }
-- 
2.22.3


