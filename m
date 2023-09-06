Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC479451B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 23:31:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe05r-0000oY-Hr; Wed, 06 Sep 2023 17:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qe05p-0000oL-00
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 17:29:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qe05m-0005Yc-0E
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 17:29:44 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 386LFZT5000458; Wed, 6 Sep 2023 21:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KCCS5P6q5UtucoAeyA11j4Kl1MTWgAeyg6MJM4DYUOA=;
 b=LvK7RC8sTlRADmxTijC7lX1nL8g7k72ekI6ET3pbKqEZaDuXjvTC8SHoWvGznFbumGYo
 WbS1lmxUEfMhrGpIlht1kDKYlZgvzVzhWxSGTYFPFtG2rm0ZRrHspf0f3IwZ66JV5MpB
 ctqCViGDGYaYsGgOsw7+QXY3M39zFrpsQT1I3PqFHlHFV+nxpstOIeV0zMa2Fm8wtNui
 B0V++0rTt1MVeOHJ3VX2PBTRFsYkbcmNORh0va8dBzAjJBvaVVtLxqVtAK54rT4XxlZ6
 pRNiS7Ziqtmy7mxg/HwicTMoJtr9ptubcs5bAiAf9oXeFKwSQDNt1kSDqul4szgXt8wo Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sy16580vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Sep 2023 21:29:38 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 386L0Q53028174; Wed, 6 Sep 2023 21:29:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug6ue3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Sep 2023 21:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtO+WoDcA1tIsHHY9GYjeDcnCwm6eVJvobS6I8Cc1Yx7s4UTjHMo/2KgqehdSip1ahEAasQ6+PlGRf3MmfHE4iGwcPeBELdr6xdX2zG4mNzZF90Ks3CRQnH3P33iSw4k58wY5mhE7HrQoGnAiPwja5WmxN1G+3QMo25irFvyCceXL5Yvu92YpZ3ooHTjBJtOaR2N1VfokmA5QjtsjVC2OpUdBOBuv8j19IZ4hL2FlYm1Von5bET0WU8V+6nQNGS1w/+d3EjcGmA1TmwHHOfAJhTpOGUTB1j56XXJbG8e+qL+h+ckP6hHnfCWSFueQCnq1ktIy7Pfqency99+h33Evg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCCS5P6q5UtucoAeyA11j4Kl1MTWgAeyg6MJM4DYUOA=;
 b=QAsIQBDspuYWi8m8JM+U1IZ9AnIVmQDi3LhABmTw4IXPaVGgYjOtLbIbrIH30NEo2a+Yc99jnHtpqTMN9SxwsoqmiZJn9eIjJ9xfbnWJcPnyNnVniTsW5Enpicpawn1F53XvTpkJd6OI89QjZPpZTrBOIpzN51oTOKRDJBTW3yt54+wtcwAqluGUQjdHN3FkRomQPwLdvAeWl0FXRsARc150Uck/TAQj/eUGZL85xOnKb3q5D0F2T3gHQF3SkRxdzRKtFeN87azSO08oOsyAaaO7LIvwUwr7PCNVoehM49y6J8Miko5j373ByqbbVyGBMp5L7AkQUx89rVzG4DTSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCCS5P6q5UtucoAeyA11j4Kl1MTWgAeyg6MJM4DYUOA=;
 b=jUWSgL4gery5KqI/jWtKgPw66qyld9WXTZ+wsCA14pvOCoYZT1ZJs8+U4FXdBgc7N793Eq9gsoxAI8saIa2G9B3e0Fv4O/Ptba5JWwe75PRbiU9wU+s7gCTU9KGwhsWt+VX3ntW1HkovCZuajqrap0vz/tphPPB99dmEX79C+gY=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by LV8PR10MB7871.namprd10.prod.outlook.com (2603:10b6:408:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 21:29:35 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 21:29:35 +0000
Message-ID: <3968a8e5-4010-0c97-7e1b-0dcba64ade01@oracle.com>
Date: Wed, 6 Sep 2023 23:29:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] migration: skip poisoned memory pages on "ram saving"
 phase
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230906135951.795581-1-william.roche@oracle.com>
 <20230906135951.795581-2-william.roche@oracle.com>
 <e2adce18-7aef-5445-352a-01e789619fac@oracle.com> <ZPiX4YLAT5HjxUAJ@x1n>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <ZPiX4YLAT5HjxUAJ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::16) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|LV8PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: d80d5ccf-1c77-4c7c-1b18-08dbaf205dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbaE357OzKdIrEKVTNPzN96u6srAVa4IU96Rn6rqmdHJOwXS3BQvJkj9Xqr9dqEhoR7gErmAE4t9m4TprgMG/BS+qPIIbZ6Mtk7w2weR/4nOLgf3PD1RTB9R3f+cTKR+Rof0dKkQfarg/SSvNmIiA5TPI7RSwv5u1XXsyPZZoOPtjPjYkuDoxHqtBItyNKRf7EHHAR2v5HnVSQ7rHTaG22SF4/x91Zym4AN3d5HuCVWrREZEuNjJ0f3z2AFzpLBojsEwaOyLMUVRD5IntOIr1bLg4htYdfyubONbVBk/IHOpO81Jb69wRq5ZEGnkSHACDAd40wIwEUz0Sk5PlNpohC3TZtfHsmHvBcP9n1yAj8NPgXv3Ilcy1qWvufm9B2VVFZ4XUM/hrV0bxc4SGx9W36i94uXF/DJi3HXKUOK0EBhGUiUUka0PezRuckn6mQ5lm9FJQekjfP2oUdinmeztok427sRvQLWqZqpJFfR6w0AiYiJ09JbwYD+jF1RaYDEE+SnBZQDDcgKV9tAxypJxsMNg+c7Wppi5m3kxi+LiPgvyVsW6LFPPsLgvoHfEVFe/FzhDTpU4wiMRatvdpXevCtXwIjgLRixjHDxB6/L9aglua1+HOi484jren8XZiWiiGjxyhXjMFOLAsrN4N8vi2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199024)(1800799009)(186009)(6666004)(6486002)(6512007)(6506007)(53546011)(478600001)(83380400001)(107886003)(26005)(2906002)(4326008)(44832011)(66476007)(41300700001)(54906003)(6916009)(66556008)(8936002)(5660300002)(316002)(66946007)(8676002)(86362001)(31696002)(2616005)(36756003)(38100700002)(31686004)(66899024)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm1tUUc3bUlJQ0llaGRwMEhrS1VQMDMyZWFXUDlJMncwclBCQUxGZUh4RStH?=
 =?utf-8?B?UEJLUEdGYS9kdEhRS0FwTG85RTF4b3ltU2hUcE8reVlHWnplNGVOaUFObHlw?=
 =?utf-8?B?aGUySzVhUjV3VTJQaU80OUh5SnpUWUFLWFIvNDRtSmErVCsxYzcxYURqU0I1?=
 =?utf-8?B?SFBtU3hFb0RQeFluRFFMQ0Y1bjR2RFhvMEIrUU1jL015V0JUWFhOMVB2Q0RQ?=
 =?utf-8?B?UHV6UzVEa0NsaU44dzVKOWFvbEJ3OFpOOXh1TFdxdGd2Vk0zem0xUzhjZkRj?=
 =?utf-8?B?WWJTSm1nUTNxTzB4aERGU2NSbWlDVVFDNUhpWGR4MGdIWERyU3BKTnNaMXEw?=
 =?utf-8?B?S0J0NDNxMWh1akJ6aERONWZDaFZVY2JZZVhRQ3p0SGhKMkl5SkE5R0c4T0lq?=
 =?utf-8?B?RkVZTDRuS0Y2YnNTVlIycVpDR01CbzNhSGo0K3k2cVlVTExvTHdTTnowc21M?=
 =?utf-8?B?Y21kUzZFR0RHWHM1R0lmUzdkS3Z3djBIUWFOc0hVeExWMlJpRXNWSUxwZ2FQ?=
 =?utf-8?B?SnJTNmVVOHBHMnZSd0JNMk5KTzR1UnhFZkI0bzBOeVJSRFkydnIxT1V1dXFQ?=
 =?utf-8?B?WmhYM3NwM2ZVTTIwTG5HVy9yakF6VFk1R2ZPS1R0NkEwL0hGZVpyNkhTQkFC?=
 =?utf-8?B?dVk5MHZFbFJ2a2RDc29sOXUyYkxjdnVQazRBT01OUGl2OHVNWG1pelN3dUs3?=
 =?utf-8?B?MWlEUWcycjZYbTYzbXhvTUlZc3loMUlnVm1lbm8rbTQ4UjQ2anBya1ZNNmpv?=
 =?utf-8?B?ZTRzN1hISVNFNi9pZTZMdWJPbUxpaGFraVpraGRqY1lPL3U1dDFJVEpHMUtm?=
 =?utf-8?B?UU42Nm10SStwbEZMYWppakZVQ09sUkdJV0tzKzlTU0tlc2oyQmNrS0dlT3Jo?=
 =?utf-8?B?MWEycFpsbWZ6alhLQ3RqcWtEVjJrTUVkWjdnRkRmKzArekNiU1J0dVhqbWlo?=
 =?utf-8?B?Z2dDMElDWnArT1JQTHJWWU92ZzhEMzJsd1gvRGgxRzdWRnpJRWJvdTJUSXd0?=
 =?utf-8?B?SmNkNTd6MjBZbUl3VkpqMVlkQTJNbDVNVzNidUxVWSsxOXBaeGErRzJ6eXpy?=
 =?utf-8?B?OFMzdEV3OWJMWlBROVhOZ3ZaeE1HZjg2ODB2anhLUjZHbnRHWVNxUGhXVXdK?=
 =?utf-8?B?cWs4aHdub3U0ek51ajNRSzdGZ1dUekJhUWlJQit2WlczQmk1dC9qQjE5WnNU?=
 =?utf-8?B?ZGZrVWdlb3psWFZzbXZvcndMNG16MmVyRHVtRUtOaDJURS9rS2NubXVLbDhq?=
 =?utf-8?B?WHRVRmdFU1hkYnlvQ2xDV1V6dCt5NXJ2UTU4WHM5MHA3Ylk3dXhEK3Z0MFFN?=
 =?utf-8?B?emlZYnplRnp6aERXRHpvSkNGNHROeG5ydXNaaVd4MlFqQi9ndmNxUjdLZVF4?=
 =?utf-8?B?bEcvTWJVeUQrZXozT2pzWFBWQnQvUmx5SU1uZG0vcy9XK2xBU2tCdXFQR2J5?=
 =?utf-8?B?M3Yvb0Y1UytOem5Mclh4S292S0JOUnowYkdVRlBMdEhGNVp5Um1IV3hockRD?=
 =?utf-8?B?cUs2V3hxQUhZeGFSbjVtZ3Z5NHRhRFZ6eHRDdm1ZVUpVbWdWM3JYeE85Um96?=
 =?utf-8?B?TStzeExnRk9HcGxQT0lYa1FuMXdkUjJNNXVrdFhxTXhTMHVlWjMvYU5jekFj?=
 =?utf-8?B?VFBhTzhYWm5ZeSt0dC96R1lJWHd1U0pWaCs0YVlqR1k4YTRFVUx5RXJaMFdQ?=
 =?utf-8?B?MTE5NVYxWmh4bm9qMUZ0NE5WSWhnU04zL3hycGcvRTZxOE9rNHNDZ0VuOG9X?=
 =?utf-8?B?SEZEYzErTFQwc0YrbVdXWk5NUzYxdnJvdDZ1UGhBb3huOUZmQzlnbGF0WG1s?=
 =?utf-8?B?d1JBejBhY2huKzZoMDExcXJYMUE2T0xnOFZPN08wZk11UkZMS25mSTVMTW0z?=
 =?utf-8?B?MmozaXZmc3JtaHNMQlR3bWU4ek50bE8zT3FkTFdjVStqNWdEUEw3d3hkcmRO?=
 =?utf-8?B?cmc2ajJqNkY5Vlp0V0hWaGFjbjRhVmo0d2ZlRENjZS93bkRMVFVhaGJWQkVJ?=
 =?utf-8?B?Z3h1NER0cFBzMkxQOWlWR0JMbUp2Wm1lUktTQm1kOXd3VFBNT2o3R05KWDds?=
 =?utf-8?B?dnN3SkdsODU3cXhkMFlnT0ZRUDBsL1FKeVZXdTYvVVhmeHNKbmtGMVM4U2Jv?=
 =?utf-8?B?alJORHN0U2VXWVF4Q0kwakh6cUx4dm1SYk9OcUVVSTZxaFcrVURtQS9xN0Z3?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ETBPgCIvTWaRIeWc+ruU75H12ktjzsEodVgg1B1NIYrNCrsLXZbFUQ0n4GgBlyRhkXGiYwGA8vSoXh6bKN+cj/SoJLKwy8qcUnBCppNzd6kL7bq+/e6Ub6OkD2suGtLLGeFXHcuhk75Dq49D27A5oHxOiH3Dtjdz0HsFKZrYtCVlVPo5DfMMUK0Ew327IBCevgL5bkJu4JpqFJMp8QCrV6sGrP/rSpRjJKrnPrlANkt4gIIfnK6luQX5BHecZ3dhQ5NdtwKDQ26QdrQwJLUoWhvbebTBb9HXlZi1QgNAZZ8p98aHxoYPC0qj4kfPcFIpuGnfSQDS0jw4V7AcZcVLyKRVmEzmj5S6NdKgMiwPxPthRlls/s7oVj5CnTgK/M/lFlDI7lZsjwl+v2lp9BJ7yzW9YZBR67jaxFuNC/EuwF7djiSQHmMFEEtcGlbCz6EoQvzPjcfbvBvWLTiwGkqd9pqWOp3kGGItnCAiGhUbgnE4DIZ7aclMhBJ9pTMQLU4QzNSK2C1YU46P8t5Eyw7wdFK5FORlDAnp37yrzfA9rsknQg57K1RsbUfb1yWRe4KgN6tGO+UuclyjxBN5e5UX4HgWeg4lQPfEj1VVo02c6FLku+oaEB1rKf3LMdy6R0666mclB4MX6AA6KlQGdAnVIaR5v2UDAFiLUz56u78au5ollKeXiJ0WivbPavyC5v8Zvjqujr3+j+yzhrb6rwEwCFTxpLOO61o4AB8VtOqLE16z5NJ3LDyycQZxV0o4J9QANHcs10Ghkz20owomS8dF3g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80d5ccf-1c77-4c7c-1b18-08dbaf205dce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 21:29:35.3097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpGHCqC+eKH0lGBGUjkk1GpVA0Jgj6Ao4oFc1MaO2jWhKaVxaAJrQ8+AmZcGKtJPp79lX8osy2hWIawHGtqFBH6jXerj+KB5+x4p+g7rKhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060186
X-Proofpoint-ORIG-GUID: hCU67dACXo_2qc8p0_O-dpAfWoUV-M74
X-Proofpoint-GUID: hCU67dACXo_2qc8p0_O-dpAfWoUV-M74
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/6/23 17:16, Peter Xu wrote:
> 
> Just a note..
> 
> Probably fine for now to reuse block page size, but IIUC the right thing to
> do is to fetch it from the signal info (in QEMU's sigbus_handler()) of
> kernel_siginfo.si_addr_lsb.
> 
> At least for x86 I think that stores the "shift" of covered poisoned page
> (one needs to track the Linux handling of VM_FAULT_HWPOISON_LARGE for a
> huge page, though.. not aware of any man page for that).  It'll then work
> naturally when Linux huge pages will start to support sub-huge-page-size
> poisoning someday.  We can definitely leave that for later.
> 

I totally agree with that !


>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -1145,7 +1145,8 @@ static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
>>>       uint8_t *p = block->host + offset;
>>>       int len = 0;
>>>   
>>> -    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>>> +    if ((kvm_enabled() && kvm_hwpoisoned_page(block, (void *)offset)) ||
> 
> Can we move this out of zero page handling?  Zero detection is not
> guaranteed to always be the 1st thing to do when processing a guest page.
> Currently it'll already skip either rdma or when compression enabled, so
> it'll keep crashing there.
> 
> Perhaps at the entry of ram_save_target_page_legacy()?

Right, as expected, using migration compression with poisoned pages 
crashes even with this fix...

The difficulty I see to place the poisoned page verification on the
entry of ram_save_target_page_legacy() is what to do to skip the found 
poison page(s) if any ?

Should I continue to treat them as zero pages written with 
save_zero_page_to_file ? Or should I consider the case of an ongoing 
compression use and create a new code compressing an empty page with 
save_compress_page() ?

And what about an RDMA memory region impacted by a memory error ?
This is an important aspect.
Does anyone know how this situation is dealt with ? And how it should be 
handled in Qemu ?

--
Thanks,
William.

