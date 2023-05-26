Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B69017125F7
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Vxy-0001y0-KJ; Fri, 26 May 2023 07:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q2Vxr-0001x5-S4
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:50:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q2Vxo-00081c-2T
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:50:35 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QBlDdG017613; Fri, 26 May 2023 04:50:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=ky5OzJIwlmaPG+VInSZ7BcG7wFthEsP8M1LWWs99hF8=;
 b=OZjF9BplR4ZldOsvdrMzVilOqAxZ7rgzgW1Sadrt037iO0Y4iJDSB0/3pAKAKhT7dtY3
 13cNUcRt6gvbKxesu0J1l2s0GVYuyWi9V2xKBKB513sNogxCAAU0tb4+cPjOVowNq+Ye
 Vl1quR4jP9eOY50zEOUsywQo+725dysaA20yjza6H0bEIikt3Y4bZgD5nXv7O5OXYOBn
 f4rFGUkYxSMOZ5MzgETjLOmPsu/hMCWyG37zMfgnp5XNCi/Yc4zWwGdVo8RQHY+YJCmb
 O/TTkaT1zE/rR3bj2S0vrPXPTEWu3LaiIpwikAkq/SnjwbBK9PPdZQoDvRY6nqsP5UTL qQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qt58gauqq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 04:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghde6iMbZJ+uaBz++0XQg35VJT3JX4rgDWnDxoxWyOe1QWjRQ8iL50Ri0eooUfaGdWQqFaf2yPbGKs4jAfX4JKX+QIsjUypJeg63Za7A0ykOUSuuJfd6YncCrhN1t6xn7PTjNHB83YLIo9+eQqbgbXPtzmsvIF9uNxkTbimLOri5BEgC5ailpsX08WYlrDw9I9f2fLuBIggDQubBA8Cyy1XnyxwOyagU0KlWEvqMftaBDyEs8KRk2uPdy8VBsGzoswk+xKOeyOSjMIKkFJIbN89ygyAmlH0yg8wp6czv/tRMVhZ/haIcwX2VlKMQAwCvC4AE1p8hYOyPzC+jol00Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky5OzJIwlmaPG+VInSZ7BcG7wFthEsP8M1LWWs99hF8=;
 b=D/9gg3NnRTJKXnLvtbn8jNWMsKcNfI5aLagj4CnYkLCyRy+G04KYNN1yspto3guJP48Jv3REK5WbeD9TbYP78R/yW8HL7I8EeuZO7fXqG/GnCyZ1a4YYNqcJXHKOQK1qqg2gezervCJKIsUF9A9xyhyNfLuLHX8+CFQTcMxDnaC2mKvtD57QZNqH7XviLij2ovLWjMrNb8g9CDXo0TevpnGrzne7a3LIqkv/3ZdBjfdoRXzLZdeUEH4ZgcnFdgNLd//mESAX2s2lTGL/vSn+WXGUGvTfdmeQ5vhIZWH3zifo21s9B/V2riB2XfBn4I5yrihfdp3yx5J6PHIUbgSr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky5OzJIwlmaPG+VInSZ7BcG7wFthEsP8M1LWWs99hF8=;
 b=NQu/DJbyAxt3L6ix+4xYh6eiS85CFCt+7TQVXAbDipVCj/Sll+R9ZMZ9KWmtANr8zu6oVC5GJj6sF4f7lJBbQ24yXBj2h3ljKJX/cvr5UPTuCzaAMCR0+HgSYLXSauNaQmwP5/Bjqq+xW0g4fjHhTn7aZ+VeX6WGuvOPG/BCI3NwA+IA+n7FzwbyvAubXhUaihAkaWdlGLOXLWEaszoWwaLV6alp9/VcuimeFJupUA+jUpw+r4IFlwReIa4rnju+cOXHTfRgPJdx+3EXRyTENt8jj26aKEx0qz5cT/NPq1FHacovuFcJdpb3YQKYzDYmERCW4kJPnKoCZyGhzI+x2Q==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CO6PR02MB8738.namprd02.prod.outlook.com (2603:10b6:303:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 11:50:25 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1%7]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 11:50:25 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [RFC 1/2] migration/vmstate: Introduce vmstate_save_state_with_err
Date: Fri, 26 May 2023 11:50:02 +0000
Message-Id: <20230526115003.212004-2-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230526115003.212004-1-tejus.gk@nutanix.com>
References: <20230526115003.212004-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CO6PR02MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 9affeb4f-6697-4963-82a8-08db5ddf64b4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6E5yp+IHC9lFDDlCf1S4MUYv8Nyqqx8vDSnWuMkpiA4HTxv5kn3NBBnJa6sdZWgqEv8rhDuvaa9tdbuLcqTyFmGwaDA0IlmZ+h+iSGWLFBSVQVEol/rZn5w35wdwcBU8GQTV+RX71Z4uQiU8/hrtxXZEWIYMxNUdZ1BVNuLq2FxuVyfLkHQQcvRoURi7lpjgaec6Rog82ucDtlcK9mOjmv7dJ7/OcJVCNXk3OwoY0F9X2C/7Fg3NTUcyjRNgMyyD6kJH0XDKY0bmOF1pY058sGyDfupW1YpV0PvZOjIzg2XwtsCen7Z/SeENvCs9kfwnaMh6TJcY0gVvmWnhv7aihoWxVBo2s+c+hTMa0lYDMeQQLFN4LLD24EN24D9uecbD2HdG0C3pej3mJXh0SuNbPnErW4V0s4wP/ZO62HeO4iwCaxENHlGOLBnnqmgeqdyBP9mN7FiACeNfTi5uoaBg13Kkm3F2XSB06GtGV2DdqxSgENIqETDE39SD/eesgNXWVsOb1VYA7dv5OdQWi0sylUL3W0kjn0Of/FlSjLUNdIbqsGymRXLVWsaiRL/WOOiH52yXYaxLpsiFUe3xXAzks4oowkuKAry08WvQCZFDlBb5Z7DsUcI+EsP3umzS+Aa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(316002)(6666004)(1076003)(26005)(6506007)(6512007)(36756003)(107886003)(66476007)(66946007)(66556008)(6916009)(4326008)(38350700002)(38100700002)(5660300002)(52116002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(86362001)(478600001)(186003)(2906002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iXbhLERoD/3lauKKR/oHXZreDQligo4B9D8IELooxXT7yvapgDiDOUkbLkzs?=
 =?us-ascii?Q?jlRSDKqI1//FPC5rIZTBA4ie2Hu+YRI5yFn05AU8+nzUEXxsosDmrCo+o6Pw?=
 =?us-ascii?Q?+Y0HRdAQgZVzzYFSjYRML8UxGmeKqEkVbvZIWciqyVCqx870u5qfHhO3tMHA?=
 =?us-ascii?Q?RAFRIv0dBfY1K8SXHkzaKUWbivh4cjFj37ufkofBaNsDIZwbtamMq8yBmVIg?=
 =?us-ascii?Q?JrqgyncJiEflJte3bD5/xZluKnxS4tyX97b/V7O2FhswAKtlDHBHbyXh9jSL?=
 =?us-ascii?Q?CY+0mBr86EVTMX7W6K0awyiciN4rTMXjPWc+BDc7u1kc9JYB1/okhHcIdMn0?=
 =?us-ascii?Q?CTv6jo8Gqhdsf3OA6yKy8IRWCtzXptgqahg11bMWwl4fKmsOnaTyM/ldzMFI?=
 =?us-ascii?Q?ZB0HZwo3lRuCPRhGXWaNN23gfInunH4DigpS6i7Ojyj51BF6cZIXeH2eZNg/?=
 =?us-ascii?Q?lRfrM4ATq7TSpMM8PDPvNSzuN7QgcvEbKQidJ1P2gZae0nm9jxjux+KBmffJ?=
 =?us-ascii?Q?sMuPsxdw2nnM346AgNkCtS5DNb06Ly6oZWx3ahjbRVDvDZ2yyQH2tve8BGkc?=
 =?us-ascii?Q?n9c6RCwVvNT3BMFrSCd5hOZOuduDi3yqhPPGDE7D0/TEz3XeQCCOlcYNk1uY?=
 =?us-ascii?Q?Hys9RwHT3twRsviz8SM+HXfQk1sTu6NoJ9+S3YZhmYZBkD6O7b994Q7YhqQU?=
 =?us-ascii?Q?aJXiMFERtZrZ+9rDmZtHtn3hNpHx9u8yhAJEDX54btrzW557VAy23Krxctg1?=
 =?us-ascii?Q?4Yf771S0jn12tiUCUJcAYaWGEu0sPu4fv6qSUUMJhneyidSM/LhJynD8XszH?=
 =?us-ascii?Q?0rNwfREcUbh2xFkepIIikVGBoh/KlT7Llx85pUv+RqoQmA3xutqzTTdIOEZz?=
 =?us-ascii?Q?cLqzcppqGDPIXfreub29Hze3G+jfrjde06mNi0Sc7HupAVseEJSOirrH/606?=
 =?us-ascii?Q?3BFmF/hRs5J748GCtsUCIpcNX3gSFA2/mzD0C89H7jK26XktNrr+DtBBnHVN?=
 =?us-ascii?Q?xXXaTm2C4YTWye7b71m8LzMbyymk4Jaen2uh5LZ2An9F3exJ+EwNgKFbdh3r?=
 =?us-ascii?Q?YKopx4I6md+ssXsTgIw+itpH5Rjxm8LqEpaTjg2HyJou3uUTfSe9c9aVCxBn?=
 =?us-ascii?Q?i7fEnYVdL2UtWe9stQj5ulFHvkzEFXZaK7p86wNYu/uFPoxD+45LNHs/tTxK?=
 =?us-ascii?Q?kVMxnCIYFQG9jkIqHD6RPZK0vrb2FHHqODQ3goCEc2Qq1TPvP2R7hvparmPs?=
 =?us-ascii?Q?lyjsV7CSIDbaa1Iv3ROu4ovKyuUFY4/8vkD92txVO0PieP4bcYii03CNBF+k?=
 =?us-ascii?Q?cAE0mc3s6l6mdZaIG3oCb/uv2jLdY7ZGFRiDaYGaye8pcyLdU+CTIThGOE8X?=
 =?us-ascii?Q?bFAFKtkVJP0MJvW28sCsBhhsWz8d/WMTqx6Ww3zJAoeG/uzqIkx+y+FixU6D?=
 =?us-ascii?Q?uupYVjpNi6xyNVP6p6X8ptp8ma3pyqCsuuKOp1SoXT0hd4qE1NcwpmUzthvX?=
 =?us-ascii?Q?EPUANpxwo1OKqjgPNBqRZaOs07yAkoCxp5Cd5+6mAzo54G/Qu7g+67+BXJQv?=
 =?us-ascii?Q?8rqBys2Ci3cf4weexwxUFA5k5rd4tqpNcif4+lpu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9affeb4f-6697-4963-82a8-08db5ddf64b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 11:50:25.3686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQkxatEXCMd1E5/Cd1Ro6WUdfUol8q1fvk2lZ1PXlr0Nq8JT/i3Iq+xr5+rpKRQRaxVqttwHZyAHcJFSRtNO9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8738
X-Proofpoint-GUID: ahWCsWJcn9O2bTYQcZYmUhVnomvatPqn
X-Proofpoint-ORIG-GUID: ahWCsWJcn9O2bTYQcZYmUhVnomvatPqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Currently, a few code paths exist in the function vmstate_save_state_v,
which ultimately leads to a migration failure. However, an update in the
current MigrationState for the error description is never done.

vmstate.c somehow doesn't seem to allow	the use	of migrate_set_error due
to some	dependencies for unit tests. Hence, this patch introduces a new
function vmstate_save_state_with_err, which will eventually propagate
the error message to savevm.c where a migrate_set_error	call can be
eventually done.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/migration/vmstate.h |  4 +++-
 migration/savevm.c          |  2 +-
 migration/vmstate.c         | 12 +++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 084f5e784a..244d00ca74 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1194,9 +1194,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc);
+int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc, Error **errp);
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc,
-                         int version_id);
+                         int version_id, Error **errp);
 
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 03795ce8dc..ec7f66619f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1000,7 +1000,7 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc);
+        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
         if (ret) {
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index af01d54b6f..35a9b67afc 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -315,11 +315,17 @@ bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc_id)
 {
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id);
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, NULL);
+}
+
+int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
+{
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
 }
 
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc, int version_id)
+                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
 {
     int ret = 0;
     const VMStateField *field = vmsd->fields;
@@ -377,7 +383,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 } else if (field->flags & VMS_VSTRUCT) {
                     ret = vmstate_save_state_v(f, field->vmsd, curr_elem,
                                                vmdesc_loop,
-                                               field->struct_version_id);
+                                               field->struct_version_id, errp);
                 } else {
                     ret = field->info->put(f, curr_elem, size, field,
                                      vmdesc_loop);
-- 
2.22.3


