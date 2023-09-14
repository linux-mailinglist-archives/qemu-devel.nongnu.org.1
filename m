Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCF79F60F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 03:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgalb-0000lS-4z; Wed, 13 Sep 2023 21:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qgalZ-0000lD-FK
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:03:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qgalW-0008Rh-FM
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:03:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DGFlpt013674; Thu, 14 Sep 2023 01:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=bUBpr/41z2nneCaY5mrf2Ws2Tmr2pjPFvw0jP1+I/XI=;
 b=tqcAP2l5WmODu+qTmzByI1sdE4OtY/WZPNVi3PA+xP6ixfkqzsdgVzpwev3yOlw8GWKR
 z+6/yoR+04kzAA6czix+PJnB31pEyZqq4QkmCHsykaJXxOIqHngBTfOWLDWZo91XpWO7
 6SC8ffdvMqpdaqutwLvU51I1u660zAlU+zf81pUJxn7et9yB+Wv9vz0TeYG97IO+oD7C
 EMTNcZCMzsU59s4Gio3LCvZ8MBldM8IokyWaMkN1SUreZiOvarXy4LOxW2xfx308Vdqn
 H8OBiCPzC1X14T9jldI4FilwoIzd7+5lMnEJLVjgifziuesMpKlHpHqRQ6Y576X1ulxa ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kkghb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 01:03:22 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38DMSQwR002629; Thu, 14 Sep 2023 01:03:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f5e9b75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 01:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsgrFDVLe7cNdChDUtCQ9cL9fS7j8nhXd0iEHA38jTAqZqAOYG/TeYUWc5xWUq0Ei1Bm6WDQdMstIu5CM60ehHXzy5zSO8WK76YEVOOFhYdJmFXcNTz7mWGdy8LyQKtehQ2B0VZrhxSlf9koKZwbPe7FE7DPkgLM6frVxR05w3VuSjEUOhIKdAFYTRwNxZJ9/YMOkErPvWrEnixwZHWRp5q8FbDCVNVjdHaVAVbTxVByd8mmC0flQj3C9qDmZp0FuMNWw+ZOuRiyvIMeIJGYtOlQN8TeJMOQQLYpRR64MInL973f5p30xQDZ5K73jjcjoV3z2SK9g9o7/CknjWkVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUBpr/41z2nneCaY5mrf2Ws2Tmr2pjPFvw0jP1+I/XI=;
 b=Axj/UtC/IgphE42Hv25Wwx6XDuiwJ24Ye48+S7P4rFBkr059FAUvFA9aQZ/125fx89f3g2svtjjxYG+D9n11xQ63DuWWDRu+7AM6rFrty5J2TBxiSWzcmSwYmOlmhzW8eqpBvtFofSn0VSaUkUNzGWm4lngB1CPZ5Ku9Z5n78qkSFA8cCWLsNF9ChDalNbhO+jW6X9UpjRN8v7HoIRjEK7N5r/w7mrt3bLwQVDqTXXq16PQqjtydGjj9gx113N2geUrzazZpP6jVdhdOjXtnJotLc0Yu1uppFg4A61q3WxGlHC3cIIbAh0wfolczkSMNKrgTRGTBtAaX4SlUURbriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUBpr/41z2nneCaY5mrf2Ws2Tmr2pjPFvw0jP1+I/XI=;
 b=FW+XJvul/dF1guf5d8+Mp/ipzGLMXfdnrlJijnkfowSmygdAMGOX8T3pkx/2DH68jpoNfHDc7ARqMSmc5F1phS7z/FVrdruPQ4YYfn7Qv94N/bs0SO8EkCaZf3rjFoW4DnnsT+G8fritaEjl3SAh3YbASTpRdF0QlkUGZuwRPas=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DS7PR10MB4975.namprd10.prod.outlook.com (2603:10b6:5:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 01:03:19 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 01:03:19 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 qemu 0/3] Allow dump-guest-memory to output standard kdump
 format
Date: Wed, 13 Sep 2023 18:03:12 -0700
Message-Id: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:805:66::42) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DS7PR10MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: c844ec4c-5719-4a08-94bb-08dbb4be6240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3v7N1zE2o1BXsII0HSwJvJW3mjcww5xdKZyi2K8vmR/H+Tu+Xl4Dymreo7gBzylYWU6FoxiHn5uAeOce9zl4G/+ayOF6waUHHvWM4UiMz6QUiFV1+jSuQkDY0gpNHl+CWJuuD/KQEhpeV+gOrUEAmiX2iviWIbE4yCn1goa/DvcJrZEs6+M3a5E2Qq5MWWKhomTrfqoAAgKEw3vHH3J0mfFeei9Iovn2tBjoAF1o9Wcif5mNGwNfT/l+0WZSX+vRGV6ZFXhhLn/g3kDUF/hp9yZRjwyc9hE9mjzkNQKp3a0JGF0eu+hwU/eyEZWq7dKUNqTtfKD36WZXfVhAGjQU+2Wy17rqI1jnGmHItHtWzfD72yFS1CTu+cS8Ei7a95UL2SeSy9yQIXSZOWA469iROHGE6alAu/9KS/x6fHRvKewqDpK4AzGviquErBGP5yBLH5YuPq/0EDdbonMt67ueqYZ/0rrn2RU/notsWxyj3bAUbJ9t/NSrjWEgDyLmiZRWWQnIybTnWzyrfJIPE6xBFLpxFaJLzWDZk//JDnQ5vQ8lET3ZK/h5wyvAgviAGpPIcZjTnms7dZBPt+J52ttPAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(38100700002)(5660300002)(36756003)(86362001)(103116003)(83380400001)(66946007)(1076003)(66476007)(478600001)(966005)(66556008)(6506007)(6666004)(6486002)(6916009)(316002)(41300700001)(8676002)(8936002)(4326008)(54906003)(6512007)(2616005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGPrUcVjasueLw92CtupsBAU3xv/mjU8VNQpn0frf2yISPZ1W0dgJklasQTX?=
 =?us-ascii?Q?ilAt9hhScbdIZyiPyNqW/9vqbtcym3+W9WO/Zlcq5C6Kr7NEoTjGstRb1YP7?=
 =?us-ascii?Q?7UaSySo+6bnZsrLgWtJaPUDmJ1nkoIxFhYyDXqz0ACV7x5p/xi84wrR5K+v6?=
 =?us-ascii?Q?fHgLlxhzDeUKs2hPBKugtXwE1X2KO+B5Wf5saT9oUDj/rnTq7t2l6WrTNXsT?=
 =?us-ascii?Q?bTlTla/PJMsp+oApj7kcumV7Zuslr/70i2pyfEb5HP+kirre3dsc/iVZNGRz?=
 =?us-ascii?Q?f8k5w9k7aPSzypgTwNhc2FK18U/c6OqywjWIVKhkBVapuWvpIbKuCdj4qvDU?=
 =?us-ascii?Q?moNr1LGxpBS/l02K+vC+SQ+Zpmc38s5aX1hXrFQtHCRotKPC2fzspyBB02zl?=
 =?us-ascii?Q?kUYZMEHXppMxmaAzz69EvqSO9GJJ4dkbniSNU4wAASZzPDtemVqd+bH0T6dL?=
 =?us-ascii?Q?nBta6V2clDPHTPxzUlUGDH8I+XbTEdK4CL8D6M74fIrPWm2LWvy7lNwTEOj7?=
 =?us-ascii?Q?HAcjZFE90kHr8Fl0L0AAHR03VwWkahp6iBIjzcI0Pacw/Tex8pGC3We/Uzp0?=
 =?us-ascii?Q?UkFGuYPz/OfenrL51rTE5w56KGxM0JTxFCQgq6A/X07XRfjAiBTCOqhQCkEp?=
 =?us-ascii?Q?IeH8/d40wJ6SxmROopF/Y0zZxLQr8ZUZ1D+MMbni3GKuXJ3uRKEiNLC01/ZO?=
 =?us-ascii?Q?OQyKonItbBxa1I+7PbVo0MOO18A97tSoxwlpVG93gkT6ErRCDnGlR4rlj9K7?=
 =?us-ascii?Q?nMSiuyBKrDFM1FN2zPKal+A82JyWcvK5kaP7w1/H4Ma2PTmo/2QDuq3hDMDX?=
 =?us-ascii?Q?9bRQtXLt07rL3PZdsGB69nnl/WyEJiTtDx11/i1MWQdpWZWUpnkUIdq4EHtO?=
 =?us-ascii?Q?F7z66fWIzzm8W0hMu9BNCTydBZ4Zh2xg30023smSQm7e1h6of8bD/AgHNx+T?=
 =?us-ascii?Q?vaoGZhxYojmjaR6lwXeeDImaYjI53Z0YJpMKU7iIU3jAZlS0ymsy0tw99OXT?=
 =?us-ascii?Q?VSCQY+VtpzcZQh1zTHNWTzdQ7zfLts7QWBhPy3vqjetJN/Xsdvz6lpCoCLIJ?=
 =?us-ascii?Q?PSbz1UqTmKvpRA3vOkXM37jMfQ5Jq2gfl0qe0i3xISZtYcDZVpIuK60MLTrt?=
 =?us-ascii?Q?qzu1w6W1+QKcBr64BiH+JvNubHzXJ4kmegHT4brUUvG9zxNtVPJ+6OeVy77E?=
 =?us-ascii?Q?psphDOe0FGV9SvYhvwaGPqv1O7CeccC6Ro8uwwrErqxR7ZZ77yoQBpX/HeuE?=
 =?us-ascii?Q?aBqQ3wE4/potLtAsNPbyolDbFceSOKm/jhrDOr+rcrcd1x26EO+j3lw0sGHl?=
 =?us-ascii?Q?a8q9UsE0dAtEjR51NOzhJvGd7H8XBVdgIHf6HNH69VluvR0/iQEsmOgX+uCQ?=
 =?us-ascii?Q?MXDj0QlCQ1Ot1Fp9W+d4WsVFV0s0w1Cxg0U2oNp0Z1U/ZCnVp+goEMcgVScd?=
 =?us-ascii?Q?iVjFMrMc9guzEGhTYZf/SrNjEbD1wXJM6cSR7cJ+uz32nQxzzJqPbFTTn22Y?=
 =?us-ascii?Q?QNVCSCsYyG1vpg64bAkEhUB72b9q4+HC6tSbR38ncux77X6HFZANNdNz7pZe?=
 =?us-ascii?Q?bLHdPyg9u8LT0LyJIFBQsOp1/eJ2f6fGsHAmKUbsHxScxdp7YSwHKZTbl8yy?=
 =?us-ascii?Q?cgwEfZi3cq7U5KbQAto8mIWeQYOBEOwNf0QlFfE0tLNC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fWzJ6e6EYi5YrMbaJ2SjOsFDN7WN/37SRVYsaswmCKKWlp6VN/thhluNEfHqw/fnIOzceKuQhhsmeg3Grtg8gCyrlew+VU5nCH6IDciCgl/1FwE/shSH3wY6ygRugPQe03mHlU6Q463RiBl6QdGs0IRj+shO+DyYMHhVfTSOhtqRoVqc/Ce0QxCHhcyh2QfVDEVngTrGvelL2GcZOLtEsZvTUDD8zXi641BdceLah44kgr4m0LE9mEKDzN1arMrqvFfUV20YndNr3IdJto6FaOdzpoBWWY98nNUpWshOYMLPjCJj2yh4GqOAhv5a6SUv+ggdkWMeGMP3T7oUS3V/5mpg1Wi6M2vrleY5vApHKtQJTpw9QLm1S5Gp2EiSByZ6AB8e7+uihKv10g1Ac7pCYl4vKoY8a1qrYnnEU0Rdyb0MpRmb+DnBdjpvw/lbxrAZxpeBzhEZY2G2H0h29jX67fICl0zho5wkuX3+O7B7y98iNybhK7V47jsqad5NUvfErxWZNynOcPDg9+VlvIKeVHf6mbWX4kYAFZlGjvAe6xAdubzrUYjfxHsdbn97FFpYOpBbqm8q4bpZE68vyuyfzxXd1m4a7dl3j2Vh59K1qJNadUwqooH9RcaRGcARKV/daEk8MM8GGw0GvyjvPVzWaAG6/Ua/CJ3vllX4Kh2fKPPB52Jk4O9bzOVkP8tQ+oyNxuLkTGwBTFPg1eaBd4lFkqXSkNPwUotHeQlbs9ZGHGtTkupEBm2oqQ8pNfxVZd7+PXtL7G7oouN9x65pXA6KRRU5ecMKcyXrEZumVWBE8xLJS2HnTpqgpjJP3Z5SlYsXi34TQqTI7txbOX7b3Ax36Cip5DX6Zk3kFTdfKil8NrtAceHrxxcGmtnsGW3qZ1kv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c844ec4c-5719-4a08-94bb-08dbb4be6240
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:03:18.9655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZrNYocEtnPMIFNH37UcFjHNXU4ZBzyyJysEBZSqIRxr/4DtYCSF8lKATgbA+4yCqDIE//05YgTfGu9tY3nrAFWm+Q+d0zoVBPPh9cBIIU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140007
X-Proofpoint-GUID: SCsqtnNvB1Acxb1sISIYklpeAxd15BFw
X-Proofpoint-ORIG-GUID: SCsqtnNvB1Acxb1sISIYklpeAxd15BFw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello all,

This is the second version of my patch series about the kdump format,
you can see the first version here [1].

The current output format for dump-guest-memory's kdump compressed
format is actually the "makedumpfile flattened" format. It was done
intentionally to allow the flexibility to write to non-seekable file
descriptors, like pipes [2], without using temporary files. Currently
libvirt uses this ability when VIR_DUMP_BYPASS_CACHE flag is set, to
avoid the dump process using page cache. The standard kdump output
format needs the page cache so that it can seek back and forth as part
of writing the dump file.

So the default kdump dump format cannot be changed to the standard
format. This patch series adds the ability to use the standard format,
and adds a QMP / HMP argument to enable it.

An open question for Daniel et al.:

Would it be possible to make flattened the default only for libvirt? I
totally agree that this would be a bad backward incompatible change
there. But for QMP / HMP commands, I think using the standard, broadly
compatible format as the default is important for user friendliness. If
a user needs to know the difference between flavors of kdump formats
like the flattened format, in order to set the correct option, then
we've already lost.

Changes from v1 to v2:
- Keep the default as the flattened format
- Add QMP / HMP arguments for "reassembled"

[1]: https://lore.kernel.org/qemu-devel/20230717163855.7383-1-stephen.s.brennan@oracle.com/
[2]: https://lore.kernel.org/qemu-devel/1390890126-17377-1-git-send-email-qiaonuohan@cn.fujitsu.com/
-> see "changes from v4 to v5" in this patch

Stephen Brennan (3):
  dump: Pass DumpState to write_ functions
  dump: Allow directly outputting reassembled kdumps
  dump: Add qmp argument "reassembled"

 dump/dump-hmp-cmds.c  |  8 +++-
 dump/dump.c           | 86 ++++++++++++++++++++++++++++++-------------
 hmp-commands.hx       |  7 +++-
 include/sysemu/dump.h |  3 +-
 qapi/dump.json        | 14 ++++++-
 5 files changed, 87 insertions(+), 31 deletions(-)

-- 
2.39.3


