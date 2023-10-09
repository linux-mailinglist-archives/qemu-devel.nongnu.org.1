Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF897BE310
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNa-0003pU-Kp; Mon, 09 Oct 2023 10:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNW-0003mV-3e
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNO-00034I-Ff
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:01 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399CrZ5x022209; Mon, 9 Oct 2023 07:36:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=45mKCOvA2OS/A1gpgMAkgbL/m1JsllaMMR0rfu3S4
 TM=; b=qc4SGjReKmUaGy/mlBauusnkx39SpEdeYADjBTFpBOgp8bYWY8DKgjPAK
 wv+1qasci0HS/6i/wuZ9cTe0tZSOW03ypK7K5CFNpIH0umR/iL1VLlpVaYJIr9sM
 E2sJHPoIuFygV/37DWg2EAsAM59o+hZsvlJjnTVjxNtY7ptyrz+YaOQvR3pxjKIY
 Sknvu/StgoMkIdJuJEf9QI1/IymxaRwxR0QA7ZX3Gh3fjbX5DulhOkrwTwTW/Tsc
 /9x50tuKLBUk1mTWf/rPfcgZX9FGsKQDvUO0bGS22rUS+PRr3vsUJD9SO242OkbA
 8AUqXk+vYMR2QD8TC9/bjP1ba7iLQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhtbtt4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYbIAM64IrWuhxjt3Yrwff5KN5w5XsB/SnoTurKd0T3KzrSf8qsPXpH9vZeJMCWgNqQG24I3CgkCyZzfH3tfg4SYp/X0ODDMH9OblNHv/A/criKFAgZG1Y44CLq8cykYtPuYWWCNutlqW6DsHYAah0gpWek0ucN8/ftHeEP9s5mg6PM4Ybrb3AkMteePbrafHoWaC4/f+AGZkRq/NM2RKbuu6YL3p0xJqv1ddhpzjvPEj+nEHgPviHFCCPdiKI3qsPi5MzcwXQLlROKSolAnGORpS9OsZBhX1iMiJNRXVOzIbEvMKqcQ7ni2XotL+wSTRPZhSDehrcElywCSuA6h2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45mKCOvA2OS/A1gpgMAkgbL/m1JsllaMMR0rfu3S4TM=;
 b=FWcT6l3XwTdvOG6Q3Arf1KvAHTrdXqwOdMmyTLgyrzR/MpQOEZMKsFjQ7zCJvfN6C/XOc9zX7VCgrPZ+vZZgPf9pPKR7nNvwNe2c8H5dxa092XqKn6ajATz+XQHWEuX3a5k79+KdHoh6qhaNlHnk5p8Ja17GvMlavOid0QF+C/xW/tpM2a+CJss4fWlBYIojCfzxtv8k2+M1dpZBFXHjpA29/05/wZjr//mrreVFVCkOwJr/mrSlMmsiH5XZLES8b4iMrUGNXjd9wd3pQjc2iGdMfRr9AVyJ0K7mxchV6xlOPxAPQfrgjiIqPSLt7VaWs2/xH4t1YRBso4HaqpXFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45mKCOvA2OS/A1gpgMAkgbL/m1JsllaMMR0rfu3S4TM=;
 b=yHgEg27bqi2lGjHEniX6HOMNo0XD91JMqKzgrzClhA3hCeFEXuZU5gjY/rM3GVQVxbFyBtz8Pwg5j8ddye6RbtAygI6ePDQSZpYg/4MeT4MLEkSNJqUWoLb1uKCUkgZQoJ7CMsCepl1Fc8hg8sJJiRCwtjjhrdw5jOYql68SO+x7WTFJ8LhBsg+e+GeIwuvO5c7UwCZdLaoti+0PhQqJe44+9mdn9sYZ4On7HK8D0lA/p1/G1Q2imA6ez4+urfNMGTiC8hL62tZBz31ly4Zl+xSDtaAOqgKh0XZalSXL2e/7TLCHtubOeU8msOV6qGtO7CdKD04oNnJwU7qGX40Tcg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MN2PR02MB6735.namprd02.prod.outlook.com (2603:10b6:208:1d7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 14:36:45 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:45 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 06/10] migration: New migrate and migrate-incoming
 argument 'channels'
Date: Mon,  9 Oct 2023 14:36:11 +0000
Message-Id: <20231009143615.86825-7-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231009143615.86825-1-het.gala@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MN2PR02MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b125f3-0cfc-46c7-a9f1-08dbc8d52943
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLX1MRypFPmmdGK0dHMeLoVtYTnv6EqiU1zwXYzm0z7tWlYs6VIAuowS9V2OdV7b53Dqr2uADWyNvcWzktOTNDDsPST82QMyMOwSq82cFYherXTTim3FYZewcuOZ8aH3GlVNLh50BPoHbn6sr9x991eIxsOgP1bkr0kwp9ueEf6WZa/yf0gB7iyBNZ3MRTkx6rFPjxjsIFcsCaVIjch958A+9qZaOEV5Cu1pKCiHyUnG33M94AkJT2SwNRyfWsfHvBkYc4kKub0md4OGSih+7mvEVsFa8pFBR0PMeXCZwY7RavNWx6kHj7kULowTX4rVmuHAZVWG7l7xblrL2/LFElGfTcOZERJZyvnZxTLFGV2OdmX83BsLX/+8skl+kgaumFgg6upXU0Pcjlpm8tNz/QNfseq6rtlOcjaB8clxZmhW3lqmGWpC7wgLdcIz8KGNKIuCi8P+Befs/Ah5YGqJRYSC1b8W9SKLAUL0rD8+AvYQozyV/fpaN/e/T5jOqc5dkXr6GYuZjxVWR6t0gCCNBqlx17FH0y5dBjZP9+vI8PHBxdLvfRig54bLQQV8Kj9q58XOAjgg53YsZIx2QG7q8rWxHcUxkLufEG+JsbvryGfRCqFKQDX9Nwtyir6c0OAE2NlPr8wof863HpmSvZqqJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(52116002)(6506007)(2616005)(1076003)(107886003)(6512007)(6666004)(86362001)(38100700002)(38350700002)(36756003)(26005)(44832011)(83380400001)(2906002)(6486002)(478600001)(41300700001)(8676002)(316002)(4326008)(8936002)(5660300002)(66476007)(66556008)(66946007)(6916009)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFh6V2gyMEdPQzlraE13Rml4UW9EM1ZJWC9GaXhQVCtoWkwxQUgrdzh4SmUx?=
 =?utf-8?B?Qno2YWlWaUVoUk9yN2JuYzA0c0dvWU1Lc0g5YWZUN2J0dm0rd3ZTTW0wa0Jp?=
 =?utf-8?B?MHZKRVdneWVyd1FIQUFKOEpXMjhhK09DOE1ZMGJUVlI5T01mWnBiRy9HeHRw?=
 =?utf-8?B?WldFeUNZSHAxZFdpVjBtMkpZMENwKy9JSTJaZjB4NlczM1ZkRFR0QTZRMS92?=
 =?utf-8?B?OTN6SXpPZmNFTVRBSk5neUVkdkx3eXB3K2lBOHJEaE9RODZtanFGV2Q4SjBn?=
 =?utf-8?B?NStYeU04U3Bhd1dOVzBZZ1ljeTVVSUxXRUdiamR3SjZxd3VZWDJGOTl5azJ6?=
 =?utf-8?B?Q0xScEFmQXpCTnNhZmNiVlV2QmplcVhPZlVrUUtPLzlhSFI0K3ZJWmtsU1Ew?=
 =?utf-8?B?S3QyZjFDclpCRDAzOUdqeXVGclR5TEFVdWt6bDU1NEpCcC91N0dNRmhvUHBL?=
 =?utf-8?B?R0paQ29iMEJNMUNORGUrNjZBK2E5ZUNJK09HL1lEMEFCZ3ljRXhDQ0UwMGlv?=
 =?utf-8?B?OUFRampWaDNLSXBDVEwwTk4xVHR3WTViMWp6eTY1ekFka255YVJHUGpVZmM3?=
 =?utf-8?B?N1lib0oyaktoRDJsODFnUFJ2MUliZ0lzT3BlR3E3Smc4cWRhcWVHaWFaajNy?=
 =?utf-8?B?eUp3UGpWSnM5TzNPZjJuL0FrazNBYlB3TjFXdnA4dTZ1ZHBlNVhoUm1lam9j?=
 =?utf-8?B?Qk5ORnNFRmNKMTJ0akNiZjM1Z2FYL25NblA5V0hnTVpLNHFrd1pLQ0d6OWF4?=
 =?utf-8?B?WjBBaVBtcGE0MWVhTm5rdHpGZ1NYdVNFNVgvVDlkNjJ3SjU3NXQvR1pudHJy?=
 =?utf-8?B?VmJGOE5MdHUrNzNXQ29pUm9TOGtuNjRsYTVkZE15SmZIbWdueGdnNlpaVFll?=
 =?utf-8?B?M1QxRzRuTFU0TE1ocHVIRjlnTzRLUDZJNWE1SFJhVm9ZMDJ1ejB5a1VoaDc5?=
 =?utf-8?B?cGFIMEZzZ21jSjVqbUZkQkQvNE9vUUpMSURLOFdTcFYrcXIxWWc4cVlEMXVM?=
 =?utf-8?B?ZCtCMVVkOHUyaTMvalV2LzNGTUcxK3ZLdHpMYW5HM01pVDcvcDZuQU8xNFBl?=
 =?utf-8?B?L2R0SlE5bHhjRnVUVFJ0dU5HRUJNT2dBbUxNU0JMY1lLYitjdEVQUjNWOStI?=
 =?utf-8?B?QkRCN3c3NlZhOXJBbjRjU3E3Qy9PeHUvblJ6bFY5Q0ZpdXA1cm5NWGxNbno1?=
 =?utf-8?B?Vk5IL3QxOSsvUU1nUFlpZGR2WjBEVlRGWE0zVjRPdTJmbnlIR1JCejVEZVJR?=
 =?utf-8?B?M0QvcU9YQzFua0NCWjZ2QkhuV0kxSnBoQkhvNzVhVy9rTzRPQkZ3N2hMSm5i?=
 =?utf-8?B?b01pVlBxY0ZHU2Q2Z3ZHZ00wQ29DMUdVV2s3WTg3VUVJa20vczc1ZE40Rktp?=
 =?utf-8?B?bE1wOGVrVDJBSndmVjc4YjVmaXdLSW5GV1ByanRUV2xsYlljb1BaQ0I4RWhK?=
 =?utf-8?B?MGZtNGlBZDRTVU10aGZVVEUyWG5xSEtGeHRxam9HQlRyVFVFdzBKQnI2aThp?=
 =?utf-8?B?OHoyMDB2cTlXSVFsclBENG9nc29HWXdURkg5QlNwRnRWRGxRWVlPVFNWNEhC?=
 =?utf-8?B?TU9pUTl5R0lGektPZFJoWk16SnptSk5YNVAyWGlkUFdOZHM5UDVLWHc3QWlz?=
 =?utf-8?B?MCtXc3c3cysveVhseE5tbWNSd1pnRlMyeExDN1MwN1ZFei9iK1ZkcTI2WHlh?=
 =?utf-8?B?cjQrQmp2TmRaNDc5ZWUrZGFRbDFJT2JnRjBLY01idDEwbitxcXp6eGNvbS9j?=
 =?utf-8?B?OUFUQ1FnSk12dFlWTXg0QlZoVjRjUTRVcXo5Q1R2ZDJaQWhrQVpzRktGMVN4?=
 =?utf-8?B?WVU5clRZaHROOHMvQ1pHYnpaUnBPUU5ocEF5cGZhUXE1VzRETGNwRGppVEs5?=
 =?utf-8?B?bHJxRXowOTBabFQ0UEtRSTlkZFBzWnI3RGUvcGpPc0FUaThYU280bkcrU0Fr?=
 =?utf-8?B?ZkJvN1pmUG9vYi9XRmRUUStmWkw0WkswMmtFdUJFZ1hER0tpRk4rK3dpUTho?=
 =?utf-8?B?UGpZLzVBNmlnU21nRnVJZ3d3N1VUY0ZCdjVTTHJkSjRhczBWYVhaYSszQXZp?=
 =?utf-8?B?MzZ4bzJYNGU2TGd1L3hmVllKMnArbFVvM0VXT0EzMHlkOStlQXRsck5xNGtB?=
 =?utf-8?Q?wJdxrp0sSW/bb7kMar1T4Ud49?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b125f3-0cfc-46c7-a9f1-08dbc8d52943
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:45.0312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qlj4nagSINdWColsHsce8frQV+td71Kr+Ts/DKeszRbVgOJo/ZE6yK3UbmuD8CmKjKD1lGkQhqB058N0GqsA9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6735
X-Proofpoint-GUID: kxtOmS8iwJbHrxaCRAlOS6hugaCj7-1t
X-Proofpoint-ORIG-GUID: kxtOmS8iwJbHrxaCRAlOS6hugaCj7-1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
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
 softmmu/vl.c                   |   2 +-
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
index 732fdadb11..f3e7c338ec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -474,11 +474,34 @@ static bool migrate_uri_parse(const char *uri,
     return true;
 }
 
-static void qemu_start_incoming_migration(const char *uri, Error **errp)
+static void qemu_start_incoming_migration(const char *uri, bool has_channels,
+                                          MigrationChannelList *channels,
+                                          Error **errp)
 {
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
@@ -1535,7 +1558,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrationChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1553,7 +1577,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1589,7 +1613,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1720,7 +1744,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrationChannelList *channels, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
@@ -1730,6 +1755,27 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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
index 4e4c39a9bd..7b84c04617 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1519,6 +1519,34 @@
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
@@ -1526,6 +1554,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # @blk: do block migration (full disk copy)
 #
 # @inc: incremental disk copy migration
@@ -1550,14 +1581,50 @@
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
@@ -1568,6 +1635,9 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1583,13 +1653,46 @@
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
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 98e071e63b..99ab0d3a51 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2690,7 +2690,7 @@ void qmp_x_exit_preconfig(Error **errp)
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


