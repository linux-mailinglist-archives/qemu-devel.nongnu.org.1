Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B427C7114
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:12:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLV-0006GK-UR; Thu, 12 Oct 2023 11:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLF-0006E1-Pl
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLB-0003eZ-4a
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:12 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39C4qA7q004840; Thu, 12 Oct 2023 08:11:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=pAGiFdX3isrHf5p9/e8XtZ+HitLl++eCbY+reURe9
 L8=; b=MrcjnHAsqGBHuZL3jTYQGkf1QbHxuHo9YxrWDMUo4jUzLeOq+g0EfdVLH
 tSEODCIGSpqAqgXimXMGZVhcKLYJbkPPYZEikMPhbMxosGOvknTAL2TZ3uvnzM73
 M1ViW5HmcOzLFv+EtSbEjj4jiUFcp2RYQWo/luQknIR41Q/CWtaPhcK7NApUXwPU
 AuaRTQuEi94xNVMz8dnjITGuw96U0pnGjj+MMDZZxKfz1bp8ep7yzELN1Oxg7Gh0
 SqNSP3RvZENGi8CNAXkOgulx/FfR6YONpzxXoaCqAFXOQE1J5+sV1AIdjKr+65nD
 U4UupzvDDEplBU7hK49kTi+a+D1ng==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tpa5c99y0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlNdo3CKl3Gj6B8d/jCYAntXPufIjsy7HwjUshoLGhFXguwsqR3whuHd8u3z89e+TMl5uNo5hg6ejCefGxHCfnF14Mb8lyUUoGOVnAp4JPzgVxunNK94x9MB5+AE/RKbQ68rfJ9jT+EiHWPXh1DiiIzb6oX0rVpgmG3wByP9HXW81/rx9sKGowE+7bhFiros7gOIziiejLg/9Dy+BiELHiZJSkGoJq9297yGd0I6WI4NqrW5m1u9xUMZTosKk8vbmklETOoFgSn2hDT0G48GBujrdFXsRs5h8Qdakv3UuObf8EVIZSNVb4yR3n/XJbMSIUM5nRRRLCWAX5YEp5rVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAGiFdX3isrHf5p9/e8XtZ+HitLl++eCbY+reURe9L8=;
 b=fLjXbqaxkkszpNbJIk5w2g6OXgolD9rDASG6EAbzi79AQ7BDEo5s0eEHng/IEdkQgOCep82qjgRv/qUImYqHBHQnlUd/ReHBUYwjK42tTvs6O7LGzE9n574+2D6TJhMHRWtxnTjE5V8YTxnUzInDNG0IEZ0pFShe/cC9wPNWkAuXtH8ieGU785AkQmgdeBMT0EJ4v0WpQegkvzkxF2gg8uagRUQytzVMEw8sOMTqWMZUS33ezOpranIhmwL4f20JFbCgNr7Y6uOgJbzTBhzV3POrju+xFIRkdL9muztHflKTvA0138gBJcoEtfif4CwQxwsDlHiJoJYNUJ+1iGdeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAGiFdX3isrHf5p9/e8XtZ+HitLl++eCbY+reURe9L8=;
 b=y8VozMzzHbi8kH+Ym0e95+fPiaqHiN7ZXNx0OqgUBXeOFaiVBxz60093CtnYCOoqOJdkmmv7OanAdwtgWgHeFFfax04zfxArus4LiL6KueQkkr+MBKt+P4Ob7cloZ9CXs/+YVDBsxl8B1BB2hetY+vIdKL12SOcdnmVnc19wA8broQwpUxudq0Usc1qVkUweVvapzbJ0lJXAnXhMmaFtqd3B55h/UnajNaFqYDmuw3xV1PL7LTWbywcSPFKCPF3bCnwmXrBe40YnRoyGVYXSFmmyKpAPw3yWhSoMhw4Jdn75VeuDdv7oS64CIo1kV7z5g+s2VUj5bcYfQ6wPAZX/uQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:03 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:03 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 01/10] migration: New QAPI type 'MigrateAddress'
Date: Thu, 12 Oct 2023 15:10:43 +0000
Message-Id: <20231012151052.154106-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231012151052.154106-1-het.gala@nutanix.com>
References: <20231012151052.154106-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: a65092fd-e992-4635-c199-08dbcb35736d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +m12i0NUTqVtUtyN++DoARvCSBEYVtK8Izbc2poagYvqFw9RT5V++0TRal9KQ1CLY9NE9ZOjoMi3sr/grTKnSryA1HeHSkGno6yYg54VdQSxhHw0PwhLE5tpMGOJ3plhFwJCoYKHuwIOkKue/yegJFObN8Wz5rsotzGP4vYlachdw1lRpEeVZdpVUs/+V88KnHrmxX8gdqSSiKGXToXumjlUivvVivTNiTjcMXZm4RXS3/r8BotZaShVzyt2PUhjRbTaNeGLfvIRidZvhZzfzqIB+846EDzs4+Jv1Yn3RwKTyBH9j1xhEZImk8duSmqsnYRo5wiIqO+967fNc7W+Z2HM9ZbxqFz9fEHGGwqdoAG7wI8SeqFEbdTmvGt/LU11sR5P2es19qASBX9xfJWge3ixxfAko0a2XQeKyRKREnXAmcb7XXprXjbYwhxmqzocMaNFIvdxjxS9sHLd3v32rnDsoTgcwFlXZe9TRuTDokAEeTCyqKGQhlOGPG+bZy3m1ubroew5mOYI+s8eQEYunVLYz8t5i368Sr5vi5WvDy/TZOMk+eMqzIXMR1e9QnRfPjimTIFFs6jNRI2+e1ll6OQxi6OUO3ZfK3ZaUaMDIf/2JMIfwTowaRCvLtKdrafJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(66899024)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3JDa0NvMDBHOVRURzFnVElHajNnaCsvNDFuWXhwTmw3NS9ZcDRnSS9rUFo5?=
 =?utf-8?B?UmNMRHBMWU15amFyZzF2L3lYSzVUcWYybCtQKzk2dTl0NldJNkNIT2RrdTcr?=
 =?utf-8?B?a0ZrVi9ZSTRiREpzUjRUWmVBNGhQVVdLVk4yWGVRVmY3a2Q0Sk5FTFp2dG9L?=
 =?utf-8?B?U3YxdHVhSU1VcWVwdmZiQnRqNzN0ZVM2czJvcFdUUDNyNXRBVVA2Si9pWkZX?=
 =?utf-8?B?MlRCWkNBS0tBVm5jOXkzbDlKcHJNWFJjSGJkbEMxTXFxMVZINFpZZ0hLS1px?=
 =?utf-8?B?c3RURXoxUlVUU0dRTVdDajBEUWdUeHB3THcvZllzWHBld0hzZlBFaDhJK1Bq?=
 =?utf-8?B?T0FsWmJtOC9DclNGNUx6OXA2aUxHcVpQbXR3UFZUQVlGdjhWeitMOGtZMmlL?=
 =?utf-8?B?N0x0eEl1ZVdCQ0NxbkhNWjdjdGI3NVgyeDVXVnRFNTZJYjRLMHNnSWIyZ2hK?=
 =?utf-8?B?TnpZNmRrNHROSjIrd3ptQkFxcjBXMDlEZWxvcFZ0cDhkVCswSzIxMU1DOW1R?=
 =?utf-8?B?S3crcDZTTkJza0x5M3RrclJFYldxbFlvMWNGVmRoem8vVG9DSWkyaVY5T3hk?=
 =?utf-8?B?dVZNVlcwNkRIdHhBRE10UEYwdzdSQXBQY1ZYWWtMOFIzNllWR3dYSEs1aGx5?=
 =?utf-8?B?d3NVUzJGdmdpUnBSYkVEMEJ2TFY0cDlwcmpuN2ZyK1NGUGxndUcvTXNNdWpm?=
 =?utf-8?B?N0kxYXMwY2tjUzFJYjZIMjJrNGZVc05xMzhkZG00ZW41YU43Y2svckR3eHg2?=
 =?utf-8?B?WWRaL1VRcWx6VTBCZjUvMVc2ekhhSVJmSjA1bk9EeG1MamNSSnlCMVJZMVlI?=
 =?utf-8?B?WEJVdUk4ejdkTmluSHVuUVorZUFtTUUrdGtReHlHQVUwdGc0ekZUVDBtYy9P?=
 =?utf-8?B?bjg0Z1RLWXFiYzhOeGttMjlVMzNKR1VIelJvSE80U1R4TjVNTWphVy9IMXVI?=
 =?utf-8?B?U1Zua0hUb1RubDJjVGhkSXhCR3gwcHM0WHJtN2JPNWRXYWFZc0RNQk11MWVq?=
 =?utf-8?B?cTQxSWpERmVhZVlPMnZCN1FFTVRlWWdoUzlYdWtNbml2V1J5VzR2Zkc3Y3oz?=
 =?utf-8?B?NDdyVzY2VW1RRW9SYVZqUUZzMGhZM0tZb3o0NFB1QkZqNExhRHk1UTYzaHh5?=
 =?utf-8?B?V1hmNDF6YmF2dlpQZFRtN1EyUzVLQlk5S2ZSUVdtU1Z6L0pIdWlDMlBVUCtC?=
 =?utf-8?B?NmJmU3FLdDUwR3BFUlFzSTU1VVFycGQvZlA0WjFFUUM1QnROcFBNcm5pT2FP?=
 =?utf-8?B?NWJoMzZQUGpUOWQ4TFdlTWpTeSt4RElCR0hvTnNFSWE4YmpKLzArcFptTVk4?=
 =?utf-8?B?b05OektWYy9aT1Q2eTNFcEVPKzlYZEFsbiszSmVPaHlQTFFsMldrY3c4ckNq?=
 =?utf-8?B?bnkxWmkzRUxUM1lvV0NxbEx5ZUxYbnRmZm1IWVZtai9JdzBHenFweWFCalVn?=
 =?utf-8?B?NjlwOTExZXVBbUVtY3hneWduTVpUc29wWHUrbitDUTRLdDE4TWVFN0RDQXo0?=
 =?utf-8?B?c1JGNFdISzErdEh6ak9zcUhkcHkzbVVMUnlxNk5jVG50Ri9OUFNZa2FUSXNB?=
 =?utf-8?B?SXpKaGNSQ1VtbFplSG0zM2pUWDByUWxXSUZIVUN4cDIxTDVHam1tRGV5L1Q5?=
 =?utf-8?B?MEUwdndqTXg2ME9GbnBtckkxZUcxR1p0b3oxU3RWeDRPUkN0OGNlKzFMdWw0?=
 =?utf-8?B?MzhSODNzNVEvbXhxRnlEVURaQ3YvbUk2UFQxUFkzVkk0OGN6YUJXWUs4S25u?=
 =?utf-8?B?RFBTUVJKRGFkcm1RY0cySWJtVjVsazRHY3JLaFYxeUVEOFUzaUllTytYRUxv?=
 =?utf-8?B?a3JUcG8vOHhiWHV4bDdwS2l4YnFWbXRMSVdqUjM2dGVUMGZxdVdKQWd2UEk3?=
 =?utf-8?B?eWMzOCsxREwzcitySG9GR3Z1cVJkVTVwZ0lXZFBCNC9RZ2syMU5HNXFTSTdR?=
 =?utf-8?B?a0htZjVocUNkS2hzZTJ6OVl5ZE9UQi9jOVNDUlhHVGdSZjZ5eDBwMSt5VTVh?=
 =?utf-8?B?Wnh2N051N2JkVHRQeFdTSkhFUVZhRG5lSWhqWVJweWpSai9SWWZ5aldQTVlS?=
 =?utf-8?B?UUQxaGY1Q0ZsUzV4VGUxRnY3RStrYW16MjRzeUFLSmdzQ2szQmZIVHd4Y0Vw?=
 =?utf-8?B?M0orREdwQ1c4bW9XOG4zQVVKd0djUmF1b3lWOWdrYmpXRVlHRFN6RW5HanZP?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65092fd-e992-4635-c199-08dbcb35736d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:03.5253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYLi1l5ZUxov1mrh6IZ/mT88AQyDQjVi8ykW0lwa83qB7voGs1A/XVr+cgfKg6CDj8BckVL1p1rRLi29TVrYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-ORIG-GUID: Or_Dgn59q_ZNynKBlhK_5_2pkkKeM7p5
X-Proofpoint-GUID: Or_Dgn59q_ZNynKBlhK_5_2pkkKeM7p5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
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

This patch introduces well defined MigrateAddress struct
and its related child objects.

The existing argument of 'migrate' and 'migrate-incoming' QAPI
- 'uri' is of type string. The current implementation follows
double encoding scheme for fetching migration parameters like
'uri' and this is not an ideal design.

Motive for intoducing struct level design is to prevent double
encoding of QAPI arguments, as Qemu should be able to directly
use the QAPI arguments without any level of encoding.

Note: this commit only adds the type, and actual uses comes
in later commits.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index d7dfaa5db9..8847def17e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1477,6 +1477,47 @@
 ##
 { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
 
+##
+# @MigrationAddressType:
+#
+# The migration stream transport mechanisms.
+#
+# @socket: Migrate via socket.
+#
+# @exec: Direct the migration stream to another process.
+#
+# @rdma: Migrate via RDMA.
+#
+# Since 8.2
+##
+{ 'enum': 'MigrationAddressType',
+  'data': ['socket', 'exec', 'rdma'] }
+
+##
+# @MigrationExecCommand:
+#
+# @args: command (list head) and arguments to execute.
+#
+# Since 8.2
+##
+{ 'struct': 'MigrationExecCommand',
+  'data': {'args': [ 'str' ] } }
+
+##
+# @MigrationAddress:
+#
+# Migration endpoint configuration.
+#
+# Since 8.2
+##
+{ 'union': 'MigrationAddress',
+  'base': { 'transport' : 'MigrationAddressType'},
+  'discriminator': 'transport',
+  'data': {
+    'socket': 'SocketAddress',
+    'exec': 'MigrationExecCommand',
+    'rdma': 'InetSocketAddress' } }
+
 ##
 # @migrate:
 #
-- 
2.22.3


