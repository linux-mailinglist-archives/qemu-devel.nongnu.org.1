Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A69347B796D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:02:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwn2-000579-Vl; Wed, 04 Oct 2023 03:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwn0-00056J-5Y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmp-0006Mk-Ew
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:25 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39418rdh001163; Wed, 4 Oct 2023 00:59:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=7fBEehkfsJojQa2VLWXEwZKghhAGXkBJc/3jqgJaQ
 cI=; b=KmJ8MofgLBFoQeQOSqVVjI6DPrWC4amlt7U3bAf+dmQhmEnWmipE0kMYF
 XRvZt5+CjeOxxUZSFfswzEcTgE3Qd8hBLTqA/joczn2N/U3FcLvovThtSvHkLqgD
 rIny3Bu8qfEBfUYFkZZVaVlKfFz8qahbdRxAwHCifYZbrQ9BE/XBuXiljvN2XlVC
 dzgJhHEe5fxgMVpq3d1a+hnw8QK4v95EUqivGklvTBtUGiyTrKy4oY9qHIjagXIf
 tB5mNLo/Vk/iUSa68uZEMahi2YRvL94WA7kEHymequV5OEiL44mBrh0jrDxo0z6a
 /k8yeKpyr+UEDLP926EevJJZ7xahg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tejrdeh9y-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOqUa664IeJ49a5j51/13pP0/y46ieftZzckiFHF7VLmLXFn6VOldZ23223WmzG3tUR12iVINd0yVCafLEbWH2nX3xLzSJl5k7AkhSGXlfmRxlpbFuq7iLJTUP51tS5MCI4UI6hChpdtpz+5XlDDYR56WhftTdV8SGWGQbfHCJi1kIiY0IpArmYNkJomZu0W9SBxXNpGzWoYvxDoLcFG/60QERJlXzM0e9LO2DDPlOxBEl2UKoUNOwEBlGqMDUBFEe0qZU55UmKHa5N701Mmx3d6e2LY+/N4zWpWUycvSATTIM9yObYl4TMMAzsm1GnuEEzQxxNfBYX31D8ZNsIk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fBEehkfsJojQa2VLWXEwZKghhAGXkBJc/3jqgJaQcI=;
 b=JhUD+iFaYTRC1jIYdZ1zpRyOdJOKKbrD4d+a9N4TpFlyIB47Dx/HksDo3NqJJWl///gyXJmc7SAFBYnsP6vZMQfcJS99kb0DB+rKvxdETrYCM2JMckFyPSPZZOq30BQSYMhSSrJyPrv5kz3AGSVhKruy9mZsxv+NdmyF7mDtjQX8zg31cteKnD5dmu5/uCwkyBTpStuJahotnpYHiX7KulVXqlMJ2kLVh4k47KqXaF33+7Y2ZXBax04j+riHDoeW4v3hapnm0wYlh0byAl9JwJvFv/FIa7w/hl5VL2faebLULhXa6A4nMKlElOh1LSU6eeOfI9/3a8Y9deJunyh1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fBEehkfsJojQa2VLWXEwZKghhAGXkBJc/3jqgJaQcI=;
 b=ktdiLZc68FiS+TVuSzjQdBYvw3KBX5yCVHPOXv4CFZMXznNSyiBbnOtK7d00vEfF//nmzFitG1ku4CmobDOzFD7ye2jSOnCCHwrmhSQvCeMKRXZm4E2n30YoqA9Cn/IvwsOJfboSAIHuTWppBOdkMWBLlYnpKZl1mYNZno7dFW5KAqlUSqImW0VEaUiuh4ouUk0sBN8+JADFXpeMWtPzPp1pMzbB8kCJivtMyZxD4hRG2q3oQi3ICDwzHjX4m/Vf35KNPawfWqFs+uVoXa1eTqJM6lpT7UqhOckjE5mDnDjx/3dPR1swwUV/h6pHEC4W8Wl31iwZENVbg4L41vSTaw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:12 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:12 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Date: Wed,  4 Oct 2023 07:58:50 +0000
Message-Id: <20231004075851.219173-10-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231004075851.219173-1-het.gala@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::19) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a55999-e384-4dc1-5677-08dbc4afcc27
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzUHI6DH4ZNhJoX0RkHqWPtEaFlB5+3UuYqXIshfiLxU0kRL+w9hTTat7sufOu7Ute4HvmMQJiJJWMjmnkW7q/OZwxAdXDZps1uzSuuhx+m9kJ3R+O3tD2C9InsT6SvK8V4NUndBHkQjJK2qJtTRwg739HQO7z0P6+a7G9YHXU6eWSA2WAbpFBfjFG2t4VNaklv+D3rWjOQGVeVk5cJhDXboSvgqaXqsRQkcZWhvsCqk/vvbhGfUf+xgLBdJBlxdoT/jvWOdHr+zBNg9zMhVQZ+wkmfsFaUaLuNmi0qsoUFYvwYnYh5r8hXjN3/2fX7E/MV0xekbuRyw32L1hgAUZ+AN7i5SirgQLgCdURtBFOKlu9G6BKdy5oeNnBCXU9J9o5G7Q/lbhDcQvDg9hRVBf4qkldt+MGC8+PdcVg4CFGO5tD4kqmEiKkKNTZpfBJdhUhTn4PA53z1e/wmBlHZ7kOWl4eisRTlJwP/YpZOBeydVqjW6EkUkhYoDDgjObHC5CYA7wLT0bPQ1Uou9lwM/EThk4+fVDmwGPQkEhIIIVuIZr5uCQDeeBEz8PYpr8wx5Ss7jG22i0BzIw0QPfX88I74MKobj13kDCTgzX0LDOB2n5uhvDC3rV+4POQLjkHblEyUHdw1+NDFtb/3zE9fTqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(66899024)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckxoTFY0NzdnZWxnMENqaWJmVEdXNUczUmttWkd0N3RMbUlSNVJDLytNcnNq?=
 =?utf-8?B?NjdFRTdma0hJcDhpd0p3dXVVT3RFS0VHd2llSWZybE90bWZaK0FmdllzbW0y?=
 =?utf-8?B?TlhtZVVDRUY1Z0V2L0pFVGZSRFpDKzV1TTc0KzZXY0lkRUlVdHZmVGRxeTEr?=
 =?utf-8?B?WFdnbDNmWDkwUnVCU3NnSEt1RUFCWU5WTkZQaEYyOEJDL29CSmxpL1RIYnQ5?=
 =?utf-8?B?M3NtRDdFQk5LY1RZTm5QZWsvYTc5azZIMHVtaE9UNTA4ZDVKdjJyMkx2dXdI?=
 =?utf-8?B?YmRHc2VBTUNoOHlTRTJCQkRnem9EZTNibWorV1I2SHlVd3crRHJOL1BrNEho?=
 =?utf-8?B?NzYraGVkeU5GODIyT0ZDVjFPd3NlbnhvSXdBdm91YWYySkVpUTRQN05BWVgx?=
 =?utf-8?B?ZGxhTmhrRHV5RWtlRzFlWVF3anpTenFGMHV4UDF5blRYVVh4UmJaajRqNVBo?=
 =?utf-8?B?WUNqMCt3YUJwSGl2WkgxeW5oemFUZXc0aktldHI3OThtakhnU2tOcWpPUFo2?=
 =?utf-8?B?YWwzOFBjSTVQNjRmRDlVM205SEVkNVFkVHhHWHFSVEVwTVBMSGZ2VDc3TEtM?=
 =?utf-8?B?LzFJcTlkUDR2QlA5YU9rOHRTQm5FTmN2d2NPazZrd2tXL2ZWYkxDQm4zcWlO?=
 =?utf-8?B?QjNYamdwMTZneFVnRWQ2N0FjaWk5T2xhUlhMbEZDYzFQcXNGdFJEcWljK3R6?=
 =?utf-8?B?aGRmZS94cUJ4VmlXS1pEN0VtTjh0NWlydXVHWHZtbXQrcXBvdEdNZkJDbHhU?=
 =?utf-8?B?c0p4VXNtKzVqSi9EaWU1dkRlMnc0LzdPZnJoalBOOHJCZzVvN2JnaUtHdnRH?=
 =?utf-8?B?azhBTGZyY2ZNNmhjc1dZR3ZJZ1NKSkkyT01BVTRQb2VHeXpid2dNVzE0N0xi?=
 =?utf-8?B?MWtEb1BJaS9QdDZ5RzVYbkRBRjdoNGp5VTJPaTd0TXoyZWplTTFqUUdXc2Ni?=
 =?utf-8?B?L2RteDhRTlBnRmNrWXMrOE12U253bUpndnpQdnhrbW5Wek1SaW5ROWZlcElC?=
 =?utf-8?B?ZmVydFVmMWVucmdoNlRaZjBpTTVXY1VJVTUvVkpZQWxJYkFmQ3p5aVVIbUpp?=
 =?utf-8?B?YytSQU9VZHZ5ZlpTZXpHZmxhNXRwZ1pMSUtLTWYyUEVPb3lJcy9TMWdFemgy?=
 =?utf-8?B?Yk5UUC9YVDI3dWFGMWRWaVJIckd2ais1OGdyWXpoa0JsY3NGc0Y0aytHeWp1?=
 =?utf-8?B?NWlsYXMxNmk4d2NJOC8yTzdnSjV6Z1RJWkRKNThqVGlzMHNpWkxQRkNPT0xx?=
 =?utf-8?B?aDVYcXhwNmdBMFJ1UjZiV2YzZ2dCbjhGb3NnVmJuUms1RDZNNUZZOXAyNWdq?=
 =?utf-8?B?QkM3WnVqWThqTHIyYlhlbTR2eStYZUw1Mlk0V2dFc0lDY00wNTFaQ205L3Bl?=
 =?utf-8?B?bzB5dFlZMWVQM1l4ajBmV3lhLzBMMEJYNUxmZE5JSG1TMytNRU8waDN1Rmtl?=
 =?utf-8?B?enhoYklOcXFHeDlXbWhhTlpOWFpkRHhUTEZmMndHUGVCVkcyQ3ZVdDg2bm0v?=
 =?utf-8?B?Q29oV0ZCNVI3Ym9iOTUyZkVPT25Dd28walpaZjNweFJSaXhpUG9PY2U2dTVT?=
 =?utf-8?B?K2pmNkVSbVpmWXBQVjB1UkU0WS9aSDJEazM3dHVUblhiajNDeE9Od3FnL09z?=
 =?utf-8?B?ZWQ2aTBVeXBxVVN4Y1VqSEtic2Z3MzNRdDljajhwUXBYQWk5Smg5U21tcUdD?=
 =?utf-8?B?MFBmUHhNRytDWUtOcjU1dVRsOHl0SGxPczV2Q0FOY2xhUlVjODBtbzFMaDhT?=
 =?utf-8?B?SytJeVM2MTRWRGladWtiS210aCswcUM3Q1lBL1ZLSjM2MDdkWlpTdDg5NVR6?=
 =?utf-8?B?QUowNmI5S012Sk84UUF4aXFaWHBoc0s4akF5TGlqdUVVLytsbzFpblhXaitX?=
 =?utf-8?B?MS9GQ1hkMFZLd1JLS0podkNHcm9INGRLanFIc25oZEFtNERZektZL0F1cDBp?=
 =?utf-8?B?RjJleGVGMTF3N0xHYlFyNTdKRXpQY2wvZHc2amp6SEorNmZRTlRWVmJUeFc5?=
 =?utf-8?B?WWIyZXJvb29qblc1NVN5K2RYTFVJWVJFWkxzN2JhcDlZTXVrLyt6aVg4SFNU?=
 =?utf-8?B?TWRhNE5ERnAzUGh3TllCOGp0UjhMekE5K3liRzhhQnc4Wk1RK0k5V3RBQjEx?=
 =?utf-8?B?cXVzaHhyWFFNbVFSckd6UnA0STdydFh3TnFuUmhQWHMxYnJ3UHhvdHhnb05y?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a55999-e384-4dc1-5677-08dbc4afcc27
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:12.7605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR9iijSMI11FJFolYlU63dd/mFjskiaNOUW34oUz/WatNvAluLQV/jkmIk5EMRH+qu8bMwE8ITzFTMaP1pOByQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-GUID: _9TMXQfM1E26ve2hD0El4SuO1LrC6Zve
X-Proofpoint-ORIG-GUID: _9TMXQfM1E26ve2hD0El4SuO1LrC6Zve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for hmp migration.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration-hmp-cmds.c | 15 +++++++++++++--
 migration/migration.c          |  5 ++---
 migration/migration.h          |  3 ++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a2e6a5c51e..a1657f3d37 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate_incoming(uri, false, NULL, &err);
+    migrate_uri_parse(uri, &channel, &err);
+    QAPI_LIST_PREPEND(caps, channel);
 
+    qmp_migrate_incoming(NULL, true, caps, &err);
+    qapi_free_MigrationChannelList(caps);
     hmp_handle_error(mon, err);
 }
 
@@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+    migrate_uri_parse(uri, &channel, &err);
+    QAPI_LIST_PREPEND(caps, channel);
+
+    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
                  false, false, true, resume, &err);
+    qapi_free_MigrationChannelList(caps);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 3eae32e616..7d2d5ae329 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -431,9 +431,8 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
-static bool migrate_uri_parse(const char *uri,
-                              MigrationChannel **channel,
-                              Error **errp)
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp)
 {
     g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
diff --git a/migration/migration.h b/migration/migration.h
index 972597f4de..f9127707f5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -511,7 +511,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
                                       Error **errp);
 
 void migrate_add_address(SocketAddress *address);
-
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
-- 
2.22.3


