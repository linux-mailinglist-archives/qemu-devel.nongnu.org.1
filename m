Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A77030F1
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:05:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZl6-00068z-6H; Mon, 15 May 2023 11:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyZl3-00066s-Bp
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:05:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pyZl0-0004w4-PG
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:05:05 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FCwMhm007445; Mon, 15 May 2023 08:05:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=keNVK32RqeORFMVvsIRNlrR8WCMGZXXiSHEPy3aC1XI=;
 b=oDFqWGIv3+/n6cT0HgNj9eIYXYxgEXYAYd9ecmuDNDlf5CmBLnoFeGD9nhKmRSOI1Q8G
 XYUXGw0WQ10Cajx3VZa8YmWXqX5SqUHaNNFYfyrRCnnD49JusLFPsiFbvw9Ze6PLd9GB
 6dxjh9B+BUA0w6we8RPHciS93NhhqPzE3MhPXQGBWg7cP3NeGqrz08xanDUIfsl5Q7SD
 BYvYTuka14QkzbOsRvM4z1tR2dSlVNwJy/XtRHm5yxv5ACBvu9fj2RLZyTESLxjvec+0
 wr15bxo+JJ1qkwvqZekMQkHEE5yUWtfc+md6PHTLLttmPYOvIhzjW9WPBD4mxWHa/H2H Cw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qj6vsb98c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 May 2023 08:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVpkQxm9MQ/H9+HoWHfUaoAvbCurFhbKdIUPGvq30sHHv4Rhk7egIFYv7nzZcqsS75PnCa+j0C9KyCnbqxLC4lgPRoxfzhICtSUr1zTUzwN1gTOEclWdCn4K9YmAOdvf7jvO/ySK+QJuDze3zELhGJF0+elAVr8vQmp0oQWQqcIUixpcFOmZ4RQk4koVCjgZkHH2FZAQgRRJEGCh7Klapf9j+QboDCvP7/R3j6EwQHL50TQczOd3BRJLn+97DqT6IdUaejo7ehKsj37ty7EAnTH+sxlKCcbJEPvfL2Ci4HSFSfcwdlyA+7wTgZd35kF8cnhkgFhgRLijRY45wkuz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keNVK32RqeORFMVvsIRNlrR8WCMGZXXiSHEPy3aC1XI=;
 b=kNndfLUWi0biuJ2YTZBDXEJezkWbxzf8QIu4brobXtEvTCvMBJropVhOOdeIdtPeNArSUYqIF4I24WbfVt2km+dQOI2CeTlo5yh5MP8O17Ryw502pbJICEw/28tOW+F0kq3+qXb1zoXayv11+Ocl2hrnMOw5LPFgoK6/4ZbTKowlCX7zhZeA7hm5JuIGyMyioTDVs8DjiGhcU9TntgLc+JqzkeZlsSany3/VZnCqniiCBw51LFf0vITyjsI/8f3xuM/PwD/a6IQ+d+0mzUdnU38prFva5qcQhmdBY+GaGOJ2sWb/pU3XIj2OdM1XNBKLr4EDF1oN12meyO7N/02bUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keNVK32RqeORFMVvsIRNlrR8WCMGZXXiSHEPy3aC1XI=;
 b=nDwsRWEs6vG+4oKhGuU/Cdr8fuCCZx3iqks/TmRzhOU72g9LolL+LOLaavOshO+Ve4qcgZ9M4EgqksaOsb/NgZpY+sK0Ya7rJytTK7obiER0KAehap75cnx6lRf90QktZv3KA672vBBgviDcqr+uuJ8LkdjtU+edOLMQNXi/0OL4b2IacBgBUa6iJXlmab7kpqTtYVi/OZfhowT/O/jg55qzdPwsB4iLFlzBn8kV7zKMpE0udDjEo8xpEj53f7uBxqhCX0mbyJqZg6iXpgypxhHysIBkkZnNoHAxfT9rMk6CJRb4DR4P9yweQfLEr1F33PKhsn1rkRTmu70NkkKuVg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SJ0PR02MB7375.namprd02.prod.outlook.com (2603:10b6:a03:2a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 15:04:57 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:04:57 +0000
Message-ID: <2a3dce41-0e4d-849e-c8ab-3c6ea7965642@nutanix.com>
Date: Mon, 15 May 2023 20:34:45 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 5/8] migration: converts exec backend to accept
 MigrateAddress struct.
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-6-het.gala@nutanix.com> <ZGIJehrjvkchRbeX@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZGIJehrjvkchRbeX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SJ0PR02MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab0e9c0-01fb-4ed0-974f-08db5555bf04
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdJn6MNc6lrpAH4gDxeLe9rtyJGT2htSjcbhbNEyScgne+KlZ04UQKeuwsgh03FKkBAbmzm6sDO7vm8TyKRcYZIBl1r3eOGghDYs1IBAw/qpf1xUOjOVmx+keSzFMNKCLHkXE0WHL7YStCuPGkKGi3/GRtP8L0PhY0IcZeal4vOMghb+tU8PkeVqDrbwK60kUL8eDymhv5E+dgbuhatxJ03j6XqfHY38RTNKp9OGxDlXQ5sz4ZnLIHBM0gjkWEDRbBhncRyUDswa8VMosOZkaQ9ccTIhrrvsc3q+7DS7Brn8I3a9ToqmJcna43+Ub/6VruM8dyUpYtZYCvbcc9Z28q/fmzF0U/SHfDJW4Sd1gvLWdsTk8FarM8EEUoaccmDGqpaF9ATtg8wBWEagcURo6vlOgUBAttxpd8DxYb7jXMMSKUxTbsdJ4KsMWxCVZdkNbkJ17eHDptGq8APTV1JgvCm5eQIP+Ttoj7/GkzlOJ8PPRUsdXJX0cF2z1jIEZBGT7ixRPKz/NGcX/KusSTgXM/99cIc/wMbe8ri9kTVwAzHuLwEy640dW62nVt4v/raWp0WxJ/DyHjgboKU79E309dXrHBS3iqc3Dt+0VTdr4wZdh77pRYcMm6eejEvhYbOoAEAjsFynqyczkDZSUNgg6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(478600001)(8676002)(44832011)(8936002)(5660300002)(2906002)(86362001)(31696002)(36756003)(6916009)(4326008)(66476007)(66556008)(66946007)(316002)(26005)(41300700001)(38100700002)(186003)(2616005)(107886003)(53546011)(6506007)(83380400001)(6512007)(6486002)(31686004)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzJmN1hsSit6d2JCYWpFaW1reW1UOUFPbjBnVWk1UFpEbjh0RkMrUUpBMHg0?=
 =?utf-8?B?VmZVZEtKS1o1cmxIWVJqN0l3V2ZlTHBjU2l2dFJVUU8wM2lZenJLNDljUnNy?=
 =?utf-8?B?eGhiV2cwanlEdk5TN0pIR1p4TGtvNzg3QWl2aGxpenovcGE3SC9BY3NwYWZ0?=
 =?utf-8?B?K08vcVAybkthVmRPUzN5NVA1dTcwS3IxNWJ4S1VqQUJFSjdEbFdSTEdHMU9i?=
 =?utf-8?B?WnlsNG5URHlOeGFVT0pYL0srSzBGQ1BPOGhOaUdSQVlDaWQyY2lsTWpwU3Q0?=
 =?utf-8?B?S3YvRXBIN09TRU9INitWRFNOWE1QMUc3dDQ0REdSZ3M4ZDJaOUIxdndEV0tS?=
 =?utf-8?B?S09lVjhFNDVSak1wSytCeFhrMWNkZHhud2YvNzhxdkRUb0N0UXZuS1pzT1lx?=
 =?utf-8?B?R013MnlGRGxXWWJ6aUZaNXM0MS83SjdkREN5OWEyRmYzY3lFR0F2d0t2VW50?=
 =?utf-8?B?b3lUTmpPQmxoQzJxRm43ak5zakpiRHJ0T1pZOTBWSXQ3RktQT214aE1qaDVD?=
 =?utf-8?B?WlEyOXA1bE5SbzYrYVNESjdPK1NvVWtqaHhTTzlBZkQzLzdEeVdCb29TRmhO?=
 =?utf-8?B?Nis5QVZadnprTmh4RGFsbzlzb3N4ZnV5SXJ5UlpmWDZ2cWJSc2FaSGE5N3ZM?=
 =?utf-8?B?akpjZVZJQjlzY2l4ZU9xYVJKbW1PRGRWZGtVV29NS2cwODdIWXcrODBDV01m?=
 =?utf-8?B?LzMrNS9nNnlBR3ZQRUpiMG5xemtONWwrZTNKajNwbWlqemVENmN4MXZ0a3o4?=
 =?utf-8?B?dTJRYmVQdjNrRkEzMHh4WDVHZ1Q2dU1tTVJiT1dTSTNkVnFlZXp1QzRLM3Vv?=
 =?utf-8?B?T3lmb0dBWVE0QWplRTZ5Q1c3VDhqaGhsYTMzVmo0eWlrM2R6R3FYcmpDZEZl?=
 =?utf-8?B?cFNEQXYydmp2YytmQzJJTkRnR2ZyZzdqaWprZ3Q0aWM1SG5waGtvV0VoMnFY?=
 =?utf-8?B?S1hsNUdUOURGK01BL2JNb2NLZTFWQzI0d1EwWnNLcEI3Tld4alJ1V2hocmZE?=
 =?utf-8?B?RDdzSDdLTzY2c2lOdFgvUUxYQXhjUlkyS3M5Y3VPU1E0SGlZUFZaWWx5ZnZl?=
 =?utf-8?B?SGt1aGh3M2MvblFRL1lJNFFIbHF4S1ZMeUdFOWx1cm9vY0ljVmo4d0J2UU1S?=
 =?utf-8?B?YlJWM1pGNEE0VFhVQTRvT0lUVUVhZFpKOUhYNExQemJMcHpTc1NXdExzTTRR?=
 =?utf-8?B?NHZFNEdEVzMzKzUrY0o1MUg4cG8ydS9xbHVEUFIwNDJ1WHMyaXF0Z0NtSkxP?=
 =?utf-8?B?N2FYQzlETGFYMUN6NTAvZWk1bm1UNGdxMmFrbXdqa0R1bjAybkVlNXB0RDZU?=
 =?utf-8?B?SDRlYnlVbjBwOWIxM2lkZ2VjeGRjMXExWlNqVHg4SU40RmIyNHJyYStVTTdZ?=
 =?utf-8?B?MVFObXR4TlNmRTVWVGVZc3dVZUlMUllKcU9IZWpxU0lOaEpnVFNrN2k4VmZY?=
 =?utf-8?B?d21FWDM4UDN3TzYxWnBIenU1ekRNUFc3S0VGNkd4cHRmODZQcE52Vnc0VDV6?=
 =?utf-8?B?aHVYSmR6ZTVoQmFkUzgrVVpSbVZ4dVREZ2crb2hnbE1OS1NELzBOYkNncTIr?=
 =?utf-8?B?dFZyTDI2OXd2cVkwMEdwS2dON2NhaHg5ejlEVCsyS2NRU0tJYldndnB1Z1Js?=
 =?utf-8?B?Z2ZQbzJIcW5DR1ZmejIzeUg3Vk9TNUVkUkVrUjVNL05CWVRyTUd3QUpaTDZ4?=
 =?utf-8?B?Mi8xUGxzcTh4WHJ1SkszcFJsVVIzLzFySjdFRWEvTjBNTU5iTVdoM0RQYmRE?=
 =?utf-8?B?VkROMkMrNmROODNvdkhuZEduU2pFbmxzeks1VmtnRFJZcnRsTDdMZVJrdUZa?=
 =?utf-8?B?YzVud3pkVC92N2N5eUFMMVhFWjY0UXIzUUVmcXFmT2FsZDRUWG1STWNtcnd5?=
 =?utf-8?B?SlQ1QUYxdGFBSjRTMXFjZ29oSEk5RTRqNG9uamE4RFFnb3c1WVBiellBY3Y2?=
 =?utf-8?B?bmFpakdHekJLNTZ1N3BzMTdGNnFTVzRKcWM3NlZIbllGbmw0Ym9lcVBod05j?=
 =?utf-8?B?d3pOOS81eDdGWk9tcUdGOXNFd2RFemY3UkpBTkd4RS9YcWJQbDRCaHdVY2Zl?=
 =?utf-8?B?eS9za1VlRWxEb1hBeHVhTHlHU2dHdXlvNVJBRi90ejAzTGhtQlByYVRMWmRH?=
 =?utf-8?Q?PJBnuWmHlFvmBOyBouotE77Tc?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab0e9c0-01fb-4ed0-974f-08db5555bf04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:04:57.2101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr/oDTRwHcMtw8OMiz45PDPuZCiAsdKS7LorUlZglgzzY52ZAML1/hrKj+EPGdLQ8kuzfMQ8ZPuivF2y8azhUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7375
X-Proofpoint-GUID: xpneIKrAFN8VUAtMSaUFfiKy_IX-f3qY
X-Proofpoint-ORIG-GUID: xpneIKrAFN8VUAtMSaUFfiKy_IX-f3qY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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


On 15/05/23 3:59 pm, Daniel P. Berrangé wrote:
> On Fri, May 12, 2023 at 02:32:37PM +0000, Het Gala wrote:
>> Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
>> new wire protocol of MigrateAddress struct.
>>
>> It is achived by parsing 'uri' string and storing migration parameters
>> required for exec connection into strList struct.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   migration/exec.c      | 58 ++++++++++++++++++++++++++++++++-----------
>>   migration/exec.h      |  4 +--
>>   migration/migration.c | 10 +++-----
>>   3 files changed, 50 insertions(+), 22 deletions(-)
>>
>> diff --git a/migration/exec.c b/migration/exec.c
>> index c4a3293246..210f4e9400 100644
>> --- a/migration/exec.c
>> +++ b/migration/exec.c
>> @@ -39,22 +39,51 @@ const char *exec_get_cmd_path(void)
>>   }
>>   #endif
>>   
>> -void exec_start_outgoing_migration(MigrationState *s, const char *command,
>> +/* provides the length of strList */
>> +static int
>> +str_list_length(strList *list)
>> +{
>> +    int len = 0;
>> +    strList *elem;
>> +
>> +    for (elem = list; elem != NULL; elem = elem->next) {
>> +        len++;
>> +    }
>> +
>> +    return len;
>> +}
>> +

Juan for your comment : "I can't believe tat we have a list type and we 
don't have a length() function for that type."

I had seen come patches regarding adding utility for finding length of a 
strList in util.h file as a MACRO, but I think the patches have still 
not gone in.

>> +static void
>> +init_exec_array(strList *command, const char **argv, Error **errp)
>> +{
>> +    int i = 0;
>> +    strList *lst;
>> +
>> +    for (lst = command; lst; lst = lst->next) {
>> +        argv[i++] = lst->value;
>> +    }
>> +
>> +    argv[i] = NULL;
>> +    return;
>> +}
>> +
>> +void exec_start_outgoing_migration(MigrationState *s, strList *command,
>>                                      Error **errp)
>>   {
>>       QIOChannel *ioc;
>>   
>> -#ifdef WIN32
>> -    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
>> -#else
>> -    const char *argv[] = { "/bin/sh", "-c", command, NULL };
>> -#endif
>> +    int length = str_list_length(command);
>> +    const char **argv = g_malloc0(length * sizeof(const char *));
> g_malloc0 is almost never desirable to use, instead:
>
>          g_new0(const char *, length);
Ack. Will change that.
>>   
>> -    trace_migration_exec_outgoing(command);
>> +    init_exec_array(command, argv, errp);
>> +    char *new_command = g_strjoinv(" ", (char **)argv);
> Never freed - use
>
>     g_autofree char *new_command...
Ack.
>> +    trace_migration_exec_outgoing(new_command);
>>
>>       ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
>>                                                       O_RDWR,
>>                                                       errp));
>>       if (!ioc) {
>> +        g_free(argv);
>>           return;
>>       }
> argv needs freeing in success too. Simpler to declare it
> with
>
>      g_auto(GStrv) argv = .....
Yes, Ack.
>>   
>> @@ -72,21 +101,22 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
>>       return G_SOURCE_REMOVE;
>>   }
>>   
>> -void exec_start_incoming_migration(const char *command, Error **errp)
>> +void exec_start_incoming_migration(strList *command, Error **errp)
>>   {
>>       QIOChannel *ioc;
>>   
>> -#ifdef WIN32
>> -    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
>> -#else
>> -    const char *argv[] = { "/bin/sh", "-c", command, NULL };
>> -#endif
>> +    int length = str_list_length(command);
>> +    const char **argv = g_malloc0(length * sizeof(const char *));
>> +
>> +    init_exec_array(command, argv, errp);
>> +    char *new_command = g_strjoinv(" ", (char **)argv);
>>   
>> -    trace_migration_exec_incoming(command);
>> +    trace_migration_exec_incoming(new_command);
>>       ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
>>                                                       O_RDWR,
>>                                                       errp));
>>       if (!ioc) {
>> +        g_free(argv);
>>           return;
>>       }
> All the same comments as the outgoing case.
Ack. Thanks Daniel for the inputs.
> With regards,
> Daniel
Regards,
Het Gala

