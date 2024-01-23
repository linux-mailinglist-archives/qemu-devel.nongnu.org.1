Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66348838B5D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:07:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDgX-00050e-Mv; Tue, 23 Jan 2024 05:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1752d9a8b2=bin.meng@windriver.com>)
 id 1rSDgU-0004zU-VN
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:07:10 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1752d9a8b2=bin.meng@windriver.com>)
 id 1rSDgS-0001c5-Jv
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:07:10 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40N7n9IP001358; Tue, 23 Jan 2024 10:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=PPS06212021; bh=XsE7P+rTAXY9EJaZC4
 JMHjuIeJaP/YRhu3o5Ulkat48=; b=cx+V6bP4NVvqdXGtTNs940z4+QMOsgu4DV
 LKZGrGv3j308oho4o51svL6T53OsPJ3iKNc9VWNQwGHnx+fLAU6ithYdvXufuGEO
 B7m2a0rjKnaCD+DUR9epR+yYUy+Aq72QZ6vW25ZN2sqgOfTyDcBu6cvKJfk9qrEj
 cDdXWaP7lMJMFB2jsajmREYqoCuTqqFe1gdy5zd5zBGdWVIDhLmv3FhwtHQYeitQ
 63ZH4yCeCE+ZUVAqapHwI5swAMemVWBigOCHbNnv9Tba/AM55khC/MCSx+atpjpm
 HuIAjxdQmnjMe29PA1A3fuYZ8NpEJwyXE9Tx2mfoT+CHzCHTjsqw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vr3cyk96u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 10:07:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA8hcCnFLDnkM9g3aPT5WbCPbFn3Ac+N2RW5jzg5/Dao0+6pxZrXj7BSnXFI6XWnsiMT+sbKjRSW1wGyNJjR0Z4g+ggLfOHAfOtZhW54cMkAh7pI4UR/yyGErJ4FZMhjibzo7XZ93YHICn5zMyQ6K5KvI6qb4Vi6arsE3vpmZjc/tZFIbppgzAzX/VdF5scS9pvuhZ3xnCBIgSSoQm3p/m6Tlu3/C7BcPEJWX3zi1RMc81Du7Nyh5feMJMivS3ZncB9VEe541KiAjWR9zwZL8SjB05UxJi0MF1JLKExvKNJth8VL0r/8ld2uzIAclcjbAhN5GNu39kLzh/FROC8+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsE7P+rTAXY9EJaZC4JMHjuIeJaP/YRhu3o5Ulkat48=;
 b=J7QPfVZOR3I00NYJ8JL3H2kELw++MwiC6+ozSSc9ELYgDv/q8Wad38GN5nkFILKOMfs4U+JQxKwVJXJ4ELEhdPEEWXkK2ceN2K68At3HyhHnNA0vDwWbnow2tCpVNwbEQ+qgcKpYEsf6pFiGjmtAbYIO3W2NTaNqlI76oNikTEvgGuJx5yxTT4uhKo0h/Vb/OQw65WsfqUQgahCSa8Iy4G0rof1h+qtpnoLdz8vOhfAlpOcSlx0K2iXgqAQska9UjQLhQ1GxyMVE+H4Tu9WXhaPX+z4BjEKNvUazRZj/gnNBHxHrgdzA53jQRWZRXNHyAKrfy3l10sxUcIXpFbmXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) by
 SN7PR11MB6603.namprd11.prod.outlook.com (2603:10b6:806:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 10:06:59 +0000
Received: from DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c]) by DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4a3a:f09e:3c5d:318c%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:06:59 +0000
From: Bin Meng <bin.meng@windriver.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Eric Blake <eblake@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] util/cutil: Allow relocatable install with prefix /
Date: Tue, 23 Jan 2024 18:06:40 +0800
Message-Id: <20240123100640.1865139-1-bin.meng@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To DM4PR11MB5358.namprd11.prod.outlook.com
 (2603:10b6:5:395::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5358:EE_|SN7PR11MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 354b13b2-f69c-4979-0595-08dc1bfb0976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kr5bEJqLPtz9sgtamhtw4z/pBaASxz0bRFPg6q6ocZfCj1AH9v9D3r3Db4mXzIJiHv4EqjnC8Dex9HAvVXX5WzE4WcjPvfmSd8/YdliMac9Wk289KMRq2xPTh+Cw1KBQ7uq3MoEAvcO1Hj9qqvMfTpBrXQos05KR2xFDipNx0Kxm8WZw4PZ5SkCGN4SHuJzD5uA00filN5PJGi6DwNev+n1TrGNR2LwJCyPlcMvN54KlwnLMBcI1xDxVotKKH7FITA4fcTYwPWctFFm5dktnuO03JLMoSlpVl3SN2Uc0tSmuN6wEFzsbNC037kW12F/O1IkyltCD6PaeE+jTvDgpCeZ2CMhQTRuVFc28eSOu2POiP13pInqAmu1Kec2sEA+O2V5lMjdlggOgutoqCGRdbJ1BW1MRSHBafEB4xC9vwE9KbfLPloZRy1+7s9kwhnP0ToRxydZ/5OH23MnCy86PhUQAlh5fvvKiwqNI1tCYIkGGr5rusJT7FhcJU86VXdovvptcv90Gp99gQuvv94VR13SkkS1C8CaYHC7q2aqK78m1TrQ3XMbqi1U6w8P1OZmx4CClNw/hDSEAnuNi6p00o8xvfu/LqM6ARR+5WIwrkp+fHsZ1AiIpj7laeCWoIDdV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39850400004)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(41300700001)(36756003)(86362001)(38350700005)(38100700002)(2616005)(26005)(1076003)(6512007)(6486002)(6506007)(4744005)(2906002)(478600001)(6916009)(66946007)(316002)(66556008)(52116002)(54906003)(66476007)(6666004)(44832011)(4326008)(5660300002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9spNQ4bgRUEgRPA72YKlicyFJnj/uaP4bLco2ZabAS9Nd6JdA1HsV6kAaFrv?=
 =?us-ascii?Q?bbBCGFrFLYeEQ3FSVyWpatytg0jSNN9XOhK/Su6gOw8L4ZzFpWqV5mMcWMUf?=
 =?us-ascii?Q?OCF4jADoUilnpYvmhY5j2+oYOBbIeKnGCA2dn7qEgfUwHtoJYdbx/ItW7gQG?=
 =?us-ascii?Q?eb7MKl+dQrxzYam2FMSK2N7jPc4ATqxan3IAh1y5B5iJgxaQu39Ikj2r8FlN?=
 =?us-ascii?Q?qrO5pSPVuO2oTYanVSj36KNyBFmVRVjC3HxkDjcU32RO/q8I50tsq37bBX1E?=
 =?us-ascii?Q?m9eGzPeNb9xZpzvf3Ats+VBnrLHaiDUQnjJSwuqIFKv/n7AiF2Aq0d8aAg/V?=
 =?us-ascii?Q?DYIIUqM+ZsuZMt2T76T7T1CdXVkQlt2jXSMKJg4KRrg3xqZ6rAeqV9BmHezo?=
 =?us-ascii?Q?YuC0bcmFWJ9qK3VIfpny+WoMJc2uIVUT7F27cJAIANE/m/c7DAOyFwo6r75Q?=
 =?us-ascii?Q?NAxBk51B1Ssn5zveELD1usUhED7PBrf+C/wbX0peKe37wDVsExW56bGsCVg/?=
 =?us-ascii?Q?s9E/IJ3nCjXEPGlQWiNjU0QG9Yy5XhuRN7A5fIWLcLyDWDCysi2BBrtbWr8G?=
 =?us-ascii?Q?I1NesNrEy+LL/STJocXaV2JRLomfM1Rd6I9MrsVJc3O9XS5JgaxHsKOFV01G?=
 =?us-ascii?Q?6ktv9hkJdsm0ccictd6T58xvb+161wyH2Ke6qEIDplLLOcKa17xMW3Gj3H1N?=
 =?us-ascii?Q?Euustu/OAA3KjXGEmafMb6WWqL/x88MbdXHT5hwmw3FK7/Za/Ckf4IdQ9dzu?=
 =?us-ascii?Q?PRH8uZpiFYtOE26ksW2ciDf5+dUEPBYetD81Rq4LREXk22hR3EDyhFevaSYC?=
 =?us-ascii?Q?lI9RqkYnbIweowDg17dVg3yLRgygBzWffi37MBqX7wFr1RQtdRBqspc4MA06?=
 =?us-ascii?Q?Y9CQy8ZbGb+60+iHzICQaskcuaE1tMBMpS5DSjpJVMmbLjSs6cQG6pN5/Ecl?=
 =?us-ascii?Q?6cs8B2+Qi19vm2njQKP2SejEh0pA302v/uh8Vjd51PFcrfoLa+RR0BqNeD3L?=
 =?us-ascii?Q?E3ek9k0ZZv35KmY+MmZSaTGvGBQh8A1ucsSD2dxPp2jrJYI3Tb8fN/aUroBG?=
 =?us-ascii?Q?7+1obtYcm/o9//VRyv5aFeB890uP5ehnwELuU/V8L/Y4JZtA2BUCYBN2xmGN?=
 =?us-ascii?Q?nlRHboNEC9TsVu0OjmCG6Wudi+2+Lhq8UzIaSHKQRTJawUu2dEMYzSn0be8x?=
 =?us-ascii?Q?72oHpcWqwKYFLssSJCIZitaJrr9eGQlXgZgYWFrJ2peZROhPXBhWlhB31gpc?=
 =?us-ascii?Q?PATtSuDPEkhgmIXOqSWJk0WWASQOKiqXDdNq8brRBkwq/kG4WQVIJovtgPjj?=
 =?us-ascii?Q?dx6Tol0hlBT8/0Ikbs8EWKQxyvSwAqFSQrfYyC5ksUCDtzq/KhqOVKZOtB4J?=
 =?us-ascii?Q?AVzYmOpQ/fJDfFMTBB5D1XCkGTv9cVYa1vDKcnl/wxkVkvkQp0534LJl4bjr?=
 =?us-ascii?Q?+vUUiLuh+i8h1RvbWJBAhuoYZIOGUzXW/VNV3raQ2YqjDHMhWHP4CXF10/DU?=
 =?us-ascii?Q?NJuw7Vo+RHLWjoen6lJfOF7t0sDMo5ZM9T3Vm5jY69rSS2bisItNOLQUvfyA?=
 =?us-ascii?Q?R0D06YkCnZy2z0TVbNF0BIrdwo0bffsvBDc2u/LY?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354b13b2-f69c-4979-0595-08dc1bfb0976
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 10:06:59.2502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbEUZs173dSfNQJJYEVN/TAHxn0T1RB2KevCPtQLlQ0xdyIVeQm5cHtMhSMu5N4r3xk+9qguhT1X8xg5P8OGjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6603
X-Proofpoint-GUID: lsS3NE3U9eelQP4trSx_qlS2NHGoO1o7
X-Proofpoint-ORIG-GUID: lsS3NE3U9eelQP4trSx_qlS2NHGoO1o7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=722 priorityscore=1501 mlxscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401230073
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=1752d9a8b2=bin.meng@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When configuring QEMU with --prefix=/, the generated QEMU executables
can't be relocated to other directories. Add an additional test logic
in starts_with_prefix() to handle this.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

 util/cutils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/cutils.c b/util/cutils.c
index 42364039a5..676bd757ba 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1021,7 +1021,8 @@ static inline bool starts_with_prefix(const char *dir)
 #pragma GCC diagnostic ignored "-Warray-bounds="
 #endif
     return !memcmp(dir, CONFIG_PREFIX, prefix_len) &&
-        (!dir[prefix_len] || G_IS_DIR_SEPARATOR(dir[prefix_len]));
+        (!dir[prefix_len] || G_IS_DIR_SEPARATOR(dir[prefix_len]) ||
+         !strcmp(CONFIG_PREFIX, "/"));
 #pragma GCC diagnostic pop
 }
 
-- 
2.34.1


