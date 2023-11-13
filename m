Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DD7E9E03
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:02:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2XUg-00033S-IX; Mon, 13 Nov 2023 09:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r2XUT-00032R-Kc; Mon, 13 Nov 2023 09:00:46 -0500
Received: from mail-mw2nam04on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::604]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1r2XUQ-0002NV-U5; Mon, 13 Nov 2023 09:00:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaPvlQ+D+8qF4/el2MQ1HNx9O2YN1v9iq3bCXCa4M2IoTnEdbAGwVmeTXz7ymeco7lw0ksLuk3iB48zLl3/pHJ1qya/O2sKEA1GhxD3a59ZG63nMfOMppmhgTrTf0/QVOakRsK8RKwDaoFgM7vPtcOJAOpHfxTtQpnMOaDi3s+inESwVJPm4ZuWOBNQRImzcJNT9TWyWxQNXa6aYkd5bqpplgNDR48s8R++3sopFMoLPqkReb/L/TCHrjNF5wwhWXtO6Xt/Ot41pcJZgICmyKNfjJ/N1Mo9Qnylr0HtwdPQ5rVdprg8J9kzfeku/ZTU4whbuDxCOryPPXg9Kzfw5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynaqFLn4QVlYPlJgYPd26++vz/eSKDPz0rv0UanWtGM=;
 b=mrGAxECVd2sfNtdCaKaHl2lCJmsynjXyi2sS/JmOMy8hwyb7B2pHWv3fM/TJVfIODtewZa7+K4mYXmDqWFiTINYvE94eFufP6aCzLdMDNnIsXxWLpPmFkaLuy79oPn8BEU6hh4iPGOUiHWmfklT8TALSSQOSfm9CXpz55w8b/0EnpBXkhLhARzk3pEWTswTBZ0eNBpVqyS4Lkz0gGfQEE1yoO6ua5mZiGxGRRnIougTbRyJVPmdQHaUP9Mq7VLk0Q0iumDJud6W+/JjA6J0CJpV+fiob2Y7fOb32jaXSTuKHaq1RRMRvsaB4b8EoEVTrCMRWpBv5Nruqu24j/9ggfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynaqFLn4QVlYPlJgYPd26++vz/eSKDPz0rv0UanWtGM=;
 b=jqIPyFndfjKl5o+FNYVb407ffRo5ffai8gssd5rjMZrOrvT0Dnh7O/8FFEXB9KcYXwE2mrkV7TmdVxTaqq4A+Pr2XBKNwkjKmEtqVckp+l0hSm1/I/nBAe3OA22FvADwi1aYRU5cNccgxYcYVbydhL7y/kVWfg8D6HlY5vpAJLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 14:00:24 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::5f66:ae33:b947:c68b%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 14:00:24 +0000
Message-ID: <0fe9575a-86bc-4f10-932b-dbaa0ec1d438@amd.com>
Date: Mon, 13 Nov 2023 15:00:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs/system/arm: Fix for rename of type
 "xlnx.bbram-ctrl"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair@alistair23.me, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20231113134344.1195478-1-armbru@redhat.com>
 <20231113134344.1195478-2-armbru@redhat.com>
From: Francisco Iglesias <francisco.iglesias@amd.com>
In-Reply-To: <20231113134344.1195478-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0148.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::20) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cbc1d9-7aba-4e36-7a03-08dbe450e1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScCfawhYIrWCpooctdWF2tkK26zuL+jCQZOJoXiFqvDAgz4N1QGbt/qQI6gex1tc7OooF8XsWzjShGSb3dEqiAfM6qVJpH07JtZFvqv+KIsW6SXLTfjMKv6NEbS9MTr/1CpK4Hc48p3R6+VsMmmaumxBVaEpqaW6eHsigJCXufd+iRUtcA+L01YBxgsHTDxEzBA8GdOx80xOhmZeLBi9XFeelCwjE9aQSkAfIHDMsoDpKKOjbmArfwhxXlx59QrB2OKj4waNLPf7ObSq6xUH1qehr8VM8agFISDy0z++SA2Jb7vcHgez9Xh42eqI802ZGLCPi9lxdKRDq0o6Sig3K1QLEhIOdWlSWoViCKz8FuSBX8zd1cq21vCW8yv9aPNJqFlk92N4XZZv99vy4MGquiZR/b88Uvr2kgmyUsd1Jkf9ibz3DiZcltClxq0Sq4LQM7tXNJG4yk9gw0XrtzbmbjERR2fmUH6AMh7UWMzX6Nss2qoR++C8cOfThqvnA1PJD4r/a22Kl0mpViLJ6XHK1gRamOmyhF0UJ83edJrmN+bS6vE/frLZoLHXnuFyzPvh5JzzkAT54OOOJq7idVntPt6PEmyL3bBSYUyOkUPnddbIKP+cj5gG+9ivlQjcA7D/ShBhtViLRfLvnmzWhbHB6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38100700002)(86362001)(66946007)(6486002)(478600001)(6666004)(6506007)(316002)(66556008)(66476007)(83380400001)(6512007)(53546011)(26005)(2616005)(41300700001)(31696002)(44832011)(8936002)(8676002)(4326008)(4001150100001)(4744005)(5660300002)(2906002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU5iRnZ6dWlpMVl0Zy9OMm90UzZISzNZRVh6Y0FhTXExUHVJOS9TMFdZUFpv?=
 =?utf-8?B?bFE3N3o5RGxWVWJXU3RmZUMydVdpNmpnU3l1OUhFR1c4WDBEODhsdWx2U3dn?=
 =?utf-8?B?L09kQitGQzFWcncya0N1VXdqRzVrR2NOdFdmaUl2SnhvaGJLcG54K3dYa1lW?=
 =?utf-8?B?dWx1dy9tSW0ycStXRmtiN2J2RlkwRWcwZmVOZzdHWkI4RUhlYkZzSHM2Ykha?=
 =?utf-8?B?VkplU1JaajFXdmhFdmtJeDJKbU1RZTRRbU1tUkhvR3lmakVHSThaTCtoQmlh?=
 =?utf-8?B?ZzFtVHNlVFVpRmpjQXVJU0dwNnVEVzJ3eHRQMUNqYUpCamhPQyswT3JIa2lJ?=
 =?utf-8?B?dk1JMGxnZmV6K25QTGZnOTd5MG8wOTJJUUR0Vm5CN1hNZmFWWlNscTVLc3FJ?=
 =?utf-8?B?SUdjbE00MFU1RHZHNEVaeEsxRXpxMzVRbEN6Q1NqS05HNEJxY09VbDlmNzFt?=
 =?utf-8?B?czZkbWtOMTZpUkhDTDFOcWQweFVOeE56N1orM210MmhINUprd2NsY0NpTytz?=
 =?utf-8?B?WjFFZUxtK3BONG01emlOZnorOXY1VC9RMWpHNHR1S2N2RUJaZVdvYTl6RUp6?=
 =?utf-8?B?R2VMLzdyQ29VUWExeXkrVlVNZHZnRDJubTBqY0R5QkliWkszZWdKRHp0aG4v?=
 =?utf-8?B?UFBBK042bkpIVGlwMkRVV092dXB4TlNlc2JNbVc4c2RpczhBQ2MyQWd4K0tT?=
 =?utf-8?B?cVFSSTlaYlVCcldEWDczOWYxT0xVa3pFL0laOGJWWGtoSmg4cFp3Tkd4aG1w?=
 =?utf-8?B?NG93RVR6dlJwVDM5TGFjOU83RW9YU2hjOVl3Z05YaENPSUJ0SmR3T2doY0Rh?=
 =?utf-8?B?OTMraUc2Rzl1VEdzMTVzMEs0ZnFEcko5djRYaFNDMklVUGROQ1pJdkFRWGNl?=
 =?utf-8?B?dExZSzdaQ1BBdlBKb2VHNWRodkFmSXB0LzVGcGxNd0FhRzIrNEMrUEV4VWxC?=
 =?utf-8?B?TFRiSGN3eDIrcmFKUXRQaHFyQjViVE11RG41VmhWalMxVTREQmRoUndpUXAy?=
 =?utf-8?B?aGdMM1dwSERycGRwUnl0NGtsYWh5cldqNzdKNHhqSndCT3ZKWkFsK05YNkJB?=
 =?utf-8?B?dU9oWTRRenVieDB2M0o0REJmaXY1V1dLQjJ0V0JiUEpvTnY3ZStEdjllN1RD?=
 =?utf-8?B?ekQ1RHN1WGhWZ0dnQXN0a2dsczVZOGVmeUFVZVM5bVFlcHJEY0grNGRhWllI?=
 =?utf-8?B?K3o4Yk1FdUt6OUJ5NW96M0p0Zkp3WU40bFBJc0FLQ2hLQzVFSlVmd2JLbytR?=
 =?utf-8?B?K3dZc0NkUDZMZHNINzY2MkNlVk1LUkRyQ0FpR21UZ1dzdXVmTXJiMm44Q0pl?=
 =?utf-8?B?Wk1MQ1dNQXBKRzJJREc3RkxKZ0p6cDdHRUl2VWo2Ynl2VWljU2NCNWhwVWlu?=
 =?utf-8?B?L2w1N3JWSnlSV1RLMXB5S0hSMnZoSWtFZjdHRmlQcDdMMlcwVEFOcUVFTDNm?=
 =?utf-8?B?Y2lKaTJFR3hnVTVNcExBRGRIK0ZYNUZ3a3IvdEtYQTJrOHhqUU5PUG5mWmZR?=
 =?utf-8?B?dlNBbGIzeFg2Y2thU2tqbHNxTFVUNWZoN1E5c1U1SnNETktvVDhaWVp4S0F6?=
 =?utf-8?B?ZCs3RVpJbmNhMkFENURlZ1BVazRNZzJoK2hYeXI3K3dYV3EzMTIrZCtkRWg5?=
 =?utf-8?B?cFpMNFk5NWtCcVRrY3M1Q1NkYVJEeXM1WDJzbjFFYytoZFlNWEFjMHNlaG5h?=
 =?utf-8?B?dWlXV244MkhySUdBWUVjamp3K1BQRllvb2ZnQjZUOWdOclBiM1RVVVR4a0pR?=
 =?utf-8?B?STdINXJ1dDV4ay85Vm5HSG1mcTZqUzdtQVRxVnE5bWhUVzJidXNVaGExSWw0?=
 =?utf-8?B?VURPM0ZNbXhDRU8vSXR5MDRrUWNvV2hVUmZYOUduaUVuVDdYZzdKSnFNd2xD?=
 =?utf-8?B?b3JBYXUxZXIxaVZzOHpFMDZqRDgwM0hJVjlzUlBpVVpxZkFiR0lNTCt1Lzhw?=
 =?utf-8?B?SU0xNmdIbXFVaVNxb2E4SG0xRmtYUWdQZjk5STQwUUdJbmtldHJPTzREUzFa?=
 =?utf-8?B?NXU3eE4zcnY0V3gwakQ3T3hDdTFrOEJoSEp4NUVkY24yVHN3dmgrNURjeXov?=
 =?utf-8?B?WG5lZXRLQ0VyVUEwMUxmcTQzL0dZeHZOME1kKzZ4MnAwc1hqRkpEWjNtWWd5?=
 =?utf-8?Q?m/nYDfOM+IXO1PUG/ScWfSuAD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cbc1d9-7aba-4e36-7a03-08dbe450e1ec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 14:00:24.6175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4F8Yp+MBgA1Dp8watZKA7ue62RTnkwpv0Cajb7niZXLQRxW0pkuVMAM2Dv9UGIvuJrOl9knxsPppxDGQbISqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::604;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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



On 2023-11-13 14:43, Markus Armbruster wrote:
> Fixes: b65b4b7ae3c8 (xlnx-bbram: hw/nvram: Use dot in device type name)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>   docs/system/arm/xlnx-versal-virt.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
> index d2d1b26692..a6a77b3799 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -194,7 +194,7 @@ To use a different index value, N, from default of 0, add:
>   
>   .. code-block:: bash
>   
> -  -global xlnx,bbram-ctrl.drive-index=N
> +  -global xlnx.bbram-ctrl.drive-index=N
>   
>   eFUSE File Backend
>   """"""""""""""""""

