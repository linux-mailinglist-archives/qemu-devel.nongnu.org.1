Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1552793E5B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtCk-00021e-Ui; Wed, 06 Sep 2023 10:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qdtCf-0001zU-TY
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:08:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qdtCc-0000X5-Jf
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:08:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 386DomlA013909
 for <qemu-devel@nongnu.org>; Wed, 6 Sep 2023 14:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=KyJD6sjVURMktKdYpGnzXpCbO9Bd6RuvmBHox6YlTzg=;
 b=n1/3rWUh5hpYgHsCTS+1u/8AVUF+gDUdzXmVdPlwaaq5zZON70DrwlUKoz29BSrgtuAY
 4CTBNyniPjwzp0ddBMRNxB1ENYqdkT94/pCMzDlnzw7QqhCqRzByp/xHUGByPzDzaCYX
 EFNeZdg7pRgLoqihftM3wXlEnbmsMA1/pq3JAylPy5Es/TSamB8xTnz/9uxM+kD+xkTg
 ojQDWzKs2tdmIi82McqQqEd/Qq0HFgMimhYrNVhbPCjg9sAIyNM0NywsNVB9+gtk6lhd
 e8SMJYOwBCenBsqaPEwei/cPN8xn/V5SvDmEVBGUCha5DKihN5X4lYqIww4YYXK/t5nf ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxtnj83np-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 14:08:14 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 386CZwqm010377
 for <qemu-devel@nongnu.org>; Wed, 6 Sep 2023 14:00:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3suugch3tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 14:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTNu4Bj3dyyUv+U6T81u9dsW8IXwzhYcGAgs9qsPfxZixuzSaKJcgmqyPEQTkpMu5thRiEykJ+L4Exmn51cyLP0qxHpreVnLt3S0ZNnQ8o28WiQUXuKc7suFit17v+jvQVlCDBPCd4da7L28fyHamR9JGR0caqQ4amyKQHFZ19n+TXb9nO6egHW2J2/F4RvmCiCjW5brWy9RPOOrbKnlV/lfbR1S7pSF+GxvH7ILpIrc2jwHn+wHiUnE6mkZ6zZQ7EcmAnjpb1kiLs/hW/93NvSiVoZ5JLH+YWjmrjl3D2TEY6YcY3ZqPzNKRHD8mpWEzc8/+R7k04A4gBtq5CNwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyJD6sjVURMktKdYpGnzXpCbO9Bd6RuvmBHox6YlTzg=;
 b=UrXnWXoT9MnKvqFnbLUhl7HQ4Z9+BHcc+Sw8GEWAl4Q6KoWu6e+dcho+NLh2DJvcTlhh5i3m9HlE+hsaTB9OiXDG2bBx1cDa1DptPpmAAQ9NdKWBa7IcXjDY8J3pMenwDiFFDuSDA9bBCzA5rfpTacbT3T+QX81nOVmHBR0giOHjZHN9zu8dxZL+YvsreaGc+fRHXbyvwpAiuuLFul0bBTtCkWGOpFTzfs18QnQGOEyzm/VgucZ10TYKXB7mjdbC6py7YkiD1wbP2LXoa2pvrjAuUnlxkErJl2IbGRmBG3sncoIYSwd/eXtpAaDbqYImBe3MYhArHw93PiHmfNBnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyJD6sjVURMktKdYpGnzXpCbO9Bd6RuvmBHox6YlTzg=;
 b=h5Soql6xUJzoKRsZNU1cpO81s1s3sFfJIAF87QY9fTdMDAlRaJZTrLd+UFEMS+AcJsOFD1FgdLqc8JI9iZptcEdsQiUCyFCWH4Jt6uYC+1r/jhBqVCqE1SGdOf0b3TTIhv8OhzZPfp+XeKdAKJfyi+kt1JZDLm2u1Fu0B/f8xA0=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:00:12 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:00:12 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org
Cc: william.roche@oracle.com, joao.m.martins@oracle.com
Subject: [PATCH 0/1] Qemu crashes on VM migration after an handled memory error
Date: Wed,  6 Sep 2023 13:59:50 +0000
Message-Id: <20230906135951.795581-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9a84d4-54c2-4e9b-52ea-08dbaee196ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09iF3J3GFduweCV2z7Fwz+3Fuo4euV08x4m1G9i1DnqR5jL+J95hB3b8c++SC9UtZvpsQjtE2V2KXxExXiRA4HOoTg+PB+jHCSDcekcYBuELWkJA2Xz9LyWjXlEuBPk1e5gx1hTRSR2hpe11l9Hi2/vxSkYjJoKApNjYSKfsIHfwCZD1tepEqEd+Hre35xQa9sp1S1pSJRamxOOV09kXapahhah3FOhIFFBPODxGTb7MOfR1CFhOMHWMWqaxjVms5S3YgySzwtPBMy8prfsb+tljrSGtmRwshmxF/Eyt3jMYVoFtJ/jWgT4/8o0Lqa74tiXLE2MaPHiOi71+5ZJa7JMduGYk9YBK8YOiUaqtO6dNCTupTBaWeSjwK4uEvBAEFF67vJHH1ppJccaUIAQ+2+DBE7Q1P85GFmBYIwtDoUAnKqz4PqXChWGWl5gDnF2HRzkuuNuNqNro5LCCVuG1Yjxecuwl+HLy4hkyUg8ULc6LktLMzRcPUx2OMJBRl0P2x8TFq65HOsV2Yq1INgONi5tdkjAKTP7QoHoVly7NEFnexNMpNtk2UJdozjH5yHnf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199024)(186009)(1800799009)(8676002)(5660300002)(316002)(6916009)(66556008)(36756003)(2906002)(66946007)(66476007)(8936002)(4326008)(41300700001)(66899024)(6506007)(6486002)(107886003)(6512007)(1076003)(6666004)(26005)(2616005)(478600001)(38100700002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkg+234MElLHPD0nhRquu5IcodpbnO8P3n72rYNGx6ocX8u1CGeAQi4lJAOn?=
 =?us-ascii?Q?6hR0xXBqI9VfDrpJ6PkiU4jWByIX491jeq9qKfymoqBvj20AuYfPIUn3M2hq?=
 =?us-ascii?Q?v97O6lvMkLar4ZQFiSKnNfdnlUlMLgjheVBYY6OszZQf/BDoDVIL/o66dVtl?=
 =?us-ascii?Q?8YIg/MJBir2iuGfjOcEkEcWfKfsd5LhD1kEsMM2sBrEJ4an+HUgCQ80m+L81?=
 =?us-ascii?Q?RzxSaPWzjazp/dPIHPNVDOhtY+I1PA0qLQ9Mv/AlgvZReZXaCI6HbxowmNLX?=
 =?us-ascii?Q?Lk4Y1YM4llPkU01WPF6R1EWn1pbrGTlCY2UerD/fYRcEM6RFuR1+mTpmxxlF?=
 =?us-ascii?Q?X0SOgEtGJ3HJ+Kba7O9qdjTu7pFBTvfYHkn0pioKgSBT8V/4ng3lNCgpZL7H?=
 =?us-ascii?Q?K5MipVJthSp8a2JzlqPrFGiPFnI14j7R1wfkHGx7NLLFsJUlKQE95T3hl3Gx?=
 =?us-ascii?Q?0hqpEPC6alJfYPmSIXBY63sEzPaZY9DzH6l04AykGOi3j4uHBjZEE04cW3Ww?=
 =?us-ascii?Q?q2cIjPXN+TcVLXZC5Z8cy13/G4fEccBJnqrx0VxNi0TWBZyJZiXSqw1xHVgZ?=
 =?us-ascii?Q?pp4oq8smAb7dv2mQnkkqb4F9UYfANd3wOs9et/imgvQEM/ARIF84dKcBpQ+i?=
 =?us-ascii?Q?p7LRc4ozGAEcFBt3X2TkIukWTXh23qp9cmSoSDoI2qfgbg4O6dTlrj0JkaQY?=
 =?us-ascii?Q?qlsuU1RwHMqjruJuxwFkS/DjSfqc6IFlMIK/RhEeBXm4NCDl0ItlHkLH8/1f?=
 =?us-ascii?Q?okw5DNeTufIoNP7ta6HHfVhc7w+mBu4it19K3pQyJ+aUaPHQ077PLxYHBSwR?=
 =?us-ascii?Q?pot9CA5/XImhafVkWcQobBv77Aq0DFDgjsR0caeiUNspo85Rxd5rvLqLfc2z?=
 =?us-ascii?Q?Zw/qDHPrytW/LT0+Iz0ONvpd9/PG6EBRvNC+tWLoN86AAOLli0yI44NggJ0v?=
 =?us-ascii?Q?5l+aFTHXqjI/d58y+oCjN1JQPgvV9oXHuTCeJs0U/cpjv++3R+/j/gs0/Ij7?=
 =?us-ascii?Q?aljIBJynQNxHDyIxCa6HaJxUL485EEPtSNoKyTEYKDU96McS4c1YygqDqxQv?=
 =?us-ascii?Q?qVjfJjnLB8Vf1G2smXL1NfDsAmTJbFPUMXmmEV4UxHSf1e4ZiJt6G9UPyRnH?=
 =?us-ascii?Q?fXQXlkvrrjcc+WpGggHidQMQDQo9P1rTqoFZI9sPdOeFgnDdHWBQefqPQg/C?=
 =?us-ascii?Q?3l1zRlxZzeEuy/6uJF3N/pd2gFEtW6T3n3mLyEc2LQBQ5dUWTnuRtf/J2iL+?=
 =?us-ascii?Q?h4LIIdGfDwk9BxlJRqUyxMY+13s0TJCfNgJX7YRhiNbfyJ93AwtxH/V80Sn3?=
 =?us-ascii?Q?eKVuHmtkAq+li7GEvIxULZAEDv/I0Fj//8x78Hy9AheDl4PwIF8QRzLRiF0m?=
 =?us-ascii?Q?UeJVaaoE04PCgq5+aadR4avZY0aThucSQEjtKyTPHT9w7BE3Q7eTF3IZw7ju?=
 =?us-ascii?Q?rJTKIHiSDpwnAJgEkaPnudhUBBxhXwbB4pyZW2QuMixgZ2+tg0pkZJymNqMX?=
 =?us-ascii?Q?1JlzUmKIcWQXz5DrG7xydDbeK7uTVWdWRjgns/Fdu7jAUWeXDTWD88LPt5qA?=
 =?us-ascii?Q?PWHLced9Owog+4BfjzP53oAG9IYzwbmn6hLmI0DTnCocheEl3XPrFZ0WO8GV?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rwn76UtFJdOzugXCUbsMJVF9C0ZIISlA8TAHEG5rEKoc9QfVvWrZwWW9wvkw8fM6kMgPhp0cmna7BnQy2F7qVsheaOVskLDL+nhS+3A67VxyV+PynN0/LorJRbvimV2eXCs0oDoXwmHzuAsv+WGu73SusQSVuqNA+K9Os87RNCsFVvfggLbPxiKCwP5K17M0Ok7hdUZzL1i2Xee8/l8bZDEo46iofl6JdDBUlgujHB2ZheJJeYdXHycvpxe6RG+Kl9oaVUqwzlZRL2rBh/LKfwPqn72fdmAskavH5u+J3SZUzEvSeoidDRmRtV6tZoRklrTsUS1/gd2+7/dLgq9UQDNvYBt+kQCFFINEjQCi2Ywad8KD7XYJPL3r8qvtZPesJjZ/ph6ittF5nT+tdrCCPCUz9T1MMat+9wmL7CXlqKduvdm3M3kxNoHz9/ZlHIKx8h21S25OTIBazxgTo3u6ZXSmxHl19T7kOhWCRU56pBaBm8gYgrGcFRlM39eb/THNPAoE3lOnW6m23DECBIglUve/dKyZJHwnXFpPgbkjP+3nrqmTNdCxv+LBAYe8Wnmw5a7zXAxnQprHN4XW2NVTbhF8rwqzRA1o/ehSyuEeIySkff2yF6pjeubFpvA3BrGD0pRuk2/jwglwRFEH+qKK5u4+/t0F8XC80VhKEC44d9WybkukNjoDjwfw99o0LDlGJSa4vtZPJeCOTk7nAAoT7ZBxa6uQNxsGnxhWhWVKueIow3SIILw/msWuRZLCyae8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9a84d4-54c2-4e9b-52ea-08dbaee196ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:00:12.4004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1hmx62thzEg61ntvl9zlFnTdznRH+YOp/YKBALkZjGMquGdK/OxpV2nolGLKYzIHb6Ek4HaWP7mNir8EeiJsYR1VJchDPPX2yKuoOvQUBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060121
X-Proofpoint-ORIG-GUID: Yn283jqfjDNRH9akiXxg5H6n60lHjHxQ
X-Proofpoint-GUID: Yn283jqfjDNRH9akiXxg5H6n60lHjHxQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
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

From: William Roche <william.roche@oracle.com>

A Qemu VM can survive a memory error, as qemu can relay the error to the
VM kernel which could also deal with it -- poisoning/off-lining the impacted
page.
This situation creates a hole in the VM memory address space that the VM kernel
knows about (an unreadable page or set of pages).

But the migration of this VM (live migration through the network or
pseudo-migration with the creation of a state file) will crash Qemu when
it sequentially reads the memory address space and stumbles on the
existing hole.

In order to correct this problem, I suggest to treat the poisoned pages as if
they were zero-pages for the migration copy.
This fix also works with underlying large pages, taking into account the
RAMBlock segment "page-size".
This fix is scripts/checkpatch.pl clean.


William Roche (1):
  migration: skip poisoned memory pages on "ram saving" phase

 accel/kvm/kvm-all.c    | 14 ++++++++++++++
 accel/stubs/kvm-stub.c |  5 +++++
 include/sysemu/kvm.h   | 10 ++++++++++
 migration/ram.c        |  3 ++-
 4 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.39.3


