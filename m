Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0500703EAD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyetc-00006w-MP; Mon, 15 May 2023 16:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pyetS-0008WA-Je; Mon, 15 May 2023 16:34:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pyetQ-0005Np-58; Mon, 15 May 2023 16:34:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FJsCv7004297; Mon, 15 May 2023 20:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zWIn4tR9iO4nCu2JCoZ0Ped/Kfeo8y6jMgumrsCpSSo=;
 b=KBn3mr2U3OPlTpWLM2XtabRT2EmDa7yZcYj6aEMGER8Dy6vzG/u8PYZUs1qUy1oRjPyp
 RWKRXwyUrg1a0WIXJJYytxl8PGCQKgZViUN2zt63eKc1O6zMVBq0wEExjfucD8utuPkP
 FdRouZ9s1J+UcivPxgV8kUUQ/NI84iGr8JpOdg0TTCAOkpi/YMa1tfs16WGuJ+hSmuL3
 XtKYciSAh0r3CPqespmrE+hn+KcuOezEsHaC8GPhJAqCTNpCI/iUnhma0BRbjxXHzgMZ
 +Ag+dP2DqTwFg53iHgkBxHl8AeYoVZmEnyzpEDpnmiM5yB1TlA7pfVEVFbALinCXn6Be sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3sbf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 20:34:01 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34FJgwW7022140; Mon, 15 May 2023 20:33:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj109eb8v-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 20:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES7/zrkEFM01jFdYM3KHxfAnx2QzIRU7Fkz6P6sKo16FpBKOV8zu7HmHlSc/zDzVn7GbQhROPEUDmvHCE0bhOqxVs9dljZgWAbIabVhkapEWIzPTS+5NDZzh54ToQ0Dw+Ez9/w5lHpWlhRKRwOl+Aup5XDSzNUtzFHRn+xcFTGtepOXma12xoEyixGZaNYqNJ1MGjeHfq0/imkuVT6JDLKUVhemSdLlCulD+olE6nHmi9vQTmhSHKsWsbwxyNZM1R3HHrVU+MNwQV5uXEoYkAS6Kf6VCYD7Qkk6FqH+eIf1NtSVl05NrDhqZKX9fZIpEk5lGEWRmOg+oxouwt1Duew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWIn4tR9iO4nCu2JCoZ0Ped/Kfeo8y6jMgumrsCpSSo=;
 b=Bsat+gyylW2nedHUUiNk/Td5HwvQP303UaVjj90DrFtpbCDOnN2I0YzFidhc3ATTda7jDe4AtPB2cU/87TwKXenEnGZvZtQRuCrtEkQeKFGny5X+JY14k6OT0+BZWNfpZas/osVfw79DLVfIXSLKVmAVKFg9h4P0VKVQD11GOn0RBvXSHI1LPEfB6ZRglDF3x235ldQ3yQysllVM+MB8AgcK60hYiK/H492XOi4a64XdpXTK4IszdAZQVJMHowMknV1irDwm25Nk8L7VXkpZtaSo0xRX56L7t+//0RkfPLpRGdAnLZC3vehtxq5bS5BR/oAnCZJDcdA26QwuYe+3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWIn4tR9iO4nCu2JCoZ0Ped/Kfeo8y6jMgumrsCpSSo=;
 b=Nw4YCaRm4DB7TcmHJtsWdacMaHEyGrVRZEn1SBS3FVoyMAdkfmH6zUf/1nm7g57+6M2lRjYdQtIvzL47px+KNMP3qEn8eBG7s72nXF9jOgNsiPULot0SKmx6YTd8Am44vXdzCygpwUrRKRwAyxHJH+7EVTFA3LC8tgejLgQpjPs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:33:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:33:25 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, ani@anisinha.ca, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Cc: boris.ostrovsky@oracle.com, miguel.luis@oracle.com,
 eric.devolder@oracle.com
Subject: [PATCH 2/3] ACPI: i386: bump to MADT to revision 3
Date: Mon, 15 May 2023 16:33:10 -0400
Message-Id: <20230515203311.2139-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230515203311.2139-1-eric.devolder@oracle.com>
References: <20230515203311.2139-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bc2fe6-7ed7-4e6a-9996-08db5583a267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4miKXlGnijrTO3BG6SP2WZOeC2zyhYVwIt/wd2/peYZLt9WhL65RMoMFz/s9vXGwG2InARXNT1cEcdDkvQ/O9gmGeuEKF/duYZD9BtzlXuMyIdc0HA+6hVjK5Po11OYwH69vDIKSGXwXW3BkwGDv4X4fu95iif6eG+SNP3hQNXg06I0qnaygBHKVkFM+1xuekE3hHnmNWmnX47nEciJY7f44TWPx9qbE3V0TBrlmHOzuWGnDyggd7It1vlmSsMIa2r5PzLeRQaFXCO2BLbulx3fDa9YypW2KOWDzeqJuDpvYxGCJTAHkCYENROremtXUnopX+UpE6VI8XiDIOu9w4+OhMOXl6Ln50QdQcb78LSYHFqepSc8CfBGUAbSHdQWKndSK3zuoddAhCrOLV1egal0xw/yFMOsQFdrvvMWKHTBH49gA+gV1MHEkAqNXVgixk2KrLLwdqWzkypyix9TxnvbTO6+Ru/MEUXFSbQdydYUR9bg2vMeAEIfnU+L810+yUTcmH5JfuXaIO7a4t7KXNyLhYOpsF9KYnXFee+u4Ra+WUyKrkd9NUTJlDMi2KmphOKlqSyG2lpdtXI9yydzVMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(86362001)(478600001)(36756003)(966005)(107886003)(186003)(6512007)(1076003)(26005)(6486002)(6506007)(6666004)(316002)(921005)(38100700002)(84970400001)(41300700001)(66476007)(66946007)(66556008)(4326008)(7416002)(5660300002)(8936002)(8676002)(83380400001)(2906002)(4744005)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+9jGchly8VDxZJ03XlowoqEW0Eo7EMP1Mw3aCcTUVqv/3LFd4B0Vp2M5tZX?=
 =?us-ascii?Q?lTcAAI2Zm8Orgrv19cGo55JH3DtLNdk+7XM4HlN1GWJkWosvAkn5F4oPorX4?=
 =?us-ascii?Q?14gFn4Vf/l+9uD1g42oeZIFoF1PVxViKRyoIMh/PHdw+X/dQFT28B9UOEPLd?=
 =?us-ascii?Q?S3ERN5PMI0buBrDTDz1osd5Dz6CiJCSdf13t/OHt/Cr/8rc1eVLYICS71+rl?=
 =?us-ascii?Q?y+v2I2jgKXIvuQqtVQWpNzP1pATvCjKGt6Wg+61C8h4YFNymznBkDUZEQPxy?=
 =?us-ascii?Q?40DiytxjQb0+67V9XBSOZ476DmGW80K9qp65QncKCByJFYqyvJk58ggqqk8p?=
 =?us-ascii?Q?+U01W3ebG8jDYZ1ROE2fsuP/KHjQOLKRoyAK9LJyMrwuUOUgX41f7WX+sEI8?=
 =?us-ascii?Q?gVeCtBfp4tlaRS/SvE7P475q8H24NBNegPO/++5H/LiOSPHWFIwcHd6HoEnD?=
 =?us-ascii?Q?7s2fEFcUSpTGIFepo1v0cpRmAqVWkIE/1H/476QthsqTvSmFN7tJVwKz0w5K?=
 =?us-ascii?Q?KSUufzRXqFf66GtYNO1nPcxA/mXOeLFbptbTUrhE0SHItbbMw19jogV3FO+v?=
 =?us-ascii?Q?2BNbhiYJ+rETc8xsdm2JRCcuZDKI/sXmJOeXUYyc2Dnuqb268T8gFUwJJ0X4?=
 =?us-ascii?Q?nN7oWea0bjron0xLsgSeaNEeqo+/nm3p7YYQ8y3oCzXHMHqyBWoxGnpMyrx9?=
 =?us-ascii?Q?EQ6t2/wu3HVYwyVSp4CNTSICbau4RzNGQYJKbIRCfdS/RZdtZOUNvps2GeVs?=
 =?us-ascii?Q?KtFylEkSkwhOOzqQd8HXrUEYGeP1dOVByW0yF79cOwuNQCbffplz0YsvBmMD?=
 =?us-ascii?Q?x4JIle219pNLxTNBYhb7dqaIPyHRJ4wrTk3lcWAsN0iij/O8Wob/oPTWmSyM?=
 =?us-ascii?Q?SN6hebgAFhJ/f6hZY3pkFjPCwsHXp7jb4+adLi+kHDeLoHPDI3VuWkY+hc0s?=
 =?us-ascii?Q?gft8AkxxKXRu/S8V4Goilw4QSFI34uAMzMMPkJ439mKkxaVRdFo2NhexHvRj?=
 =?us-ascii?Q?py0Bnv+n91Q0YwQeu403Lads7KspEfcBD9m6+4ZFSnJFlTQ4g5TbzGe2GJ4L?=
 =?us-ascii?Q?Dt7LKC85lteQq41T5hVGdJOK19JX8TWFREvakd2mcgN5Ms8xFb2tDmuaO9qr?=
 =?us-ascii?Q?vMY0ny4tsxuFQ1GBnO4/YZ5gdmsSrkkbP6Ui4Xjz/Mqxe8mHRbNojSNm1M+7?=
 =?us-ascii?Q?ebGeU4DChYn4RJskFoDemI0lEIodkIvMtgIHe/Ux5eGKd7ZclEq6HpK+3CQC?=
 =?us-ascii?Q?9mgknfrItW7XdYdc0c/dLoHga4q1FJu+GAOFi3p/VNQMHHlH8NEsWpKARHK4?=
 =?us-ascii?Q?sZ2wR3w+V+9vo3s3D/R9jEHjOtaiGzNJF7Lhs438gvjTWsCoefNMOXlWYEip?=
 =?us-ascii?Q?NKM/cjrnYC7C7GVAQ9wfJb0AVFMMT8rgijUE826tdsgpsL7EpgzPjBhVqbZQ?=
 =?us-ascii?Q?FpuJ1Ntn4LxI6Nz7CyIfqZV5Jp6hcuxWBeMXBtwVcMZbrh+p4CKc4Kck7N0f?=
 =?us-ascii?Q?FEIbrJbAxc19zmKdc6mLYCHBL1WLFp8RmlH/BHqU/88m/o2CWQk9mpFtoJg1?=
 =?us-ascii?Q?FeZfQl5g6JQ+oW6p3X7FRDdzsmMIw0Rnkm2QVmfQ3+MWCt0qjgaarKuQ04Tt?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mj68Nuq0o3QVeKyPGESsFKSiiauEGprEa0G741WnVJBKLGm76t9da/O0H1SUs1arnJfIX4xesSPddlWb8/2xlPimhFB+99ULq1MMJL+AlWjHDU3vdEaDBOIe4m+nKxbOnf+AuCD60uSDgrEG2dL5FM4n2tYDAQTu/iE4F/K4CYx0HE8lAjfbtm5XZ/SnMet9oU737TokNfva458QA14kmhh9bh5NP1/q7CN/NOc3Ma0A5VpSY1tdDT932K+yf9usQrl36qBtuE1nnPylDhDoRX4SX8Yot3D/3DEmGaZ/dCax628t3oKYpYrJ5ky1nTtTZsPjA81oKPeRYpwymQopijNwt6BWaJl6uAb2lp5VCl6w8kh/uv/q00GckYaATj3PXEuBJkklbefrghY9jKWxdCZZVq7vGakK5k98oaqdcuQLAYO+yTdWRHjg7sdeNfLs3OC29zWAGSW5KnAe4haBheQ+XnItfUSLzDRhX6EkTmlOv6/sdwLg4M7SYUm9fo99c7jakjMVxMXC6RAnCFUnBij5R2XqSh3a5XI8TojSRJG6zyNuiWBb+rBGWU8AgUDc++ssImANIVN2RJsmcSu4pPnHJr09uA43ikO9ABIywEmfqA8W9Y60NM1cis93/IwyPLf1p+6LyUQfSmLSDs3RuyP2z7jlG9KCvKo0ec1fRR85P0PY6OJGxGNxyY8D+BMFG8p7t0RjqddBQNjfOb8teUXVdTxRV2z4Zw4USvfU03F9VPBKd86hwV2fTeD8KQClliamyUpC3hmWQ8+3Uv561Qk4uq36a82XpnQ+uP3/ZYLRBoIsI9H3aTPEIdAKf7rp24Vwmv/3Yyp950k9aor/7plcIz4vhDNK6x2OcNuf0ryud+kaa0yqzqTTOFnghH6QOFjAVwFObuesCuEFwurEuA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bc2fe6-7ed7-4e6a-9996-08db5583a267
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:33:25.7842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekgAnhG2YYF4TNfUI4j/sKRAZHpyWOfHMIEQW/O4ZUUmEFwxYugq3/q1JZh8Mt5BoPJ3LSYHF0ps5wG96NSZGjPPzT624LwE2aIez1XS5UE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150170
X-Proofpoint-GUID: Wi4PigjkYI6eYQuZ_8PrTsYvFULBBOYr
X-Proofpoint-ORIG-GUID: Wi4PigjkYI6eYQuZ_8PrTsYvFULBBOYr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently i386 QEMU generates MADT revision 3, and reports
MADT revision 1. Set .revision to 3 to match reality.

Link: https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@ora
cle.com/T/#t
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 hw/i386/acpi-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 52e5c1439a..8a0932fe84 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -102,7 +102,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
-    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = oem_id,
+    AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
-- 
2.31.1


