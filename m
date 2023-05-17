Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA98706E1D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:27:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJyW-0006WB-VZ; Wed, 17 May 2023 12:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pzJyU-0006Vu-3I
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pzJyR-0004t9-N9
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE4I5L022235; Wed, 17 May 2023 16:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=SVIJvmTBHtpA8do9Ho996b906D8ikK1Q0n+l7+dQsxM=;
 b=ob0ziH36+GDXE62exBUxVw2dbzWRCTQLe0kXF6h7dCPMLKblyPtR7Y5YZuzFqJ+hwA4c
 a93YdxSFf/vq5Vkm/9UsnkZNDNyhg83XyYRPCGj9vNTI2wkxGLCukd0bEBrfRjokXDQm
 nwj70bCuTbpIx7jV2hniLicKUKI7CxqYuqK/4QDpJCx8g4lSxrvUqOgwTdxle3H/Wl4M
 HcVmX0Gi9em8FZ9jZnawe+f9bMZVTSRcut9jUj1408Q4Ej+/So9CFxnmKHhAtFUAceSW
 1WGqdB/tUv6e1DDzhf3uMKDpFhY3Zku+cRE6xix7H02GNoUOCYI6ZRfXJx/KZbA/BgfC mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpgkdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:25:55 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HFGYbw004157; Wed, 17 May 2023 16:25:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10bx9be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:25:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0h3Z5AdZEMyGiRChRt9aSGXxvxM0tcrV843RAznONg6X82idxlWw3bPxhdY08CdfpE1zIrst6pclkdd5Il4+C6JD/AuJBDubtYsHlCYAVpy7+DWyCnLUPgfPEVUuDDL9KsJd4qxrrr0nhmW9ZqTQ7SNSxHNy85IAof46PxeniptOYLJJSZuPwNrrbySm/CZPQsbV3R7kchX1Y8VeG0LcNpgrUd0nQ3Qexf0TtslRbhJIo6LvyQxuRvw7b0k8G4ClsnPtJvgaDF+cZMi+07sSWGP9nkjTFr+nb1/gszfwI+1cTEeEfV1gM1nL4To2B/8RnIUD+go8Epv5vSQEpIJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVIJvmTBHtpA8do9Ho996b906D8ikK1Q0n+l7+dQsxM=;
 b=HW1bEZoLwEJRW39kUaRt0Jybl36vZz3GgbOz3mLeTzFr4qCCJp81PepUeL416FHb8I0SpMihdw2+ssdErnwYval1U0nVtmyGkK5Lt8uManIisnU/VB4nLmZ2HFiyiJ2Wxnc0CCM3qy6UbR+1S4H/zklJiV+PWa8UBj330/Rlrwyyl7kx8u1VhPO3Awlm5unE5VdOD+1Ete5en5oiiRt9ERKqFmM7hIkxuAmpKS2Yziqob7WcYcoZcUzMLUQwcCRUtdoh/lVfGSgB9xJxzJgMKSTDWOKQ0JIAUzmcdYD60Gjw3gaM5dr1Xq6nNvCoNb/nSbEZ7NLYVF7VOPTMLL8aCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVIJvmTBHtpA8do9Ho996b906D8ikK1Q0n+l7+dQsxM=;
 b=GF0IExRf+WSDEAck7PkdavcJJH3lJTYjK9+oHZZSBo8y2enT7XUYA6/DUO13YIkh4AzT+hKqUQb+qI5GX5uZ2qO+jyIdrY0X/o2J5w+SBv6zhNRpEeaabbZk2p1FsdTFOYfSewtgEfZ6VTVrByAgMop1w765aSx8uKi9PBYAY7k=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB7244.namprd10.prod.outlook.com (2603:10b6:930:6c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:25:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:25:53 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Cc: boris.ostrovsky@oracle.com, miguel.luis@oracle.com,
 eric.devolder@oracle.com
Subject: [PATCH v2 0/3] ACPI: i386: bump MADT to revision 3
Date: Wed, 17 May 2023 12:25:42 -0400
Message-Id: <20230517162545.2191-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44)
 To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 877b3b9e-b41f-4ca6-0b2d-08db56f36256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3s+xAaLjzZ3qBkgRkfzNuEvlk8TGrc8r81fro76x25AFs4JkQRLyJv0egl7GCBtlobj3ChC+bSC8TgHDJo46a6ZJt62PS5RJsJHMT8Io40p6LbJKSwxjPC4SNENeEsnITs30weO839Sck8prJfp3myhbH+tGzdLlh57nozEvthKYmH/I3ovArbfZIrGUbsKD5gdDMPpvwugVMZ+ZKAHBEoT1M6nLwvlxJs3o/LijW9Zgq2juqmsrOrPL1sFWybBaR4tvlp+8tDy/IlS0TIgL5FNNBj73bGPyKiZia+wQkKW1tzb7TRmw4aeWZJ+CMd4FUIe4rb6jz5TlJMOdOFQZCs0m21lPJtFiLWod0BjGC06VBkmArp4PkwnrJU7zCUMPsztj8HlUfLuNG5mqriSHJvlpGCqmAYoqD3EhBsAwq5znfhxfCym1+gNmKunAVqsRtFFz2oa8MC7sd4xXGOgyZlhAEHq3kjo5AXCCtfW9/3NHlPsaBcWRd7+XNSubhPyF/EXZ6oixP065Xt4JL5AsSSLXJFeFZ4wRtI8KwM0KuNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(8676002)(5660300002)(8936002)(83380400001)(1076003)(6506007)(186003)(6512007)(26005)(86362001)(107886003)(2616005)(38100700002)(41300700001)(478600001)(6666004)(6486002)(66556008)(36756003)(4326008)(966005)(66476007)(66946007)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TV3WrclMgaJQyqIOq4xZxaRMRbpeusa4weJQEeIQz8uoUx0hB/Q4N99sNaVU?=
 =?us-ascii?Q?ipmZ2JsEJ8GlX4n0FLnZy4UKANvQYGfQ7n6beYvTimNqP9di17j6IlSsyth+?=
 =?us-ascii?Q?l3FSz8kOkOjOwySVN2hTfAz3hG24h0sA2es9kCkXqfz/vtX6p6KcaRlcZ/Am?=
 =?us-ascii?Q?RPsK32KfwGbVpvvIlod11u2fytA8YfrpeiMMwHNV7+MZs9eu6dQgzzlXKPKh?=
 =?us-ascii?Q?WlkF+yTvEehzl1FfOsBNLyQfclEdjnzKtJ8JTQ+qsI3tEMCzica7X8/JinX5?=
 =?us-ascii?Q?KjSTUv5SaO5NDRknC2pV1RhmWtCs/uUQDRhNaTr5Ersr7ADvG/m4DpT2+Mtc?=
 =?us-ascii?Q?m3nR602Uc+GdTMqzEc/UBROGko/4Fq/QdbAxPms0TRDn/nn9BdQb9Vbjd1lZ?=
 =?us-ascii?Q?avPEXS4mNpigJsIEmLGMC7BaA4YS7Eqkh+jKoByi09qBBPFlMy91QbRhTrWB?=
 =?us-ascii?Q?0wh5nVzCHjkPgrejiVjqDz7KSCFkrOvcqSg8gBrdT2hXhiEeAKXoAI1S/hIx?=
 =?us-ascii?Q?z0zw5xL7fgxUKzQ9K4UpRdsuKkYC1AHsSkCq4420tzDTqCYlRDWaLlFK5RJ3?=
 =?us-ascii?Q?ttVzCVEF0JdT23YiR29YxcsB6fy79/1xFFUNj8+8lULKdQgCMkj8Wt4GBnTy?=
 =?us-ascii?Q?T9Dip47hNo+w1OVSBWxNdlvefxpN+FicHZrM5k9KWzyYWnjNbrqkF5iyZyM6?=
 =?us-ascii?Q?GprmsufE51yw4HJjA+qMsgBMpzK/ZFboS84BiN1MkrjEVz2mBcR8SS85Xzmv?=
 =?us-ascii?Q?mSZGbqUnMPE3ikAz6E63s+2hAgg1LQiXmNa6jq+BObC1EGEbXF1uJRT+u4xO?=
 =?us-ascii?Q?yATW230yybb072hrc2e4Ch801UkxWKaqsn14vPc6idzXYg82aEVBIJJqNl82?=
 =?us-ascii?Q?NEviyrENlIyNNjEklZamDSSHxavD1Qgzn3zk17bW+1+rMBjniEDuizEiTPzQ?=
 =?us-ascii?Q?9x1bzp9iism0wk2AQY7rg/giaqg74t1MDBBqcFvfC//zYvvLliS1mMKiU8AH?=
 =?us-ascii?Q?ysA4VOIxZhK6actFYlSiGxya6IL5QV1Ojf17ErJvOc8K153cAuZWynsmNFkG?=
 =?us-ascii?Q?SyZBjfTAcVACwHVoZKYHjEkE2zPP5s3ifThqFitxNsu/y/ZPnkIq1poqeEZP?=
 =?us-ascii?Q?Gdh4Ar53qfoqVvSPPd3v5oDqBU7nT4FV32KFcDMorFY45QPGQFk75HsUwwEX?=
 =?us-ascii?Q?v/CEAjKRAbmpooj+gOp9HPl3lD8uHFNr2DCHwIY6xKn71pxXq+7c2NRg+dqc?=
 =?us-ascii?Q?COpsKiDU3gwGUG6PT3z3T9V4PMQvTGTyyvt6+Hk8LoeauXWlXrUyy37eyhFN?=
 =?us-ascii?Q?0eQIp2tB2uTzlhSvKj1pzUv+5fC5fKbOR0Y8UIhlBPzncG/Zt+gohd2IAiPU?=
 =?us-ascii?Q?RmXjmHOkBtPhb6h1qgG+hnbm/pYiLIH0K5QS6cbkTzA+9C6s0mY2HocDJNUD?=
 =?us-ascii?Q?5TM4cpWbArwlTMrD8zok2pElpLReuPGGx7mr75AcsEkwBQvOsKUoVT3ey8r4?=
 =?us-ascii?Q?K3xo9qTTXcDpP5WFJLttNxO/TjgS0Bqgj2WFEtZCv+8OXzfVwKzFXGNEVCrR?=
 =?us-ascii?Q?5Wi2yLMMGZxJq0jIQX7Lcdvxlzhh3bWQB0lZIbSd+H8AzpdX+jtoziS3CuyZ?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gpgOLTSC60jwWDpwIz2Ta0uvtsktrNnelHIqvrbxkYqgfqjAIFcHlZUdalqPvUJXJ2F6wp44FtbBUGIvbmaFXqWj9Zm1F/c4QO2Rdszxiv7jXMPSTfIPqV697IEOAs4PV9b+k5moxWmiuc4ZIs4y5WXoxh/czDcR7Mv7SJelJyzqzMQ4+oEY0Riw5uds83NCJKghXzpZK/AvhK/7hCsCEkRjR3SgNFcoL3uY6Gy3gFKPOgW/Iwvs4zenbd9sXHSXmmONTAUc+sFnSr4D5vgYaGV2b86VR6VlFm+Y/+CtnVMUmTw+DBhv68A3OhQABhMeNSqVQm1cBlcwUGi8L/xXriwWOXZTHPUE67dWk9LtK1flfR6/1HMj4XuIXQEcHUnA5Lht/1yfYYncHF0rlz62evybRSNeq8cQ7i2KV4VICKRzEpvG5c81lLrJ9ehKv4THfc3w4gfjOpJbsAkMl2LjW35dzaOCAf5Qqbi1kW8veOgbjGrNysBNz9pin44fRkwB+tC7YFkWUAk7KO1S9pYNHZt6Cn9ORiW/syX2C6IRdqD+4IzVvnNtTfsvhoUdxH3wE5qu9KNwgP3R3ZTWnEpuvv9xm+fqjgkZKc3SjzgZ4GJnr68jzeK5hGHMp8kciua6OypjO3H0wAAMmSc0PUV1rQQeNcWmKveL3KI+QYIAfV81PoWu0q3dRrnmDDm/sKjTc1LTODZ4PmrurmqNEP6zUqqTQMPjMPOPDtMb3XCIi5valnDDs6xuMcOc8Ofxhgb7d2VAEgaTzc5wxaAiWsEEPnfQIqMuoxNYg8Qd3LdSvfTF+mUwZuYI9QyPSO5FGnNXJWEvMNv8Nef0GpoumaShXxbwdJIkTqFmxQR+dTXEWzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877b3b9e-b41f-4ca6-0b2d-08db56f36256
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:25:53.2001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PATyeaGyFbjsq995FX5pMMCU1NWyCMM1SOFqvuadA/cjzZPetlylakGwWTOBF5uiGYLjBj7QD/O3psMy4HYOMVIHcsKjpXK6IHs4/J37g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=986 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170133
X-Proofpoint-GUID: 7iqWUWlON2Gd5e1tpj_RZGlagT9Izqq2
X-Proofpoint-ORIG-GUID: 7iqWUWlON2Gd5e1tpj_RZGlagT9Izqq2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following Linux kernel change broke CPU hotplug for MADT revision
less than 5.

 e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")

Discussion on this topic can be located here:

 https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@oracle.com/T/#t

which resulted in the following fixes in Linux 6.3-rc5:

 a74fabfbd1b7: ("x86/ACPI/boot: Use FADT version to check support for online capable")
 fed8d8773b8e: ("x86/acpi/boot: Correct acpi_is_processor_usable() check")

However, as part of the investigation into resolving this breakage, I
learned that i386 QEMU reports revision 1, while technically it
generates revision 3.

Below is a table summarizing the changes to the MADT. This information
gleamed from the ACPI specs on uefi.org.

ACPI    MADT    What
Version Version
1.0             MADT not present
2.0     1       Section 5.2.10.4
3.0     2       Section 5.2.11.4
                 5.2.11.13 Local SAPIC Structure added two new fields:
                  ACPI Processor UID Value
                  ACPI Processor UID String
                 5.2.10.14 Platform Interrupt Sources Structure:
                  Reserved changed to Platform Interrupt Sources Flags
3.0b    2       Section 5.2.11.4
                 Added a section describing guidelines for the ordering of
                 processors in the MADT to support proper boot processor
                 and multi-threaded logical processor operation.
4.0     3       Section 5.2.12
                 Adds Processor Local x2APIC structure type 9
                 Adds Local x2APIC NMI structure type 0xA
5.0     3       Section 5.2.12
6.0     3       Section 5.2.12
6.0a    4       Section 5.2.12
                 Adds ARM GIC structure types 0xB-0xF
6.2a    45      Section 5.2.12   <--- version 45, is indeed accurate!
6.2b    5       Section 5.2.12
                 GIC ITS last Reserved offset changed to 16 from 20 (typo)
6.3     5       Section 5.2.12
                 Adds Local APIC Flags Online Capable!
                 Adds GICC SPE Overflow Interrupt field
6.4     5       Section 5.2.12
                 Adds Multiprocessor Wakeup Structure type 0x10
                 (change notes says structure previously misplaced?)
6.5     5       Section 5.2.12

For the MADT revision change 1 -> 2, the spec has a change to the
SAPIC structure. In general, QEMU does not generate/support SAPIC.
So the QEMU i386 MADT revision can safely be moved to 2.

For the MADT revision change 2 -> 3, the spec adds Local x2APIC
structures. QEMU has long supported x2apic ACPI structures.
So the QEMU i386 MADT revision can safely be moved to 3.

So, set the MADT revision to 3.

Regards,
Eric
---
v2: 17may2023
 - Fix problems with the binary tables for the bios-tables-test.c
   and make check.

v1: 15may2023
 - initial
---
Eric DeVolder (3):
  ACPI: bios-tables-test.c step 2 (allowed-diff entries)
  ACPI: i386: bump to MADT to revision 3
  ACPI: bios-tables-test.c step 5 (update expected table binaries)

 hw/i386/acpi-common.c                         |   2 +-
 tests/data/acpi/microvm/APIC                  | Bin 70 -> 70 bytes
 tests/data/acpi/microvm/APIC.ioapic2          | Bin 82 -> 82 bytes
 tests/data/acpi/microvm/APIC.pcie             | Bin 110 -> 110 bytes
 tests/data/acpi/pc/APIC                       | Bin 120 -> 120 bytes
 tests/data/acpi/pc/APIC.acpihmat              | Bin 128 -> 128 bytes
 tests/data/acpi/pc/APIC.cphp                  | Bin 160 -> 160 bytes
 tests/data/acpi/pc/APIC.dimmpxm               | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC                      | Bin 120 -> 120 bytes
 tests/data/acpi/q35/APIC.acpihmat             | Bin 128 -> 128 bytes
 tests/data/acpi/q35/APIC.acpihmat-noinitiator | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC.core-count2          | Bin 2478 -> 2478 bytes
 tests/data/acpi/q35/APIC.cphp                 | Bin 160 -> 160 bytes
 tests/data/acpi/q35/APIC.dimmpxm              | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC.xapic                | Bin 2686 -> 2686 bytes
 15 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.31.1


