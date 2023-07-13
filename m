Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F5C751872
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 08:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJpMJ-0003Th-9c; Thu, 13 Jul 2023 01:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qJpMG-0003TT-KO
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 01:59:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qJpME-0007O6-G6
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 01:59:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36CLA8tr028911; Thu, 13 Jul 2023 05:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WbqGh3CzROY1fjkmJnGSRVZLRdStu23CT4N9khx6VBM=;
 b=iASM27UjCZdq5ZCmhjbXoY1PsLPptbRcxyevlgcsMi5YPo7MCLy6eGLuf6bRhAJ2/qrD
 NoeqZ+2+SOvF2E+SjMomtU2GbcTOF8OY3Bm7O5I/V31NgLYSrIpEtx2oBaexWL1A8j1z
 aSTbuQEHv4tkqLRaCvJO5BmmrCVx4HxKMShmwHCXFcmAdfSM5ZDPxPSVgrnd8jWmZWws
 xJDQ9O+5t33akqwbnOYLYlG3KizLd0ZxqP+keDyezSQWI/08LSl5mUv6hMixG5wnMfCx
 5PO8HswUqMu0Mg3OSJiz19ySjZR3iAn+itTlflxtYaCQF/sgsQVHNgJAXYD91CqOjGys Gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xuq8gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 05:59:12 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36D4aJnO004301; Thu, 13 Jul 2023 05:59:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rpx8e2t65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 05:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZGI+22Pe1u6pxxctaqSPOCTOCjUpnTfDH7LyojjqbGWKj9atUYbfeiVzG7RInGglup89EUmJJnsiKAqWb9+zWY5O74HI7C3qU+TSFeE9EKuZa7BPeiPJboBSuEHaUfDJC91yJkMOXHXBq0kkggGGYtQWzLQE48iJ7QPq7gMtnCdF0kUPDTTxCmbKtt77NXtbxoCcvrCbNRL6/VlgXudfUwEV7Sc//u361fc7Qg4mrARJraL5EGl/wGDhuqNk2oxTJDKSfIiDK0bPpqrxDN3A91h3hikakoNHipcaj4bOEYA+RVJDbdFckqyyr3ZbyKqKn0NO1N1chVETOu/TEcjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbqGh3CzROY1fjkmJnGSRVZLRdStu23CT4N9khx6VBM=;
 b=SBWCprzvhs/0GiFRt5C650WJ+Tah+Wx55YhWAJQtL3mulkYzSRaLIvqqRbLFuPOrbNFWF+WVeTIcKDjySPh340fHfkZ9mos1Cf+Ogc+o2ZtymtNVxBjFI2gjPoH7XUCVXjPczIRefIYnvJfDHSZuX5Z48A+4+CVSSVFxy9Ibu1MZaKw/d7RLGYt6gH+b3iV4E9j1M/tMzosy8K+py8LNEAZgMfqYGkGpDEWdLx/7y0Y9uBCuM84f8hbAPSEMoMEG5MAk7+26J1z7RoF6CN1oTSLEQ2BQi2ukJgX01DAz+Aad72pyKHKK0gIn6YHyL72lGHQpODa79UXP5l/XAvHVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbqGh3CzROY1fjkmJnGSRVZLRdStu23CT4N9khx6VBM=;
 b=EAnnuVoGthyy9GyxGrIh0AmOp4Q7RZH80e6mhhc6Il98zlFmwuph12KFb/GE8rZKKR/8suxx/BeSDCnScULNl3/WR0QLZyi821AcS8fCfpssykpvzjG7Tpy0O0bzdj9kV7qFk+ahBNTyOtqDiix9jkhMiBwH6huJ+kPfnyw4w5I=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BLAPR10MB4977.namprd10.prod.outlook.com (2603:10b6:208:306::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 05:59:06 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::96aa:8e73:85a9:98b9]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::96aa:8e73:85a9:98b9%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 05:59:06 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, joe.jin@oracle.com
Subject: [PATCH 1/1] dump: kdump-zlib data pages not dumped with pvtime/aarch64
Date: Wed, 12 Jul 2023 22:58:19 -0700
Message-Id: <20230713055819.30497-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0105.namprd05.prod.outlook.com
 (2603:10b6:803:42::22) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BLAPR10MB4977:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c29952-c358-4344-39fd-08db836643f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHjPZNAgT/SDyD3YllRH20A2lC0vO5G+ygaTBub4X6YbRb/z/yMjTnTCsZ/68boouN2nNEjMRuXkmxbDs73xeUtByjYhqn7KkfOzfY/NATz6j8qDMavQpsIflDbUkf32+eTQqigMwDT3ix9GpNxU/MiqrWhh8Wt8OTDrYf2XH6BqEYCCHfwQgxWvt8UeckDRU9/nIkE1971sAPLsNNch5uSY4lthTGxasgg/ZtYqTCagGEi8xSMRX+a+sV3xfCaYlvfizn0P5GJlmXbKuLK67OghdCSV5SeeaorEXrbfksapz4xRQ+pzSGfu8dUYjY8ybX3HfPE6Zu2F7SGyCZGkHh9HmXacUXb4Pw50hSccWoQRlb3qW4VAwD7tE0e9Hg6meXJXdjw2fczj76H1As4zBDLljsPRFu5JhA6ZoioWQBGTds8iMY+G9E3BH5pqgixIP22MBNmzGYDvPW/kl2gqjDcDLPQZknUsG6luW9lFxCupIL4VAjOX8uiZZmX+x5CGyekukTWB+b7Qao0GdGCA59CNTu7l2PKeGeiY6eebkyzAoNvrNK0zHkH25tEpCAR/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(83380400001)(107886003)(2616005)(38100700002)(86362001)(44832011)(6916009)(8936002)(8676002)(5660300002)(36756003)(4326008)(316002)(41300700001)(66476007)(6666004)(6486002)(6512007)(26005)(1076003)(6506007)(186003)(66556008)(66946007)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qfymudcHMa15ruZGIE/z80bnQ6UKfTeDC1zLSjjnTO5naYUFY+YowDMtOkSi?=
 =?us-ascii?Q?wq1Yjy/zD0xp4r+hxYXJgJAwKxvrjalXzekUynTATX87owl444nj/rKxmcvO?=
 =?us-ascii?Q?j+T9QWvuNmTPG2bUdgAumnyx8b54u8UeWZldIQSvld/5JsPAn9DI5r7oTxU0?=
 =?us-ascii?Q?u+O4eDJbT6Rq/0PYoH5+P+hAnQt/Y3yeJSTON4rB9H4iIc3TK44qZ/52/xnc?=
 =?us-ascii?Q?JW3kAnLe8/AkbLPjAyCyGtPCaa+tOExxpaSMljRyvkeJp2bEiq+Z5RIc2ot5?=
 =?us-ascii?Q?vwFhEK/+B23ZNohdMXSzWp7ooGndbQCGth/ZyIZwURP1HrRxIE1ErBx+DLcJ?=
 =?us-ascii?Q?s7hlI9p7665ejNR7ZWtoxS88TL9L8f152yHVeKeUX3MW1x3f1t1Cw2FdbL6J?=
 =?us-ascii?Q?PVrcpaEjUEodnPgRt4KjfKBnHTVmx7W+lwdFr8gDLH0emXX9I8HKcGQSvOPL?=
 =?us-ascii?Q?IHBOaGq32UUS+fCBaNQZKnipdgjEwOVIkaeKU1hV+Le6aKhvrlolz8ndesSY?=
 =?us-ascii?Q?pePm4s2szbJr5OtkexOpRV+ZDbNx523XNE42pUYQ2mkKukjte3WAGqbEFXI9?=
 =?us-ascii?Q?Ujsi2PBE0G3uqNQDFWCztWX8iFxrz00NwPWUbYW4ObHbuaHyNseiNjT/4cHK?=
 =?us-ascii?Q?UXNdYHUAskrxDayHVw5J3MS7x2fj5cBy6nPB9CnG2cba7Ijoyx9loYYwJrW2?=
 =?us-ascii?Q?SUkvmfm1yrIU41iavOBnkwvKEZrrsgOSYojwsmkyr4NfE9poXfyovIrUf8Zt?=
 =?us-ascii?Q?86JnL4syTA/rGYsEepDnbgJo3WGRK7Yk0LZTe6p8DUNcCTB6lE1oF1c/zPy+?=
 =?us-ascii?Q?6YjM2zOs0piSxWFsi6YdOo+3yaZjLnpBoWct7f5wXIvsODlAPB45C1h0tNF/?=
 =?us-ascii?Q?Vne86FuoBVPdmUuPSOaBnQyOb1QaijmsP0jajARggOHSf0a7KHrmrrwlFo7H?=
 =?us-ascii?Q?FVcwKTXZwrFRuxWs8RnKwU9yOu10LuJujKEktGB+I0/sf+VgZrie0pCwbn4U?=
 =?us-ascii?Q?MZohb7TxW23bLequ1ZhT0itSg0eSIIYSRYhD+bq0ZUg8/UmkongBvmi660Lo?=
 =?us-ascii?Q?rMKVNLF/XN5RWhCli6f6rMTNYXhbkCa+ywmTB/JOmRBY30mTt8mWgNBJtMLG?=
 =?us-ascii?Q?w9qhxAXpGvOUQ0scLUcEvt236/PeKRosVf5vT9BvW2A2VVWVzPSs8kohsY8P?=
 =?us-ascii?Q?fS9ra9gJTPwNz6NsN9PAV83esw4imhHdVDz8R0MUV71HGSej4oml2qLPVd1n?=
 =?us-ascii?Q?k8IDhCictGSFTn4cl8jSz73CbgvL2yGmyMCHlX6/TAIRaAGw8h3CQkgjoUzy?=
 =?us-ascii?Q?mkvzqNmsWQdiG7qtM+ZCzC3MuEjPuPtp+xk1OWJ5WiOsIKDw3JEPRPd5dW0x?=
 =?us-ascii?Q?DyjEMLsBRIkbpI0kZo3Wzbc2KBzo3M224Zu45Ukh5JPy2hjiaPTI3uQmMV/H?=
 =?us-ascii?Q?eJDGuxcrTbL7POochXE9+GgiBwDF0pLKt6zd8Sr6zHnnTjgTJ0ZEn+eP034Z?=
 =?us-ascii?Q?TCw4ljoqhG1stXLMmoAhEbQiDEYiXtOv00SZkSVsERpk2L7hhQO3dAZRpUuf?=
 =?us-ascii?Q?QydcETj/WnKnnsyhgznpOJYLOhYCgefZOwlH6L4L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a8IPrKlcZJ8e1qfhuJN0+1EqgRpLlUI0DXqFVCxvswBraqj+rBExSaJ9CEMmmvg/MxFuasRg7NG5R1noqACR7YGbNJG+nETMpRMz4+XR7/kJ7CQeNF6JcJ5IY2MHJZUBilik8/PMiczig922NWzcPhrWB708g1XmJ23nCz9o+yC2lfeJU6xjqT+mdQo6lB8sfV7PnxfcQBYfYh5wy71E3HV/IGTvNjxG0KHjTXQ8d9HmZpjkP7TZJoYozflxrzfYE2HssxBrwXx1Ohbx+xRMIN8vkCnin96xqiG8nL4KrvXAaltxMs7Rq5E9fL4N+CAMOYLORF0/IQ1NiZOL3SCPK05lJIcLshA7lociqLTkoSySee5U05KEWBC5O6bdEdRoVjpEiZ34rgezlA3jDjwmU79D+dxo6uaTzG1Uw++Hh+owINRxpX9Qkh4M7HPW9J+oUqR44zrXEKfYhrnwi/cnHLMznB5vNoq7sGxagC5ngtxscm80sLqXMHTGT+s2EfV1uQ6HV3zqv7qsUk54h+bgI0TkP3ylnzbk8JGswdA3s6XyWxsc9FxWtYD9yrL4qRZzJLLiGfg576B49tN8rbKaCGSLMsnx+X6dVel2hepRFFg3v/WH2h8zQsb2ewU/LQpFhzJYy0CT1d22+FV4TZTjP0FDZygttRH1PDr2LsEX5VOnkAE2iyvKjmpFY6TjTm335qcwOUnvbBNCj4Fbvv4rXjEaM5LjO3pdi8i9RHuzB6fXbx9Tq+p5oOiFep7nQLCxphIMnupcOaM49zpMRqGfDQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c29952-c358-4344-39fd-08db836643f7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 05:59:05.6284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5jQy8OW7dqF8p56PAb1Ue3y/Bk5+OUn8ycoj09aF0LC2ojF26zPbmEOPYlm3Z8IggShox531lQvYFyqvp8vog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_03,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130053
X-Proofpoint-GUID: H9uYcKlfceVkK7RpbOzK_GsjBpcuMz2N
X-Proofpoint-ORIG-GUID: H9uYcKlfceVkK7RpbOzK_GsjBpcuMz2N
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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

The kdump-zlib data pages are not dumped from aarch64 host when the
'pvtime' is involved, that is, when the block->target_end is not aligned to
page_size. In the below example, it is expected to dump two blocks.

(qemu) info mtree -f
... ...
  00000000090a0000-00000000090a0fff (prio 0, ram): pvtime KVM
... ...
  0000000040000000-00000001bfffffff (prio 0, ram): mach-virt.ram KVM
... ...

However, there is an issue with get_next_page() so that the pages for
"mach-virt.ram" will not be dumped.

At line 1296, although we have reached at the end of the 'pvtime' block,
since it is not aligned to the page_size (e.g., 0x10000), it will not break
at line 1298.

1255 static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
1256                           uint8_t **bufptr, DumpState *s)
... ...
1294             memcpy(buf + addr % page_size, hbuf, n);
1295             addr += n;
1296             if (addr % page_size == 0) {
1297                 /* we filled up the page */
1298                 break;
1299             }

As a result, get_next_page() will continue to the next
block ("mach-virt.ram"). Finally, when get_next_page() returns to the
caller:

- 'pfnptr' is referring to the 'pvtime'
- but 'blockptr' is referring to the "mach-virt.ram"

When get_next_page() is called the next time, "*pfnptr += 1" still refers
to the prior 'pvtime'. It will exit immediately because it is out of the
range of the current "mach-virt.ram".

The fix is to break when it is time to come to the next block, so that both
'pfnptr' and 'blockptr' refer to the same block.

Fixes: 94d788408d2d ("dump: fix kdump to work over non-aligned blocks")
Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 dump/dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 1f1a6edcab..c93e4c572f 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1293,8 +1293,8 @@ static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
 
             memcpy(buf + addr % page_size, hbuf, n);
             addr += n;
-            if (addr % page_size == 0) {
-                /* we filled up the page */
+            if (addr % page_size == 0 || addr >= block->target_end) {
+                /* we filled up the page or the current block is finished */
                 break;
             }
         } else {
-- 
2.34.1


