Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7417C711B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:13:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLj-0006PM-6O; Thu, 12 Oct 2023 11:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLg-0006P0-Uh
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLe-0003h3-Ay
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:40 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39CAbVNU017937; Thu, 12 Oct 2023 08:11:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=QYQt1F17I/3pIxR2dFagkPoStsTfaHb2esFTBW9ip
 x4=; b=X+C0m60DbxYY2Jq1RWQBqeAcRnjn+DBXrUl5GtPeKPmZ/yKNBPeRJvMm2
 PMEnEtPNel/U1xVFbJ3oOMXuTHahcGa4eqIvEFyeBuCPMqMrz/FDFRpPX9NWstD0
 TvA18MQBZ0i3fvMulKoc4YUR3TlmKs75kUsfsVM+SzW5cB13vrhxiF7XnESGSmx5
 x7DJ2UbyyaOdUyDv5kFV0JbLFOQr3xX8uaJb35LgsRZ8nw5zfxJvLiRIij0Pyyv8
 XOyD9maLBdv9BTzLXodJM1qfQjTTKxE3mTvJRd+KWNTT0Sgck3ii3Rei874x+o25
 xhr05Akhujnky4RB+4d64GkwVZ4Rw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhv0bhs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKJIyC1Oa9wZdhF70CGNMXP1c2GXmA0lSZ3mbmyHrMC8E7SBksXmRekdaexQ8xoV38N9tFaLmGF1gWOlm/je1Q5E4O8ZpkX5GSoTYX/atjkhmP4qZ+xCC0956KVxqPobmA5Xucwf7yL1zE8YIawkxWo95yf51OE6lh+lt7aGsRIWDVtn33QPbx7BgIUhTbIoJL9ZzmDF6pSCYv7GplsvmxnfywyFg7Jb9pvrhkOHnxSxGcwlmvC+kAWlx3dZGhUFcWPvWSuYTEgGGbjk/TbAOhgNQGqsYjn27md/aAft55NVbsfOvUd0hfEsfD1BsLDJPqQ7Bo958t2R2pglG3JKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYQt1F17I/3pIxR2dFagkPoStsTfaHb2esFTBW9ipx4=;
 b=nJLeR94dnplLOOH80AJvksxRcZc+t3QaNk+HriQlofsUI8+kH54px4cePZxdi6Y/5JNDFOfVO7KSvByNH9uVh8VQOHcNyvEHx6dx+GTM0XTwxhwxCbdXN4H2wH5+IzP4iy4PEqShJXbyl0O2Sjly/0VmALs8NU7wFxrw5DUn3MwvYGB78Rwws2q89dDIllt0YbmLlqIQ1Dl5SP6L5/59KMp+P+J681K6iy84aMqITuayeEgS9Bkp9Pe74R5l02CqhDR876ypF6cGXauN7TBLpWPyaWYfWTiCGJvim3FQikYxJ0saywUy/v4qV17k/Uw5nY7cn5oGNufkel560qnwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYQt1F17I/3pIxR2dFagkPoStsTfaHb2esFTBW9ipx4=;
 b=yCAJ5Be8WcDy7IrVmUBKLcNsglYexFhBupvBB4wOEE34GTUGTqtcuyYo5LEtL+KggM2Nrh8ZEprdXVMt4xbB03GiZ0dEjBfgU6eeJ/wwDA+KbHu+ZPO+cH1pn8gPQZlxfL9Zh4JCBlRWQXZDVunmyFoZoTvtdGWIiGUKMkOQQD8J2N9wEEnlL/hPhxtpJraxu+b+qCR90U8EIpgJ+t1jTRA13ioIB3YehrrYgUiHBGJGVubcCHy/3IoIyim6zpmE4OQSzD3NvwBNspPWfN+MnO+Xpsgwgb4JbszhvsTjpzVDcG79JuEn+kdT7PAuRncIGESjwOfSEddkgLY9evKWCQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:20 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:20 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 06/10] migration: New migrate and migrate-incoming
 argument 'channels'
Date: Thu, 12 Oct 2023 15:10:48 +0000
Message-Id: <20231012151052.154106-7-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1afd85d4-e513-409a-9ba3-08dbcb357d4f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQ38UTALS4hVRP4fEQkVwBiC26SEg0oBF3R3s9f32WFagxRrtbpkePNg0axP6DnKuZcnTmAY7/g6iOi6d77NckH+xhQOQqmtfxYIb0dqCmoUzaLEmwb6FsOlIdNSjNi+bQ2J6l/QNn4mNIvYu0+c67K6QyvM5Z9zYzk8juGgA/ctyZxomOk37+7o1RC46CR1peOnOAVjrHSoQ4A5w9JioaBAyihwFheUuUSASDzJGXuqoLgN48s9dZtBGlUSBP6u/Lql3FK4aulaB0uADPCpSybfpNHc2iU0pw68jJ8STezrqwQYn9DYoaUUU6sSCgDpYje8rYNcalJCBwSiHYRX1/d6kbARDmPJF9pS/bgZHulnx80IuHvDDELUjJkRlZBOOzcfQaWgUGzN18M9Y0SrNvbbVP2IEgq4Hr4WFcSPrQRxfW9pOkJoJ0AtCVZyLn+pJlh0FYGLL2k9wBez6kF/UFsE+sq6MhCL3sdeC0woyUKrwd8gXfwHS4tFgri331sh1XxCo4ZBlnI3xWWpc+y+FumE3K0YdT8IjQcyx3ZCnzvfIBsDMw/B3c5sRU3iRzkjEQn2g3bH9Qk0ESBguVjWdUhcuV4vc+z2WAVsuPm0vCryhIw6FVJMjF80oTKx+FMJYoREMXe5EzmoCRxJnFqa/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWwwdEpOTkpuMFdNUkpzK1p1UHlmaWNNQTRDcEI5SGtoNmZNRlpOc1ZkNGdZ?=
 =?utf-8?B?UXRUciszdFBSbERwVnRwNUc2MUNEMHhsL2xYVDFZZnZTUm4vSVlrcnhSanVB?=
 =?utf-8?B?WEZoVFZjZDQ0RTJYWjNLT0J3TlZmMW95NnJabkI1TnFmTm5QZVZvWExJYnBE?=
 =?utf-8?B?Nml4dWNySVdHSkltVnRxRk8zYnBlZE1IR2k4MkNQbFlERlJMVGJBYjU3cnFE?=
 =?utf-8?B?aEc5RnNuS0JQWUlraHAzbHJVa1ZrQy96UTlRdDk2QnRQMURYVi8rcHliRjQ3?=
 =?utf-8?B?UzBVNVFlazV2SWpRTmJOdCtRdk1DQSs4MDVPMXhydUh5c3ZGN2xqWkZsamdl?=
 =?utf-8?B?UUc5eC9ucEVtYWJMVHJTckk4TUprVHBjSU5KenloS0hUYnc3RXdLNU9BbUEw?=
 =?utf-8?B?WGdtTGVmS1pEOFNpVFRUMXJ1c1hOQjBhMElDdTBjVGpDVi9DcTllaElFZ2Mx?=
 =?utf-8?B?MFUyOFQ5bFZYNlg4bTBaejgybEZLS1p2WWtTNHVBZHB1TS9zZFFFaTdaZHpm?=
 =?utf-8?B?d1Jzc3Z4elZwZnd0dTBSOGRUc0RhZTVwbXJlUlNUL0V2S3NVbjJmSzNUVjNa?=
 =?utf-8?B?aEJtVW9wM0FXQXJuZmFwUVBiOHM2OGd6NkZVR3FhMklndGNFYWZWc0kxRGJI?=
 =?utf-8?B?SVNIa0Q2bGkwU3JSdzVnelZRcDZ2Zlc1YURIMmpaZUVMak12dWlWRGY5ZFZs?=
 =?utf-8?B?dDNiWUM0THJtaVRuTm44SExsSk5iSTUxdklNVXNkTWw3ejJyOU9pcHd0RTZW?=
 =?utf-8?B?M3g4Ny9BYjFMYW9PL2VzNDFPbDQ4enNCYWgvYWxGdFF0RDlibmxxaCtDcnpq?=
 =?utf-8?B?MjF6eXN6anB1UFdFZ2U1NmpvNEFzMVY0WlZSRlZLRnpXajAxNmFIQ3dnb1Z5?=
 =?utf-8?B?OVlpbnVDZStHZU9NTkVWYkxYYjR4V1lsMlZKVlVNUlZ4cGEydjF1NmJaTGRr?=
 =?utf-8?B?MWNYQm1FRU4zV052NkVQRUZsblBnQW1Fd2g0aHZYbWVLNWV1N0xiSXM2Z1Nm?=
 =?utf-8?B?SVNVVjNFb2w3M3BvNXc3L1gyUUo3YVRNaVV1RG1aOWNFWWdZemxOLzdZdVFo?=
 =?utf-8?B?SEpqNkhsZi8zNmhiVW1Pa015alZ5VEk0d3hEajJxVDgyakFIQTNTb2VtTmZo?=
 =?utf-8?B?d1V4eUZDV2hCMUFqa0J4SlpqWlR6Zjlvc0wvaFdLTUxKaGdaTGJQcXA3bUsy?=
 =?utf-8?B?VFpPQVZYcE9HU3BHU1I1UUpXT0pwQVJyeVk2RWN1dm96bHB6T3pJUWlrdkxt?=
 =?utf-8?B?NnlPckk1a3piM01jNUNCdGdaeURoWFZkNnhxWEJ1b1ZIM1VySmdiT2lFckRt?=
 =?utf-8?B?NktSb2g3eFNBbFdEck9Sb0N0RWZCMDgvcUFqL0o3V1dsb1FDYVRKa3JtbXhY?=
 =?utf-8?B?aVRJbjBjSHRUaVJQM3JCU05Ub0pBZ1ZjQXlTSGhsWmN5azlBaG0rK3RsdUlm?=
 =?utf-8?B?N2VsdGdhSXVubzAvNkZ0eVlzbTNmUWpFayt5dU1zR2Q2azJ4TWpCc0FuMWo4?=
 =?utf-8?B?WStpZUNDUFd3SG5nVzBLeGE0NUJoS1RlWm5ITkNtWXlZdDVZbm50YmVyL2x5?=
 =?utf-8?B?SUw3YTFhVlE1MFVsYVF1K0UwN3c3eFZ2VmIrdVVNdk9kZWp1blI1QUYxZ0R3?=
 =?utf-8?B?d2VTVmlqeGlpZGdJbVdObnYvUkU2VFdzSDBEQ1h6WFRMN0M5NmdhbkNubm9t?=
 =?utf-8?B?S21oUWU3Tko0UzAyUjkvcnY5N0h3Si95Z0pXbnlNaG95c0JyNmRIN254UDdt?=
 =?utf-8?B?MVhYSTdGN1g1Q2NCUmdFb2NPOFRPWkpvZGkySkJIem52NHdMUW1IU2psallL?=
 =?utf-8?B?eTIxdnF3aVBIOEt6c1pqSW9yeTBqV2pNeGFpaS9YRGc1MXkzNlpnbmxUUm5N?=
 =?utf-8?B?eVRsVlRWYjhyM0xIWmt4NDNoYytlUnkxMmpSQWVoaFJBdndBY0pGNVBmV3E5?=
 =?utf-8?B?UHRPaG1ZWXd0RmFEUkxGUlZrTitmV3VndkhPYzVTb2cvdkkyM2xHd1FHUlk4?=
 =?utf-8?B?Z2xRc3N4TlhUMXUxTHZLMmJIMitaQUR2WFlid2F2VnBkMVQ2WmhTNExPa0dq?=
 =?utf-8?B?MDVrbUdBaXNkcVVydHVEUXVVdTIzVEorejQxcldPdjJFT3BiQ1MxQ3ExblU0?=
 =?utf-8?Q?w8yNKb07Ask84W1CcYlA+UTyj?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afd85d4-e513-409a-9ba3-08dbcb357d4f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:20.1320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6iYQaT0Pgw3flXReMyQQZXZ8dtpBMnY6sueBifU7ooxb5ggEaJ8J96qmaIz8ONBic3gL6IDIBrvvB2sV2/QBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-ORIG-GUID: 0hKDfD9W2vEFjF40llwuARZ59dHKF2c2
X-Proofpoint-GUID: 0hKDfD9W2vEFjF40llwuARZ59dHKF2c2
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

MigrateChannelList allows to connect accross multiple interfaces.
Add MigrateChannelList struct as argument to migration QAPIs.

We plan to include multiple channels in future, to connnect
multiple interfaces. Hence, we choose 'MigrateChannelList'
as the new argument over 'MigrateChannel' to make migration
QAPIs future proof.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/migration-hmp-cmds.c |   6 +-
 migration/migration.c          |  56 +++++++++++++++--
 qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
 system/vl.c                    |   2 +-
 4 files changed, 161 insertions(+), 12 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c115ef2d23..a2e6a5c51e 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -442,7 +442,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
 
-    qmp_migrate_incoming(uri, &err);
+    qmp_migrate_incoming(uri, false, NULL, &err);
 
     hmp_handle_error(mon, err);
 }
@@ -731,8 +731,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
-                false, false, true, resume, &err);
+    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 10b2c4f318..da50b83e5c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -474,12 +474,35 @@ static bool migrate_uri_parse(const char *uri,
     return true;
 }
 
-static void qemu_start_incoming_migration(const char *uri, Error **errp)
+static void qemu_start_incoming_migration(const char *uri, bool has_channels,
+                                          MigrationChannelList *channels,
+                                          Error **errp)
 {
     const char *p = NULL;
     g_autoptr(MigrationAddress) channel = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (has_channels) {
+        error_setg(errp, "'channels' argument should not be set yet.");
+        return;
+    }
+
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate-incoming' qmp command ");
+        return;
+    }
+
+    if (!uri && !has_channels) {
+        error_setg(errp, "neither 'uri' or 'channels' argument are "
+                   "specified in 'migrate-incoming' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
@@ -1547,7 +1570,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrationChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1565,7 +1589,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1601,7 +1625,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1732,7 +1756,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrationChannelList *channels, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
@@ -1742,6 +1767,27 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     const char *p = NULL;
     g_autoptr(MigrationAddress) channel = NULL;
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (has_channels) {
+        error_setg(errp, "'channels' argument should not be set yet.");
+        return;
+    }
+
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate' qmp command ");
+        return;
+    }
+
+    if (!uri && !has_channels) {
+        error_setg(errp, "neither 'uri' or 'channels' argument are "
+                   "specified in 'migrate' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index 8847def17e..9292c282ac 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1518,6 +1518,34 @@
     'exec': 'MigrationExecCommand',
     'rdma': 'InetSocketAddress' } }
 
+##
+# @MigrationChannelType:
+#
+# The migration channel-type request options.
+#
+# @main: Main outbound migration channel.
+#
+# Since 8.1
+##
+{ 'enum': 'MigrationChannelType',
+  'data': [ 'main' ] }
+
+##
+# @MigrationChannel:
+#
+# Migration stream channel parameters.
+#
+# @channel-type: Channel type for transfering packet information.
+#
+# @addr: Migration endpoint configuration on destination interface.
+#
+# Since 8.1
+##
+{ 'struct': 'MigrationChannel',
+  'data': {
+      'channel-type': 'MigrationChannelType',
+      'addr': 'MigrationAddress' } }
+
 ##
 # @migrate:
 #
@@ -1525,6 +1553,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # @blk: do block migration (full disk copy)
 #
 # @inc: incremental disk copy migration
@@ -1549,14 +1580,50 @@
 # 3. The user Monitor's "detach" argument is invalid in QMP and should
 #    not be used
 #
+# 4. The uri argument should have the Uniform Resource Identifier of
+#    default destination VM. This connection will be bound to default
+#    network.
+#
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 6. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
-           '*detach': 'bool', '*resume': 'bool' } }
+  'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],
+           '*blk': 'bool', '*inc': 'bool', '*detach': 'bool',
+           '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
@@ -1567,6 +1634,9 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1582,13 +1652,46 @@
 #
 # 3. The uri format is the same as for -incoming
 #
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 4. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate-incoming",
 #      "arguments": { "uri": "tcp::4446" } }
 # <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming',
+             'data': {'*uri': 'str',
+                      '*channels': [ 'MigrationChannel' ] } }
 
 ##
 # @xen-save-devices-state:
diff --git a/system/vl.c b/system/vl.c
index ba83040675..1672feb775 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2695,7 +2695,7 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, &local_err);
+            qmp_migrate_incoming(incoming, false, NULL, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.22.3


