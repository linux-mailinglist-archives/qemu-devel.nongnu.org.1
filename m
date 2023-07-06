Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C006749E20
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPLZ-000395-Da; Thu, 06 Jul 2023 09:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qHPLW-00037n-TR
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:48:35 -0400
Received: from mail-dm3nam02on20612.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::612]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qHPLU-00089S-Ex
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:48:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK2L2d7T0tQEaSa4+7QUzaJodyzxJXNzAkjQKL80BNyAtS0vzb6uILPlkWYzaX2so9iaQW4x+y4hV4SpUrXLPg1U0p0ltIjzXN5mlIIRQiHEtzvrRUTrf9Wgs7I8XjSfMpqB1zumO4TbyjDzuKQkYc2xpxbPfVHT+T7RVdVHBx95EAtQYRLODwJVhxt+6kxr3BGzDnhNr5/gFjY80uUWBoxtRST4BH/AYycd+JTuGGgSQ+N0gfmphIPzfSqlEbrbiTXWX0zQWiaUQZ8XKFFevFrCldPiRVYe8ofQTrUveEL0wV0H8m6btYYn61nfroKKYTdCFIHzXLXdnYz+SbmjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyjPy1NvaROfp1N5LSoirYFUkg4pgv05WOgYg4uu71A=;
 b=eKe4Sb2sHAe3eR0jIwrKNlznK8pyiVPzJHcVZ2TmzB8kiVtYjLxj81mV99qx5HluUoVbEit4Pe1UmWcx4GyrAlMPYYWYwrk7RLJCHZ5x0Rr9v3gqyWPy3MiX0gAkAS1OiHQlotKmEGh4fovwM8oEt7KFvsDB7NsU/aVNzHTtWuckqEYqU/cK5mlrjR3E7uRh52IuoSjhAgZlsQMr7Tx5aM95FI1/kRKvJiUuNiRh8UoflR7A+3esEwVhhSh/TbteOSgOBh9cJDCed73DIjFhv3LSJaP0fQfSz4aQnK0YwbRyqtWdX8+/o9GLN5GRH+l2t2JM9yc3KErUNPLF9Tp6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyjPy1NvaROfp1N5LSoirYFUkg4pgv05WOgYg4uu71A=;
 b=WTz6TGHBKXIH8Fkt8+1iZV0LwZq+GGqdxztpXBBNTKhPe/jhymdA1h/P73PPkKmrzWKp/TsmZ4aBCxXePC/gKf7pt3wsQZ637MbqPXpErgglhVDT4mabRjgNmU8XfrIhfW+peVVdmLbhthiZAT1oCFzO+bxfJhONqZ908QxmuSJtewUMXt3TolnjTdD9+G+8yGHdT9CeIvTEaG5eleUQWxreUd4B1IX/BnQiKxGUr1n4yuNgQtycGZ3VEXu4aI/vUyayE2AFLKliGVBAXUvEfNpPzLUYIOZSAvw1D5IW1yP6tIuTx9xmNNZAFOE7Tez7neG5tCXBb2qu3l7XdgOtQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 13:48:23 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:48:23 +0000
Message-ID: <885a8099-b56b-a528-6d68-f1fd16ea4b9c@nvidia.com>
Date: Thu, 6 Jul 2023 16:48:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/2] migration: switchover-hold parameter
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230706124331.377939-1-peterx@redhat.com>
 <20230706124331.377939-2-peterx@redhat.com>
 <7bdfed14-0c32-901c-612c-3e66a79aa35e@nvidia.com> <ZKbFTfqfXD53w84l@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZKbFTfqfXD53w84l@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e678664-c17b-453d-2679-08db7e27aa73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OyDIrlPgMsbqvcMIcrWm4ae1U2Eiq7GquQQt1boHSnmQ0BFNK0jtT/x3xB7WW/rSoS2mcr6qDfjn92LWlEJ0PrJggSs8iTrQ71XJIH/jVdUsDHz21Wnxh92H/7HM0YNomS5BRNCnX66D5zeEbFaNpdbsx1tLZMe3x66YuSnyNpt/J6j8YWcDb2EXuMEBBJ+8TYGFWXeXSiPEKLWUlbkcdsWCazmdb2ao2xslRv24pOTYBbeQJ6XwqbDM8x3vDTlRWA+T5qudD3QGKcUamz+xWKlxsweFjNUL52K6knNFimaBxyiM5qQRGXzDfqcG+r21EilXA9iZ5puXdgKORuNZCsquaEdTEhbLnII9UlI6xuL94TGATCy8xOTpih+wGYoJ9gw9Emweh4edng/mECvRZxdbQLUJ+CYqtJnD7nqTTE9C40vko1phPdvM5gXHq/2C2HIYbKCJDN2uqpdSfUyC+iGLMOGzQPtz3DUpEJhzN6msa87MpqtHVUlN9tz4nUrp9xIoVV00nVMTnXTDvbfuKKnamX5fTJ0bbRy3ehPFZnfI4Sp9OzFn5UcfRm5E1XcLAcFpZObpPyFZL/SvXgRx4pbw8SDzvFcnAUXH96YtBBMmUSh/2zNDTj97yINEex0UQf4FZsSoJsu9kQbKq3RAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(31686004)(86362001)(6916009)(186003)(66556008)(66946007)(26005)(6506007)(66476007)(6512007)(53546011)(83380400001)(2616005)(31696002)(66899021)(2906002)(6486002)(6666004)(38100700002)(5660300002)(478600001)(8676002)(54906003)(41300700001)(8936002)(7416002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpwSUVGRFk4dVU4RHFPZ3pOcDRrOGFNNFlVU0FKR05qQUhmam02dFB5YVNS?=
 =?utf-8?B?NE84bjhkS2QxVlNjNlg4aTJzaWF6YnQ1ZDRUdUVZUHcwOHVCM2dLSnlQa0dG?=
 =?utf-8?B?aVVzYlkzUzhYTnBOK3NWclNGQ1crRlBwdHdBajlJWklrWVVyOHNmY0lhbWJF?=
 =?utf-8?B?RjNVYWxoKy85eUFwbHRnaDhqSVBJbDhrUEVySGExNzNQQnVLR2VtK1djRGwr?=
 =?utf-8?B?MzZ1bGVMZHh2dGdKeU8xdzFOQmFMTUJOR0pkZW9takVJUTBkMmZHZHdnQlhx?=
 =?utf-8?B?T2M5S2YwWnk0cnBvNFphVGpjaU8zNkltMjFWMkNCMGdRQmhQZEpiMVZZQnFP?=
 =?utf-8?B?VVdZTU9LUVdPYUFmZ1F6OFBnUkEwbXlDRVVEbWd1NzBBMFh2empJWmYzdVBw?=
 =?utf-8?B?U0RnSkFoQ25qQm5rbXVCVkVWQTY4aWhGck1YeE53bkZMRTZhcGlWN3h3c1dw?=
 =?utf-8?B?bHo5alV3aGJEdmlOUERVckRvVDFhd0V4N1hVazhtcU55TFhrOTJQdDhXOEcx?=
 =?utf-8?B?RmVLZlhGNnR3ZjNMWHlmeTk2SmxEL3pOWXZILzdnUUJIZWZwekFiSThia1hr?=
 =?utf-8?B?WERiUjlsaEhmd2s3eTFKNXF0YTVaM3BJMDJSSnVaMTF6RFl0dStTbmRDOWRx?=
 =?utf-8?B?R3QvQk9LU3ppVFl0RFloZWUyd29ySzJHUmJuTXZrWi9LK09HNXJ3YzJTU0k2?=
 =?utf-8?B?cVk4OVJ4QXFEdDNSTVdDRjhHRlFhTjZzVmd4QnJXdzJ5ODlsZmdlT0gvaGwx?=
 =?utf-8?B?bnVGb1U3eGRXajVNQ2g3QS9tdVloL3M0dUQvZUYzTFZIamhLKzRZclBNb2Ir?=
 =?utf-8?B?VWlvL0RBQ0M3ZTJBRkl0RlpIZ0ZrSUg4NmxsemdkQy9OaHZKTkV6ak5rU3FV?=
 =?utf-8?B?eVhmZFVvTXROUHNBZm5hRGVYU2NLdEx6cXB5blR4ODh6RnVrdWplVVpkM01o?=
 =?utf-8?B?bkRkb0xDblBNUVBFc0JwYXpQZU9tV0hNbGdpUXRmSUdsMktySWtHYlVVNmU3?=
 =?utf-8?B?QzUvNXA5UllUcGFiRGNNNy9KemJrUUphZkI4Mm54Ynkwdk05NkVQN3V1UFBm?=
 =?utf-8?B?UlBSOTlTZ3JBSG9oYU9haTB0eXRZUk5sU2pLUWdaTjk3TlErR28rQ01YOGVm?=
 =?utf-8?B?VURCYXhHT3VHUUdGV3J0dHNTM0kvamN4MXZ3VUpTWjlXWkc4amlydnVHbzls?=
 =?utf-8?B?YmVyNzNKb245Q1FSK09na2lTK0krUUZOb2hXMytEeVJDTnNZTVBMeGR2YkFO?=
 =?utf-8?B?UnJ0RnJrbmRQMnBzcFhGUHFjUWhaRERweUNpeCtTUWNDOHlyZDVlVTJLVG04?=
 =?utf-8?B?MjR1b0lCQzdaV1U5RzF2T3E5N2pyckVlbzhPekUxR2NsZHdVcXJMY2NBK0NB?=
 =?utf-8?B?MHdSblUxbTZ1OUhSbzljOHArdG5WTFc1UXJsQ0lWWUlFcUNPeE9meG1rdm9B?=
 =?utf-8?B?c2s1ckxZWDM4MGNQeVUvNGVIRVc1ZHEwUEt4aE5CdStlQzNDWHV5SWI0eGFy?=
 =?utf-8?B?bmJGeTU0bVE2WCtuOEo0Vm1HNkhydzl2OHpKS0ZBYWZwcXNuTjZwbi9CMmUr?=
 =?utf-8?B?WXFkUlFwUFk0YU5iZnd5cXpydTRZbDdodmdWT05HUFJQOGQrWGRnaGZYWE11?=
 =?utf-8?B?ODEvTEhTZ0pnRjBpM1ZXNmh2R0FaMWZEYTZWZHZIUmltS2xRY2gzOHQxR3BT?=
 =?utf-8?B?YlU0aVByalZCeDloL1JBVDJGUVRMaVYzQ29jOStQcDgySTBrWDJRRHhyTFVm?=
 =?utf-8?B?SWU3WHdpVm1pQlJDczNMeWlGcmt1MUppdHQ2aXdLenZseWRCVFVhWVV6cDV3?=
 =?utf-8?B?NnRKeDd4dkN3SmJ2WHVNdUp0TUJHRmxiMWxsN1RZeUxobjJkeWVvZWpUZnZM?=
 =?utf-8?B?aSttTmFTT2Z6WVNMRmw1eS9NUWVmUzJpTWxiM0VVN1dwZnpweGN1akZjdjdF?=
 =?utf-8?B?ZGIvZ0sxUVJITmtBNjk2NkpSSGhJQmJ3K1lYaWRlSjVxQnBjaFFPYitGQjFC?=
 =?utf-8?B?VW5sNW5FYjFGNlJpNk5RYkRreFdKTVBPSjNXTEx5NW1MV05Sc0dqamhvK1Q3?=
 =?utf-8?B?UVBEaVNYelQ3a2x0YUdpRkcvS2tOS1RFRUI5Q0VMSmt1OG9tYWkxb3FabWdX?=
 =?utf-8?Q?4uljGQOTjI+NIXmqxYFNvCxFN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e678664-c17b-453d-2679-08db7e27aa73
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:48:23.3802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjDoUTmm0BUzPuAz7Esvmt6B6SrzZRE5LfrDrQOGMSLRhcvKaxfruVHsCL7G3uxV41YhbEiwmUIGemJvscGKCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
Received-SPF: softfail client-ip=2a01:111:f400:7e83::612;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 06/07/2023 16:44, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Jul 06, 2023 at 04:29:22PM +0300, Avihai Horon wrote:
>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>> index 9885d7c9f7..c3b3860f00 100644
>>> --- a/migration/migration-hmp-cmds.c
>>> +++ b/migration/migration-hmp-cmds.c
>>> @@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>            monitor_printf(mon, "%s: '%s'\n",
>>>                MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>>>                params->tls_authz);
>>> +        monitor_printf(mon, "%s: %s\n",
>>> +            MigrationParameter_str(MIGRATION_PARAMETER_SWITCHOVER_HOLD),
>>> +            params->switchover_hold ? "on" : "off");
>>>
>>>            if (params->has_block_bitmap_mapping) {
>>>                const BitmapMigrationNodeAliasList *bmnal;
>>> @@ -616,6 +619,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>>            p->has_announce_step = true;
>>>            visit_type_size(v, param, &p->announce_step, &err);
>>>            break;
>>> +    case MIGRATION_PARAMETER_SWITCHOVER_HOLD:
>>> +        p->has_switchover_hold = true;
>>> +        visit_type_bool(v, param, &p->switchover_hold, &err);
>> Should this sem post switchover_hold_sem like in the QMP case?
> hmp_migrate_set_parameter() calls qmp_migrate_set_parameters() later, so
> it'll be posted there.

Oh right, I missed that.

Thanks.


