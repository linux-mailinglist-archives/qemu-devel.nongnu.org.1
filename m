Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB982D3AC
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:35:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPEgi-0002Fl-2o; Sun, 14 Jan 2024 23:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1744ec9a4b=bin.meng@windriver.com>)
 id 1rPEgf-0002Ex-SC; Sun, 14 Jan 2024 23:35:01 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1744ec9a4b=bin.meng@windriver.com>)
 id 1rPEgd-00031d-Mp; Sun, 14 Jan 2024 23:35:01 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F3uicm001931; Sun, 14 Jan 2024 20:34:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 PPS06212021; bh=/OEbbsO5755uJNTmelN4zLikb8E9MCrDj4Je6MuJ2HU=; b=
 n9fj3AdYPdVMVn4XR02tFPYvBAR4Yl+QFk4p/hjP05jvv7BS/S5O2Q67RDtU+38I
 RWSKNafGnybwbV4tID6rGBGo9px+kbxmN2RPGnU1uVYilEPvcT/wkMinlW+R3iKR
 iDI6es2o9k90VkTa3J07guaEByi8ARxeOKXeFxSBj0MGwCwGoNL7EePCYZ/O09/o
 q2NbHfupQJu5nJqe9Zz8gWjfKsyrFkfQslqEFuei8EDTgvjO2uaWB2Slz2xMCPfD
 msamlTBtStIw60YdIpdWnKjLn8fV+BjrvdojEdYHrrwtqpij0lcwr5IQvXt6fOC5
 QGXaIxc6b5lGlOJGzwioeA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vkpp41cyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 14 Jan 2024 20:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiyzbU5jM8i7AtK/4QokINWBcz99XoLY/rLwBYGfdSNTE66a8DGYwGCn17s2W634GO72Pg48inWJ2ySCd+DdlhGM1AaeTAkZ+WLgf0oiY+QaT1FJ1uo5KcKpVJ/qsESvGrHMNqmMySYNcN9d9wg3echtwEnMmA3FFA8JucEfCLfP3QadkO9moqOLtcvrWr1TBRT4S/zsAPYr+hzLiDt5yuLbrakTnIJaW6yElvH6mLE4jEe9CRHzlIJcE9HqbiEoiUoAvZSLCfo1kIlCK3bL4Bkz8ErPyXKJwzoX2gBjARXQe9e79DU9yI1SmswHRr0dYx8SxUViGM7eQHh9DqqPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OEbbsO5755uJNTmelN4zLikb8E9MCrDj4Je6MuJ2HU=;
 b=VUbd5dwyCdtFrTnY/SmoPYuZl+TjcIWBBp0JJdXaLYxUx1frPsd0bwo1yIkdyjZMRS+48jKTr5IH0tMw2RJQeB8goZb9abvfhRtVNMZ1ZN3Jv4l4GOW67DngRwFNAIK6C8kJcWUQNRR3AUglbqnEPf0IiZu22pp0h3T1XxaV3NSzhyRC7FNqKe3miKb85uyW2Rvh398uVUfcy/ceitM2Dl32UuLezHPdJGZtsv0TCz0jP9CVGP00fzM5M1b9+gmo8ApieltKkeaoBXrdI53gJrpOA1rd8v7NvdLBC5wyQiiIZ2MiR1E8snqRndmSaeDYOO+d0fvw2Ga7YZ7mT17wHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) by
 CY8PR11MB6891.namprd11.prod.outlook.com (2603:10b6:930:5c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Mon, 15 Jan 2024 04:34:53 +0000
Received: from DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c]) by DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c%6]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 04:34:53 +0000
From: Bin Meng <bin.meng@windriver.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 2/3] hw/arm: Pack the QEMU generated device tree
Date: Mon, 15 Jan 2024 12:34:29 +0800
Message-Id: <20240115043431.3900922-3-bin.meng@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115043431.3900922-1-bin.meng@windriver.com>
References: <20240115043431.3900922-1-bin.meng@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DM4PR11MB5358.namprd11.prod.outlook.com
 (2603:10b6:5:395::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5358:EE_|CY8PR11MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ebdda0-ff01-47f9-8b3c-08dc1583514e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWFLkE/VolNCGTL9u3LPmBQ30LbTUV6WCu1LH7QV0JcwfaoEG6e16wKIEZs32m/LM6MXIPjbcLn5qdWGw7XLghQQacYkQ7gIvVce8jS06wHtSG/oomQwq/+nYKYdJgi1yZsxpeyD/jwt+faj+F4a0FZwm3nYoJxPQH68oerfSgmUr2/QSGc79m0rTF4DxeAarD9H+aIhjVY0kd7hM8q7k3PclL2dy1QvHOsxdU0XNVuZJvgtGNL2q7MidsmCbd/SY69QEFp8TsmDvCpE+GC3JZUk6rMIgzD64VRDrHpWxxw53OtdpLvOGuL5leJByHJ7tfRC2JUUAlGO2dreEqeFO3DNFmg9EuJbxVI7Yj9Y6OvMomsDm5S50LuZWziejKxmsvCqrN0NG2HmhQMLLy21hVppPAiujh80HbXb5zvDYMGT9f0H/PgClMuXU4+n782T+dpHr9lRDWKxc2jbmW4+EVCYiqp2FFVPUm/+t1GpOKCodsbwfnR9uyv+DW/utppcmDJrxbH9qlp+xlYOJRRqlGkuNMw0BH0Z4g8McmEEtz/28jU7V3G0Db0fBf9tfJ4gnB/c8Pg1B7uHRzXQW4LAw5witfDYjOCL8PHXkJr2C7PY53aeRhOOKzr3/Yw30GYr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39840400004)(396003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66476007)(66946007)(66556008)(6916009)(44832011)(36756003)(8936002)(8676002)(316002)(38100700002)(6512007)(4326008)(6486002)(38350700005)(2906002)(4744005)(5660300002)(41300700001)(86362001)(478600001)(26005)(2616005)(1076003)(52116002)(6506007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJOrM/m7AvV5ATBtOluEAvf0Mm7b3nGBLjMxGHJFwBL7M4vC0saaeuDiGdVl?=
 =?us-ascii?Q?eY0Ckln3dJlrfagqkDV4NjgDZkw7TEW+A7zrENjCJmVUr0V3eIwVyYUj+V7g?=
 =?us-ascii?Q?iBRJs09+xb+bAjkmWnLPPMW6g3/GwqFjXfAXHtPT+ioVXbIWtGxjS/gBusoD?=
 =?us-ascii?Q?8hOy9HI8iJ6Lg4BfNR1IsRX9xCOc5MhXNDpLrP4GetqCBuAeIiPTIVcD4rwZ?=
 =?us-ascii?Q?hARefQamGeOSzM+DSe+spjB/yONn1DJHD2/dzYYpxISNdXDl7ovqTtrZNjop?=
 =?us-ascii?Q?71DF4wpkXi5MVKktABGNfi7jF0KY83vEKtMN+CMEk8diuxiypQNBwrCtXqNJ?=
 =?us-ascii?Q?W9I3xsTqP5Epxm8un04aejOR2S0RhnZooHcMdccdfbTDZ/2KK41XcH7EY09U?=
 =?us-ascii?Q?E3dbRFp/FOZZRB7r91hSek3CWpIr4PSSs2NoPIvtKB0oC27JddGB3prgW/2K?=
 =?us-ascii?Q?t5NV9AwnOrop/o7V8yqt/wK2vkKbWJhQ7TN84Cwy0zJcWWMQqo1+z0NPV+fS?=
 =?us-ascii?Q?WUlt2IY+ak9cl6oIkTkDMLJdcGcAHoK+PjdDMLggP/xEAO7SvrgKnNYZUrBd?=
 =?us-ascii?Q?gwnzXVYuls7Gw/YT1CTeg24amXzyZFCpk0/cDN9xSyz+NOlD4V90AmyTJTpv?=
 =?us-ascii?Q?O/h8AdmKgM6zbTY0ZInOTYQCviCL/Dbn14BKlef1M2gOe0tZvYK0RdSHSfKZ?=
 =?us-ascii?Q?n0PdqH3XOqKxeF4FPn62XryU3HxggJOKF+a28znienDavI6aMTxsYhigC9ba?=
 =?us-ascii?Q?C6hD0jHwQT6ZEbEfs7+66jxc/XK3YvFjwVlZn//o9xOMwCMCvfz+VJNIpia/?=
 =?us-ascii?Q?vvBF/L0OEoZECfbvwPF6ji5p52swEOV1wtmxKRKFgodPKys9HxtC02ZZHjJx?=
 =?us-ascii?Q?GxEqDsPigM/up+4Zh2JumvDU6FxtfnEALx2SDDgSnGp2s1LzksZhGejpatXk?=
 =?us-ascii?Q?ZMBHljEnUPZckinUG8u9VLdsudsaFCWK958R9mpVyefqH5uQ/ssRT8hGIjGY?=
 =?us-ascii?Q?6ujtlnepf8usdBJyoFSucYoIlM+Vqqd8EwctsFBRJE6ZWD4TKDa0iY32azme?=
 =?us-ascii?Q?VDY9Y9IG+vhwAOt1V4nWqI41SEQX+tRTstZmjxHWS09rGbd2ERqqN4KyYvwA?=
 =?us-ascii?Q?Qorv0CzfCMSHnxQ5NQ0Nv8NRqxacj0xVVPwX22h6+pW6hG9eBH5S68di/+4X?=
 =?us-ascii?Q?Tqz7r0ehjXmGe4pRpXId5m4A+fFZfCNmvU7/hrrs3HtVPF91Y5YsfctJZhWp?=
 =?us-ascii?Q?eT2JQK7jQoXVHTn9DGiWlnzPP3PsiIh25alfdPIPIoAxER30fWI5g+RTIgsK?=
 =?us-ascii?Q?k/kz5jsUjUM7FqDCy6rsma9EjeI21LoI/cpx3R4yWYxKcSoAAFCkd9z4a41F?=
 =?us-ascii?Q?wIZZP7HTKfQxICI52bRJPJjncYG5v7v4BPBUipIqXnJDEb3U3gHQwR6SyUa3?=
 =?us-ascii?Q?SvgiIdZQSoK/PZUov5wToBWvy2bQhB/AvMA/VCv0czhxSPmFSMAUuVMwaX85?=
 =?us-ascii?Q?rqDPREZNAg0jAIKl0ZMAosyVjfnrl5OTBSsXyxc8CSr6a70/PZhrda1xTiqJ?=
 =?us-ascii?Q?azmiMoODr7KV5u3mWKtk3WuI3lTCyYWHYqHNkaMJ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ebdda0-ff01-47f9-8b3c-08dc1583514e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 04:34:53.1323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zKjK26MxWd1IV8kr+2Y9rArIhUXLmHZGtII707JVOp5SOR5wpcnnPyTrRDzg5bElDjrv+jPvBwwTPacrtFcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6891
X-Proofpoint-GUID: W4dR0ncHVUWVMTzOD1vRbuUOderMu-gM
X-Proofpoint-ORIG-GUID: W4dR0ncHVUWVMTzOD1vRbuUOderMu-gM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=786 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150033
Received-SPF: pass client-ip=205.220.166.238;
 envelope-from=prvs=1744ec9a4b=bin.meng@windriver.com;
 helo=mx0a-0064b401.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

By default QEMU generates a 1 MiB sized device tree. Let's pack it
to save some room.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/arm/boot.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ff1173299f..511ec10ed0 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -662,6 +662,17 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         binfo->modify_dtb(binfo, fdt);
     }
 
+    /*
+     * By default QEMU generates a 1 MiB sized device tree.
+     * Let's pack it to save some room.
+     */
+    if (binfo->get_dtb) {
+        rc = fdt_pack(fdt);
+        /* Should only fail if we've built a corrupted tree */
+        g_assert(rc == 0);
+        size = fdt_totalsize(fdt);
+    }
+
     qemu_fdt_dumpdtb(fdt, size);
 
     /* Put the DTB into the memory map as a ROM image: this will ensure
-- 
2.34.1


