Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933678F4E4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 23:55:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbpdQ-0003tS-GL; Thu, 31 Aug 2023 17:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qbpdJ-0003tE-JS
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 17:55:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qbpdD-0004SY-JT
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 17:55:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37VJ4j9i018702; Thu, 31 Aug 2023 21:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=a59guttkWw7/wwxvj1ZC2P8J89ypOAte46h/6OJnyec=;
 b=HmJ5CkVJt0XxIXLaohSn1oxE/aEkb7TfE6S5/yDXAiWHm/3xMzVcmVqseIlU+kw5pgse
 84k7u2lilwiwnDQWP6fJCrt65wE/reuFFgPhWdrhMykNITEasbQay8o4PBt+ME5DJi8y
 Eyuji1yqSph8ug9UudYtOo/pZJRfyEuRGh6JqeYwDUeN/OdHokSRbk5A0wBqK0GR1KuQ
 GBEUoLjLK8me4Lhdl4qnSj1lDbWYVRc7ZyXTGUKvixS0+jysP44IPcDycEHlm68XHcxd
 CRiqa0nmsWiATPv+IoT2crr6qrYDjSxJkOl+ILiBdpCYTuMeuFYtHpVthHETVArnhEdR QA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k6aw0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 21:55:06 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37VJmF60014527; Thu, 31 Aug 2023 21:55:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6hrjegt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 21:55:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a30Qlrt0mS14AziWIWr9qq/zqeWNROcf+KuauTmoTcFXgQyyKjqv99qRPVo+ZsTkN8gCFnbG02++x47S6NgE7cibI4BIJ72/voWVH9J8/ejPrKlUbA6yC2eaoJEM+rPtFyS55lm0NYYHlrJ2G2PN53MrZlJzh54H8LDXpuyl6MyoBH2LlDY8SJPzHmbKDuy4h0brg11OhiNl8cFmuAm3aYS228Iw2ldKNa6D4z6JIwcG/75rX92WiTC6WEZebW7y6pAglHzEy7AFUWpOpwYJoaeABKSu+XK51bAJyt9p1H0DFJKaphom5dwkklarX0mpyuZHI/sCiEYQbpTT+Wj2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a59guttkWw7/wwxvj1ZC2P8J89ypOAte46h/6OJnyec=;
 b=lrT5PHzZmN/6h0CpHBMunjLQppH+jnlfvHbTFN5/bw6YLZUX9OwE8qR+6pT7q5x1mV7ReA8Kyz3ZkueEm1rO1C9qZ+NjmuP0HCnGEkyERLKqsYY6JXIR3C3OTeCXRdToRBo2FQmrijnRKVYWYg1tJ4CjhEVlVa/UNKANDl/d2l579bwSvZEYOZj4W13aK6NZHDdR5HDUKjGCAc9t1bUwv/dtOIp912SK2O/CTwp6QPdmMH6AxafBv1/sBDFHMMPcR5pWW3JyUAg9+YQZX82jJc+UUdMY6N0TOJqs/EIn1/IJ3ibG4REQ1/Z7vwPk+g9hdaN5bMh698LlNJTxRDyHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a59guttkWw7/wwxvj1ZC2P8J89ypOAte46h/6OJnyec=;
 b=A+xHXx2gTfysW/IhwWkyTXmfhE9HLuYcI7hHdLm42UCTGrgFhrh7odAr/QqntkdcMxPQlD/gk4OvFfWiDPmLRvjBVkJ2lWokPedRYC5k4oeJWJAz/ABAPjcrz38BWABvnG9JuHh9wMJ4ThTkeKvrkuoz5Vy/IrV9g4ml1l42Ktg=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by DS7PR10MB5998.namprd10.prod.outlook.com (2603:10b6:8:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 21:55:03 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac%3]) with mapi id 15.20.6745.015; Thu, 31 Aug 2023
 21:55:02 +0000
Message-ID: <954cbf1f-0cc5-1dac-1e0f-d0203df08863@oracle.com>
Date: Thu, 31 Aug 2023 23:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] i386: Fix MCE support for AMD hosts
Content-Language: en-US, fr
To: John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230726204157.3604531-1-john.allen@amd.com>
 <20230726204157.3604531-3-john.allen@amd.com>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <20230726204157.3604531-3-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::15) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|DS7PR10MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4127686b-1457-49c3-7b32-08dbaa6cedda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTH9+LLXYg+3e2dVfTrQ9NCUIpJdcEhXqvDN5KWFG3D0a4Kybd+RLDUGPxHPI0CxkSHC3Pg4a9kf4rbTYou3YQIep1g8nKhhLMgcKhjHw0wQi/MnNHeuMNrbeVO60FJ3dwQDBFzDPnXEj8I8v8qifYjitQGx+CMpe0iHyfjQZxEVjrZ4IMudhwwotAxQkixuUy+DRJEsedYpucN/eT6rH5bAHz1b1gRUHzRczZibx4/AJnm7liwH6LisV7QNZpwi1eEFj5EXfpmSWklg/Cs9tuY2JQW8JzvKsixagogydC9abxRLz+JeZ7SZ8SaMpDUkxvuT711GAxA5KxB5JB0BVpznNQ+xUc/R4n9iShYU7iTkn0yDdPpvApcrNjCenycjCn2qhl/SjT+2jW1lnax51tYT31/QsQeAe01iFBXGHnCyqQ1VoSfJlDAi4mvq7NmFCAzATXu/K34FMTbUrx9BJrTcfmYS97UWPFKetEIcBLuncMKp/7Jorh5i/IIJWFLrPeeRuJBeybmQhMR/mZNa0ost0RrT/1RfVWRX+/1xlnycKL1iO+vN/TAQuETULsGiudusiV2MnvbfbCd/oEROqREudmfV5ZP1osnHeMLNcglVSi9gTo5RRiiIfVufeCR88HZ8E1qsQDvHY/akbUs+xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(186009)(451199024)(1800799009)(66476007)(66556008)(316002)(478600001)(38100700002)(66946007)(2906002)(41300700001)(44832011)(86362001)(8936002)(8676002)(5660300002)(4326008)(83380400001)(6486002)(6512007)(2616005)(6506007)(26005)(6666004)(53546011)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHFxcU15RHBzRG5xRG1Wc0lHSVdpeENHWFlwQjhuQ0w0R0NjRWpUZGVTOTlJ?=
 =?utf-8?B?dmpRS240WjU3NXd2Q0xMdG9DcytiVGNYVDZPTjh3OVlJVDJ1ZTNvSnZHYTJp?=
 =?utf-8?B?bTdOQlloVzhvbjdjQmcvbE95ZU45MlRpb2hseE1lU1BNVktrQTBSdENCSDIr?=
 =?utf-8?B?bHNjY0RqVEQ4aC9hd1lEOG43TUhvQ21QU0FWUnNCQy80VFVsZi9RUmRwSG9l?=
 =?utf-8?B?NXRGZ25FSzdTWThtbnA2TmVjZ3BxUGtYTjVYa2xjMmNGclJvT0NhVmFvRTFv?=
 =?utf-8?B?aXEyVmw1bnBHNlN2YSs5dlFZcWl0QWRNK09hZFZhYmc3VFFOUXk0TVdHdGxh?=
 =?utf-8?B?eTkvaUMxN1NGb1V0QVBZM0lYUVFNMEEwcTR3OGs5Rkl0NEpYRzlJVmJCZ0dH?=
 =?utf-8?B?cWdEZUVER0l4MG1ENStzM0IyaFpuaDhOWXZXeVlhMVJxZk9pOTFYS2pPYlIz?=
 =?utf-8?B?OXVrdHBvb2Y0SEVobEJhaHAxeFRLbFljRE5mZVpWQko4aWxIUUJaZGJ6WG9o?=
 =?utf-8?B?MWVCMnpjSFlaNjl5RVMrYmNUVkdmb2VkK2Y2Y1FvazJHQnU0N3UxVXZhSEU3?=
 =?utf-8?B?ZXAwUWlhOFo1b2YzYTdsTG11aGgyU0JDZ3NQdEl6MndmcW1hby9ydlU4Nlh5?=
 =?utf-8?B?YzRidC9IYUwwbVhhUU90ejllOFJ1bjZORUFsRzNhdHlTR3liYm4vK3QvTk53?=
 =?utf-8?B?bnZDWlVEZzdLZWpwMHpaZUQ3cWIwOEVEeGFiTkhDM1NtQ2ZoZW1hck93T0Nv?=
 =?utf-8?B?Zm1PcndSZnNoaTc5V3Z3RlpsNWVhZ2VvTTliNGtTMDVVZExLMEFnTHkzcVNz?=
 =?utf-8?B?eFhFbW5lNmpDSnJ0NWxnSUgvVUdwSVQ4K1BRSkR0K2JrQVdaVkM2eUV5S1po?=
 =?utf-8?B?TzZiTFJ6ZzRIN3JuQTRPa3lvU3hRQStGZUVvRkp2cGJOeUQycFBrVCt2M1hO?=
 =?utf-8?B?TDNUTFpGZFNXN2pmVEx1cUlTZC94THBPYVBBNzBkdGdsQ2pwY0g1TGo1Z1hH?=
 =?utf-8?B?ZkRqZWx5ekpSK0tWaXQvb2JRVTBuNDZqUm41QVo0d2lrNElza3k2cEJKcEdG?=
 =?utf-8?B?bmdtcTlXNVNIcmI3R0dxWTRQVXQ4MitFK0VSVWpIbU1oZFlxMFQyNkJhOWJy?=
 =?utf-8?B?V3RFMDRud1dkczJ1MUdnUlNtdHBnK2dkcW1SbzVhdVBNVjdFdjFNRU8yaUxZ?=
 =?utf-8?B?Nk96NW5FSDEvZ0dnanM4dDNPQVd4K2krZnExSWZQU2pZc0VzTU9FaDZsUWVh?=
 =?utf-8?B?NzdQU2NGRmRRUEdTbnBjWFVXTm8wTTdpaXUza1RDVjdGSDM0aWFpNTB2WVlI?=
 =?utf-8?B?eUtuMTRHV2l2TStmUGc4cWovNG5yc2xNanhNZGJQa3MrbUZtOTZEUlFyTVRR?=
 =?utf-8?B?Y3c5ZUt5LzkvWUpmVy9tbmpNLzV0OXpxUllYY1pYNnNvaVBRWFNJTnk0bFJw?=
 =?utf-8?B?Z0ZnL05ZQ0VJUGFjY0ZIUVR0Z1UrQU5rVEorM0FkMU9CV2trcnRyWE96Uy9h?=
 =?utf-8?B?cG5lMDlYM1l2WFh1TXJPK0FEUitRN0hGQ3c4Q29IdWNQamJPVWVKd3hwZWdH?=
 =?utf-8?B?bjYyeG15OWd4U080Wm9uSUNScG1OdHAySDJTcWVlUzJDcEU0VkVFcnJVQWpR?=
 =?utf-8?B?cW1hNkVrTEMxTkV0OHlVUnV5WThLNmw0cGhET1JVYUkyS1hNc3BuelhTdVg1?=
 =?utf-8?B?aUIyNHVTeCs1eWVubjNOUXFiT0dOUjh3d21lQndiV0VVczVnZzgzcE1OMGdy?=
 =?utf-8?B?bkFDYUZMZXJWUUhiaHdhWlM2Yk1USDlneHZ0MnpjZWJRczd2TDc4blAvazJT?=
 =?utf-8?B?d05tTUFwVEo3bGc2VGVlOGpHd0hoa0ZTaWZMMzVyUmFEdmFVWitZdkNkcTdV?=
 =?utf-8?B?Rm03QkhvNGpoemFKTDVJczBIREQrN0hYdXVuSFozMmp4eVgybnNWM1EySDg5?=
 =?utf-8?B?ZU5oZUxXdW9aVEw1WXRhVHBJN1lPMVpYcTJVU0VWNFFrUE8wR3dONTFkRzQ3?=
 =?utf-8?B?akRYRFZuV2l0ZXVGdlFaRFdwTzJZOWMzYmVCNWZqOFJxM01XaGFCVUNzWHFo?=
 =?utf-8?B?RlE4ZGpGL0ZYQ1RaaHIwNUxjS2htcWFJSmVQSkVXVnNuRGF0VnNnL3U1ODNn?=
 =?utf-8?B?RFVDZGQ3YTlkbzhUWi9uNkJrd0JsQ2xqTU5QUnMvTzloKyt0NlRJSGF0STU0?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XfoCeCK8TLfCOgbPAkOCAmq26N9uajxg7KSCU0Ay6G7frVGNPUI68coWmlhuU+rcQfISINgONaoIsjC4MJlNkxCeaYpqCgGFbKScBW81MImXTZGJ9vxkYZOzQ6wzmLoE/gPb98OH+3e4wL8LEbrA5ztwqc0lE+zwjpVYy4lCIRXjO3iFkklu1tHD5kNmkYQG8e8H9CjRlyYAI+yxDHg61QWNnZsii3Ttnq296kCErTJuvyOhfJkS+MOJv4iaehL78UrR+z0lztQayeaPEy+oIiuLzXIUBFGxKT2L5NOMQAZE3cMOnSUqKAdsSt/7qDWVMDH4AphRL9E6b7hl1Y/FeX4LyVNVWUy0Jrqq7wHUcoPmE1t/vUC7GjdS2Gtdx8CQiPQubGQHDPVuW3B+yew8iKyaEJz7PTGAZdMUY2L0lP9P1Cz21qfP8InWv2ikOKlQtUjFJ4/eK8cEGomu39qG8OjVD7SeMYYcV+IMRnVtTXNNNRt0GDaQHL1FqNyY4HXmD43Ee9tQwvqN+zPhe8JAGUzUPmgpsWHUAe92haxg7J4H2U2Ae/NWgTeniAKCDdLrLFyr/PSmCfgac9c64XuW6r2VjS6EWHC3BZNRudLroBHeExMGgccvFQN/mqCW6iPAAEItL04nHPHZP9MrzpwlMgqs3vgJgtyGdxYzRuaOQ6H/daXOzn96oRkI9dOGpt7oyOYBgorrQIPLqAR+a7v0qugxWSgx8ZPOyqFkx6LFiVfzgJdHBl+nnQrssg5Axc0+/qWGkdbmFJuVvIWEa80x+Wc0H99KMQpO5GFzVTnPp8Qfw/7nYzzzTv6jnPZPGG9VD/CFIoDRwDcSu0uVU6efAW/6HUWO2xAY2Mgl8bclczE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4127686b-1457-49c3-7b32-08dbaa6cedda
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:55:02.9020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tronQtpULGZ2v7aeqpu7mtXfmc+SZvjTVE+QGiwJpDSU5G3oTdjpkV7ZQcxCFj3opr1qpvWIDOAYYldvmQO8OqOtIsUXuy3TFMtIj+Shl1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_20,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310197
X-Proofpoint-GUID: JSHOwOtPxDTCCPr7E86C2zw6bwH9YdQ9
X-Proofpoint-ORIG-GUID: JSHOwOtPxDTCCPr7E86C2zw6bwH9YdQ9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

John,

I also noticed something important about this specific code:

Qemu commit cb48748af7dfd7654323eb839d1f853ffa873652 introduced the use 
of the MCG_STATUS_RIPV in the case of a BUS_MCEERR_AR error, but it 
looks like your reference code is not having this flag.

According to me, we should keep this flag in the case of a non-AMD 
machine with a BUS_MCEERR_AR.

The patch should look something like that:

[...]
-    if (code == BUS_MCEERR_AR) {
-        status |= MCI_STATUS_AR | 0x134;
-        mcg_status |= MCG_STATUS_RIPV | MCG_STATUS_EIPV;
+    if (!IS_AMD_CPU(env)) {
+        status |= MCI_STATUS_S;
+        if (code == BUS_MCEERR_AR) {
+            status |= MCI_STATUS_AR | 0x134;
+            mcg_status |= MCG_STATUS_RIPV | MCG_STATUS_EIPV;
[...]


Cheers,
William.


On 7/26/23 22:41, John Allen wrote:
> For the most part, AMD hosts can use the same MCE injection code as Intel but,
> there are instances where the qemu implementation is Intel specific. First, MCE
> deliviery works differently on AMD and does not support broadcast. Second,
> kvm_mce_inject generates MCEs that include a number of Intel specific status
> bits. Modify kvm_mce_inject to properly generate MCEs on AMD platforms.
>
> Reported-by: William Roche <william.roche@oracle.com>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>   target/i386/helper.c  |  4 ++++
>   target/i386/kvm/kvm.c | 17 +++++++++++------
>   2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 533b29cb91..a6523858e0 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -76,6 +76,10 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
>       int family = 0;
>       int model = 0;
>   
> +    if (IS_AMD_CPU(env)) {
> +        return 0;
> +    }
> +
>       cpu_x86_version(env, &family, &model);
>       if ((family == 6 && model >= 14) || family > 6) {
>           return 1;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 4b62138459..87a50c8aaf 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -532,16 +532,21 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>       CPUState *cs = CPU(cpu);
>       CPUX86State *env = &cpu->env;
>       uint64_t status = MCI_STATUS_VAL | MCI_STATUS_UC | MCI_STATUS_EN |
> -                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV | MCI_STATUS_S;
> +                      MCI_STATUS_MISCV | MCI_STATUS_ADDRV;
>       uint64_t mcg_status = MCG_STATUS_MCIP;
>       int flags = 0;
>   
> -    if (code == BUS_MCEERR_AR) {
> -        status |= MCI_STATUS_AR | 0x134;
> -        mcg_status |= MCG_STATUS_EIPV;
> +    if (!IS_AMD_CPU(env)) {
> +        status |= MCI_STATUS_S;
> +        if (code == BUS_MCEERR_AR) {
> +            status |= MCI_STATUS_AR | 0x134;
> +            mcg_status |= MCG_STATUS_EIPV;
> +        } else {
> +            status |= 0xc0;
> +            mcg_status |= MCG_STATUS_RIPV;
> +        }
>       } else {
> -        status |= 0xc0;
> -        mcg_status |= MCG_STATUS_RIPV;
> +        mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
>       }
>   
>       flags = cpu_x86_support_mca_broadcast(env) ? MCE_INJECT_BROADCAST : 0;

