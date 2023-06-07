Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4F726552
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vYv-0006Bv-3S; Wed, 07 Jun 2023 11:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6vYs-0006BG-E2
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:59:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1q6vYq-0005FA-F7
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:59:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EaM6P006056; Wed, 7 Jun 2023 15:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=gb7lVkrKGIia2bkp0M++BlD0y6yZBnWQi0l8yWIq38c=;
 b=ouRU3lq7Y/0Uy1jl1TxogIMBMTQmkokSlGWTFlqr3uzWB1ZW9QrWptRetNcbvqhnoPgi
 VWPZsCzbkJIIDW9HBUYObGNnPd/oxc71mU8ugaC+4Gs3vj92kzrDU0Z6y3rlC7xvhC6G
 CH5s4k/4+5miypOo8xyG2PTwjeAkdY7P5xmYBWLiw3FoGzkRcJzy5/EaQv8Q6Tj+46us
 Rl0m0vmFBAxEK9CF338ughOgQQP5QC9Te0cuCjUzEwT7L6eRCuIFBLKTItcQ136dF021
 nUUq17LPmgfV8+6BG7VVydk/CLyI+KmWsqini0HWh7fnRz7m/v4ystiZ6q96W/279Q0g hA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6sj63y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 15:58:57 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357EvuMn035892; Wed, 7 Jun 2023 15:58:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6rpxat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 15:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNl8AFAXhXoSzXZLj/btucprt4Ueo/DcmVcewDjIZLR49q/GTGkc0dHXZV3ejLWitoDbVd6a87ayFcp2/IC+a+4Kb3Zc7q+0JNHS36/ZivHWQv9uO4EbxgwCDhvEnNWiH4gWNSVsuudGOoHR5DCtqTM1+HxncSo8QXxZdIxdAnV0iXobaXjDAgexBR7BgOOy/bffHk3hSRUT9rhFG2PahPGIeiBW8+N7WE0H2GinVmJWWJQk3XNL1CKgRuMSLhfQR4j1B+Tr1SvDcq4W1tDejqkL9tSfrAcYBF+UgJ0ovQJu/pclgrl/fpxsLQpOyaX33Tr7CFEJfUuLASeBdlYe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb7lVkrKGIia2bkp0M++BlD0y6yZBnWQi0l8yWIq38c=;
 b=hU8tMDVxy8qn9UhZYOc+uWtdtgSb+Y8IFTwCyTdtC2VHcfLqXUJJaNslTy9jQlhOJK8ykpP/RGdjHAfzgZbd4gNCLxNray94OH0SngHoBEjOEsIrfI+wtjpdgjrtNnDfAfVOQV92+UypoOlGqqXuARvMnj9hc2ra+djmK1PCLr96OoOFQLgpOKMOzTq6PeLd2lnMt6F8ba+TpAwbt6/HWgwLkxE5KLqbSiiw3GTNbSOKEtgMEvC1SZNrN0iq/9d+m/iRFX0LmvgBQcKm9tEMJIfIhODigYfrmWL/lV+1q8TGbmke8gGCBcr8rouyfEofEhHjY03BBLdt/KRfzxUzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb7lVkrKGIia2bkp0M++BlD0y6yZBnWQi0l8yWIq38c=;
 b=fa/+SgFpATPlt1vbxdy0sIJm486ISKByk1pN2ws7uE44g9ItonYY2iLRI9TuRNeOTZQYpaODPrqFETIHPuBsVo9+mqfOV8uY1GPw9M2OkjK/hFVLrB3wbeEHuyzWJW3RF8fHyxj6bKZFTDOmMZoAq+fIpr7dv06CnYG/HQh3BTI=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 15:58:54 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 15:58:54 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, elena.ufimtseva@oracle.com, kanth.ghatraju@oracle.com, 
 karl.heubaum@oracle.com
Subject: [PATCH 0/1] update maintainers list for vfio-user & multi-process QEMU
Date: Wed,  7 Jun 2023 15:58:50 +0000
Message-Id: <cover.1686153256.git.jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:8:2f::22) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|CY8PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa107b0-c9a5-4bd8-1c5c-08db6770180a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QtCNSSAOfgIFTTFcauUpehhPVuQ96lYUJWL5oppmQ0mQwoYygdtCUH1q8eGYwUX6A0AHIbAFblIMPYp/8Bn/AOX0SHLrJG/WcQSFnIQa+5Jpj03H+ts8Zq6rUNdKsGmXdKuR+KOdYxjHugbDj1tj23Gz7MQllI79gsKX4xNt6KokAqmszkcFFBEL7nHW9Y2u3+7aHX2rnGIqadFbCoOFxQ4N6iMyxjoeiakbchzYMdwyG4XShQ2TpEhP3VTsjecw08qsuVh2eB2ogMyroLTi2GNWkAwUQ3TbHz/ll/VQ7r4qO0sXprmuXDUehkYw33KJ4OFPObKnvQIZuc+Tg177IWVTgu41Xw58sGTzHWQ5bhiuxau65dEwPMlzCMWdMQPcXcEE5m1Xpda0dlKUE+FzJvGNhrm5Yohcf1jnPGmJXyKutOKrpT37hpgLpq0IgWBeiMnfOQTHnq+6GR+lUhLu3+DnwsCx/fbZp3ki3Nh9ZWJ70Ebjke5G2NflogJouVIdYwzGssD93jg0YtxTuYjTJ8m+q+Y/Fxy2iTq5KIUdRewbC0sNamuLNN6dyrF1cF8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(15650500001)(2906002)(36756003)(558084003)(38100700002)(86362001)(5660300002)(186003)(66556008)(478600001)(6666004)(6486002)(8936002)(6916009)(66476007)(316002)(66946007)(41300700001)(4326008)(8676002)(83380400001)(2616005)(6506007)(107886003)(26005)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nNnFKEAnlVLEpqOecZB7pG4NaolemWabYWVKbwxN84AaWSxCmCf7BWZT4ecL?=
 =?us-ascii?Q?FclNimxmChhgQhQ+0Tt5GQEwLxktssK7Z1OPGFidXdCErcQbgu3CEFV+Ho0H?=
 =?us-ascii?Q?GESo8SsrluWJNGOTGKlAUiTuNkJVPMPJhn8W2RrFh9X2/D7hhh0cIgn3LKQ6?=
 =?us-ascii?Q?CrUthEK9qtSH5tOs6AC6RQFlbXVWWnW/KHAaxN/KXdIANElpl+LG+8TIqo41?=
 =?us-ascii?Q?carMma0N7OhFN7WpCpmE7Fq2bjp2VBQ1sFDT5cJhZI9cDhlT2XRDYyHQJapv?=
 =?us-ascii?Q?kqVc+NuSG7TbAX4NtGTf90fujfVA4WmqPZNNK9PZ/1Gjc6kCbwg5RLchtByU?=
 =?us-ascii?Q?mhCYm029b2EQEzb36GymUalVZCyVF3UX0RnM0woV8BOhmp9YnPVC5MgFFhHN?=
 =?us-ascii?Q?mZN+XPfITMzV1eDxFhP5Q6ztcr47KSvwTFXoG0PO4dRtdoWmbNshRPvZYZNV?=
 =?us-ascii?Q?fjZt/ANmb6WAXlBwsgt3Q75ZS8CDkfemODV8iCIxDomC9c6yCPwMzS4hoVlG?=
 =?us-ascii?Q?1a4DuhHVeibFQrRD/xvvpQSRyinBd4XADhy7KvTE6FlZW+y6MdHuzuj8UBER?=
 =?us-ascii?Q?O5mkjtbE6T3ROhUtgR/kIkNCFQQQBxeHYoL1HAxAAfwGRHZ5LX3ZmuiPwDgP?=
 =?us-ascii?Q?NnABRE5LfoeeIckNWRwhJzk4h7ubZXo3ORMFfKAo654iqnQUhZ+0D19F//9c?=
 =?us-ascii?Q?nJFDIIVY1FzkXdmCnr6sM9CQEstFuxklQKf8u8bSmCuRpeIooM9gLzrT+HMM?=
 =?us-ascii?Q?dcPeuCSw2iF2gmh16TU5pELZA0KydCEDk9CvG1A19BrQavZJofR1jQAnHD2N?=
 =?us-ascii?Q?plpVxzvAG88mOWtJDsBygnvz0+XnVBnbod8gUOAg8bsdTBm0zEQQ6Sc2iaRa?=
 =?us-ascii?Q?CRrtsDNYFuh/vWzO6mQAWfJ7EU7XIB78LkepIwFzoekxvvAbNh9dtgLGwLqs?=
 =?us-ascii?Q?GklBhKAVMEZriPl1fi4PK6ODoROcgkMX30wLfVu89s5eQ+zjyf1ElILEzhMA?=
 =?us-ascii?Q?dioaAsFrhaOc/pfUQsben+ZqZJwghRP9ZfTkp4ScFrgZqXa3OPbijqNDgmZE?=
 =?us-ascii?Q?1c9DblM725iW32xgvBGkuB1yR444S5j/9YIGUDgUeCYjYbUX7BGrAcJ43koq?=
 =?us-ascii?Q?5fEZpLpMr5UVQ2BX3j0646Xkr9gfjnD5TfoZinv1nNtJIvPR1uU9tRQ1xsni?=
 =?us-ascii?Q?A/XmHHBnm5z0jN2mWuRTZA8+r75qWTRqwbSaWTZx+BXiKgLDLPOH5eGMriMu?=
 =?us-ascii?Q?vujeY2w5bsuHTpmEKvxItSPNSdBQZLrOr4bcPvemWgAi2uXbZy/iprh8dQbn?=
 =?us-ascii?Q?5u6Y3yjMWa2Xl7ia0eTRAWo3yJyIJrlnTHxq+4RNldzh0/RUe2WTc4uYEI9+?=
 =?us-ascii?Q?p5ohMTBJmo+wsI76jMNZDvVVf1Ws8uUgRaUzVJyZcvtqWqzI8jxKE814sFPu?=
 =?us-ascii?Q?OuyoiCrZN2mmYD0KS81AWS3ldmANz5Rfkb0GypMj+4RWn+Kr9NBUrsyC8j9n?=
 =?us-ascii?Q?69SZUtpw+g1MhpZPHxpZB1ZenbWH2VRGAjwb/n96wTsmJ0qy17J5oEMF39sz?=
 =?us-ascii?Q?CsdxpOgl+JesDVU4zrzacq8gbQY0r5pF0SvVfoUI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XS2Q2qBki0UaLU/RkreDzgPe4MeJqSNlUznn4zO/qRrfKs5ZWEhvBxDOPfv1UdE8/kPoEjCo8XP3IM3vPBCrQi4Q+NjyxYyF/Qz/CyPnh0WCjLP4pxXYKocdKC8R+rtMYH4a6XN8bF8RdWbRn70bwIw9IDE7kRlXHSW9RUKNKfNALcF594CUX/zCFYxFJ1VS2AK94q4TURYGcYIQ50N06uaOrMDiAkSo/D2wFo/ig2fGX/XOsirhtaGmYObNia9eygcFtlJiKuy96Xy6R/3zHCikIwvWJ41l1mVBTAnCHlMyxTGcoZ2ydl7hPZS7tC/q/MDuuA2LX7ETwkXUOFl2/zO/rStFZgQj6InfWMMIeF6YrJEZ/hteRwAqNZMPAk9F/OV8lHNJU011Asy502cX5exg5er8v2Pn1yJ9kQaaShv4wqsO+J13PQrfWGCtBpYhBVR/bsYXaYHlzL69RGl9Gvp+5yhJnyowSun9tLdkD2Yv6+ByUKygHMBDNMgPoOymUMQcCGaoa4uWSkcqcJeO5bXX7J63DvPpFvrVvU6FL5MdEubB2ckEqAiq0ACQikzYIEN5lHuf99LZkiGBYbAqbCJlRJdjzLcU+ZLQLYr8x0DgCqQc5exYO4S3xF6vnazls8GHALc/XSKBuVYJRu564lr1vGABQZn2iay8xwXd8M4Foa4GOTDkjEhW6G/fpSanzTFgzA4javhXZx9+RnWiiklwRcfjuDi5Sv9WJkl9w+rlSTIvn4ZHJysqcLOFCs1WB3RSHUuWR/SwBe5zPuyNRA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa107b0-c9a5-4bd8-1c5c-08db6770180a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:58:54.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TUxW31YBczgYozAP3yl7orffx4hBapYrONBDBdrc0PaEdGU14fdJEM5aaevUAI1HbIttRO5WmOmt37D/h3Egg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=775
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070136
X-Proofpoint-GUID: ocpQJIdGdPyBLYuccr_sSwwtSm1GEONL
X-Proofpoint-ORIG-GUID: ocpQJIdGdPyBLYuccr_sSwwtSm1GEONL
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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

John Johnson doesn't work at Oracle anymore. I tried to contact him to
get his updated email address, but I haven't heard anything from him.

Jagannathan Raman (1):
  maintainers: update maintainers list for vfio-user & multi-process
    QEMU

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

-- 
2.20.1


