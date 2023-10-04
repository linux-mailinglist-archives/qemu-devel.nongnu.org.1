Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA27B8140
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2Cn-0002Hy-U0; Wed, 04 Oct 2023 09:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qo2CY-0002Ap-TQ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:46:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qo2CO-0008IM-6Q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:46:10 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 394B2toK028855; Wed, 4 Oct 2023 06:45:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=dGBpJJ0ulu/QTqmF+hyKtJnlA56Kus2e0vZTJcrIz
 Jc=; b=K0UEQvtZL05HW2zwoCu/rX/uqEigNM0/Eb7KfA3avpMIKaF6F9hE18C/x
 eiuiIwm8f5uA7U+aUDwE2sQ1JXeAJNd6B5IohoOk6Lnsxk0EhkOdJti3xFcVMkw7
 NPCN/nfhMOgSipkVPVMh4slE9ya44sctzI8d0eBN5HUJF7OD6i99s/kGcp5afSDn
 l1dwrgA1SMHpZgtEwhnKJCNAsxeTIXTMVtbUSmkitkySLafEpRbA7vyIcV52dmwJ
 zxJGgzx3rA25Xri1QVP2D0B+pSivSz1FAU0jeruv/whYAMDPuRm++9q1K1GX7ohm
 Hh0TbulEoKyetDIT4rGKVIEgvkjog==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3teg0rqar8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 06:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZgI6IKDdJjiOfMk6oG1UIdoK/8MFpsVEAbSmRAKvfQ325zqn2Cz+mKqZ7w/Y6nO1V6yOXtf5AMJ4RnEMjqknmIi4wvxpfD4inpkHivKAOji5UFa3E8bURLQqVjBNre5ek9whYZfyFIPjJ/Xt+V3YGGa6NoQjdKBqveuvyXNUxi4BwwfjQuLHXpcdKAOI+WNmDrSurPwMQ1v2JT4EJMBP9mDLky+ZfEI214mUosuSkzB/6+X0DAzRNbmyUbjBaR0S4S3oTEd9/DXv6SgswLTBcVOrL2TuCZM9EEXM4qosgzx9LtVtrNj5mmStJvbYqjK1GnDYMiH0uYPg9r7Y29uFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGBpJJ0ulu/QTqmF+hyKtJnlA56Kus2e0vZTJcrIzJc=;
 b=dCNLusUSkmekcQl5dUzdNzqpKlJjVdgmJjMy3ylbak+lw8TZCqVqNKPWGOIUjN+UfUcdjcOesbT5iSxQ9/u3Uwv/jcY8yIQ288msGLUbR3VucDP27PlrVO3PDCBtx/DvjQg5bVDT/EPjSIRz//KbV+E79xDTcXKV9Ii7IyyZX1CnC3WisyWC7WVrXfDgMt5hARjosvDvm+kjVoU9dpf2du8wVGoUcggOo1z0xyy5E5HKa+mXBkpx2cKJzShqKpVodi6bwzYMcNR3gsoV2+dxK1RyfYxepdCGZEF0Fc+T9R7oL9w6k4/S56Wt7E2P8bizzMf1ydWPJQCI3y26VsBSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGBpJJ0ulu/QTqmF+hyKtJnlA56Kus2e0vZTJcrIzJc=;
 b=NDlmiKek9c5IbVQueShUwb59siNjqS+6Vd1p2yDKE/ij1wVbrkZrbLrKLhSH0VpHc89k3dJQ+ZQGBegSiW9WyfDltEfG/xFmd59a0/m+/UYseh7BUxTSOArG0K8xThrfH2NQrnOxhLE2A60QqAS1T3DIzmrSm2zX1vxMnU60MUkUn0sAitqIPk5kN3COmKS/qOG3Idsth+lUwR3ZyVQJB93tVpzhRfqvBYVUn8tK64pilILwP4Z8Mx0vLBiwM4bZwEvspQFNY+xmCijLHcV6iF/KH4Fd30b+5uqpIQ9/LHli9t7p3ts8RHN3wJX0cVA9L71iKUg5cwzFVbSm8iD4fw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA1PR02MB8898.namprd02.prod.outlook.com (2603:10b6:208:38a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 13:45:53 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 13:45:53 +0000
Message-ID: <ec1a8f2e-ec10-46e2-1a2c-1ae593080ad4@nutanix.com>
Date: Wed, 4 Oct 2023 19:15:40 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v11 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <871qea5x7w.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <871qea5x7w.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::24) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA1PR02MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c62f7b-00a4-4a53-4e09-08dbc4e039f8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IulSIVwQK7sC3jCXlYcwYvMHsZkc7grr8xUr4orICesd1N2MCNCOfqxlIgjUDypsDYolpA2Oj+PBauN6N9Fk7DntQXQrluxja5pU2gdIrcMIrDcTjmToNPGTzwRs/eqYqMjR585pjmJ6JBuxpTEYxxXifVZQnLPJHM/skCbXaKLnr3NWJDCZuqkaW2ZyANK88UFfF2KD18voIN/6Diw1I47VNGEEZtNzXaznw+G7BMISjLqiduokkq1IsLPj1vJqTEGwnFqriHs9BcEoz7uxKngOJFEBDCvKUtkN4RAasc7F7HpwVCKurel+mj//vYrzqXAR3XaIAHtuRnW8KYZFkvvsAIk7bP66rZrUtP3A6gNLRDRk4dpUYli0+05ZGxozJX43AFCyovX+HLEj5rkiD4MkAN7+apcBLFAmMJvN2fLMDp/Ujm8cVhfLrgO1LGL3lSpvfZd3oBDmVgTztTv0qTAwLUPD6JmKBXqRprq9wbDG/oWYJGz4GujVef+2sBlyLthE8dsD5rk4ZYWKzftngEl7t3USrN+n6dXGJwcoSfkjEbGAZpSKhHvPH/33kCvxDMpu+iaK/ah1i5fHfqWbiZbsciyWwfbSwrQMojBBl01e8PCbptlSQIqF//FMYkhHVEvRPgBzXuBcLo6ju7/Rqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66946007)(66476007)(66556008)(316002)(38100700002)(478600001)(966005)(6486002)(6666004)(86362001)(2906002)(36756003)(31696002)(41300700001)(8676002)(8936002)(4326008)(44832011)(5660300002)(2616005)(26005)(107886003)(83380400001)(31686004)(53546011)(6506007)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1JnUUd4ZFl6M2xEQUNQTHJqL2tYQ1ptM1lYZEY0Y0FEalRjR0dSc1hJUEJ2?=
 =?utf-8?B?N1FCWDdKZFlsek1iNFozVlhpZU1XOU1NMUt4Mjlzb3ZGcTFPVk4xT1pKeDQr?=
 =?utf-8?B?cXBzNFYwR241VHB0NXRPbWxMSlc4TERYVUxwU29SU3RRalV3a2JwQnBGdnpa?=
 =?utf-8?B?WkhERmdueW5jZnB5dm9TZWhucGV4VzRDbjF6YTh3dGFGSytNMGhTTndEUWJo?=
 =?utf-8?B?b1BWcEY3c2NVbXRHbnVkZGtNM1pSYkNnTmQvLzJlRjZqQVhMdmdoQVQ4YnNl?=
 =?utf-8?B?UUpjL1V5NzlVTFpJY2hEUEl6VlYrWkd1UUxKaVZLeEdoWkNsSHVubDFNSDk4?=
 =?utf-8?B?UC9JM1V1K1ZNeHQxaHl1SFNqMUR6N3E4TGw3MW1HT1NmSUp2cnY2OWowcThJ?=
 =?utf-8?B?bmF4NUt5OUhoZEI3UzdyeVk1V2s5REFKc2VNZjN2bUIzQ1BTdUMvVWNxcml3?=
 =?utf-8?B?NTAwQi9wVlFpaVdxeVFSRy81TVRRc1dMZzQ5ZHlCdTlzTlRBSzRtTjc4UVNm?=
 =?utf-8?B?Q2REQS9nMys4bktrMjF0QkpjUkRoMmEweTFYM1YxSjRwbGlTbVJFQXlQL3Yw?=
 =?utf-8?B?amhwOVJhd1BVczRYSTFQb3FZQTJoZFBZL0ZnelJrWm1icTdvNklOMHhOZWFn?=
 =?utf-8?B?Z25GTDBsT0lsNzBQWnpzR1oxNnNwWWg2eXRsNVpYQ3A1YUxCb3FKcWZaYTd3?=
 =?utf-8?B?WGJlZzF0VC9DaUttRUtGOXVzSi9xZWZtSXQwMEdTd29HRCsxb2xSWm1WWDJP?=
 =?utf-8?B?bkVUc3VBemZVSEtaRHBLSUxLRUtJcUkrK1cvaWtPem5XeW1QRnlpMUozbzJu?=
 =?utf-8?B?L2pYN2s3Z2d0eXIxSk1HTUQwMWhmVDdOMHQ0RTFmdzl4VWZCUlBNTmZna2pF?=
 =?utf-8?B?Zno2cFF1dDlIbnRPVjJwczkwa1p3Zm0vRHNRSVpOTFVSdGNwbmRiZ0NpM3Np?=
 =?utf-8?B?VUxuekhsRlNpRmdTODduMGVubkt5Z1Q2bm1ZajYrZXdCQ3diMmFqcjFFVmZ1?=
 =?utf-8?B?cWc4UlVkWHFsT0gzbVJuaFRwSmRsWFFOdzNLZUhpY3hwN3hrazdvdmEzYkMv?=
 =?utf-8?B?SHFBZGwrUXVvWkN1YzRzVVBEY1VWNEpBUTBEWWpzczFrUngycDVaRG9iRVc0?=
 =?utf-8?B?Z2o3VlZYb1ZjUDVXZG43eDJHeTloZXFwVWN0RjZwb2V2aXFkc1RzWXJaRHNZ?=
 =?utf-8?B?M0NiOXBMblMxTUEzS2RFYm9aS013MEljK29jelIxUE5yWFBFUE8zcHJ2cWZz?=
 =?utf-8?B?NVNwYU1GdER3MHpIWHhPaElnZ1A1MTl6eVhHMStmQ0VQODNFc2hDVEs4eVh0?=
 =?utf-8?B?NU4wY212b0hXZ0ZXR2pmSGRaWnJpSWZiRHdpWENXYXlVdnBaZWRkRDhnNVJy?=
 =?utf-8?B?NjhvRFBNRDV4SHF5VG1SRjZpc2FNKzVmc1V3ZjQvTG4rbEl4ZlFlMGQ4R0tL?=
 =?utf-8?B?M3RnUjNzczJHNGZoTHpVaU5YTnRMZGNUL1BuYXpnODc3b1JMUW5zaFJvNkZ2?=
 =?utf-8?B?WEh4cEVHU0tqWFBnaGlRMnJzYlkwQzFTVEtLdEp3bTZwZEkzeXpnR2duUmZD?=
 =?utf-8?B?cGswcndoVEVacWN0dlk5YUxuMnhyT1IyMzhzcGpJSDhTR2JIRUhKcFo3blBo?=
 =?utf-8?B?bnM0cFlQNHB5ZnZlSU5ZeU9QaGRwY0VQcGMvajYrc1l4S2tUb3BQbDVQZDVj?=
 =?utf-8?B?dWUwem96R200emwyckVRdkRBWm5YbEdRd0N2bUI2eWFpYjFaSVE3MUI1UVpT?=
 =?utf-8?B?eTVmZmxRYUYvMDBOWllHdkNnY3JyZUZyeTFpNWRkYTlwWFczZTlaeThtaC9Y?=
 =?utf-8?B?WTE0SjNOR2NseVp2VEZjTVI0VFMvV01aMGJJaVdVR0JsN3ByNWRaSXd6TTht?=
 =?utf-8?B?SXhVVXlQY1RUYVdKdU8rd1M4OFh5UmZPa1BBS3dzczYvSW5KeDdKMEJXSWJS?=
 =?utf-8?B?ZStiRVZUa2Q3OTBQNXdwaU5adnJMb2lTME1JSnM2S3RzMmgvMjFidGgxREx5?=
 =?utf-8?B?N3I0L1ZjUFpmV3NwY3RFbURkQkFiMlYrRmc1ci96S1Q3RTJJRVpuMVlFcGJz?=
 =?utf-8?B?bHFQWW9JSFIvNkx2b2M5TzFLbUhubjEzcDVFbER4U2dqNXhXOFF3UUkrYmo0?=
 =?utf-8?Q?YpEmuBrlQ3Gp0dfg3k8xi+cxz?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c62f7b-00a4-4a53-4e09-08dbc4e039f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:45:53.0896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsExn0tluqsMRYN+xWYrGhz/1tpoyU6WTZM+aWSrGy+M2Wb7DDtrf3hfqleO6oHjLj3DrFzO3ZLLq1nnSaqw1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8898
X-Proofpoint-ORIG-GUID: HG6CevGy41DVep-hdAYN0p8Xrf2L_LO8
X-Proofpoint-GUID: HG6CevGy41DVep-hdAYN0p8Xrf2L_LO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 04/10/23 7:03 pm, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> This is v11 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
>> for upstream review.
>>
>> Update: Daniel has reviewed all patches and is okay with them. Markus has also
>>          given Acked-by tag for patches related to QAPI syntax change.
>> Fabiano, Juan and other migration maintainers, let me know if there are still
>> improvements to be made in this patchset series.
>>
>> Link to previous upstream community patchset links:
>> v1: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=jsRvKRy1JOiy05KX1CtLqWN1su5XNmKPKuJTSx5sZpU&e=
>> v2: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=mzt3n5PD1QclHfpZEh-VMoLkkwT8xqjPYN-1r7MOly0&e=
>> v3: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=fa9W71JU6-3xZrjLH7AmElgqwJGUkPeQv3P7n6EXxOM&e=
>> v4: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=Xr1y3EvBzEtWT9O1fVNapCb3WnD-aWR8UeXv6J6gZQM&e=
>> v5: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=OtK10W2Z0DobrktRfTCMYPxbcMaaZ6f6qoA65D4RG_A&e=
>> v6: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=XH-4qFQgdkAKmRsa9DuqaZgJMvGUi1p4-s05AsAEYRo&e=
>> v7: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=RwvfliI4wLm7S0TKl5RMku-gSSE-5fZPYH0MkzJdoPw&e=
>> v8: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=BZsKBJGVPDWXwGgb2-fAnS9pWzTYuLzI92TmuWBcB3k&e=
>> v9: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=YcWFU9I2u-R6QbVjweZ3lFvJlllm-i9o5_jtLBxC_oc&e=
>> v10: https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=DwIBAg&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=xuVA--dLVo9lijpitqSt7EOEzBGpEvigXGCb9p_MIk0xmhQZ8bPasLgZ2aOlEBcz&s=JQt63Ikbz21vmsLmSensQu8zknGuS9bls-IFpndor78&e=
>>
>> v10 -> v11 changelog:
>> -------------------
>> - Resolved make check errors as its been almost two months since v10
>>    version of this patchset series went out. Till date migration workflow
>>    might have changed which caused make check errors.
> Sorry, there must be a misunderstanding here. This series still has
> problems. Just look at patch 6 that adds the "channel-type" parameter and
> patch 10 that uses "channeltype" in the test (without hyphen). This
> cannot work.
Ack. I will change that.
> There's also several instances of g_autoptr being used incorrectly. I
> could comment on every patch individually, but this series cannot have
> passed make check.
Are we allowed to run the make checks ? I am not aware from where these 
failures are arising. It would be helpful if you could point out to me 
where g_autoptr is incorrectly used ?
> Please resend this with the issues fixed and drop the Reviewed-bys from
> the affected patches.
How to verify which are the affected patches here ?
> Summary of Failures:
>
>    1/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test         ERROR           0.44s   killed by signal 6 SIGABRT
>    7/418 qemu:qtest+qtest-i386 / qtest-i386/migration-test             ERROR           0.47s   killed by signal 6 SIGABRT
> 121/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-swtpm-test     ERROR           0.55s   killed by signal 6 SIGABRT
> 128/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-tis-swtpm-test     ERROR           0.72s   killed by signal 6 SIGABRT
> 131/418 qemu:qtest+qtest-i386 / qtest-i386/ahci-test                  ERROR          12.53s   killed by signal 6 SIGABRT
> 134/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test              ERROR          13.04s   killed by signal 6 SIGABRT
> 143/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover    ERROR           2.95s   killed by signal 6 SIGABRT
> 147/418 qemu:qtest+qtest-i386 / qtest-i386/qos-test                   ERROR          16.12s   killed by signal 6 SIGABRT
> 148/418 qemu:qtest+qtest-x86_64 / qtest-x86_64/qos-test               ERROR          16.15s   killed by signal 6 SIGABRT
> 177/418 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-swtpm-test         ERROR           0.55s   killed by signal 6 SIGABRT
> 180/418 qemu:qtest+qtest-i386 / qtest-i386/tpm-tis-swtpm-test         ERROR           0.59s   killed by signal 6 SIGABRT
> 197/418 qemu:qtest+qtest-i386 / qtest-i386/virtio-net-failover        ERROR           2.38s   killed by signal 6 SIGABRT
> 305/418 qemu:block / io-qcow2-181                                     ERROR           0.52s   exit status 1
> 312/418 qemu:block / io-qcow2-060                                     ERROR           9.89s   exit status 1
> 316/418 qemu:block / io-qcow2-203                                     ERROR           0.84s   exit status 1
>
Regards,
Het Gala

