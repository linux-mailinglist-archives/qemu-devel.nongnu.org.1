Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E529570DCEB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RQW-0004kl-Kj; Tue, 23 May 2023 08:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q1RQB-0004fl-AV
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:47:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1q1RQ3-0004bO-MF
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:47:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34N8Astg032137; Tue, 23 May 2023 05:46:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=vJOG/bH4aIXQQiO5usbI34Y3EmVFnDNLW2cGJEnly+I=;
 b=e4Vnru6YRWhNPY9/Skak0kKLyOWKmU5D2A58H5+ZQK53IGjDqC62pHX4AqgVNdVTYHPd
 EF5l90WwmoJCv3iVDP1ltOUi7sqBk38msJU/wDKKTFAUfe8BU+axG4RpUkBs1SDQlJIm
 kavZb208J89nmNNE/H7SuJmof2BjxW/rP0beuRK3gOYv7tB+ou43sKZTblazuLREJ3DR
 vDf7eZO1XFS3guhN6Y7tQ1WuTD/FqTiWXBu3HG2mMg5SBGHj5IlEe7zI69CN5Hlzqp5P
 +uHa0CvpUZkz3LRy3vmaRsf55Dmv5PG6q+VyiaFnZ4c10x1zYJv6Z4rQxXpNiaUpxLH4 8w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qpwhce0bv-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 05:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNWE+s5KR0xuh3o1gx6B/5pm7SJLCRxDNVS9J9E+vMAZ30IQAELQOa9cx96p3FmDMejSkuTXHiSDHMok/n7YOPSp6oJnihwQE1GX7Kk5b92hxn100YnR4pz2a6yUfd/3lWrx1BZdRxcVj/cOhCk8aZ03DPPjzaGGiKBdG7yx8MJCBQPVxSz0V8bxBlL+EmEkKUzBiPgvkLVqJSqAUYvDKirq7/ZC8ag1hJtGCAgQw6Umu5aDjm0szrfSRR551C+mJzrLNktMixCmL9cZTkT/tBQ6v3yJnsAnuuKeezQ/uxWsDkoeTGp8wsWirlVsDExBWofxRzL/wVPGkZF7wzs7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJOG/bH4aIXQQiO5usbI34Y3EmVFnDNLW2cGJEnly+I=;
 b=WofgMqwf1aXhnou3JqnsgopZPsU7NFyLpRvPgQt9ihPO/1rGX/r6pFnPiBgbUT+013xKe0AEzCvT1LInb7dOcbuZY+aD/EQqOrvoTygT/g5CcmWgPo+X4xlW6dggaxipgLFhZcP0DaohX2XDmcShpmT587s8WWfs4xGNWTNi8jY6twQQnl7vSkVN4FRpNUXK8AztVD1D1+Qc1CdIMmpslzzyqopO2nZ5+9juBu5apXBn/ixz64V8kR9O9J/whruXKUH+0t4NjJeKHa1+eKkbG8LdXBKJJEaLmMfxwkE7HA2FVPxNUabIr48/Det8zETupiPDVKntYnX2pvOOAHbHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJOG/bH4aIXQQiO5usbI34Y3EmVFnDNLW2cGJEnly+I=;
 b=p2+XY8nOWHK3gYFQ0LCFcZQhi9NeFHReZe+db5rJG33udoF4Js2yPqsvoJpRt2eEWJ12PryoClmzGU8ZAgGUjZ7yvRfasyWKp8oZEx5vVEeGDsy8jivP+sYfq4vNUZ4FhNc+8/zR0sRIf2ksrOc4gxmsoOw6pxct8iqRvBUkmCQD+nq5uKUqovSUIBBKeP1UINnIDcVcll7c77uGod7lDyLftLKc6dwVgCDv0+/czKgYujycusl3BeIbUNhg9o9Zp8zTL2HfAA2fHSIR5D+O2RjtZp5gXSqchBgMw+lQ+Mj4nREBFRM0D2402+aJOxspz/itMka6sEmgG+r7p58q8Q==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CH3PR02MB9516.namprd02.prod.outlook.com (2603:10b6:610:12a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 12:46:54 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:46:54 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, ahv-india-host@nutanix.com,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v4 2/2] migration: Refactor repeated call of
 yank_unregister_instance
Date: Tue, 23 May 2023 12:46:38 +0000
Message-Id: <20230523124638.16270-3-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230523124638.16270-1-tejus.gk@nutanix.com>
References: <20230523124638.16270-1-tejus.gk@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::20) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CH3PR02MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: e5992089-2711-4e0c-6a87-08db5b8bc925
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/N+dpR6elBhtnvoi1MZvnJTjthykIoB8koAP5ZXBSYk1/ANr+e0xyT1tIk4AR+G23araxiXpJmp5nwibrH39nGj/FiIySBdmnJU1TZwfatKNck6w1+uOvr09Qig54n/O+QHLowBPyRKUoR61Ize7EZMB8u6jyHzvJfFQEj7yCjRpmcGHIVkRRcANEycFOfLs20yzWBWYYAXZD/A3fYpElq0V62r7idL5NphjzmOlmpVuOZhRbxj3ZQhzSwiFNMLPipdoUGeWikcC72euuAf1cC4/xo+eJsL20A/PQHK09Occk0RaT4mpozRZdUmfCkYX7ClLPCNf8s/un6es1H7b3E4xr/2LclnkLHOOzZERTxEcYO7hZBBB1rrJgl6TKfJIJo2oJFfF44g5KRZZ45VjwBb8kAzz+33rIXGG+aj6aOzEXe4nUvgewrH8ftvpMVWcfdAPaSO60ufK6r4+QsVYhFpqYgYvs+0O2O9YmLH4/Re6zl9ENVDOwk3qP4GAg1vQY0v/x7i07Szvxt2w1TyPm89zWIyE00O+F//BQJ1TxLq3me1rJGqBjTH2/NqzxPVgro+SXPoqPex8Zo44XPwj0BpZDYrSJoFo2KjXi2lq6Va8xEurCGIrXHhclxUuaCs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(52116002)(8676002)(8936002)(5660300002)(86362001)(6506007)(26005)(1076003)(6512007)(83380400001)(2616005)(2906002)(36756003)(186003)(107886003)(66476007)(66556008)(4326008)(6916009)(66946007)(316002)(478600001)(38350700002)(38100700002)(6486002)(41300700001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW5PNDlPOXZpL0NDYmV3KzNja0kyZXl1RFhTSzEza2xmR1NzZTNKMEdrVTJ6?=
 =?utf-8?B?OGdCclJvenB4MERPeGx1OWFwTGJYQmJib2RTaExpUEtvVk8yWHhXZk9WQXhQ?=
 =?utf-8?B?RkdFYmN6R0ZVTnhjMUNITXJCR1l2MURkazNLM3FnRThNckxrMHRRZXZoUyto?=
 =?utf-8?B?ajJjU1phY29OVWZ6MGVDREZ3N1NMMmI2MG1ydjNMSU16N0ZEcWZHSURoMTdl?=
 =?utf-8?B?blVJUUErZ3pVYmpJZENhVlpJZjJoWlh0bWZmSTRkbXV2bFNVRFdEQ21vYU01?=
 =?utf-8?B?ZmZabE14M2wwY09ZZXdhR3lRS1dUQmN0cWJiNnNvWkFkMHI5UGhEMUZCSFpM?=
 =?utf-8?B?eVcvUmNUK0hSOEZvTlNWckZLMUtreXRIcmFxaUx6U3RxVzVIK1p4Nk0zNlZa?=
 =?utf-8?B?OG9jUSt0K0w5YzdveENVdk1uaXRPU00vTUJXVXFnMFlTbjF3aTB4RFRnY3B5?=
 =?utf-8?B?Y0RVUlplcmdYbTFrd054K296SjkrQ1hWb0x4R0hjeWZmam55RXUzekZrVjkv?=
 =?utf-8?B?eDg4ZlhpelE3b2pzSGZMcG40R0FGTDcrWmllS1U2K1ZpRUJsd3pTL21MblNK?=
 =?utf-8?B?NDhVdElVcklDR1JzKzNwMUpKekg5V1ErN3hKS294eWNBaExwb2JneHc5eTFM?=
 =?utf-8?B?c0VBanNERWo1S2RjNitJUVpxWmRoSXptOVYwZXhtTlpvU2ZGRjNLeHZWNGIv?=
 =?utf-8?B?dVp6RzNtRFpoRVNKcnllYU5nVzRCd1JaY3VTRnBMTm15TzllVzIyOUJ3WDNs?=
 =?utf-8?B?dy9rakgvNzBNUnVJZmd4SVl3dWU5Q2ZzUUEvRE1NOGFjUlpmNU9LK0ZjN3Ey?=
 =?utf-8?B?Y2pHcERZRjJCdHFqdEx5NkEyZFFDSFJaZ3RUZ2dsdDBJLytQcXBHK2xsUlRl?=
 =?utf-8?B?OG93YlNZV0RrQ25jWGdvT3hsdVpDRno4T3VhTW9Zd2VqaEZmRU9JZjZ4K0Nr?=
 =?utf-8?B?OWJ2STlTTndQQnYxeDdBdGNBVnYrUHJoMlkxL0QvQ1lZREJkZ01hZlRzYnUy?=
 =?utf-8?B?Z20zYUJmdENPZFIyS2RjSUpyRTBYYVdHb21vd3lLbW9GSnU1bWNPaE1UK20y?=
 =?utf-8?B?cCtib2NFQzFSMlNDL2haQlowMkxUZTdId08zUXpTdU5tQUNUVkhzblNoREVJ?=
 =?utf-8?B?MHNSWnp6cWJGQUlxdUVOWnFzdUFEMWxDWVp5aExIa21aZHA0RlBUN3o5N1Ew?=
 =?utf-8?B?WjUyY0dGaE1VMnF0Y2Z2V3RsakEvQWZYMVhtUTNLN09oOXl4TEJ4WjUrYUdx?=
 =?utf-8?B?c3dOQ1M3OGcwUUJESGdEVnRsUm9NQ1U4bC9uR09YbXNKMWNmS3VKNThBa003?=
 =?utf-8?B?MjliVmZydU5LVHhqTUZ2cmZ1bkg5UW9zWVZzeXA0YUVJLzBrNHRQaDNMZTd2?=
 =?utf-8?B?K1ZOZ3NoVzNpa3B4bHJlQXU0TW1FS2E5OWMyaHZia0FCTFJ2NklHMWdEeThL?=
 =?utf-8?B?UHY2aVg0UDQ3d3ZDc09CT1RTK1Q3bm95bllXOHVYTEpJNGdoZ2JmMzVhT1ZN?=
 =?utf-8?B?anZtalF0Y3Z2a0NmMk1zK3Y2QzJWZVFjVGFpK1BkcDdHMTBuS0FFVWMyWkFo?=
 =?utf-8?B?aVR4aGtGU1lMVU15RzFidlc0ZS9RbUYyVGprUTQzQStOSElZRTdiZEdJd3lD?=
 =?utf-8?B?TlZsNERMZy9ZSEVCTlhrT01mZkNoelUzSWJ5bnJ2d3ZTeGZNVGhkelJHcHBQ?=
 =?utf-8?B?dmxTUFM3RUM1KzlIdUQwYUFUNFRjdWJXNDFRYlZDSS9SR2Y4Qng5U0FjeWVV?=
 =?utf-8?B?MForMDVmbnRiZENiZEJ1dXpyeG01eVNvSENoOUJQSnRkbzZwWGc2R2Z0dEFv?=
 =?utf-8?B?OWM3aWNPdzgrekZWSGZOa3Q0Q1BRcWltcnhLV0Q0cXRrNGZJcFo2ZUQ4ZFFy?=
 =?utf-8?B?NlFLaXgvNmZVc29IYWJHL1p0L285R3BkWlRzTGRKMVZlMTRld2VmQWg5UDJy?=
 =?utf-8?B?RUdiTnZoV3lJdGFIVFFDUVFNZ3Z3WXBmWUFzTDFVMWN2dDdDVTNOMU5Xa01a?=
 =?utf-8?B?L21TYVM1d2VobG1BMG12SW5TVkJnTlc4c3lVWjkvVzZXS0hWTlFUeldXb1po?=
 =?utf-8?B?ZHJhM0dVeTdWNHp6eTFtYlZFR2xobkVKL3FiemxtWDI0ODNBUUJVLzBHM3dB?=
 =?utf-8?Q?36o+kL2g7IQDjgLJYWPm55DnJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5992089-2711-4e0c-6a87-08db5b8bc925
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:46:53.7865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STVRr/4JE47EtLJUjCpWRe96dLPFIZ9rwScp/KWj7uiRKi8I6vBdPPcfMuUm+PI3jMqamHAotpXbPJr/lvq0MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9516
X-Proofpoint-ORIG-GUID: oDSaPWDN9gM9F_fPH9tFjpjl7LQOYDeq
X-Proofpoint-GUID: oDSaPWDN9gM9F_fPH9tFjpjl7LQOYDeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_08,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

In the function qmp_migrate(), yank_unregister_instance() gets called
twice which isn't required. Hence, refactoring it so that it gets called
during the local_error cleanup.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 migration/migration.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 161d4e9a71..b2555ff45d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1663,15 +1663,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        if (!(has_resume && resume)) {
-            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-        }
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         block_cleanup_parameters();
-        return;
     }
 
     if (local_err) {
-- 
2.22.3


