Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E5E793E8E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:17:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtL7-0000mG-IF; Wed, 06 Sep 2023 10:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdtL4-0000m0-RZ
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:17:02 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com
 ([40.107.220.46] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qdtL2-0002N3-1k
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTePa8tr9WnIZ7D39wefj6iYm/I3tgPwj3u0lz7ngWe6MdQX5J03ff9LyyK1AvyEidp9+lXDDFNIRZNI4TZpLE4ph7VX0Ay51j5O/+xfYXQIRZi4ty5hfZzDz6P66+QOEN89Q5KZcqZv+XYb80u/oV3myW/69fwcpZr7/KTU56YiCa9j5mciBv9kDO8p9oGJXpsImrjeN74cnWHMOF3vfkjKO2ivFR6YcVrWn1YJG7LoX4tm6nroDOUJRZJcCKqK9jkDOmjvWostLsfcjpgC7wRZU1aV6q+EbdmRBdthnW4eHtcVP3z+d3L3EEdwnSRA0n/b6P8VDdWzIz5zOm6aFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCqSKxBun8446ASNgTht6i/8QGTkY5Cjl2+dfrQXGqY=;
 b=NagpOe4YNBa8sSxnc9TS7KDIwTbXN6WB3L0Rp4hX7f9bV81yc8Mc8mYnxX+vlWmd12SdxT9lZzSHzN3x1UtBPpj3kV5QpOk47FUmMg1f00SGXM7R66dsXIFnUxZYWo37CobX+1Utay48n++5AY7Xg8W/ufKZhcjFfWnx2wCbXq10Uq0OBH/ofs9pOeHgCk48wJyHaL86kVXwMUwaOk/mbFRcqq27Hy9DKZuY8wRBrbzJSQ4/ZzxgH1UJAi4F7hSwR0x6oBENz3qsu8S2AXjIyRQw+7o6Kjs8C+hArAWDLF39K9+jLbl/1dDNPB33VIM070Iri0CAvS6Uy819buRP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCqSKxBun8446ASNgTht6i/8QGTkY5Cjl2+dfrQXGqY=;
 b=YMrIVvVgfKMEQ8OkCsBtc8D9BEel2S02OtVK/2RRC7T3xN+jhMdeCqSVr/+wWmWN65S0LkjKalCeiCLWcC5aZ70qD9PGDTgtB58Y8t3mo48n1zLrC0h965jdiGR5PaWCHmDu0DZq3uE8n48D5jlmFTdb821oUJtkw1XGMYX/itYRev795Jf+b/N2VVuRCyM/gL3p2yTdVjV5m4fxxOtrT55FKB8NDZoYW3sqT1I0NbtDXQiy8SMEdE3vwYHFAYz7h09dCkE0B+YeF6v9L9d/XtG7TMDEVXpg2pKRnVsAVkRtWaLrGXwRIwg5rLKRu5/WJsyMpOIdqacOR16qEDUUDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:11:53 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:11:53 +0000
Message-ID: <c0a9c367-457f-f55e-df8b-d8542916039c@nvidia.com>
Date: Wed, 6 Sep 2023 17:11:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/5] migration: Add .save_prepare() handler to struct
 SaveVMHandlers
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
 <20230831125702.11263-4-avihaih@nvidia.com> <ZPIIEYhcwPJLg2Lj@x1n>
 <94038246-216c-3304-3f8b-1fb6f6ed684d@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <94038246-216c-3304-3f8b-1fb6f6ed684d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 750ea37f-ab2f-413d-347e-08dbaee3383a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3jXUB3Vm5BWDyUaZbnBloHE/OFiDhj84e6k8orZAJSij669vO76OUixUtOwOYvHXoe9j3iiMO9vRKMZZLra0QCHhOpMm4sJeTMD3j4Xsn6Lm5ep14lcwhVGU1v+lJlluAGOu4OI+o/SouLkpgwfgY9JgQn/h512zBzpPFClkPlHEdY6xbBlpClQ7yYLtSGRclv9hbM06cQpE3IUyfh7Z+MpgRyw1H/xH7pvEosA5fcTZ8u/XXPzGao6M0MZ4Aebf5wTYpEfT+OBgtxWO1xQh2mPH0J/IWg9zAgal1fPQ+GbRK0LX6RFfjqXJXPO1KijTlZMMuYsI4lazs4pI+4ZAlfaElHQqH3e5IUQoTeV7rfXlCf748J0VIz1WCwnRJth0VxaN5zVaBy2rggnkwQ5BpL0hEEH0Jjbd+Mmm7hc1WpWXTM3U/dMnPc1Q/KjSjaPRYpjFSQXx9uWxti3vpR4Nqz/jUgT0+trdg0mm8W16EY1/xNjyVLne6Um05638Sj9mhJF6xwcnU6jk3IO9rdB1qMLdPK4pNwqnQOGD91ud2JSBS0JKhfJPKbGywZ5YUod9JE9w28c/N0wQ3lO8G7f2zgJDEL4wMROchZ7xOExrgkKCNqx3tgyO3E4it47WlAb5ka+qOm+iOttVbXGTcIAJ/d+HjNc90ZmFUY01ajNr2KTfY4VbMhyDdu+5Awu9zkc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(53546011)(5660300002)(26005)(66476007)(66946007)(66556008)(54906003)(316002)(6512007)(6506007)(110136005)(41300700001)(6666004)(8936002)(4326008)(8676002)(2616005)(31686004)(478600001)(6486002)(66574015)(2906002)(31696002)(86362001)(36756003)(38100700002)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9sSCtkWU5VRW5qbFkvUXVYYzNNMk9NUnkvQVVpU2wrNTVpWngrY1hoVE5l?=
 =?utf-8?B?cTBBWXBaUW1rVmVzL0M0Y3NBbDdkYzNxcHp4UEpxS29rNjVkZjBiWW5hTnYv?=
 =?utf-8?B?VmZaZjdmK0tKRC9FamVHaGNvMUk1UmcvMW5zeVY4OXFhTWFVT2lTNkVuc0R3?=
 =?utf-8?B?a2RuTUdvclFqMTc0YzZpVUpwRjlvQW5wSzlLei83M2V4N2RvcW1yNDlEczBC?=
 =?utf-8?B?T0hUTGRCNkxjU2QzU29QZmlUUmZmN05ESjRydUY4Nm9HaDZnZzdDalFKa0JS?=
 =?utf-8?B?aXE0Zm1PUlRaTCtkNXpzQmttbHo4WnFaUVBnRFdoaUswdFVQZzM1ZXRDM0FW?=
 =?utf-8?B?ZTRsUm9YNENXQnZSdUVNYjNpUmhGM1VWQnRJR0MyWW9ORy9pWEgzVWl6bXhk?=
 =?utf-8?B?NVNvdG5mQVdJZmZUdEM1QUM0andwMkdtVi85RDRUNmJEbXdQWUZESnAwaHZS?=
 =?utf-8?B?TkNqbVJTSFBMa1VOeE9tVDdNYTZDYm9iRU9Kb0gwTXZZaGYrQjFhUzkrb2xL?=
 =?utf-8?B?Z09kT0MxOUhXQTJzSnRyTkVRZ0pLdFNGNXdRMm90VVRFK0NwSUJNOUI1TEhu?=
 =?utf-8?B?UXlweVh4ZVZ2ajltbHRrQ3Nzc2hTZzNuaUhKUTdvL2RvcVd2eVQvSkY5MEgz?=
 =?utf-8?B?K2ZLZFpTM0FZMzY0RDdKUityUUZMZEdLS3FLWXZ4dHpoV0JDUWNHcEFGeUFH?=
 =?utf-8?B?NlFmdzJZclVPQ0VzdHNkQkF6NkdBdjFEend3Rkh1WEJCcW9PdHk0MkdVbVFo?=
 =?utf-8?B?R2kwUmZaRmYrQVEzVVltRHBEcEJyNDZrclBGbFo4ZWI5T2VhVnRUT2d1aXJD?=
 =?utf-8?B?V1UrdHJPZU5xWmpxRnVwcTdtamRDYTAwa0M5cHNTUlVSZW1CMVp1cTUxRkZK?=
 =?utf-8?B?R2w4K29VcFB4RytaekVPQjZGSHAzWW02blZGeTFJK1NPQ0haTy9WT3JDR0M3?=
 =?utf-8?B?MlBNUU9SOEpFQjRVOGZGWkg4K2kvUTFlREd1T2F3UHRkNmoyR282bHRJbnRo?=
 =?utf-8?B?ckVnRVRpVU9TRkJrcE1PSG55MXpRcVduWWtVdWJBb096K2NUM2RoK1prMGFQ?=
 =?utf-8?B?dXAySmJrWXNQUzhES0UwSzVYWU1QSWNvelZ1cFJWQ3RPN2xtOUZPTEZFRDdC?=
 =?utf-8?B?UHl1Mkg1TGlvZEE2YXJ2MzdIbVFmQUJRRzRUeFFzTzlPcWszYXlzV1d3dGVa?=
 =?utf-8?B?QUtuYlA5RFdPeVpEM2FkKzhjRklqQlgvTVpjaDRJMmZONU51Wi9HMytteFBH?=
 =?utf-8?B?ak9ZanRtaGJwN0N6TDZya2M0Y1dsZ1ZyTlFNVGw1Z3ZYeXkrelhnbHlFQ3l4?=
 =?utf-8?B?Y2JMUEFPR1ZIZUpaNmNKeFgzOXhmSXRybENiUkNXdzgwRGg1YzJkM2c5Zi9p?=
 =?utf-8?B?L1lsSzM4MGtKTHVKKzRwbTVsSFV6U1JTTElUUTIvakxGQmlvQWdOVXV2VjB0?=
 =?utf-8?B?Qm1wV0xCVHBISnV4NjVKS1ZYaXdsR2xuZ25pSEJnejkwUyt1QlY0TmVDQTJ1?=
 =?utf-8?B?SEJkS3NSM0lVZndlMmxyRHplaXJJOFdVd2tUcTArQUVMU2pmMHMrU2laVDZj?=
 =?utf-8?B?UlNFS0dUelFwWnpQNE9EOEZoTzdPNEJDT2dRblNqZFpWS2xZQ29HTUJHZmx2?=
 =?utf-8?B?SDRCRFlsSWNJVWRsVnF0WWoxaTVldHlEYlpZS0FaT29kWHFqVjZKcXo3OGty?=
 =?utf-8?B?RFNDdnN3Yzl3MGZYMnY4QXlsTWRWeFFTelgwL3lYb2RRKy8xNkdYeWluRGVu?=
 =?utf-8?B?WXlyN21sbkw0YStLZEpGSkRTNWtQMndsZ0dYSUR1R1BLVDU4SXo1SStMNnFl?=
 =?utf-8?B?SENmMnpRQTdMUzVMdGVRNVk1QUZXUVFGR3dRTXBqekkrWWxBRUJUM2FBanZk?=
 =?utf-8?B?Q1pHUkJCL1RVakwxeE52NEJiNy9GVTRiM0lBS2FEejBRcTJRZi85UEJrd3h4?=
 =?utf-8?B?MVA4TGorY1JMU21BS2djS0FIa05BNnV6cksyeTUzYkVTVmF1ZUc1ZnpqdDJG?=
 =?utf-8?B?dUZFWCtnOWNCRUZFdXY4dkZQbDJTZWVLUnRqTVZaak9xamJPZGswdHAvNjBK?=
 =?utf-8?B?ekhBREJXT3BLWXBObEQ2bVBUVCszaHBxN2cxNnJIL1Ivdi9vWlNnRGN6aFBI?=
 =?utf-8?Q?gSpEVnzEZoZUEFw/wKHADlqZF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750ea37f-ab2f-413d-347e-08dbaee3383a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:11:53.0738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0RzGoMyML//8ecNvnwon0WNCAmPNOTKDkv2+18rdPrTl5sYN7uzFQc5PkVhRc7TcWX1QxibV2cjyWjMo0550A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
Received-SPF: softfail client-ip=40.107.220.46;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 05/09/2023 19:13, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 9/1/23 17:49, Peter Xu wrote:
>> On Thu, Aug 31, 2023 at 03:57:00PM +0300, Avihai Horon wrote:
>>> Add a new .save_prepare() handler to struct SaveVMHandlers. This 
>>> handler
>>> is called early, even before migration starts, and can be used by
>>> devices to perform early checks.
>>>
>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>
>> Shouldn't be hard to unify the two call sites for qmp migrate and save
>> snapshot, but we can leave that for later:
>
> yes. It could be called from migrate_init() with minor changes.
>
> We could probably move :
>
>     memset(&mig_stats, 0, sizeof(mig_stats));
>     memset(&compression_counters, 0, sizeof(compression_counters));
>     migration_reset_vfio_bytes_transferred();
>
> under migrate_init() also.

I will send v3 with the above changes shortly.

Thanks.

> Anyhow,
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>

