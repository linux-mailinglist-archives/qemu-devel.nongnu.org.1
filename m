Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F105706E16
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJyf-0006Xv-VH; Wed, 17 May 2023 12:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pzJye-0006Xm-8d
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pzJyc-0004ut-55
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:26:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE4e1q014520; Wed, 17 May 2023 16:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PZ4Jc93d8o4Mu/EsagkUrRryEEGADLJMjEaF/3Vk9dI=;
 b=AN1ORDj/yyZbed/Iqh1pmru24rQA9ABbhNjPF4ajUfBqqvxym3AFRLuJj4W7RfkZjYrM
 AenUNQvdCWvztdr35kLQtmuM8QPtU1jObEx+jydK9DiAhEEDR76yqXPiewrscD3ueNgP
 Gg6KzzmTrGjMJJO6CVBLSspjwlDgZvJCKvOR3YbKy+2g4t5dA0wBCVwjHn80kpoMAfuo
 KmNL1cerIIW7WiFeQeKT5YyRTgTClbuqDtDPDtmMgjBjTWM1U3HMHLaK2vBzvupkGLLi
 Rlf+Jv20UOjzx4l4P7bJ6GrqHdhMYwnJ21u7pshKbnfc4ZB0ZWyBmeuy2WgRQnxbUoWD ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j0qam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:26:06 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HFNMlO025109; Wed, 17 May 2023 16:26:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj105n2xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVl+os6QdSYxUTo5AI/x7GT4BeklFdC2s5hNBjR1SsclsQ6qAAo/LaNBMkK00quOqMgfrws92ltMWuVjIWZCYQ8z+vYGNLJNgZMqpk7yUWVo02gzHdLje0VNpsE+ONQ8gXXR7245ZHierwVzb0iXLruTz0f7RKxUNatxSQp6UwpkLVVBi6gFT67I+w89W7l48JSqMlgy3EbQaCFftwsPzLoYvymCxE0vX1hiyjY9CeBfG5NMYI9ldeYDMovAJzR9hKfReDSxN8fWEYv9CXmEAffUZOl8htd9w0Ok1YUs5YRAghYeDd+lhLiEIfJchSKlc8LdkUKCOYczTqQ/LINcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZ4Jc93d8o4Mu/EsagkUrRryEEGADLJMjEaF/3Vk9dI=;
 b=hQXJcIG90ESTu1VoQJaDIMCTrKHimaxqJAuunWJBXNMLt8M15TqyvRXaHi7HDeYLY9owI4VHC3wAEDSXVYa+gupJnzZOBAhc3YwX0IJbvPd4YNXIck4yxfsPSahDnmzklt3MxgpKyqvpLHEzSb5Q4d7Pf3nviKQn/IMr+23CYrEv34Ax/tHWU5ho/VZgTekR5UQ1mnDs2Xdlyocj/8USfcmSXxbXFirv9USoS1L/9yjyXFy/GEfjr8HST/y/2yy5MlRoZxEa5zZEoXTyn4tUZvTZU0Etz1QFk/N/Zgu/GFzEZnORsww/GupM2n9JsE6x4LUNJ9+ytvqkUfDIa4PpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ4Jc93d8o4Mu/EsagkUrRryEEGADLJMjEaF/3Vk9dI=;
 b=syRYIeSG73I3251CLEDUdrMS4552S7RDbfvmI50kovqnoBCrJzNO6dQmR4Zh2Qrg1oDxCy7KoFxY+ZBh8VTAbpdzUh15RuoJiwLIxDNSTw72qy4loMTiLcJFhxxEQ6cDBqZM7SiCpzBCSjJltjzqAqhscNgKcikqG51jgGpsDf0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:26:02 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:26:02 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Cc: boris.ostrovsky@oracle.com, miguel.luis@oracle.com,
 eric.devolder@oracle.com
Subject: [PATCH v2 3/3] ACPI: bios-tables-test.c step 5 (update expected table
 binaries)
Date: Wed, 17 May 2023 12:25:45 -0400
Message-Id: <20230517162545.2191-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230517162545.2191-1-eric.devolder@oracle.com>
References: <20230517162545.2191-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5307642c-7d11-4fed-11d4-08db56f367b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMEo5nT1aRp8eTiziZMjiOAQ4AYmnjeERzVv+yGceoiyir5nylEIi0NQZlm+7ZuSkcKUu95e1Qwq4mgmRlvMf3CdPwNkBi5VpgBm6aYeIVxhvhAdTKmaHA7WW7wwuTwjfDz4V65lrb+nzImEqaHmQf43f+SR1m+EXHijTK9Ps2IcBCVFw45JTU1rkPvw16xXlU26pHww3mp0Gmwr6Kwxfh1vO9UHRumTvEmeeeAzKv9HkzD7y5Ex7X40A8XrK3CIA5Cxlnl+W6blP1dfjmmVjwUVY/Mw0yim+RZQInsw8rEU9iIpjSj+VAxpx0MyDnnKJ9FdFdO8okWCTUXbCkJhnL/iJvBpIwskV3384604gqdP6Ysb9QNsnTy7q5OOM/zjjMmjQho7B27//DOsW4IPpq4e4JSkvJTeI6xaZdb9bDk7hgT89uWwijX3lhjTARghaxKyn4h97y5xR+Y4mJIJWBcbQjTMDnxSV3MzWZma1vEVQSnN2O2TQmp0yaGMQ9yldYepRFMph7rLZF2AUmBhtSIXiUewhiqOxuLKkyIjIFS7MVajP2A4TfDhzbAMBDplKkZAYFEuh0EjTrMj7TyJ/WqWHx7C/lmpcY+/hGPxBWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(5660300002)(41300700001)(2906002)(36756003)(2616005)(83380400001)(86362001)(38100700002)(1076003)(26005)(186003)(6512007)(6506007)(8676002)(8936002)(107886003)(66556008)(66476007)(66946007)(478600001)(6666004)(6486002)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdKVSQw9HlExe8W8BOwnwKbGlsg8qL9K/rSyG3bp/gG8CTJrUYwGuYxZhKzB?=
 =?us-ascii?Q?MPqrVRXaTL13OwqrDIlAtT8RjeSR92i+cFxxYuWYgV1Y0NSX1cwOlxV3QIKV?=
 =?us-ascii?Q?GsSG0lBNj1wt9OwtkY0rlMVqGACsf+2HzIcHUvljngYbFmpmU7KaN+hE4npK?=
 =?us-ascii?Q?SG/VpA1zJ29A1pysKuB71Zdbw0tMw7NzNyXR1ppg26WxEXkzAOFYeaWgwF5X?=
 =?us-ascii?Q?GKXR6XeAyiqH6/ZvduZrl1uXAuHSBeidknH2cphBhFgvCEYpiQefGzWUQPEh?=
 =?us-ascii?Q?++nxCgS28PFMMetxQwvoI8n3h33NTFqVQoZtdPcDt7IESOjTJgmiFWeQPFz+?=
 =?us-ascii?Q?mrufXv8VapJkw71DrHNiGOSlrrUuhiQQWo7DKyQwuVLaw7U7F9wohFYJLc7J?=
 =?us-ascii?Q?OT6FssdZM0w70NiVNGz4HYswzqJKnITgfcErX0RMs8JJy9D1mylCmlIpX+Sq?=
 =?us-ascii?Q?TzNfO64hxr3+rNCpX1SS5gsuvmLyxDxbpUZ8pOAjti/8OyNRLweV5oBynFSU?=
 =?us-ascii?Q?bwlWsum8/+1valn/fTiooKAErzaViUPhSkEQ0DPqZQi832a02LbIftoouzj8?=
 =?us-ascii?Q?IS7a9unuJEOE/JVx/lwKqkhcm/T87ysDSQH0ygKHXHG/mCWB7jNhEeObjos1?=
 =?us-ascii?Q?UV8trcCULOvjboYgj2WC2muHSEv4NlP2hHGl+Z3Nfhc/g6aDPpglTeQBIccP?=
 =?us-ascii?Q?E/OmSqVVGxpzfjfwBjztKmcUB1FPjm/i9WATqYY23og0cWshXrKivfSSJsCg?=
 =?us-ascii?Q?kJGs3Xm6GR1Nh1nUYv9BEQx93X1DHPArTCYvcQeU+s9mB8AoCU9WtvycSkhF?=
 =?us-ascii?Q?+BxcRVoeHED1qK87O2NRhL/fN9PsAzf+4al6V+CDx68S0iyP0weifSQXGcGH?=
 =?us-ascii?Q?o1KN5WIpJzZQV9YQuuxQlPs1p5eh9mTzvO0j050Gof8gzEDawOpWAIDS5SpT?=
 =?us-ascii?Q?wUs8NXr6ZXEfJAbvN2jnTMA0FqXR22zaghkPDuxSMj7XZKYO4VKlMFcQpFIZ?=
 =?us-ascii?Q?tlAvf5ui/KTGPjXOpVdb64mM8XsCLj3vJvSF+nKy8AQPSMT3bD3Qv61XYPTL?=
 =?us-ascii?Q?Ti2G35BsgYn2L1mv7HOj4fmyZooMv/9Tbjz7UrYMxdE2hgoosJngUSKEgzgy?=
 =?us-ascii?Q?spqK40vim1uZavj96vxWx7bioY5+kn5fvqiYEdmdgOTRybMEuKgq8E33DrY+?=
 =?us-ascii?Q?9q+3EBPZgfjtXWC1I0xKTTQL/FnwLw80dkRIdv8iyEXLUHgJqL9G6wBhXvBg?=
 =?us-ascii?Q?J2Kr8LjPWMc+gvrhXrad0c62XZtX5WrksCSNkOE/+TmLCwfQ6nh+0WPP62WV?=
 =?us-ascii?Q?NjwCol5OuQYxLsWLI9iT0ooznJoLckRWX8yp0dF62R2/b8+nAihHv6AZapAi?=
 =?us-ascii?Q?7Ro2IkoLk5+kTS1EQEQZJvLHChheyNol8Pbx+sn3jF2qQ+aBdZKYFGu0VJ46?=
 =?us-ascii?Q?bF229G2AayVYnylUgQmvC7bKzCJ5w8vXRJ5lq+VmHzidbWD8UNwfFQ5iVeTS?=
 =?us-ascii?Q?I93cdzEUE0PFGAhNkc3JzwtEdmvTmTV4AWOYZTjoUYqq4uVc7GUfO/kGzQFG?=
 =?us-ascii?Q?UlM8j/LoHrjvVRCF7oNDrp4bTc8wqKhms1IdD2aJd95mIlWOb2Z0JWGCevLj?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J9N/hnNcJQhy1W5I+CiS5xhiniAftC8WNwpGeNB/bafmLcK7WJCd3IzM2sAAH8SFmZh7fh8v+JJjosuZgOFHIVVFp9SHp+cC9PNsvV27FfLZT7qZPYtl4+Gta7TiHaMwLW66/cWmxRlt3tGX73uD21U98pstqzXukZ4tFWZq7VDPUS6XTetrf9HasVHYhn07gYFZ79DtrLQkN14IBTGLXoSho5fI7MSnQ30+d+U+cENfZ8i1qY3jJHJQgne9HLkwuv58LXD6qLiQemH7XwwLB3TyvQZACq5qrzAReeQJ6Wc6Qx1WE7HT/c2tueREQkETlLQqibDYbb3c4LMHwfKII+bbNaqld40G42E6H2GpUhXiq+iAsqPK8uAfuuIa0xiV/P6tZontCEbUzeEvLDH63UoAM+YhXKnDIU5Yut4VXnj4RAr0MHrv0cVPgbMCHFc8rxjfigPEH360ZqpFO6nIRUlbPo3XJwbwid+EifGRf6Aby4CNbClPQW6vRw+6e/Tsn1R7r/1GDeQQfMvNXu13oEyfidpY2Y68R91hZZl9u8IGdPjjlMuZ+1vWDaUU1hWRr/VmR3BJcwBpCqZ4USfpWQu9dYzUCWnC1eRE2EoXUKat7admccDO7TXTGTnEe9P7ZIfDxUtgcEgvVqSsdSjNfcEO70qgYJQePc5iP1eRuNTAIirDUuHrclpaydd5NNLXii/k3C5hJLMmIk1VU66HY1aVWlFA22cfhJCj+p4+qH2pTx15+hm3Mras9s7z46feK0frmZ/ptA1UNkpLkTvAlinrNEtODvBspPLt79pZZuyhzYB8s8vtfLFvpkla8wQN/S0oq3vQXRjmi6DngQDZaN3R/uQBPMI2Af+37Et+spE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5307642c-7d11-4fed-11d4-08db56f367b3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:26:02.1547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIns9uPV6sEjyU23shjVu0f0IRQXkpoSBZbNxGdWOQyo+EST+Xlbl8wZtElQnTfcAPIXw/YaMSPXgleTeTiXOxUOISLdyAF6KYtHlA/RCZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170133
X-Proofpoint-GUID: ijevUeJznlohi-BVANxy8WcG137THwZX
X-Proofpoint-ORIG-GUID: ijevUeJznlohi-BVANxy8WcG137THwZX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 5 and 6.

An examination of all the files impacted (as listed in
bios-tables-test-allowe-diff.h) shows only the MADT/APIC tables
bumping revision from 1 to 3, and a corresponding change to
the checksum. The below diff is typical:

 --- /tmp/asl-1F9641.dsl	2023-05-16 15:18:31.292579156 -0400
 +++ /tmp/asl-GVD741.dsl	2023-05-16 15:18:31.291579149 -0400
 @@ -1,32 +1,32 @@
  /*
   * Intel ACPI Component Architecture
   * AML/ASL+ Disassembler version 20230331 (64-bit version)
   * Copyright (c) 2000 - 2023 Intel Corporation
   *
 - * Disassembly of tests/data/acpi/pc/APIC, Tue May 16 15:18:31 2023
 + * Disassembly of /tmp/aml-R4D741, Tue May 16 15:18:31 2023
   *
   * ACPI Data Table [APIC]
   *
   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
   */

  [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
  [004h 0004 004h]                Table Length : 00000078
 -[008h 0008 001h]                    Revision : 01
 -[009h 0009 001h]                    Checksum : 8A
 +[008h 0008 001h]                    Revision : 03
 +[009h 0009 001h]                    Checksum : 88
  [00Ah 0010 006h]                      Oem ID : "BOCHS "
  [010h 0016 008h]                Oem Table ID : "BXPC    "
  [018h 0024 004h]                Oem Revision : 00000001
  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
  [020h 0032 004h]       Asl Compiler Revision : 00000001

  [024h 0036 004h]          Local Apic Address : FEE00000
  [028h 0040 004h]       Flags (decoded below) : 00000001
                           PC-AT Compatibility : 1

  [02Ch 0044 001h]               Subtable Type : 00 [Processor Local APIC]
  [02Dh 0045 001h]                      Length : 08
  [02Eh 0046 001h]                Processor ID : 00
  [02Fh 0047 001h]               Local Apic ID : 00
  [030h 0048 004h]       Flags (decoded below) : 00000001
                             Processor Enabled : 1
 @@ -81,24 +81,24 @@
  [06Bh 0107 001h]                      Source : 0B
  [06Ch 0108 004h]                   Interrupt : 0000000B
  [070h 0112 002h]       Flags (decoded below) : 000D
                                      Polarity : 1
                                  Trigger Mode : 3

  [072h 0114 001h]               Subtable Type : 04 [Local APIC NMI]
  [073h 0115 001h]                      Length : 06
  [074h 0116 001h]                Processor ID : FF
  [075h 0117 002h]       Flags (decoded below) : 0000
                                      Polarity : 0
                                  Trigger Mode : 0
  [077h 0119 001h]        Interrupt Input LINT : 01

  Raw Table Data: Length 120 (0x78)

 -    0000: 41 50 49 43 78 00 00 00 01 8A 42 4F 43 48 53 20  // APICx.....BOCHS
 +    0000: 41 50 49 43 78 00 00 00 03 88 42 4F 43 48 53 20  // APICx.....BOCHS
      0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
      0020: 01 00 00 00 00 00 E0 FE 01 00 00 00 00 08 00 00  // ................
      0030: 01 00 00 00 01 0C 00 00 00 00 C0 FE 00 00 00 00  // ................
      0040: 02 0A 00 00 02 00 00 00 00 00 02 0A 00 05 05 00  // ................
      0050: 00 00 0D 00 02 0A 00 09 09 00 00 00 0D 00 02 0A  // ................
      0060: 00 0A 0A 00 00 00 0D 00 02 0A 00 0B 0B 00 00 00  // ................
      0070: 0D 00 04 06 FF 00 00 01                          // ........

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
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
 tests/qtest/bios-tables-test-allowed-diff.h   |  14 --------------
 15 files changed, 14 deletions(-)

diff --git a/tests/data/acpi/microvm/APIC b/tests/data/acpi/microvm/APIC
index 68dbd44a7e35a356083f086df60f70e424c4249f..672764e711d80402890902ba9ded10915770e84c 100644
GIT binary patch
delta 16
XcmZ>B<8ln}barE4U|=qq$Ylcn95e$)

delta 16
XcmZ>B<8ln}barE4U|=kn$Ylcn95Mq&

diff --git a/tests/data/acpi/microvm/APIC.ioapic2 b/tests/data/acpi/microvm/APIC.ioapic2
index 3063c52cd3e9bbed29c06031b375900f4a49b9e0..6f24fdb12ce3f1c13df7ff835e475d8023e20d4a 100644
GIT binary patch
delta 16
XcmWFv;&Ke|bPi%*U|?>X$mIb59$W*3

delta 16
XcmWFv;&Ke|bPi%*U|?*X$mIb59$Ev1

diff --git a/tests/data/acpi/microvm/APIC.pcie b/tests/data/acpi/microvm/APIC.pcie
index 4e8f6ed8d6a866429fc17aecdeafc3fb5ef65fa3..2239ca76a607fb1ff9d392298e2bd6461bba7ecf 100644
GIT binary patch
delta 16
Xcmd1H<8ln}bk1X7U|_DA$dv*BBD@3c

delta 16
Xcmd1H<8ln}bk1X7U|_77$dv*BBDw?a

diff --git a/tests/data/acpi/pc/APIC b/tests/data/acpi/pc/APIC
index 208331db53b7dd5c6205cce0e95427636b86dd64..868a3432f0295257393e45b75483ef4bec455d74 100644
GIT binary patch
delta 16
Xcmb=Z;BpM`bgp1vU|{Z;$dv~GB#s0m

delta 16
Xcmb=Z;BpM`bgp1vU|{T;$dv~GB#Z<k

diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/pc/APIC.acpihmat
index 812c4603f2701494f6bb761570323158a20d4043..125d1ff0871f772bc8cfe3e2afbff70edf221291 100644
GIT binary patch
delta 18
ZcmZo*Y+&Sa4DfVrU|?WiE}h6#1^_241Tz2t

delta 18
ZcmZo*Y+&Sa4DfVrU|?WiET70#1^_221Tz2t

diff --git a/tests/data/acpi/pc/APIC.cphp b/tests/data/acpi/pc/APIC.cphp
index 65cc4f4a9aa2676140a6525cdac1e838274b1e07..a2c2a24e5e3cf143b57a8932f78eeda6d7b8bbdb 100644
GIT binary patch
delta 18
ZcmZ3$xPXz%F~HM#0RsaAv)DwgX#guQ1XKV3

delta 18
ZcmZ3$xPXz%F~HM#0RsaAqr^n6X#guO1XKV3

diff --git a/tests/data/acpi/pc/APIC.dimmpxm b/tests/data/acpi/pc/APIC.dimmpxm
index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
GIT binary patch
delta 18
ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>

delta 18
ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>

diff --git a/tests/data/acpi/q35/APIC b/tests/data/acpi/q35/APIC
index 208331db53b7dd5c6205cce0e95427636b86dd64..868a3432f0295257393e45b75483ef4bec455d74 100644
GIT binary patch
delta 16
Xcmb=Z;BpM`bgp1vU|{Z;$dv~GB#s0m

delta 16
Xcmb=Z;BpM`bgp1vU|{T;$dv~GB#Z<k

diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/q35/APIC.acpihmat
index 812c4603f2701494f6bb761570323158a20d4043..125d1ff0871f772bc8cfe3e2afbff70edf221291 100644
GIT binary patch
delta 18
ZcmZo*Y+&Sa4DfVrU|?WiE}h6#1^_241Tz2t

delta 18
ZcmZo*Y+&Sa4DfVrU|?WiET70#1^_221Tz2t

diff --git a/tests/data/acpi/q35/APIC.acpihmat-noinitiator b/tests/data/acpi/q35/APIC.acpihmat-noinitiator
index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
GIT binary patch
delta 18
ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>

delta 18
ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>

diff --git a/tests/data/acpi/q35/APIC.core-count2 b/tests/data/acpi/q35/APIC.core-count2
index a255082ef5bc39f0d92d3e372b91f09dd6d0d9a1..f5da2eb1e8a93d961b39f665f2e8b02acf1aeb3c 100644
GIT binary patch
delta 19
acmZ1{yiS<QF~HM#9VY_=^SO;&OE>{I`URQ*

delta 19
acmZ1{yiS<QF~HM#9VY_=<Ase}OE>{I_yw8(

diff --git a/tests/data/acpi/q35/APIC.cphp b/tests/data/acpi/q35/APIC.cphp
index 65cc4f4a9aa2676140a6525cdac1e838274b1e07..a2c2a24e5e3cf143b57a8932f78eeda6d7b8bbdb 100644
GIT binary patch
delta 18
ZcmZ3$xPXz%F~HM#0RsaAv)DwgX#guQ1XKV3

delta 18
ZcmZ3$xPXz%F~HM#0RsaAqr^n6X#guO1XKV3

diff --git a/tests/data/acpi/q35/APIC.dimmpxm b/tests/data/acpi/q35/APIC.dimmpxm
index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
GIT binary patch
delta 18
ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>

delta 18
ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>

diff --git a/tests/data/acpi/q35/APIC.xapic b/tests/data/acpi/q35/APIC.xapic
index c1969c35aa12b61d25e0134bbb8d2187ba42d663..83bd28325af9d6d7619015a9701866b8f3f1d754 100644
GIT binary patch
delta 19
acmew-@=t`zF~HNgj*EeTS#2X%2^Ro9-UT)Q

delta 19
acmew-@=t`zF~HNgj*EeTQDY-l2^Ro9+yyoO

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 66ae44e6b9..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,15 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/microvm/APIC",
-"tests/data/acpi/microvm/APIC.ioapic2",
-"tests/data/acpi/microvm/APIC.pcie",
-"tests/data/acpi/pc/APIC",
-"tests/data/acpi/pc/APIC.acpihmat",
-"tests/data/acpi/pc/APIC.cphp",
-"tests/data/acpi/pc/APIC.dimmpxm",
-"tests/data/acpi/q35/APIC",
-"tests/data/acpi/q35/APIC.acpihmat",
-"tests/data/acpi/q35/APIC.acpihmat-noinitiator",
-"tests/data/acpi/q35/APIC.core-count2",
-"tests/data/acpi/q35/APIC.cphp",
-"tests/data/acpi/q35/APIC.dimmpxm",
-"tests/data/acpi/q35/APIC.xapic",
-- 
2.31.1


