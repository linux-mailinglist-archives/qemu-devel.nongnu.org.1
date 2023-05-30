Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEB715C9E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:07:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xBU-0000gA-UU; Tue, 30 May 2023 07:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3xBN-0000d6-Vv
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:06:33 -0400
Received: from mail-mw2nam10on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::617]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q3xBL-0007oE-BX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V068Cc2FQzygCnGvm7w674afTXxAJPqNPn/xuJwWvIJfDA376GFP0TdL8oUsEWd9KhkRGLotT4tZbBdYSz3kiaFHUiSKQNEP66/UwZbzt9Bv99s0kMmSGle18nXvGBIGiFJVIS3qGpCpLBy3o+Npa2imz/Qw9bDAjnUpVCBe0DMIEDEgeHiibSDiCdqWtkhGl91qRS5Ylw5+lBidNBsSA2Hrdxp7tcDHzlBtAXjL9+IUgCjYig5IJ8WYbXToMWAMsKOjBqZHjg0uFeG37N/2EWHhZ9wB7VIVy3HbxdTfgd48sVh+yOI85Ru1mYzeFasV3igfX8Pv1Byg0peHt9i1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1mRpHhl093qeETELr3uJ2Lk6SzunausXMk/9jufCWA=;
 b=XsAzmxVC/Wr2FadvOITkrp6sY+5ITSE+mGxv587zLhJZKP3x+g5XeZ5Xa8R0rPRm+AasoVHlICiTEJq1KlFI88NkKIaLqddSgVQ4EjoaQtf1j9AutXphnCevPowN8WUDr2TU6H2np72YO1sjA9IjKVoIj74GmcZLpg9AjVud6K26trikpJoxV9mIT+kUsnwLDIMgToWXhe82ETgXzkT/RW1wKinstd6MvPSRFIVVxZhV5MjKSESIDpBcoMywjMIO+gX7j5RJxD4v8J4KukOqQkEUBAndUhiUdogNpTYqbYbls4v2Xx/Irw8iuwKtTFiIeXg8ZUP7Kw3ggYw3PyhRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1mRpHhl093qeETELr3uJ2Lk6SzunausXMk/9jufCWA=;
 b=Ekr3//Onr+D9EMoRNXv/H+n6OqV1dy2E50MqrPSbvivaxM7BTcNXO0oMYFoy/5XIqBd2iD10gjkKkvQYk6E5f0jdVcE8bhSwVmPVlsTHXXihdlHszqQIJT2MdojbMz+u8OuIBOkLbgrS9sqJDbjik2AnfXd72Rm0tEntrk0tM9zbowQIlI5aWrzHpBhgxdyFGO7E5XlTxwAN5tW/C8NYUgIJQbAeJs70zF7TSfJJwmrwwo5oR3JAu1bojgobJg4IU1L7dxP31O41cV9R6nq+/KVfzuq7oeTxOBWFB1bHe1QLCA9H9+xK3SN9ZfK5GqnjSBuJTm7LD0t2BgCf9Uw+Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:06:23 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c887:8186:c2f0:d7e6%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:06:23 +0000
Message-ID: <e26f2eda-f3d8-b8ce-a1a6-870a0200b45d@nvidia.com>
Date: Tue, 30 May 2023 14:06:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 7/9] vfio/migration: Add VFIO migration pre-copy support
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230528140652.8693-1-avihaih@nvidia.com>
 <20230528140652.8693-8-avihaih@nvidia.com>
 <f18c4598-a1c7-ba45-5885-e14b833f2fde@redhat.com>
 <d7826e76-f33c-9635-43e7-8466063f212b@nvidia.com>
 <e2844dce-3b84-2a00-639c-4e2b2472b2a6@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <e2844dce-3b84-2a00-639c-4e2b2472b2a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0066.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH0PR12MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: 157d766e-8814-4ace-f683-08db60fde780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P95HRuRo6MY3HARmaIg1L6VcZ8ZzhvveMdpDOjGrWCINqhZqG/auZmRJtd/qaU6jljoMHN2SbnVuVN3MwvMbKfhztoqfGWS1NBIqr3PgkYO+f4O3o2eEJayMLfHmKNPNxaYv7JJRKCvjwxi5ZIVwaqVbDIvF6Ka1VyBqjsBSYUVrDB4kJZsWMyNDkXEXAeSMqJ4WiWDl/sFN0CVAKCmGUecLaRWNKK/bw2iWbnHHnhSKwgADpVH0FccPYUTWTbEUcqkVTqQEcSlqQlSONbWMB/bQcHRmG9QWtM5922V7uklXN0bbS4D6HMaP57wvv0Kh/VqXEIp143qsaNhDdWbhb/F0sZtLjJdGLw4wb2HGP9KTymXEyZyZGrkJanbdqOav8sM3bBw4W/428dDi9dRiBpz4+oA6wREK/UfRbEd4rzO0/qI/le56z096EvUQt3/v8pJ/3qJH3Gv/bn3S87gwKBkFlAnaj3NJh297eUCZfoc7BR5XXbP0ZZCGSRm9q0hG4MpiXuiv6/oLF7NlzqNiP+wEvhH/Kp2UL1QTW1R4gD+Y6tsz5+dRgvZzsP6ejYVx+Q5lILwEwznmsUIVmJN2/Hp8aJYAUylG9DcY9GkUZfY1aXLqJADBIOjAJ0hvKNY4IW2yPdURisUNXDm+U3GyUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(31696002)(86362001)(36756003)(478600001)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(83380400001)(6486002)(6666004)(8936002)(8676002)(41300700001)(2906002)(7416002)(38100700002)(2616005)(5660300002)(6512007)(6506007)(53546011)(26005)(186003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WitUQkZBVldhTEUrb2lJSFFtQ0lKMzVIWUhUNmxhVjZic2dqell0cmM1QzFD?=
 =?utf-8?B?N1hwRnV1TzI2NHNya3lVaFp3K29LTHFkMUd4Zk9jQmJ2WVkzK2FKZ0IyeVc0?=
 =?utf-8?B?dXhxMG1YNFlMaTY3cDAycmVqR3ZER3JVT0xvNkY1MmNpSTdmTmg5UXFPcW1N?=
 =?utf-8?B?Vktpc3h2MURKdjllL0FVT0l4dFNZRFpObUFIemlZUENzL2FCcVVoUTFIY1ZV?=
 =?utf-8?B?a0I1WmdCd2h5Y0ZaMS95amhlMThqcStnOFlpVXFnUTYwb2huR2JIck43WVBr?=
 =?utf-8?B?ZGx1dk1xeWNYcXFnRmF5eGxlNHc2ME52YXR0dzJ1bjdGZkUydGlFc0VIK3Vk?=
 =?utf-8?B?L0REQitPNHJURjVnL1p2RXJLRHhQa1g3QkUyUTNjUGxBTkdmby8rb0hYRUlN?=
 =?utf-8?B?NC9QK0lHdlA2Si9paDlnS2hhOUEvTVBHOFFPZjdMV1VMQjY1YlFqSkRZbjRk?=
 =?utf-8?B?MlZNUUJoMk1kREwxd0JTR0F4Q090b09qSVk4Y3RRSVVxQ1Z1YTFDdnFMT1Ew?=
 =?utf-8?B?R0RTZE5xTXkxUXRKVXRHMVMyRjhiVFFNSVpuT0NIcnN1U3BIT1d1QkFIT3dZ?=
 =?utf-8?B?REJFR0dDVHYxOUhuWHlHckhHWXlqRFd4TnViMm9xSzZnWTR2bGkvR1ZzUDRw?=
 =?utf-8?B?QWVwOHBuMzZLTWFWVzRFa1ZPQnV5VytmMVAxcTVqNG5vdVpvWSszMTdKbElF?=
 =?utf-8?B?WkFnM1ZMWmRvUVcxV0ZERHNJUnI2aUpkZjBNQXY3b01xUFJzd1lqMkJhRFBt?=
 =?utf-8?B?UHpvYjFodGlxdTdhOWRKcXJOekVOajVFS21yNktQeUJla3ZaQkMyQ2FXSGpw?=
 =?utf-8?B?NC9zZmhrMlg0QWI5Z2NiTm8vWUhlR3lWWXdKdmVKVjJ5akVpTU5TNHUrOVNW?=
 =?utf-8?B?d3Z6Y09nSnhmTWlNdVRLQkhiK0lTZi9WYmFSeVkrc1FPb3hmRHlGVnVJSDRD?=
 =?utf-8?B?SzgzSk9oR0NZWkR0ZWRCR0ZEQTB1cVdLMkRNSTZMQkNVWkJ3TlIydXpsckJL?=
 =?utf-8?B?VHlkUzBPVVVxaFk4M1FCYnZUUmtDalZKZ0NhVFQrRDZMVmdta2p5MjRQQUdi?=
 =?utf-8?B?QXFYN0V0TExnK0NHbGJiRXQwd3lmaFRCVGZ3S09JdEJJRXdvSkxwSTdLSm1a?=
 =?utf-8?B?RjlsSm9xLzdDUk9zTEticjErQjA4dm12cjkwSzVsR2VteStSWWhsaGIyYmlH?=
 =?utf-8?B?dGQ0Q1MwMHZPRXJvMkRpY2E3T0E4RCtlTlBpYjEwa2FpbjluSkM3RTd6ZkhW?=
 =?utf-8?B?THovaVl6Q3BrcEZPMnV6N3JDbkEybHpobVF2T3JQUE41T3NNY2wwTGFMaEl5?=
 =?utf-8?B?empJdUhrSHNGb2tzWHB4SmhqMjZJNyt3OEljY20xQWg5c2dvcHVISUowN1ZW?=
 =?utf-8?B?MEZoYU9JTjVZRUVlRGhuTFBlK3N1KzRQa0hsdWtXVkk3ek12MVZ1WVljTEpI?=
 =?utf-8?B?L0EzQnBmOW12Njg5eEhZRys1dGtoUzNKVm1tUitGTEYwRzhWbXpnTFJwNDln?=
 =?utf-8?B?N2NXaWFDa3NHUEVSRDhxR1V2cG5iUWJBak9yVTloaVpCMWNMQWlDS2c3SXE5?=
 =?utf-8?B?aFJ5UXFZZnNrSnoxUkZJazBBa2EzOS9RYk8xR1VsVnVJNzE1L2wwVmhvOEJo?=
 =?utf-8?B?b2t5ajFHb0NzOFBZVC92ZWJiek54RTdFa25vc3NQUWdzVkZEcmwrVVpWUUJl?=
 =?utf-8?B?UllJTWhZa05wbzZEN0duMnhXVFBPK1pFclN0UHRNeGJSR0FOYWVuNXpkU2ZG?=
 =?utf-8?B?dVBSa21FSFRUUHFsQnY2WVIvdHpZQVdkVE04cXV5S1hZTjZhRWtTMzgrTHFW?=
 =?utf-8?B?TjBld3JYcHlLcWg1a3dxQlBNWFR1dFgxUXdCM2pyOENmc0lvUWdmTUovaktn?=
 =?utf-8?B?RjdtSDhONkw3VnBpeTdPQTd5WFNKanpBY2podTlzYWcrTEg1ZmpTZENhUG1D?=
 =?utf-8?B?TjN4dWl3TVBtWjFBYUxkSXZ3WW14UTBhQnJQaVovMWpISjNtbWp5OTFsTDNP?=
 =?utf-8?B?Mm9VUG4ySTRXTHkzU2ZyTk5ZWGJZQWZGcDI2MWVncUFRYUhTRWxTYVNwdkU4?=
 =?utf-8?B?UGN2d1FLYTZMMWF3bFlkNjFZQ00vc3pDd2prK2xieXN6Z0VDQStQK2xOWGx5?=
 =?utf-8?Q?x6oZmx/5o6wiWdhLZjlA+41q+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157d766e-8814-4ace-f683-08db60fde780
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:06:23.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUlhN7ljczWf5J2hJkL5Jyg2iMtREtF8a0FqLOUsx8PZe7Ut+W4NHgOhkSDn/e+rAadrFR4gNIpfDt4ynimeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
Received-SPF: softfail client-ip=2a01:111:f400:7e89::617;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 30/05/2023 13:17, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
>>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>>> index 646e42fd27..548f9488a7 100644
>>>> --- a/hw/vfio/trace-events
>>>> +++ b/hw/vfio/trace-events
>>>> @@ -162,6 +162,8 @@ vfio_save_block(const char *name, int 
>>>> data_size) " (%s) data_size %d"
>>>>   vfio_save_cleanup(const char *name) " (%s)"
>>>>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>>>>   vfio_save_device_config_state(const char *name) " (%s)"
>>>> +vfio_save_iterate(const char *name, uint64_t precopy_init_size, 
>>>> uint64_t precopy_dirty_size) " (%s) precopy initial size 
>>>> 0x%"PRIx64" precopy dirty size 0x%"PRIx64"
>>>
>>> the extra '"' at the end breaks compile. No need to resend just for 
>>> that.
>>> It can be fixed.
>>>
>> Oh, strange that it doesn't break when I compile it.
>> Do you have any idea why would  that be?
>
> It generates a -Werror=format= .
>
> Did you configure the build with  --disable-werror  ?

Nope.

configure prints this:
User defined options
     [...]
     werror                          : true


