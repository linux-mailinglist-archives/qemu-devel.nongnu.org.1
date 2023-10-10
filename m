Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 995EE7BF21F
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 07:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq57x-0000st-Al; Tue, 10 Oct 2023 01:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qq57u-0000qp-LW
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:17:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qq57r-000564-B4
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:17:50 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39A3jCiv031619; Mon, 9 Oct 2023 22:17:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=vFULo4dahb2p
 F8IPHH2Ay0eYsOzyRgnc9EOSLm0Wlno=; b=sm4zcrMx40SkPL926V/1k6oPDWHB
 GsbvrSGM4UbazNQl0QwZrefbwHgwyuxqZkfCgz9t8OLqfTKvN2LSUmIL4VPRnH/7
 g5yBGratG8OvYj/Nwab4pZWgulbvC8ttGuj/oXkRTSJinU1ts0yybCErLdhi8VoE
 L2yVJpCQsIKreePMd2cowE3RFih0c9BZWm1OKMSt6tIvr78H6m87IRQsd7VUlrLf
 2doVCmFHtElh2tcfzkzsYKGfPt0yPdQpmBHR1iYPKiEj5bW8O8K2VNWeIQmM3JpE
 lobME7h/ehTs4j5YK10eKPtcFaAcDQVnydV91cs6RHjyjP1ZgRygdGARNQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkht8b5a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 22:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfXEIs+lsu4VT1k/bUWJ+jHdMx6i/xPY0kkV7UGMPcCLddtDB1Z8XXO23NQZESy5OFbqMcGQfz9uMJjNQlfL/KyNuV6jWlwJK1+gAg180HQy75mS/rV01blSC64u4M2+wnvhIK04EMPO5/2lprx5rZ9NYCM27Ew15/L0Be9gL9tI8odrPM8v7v87TKlymDoPr1Xji/uXrJHbZgNU8vWqQ0Y5Gg9m7IoxAQ9XbqKL4sXBONq8ED513ho/9Oq+/ejnV42OFSc842mO/cvmbFQfdOUyr6DYdLA3A9gB8e7+7y+0CTpAuN3WiQuvny0sfW7N/av4+zINffOA0BhqhIlgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFULo4dahb2pF8IPHH2Ay0eYsOzyRgnc9EOSLm0Wlno=;
 b=QM4hGu6mzSf7184o37qq+lfnatqBdPEvnOZC/TOSQ2GdqPurKSPrIHNWlZaTUWPg4y+w3iyeR0Mz46KJy8xSS1S09ji93mEa7XVfKB82Wk+XD9SismRO05ArBGHDWv6vuAjmx6horrRQibchujbqu0qyNOx3sUVX4HaFKt3n17UNH5gOpTsJDbpX1abDhQr/UrLqXR1yTlhqpfRQCWYnz7GyY3Pl4NB6d/NzU/EhhRkUZsMGI4jBbxdVKev1Qyv1eFOJkJ5GPJC85rNzBx0LmjQHRXSXVEH8EE3MBZ67I2dqZjA3Lkq2VHHP6oVEmVV0v4XU9H9l9EJBrwCiRLIMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFULo4dahb2pF8IPHH2Ay0eYsOzyRgnc9EOSLm0Wlno=;
 b=ujUoEGz46eJZ0/o54Df4BMTvax3UNlvvj7babVnC3Kk/+yW0SFma6ePxtytEjxRFL9gUJoQmGC8N0j/4a08HoiLOxJU5nDETgsmJdM5g5XIMMjLy3TLL1+s+LnSvvoAUgdQvJE38Vfuwcni8grdENi0WgWMi7vLr0oJ/mtPAZDpRtMIA2iS3kWXDIgPZGsfmYEOjRHPtaCoT+I1p5OxfKo2vtdX4nbYSRNoW0I2hpJEoa+oX4vuvondESzZGbFRag50K+3Q2YA/lJ4taN3w2Y4zYxPDTfWyrpaGd7rWjA/uRzzLiUKxLGRuzQFiwBYnH3UzTdGhsmQYqwxGZhWbxlQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6754.namprd02.prod.outlook.com (2603:10b6:a03:213::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 05:17:42 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 05:17:42 +0000
Content-Type: multipart/alternative;
 boundary="------------9f0V0UECGBLLq040clM4mXq0"
Message-ID: <099c8758-e2c4-4ddc-a7bf-18993577c290@nutanix.com>
Date: Tue, 10 Oct 2023 10:47:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-9-het.gala@nutanix.com> <87ediapg58.fsf@suse.de>
 <1fa0fa5d-0989-43df-8f58-881b859f3f09@nutanix.com> <877cnvg98e.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <877cnvg98e.fsf@suse.de>
X-ClientProxiedBy: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4d32d3-4964-4339-ef90-08dbc95039db
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLr2CL0bymkZuqf71CCICEN3O9Ic2S17J8kZjz6obgmD6mWk1zDQXAdudZFefXCJGEx+qV68XI+csncCM5RxLif+OX770lfrVGV8sHtlIzwWa59kbV3vfuPT7h+eafL+b1doMlQUHqrJ+ROOJIBKJPaQ+ghlrb+0LhplqfFEQc6H3rimLqC7HVUmRcnT/uvlrx7qAeSjCzmo1diGZqegT5ptrfr05XEoe+U6oeenlCQWNPLIV8si3KNtIZOheMFkyXnaa70wBmZCcHBgamSkymLesRQvtf07NMYuLDEpFSDlBa+eurO38e1AXmNYoUaVnL6MhtVHUI1krtEtx/nJ3YLxaeKKx2X3SXLLVIq6HfdK9JFU1MwPzn91OWWcsEnEOjY4LhKXZdFf3SyNmRDcDoCq82dMqxhEC17IWjjfwmc0CcmUj7uJfkfpj9GVjnylZmjd0HxqaYbXG2BnDE7rq2HLnKszkZx1n+llg75cVV0Kwm8OOUYQa1vIVklEz5gERCiak3Ux7EzG3AAH90R2bwj6XSdhDSSM6GHpr4GaIXVbL+yhVhUgVqO8itp66CUuEYN5Jm5heI6QaK32GjYARSwM8M62029ejtk9VCQnqaCfZq2nFu/sJS8LeEEKkKey5MflO/qLi2AbT3pQnvl0MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39850400004)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(33964004)(26005)(2616005)(53546011)(8676002)(6512007)(5660300002)(6666004)(316002)(6506007)(66476007)(478600001)(4326008)(30864003)(83380400001)(2906002)(66946007)(66556008)(6486002)(44832011)(41300700001)(8936002)(31696002)(107886003)(38100700002)(36756003)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZYQ0E3NG03UUxpNGlyVm9ZUDdDSTVtc1Zrd3pESVIrSGxlVHlqa3RQb3dQ?=
 =?utf-8?B?QnRQQTI5bmxpWEFjM3laTHlYZno4aW9ZZUtjQjJkS0xERjB5Y2E3TzNsUEY3?=
 =?utf-8?B?VU9tRWZVUnkzaCtlY2tUaUgrOEhuUjFIUFAzS2lPQWxrL3Z1bHZhdC9sZkIv?=
 =?utf-8?B?czVlZUx0MW5WZkFQK0FRU3psMk5CVHcrVWFuNGVPazB3S0IxSGpTTHVFQ1BY?=
 =?utf-8?B?TG4xcFdFK1JZVGdDdy9JWVVNU2lXcVBVRmFKeTRGR2dOWVJTcGpZckt4SjVO?=
 =?utf-8?B?YTVlUTh6OUpPQ3VISm5xd1laTWJ3d1dXOXk4czN2bitFVWtwVG01Ti9jb1Zz?=
 =?utf-8?B?UHBuWU50b3Y5cGFHQVhhWEVaeHhUSHY0RjdLaTZkaEdOUmcvVlNwUTVVWkN1?=
 =?utf-8?B?UmJIdGFzYVl0TktsWVlxbHcxTGYyWmhsT3RkbUpxV3VJK0FoOTlRaWZha0to?=
 =?utf-8?B?YjVCTGZzNngzd0NSY3JucnVhNStzRzNsSVFoT0FkVk91QmpuUVFBbEpXMWdS?=
 =?utf-8?B?SjZuM0hXR3lIQjZVK3dXRWlFemwxV1hlTWJPM3NROG85cEpNdHNiS2Z5dGJt?=
 =?utf-8?B?dXhYWWRuMVo2b0hQSWtLcmN1NVRqMm14d3B3bUhmUi9pQk5tRkhvcVcvTGlV?=
 =?utf-8?B?Tmx4UTRzdUhod1h2Y21BL3JrN0N4cmFqODZHWVF2R0JQZjFhQWduTTRxKzN4?=
 =?utf-8?B?dlNXWkswTlAxL1RGQjVGVDVvUkpGYytRL3N0QTBSOW9MRXZYSGVvbndldWR3?=
 =?utf-8?B?dDRxbk53M2VCQTJIM3NoQ1dBSGs0WGRCOGY2aFpXNjNhbFhvOFg3bUhvYWht?=
 =?utf-8?B?M1NyakdTSXZYZDk3cHlBd0VLOUpGMnZ1M20zQ0JJY1lyVXhGSk5aODZDOGhS?=
 =?utf-8?B?TnpTWjRwU2FSUWxlNmxMVGxuNDRLWnJhYXlYT2xKVEZ5Q0pWUkJqZmxrQmVE?=
 =?utf-8?B?VjR6Y3VhSUZESVJ3NDdoSHlyc3BiVWh5L2srNC81ckZaQlFFZGxPZ3Zhak9X?=
 =?utf-8?B?VmRiUzZVL2FkWDFMNVY4dHFtaWF2OVloZmpYMGkwRG9mU3F4SHNxdU9odWRX?=
 =?utf-8?B?R0piS1V2M3lGTWJneDBTSGZsYVVGQnBxdDFONGloaXJhc3F1S1g2QXpGWXlY?=
 =?utf-8?B?Qng4NVloVGw0SFNkZ3NwYkxXLzFoUHh6MWs0cEc0cVVETDdvRFU3dDhpeGlM?=
 =?utf-8?B?VkY3ZGFzK0ZQSWx1N3JnK0ZhRTVnczZNZVBjdkxma1FaK0FlNkdqL2NlKzNC?=
 =?utf-8?B?QllkSjNIS1hiZzRnVVcyMUJTZXdzVXMrNmhWNGxTWVVoWWQ3emRHTkVheWh0?=
 =?utf-8?B?NTFVOGpyc2JRTFNTYU5tdjF5RDhtYkdOeWoxMjJMdUljazJVTTg4NTFTdXdz?=
 =?utf-8?B?ZU5QdGY1R1c3SVZWMTl1cytRblRhMUdpMU8xWmFHeDlHcEtlOFVVL2JFR0NZ?=
 =?utf-8?B?SEkvaXU1WGZXUk9nR0dRN0JsVzM4VWZ2RXhLOVVoRjdRcTl2bG1jZWtPdFg5?=
 =?utf-8?B?cHRDN2w1ZHA4U1RHaTRheUg5bjZnUzUyNDBORDRFaXVJQ2FheFNKZ283ZG9O?=
 =?utf-8?B?MTB3enk5TlVIQVZnU25BOGE0V21sYSszMlEyVzltbGVzeEZQTFlMdDNGSW9S?=
 =?utf-8?B?V2syTkV5ZDRXelpwV1RnOVBRMnhCU2FYdzVFRFlNc3Q0emNOTEZhN2llb2Vj?=
 =?utf-8?B?ZDIzQVBOQk1VTStwazVwbCt1bnNXWWVaMWUvZURHdEg2T0dzYTdZN3I2QlpX?=
 =?utf-8?B?a1NjSEN2TWxoMC9mcVFjNW41a201bldPU2xEalNJR3Q5UnBqYXFlMXNpbnFB?=
 =?utf-8?B?bHNiZjVKSmhGTmFVL3RHZm1vL3hYMmVZSEFWNkdKZUlTTncwdG1kaGtQK3c5?=
 =?utf-8?B?QzRrRHV0bXVMMnlQRVMybXo0RmhUSWN4M2QyWjBuUnZPZkJSSVJ4WTViOHVY?=
 =?utf-8?B?ck5GM0xzZGxJUndzNG5RU0tLWFJjT1IvWlpkZjU5dWpaQk5Gd0VtVENZaUlm?=
 =?utf-8?B?UUVCeUxsVFF2NFBkQTVDRDBvZmVCMC9mYnJMRWx5dEpaRXFTMVlWQ282bXVE?=
 =?utf-8?B?M0FZakNPVmFRN3NtNUR5ZGE4aENCK0pSVE9QemlFQ2NJcEFVZW51TXlWS1hQ?=
 =?utf-8?Q?8JwvBh2Ud2H6G31PCxSpuvXlY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4d32d3-4964-4339-ef90-08dbc95039db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 05:17:41.3905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiC/n0dq94M+khFiLVUQrw2BumOr5Aa5yIufded8EkrQeOxNi257WZQwe4YUslOymAsZVM7GgTpWjn4vDTObmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6754
X-Proofpoint-ORIG-GUID: EgrLVGAb8-4nRLhrr2OQRTd_PhdVbHz0
X-Proofpoint-GUID: EgrLVGAb8-4nRLhrr2OQRTd_PhdVbHz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_03,2023-10-09_01,2023-05-22_02
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

--------------9f0V0UECGBLLq040clM4mXq0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/9/2023 7:59 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 10/4/2023 8:51 PM, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>   writes:
>>>
>>>> Integrate MigrateChannelList with all transport backends
>>>> (socket, exec and rdma) for both src and dest migration
>>>> endpoints for qmp migration.
>>>>
>>>> For current series, limit the size of MigrateChannelList
>>>> to single element (single interface) as runtime check.
>>>>
>>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>>>> ---
>>>>    migration/migration.c | 95 +++++++++++++++++++++++--------------------
>>>>    1 file changed, 52 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 6f948988ec..3eae32e616 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -432,9 +432,10 @@ void migrate_add_address(SocketAddress *address)
>>>>    }
>>>>    
>>>>    static bool migrate_uri_parse(const char *uri,
>>>> -                              MigrationAddress **channel,
>>>> +                              MigrationChannel **channel,
>>>>                                  Error **errp)
>>>>    {
>>>> +    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>>> Here val is passed out of scope so it shouldn't be g_autoptr.
>> I guess, same as for 'addr' we need to go with adding
>> g_steal_pointer(&val) here too ?
> Yes, you cannot give the same pointer to *channel because this one is
> already being tracked by g_autoptr and it will free the memory when it
> gets the chance. So we need to steal it from g_autoptr, so to speak.
Yes true. Ack.
>>>>        g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>>>>        SocketAddress *saddr = &addr->u.socket;
>>>>        InetSocketAddress *isock = &addr->u.rdma;
>>>> @@ -471,7 +472,9 @@ static bool migrate_uri_parse(const char *uri,
>>>>            return false;
>>>>        }
>>>>    
>>>> -    *channel = addr;
>>>> +    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
>>>> +    val->addr = addr;
>>>> +    *channel = val;
>>>>        return true;
>>>>    }
>>>>    
>>>> @@ -479,41 +482,44 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>>>                                              MigrationChannelList *channels,
>>>>                                              Error **errp)
>>>>    {
>>>> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>>>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>>>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>>> Here we want just the pointer, no allocation, no freeing. For both
>>> channel and addr.
>> Ack, same as channel in patch 2.
> This is actually one of the cases where we need to think about how we
> are going to free that memory. You need to make sure no one is using the
> 'addr' after you call into the *_incoming_migration functions. All users
> should either use the value and return or make a copy if they intend to
> pass it forward. If you determine that no one is using 'addr' and
> 'channel', then we could bring the channel g_autoptr back.
Honestly, I think g_autoptr would work here because no one uses addr or 
channel after *_incoming_migration or *_outgoing_migration functions. 
But not sure. But that does not make the checks pass, so I have gone 
forward with simple pointers to pass make checks.
>
>>>>    
>>>>        /*
>>>>         * Having preliminary checks for uri and channel
>>>>         */
>>>> -    if (has_channels) {
>>>> -        error_setg(errp, "'channels' argument should not be set yet.");
>>>> -        return;
>>>> -    }
>>>> -
>>>>        if (uri && has_channels) {
>>>>            error_setg(errp, "'uri' and 'channels' arguments are mutually "
>>>>                       "exclusive; exactly one of the two should be present in "
>>>>                       "'migrate-incoming' qmp command ");
>>>>            return;
>>>> -    }
>>>> -
>>>> -    if (!uri && !has_channels) {
>>>> +    } else if (channels) {
>>>> +        /* To verify that Migrate channel list has only item */
>>>> +        if (channels->next) {
>>>> +            error_setg(errp, "Channel list has more than one entries");
>>>> +            return;
>>>> +        }
>>>> +        channel = channels->value;
>>>> +    } else if (uri) {
>>>> +        /* caller uses the old URI syntax */
>>>> +        if (!migrate_uri_parse(uri, &channel, errp)) {
>>>> +            return;
>>>> +        }
>>>> +    } else {
>>>>            error_setg(errp, "neither 'uri' or 'channels' argument are "
>>>>                       "specified in 'migrate-incoming' qmp command ");
>>>>            return;
>>>>        }
>>>> -
>>>> -    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>>>> -        return;
>>>> -    }
>>>> +    addr = channel->addr;
>>>>    
>>>>        /* transport mechanism not suitable for migration? */
>>>> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
>>>> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>>>>            return;
>>>>        }
>>>>    
>>>>        qapi_event_send_migration(MIGRATION_STATUS_SETUP);
>>>> -    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>>>> -        SocketAddress *saddr = &channel->u.socket;
>>>> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>>>> +        SocketAddress *saddr = &addr->u.socket;
>>>>            if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>>>>                saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>>>>                saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
>>>> @@ -522,11 +528,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>>>                fd_start_incoming_migration(saddr->u.fd.str, errp);
>>>>            }
>>>>    #ifdef CONFIG_RDMA
>>>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>>>> -        rdma_start_incoming_migration(&channel->u.rdma, errp);
>>>> -#endif
>>>> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>>>> -        exec_start_incoming_migration(channel->u.exec.args, errp);
>>>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>>>> +        rdma_start_incoming_migration(&addr->u.rdma, errp);
>>>> + #endif
>>>> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>>>> +        exec_start_incoming_migration(addr->u.exec.args, errp);
>>>>        } else {
>>>>            error_setg(errp, "unknown migration protocol: %s", uri);
>>>>        }
>>>> @@ -1750,35 +1756,38 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>>        bool resume_requested;
>>>>        Error *local_err = NULL;
>>>>        MigrationState *s = migrate_get_current();
>>>> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>>>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>>>> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>>> Again just the pointers.
>>>
>>> We'll have to make another pass and check whether we're missing freeing
>>> something. But for now let's first clear all the errors then we can look
>>> at the code working and do the necessary changes.
>> Ack.
>>>>    
>>>>        /*
>>>>         * Having preliminary checks for uri and channel
>>>>         */
>>>> -    if (has_channels) {
>>>> -        error_setg(errp, "'channels' argument should not be set yet.");
>>>> -        return;
>>>> -    }
>>>>     
>> Regards,
>> Het Gala
Regards,
Het Gala
--------------9f0V0UECGBLLq040clM4mXq0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/9/2023 7:59 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:877cnvg98e.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 10/4/2023 8:51 PM, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for qmp migration.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran<a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Daniel P. Berrangé<a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
---
  migration/migration.c | 95 +++++++++++++++++++++++--------------------
  1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6f948988ec..3eae32e616 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -432,9 +432,10 @@ void migrate_add_address(SocketAddress *address)
  }
  
  static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                                Error **errp)
  {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Here val is passed out of scope so it shouldn't be g_autoptr.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I guess, same as for 'addr' we need to go with adding 
g_steal_pointer(&amp;val) here too ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes, you cannot give the same pointer to *channel because this one is
already being tracked by g_autoptr and it will free the memory when it
gets the chance. So we need to steal it from g_autoptr, so to speak.</pre>
    </blockquote>
    Yes true. Ack.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:877cnvg98e.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">      g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
      SocketAddress *saddr = &amp;addr-&gt;u.socket;
      InetSocketAddress *isock = &amp;addr-&gt;u.rdma;
@@ -471,7 +472,9 @@ static bool migrate_uri_parse(const char *uri,
          return false;
      }
  
-    *channel = addr;
+    val-&gt;channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val-&gt;addr = addr;
+    *channel = val;
      return true;
  }
  
@@ -479,41 +482,44 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                            MigrationChannelList *channels,
                                            Error **errp)
  {
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Here we want just the pointer, no allocation, no freeing. For both
channel and addr.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Ack, same as channel in patch 2.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This is actually one of the cases where we need to think about how we
are going to free that memory. You need to make sure no one is using the
'addr' after you call into the *_incoming_migration functions. All users
should either use the value and return or make a copy if they intend to
pass it forward. If you determine that no one is using 'addr' and
'channel', then we could bring the channel g_autoptr back.</pre>
    </blockquote>
    Honestly, I think g_autoptr would work here because no one uses addr
    or channel after <span style="white-space: pre-wrap">*_incoming_migration or </span><span style="white-space: pre-wrap">*_outgoing_migration functions. But not sure. But that does not make the checks pass, so I have gone forward with simple pointers to pass make checks.</span>
    <blockquote type="cite" cite="mid:877cnvg98e.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  
      /*
       * Having preliminary checks for uri and channel
       */
-    if (has_channels) {
-        error_setg(errp, &quot;'channels' argument should not be set yet.&quot;);
-        return;
-    }
-
      if (uri &amp;&amp; has_channels) {
          error_setg(errp, &quot;'uri' and 'channels' arguments are mutually &quot;
                     &quot;exclusive; exactly one of the two should be present in &quot;
                     &quot;'migrate-incoming' qmp command &quot;);
          return;
-    }
-
-    if (!uri &amp;&amp; !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels-&gt;next) {
+            error_setg(errp, &quot;Channel list has more than one entries&quot;);
+            return;
+        }
+        channel = channels-&gt;value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &amp;channel, errp)) {
+            return;
+        }
+    } else {
          error_setg(errp, &quot;neither 'uri' or 'channels' argument are &quot;
                     &quot;specified in 'migrate-incoming' qmp command &quot;);
          return;
      }
-
-    if (uri &amp;&amp; !migrate_uri_parse(uri, &amp;channel, errp)) {
-        return;
-    }
+    addr = channel-&gt;addr;
  
      /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
          return;
      }
  
      qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (channel-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &amp;channel-&gt;u.socket;
+    if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &amp;addr-&gt;u.socket;
          if (saddr-&gt;type == SOCKET_ADDRESS_TYPE_INET ||
              saddr-&gt;type == SOCKET_ADDRESS_TYPE_UNIX ||
              saddr-&gt;type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -522,11 +528,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
              fd_start_incoming_migration(saddr-&gt;u.fd.str, errp);
          }
  #ifdef CONFIG_RDMA
-    } else if (channel-&gt;transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&amp;channel-&gt;u.rdma, errp);
-#endif
-    } else if (channel-&gt;transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel-&gt;u.exec.args, errp);
+    } else if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&amp;addr-&gt;u.rdma, errp);
+ #endif
+    } else if (addr-&gt;transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addr-&gt;u.exec.args, errp);
      } else {
          error_setg(errp, &quot;unknown migration protocol: %s&quot;, uri);
      }
@@ -1750,35 +1756,38 @@ void qmp_migrate(const char *uri, bool has_channels,
      bool resume_requested;
      Error *local_err = NULL;
      MigrationState *s = migrate_get_current();
-    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Again just the pointers.

We'll have to make another pass and check whether we're missing freeing
something. But for now let's first clear all the errors then we can look
at the code working and do the necessary changes.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Ack.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  
      /*
       * Having preliminary checks for uri and channel
       */
-    if (has_channels) {
-        error_setg(errp, &quot;'channels' argument should not be set yet.&quot;);
-        return;
-    }
   
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Regards,
Het Gala</pre>
      </blockquote>
    </blockquote>
    Regards,<br>
    Het Gala<span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------9f0V0UECGBLLq040clM4mXq0--

