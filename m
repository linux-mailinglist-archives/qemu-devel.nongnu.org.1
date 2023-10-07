Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E457BC73A
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 13:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp5bB-0004n2-S5; Sat, 07 Oct 2023 07:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qp5b9-0004mf-V7
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 07:35:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qp5b7-0006Sh-BE
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 07:35:55 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 397B3AHP023086; Sat, 7 Oct 2023 04:35:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=VhLLfXtTcQwQ
 iGKCl4NOgBaMV4ljWF3O3aetr7OU8fI=; b=RXKz2FrqEQPsEZYWX+0H+Ik/Z9+p
 LJQttmSsNvWbV1wT23OMH0fWf7NsmeOvC4Vrwn+k3ArrGoxRSbrE5k9tA2RJmWcw
 YgKCWgjNoSwNoaQ2lePofeaEhSS7+czB6OlCx3ek2DHoE/yxM1rsTbsCmQ5yt5Lz
 i+3OnA8g8v6hfdF+i/Z8OEVcbSHYFWOK78UanFBCgwEbVrwQnMhlvJp8JgzdAqlK
 bKE3MMdB7cJIeDSNS5UJMSIs+xUiet7uPkR/kkv5diUuDnyjUM7kQt+Fcw81UNyC
 Hs4WvwQNeAFi0Y2GHvQh6/oI5+sHckOcLW05x8EyaR0ZIbUH14xwz4GIag==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tek0cypre-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Oct 2023 04:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhcbeiO1+yNtJULnCaQroZ62PFubO7+xKZ7gd/6iuE6bMimJp4RWBRX2MwpVvrVg58hF4cyA2G+z2tT+i8HTV9VDY6FWISIvHrCE+jZh1h4kBAXTXjfr8E0iH1TLVXS69b4fACZ6rzKOmC8PBzk4KM4M0Q5tisiMOwWsoeoboBePv8zSvtQS//1RN+qy1mpvx/4kuPQs6Qwl6c1hqC3HWRJk8CAUsatOsipjLzKt1IVz4CTDc5B1QX8rtLxfN08ORtVQyW26IWzY2/xrpdTa30wz+/mJUhzCWFQI9d7QlsvIPykoRoTN+CfIgbPr05mmG8iKagOFRQM8nP90R+8myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhLLfXtTcQwQiGKCl4NOgBaMV4ljWF3O3aetr7OU8fI=;
 b=FN0x+BqNRP7b8YueAMIjLojDfwAZbFZ3EmeIDVpGc2yAqQLx4HidaLwdldFQSZlAxh7WYADl3VvGcLCUaB5osNlCYrBPkqHxgocOPALeFmG9mbqzdVoSBho0yCj+5NSpgBi7/T4mVmancWzTWekhsAl+Mzq+R7r95Zhh/xKKc+NXHAM28kwqkosvTkoSa7CZwGVnhqOx98Ny0CMGn0QKOlyJ7bMS53FD5chh1yTT3r9krKy1OYgGML5D/eSJSOiDDUk8bZ/l4CjtpsrM+8AiBhYtZGTKvnTa/qbYf0+/tZ2lSSr/xpBHIXtOhta/mqzkeg637CIogG9VYs6oHF0VvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhLLfXtTcQwQiGKCl4NOgBaMV4ljWF3O3aetr7OU8fI=;
 b=up8pchKIgSBDgiO7QBBNEWbUNxz9MlL43+L2bFQ1Hzcc+9j05y+HVwreNARYEO3+aqW9s1A7haAMaTUmVwYwKpuJd0tT/a2tN06wwh76kGZk/PUVJoewqG+Pq5WTUTBsfF9Se5AyhkCgOz23Ml3XMNBu/2FKFG0mJ+XwchzUa25ITI99dKWLQYxZTXVDpVA+uGiov9Beiaqkc4y5vAtM3iayPAR6elOahO7BucKQcyxZxuKz1IwaoAMyIJ/cxMVepreBn6akYYY3v1aN3QiN3JZgXoMgkbSRO8QA6JDhP3vCvGyBaItxT0ftEgQZsVMZeE7TbY7fD7ZdC2XDEDhMrg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM3PR02MB10276.namprd02.prod.outlook.com (2603:10b6:0:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Sat, 7 Oct
 2023 11:35:46 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.039; Sat, 7 Oct 2023
 11:35:46 +0000
Content-Type: multipart/alternative;
 boundary="------------wfmKdDjQ0f44OPibJs5pcWGA"
Message-ID: <b9a9b3ff-80ff-4b23-bbd8-996afe40e7d7@nutanix.com>
Date: Sat, 7 Oct 2023 17:05:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-3-het.gala@nutanix.com> <87jzs2phxb.fsf@suse.de>
 <ZR2nuqQ7s1D5BweM@redhat.com> <87h6n65kac.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87h6n65kac.fsf@suse.de>
X-ClientProxiedBy: BYAPR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::28) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM3PR02MB10276:EE_
X-MS-Office365-Filtering-Correlation-Id: a54dae0f-25ff-44fa-ac43-08dbc7298b5d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUZd50LU5EOX1hNGuplrIw8o+quz4ePAGgUgOLQl8k9dl6t0jwFwibQu15EI2ewD4nN/ELhr+MgAv67pHo6tOjCEI0y6VCeAO+piMLiHgkI19CVxo+/1HzbJsoMmvFkK8669n8OcHTddodC0X0Q7YAeNhwwFPVH5CGKpzqmshcKOFML6YBzn9WWCvUrp86tHT8np5189luLmaRevWfAtt3rNn48Bq5q9jNy61DPuhkiLfPTAz5dXqUiBfynEHrad4IfxpW8Xv9hp8Oh2Ek337OScpECwb0mKd3WXpbgWWEK9HkUxEbyZbqxoKWLMAK1MoN83xr4jdozp1jWMs+AmKixR7/zH3A25eIaDzXEqr4ao9W+ONitYumIjfMM7WZN8VRM+BZdYVN9WXmUx10sg3IAGG7uNPp0opmfgbpr0+BmvPjpHp17J44hyi/DwEXNvbi/jWZge2vPU9O55BZKZMxHa1AyIygkwzHDTaOiS9BP+fX8ZmjAuAS90FtPHn5WhSDtawby/MsWg6dlAec/qkBCnCs2P6W+GET06bRAkSWk4lsLY4tXTAjGCkv3odCXuSWOZi3b0yMXY6QY0aipjQUO6L52XUrGVG6d+4zeIqSoYkPsFn01KA3+rUP2EqMEgIH3h0osFS5RooIQWVpgpwnNASYtABUy4IBHvjxpT8T/bS/sX6bgJccvoE8Ha97mG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(376002)(39850400004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66556008)(66476007)(316002)(2616005)(66899024)(66946007)(41300700001)(53546011)(6512007)(6506007)(26005)(36756003)(6666004)(107886003)(6486002)(83380400001)(38100700002)(86362001)(966005)(31696002)(166002)(478600001)(110136005)(33964004)(44832011)(21615005)(2906002)(31686004)(4326008)(8676002)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlNvNGUyV2xxQXByd0gzd1NVVzFMMUZsSUdKMzRnR3c1ekhYR3R3RkoyYVdI?=
 =?utf-8?B?eWF3Nm9hM1UwZWxMeS9XV2ZpN25PMklxQlU5Unh2aHJvUitQMDJQdGRkd2do?=
 =?utf-8?B?ZGFiejhreXZJVjkzVVkzYTNDUTBvSThMYmdyWWVNaFJQalpMZ3BMc25TSmNQ?=
 =?utf-8?B?NXhDT1FLSFBZRWhpdTZ1T3dIeU5TOTVGZlNrMTl1U2N2cFl3T1Vacm9LZzNv?=
 =?utf-8?B?b1lFam12SUg5aTZwdjFoT2FPSmpnQnhEQzVUSmFoa3BEclZmTVptY3BiRWZM?=
 =?utf-8?B?SzZBbkphSU1ZTHFkOXNiamlZaHJDTzVTWDRIc3htK2JZMlpOZ2NwdGIyRGhS?=
 =?utf-8?B?NHM0QlljRGk0c1F5VHdldGxXeHd0M25zT3U2dGZCOUpzdWdRYzd3b3hJQmRS?=
 =?utf-8?B?TXd3VVkyUUlISlpHbWZLa090U0tYVTlQcFMzdTI4TXYybUtSVnVTZ1ZBeHhm?=
 =?utf-8?B?UnlteTJFUE91UFRGQ29pQ0RlL2pyM0FNbjZPTEE3ZHgwbG5iZkhUSjBCWGM3?=
 =?utf-8?B?OUNoWEhETjRLRCs4M0pKQTlJSk9LRHltMmJOeVJLdm4vaXpCNnIyQ0RhOEUr?=
 =?utf-8?B?Nm1CdFE1V3lRREkvcXlob0NxbTNqcC9LNkc0N09xeml4TlYzWTRkNzBpNDZp?=
 =?utf-8?B?REhNeHBYQTZOV2hHT2tNcWcxeVdRZW9mejJnakpBZXZaY3cyditYY09vSmwz?=
 =?utf-8?B?akVBTVRVQnhqZ2pqOFhsRWNEeU43NDRTMHE5dDFxMXFrYnh1bzRYbStkT055?=
 =?utf-8?B?SlB4QVA2Zll0eUovZnJWb2dYem9iUEpLalhxMUFzWTdHaVFqa3ZidHB2b2gz?=
 =?utf-8?B?YTJNcFkrMk0wRk1LeG5CWlV2NHI5cFptaUpIL1ZESWxMY1cxcEo3WXZ2dk5B?=
 =?utf-8?B?S0g0VGNXSVhOMGwxaTVGb09lK1dyUGxDNC8zQkhQY3BpU0xZTjR0b2RoaStB?=
 =?utf-8?B?YWs1SkpHWm44ZkVJb3BzUTFCUk4yaDVrQmNxbEx2UlFVUjY0akM0bVhxMjZQ?=
 =?utf-8?B?TWNsRjVoUC9wMTNDb3dodnkrZXV5S0orQ3dQb05zY01mSzlLdndTTEZ2MUoz?=
 =?utf-8?B?NGFaclpjYmptQ2ZLbUhYbFcxRTIyNm0vWS8wYWdueUloSDUxSGpBR3dySnlH?=
 =?utf-8?B?WVN6RWNlT1pjcmVKMG1ScjdsSTVkbTRWSVdXb0ttOGdRVmhmSFJNSGhpQk0v?=
 =?utf-8?B?L2NpSzl5YWJWTVBHY1JGUW8rRTVJWG14eGdKUFFsbnR5RXlqbFJjMnArWnNJ?=
 =?utf-8?B?RThnZTNtcklJN1E1cGtMMExtZWVPRDRHVmNSNE5JL2xRT005WUFiN01vWDZx?=
 =?utf-8?B?UHZ4RDF5c2p4KzAxYlJHcnR6MlBLcVUvazE3N1ZKdXArK3JxNXA0ZzIwU3U5?=
 =?utf-8?B?ZExNL05RTUFDYlh6RXdwVldsSmdqNi9Kd0toUlU1NVlncWtQUWRsaUorVzFx?=
 =?utf-8?B?QnZnY0NTQ2lkcWx1NmRCdjd6Z2JYam13VFNvRUlKUGRPUCtrMjk2clZNVEFm?=
 =?utf-8?B?SlhlM1ZVejBPeEttUWhtdHJGOXZLUUxkUnVXeXhycE4rczR1L1k0SjlpRjZr?=
 =?utf-8?B?ZXFFTlVSSzBRTGdjTnM0bDc5a0U1YkRlSEFRNmlYcld2TGhkS1dkWWZ5TStM?=
 =?utf-8?B?S2IzeDRheldUN3ZJVVdQVTJxSS9ZdTRzWTA4em5iajRsSGFKUld6QTFzT29L?=
 =?utf-8?B?L3N0NlY4ZHp6NHpiaFcwbFRibDZaanNMZTJtUnNQTjRUZDhmY1RzVXJpMkV4?=
 =?utf-8?B?ODhaUVR6U1VvWXpWSWo0TU9CVEhxTEEzTGFqRjNNYlZURUhTT05tWUxZQ3Fp?=
 =?utf-8?B?eEFCS3NSZ0xyVFZkZHNTYU15dDU5THBvZFJZUXBhT280clVONGU4QSs4ZFp4?=
 =?utf-8?B?ZlpNK2VpUlYvZjl3TjI4RUdOUkJmYmlGZS9neE1mcFMwbjJ6RjlEMlFTSGxV?=
 =?utf-8?B?Mm1WaUNZUktlRTNMVVY1dXdvaXZveURzV3lacE1Xd3lLZUhWc3dCaDJMMUwv?=
 =?utf-8?B?dElqZDRab2NDOGN1S0tkZHFIOWFlaVJnZnF6dDRNMFhJNVFRbmZ0N0ozYkxm?=
 =?utf-8?B?RkdlaUZ3dUI3ZG9IdG14c3lZVmkzZmhXWmp0dW9NbUpSK1I1bzdvZjBEWi9K?=
 =?utf-8?Q?jNlo5eOye3s/5jdzglRZ+Ve3W?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54dae0f-25ff-44fa-ac43-08dbc7298b5d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 11:35:45.4505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adf/JcNPOzZqE8dBP6zV1el3zbafaWWH+RDkAx6A4aTCw8LFz4/LjGUPceGwg2D5cpo2OXAA563A3nW9pGtoPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10276
X-Proofpoint-ORIG-GUID: dRswzVioK1j7dXu9dgTbCMvuKOs0pUVf
X-Proofpoint-GUID: dRswzVioK1j7dXu9dgTbCMvuKOs0pUVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

--------------wfmKdDjQ0f44OPibJs5pcWGA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/4/2023 11:42 PM, Fabiano Rosas wrote:
> Daniel P. Berrangé<berrange@redhat.com>  writes:
>
>> On Wed, Oct 04, 2023 at 11:43:12AM -0300, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
>>>> string containing migration connection related information
>>>> and stores them inside well defined 'MigrateAddress' struct.
>>>>
>>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>>>> ---
>>>>   migration/exec.c      |  1 -
>>>>   migration/exec.h      |  4 ++++
>>>>   migration/migration.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 59 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/exec.c b/migration/exec.c
>>>> index 2bf882bbe1..32f5143dfd 100644
>>>> --- a/migration/exec.c
>>>> +++ b/migration/exec.c
>>>> @@ -27,7 +27,6 @@
>>>>   #include "qemu/cutils.h"
>>>>   
>>>>   #ifdef WIN32
>>>> -const char *exec_get_cmd_path(void);
>>>>   const char *exec_get_cmd_path(void)
>>>>   {
>>>>       g_autofree char *detected_path = g_new(char, MAX_PATH);
>>>> diff --git a/migration/exec.h b/migration/exec.h
>>>> index b210ffde7a..736cd71028 100644
>>>> --- a/migration/exec.h
>>>> +++ b/migration/exec.h
>>>> @@ -19,6 +19,10 @@
>>>>   
>>>>   #ifndef QEMU_MIGRATION_EXEC_H
>>>>   #define QEMU_MIGRATION_EXEC_H
>>>> +
>>>> +#ifdef WIN32
>>>> +const char *exec_get_cmd_path(void);
>>>> +#endif
>>>>   void exec_start_incoming_migration(const char *host_port, Error **errp);
>>>>   
>>>>   void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 6d3cf5d5cd..dcbd509d56 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -65,6 +65,7 @@
>>>>   #include "sysemu/qtest.h"
>>>>   #include "options.h"
>>>>   #include "sysemu/dirtylimit.h"
>>>> +#include "qemu/sockets.h"
>>>>   
>>>>   static NotifierList migration_state_notifiers =
>>>>       NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
>>>> @@ -427,15 +428,64 @@ void migrate_add_address(SocketAddress *address)
>>>>                         QAPI_CLONE(SocketAddress, address));
>>>>   }
>>>>   
>>>> +static bool migrate_uri_parse(const char *uri,
>>>> +                              MigrationAddress **channel,
>>>> +                              Error **errp)
>>>> +{
>>>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>>> This cannot be g_autoptr because you're passing it out of scope at the
>>> end of the function.
>> It is still good to use g_autoptr to deal with the error paths.
>>
>> On the success path though you need   g_steal_pointer(&addr) to
>> prevent the autofree cleanup running.
> Ah good point, this has been suggested in an earlier version already, I
> forgot to mention. We should definitely use g_steal_pointer() whenever
> the variable goes out of scope.
Okay. I get the point that g_autoptr helps to deal with freeing of 
pointer in case error occurs inside the function.
But I am still trying to figure out why we need g_steal_pointer() ? If 
you could please explain once again.
My understanding till now was that if we want to return 'addr' variable 
as return type, then we would want to make use of g_steal_pointer(&addr) 
so instead of addr, we pass a temp ptr refrencing to the same location 
as addr, and then assign addr = NULL. But we are already assigning the 
memory location where addr was refrencing to 'channel'. Let me know if I 
am missing something ?
I think the syntax follows as the second example given here: 
https://docs.gtk.org/glib/func.steal_pointer.html ?


Regards,
Het Gala
--------------wfmKdDjQ0f44OPibJs5pcWGA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/4/2023 11:42 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87h6n65kac.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Daniel P. Berrangé <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On Wed, Oct 04, 2023 at 11:43:12AM -0300, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
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
        <pre class="moz-quote-pre" wrap="">
It is still good to use g_autoptr to deal with the error paths.

On the success path though you need   g_steal_pointer(&amp;addr) to
prevent the autofree cleanup running.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ah good point, this has been suggested in an earlier version already, I
forgot to mention. We should definitely use g_steal_pointer() whenever
the variable goes out of scope.</pre>
    </blockquote>
    Okay. I get the point that g_autoptr helps to deal with freeing of
    pointer in case error occurs inside the function.<br>
    But I am still trying to figure out why we need g_steal_pointer() ?
    If you could please explain once again.<br>
    My understanding till now was that if we want to return 'addr'
    variable as return type, then we would want to make use of
    g_steal_pointer(&amp;addr) so instead of addr, we pass a temp ptr
    refrencing to the same location as addr, and then assign addr =
    NULL. But we are already assigning the memory location where addr
    was refrencing to 'channel'. Let me know if I am missing something ?<br>
    I think the syntax follows as the second example given here:
    <a class="moz-txt-link-freetext" href="https://docs.gtk.org/glib/func.steal_pointer.html">https://docs.gtk.org/glib/func.steal_pointer.html</a> ?<br>
    <p><br>
    </p>
    Regards,<br>
    Het Gala<span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------wfmKdDjQ0f44OPibJs5pcWGA--

