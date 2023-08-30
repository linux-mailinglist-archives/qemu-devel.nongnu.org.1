Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31678D773
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNnJ-0000I5-4y; Wed, 30 Aug 2023 12:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbNnH-0008Un-9S
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:11:47 -0400
Received: from mail-bn1nam02on2051.outbound.protection.outlook.com
 ([40.107.212.51] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbNnE-0002za-A0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:11:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SljfR+eZjgGRGOVJcsRaTIW2T96fkFc1l04cyiX7tljAV21DXnQjY6hwV+ajBXSDk30P3etTNb0FonpLJ9ELIWI9icKBBNb3roLnJss+O7ElQKrAPRVCZiKcHOSfY8Sn3DpPG5KU5BW9P2Sty6RXHXUo08E1FNYDVm9/zEohrCuTUNW+d9bgQcaotnmhquyhoQJpHpTf5aHallvPT2zuEqm8pj76husUA/ZLLTVzey5AG16BDoQ1nC9044cBS3rSkqomK8hWyGk5xzU3pmVhkthTvl+yDs9RyxgB5kPFFKhYI+y1jctTzQDQmJDV9a604XZTl4ryw2W7TFcfXgPsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNrURN5LVnalE96Ruu3qPGpfO8UxnaZsiwNRTc+/BaY=;
 b=Y0C/r9u4nkr9qVwGBA6fF6P+v4t/L960qyRVECllQExaKDYGliYMc4hrj0A023zxRH/6GsoX5pmx6iZJysJY1ouyUvSt4J30c1xkz7S3nC7X/yXDZ15YIHvWupoZMfOz42uu+/PsY9EKm71Mx0AH/pEQ3EIjKggSRDY3pcdG1UlcklWMr/vEJAreKdMGUAne44DrtUszG3Wwq1queniD2ZRpG4+d5kz9febKUctJfbvnh7Fk3hXLuaEFnuD1zb/G8NfymdMKtWiI9OkFIES7wYDaXVxKsCWoh1UzEqiIc/3f4OWCqxlclkgCsLf/3kGcXYBQdJTm5sW7jOaFWxgunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNrURN5LVnalE96Ruu3qPGpfO8UxnaZsiwNRTc+/BaY=;
 b=jIUJQwgRUzPfJbaZHi3IVN9Zf5SGY7/fnnLJsgOfkOzTJE6Ud1wUxUKwFXrw2AoSydkkbhO2dx1OqMyr+KCESnpZn7tQTT2q6hpS12B4HnR6IU2QVdtfZciL7OO8j/d4y4wAq3/rs7oMGITF7ljfhplMQGrALurENcMKfuAhrjiOEr9Ab4IaI/nYWp+uKJxoFH3DPwImop5pK/GhOv3vh64rQOrySPbvDoefDlTsT/UEPgprEZvRBwMXdVL5cnqJr0qVeTfxLZW/5CEgIe7E9M5DGqIpYeTo7eKoiYMyjmWZOoT5g+v9+GbvBBinHa26JkyST37yhgDfsoLJFTeeag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 16:06:38 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 16:06:38 +0000
Message-ID: <bad109e7-5534-1404-d894-e5fb282b479b@nvidia.com>
Date: Wed, 30 Aug 2023 19:06:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-6-avihaih@nvidia.com> <ZO4GTnuqSORbvePL@x1n>
 <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com>
 <ZO44klknC6hpd7mf@x1n>
 <adb00739-3074-dc16-bb24-1e42cbbdd50a@nvidia.com>
 <b900cc98-49fe-219b-4be0-a4b8eb36e1a4@redhat.com>
 <e3d3b6f8-2877-620e-66eb-6d3a53d65bc6@nvidia.com>
 <d036904b-6106-2cfd-6533-70f0f70fea2f@redhat.com>
 <2ce812f6-3372-fd3d-b0f3-46f12a9dc64c@nvidia.com>
 <95a37158-3ded-3930-ebf9-e33df4416cec@redhat.com> <ZO9Qj/tbHqZ/h34z@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZO9Qj/tbHqZ/h34z@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3a773b-22f8-4173-25d8-08dba9731714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1LJ84zD6JHAFCFRhLLeCU1c9T3K+zrR10i718/eW1vm7967RMRkRh40RC/rx0JPp1Jv0DL2l59BJnAS7tU2JzFd2FS+onfn5ZWdnyCqx88h/G5z/aMvEtjTi5L98e/94NMqeld9V/qwWLFoTZlnH/KjYtofe9yn/bHnrnJCmaFJLzlJ8nA8RbeMCm4IZIniYRMF6vqqsOdS1WgHSqLTzH7a0KKU7jKqSzCxY2iCOxvhFCiEdRvHKrYQgq4qV+qfi0T4fZKYaibep7zWMAYu2JZfNgWcs5aEFoLrwdlLgX4MqzBFJ8thZIONh687aBWAn8IDyqQdfokELyl0nxwtCD5JhHwPVRq3AmSh1nf2Yy8KWVXRPxozIeAwX0tjBMAThVIRxs6yoVFAdOhls7ZxQ3XqSzjkx7DIwYoyfFFuBQaPOS+hFpFppnbKwDwQ1qKn9bY9D3wigTeamDCny8cMxCCBMcwBYHEW52z2lD32a9wDUmjHnwhoqmxYjZXzcyI+tmJIl6OvArA1i9WOm4NJSlzMMltsGytOQCkg+XUoG6lU/NHU8fWndrHnoNdLj5Q/IYAXg3IXFwPeREgWmq6/yFUNc0y5HZHUDSdkfg+M7LkqoaSbI/fVkYBBIkUrjJRjzYmW8jfbX8f8NatCh5bA2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(6512007)(38100700002)(316002)(41300700001)(66574015)(4326008)(2906002)(83380400001)(2616005)(86362001)(8676002)(5660300002)(31696002)(26005)(36756003)(8936002)(6666004)(66556008)(6506007)(6486002)(66476007)(54906003)(66946007)(478600001)(31686004)(53546011)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzlNVkU0Yy9ZdVd6MnRKcWhaSEpiRGxwRlBqZVdTTTY1UVlDSDhWK3hSSk1q?=
 =?utf-8?B?aTRNdWNNYzI0RnFPdm5sbWdOeE1KKzBIZ2JvMGUybStkNmZYRTI2R1Q5cXNx?=
 =?utf-8?B?c3JaSVV5RENCdDZkOVZoWENqMWhRb0drQzZMc3JiZCtlMHFUZVQzL3d2aHNY?=
 =?utf-8?B?YnQzMEJDRnhHR2NZOC9ocFplMzFDV1Q2YzB5OUhFUFlnSjhGVE5XdFZZRFpM?=
 =?utf-8?B?WGEzN2ttcHRQVjE4eW9QblY5d1FBVmxkZk9BN3J0N3V2MkVkTzZRcVZONFZT?=
 =?utf-8?B?emFoVXlWQWwybTlTenJIWjk4MUc4RUZKeFN2VjFVQlc2Q2hLazhEUWlBRUxy?=
 =?utf-8?B?eTM2TFVuR0ptUHZxdGJIQ1J3QXFLamxLdWhZNk4zU1NoYVJidGdBN0Y5Wlk3?=
 =?utf-8?B?cC9mZ1hGYVA3ZURGcnkzTGFYOGY4M1cycXYyNXRIYUEyVGRydWtnQ2VFdnpS?=
 =?utf-8?B?U3dPck51Z1lmV21FUitucFpwa1RTSFpScDJKR0VvQkpJZEUzWWV3d1phY1Fl?=
 =?utf-8?B?MlBEQVIyWDIwODVvUEM0ZmQwN3VlZHVyNm5JbkhTVTZSZUU4V1BJcG5UdUpI?=
 =?utf-8?B?TEhBMHdOMU53R04zQXI1YjBtbUpKdkVqaFBhdGQ2V2dQMHFYL2NXTlV1ZWZD?=
 =?utf-8?B?L0I3QnpPMGxjQ1I1c3NEbk5uMWlIRG9wL1djUC9MWnEvQ2NMZFlIQ3hYbWk1?=
 =?utf-8?B?a2s3bmZmYlREZUJGRW1vZFlLaGdwKzRBaXplOE1BMkRHNWFNa1ZoTVNReXRw?=
 =?utf-8?B?Q3BMaE9GMW9NMjB3UFlxT2FnNWtyblB3NU12cnNHaWdDcnZXSS9UMndIZTli?=
 =?utf-8?B?NVllTmNSS0hOWGhhRjgxZDlYalFOQnhKR1RYaFpNb2VvTG1PZytlUXF1b3Rq?=
 =?utf-8?B?YUtsTE1jQ05XeXJham1WQ0k0d0JBMS9xRXRSenlKVUhDT2NIdzlBeDVZNDFi?=
 =?utf-8?B?TzhseHhXZkwwNHE5NmlZb0Q2dnVtamx3RkRtcmxSVEtLYXRlK2lSR3dmc0Iw?=
 =?utf-8?B?SUlUcWtjdjZPV0FKQ1pwRk1wZi9vdWJSUGpsam0yM0FjK2hPYWV5dEVHdHFt?=
 =?utf-8?B?d0FqZFNreUJLZWJqMEZQTEh2WUFDN1JkdDN1MnhJUkcxV2J6L21XUFFsYmps?=
 =?utf-8?B?S1pLNCtVVzNxS1hieklMUFBBcHgyM3ZjTDZ3ZXRwV2RMYnpyT1BuREhvckt6?=
 =?utf-8?B?MTRxZGthTnNRbUlDOXJyb25FRU12cEU0SWxTR1pBQXlrNXQ5QWxkRThNRWNM?=
 =?utf-8?B?cmJWTW9Na0VnL2I0N1hIQi8rSG9jdStYUGc1UXcxbDZSaGNKVHd3eWN0U01Y?=
 =?utf-8?B?dzFMVnROK3hxZmRONEhXUVhQRkJNZXVIcTFKYlpQZkpjVS9vNU9tYTZYU1JU?=
 =?utf-8?B?eGZvV1dVSDJoN0d2K0xBbXRwVWVhZE91cEN6ekV6cmxWcElvYmlkUUxnSERn?=
 =?utf-8?B?TnppUVZWNERiaFl1S0l6MnRkdFhVbGlGL2JTWGdGZWNjSCtSVmc0MHhtUEFG?=
 =?utf-8?B?dE5xNlAvcFUvSWp0NmJ6bVBPR3ZLdXRmYTB5eWJOY0FSMEJCcjRaRnd4KytK?=
 =?utf-8?B?OUlvd2lSYUtISHVvb05OM3l6WmtEL1dCSHp2NUl4OHNIanNKUEhpdVBhVXQy?=
 =?utf-8?B?QitlUkx0czF5VzQ1Vit5bkRRWnpjVXlSS1JtTElXNys5a2czOHJJd0lJSi9Z?=
 =?utf-8?B?SkJtUjNkNC9idUNjNENweXlLWEZ1UFZtNFJtSy9wN3BHdm5lc0JsRG5Vay9B?=
 =?utf-8?B?ZllVaEsxb3QyZ0QvTDBEQjBFUWF0VXF2SENOL0hIeEJYRWpxWGttUDVHelh6?=
 =?utf-8?B?bUorb3E3NmxaeEd5dXRTWDlub2ZuKzcwdmpqaFNvQmZFSkczbDl2UUpDRm5h?=
 =?utf-8?B?c1p1NVBMWlF5SnlpeWZGRjNNUmxCN3ptcFp4YzVnS2FNMnZ4TDVZM2dlV0Fm?=
 =?utf-8?B?NXR3WTU1bHBlNHIxT0FzayswRTVIajd1bi9mbDlpUkZqWHNjNHBwcTdaNVk5?=
 =?utf-8?B?dGFTS1pwekE1RUp1K09xcm4vdDNqTkswNzc4WEhPRnM5TEdTVndqdHlEc0Ft?=
 =?utf-8?B?ak8xaDI1RlRqWGZrcThPRkNlaDdRYnoxcDBuSXBEVWNJb0V0Q2xvbzlIZElI?=
 =?utf-8?Q?VAi6reO9YgWJYjXM/oltW3pod?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3a773b-22f8-4173-25d8-08dba9731714
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 16:06:38.0440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyO+sYuUBzs/cbc9HgJsNBtcOdKcUwjmUECvffIbsVB1YfxtT1WCa/RkVBZBxNrE0iXPB6nkJg3pRU+Q/D92ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
Received-SPF: softfail client-ip=40.107.212.51;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 30/08/2023 17:22, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Aug 30, 2023 at 01:17:55PM +0200, Cédric Le Goater wrote:
>> On 8/30/23 12:12, Avihai Horon wrote:
>>> On 30/08/2023 12:53, Cédric Le Goater wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 8/30/23 11:21, Avihai Horon wrote:
>>>>> On 30/08/2023 11:37, Cédric Le Goater wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> On 8/30/23 09:01, Avihai Horon wrote:
>>>>>>> On 29/08/2023 21:27, Peter Xu wrote:
>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>
>>>>>>>>
>>>>>>>> On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
>>>>>>>>> On 29/08/2023 17:53, Peter Xu wrote:
>>>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
>>>>>>>>>>> diff --git a/migration/options.c b/migration/options.c
>>>>>>>>>>> index 1d1e1321b0..e201053563 100644
>>>>>>>>>>> --- a/migration/options.c
>>>>>>>>>>> +++ b/migration/options.c
>>>>>>>>>>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>>>>>>>>>>                 error_setg(errp, "Postcopy is not yet compatible with multifd");
>>>>>>>>>>>                 return false;
>>>>>>>>>>>             }
>>>>>>>>>>> +
>>>>>>>>>>> +        if (migration_vfio_mig_active()) {
>>>>>>>>>>> +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
>>>>>>>>>>> +            return false;
>>>>>>>>>>> +        }
>>>>>>>>>> Hmm.. this will add yet another vfio hard-coded line into migration/..
>>>>>>>>>>
>>>>>>>>>> What will happen if the vfio device is hot plugged after enabling
>>>>>>>>>> postcopy-ram here?
>>>>>>>>> In that case a migration blocker will be added.
>>>>>>>>>
>>>>>>>>>> Is it possible to do it in a generic way?
>>>>>>>>> What comes to my mind is to let devices register a handler for a "caps
>>>>>>>>> change" notification and allow them to object.
>>>>>>>>> But maybe that's a bit of an overkill.
>>>>>>>> This one also sounds better than hard-codes to me.
>>>>>>>>
>>>>>>>>>> I was thinking the only unified place to do such check is when migration
>>>>>>>>>> starts, as long as we switch to SETUP all caps are locked and doesn't allow
>>>>>>>>>> any change until it finishes or fails.
>>>>>>>>>>
>>>>>>>>>> So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
>>>>>>>>>> to fail the whole migration early?  For example, maybe we should have an
>>>>>>>>>> Error** passed in, then if it fails it calls migrate_set_error, so
>>>>>>>>>> reflected in query-migrate later too.
>>>>>>>>> Yes, I think this could work and it will simplify things because we could
>>>>>>>>> also drop the VFIO migration blockers code.
>>>>>>>>> The downside is that the user will know migration is blocked only when he
>>>>>>>>> tries to migrate, and migrate_caps_check() will not block setting postcopy
>>>>>>>>> when a VFIO device is already attached.
>>>>>>>>> I don't have a strong opinion here, so if it's fine by you and everyone
>>>>>>>>> else, I could change that to what you suggested.
>>>>>>>> Failing later would be fine in this case to me; my expectation is VFIO
>>>>>>>> users should be advanced already anyway (as the whole solution is still
>>>>>>>> pretty involved comparing to a generic VM migration) and shouldn't try to
>>>>>>>> trigger that at all in real life.  IOW I'd expect this check will be there
>>>>>>>> just for sanity, rather than being relied on to let people be aware of it
>>>>>>>> by the error message.
>>>>>>> Yes, I agree with you.
>>>>>>>
>>>>>>>> Meanwhile the blocker + caps check is slightly complicated to me to guard
>>>>>>>> both sides.  So I'd vote for failing at the QMP command. But we can wait
>>>>>>>> and see whether there's other votes.
>>>>>>> Sure.
>>>>>>> So I will do the checking in vfio_save_setup(), unless someone else has a better idea.
>>>>>> Just to recap for my understanding,
>>>>>>
>>>>>> vfio_save_setup() would test migrate_postcopy_ram() and update a new
>>>>>> 'Error *err' parameter of the .save_setup() op which would be taken
>>>>>> into account in qemu_savevm_state_setup(). Is that correct ?
>>>>>>
>>>>> Yes.
>>>>> But I wonder if it would be simpler to call migrate_set_error() directly from vfio_save_setup() instead of adding "Error *err" argument to .save_setup() and changing all other users.
>>>>> What do you prefer?
>>>> Well, with my downstreamer hat, I would prefer a simpler solution for the
>>>> VFIO postcopy limitation first. That said, there is value in adding
>>>> a 'Error *' parameter to the .save_setup() op and letting the top routine
>>>> qemu_savevm_state_setup() propagate. Other SaveVMhandler could start using
>>>> it. even VFIO has multiple error_report() in vfio_save_setup() which could
>>>> be propagated to the top callers.
>>>>
>>>> Let's try that first. I will check your new series on top of 8.0
>>>>
>>> OK, so just making sure, you want to add "Error *err" argument to .save_setup() first and see how it goes, right?
>> yes. Sorry. that was not clear.
> I just remembered one pity of failing at save_setup() is it won't fail qmp
> command "migrate" itself, but only reflected in query-migrate later.
>
> If we want to make it even better (no strong opinion here, of now), we can
> have it separate from save_setup(), e.g., SaveVMHandlers.save_prepare(), so
> that it can be called even at migrate_prepare() and fail the QMP command
> with proper errors.

Sounds good.
I will do it and send v2, hopefully tomorrow.

Thanks.


