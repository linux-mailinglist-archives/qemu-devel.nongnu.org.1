Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5697BC651
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 11:03:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp3C9-0003xh-Qt; Sat, 07 Oct 2023 05:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qp3C7-0003xS-Pf
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 05:01:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qp3C4-00037A-QJ
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 05:01:55 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3978Fl6e001019; Sat, 7 Oct 2023 02:01:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=V7HevrcQoZlh
 SMSQ7CpIyG6XDHQsyZuIpfYR1Ch6m2M=; b=oVkmn+Z0ifUeqWxd4MO+/t3iPnEA
 4Eg5k76nZTSEesUkRlAO33tbUSWeDr/0x7OCQbnAJkSCtSw4Ar7AsJ77Rn0GD3Tz
 53MbtovX7SRxvsJjidNdJaH6bK+cpG0k8AXCMlQCiG4mgNvg1DCfFaUnCGTelHPz
 trfwm/TszxmBUvqiO/9YiVu1PN4CP73tFACTcx5BiKLJ+Kby57Zvixg1mv3MgU+L
 FHEkmPx37HlU5x369WTIX2SJeyIxZYzgGevYLEyzLztVrfrsWGQuTq0zi/+JdhW7
 ot51TTQhGKupnTEzjIXm4keGVcSajacxWEeEAMv3Hq9vVa5dl6Jt8HToRQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tk3nr8136-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Oct 2023 02:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9U9/uMBfx+0HyS/IWC+nkmy1ahsmT2JytYqtZI5c1cyAvkPyGCNtnA/0k8/kOMJ0/Rj3vqkApJCR5ADNxLxvwxd4be2RgdHVDdxTjFpgf1R4uaYho2M+ro/eUEDib1cDeXgXPVh3F/5bOg5eWZNJRVZKcpWaHT7jaXJPyW3oBvhFJOIB9VSBnH93O3ZOKKoerlzBjaTksdn6Jnj0YBC4M6bSGASrMbAD4jMc+fkpDYqPkExL5gkJ7qabMzxHqXHB6ARPj0mOc4OjKQpPmMenIeoE6LSXvPRr6gcxCuqzS5C7gixnSKlKAlQkdKpWFYh8gNcK1z8xC3MuL9DQVbb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7HevrcQoZlhSMSQ7CpIyG6XDHQsyZuIpfYR1Ch6m2M=;
 b=Jv2oQPIYVJ/wfuANB0dlRMbB19h81CBk7hu3Ni55sq0+99ITG98tNyLnSwhvro7uy37t0RMvR49XWxQK+Z6A9Eej+uLWH09B+CQwuQtMfp3p7SJa3x6hNgkRYhTYVKUTlFTU8d+osW24OxxPvw76uAYxllM0bhlT5Srm97Geo6gmSIu0f+8W9RqRYJIEEHcNBA6RZB7Gdr0y8DEaYtorLuzpdEzotSH8/XEQu2tNoEiAVsRP8LaUBgdnsKklrSuQytM0egASMyoJMwtmgmwZ0oxLu9cp5YD1FcJbPStQkHBq4FAp37v09l14DWlL3SYcKX+MRRxlvBhgq0jx2eXxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7HevrcQoZlhSMSQ7CpIyG6XDHQsyZuIpfYR1Ch6m2M=;
 b=EYZFWoe1F4fXH+vD64QKgBdMiQupUhPRNzs3NWvtahhJq4nVBweNvXLDnj9WSu2SXCjlgl0zGwgBOqK9p/mW2DoT94/1J9+GzY9ZabT6uU0wp06s/FQW8rtpunXGqAwEspHQllkRWO3P/jKSPQ77AmpZvF+/gyY1m+NYBQ4eaKPpLZE9pW4gzD4THlHQdMc2VrDLjG/ORblN2vU/lSoAnOiLXuP/NZ/H20oqnGdCYCqptSb9lPy5dwgPjM3q/4jeAGW2NaHoNpxfKBypggA8kZ+AckUotg7Uhm8iSsTPSKxVqPsSkaAl8yTaNQWowf5H5zvMng/kuZVDBXxZFT8PsQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB8285.namprd02.prod.outlook.com (2603:10b6:408:158::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Sat, 7 Oct
 2023 09:01:42 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.039; Sat, 7 Oct 2023
 09:01:42 +0000
Content-Type: multipart/alternative;
 boundary="------------BSwiZlPvKi8ftXjgecunxxI8"
Message-ID: <bb47d7b8-fa76-41cc-b62e-ca9159ccd7e5@nutanix.com>
Date: Sat, 7 Oct 2023 14:31:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-3-het.gala@nutanix.com> <87jzs2phxb.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87jzs2phxb.fsf@suse.de>
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BN0PR02MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: e432e201-5cf1-4cd6-c311-08dbc71405f3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Isp5c69jSXOnCv7WdyX8DF3RSa2AXpD5e5ZEMJ4P2hZLhD6MxpVaSe6oo5HeavVXAw6CHPQMP3Zu22MS4bASkZOHvF2T2p/fZdd0lKYogLF/ycgiyRDznDAlf2vDIyaaDk1iT7HaFwt79cEsg76PCEb8eXy8t3wWwy8/71Ll88A4Ikwdeb93Tbrw/khkK7MhCFQGJteqe3o067FSHtYq+ZsYOwZshr/huCb6FCTn3CGhhLzdaVQHEbMVZD3LIa5JEO8tzbCgwx1S7nxsSiL/3d+v2U76D5C0u+mATglE7osvXYep55+zFcsIbZs+ldggeT07BbcUkCdMfOYV6JeT2FGnNccL7IWmOJ32UnJCJgtUMKUxpmu4nEUmnZ1qhWaMOj3weCPAwIxpMiFodey9oUY3zCkArZCs1wBz71YA5Y0tlfYae5mTOrYRboXUV11xQtNIZt8+/yz7o8bA6d9411PhMU6tltBACbgaImftX7d2wWFmxemMcQwiYArmW8GkjjrAxtQzv+sOe06S4r0U7ufoZqrYmZBry3weMTnMOKmCBgkxKtvxQmveRcGpeDfgr0ofacdhDRhubmumEaWzW+7SFUo90RBnfji6t/UmmlmZP1vLfJe92Ym1pjWOE32sF80O2Zr3oT9DhAqxvH1Z8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(6512007)(316002)(31686004)(83380400001)(2906002)(30864003)(44832011)(5660300002)(41300700001)(8936002)(8676002)(36756003)(4326008)(66476007)(26005)(86362001)(6486002)(66556008)(66946007)(2616005)(31696002)(53546011)(38100700002)(33964004)(107886003)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjV5VGk3eFJRVGJlejJkVmRqMTNBMEZTTTJ6eEJrNTRUeVNiS0czYnhzQmpU?=
 =?utf-8?B?bFgySm9wOUMyOXZXQi94U3hTMWkyK0ZTV3FvWmhUODlXT0tCd0drb1diZDNq?=
 =?utf-8?B?bkwvMDNPWFNvRFQ4dFZzNEl3L3JveUhzQmNEMEh6ODV3ZkhieHVDVFVDcWQ3?=
 =?utf-8?B?SHVwQVh4RFY1UFh3RjJaR21ESWMrMi92ZUt6c2ErUTZBZTkyYkdkQlpqczJU?=
 =?utf-8?B?N0dxZDZQVW04Zy96cUdhV3hYNWlqbUhlU0Vqc0tBdUVlRGpONWVSZjZTdXNj?=
 =?utf-8?B?dVo1MjRLYzNqTy9HQU1ialFNQ2V1cnJ3dG85UkdDanJZckc4T3dsNEQwMzJx?=
 =?utf-8?B?L3JsUnp2Qlp3czhLTnhYaU9KcEpqWVREQ3JlejNuUEtYVm45eW80N0xtZ21x?=
 =?utf-8?B?aGVOdWpWR3VhOWRUYkxFRTRVSUJCbDZMTDVuK3dzTWpkbjVLMjB6T0w2UmdU?=
 =?utf-8?B?V2g4Z0huMzJzOWZyWEhnZ0UrNko3UzJ5eVpNcGpwbVVEOEt2T2RSMDFrdUhr?=
 =?utf-8?B?dlJpZFptQ1NJWk1odlFhSmF6N0M0c1RJUDVHVHlOMkZZcWsrZENwa05xL3J0?=
 =?utf-8?B?MFM0V3ZGenZKQU1JMFdjdU1yaUVjOCs2eE1hQmVCQmtRM3BpenArVW1Bb1NW?=
 =?utf-8?B?NjN6K0lhOGZHd1pPSElONFQweEVrenU0UitXdHJ4dFNBUkpPeWJJc0cwUERW?=
 =?utf-8?B?d3ZKVzQrdVpHNzdObnRoZkdIM25oNldIL0MzZkJwa3N1bis5YzZ5WjVuMTAv?=
 =?utf-8?B?NHFqUlJvZWEzaXhrOFVHNWNVZkxEZnBXTHAzYWtZbWpKdk4yejh1bmcvWGk5?=
 =?utf-8?B?cVRiNmZzVHJmaHJrWm9oZm5hM0JnaG9PNm01WmpJUWZBdi9maW1hbFg5alNL?=
 =?utf-8?B?UHE4a1pEWE5HeDNiVGI5TXJSVnFuemhwUEpFcFJNMFNrbG5OV3E3U2piR3E2?=
 =?utf-8?B?YlFiVG5HVVhxZ2hIL1A3d2I0L0tVK1JRWUZtQnAxQmVxdUZCMVAwU1J1c0FL?=
 =?utf-8?B?dm5SN1c2QlpvMkMvMU5VaktWVmY3ZGpSTUY1UzE3UmZnTFc1cGJXUjFOeGRn?=
 =?utf-8?B?Q0dTTFBSSnFiRUk5WUp5NHo4QjVwVXA4ZmNwajhsTHJiNjFNeTVCRDBsYXRt?=
 =?utf-8?B?UzZ4MnM3TFF5SnJ4a25qWGFFckZ1MzhzR0FOZEp6TjJ5cTFqWW8vMHhuYnJ5?=
 =?utf-8?B?b2VabW45U0lFbGRGZ0FUQjNqYzVvNWxTTEdQRXlVWEVuUHJFV1NPNXJoNFhv?=
 =?utf-8?B?M3IxM3lWQWswSFpCcmtWRE1TWEdtY3d4aktrYXpoeTBhK2RaVmhZOHB5QU9m?=
 =?utf-8?B?MDBDVy90VHdBc1lJV1hTYm50WEJIelRJK0ptdEduMlBlM0hpRXhWa0ZobWth?=
 =?utf-8?B?dkRhYXQrRnJlcTl4QzJiazJ1MEg5NlhIWkY2L1ZuaW41bnpHQUE2dU9QT1VH?=
 =?utf-8?B?MENweEYrZkd2UUNza255SktZWk55eHZSZ2RYTTcyUldMQlB5Um91NUZnK2xW?=
 =?utf-8?B?SWNCSE9kNlRhSm91Vm40MEdMdWRPczB2ZFgvcFROZ3JyWTlqRnN0RnZiWVo1?=
 =?utf-8?B?UUl6a1cwL1dyeUF6bkZOUDdxakgzdlA3RzFBalZtc3RTazNFTlJNNUNMM1RR?=
 =?utf-8?B?YUJOK3VrY05lWmVpKzFGM0J4aTFqRFVqa2JsMmpHVEdYNFZjY3drZnVoeEpt?=
 =?utf-8?B?OHlzUHFZQ0xIU01RVWJ5a1VLU2thTkxmOUpUc3N4K2VBb1dOS0NHbnNBWWta?=
 =?utf-8?B?VlM5WFYzQnZBdFgway8yNWU3RDJ2SVhQSnRKY3dhcXdlOVAvL255WGZkeDRi?=
 =?utf-8?B?cy8vTGpPRzczbWRmT0RZM2FVSGxRS3dlcE8vMC9JRnk3Vkx1d21namFNbTlN?=
 =?utf-8?B?ZHJwTSt3UTM3M1NQdEYvZy9uVUdIaXZkRFV2S3FMbTRnbG5kL0kyWmZSV2RB?=
 =?utf-8?B?MEhONGhET0V4L2RVV2VpNEhSTStlRFhiVktuOWNIeEd4dlRWSm1XMDJSRUEy?=
 =?utf-8?B?MjFMeWJsWUpvRkVLV1d3NDBzQlRQcitSeUJ6clNLQzFKekMrdEt4MUNZZGJM?=
 =?utf-8?B?VkdaRC9KWFVrSUhTWkt3azE0ckVWZFVNOUxhWE5CWFFtMXV6bkFGVi9nY2ps?=
 =?utf-8?Q?MfT8kbXVV2/WmqQcxEYfgt1eX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e432e201-5cf1-4cd6-c311-08dbc71405f3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 09:01:41.7566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gp1hHnXiPg3qnmyDMyLd7rDss8RTcz1oezu6BnvOUpszQFNSkzepU2ri5NXNjoVwxrgTm9j3YJSQJwh1oDuccw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8285
X-Proofpoint-GUID: Ha8_9ZVCNt6He1blGe7Pw0Dl38QajXG3
X-Proofpoint-ORIG-GUID: Ha8_9ZVCNt6He1blGe7Pw0Dl38QajXG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_06,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

--------------BSwiZlPvKi8ftXjgecunxxI8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/4/2023 8:13 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
>> string containing migration connection related information
>> and stores them inside well defined 'MigrateAddress' struct.
>>
>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>> ---
>>   migration/exec.c      |  1 -
>>   migration/exec.h      |  4 ++++
>>   migration/migration.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/exec.c b/migration/exec.c
>> index 2bf882bbe1..32f5143dfd 100644
>> --- a/migration/exec.c
>> +++ b/migration/exec.c
>> @@ -27,7 +27,6 @@
>>   #include "qemu/cutils.h"
>>   
>>   #ifdef WIN32
>> -const char *exec_get_cmd_path(void);
>>   const char *exec_get_cmd_path(void)
>>   {
>>       g_autofree char *detected_path = g_new(char, MAX_PATH);
>> diff --git a/migration/exec.h b/migration/exec.h
>> index b210ffde7a..736cd71028 100644
>> --- a/migration/exec.h
>> +++ b/migration/exec.h
>> @@ -19,6 +19,10 @@
>>   
>>   #ifndef QEMU_MIGRATION_EXEC_H
>>   #define QEMU_MIGRATION_EXEC_H
>> +
>> +#ifdef WIN32
>> +const char *exec_get_cmd_path(void);
>> +#endif
>>   void exec_start_incoming_migration(const char *host_port, Error **errp);
>>   
>>   void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6d3cf5d5cd..dcbd509d56 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -65,6 +65,7 @@
>>   #include "sysemu/qtest.h"
>>   #include "options.h"
>>   #include "sysemu/dirtylimit.h"
>> +#include "qemu/sockets.h"
>>   
>>   static NotifierList migration_state_notifiers =
>>       NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
>> @@ -427,15 +428,64 @@ void migrate_add_address(SocketAddress *address)
>>                         QAPI_CLONE(SocketAddress, address));
>>   }
>>   
>> +static bool migrate_uri_parse(const char *uri,
>> +                              MigrationAddress **channel,
>> +                              Error **errp)
>> +{
>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> This cannot be g_autoptr because you're passing it out of scope at the
> end of the function.
>> +    SocketAddress *saddr = &addr->u.socket;
> This attribution is useless. Down below you overwrite it with the result
> of socket_parse.
Ack. Will assign saddr to NULL here.
>> +    InetSocketAddress *isock = &addr->u.rdma;
>> +    strList **tail = &addr->u.exec.args;
>> +
>> +    if (strstart(uri, "exec:", NULL)) {
>> +        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
>> +#ifdef WIN32
>> +        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
>> +        QAPI_LIST_APPEND(tail, g_strdup("/c"));
>> +#else
>> +        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
>> +        QAPI_LIST_APPEND(tail, g_strdup("-c"));
>> +#endif
>> +        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
>> +    } else if (strstart(uri, "rdma:", NULL)) {
>> +        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
>> +            qapi_free_InetSocketAddress(isock);
>> +            return false;
>> +        }
>> +        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
>> +    } else if (strstart(uri, "tcp:", NULL) ||
>> +                strstart(uri, "unix:", NULL) ||
>> +                strstart(uri, "vsock:", NULL) ||
>> +                strstart(uri, "fd:", NULL)) {
>> +        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
>> +        saddr = socket_parse(uri, errp);
>> +        if (!saddr) {
>> +            qapi_free_SocketAddress(saddr);
> Shouldn't free here. socket_parse() already does so on failure.
Okay, understood. So should just return false, nothing else here.
>> +            return false;
>> +        }
> Then here you can set the values you intended to set.
>
> addr->u.socket.type = saddr->type;
> addr->u.socket.u = saddr->u;
Ack. Will do that change.
>> +    } else {
>> +        error_setg(errp, "unknown migration protocol: %s", uri);
>> +        return false;
>> +    }
>> +
>> +    *channel = addr;
>> +    return true;
>> +}
>> +
>>   static void qemu_start_incoming_migration(const char *uri, Error **errp)
>>   {
>>       const char *p = NULL;
>> +    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
> The memory is leaked here because the pointer is overwritten below. Just
> set it to NULL. You can keep the g_autoptr.
Ack. You mean it is overwritten by migrate_parse_uri function.
>>   
>>       /* URI is not suitable for migration? */
>>       if (!migration_channels_and_uri_compatible(uri, errp)) {
>>           return;
>>       }
>>   
>> +    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>> +        return;
>> +    }
>> +
>>       qapi_event_send_migration(MIGRATION_STATUS_SETUP);
>>       if (strstart(uri, "tcp:", &p) ||
>>           strstart(uri, "unix:", NULL) ||
>> @@ -1671,12 +1721,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>       Error *local_err = NULL;
>>       MigrationState *s = migrate_get_current();
>>       const char *p = NULL;
>> +    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
> Same here.
Ack. Will change that.
>>   
>>       /* URI is not suitable for migration? */
>>       if (!migration_channels_and_uri_compatible(uri, errp)) {
>>           return;
>>       }
>>   
>> +    if (!migrate_uri_parse(uri, &channel, errp)) {
>> +        return;
>> +    }
>> +
>>       resume_requested = has_resume && resume;
>>       if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
>>                            resume_requested, errp)) {
Regards,
Het Gala
--------------BSwiZlPvKi8ftXjgecunxxI8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/4/2023 8:13 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87jzs2phxb.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
string containing migration connection related information
and stores them inside well defined 'MigrateAddress' struct.

Suggested-by: Aravind Retnakaran <a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Daniel P. Berrangé <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
---
 migration/exec.c      |  1 -
 migration/exec.h      |  4 ++++
 migration/migration.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/migration/exec.c b/migration/exec.c
index 2bf882bbe1..32f5143dfd 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -27,7 +27,6 @@
 #include &quot;qemu/cutils.h&quot;
 
 #ifdef WIN32
-const char *exec_get_cmd_path(void);
 const char *exec_get_cmd_path(void)
 {
     g_autofree char *detected_path = g_new(char, MAX_PATH);
diff --git a/migration/exec.h b/migration/exec.h
index b210ffde7a..736cd71028 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -19,6 +19,10 @@
 
 #ifndef QEMU_MIGRATION_EXEC_H
 #define QEMU_MIGRATION_EXEC_H
+
+#ifdef WIN32
+const char *exec_get_cmd_path(void);
+#endif
 void exec_start_incoming_migration(const char *host_port, Error **errp);
 
 void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
diff --git a/migration/migration.c b/migration/migration.c
index 6d3cf5d5cd..dcbd509d56 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -65,6 +65,7 @@
 #include &quot;sysemu/qtest.h&quot;
 #include &quot;options.h&quot;
 #include &quot;sysemu/dirtylimit.h&quot;
+#include &quot;qemu/sockets.h&quot;
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -427,15 +428,64 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
+static bool migrate_uri_parse(const char *uri,
+                              MigrationAddress **channel,
+                              Error **errp)
+{
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This cannot be g_autoptr because you're passing it out of scope at the
end of the function.
</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:87jzs2phxb.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    SocketAddress *saddr = &amp;addr-&gt;u.socket;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This attribution is useless. Down below you overwrite it with the result
of socket_parse.</pre>
    </blockquote>
    Ack. Will assign saddr to NULL here.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87jzs2phxb.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    InetSocketAddress *isock = &amp;addr-&gt;u.rdma;
+    strList **tail = &amp;addr-&gt;u.exec.args;
+
+    if (strstart(uri, &quot;exec:&quot;, NULL)) {
+        addr-&gt;transport = MIGRATION_ADDRESS_TYPE_EXEC;
+#ifdef WIN32
+        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
+        QAPI_LIST_APPEND(tail, g_strdup(&quot;/c&quot;));
+#else
+        QAPI_LIST_APPEND(tail, g_strdup(&quot;/bin/sh&quot;));
+        QAPI_LIST_APPEND(tail, g_strdup(&quot;-c&quot;));
+#endif
+        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen(&quot;exec:&quot;)));
+    } else if (strstart(uri, &quot;rdma:&quot;, NULL)) {
+        if (inet_parse(isock, uri + strlen(&quot;rdma:&quot;), errp)) {
+            qapi_free_InetSocketAddress(isock);
+            return false;
+        }
+        addr-&gt;transport = MIGRATION_ADDRESS_TYPE_RDMA;
+    } else if (strstart(uri, &quot;tcp:&quot;, NULL) ||
+                strstart(uri, &quot;unix:&quot;, NULL) ||
+                strstart(uri, &quot;vsock:&quot;, NULL) ||
+                strstart(uri, &quot;fd:&quot;, NULL)) {
+        addr-&gt;transport = MIGRATION_ADDRESS_TYPE_SOCKET;
+        saddr = socket_parse(uri, errp);
+        if (!saddr) {
+            qapi_free_SocketAddress(saddr);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Shouldn't free here. socket_parse() already does so on failure.</pre>
    </blockquote>
    Okay, understood. So should just return false, nothing else here.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87jzs2phxb.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+            return false;
+        }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Then here you can set the values you intended to set.

addr-&gt;u.socket.type = saddr-&gt;type;
addr-&gt;u.socket.u = saddr-&gt;u;</pre>
    </blockquote>
    Ack. Will do that change.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87jzs2phxb.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    } else {
+        error_setg(errp, &quot;unknown migration protocol: %s&quot;, uri);
+        return false;
+    }
+
+    *channel = addr;
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The memory is leaked here because the pointer is overwritten below. Just
set it to NULL. You can keep the g_autoptr.
</pre>
    </blockquote>
    Ack. You mean it is overwritten by migrate_parse_uri function.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87jzs2phxb.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (uri &amp;&amp; !migrate_uri_parse(uri, &amp;channel, errp)) {
+        return;
+    }
+
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (strstart(uri, &quot;tcp:&quot;, &amp;p) ||
         strstart(uri, &quot;unix:&quot;, NULL) ||
@@ -1671,12 +1721,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Same here.
</pre>
    </blockquote>
    Ack. Will change that.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87jzs2phxb.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (!migrate_uri_parse(uri, &amp;channel, errp)) {
+        return;
+    }
+
     resume_requested = has_resume &amp;&amp; resume;
     if (!migrate_prepare(s, has_blk &amp;&amp; blk, has_inc &amp;&amp; inc,
                          resume_requested, errp)) {</pre>
      </blockquote>
    </blockquote>
    Regards,<br>
    Het Gala<span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------BSwiZlPvKi8ftXjgecunxxI8--

