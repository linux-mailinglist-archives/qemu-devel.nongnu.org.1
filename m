Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293E7EA793
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 01:38:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2hQP-0005d5-Gu; Mon, 13 Nov 2023 19:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r2hQN-0005bL-DM
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 19:37:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r2hQK-0007Vs-Tj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 19:37:03 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADNsSdr000731; Tue, 14 Nov 2023 00:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=g7jhaoxx5+XFdL07NL9vjufvwtMVG3ZjGk+HdbxAgng=;
 b=GsBe8r5CMdaXdZ8FcAjsg1v2PmYxTRR3veZmPxusBODHZH9a7qsEMl7TdXqWTaMLT+RW
 gTL20WagWp313So4XD61KEyLBnOu6qmQC9x2n+79aj9nS1Loo6sAxPx48Nh96rzaBinZ
 AeRbpsJqU3h22SAuMtfACz8pIkHggpUjDIpm/Qu5/9x+5lx4nXzLMA/uwDaSLaLkcx/z
 C1nEWz4rDibvjCT4NuShCrAaAWTu8gIV6wio6X7WAcwBmwF1mxJNjX9xx+l1mbDFA4O2
 sn8yil89sb0KlDS8Qe9OgZA4BYTNVeVw2yQiDvSuyzjINWRZCrb1WKs06BJpimRH76GD PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n3c1qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 00:36:51 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADN8iQb029937; Tue, 14 Nov 2023 00:36:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxqqqn7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 00:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja5MXq85BwboGc4M0fFxsfolxhJB3bxuLsXYq1lPkyP7htgjVncESe62JDIU+fWbE9DsaCDCsNOezdfKa6/GU4PUMliTd3qXHufiLfXLPS/08dZugIUSEjs1UcrPW2gnGe5nV1wVS3lPthBLfbAyWxPEYOqVVglv6hC1ucnOUixNC2g0W1TgBwIOjSXLZzxEg/dCHqc8DHD9AUH+3zCbBz4/i5UxWjfDh7q2UfHBqriE35FbJhNjmPS1VRoKdiwRtJCrGnI3d7pud4Vtj/ZMEiUCdtsQAZwQfHqaj9ZCvLNKla3RxdROS+UimULZamlizZnIhel4+tZG5y3qzu/BDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7jhaoxx5+XFdL07NL9vjufvwtMVG3ZjGk+HdbxAgng=;
 b=Ii4IvbNptLPLTTjOGKPFWIPUJpI9Np0pYoluuzaVjTg6Zp9QHEBfZJxLSxINjxiP1sEU5xnks9QlzIH9JtppcXtHsq77nyhWpeI1OB+XKkhO4cWTnDv0TapD/WbKzX7orDkUYKDKdyRARYSwvzSuI/9B0oyaExbh2FSSAEFAUo4Hou3srGRA75oFJ6Q78JhiJaa3ehCUrAhpBF/HedORjSZd3VfRIri5lvcG9PQv9lyKnQt43jXklzRaBncip3FOW6x6f/goZ8HND2qNVoco5qvgyEnZFTKj/N2blIJ9Z5GuYOByjacB80cOVhpiUKplChr4YuTmfPlcq/SgdFrp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7jhaoxx5+XFdL07NL9vjufvwtMVG3ZjGk+HdbxAgng=;
 b=GheIDmby+Wf6nItp3eStoY++riW1CfScR1c81P6YlhcHruvBuPj4j1J2gftm3kCBaI5+ILEUlQVV4RKLyvhrFyJyfpkJaI77ofCv1nx3ITPDr6mjjm+DOJ8wjl64UF3opBwhIs37u+qXrn/WOCfuQRaxHBG9zFt4mdinnt1zAgc=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 00:36:48 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 00:36:48 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/2] vhost: Add worker backend callouts
Date: Mon, 13 Nov 2023 18:36:43 -0600
Message-Id: <20231114003644.7026-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114003644.7026-1-michael.christie@oracle.com>
References: <20231114003644.7026-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::13) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 47773d82-130f-47bd-5022-08dbe4a9c94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRja5FPB8zOgLQ64LkkEAtF7mUAXnsH1yMdPCvkF4oGBPVBAAlDc9EZq1vSnRMcCu2+ZN63eY3rDrRanZs9GMDTHjRgp8XaemizS3QIb9gEVj4a4MP78NelW++HE7Fp/vBEVUkDOt6RpLEjxyQovKEljr/m6a1YHSvZDl4hcsvL53NrQ3+54yOjuZ5wyx5EetCSpTxxaRVE0NLxl+mSmBB97StAREso7jWR4DqkbYDlThoGaS/2ktZvASd7EZOh1rCHkcKU7r/W3UbPc+dcNhFJzlIk7tn4pDxmJ8cIgr22NyIDwhJt25FsZYmlrD9KFE9RxMO/MK++7hjrlnX8+mylv/tgiTiL61cat1ASikv7kDR+hrGlEOzUFId0KdPBW8iBCcKRUMWmYrVXeZOlmkVO4q6f8+oCMuyIWBPb7Zj6FxOk7+WlCg/ZlrW/ydCYdx+ak/qHGfE2qHMRSYkC7B/GgvQ01TMCx5m+TN5ufXVbD31WLh3LDxtRQpuM8X0+fhhP8lHMfzdsc4bJ3MTpyp37x+iTMVwQxmsz61a4vYPG+hJokm1rnGM5IRFMRGP9B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(5660300002)(2906002)(26005)(38100700002)(6486002)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(1076003)(6512007)(2616005)(107886003)(8936002)(6666004)(6506007)(478600001)(41300700001)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5rejU/fTaUKlIUL/7icSvD/VM8Wn959MI9MBufBNtH79g93JxT1OGXj4Xa5X?=
 =?us-ascii?Q?gjhOWy42kb7t4igp+vZ6FjZgjUUwjorrr/Rxu7w7bgA5GuUUSZ+8yWmY4Dvo?=
 =?us-ascii?Q?niR2gs9L8uR3N/nlo1W9IvlWpFErER4Z+vkH97v/aK+4sY5ME02m8PI5UB/w?=
 =?us-ascii?Q?LBS9tT2mi2O4QgdcRkMi71knvzNYS6STq2hav98qulLqRudp4pQAoNP5+hb8?=
 =?us-ascii?Q?qRqGtGDyQVTb9H3g2R4G+TfzlJZzLmlW9KBdRpQ7O9c9LkTa1JDOQygeXRp/?=
 =?us-ascii?Q?R/RvpZ7cw5F2ZpSI8VijnaO/GEw6KaJfRfEdh+xbriTFM7uR59SLGcwXhMIJ?=
 =?us-ascii?Q?JfOe244jbKbKzI71eqo5mfTCS2IPWQGW9RmM8zsuNvp3AukeIwsslczWOKKu?=
 =?us-ascii?Q?TTiFYloGEv2paCZ14sks9bQMT3NurudNYB8hTwkqWwpKySUyApgL2S2PIzKt?=
 =?us-ascii?Q?vVhOHnGhS5gD8XFDFBTYVhMXw1PJBTAlrB5PxC58N+oISYJ3Jhgyvlibn5r7?=
 =?us-ascii?Q?ZDZe8vwfWgbCqs2hcvkmBqyuxnsq/L5VC/zjR5MLNQz4qhf7Vgt+gyWOeYF8?=
 =?us-ascii?Q?zY4RFGAZXvMQUI+9S6qE2+hcidVwbeS9yxZRipObzfpQJkeO3SFnsfJ4Erx7?=
 =?us-ascii?Q?fPgZGp99pjuhVlGaYwURQ/x8FUFuOXFkmv9Ikqxb7GTKr5Ru7oHX3amvZcab?=
 =?us-ascii?Q?4fBKW53FaMJ15b9bBxm1aO3vHXRn/i85N1j4NtCdDYIzvsyi0co81w/N3IgL?=
 =?us-ascii?Q?bLMo8EGlg4v+DTlcEjLZtZ4Uj3SQlmSun2QujjWQfis41TWFAxwnwJKPUkNx?=
 =?us-ascii?Q?On5LzXPrGdjCUS7KBwf4fhjneaXvyclj/idxho2HgFmlEUhskT/zWYMUvz3A?=
 =?us-ascii?Q?CdGWohQIuPlap/Rl79yM2zof1QAn/j5O/JvfhkyIk6sTrgQO1v2BFLHc/WXC?=
 =?us-ascii?Q?wqCtRaz25hci5Zbigik0Nt6X7r0tEnsrnboPKDa2V9N8OrXCBCRFPu+VOfLI?=
 =?us-ascii?Q?SRiIUyMDoA2sxoPFGP7OAjpvDZxVjNC8Q/h8wpR9TIDUOltTkSqyYxCkfnZT?=
 =?us-ascii?Q?6suiIbQFfgEuTRPXOf+z49cjwr6oRqt35UK6CebmMiM+8eHg2l/mCDS5OTmc?=
 =?us-ascii?Q?22dgqbzVvat7R5ASCrSeU29sxk1RrmX78h9H50NB/+0x0szYhpgypaRQ49Ak?=
 =?us-ascii?Q?XESMK2pXT/itYKJl+R725nX3Tal/yPzw0c+ZLzqICpuiL6RQXAIATUIqFJEF?=
 =?us-ascii?Q?ECNE2iBQR7f4q6pN9GpygY0vyxjIU4MkrgSqQIahwwWoqfsw4bHwo0B+8q2E?=
 =?us-ascii?Q?OK3Dd0wXYqW0tvUUEe4I8x3gUdW9u9jgyqedtWIUhLOuMN8wy1b+0QEkEeRg?=
 =?us-ascii?Q?eGGSWyxjcw6Jup9O/hvOj3eMJ/biQ7hg5ykzt/JgMqpa6eu/puI6Ho6pCAPL?=
 =?us-ascii?Q?w7nw5ajp4cXXaOrbjdvqgBbMqr98qCzBM+LOywcamj8x+yRZfBWWT0woGEkE?=
 =?us-ascii?Q?1Or+QQ17eNk3uGekl8AMAddTod7HRNRf7czLE5L1OBFP913EVWUxhnpEAbYE?=
 =?us-ascii?Q?0KoUwsWSp6A5CsmcT6+EDkUGT8rQy6P7DOtUGRN1ZT+YKNEfDJwflkcBAW2D?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P8g9hU7BLVNBMcobqIerzV8tf75E7lcYtxXfJjEvhu8xEcSVs81JlyCDFOHAQ/mYqcvKVIVILN5JGay3OQ027SbYZCRC3/PFA/kDtYaHFzOGbHROJMDsSIdjZ9ht9C/pMsxah6L3WuoIh3P5Wyf+MthmtjBxpzfT/afJa8KbtDg4va0NlywJ5GMFJZZQ3m9ohuVlaxSxbMdvdloGn41NuUt2FimiQzuQ9iMO8g8ASWTk3wWVnTKfmJZ5xAfaw8nKhYxSKcGBxX4LyCsFG0A2FY7iKBzl7HDDyAi4MusDDGW1wWQIWhxBpx3o2pytPefeSG6d/f5Vy36WQEYN04hUsat43/ejRn3Df+qmGJYE92oNZrFGBoMe/6hu92Hi9SIMPT30a9JrUOwlBCtkquRAKdZ8FY9aLnma2NS97e65rn9UZ0Ld9yp4E/LEvRhV/xmjp/mBz7ergyVlzj69kJB31OCVWMSgYKDuFsNWAyxLlKquda+DhGrPjlFRZc0X8H1Uxk/dNIoz+1J8tIJMudn7ZJUx8nrsJKyVPfSFpjr9WI34mkI2zpF9Mq6sVLJMh8Ej/MtFtvFn5BK8jcvtaa6K4LgKJxQ2W5SZjPsNaLw4uxawE+3evbMYS2GOsjwA+Uf3lhzkfU8RB/Z7rHxAOnK91MgVknwhtmL26VHwjzqTmxoI25db8Jw0sPWpGa6gW8FqyxOPaf9NaYEJl8q/dv9Q8uqKpbJkIn2Oge59AkFp0TsOsvZ248i2q/F0aSK1bbo3HprGIZ9ewMVC/imWijObnBDpjWmecD5g9SauZEx/bQw5fGm7Jd3ExHPxTMCGG7Km
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47773d82-130f-47bd-5022-08dbe4a9c94b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 00:36:48.1854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taaeaoBVbovRoz6TrHjnRpRfynKj+uOJVUrTtjKCp4JaOfWe6fx13HrC8XWM7hTB7prxqdE/9e2Xg9XahQPWsZz1jX4CT5DghYa3vepxpkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140001
X-Proofpoint-GUID: T74wTKrPx6GcuIW5Wz7ftjgEiGyoFPRn
X-Proofpoint-ORIG-GUID: T74wTKrPx6GcuIW5Wz7ftjgEiGyoFPRn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=michael.christie@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds the vhost backend callouts for the worker ioctls added in the
6.4 linux kernel commit:

c1ecd8e95007 ("vhost: allow userspace to create workers")

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 hw/virtio/vhost-backend.c         | 28 ++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h | 14 ++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 17f3fc6a0823..833804dd40f2 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -158,6 +158,30 @@ static int vhost_kernel_set_vring_busyloop_timeout(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_VRING_BUSYLOOP_TIMEOUT, s);
 }
 
+static int vhost_kernel_new_worker(struct vhost_dev *dev,
+                                   struct vhost_worker_state *worker)
+{
+    return vhost_kernel_call(dev, VHOST_NEW_WORKER, worker);
+}
+
+static int vhost_kernel_free_worker(struct vhost_dev *dev,
+                                    struct vhost_worker_state *worker)
+{
+    return vhost_kernel_call(dev, VHOST_FREE_WORKER, worker);
+}
+
+static int vhost_kernel_attach_vring_worker(struct vhost_dev *dev,
+                                            struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_ATTACH_VRING_WORKER, worker);
+}
+
+static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker)
+{
+    return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
+}
+
 static int vhost_kernel_set_features(struct vhost_dev *dev,
                                      uint64_t features)
 {
@@ -313,6 +337,10 @@ const VhostOps kernel_ops = {
         .vhost_set_vring_err = vhost_kernel_set_vring_err,
         .vhost_set_vring_busyloop_timeout =
                                 vhost_kernel_set_vring_busyloop_timeout,
+        .vhost_get_vring_worker = vhost_kernel_get_vring_worker,
+        .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
+        .vhost_new_worker = vhost_kernel_new_worker,
+        .vhost_free_worker = vhost_kernel_free_worker,
         .vhost_set_features = vhost_kernel_set_features,
         .vhost_get_features = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 96ccc18cd33b..9f16d0884e8f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -33,6 +33,8 @@ struct vhost_memory;
 struct vhost_vring_file;
 struct vhost_vring_state;
 struct vhost_vring_addr;
+struct vhost_vring_worker;
+struct vhost_worker_state;
 struct vhost_scsi_target;
 struct vhost_iotlb_msg;
 struct vhost_virtqueue;
@@ -73,6 +75,14 @@ typedef int (*vhost_set_vring_err_op)(struct vhost_dev *dev,
                                       struct vhost_vring_file *file);
 typedef int (*vhost_set_vring_busyloop_timeout_op)(struct vhost_dev *dev,
                                                    struct vhost_vring_state *r);
+typedef int (*vhost_attach_vring_worker_op)(struct vhost_dev *dev,
+                                            struct vhost_vring_worker *worker);
+typedef int (*vhost_get_vring_worker_op)(struct vhost_dev *dev,
+                                         struct vhost_vring_worker *worker);
+typedef int (*vhost_new_worker_op)(struct vhost_dev *dev,
+                                   struct vhost_worker_state *worker);
+typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
+                                    struct vhost_worker_state *worker);
 typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
@@ -151,6 +161,10 @@ typedef struct VhostOps {
     vhost_set_vring_call_op vhost_set_vring_call;
     vhost_set_vring_err_op vhost_set_vring_err;
     vhost_set_vring_busyloop_timeout_op vhost_set_vring_busyloop_timeout;
+    vhost_new_worker_op vhost_new_worker;
+    vhost_free_worker_op vhost_free_worker;
+    vhost_get_vring_worker_op vhost_get_vring_worker;
+    vhost_attach_vring_worker_op vhost_attach_vring_worker;
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
-- 
2.34.1


