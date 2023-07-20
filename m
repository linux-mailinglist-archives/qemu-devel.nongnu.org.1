Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380875AFF6
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTj2-0002Uv-94; Thu, 20 Jul 2023 09:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qMTit-0002SD-D7
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:29:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qMTiq-0004Wn-TB
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:29:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36KDQjAO031413; Thu, 20 Jul 2023 13:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tDMndnuFEhYSRRm6siCIm9sd6jHp/cUxmqS1+DUPt/o=;
 b=3y2DRwjaRBKc9EmXLqQgsLncv6hYD0gKGteK0Z9QS3iVIrE8ItXtJXG/XhJA/35kgE+c
 jfCrAARm9JqYgXiauIHdh9r+PVjsKJxncFWaShN1CRLZRYS+Xm71Nu40zJCFmGtfBeFu
 7m6Nuyp2MvcyS3LROWEBUgiYQ/lCk79C3E8pwtJ8w4SW7waIHjA0QHAFulZNDgujgwsP
 urE+XqKtgNSJsTa4sZ4so3YErHBV+gxbTIb722e46jxSdEh+FyrnuR/TDJWX7vdYuL2U
 VpWwHBu5q2lDoNOjWsvcU8FY8j9Xu88uP/VXEpMIb8JXatUe5BR+khjEUwwhYQDzpqGb TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run789me1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jul 2023 13:29:30 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36KBw4AC017331; Thu, 20 Jul 2023 13:29:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw8mtsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jul 2023 13:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anZLKqhYGhHPs57N2S/+ICo0TEB0fd4MqJdXwbgDbZBllb2LGzt9c+fnwNSjVHlaR2PQr0ZqIv6wu104B/jcFY4c/bi8bbW/FbFFY/om8kXA1uX7Hqg/SeT4JQIOhQkXHeP/z0ka/XVJogljfLWjHoKNMAIlJIN5aJGvQT1sYcD9Ub4Pt+r/bvbq+DyPqWmc5Nrs6qKGFIRM1HVtNVBCsEuqQulyVEgLLPKk+cLZ2XLh+9DSpN/FcrgQR0f6dfT42u1Ox8um2sTAZqGeX9Vdh7P7wudIlWHtf8lBiId2ZbZSSSEPRp4HR8+qWF8CX4CGh8SEXk0TM6eIabhd9+S02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDMndnuFEhYSRRm6siCIm9sd6jHp/cUxmqS1+DUPt/o=;
 b=B6RjXH4CSdrMBKRBBWnwqFeioD0r9YXkiEBA3xQgfuERnnTyH4F4u27ACPOgP824tdbDUDSvc60SduMRsNnBfLEhhUyma3wBnKAKPi3pn0FMT9Z/J4n52YpfwORN8W0eJclLztEJR2HaYlke8nhIqL3GuvLLCA9MUJ4IGU0Yl5FLGop1SB3hx23fjlPGkB4LID23Kwjpx5KDHGe2ZFY16AQxbmFhujbPEUoscR4cbC8Ytmv5Be9sA5gOfAnrQ05DG+nID0b/yqHVa4USB4MXTJ8vxFEpBZRKY/QbZlYhSjl2rANOfmWDML/a4vcg1UqSZ8SghXV/50s1aDBgpv5QGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDMndnuFEhYSRRm6siCIm9sd6jHp/cUxmqS1+DUPt/o=;
 b=uugxxQz4zkImLjF0jJh6QWbWoynGq6ntIUh2Z+WSpLoHt9+p0u4Q+Vmvm2kxb4KrUgbHIf7XXlxPtvq803olFEpyRhR+IG+/ffPvomMNtNUilZ7V7EPMTX7yD0DXoI78VCRqUK7XP3wT7ADUmYxWkNechKpG0YyiNyuN1/xYMYw=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 13:29:26 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::40d8:4f43:2760:7787]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::40d8:4f43:2760:7787%3]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 13:29:26 +0000
Message-ID: <9380b925-26c9-99a6-2cc8-9a64c143dde7@oracle.com>
Date: Thu, 20 Jul 2023 14:29:20 +0100
Subject: Re: [PATCH 1/2] i386: Add support for SUCCOR feature
Content-Language: en-US
To: John Allen <john.allen@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, yazen.ghannam@amd.com, michael.roth@amd.com,
 babu.moger@amd.com, william.roche@oracle.com
References: <20230706194022.2485195-1-john.allen@amd.com>
 <20230706194022.2485195-2-john.allen@amd.com>
 <d4c1bb9b-8438-ed00-c79d-e8ad2a7e4eed@redhat.com>
 <ZK761jK1wB62T3xv@johallen-workstation>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZK761jK1wB62T3xv@johallen-workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::36) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 929034ca-d8cb-4b96-a70e-08db89255696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NAo07ijWp5CsySRM6sD2b7Kf2iiUIYXW1p1ciI1uAWpZGpliW5MaIT3WXKGgy6Yiv4jVt/SLlrvh+ZrvJvGOqNNtvYLyydU4/dJzpVeBmSMJm6/Ez7JiGRgxARme+PA7CDkUXZqu8T9viX6fvJ6wifXyNHHBWIcCf+WXcron59ldiceaaMhAbuJjkW+ovXb0hJNUGOtzaUJBiXLUsvEBvYolzWj+4LqIc3IBVKyATrEp8LgN8BMgf5mUcx66MXt5HX5ShlU9XTZzcCggK9301Ychgcm8vnCn62G7qhUqunqetnvXVig7EtsjAQGYoyzjtMBOme2ZagW4Xqk61jcjRbtfC5M98e9BaaRgz11X9Yv2QaVzqkW/Dl/XhvNdjNrsc6wgbhhYE3IlPKoV3RNE3bfZG+Q9/h0eby5Unz9Qo3r/OrqzW7b6LCt4HTEa8qVa+ZZaHa5gq1FsSx0VJ2vZmoEjy1AzaC0UVKylgZdNC0s9vjw1a/YOj//+AOhWnBalfi9gsquwoucKRKyCBagpvej05a16kdCF/sKg3JJVEO1eZ9hxrvkfd6kutFgoLYfS9zvpkgc1N9+0Q8dcezva/BxokWe1ZG8MB9N0yEtVJnmG00vvWOV2aSV02w/46JW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(84040400005)(451199021)(31686004)(6512007)(6486002)(478600001)(38100700002)(186003)(53546011)(107886003)(5660300002)(6506007)(2616005)(6666004)(83380400001)(26005)(316002)(8936002)(41300700001)(8676002)(2906002)(86362001)(31696002)(36756003)(110136005)(66556008)(66476007)(4326008)(66946007)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MndKcEd6NlpQSkI5UERTazIvbGphY0Z0cmxZeFhTNGpuR2Z4YWpPeGZZcG5S?=
 =?utf-8?B?VHhSa2VFMmtEMUptVzI0WEdaaUFKL056QUlST2FvWHBGMU9CVGxXcUxyVXNp?=
 =?utf-8?B?Y0dYV3Yxa2FXbk0vUEIxYUpvL3VDd21VV2dhOVVud0dWWUFiRFBPS1c1UnJL?=
 =?utf-8?B?RG1URm16VUlxKzZGU0xiOWw4NVFpaGpmWDhCcEd4NEk5NEV4cEh0R1h6dzZz?=
 =?utf-8?B?anA1WG0xU2RUOHNKdGZVMXZ2V3dEU1lRYiticFZYRTB6RVhZM1dmZi9lbDM0?=
 =?utf-8?B?TC9CUzZxbCtUMFpkSlJzVnZPT09GN0t5L09jVjdrUm1HZkdzRnMxVlRrT3BS?=
 =?utf-8?B?UmJXOEgzWkFFQmdtRHRsbmFBSTZSV09WcFNieFJUSUVaRTZtMVBZMDZnQXNT?=
 =?utf-8?B?dCtjd1pXTlJzckhuKzh2cmR0U2tpSmFVNTRZbFIrZEVRL3BIWk9FUURsaW94?=
 =?utf-8?B?eG5lZWoyN3cwa2NDbGFaWC83TmYrSGFPRUg1bUwvNlBhN0kyc0taU1A3WEJP?=
 =?utf-8?B?TGNRdGlFdW9OQ2JlalhjcGFrdUxpOCtiNkdPK1EvWElOMTdDYi9tdGJRR0ZM?=
 =?utf-8?B?OUhaVmpxTktYYUJ2bEV4Vkpsc0MwUkI4dGhuSDJaQnp5RTZMcHRvMnJuTXZX?=
 =?utf-8?B?Y2JqK3lUU2JkcG5YZUFxZEhCNXNFMmhybUZ4b3MwMG8reCtXRFBQNmZmdC9U?=
 =?utf-8?B?L1FNc0dQNlB1U3E4YytHMVN4OTdqZWdWWTFBVUw3UEt0Sk80M1B5Ym0wRTh1?=
 =?utf-8?B?M01uVTltd1NlL1RTNGpoNlR3VkpnTXFvR2FvUllmT1BYT0dxSE51M1BNYWFt?=
 =?utf-8?B?RTladEJNK1cwTmZ5SjZ6dzRaUVBHSGxTZVNaU1hFUUh3cUs3Q0tQRUU5bGhW?=
 =?utf-8?B?Z1hmZFJmYUEzQ1V4RlprTDE5cFpzeEIrYTJMbWNNZGVuRStWQndVR1RlbnFS?=
 =?utf-8?B?SmVxRjBQNGZCclpNMzIrYU5YY1ljdXZ5WUtPWU9YNmJmQW4reVh5ZmRiSVVB?=
 =?utf-8?B?d0RRNDBNL3RtbnNIakxKakRkT1JCSjgxVUU2NmpTSTFFeDNBNndtanBlam5L?=
 =?utf-8?B?UXNZeW1GYzcxNTJuS2Nub3l0YTAwOXZ5WGY5Z090UFdhbTUwenNhbkNaWnE2?=
 =?utf-8?B?M253T3IvNHZIK1pteXVKaUhOVGcvWUhsRW5HUTNxQ3cwelFGQWRmbnl1OGlF?=
 =?utf-8?B?L3d4ZkFFajhxMWpRWnQvdEY4ZEQ0blJPOEx2Wi9SMk9rdU94NkpldFhraith?=
 =?utf-8?B?Y0ljN21hY25ENFU5UFU5eVVabVE3ME9CWUZjanVoL2xJWEhqU09DbVl3ck0r?=
 =?utf-8?B?aTRhSHdjV284SklMK1U2SmlhMy9KT2c5K1U0YXFKNmZ1MWZYMzdXTW12Y1Q0?=
 =?utf-8?B?ZExhdkpSdldTNkdKWkYzWDB3aStiemRaTDhoczZIQUc0alN3U1ZxODMxNHBn?=
 =?utf-8?B?dUVYbUpSbjlaQmpla3VKQW1PbVVoTEh1am9WMmxKSjFlZWhGTlEwS3FNR0xk?=
 =?utf-8?B?WGlRaVpYbDJSZ3FIdFp1RWhiSVZrajJHWmQxZEY1Wk9uSm9tekdaYzIvOHoy?=
 =?utf-8?B?YzQ3cXJRSzhLRWswY01Mc2pteVAra0lqdHZ6TUFqVVhlV21ydnMwWnVjb1Fp?=
 =?utf-8?B?MlhXTkZEY00rbHBRYzRFRjhlSUNiaHY2ZUpEdkovNWtIK0NlNUIzU1hNN1hR?=
 =?utf-8?B?amtQYmNkVGpHV29BYjRWMklXUXN3VFFkQXhKSGFKVm9TWHBGaFl0V0l3MHpr?=
 =?utf-8?B?WW9OMTFKbld6V1ZXNzBndVVhUndaUXE0U2NmSExjb1RObjc4WXV4YjhKcTY1?=
 =?utf-8?B?clY0T3g3UjRPNDRJOGZrbkxwK0VCRnR0SG1icGtzK0hJVHRPZjBZc0VIWVNK?=
 =?utf-8?B?am82d054MTVLTnpnTkpCWlVuSTZ6Rlc0dnJQOFU3NHNTWHpTNHY2VVZBVnlk?=
 =?utf-8?B?SFBwK3Y3OHV5SFhqcVE2M2ZSaHBSUzQzZXN5WVNPQm9kMHdKaTh6L1NNTmZw?=
 =?utf-8?B?STVNTnRMNHE5Z2tFb2tBOWJ3L1EvdFhKUEtXRzFWTy96N0RmNXpnem85NlJk?=
 =?utf-8?B?LzhSTHFEaGFiM3lqUEpydXRmNFhLVFNOUVBTZU55TWNVME1BYzQrdElleWJw?=
 =?utf-8?B?SGJYM3JTWjMyS2p4Zm1VK2RjTFJod1d5Z0xCRCt1eEFTYXQ1cXhYNCtYR1h6?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1aSg3GUe1Q2d+bTtOTeUj1ts63/fmzXMHYpZNnuYIg909agwWqQU2GY18ZlcDhMt8XkqA6gpgO5j/tUe32QInPC9rQsql8KNklWBg7Sl5/QtwEtZEtdKTma6PfFaSoBDnCdhcNA340RWU0lad+lpuUnu4r0byzYcj6UVS6Huw9zBz93wcw4rXwrs4Ze7vxIO8Og+2d6JIBwhNkj5IxB/x2I+0/IcMSIYaz1adLm0uzsYtKDs4WxhogEIMNQMtFs6OLslmQKYVevquX0b1h2v3HL0+x9blAyK0iIJoV93klacKn80QsA9gyApjIEAEny3tMmUlr3Uc9lsJ/MFZmyRhU7k+ba3GCpIUrjrAIyfKLMZuLsbRb8b9mrZ9ODACNZ7xNyGLh7sLjYzVMgJdScw2Plsb5euO0SQ5sZtNaEzdY95BCuoC5OQ9epPkm8aefemJTrWrBPr8qy8mJMf5pgZ21NdNDB3QYdFRVjPg0PalO1nFAffz1r17o4kxbYupKN0gBaYk/i6EYDSOb+9KoXm65dhysn4+yozJPQ8PIyEmsWxrH7J6GutmB+occ3ys4Kp/u772vfprDoFaBEE8DdWvimMiakRIsFjejaR49rDnRVLXCFqIiy4eYIukGibEIsqYVvZ59tz/ZpHUVf8RCZ//WHNOzp/RsNYSRKb3GBC+PtBqqyoq/lzzAbcIehgrHjAhQVPY9b6/m8bEpuNWcmjf8gE9egrtq8CYzCVkXFItYqfjWQeOm5XydVp/wj90gb4VUK9zNZXoSvnuydwPs+jRZvaoFrgXdZKJ1ng2zwfKcw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929034ca-d8cb-4b96-a70e-08db89255696
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 13:29:26.4447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvjWUNalsUwfhxf1sClwPkqEAhghNMZ4WxUZvAmIsBi/NAifJCoDb60lyZoFXyb5fQ5xoeYRxHZJ8Ab3H5FP7nE3CwQnZfr80LwMoGRJFlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=840
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200113
X-Proofpoint-ORIG-GUID: f1QVIzIRE0BOG_BwpGt6sEWtwc4-nlvr
X-Proofpoint-GUID: f1QVIzIRE0BOG_BwpGt6sEWtwc4-nlvr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 12/07/2023 20:11, John Allen wrote:
> On Fri, Jul 07, 2023 at 04:25:22PM +0200, Paolo Bonzini wrote:
>> On 7/6/23 21:40, John Allen wrote:
>>>       case 0x80000007:
>>>           *eax = 0;
>>> -        *ebx = 0;
>>> +        *ebx = env->features[FEAT_8000_0007_EBX] | CPUID_8000_0007_EBX_SUCCOR;
>>>           *ecx = 0;
>>>           *edx = env->features[FEAT_8000_0007_EDX];
>>>           break;
>>
>> I agree that it needs no hypervisor support, but Babu is right that you
>> cannot add it unconditionally (especially not on Intel processors).
>>
>> You can special case CPUID_8000_0007_EBX_SUCCOR in
>> kvm_arch_get_supported_cpuid() so that it is added even on old kernels.
>> There are already several such cases.  Adding it to KVM is nice to have
>> anyway, so please send a patch for that.
> 
> By adding it to KVM do you mean adding a patch to the kernel to expose
> the cpuid bit? Or do you mean just adding the special case to
> kvm_arch_get_supported_cpuid?
> 
> For the kvm_arch_get_supported_cpuid case, I don't understand how this
> would be different from unconditionally exposing the bit as done above.
> Can you help me understand what you have in mind for this?
> 
> I might add a case like below:
> ...
>     } else if (function == 0x80000007 && reg == R_EBX) {
>         ret |= CPUID_8000_0007_EBX_SUCCOR;
> ...
> 

IIUC the thinking here is to cover a hypervisor that doesn't advertise SUCCOR
via supported cpuid from the kernel, by adding that elif statement above.
So when a CPU model is configured, the filtering of cpuid leafs logic
takes place, it doesn't "dissappear" when the values from the kernel isn't set.

Otherwise, if it's advertised by the kernel, everything goes as normal in this
filtering logic and everything works.

This presumes that you set "succor" feature string in the CPUID model definition
instead of unilaterally defining it like this patch. Such that only AMD CPU
models advertise the feature instead of everybody.

> If we wanted to only expose the bit for AMD cpus, we would then need to
> call IS_AMD_CPU with the CPUX86State as a paramter which would mean that
> kvm_arch_get_supported_cpuid and all of its callers would need to take
> the CPUX86State as a parameter. Is there another way to differentiate
> between AMD and Intel cpus in this case?
> 
There might be an implicit convetion here where the caller is the one selecting
all the bits -- so kvm_arch_get_supported_cpuid won't care to validate which
vendor supports a given bit. Usually steered down via CPU model names (-cpu
Genoa), or named CPU features (-cpu Genoa,-feature-name) e.g. Nothing stops you
from trying to use a Intel CPUID on a AMD host. So the IS_AMD_CPU inside
kvm_arch_get_supported_cpuid doesn't seem to matter

	Joao

