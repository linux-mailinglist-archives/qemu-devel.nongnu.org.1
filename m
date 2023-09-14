Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7415479F612
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 03:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgamC-0000oL-5O; Wed, 13 Sep 2023 21:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qgam8-0000o7-6f
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:04:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qgam6-0008W6-8G
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:04:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DNMhS2015446; Thu, 14 Sep 2023 01:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=s50DNF5qM5IN5dmRI7stW4xoSfcPGFYza1InsBgy2iU=;
 b=qab7ti/1h7AmyP6aS6e+XRBcSV7BnQnh3/6IwEiSG3e3HCjUzTWHW0+5G5knmTc51Mjd
 yZ2h/0+VI1Ysemgpko5hOBtxlSJnvUsUDuIqOWHZIabUBLT2yNF9fVkMjiqTpYq8SSUb
 N/zulUcgHOrQD11rnTZhieEqoOQvC9pTO1rb3K7Eja1hsRdCq9f82Uqxvsq42pYq3kxx
 EowcjDNiHx+2IxrYbiGM1BS1DHbXUoPOgnP+ChUc+bmT4KLpOZ55CXDp6zATSvOHqR95
 sY0/y/5NDGEk0bCCLHfxdpTZsbaYnersckslHrK5VUpye94X9ZWuo7j/mplxpVXBqjxE Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t37jr2w7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 01:04:04 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38E117OU023178; Thu, 14 Sep 2023 01:03:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f588p9a-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 01:03:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpIjGewM+m6EVqTW9pKJ0oREy176u/5gYMxH7oCJ6vONDPS0rpzemjN7IXRFQ0da/KKYGyD/ec4Ehn6I8nLGSdGqymcqvpg9iJxf9HfynnkMi6t9ggLNoWKbwbatuFfFeUC8bVENJ5tUvAbRPwk4tr7IRfALkpwCV3eO4RR1d4+WBTgi2koYa2/zfPwjGg85j2e9koE8/A6hRHrwAC27hJoUARbqW/EXevsScxBCRYGU+Xjtt8q/in94ct+wiafuHfhkhO+9mvlroIMBVETz1hXf3fa2NAJQmqQtXP7u3ls/VRigRlmR6MAK2PndwCPViFYc0hMTqCMpc0fM3fzsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s50DNF5qM5IN5dmRI7stW4xoSfcPGFYza1InsBgy2iU=;
 b=cdIpPa7pk3HnrLrUgup3XL0H2erhFnHJYFylVhyvRp/Jlzqs+/+VVQSpP0evvjpLBrjuR/HBeqfhKVqwLgIYMIdl7TLwZJvhMKmjqog6ArZNSwR/gtAK43fh/72WrJe2Rd5o5knuyokTxF5Ciq9G7+obFwkVN/cJf/03cTE32uOCPWwSAbkOSxzvCYpx0ZTNcGPPnildBf/VGyVjn2T5HQAKs6Z+z0RdUKF2zuLCWthdndYsFAfhTPRRrCQoXyzsvhJNxHwZ5hPzn8l2TelK/uLuRuUIIcbCAPjLvfIQH1XwQ90/46AfYyRFk/LDsYibd4c7pDQEPniFGeJBiLwrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s50DNF5qM5IN5dmRI7stW4xoSfcPGFYza1InsBgy2iU=;
 b=N7y99qHQ8eb38Myuqn1qzwLqDd8TUqfpPhoQy9jdnp+XYN23Xu5WPJMFgECXE84e9ZcLLEVnVgk4E61Zi+xqF/y4ZsWDgo0bBiApypIiYfFE2Pbd0gwX7mXbXQCfRWeRcTY6VsrNsU3z5tINkaDFnLGYh+j2ifbcazOvh/fE1qA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DS7PR10MB4975.namprd10.prod.outlook.com (2603:10b6:5:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 01:03:22 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 01:03:22 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 qemu 2/3] dump: Allow directly outputting reassembled kdumps
Date: Wed, 13 Sep 2023 18:03:14 -0700
Message-Id: <20230914010315.945705-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:806:22::25) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DS7PR10MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1b37cd-743c-40e3-d3f5-08dbb4be6483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/PYHyRTK7iTE5Mjdkz0sDwdN/OxCXaeNWNr1Fa1GTXIHZYx7xbzSbYmuY+d3JdrMpKGr7JfWfNfq//BP8y9+Qw+4ral8Q7J7zuFugS15ltmb7wbIUgNkJHj/1HP0SB3OuehHoH10fm9yZ1yC2ko0cqHqlKy1YWpCVdgu4eUFfMhhI+DOa6lYmeJiE4CEVSa+7QzJ0mM4N/0FLQhynLRhuOGsCoznCA32uFcsx48tG40xX0FLTzKbhMq4nGqIJtBKqUvFVO+Cj13ghk1O7bSXI8VXoA0OO+uB/4MhSoh8Z3/zY6opE1uHS5c7MHGj3LmQ5MxKTUQq2XdgXzQI9nicQrGR4MUT50TkLiG9iMfRWFRoC48EMNHl3j/iDKZvP1CeHcA8sdfTiRjDdI+78wzbgiGMr0JvLflqkrH0vovqQbr/FmxX8FDStJgH9Xg5sa+pey+5EAs1d/w7cfkmK57rAsK6q2KkFs4dT8IcCqGnEUSxdxT6+hNLyNk8qrtIS6YiSCJtaerP9VIzMyK1LPdd51WdUy6a/EKIoTdsFoVWu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(66899024)(38100700002)(5660300002)(36756003)(86362001)(103116003)(83380400001)(66946007)(1076003)(66476007)(478600001)(966005)(66556008)(6506007)(6666004)(6486002)(6916009)(316002)(41300700001)(8676002)(8936002)(4326008)(54906003)(6512007)(2616005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?voDw5cQ/LL8nHvXZ7ymO2Jvg1hvAlQYcAYKdsljHBNYHlMJamWb5daIpVj6D?=
 =?us-ascii?Q?SnZwKChTx4ySr/owOpvuRkPyYozK/HU8bCFxl4M06HxJpgfhvQYsCdHp5OI9?=
 =?us-ascii?Q?PLVt2RRbFECTQY6b/TcgLL0RK6CySsbjX6QYQeM6ERWrBw31FJudkoWjy7AH?=
 =?us-ascii?Q?bAkJqe4g4TXsFD5MbYqPVXcpuLeI9WFk4GxdtAMnKi++8pTAu8XT95zDMwhE?=
 =?us-ascii?Q?hePG4cwmUtFWDT6mYTz3CgsL1yvwmaric7lNpR84saOapHvqDNMLnhD2TWra?=
 =?us-ascii?Q?P58HlRwpcdEt/9DWoOUwucW60fXczC/7r1BHzb2xoxGrevXhkA+dRELxiwa+?=
 =?us-ascii?Q?BF728qXC0P8/Zvz1pt/X1dl4P2n19aQb9AtPK/8XAo21Bd7q+iI1JIFEH6+F?=
 =?us-ascii?Q?MGkBIGyeBuoVDoLfSP8KJnTB7ED8DV0dmpoMSZlZEEo2AW0c39gVmCFnEtad?=
 =?us-ascii?Q?oO6Vube6JmqUvI3QKhX3rcDAYGgyHmUABSPiuLNqBrSmQSTHs7X0XlTXQCRD?=
 =?us-ascii?Q?zEeS1LXO1Ntndr+KXAUtJx2FibGUF9Ch7osEfmZiUMGskbWuZoxJehBCfUXl?=
 =?us-ascii?Q?o+7syLo142Pkg3Y7zrtzSOTubmA646w7Zbh0Nrxe8wqzdTe5wvbyt+K09/Wi?=
 =?us-ascii?Q?fZUIyOLRhVTuzq2CtBB/2yKqy5eoUtQQtOlUAryAvLZTpfnVkz4YeKxxpvVt?=
 =?us-ascii?Q?3N3Z3ZH8y9e6aWP9BMXXLnSk2iIU0Gd6JQ4s0jrH2yyZSzGQHu8aiRj6JSMo?=
 =?us-ascii?Q?HsSrnGmrN4lNNUSs31r5vvoSeN+cCUlFzLW+MqrYlx0T508tLho9ybz3e3lz?=
 =?us-ascii?Q?QM/A+6oEq0Km6NLnmWKEKVmEB8um4M7uuI3QXMxETc59ttV5YPjfApY6N1Qc?=
 =?us-ascii?Q?TnrtHyj5FnpaDUHmpMWpSnCmj8V1JQoPfinkxQqJwgsP+WybZNKMrDUnXYCb?=
 =?us-ascii?Q?GaY44ZSBqLrF3pryHctoKwkta6BGPde4nCV/y0aKLQ7pFN3X4fNrN8CjOoMy?=
 =?us-ascii?Q?qpuB2M2EcqZS2Q99LaNZ9fzWtU3F38kRQKjVHpBaZSQlmRDWiIjFJZCGxww6?=
 =?us-ascii?Q?EdjKJm4i7TGTVTaF67gbDdYdozLTcs62ZJhS8uYN//OBTVMguQQHQaszTcyD?=
 =?us-ascii?Q?MWuEx6sp3hakRGiFQGi11KmYBq2hNgaWIMxZovsxv8OdFgGhw0MDrWi28YOz?=
 =?us-ascii?Q?o055iUxU5iP6gSembRKsoVzTTkwGha9H8TTFQjWNe5GMO+foKvMfCVTrYkIz?=
 =?us-ascii?Q?4Cx4x6morAWWZDPxVXoieOOrkXhdI/hNiP1tvQf4jY5MtqWY0c0DLx68ktxv?=
 =?us-ascii?Q?vUggTRLXYap2SLtBmB0CUpxCM2Sg6+Mk3fm+1PRC5G28Lw00NziXZYgy0DS4?=
 =?us-ascii?Q?Hnuca3PkVLWRavCj6LrFBxfvuBVR0zRfpm5DkLsR9O3VcwbLtNLxpeMPGRJM?=
 =?us-ascii?Q?KLZgcYY4SuKvuy+CE41+DFeqSDWP8QUv5Xvq/P1JtgirnLRTVAorFAcHaEtg?=
 =?us-ascii?Q?v2g7XoGpEkZ7H4b4O0vzTZ4KYDlT5tGZ8mH4/YufJShptwShHmv+AaziQ8mZ?=
 =?us-ascii?Q?pJ3bFpApUFXCHYeRek1cig9g+gQTuGqcd18/enHzsFs0cSkkxBgXS55Qix+8?=
 =?us-ascii?Q?0erx0I8RLBi5UxbZkwcetTmcaarmlFI6ge0GlItH+ulq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Epcnx0utwrIEOSPqkK59AkRDtZCzir2qOLVcXK4F0igwP1SQoj404Ez2HDxIuvFSKFr9nt9DtcxGcnDD739xFNOJ0LEqpQOCzmEbWjsnAWb9d2oeCMAXbs6xk5pU25lMtXkM/fU51U69O9L/kKiF+uZeqfkwGN4hfGXCqRt58iccZLJ+W4012zZwYlsDkMOcjD0mYsCyf7njkWBtmTV1nNCEm2evq6Zhh0ns79vpuRU0yXUE64t1q+Sf7CMsa3OKi4fqyDWrv7WA4uf4eOjJgcKws9FkCTEU2SIya+ewcXdUzwWR4XBa7Ebekbu+QXAWrKEshSvHNiaFMPcZM1Z0nnqHOa5nOpIasHDv26gDH2gwd6MhSXCCEbZKu0/30pmOGhHNCcIZ/Tj20atTIKCGW1CBmlcFtpR1Wk7gkWna+7OzxqzVip5+PQtvQp+KBuH4PsEwYtg7xJaCHsnw/u0mlj6Ew6kVq0eKXoNFnUvopltY0RtBQDip+9ODbIVSqFjP7wbD5p7dk8qkW2B6x8D6a/71gLZF+RbU0vF+Fe3aydrlq/oMqYL3cLzYfN5HLlgsSJerhfAPdEC5JF18qR1771BUER+oytDTCAV99YHKF3xktaOrZGoFO+ota50yk3qL8Y0CtVFLDjXsUCuiGjSZSojJuCIG39pGXmvIpTKJAlds7j3Iegzq1Q50G0+SA0k9MdYBv4+VDE+micBhypgkrPwK7ZvTdbVa72bQOhhCohXgpO7CMaUVYtG16V739tlvRQLnlHcmb884rIUzRcmXDOVOGsjodqvgzMF/dpVLK/8A9PaTOBIPZEvDx9t7FLyBrZhO/xaxfic42QZHy6uR9gdx2cZ2e4FNLZyW31NH7d1bP99ZObfqfa5LX61h5Ab2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1b37cd-743c-40e3-d3f5-08dbb4be6483
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:03:22.7215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXX189NANbqHoE0mocviVx3aq/vYkIdTkqzAVMj82EhR577svMax4g9tGUNu7VvR1o4oWxl9FoZyhAWllMUOVh7YgAjfvRZZFIyJLYh1Ofg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140008
X-Proofpoint-ORIG-GUID: GJITTWbyMCYYolOHewpUkGtlCIISdhW6
X-Proofpoint-GUID: GJITTWbyMCYYolOHewpUkGtlCIISdhW6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0b-00069f02.pphosted.com
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

The flattened format (currently output by qemu) is used by makedumpfile
only when it is outputting a vmcore to a file which is not seekable. The
flattened format functions essentially as a set of instructions of the
form "seek to the given offset, then write the given bytes out".

The flattened format can be reconstructed using makedumpfile -R, or
makedumpfile-R.pl, but it is a slow process because it requires copying
the entire vmcore. The flattened format can also be directly read by
crash, but still, it requires a lengthy reassembly phase.

To sum up, the flattened format is not an ideal one: it should only be
used on files which are actually not seekable. This is the exact
strategy which makedumpfile uses, as seen in the implementation of
"write_buffer()" in makedumpfile [1]. However, Qemu has always used the
flattened format. For compatibility it is best not to change the default
output format without warning. So, add a flag to DumpState which changes
the output to use the normal (i.e. reassembled) format. This flag will
be added to the QMP commands in the next change.

[1]: https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a2746dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dump/dump.c           | 38 +++++++++++++++++++++++++++++++-------
 include/sysemu/dump.h |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 74071a1565..fb9040cfbc 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -814,6 +814,16 @@ static int write_start_flat_header(DumpState *s)
     MakedumpfileHeader *mh;
     int ret = 0;
 
+    /* The user can request we not use the flattened format, but
+     * if the file is not seekable, we need to fall back to flattened. */
+    if (s->kdump_reassembled) {
+        if (lseek(s->fd, 0, SEEK_CUR) == (loff_t) -1) {
+            s->kdump_reassembled = false;
+        } else {
+            return 0;
+        }
+    }
+
     QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
     mh = g_malloc0(MAX_SIZE_MDF_HEADER);
 
@@ -837,6 +847,10 @@ static int write_end_flat_header(DumpState *s)
 {
     MakedumpfileDataHeader mdh;
 
+    if (s->kdump_reassembled) {
+        return 0;
+    }
+
     mdh.offset = END_FLAG_FLAT_HEADER;
     mdh.buf_size = END_FLAG_FLAT_HEADER;
 
@@ -853,13 +867,21 @@ static int write_buffer(DumpState *s, off_t offset, const void *buf, size_t size
 {
     size_t written_size;
     MakedumpfileDataHeader mdh;
+    loff_t seek_loc;
 
-    mdh.offset = cpu_to_be64(offset);
-    mdh.buf_size = cpu_to_be64(size);
+    if (s->kdump_reassembled) {
+        seek_loc = lseek(s->fd, offset, SEEK_SET);
+        if (seek_loc == (off_t) -1) {
+            return -1;
+        }
+    } else {
+        mdh.offset = cpu_to_be64(offset);
+        mdh.buf_size = cpu_to_be64(size);
 
-    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
-    if (written_size != sizeof(mdh)) {
-        return -1;
+        written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
+        if (written_size != sizeof(mdh)) {
+            return -1;
+        }
     }
 
     written_size = qemu_write_full(s->fd, buf, size);
@@ -1775,7 +1797,8 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
 
 static void dump_init(DumpState *s, int fd, bool has_format,
                       DumpGuestMemoryFormat format, bool paging, bool has_filter,
-                      int64_t begin, int64_t length, Error **errp)
+                      int64_t begin, int64_t length, bool kdump_reassembled,
+                      Error **errp)
 {
     ERRP_GUARD();
     VMCoreInfoState *vmci = vmcoreinfo_find();
@@ -1786,6 +1809,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     s->has_format = has_format;
     s->format = format;
     s->written_size = 0;
+    s->kdump_reassembled = kdump_reassembled;
 
     /* kdump-compressed is conflict with paging and filter */
     if (has_format && format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
@@ -2168,7 +2192,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     dump_state_prepare(s);
 
     dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, errp);
+              begin, length, false, errp);
     if (*errp) {
         qatomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index e27af8fb34..71ec492fce 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -157,6 +157,7 @@ typedef struct DumpState {
     MemoryMappingList list;
     bool resume;
     bool detached;
+    bool kdump_reassembled;
     hwaddr memory_offset;
     int fd;
 
-- 
2.39.3


