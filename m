Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6551F7EA791
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 01:38:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2hQO-0005bV-R8; Mon, 13 Nov 2023 19:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r2hQL-0005ZA-Tr
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 19:37:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r2hQJ-0007Vu-PR
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 19:37:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADNsroR001097; Tue, 14 Nov 2023 00:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=68cxwzCaLx7aCsBdyJEuSGtZ3YS5/lR1tMf1Gy5xa0E=;
 b=CRMOXv77H0W2ko1HXrxipxUSgshibT81nwPCBzmYZw8bzxNGmT1AFqsl6tCzjFg1w0jw
 0IHNHotlcUO+nwyjfubjXqgj6elKD/72NzlytyZhzLaDk5jPdUfncPFAecu5CrW3otzk
 ZP8yMdgculr1OH4vURFNt1yWMtniLwqz0AbjhH3ssEQOHKBbaqLmzxZaQFqHlDbHkdza
 LjOpQ1x9dQ7lGWrPeAHRLdHh0vtTZe3PvAjmc41K88wBDodlCRbfmgwWjFxcyROUMf9u
 r3X+GD3kZ1ihYg42mxtYpkwYPyhmDVB3yjC4L4tg7YGxasOKpjnXTwYjqzPZsxSqBLyf hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n3c1qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 00:36:53 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADN3g2h029776; Tue, 14 Nov 2023 00:36:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxqqqn89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 00:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNzGtj/m20GrvZEXiros5Zow0v2bBlUik/nFuaeMx1+KFi3hbbnGhW9mhznvSwux0v08OC+BTT5xSuCNoDXcilFTVtgdE0aV/gYrKPXloblYwPIBGoCtkMTbaw5y0VdPb4qkuHZxYRlur7yz9bU7htXp3/eEjQIttApxnhosB5YSwWg4BO6UGwUabHr0WPxSy3PL4tMD/Dwh03SBSWz+WLmSZL1X1+I4yAaaw51tWR8P7xPxPlVXG4BWjDazU3B7YsdMoYjcRhn93e0w1D0ixXRU/5ET/wOm36ZNQmCEFb4qhjsiKGCyJnBz7XvPnX9oPKg98h8XKnvA3dTgu3ZA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68cxwzCaLx7aCsBdyJEuSGtZ3YS5/lR1tMf1Gy5xa0E=;
 b=BN8+SklWEywcDrFi1TY0vriuHi8VrCeG2tJ70tJZ1q05FKWHPEl2dexyZ5pN4VGWS6usOn0K51q+KxNUhQPKERT4QpWao7xOm/eo55YBatQ0Pl5ubIWMExV2CGdg3bWSFJPFW7uQA3r/k/Z2TKcaI+Ai7eX0IhQTHpl2eYaq8oMduzRJfXbMEdgspqJ1dhg/OdsR39VidbYH58BQzWBbfMhSjOzbiI3YGOlrblD62D06VCM5OMQnG1RVQvji+0snyRAe4BPTOomsH8JLsv2dsHy1Qlz35h++L35ui5TbBwhA/LIBHxJTmmHCcyFiq/VFdAYyxbQVGthR4jyAOU1+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68cxwzCaLx7aCsBdyJEuSGtZ3YS5/lR1tMf1Gy5xa0E=;
 b=Aa8C6Gf2xDBURmp2315TJmsPiyKuP26oTcvgE1pdxumID27tmMjwtJMxHwrLvM9lvCwdxNIs0xpyTIoiNw98LdFPeHuZrs3cTi+LQ0XbtWHKikQaT96iTotp/wgULCAdbvledE0ko0PJYdTbqGZOxj9ngr6Nr/8jYTBVPeRBKqM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB6436.namprd10.prod.outlook.com (2603:10b6:510:21c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 00:36:49 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 00:36:49 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/2] vhost-scsi: Add support for a worker thread per virtqueue
Date: Mon, 13 Nov 2023 18:36:44 -0600
Message-Id: <20231114003644.7026-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114003644.7026-1-michael.christie@oracle.com>
References: <20231114003644.7026-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:4:60::36) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd5b690-1d70-4944-fec4-08dbe4a9c9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jjo8cqTb6uYYLa1nlgHV6W0oj+DzAKFZ81B7FSEtZnUisgRd3nMSqBiK9L+d6Zaj5pKqbmSlzcOXwLYsS9KkYj5lBSF1JrstOfYhjJUDwceWw60o/qHNW74oxs0Duc1IWivfaSMasUepB5630M7r+EpAb9Vd6GPffMIYJFOLy6m4j3kqsYjIi8pkJFSoEwfdhcfCLq7Drw8Ccq3YQt2URifXWbqa20j0sZtiv5KgeSI7adkWrKpMsaFQ+VnkbS/PGEgCpys6SVLoAMjqc47/OHhmac9rLqzpm42vEbR0RSyJQ/SrUI/Pxqz5UHAB9QptaXobd6M/RuuNDOqv3D8Ukk8jnbp23TOIFpVzjKjZ3YKvRo19uvY8gIR4Ady+Zhg1qV/atX5kFeoMXaIHbz+/o+wOdKFUx7MG1KPEVZmgTDwUaH3hTlvdTUQC9l1wZpAalT1lzyLQcROTpK2OWYuFbcHql8S0vMaHqfBkBCW2iM9upNvTSWgpuxgMgOkisyRsoj6J1z1v9o1iJ+OXgHatx9DmXOHG60Wi6IGE1d+TJu4Ibyi9iPfYC3Ocb6f6eNMo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(66476007)(66946007)(66556008)(38100700002)(86362001)(36756003)(6512007)(107886003)(1076003)(2616005)(6506007)(6666004)(2906002)(478600001)(316002)(4326008)(6486002)(5660300002)(8936002)(8676002)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7TPiQvG8LRGIVasguCWc5LM+xe7UhhRJ3xGbZdbppgFFqJ0kJOYZHc1vB+0?=
 =?us-ascii?Q?1GWH/U5XAzGWctHzbI7rSuTcHLWk4ndQiQjQHawrmhhdGKgkZC3QCXMRW8RZ?=
 =?us-ascii?Q?GwgrEsPc//A13rB5F78aqqmVVDsclmcz6+ecxsx/itqw45puJenkJivN7iBI?=
 =?us-ascii?Q?/5ShnwV54HYsB82GI6noHiED2seVGCMpxs0mDLlC1ZiR34H7YbS1K8VC2Iix?=
 =?us-ascii?Q?/SgEd/fiLTirTxtmfQRin8+nQ9PoMcAn9nIH1eGTIh9ZLO3nqC2N/p51n/49?=
 =?us-ascii?Q?lYc7uvkywFVy6z34rjT7AXwXKUHoSUX3G1nq4wpKzFNp3X9ebfL+0aUklaBE?=
 =?us-ascii?Q?xgMm5v4IJ7t9I+guWf1Z4AT0QabpT5ZM4YMrljlspQbWQBDbQK5QKFsUO80Z?=
 =?us-ascii?Q?b506z46+Lee/7IKbyYJA2OGesFslI5QjVDsltbwJitCfxxIq3l6log7V6oub?=
 =?us-ascii?Q?8qhi1F0bf5uBJmRGHhsoToo2JumckvYgyCN6e4gnHqUh2lLgFDvCotIPixIX?=
 =?us-ascii?Q?NG/mGS0dZo/d7/PSIdZr1YUiXMdETxJfmMPFkoP16OKqdNwX2pd5s0rlYHZZ?=
 =?us-ascii?Q?1cLEtFdJYNkjsx0lIGi+sUcw6kQnScTnbjaEDJ2EicBABPxP++x2jGDRdaeO?=
 =?us-ascii?Q?Gl8GN3BLpXlJJQuNzhccu/qlaRxd+lZBUmY7mac4Uvu1sntbTvkwhLSzo425?=
 =?us-ascii?Q?dlz+Hx1pLLAC1tzowOdpgQfmh+SE8LugJy2UhbM+qYXGhDsBUhE0C8PQzEa1?=
 =?us-ascii?Q?qfYIt8sSB2CAM2yf4c8PwKgMqk/5UvhdWZRGPdW3+AkHilSQx4gV/uW1MZTa?=
 =?us-ascii?Q?r+OWRPPajYA2mwypd0IkhKCRBrJH/VB+UoG+PGGYxymLo+gRWKw6czY2g/IN?=
 =?us-ascii?Q?UmfsY9+xL26QmWdJblxMydFchdIMTuJtZlrzrq/06ttDhuyjPIVBKP/dJJI4?=
 =?us-ascii?Q?pTMH8q0JAxRIQei7kmBI/LioPeb4mLM49hTsJ5zawCjlogWNbDhDt7zAMQQL?=
 =?us-ascii?Q?t8lUYzGjFFQRFsNbAQIaHF8FokLbygO3LlmqHYDJn0rIcq/oLkoLK23Ny4da?=
 =?us-ascii?Q?cdGuSdc0rW7j989wsmvkq2ASiz+exi2NLsOBaeaIbQ5Q2z56NV7mbiKOHFda?=
 =?us-ascii?Q?DnfyMZdy7UiIq+uWwEa7Whk884k2K0W09wHnf1NRJZoFmy0oaX5pss2klV+2?=
 =?us-ascii?Q?6+48Fo7TWpqdrQzT7PyMW8MzK/AijxVS7hEtuOVptl+SJOBHczD0Ut4GzKSp?=
 =?us-ascii?Q?QNrGUi5U49GarZqcW3VtNjqUWGklzDF3WacQlfK+af6+twPlDZYSL7QWAk3F?=
 =?us-ascii?Q?Nrck8bw7Im4UIctqA5h+V/v2A/e5bPCDtYwBS+OoS1aQYkUdslytyeODPE4M?=
 =?us-ascii?Q?iJqLQKzJLJSM5xKVdblmon5R8oChlkS5dT9euWwFlMiYyHlwBrGkwZx6XYk1?=
 =?us-ascii?Q?imNDRG1ETpkMt/gCB6KRvolKqj8ol1HANx6xe3JfSK+p9wh34wiNrSh1O5HB?=
 =?us-ascii?Q?VyST6aJnXiPHb3gKpvKthrnNXRtCCRq9ApvSfqTgaUgtUtvoOH75IqZrDUbB?=
 =?us-ascii?Q?f4Ov4aI63XFX3D8HKGmf7++0emsbMXFiydYcTsyi12sYtQq9LD8Yx3UHMZz/?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5bdfu5KJowgTAbEKHSx54Ftrc4sTsHxIr0kR4m6s/0foLrv92XkqAhb1YOMT6DdwWKh4/yt2k/KbzrXtolCvMVvASofVycGzalqKFxDG1b5NnrfogFdAMSqDxHf34f92EWSXVLMZyGp60kJ/HClXtTLW4pRKHcI9ulLIUPB8AZbK3Wk+OjMvxYqkIYDDGSzwosrITI09Ika1e0HLcjCzCP1EC4R4n7ixVolhPmLW4BCeFtnGQv9/AHDsnUFTUcz8FnyH1+juzGblD6CluFYSHuvNjFsH5dt0TspC7Uy4jiylEppdzb6JdZ+hg03tIkbJiTop9vRo/MXw6e2dBjlIyt6tmQEo6aCBcfFLv0fh9vXrXtbzm1Gi1ewOvOSGs7U1iCs1sKl4NWfefJyhKF4AShdGUE3reoqMArqVNdNx7evmbOvX+4dM9CCUfj9tlOZOGa4OD9IrEkTc79ucf403jfY6crd3vjLl7B4ZvEdjjOs+4f6KYfSKvNATpB1S0TAWiZo8tac3m0q46swn/S6+Gd+08OeuWwciKWQv0m1IGRAoVVLS5uSA+fYppi7b+qP5D+sDrCx2IL1ZkBZ4Y4Bax6Qf/v9Q0e6mcigqrzph0k1IUX4RZNKCrXAv+kvjCi98XXAoCrOP6I71JP2yzeneSeElqflMsejz8NGQ8S7SJBz7GzcGUUCa/Z+vXWXtH5uMIVO0bt/Vq7YYytXd/WlaRxsGgiWTz8/WoH4WABg+MUK9NzRC+XxJOEOy0j87aRzgzRm5cMcOOvlkrDJCwbGMCm6VmRTr7Uqk8AIFiEnJI0gD4YAoqXB0MIUeCcbPMK15
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd5b690-1d70-4944-fec4-08dbe4a9c9f6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 00:36:49.3032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogkrSyPewLLRidXbWJ8K3lkaG/cP/7Sf16MPxbY0AocGZpUVuI8Pcpsy7p/3j8o3ay7pcHaSWkLvVnKsFkyYPE0eDpbf8YNBrRCM4jyG9YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140001
X-Proofpoint-GUID: YQU-153nSkQ-sFSPjLt_hExVSuEKPQzf
X-Proofpoint-ORIG-GUID: YQU-153nSkQ-sFSPjLt_hExVSuEKPQzf
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

This adds support for vhost-scsi to be able to create a worker thread
per virtqueue. Right now for vhost-net we get a worker thread per
tx/rx virtqueue pair which scales nicely as we add more virtqueues and
CPUs, but for scsi we get the single worker thread that's shared by all
virtqueues. When trying to send IO to more than 2 virtqueues the single
thread becomes a bottlneck.

This patch adds a new setting, virtqueue_workers, which can be set to:

1: Existing behavior whre we get the single thread.
-1: Create a worker per IO virtqueue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 hw/scsi/vhost-scsi.c            | 68 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-scsi.h |  1 +
 2 files changed, 69 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 3126df9e1d9d..5cf669b6563b 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -31,6 +31,9 @@
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
 
+#define VHOST_SCSI_WORKER_PER_VQ    -1
+#define VHOST_SCSI_WORKER_DEF        1
+
 /* Features supported by host kernel. */
 static const int kernel_feature_bits[] = {
     VIRTIO_F_NOTIFY_ON_EMPTY,
@@ -165,6 +168,62 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
     .pre_save = vhost_scsi_pre_save,
 };
 
+static int vhost_scsi_set_workers(VHostSCSICommon *vsc, int workers_cnt)
+{
+    struct vhost_dev *dev = &vsc->dev;
+    struct vhost_vring_worker vq_worker;
+    struct vhost_worker_state worker;
+    int i, ret;
+
+    /* Use default worker */
+    if (workers_cnt == VHOST_SCSI_WORKER_DEF ||
+        dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
+        return 0;
+    }
+
+    if (workers_cnt != VHOST_SCSI_WORKER_PER_VQ) {
+        return -EINVAL;
+    }
+
+    /*
+     * ctl/evt share the first worker since it will be rare for them
+     * to send cmds while IO is running.
+     */
+    for (i = VHOST_SCSI_VQ_NUM_FIXED + 1; i < dev->nvqs; i++) {
+        memset(&worker, 0, sizeof(worker));
+
+        ret = dev->vhost_ops->vhost_new_worker(dev, &worker);
+        if (ret == -ENOTTY) {
+            /*
+             * worker ioctls are not implemented so just ignore and
+             * and continue device setup.
+             */
+            ret = 0;
+            break;
+        } else if (ret) {
+            break;
+        }
+
+        memset(&vq_worker, 0, sizeof(vq_worker));
+        vq_worker.worker_id = worker.worker_id;
+        vq_worker.index = i;
+
+        ret = dev->vhost_ops->vhost_attach_vring_worker(dev, &vq_worker);
+        if (ret == -ENOTTY) {
+            /*
+             * It's a bug for the kernel to have supported the worker creation
+             * ioctl but not attach.
+             */
+            dev->vhost_ops->vhost_free_worker(dev, &worker);
+            break;
+        } else if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
@@ -232,6 +291,13 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         goto free_vqs;
     }
 
+    ret = vhost_scsi_set_workers(vsc, vs->conf.virtqueue_workers);
+    if (ret < 0) {
+        error_setg(errp, "vhost-scsi: vhost worker setup failed: %s",
+                   strerror(-ret));
+        goto free_vqs;
+    }
+
     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
@@ -297,6 +363,8 @@ static Property vhost_scsi_properties[] = {
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
+    DEFINE_PROP_INT32("virtqueue_workers", VirtIOSCSICommon,
+                      conf.virtqueue_workers, VHOST_SCSI_WORKER_DEF),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 779568ab5d28..f70624ece564 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -51,6 +51,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
 struct VirtIOSCSIConf {
     uint32_t num_queues;
     uint32_t virtqueue_size;
+    int virtqueue_workers;
     bool seg_max_adjust;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
-- 
2.34.1


