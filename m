Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1403726DB6
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 22:44:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q701D-0003qH-VE; Wed, 07 Jun 2023 16:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q7016-0003pm-7W
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:44:28 -0400
Received: from mail-mw2nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::60a]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q7013-0000He-4w
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1yneJp4ExO2A6RWobmKGUHSwrdr4OEaNLRi0zTclH5veKybeeySFnGuwmML1qCTGjOaTSUuyDrk81FsT07qW2fwGJxPDrsW7tIkd4FB2J8wxuKypSoMGEsw8f4TBrd/W0g1enQmL49atMe5waZf5KKH7X1p2ZP9yOibnbvK0y1HnZStmLmyoFdLb5vrkOgKQWDhs5oD/+c7xyGHVGos/KNxGzJAxa3dbn+cXyKXEsq1+HW5v+sto1uESnewF+ng59Rkz6/nXXTch7xZz89le1+nn8+vS08TVcb/dEx7FKioZKiMhVGrUpbgnMIvlUflKo5iWZXCnQirKE8DccFUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+Vw6KUxmMmXU+nK/j2I6gFsM5LjmIUVHQkjSZYOLsw=;
 b=Fga7j7C0fx7GVpuJF6vFS6EF7bNQWEEkA5Lc0+ZsI24R6J3MU1G0G70bqIUi/q2pw0aKnhM8dhgeB8Pw8unpFsxjcfGlaEPXAAJUZ/M0KrcUQ8x0++MrdcEJ+0sjJt++R4FWWxx+4AbRd1VHPQcwvVDfMeg3xPexqKQG6+TI2zCmMGi6PrGwBdltSffZ6DytHUO2hV1B7hueeH218pxONofSbrylKRECnUKdzDBQjX1vv/Rto8TvdlIo94e5IsvIXW4ivXgoQfzixMlD98C+Xgv+FRJC0jSPorBpET1qgTsPWmyL0TqxG/k55jNh733uP6RVpDD8HLV3CfkUq9dWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+Vw6KUxmMmXU+nK/j2I6gFsM5LjmIUVHQkjSZYOLsw=;
 b=vaZiPaSNN+4LbP9imtS8UjW++Uvt8+TJycMmpcIer4QFBlpQxO77Pb7P7IzTFyD9hN1/IfYNi83e4lRe/bdAqmXeu8OhWV9SLeCtkL6Oeg9ZR85SBJro0z88ZRAEiIUuxmpGxjlonLO7OWC2YhuZZklV9jaAsLqInvo9xypKsvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.36; Wed, 7 Jun 2023 20:44:19 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 20:44:19 +0000
Message-ID: <b209b1cc-689d-c0b8-8bd7-6f13d7bce24e@amd.com>
Date: Wed, 7 Jun 2023 13:44:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 1/3] hw/i386/pc: Refactor logic to set SMBIOS defaults
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 imammedo@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-2-suravee.suthikulpanit@amd.com>
 <ZIA7x5cYNr99mhzd@redhat.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZIA7x5cYNr99mhzd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 789ae054-5c13-40ba-7bcd-08db6797f74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oi5DlchNRU2yLXkLsYah1HDJZZKsCRZTz8Nairvi0RsoEMD1dcCLUCIbRUZLqdGP5BcAaXEyKjR9eS5JGGjmJxOJTjc+jjA697qJmymxKw+9VkC2/kuZyJ2V/GTIP3YnzDVLMEdwsvej1IStJG5XjrROH7rK02UeUWdxjt9TTXRoquyN+pEG/aFCgTMJOqa0HNbU3uzc9uxUJtk8QsBat/fzxwUXpd8/fDmlcItk7V7j6NLDHSkbZWfplnXWY8ozY9kychbSxhk50iBLtoccwOMtSnF59s6IT68/dHxbJRpejuydMZhZMjrMYGmhEabYbHVZFpDqoWSNMMX30ubXwbDMTYqcCHBnTbIJE3wXLCaoRyR1xyvRnmNkdWBK6iUl0+VR1saVdgliyt7xL7obFeCz6C0H4X8FTIPNljOHho5nSy0sSKDP8x0T4+m85ylRTBQFLTbEPt8WqfBKhau4tjWQgyy4gpSYwOLUPbhLCuabQWis6Zb5yK5T5b+kSBz7XggvSU+RZXlBxVXX8BuY+j38pa7iRMlvVA8pr5fdiptT4IW9ZC0DXHpDdj6ZlALCWgiDbKKuOkDZr7RpXYYPzSmJK7Ujvg/AJOSQNfWElppRj2iQV3s9ruuDF4Rqm8onImEINpJFR0KVe1p+CwxcRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(316002)(6486002)(41300700001)(83380400001)(2616005)(31696002)(86362001)(6506007)(53546011)(6512007)(186003)(7416002)(26005)(2906002)(38100700002)(36756003)(5660300002)(8936002)(8676002)(66946007)(31686004)(478600001)(6666004)(66556008)(4326008)(66476007)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWxOMnlYVHNWQTlLenpvc2Q2TmkyVjdwcWc5UUFhWlYwK1l5bEFXamc2ck1Q?=
 =?utf-8?B?L1U1MlBCRUpKS3pPc21sOFQva25LWDdSeFl2VEdRUUpna0IzRkppWXZoNVFE?=
 =?utf-8?B?YXlzdXBFWkRKMmNNRG5PUXdYd3Y2QmNwY2N2L3d5U2tYZC9NYXREZlRSNC85?=
 =?utf-8?B?RjdSMjByUkF6VUpvYnlna2tiR214NDNHK214ZlBaQ2FZU282MHJwSVNaeW8w?=
 =?utf-8?B?ME02eTFPVTExcVVETitIb09md1kyVVNkVDhYRUwvTmdyZGVoRXlmT1JQN21C?=
 =?utf-8?B?djFTMDlWRXo0am90dktzUGN6TERSUGV4WkNrTFRheWhSN1VyNWhxOFRWZE03?=
 =?utf-8?B?V2FMWWg0YllFYXI3VHVxbm4wOXM3bXptRUJWNnBXMTczaEZrdGdHcVNINDNS?=
 =?utf-8?B?U0F2OWdDcU02dW9hUndqdW9sRFU1a1U0SHlHQjZ3WlRxcE1CTUl1bXJNbzdR?=
 =?utf-8?B?NE5CTTAydWwvUURTVWthb244cFNvZ2N3L1lFOVIrUXJ1bGk3WklIWmI1VGlB?=
 =?utf-8?B?T1VOQzhjRnFURlJHNDRCUVo3eGtCbHpHbDJsKzU2QkZNMkNwTHN4M1ZBRkd5?=
 =?utf-8?B?L3VTanV4Z212ZlY3STJxcDFMd1lZZ2NjaGQzUjJqVlRpS0FsS0Y4LzkvQ2ZZ?=
 =?utf-8?B?QUNqZ1BVZDlzb0lCSjM4ZW1ubnhFSTJacXN1blBsQjJmd3hQblBoSEhvQXE5?=
 =?utf-8?B?cGR1Qitsa0hwS2ZpYnd5OGRMUzRRQnBGRXdUdmdKMGRFLy9hYm85VWU5K01X?=
 =?utf-8?B?UHh0UXg2ckp2cXVPVEo3dXRpQTNhVjlkbzl2SDFpc2twTUJaVitnWFJaWVJD?=
 =?utf-8?B?REN0c0xOL0lkVlgxUHgrSGtoZFVCdHBZRW96dGtxaUppNVFUV2RQMjdWK0dp?=
 =?utf-8?B?RXIrQitxZWhoaHVnNEtmMTArY085VDZCbmVBQVgyQUpLMTZoMFcxMExXU2ZK?=
 =?utf-8?B?Y21HNjd4OWZKZ1dudXpSSkMvMm9KWnZMQnJjUXBWUmFPdW9lWWVaVm9xL25k?=
 =?utf-8?B?UldhNFc5cVhtZFZSRmpqdkxjYjZNSmlzVWdEeGpNUXVHbDBXdGpRdDFrNndJ?=
 =?utf-8?B?YUt3RWZidUZPaVpleHNOZ2swSmVzZ3k2TXFTTW9GbFVIUHFlMnpWc0t6RnBD?=
 =?utf-8?B?TG1peXpiRDFrQkJIVGsrclo0OEc3Ums5S0t3dm9abnFzancwTTFsUVlnUmRr?=
 =?utf-8?B?cVl6QklpWmhxdDhEOThiN2hhVmpRVDY5cEpZYWhzQ1Fmc0hWYXFWMGlyM2ln?=
 =?utf-8?B?SFd5b1ExS1ZzVmE4cDdhMEdPWFZLc1d4cC80WkNLZjlrQTF0SDNPYzFPQmJm?=
 =?utf-8?B?V2RNZXhuVW5ZMmVva0tXQUFWblU3MlFHVU5KNkNoTW44a2pzejFyd3hqUE1E?=
 =?utf-8?B?RWV3OFdtSkJYcXhTSjhhNEJUSmRZVmNvbXA5ZFZaQ3ZWUXFHcDR3YjZKZm1s?=
 =?utf-8?B?NmtncW9ienRhd2FRcEdZY0taREJ4K2NadXhscGR1d1dVbXMzMlpwdS9wWlZs?=
 =?utf-8?B?UzVLV0MwM0dCc2NZZFVNejIyNkRnQ0VnN1MrNlpEOGdFRXVTTithOU1EY3h4?=
 =?utf-8?B?bmR1TFNvczY4U3VWLzRWS2FtcFl5dFdzeFhlVW94OEtMeER2RzVCYVJsSTVl?=
 =?utf-8?B?ckEzM0dCb2tYSno3eDBmN1E1T0hndFg1cmpDYnRRa3lsUXZ6MzVZRExCb2da?=
 =?utf-8?B?SmlVUjM4MGFPZUFLSStLU0ZWRTNrTXB5S2JQN0dWdlZNR2w5QTI2NGxwcFRt?=
 =?utf-8?B?SWd4SklIWWZCVHk3THUzbFRhUzBENnpiaUN2L0VTc0FLNHlJK2NPdEp0Z0xj?=
 =?utf-8?B?R1Z5UzdZY2V1S3A3MWIwM0FVeS9jMHFobVQxekEyWlZwSDdET0kraFBtSXFr?=
 =?utf-8?B?ME85QWFCTEJkZ05OekplaG54U09pMEgwYUlpWG80UlY5NGFVd2VuTjJraStP?=
 =?utf-8?B?cUhCVW1QaW81TEt6bEFxeEFzVTRhWE41OXNrMllETTgzZkZ1THlBbFlGUVRK?=
 =?utf-8?B?VTlkaHgvYzFwckZWbWNkMmpsZjBvSzVpdG8wc1JDeGVJWjFrVzlOaEJKR0dS?=
 =?utf-8?B?RWpSVjNJZE1vQ1ltd3lhN1lLN1BMVEZIVFBIQ3FML2ZOREtKMmZoV2F2TVhF?=
 =?utf-8?Q?MzfEUJJcpF3vwIktM0pTCC7G8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789ae054-5c13-40ba-7bcd-08db6797f74f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 20:44:19.1513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6omCu2I3rc2jMlHHzZ1L0VHfg5YwiN/mEVuM2fA/E4dgQ+YLNCpb1y9316uFc7f0+b129ZmqvVofIaEK46E/YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
Received-SPF: softfail client-ip=2a01:111:f400:7e89::60a;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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



On 6/7/2023 3:11 PM, Daniel P. Berrangé wrote:
> On Tue, Jun 06, 2023 at 09:49:37PM -0500, Suravee Suthikulpanit wrote:
>> Into a helper function pc_machine_init_smbios() in preparation for
>> subsequent code to upgrade default SMBIOS entry point type.
>>
>> Then, call the helper function from the pc_machine_initfn() to eliminate
>> duplicate code in pc_q35.c and pc_pixx.c. However, this changes the
>> ordering of when the smbios_set_defaults() is called to before
>> pc_machine_set_smbios_ep() (i.e. before handling the user specified
>> QEMU option "-M ...,smbios-entry-point-type=[32|64]" to override
>> the default type.)
>>
>> Therefore, also call the helper function in pc_machine_set_smbios_ep()
>> to update the defaults.
>
> This is unsafe - smbios_set_defaults is only intended to be called
> once. Calling it twice leads to a SEGV due to double-free
> 
> $  ./build/qemu-system-x86_64 -machine pc,smbios-entry-point-type=64 -smbios file=/tmp/smbios_entry_point
> Segmentation fault (core dumped)

Thanks for pointing this out. I missed this

> IMHO we should just not do this refactoring. The existing duplicated
> code is not a significant burden, and thus is better than having to
> workaround calling pc_machine_set_smbios_ep too early in startup.

Ok

Thanks,
Suravee

