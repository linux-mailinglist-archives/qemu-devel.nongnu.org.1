Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596AF82D3AA
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:35:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPEgl-0002I9-Cl; Sun, 14 Jan 2024 23:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1744ec9a4b=bin.meng@windriver.com>)
 id 1rPEgh-0002Fm-9E
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:35:03 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1744ec9a4b=bin.meng@windriver.com>)
 id 1rPEgd-00031e-R9
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:35:03 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F4N24J031405
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 20:34:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 PPS06212021; bh=/RpjOSgsSCErYe6CtkQb+veSuq2QyWJoppz8P5r9/PA=; b=
 KXWXxh6gcC8tThM1H/7FNoq59Ls6gdIlPBk/D7rtbVwZQHr1plDYP3W/cGmg15FY
 Rt21z8Hk5Be3GiGMvDQteS7ne1ON9x8gQqx5aau1IlC29afvxsjLDBtHCka8RNGy
 /GU5/ptUpHIRY3/CjHGMEeXwcysrGrbRWRdnlASfo3ZrKNT8p0iEon/TO3yKTyYb
 LWkZS+92zEraKg6X/9hSGsghcr5shaANzycm7tyy0/LDS2WuP0egvck1ct7WHX3L
 5rnFqXQn8T+cAS0rZnlaHaaj9eDoTbCOX1Sy+2Kkc21vScd4Ocaa1lXGNePY2MZi
 9DuoMrL5W2z3VfkJu5fCJg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vkpp41cyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 20:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL9b0nVRsmmasg8bAZ/vyFF8OQY4VK2KYszafzU0AgSeeCnAXN78YWNgAxrJ/NJgxAz+C8LJ5KLmmd9krQfpspFFvZRqFarq39mLN3bSQdujLVmbxCKP08T2BhUniUADoNXE8v2WXuNm/0QB11jr3E5xWpoO8u0vKfF0tkhKYtURfYKudtxMOXHyUOBOUHTUmPIMQOz+HranZcFzEzbUMWGCFJjQ2u1mD8RnXx9hxAEX8617U0bIeJRBNk/FM/CoiZcdjpNBEq0l30TJOFOVgPv32nHQvJ4hZyp84JEfZ01TPT34fXQXRpzwJs6KrpmdQ5uatJKnIhoDH/Wn9Y6u/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RpjOSgsSCErYe6CtkQb+veSuq2QyWJoppz8P5r9/PA=;
 b=TXIYbTkvGBYy0XO5GZPbwcFOWPjoYfBTQHwxCR/KMzRklQwHpwc4N/CZJ0UktmVaZd3eQBhHzSTqwtU+5PdrNSYTe91hcKMFguEPloRzGJmh0NNYn/Z7TFVV54DoTugDfTEh7pxKdZcWTorKTFxGtfoM+oHWz4iqGCJxHj0zD5mYooAgN+r3OAAahTZy35Lk9y57PNWkTWQgGcLRGm4Yo54a9jPVTNusWK7/tO/bCJntmk7c6yjfjKn5ldNnM0de7EjmDawo4u1kzOZ0YlpVzZvqNMbhWVS5p+Hv0af+uCstel5BUFT1e6IOt4cq28eFrAZWUd0MRiSCvK3bz0UM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) by
 CY8PR11MB6891.namprd11.prod.outlook.com (2603:10b6:930:5c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Mon, 15 Jan 2024 04:34:54 +0000
Received: from DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c]) by DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c%6]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 04:34:54 +0000
From: Bin Meng <bin.meng@windriver.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/acpi: Update virt/SSDT.memhp
Date: Mon, 15 Jan 2024 12:34:30 +0800
Message-Id: <20240115043431.3900922-4-bin.meng@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1db6253b-6223-4b25-5b9a-08dc1583521f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhPPrRGkiTHrX/auktZnejIRDJZ978LzUk/0K7ElYDCHQD9i1YLL+r7Ng+XBnANF5Ivq9h0kp49T2/KH/mFgWz9+FVclUWg0pupowY2JZ+7Xm6pTflSBLYlYmgoUjsv39H9ErW30/6knA5i1jb6ZzOXzlGNFDAPDgmS0T1jhLg110PnzVlkVWXVNBPlJDLq+zQbS/bij9RZwSQ9nzP6eP9wdSZ5O5pk4b1rg3CItWqyGd+Po96O2/Wat2+PCL6rs8KpYMq8HjuWwMV2gBf8ETqCef1XhX1ozKvJQDpg1k4SI2BqAFexYFA1dIFphv+65pESRUNYUw0bo6fvv0Elcogj9/VAxRxeUFeY6ICQ0SV1doBdjzH2XXTi8k22o/JWwJBV3jQYPcU807GF+fcxvgCHN792MJhMzKi45AQuvgrD39SVf9PQrxcduIunq6wOu4a5+lwA/TdcP4odDsnXFKXa62B1v2+r2DSKpQjI4AzigSqG9D1/4llcY5mSpE6E7uWOpxcUvib/OPYpdAqHeP6uXUsFqmWh4Us3+CpWiizXpO7ljp1XGEsxWWUATxNf5jPFHWOZxIDe6oHIxqwJEN+Y28/W1qGfjLljI02vSi2N4sCy46zzsrzNy0XEm/feS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39840400004)(396003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66476007)(66946007)(66556008)(6916009)(44832011)(36756003)(8936002)(8676002)(316002)(38100700002)(6512007)(6486002)(38350700005)(2906002)(4744005)(5660300002)(83380400001)(41300700001)(86362001)(478600001)(26005)(2616005)(1076003)(52116002)(6506007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGC1Ps7JG3jwoQ1lwc82pRNUne89Y3PDcdPz6K0lb7JQ0hjrqr55BH6IcTQO?=
 =?us-ascii?Q?1QUUT53nWkZpiE8Yhdpkgtvx6U+3YnxV+wCdNybHg6c7+KcblPgauuaiNUQ9?=
 =?us-ascii?Q?29YgD5f3H//32qTRhhq5WZJbhcEh1KB0np0IQjn/e3quV0JQlGVOT2LMztGW?=
 =?us-ascii?Q?EVFlbuqFAFe7qKh10rHRrA1prlzoFS6aJAZRjaL5lKRsW/ndYc7KS1hTufX2?=
 =?us-ascii?Q?SfoQbowJz0IcGOim/pbOTxcepjw6IJQkUSTOUblY91umgSLcm92eu707YBu5?=
 =?us-ascii?Q?I+f6Gr0KvyO4r2lqMFnQpRVyql8XV6eiETa3gnokFuv8S8ht3bHmB/G6Zk7q?=
 =?us-ascii?Q?MuXoa9BCN8En1+MXHrxcP6WvH1OxgMOgc+6VrN407SGSCEiRL6xbbe2bnZTS?=
 =?us-ascii?Q?5M4UrAo3UxEV3CnfAmIYTSsdpR4el/YgC3Fq5u2d1xp6vSKmT3EsdZCQmLs2?=
 =?us-ascii?Q?AoiwRmbQN7yhdnChE0E0lhfcJRuFyuYnkBGqRitxe2zr2fkqR3CVzT8X8ibl?=
 =?us-ascii?Q?mYTy294PEqsB6pJjZnL/lUHOJkbCWIqssyhNeD931/sUCP1YmUdDZxcQxNEA?=
 =?us-ascii?Q?JaK1UPiMT3lQ1+X8Ml6XvHhn2LD8L+zMsOG6qmXoxJexJwH9ar7QYuoLpz2+?=
 =?us-ascii?Q?ISVqKmKwjioIcME22DEzNFqo4u10EQDIYL3rHd6hQZ5bqLVl1fJEVNj92e3E?=
 =?us-ascii?Q?mxYhWBLrE9+c6DcEkIxyJtha4SIxtfjCZy09D0QnqUTEUBfZ/D7qWpWVgbNV?=
 =?us-ascii?Q?1dCpwgBFJZc1gybsGPi3/Yqe3T7UuBfPWZTirt7aIu5l6TamYCLB8FjhhGkv?=
 =?us-ascii?Q?FIEFuBSjb/OODs7zwHMwy0USYEr/Y3r+5asFxwX3BhwBh3zbjAIIbYQecA+E?=
 =?us-ascii?Q?AFx08QFXOR3rGMY8kk9YZ5VOiFTTcKzDbYS/uoHiPujGqB0avRO/W+HyLp8R?=
 =?us-ascii?Q?G2EUEDEhor92CwoT65aMwhOU8XPsz3md7SHZJTT9u/d2gjygUrjJsnyJRXu5?=
 =?us-ascii?Q?cGgDOPSwjBGa2mt3p3Cl3DHZp+dgBIY9N5HeRBc/1kdB6RrXaO1kgSZB3Qos?=
 =?us-ascii?Q?Gv0WNzo75XG/GpNTUWZz68GEbNxum7sv47oRs1dAFH9ev3vdipts8eE1qfEz?=
 =?us-ascii?Q?X0bbT8Z9HZV5Ekmf2rdbBFtZbQSAGYvspdtQ0hIKn4YTu2PAtErf5WeTE6tR?=
 =?us-ascii?Q?WnHDeUnUeSrSolmuAXv+bzNP9gFeVADlHmp5p51GsQMlhayCzsGBoeUW1v5t?=
 =?us-ascii?Q?grK6y/cnZWEQQvx9tPXb7uuBLf7i/hZPk9qJ1cFkd5h/y28zjPKFrsU+GlNx?=
 =?us-ascii?Q?iK6X0tm7JR30tO1C54D8fwyZvx6ExFFdQSK3XlAzCa2q6HOwmnrxk5mMBat5?=
 =?us-ascii?Q?o3kGFuqQZTK/7a6kjsxEahaKtTN6BqXV2iT6ZK07rRMgiQBX8NNidI+wRFh2?=
 =?us-ascii?Q?8T6HqtSWBGKjDT4mKsuLkG9VPuv2+yF/0fcq9yxNlUKLclu965apdh0pP365?=
 =?us-ascii?Q?wNSkb+2mT5D9bzvnVnyVRqjZUdKJurqHmvWN4FHxIGRA3v7P7DuYpAQM/9Rs?=
 =?us-ascii?Q?WhWMqJ78xfqKFPkqffGeIVb6MiyNj5sEnJmtrE6+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db6253b-6223-4b25-5b9a-08dc1583521f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 04:34:54.5049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHeANRr5hFVlUw+w64ZTJmo3cS5tPmyi/Eip0UfYrjjc+HU8WLZhdFwVcJ+du1XGtmEg4TnxuV2VzcR4P9TEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6891
X-Proofpoint-GUID: Je240mbTHdS_QN5yx_Seu0PiHdYo3bgr
X-Proofpoint-ORIG-GUID: Je240mbTHdS_QN5yx_Seu0PiHdYo3bgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=530 suspectscore=0 malwarescore=0 adultscore=0
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

The Arm dtb changes caused an address change:

 DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
 {
     [ ... ]
-    Name (MEMA, 0x43C80000)
+    Name (MEMA, 0x43D80000)
 }

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

 tests/data/acpi/virt/SSDT.memhp | Bin 1817 -> 1817 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
index fb3dcde5a10936667ad75a759b8bd444a7b19fc2..4d3ef733276bf5992da5b0bb967f6d60e243417d 100644
GIT binary patch
delta 22
dcmbQqH<OPmIM^jblAVEpao$EQUUsG%&Hz1D1wsG-

delta 22
dcmbQqH<OPmIM^jblAVEpaot8PUUsGv&Hz2O1wsG-

-- 
2.34.1


