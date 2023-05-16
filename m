Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE17054D7
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 19:19:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyyJt-0002EW-OL; Tue, 16 May 2023 13:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyyJq-0002CT-15
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:18:38 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyyJm-0005Td-0P
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:18:36 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34GH4dLf026444; Tue, 16 May 2023 10:18:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=r7q17gziEuC+RuKMS5iiATNRb0DVT6vgFYZQSsBR94w=;
 b=iIzvEVMIegPEC1C/s9rIG+GoNexfUkMCkMg0xsjAZs5mqTyp4cDioZG7RTvq5hohOsMY
 KxfVpdww+/16kWo07HTYgAw4YzP7FpHWS+mp8HKszpBZYMoM1k4vZd5SEN8ldVo1Q2+P
 e7qmi7TFqphsrswrotM3FJcDKdhXYLRsr7RdZ0ciaR6YSNAoGNaUjUjs5jog2SN/OBCs
 4Fji1v46hzDuduaii/zhlOenCytcaGxwbCO6RG2Sh8LA6afnPnYJUgMLbyJ9mmspWX8k
 HbHcbgWiBJQ0i24GbBigRisG2t9huxmCxNK6WlQEhTDenYoQOk7CiXSx/Nfqa4aDubwz aA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qja306nc6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 10:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0eMVY5KknaPBlVYA3B24KitL9Xx5uJsZ6/Q9Nkif3tb5nA+uLo6XWwL2LcsFFAu0CVdhayDQw+sZWJBYGO65jEw/bSimxRDQqWACITWp6S4FiAiU/g1BSQvhs7wxKIxl4xWDbzBVViNREhmw55mWV9CTMIrwdFjs9DUX/aVlzhD/1G47wCxolweRkpZtospUPsCTQ5cDtICCzyyva4AAZDhe3PghQQQOFSMDVSSlsstrlDog6/PAVssRnpT2PQHXlllacuP7iiU4yjSB2pzIrAk6nGg4nKpPokfFGw/Q8cToSLOFtxT3iEY39o9MUJxTP9HEmRqZL9NC3H/8IQ9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7q17gziEuC+RuKMS5iiATNRb0DVT6vgFYZQSsBR94w=;
 b=HjMB5rCJecqWQ+4KoeOWf9Kv1Ob4fa4b4ztul+6/8XypI2wBUsI/XZirURKLqH6S0LskkFXm0LAN6P4zCLHErQO5UOO2jgSDHsUvHUfZZcpNbQxzsWdgvNzJOhJo51IZy3pl/oSi3OP7qJOqE+SgtzK23J4b44OiH2EyDOvLR5D13hhOYN0BT7r4vnvUmEvIHhKvOQFDlrtq5L35LipcEv0lWSOar57UjQ9e7yh8VjmdNluSg+aVo4yLXszywvjAsFk0PSxpQZ8hrEu0HTWubkcd797H21n/Y507IhlNwicpLHffEyPCKFbJ8O8dz7rbuaY3tA12AjZh8Ff95UesBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7q17gziEuC+RuKMS5iiATNRb0DVT6vgFYZQSsBR94w=;
 b=cHcL3nZ1OiFFc4Ct60lYpHeO8FzKwGsAomCsjHTSc5K0Tc9lVrKJc7DRUQqP3V0rrMg2Il1Bjr9PEwFidEjKXgr0iw2E3hlk7OzBHw0INswueoYqe9r7RkZRDbsAelWcdkgOVstNO1xe2QzmAcvk5jYoEgn4QSDawXR6vAuU9lNzM1kLf08OZ/pBtdVx8TWPHKxdYYdsAVMb5FQxa0m77WrK+s7Trhj7ZDtY1/QUgVyibxMoos72mQLKJS4hkZdX8ygZ9F3GHEn3QrpPT0wbajclBz9EIlkGMxgLFA/C+EabqXX9rmJAo8Awpp5dajKVOs6ZKyTRW8iqpScpEknf0Q==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA0PR02MB7498.namprd02.prod.outlook.com (2603:10b6:806:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 17:18:28 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%6]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 17:18:27 +0000
Message-ID: <06881487-aa29-ed63-53da-6f4323bd7cc6@nutanix.com>
Date: Tue, 16 May 2023 22:48:16 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 8/8] migration: Introduced MigrateChannelList struct to
 migration code flow.
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-9-het.gala@nutanix.com> <ZGIMk9wKg9h6pndM@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZGIMk9wKg9h6pndM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::7) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SA0PR02MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 161f13a7-5b65-457e-ac84-08db56318fd4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GdVbbRyI5qVfSd+J7kN8A0QPJqw7hmAqc1xk8sxRU3HObdMuI68EhfqwcrOcqZ/GA7qMl5SxBMDdhDKG+bz37U8lK7LR+QmUTrIfWLTs8g+6/2Sdbr/Vc1RrhGAulPqhcb8TBCoq/1ENJuS/runJk1iPmIrbhBtu6BbnunqW9oKp/1JhGCze1R2p7siTrhm6cEcFL8JoP+1UsvvgIT5cqfvNp8GgOzYpS5CGMO2Z/1E5bF9vip8cvj2fUHHx5glKlOrSkeKYaimw8/pHlskoveIyzZar9wpPJW/4B/0aIUBPIMdhbLYFtDQXbvdC7n2FO17gXN1mpu/raHjpMcj4mTzrH/T97rl/2ot56bpgdelPdZYan2IlUdphWPXLnIJEDxHNGzPXGhcxqt3uSJn8Uv7zqPzG4zZ3YfLWQnxgANhadxbaUR7YrGx6GlrPI1+yKjMpfJ6aDT4CU9TWJaL6tLPSc0SZhBDycofniYWjkro9j0C+kfQavIqbcJXgVCPwuzoXBB3bGWrF9W74pTNEQKWP1ihnAu+zR8/VXhvCBbIvVR3dB/rbEIqQF0RyDgnMM/XoAnrFAW86LdgPSaA/hnGNB6kbsM3S+RywRYOllsMDlhlsu1iyxzlwZTGCoxwe1nm8dI+PyXaek0Nl2t+KYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(53546011)(6506007)(6512007)(26005)(107886003)(36756003)(83380400001)(2616005)(38100700002)(86362001)(31696002)(186003)(2906002)(478600001)(8676002)(5660300002)(4326008)(31686004)(6916009)(8936002)(66556008)(66946007)(66476007)(44832011)(316002)(6666004)(6486002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRySmxyQ25hTTV3Unh2VnBpL05lNFpYWEFCa2U0Sk1zV0xjR3gyUTFzVHBR?=
 =?utf-8?B?RVlyVmZLNWp4d2dlRVkyemtpRFNlM2xlYjFJUWQ0VUpIYXc1VmoxbEhUcWQr?=
 =?utf-8?B?OStnVVF2ZGVWOThyU3FUWCszdTBGVk9OeVlhdHQwVk42ajhoL3JoT2JvZ2Vy?=
 =?utf-8?B?NjgzV2FWUENDZkpYR2RiWk1rUlN2bm03VWtSYWdhRFk1enNzbnNaWXpRWStI?=
 =?utf-8?B?T00zblNaSjJ4SnliWjJXTHJIVm1EcnV3bEtQMDJma3FHUlNqaXJ1Z01hWkpS?=
 =?utf-8?B?NytjN3Nxc1BzcDhwYWRsbzlxZjBvZFZEaWRDSFJTenF6WlVWVG9ZT0pSeWZj?=
 =?utf-8?B?eXlYMEIydWlMNHFnNU0wRStTSzBObDkyYVNKUktMMnNibmxoTGNPRTVtK0FV?=
 =?utf-8?B?a29WZzVCOEdiV0dRTXBURUNWNzZ2REJadkU1N2h5U3FtOWJpcmNTWDZxWWRo?=
 =?utf-8?B?Y0Z6TTA0VW1FK2g2WXcwdWRldVZlQkdHWUNpZ01uTkw1K1BndjRMQXg5dlZo?=
 =?utf-8?B?YldQc21DQ2tGMWs0dWdDcC9vdUh0anB3ckVDT2dqazVNK3h3WFV5TlUyNzcw?=
 =?utf-8?B?cVBTL0pXbFM4MzFuSWNDd2tFekU1U2EwNmNsZEI2YkNTSmREcWZYQ2NUZ2xv?=
 =?utf-8?B?YTlIOENoSE9qUWpyWE9OVzFFVlBWMDFOdDh0ZEJSNFVGeG5PS1hycWYyOW5U?=
 =?utf-8?B?K3A3SVpTdnUyTjMwNXMzbDgvelhMKzdmY3RIQks3V1BhSjNxZUUwSEpBUFNT?=
 =?utf-8?B?K1VsWGtkeEZhZlljUzZXT2liU3FDWHovQlhBdGNMOHVOcjFhekJ2SDE2dkFW?=
 =?utf-8?B?K1hNRU9FTEJ5eCtTZGVoR0t3WUZtb0JIcjB6Y1VVTGlhMVRES3VvU2UxeWRH?=
 =?utf-8?B?MGNsdUFXVmJNYzBSTEVlTERYSGJHMk05OFR0RlJhUFFIT09tZmhnSlVQTDRQ?=
 =?utf-8?B?WE00WDdGN0NQYnZsa1hWdVVDaHRidUkwU1JIbFEvcmRuUXRIRDN1NGlHek53?=
 =?utf-8?B?R1N2VVMvVnJkMWRhMGxRcW8xbXdoaVIyaXNwRE1tNHZDMWdoa2MzNFVSWkZu?=
 =?utf-8?B?NHRocnM0bG0zb0plUG9sN3RKazBxTm1BVHN1MFVrUEgwVFNpdVA3dEFwbXd3?=
 =?utf-8?B?N2JhbDUwMEYxWlliclNKZDlESmlaTFk2QnVlQVJwOVR1aTJDYkRnOXNDTnB4?=
 =?utf-8?B?TmxqRklYbVV1WHNseGFiZGliWGtSZlZFUUtLVWk3QnpUVjZxdUkreHltbnpQ?=
 =?utf-8?B?V1BRVFo3bEVrUUl1YURWLytKcEVQWWJia0p3ZHFnKzVLZzQ3Z0duTVNidnJi?=
 =?utf-8?B?aW00Q29VMEU0dUUrdU1LRjd1bDdCM0JPbUdqL1F4UlN3T0xNRjJZbjUyK0xQ?=
 =?utf-8?B?c1FVd24zVlg0VTBvcmdrSmZzblJmcFY2cWovV0NlM0ZFZzloeHVjTmJvLzlU?=
 =?utf-8?B?VmxtN3A2UXdQK3ZnaWFzQ1NjRUQwT2h4Uzhubk5QL0Z0ckowYWpMdWtLRjBN?=
 =?utf-8?B?RXUva3FjMkwybkFoc2F3d1VrZm1IcVFoZCt2aEJicnpHOGh0UEd6TkNlN1JW?=
 =?utf-8?B?Z0E3MEwyK3IrV09FcUZYRjBkNmRudGdsRXRUQ3V5WWZBTTkxN3VOeWJkcVQv?=
 =?utf-8?B?dllvSmR5ejJ6YlowdmZzOVMwaG4waERLVWxhTWF0ZUFmYjlpQUhoRDF5dC9x?=
 =?utf-8?B?ZEdXK1NvS2dvNjhiTkdURU80b2JEWm8zOEVwNGZaOVhyYUh6NEtwRm5ZdW1l?=
 =?utf-8?B?eDRvekEzK21TWEt6THhVamdiTFlFeVBxYXBUaTk3b1B3T2tiK0JsdnRWMlkr?=
 =?utf-8?B?aHNnRDk4YXBmakJ5Vmw2UE5VOTcrTFlpRnFZbkFBVko4QkxPQVEvKzJCOHRh?=
 =?utf-8?B?cTU1T1JTRjdKMHA2VXg3enRpZWZoWHNUekJFeFNtUDFZOEtzV0s1L1FSdTlm?=
 =?utf-8?B?YXMwV1JKSTc4eDZESzFIWTV3YzgxN004N2ZZaEE0QysrOG9RNGRtMHFhanFa?=
 =?utf-8?B?d0M2Zk02RlBKQ0hqb3dQOHQ5QWlrdTRLRWRrOUVMbkVhdmJ2TS9DOXVQRXFi?=
 =?utf-8?B?SkpqN04vbTdZUWJ1bVNZWkRlTFNqSU5PSGI2ZmJQMlFRNHJFSFovbkI4c2Er?=
 =?utf-8?Q?jYqMx0CTNdRUPvAegkJX1vDzF?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161f13a7-5b65-457e-ac84-08db56318fd4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 17:18:27.4391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9g7ZAFgtNJneqfczx9I6ryZ6vhooe21vT1kiwFzX4I5WiN4ZrKJq3U9xywpfdeIEYhGUGLDeUxwCfp2iQxIu7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7498
X-Proofpoint-GUID: 7KZrkd_NZ7Lc0CFlAPFcwsffrf9T0xJb
X-Proofpoint-ORIG-GUID: 7KZrkd_NZ7Lc0CFlAPFcwsffrf9T0xJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_09,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 15/05/23 4:12 pm, Daniel P. Berrangé wrote:
> On Fri, May 12, 2023 at 02:32:40PM +0000, Het Gala wrote:
>> Integrated MigrateChannelList with all transport backends (socket, exec
>> and rdma) for both source and destination migration code flow.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   migration/migration.c | 95 +++++++++++++++++++++++++++----------------
>>   migration/socket.c    |  5 ++-
>>   2 files changed, 64 insertions(+), 36 deletions(-)
>>
>>       Error *local_err = NULL;
>> +    MigrateChannel *val = g_new0(MigrateChannel, 1);
>>       MigrateAddress *addrs = g_new0(MigrateAddress, 1);
>>       SocketAddress *saddr;
>>       InetSocketAddress *isock = &addrs->u.rdma;
>> @@ -441,6 +442,7 @@ static bool migrate_uri_parse(const char *uri,
>>       }
>>   
>>       if (local_err) {
>> +        qapi_free_MigrateChannel(val);
>>           qapi_free_MigrateAddress(addrs);
>>           qapi_free_SocketAddress(saddr);
>>           qapi_free_InetSocketAddress(isock);
>> @@ -448,7 +450,9 @@ static bool migrate_uri_parse(const char *uri,
>>           return false;
>>       }
>>   
>> -    *channel = addrs;
>> +    val->channeltype = MIGRATE_CHANNEL_TYPE_MAIN;
>> +    val->addr = addrs;
>> +    *channel = val;
>>       return true;
>>   }
>>   
>> @@ -457,8 +461,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>                                             Error **errp)
>>   {
>>       Error *local_err = NULL;
>> -    MigrateAddress *channel = g_new0(MigrateAddress, 1);
>> +    MigrateAddress *addrs;
>>       SocketAddress *saddr;
>> +    MigrateChannel *channel = NULL;
>>   
>>       /*
>>        * Having preliminary checks for uri and channel
>> @@ -467,22 +472,30 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>           error_setg(errp, "'uri' and 'channels' arguments are mutually "
>>                      "exclusive; exactly one of the two should be present in "
>>                      "'migrate-incoming' qmp command ");
>> -        return;
>> -    }
>> -
>> -    /* URI is not suitable for migration? */
>> -    if (!migration_channels_and_uri_compatible(uri, errp)) {
>>           goto out;
>> -    }
>> +    } else if (channels) {
>> +        /* To verify that Migrate channel list has only item */
>> +        if (channels->next) {
>> +            error_setg(errp, "Channel list has more than one entries");
>> +            goto out;
>> +        }
>> +        channel = channels->value;
>> +    } else {
>> +        /* URI is not suitable for migration? */
>> +        if (!migration_channels_and_uri_compatible(uri, errp)) {
>> +            goto out;
>> +        }
> THis check only gets executed when the caller uses the old
> URI syntax. We need to it be run when using the modern
> MigrateChannel QAPI syntax too.
>
> IOW, migration_channels_and_uri_compatible() needs converting
> to take a 'MigrateChannel' object instead of URI, and then
> the check can be run after the URI -> MigrateCHannel conversion

Yes, Daniel. Got your point. Will change it in the next version.

For Juan's comments, I have not explored the test side code still, so is 
the idea to have some similar test functions like 
test_precopy_tcp_plain, test_precopy_unix_plain but with the new syntax 
? Please confirm this, and any advice on how appraoch this?

>>   
>> -    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>> -        error_setg(errp, "Error parsing uri");
>> -        goto out;
>> +        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>> +            error_setg(errp, "Error parsing uri");
>> +            goto out;
>> +        }
>>       }
>>   
>> -    saddr = &channel->u.socket;
>> +    addrs = channel->addr;
>> +    saddr = &channel->addr->u.socket;
>>       qapi_event_send_migration(MIGRATION_STATUS_SETUP);
>> -    if (channel->transport == MIGRATE_TRANSPORT_SOCKET) {
>> +    if (addrs->transport == MIGRATE_TRANSPORT_SOCKET) {
>>           if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>>               saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>>               saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
>> @@ -491,23 +504,25 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>               fd_start_incoming_migration(saddr->u.fd.str, &local_err);
>>           }
>>   #ifdef CONFIG_RDMA
>> -    } else if (channel->transport == MIGRATE_TRANSPORT_RDMA) {
>> -        rdma_start_incoming_migration(&channel->u.rdma, &local_err);
>> +    } else if (addrs->transport == MIGRATE_TRANSPORT_RDMA) {
>> +        rdma_start_incoming_migration(&addrs->u.rdma, &local_err);
>>   #endif
>> -    } else if (channel->transport == MIGRATE_TRANSPORT_EXEC) {
>> -        exec_start_incoming_migration(channel->u.exec.args, &local_err);
>> +    } else if (addrs->transport == MIGRATE_TRANSPORT_EXEC) {
>> +        exec_start_incoming_migration(addrs->u.exec.args, &local_err);
>>       } else {
>>           error_setg(errp, "unknown migration protocol: %s", uri);
>>       }
>>   
>>       if (local_err) {
>> +        qapi_free_MigrateAddress(addrs);
>>           qapi_free_SocketAddress(saddr);
>>           error_propagate(errp, local_err);
>>           return;
>>       }
>>   
>>   out:
>> -    qapi_free_MigrateAddress(channel);
>> +    qapi_free_MigrateChannel(channel);
>> +    return;
>>   }
>>   
>>   static void process_incoming_migration_bh(void *opaque)
>> @@ -1714,8 +1729,9 @@ void qmp_migrate(const char *uri, bool has_channels,
>>   {
>>       Error *local_err = NULL;
>>       MigrationState *s = migrate_get_current();
>> -    MigrateAddress *channel = g_new0(MigrateAddress, 1);
>> +    MigrateAddress *addrs;
>>       SocketAddress *saddr;
>> +    MigrateChannel *channel = NULL;
>>   
>>   struct SocketOutgoingArgs {
>>       SocketAddress *saddr;
>> @@ -114,12 +116,13 @@ void socket_start_outgoing_migration(MigrationState *s,
>>   {
>>       QIOChannelSocket *sioc = qio_channel_socket_new();
>>       struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
>> +    SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
>>   
>>       data->s = s;
>>   
>>       /* in case previous migration leaked it */
>>       qapi_free_SocketAddress(outgoing_args.saddr);
>> -    outgoing_args.saddr = saddr;
>> +    outgoing_args.saddr = addr;
>>   
>>       if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
>>           data->hostname = g_strdup(saddr->u.inet.host);
>> -- 
>> 2.22.3
>>
> With regards,
> Daniel
Regards,
Het Gala

