Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 412717BFF6D
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDsz-0003Qw-3T; Tue, 10 Oct 2023 10:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqDsr-0003QQ-8E
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:38:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqDsl-0002Ks-TB
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:38:51 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39ACMXGp017510; Tue, 10 Oct 2023 07:38:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=MB6LX0cNMH8Q
 ceNNr7tvdhIoWI2AvMQDfANiV7jl5lE=; b=R4jNJhLD30B+gJ3660An3St3137B
 SS8dpOvm9Q/l271fW2mexBNxUVkMIa3sBw9bMJKcdPKn4HpKrBL7KP9MB3Rt+ofi
 QPFwVuEZj8HagkmbeIGzBzA7fhK4gAzkUlm8sotKFYiezjd8zlJet87Nw5rEVPjf
 Z9EexqMrI3t9PCK9ArUizPsC4sI8MljbaGRcwUCwEmuVijUPGmnyJAAqzKLAviyi
 gI62Zx62z/vLoP3lHjF6uqM0E14KmBnYnkjoEXTJml/WBI7cUVphAqH9W7y+zdWB
 iz8hks1tDpYpBL0oL08qinGVMj3+/zpQs6sJ2px6/D1fa+XRUI2FjiSgzQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhu4nmb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 07:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n14nFw65BmaH6Hxz5MluyNz2twA3mShIPqPYOLI4l5mOpHRknBON8GzObE0C6WTFuQAHSReHpLq6fr6I/fRKt4embOdSBqsNe2wFDLzVyhodoQvhzhgElYE6soJaupqPHZOToaW9m6IJrfK0gUFz1XeCTzbBzP4G4uwI8g6/ISXPXZw9Bo7PsoMllF9JFVGf0c6rXJJ/0bDfa+4GHQaAaASRratN0PTf3BuA4iMUBd904gla1bcxJJVzxbPZ/t3bcfQXxicwuBx86+e4j5WoM5LgROKbbjTpKYmY+lg2wGWqQvR1i0aXfAFSfkVPRm0Kv/m8K6IZL2b0gzyR2DMJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB6LX0cNMH8QceNNr7tvdhIoWI2AvMQDfANiV7jl5lE=;
 b=UWOVNhzGQQ55Mk3isYnNceZd56Takk4THoR4+qUOGnJwh+2d2JKpVDRpVJ3n6/AP9S7FPRv00/jVcN99cVQtkkjAT/VbRGA8fmhR4oPEY4nud+cTcJPxyk+PNuHJib0I/erIt6u2oQxYAnl3u3CcNAlqVR7j1O0Ay8p/Z5rs3x+uHQiSECM13DicKU44JWxWQMx8DfCwmbbwE7A9WAixrNfJaJi5UVreUAlJcMoZnNaH48b9QZtCH0iMk8yyumC6WPvkEOdTNpI/DnFt/8PYMN1guffN4YlyEROEImOowPW60B4X74mMhkNpLcHtCvzKTILL3MHmcKw0Zvog/d1How==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB6LX0cNMH8QceNNr7tvdhIoWI2AvMQDfANiV7jl5lE=;
 b=Kt3ftB+gwy691dwLUvHM5zqX9Me6uXSaiKQXkFZRwEP4Dx/OnUnT9Z0gHc5Vd8plSYeRv1oU6clmJ8+GFC5qGO2At6/46lOnWbHAD9l2SZLHHSHkpKMsNVQYxTt9GBivLlqP12W5bUaviZE4mTHo+EQisCqStjZqOs6NLKRT8FIBbh+lNeyt4Ffbiz0MVKfGjIUt91VTAEBOIE8zqiwvwU2BJRdht/Gsaf/DgcL9eP8G5MnJJtvw/PGZ5ksFREJclaxZ2FfDrtG6JostBn9kEHU99HAILVT6QRPZru2q3RCWmN+nVup/O+vXRATdKiSvrNcEQLImxYHLhwbgMKsGbQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB9783.namprd02.prod.outlook.com (2603:10b6:610:170::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 10 Oct
 2023 14:38:36 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:38:36 +0000
Content-Type: multipart/alternative;
 boundary="------------TSFh0fYRIjVbl7LLsZjTXHJy"
Message-ID: <10b5a323-2f94-4488-8c51-07fdfdefc9ac@nutanix.com>
Date: Tue, 10 Oct 2023 20:08:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231009143615.86825-1-het.gala@nutanix.com>
 <87wmvvjymi.fsf@suse.de> <5e59637a-d6ba-46e6-9c28-cc8c16c7fa16@nutanix.com>
 <87r0m2siz7.fsf@suse.de> <87lecasgd5.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87lecasgd5.fsf@suse.de>
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH3PR02MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: b23f4d66-7f05-4e39-f7fe-08dbc99e959f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtJEV3uMvJ4FV13mgoV3G9ob8JznavBHTM2Aux+9GUMhTRd1uGpCh4xc9RxDE5sBlYRTf7nbl+Eizlb8YSQ16Xb0kaxRpcET7fqa7eCY2fkU8HCc7FWBEKg7wND3oOEgzhzCQoiLbWufqSd9KGAWabn+j6gB2nK0XrMTRULz8pDawhF5WtxA2tF8QrYOJ7seKLEfSl7omrt3snDhnr+fesh2oX0+GHsyjdGjU9KyFk+s/vbkJUAIlyjJ8C6dGFugRqs70UUTxLGguoGYhh4dDlf6GfFjvjkSCgVBuyMM8vScJwk569uujIpghrapai4n6I5myYJiYH5LF7NYguoDQ5nhQ5pkTHrAfzJ7qjBB24hahusPy2BcQrv7l+WMYxQuPuYFnvZX2O5JHfaftrlE+pLl1yH0d47fqB7F6uy17fgNYcAVR/VB1VX3Hveh9B81zwssjt5GXnd4BDp7z2oJ8Sm7ubXqsCbhbZfp2ja9d6pXwKgtPyd7fuYFYFwrRCvPUOX201/K2N/UgBo90fY6G07r38LVouGteSiUe2XLLr5J9sMpTWOvnEhJmofJ+lTVkvhjM1cZna/YFpqpZKWjLoV0uhoSSLuAU9ZUFYF34nzuR1gc3znwd4EI2UdbVcLV8tipnD6lfVrskRws1pybJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(166002)(38100700002)(6666004)(33964004)(44832011)(478600001)(6486002)(966005)(8936002)(6506007)(5660300002)(53546011)(4326008)(8676002)(316002)(6512007)(41300700001)(2906002)(30864003)(66946007)(66556008)(66476007)(83380400001)(2616005)(26005)(107886003)(86362001)(36756003)(31686004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhndlRJeEswdVBuQ3VFOVBTY00zemI0UnQ4dFc0MHFhRDQwYnBNRG9jSGMw?=
 =?utf-8?B?NVlGZ085VXdpa2tSZVFzVlFnam9sOFN1M0Z5cUpZdWV2cUdaR3MyUGZjLzUw?=
 =?utf-8?B?NHJFbFQ1RGVZeWRSNDdJbGEvMmNsUkFvdGhqSlJ0TUZ6Vjl6UE85YzFlcWti?=
 =?utf-8?B?cjV4cEV6QXBHL01xVjllSjdjWVhReUVoL1ZMQnFmWW9IcUs4akcweHlyNHI4?=
 =?utf-8?B?ZnZwS01vWGpsQU5uUnprdW5iWXhzMDVINVpKN3ludnF6WndURDVucVd2c3FU?=
 =?utf-8?B?R21adjdkM3JtMEdTNDJ0ZGRKUXZRTjJXLzFUSEt4bWRVQVdwQ2ZQV0lCcXh5?=
 =?utf-8?B?NFpRTTJDR1RKQnViTGlXblQ2ZnljNXUvb2RoRUJwMTA5Rk9ZOUNTSGlHTHVY?=
 =?utf-8?B?S1MyV3l4Z3cwK3IzaDVRclFianhMSGx4QThQM3R3bDA4VUhJR0Q5Qkl3aFNm?=
 =?utf-8?B?UVB2OHByVEdUT3FQdi9oRVRDTDdDZlJpZEh0Z3FiUWdzWm1IR3JKcFk5Kzcz?=
 =?utf-8?B?N1ZnVm82NDRaaytlOWs5MS83UDE0WHh4YUdlQkhFK2ptWTRmSHFuT3FESzla?=
 =?utf-8?B?SDdyRFhWN2NvVEhKeTZkRzFEam9LMW1YTjZnOEtxenFqNWZNZk1BekNVSVRF?=
 =?utf-8?B?SUhEV3kvU0NVWTdHd0JaelE1VWpPY09TUThDRlA2WGtpOEp6NVhtYnV1ZXU2?=
 =?utf-8?B?bW1KMlBkWXJyL056UVBYTFExMUptdG0wRzRQS0tkQ296TWtCelc2a2xpOEIy?=
 =?utf-8?B?cTFsakFadFNHM0ZPQlUrL3I3R3QxTkNzaVVERVlNdmlxRlp3Tnl0Z2VIdCtH?=
 =?utf-8?B?cTlZTitxb3BOVzJ6Zkpzc2J2VVFFYVpHRy9HOVN5S0xLcEdOT0xjSS8yRzJJ?=
 =?utf-8?B?T3NNdW5RcGthUjhSTmRmTzlLVERwRUI2REdPQzdCVkU4MGxLb3FTYmdvK2VL?=
 =?utf-8?B?OHh3SmxSOVViYXRhVWhSd2xoV0pzMG5Xd1VJWS94U3NFRDhyVlNHOWdQTTAz?=
 =?utf-8?B?MElwOWpNOUlRY0Zic1RNbFVNbHVKOWVvSm9FN1JmLzFPVStyZC94dU9JcjdE?=
 =?utf-8?B?VkVpUERvYzV1dm04NFRGbmdkYTNxMVNWTnNJSXBJd0NIZmg3ckVsSTl0L1NK?=
 =?utf-8?B?R1Z6cjkwTGxUb2k1OUFtR3RhUmtiRmRlVHFUeGxvTUhobm1BMmZzTjRNMW1P?=
 =?utf-8?B?NENBeHFOdXpFNk93ell2c2hNMnhoQlRoa3EwNmcxRnBhRE50R21EN3NDbWFE?=
 =?utf-8?B?TjdTYXYzaVBhaXhGR2cyaDA3L05nNEpBTHFnV1FjdmlWVnppc0tSYmxqOVJq?=
 =?utf-8?B?aWdGT0lKVW5ZbmRtSURIdkk1Qm1hU0NJdFA1K0tQNFBEWDR6eTFGTmRET0hH?=
 =?utf-8?B?MEVvaUZMMEJsbWlIc2VmSjFKMkl1VWtobUlURlAwcHhlYjFMZGlBZjl0N1pG?=
 =?utf-8?B?R0tkNWI1ZkFUMXltZWlheXNpSjBJaFptYlIrUnNqSTZuQUZHNkpIdFQvcURV?=
 =?utf-8?B?VnRuckk0dnM2bUt0b2xEN2orR1Bhb3ZGM1BTbjZQODJFeDZkVW5hbnhXcEdG?=
 =?utf-8?B?QTErM2N1Zk5nWkdJK1FZeGhnRW1seWNjdURHajFTcGwrUFpJS2N4VVlXWWo4?=
 =?utf-8?B?MGhYMERLMTljK2Q3WTFEWklkZmEwRUdhZzBvd2x6YytibmRNWWhUb08zaGVq?=
 =?utf-8?B?Syt6eFhFVGxkQ3BMN1VxM0c5dXFLMXVSV0lCNmVJSFFReTR5Y1lweDVFV2Ji?=
 =?utf-8?B?MGNDMVR3M3ZuenhPN3NiSm1sR2xySUxaTWh2Rk5hNTNhbHNuNkRoY2MxNkhL?=
 =?utf-8?B?MXJRRlJraEhnMnhNbVgrWWtsajFVVm5EOGpXSEg5emovNDduUmhIbC9ZeGdM?=
 =?utf-8?B?MUdCeHBac2dHNk85cng5MlJkUVlKWFNpdnI2R21mMEhVeXBwZHcxTmtPbEdI?=
 =?utf-8?B?dHJlSytTTGo5MGU2NUJnRU5tenQzbHZNUFBWOEJPWWVkeXhJazh3MHdLZkVI?=
 =?utf-8?B?cVZQdFFhTmsyTWtHOHk2czIvSlN2aE10YVg0SDFyNGdOSEFremlBVUpHYVZ2?=
 =?utf-8?B?bytDVU9NckZrQnBSWCsxL1dTZVVXaDJnRS9sRERwckhMeC8xb1haajdaSGZQ?=
 =?utf-8?Q?n5mRi7zQ55qZZTf4ehzcBoMcB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23f4d66-7f05-4e39-f7fe-08dbc99e959f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:38:35.6802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23HV7m25GJ0JA4DY4k7H3QgllCFGGT/9eHG19fYeF/mCuoqGAMaxvE9JB4MyjYdSCZvlWtNPtA90IPNlZY2SCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9783
X-Proofpoint-ORIG-GUID: Mczdyk7iJoJ9a1lFnLzo_BDKOfMLdKS7
X-Proofpoint-GUID: Mczdyk7iJoJ9a1lFnLzo_BDKOfMLdKS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------TSFh0fYRIjVbl7LLsZjTXHJy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/2023 7:56 PM, Fabiano Rosas wrote:
> Fabiano Rosas<farosas@suse.de>  writes:
>
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> On 10/10/2023 2:34 AM, Fabiano Rosas wrote:
>>>> Het Gala<het.gala@nutanix.com>   writes:
>>>>
>>>>> This is v12 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
>>>>> for upstream review.
>>>>>
>>>>> Would like to thank all the maintainers that actively participated in the v11
>>>>> patchset discussion and gave insightful suggestions to improve the patches.
>>>>>
>>>>> Link to previous upstream community patchset links:
>>>>> v1:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=OXhp-cq93AZ1ZRIwKL5wXhx5-8ei7RfBdmmbU9KNDfg&e=   
>>>>> v2:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=r7SYaB2fxLcEP2DiHslsbEyaY7ZPrXxageSBRtRZ7TA&e=   
>>>>> v3:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=fnGhJw56ypUavnslnUL6JeK4OLi7xwh7TGsafaSSZvw&e=   
>>>>> v4:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=SA4q18GEE4q3Eh7sy5nhQ8OZO5KM8kfapiBkSPZYDxE&e=   
>>>>> v5:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=QRW_aAGHmTBajBnu1a4jcxQFZ1lf1N3RCyLgOt82Ji4&e=   
>>>>> v6:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=7Dmgm47UdQ0h0Y9-XffsUW_ZdeQ-eCCVzhUkigTMKbc&e=   
>>>>> v7:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=8a3tAfIJ-6st1tlYkbjsRWEv-JvEFxokXzanf0WCqzw&e=   
>>>>> v8:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=4q_F05ZPdhWsPJ0fa850gHS90AsVX7MbsaIHi-3OsMI&e=   
>>>>> v9:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=1wNhJSfSvAoadG06F2JKFHZ2mA4QWSgqvYpt1zRX9qw&e=   
>>>>> v10:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=guEm3FuFn7jutT4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&e=   
>>>>> v11:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=W7rbQhebtuWtT2ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&e=   
>>>>>
>>>>> v11 -> v12 changelog:
>>>>> -------------------
>>>>> - Resolved double-freeing when using g_autoptr in structures that are
>>>>>     nested into another.
>>>>> - Overwriting of pointers to an existing allocated memory is solved at
>>>>>     various places.
>>>>> - Use of g_autoptr caused make check errors in non-error path while going
>>>>>     out of scope inside function. Added g_steal_pointer() in the non-error
>>>>>     paths wherever required.
>>>> Please run make check before sending:
>>>> ▶ 242/355 qcow2 181  FAIL
>>>>
>>>> You can also push your code to your gitlab and run a pipeline with the
>>>> branch.
>>> I tested on my setup, and it passed all the checks.
>> Ok, so this particular test must have been skipped. It's not possible
>> that the test ran and passed since the issue is a very abrupt abort().
>>
> Ok, so I think what is going on is that both your system and CI don't
> support postcopy_ram so this test is skipped.

Yes, on my setup, postcopy_ram is not supported / enabled for now. So 
the test failing is related to post copy, is that a concern for our 
patches ?

I looked at the test logs, and the error does not belong to migration 
failure imo.

>> Try to run 'make check-block' and watch for the test 181. Or run from the
>> build directory: ./tests/qemu-iotests/check -qcow2 181
>>
>> I started a gitlab pipeline with this code to rule out anything in my
>> own setup. Let's see:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_farosas_qemu_-2D_pipelines_1032002487&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=gGMQaHYTLaVYV5pnYVZXGJfYst4XCAmfGs9Ke84e99EZOorbubM8ZScBQq5Jn-Yw&s=kCkY_z43mLb7OTgH_L4cdz8OcmCwo0r_hojI7aCOqZ8&e=  
>>
> The issue manifested in the disable-tcg build in the qcow2 091
> test. It's the same issue as 181.
Ack.
> There's also checkpatch issues. We have ./scripts/checkpatch.pl to help
> with those. Just give it .patch files and it will tell you if
> something's wrong with the patch.

Yes, sorry about that. I am aware of checkpath.pl scripts. I will go 
through the patches and make sure, it follows all the guidelines in the 
next version.

Regards,
Het Gala
--------------TSFh0fYRIjVbl7LLsZjTXHJy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 10/10/2023 7:56 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87lecasgd5.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 10/10/2023 2:34 AM, Fabiano Rosas wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">This is v12 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Would like to thank all the maintainers that actively participated in the v11
patchset discussion and gave insightful suggestions to improve the patches.

Link to previous upstream community patchset links:
v1:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=OXhp-cq93AZ1ZRIwKL5wXhx5-8ei7RfBdmmbU9KNDfg&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=OXhp-cq93AZ1ZRIwKL5wXhx5-8ei7RfBdmmbU9KNDfg&amp;e=</a>  
v2:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=r7SYaB2fxLcEP2DiHslsbEyaY7ZPrXxageSBRtRZ7TA&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=r7SYaB2fxLcEP2DiHslsbEyaY7ZPrXxageSBRtRZ7TA&amp;e=</a>  
v3:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=fnGhJw56ypUavnslnUL6JeK4OLi7xwh7TGsafaSSZvw&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=fnGhJw56ypUavnslnUL6JeK4OLi7xwh7TGsafaSSZvw&amp;e=</a>  
v4:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=SA4q18GEE4q3Eh7sy5nhQ8OZO5KM8kfapiBkSPZYDxE&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=SA4q18GEE4q3Eh7sy5nhQ8OZO5KM8kfapiBkSPZYDxE&amp;e=</a>  
v5:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=QRW_aAGHmTBajBnu1a4jcxQFZ1lf1N3RCyLgOt82Ji4&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=QRW_aAGHmTBajBnu1a4jcxQFZ1lf1N3RCyLgOt82Ji4&amp;e=</a>  
v6:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=7Dmgm47UdQ0h0Y9-XffsUW_ZdeQ-eCCVzhUkigTMKbc&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=7Dmgm47UdQ0h0Y9-XffsUW_ZdeQ-eCCVzhUkigTMKbc&amp;e=</a>  
v7:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=8a3tAfIJ-6st1tlYkbjsRWEv-JvEFxokXzanf0WCqzw&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=8a3tAfIJ-6st1tlYkbjsRWEv-JvEFxokXzanf0WCqzw&amp;e=</a>  
v8:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=4q_F05ZPdhWsPJ0fa850gHS90AsVX7MbsaIHi-3OsMI&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=4q_F05ZPdhWsPJ0fa850gHS90AsVX7MbsaIHi-3OsMI&amp;e=</a>  
v9:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=1wNhJSfSvAoadG06F2JKFHZ2mA4QWSgqvYpt1zRX9qw&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=1wNhJSfSvAoadG06F2JKFHZ2mA4QWSgqvYpt1zRX9qw&amp;e=</a>  
v10:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=guEm3FuFn7jutT4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=guEm3FuFn7jutT4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&amp;e=</a>  
v11:<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=W7rbQhebtuWtT2ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=W7rbQhebtuWtT2ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&amp;e=</a>  

v11 -&gt; v12 changelog:
-------------------
- Resolved double-freeing when using g_autoptr in structures that are
   nested into another.
- Overwriting of pointers to an existing allocated memory is solved at
   various places.
- Use of g_autoptr caused make check errors in non-error path while going
   out of scope inside function. Added g_steal_pointer() in the non-error
   paths wherever required.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Please run make check before sending:
▶ 242/355 qcow2 181  FAIL

You can also push your code to your gitlab and run a pipeline with the
branch.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
I tested on my setup, and it passed all the checks.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Ok, so this particular test must have been skipped. It's not possible
that the test ran and passed since the issue is a very abrupt abort().

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ok, so I think what is going on is that both your system and CI don't
support postcopy_ram so this test is skipped.
</pre>
    </blockquote>
    <p>Yes, on my setup, postcopy_ram is not supported / enabled for
      now. So the test failing is related to post copy, is that a
      concern for our patches ?</p>
    <p>I looked at the test logs, and the error does not belong to
      migration failure imo.<span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:87lecasgd5.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Try to run 'make check-block' and watch for the test 181. Or run from the
build directory: ./tests/qemu-iotests/check -qcow2 181

I started a gitlab pipeline with this code to rule out anything in my
own setup. Let's see:
<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_farosas_qemu_-2D_pipelines_1032002487&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=gGMQaHYTLaVYV5pnYVZXGJfYst4XCAmfGs9Ke84e99EZOorbubM8ZScBQq5Jn-Yw&amp;s=kCkY_z43mLb7OTgH_L4cdz8OcmCwo0r_hojI7aCOqZ8&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_farosas_qemu_-2D_pipelines_1032002487&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=gGMQaHYTLaVYV5pnYVZXGJfYst4XCAmfGs9Ke84e99EZOorbubM8ZScBQq5Jn-Yw&amp;s=kCkY_z43mLb7OTgH_L4cdz8OcmCwo0r_hojI7aCOqZ8&amp;e=</a> 

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The issue manifested in the disable-tcg build in the qcow2 091
test. It's the same issue as 181.</pre>
    </blockquote>
    Ack.<span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87lecasgd5.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">There's also checkpatch issues. We have ./scripts/checkpatch.pl to help
with those. Just give it .patch files and it will tell you if
something's wrong with the patch.</pre>
    </blockquote>
    <p>Yes, sorry about that. I am aware of checkpath.pl scripts. I will
      go through the patches and make sure, it follows all the
      guidelines in the next version.</p>
    <span style="white-space: pre-wrap">Regards,</span><br>
    <span style="white-space: pre-wrap">Het Gala
</span>
  </body>
</html>

--------------TSFh0fYRIjVbl7LLsZjTXHJy--

