Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2E7158F9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:46:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3uz2-00041V-RC; Tue, 30 May 2023 04:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3uyt-000419-Ni
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:45:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3uyn-0005l6-E1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 04:45:27 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34U2s2jP030651; Tue, 30 May 2023 01:45:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=NhB7Q+nZ+Eb8PLdfV2YxXbgzE6OJ/X/oB797ccoZPXY=;
 b=M8jtlUr/NuMuUFLD2uSUvqsfp2htshjyASKv1V0e8/HwYwypbE5MtAoMERog9G6hILGb
 Lp2qUE2QnBpI/pzAdj7A41RfzcZXDqdEpKhElcQq17Ma0wGIzPOl+5dC75041BxRYfPc
 3PGTa2PKriVUebdgHJ17mQitXNktcRKs/Xy9a6x+321E1k1tgftF2KarYnF+LSUQyuE0
 3AxgiDZRQnDOdFS6FCK1vTzeiGG/sbwdI+eo7rUFXKcFhgKgW8QNoyL54odWpNmv3uIS
 vnytxqWs90QF3oMLxCWsvgNY3RPFi7v6h4lZQo/JyEvSLE8pafX26S6iA9kQeUSnj0FM dA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3quds5n0uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 01:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzMnhP/KrlFIaFQlA1hvNP5oVu9qOWcKKsmUn2L1t+fb0XYrIOeg35SH4KbWyycFVbnoarbxcROaG3L1Os/nBFRap3UhuWxmMd5BXr09G0xQ8daNugQXw+ACwak6pZoVC7OMPfFZXmF3sALVMhTuICP9YWleqvzLVAfehlbAu7pK1BBtJh29iHYwUA5wKx7SACLK098HVl/+zkTx3cu3PZoPsErUy87fZl3JVBuxKMlo4Q+EWJuDlkK/7lII/PTn9uTZ6nAzsftsrGjEDxjauriz6Jp087qelq1XL5y7hFL81RC/dRnVHf26hKxTTtSkQYN+thJAVjVLnoa9nsQ1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhB7Q+nZ+Eb8PLdfV2YxXbgzE6OJ/X/oB797ccoZPXY=;
 b=UsZhS7g9GhOcGVE8f3aIW7tL3xrHEaP5or46IwGnieRvizvsjbyOmp/HS3Wn9xhJTeWG13s6lx/v1KDBISDlXDqT5RR7H99Zf8DQ2/SLJkk93p0So5UODkIHp56O38FbvTQ+Y3OMx7PxlKgvSMJYGJ+XXIf87OCqbjIDsqEXzfpWquNEg31t7xIBmFjg8qR4HXEKaCCa6M6KtkFU+5FFVxvM5TGJ8GJY8jZFcmjKdy+ZssZxsB+Crnt3hMuFI98JtpFwAE2Z8i98+Dp4SQEUEttwCjrrFC2uMdZZjeek+pGB9YwujhC5rgqebALfCmzK5b7aB6go/RfraqA9SU1Q/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhB7Q+nZ+Eb8PLdfV2YxXbgzE6OJ/X/oB797ccoZPXY=;
 b=hxZiC2Cng9hpgQcxNicfM8oK9udAqW/TjFFhHWd2qMHToPWR5aiTi/yoGArlF/ioKa/Q36hQh0hCG6f0xxGINK8SGIywbC5uUEPdCkNDRLYj+33t/sY4VYos+4gA1kCALlmV2w6Ovg06anG8+ZaDkQc8QhNEE4QEg609NFBf8jhomWKFhYstfkTRhbsmAxk172C2I0+JgxkIZ3gLerUtVI7Pw70+F4Fv5B9xIS30Hh3aMLrCtDbw7/C6YlmMLGf63JblsrQrvEL7WK7cd0VV2ZBKxeku09Fr/UkgO5HU9tzCuBMbOMxq7cQqUTEO5B2x5gRk1q53op/SVzYZaZmGuA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CH2PR02MB6838.namprd02.prod.outlook.com (2603:10b6:610:79::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 08:45:13 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 08:45:12 +0000
Message-ID: <31b8fffe-ea87-9d5c-a601-0f873d1c31c1@nutanix.com>
Date: Tue, 30 May 2023 14:15:00 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-7-het.gala@nutanix.com> <875y8gjo5h.fsf@pond.sub.org>
 <2837b5c4-2f70-c6b2-8309-13c40540ec1d@nutanix.com>
 <875y8auwae.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <875y8auwae.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CH2PR02MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2a79d5-672f-4574-0e7e-08db60ea2e01
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAEm9PBmm7M24qaCsroPt7Yj8HPyzXpLiUi80CDVmlRdWL5N4Hb/MYAML/g6TWomFYLyVk8RJspbGN2oq9A1R2qWkZTH+WYPNOphIqLSde8f4QLYFF6zDCoj1Dpuitf/4Lnr4crv2+yn8V0X306KtY+VSmz0m//7mRGbJ08nzizABkUXz40jNTxu3+s737VdGnEFwD7MRGkSTIepF/0eWhv2EiysppQ8CacT9fDYxPaV6J5rCdOm0xP5HMDmU6Dm0EqGqV2SSGg7ucSgYlGapQk3aMjp1lEzRijJyNPCHlUmhxqnJQ+X+KrV5CD5pddEdNZ9suZPEDeEiqyW6yYEAWNN2Cws5sgeszaCeRq+JoLbnu/t6dvIT9pT7l5KKlaoT2KU6rRbZaxr/JorPXq5x7JfmzK+jOQQP2wEqaN7MaEb1tGR0e3mftYlpY9uwvkFd3oqulmBajwT9nQaPap5V429OTXW+1A2HELkrfzqkDGWUzfvFV0TOdfAVnRxfPsFKxi+v9DmBL3SbjPOZfW+q/tC7N0kwbb9f5MlGLTkYRFyBO+HRs/wqEdK731M7YXaR76MuvgRMxRyL8lwrI9yX0drQMI9m/py79t3PW+YM5e1J0w5DWlne99fcadJ3lREWG4OyiBX/HEmcdcqCCxUug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(31696002)(6486002)(86362001)(41300700001)(4326008)(6916009)(6666004)(316002)(66946007)(66476007)(66556008)(36756003)(44832011)(107886003)(5660300002)(186003)(2906002)(53546011)(31686004)(6512007)(6506007)(26005)(2616005)(83380400001)(38100700002)(478600001)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elQxZmpweC8xUFdUVGF1K3JwMUFLQVpMOEJ1ZDUzeGV6dEZxVWlmd0pVVlRr?=
 =?utf-8?B?Tm5XOU1WQnEyWWlvSU9lb3dKQTVabFZLWGpBbTZ5aHNWK3V2VVE0eFYwVW9v?=
 =?utf-8?B?cTJaSXJ3WG9DalhHQVlQUUgya0loS3JOdUxaRTQwZ0tUTGMzWW9kaHBGc0lr?=
 =?utf-8?B?N2w0d1pkbmt3V29EVnNMK0ZqZzI5d2dJaWdUTjhYaXdBc2RVVC9Lc3VYa0Ji?=
 =?utf-8?B?eVpaVksxcmxKd1FtKzJkVityS0FMakt5SmwwUk93QjhZbGJkcHlvZnVEMUpS?=
 =?utf-8?B?YmF0bW1VdFpRQW54WEk3VmpOU0lWdHFGRytrVUM0YnlqMElvbzJ2SUtjOUVo?=
 =?utf-8?B?Y1dPZ0FjNFNyVHZzUzFLTlRKOTRIMGZOYmFXZExqMDJVczJ5djNlUDhRSStu?=
 =?utf-8?B?REdNUGFIeHQ0RXRiNVNKSVg1K2ViZFpiVlNrNWlxUmVnNXJoSU9PV0hHeDk5?=
 =?utf-8?B?RU9OSy9xdXJzenkyaGgyYXRRNS9LL2NRbTJCUjhKc1hkVEF2QXB3QlRQNmlx?=
 =?utf-8?B?QVBXbVE2RXFzMW85bldtSkttTUYyZHVwaG8vTGI3MkhLalZ3S2lQWXNENzU2?=
 =?utf-8?B?UDhoci83N080b0FZUmNWQk9TV0VTSnBXTUNYaFhtVTU5ZnBoRnJNMWhhVVBG?=
 =?utf-8?B?T3c3UUFPQzZaaFByY1ZlbkdqcVd0VEJLV21QTTd6bTBkckVnSFEwTFcwMU43?=
 =?utf-8?B?VzBMazgrWDZ4Zk8vdjhPSjlsaUU1RFFoeDVrZkdjYmVpY3QxVG5zVklmYVdX?=
 =?utf-8?B?UUI3WmJzVjhIQmFxY3o5YUM0VlZ1QUxCSk1ZazVwcmt0YWlacUFWRkw5Ui8z?=
 =?utf-8?B?Szh4WjczT2FoOXh1OThIMXBUT0xDdnhLZGplejBmS1R0aHpFMnFoakdUU3lz?=
 =?utf-8?B?bzNWZU1rVUVrZ3RHaVZEelkxQ0VVc1FoVjJBajk3K2RyekVxNEUxdlBxb3hx?=
 =?utf-8?B?YktGRU9oYStjWnF1bTUyZG96Y3dpN3U1WUNaZm1sck5wclNPV2xlUmlsalQ1?=
 =?utf-8?B?aXAzWUNRS0FXbC9SbVRzeVRpcUpWOEYraVJKVGtCWXJBVGpSLzFBVDl2cVo2?=
 =?utf-8?B?NWIvQ0RWZ2tGVlRNSkljSzlkS2VIayszMmlKZjFKWnU3Z2sxQVpHSDJvZE1B?=
 =?utf-8?B?YVR4dE00UzBoekZkVCt5RHhRVVZRS0luMForUmMrT21JdXNmNUEyOUg5NUE5?=
 =?utf-8?B?ZVhuZDB0RHgxR0dLTlJFVUlyRG5EdkpaMm5rSUZnMU1XQmZLOHRoYW5FOThK?=
 =?utf-8?B?MElhVlJtVHNncHRYM2NvU04xallpUkZOdURDS0dzaittTTYveE5IWlpuanY0?=
 =?utf-8?B?QWcrb0xMWFBtaytER1BIczE2cDV0dFYva2JPNm12enJGdThMcVE1WjViYmdw?=
 =?utf-8?B?WkRnblBVazc0UlVaOEQ2U29KQkNWWG4zZWc1eU5uZFIrOHBxNktPamp1ajl2?=
 =?utf-8?B?Q1JxVTl3WE5xMm54T09ob2w2V1NaWG14WUoyVjdsTTI4d0Q0ODJhSjdwdTFl?=
 =?utf-8?B?aUR3NlJicXhteUFRYWdJWE1kUkF4MU51a3dFa2hsSEw4Vk5rUnVFSFNNSDB1?=
 =?utf-8?B?QkNsT1E2Z2J5dXJ3c3E0cDRGdS9pUndzVDg1OFdsa1FMSnZZYXBHcXNqVjVt?=
 =?utf-8?B?VGswRnBBaFN0M1F6bU5ham44ekpQREJrMlJIdndPZHFZblhlL2c3OHpNTkZ1?=
 =?utf-8?B?L1RGa3E1bE1TQzBicEcvd1NpRFZtUjdzbGx0RThMWkpGQ2xVM2YxQlp5NDNI?=
 =?utf-8?B?RWhZQUVHRDBIODZuUEFrZXNramQ0MjFUZWord2tmUWlvMUJ6d1JKdEIzQzZO?=
 =?utf-8?B?c0ViQktxWGwwdHhlcmZ6S0Jyd0FHTzF6MHE3UmEwTHZMMXEwOHQ2cFdPWTRU?=
 =?utf-8?B?M1Bwa0JiZUZVUHNCOHIxYzhzbHNIOHVBR3hBelJvV2pYclZaTEgrZHkwbzJM?=
 =?utf-8?B?KzhTdkw0LzhsUGxLckdkWXlvRGxLdlY3d1poNzFrM1ZIK0hFamlZUzdIVmlG?=
 =?utf-8?B?dHlRUzV2ZEoydEEyZFhOSHR6eUNhK3Zpc3Vhb3N5Z2JuTE1YOWlGdElQQ0pw?=
 =?utf-8?B?bXUwOXVGQ0ErZzBWWlpuQ0RSRXRWb3Y3ZWM5YXdwUjNxdThSUHZIdDFNaGwy?=
 =?utf-8?Q?7Mcy2/6vTd5VFa+tTOx0xY+9b?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2a79d5-672f-4574-0e7e-08db60ea2e01
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 08:45:11.8168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRyo+48M454mAauhh3O0B3wsQ11DlZhQdPphzBju0i0ib9qzAV4WrKTCn6ZZhLBAna2CWnGkaRJMgX0f7StGnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6838
X-Proofpoint-GUID: -HsY_nk55Y8rQw3NiRtn2J86Glc1_CWz
X-Proofpoint-ORIG-GUID: -HsY_nk55Y8rQw3NiRtn2J86Glc1_CWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 30/05/23 12:43 pm, Markus Armbruster wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> On 25/05/23 11:20 pm, Markus Armbruster wrote:
>>> Het Gala <het.gala@nutanix.com> writes:
>>>
>>>> MigrateChannelList allows to connect accross multiple interfaces. Added
>>>> MigrateChannelList struct as argument to migration QAPIs.
>>>>
>>>> Future patchset series plans to include multiple MigrateChannels
>>>> for multiple interfaces to be connected. That is the reason, 'MigrateChannelList'
>>>> is the preferred choice of argument over 'MigrateChannel' and making
>>>> migration QAPIs future proof.
>>>>
>>>> For current patchset series, have limited the size of the list to single
>>>> element (single interface) as runtime check.
>>>>
>>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>>> ---
>>> [...]
>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index c500744bb7..86bbc916d1 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -1448,12 +1448,47 @@
>>>>        'exec': 'MigrateExecCommand',
>>>>        'rdma': 'InetSocketAddress' } }
>>>>    +##
>>>> +# @MigrateChannelType:
>>> As mentioned in my review of PATCH 1, I prefer nouns to verbs for types,
>>> i.e.  Migration, not Migrate.  More of the same below, not flagging it
>>> again.
>>>
>> Ack.
>>
>> Also, I forgot ot mention in the 1st patch - even for union and struct namings - nouns are preffered over verbs ? or its just for enum types ?
>> We use structs like - MigrateExecCommand, MigrateChannel --> MigrationExecCommand, MigrationChannel ?
>> and union like - MigrateAddress --> MigrationAddress ?
> The "types are things, and names of things are nouns" argument applies
> to all types.
>
> Yes, existing names use verbs in places.  Mildly annoying.
>
> Renaming them would not create compatibility problems, as types are not
> part of the external interface.  Up to migration maintainers.
Yes, I got your point. Will change naming convention for all 'types' as 
nouns other than 'command' which will be a verb. Will kep this in mind 
in future too. Thanks!
>>>> +#
>>>> +# The supported options for migration channel type requests
>>>> +#
>>>> +# @main: Support request for main outbound migration control channel
>>>> +#
>>>> +# Since 8.1
>>>> +##
>>>> +{ 'enum': 'MigrateChannelType',
>>>> +  'data': [ 'main' ] }
>>>> +
>>>> +##
>>>> +# @MigrateChannel:
>>>> +#
>>>> +# Information regarding migration Channel-type for transferring packets,
>>>> +# source and corresponding destination interface for socket connection
>>>> +# and number of multifd channels over the interface.
>>>> +#
>>>> +# @channeltype: Name of Channel type for transfering packet information
>>> @channel-type, because "channeltype" is not a word.
>> Ack.
>>
>>>> +#
>>>> +# @addr: Information regarding migration parameters of destination interface
>>>> +#
>>>> +# Since 8.1
>>>> +##
>>>> +{ 'struct': 'MigrateChannel',
>>>> +  'data': {
>>>> +       'channeltype': 'MigrateChannelType',
>>>> +       'addr': 'MigrateAddress' } }
>>>> +
>>>>    ##
>>>>    # @migrate:
>>>>    #
>>>>    # Migrates the current running guest to another Virtual Machine.
>>>>    #
>>>>    # @uri: the Uniform Resource Identifier of the destination VM
>>>> +#       for migration thread
>>>> +#
>>>> +# @channels: Struct containing list of migration channel types, with all
>>>> +#            the information regarding destination interfaces required for
>>>> +#            initiating a migration stream.
>>> Please format like
>>>
>>>      # @uri: the Uniform Resource Identifier of the destination VM for
>>>      #     migration thread
>>>      #
>>>      # @channels: Struct containing list of migration channel types, with
>>>      #     all the information regarding destination interfaces required
>>>      #     for initiating a migration stream.
>>>
>>> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
>>> to conform to current conventions).
>> Ack. Will change that in the previous patch and will take care in future patches too. Thanks for informing regarding qapi documentation changes!
> Gladly!  It's the only way to make the nicer formatting stick :)
Yes 😅
>
>>>>    #
>>>>    # @blk: do block migration (full disk copy)
>>>>    #
>>>> @@ -1479,14 +1514,44 @@
>>>>    # 3. The user Monitor's "detach" argument is invalid in QMP and should
>>>>    #    not be used
>>>>    #
>>>> +# 4. The uri argument should have the Uniform Resource Identifier of default
>>>> +#    destination VM. This connection will be bound to default network
>>>> +#
>>>> +# 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly one
>>>> +#    of the two should be present.
>>>> +#
>>> Long lines.  Better:
>>>
>>>      # 4. The uri argument should have the Uniform Resource Identifier of
>>>      #    default destination VM.  This connection will be bound to default
>>>      #    network
>>>      #
>>>      # 5. The 'uri' and 'channel' arguments are mutually exclusive; exactly
>>>      #    one of the two should be present.
>> Ack.
>>>>    # Example:
>>>>    #
>>>>    # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
>>>>    # <- { "return": {} }
>>>> +# -> { "execute": "migrate",
>>>> +#      "arguments": {
>>>> +#          "channels": [ { "channeltype": "main",
>>>> +#                          "addr": { "transport": "socket", "type": "inet",
>>>> +#                                    "host": "10.12.34.9",
>>>> +#                                    "port": "1050" } } ] } }
>>>> +# <- { "return": {} }
>>>> +#
>>>> +# -> { "execute": "migrate",
>>>> +#      "arguments": {
>>>> +#          "channels": [ { "channeltype": "main",
>>>> +#                          "addr": { "transport": "exec",
>>>> +#                                    "args": [ "/bin/nc", "-p", "6000",
>>>> +#                                              "/some/sock" ] } } ] } }
>>>> +# <- { "return": {} }
>>>> +#
>>>> +# -> { "execute": "migrate",
>>>> +#      "arguments": {
>>>> +#          "channels": [ { "channeltype": "main",
>>>> +#                          "addr": { "transport": "rdma",
>>>> +#                                    "host": "10.12.34.9",
>>>> +#                                    "port": "1050" } } ] } }
>>>> +# <- { "return": {} }
>>>> +#
>>>>    ##
>>>>    { 'command': 'migrate',
>>>> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
>>>> -           '*detach': 'bool', '*resume': 'bool' } }
>>>> +  'data': {'*uri': 'str', '*channels': [ 'MigrateChannel' ], '*blk': 'bool',
>>>> +           '*inc': 'bool', '*detach': 'bool', '*resume': 'bool' } }
>>>>      ##
>>>>    # @migrate-incoming:
>>>> @@ -1497,6 +1562,10 @@
>>>>    # @uri: The Uniform Resource Identifier identifying the source or
>>>>    #     address to listen on
>>>>    #
>>>> +# @channels: Struct containing list of migration channel types, with all
>>>> +#            the information regarding destination interfaces required for
>>>> +#            initiating a migration stream.
>>>> +#
>>> The list doesn't contain migration channel types, it contains migration
>>> channels.
>> Yes, my bad. Will update it.
> Writing good documentation is hard!
>
>>> I'm not sure what you're trying to say by "with all the information ..."
>>>
>>> What does it mean to have multiple channels?
>> In future patchset series, we will be introducing channels over different interfaces (src-dest pair), with each channel having multiple multifd channels. For now we will restrict the size of the list to 1.
> Please document this restriction right here.
Ack. But it is mainly an implementation point that's the reason I did 
not mention it here but have mentioned it in the migration code flow 
path. Will add one more point to note down.
> When you add support for multiple channels, will each channel have a
> unique channel type?

Not every channel will have a unique channel type but mixture like, for 
multifd in future : (main, data, data, data) --> the first connection 
will be migration main connection, other three will be multifd connections.

> [...]
Regards,
Het Gala

