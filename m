Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516B7D92EA
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:59:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwIfe-0003KQ-VI; Fri, 27 Oct 2023 04:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qwIfc-0003Jp-D7
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:58:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qwIfa-0006jS-8U
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:58:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39R5iJ2r010147; Fri, 27 Oct 2023 08:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kOxcofe14AJo5PEc4qgQzvm/0pf+YhCPEjQwSh9DtK8=;
 b=DtY65lyJLe9jsIhVOQ3fYmJ7nLccRVJfRphEI+R7t4OHFxIRQiLHH7wyFYmbYvJJ47s0
 EFkfHQauLoTpYTPmtPg9gAKlNORWvktmdsYEnLp4g8+/il50Eeunf97JLBxO0vuzUsVJ
 /sFGZsWX5rSlaUytnxGLamL7bJObLSUBNmacNCEpD5tMjx9QAQrDW8JMOxKRYnaEI0bi
 QSF3mlRGkoiD91g61RWNsdY46UGIhAH/1AqLhgosbwlg6Pc7kOcefNXrzd9DSa4Mai0J
 D9TEh6xGA389/iYD3v17XoH6YsmPZUXfpt/ouJpsxzmbgnDBsD4quF9FnIuGl3dtQq9I Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx2191h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Oct 2023 08:58:16 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39R8dixk038043; Fri, 27 Oct 2023 08:58:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqsptq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Oct 2023 08:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvCswlLwf9uOGM5lRirHyOcgSDvApEPzF0jgBCPi9sTLj0suAFU+dQfov5oyUPBQFAW8cXA3iYN8qqExG5j69upligXOMDyy/OytC1V2GjFCwdpTZsyfr6FwqKrcCF8akCYQWrpJ8nliCHeNSXcOWMdHN9ArdX3s0+0AyV3l4fpPy4d4+YXXA4fM7zruqhjcDHyQ8pmT6yagui761MNb9yQzIhwwp4B5SA/sdoRan4lKotS8x42CCvu3eucMFByWMQ1XGPNrqIrPG8zUp1Elw4DoY3M1TDGMW9dIhuJet5iWptzYBj3z1i8VrO8no0WC4NWtA4GFeQHoGEsNqjHKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOxcofe14AJo5PEc4qgQzvm/0pf+YhCPEjQwSh9DtK8=;
 b=BMuHt1ElNSouL6wdhxHQkvPLzrFn8Tb+gn9LlHKw5/eEtqWh3fNwnEZFJTEpiHr0ecVwqJLjC6o76VwYE86uS+1KkFSES2O9DsVIUBgZmGYp0DVfACrrJX21S6hrLjuR9qjZUClMApZy0CoMVpL17Od6GUUrE9uf/EY9tyhloaKcTz4BBWaHJAmyc6BnQQvoc5UYXP/D6S/TsGo0aDy4m9tfqTAYRhGBGUm6AVBA0iYt6Sb7QMs6ecHfRferfcZWHseLo+iLHhpylTmovXujgyo/EUlUgvou1VO5BlyyD11hBDGnvLsIWz1jBbZRQKdsCZrHDwpt0weIKxK4QJzAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOxcofe14AJo5PEc4qgQzvm/0pf+YhCPEjQwSh9DtK8=;
 b=hqE7UsiJPLsendDeQUXrfTfT4M0GvUaE0Evgekz/q3Cu+ZTUE36gxxVG1Tl+fnjA2VTtPEDZGr8UOQp8zf9KH8b2rfEX/aF79Ty9ax4ccr2yi3PIVz1ufT96U9zCqG879QfOGbPTFUFnVQTnfZuuOs185Dqjb8oiVrZJ4Yf3jtk=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BN0PR10MB5302.namprd10.prod.outlook.com (2603:10b6:408:117::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 08:58:07 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 08:58:07 +0000
Message-ID: <af899e9e-a1b6-4682-ba83-6d0267e46247@oracle.com>
Date: Fri, 27 Oct 2023 09:58:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com> <ZTqb/XDnwhkTUL3s@x1n>
 <ZTqtieZo/VaSscp5@x1n> <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
 <ZTrHAbyDxLsDl007@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZTrHAbyDxLsDl007@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0450.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::23) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BN0PR10MB5302:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4b24d1-dfec-4e76-19ac-08dbd6cad66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmhWQ7VHiGBLysvA/0RxNQjgS3ycdzw6Ux0/tzdN00TfBQHBnXkMrA+VcCoOrryNkSfGTRTuzcXSTWX8ZVDSPqUIPTpw/X2zTdST4yWCI8j07mf21BPS2kqEY0j3tvXuzbnxzKzO4A7sDHxv4D2rWiRiB8/j8dl83aUqyuLrI+iR59L86d1zrcILcGk07C9TD/DjIVfcC9RaC+BS0EBKgwCJVkre8ZBUfB/XNoY3RxPDFnYVtCQKHsPv7JbGID3gaGRClbzAdMogH8OJdqq2FYFQC/13UNIZJsTDWL4VL8hCrPISpmP1UclVhw1x2DsTgkVbXuk663Wi8cQx792HkyWia7NFYF/PUc42GJ1XSwAWSwBnBkWFAKhNVZhtRAo4Eih0qPgy6dRcsOsJgQR+WpzahMsjASTWR6U95nxYwZENRy+QgsUjUxaVU5bvvzv77DHlB5u+X0cI3xMwfwofgfSR0FCvb9rBhctWkjQFIFqugelUrdsajYVfKchC3NkJvyfhIVOgZLWflUD7X5XS/ZQGek8pRR3rWY2Gxq7nUw/rsDyzILMC9AwhOmQwfTIpDjHmGdYaFrruhJG5AYpUavR2rg5NJi3TijQvQcAE6Krl9JopgPsf5haA/jAXNNV8pfNsPu5U/gTJjvKEDi2uIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4326008)(8676002)(8936002)(6486002)(2616005)(6506007)(53546011)(86362001)(6512007)(6666004)(478600001)(36756003)(26005)(83380400001)(31696002)(38100700002)(6916009)(316002)(66946007)(54906003)(66556008)(66476007)(5660300002)(2906002)(31686004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXBEMkNaNnFrVEc5KzBsQ0s2a0xqd1d2UHdQeDJuNVNUemxEY0JmNmhrLy9v?=
 =?utf-8?B?TmtLcTMxZmRJL2wrZ1FkR2t4eXgya0ZBeHNSYmJuZ293dFJzeW1TdlN3aXdr?=
 =?utf-8?B?NlZJaStpNndLbUYwOGovK20yWEdHK253OGM2eUkrdmdyMElyRy9oM2lRR3RS?=
 =?utf-8?B?OWw1UG1SQ2hFZjV0bndLNHRTZVprV001NVFpMUJLdHQvOFRma3htTGErcWJo?=
 =?utf-8?B?QURZaTh2RFlSc2RnVjRnS011OHIxVG1lMEFiSGdYMnIxMVUyUzVRUEFSMjdz?=
 =?utf-8?B?ZS90dm5vYlVodFMzL3lnOHM5aVRXaDN3Vm5JMVNwYmwzQ1BpMFhENnMrL2tS?=
 =?utf-8?B?eEEzZDNVcmJSUWUwRHd6emJqL1pTd0VXSzg0Q0t4aXRQeDB1WFIrb2toZ3lN?=
 =?utf-8?B?VWpwR2pQbndvUXl1TG81MXZ3dEFtSWtvdk5IV0VwMnl4VDVtY0RnMmFwdnRC?=
 =?utf-8?B?azZGNTVIZHA4ckJSa1kvUURPUnN4VDVhdUNDa1pHM0hYQXplUGREMDUrS2JO?=
 =?utf-8?B?RkNleUFBZHN2L0J6SkY4NlZIaFNwL0hvVVh1MUt3UHAxL3E4WHpSYjhSM3NF?=
 =?utf-8?B?L0h2NkhZaEJOblgwT0JhbzBYcmFydHZBb3dYUVdqKzNYRXVEdVB0M3l6LzZt?=
 =?utf-8?B?UnF4VUJWbnBiZEdaNDRQV2tJQXZCMk1FVWFJc1BjK3Ftd1BsdGUrWlhHbmNP?=
 =?utf-8?B?MHZtbmlLMmFXNnQ1ZFFsL3BoU3ZBb3d3Mm9raHlqMlZkT0ZJbWNtRDc2YzFp?=
 =?utf-8?B?L3pNRU9KdWl1SGFZeCtsNWpmdmdFSzhjNkV3RTNzMWhVQ0ZpQUU4V21oM3RM?=
 =?utf-8?B?VkwzZ2tGUUw5ZWVCRFhKOGNPdVo4QWZnMTFpMEN6TnZoZFhvOVYvbS9PSzd1?=
 =?utf-8?B?clpkYVh6L0c2ZGZZVlpCdzZUbkpZV1dzUXdYYXc4QXdRTzRuTVd6L2Z2RzQv?=
 =?utf-8?B?LzEzZGw4ZXRjRGVudkM2RDRtVW45VjRxbU1XUVVlUlZMYlV3Rk1MbjArY2pF?=
 =?utf-8?B?YUNFZ3JhckRmaDhNZDMvc1ZxSVJtUXExRXJueGlRTVNvNDJkcE1JdGMyN2V6?=
 =?utf-8?B?T00zT3pXU3plUnpjSkVMcGhFYW03T0JOaUpXWHIxWG9Ea0tUZEhSajRZdE8x?=
 =?utf-8?B?bzFvOHV6WHNCa0twL0xNdjBURnE4U0VCeS81b0pMSlU1VXBLNC9RLzdEQnBP?=
 =?utf-8?B?Q1BHNFRPSEs2TUdyODdJZVNKdWgrajFyQ0E3WTBxTjltN2JWb0VMTkg1UGZV?=
 =?utf-8?B?RDQxMS8rT2FsQW80YjVxN3h6dHNrNWo4bEFUU1JraGdRVUd4T1VkcGd1RUZS?=
 =?utf-8?B?OWdpRzk0RFoxMlFBTnBobTU0dW9KVzFSd3pQLzg1ZmdFdWF6dnk1d3p2SkYy?=
 =?utf-8?B?WTFaOHJQU2xmTDVteWladDhSOUJxczRPMHdXUElOVEJQVkM2ZnBjU00rTURU?=
 =?utf-8?B?eW5ZOEFtTWpyT2duYnJ1ejRFcUhhd2ExYXhiTER0ZlNmcWtnaFJhNmhqSWV0?=
 =?utf-8?B?dkJ6WjRyZmZWOEhWRlN2ak9lS2Nkc0Yxa0QyWkFMOXVyTGtoWFZmcVovV09Q?=
 =?utf-8?B?N2xvTnpTTllUYkdFUzNEQkFJTXNoV2hBc0pwMTBYbkdtcWcvVEcrTVRkOElk?=
 =?utf-8?B?Ri96WmZndmtYczZhZTBZQ1lCemtQZE5OdDZGMVJPQ2dSc0EwNllRVTJGQkNM?=
 =?utf-8?B?SWlRUFBaVFh1K2RYS2o4YWtnVDVGZit5WklMY2l2L3gzSUFuc2k0R0VHZURk?=
 =?utf-8?B?NEhmVVhRcXptbDd5RGhUdEhTTWczalAyMW1wN2poT2dSUzM3eU5ZdnZ0c0Jy?=
 =?utf-8?B?N3VlYjNselZqQW1sR1UyWkhlMUF1Y2d0Y3VPOUtmQ0VOd3JkdEpHVFJocjlE?=
 =?utf-8?B?Mk1hNlVYbS90N2FiZys5K1V0WlNYRVUrY3p0NGRHVVA4N3Q5NTNIc3ZRR3Zq?=
 =?utf-8?B?U2p2WnJsaTY1RkpYVDV0dEl6dWtHb0s2MTd2OXpWMG5GMno0NG15YXd3UEwv?=
 =?utf-8?B?dktpQUkvaXlrVThZdUFiRU4xcUV0OFYxTWtSUWVjQmwxWjlaMVo1d1kvME1k?=
 =?utf-8?B?eHlNVFg3OVBkdC9xUE5IdGFGOWJpYUpzY3dKQkcyNWE5VjNFUUt1ZEs5SUcr?=
 =?utf-8?B?MnZVWDdWU3M3Q1dwTTh6NFJkL2NEWjlNYkhHdG11V2ZsM1lUeUczc0luVDhS?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CIrFUi9kZs21eYZymrua0p4BgKG9qXnj8YDXM5jdABWGlvW7pgPz0uGkbTR2lIuSn23aVXKR8GVc7W5nsO+1ZysylIUjp9CjrQPfN6aftsutBhP061WywyYYQ9EUfTpxPb3DNhGTC+niYFRRZNysiRzx30qCgzF1F3SlxZhu6jhaRWPBhzHxxPwxN34WfsUWSiRZMJTClX9ErjJQeJ+JeB5ZErZ+gnTlhyoXU/1kLQ+AyVuCbgZX++OPUBB6UxA1SXLL2YC8+kXyVFLZhJpW2nWMx1DNo09RuL4eDojFnRRjE+Rr6I2Y2ceqgldzoXBk24hY7yt383iFcR8xiaaxkC/3WFzI9TWN4/yeaoGiVMg+BjmxrGi7xM9cMPuQSzAPZCGXSZdaYqcd//xzULuIxF1TL2Y8J8+hXSjBPo9HhtTipH5P60YdPTGScxBWPcjF2umNXOjl3J4/zgToZUkHleQ/A/YjIlpQyb9WHpL5zEV8y4jse7V+SibeU35xyJWshrVDDlKIGixlz99vBEMsli9K33TNTB8T7tTw9C6KnpqzfwfCvO2IHR//poNhPRoPzL0W+hZJZqmjc2GNEQlPIhxKvjh5/OscIFbuIwPIODKftX3rYcBkSGnCIYi6na7+pVMlkWsAP0r/eiL9fepf/TeZ25JR5KaX0PY/CpRC/6p+TZcVHdFmpEBakH5ylMJx58JrRBVseTVp7V69LmUzWcwwhi5DqJK5r7PrN+fv/nXj/V80ZbTUReUNwJIwydMTcj5UHe23WrcbGCu3SdmfSslASwUiyd4MPwBfLOv4H/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4b24d1-dfec-4e76-19ac-08dbd6cad66a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:58:07.4407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nirX1vDW8JDr/zCj34375jisS51+BCUte+tgCkN9jKl1psbtSuS3gVMZOtRanEVSYz2j8pp0McFOcVKbM8DtndD7LHkinQ5NN17kVSr2GXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=884
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270077
X-Proofpoint-ORIG-GUID: BDpaif4CZ0YLBxef-owaPHMAKLxEYBF2
X-Proofpoint-GUID: BDpaif4CZ0YLBxef-owaPHMAKLxEYBF2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 26/10/2023 21:07, Peter Xu wrote:
> On Thu, Oct 26, 2023 at 08:33:13PM +0100, Joao Martins wrote:
>> Sure. For the fourth patch, feel free to add Suggested-by and/or a Link,
>> considering it started on the other patches (if you also agree it is right). The
>> patches ofc are enterily different, but at least I like to believe the ideas
>> initially presented and then subsequently improved are what lead to the downtime
>> observability improvements in this series.
> 
> Sure, I'll add that.
> 
> If you like, I would be definitely happy to have Co-developed-by: with you,
> if you agree. 

Oh, that's great, thanks!

> I just don't know whether that addressed all your need, and
> I need some patch like that for our builds.

I think it achieves the same as the other series. Or rather it re-implements it
but with less compromise on QAPI and made the tracepoints more 'generic' to even
other usecases and less specific to the 'checkpoint breakdown'. Which makes the
implementation simpler (like we don't need that array storing the checkpoint
timestamps) given that it's just tracing and not for QAPI.

Though while it puts more work over developing new tracing tooling for users, I
think it's a good start towards downtime breakdown "clearity" without trading
off maintenance.

	Joao

