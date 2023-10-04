Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF5F7B795C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwmo-00053F-BT; Wed, 04 Oct 2023 03:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmm-000534-Fo
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qnwmk-0006MK-Jz
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 03:59:12 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393Kj15s026467; Wed, 4 Oct 2023 00:59:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=uZEQUvCp6ZUJ3uSVxFQGDncnxyD9KRWF12/PPLuXE
 EA=; b=F/M8UQcfCeU9LBKWnlxkgrt4/BQ3vndL78cmg0wgYGdYu7CmeQLAWTw91
 tCu8gdX36+Ke+VG0ov5H6WsOEXkf53V9DGEtzm9iZKWCo7VAGJIZOnpcwDd0zseQ
 E54cu6+xuT2zIWqUvNzXw/OeY3AGShZj2OAzsVyrzxGr9KVZvg/pzJFXB5EYl/d8
 GSZsUbiET3hlkL7N46L52s8DrJvMBfSSCxtXgS2wMBMebsmkRzZKQKvXIpz9O7Bs
 Go1qKhb1e20js2lZnvHbUNxgaBtfWTGHT4fOd+CiRl1VkXvyy6vmf41yEkxc9lpI
 QrFtCfyvcN+LWK2omXpzQpTizYN7g==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3teg0rpr8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 00:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K46dHdyS4MmpbyIo3fSIm5/jAx2k48+rzrnVvYjgV5odHidp6D5VOJKkWg+KVwl+n65rpK+TLHY7Dorh6RNwDAaSquXwSOpjSFQKj4tBuXhng1CZ9JF3mafZdTi7WMVPD+NJF3OlXxpB1MnY0PW0A+rpBgNjIZGC0yXLlmP54U0DaJaAo27b0jIweOGUewVZiQO8FDAMfyiRgC6sKTEHtOnJ6DsZ6wBQo6ulMCpCvftWEW38Jxpdkqmch+gg6FAZ5piLVuXyfrvPIuyhFUi1X3DAoeBaO1XuTRuLbvVwLG615oIwApKljRgVw8LXQJMXhsR9pUmwvIRQZ439BrFBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZEQUvCp6ZUJ3uSVxFQGDncnxyD9KRWF12/PPLuXEEA=;
 b=m6QilbEsVWODdo0TaMFOS+PUZUUlgHdRCBE/LyybtIoMJtH57nzYkm9qgYlXCx+hC2PvPbV87A30x8Sc1Ry1pGACSFMXzTPpMcqqNW8FUkt7yYhwvQ1sffoTVtKfP1Y0igeoF0En7IMKV9maMR2o7B/Aw5w6LEBrgnPwxiheNO3qce1mDysiuKZGRYF8pYips+iGFX5mpiQxzwwBP7dpO4yNDZ07yqssDOdNbyZ51jJeGWtn/Y5FCIiqke1+zC1bAgUfbIx8KN0it24mgUVPXpcdE1SY1KIniXgv731BW5byq70oN8liYu8MiC1XukM05lxNMQfM8aY8XK0rlYPykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZEQUvCp6ZUJ3uSVxFQGDncnxyD9KRWF12/PPLuXEEA=;
 b=Sn5J/nhCBJH3ntjPchbM+7haFSDVbK64D9DfhLvpAkENU3qQT1ovso/Xyap35x5CSEaHPtNiWO0rP+DX+pnaSuu8G4Q6XyvwKFTsvZrNOjVO6//PhZtcx5/V2Lx1i3nBYCN4Ee9v/BFWDM0WmzIAorkbtvgHhmLapkQySM/wQjbwJrdqpEJUoPXXuzyTN9iBbzlOXqwPAEeuDXgxRyB/N9gBHDHBLTEcw59KVgyiTd1t+R0Nzbr0ODdxZYXeebN1gVtv74BzjdsaDvVOax6ZcZriE9RgsuNnxs/KaebM7ZWfEcW1yGDfCmS5aTpo/RL4i6hO6Be4LXVfKewWH9capw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8294.namprd02.prod.outlook.com (2603:10b6:8:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 07:59:06 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 07:59:06 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v11 05/10] migration: convert exec backend to accept
 MigrateAddress.
Date: Wed,  4 Oct 2023 07:58:46 +0000
Message-Id: <20231004075851.219173-6-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0673e0ab-2309-46c2-4418-08dbc4afc87e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC/QEjpTlKa6GW/o0EmNU6J6XFESjO4erQwATgqd36/2/vmu5R0+po1Pp7Nt/eGIWLVIytGqozJE+38oi8jZND8MxIo+PxIkx6gmgBshhUfBS0vSfLnGHGQipFfj2sQ87WgNV8ksaEcYYNOYZi6rD003dq6v6++jhupe/uPTge3ysyVXgDF+PF8CDK1PCUk9rPUzjy9Gg7XV+JNdkA2azDfpl762nkGgoGumbhGC8diJ2Xd1oquOJ9mFEXfTGO4Iuto48R/wNK7s8NEPPOptHUZcKmpL4FzwRraEIT6PxHHVxp5IrEHuC4wYYwfndj0yAMw6E4Idy8AJ+es1/6BB07q1pH0pnT9Wk4GPZomln7Fu3ClNYDGx1UIG8QsR0rGCtNiZyWTMFC0S1+0pO8yXth0ncFCksPp900DkAONABdAv9Ns9yX15CQAM+9RUhDVPDnN6B8jnyJIMZ8ZFzVDnKp/0jPvMUsjl3PRybeq8UKc1CIddzvltmCaXqgKOnNp1fgy1oiKWb2S9r1Yqy2K96Fb8EzT/aC1dizEtLd57XrHWdVwWDI0kH+V8O6cqvGz+elMR5wGzFuufmapMr5hkOhpHtocSoaCbzJdTJfhJ0SZIGi+VWXG8wMZjlAU0jr673wj0rSVHJRwY+NjwQ28WHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(1076003)(41300700001)(107886003)(6486002)(2616005)(52116002)(6916009)(66946007)(6506007)(6512007)(316002)(44832011)(66556008)(66476007)(8676002)(4326008)(5660300002)(8936002)(26005)(478600001)(6666004)(2906002)(83380400001)(38100700002)(36756003)(38350700002)(86362001)(218753002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNMSlluTlgyR1N5d25wZTRNWW5kNWpiVzdZOWpGOGdUNXcvdEtMZHAxNUZG?=
 =?utf-8?B?b2c1cldDTjdkT0YrMVN3L245WUQ1T1VxSjlwSEpNTlJRZGtTRlIwemFoRkNR?=
 =?utf-8?B?OHBUakpxVWR6U0VRZFVqcWFNU2k5dWdxVkpnb1VWenFGU280R0RRT2UvN01x?=
 =?utf-8?B?ei9oOEszaTVHeXEvQXJFRDNrL1hlcjVxY2VpaWdGc0c5VmQ5MkRBZ3IvejBP?=
 =?utf-8?B?UVhwQmp6MDYyZVZVSUh3Mm1XMTRsaFFoV1Q0WHNJSi83OE13bXFyT1N2a1dE?=
 =?utf-8?B?Sm5WRVlBYzE1cmdxdmROaVB6Z2E1MnRqemhqeGtvaXVWZ21hb0JtSWlRU2U1?=
 =?utf-8?B?UU1taUdYS3VQd0twL0s1L29ZVm03dnFWK1lFYkRZQ2ZqYVR6R0owcUIwWVhv?=
 =?utf-8?B?TkgvSmFFVEZ3Myt2RkNSUDhzSW15b1V5ZnJQY1kvSlJLakZQYjhscUFScERv?=
 =?utf-8?B?Q2FLT0Exb3Y2eXFnWkdxOHN1eHljSjN3SkhycVVwTzFqNUU0ejN3amV4Rith?=
 =?utf-8?B?My9JVFpYdXVmK2grRlNpdHprZ1kwMExjZ2FEVG5ORmZMM1Vsa2ROdm1QVW1o?=
 =?utf-8?B?NTA1NEs2OEN4WWtmUThxWElMZUFRRzZBUGhLZHhBR1ZQZFJrVlNLU3hOdzJM?=
 =?utf-8?B?L1dtVllDOGJvLzVyZDQ0VWhiOVo5aEZUejNPZnBENmZaV0RKTGg0c2lldzB6?=
 =?utf-8?B?UFh0alhsSS9WRDBuenZhZ0tkb0s3b1RRZUFESnVReEd0M2VnYUVOT3BzRGE3?=
 =?utf-8?B?ZGNqK0szM2pwb1FKTWpSemI1QnR3WFFSVXZPZFZmNTR4L0FLNmNWSjR0cmFp?=
 =?utf-8?B?aVRsc3hPaVJmUzFjeVFRbmVKc0dJQkJiMnk4OWYzMVNaQ1VPcHB0MWFnOHJt?=
 =?utf-8?B?TW96d0VScEVwMEh6WU94UnhDeUlESExWaVVBaldmRHhvbjd3KzlwblZXUGJk?=
 =?utf-8?B?M3QvUEFTazFhYU45ZDFDbUErT1poSmJXQ2NScDBCTXFnNnI2QXRFTUt4VldH?=
 =?utf-8?B?djQzdmI5anJrRFFxNWFtZ2E3U1pYWUlybjAvVHA1UUgramJrcmxzQzVpSWsx?=
 =?utf-8?B?SVBENlMrdlVyT1liV1htbkZEdXVtTjIyQTFCK1JvVWJIMzhuRXUxRHdyMnU5?=
 =?utf-8?B?Qlo3SERvUVF1c3dQcnpnUzdhOWRER2JMdDNkT2hMTEVRMEE5UEp5WFRzaU5H?=
 =?utf-8?B?elZnWEo4L29ycFB6bEVWazFWZlVxS3BjMHhwZ2g3VWZHbzhKZHZUbnZpS2I2?=
 =?utf-8?B?S3M5S0JyejJRdGhRQ1A2UGhZUFZ4QnBycXh2UW5nTFlpRmJGcC9sSlRSUTNM?=
 =?utf-8?B?ZmUxdFlKbCttMW90YmVOWHFZYStaNXZycmcvVjZnWWh6Q2FLakR6K3lXYWZD?=
 =?utf-8?B?U1E1WEtFY0R5RHJybG9tVEpWNnZkVWpkSlVrcGE5UGRRejNoeTRVV0s5UHg3?=
 =?utf-8?B?RFQrbHJsK2ZpeFJEZmphNHkzaGkzQVBydU8yd1VTVTN3bXUwcUFmdU9JR242?=
 =?utf-8?B?bWRONzJPQmNGbzZib1dMRmlZTWdVU3d3Q3NLaFpsbDV3VnZnTlZzRXVBN3BX?=
 =?utf-8?B?Yi83WDczU1U3aHhnTWxvVy9UYmdxTkNOUForZjNRK2c3ZEl5MGlYQ0xMK2hJ?=
 =?utf-8?B?czZnbG9pL0F6UTRCRFo1clVRSU5WMWowRW5odjBkR2tiZ3RYSmFiM0FiQXBo?=
 =?utf-8?B?eG1VZjZJQVdHRjZnMHA3cm93VG1RcHVQQmJFczVWY2U5ZkozUHFsZENXL2di?=
 =?utf-8?B?K1BNNG9vdVZGelFrM1BIMGFNQTd1T1hhL1dmTWVhZTFhUmR5VFMzRTFGYStK?=
 =?utf-8?B?ZUlTakNpRStsVTlmQlRSa2NoVENSUUtpbkZTVWxuV2I1THNLQnp4Smp4M0ZN?=
 =?utf-8?B?NUx5emdrSGQ3YkcwdmtxMmd2akRMM3h3aTFpVUVTZGM5aTZ5RnZpbWsvSVBi?=
 =?utf-8?B?UjBhampLRmhZOVZ4UjlZaTBQSkJKbzFTa1pVa1VEK2tIWTMzLyt1anQwMHh1?=
 =?utf-8?B?REM0Z0UxRXZ4czJSTUtoZytEdWFZbDA2U3U2c2RTMXB0cVoyYWdUV0JhU2lB?=
 =?utf-8?B?ZFNQWGRHUVNkTFcySURpTUhaaFNQTzVUN2kzRmpTWkVJRHpQNk5ZLzBZN200?=
 =?utf-8?Q?TnwBN7Zt7Q77QG0OmQgsWeUpt?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0673e0ab-2309-46c2-4418-08dbc4afc87e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:59:06.6178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NoBuqULmTr/io8WLYVMctUvRVUM0lvzL9HSSXxP1toSQbsgJXYzWnjylcZtOzvZgmVmSxrbCI0kKA1CRqgKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8294
X-Proofpoint-ORIG-GUID: t8XMNuNOZzrWqaPjRImSAhqAaxb38993
X-Proofpoint-GUID: t8XMNuNOZzrWqaPjRImSAhqAaxb38993
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

Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for exec connection into strList struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/exec.c      | 71 +++++++++++++++++++++++++++++++------------
 migration/exec.h      |  4 +--
 migration/migration.c | 10 +++---
 3 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 32f5143dfd..8bc321c66b 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,20 +39,50 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
+/* provides the length of strList */
+static int
+str_list_length(strList *list)
+{
+    int len = 0;
+    strList *elem;
+
+    for (elem = list; elem != NULL; elem = elem->next) {
+        len++;
+    }
+
+    return len;
+}
+
+static void
+init_exec_array(strList *command, char **argv, Error **errp)
+{
+    int i = 0;
+    strList *lst;
+
+    for (lst = command; lst; lst = lst->next) {
+        argv[i++] = lst->value;
+    }
+
+    argv[i] = NULL;
+    return;
+}
+
+void exec_start_outgoing_migration(MigrationState *s, strList *command,
+                                   Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
 
-    trace_migration_exec_outgoing(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+
+    trace_migration_exec_outgoing(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn((const char * const *) argv,
+                                      O_RDWR,
+                                      errp));
     if (!ioc) {
         return;
     }
@@ -71,20 +101,21 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void exec_start_incoming_migration(const char *command, Error **errp)
+void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
+
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
-    trace_migration_exec_incoming(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    trace_migration_exec_incoming(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn((const char * const *) argv,
+                                      O_RDWR,
+                                      errp));
     if (!ioc) {
         return;
     }
diff --git a/migration/exec.h b/migration/exec.h
index 736cd71028..3107f205e3 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -23,8 +23,8 @@
 #ifdef WIN32
 const char *exec_get_cmd_path(void);
 #endif
-void exec_start_incoming_migration(const char *host_port, Error **errp);
+void exec_start_incoming_migration(strList *host_port, Error **errp);
 
-void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
+void exec_start_outgoing_migration(MigrationState *s, strList *host_port,
                                    Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index b41fda6f80..ebe14b9c38 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -474,7 +474,6 @@ static bool migrate_uri_parse(const char *uri,
 
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -500,8 +499,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(channel->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1723,7 +1722,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -1761,8 +1759,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
-- 
2.22.3


