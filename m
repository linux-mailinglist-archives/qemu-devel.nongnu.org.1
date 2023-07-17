Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FA756970
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:44:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRK2-00012e-V8; Mon, 17 Jul 2023 12:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qLRFc-0008IM-T2
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:39:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qLRFa-0003dW-1x
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:39:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36HF0bTM014471; Mon, 17 Jul 2023 16:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=EyaBGW8+Wjuk7Yh07D4PHS6NPNtR1a7/85EdYjrLCos=;
 b=2fdQxiHGg99wzyEdv3hCguak+PQuLRhDuANgv302+JsS0W9mqnQl3xb6XmMFkoid7uhZ
 R9rAYl7pl11H9FLsFLTiQ5rhVARYR2ngZ/ocyL2k7muzzqPe6Ha9Fh/pogQ0CggPF42S
 S/cxjn4nzLs+g4NphqzC3khb1t50AJRfuekjaRisjBlH+MhITqs6eaLJ2n9H1HfZnH76
 7i6LgYqK60JWlufFBAiK8OdzXOjJOFvl5S1JqYYohA/idChf5wvdc9Uv8MmqahEovlkx
 JVaQu8O9k9egy3EIL6AeeV9W6sK9OBOkiX7NxfZoCZuZd42aYYrjwGD+qWzw9lHtethh Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a361d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 16:39:01 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36HGKA2q019234; Mon, 17 Jul 2023 16:39:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw4djn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 16:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqveBqfjd6EuCU1DQbnUvoAfS43q9iBADAOwwgQRsBbPNP5L6E/ORQyQjdUZgD7A4mQ8sStgGXInc97K5f2kIsap+M8JZRAFeWktEPGFHkoFGQ9eZcy0unUfy05xfxcCoISUkmrN6+GTXJJIZ+IHPXOADF5EMuvjPOh3sE1AuivP8nUxyjhVA7bGWbYBvnn79L2T6rtlj8wTZ9+A1fX4m1vrd+dwoFyjg52K6OuDsRwzp6FX8CgDmR0YvEVccYiFy75Y4ObYNHETgqqa6awgH/GGzN3Q8+SJxd7GAIFQhWacNAKPLJVRzDRDRnd9aXiv6B44r2Owwjs8iVtYOidzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyaBGW8+Wjuk7Yh07D4PHS6NPNtR1a7/85EdYjrLCos=;
 b=OGtkvJuRWmt9pDdo/dpHCrrWEkdinoRc5Zd5ZqBem/OgG1EnPPzqYsIbnJA88lK/3k8MIPl9R+dtpOzAO/DhalJ/6tgU2TisaMvMgRBpW4rVbVBjiyuVLIXHFFv1DtlpvSJEKead2Uh7V58zNhozrMFROwOvi76oYGSiJPoFn+tNOE+T/LMHMFPAJd8hO/8E/neDxBJdfVwpvbeYsP4Fu5V+NnGqbxmbt5Kw8zNX7Sqlenvo/QeVhU4M6FJUj0EPC+gAo48j7zjJ9BXJ/wU5H6bkks6nzzS5DeiLgrwjuOnMmB1PJYMVw4S2exeLjxieDqcLbPGNGb8Rfh/m6w6WpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyaBGW8+Wjuk7Yh07D4PHS6NPNtR1a7/85EdYjrLCos=;
 b=pmi+nHEdeA50a1kE9e/P1Mydfe919AteGTNM0ctKWlaYKwJsakf0IM3PZLWDomsd3RFvYn0ML8ZaG5iMOD3vD/DcorTNloDaMG43ZmWqI1cRfnKPsAGqAZZToqbh/3HDi4p+y48SbQFbSjqw/n7SDybfxugXmb7fi8vuvl8r2JQ=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH7PR10MB7717.namprd10.prod.outlook.com (2603:10b6:510:308::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:38:58 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::c89f:f0e5:c5bd:aae5]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::c89f:f0e5:c5bd:aae5%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:38:58 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 joao.m.martins@oracle.com
Subject: [PATCH qemu 0/2] dump: Only use the makedumpfile flattened format
 when necessary
Date: Mon, 17 Jul 2023 09:38:53 -0700
Message-Id: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:180::24) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH7PR10MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ceebb8d-2c1d-422c-77de-08db86e4516e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scz7NLb9YWxjRYqUsB1VH6bkrMN9IPukCOli2QcrnWM6oyxRr7cKmjHTF803rz3QLu17XkP4+9RgeYYi5dG/kGMXjFmcUPU/I65XkxlCXx4MRmWaP1X81gtdQ3TZ3m59ArSnhrENezUWz08FFumKF8jv5gcNXXVNX1bh5EJoqiJRqN3sbYHFbCshPdjwpKoYLXx1Wlq+D92V3AnbzIM1iyrzv662qQioVnA/VRc3o9YRBvLVJcV43Pi+qSM0Q89YDNhnEuJ7QyCk8+VtdgjaBzYWGSfXLK0ljs1STL88edgZBZRM+ODCgFMNhfkE5f+XNwo9uVldIthDaij/Oeivgdmt3sIeF6ma3f4Mif1AzutVHthAlMCS0m9SKmc/lTF0Kqe3rD/fBXURMKK9bJcTVO6B1DsObUGyR40nBcUBrHNxLeKcS297QrZSL0lx+edMCsdwpVD4E5xRblzYQq1Qsmai86nPJyoFYBi0sKHa5VR0t4Lehbt7fxc7i2r4MbUakdTbtWXLb4mDcXDtZ9CImFFjUGnZRdIPMvgqVgGqUp8sBr4+bR27FhSaWQqXY5Hw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(478600001)(6486002)(6666004)(83380400001)(86362001)(103116003)(2906002)(186003)(36756003)(1076003)(6506007)(107886003)(6512007)(2616005)(316002)(66556008)(38100700002)(6916009)(66476007)(66946007)(41300700001)(4326008)(8676002)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCyjhLR3hlf08CWr3HJXJIvL2iMBflHHbZgwTTd9Z2JgcBBPaNFsixNXBV6z?=
 =?us-ascii?Q?cjX/k6PbL+oHLo3y+Fzc9xQkOIoNe5dVMV5gNt5yC7r1tGVcAxBQU88VGY+I?=
 =?us-ascii?Q?X2PdIO6exrdhb6lYW467UCN9nqHC3sOHhh/COvhMrkoOM8+3aSZiAWb87gbH?=
 =?us-ascii?Q?xYYdVZ7ivkHiFuGafnXafuarg2zg+etfu/j/lChbFtcy7a9LL5PD5+DD0Hz8?=
 =?us-ascii?Q?v7q5FbiT5J2cngKaoackP6tifGKPxMUDeCNSDWmazVVzbTUtmgaEGsd4Lhjh?=
 =?us-ascii?Q?YfT7qBSRqw5rEKjSyUunWDVux75o/jFmk7GMJm75zokOwHoFKstN/XBUtjxY?=
 =?us-ascii?Q?gyxlRjFeMWWrfWbf68ZtUI437MgZEx4joLSXcLBt4FviciQrjvCSPGeZ/P4j?=
 =?us-ascii?Q?egHQAlpQtN1oUBog2ljdpN61xtdgq7Bxon8G8WsHnoulR9ezDXF9EdflBQ4H?=
 =?us-ascii?Q?n1AOj6Kk/migGlkKvv2+x7GFIt7+IO8vSZOx3unulig2Xw4d3ByAlSgj89Ea?=
 =?us-ascii?Q?Y82CkBleOFUTXJDFIzgnRsb0vzvKUMI9jJGdG7dV2Yyu8glLvBYwa2jgVSK/?=
 =?us-ascii?Q?1gSJjXpvCL2N2PyD1wL7Zy2/oQkyf0JVSDd57/niHkaoRYMk8Id5E9Vp7+Bo?=
 =?us-ascii?Q?K5mJyFcBvdhO4TxaYPznyANMeU1dSq5AJ1R1JXs/TK+UwEl0r62CW7GZ2ZX8?=
 =?us-ascii?Q?7JO5rguzHrpvmn/1f0U8vULzwjfOUELDSf+EJ06Ex3TJd3OOApe/QQmBkgH0?=
 =?us-ascii?Q?wlNRlTXkQEGTOxn2tI1AHpTsrRBPrS6UGUig/krLEu7c2xlzbvQHy5NvGD9M?=
 =?us-ascii?Q?4sCxxSoAEptQ1CmctfcNF912/uJbtdxRRGTe2OQAb1/+OuHk+pvNW8UyBsNW?=
 =?us-ascii?Q?fk3793n9927B+VI2CMl+NlZzDjgCzgB1QgHbHJAnhvEHrraj4zuwiIbRtR7D?=
 =?us-ascii?Q?jQZ/rov/2ZXDsakR/50RgfF6C9AC3sLr05Ac1ycTYUZ8t1UpUq4eu5VDp0BK?=
 =?us-ascii?Q?bUuqx50qbT4UiqUKIYPCvuT/i/ygPZwp+VPfvUYENvY+T0IETF/Zpg4IF0Uh?=
 =?us-ascii?Q?SP6fYotQ9DAFXMk82Fi/zVejqiaA4W3oLePjSK7yAUBQ7OPxLQPPQSErc/TT?=
 =?us-ascii?Q?xgBhTe2C6FhR9Y8LsYFE6LP2KxZksWBwt5atFkVuRTNCMeZ0kAzWTt6jRtLJ?=
 =?us-ascii?Q?gM4qTNm25UWcyYIr4aBma/lh7frcvo1zF7OKUtKL65sdn1EiLTQWvU4ARD4z?=
 =?us-ascii?Q?QfW7ubhsLnZqMjjlfYFUb5ERlIOniXB95iLsq+cQz1u3x/L5MvlJAB0j+4Pi?=
 =?us-ascii?Q?rPpi7YrGvSSO2KtLSkX+9qyOdqpnDXz1O9Brwu3YO6wAMubhiNK8eR/KOPVM?=
 =?us-ascii?Q?sLOBH24H014sTDEUg0AkSYGwJAwjBGkqge3FCGO1EG2WSWb8YlS/j3/ypUVg?=
 =?us-ascii?Q?XDRFOBGnJaOSTI8vigFq+zrPJELibBG/3Zk6tcuM1tWkeHPO36Q0NLFpjghO?=
 =?us-ascii?Q?sgFmUbWBGtdlll1lC9u6FD9CViltTYrAe+XxY/P9lrJn2GEHOVpN3pdivuDN?=
 =?us-ascii?Q?g0f12Z7qtRLzeVg9Jvt8GgqdT4PNtsLvpTW4Qg+YsxYf5Czd4T+m/lp5qy7b?=
 =?us-ascii?Q?pvoUceFuoK0Mdgb+R5BfN8s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I2idekMqaZXjIa5D6VgTAZ3XdcGqrc3HMrbYqj3AH9Ixv2xZoSWdwOxhVekp6Aa3uc3VVDAeAlLfaniZO/0F4Yhb63uZ5HDJm27mvBp+oV7IMHCaYo4RuA5jRLzu7v1SE6yXTNGA2XHsItuh2eRNaxIJ8KUyKJ1t6Fl6/MjnhOmvUcOQe4PiCK0un7vSEaVScebraHupRUUZVvrLL2/gFJNk6afacvNUT1YVXK4i5dFbWWElByGbYK5jnW94BZsjQvXP1jpZOKbqgCW9ka02efqqJzub+JSzRoPEiu2yQ/FraGJPupRhGWG0EaDHms0OaL94+JrhGYsk4ocJNor5xWbmcVb87FLRSskhKzVopIeQuYduCUeDHB6RDg9YImGWrzcvacfJ2EZKhAElLiyyoW9DLJzQLe7O7QVzuVUYvQfJhXk4l90Dqd98SBdkck+lx2D0SDaaNMl6FJS7sfmGC6ML0kyKIFgdeQQR+pLX/JGtV1gevy+5S9CzaQSqFqMB0j1PusmXWjL5jBFap2KyjcZHoJJtIVPYWHoWYP7vzdz4bdDumk2OKJbnOAJEWve2uOWrPM1VHd7l1AZkW8cDk9kfwzAzbzcZOVV1YNR+8WJEXMkmSQlSUVZwFvEVnz1CmeKm53IadHVEFZadufb/D2TBZVKOuGOEO2hIaDwHPzPuNfc5+Guto5f6QPwqZL+UcoTmj4Arku/bhR3SqyXIWhmtkOH1UTEFxAh61igSF6oTn3n6snJNmp5x2pxt/u4odZa7SIRWV5/1yLzr5KRv6uQtfYtad7HpIDD3MQGGd7Zf/w3PkEeSJ0gkTe6sNzcb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceebb8d-2c1d-422c-77de-08db86e4516e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:38:58.2304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTou63SxXbZ580GOjSIJ8Zh+KQGom9s6sfdl9inhyQV4CP2gxTQzrCSyZjqlzCWOOUJRCF4qUnacCOgugdbW5lQ5x5wpxXjWFBTq87bF40o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170153
X-Proofpoint-GUID: yjvEn6J3NAX2UzjA5xjnR6YLPCQUFbXK
X-Proofpoint-ORIG-GUID: yjvEn6J3NAX2UzjA5xjnR6YLPCQUFbXK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jul 2023 12:43:40 -0400
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

Hello,

The dump-guest-memory monitor command supports kdump-zlib, as well as a
few other compression options for the kdump format. However, the format
it actually outputs is a variation on that format known as the
"flattened format".  The flattened format is essentially a sequence of
records that give instructions on how to create the final output file.
Each record can be viewed as an instruction: seek to the given offset,
and then write a certain number of bytes to the output file.

The "flattened format" exists to serve makedumpfile in very specific
cases, when there's no filesystem to write a dump to. Then, makedumpfile
may output to stdout or a socket. Since these files aren't seekable, and
buffering the full output would exceed the memory available to it,
makedumpfile is forced to use this flattened format instead.

The flattened format is intended to be reassembled after the fact, using
"makedumpfile -R" or "makedumpfile-R.pl", but this is a lengthy process
because it requires copying the entire file. Crash can read the
flattened format, but this requires a lengthy phase in which it
reassembles / indexes the file. Essentially, I can think of no reason
why a user would want to have the flattened format, when the regular
kdump format is available to them.

So therefore, this patch series changes the behavior of the kdump
creation to match the behavior of makedumpfile: when the output file is
seekable, it will write the normal kdump format. When the output file is
not, it will continue to write the flattened format.

While there could be an argument that the flattened format is more
efficient (in time and/or memory) to create, because it doesn't require
seeking, I'm don't believe this to be the case. Makedumpfile itself is
intended to run in very constrained kexec environments, and it always
writes the regular kdump format, unless its output file is not seekable.
However, I would be open to doing some testing if necessary to verify
the performance is similar.

I do understand that this could raise compatibility concerns. From my
perspective, the "regular kdump format" is strictly more compatible to
other tools than the flattened format. And as I said, I can't think of a
use case where a person would *want* the flattened format. But if it's a
problem, then we could implement a new option to enable the new
behavior.

I've gone ahead and tested the changes and confirmed that the resulting
dumps are still readable via crash with an x86_64 guest.

Thanks for your consideration and review,
Stephen

Stephen Brennan (2):
  dump: Pass DumpState to write_ functions
  dump: Only use the makedumpfile flattened format when necessary

 dump/dump.c           | 68 ++++++++++++++++++++++++++++---------------
 include/sysemu/dump.h |  3 +-
 2 files changed, 46 insertions(+), 25 deletions(-)

-- 
2.39.2


