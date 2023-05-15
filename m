Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380E70314B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZwA-0005Vu-Fo; Mon, 15 May 2023 11:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyZw8-0005VE-FW
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:16:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyZw3-0007tC-RH
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:16:32 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FAfHGp031270; Mon, 15 May 2023 08:16:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=ny66O2V+QPJ0oE04dkGk63hs4ag3vg/ZrAdu3OqFql4=;
 b=gqEgRDOuaiUF7Zv20sqabtiCi3BXcT1l19DR+/n2dmXoQvErKoUA5m2zba3LSVaj3HtV
 uK/2v9WGMIuyiob05RG9BBfHw6vnJuJ38pfTXVpaBVC0WU71PhbVFlzJGChCMejG9Maf
 Ff1vRAlutd7FZVWwBOHYBRF9AT5ggBoO8XcjD04TWYh2HYw7EN9qMiDYgDghjT95cuIa
 QjlSLNnblcZD+RHaKpzjQHG7b5OJbI7cj2qKhB+bdmQK/olBvSrxBeJlB0X+VUNLGGxk
 ib1ZwcVFD/ucY7egkRZGJWbrYF/Aw29uy+2fEWL5UMCRoCDWPLXaEhygZ1wDGAros7Lt dA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qja303s8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 May 2023 08:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdZ/zHJ2SC1dvJqOWgyD1Fz6LxqZBouuRh90qdg8OQvLo7d7Qdk0wAw6EQhbrtuAX/vtRZGxIVuRYgdaysJBh9/KMsxaQ5pP9MUsD6J7vwFvu5TUFuUzxfDAlR0X+UfwBpoSoeacAYwzXjopaXlOKtuXQ9AR87X765R1ZYnme7WIUQGf9ET0dJRSfjg4BxC7412ccVo9UHwhV/soNOAxP8NG1qXAT7530TmUeVilhTpn2IPuXlSt/JZclMZA6No3y+2KddkoRywHh7zQtwvMgfL07QLRbUYw0U223V1rP4VD0Fle4bAwlHRqM7MT//VLqUZgJM6wPnVXw6n2P+TFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny66O2V+QPJ0oE04dkGk63hs4ag3vg/ZrAdu3OqFql4=;
 b=oOOAZry9aAm2VDrgPOgY6swHPLcbsuS+E2QhV6MknqBXlyE/agRXlHuc54vlJ8SBGmARs9lCE3/OKxtq99SNCouq3ra4bBScwDHNQnYmo0xsJgCBbeu9Iqjeyg8u43G3xzENyBye37uJEBIxPXnWXmpdNCP3WxFvZ7DhZR/6px80FGvzVhS/NA9v3fML0zAnqDn+tK++N4qMQjbydrQzFunUhMTcvy7JTJBIn1irSP7q9GhAihPjVYv7kMeSnqE/rSuf6tYS2yeURtFRzeNmdow1FuwRlq3tzspqADYJSialj9i1zSXxfTKlfNB6D0RHM42eoUEBLuDsHubNaaN1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny66O2V+QPJ0oE04dkGk63hs4ag3vg/ZrAdu3OqFql4=;
 b=qg/j7wXVdgTH1FAZGGMwI//V84+eaBkjOsfvBwaxgICHEAwPFSozzVeX8x3reXhHvoLfkRFdP+rX6sNrbhWuggC4dqFG1BOU9de1WBPi9OgEFsEEsVi9SQ4ZWPQpHiAMIAgUlP7+FRFQcPubuviJ7W5fRJ1E/eQD3lfp1OCwQVJn0GaCGvYZeQt3oyT/xW79IIWIAEe3jzCFUI5mHM5q++mgU7j37jqDu/0T3VBhN1IMKwaIQxrH4GlvFeslVcuqPATRIj+vMWHE7B0+qkUEd6lHW2E/kqeuc7XBxXbLYBpaGelo4o02uKbIpuI+o0RaTxh36K4uUO/W5cxfC9rJnw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM4PR02MB9006.namprd02.prod.outlook.com (2603:10b6:8:8b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Mon, 15 May
 2023 15:16:23 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:16:23 +0000
Message-ID: <381c8c37-3e9f-43e2-4920-3f9ea09ad54a@nutanix.com>
Date: Mon, 15 May 2023 20:46:12 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/8] migration: converts socket backend to accept
 MigrateAddress struct
To: quintela@redhat.com
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, prerna.saxena@nutanix.com, dgilbert@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-4-het.gala@nutanix.com> <ZGIGxf5WaHwasY1p@redhat.com>
 <71658ac2-6aa9-cde3-0eb9-82dae3c7ed0b@nutanix.com>
 <87wn19y7mw.fsf@secure.mitica>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87wn19y7mw.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM4PR02MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 8777bdc9-9974-44e9-119d-08db55575817
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mju3sZd3W5xfC4lfpgtsDCGUZXTdy3mZBxGHQKyt3VTGTxNlP8pjezVhXOJXvWmgBaaad6gCVZOIVWYCwIwVfl0aDUk4x0jEjYOHZzmuz/8xzp83HTzVCSIjlpJa5gxmD9iabThy/HYpvZCTaE7qz+Sxyt4rn2CgWpmxd4mHQaqjAmhj4zzyRhgu8dnA+QQjuJ0EXEkRAdOuzDlyHZmMvZNenC1EXb4a1VwLqrQTt7AxM14dipJ9cJ26DHL2HqXiM/6N7vPns99UpXRyi7nBSJ0aDwn9MV7V+9ucPc4TeB4XHh3iPgLLW2YgRiyV1zUsAt/O0E3EtvpCyu4DTfQ25Wjnp9lOm3Cu6fre/gXHAywWNQxzne1/0+H9lDZ7A6nEHsjtoVaYeoq75TaIm/3C3TjCLOQz413ApjXCuB4A6LWZWPjfVFY8GS/GQtcKVc8j78lAFf/dUoJ+xyAcD1V2TxVgJ4stAVEZ+3GS8w5Dfrmvxg7Xudy2r0vejGwSgTs/qARmE3Y0NCbT6osjyIErY2aJab7EgulXfvrWw3UROGA4pQKIGyGlkVPpuaWRdbbEk91SH5NFVMVxokHDB0OkMJGQu0vDv4G7/wBA4XKOd5aFxLhWPLBQu9rm9nUWMdHHpjCLvb8X9lZFg/j4tGYBDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(83380400001)(6486002)(5660300002)(44832011)(36756003)(6666004)(2616005)(41300700001)(38100700002)(2906002)(31686004)(8936002)(8676002)(26005)(6512007)(86362001)(53546011)(107886003)(31696002)(6506007)(316002)(4326008)(186003)(6916009)(478600001)(66946007)(66476007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEt3WEltVmhqbFBVblNEVHJSRGs1L2NEV2dHRjU4cjVLZmpDMTh4NFo0Zkd6?=
 =?utf-8?B?d1UyejhtWWpjOW55K3FFRWt6Z2ZjaDJxOEViNGlRaWpLRWxBdlluYkZCa3N5?=
 =?utf-8?B?UzE2TllkS2xWdC9NVkdMaWZXZFhmV01LRldSb1dUS0JYZ045c0J4UFFVRXRG?=
 =?utf-8?B?OUlPdzNEdk1uSWVEYSs2T3Z6ZkVYV1dTazNDTHA5N3YrSXJ0NWw1YkFsTDJB?=
 =?utf-8?B?S25tT1F1QUtCbE9yQnRXSUJyNnJiSEhBSURsSERMZE5WRlJ3R0tpaXZzNFd2?=
 =?utf-8?B?N3ZlemJWMXNXYlQwb2UwUm9RRE5NWUJMbkdQZFNBUzM1NjNUaU1lemZlQ2RD?=
 =?utf-8?B?UGVkbWFEUTVYdmhJekVJSlRXNy9ybktST0w4RVBYNTNwZnBKd0J3Y2labGF4?=
 =?utf-8?B?ZnQ2bE8vVk1Nb1ZQQlZJYWNCc012RklYNlBhbVB6dVpHMEhDU29Qd2pSN21x?=
 =?utf-8?B?RFNLMFFjVjFNMlJtWVIxb1NqQmVJRlBxSEJodHBVQ2V0ZUNYbkp5bjh1akp1?=
 =?utf-8?B?SnM4bE9oU3N1LzdHVE5DTUFnR0F1N1g4citqc05wdWlyMTVWMWo3Yjd3T1k4?=
 =?utf-8?B?TnpBOVdFUHc5eFJCMThOblZDYXpJUVRvMjhVdTl1bUIzeFhWQlJxUUFHQ1hT?=
 =?utf-8?B?a2ZRb0pFY2hvajY4UFkwLy9uK0oyL1F0NlNKNXNBeHYyZnM0ZnJLaS9LV2dS?=
 =?utf-8?B?UTRPb3lubURQTU1wRDhmTDkwVVpDNG81U2MxRHRyc2VsVHVLNUlvUmxnS05M?=
 =?utf-8?B?OXpiN3U4a2VVeU1ZYm9tS3I1Z2c4RElPMjByOWVZQVlTalY3MlVCUnlYWVcr?=
 =?utf-8?B?Y0pXc2hUeDZaWi9NanJnS0JCeThHdTAzU3FsT3lLVWgvRm5wRkZ6bElCZjJJ?=
 =?utf-8?B?cUsrSXpOalFiU1NvRXgydHdoU1RaRWRiQk5CaFA1WkZBcC8vVXhZNnpLNTFr?=
 =?utf-8?B?c3BIQVRwMmUzaW8xNVVBanh4MnhoVGk1ekN2QlE5M1QyOGE4RlJMSWErdVZr?=
 =?utf-8?B?czBuUHpzVjJOVFVWTzB3aFJ6VmhIY3k0Q1BYaGhrdzB0NThUbFVxYmR3OWcw?=
 =?utf-8?B?SHlXdmc2V3czTWhTSnc2TGFQR21kWitLM0FkejNRQ2dJT1pJdTJ5dFdzN0to?=
 =?utf-8?B?TURuOVE2U1RmcEpOV1NVOGZCSWJVclNqS3FlMG0zRjRpWWxJNFlrT2dLN0t2?=
 =?utf-8?B?TGdycGZic3hJOTlTMFg4NkJpYUNLWjBBUDJOd0JxTnNlNUsxbE9XcFhWdDJl?=
 =?utf-8?B?S2JENE5FaXVqYldiNUM0SUhvdFhZdGhSREd3MHoxdkVjUHkxdFkwUGMzVUZm?=
 =?utf-8?B?SjZneW5DOEF0WVJuaTN5dUpXK1cwSDJnTjYxUlprZlYwMXk4NmMrckJTNXh1?=
 =?utf-8?B?RkNLY2JmZzdleHdXOEYxWVVwMHhuZCtzMTVxUXFKc2hVNnFZcTBBUVpDUGlJ?=
 =?utf-8?B?b3RRNWxKUFlIdVJaSDVRcEdTUHhyaWV4UVIxYWpleXV6YmJOUnd0TkRUbWg2?=
 =?utf-8?B?NDJhTzFuSUtDcHIyR3pRbUZQTFJGWGpsb0lQSVZnTll3MzhzNGU5Z0hkQzRP?=
 =?utf-8?B?Vm1EWW02MERSZTkvbW5mWGF6Y052OHZFWmxDeXdMejA5QU9DZmJNcUhuRTZy?=
 =?utf-8?B?dWlUTzU0NCtjM2ladUZVcU1MWHJ6RkNVdG1GK09iL3JJcEd2SlhuR092MGli?=
 =?utf-8?B?SXMzUjVUYUMyRHk3bDJGVkQxbitFSHlaUEl3dkFBOUZpaFJDN3FVSXVZSnpJ?=
 =?utf-8?B?SGdBOXliY3pXaTJMTFNZSGxqaGRBbnc2c1ozdVl6dVNOSCtMVFVrOTV3Um9G?=
 =?utf-8?B?Q2Z3QktOT3dDaWtkNU9wTGx4MG50eHBGQ0dBSW0xb3RuQkZnU0FQV1Bwek8r?=
 =?utf-8?B?NFNWYkZhekt5STVNYWhrUDJnTGx6K045WXZ3eDQzSnVtVUJ5ZHlRM1lDVGJE?=
 =?utf-8?B?aE5rWmoxSjZPR3RSV1NXbFNiMzBHbCtqenRnaUlZRURIdC9zUkZQNkcvK3Fi?=
 =?utf-8?B?YkhLUVU3S0VqNmF4bSs0QVlXUzFEWmxEMjhUTlpxcFhlandaUFhJZmdudzJM?=
 =?utf-8?B?ZWdud1RERHYyQ3F4TnVDSDhycmNHQW91WWNtR3N4V2lDSW1VOStSMDN1cEJD?=
 =?utf-8?Q?r2zGuBVRrfguuLEjqUyMQ4mNx?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8777bdc9-9974-44e9-119d-08db55575817
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:16:23.5286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nnqqxBWhmNOkDJFntbTItkizW619Go02usUosRibKjw5bHyjP8kCpGmvswPoBnK1yEWW55vFYz+t90CfsnLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9006
X-Proofpoint-GUID: VpZvJJ7iUJd1Y-GdmKg3ueoymR1upJ8_
X-Proofpoint-ORIG-GUID: VpZvJJ7iUJd1Y-GdmKg3ueoymR1upJ8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 15/05/23 8:16 pm, Juan Quintela wrote:
> Het Gala <het.gala@nutanix.com> wrote:
>> On 15/05/23 3:47 pm, Daniel P. Berrangé wrote:
>>> On Fri, May 12, 2023 at 02:32:35PM +0000, Het Gala wrote:
>>>> Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
>>>> new wire protocol of MigrateAddress struct.
>>>>
>>>> It is achived by parsing 'uri' string and storing migration parameters
>>>> required for socket connection into well defined SocketAddress struct.
>>>>
>>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>>> ---
>>>>    migration/exec.c      |  4 ++--
>>>>    migration/exec.h      |  4 ++++
>>>>    migration/migration.c | 44 +++++++++++++++++++++++++++++++------------
>>>>    migration/socket.c    | 34 +++++----------------------------
>>>>    migration/socket.h    |  7 ++++---
>>>>    5 files changed, 47 insertions(+), 46 deletions(-)
>>>>
>>>> diff --git a/migration/exec.c b/migration/exec.c
>>>> index 2bf882bbe1..c4a3293246 100644
>>>> --- a/migration/exec.c
>>>> +++ b/migration/exec.c
>>>> @@ -27,7 +27,6 @@
>>>>    #include "qemu/cutils.h"
>>>>      #ifdef WIN32
>>>> -const char *exec_get_cmd_path(void);
>>>>    const char *exec_get_cmd_path(void)
>> Even this, I will shift it to the 2nd patch, where I need to move
>> exec_get_cmd_path() out accross other file (migration.c).
> great.
>
>>>>    {
>>>>        g_autofree char *detected_path = g_new(char, MAX_PATH);
>>>> @@ -40,7 +39,8 @@ const char *exec_get_cmd_path(void)
>>>>    }
>>>>    #endif
>>>>    -void exec_start_outgoing_migration(MigrationState *s, const char
>>>> *command, Error **errp)
>>>> +void exec_start_outgoing_migration(MigrationState *s, const char *command,
>>>> +                                   Error **errp)
>>>>    {
>>>>        QIOChannel *ioc;
>> Sure, Juan. Will change this in the 2nd patch itself instead of
>> here. I am not very convinved why should we have a different patch all
>> together for this, because we are just using this code outside this
>> file in my opinion? But if you still think so, I can make a different
>> patch for that.
> It is up to you.

For now, I will keep it with 2nd patch. If any other maintainer also 
thinks that it should be a separate patch all together of windows 
support for exec, I will make a new patch for that. But thankyou for 
your suggestion 😁

>> Juan, I get your point. But I think, we won't be needing local_err at
>> all, if I use g_autoptr for 'channel' and 'saddr' is a part of
>> 'channel'. Let me have a v2 patchset and if it is still not
>> convinving, we can have a discussion on this.
>>> THis leaks 'channel', and free's 'saddr' which actually  belongs
>>> to channel.
>>>
>>> With my comments on the previous patch suggesting g_autoptr for
>>> 'channel', we don't need any free calls for 'saddr' or 'channel'.
>> Right. With g_autoptr used for freeing 'channel' in last patch, we
>> wont have to worry about freeing 'saddr' at all. Thanks Daniel
>>
>> if (local_err) {
>>      qapi_free_SocketAddress(saddr);
>>      error_propagate(errp, local_err);
>>      return;
>> }
>> And after changing the position for assigning 'saddr' and using
>> g_autoptr for 'channel' I believe we can get rid of 'local_error'
>> variable too and replace it with 'errp'. Please suggest if I am
>> missing something here. TIA!
> great.  That is much better.
Ack.
>>>>    -void socket_start_outgoing_migration(MigrationState *s,
>>>> -                                     const char *str,
>>>> -                                     Error **errp)
>>>> -{
>>>> -    Error *err = NULL;
>>>> -    SocketAddress *saddr = socket_parse(str, &err);
>>>> -    if (!err) {
>>>> -        socket_start_outgoing_migration_internal(s, saddr, &err);
>>>> -    }
>>>> -    error_propagate(errp, err);
>>>> -}
>>>> -
>> Actually Juan. I don't need this function at all, because parsing of
>> uri into socketAddress using socket_parse is already done. So there is
>> no use of having this function in the first place, so I decided to
>> delete this fucntion all together. Same with incoming function.
> What I mean is that this code was already there.  And it was doing it
> wrong.  The parts that I corrected you were using this pattern, chcking
> that err was NULL, intsead of cheking that saddr is NULL.
Yes, I get your point. But that function is useless if socket_parse() 
function is not needed. So have omitted the function all together as 
socket parsing is already done in earlier patches.
> Later, Juan.
Regards,
Het Gala

