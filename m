Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F7A709424
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwn6-0007jd-1W; Fri, 19 May 2023 05:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwn2-0007j5-Ey
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:52:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwmy-00010Y-Iw
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:52:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J4mKOQ015301; Fri, 19 May 2023 02:52:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=P0iiX00Evdv6kE7t9EGSzdGB4YRIpa9+pRHxwhZ1Jig=;
 b=G3yVcMz0sB/yvTH7PaejnCAJNFhv2syTie324nh1mGbsEUeWeaovjnCtE21I206zeNcm
 ouKnlLsb/9YOzjNw35NUSdjoBxiSXdn5JQ7vrRP+ukw9Sn3TiJfOceY1JKiwXbteCWkb
 TT7wYdgZIoVPQ+8D1b9cbhsH/OLQ0TWrkLz2HAPpS7DpWRUziVmwa0+ohPcakkTA5ET+
 Scq9+qlXNtokOEGNxCxR5w/h6OvM4QWXa4fTq76fHM5YXXotscH0+YROX+koQLC7Pkxl
 mm1hJKRTp7j6T+Uwd2LqTTTQMXlpYVoXYWYgxhyRk31EOppmSIRDEf4eDgESx3mnV414 RQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmvtrdats-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/hwyA9tx+KhMcs35QsTloTE9Aok/5bTIbm4rTvtYuSA/6KyLMu7Qx87GiF4XvNEY13rRCVOfqo4MwAjwqTWuidzsbAyRxm5XvfPb7CdPP4QaEVP+MrKhPzy1tMRnezBTKWOpTi37mIJnytci8yddNvorujB/X0TQkTXM4t1TxbRju6En2w3Jyjnz4w9RwMFEsbjYjWFcBAO8C5IJ+/aSXRRNh9TwbKlQuVma5sbwTWG6t034PHINlvfFDUuPonGgIKMldDP4B37Xc3xxzsHBZNKyL2rPYuJyfl2AmNLdkV2ZL3RFOgK7pMDiLRs7qP7pAPBxaH4vGFpXXo1Tm+thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0iiX00Evdv6kE7t9EGSzdGB4YRIpa9+pRHxwhZ1Jig=;
 b=UFpHUir8Iu79KeRj5o2hu15vAcciE55cP6eRMyJ9lEE4eUgRMkfnSjWxe62hOi/1s8KSqx1kIhv40jv0clhvHa9zBnDJlpuUYlGqYkI6qSAn99J5sBdgweMu0x+qgZr8+gfOnr5lm3EI3fZkaATjTWWg3bWm6uIth/FLAC9Ou57pwvyfjjRXzCmH7hytuWOypLMS5DCPxI++GjQ6lJ/ZwfPLKzsug8R5FdPQPsmOKC6axobxEfbImyJFs+ME5C3ovAKnlbiio6CIArYS42z3W2dmwmt0OqTCR7346z1EB3QKAT0zoMfwegtJFvwPbsfcDzIeHx7D4Gq4ifrjauJsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0iiX00Evdv6kE7t9EGSzdGB4YRIpa9+pRHxwhZ1Jig=;
 b=BtgB2sZqUykKs8TlqgTM7kxKI6LG0spyYcOhgmWSNGubhGgTTiuMpi8UELrlbcCoVvwZiPLgq+tKLQ1FBitRFCGbqTCH/BcI0zhz7kdLnK+p7tbWQaL7YJa2kmnzg/YXm0RiNAogxXTuOVRTJ62ax04Nl8Yr27lWHwQ3e7tfUUDot3KFSVWhwRByGI7Q2vqs1RsZLZOlAkBs1vBkgSP+lUCh30X/hIc0W8dTHhnb9SjROd9XAo5j+kg0JmJyDTR+MgglNLNR2grXILU22p6brw7lNp2BdkXkjGIHBuDZ59fFd8QiclMJx9M8BC+OXbrIkiI9/mb85Yd3vxwg0dVy2A==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH0PR02MB7946.namprd02.prod.outlook.com (2603:10b6:610:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:52:39 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:52:39 +0000
Message-ID: <d8224d01-4cd2-11eb-fc53-9b8b3d815a1b@nutanix.com>
Date: Fri, 19 May 2023 15:22:29 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v5 5/9] migration: convert exec backend to accept
 MigrateAddress struct.
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-6-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20230519094617.7078-6-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH0PR02MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 93443c65-640f-47a8-d37a-08db584ec7bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wFB+xgItNoAbcO0wvIw6t+dYEU6jx6Au3on5K0ZKbaGE0dbvYaLJzlmpvk5bbqz84zuufFe2++gkJZhS3n9DxhCcCrv3HORaG1RS9QSV73gzdMMxWigBV8SFm5VBhUfrmm/vPNCwu5oE3NEB03UJT1OycvUgCBnBFvIVTJSrAMhecfDjSi6KKCgLexumuD9Rkcfkq4LjX7NCdvzzACC+f/ln8Vsky6U+Wgypt4HYw6cLsj+AS26aLDF+6gAXjPGn8Q1WV1m2rh4ZjiI98I7E4QunYvH+2UZ08bKcozKwU12G4+kVoJGR99NNZmTALMT9ZR9ozkqWnEvpA1q6MomPRrtf0MsIKRLBDVPw4LbfSSxR+Alr7mhqlL5XR3l2QfCKAwUMI+9IPcLsyZZm3tAcBu81eW2oDSmVsX0xC8cUmjqBZ9GXVSOvm2Brwr4Ve6IjWmW6x6+mH4kkaJvQ4xP8CDRWCHFSWRO6kfO3G2dkIGFj47rhEUhtusLofbQcb4y6ZpYnOZ6c0HtovYWQSYY9uy2LoB17vQpetwI6Qfl+jClr4CIqru70aWyneMPZGLLGO6IqjS3IuFYmldjHbui2ZLgH145+EY0PqAh61X2TC7uybvS6CIi/6u29Wn6v+SFRCgBwOVk+xyLs68RYYxN7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(31686004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(316002)(86362001)(31696002)(36756003)(83380400001)(6512007)(6506007)(26005)(107886003)(2616005)(186003)(53546011)(41300700001)(5660300002)(8936002)(8676002)(44832011)(2906002)(6486002)(6666004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3ZreFhSRXJtelFhSFJWNkJkL0g1d2E2V3Z3SkVtQTU2ZXhtT0FSdnozcXZO?=
 =?utf-8?B?Wlprck4zeWZVVWxNdGdYOGJCazluN0FNVGpUNW10V2ZOTjRaNlR4OEhkb3lX?=
 =?utf-8?B?RGhyOGZRU2Y1dGNEUTFoOXZMOG5HYlZub2l1V1dlK1Jla0g4anpBNDNTVEZz?=
 =?utf-8?B?b1oyWWRGQ1B3T2NwVzNRbGlOeFV4ME1xVlVqbVhQWmJBT1dJaFZWZzlBSFBr?=
 =?utf-8?B?MjRNcFcrVmczTlVBQ05aem9GUTV2TGtUNmQ0L0F1Ny82VlFsMlhRWWczWEdM?=
 =?utf-8?B?SWVxWk9VbmtFK2owRUpIR00rYUJGdVowSGh3bzNzS2cwSkRnYlBzbFVtejV6?=
 =?utf-8?B?QnRWTW1lQ1N4M1ErZ1c4Z1FBa0NvYjZwZnRPd0hvdXdMV0lUL1dsRm0yVU92?=
 =?utf-8?B?TmNKUkE2TmQ2UTcyMUhpb3RndTNXODQxZ0FBUjRsb0lveTRmTW90Wmg0WnRi?=
 =?utf-8?B?QzFERTlNaHhCZjFNRkhISE5aUXAwaGJLQURucjF0enRTbWNLNVRwWW5vbmZS?=
 =?utf-8?B?SzI2TVBBL3NGZTdyS29YdnVSK2thVWFUZ2NMcHdtbkc2eE1mRG4zUCt0dHRi?=
 =?utf-8?B?MTRob21jMmZwanFZc1hoY2QzQzN5YjRHaDRWZko1anNSZWxoNFAyYy9kWjBD?=
 =?utf-8?B?a24ybUU4K3REV2pQZ25wOWFIV3VxR2tGQ1JuVFB4ekl1cGV3dk1EUFlMa3FD?=
 =?utf-8?B?eWFFRTd0RTNob011OVBCa1BOMFB3TE5hRE1Wb2czQ0ZPM1U1YnlVOHhqaDlK?=
 =?utf-8?B?K0Z3U1J5UjErekxESnVMMzNscTF2UTlVUWRPWVBVaXFnRWIwallJbFo1eHgw?=
 =?utf-8?B?UGk4ZXdSSTBHKzZscUFkcHVHbkM1QlVNSnBkNUlFd0lIY01nTWpTUEY1NGEz?=
 =?utf-8?B?aEQwaThxdnpKK3RCb0t1QkRwRW5VSE9URGdlTDdyK2M1NGpYREJWTnN0eW1V?=
 =?utf-8?B?VGZRbFJITUMrVXJzRVRiS2RpSTBOREM0R1Fyckc0bVFhZmVITHJJTXpHU0Nz?=
 =?utf-8?B?ODIwSFhmSGhhdXZrUHAyRXhXYzBYa00wVTNOdVRURWMwdnNzL2R3c2I3T04x?=
 =?utf-8?B?QXdla0dMOHNmcXZOOEcvZS9QNy9ZSDhVazZNK1lTeFR1VjA0THZicnpWdElm?=
 =?utf-8?B?R2w3dWpRbDhxQVhhUndPdEg5L2YzN0VyQ1pCQ2NYSFI2QWRCczdKamtuWkxR?=
 =?utf-8?B?cmdHY250VEVhS2xyU3V0YlVlTWFHRXA3RnhLcVVvZXkrZEtJNEdJcHR5cWo3?=
 =?utf-8?B?bGZwVmJ3YTRRWUlIR1F1YnVSd1pEUmt2aE12ZUlDalQ1QnFDTWdzTEVaTVB3?=
 =?utf-8?B?OFo2dmhDZDREci9kUlVveklQL2szVHRuZHN2RHNEdU9uVTF1cjRpWTN0SVhH?=
 =?utf-8?B?N3BqVDRZWVBLQ2plK3RiOFZQQ0RkZHRHSGh3a011cDhXcFUwZmxTTjNVOXds?=
 =?utf-8?B?YjRveFN0OWk5NURyblZzTDZtY1ZleXRwYUcyYTlvcjlqYjlqUENhSEdGREZm?=
 =?utf-8?B?Y01hczJMK28zNHRveStDWFJTUVBFQVZ1b1VwR3kzM3dDUmtXeWEwNi9COVFn?=
 =?utf-8?B?RklrM2NNQnlXZ1ducFhSRnFxOW1VT0VvV2pXNWxKdks0VWJPS1FRbDVRVEpj?=
 =?utf-8?B?eHZ2b3pCWWNPNVNJMWhmMFhXOSs0VVBweVFIVXZiYjNwalg3b20zV3loWkc0?=
 =?utf-8?B?Z2gvY3RGL09LRU51ZXNwb1NCYUJVMGJteEFKOE5EUHlVWTNBdnRqakZ5TDRI?=
 =?utf-8?B?N2huTTRZeFE2aFdESlZMODRLZlhub1pzUDFDNXA3dFp1SGEyN3k1eDB4UXJx?=
 =?utf-8?B?ZVdwNW00eThFNlVab3l5RlUvOEJMSmJSTDhHWnNjY0RJSHZsTDZaekI5OEhl?=
 =?utf-8?B?dmcvdlk3ekw5ZkFyc21nUjRVdXV6NHFQaUZXcGpLYlRaYktOaXpQaldDTU15?=
 =?utf-8?B?a3NNVzA5MFozVTNNOTQza2RkQm1xei9oeGFhUkJJT3FlT0NwM1VzVkJydkR4?=
 =?utf-8?B?Y0QvYnNsWm85Vk5xWk45ZDFudFFaeW5MaUlwdTBmNWx4Y3NaT2pKVlpJMnI2?=
 =?utf-8?B?bCtlelNqWjAwNXovV0FwRGFvbmk1eDNIMzcxcVBvbWRuVTgwNkNnU0szUU1V?=
 =?utf-8?Q?6tNdsPdiGh0V5+0oUIp2MGiW3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93443c65-640f-47a8-d37a-08db584ec7bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:52:38.8913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrhOuJGVwTMr3XxJm9+XknFz1m5Tj2zMvSjQYLmGHgxZuGYV5iS+dIt+ZSiiTP7+I9JmRbpu+HmNZZb7Z5n6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7946
X-Proofpoint-GUID: 9togdol4P-QY_-sRBzqiFMJMuRpXRAHe
X-Proofpoint-ORIG-GUID: 9togdol4P-QY_-sRBzqiFMJMuRpXRAHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 19/05/23 3:16 pm, Het Gala wrote:
> Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
> new wire protocol of MigrateAddress struct.
>
> It is achived by parsing 'uri' string and storing migration parameters
> required for exec connection into strList struct.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>   migration/exec.c      | 60 +++++++++++++++++++++++++++++++------------
>   migration/exec.h      |  4 +--
>   migration/migration.c | 10 +++-----
>   3 files changed, 50 insertions(+), 24 deletions(-)
>
> diff --git a/migration/exec.c b/migration/exec.c
> index c4a3293246..a4f02b207f 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -39,19 +39,47 @@ const char *exec_get_cmd_path(void)
>   }
>   #endif
>   
> -void exec_start_outgoing_migration(MigrationState *s, const char *command,
> +/* provides the length of strList */
> +static int
> +str_list_length(strList *list)
> +{
> +    int len = 0;
> +    strList *elem;
> +
> +    for (elem = list; elem != NULL; elem = elem->next) {
> +        len++;
> +    }
> +
> +    return len;
> +}
> +
> +static void
> +init_exec_array(strList *command, char **argv, Error **errp)
> +{
> +    int i = 0;
> +    strList *lst;
> +
> +    for (lst = command; lst; lst = lst->next) {
> +        argv[i++] = lst->value;
> +    }
> +
> +    argv[i] = NULL;
> +    return;
> +}
> +
> +void exec_start_outgoing_migration(MigrationState *s, strList *command,
>                                      Error **errp)
>   {
>       QIOChannel *ioc;
>   
> -#ifdef WIN32
> -    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
> -#else
> -    const char *argv[] = { "/bin/sh", "-c", command, NULL };
> -#endif
> +    int length = str_list_length(command);
> +    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
>   
> -    trace_migration_exec_outgoing(command);
> -    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
> +    init_exec_array(command, argv, errp);
> +    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
> +
> +    trace_migration_exec_outgoing(new_command);
> +    ioc = QIO_CHANNEL(qio_channel_command_new_spawn((const char * const*) argv,
>                                                       O_RDWR,
>                                                       errp));
>       if (!ioc) {
> @@ -72,18 +100,18 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
>       return G_SOURCE_REMOVE;
>   }
>   
> -void exec_start_incoming_migration(const char *command, Error **errp)
> +void exec_start_incoming_migration(strList *command, Error **errp)
>   {
>       QIOChannel *ioc;
>   
> -#ifdef WIN32
> -    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
> -#else
> -    const char *argv[] = { "/bin/sh", "-c", command, NULL };
> -#endif
> +    int length = str_list_length(command);
> +    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
> +
> +    init_exec_array(command, argv, errp);
> +    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
>   
> -    trace_migration_exec_incoming(command);
> -    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
> +    trace_migration_exec_incoming(new_command);
> +    ioc = QIO_CHANNEL(qio_channel_command_new_spawn((const char * const*) argv,
>                                                       O_RDWR,
>                                                       errp));
Not sure if the type conversions are 100% correct, maintainers please 
advice here on the patch if I am missing something or something is sort 
of a bad practise for Qemu ?
>       if (!ioc) {
> diff --git a/migration/exec.h b/migration/exec.h
> index 736cd71028..3107f205e3 100644
> --- a/migration/exec.h
> +++ b/migration/exec.h
> @@ -23,8 +23,8 @@
>   #ifdef WIN32
>   const char *exec_get_cmd_path(void);
>   #endif
> -void exec_start_incoming_migration(const char *host_port, Error **errp);
> +void exec_start_incoming_migration(strList *host_port, Error **errp);
>   
> -void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
> +void exec_start_outgoing_migration(MigrationState *s, strList *host_port,
>                                      Error **errp);
>   #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index b7c72fafc9..0a6ab9229b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -465,7 +465,6 @@ static bool migrate_uri_parse(const char *uri, MigrateAddress **channel,
>   
>   static void qemu_start_incoming_migration(const char *uri, Error **errp)
>   {
> -    const char *p = NULL;
>       g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
>   
Regards,
Het Gala

