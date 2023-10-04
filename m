Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A47B7955
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 09:59:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwmk-00052Q-Ia; Wed, 04 Oct 2023 03:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmj-00052A-8a
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmh-0006KA-6i
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:09 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393Kj15r026467; Wed, 4 Oct 2023 00:59:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=SsXnl8g0BI9yYvYiCQb7gTsJQhOjoTiy/CerWusjg
 /w=; b=V+418kBX0UPfLc61PHZgLUFDhbr9OQYkMzIbewLnU/qsJdNUcMM9JDpW0
 guBLfLgt5i9WwDdTMafmVdMLooj/PMV04DWy4aGbEaKxQuUxXHCZ/llc3yxQ03zp
 xf5v8IOmQKV5QvUhhcPjNDDFMTWBWfYdOELGI9DCrT+b+MnKyNMsDFDJC60d/Rzo
 9ya2MArc6hqG9io47IhwkUE3aF2xDw2OPMyNKD6sT74hVwH7e360MBrR3AEw2qwg
 yOwqPg84o1VsbByD7BRLp0YdqSBFZN3GGyq54WmM4MsawRNXzaD2ehDGVXuNbZBU
 JYvu62cRxC76Bj0Rg09hygC67EHLw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3teg0rpr8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS37nVEIMv8Er/2nhK+oLOSuGG3j4MIVJXdflEQ6b8/luSLS14HDuw9eJibFn8eQWwWAuVdIAo6TUSrPi9iJ4apPLF5VzNMgv7l131xFiFWVhlRzDjjqisJNiEORquxTGlbvd5cVYKuuUaPmlg5C2uxhvi9jRyhdy2PZWh0tM7jEKqYmrDKx8ltFZGUg76cYpA037i1oaF7wQWU6b8T1tcdNu6uAWFZplsZAq7e1dB4+cutxcx9FMWEON3UXxCAlo9Bq/CUMTS9wncXu7EOWLxqJPGaklaKavntBPSKHwF/yWZvvEWA2SjEu+eVADbjZIBTzrupJGnhjFcMQnbudeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsXnl8g0BI9yYvYiCQb7gTsJQhOjoTiy/CerWusjg/w=;
 b=gPQuz7Vg4ja7nRfVDjP7XRgu3t6LdA0qjTwmem6JdLb0ojIJ3+kpb3xvBdKmHjfLQsZCX47H10b65Tnz5KVdi8rZBvQGPL2d4ty2AV+iuIG0AyNBkjhdkhSFTJJcHos50uGWhwSYMeVAe1A5MShik3gTVKDszOp7wlfKhFpqN4L6QPkmHns43ZPqg7DrC2G2hMGcHzQjWKSnAAFOP5/wnrCHSkgLbKGT/ZK5EFPEEuv8lnpgl+ZuDEO14dygLGICQL8mS28YdjFONvi66sounIT9I0q8jbFY5x7iT+sFzCn4yW9Pp1SUo838VjP9xQ1gqXxdR9KxFE+aUj8KuZ5VFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsXnl8g0BI9yYvYiCQb7gTsJQhOjoTiy/CerWusjg/w=;
 b=hh4LJZHvHCTas05yXsnh1Dzw3hR2ayjEfIJoJYJhczr6nB92/4l85kHXG9YX5tysUs+JB6WhKwGmIyN0rLBdCgjLzvTOAgvXGhTmNeunGsxiYsm/bT6OQQq+m7c/VVjanIIs9x15wvNkjSGjDLaDdiaFi0IT5FQwnk7fPDIFljwVfrnzkDFDpUAZ0y4aCuWqHW3TGl8aG4xoNyBXI6bUZQEcrMa1NuNJWpNX4PdTMQ691VHtS5fYlSEhEdodWA2/LvJobNp3GKsD0GIVGrlUH0IYJ5pFwPCLWJ1ib2kWvYjrH+gNu9w+zZXlzXXc+dHmpOGWyElLaTkIcUM9Hj0ISQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:03 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:03 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 03/10] migration: convert socket backend to accept
 MigrateAddress
Date: Wed,  4 Oct 2023 07:58:44 +0000
Message-Id: <20231004075851.219173-4-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26b3e0fe-3ffc-4f81-9e84-08dbc4afc67d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXbLVDzt+40lG6N9OOg49hsdTZAFsnWZDkY2bE39j5didLYp7prWFzXevo3kGT96zg45PzIwaCzR0yYxkUaSLrAF9ZwsBaZEujtgvMYny91736Ybbu2GQZqKUx2e7D6HmAW+XMv0fk6cGUSfimrIC2vlG0mAhOOAhNnvNMk6HVTm0zZCej+0eoBEfx5ikL43c+kOhdl/uxbj3EQ3wsDKnHyTJShepzebDrWpSsFmkza+Wdc9w+x1/S7EWIlRnAO1LWZe+my54jtXtiVNfrhjc57dEE4lRnpDCXZpZO11LUygwd79KOb4B1l3PDAx+pn7Gqy/q7SvZGYnEwGsHdYrgT5bHIuyN1dvTRFIqXJZ3yuDa+dFVOq03mOEgWN/7GfM7mDOa23XuKQ9kC0offem2H8jjZ3ETo2YyigyWvIMwkQe4l9TJTOqQavdov/oDAH6+Y9s70OrlYPshPQr9lRlF+sdlGjteQAb0YOWyJ7HsrGdeyTdCkN/Z1lxYgDn33sExLH/soYaX37hhvamBGhWYYz8kiYtlXZ1LH+5ZV4CLwwB3v2nImWQKeAqgAzxx150bEWxSXzB9sZ2gQhR7J4q1+ryUEBhg8NuylAhF4ENsqtlWKprxkx93gnlzmfIUJKu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ris3dVNGRlgwT205UFg0QTAzRmQzZ3QyQVRFd09wbGVnd1N3Z0czK1JWTGJ5?=
 =?utf-8?B?cVRHZkp3WWYxc0FkcmZRZDJobG04dW5YYkdoNjVlUmpFOW1FdGZselpUbDdp?=
 =?utf-8?B?S01vMXpNUmd3eE1LOVhJNWpRdkhIcmlTZDRxamVvQnc0L3JMUU1tMkg1Yy81?=
 =?utf-8?B?ZGwwRytTeEdaSUllZEVQWkg1SXpqUnVSTlBKYm5IYmdSSjBBWUc1NGUzZDVW?=
 =?utf-8?B?ZU1RSURnMTcvMVRJSkN3bGxpbG0vU1BDMnp4OTN6UzRjMnVFdGtwclRrdTZt?=
 =?utf-8?B?ZXFVVEx0SmVQMWg0ZXlFT0huRW5sRkJTNit3Z0RiUGF3TkZMOEZSRXlOTUox?=
 =?utf-8?B?V2pGam04Nmtobmpqb3BtWHcySU9GNGFiMmE0bFI5bERPOHRtS1VBTnBGUEFJ?=
 =?utf-8?B?VmpkcHVhMDVYTXVLQlp5QXJpS3d5NUJDTzZHQ0l5ZnloZU9wYnluVDVWSUpD?=
 =?utf-8?B?ZEUrZDhWa3ZuSDdYYXpaK1REcUtjdFRNd1pUZmRiVmJaVGZhYzBEQVZvM2Zt?=
 =?utf-8?B?cm0rTFhwRUV4dTFYdTg0cXdXRTdIWEttVFRaOEZ1Y0JlNmE5Y1ZNdS8zc3dW?=
 =?utf-8?B?T1Y0bHc3Y2I0MTRLZlVhWjlTN1NzZ1lHcVpEY0lhdXlDMzlKTGlJMU45TjVn?=
 =?utf-8?B?Vkw4c1ZvUWJ6NEo1NXhWdlN1ckl2THM0YzhtcWVsbXhvbFg0bTducVBTOGFa?=
 =?utf-8?B?RXR5RnhSTllFYk1NL1JXQys0UGlwWVpJaGlyY3Vjem41a2ZYdDJObnBPYWpv?=
 =?utf-8?B?Q05UYW9GK1dqdjFOUno0QXVpenhxMHlGY3M4ZGwvOXBEVXJhclV0VGtqWFMr?=
 =?utf-8?B?a042Zmp2NmhKN0pqb2ZvZ3R3ZnJ6UmdEMHRIRUpNTXhjS1ZHcTNnMTRDaU9W?=
 =?utf-8?B?QjRjYlpwYnRtdll6OXJUYmFQOXRaRTRmRmFVcEYxeVMrclprU1F5RmM4dXhU?=
 =?utf-8?B?TWNJV0NEbXhHSUVtMk9hVUdyY1cza1l2UFMxcFN1ckNIMmFRU0p5d0tFRDcr?=
 =?utf-8?B?czhNTDc5b1ZqNXY1aWFnSUl3d1dHZnlzTmJDSU1oYnZCaFhBWmQ0MXEranJM?=
 =?utf-8?B?MVQvc1ZIbkhndFhlZ040ajNBalJMcXR2WlF3Q0ExTk5WUkhWNUFYb1EzMERV?=
 =?utf-8?B?MFdJRWpTQjlsQ1d6bjVoNzI3Z3BKdDZKS2U5d0kyYUYzRmtZT0FOcXhpWXdr?=
 =?utf-8?B?MmdhUm84b1dsdEVkL3pkTjRLWWZhWjR0anEvM1dEbEdXZlNPdExtMDZabXJR?=
 =?utf-8?B?cVV2aHFrQ0VFemIwa2RQYVRCOUQ1N2JJbnl2V1FpMkc1aDFqSzNTYlUwN3pl?=
 =?utf-8?B?NmhmakdtZHRMZkVoV2J3THdzMEJjU1BDVE1ISGhReGNVR1l6RDRBVW9aRm5X?=
 =?utf-8?B?WG9mZGd5dVVNWFBNK2w4Zjh6djFWM08zTWsycTI0ZFBINW9KUXpYQjRhMnV5?=
 =?utf-8?B?ZEZ3ZWFubkxwRnRiTjZVNXdzY013S1VoOEtSVHM0NVZ6RTBSK0Q5UTMxSjd5?=
 =?utf-8?B?R3l3UVRteDdLblU1cS9DVFJPazI4OFJVOUkra2d3UjB4eWlvWEljK1F4K04r?=
 =?utf-8?B?bS90Zys0QU14QjQ3YnM4b1hTS0NRbUNJUGJ2ZVBsdTNMRFhHeHZWUCtLWnI5?=
 =?utf-8?B?aWVFTlBmMnpNbDVxNE0zSVJHQWJUOFd6ODhRODgvZGpmaDRGRnF5TEVwWHJH?=
 =?utf-8?B?Sm1PTzNGMkJqK0NLUnRJTVBpNW1VMFhtVGJ6dWUzRHVxTGpZNjNodXZvVldx?=
 =?utf-8?B?MWhhVkpUM3BSUHRVZy9ZVFppNGlPNTdXU0VaLzdHd0lUM3NXeU9wWFNmZVFH?=
 =?utf-8?B?MmtnNXZSZW5lS0lGWkg2REMvTDVKZXFBTEJzUXRhWVJueWVJeTNFdHhwaUUr?=
 =?utf-8?B?VkFDY1ViQkRCTXJKMGM2Q0NvWG5JRVBaVGROd3c4OFlneFdFUzlsTGZJNDRS?=
 =?utf-8?B?bFJMTkpQUk1UZ0IzT05uNG5BWEZrMVZwbUZjWFFleHRBN213aGlJMUlucC83?=
 =?utf-8?B?ajFhcUtBV3hIRW9qRFhLMndmUi95ZDV4MXVGUFFqSzZZYU9SQ2RZeFUxS0Ur?=
 =?utf-8?B?dVExdm5acmg5ZFVjUVZySjVtRzUyeWVjTmRaTkVLSDNsdFhsWXNTaEtQTlBW?=
 =?utf-8?Q?8VDapCMjE+Mvh8oZVl/wgT34o?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b3e0fe-3ffc-4f81-9e84-08dbc4afc67d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:03.2865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEJRgVJ27inEka72bQe/BkTyaATvAtdAerE9GroDoSmIipWxNqMaQqx7mcj9wNUp2C6vOtCaC/L8cm9/mBlkXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-ORIG-GUID: c7cMzN2RxaSr11LhZbn9Wfd59G2EQXYM
X-Proofpoint-GUID: c7cMzN2RxaSr11LhZbn9Wfd59G2EQXYM
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

Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for socket connection into well defined SocketAddress struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration.c | 30 ++++++++++++++++++------------
 migration/socket.c    | 39 +++++++++------------------------------
 migration/socket.h    |  7 ++++---
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dcbd509d56..b773f0110f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -487,18 +487,21 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_incoming_migration(p ? p : uri, errp);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_incoming_migration(saddr, errp);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_incoming_migration(saddr->u.fd.str, errp);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_incoming_migration(p, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1745,18 +1748,21 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         }
     }
 
-    if (strstart(uri, "tcp:", &p) ||
-        strstart(uri, "unix:", NULL) ||
-        strstart(uri, "vsock:", NULL)) {
-        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
+    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &channel->u.socket;
+        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
+            socket_start_outgoing_migration(s, saddr, &local_err);
+        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
+            fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
+        }
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "fd:", &p)) {
-        fd_start_outgoing_migration(s, p, &local_err);
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
diff --git a/migration/socket.c b/migration/socket.c
index 1b6f5baefb..98e3ea1514 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -28,6 +28,8 @@
 #include "trace.h"
 #include "postcopy-ram.h"
 #include "options.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-sockets.h"
 
 struct SocketOutgoingArgs {
     SocketAddress *saddr;
@@ -108,19 +110,19 @@ out:
     object_unref(OBJECT(sioc));
 }
 
-static void
-socket_start_outgoing_migration_internal(MigrationState *s,
-                                         SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr,
+                                     Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
+    SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
 
     data->s = s;
 
     /* in case previous migration leaked it */
     qapi_free_SocketAddress(outgoing_args.saddr);
-    outgoing_args.saddr = saddr;
+    outgoing_args.saddr = addr;
 
     if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         data->hostname = g_strdup(saddr->u.inet.host);
@@ -135,18 +137,6 @@ socket_start_outgoing_migration_internal(MigrationState *s,
                                      NULL);
 }
 
-void socket_start_outgoing_migration(MigrationState *s,
-                                     const char *str,
-                                     Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_outgoing_migration_internal(s, saddr, &err);
-    }
-    error_propagate(errp, err);
-}
-
 static void socket_accept_incoming_migration(QIONetListener *listener,
                                              QIOChannelSocket *cioc,
                                              gpointer opaque)
@@ -172,9 +162,8 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
-static void
-socket_start_incoming_migration_internal(SocketAddress *saddr,
-                                         Error **errp)
+void socket_start_incoming_migration(SocketAddress *saddr,
+                                     Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -213,13 +202,3 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
     }
 }
 
-void socket_start_incoming_migration(const char *str, Error **errp)
-{
-    Error *err = NULL;
-    SocketAddress *saddr = socket_parse(str, &err);
-    if (!err) {
-        socket_start_incoming_migration_internal(saddr, &err);
-    }
-    qapi_free_SocketAddress(saddr);
-    error_propagate(errp, err);
-}
diff --git a/migration/socket.h b/migration/socket.h
index dc54df4e6c..5e4c33b8ea 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -19,13 +19,14 @@
 
 #include "io/channel.h"
 #include "io/task.h"
+#include "qemu/sockets.h"
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
 int socket_send_channel_destroy(QIOChannel *send);
 
-void socket_start_incoming_migration(const char *str, Error **errp);
+void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
-void socket_start_outgoing_migration(MigrationState *s, const char *str,
-                                     Error **errp);
+void socket_start_outgoing_migration(MigrationState *s,
+                                     SocketAddress *saddr, Error **errp);
 #endif
-- 
2.22.3


