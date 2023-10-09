Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9027BE3E5
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 17:08:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprqJ-0005Bq-Ky; Mon, 09 Oct 2023 11:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprqF-0005BC-Bp
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:06:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprqB-0008BU-7O
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:06:42 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399CVmEa012215; Mon, 9 Oct 2023 08:06:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=qeA5YIwEMsyH
 MPmF96iuj0c/mBeJuBlfuTgVuoyRlmY=; b=xlzgbtuUJS1p2CjnnN4FSP1WEjDh
 4SD2TAmhEMz1AdWhvoo0hOCHsbnUeqFO9AFvjQYu9VhrsOVpsZJKSrZ0veKxE01l
 q6MrIblNcSg5SqOqcBx2iYYbO9g8vuWdqWeTG6xCSlzQzMoJfYuprpRFMlMle6/D
 B6hDNg8DfAfyDVYD4u3Ec+ZgCAVW8B4EEDzSlf1q/E2K19bPfnDOrOszlBvNPKNa
 wbRa4vmv44kSx903TJ9qM9HNYgOxMc8fOzTl6JJfYg9a7lQjxsdiCjC29fJorWr+
 78QwOJuBodJZMPKVjC+lz4A9ub/hqKSD+FtRrta/ONoVAw8iCS/LH8ij2g==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhtbtx0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 08:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhA2dgxfADyAMc1F+fQNZ7ml9mW6PsjjGbM34Fz7xNJkhxeWh9Xi3vnXpxKkXnyaDBQwEuq44YXB3gXnfXE7c7zMNKOiO10fu+kMkS+7ougtUHzpCBjtnzDAke+nMSSasC0Dcqdc1ybm5SXcKdk/aXXH0GqSC4rFdkI9lxTEhyP2Mv80hGYRZiBW9NnIb9L5lMZkUcClWW6BL5Dqcj+4zQMV1+CAhSdGJ9AIC7L9AKXpjWcI/mg8CoXS78nVrmxdHNR+gv0ILZFdLZ4apu4ABfWTqv0EPxBSKLCXET6TckeWxyyuJXWf12uBE7w9wrA7e8wSJiJ8CNW+HpTHt6C32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeA5YIwEMsyHMPmF96iuj0c/mBeJuBlfuTgVuoyRlmY=;
 b=lz8TmUzXDBdT5MNrt75/FO4N7SNKCYOlg9pX0kacLKoWTnyPDKhkFagcX5YuPnMo2mAtV9S1/gRV0ODCVt4AGts8prwusVkwM3OFyKQPqoHxdF9aboWtzItCc3hwbOIy0hGQz/e2Ge5r+Tzt+rokA80o0QsCNKPafYEM/j1GL/wvAoVOh3ALHj/qVfW02b889mhwwS8/IUJDQXS2mrPg65lGJAfifiAsSAkuqvOJpf0KBwdZHhktdblkYbRbDdxl076ji463THPJl3hJCkCzAHfdsJDKtMSPN6+us1IlhQJcZjYSyfXF3AmABdeypbWoOrNbP9kgK2Dvvd0FXzUnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeA5YIwEMsyHMPmF96iuj0c/mBeJuBlfuTgVuoyRlmY=;
 b=IgjGjvinmYks+pVxOea+4c1i8bM1FWkP/DlW1rS4NufoHl67AvhQuNiOGB0GkC0kxcwiXp8QmR416blpnbIigsbbViKtLqcX2NiVp6C9HBdxBgFNvqhiKcqPhddCWMlsfAM6N2DZZfztDk32Pep0g/F49JtbMfuI/PWIGWYbZ8GmQJn2YQsZsrZsmY6NSyzffL4UYmWp/TL9YsZO3xHWQ/8j19qV2ucoUM+jcNt1R2mqJWhY/66KedQ9UJGDdeUDYfzoNUjjHCJlkR7EClJ7Ag86r3DJRwQORbs3hc98SRiYefMIEK5Tb119VQxrNXB51yAoCtqKDLwgos3b/dadAg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9241.namprd02.prod.outlook.com (2603:10b6:208:436::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:06:32 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:06:31 +0000
Content-Type: multipart/alternative;
 boundary="------------y50cXSoNqBcpTNFwmPy03H4F"
Message-ID: <5a53fbd6-9589-4e0b-9dee-7468583e9012@nutanix.com>
Date: Mon, 9 Oct 2023 20:36:30 +0530
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
 <b9a9b3ff-80ff-4b23-bbd8-996afe40e7d7@nutanix.com> <87a5srg9yo.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87a5srg9yo.fsf@suse.de>
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fe0fcf-befe-4d69-7a43-08dbc8d95247
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TAj3s0oo6+eLyjvE5+/9hFVdrgAZFh7FObbpuobiiCg8uOpzJW0Mxy2mK9DI6K8Shfj+ct3kJE4FQFpqYXbTQxZrJAo5lrH5eMC4Uc2QNBEZ5Dz7e3QZaZ0j0OhjQmDZYD1Rv9E+cAXE9VHfpmS9w4bTpH04cRuhwAh19Q3fcSiyAiNy0qmPsL3XD/0+DzRIH+IH63MWHv6vnOGcyPuxCxNe9Lky/r0jsN4BNr7YH+ZkdIudF0boVf+XRxifiRr3JzhfcLKfporRW8wHNUwT+baBmZKVViMIt35InS+Sy7/mtI635uS4N+8EKz5hVHPWzbcyN1mVJKu5i1I8YDATI9zuXyGa+Kvh3cs3GK7yO3D5FKoyObTmbaY3838pSRFWQhLJIvSu0FJd8KFqG8T8cA0muchBSitgHfOdJlwGZUfNeg88ZXBnp0Vg5H6lKO5ggdCO5ekp0EgstAgTVfRw+KPQpnD3GhBcH2fDCi1OzcbeqvmTkqtwIX9AqasNZ7W5z2M8FA6fPTINkjvx1radwwk289oq6ZMifEhIAcSwyWVd9onFmr38Na/PDCM9EjWb+xztDbu9svspQYHXKcl656uHGIddw/B/p22KyuRs0c/Zs0MDwuzyq4x45I2Fw3Xm+uwteapRTrqwGW/sRMJxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(83380400001)(2616005)(107886003)(26005)(166002)(66556008)(66476007)(316002)(110136005)(66946007)(8676002)(4326008)(5660300002)(41300700001)(53546011)(6506007)(44832011)(2906002)(966005)(6512007)(478600001)(6486002)(8936002)(33964004)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxFTUg2cHRjeXowSXVvWmsyMUluazMrb0t6OUZ3RnpHUmlYTWxaUXdsRjM3?=
 =?utf-8?B?c3lRUHlzNUxyVkdzQzdhMHVPS2pvUGJieXBobVZiS2l3MmZya2FKbnV4Q2hy?=
 =?utf-8?B?a0hlb3M3clZyLzJ3RXBkZ0ZpdHBUZmVoSlhqMWFrRDVvbzdXNVlHdHkvb3FE?=
 =?utf-8?B?R0hnbXMvbkpIa2t0MVZUdWJDRCsxQzcyMkV3V3Y0ODM4M2w0bnptMWNCTHNO?=
 =?utf-8?B?bWxYTW01UDdWSUFYYWdxN2xoT2UwbFByR25oR2p5Z05SRzZUR0s5d3NwMXBt?=
 =?utf-8?B?WTdkWWJjQS8zYXZRRDhyZ1IxWklaaW1yZDJmOXFJZ29pQzZjbitVa2RtVXlN?=
 =?utf-8?B?a0NTVHlrbnllaGh3dnk1ZzZ1NUN1K2kxMEhmOWp0OXdVTkVQM2NrdEwwZkN0?=
 =?utf-8?B?UGI5MDBiM0FpSmpDOU4zZUhFaVFyUWhCZWRLcGRnZHozbkJhYXgrRzdyRFBN?=
 =?utf-8?B?ekRaYXRGVVFua2MvMFcwZG9KRFhReHVHREgyOVpHNkpHdG92Uk0zSVlqdFlw?=
 =?utf-8?B?bWN3TG4xdml4ZXY5QVU4SHpIUnVFb2VoWmxWbWYraUdHZjBtaHlhSjViMUdG?=
 =?utf-8?B?Qk9CdkNMM2Z2aDg2MHIvcDVQZFlaL2dWOGVCeERtSjFmSUVQWi9oU0ZBa3lp?=
 =?utf-8?B?dnJIUVk0bnczUWFFdWZwSzRHcDEvNkE4bkhVeHorYTlCNWJNWkJBQVlaZWgy?=
 =?utf-8?B?dHh2c3BMbE12M213bUFpVHU3czlwenhtanVrbnFoZjVaRGV0bDgwT0wweGt1?=
 =?utf-8?B?N0t2SzJBZmthbnZkQUdDZVNnRTc3eHJhRDhXenVDRnFLYnQ0amlHdkJSZTVO?=
 =?utf-8?B?S2dBcGtqRjQ2aW1rREEvV3BSZWs0RHlUeWdiY1F4UkxLZC8xKzVrZE4ySXQ4?=
 =?utf-8?B?b1VvbU8yeTNkaE5KcDhPZzIzRlB1YzRzUHU0bk9DdmlTdXVEalgxYnM2UEpZ?=
 =?utf-8?B?dmpOTlNCSUpYYktnNGRGQUJJdXRzT2NMRGpqWGQ2dE1IM1hHY3UrVTlqNG1x?=
 =?utf-8?B?cTVGVWVkZnc0cmt3azcrL2xZR2ozNDZCVjZWTUpzOFVoV1JHdkVIbGJ2TVVU?=
 =?utf-8?B?SXFyNHFTMTdBY3FqeHIvdHB5QzhuYm45MkE3b2REbmx2YURienRpM3VHdGlw?=
 =?utf-8?B?ZXc3TzBxTUI2WWN2UkJQUHBnbWduUUhnaDVDSHRNdVhLL3BpQnpJK0FyQTRv?=
 =?utf-8?B?VzU0dC92NDFpMXNERkN2MTRIRVBXOGdEMUpYWUxJbVUxVGIvMDRYOTdwa2N5?=
 =?utf-8?B?NE5YaHU5SjFScFhFVFM0bkQyVy9RUFFvVlRwelhaNVFmaE05QjUzRExrT2hX?=
 =?utf-8?B?cGVWeld6T3gxVmlxWm93dGJCczRNTDBURmdwa1pDbUdhRzY3K2o2MUxsWkt4?=
 =?utf-8?B?dHNIYnFrR1lPNEdLRy9EcDlYbU9wVHhZRlJGQ0JlR290cWJmcTduekZpYldz?=
 =?utf-8?B?UzVzckdvTjBXWHVUVmJqQ0I2QTlCY244NVRXdmRFazdPVldwQ1Yra1FoNlFM?=
 =?utf-8?B?VnAxKzhtcHJLckVkSnRHMkZGbkNFa0NZUVZZTWNjVVYrSzY1Y095Mjl4Szkv?=
 =?utf-8?B?ZURrRmFGbkdJQVNUekZ1cEhLdE42R3pITXVUWkp2cnE0S3NBODUybkJsb2Vw?=
 =?utf-8?B?NnNOR01xbWJqelhHb1VRa2lpWkRITHhlQTc1L1BpcVVCUVZwSlRuZDRaTEE2?=
 =?utf-8?B?UWJPWGRhYXIwbVBSWGRSZGd3MGNvSFUyTXp3aHNjT3hocWhFemt1L2RVV3JK?=
 =?utf-8?B?NTRvUEpTWUtYaGhFbzd4Y0hQQk5leTFVdkNXZ2J6QWtJbWhicWo2Ty9MUGNL?=
 =?utf-8?B?SlAwdFUrYkZkOXduTkpCbVFEci9qaTdrb0paSnY2cXhQZFlBWXBDdmRiUzdM?=
 =?utf-8?B?WVpZL0dualVhajNoYVJ1KzNJOStnWTRsOXlkRTZmcHF0Y3JESVQvTGdUU3Nl?=
 =?utf-8?B?dGFZaTZzdW5nK05rYi9SZHo2UGRiNkd3RXE3KzhwbzBjWitEaUd1THZmSXdi?=
 =?utf-8?B?TmNqS1BZZnkvY2VoblN4M3pMcWlqcWRiSmlFV0JWV1kwUGdod2NuQmZ3djRn?=
 =?utf-8?B?VlhJOHljMFBLQ0hxem1PQ3NXSys1N2dyOVZISkRKeFpaeXVsTisxUGZyUVVp?=
 =?utf-8?Q?POWoOmsZfrRlOi/+Ir/sIsffJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fe0fcf-befe-4d69-7a43-08dbc8d95247
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:06:31.8120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWPJMpe+Y+vR20y+wQwOhvBupcLCxFvuhaeRZwLIYudfVa3gtcz2JKx2LtV2123GmmrLnKItQHeK0XKjIUWJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9241
X-Proofpoint-GUID: tp4n5a7QZsLNhXh3vxe3Dv1AFtknox-E
X-Proofpoint-ORIG-GUID: tp4n5a7QZsLNhXh3vxe3Dv1AFtknox-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_13,2023-10-09_01,2023-05-22_02
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

--------------y50cXSoNqBcpTNFwmPy03H4F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/9/2023 7:43 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 10/4/2023 11:42 PM, Fabiano Rosas wrote:
>>> Daniel P. Berrangé<berrange@redhat.com>   writes:
>>>
>>>> On Wed, Oct 04, 2023 at 11:43:12AM -0300, Fabiano Rosas wrote:
>>>>> Het Gala<het.gala@nutanix.com>   writes:
>>>>>
>>>>>> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
>>>>>> string containing migration connection related information
>>>>>> and stores them inside well defined 'MigrateAddress' struct.
>>>>>>
>>>>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>>>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>>>>>> ---
>>>>>>    migration/exec.c      |  1 -
>>>>>>    migration/exec.h      |  4 ++++
>>>>>>    migration/migration.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>>>>>>    3 files changed, 59 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/migration/exec.c b/migration/exec.c
>>>>>> index 2bf882bbe1..32f5143dfd 100644
>>>>>> --- a/migration/exec.c
>>>>>> +++ b/migration/exec.c
>>>>>> @@ -27,7 +27,6 @@
>>>>>>    #include "qemu/cutils.h"
>>>>>>    
>>>>>>    #ifdef WIN32
>>>>>> -const char *exec_get_cmd_path(void);
>>>>>>    const char *exec_get_cmd_path(void)
>>>>>>    {
>>>>>>        g_autofree char *detected_path = g_new(char, MAX_PATH);
>>>>>> diff --git a/migration/exec.h b/migration/exec.h
>>>>>> index b210ffde7a..736cd71028 100644
>>>>>> --- a/migration/exec.h
>>>>>> +++ b/migration/exec.h
>>>>>> @@ -19,6 +19,10 @@
>>>>>>    
>>>>>>    #ifndef QEMU_MIGRATION_EXEC_H
>>>>>> rate_add_address(SocketAddress *address)
>>>>>> ng it out of scope at the
>>>>>> end of the function.
>>>> It is still good to use g_autoptr to deal with the error paths.
>>>>
>>>> On the success path though you need   g_steal_pointer(&addr) to
>>>> prevent the autofree cleanup running.
>>> Ah good point, this has been suggested in an earlier version already, I
>>> forgot to mention. We should definitely use g_steal_pointer() whenever
>>> the variable goes out of scope.
>> Okay. I get the point that g_autoptr helps to deal with freeing of
>> pointer in case error occurs inside the function.
> Yes, but note g_autoptr will free the memory any time the variable goes
> out of scope, i.e. any time we return from the function. Even when
> there's no error and we actually want that memory to still be around for
> the callers to use.
>
>> But I am still trying to figure out why we need g_steal_pointer() ? If
>> you could please explain once again.
>> My understanding till now was that if we want to return 'addr' variable
>> as return type, then we would want to make use of g_steal_pointer(&addr)
>> so instead of addr, we pass a temp ptr refrencing to the same location
>> as addr, and then assign addr = NULL. But we are already assigning the
>> memory location where addr was refrencing to 'channel'. Let me know if I
>> am missing something ?
> So now 'channel' points to the memory you allocated at the start of the
> function with g_new0. When the function returns, g_autoptr has no idea
> that someone is still using that memory, so it will just free it.
>
> Whenever you want a chunk of memory to be accessed across function calls
> like that you need to steal the reference. After stealing, the pointer
> that was registered with g_autoptr (in this case 'addr') now points to
> nothing and the pointer that was returned/assigned is a different one
> that isn't known by any cleanup functions.
>
> Note that after g_steal_pointer, that memory now becomes responsibility
> of whatever piece of code owns that pointer. In this case,
> qemu_start_incoming_migration() and qmp_migrate(). Those two functions
> will have to free the memory once they are done with it. Or do the
> g_autoptr/g_steal_pointer trick once more.

Got your point perfectly now. Thanks a lot. Just so that I understood 
right, summarising it in short:

g_autoptr --> helps in error paths so we use it, but for non-error paths 
if it goes out of scope, it will free it so to prevent that we have to 
use g_steal_pointer(). Either use g_autoptr/g_steal_pointer pair or do 
it simple but then will have to take care of error paths as well as 
non-error paths to free the pointers.

>> I think the syntax follows as the second example given here:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.gtk.org_glib_func.steal-5Fpointer.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=Fn2ZhrrsSvcV_ZUX3PUnI1zMMD7JM5o1X9LbURlU1B7O06RNnzmOS3hKI4HBe6fB&s=iJFFbZnxzfqd1xu3gRVfvdjjE_X3XT3t0aRRAIeaUUc&e=   ?
> Yep, that's it.

Ack.

Regards,
Het Gala
--------------y50cXSoNqBcpTNFwmPy03H4F
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/9/2023 7:43 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87a5srg9yo.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 10/4/2023 11:42 PM, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Daniel P. Berrangé<a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>  writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On Wed, Oct 04, 2023 at 11:43:12AM -0300, Fabiano Rosas wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
string containing migration connection related information
and stores them inside well defined 'MigrateAddress' struct.

Suggested-by: Aravind Retnakaran<a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Daniel P. Berrangé<a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
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
rate_add_address(SocketAddress *address)
ng it out of scope at the
end of the function.
</pre>
              </blockquote>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">It is still good to use g_autoptr to deal with the error paths.

On the success path though you need   g_steal_pointer(&amp;addr) to
prevent the autofree cleanup running.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Ah good point, this has been suggested in an earlier version already, I
forgot to mention. We should definitely use g_steal_pointer() whenever
the variable goes out of scope.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Okay. I get the point that g_autoptr helps to deal with freeing of 
pointer in case error occurs inside the function.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes, but note g_autoptr will free the memory any time the variable goes
out of scope, i.e. any time we return from the function. Even when
there's no error and we actually want that memory to still be around for
the callers to use.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">But I am still trying to figure out why we need g_steal_pointer() ? If 
you could please explain once again.
My understanding till now was that if we want to return 'addr' variable 
as return type, then we would want to make use of g_steal_pointer(&amp;addr) 
so instead of addr, we pass a temp ptr refrencing to the same location 
as addr, and then assign addr = NULL. But we are already assigning the 
memory location where addr was refrencing to 'channel'. Let me know if I 
am missing something ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
So now 'channel' points to the memory you allocated at the start of the
function with g_new0. When the function returns, g_autoptr has no idea
that someone is still using that memory, so it will just free it.

Whenever you want a chunk of memory to be accessed across function calls
like that you need to steal the reference. After stealing, the pointer
that was registered with g_autoptr (in this case 'addr') now points to
nothing and the pointer that was returned/assigned is a different one
that isn't known by any cleanup functions.

Note that after g_steal_pointer, that memory now becomes responsibility
of whatever piece of code owns that pointer. In this case,
qemu_start_incoming_migration() and qmp_migrate(). Those two functions
will have to free the memory once they are done with it. Or do the
g_autoptr/g_steal_pointer trick once more.</pre>
    </blockquote>
    <p>Got your point perfectly now. Thanks a lot. Just so that I
      understood right, summarising it in short:</p>
    <p>g_autoptr --&gt; helps in error paths so we use it, but for
      non-error paths if it goes out of scope, it will free it so to
      prevent that we have to use g_steal_pointer(). Either use <span style="white-space: pre-wrap">g_autoptr/g_steal_pointer pair or do it simple but then will have to take care of error paths as well as non-error paths to free the pointers.<span style="white-space: normal"></span></span></p>
    <blockquote type="cite" cite="mid:87a5srg9yo.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I think the syntax follows as the second example given here: 
<a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.gtk.org_glib_func.steal-5Fpointer.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=Fn2ZhrrsSvcV_ZUX3PUnI1zMMD7JM5o1X9LbURlU1B7O06RNnzmOS3hKI4HBe6fB&amp;s=iJFFbZnxzfqd1xu3gRVfvdjjE_X3XT3t0aRRAIeaUUc&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__docs.gtk.org_glib_func.steal-5Fpointer.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=Fn2ZhrrsSvcV_ZUX3PUnI1zMMD7JM5o1X9LbURlU1B7O06RNnzmOS3hKI4HBe6fB&amp;s=iJFFbZnxzfqd1xu3gRVfvdjjE_X3XT3t0aRRAIeaUUc&amp;e=</a>  ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yep, that's it.</pre>
    </blockquote>
    <p>Ack.</p>
    Regards,<br>
    Het Gala<span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------y50cXSoNqBcpTNFwmPy03H4F--

