Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B93AC73DC1B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDjJP-0000jC-6s; Mon, 26 Jun 2023 06:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDjJJ-0000iP-QP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:19:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDjJF-0003jU-S6
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:19:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35Q9Vfs5004043; Mon, 26 Jun 2023 10:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=XLrkyHVscnZXFZrD/+T7QYyK0cNHBRplFRyiY6OpqB0=;
 b=FgAknXZjLiTdQ79l/YFJibWPKUaJ2hIduYAuBbstxFb5tTQ10U4E7zLbJyCOOs61I9PT
 LlZbJ2C88zFzUc+cMOawKDKdo+dp21lkZubqDYKnlT1PTkQ51dpaFh3jFBvG7R3nZXQ5
 1GpOxGjApHuP105Ra2cfYRIf7s+PPtflkwvT1rjXUbqQfxjFJAzqExZLmMl1CRBdxBLQ
 eg+iwg+PGoGIfbVmBK4Mj/wRnsKcEef+jrhJNXPluiDHKtohMDycO2QaDs8ZAFagvDH0
 ZttkeHnE6zguBTMfHRNL6uk6xQCo23eIW76/vrIPvPGUJanjKPCBiRNyn4e0aPkA9E7T xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30tdyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 10:18:57 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35Q9ZVpa011149; Mon, 26 Jun 2023 10:18:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx2vnsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 10:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPDAMfdPgeEU6AOUfSoZQOefX7x/Iz+L1XBBEHyVAj7OMKZO2HeeiMdvXcwLh5Ji+vzUBdGF4hq7HlW88lc8ULU/CNiNh5va7iBztWwKDJwJm3RjIcOJb59Fqk9tAp5Ol7svcAlT9FeHReLNtdxK0hhUJvPM2S9TePZWUKEmO3LzSg8Z5LGAWfHg3JhGpQgNTc1r1VIPe2OUVL4c5pKbNuLuJZF+o/ptvebnrp6GtA30hgGCo/g+rwq+rrg6e4DQIZJaq6V0j4A6JZAodfx4XEO4Up0Kf1Cyth7AixNonvpbm6Fw5fKpxiECOZzjE13W6cqaxrxjAo0U1wEByjeLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLrkyHVscnZXFZrD/+T7QYyK0cNHBRplFRyiY6OpqB0=;
 b=ivQfH3bKKXpUcGVFMhfImRYVsurSmTlWAMOJ8rPazZtV3d38GBhaXl8/5oBemLLoS7jsuGLs9ha1U+upUJhjYoNzguI5qS6WlP70lfQzqtd3tjfU0rMWS5i2jYs8PPd/U9iLa1YAGdu7S0Pywfhx1SPY8nDWPWXUV4kfMhkUj2upvj/eVAKPl078zpNg18Cqb2YcQHU+/kHA4IP+11Tf/DQkYgAdd6Yg3YW/qp6lp3edhrw/hruC1M7sCDNrLuQGcFQpWunVKQjHJJIG+Djcz1KPFXaJlPYJ5h7W8a0aS0Ff/rezhw/UyzKCaUXR9CyYlz9sa9jRDTB0lIQzK55P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLrkyHVscnZXFZrD/+T7QYyK0cNHBRplFRyiY6OpqB0=;
 b=kMgAegwUALS6lAidxo+JjH8lALmwB0oqr1SI8/JgkVYGVqfJbAqe3xJhMjLx/ucq7fVKpFUwUG4+ZWmLjw7bS8LEetYfYo68NreA9soQXo6leoNCSM8Oz5wDxhWHCI8kEdYlZkt0kQsSp3xIIJ85nalG37hL2fuJ82j6npg91q4=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 10:18:53 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 10:18:52 +0000
Message-ID: <3afe5106-414e-5a3d-4a15-3992f80fac5b@oracle.com>
Date: Mon, 26 Jun 2023 11:18:47 +0100
Subject: Re: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, chao.p.peng@intel.com,
 qemu-devel@nongnu.org
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-4-zhenzhong.duan@intel.com>
 <c8583433-9b9f-4380-8076-8ca623b66770@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <c8583433-9b9f-4380-8076-8ca623b66770@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::44) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ2PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca73a10-7a75-42d6-31bf-08db762ebdbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TyoCnxlVijrAVW107T9GPWPqtLPEAnVnq++rSGm09znlFEimytUW4L55OOBME4N5jSFd+VJMrdUEd/xNkbVerlDF2U3T/U+K7ku3gozLP5//0VfAkqLWLKudh4a6kt7r0XmiOJDRG/h3iWULkhL5ZEAx9h5Pn+RgeAPrXDDYSxSZoffJlERQ+w0FEjn9VkUjfE1VJLX979WRf3H2R0IRCXfQ8VWO6XW0BMLoeLoQaP405OygbDoQnwUacXiueEW4BdX46sRduinMVXg5jNWYwqoW29dxTEZRQiAArSm1c4G8SotaDp4ES/cYFix8a4fALMpYnd2gdw5cplNc9pGrufnuQUHR04lMrl7d7mVvNHQ2E6WxnWUhQs6XsKiYV+jOL7ufbO8CAJ+X7Hz1ICdbWKa3c8oLDUhbaz/hQwDXrtc7Pv5LBcy59S43+Q3k8LUHBIoGZ19E/62YQSubJT0Edpf1Rnl7pXRu8Kxnd/dI8qhFmtwvrfP/rMS+wqXN14yHJ33ZBKJaEVRN8sXXwCSCdaB1dnsCCJORND+paau0lBJFtMfIj34XgYUYe8Sb/VFMobnv9lEgA6z9/ylFfCTY1Onbokw6lujPlgzhfEd7+fSC5tGCNXmvTr2Uyt+U5ax
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(2906002)(6486002)(6666004)(38100700002)(2616005)(83380400001)(6512007)(6506007)(186003)(53546011)(26005)(41300700001)(31696002)(86362001)(110136005)(478600001)(316002)(66946007)(66556008)(66476007)(4326008)(8936002)(36756003)(31686004)(8676002)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9FUUtMOFp0bm0wWUhaMzZvU1VIWWJ5Wkg2VzJrRXJrM2ljRWFiTlFpWFRP?=
 =?utf-8?B?enRQUkhZcUJ3VHA2Z050Y0xqMzBwN1pwZmRNeVM0MHVsQmVRZjhHSUpZWXRt?=
 =?utf-8?B?ZmlvQXBiaHI0OTNiWkFqdGM0b3luTjRxRHdiNUczYjQ5bmE2RE5KNnRWMlRM?=
 =?utf-8?B?eDhqc3hIaGsyTDluUFVEcTFVZnhIVzFSTnlnYUI5clRUNWVsd3c4ZiswcHNq?=
 =?utf-8?B?ZFd0UXpLVlJmUUJvdmRMd1F3MHh4VEdEOWI5M0krMUg1djZ3aGdjL2hYQ1lQ?=
 =?utf-8?B?UU9nQkxXNEtUZGdOZHdxQk9BcVVwcitWUE1sZkV3VC94MlZnWFE2VmIvVDdX?=
 =?utf-8?B?dkd0cDUzOVVGb3lLaWdnVXNyZ3BmSWtiODczZmdjZ1Jra1Z6V3RaRm5rWjhY?=
 =?utf-8?B?eGEwOE80WVQwQXl4NFcxeTJ3UzV3Nkh3dnQ0NmltbTZrZzExNXZEMzNXUENS?=
 =?utf-8?B?cUVLTHZsSmUvNGlOTXFicmtrZG9sajk0WW5TdzN1L2VVclVhRVV0OCsvWEdW?=
 =?utf-8?B?M3J4cWhYd25MYVo0RGFJdmpUak92Ui9hOXpPQklEaU9CZGlOb2lnQTdidjJU?=
 =?utf-8?B?UDhtOU5Hblp0eFRUTm9VV2ZQdDlSTHoxWFNXYlFlWEw0MFdvZ0hxTUIrcndj?=
 =?utf-8?B?Z044U2lIVFl4dDhMUWxkZ2lNcUFRaSt1UU1zbUJVRW1GQlZYbWdoaFl0STFq?=
 =?utf-8?B?eUZJemx3aGlTYm9GTXlVUVFPYW4wZXNKRjJocHdMWklZL0tGVkJQczBJSUlR?=
 =?utf-8?B?WWdQTG04Q3NyMjFVbmdLbG85dXFpRU5uYVJqUWhacTErRXVVL0xwR3pUOWxw?=
 =?utf-8?B?VHRjcjM4TnZvYTZRK1VNMlI2OXlkMmg2OFowM21YdHo5V3oyOUdyTVQrN1Bv?=
 =?utf-8?B?L2o1aVhEWkJoMWxpb21HTVp5MGdQU09TVGNSNnVxaEV3TUxDWHpJSnQ3Rkcy?=
 =?utf-8?B?NDNTMDkrSU9YakNNamhkL3gxZ1k5WkhoYlY0TTQrY3VDWThqWndycHQwUWtV?=
 =?utf-8?B?QTJnWTRvRVRtQkFMUmhyUDg4d1dTTVF0SXdnYlVDNlhqbGtqemYyMWhqS29y?=
 =?utf-8?B?SEdDUkJEOEhvMnlmRzA2ODExSGxjbmpYMjhvRkJ1U1FlQ1p1bGVWMlZYa3VN?=
 =?utf-8?B?SU9PUmp3dkpkdkdvT1RFSEpzNVlnUGdnMW1rVi9hcFB0elF1Q3lwbjlzRktx?=
 =?utf-8?B?RjgrbFIyeHlMa0x2ZkZJZUFDM29SQjhPYVdHelNXWWxrNmN3bHdMdWxLUW9X?=
 =?utf-8?B?Um9lbHhLZjNvSXZnYWYzdDVyWUdzdVJOakFqTHNOUXkyV3J6RUxnVDJUYzBE?=
 =?utf-8?B?M3VBdFNheFlhMStXbmFIOGg1WnM1aEd2b1ptYzEzRCswaHl0d1U1RU04Y1VS?=
 =?utf-8?B?bXlobEk3UDJWSmliR1h6Sk16NTFvTWdmd1MvMXFMUTloL09oSEhoQWdxOVRC?=
 =?utf-8?B?NGpVcHpvN3BjeEY5N25zWW1NSlJYNm80MDZOWEdvSFR1TFRBYXpGVHR1WWYx?=
 =?utf-8?B?Q1UzNzZFbEJxaEdGbkZ5ek9HM0pQQW90Z3l3TEN0MTNoL2V2K25kY0t0VmdO?=
 =?utf-8?B?cy82MEc1a0RpandFeW00VzBGYXdJcG1zMXZHK1pHS2hxeUpCcVhsd1pyb1NI?=
 =?utf-8?B?R1BpRVlHWldBL0ZXZEhNZlk4TlJRUFlUOTB5NkxQeEVEZ2UvbitQZVJxb3Vj?=
 =?utf-8?B?WUhOU2RNbVJiaUxZeTVHOVp5Rk5QTTRuWW9acW83cEV6OHNIRTFZSml1dGxj?=
 =?utf-8?B?bVRSd1Zqa2JkY3lUV25DN0lDeDRWYWkxT011KzlJNGlVdEhwTC9WTEdaVElI?=
 =?utf-8?B?RGNqU1V5ZEtKaFlJS2t2cHhOU1hPNjVsNlZFUWJMa2gzckRCdTBxeVFzblZU?=
 =?utf-8?B?ZU1XU3hCMTgvRGhhMGhlMWJlc1Z0WmQ2dE1VSFVGMWtCeU1sbHlmd1F5cDVB?=
 =?utf-8?B?ODF1aThSWXR4Z0tjd3l6ZnhuNjB1OXY0MEVHRmpXb0J0UFdhek02Zkk4d3ZV?=
 =?utf-8?B?NWIvK0l6WDJyK3ZzTW1QWEV0TldkRFAxL0JqUVJjaVQyZnhwU2ErMHcva3Mx?=
 =?utf-8?B?R1JUVHBSUjNxV1Z2QUM4a0k2VmZkVnovQ0h1dFF6dHhQRFBHRlVwR3pmUUFh?=
 =?utf-8?B?RWZkbHEwUzQ5ZkVyUUkydDRQZk5UaGkvV0dSaWtVWU4vSGF2WlpMcGFIU29I?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tx4NzfFPuEBSLfQ8/dN7ZHTILh0nLvRA+ASyle+2xEqzGPdAhkd17TcbBdzzNey6L9p9Yep1aLrhJyS9BGten0Z1vHucnkInvZR4RYf0NahF88q6ouKCkYusfXnjjCbZfPqUAFeFqfN6betFelGAQTNtt3ts8WOIwwxQvWWzTY/GLiKv3XKBe2uCLJVue1aqUZqXudt3kWUZAsTyUtdC+rfdjIOJermu7CpDNv3WyM+/blMu/R4/23e9KSWc7qFrzOaaYHB39qJsd1elx7ZUTwrj78ZzuA2BAcBK6V394ss8RYAt2o+mW6gwsZKJxkyIVMqkZrx0lj2ZZUXEGLzAbZW+MS9m78chrc+m4BYMOARyOCsj3MnI00b8xmxmgSxzhkxUaNiKP/3MdnjZuTl5TqnfY9kf8/h6VNN750PkMqgVeHrIzcmtmjQNS2y9eeHdoK4MP+84qRLR/ci6ELK/U5Ja13PlFfbHxFK1LGUgjOgL051J/BCU4xE07acW238bpphKvrYepMs6WsdPXJev6YLZkCbsN+NbFDohSnaEaV/MPsUaAz3CQT8fEXQJBt/0xwl8bcOQIYz8DAfvS+W9BXSxs8JXUnEqvTNYunNptYZMPu/TkYXHxyK02319SiOkTtf1r4oh8KltUwHRbA4h7y7Mm6qEolq51Y5RPDaMCnkO6v1fvzb1SwFjs2eV48/7qPP/wyzuq6cUUV/3Puu5+Xawsa5cEmZMP3UQfW65aThBtgSdBzAsmcdZ+ciZTQU+FSHvwmPStI9HLf8gVde4GLJnh9By1tAbiJo2zpp4It51tbyKDKl0eqsqjHXSvPNUJwjLUJ8nGR7DZf+7S0Tx1A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca73a10-7a75-42d6-31bf-08db762ebdbe
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:18:52.8755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If8havzVbm6RuhFWVAiXTwU7ECpmbwpTVMswMQCsob+MBjvvlITKtfi2XhIDIATrTPm8o/B25A8IQvtsUNaP/mrcgdE8De/NKqGXFEJDcbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_06,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=917
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260093
X-Proofpoint-ORIG-GUID: bSCkvzSi8bbBbneqsqWDah32xLz2uHNO
X-Proofpoint-GUID: bSCkvzSi8bbBbneqsqWDah32xLz2uHNO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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



On 26/06/2023 10:34, Avihai Horon wrote:
> 
> On 21/06/2023 11:02, Zhenzhong Duan wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> This patch refactors vfio_migration_realize() and its dependend code
>> as follows:
>>
>> 1. It's redundant in vfio_migration_realize() to registers multiple blockers,
>>     e.g: vIOMMU blocker can be refactored as per device blocker.
>> 2. Change vfio_block_giommu_migration() to be only a per device checker.
>> 3. Remove global vIOMMU blocker related stuff, e.g:
>>     giommu_migration_blocker, vfio_unblock_giommu_migration(),
>>     vfio_viommu_preset() and vfio_migration_finalize()
>> 4. Change vfio_migration_realize() and dependent vfio_block_*_migration() to
>>     return bool type.
>> 5. Change to print "Migration disabled" only after adding blocker succeed.
>> 6. Add device name to errp so "info migrate" could be more informative.
>>
>> migrate_add_blocker() returns 0 when successfully adding the migration blocker.
>> However, the caller of vfio_migration_realize() considers that migration was
>> blocked when the latter returned an error. What matters for migration is that
>> the blocker is added in core migration, so this cleans up usability such that
>> user sees "Migrate disabled" when any of the vfio migration blockers are active.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/common.c              | 54 +++++------------------------------
>>   hw/vfio/migration.c           | 37 +++++++++++-------------
>>   hw/vfio/pci.c                 |  4 +--
>>   include/hw/vfio/vfio-common.h |  7 ++---
>>   4 files changed, 29 insertions(+), 73 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index fa8fd949b1cf..cc5f4e805341 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -362,8 +362,6 @@ bool vfio_mig_active(void)
>>   }
>>
>>   static Error *multiple_devices_migration_blocker;
>> -static Error *giommu_migration_blocker;
>> -
>>   static unsigned int vfio_migratable_device_num(void)
>>   {
>>       VFIOGroup *group;
>> @@ -381,13 +379,13 @@ static unsigned int vfio_migratable_device_num(void)
>>       return device_num;
>>   }
>>
>> -int vfio_block_multiple_devices_migration(Error **errp)
>> +bool vfio_block_multiple_devices_migration(Error **errp)
>>   {
>>       int ret;
>>
>>       if (multiple_devices_migration_blocker ||
>>           vfio_migratable_device_num() <= 1) {
>> -        return 0;
>> +        return true;
>>       }
>>
>>       error_setg(&multiple_devices_migration_blocker,
>> @@ -397,9 +395,11 @@ int vfio_block_multiple_devices_migration(Error **errp)
>>       if (ret < 0) {
>>           error_free(multiple_devices_migration_blocker);
>>           multiple_devices_migration_blocker = NULL;
>> +    } else {
>> +        error_report("Migration disabled, not support multiple VFIO devices");
>>       }
>>
>> -    return ret;
>> +    return !ret;
>>   }
>>
>>   void vfio_unblock_multiple_devices_migration(void)
>> @@ -414,49 +414,9 @@ void vfio_unblock_multiple_devices_migration(void)
>>       multiple_devices_migration_blocker = NULL;
>>   }
>>
>> -static bool vfio_viommu_preset(void)
>> -{
>> -    VFIOAddressSpace *space;
>> -
>> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> -        if (space->as != &address_space_memory) {
>> -            return true;
>> -        }
>> -    }
>> -
>> -    return false;
>> -}
>> -
>> -int vfio_block_giommu_migration(Error **errp)
>> -{
>> -    int ret;
>> -
>> -    if (giommu_migration_blocker ||
>> -        !vfio_viommu_preset()) {
>> -        return 0;
>> -    }
>> -
>> -    error_setg(&giommu_migration_blocker,
>> -               "Migration is currently not supported with vIOMMU enabled");
>> -    ret = migrate_add_blocker(giommu_migration_blocker, errp);
>> -    if (ret < 0) {
>> -        error_free(giommu_migration_blocker);
>> -        giommu_migration_blocker = NULL;
>> -    }
>> -
>> -    return ret;
>> -}
>> -
>> -void vfio_migration_finalize(void)
>> +bool vfio_block_giommu_migration(VFIODevice *vbasedev)
>>   {
>> -    if (!giommu_migration_blocker ||
>> -        vfio_viommu_preset()) {
>> -        return;
>> -    }
>> -
>> -    migrate_del_blocker(giommu_migration_blocker);
>> -    error_free(giommu_migration_blocker);
>> -    giommu_migration_blocker = NULL;
>> +    return vbasedev->group->container->space->as != &address_space_memory;
>>   }
> 
> I guess vfio_block_giommu_migration can be moved to migration.c and made static?
> Although Joao's vIOMMU series will probably change that back later in some way.
> 
I guess it makes sense -- the thing that was tieing him was the global migration
blocker, which is now consolidated into the main migration blocker.

My vIOMMU series will relax this condition yes (still same per-device scope).
And I will need to check the maximum IOVA in the vIOMMU. But it's new code I can
adjust and Zhenzhong shouldn't worry about the vIOMMU future stuff but I don't
expect to influence location, say if it gets moved into migration.c

