Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77417DD652
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:51:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtpv-0000K9-RG; Tue, 31 Oct 2023 14:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qxtpr-0000Jx-FV
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:51:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qxtpn-00052r-Rj
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:51:30 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39VDbjTS015951; Tue, 31 Oct 2023 11:51:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=L0FV9rSQyZvbamcHIGebukeP7AGU+9G7AQA+qhY9Q
 yA=; b=PwQ2RTyOX93UF4VowIllnBXWg88vkpjDoZnPQv6NmYcVdXn4aR3aYz7am
 G3zDC2v/TcjwVSYeO4cPWspQCnnPoNA6wi5pQoLQNzZWHdonMUSmPhCg1z9YC/rm
 6oXRK60ipbgtAURdIAGSdZ+rAZS+4/54CV4P9GrzqxvyjDbJGqm2P2YmXWEIUEQw
 XNzYc6UILV3YAuHhcn2LkxLO+/xTOnEh5RKXtGDQhzVoFeNNsJB1sOgj5+Tel2QY
 mepl3b9M3aqJgXgO6LDscldyVtR5DP+imzOSXB7U3nullPm5YkyxCunQrfHD2bp0
 kwexvaKuSpjPalqxj9hAI7yEa+Ufw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3u11txnxtv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 11:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frioIx+lXjPuDPlVNXDyz7MrKXbo8VDD2u2TaTZsDJ/XasA+BAgJolzY8qcbcIvrJe7fnNjj5gbmwvNTNxW9GBaykc5Xx00acxPEADgO75xdeImGRZroO5MlQ4HuKPKrYebza14T6QUdFY4VfO+KuexGWe0WjjINXuRVT+2h9fEnLN58OvJjSJqamQCg8msBQ+wIH38UEKDQkEl3BG4VyFsVEQc/uXibvqpVbojKGz/JgbE43QD01lIZ8VkVSCZtSBh2+kEap2qyjtXRMAf0BnRWY4VbrtgxsRQ01kWhHg66XDhhA4AExiCxoboYOvifzQ45PGA/y1f9gBQuMXz0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0FV9rSQyZvbamcHIGebukeP7AGU+9G7AQA+qhY9QyA=;
 b=OjnQepIRrvTXZ4y3MttbZNjA6K/CVP3tcWJvdZcsBdIwLORtxrCcdxZxJt+fpX2tQbdygmacupSk/pJFKj4gh8TAbjJ+SeTBcu/Bg8qJiDsipJDBZ91yV1Ru3v0GQffp/MDZrACXfV6I8JEtC9hNQiuxu/OTTsHOqn6sNbjYozHolkaMFCYQJg58PwZWgH3V61SaL871bkw+PP3zZEUcxoLQCwmwV9LbZ1hRROSd/aa48YUkAF38LZL2VAu+2XsKh2HYZejJYXNqcMRkaJO2uZ40HPt9j2TrOQhT0ZJO/6HtGRk4XlgwDM7jYYP7xSZzCKq9N1bC2Ngx92SSKLOM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0FV9rSQyZvbamcHIGebukeP7AGU+9G7AQA+qhY9QyA=;
 b=s8yp9RaWAI/IbZCn0kPn+CHWAU07C+0PAJu4Izn8dkXzWvrGmQoV3AornW/66H/d+o8F0DPwvqH2mxqpE5bgXIu92G14cUTAvfRTmkQO6ZbpngBoQycVE7ACImGeJQs1hib2+sq67EdPFEC09KcgItog5QFksaznP6mdPTQxPIHEtX6MeMs6QtnZT/49+fPx3oErC8q3MSzKbizJ+ZNMwhEQ5I2stI8WXxOXHqxjfJFWCB+JpoL2PrqO2iijF7ovKvxjlhTIDfcVld1dfqBwOJqyof6wVEHQReAOWpexL553iIfH/y6Czj578cyAnM5ypGTcB6vyZF1hI0QILVJ0Lg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6476.namprd02.prod.outlook.com (2603:10b6:610:67::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 31 Oct
 2023 18:51:18 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f0ae:86b1:db55:61d7]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f0ae:86b1:db55:61d7%7]) with mapi id 15.20.6907.028; Tue, 31 Oct 2023
 18:51:18 +0000
Message-ID: <d746e4d6-1572-2360-3780-7be4ae63ac29@nutanix.com>
Date: Wed, 1 Nov 2023 00:21:08 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v15 13/14] migration: Implement MigrateChannelList to hmp
 migration flow.
To: quintela@redhat.com, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-14-farosas@suse.de> <87msvy4rjg.fsf@secure.mitica>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87msvy4rjg.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7aa10c-c431-4c22-a08c-08dbda425dbf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHH7vFHUNPSOtJTwHPE9AYlwXreFgAjK3w8+T1tOACf/6QvvbUjD1jSYoXEzkQHMIEy5QWVDIci0+xzXDFCjjhGCzKe553aP+iGCUVgp+VCNpaeSBdicySrXmU/XBmPo24Z5RZ8hZ53IzHbKGM8doNzyRx4yy90/iTmuy9fwmZp3usK+ptaDluaAIahRH42M7NJwMMNiZOfFo+SFVDjWREFJ2VBnsrvdI6ys/1pbQqZxTsOrc56Dt5Ept3UMDobHu+2pdqR5NKW+WnAs3ZLE0TVUAzhUASkphagiwH8qwnq1MxHZBQZPH5Iv0pQOxuyrw7AKusRIH/fTIu/9b6PBZgyXOk4l3G3zMybgS5B9b6sKZepeVrFRKox1zXK4EML+vEwrnyg6xCQnyBKDPOGEDv/Wm2Ll6g8m3p3ybRF1Pi/ZaVoBYyEIOzmURKiAXengRmgky9oEapbDwYynzHEEW/JgC8NX6TkrXgfH6+mY7sM9mg8O6TghmcFNUwlHBiZ10yz2sa1f1EivwKBXjAh7ks9VlJiOIqshqrHy7rJx5KcDld2VUy+nteM1h4IF7ryyDWNLIdi2rObI6PPUbqg8wQnNdkvZTDr94y/pMzhfhHmEaW9/42soTleArb/KHrf8xReEyI2aOSgPZlkm705zXZ4j78eAU6wvke+udexyNg4nFJvwgbC4cT0Xdb3XQXkP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66476007)(6666004)(8936002)(66946007)(41300700001)(7416002)(66556008)(6916009)(8676002)(478600001)(54906003)(316002)(44832011)(4326008)(31696002)(2616005)(83380400001)(36756003)(38100700002)(26005)(86362001)(6506007)(6486002)(53546011)(6512007)(2906002)(5660300002)(31686004)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky90MGJER0NjWkdZSjRvdEFTaGhXVERmdDBtUGdEOEh0a2hHeWkzc09KMnBL?=
 =?utf-8?B?NEhUcWc3a3VvcGJScWZGNFlwSnRZVVdJNWNwakZEaUdLNHpQbXdJbjg5bnRE?=
 =?utf-8?B?NTQrMkloNVBwbnhQUUI5Vk5Rc3hkeGxtUHdpc0Y0cXNmanowcjlFM3FaTTFH?=
 =?utf-8?B?RXpqSXl1QmJTM3MvMzBDZGs4WWJvaENzK0RrVENzT3ptYmo4WldmL2tMeE42?=
 =?utf-8?B?cmxkdksrRitIS0xoSGV5L1dUSXA4MEh5a2pmVjRUSEd3eDdsbTBpMnJsd2Fo?=
 =?utf-8?B?ZW5ya0JwcWNFZXltVXRsTDA2MENsM3RCOUZvK29HWUNGTjZzRzlBNGxrRVov?=
 =?utf-8?B?OTBEN201UElBNDlVcmo1Q1FEQlpCbEdLdER2b3lmS2JzaDMzMENWelBSc3Ew?=
 =?utf-8?B?aWxIMTlxekF2Uko4S05yTUIreG5CY25xNW1zV2pBQ1JYQzMxeldld3loNEJ1?=
 =?utf-8?B?eXNJT1lrWXh6UlZoMEVpaGljNWdLQWtyUjNLekRiWXBqeHlzZFkyd0dGYitH?=
 =?utf-8?B?WHNueEdObGdYYzVFZFF5cEdvVzE1Ly83YlVIaEFTcnU0VzJkUExTang2a3NU?=
 =?utf-8?B?N3hqenZKK3U2ZU1uRHcwY0plVWMrb0Y1djJ2dzRzeEU5TG9qWmdRb3kzc0ZN?=
 =?utf-8?B?dktnSms1Mjk3WEYrbjY5dXFIUHJ6UDRORmRUb0VrQ3RYYmRMOFdJNmQyb2ZK?=
 =?utf-8?B?NnFuWk8rS3lvOFlpWmRqejBaT1M3THhNMVM0UStaSVhadUxPdXhUeGd6SjNp?=
 =?utf-8?B?SXY1THNFVzFWMllvMC9VMlNqeEZFS0JIeHk3R3lFZGJ0TE5XS3pIZWFITUNK?=
 =?utf-8?B?N25vNjg2NEJ3SXFrdkNIN2toT3pmb0NOWCtaNnhOdnZvTWdCZE1ERktnYk9r?=
 =?utf-8?B?NDh0YmlMWGprbWVDYTA2a2Y3RmVLWkR3QnJxOXVYZFFHT2RiUnZvOVBVd3Ur?=
 =?utf-8?B?Q2VVYkhYM3c2RFlSSUhzNUYxdTM3ZTl1TXFackgxQnlxZ0trUmtvZUh5ck9y?=
 =?utf-8?B?TmI4YXg2ZkFIWU5PaHVxRlBtNXVIVmVHY0c4K1Z5MDRNNlVKbURHdmZBSHIx?=
 =?utf-8?B?SjFiUHBET0hlN2JQVlphU2d4ZWQrckR0YUNWTVNoNUFUZFQrQkhmb1RmM2l2?=
 =?utf-8?B?MFduMmxSVmR1Y2t5NlBHYnF5QVFib1NxZUxGOUVTZ05wd1NuZTc1eWY5TGpw?=
 =?utf-8?B?RElPemxmSkdLN3lBTXBTVTNxL011NUpHUzBSeERNdTBmbVZxRi9nTDg1RFhD?=
 =?utf-8?B?aTdGUWpmOUFmUE80aWZDOUprTEtvTUdZZ0pUWllCNGdYT25TcGQvU1k3c05n?=
 =?utf-8?B?Q3Zia0lQU3RIM1NxcWJBWTJYOW96bHJGazFCWUowTTVudWtBc1hrZkcvWGQz?=
 =?utf-8?B?UzRqbGpZMDU3U00waHVvaWl3STN4R1VrcWlnNzlodkRHK2kxQjdBaThZeEYy?=
 =?utf-8?B?RVhXWW9oa21VSDkrZ3djQ1hodEJUNXlBZ1RFQVhUVGhLTnc1dlRzTXh4aXBD?=
 =?utf-8?B?K0tHdm1UN2VoSC9pSlhlaFJIS2E4dGJKZ1pUcStacjdKd244K1FYOWdXanVH?=
 =?utf-8?B?bWkvbHlqSlJtV1NrenFUUmN4eWJXRlhVL2NYOVg5WmlFTFR5V3RSb2FqRy9M?=
 =?utf-8?B?R3RRRGV4YndpM3BON3lrZWlEOTJoMmo0NHFyQTBqY09EV2krN3VGYW5icncz?=
 =?utf-8?B?MUVvam4xNEVjU09RRlUyb1AyVmREQ1J5bVJobjZUL0IyQzlvcWF4eW5LRmVu?=
 =?utf-8?B?bXROK1NPWnhpektaSi9JcVZaRXRHNkd2dmpUWmFNNG9IWENRWTNCVFpFeDJr?=
 =?utf-8?B?Y3lSbkljajhaOXhrVzVHdEZENmM2NGFkQ1BQYVdoSm5HeTZTWjY1bWV1Tmx3?=
 =?utf-8?B?R2d5dTEvU21iT1plc2tnVld4eFZ4WU1uSGM5VzYxbUYvVHUwdVppbFhadzZB?=
 =?utf-8?B?VlcrZnloWEJucEY3emVXaURHaFhrV3k4Q1Fva3BzcVVqLzFGUmxqUWoyTEZV?=
 =?utf-8?B?dWlFQXp3S0M3T1Q2WGpZZmtUTVBhTCt3UEdQdVFDeGpUK1VlVXFzZlhOUEZF?=
 =?utf-8?B?NEN3Y2ZCNUZLbDFmd1hNdkZQZmIxU2IrbHJpYjdrSzR2aU5ZV0Y3aCszWnpo?=
 =?utf-8?Q?d8DAldN9+VLJa05Jl5q9T2XOT?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7aa10c-c431-4c22-a08c-08dbda425dbf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 18:51:18.2221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNsZU0S7sVsMGYcCdy3NEz1Zp/GCRQ2hQwKn51396no4vRWwGCkwna1zCGwX4V+/zWtQoHqJhzcVz2LmL9cEtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6476
X-Proofpoint-ORIG-GUID: mbgIb_PQiip0v2arok7YgEN_zupJKCyh
X-Proofpoint-GUID: mbgIb_PQiip0v2arok7YgEN_zupJKCyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_06,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.053, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 31/10/23 11:12 pm, Juan Quintela wrote:
> Fabiano Rosas <farosas@suse.de> wrote:
>> From: Het Gala <het.gala@nutanix.com>
>>
>> Integrate MigrateChannelList with all transport backends
>> (socket, exec and rdma) for both src and dest migration
>> endpoints for hmp migration.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
>>       bool resume = qdict_get_try_bool(qdict, "resume", false);
>>       const char *uri = qdict_get_str(qdict, "uri");
>>       Error *err = NULL;
>> +    MigrationChannelList *caps = NULL;
>> +    g_autoptr(MigrationChannel) channel = NULL;
>>   
>> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
>> +    if (!migrate_uri_parse(uri, &channel, &err)) {
>> +        goto end;
>> +    }
>> +    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>> +
>> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>>                    false, false, true, resume, &err);
>
>> -    if (hmp_handle_error(mon, err)) {
>> -        return;
>> -    }
> I think that dropping this chunk is wrong.  What assures that
> qmp_migrate will not give an error?
>
>> +    qapi_free_MigrationChannelList(caps);
>
>
>
>
>>   
>>       if (!detach) {
>>           HMPMigrationStatus *status;
>> @@ -766,6 +780,9 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>                                             status);
>>           timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
>>       }
>> +
>> +end:
>> +    hmp_handle_error(mon, err);
>
> Oh, you put it here, but you enter in the detach case even if there is
> one error.
>
> I think it is easier to just repeat the hmp_mhandle_error() inplace of
> the goto.

Okay Juan, will add hmp_handle_error() instead of goto statement

if (!migrate_uri_parse(uri, &channel, &err)) {
     hmp_handle_error(mon, err);
     return;
}

I will send new patchset, squash previous commits and add the tags 
wherever required.

> Later, Juan.
Regards,
Het Gala

