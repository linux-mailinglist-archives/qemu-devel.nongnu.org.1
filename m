Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F7717450
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 05:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4CLA-00028k-C6; Tue, 30 May 2023 23:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1q4CL8-00027q-F3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:17:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1q4CL2-0006Qu-Oi
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:17:31 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34V0Q3qM020062; Tue, 30 May 2023 20:17:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=J1TVz6rZi+VkghRkZpDPbtsvt8T5zsI7yzYxB5dsRAg=;
 b=CLW6mPy4sMH11uWIvzX9sbf5lEkzz0lY2XPMX67djWgPujJyFK4D8h2kxc0L2PZVexfC
 DxJNoTt7kvHe7xM3Q5lGpYYms+Ia+kbMP/GxCeGEgGY6GhVpfgxwIuI62MEBtE9j2I2z
 /Q2eseIj2ZL13vBEC579FakvZcJeDzA9LpDovv82cEv5Ysqx7VzzRwl4wKKwsC/4hn1V
 k6um45rLgFb7bfcnaKonfzgjIRXMl8xMJ0vr9RZss9BmETka7T2gcrTRD5CPKs0JHFHz
 xxcw4gcRXkvQQKW3CzdeEK2/uFFTYk4VGtdI/oOOK7kxzGgT4dre3HABiDNyDkyT4NRE Xg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3quhcxrthp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 20:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpw/fieiJb2wi3/N+Y3yoQVflb6Tun9Uo4zYFW6O2aJPlzm+N6UxXI1wYeGq2JaL9yErEdDhKLHeBZLGRyDJhSY+9WcGa+K8rHOWPeCI4ly5CHbtxf3rWgzS7RLFR7Nt2WssKbYLIEfgb52mIdJWCIeGpVlKJa0+HhKY3YjLCySB8iIecYAoZZDdm+pTf/JxJ+3JmZEkQZZLAl2oGrJ6Uk8dybIl615FzySTm4NdC0IG1280mAAxzIV/PRShxGLgv/wIyn0dwU0HevVqN1OMY1LBDFBWC9ai7gVPNOvPZT0vySGlqh/t4EGkKpY8vI/V8qGGjszyU5JYXnl0YkYLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1TVz6rZi+VkghRkZpDPbtsvt8T5zsI7yzYxB5dsRAg=;
 b=ZPMQ/59qLBdL6difYMlYq6ZM+GcSHtdmqDojGY1OQ1Kemoh6jwqbYes/QTdpaPSocReOS3aRHGttaeB82y0d0AmWN4RMXTmFtkVbjH+tC3WBjgjt/TqijQyLoVM3QMEz6kkPnMYWP/FKu7glt+STJD2sFpkmuVf/FFA194xO3P5BrqdgDIzQ8VN4snE9rTZt8RTZbbZkX3eNs0t2WJEyASUhRWvn7TRlVw9TeM7YUFfUsQIkihF+t1NiOIVeLdvGRJaa/+tHO2R/SiRP87/IU4JBi8/X2rFxX01B1JLPTSyu2/v5T7+bNKNSB8KsOxaaa8QEuWKC0Tmn72ezAJ+fuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1TVz6rZi+VkghRkZpDPbtsvt8T5zsI7yzYxB5dsRAg=;
 b=WESJ5sLagRkHuOdzz5dQqoKAUzSo/TeYxwY5bXfzil6r5813hY1gU3mPgAny3JqF/IVqwyrQHZNpjmheUiphnWnRR2DxRuz03Jcfi/p2FrzzM0WYAOpgio42nrdgvh/8sa7+J2Bsb6F0RwwaAG9mgy3fHn3AdM6j2+pRKzCHjJeaA+m0RAyAr55A7TdwbqTAdU0dppBpbt4//nbYR+JUTIaudx/u1g1BCXc88GJE2cu/0SstfHwU5AWnrlZnaHQUVvQGldQG3oEaqm1ZbqJ3vjBtMnBEJ0FyCHyEaxcw6R+VSQyDqVUgCF6wNM8GT/yt4Yol808AWA5MjQ8b+luUIw==
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by SJ0PR02MB8612.namprd02.prod.outlook.com (2603:10b6:a03:3f8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 03:17:22 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::b138:ab35:d489:67f]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::b138:ab35:d489:67f%4]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 03:17:22 +0000
From: Jon Kohler <jon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH] tap: introduce IFF_NAPI
Date: Tue, 30 May 2023 23:16:45 -0400
Message-Id: <20230531031645.44335-1-jon@nutanix.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To BL0PR02MB4579.namprd02.prod.outlook.com
 (2603:10b6:208:4b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB4579:EE_|SJ0PR02MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f3d353-d778-481a-72ab-08db61858c9a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7j5N88TKZqAdC+NIu+y9q4TyPexSl9SbVqus31x+SsZI6bMIg06U7ZRVnIQIh0bFWthAtcqvMIYUgZoLEknrBfpZsSwNcVFRIVNqG6PPtKBYzwA0gKbJareIFXHR4jaj0GAnKxnXHUouokj5y28tB7D/HBFe+qo4VqfOxMC5K77c9uQJgADVoeCMXtllfF3xc0dAHBDT42JW9HKtFWHVCZv4FXtpIaMGLlj/iHPhlx8k1l9qehxA1jVgSy0zRNtLgXp8FZIi9/OETQwqHbc/Kt7B+d4LjxyulSiCURK8t5miQ4x6FsBuwtOI89vV58/Hx4y0iEfEzUUgRzM2ZHDTXZM4wkMMtI9+/4C6ohC6Lj9yv4gf+KqV24C4TN0LMpdBqzCTRZUm0sX/0SfZmULJG9lP4F2zknzsNbwKqmx2fIaM5HshfR7Bvpp8RoiECLOBd3YhV3U0vJSTn/NvaQTdziECXIZu7wEZEPHerDnAkQbdbm7CH0GwoA0a63iKT7wbJJcSWOeDqppHm8HPdWzy8knlnYH35z6yyJuAzvmhCavdx27ryN0tXaVN0lVgHATB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB4579.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(478600001)(54906003)(8676002)(8936002)(5660300002)(66476007)(36756003)(2906002)(86362001)(66556008)(4326008)(6916009)(66946007)(316002)(41300700001)(38100700002)(1076003)(6512007)(6506007)(186003)(2616005)(6486002)(6666004)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mO4JwF05uGUDTecNR0f6DevikXdJedcp18yHA3V3z2ChTYgkJme/b+z1idv?=
 =?us-ascii?Q?sl/+RLqFKoVFScxrg5nX/8E9n4+CEBegI+X3cMFuh52MassKFJ0Kz0VJpqR2?=
 =?us-ascii?Q?DDI8DNPaQXwEearFpgYOdUb7xr1J1OUqrGv5FrwH5Xe/jRpvBi86RCE5xWq1?=
 =?us-ascii?Q?JVFFbvZeKNGTMqq5HiKxNRSJufsqEwWKuZuIdhDy58yDF81sM8wdTStVOXVR?=
 =?us-ascii?Q?3MCGeX8N0/MUJB0w/QC9SmyAF5pDR4QPbRiVsnQvI1TRG0dBZwght4muPj+X?=
 =?us-ascii?Q?y4ilAzJSpDS5qZcldB40GBHODuZDLUXZ0+AxPeceuwlQme36ki4s7WRPKAxD?=
 =?us-ascii?Q?K5c4kq/thsluZywI01ikoMDV0TpLSSg7aW899UdFsdHM+SNSingmfadH5Hrl?=
 =?us-ascii?Q?SnOyfAIFL/QA/afrS6Vx0ujyJo3NQaRGTGz+ey4HzO35IEmlv5RCGZ4xDeaF?=
 =?us-ascii?Q?FPJ2SuKLo8Z3+APSxkztYvhBS5KaQWB/gkNiGoWqW+PrTseaWplNHsclx+Il?=
 =?us-ascii?Q?/hQMHnEuIDOpT4hzRHJM+v5+Vv54ORanawWi8h5lODW/GO9dUdYBXTJtfzWG?=
 =?us-ascii?Q?z1yOSoW+CmtwOvNJCtWaFdD1RSrqsbEcC43d4sD3kvX0bcmttJEjOZvFitHe?=
 =?us-ascii?Q?4l/CkVbZF3v3DlzjL2z4+SJ3f8x3Wa1C0/ltsOnhKHxCVLGieW8bzml4VIEQ?=
 =?us-ascii?Q?8lMSj4d/tWA0y2tpH4DwveDE0GDvFJQqDbNqHdkCMoYDyXBn92G6rAqxNHuG?=
 =?us-ascii?Q?d8b6MVPO57095xPdPqniENQOj8WabppkJZ+I9a+cRCtwODm3iN179gNgjX8f?=
 =?us-ascii?Q?QDJOWHwVMVaCvFFTaeij8iJgkHFZrhR9lorLFs5n3aeN1j8J50duRxZNpxF6?=
 =?us-ascii?Q?sXLlH7L9Ar7LcLTczO92iQNsmFBo0Zxj9JPYXgVX9Vcf/TMyYG3fQ7oYD/OO?=
 =?us-ascii?Q?7gHmTLaZKYSNWYWKVG9B5WZY4Nz0SL01Go8hBbFUOnG3K+rh7chJXcmhQUUj?=
 =?us-ascii?Q?7wPLqA001eP389/v/LBEKvR5rhxHuOa/FtWy1IQaFGcaJHWQsTRd+J230bzu?=
 =?us-ascii?Q?iYH8jnhvV/JOS+qof+Db0YVCjdWNUsB/Hqgh3D6r6ZcI5hg/XmpdaClXYpHj?=
 =?us-ascii?Q?F5jtqTiRxSaHNW3iZ+2C8lXswbz+OBfk7PumW6dn6Dl+NiZ3qvZgWEHgfSCE?=
 =?us-ascii?Q?I8YmgWhJtOwnoGzfErgoY6CDtIimdEp136A89mewyWmaUIB7rLhWNpk7iDVk?=
 =?us-ascii?Q?LZOj1D5H4fBAYu0ehtW4HK+QmRNzexMhPa/v1Gnfi0lYbH4uJoWZX1EB78K6?=
 =?us-ascii?Q?Q2aX0dWhqae0rmTioYCBI8Ew3mKXUAyfalTG41uN79dzR0cWNXvl4k4BMgod?=
 =?us-ascii?Q?9WVnvkBdHozUQ6uKt3HDGEPABICifbDjaD/8NPJDrl86CGubwQMW52TIO+aj?=
 =?us-ascii?Q?xLFLS4swuFQi7LgLsUKTUgW4ncZIY5COPJJ5NgTA1YvdxKCGD5gsqHhc2UrB?=
 =?us-ascii?Q?ftVajGArawhSLyef5VUrCrbdr2n8FjCamgr+8EuzsXoA5hijnv5Dm+VmNIlF?=
 =?us-ascii?Q?+869m8AqHth1WWaXJvE7OzBvmCpACAJnl7GLjuSOKmne2WbKzyPHmNTzdl91?=
 =?us-ascii?Q?Y4/K4beUJNlFqYpnQ+6dbjypOBpMHbxyyu99p4iexsR2drGd3XiieVmz60XT?=
 =?us-ascii?Q?Ew4HRA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f3d353-d778-481a-72ab-08db61858c9a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 03:17:22.3962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9xqbaUsrhQ5Ud+3DKqL726KnVPx82HtAG7S7NYEXk/Za8DAcs/kPgj+l3vuFrAylX8fe3NZiv/rsrY2TYuDFWptbTFq4tE2CE6OtLyIirA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8612
X-Proofpoint-ORIG-GUID: Bvzxh89cPypKNkgoBoIk0VOSH072PQNz
X-Proofpoint-GUID: Bvzxh89cPypKNkgoBoIk0VOSH072PQNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If kernel supports IFF_NAPI, lets use it, which is especially useful
on kernels containing fb3f903769e8 ("tun: support NAPI for packets
received from batched XDP buffs"), as IFF_NAPI allows the
vhost_tx_batch path to use NAPI on XDP buffs.

Benchmark w/ iperf -c (remote srv) -P (thread count) -l (stream size)
from a guest running kernel 5.10.105 to remote bare metal running
patched code on kernel 5.10.139. Guests were configured 1x virtio-net
device with 4x queues, resulting in 4x vhost-worker threads. Hosts are
identical with Intel ICX 4314 @ 2.4 GHz with Mellanox CX5 25GbE NIC ->
Arista 25GbE switch. vhost-worker threads largely maxed out on CPU on
"Before" and around ~50-60% utilization "After".

Single Stream: iperf -P 1
iperf -l size | Before          | After          | Increase
64B           | 593 Mbits/sec   | 712 Mbits/sec  | ~20%
128B          | 1.00 Gbits/sec  | 1.18 Gbits/sec | ~18%
4KB           | 17.6 Gbits/sec  | 22.7 Gbits/sec | ~29%

Multiple Stream: iperf -P 12
iperf -l size | Before          | After          | Increase
64B           | 6.35 Gbits/sec  | 7.78 Gbits/sec | ~23%
128B          | 10.8 Gbits/sec  | 14.2 Gbits/sec | ~31%
4KB           | 23.6 Gbits/sec  | 23.6 Gbits/sec | (line speed)

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 net/tap-linux.c | 4 ++++
 net/tap-linux.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/net/tap-linux.c b/net/tap-linux.c
index f54f308d359..fd94df166e0 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -62,6 +62,10 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
         ifr.ifr_flags |= IFF_ONE_QUEUE;
     }
 
+    if (features & IFF_NAPI) {
+        ifr.ifr_flags |= IFF_NAPI;
+    }
+
     if (*vnet_hdr) {
         if (features & IFF_VNET_HDR) {
             *vnet_hdr = 1;
diff --git a/net/tap-linux.h b/net/tap-linux.h
index bbbb62c2a75..f4d8e55270b 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -37,6 +37,7 @@
 
 /* TUNSETIFF ifr flags */
 #define IFF_TAP          0x0002
+#define IFF_NAPI         0x0010
 #define IFF_NO_PI        0x1000
 #define IFF_ONE_QUEUE    0x2000
 #define IFF_VNET_HDR     0x4000
-- 
2.30.1 (Apple Git-130)


