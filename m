Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4A7383F2
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBx7G-0005Jr-Eq; Wed, 21 Jun 2023 08:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBx7D-0005Jh-20
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:39:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qBx7B-0002WO-BD
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:39:14 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35L8u2uc009623; Wed, 21 Jun 2023 05:39:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=RZ5ZWqIwJkrWPHZ/ZncsaBiam1E9eaTrpXoGFVP7+58=;
 b=vpft/T5yzrC1IBL9ajeo9fN04WtgIVifvpfO2iokANY7H33EZioqofRYxxV5OQu10qvP
 2jk/nW17utOC4vnOqn2mBy4jDUkilMrQOxoIxG/7cfRgLY3UG5lset/cKAgZ8ikQoryn
 GGXxEgJizO/OIFXCxgSPWPJ6mwNGTYzxALdeWwP9Umhb3dSVJ79gnucMOdjKtnN0ITtz
 Ia3UbEqcwwCS8/FDygR4ifB8/83NdPi6lKJUTXndyoaT8d0iAI57x5XXsRQ/137HdfPx
 h5ElWikV1FlhHiu9P8Ep4HAkSUES/X7QfU/k2A/ZL4wyC2q3wEOIFScrCCBiYpOhgVyb mQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r9cbxqrwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 05:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/p56bIvnF8mNohNbk4YdK5ejSwEcHA/DRbe10d0rFDI/7sHzSld98FRC0Z4EHf+wD9FWX4Cqb44946C2hI4TvzLc2Vj5PQikPHb8ddDnJDS4fMu3uV1NXAONWDQx3v4W9zbU/S6DB9tS05GTjGUdIRxdMFOUcFksUKND/NKZ5QSEtNnyw3X7D+DOvYTrFyjSgilCBtmu8AdS/RpgQ9DfhCfdUZCusIoSWEABzlIH8N40EYUo257MCRn06NuDbG+t/m4ESQGD5IZ2xm+K2OugOBH1Z6G0sUPGNu/J8PBLw3P9IvjSu56osgbhhRMuCYjtMl2TMZTNjRtwic4PvxjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ5ZWqIwJkrWPHZ/ZncsaBiam1E9eaTrpXoGFVP7+58=;
 b=Bl1mEFdodPizbzwO9OgEQ5g3WxoI74Ka9fWFBS8IOSQKbYBTsANIJheGj8DiKBDN1qL2OVkl0fFBaPKACodLIFa3SpV4A8ze6ubArEfuO92c65WSDF04BBGtyrexqTSQA/RswM8GFQ1E25cO0EIu9EK0dPZwLY6n5MaUkiy5EAeyvoMkJyjCeL/+6k+Ztr82Adyq72VdtyazrTuLO0K3917u7fJAZRRyoThGS/mvLhd8PC8+4OXblLqM+YEJp3KBnQn1oOiShtQOz3HAEc1AyHswzd+w8ERkFETk2f1CTX84JxQAoe6BcBrAaY9QljaJ/S9QZj2k1MOI9pCMjZcZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ5ZWqIwJkrWPHZ/ZncsaBiam1E9eaTrpXoGFVP7+58=;
 b=HSHavnEHT6FzY1GoHml9tmH9fReFeusijtAjq4cvfnKGeG6xKcPg0JrYwLhwr4NspnnqCJWjkSA7bGpMHzDr3Et5b6At9kVFqoAY+CvS/3GQmBmmJCw+uxXk6LxLIGAbVInOiBnC7YMlHo6x/2Ssp/7E3t2hNVOQdbnE9kNxyjNI91Pl46uKg18hO54qFpw3zfC5Zu9gx1W3KdfUIqBLCF+hjZ7jNe5S7rE13nuX9I/fTu58kBmVhNEK27hNJ3OzbdzbZvDKM4NPwQTi90I/wKv/0OI1jFOQR6qZ2uZHF0ivIzPg0UD+kSFO4iuTH4RBEbF539fJi90ENx1NrRlbAg==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by SN4PR0201MB8725.namprd02.prod.outlook.com (2603:10b6:806:1e8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 12:39:06 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4f5f:3660:5304:57f7%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 12:39:06 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com, Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v2 0/2] Update error description outside migration.c
Date: Wed, 21 Jun 2023 12:38:42 +0000
Message-Id: <20230621123844.177739-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|SN4PR0201MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: b326c223-df5d-4e88-281e-08db7254803f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RCgiYfHrrHUgK0fzwoAql+RgT4cQLilSJ+E44bHq7F56KrM/pQzUdolIzGqWxZJGl+85MWmPGTfpjfAxeZfNSu3+Wu85R1hCqqfLcrP9KGlowOxo3jAcwFnbfAAl8YPAJ4dNC68boA4ZYubjA89s7uqx7+7TkN0RXoPlCmzQGRU+p9MzWr4XPBas4nqZjRbBUPDvWcp0lAbw6HijKCDxsJmP5Lr2pnvzuhV30bHnC8vAeDOFyAGA2tsJyZ4pBlzJStVePv5swW8BFdFORuHPE7T0meYOcUpv/jwWohwM+zCWA6TxbdVYquVho/hP+gXM/cZPzRuj+bJxe6i6P1DSOLQlW9ZJKec9UIlenm7SkTf5nBH9QH8j5zEyxYTbA3r1wnc7k97Wz25fveMDtvnDAVU97mAd5PRDINAhhLRvOms+LUOtKZ6UUhefcHg0fhPzA+mMRG70khJ0P64p0BBVmxFXjpOOw2b7m4kLMOUxtr9Wn97lkGxL4lLSjnlzDmPMZoDVXcgaF3E6MyAutCqBAONeYPUHOWvwbrVCItE8w9dfwpFhlezyTl1Wqugh9UBf+Mu2EUsIHUPkppTdDorxKa782tn0jSRHpbcpqSVptESy68ksIdjzlOx+179Q4iB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(6512007)(36756003)(5660300002)(66556008)(66476007)(8676002)(41300700001)(8936002)(6916009)(38350700002)(38100700002)(86362001)(4326008)(66946007)(316002)(107886003)(6506007)(6486002)(15650500001)(1076003)(26005)(2906002)(186003)(4744005)(52116002)(2616005)(478600001)(6666004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ahWJ5HAby9REp6flVE5kQWgB9XUBA3HeWbHw0XGlclozfMemFZ4O9D9Ag7Hx?=
 =?us-ascii?Q?Fs89oxiOUZOgh1/cG6HL7EUE6l+dpRwE0Y8PfahTUe8YUFeRZ3tkn3LSAZqa?=
 =?us-ascii?Q?/qy+JnbwMZbN1r294412i8kTdbD+R/kBK/NfGWBaUHKRAk3M2Kn54WK21LJ/?=
 =?us-ascii?Q?e3QDj1gpksZ1ybny5FJhfE5N0KlXguuins9C6IFfm+3HYlnDZgtAv9vdUOPf?=
 =?us-ascii?Q?IcKNv7pyGiPX6Nv2K032CDWDbemBjOceoiOfetCxYe3K+ft6GAAzXtbRmfiF?=
 =?us-ascii?Q?anSHqG1c08lcd798B131QaKxY1r4YjC5IOFcUT2JW2T16J5XOW+AVYUPZESi?=
 =?us-ascii?Q?KUxMIbthjXIZUSyNIt8m/zdNLqrAVNCOHE4KZkvzP1CRA7lV/G7O60G25lqs?=
 =?us-ascii?Q?BfkIxM/LuHqwhS4YQmyGP/13AVYQzUjcskM0xJ6GlnhpSvh9hlgG5iLp/ApP?=
 =?us-ascii?Q?/vPeBtqPM0QwLOWq35tvKhMZvqKE+AAV27GgbrQ2PcPi9duQ3M3iRchEkWjb?=
 =?us-ascii?Q?z5xXtoB4sTBnn5NfUVLN+VCa/igQRd6hU2Smo1jmu2twMGYkVPEQbGej+09h?=
 =?us-ascii?Q?Vw7jehRw5jLyxrvjFVyUY/y+JKxKNnoXVRjE+/BUFC9CEb+ZxWTQkusK9AO8?=
 =?us-ascii?Q?K+PEVvMC1hNgE/hW9ZFBrdgVknqsNJry8Pf3BsOrwa20hXWcmfwvRiMRk3ss?=
 =?us-ascii?Q?0VAXse790TY0TRmla0gfS5nTRZ8WnrYnYh4wvgkd9Po3UFHhBDpo5TCiW/PD?=
 =?us-ascii?Q?h7rt+sJFVFCisFa6JmZnYMpE5ZWROSb4gRjtkYaMvV97PH6Y9e+RN5bE8ZuY?=
 =?us-ascii?Q?7AgUmi9Qr+CDwGvupI6yOeqZvNsf1w1SjFsguJii+4BwwJJVe+A9NNMcCihJ?=
 =?us-ascii?Q?dEivDFW0Pwiu+eVRw7X4vUKdFy69IWjTuTRQ6v9PBfcmtC7U7iizaHn30wva?=
 =?us-ascii?Q?jfAIjRyxSHGSmJUWuoh2M0OcdQfKFcDDjfC/diEPxeOsbimZ/g0bAPqFWOaL?=
 =?us-ascii?Q?l3LassmqPKMhxwR66hlJ0ADRYcx+k2lhiQHGAimWB/jV67sfEbkD9bT2VCL2?=
 =?us-ascii?Q?bEzB1sEz1RlNy+Og7gyaQ2JQYYOvrs4WyMwOGX9rwGV+U5O7JEHd2hdjs7ck?=
 =?us-ascii?Q?bDTTLwGJ/J3KEq5PhO+T6TN7L13oocHbEtmyW/mrVVphCX/6qB/bJErWbrwO?=
 =?us-ascii?Q?SmjT1h0lN2LrFjC973Q2TakEh9K6g8+7SS2J2qBbicNZbZwzKi4kMegB8tJD?=
 =?us-ascii?Q?TX1vZuu9VHaKVW2BCERiGVDPhypevwjgGjAtKOzssY6opDpiHcHSPGqG12MG?=
 =?us-ascii?Q?0mOk8TaX4QDFFdhEigk68cg4Ndm2Pqy6BCtCW/yzd5eOn/TQUpelVrxc2hWn?=
 =?us-ascii?Q?IVqZ1oeOFqpIUnrz1S8mtIzl8A8agcDHFMO781IcAYTG1m7U9D/tkK96wVx4?=
 =?us-ascii?Q?V9dCbVZUaca925DKBD24RlsuMVmpnoa6JsKb/9jSTV+9EGgqRTqgnc06mHv5?=
 =?us-ascii?Q?4UPPkQMEc3MlOHsaiFiC/MfrPzjnRmvcmAaB6LwkrTR0FHuMz05MGDw6Raf5?=
 =?us-ascii?Q?rjakYDakyKpyhBu/6WHG4ZryF7QN1pWmPna7Zg5r?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b326c223-df5d-4e88-281e-08db7254803f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:39:05.9790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjhSAUy9YVLeqPx7g7HIy9/k9JSh5hrBvj4mMbenR7KapK3GxmN/iF6soNQeJBoMmIWC1DBx3UcfltAGpB4dsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8725
X-Proofpoint-ORIG-GUID: WVd47RnKeNkuKiJdeXjim6yTUrgOcbbe
X-Proofpoint-GUID: WVd47RnKeNkuKiJdeXjim6yTUrgOcbbe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
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

Hi everyone,

Thank you, Peter, for the review; I'm sending this patch out as a 
standard patch rather than an RFC patch. These are the following 
modifications in this version:

v2:
- Rebase on master

Thanks,
Tejus

Tejus GK (2):
  migration/vmstate: Introduce vmstate_save_state_with_err
  migration: Update error description outside migration.c

 include/migration/vmstate.h |  4 +++-
 migration/savevm.c          | 19 +++++++++++++++----
 migration/vmstate.c         | 19 +++++++++++++------
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.22.3


