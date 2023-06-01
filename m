Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428A9719621
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4e6y-0005BQ-6r; Thu, 01 Jun 2023 04:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q4e6s-0005B0-Vj
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:56:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q4e6k-0008PD-NF
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:56:42 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3512S5vO032500; Thu, 1 Jun 2023 01:56:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=bXiRc4Chg/TBqqCE3pgvt9j9+t60DT/3TbR5tPqMXWs=;
 b=prIB5LDsXIb6kYR8yobdEZAjn5e8Y3FPa80qc5HUpzbR1zmagbzlljui33ZGrcWWJ6U2
 0hPQKH4Ry73Gn63JqKXVEgSL6ea9PzDbI08wgl+MMgbwYR0br1Y4TJI9BctMmbQXELfv
 V4ZFIiKEGk861Uq0lziEyqApuvEDDfy2GgqO/Eqb4ttD01VYBROuHOWFKvVJ/ZbM+/9e
 EzKAaY5Y+NFifXe79t4/d+6gtMx8vjqLJKNU4XiIgsAlGLvWn7NBbrv9MYe2dl4M1yrw
 nTOpu1Fi8GrmBCYjWZtZrEascqmVeyuXpIfuPm+kF8Fc3yEDLcU7AfJ9wgnXjXOzmlDt 7w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qxdh9h2fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 01:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exdllirTwMxx9w4OUwwlKuCfexxRJJ7NrVmFs1pXgygCjpjeMZzpG8iKNQ36y0/fXLrSjLb3YlkzPS1EgISqv6ybRGxFGmr+J+o7vv15Dj5i9iwsy+zcdxHJd9FjZeWr3VySwsx2XzyZs1qiSNgHnxkZHu48vq4Ho3boKsEpEWNdqkPtV5H+zFv/iZLzx2eq2YaLOalii4U5Bjtm8WBlWs/lNbItniNky9fzfmJ38AGMsrbWdUd3enmHVuheeXWgNczrw0GjrUfENLRbWXEMNDPA340C8wtvWSSXByZ/yqegkRoWMsm9cDFk561mBN9H8ePfDR5yfKi4+xWufO67/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXiRc4Chg/TBqqCE3pgvt9j9+t60DT/3TbR5tPqMXWs=;
 b=j+PGseEvF7oPTCeMtxy9SZutlgUDe4gtQSIVYmQsUMfRctVeuopMi3fBIg+FFg152EK5xzXjo9Wl//FIE0r1OfLFH0rHXk9bRwk0Ju5/K5h/YjXmWQ/T64DH/aKsObNqx/a14gqcPFd3tMSpWHXiYWj2PRu+dgsuQ2RumjtihWG31U0d5egg5xMWedORfRFxCzQ0kSmlr5MkZk2sP2tjiBnrXl2cRCIXVQ4h4RVe4Y4dTFg6CM2qVu+FawY5LQY5Ha8ov267BkD2Nvv5KJDS5tPYBSleb30T5j93pSYhyXCoQ2ZLNzlukSpFUQt3OBtZ6uSWrtQuOWajI6NqUZNOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXiRc4Chg/TBqqCE3pgvt9j9+t60DT/3TbR5tPqMXWs=;
 b=rhioMj98sHMhkZujmOa6SWsGipoRVFX9VzGHAZTcg0qLsRxh1tA2SOCx2YJgB+O2vFV/EFbc+pJtbUKRd6y6X8jcQbvAma9PoYdzC021IEEqZnw/fx9iG5ZKcofWPdI3L9RE4e7eWwhTfItKCG/fwTvb14KX16f3Kbpck9TaHgmAtdKKxDq6ktgZUrSndAXIjofAi7V9LNjVIgklQ5ZCcX58x/r2RD3f1HjFuOK4enbLf5UqQ1z+dS1tsPdlqzxZA+AHyeWMj/YivrvnQHP/vfx5AfpcTGDA/UVbR1i5/kfFxeKy8rWPVdTtgo9SoLvQ3dFG2vmigo2jbH1KdqJTRA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SJ2PR02MB9772.namprd02.prod.outlook.com (2603:10b6:a03:53f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 08:56:28 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 08:56:28 +0000
Message-ID: <e60ba9ca-9802-4034-242e-ea61566db175@nutanix.com>
Date: Thu, 1 Jun 2023 14:26:15 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com> <87sfbkjow3.fsf@pond.sub.org>
 <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
 <87edmyuwzc.fsf@pond.sub.org>
 <99b3e516-2a4a-aa48-8bc2-7bb886b8db52@nutanix.com>
 <ZHXnsidOhgjs+oV2@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZHXnsidOhgjs+oV2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::25) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SJ2PR02MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdb93c0-118d-4de7-ce3e-08db627e157b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8KhC9+DimSLMJkT+SNvfqWnUj/I5nWGjnRoB9qBQXILkDAAu7C2X4UhzXzmDVUdNrwIiqPUeB/Ex1CGgHDi8psO6TAShTh1ZQwHhM5ma7N8D844RPh7MHFYnvf3bgCS9JZahQhSNeN14v+/ZDGqKJu/ivKRbc1/HY1UQfL2bWKb31TNAXCRCD9jNJnCM0eww3J36nVJhjNvoL3OfJ6mbPYbPTOM+o110t0aJsk9W/QpaME7jDjXV7AXhROBAENTpZlluPfF/XhoidIouXMzmhVaV3nC7CRrVj36vsXu+C85GDJlUmlFhphtqUUdEFbq3bSvVEzEAAfa9T23DLXTVIMphKCqq8AhxUJnuOAElAnCVoXEvuW1esGuLxnam3Ihms7vWRYgbpUIycnn7aF/43kZaLr2xt4OziSusIl3Fn8qkB6te36b3Exrubvg6fLGYHU0aZDjL3EoTv3NT6TQNfL+pNn//Q2B31uWRdfynMHbWpvg9eLjMCH5/lbxWETwciyWI0XvPDuvEZs+o+rHk+NFfOBE6/q1cOXRxDaWdEm90iedeEnbB2vmxcI4DwVW6a1Z9qRuQXvRKh/DUmDLW+L7kPh1wbw/XbeOnmJBBdYrTp1XmfpPH2rOdawK9q4dxsGWyySR2FDVmzza8+1ZQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(6666004)(6486002)(478600001)(36756003)(186003)(6506007)(53546011)(6512007)(83380400001)(2616005)(38100700002)(31696002)(86362001)(26005)(107886003)(316002)(4326008)(41300700001)(66556008)(66476007)(66946007)(44832011)(31686004)(2906002)(8676002)(5660300002)(8936002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNEVi9yQWNhMnlSNWRUSThHeEh2K25mUE5kS2ZVZU11cWFnZ3JLTHpGU1F4?=
 =?utf-8?B?dWgrK3BNbW85US80cTFwclI4TzFXQXFrWjkwTnpEeC94UEFwYVA1bmorV2I5?=
 =?utf-8?B?M05qRTE2VEU5Q2k2ZEtDNHIxbDdVVzlWSm8xQ2UzRnBBL0wzOGNDUzExTjJY?=
 =?utf-8?B?UzlBQkJMTDZJT0pMMnVRWXRvcTN4Skl4Q2dQMi9NTWVtQmRCYjNlMzJaTlp2?=
 =?utf-8?B?REhMRGZ0d3c0YVlmNEUwbTlCRkk3cTgrSjlGdTBtRTJTbGVmK1piODc3cHRq?=
 =?utf-8?B?TEpwOWNtL0UySytWN2FQMDI5MHNtV0lZb2ZibUs1TTdvMDcvaU1ESE9KYVVH?=
 =?utf-8?B?MkJDQk0xNU1UV0hUeXRlRmd3cy9xRkhpSlo1ZmZPamc0b3BEWlpFaTBjeGFq?=
 =?utf-8?B?a0p1QnFBWG82RzhFRXFweTlTVFRyTUNTWEVXNWx3cTVHQnl2ZEJ5bVp0STVt?=
 =?utf-8?B?SzRKNHVQQVRYZzd6b09sOUl5eS9tRmFIMDJRaWpHOXdlNnlReGdUemdsZmVu?=
 =?utf-8?B?S0loMTNXMDlWQzMwRDkyblNJMUZxTW9GY1FjYnQza2NkcHJrSjRxc09YaTdN?=
 =?utf-8?B?ay9FWkwxd3lPQmlZL0ZYekpsTVpkRUdRV1lmc1BaTGx1cDFOTFRtZVB5NHFK?=
 =?utf-8?B?SlB1dVdqOFJiSTFTc3kzMEx6UjBxclI3cGhFeFhiM24rK3ZtbVM0aGIvVWZS?=
 =?utf-8?B?ZlVBdEpwOGpPaTc5UThvTWNFQXpFUE5hYk5kSDcvZHQ2K093L1A1Qm8xYURk?=
 =?utf-8?B?TjlEQnZ0bGxFRWorUzhIWEcrSy9zeG05enYveEJLTEdZank2ckFoRDNhVVY4?=
 =?utf-8?B?RWdhZjNkUjlmT1FPa2NZZjNXN1NWNVhiQkc5ekxvekJOMHBjNi9obE1UWmtI?=
 =?utf-8?B?M0RZeXNBY20zNWJYbVRKT3FMckI0UEJiTHkvNWxaWXFZNkx5ckNxeFAxWFNq?=
 =?utf-8?B?cEZkL2ZYWkNjbi82Qmc3WjlPM2NRNU9PazJuSm9jbEJnTFpZcHc0R3VpdHJz?=
 =?utf-8?B?ZE5uM3htL0MzTndQWlVGWHlHZjlHanRXV2ZrYXNKaXJxWWhLZStoaC9SMVkz?=
 =?utf-8?B?QThWbzJ0R1FIeTF5OEpaVUJQUUF3Z0ZpL3BFdWRWZE4vQ0lqRWdoNm9PSGlT?=
 =?utf-8?B?bkxtZVNFTnRwRTRXUDc3VTBScXdhSllta3ZsUU9tV0FQM3hrM21ZUnFjSzJX?=
 =?utf-8?B?WWlvQ2pvZElIT2xha1Npd3RBWnc0dWNJU3l1MW5Kd1R6QWtpMms1Z0VxU0kw?=
 =?utf-8?B?Q2tZQ3pEK0J6ZGhCRlE4cG96VzVTSU4xNC9QNnVXVjU4UEU1eTZnNFY0TDJ0?=
 =?utf-8?B?Q1dONzhEZlpmUDQ5K25QcEZOdXJlK0ZZeWs0SkR3NjE5NVZ3djF4eWhQeDRY?=
 =?utf-8?B?eXVvbGNVdFVUaUR5VWE4YXVTeTMydDJpTlllZDhXaWVmclRSMTR2TFh4cU8y?=
 =?utf-8?B?Qk1pLzVZd0tZU2VuaUo0KzVxbW16QnU0WUkrOUdQMkFtSnJraEU0R0dGa3ZM?=
 =?utf-8?B?ekZoTWlWbzh3WUFUdW1Qam85a3ZDWVBFWklTcCtjR2hPblhRZTBSS3ovYUw3?=
 =?utf-8?B?cFhmZHlLK01PSGgzRy9vTElvWmFEQVBTc2l3TWhucHEzbnJUR0hFaFJiVy9M?=
 =?utf-8?B?ZFBVQnJEbVhuN29iOXdhZDg5MkpTOWpNYzJ6ZHZ3ZkxqcWpQOFJRMktkNmF5?=
 =?utf-8?B?em4way8ySFFFNjIyK0NUblVaYkZPMnRucGJaMnBtVVhGMEJOVi9XOWVWNHpP?=
 =?utf-8?B?end3alN6bW4wVlpYcWRvZlZPZGhVbEpSZkFmZnIrSG1uOGhvYitnOW1uRUxS?=
 =?utf-8?B?V3c0bEV2bjZKRU5EdnhaZEJ4TFpSWDBlZnl6Rmk0Vm1aaXN1WWovVWNpVHpB?=
 =?utf-8?B?a3BXODVrTityRUcxMHlGVGdPbWUxa05NT1B4K1pzZ1dtbi9tcUltYnhhWFpt?=
 =?utf-8?B?dzJaRXY0VUZUc1pWME1PcDBGdmt0RkNYRS9SODlwN05FZVZLVnlvbk50MlI3?=
 =?utf-8?B?SDhUTWU5bkhZeHZZVTVIN2JmdGpZRVlObGNHanhrNHVUMUNuSG1nQVpaWDlJ?=
 =?utf-8?B?WUZRWGlwNmlVOThkNmxFeklWSXVUa084Q0lLZERsNE9IR2U1d0d1dmVralN4?=
 =?utf-8?Q?egLUr4+MnKbKl+rlX7ZmQYpBv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdb93c0-118d-4de7-ce3e-08db627e157b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 08:56:27.4788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QazlrCcsTEqLqpWsDZAyGw899X5CfKPmn6Cr9VrEGQDT0oK3UHBFrUPc0wHKvJ157k1fN+KbzzH7JieI3DqYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9772
X-Proofpoint-ORIG-GUID: BgFyCUGe-oGPZOusRZ_OJOLPhzEagRGO
X-Proofpoint-GUID: BgFyCUGe-oGPZOusRZ_OJOLPhzEagRGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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


On 30/05/23 5:40 pm, Daniel P. Berrangé wrote:
> On Tue, May 30, 2023 at 01:02:27PM +0530, Het Gala wrote:
>> On 30/05/23 12:28 pm, Markus Armbruster wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>
[...]
>>>>>> +##
>>>>>> +{ 'enum': 'MigrateTransport',
>>>>>> +  'data': ['socket', 'exec', 'rdma'] }
>>>>>> +
>>>>>> +##
>>>>>> +# @MigrateExecCommand:
>>>>> Documentation of @args is missing.
>>>> Ack. Should the naming '@args' be replaced by '@filepath' or @path' or something similar ?
>>> Depends on what @args means.
>>>
>>> I guess its [program, arg1, arg2, ...].
> Yes, that is correct. Essentially this ends up calling
>
>     execve(@args[0], @args)
>
>>> You could split off the program:
>>>
>>>       'program: 'str',
>>>       'args': [ 'str' ]
> Now you also have to declare whether '@args' includes or excludes
> 'program' as @args[0]. execve() style would be to have '@args[0]'
> duplicate 'program'. Personally I think that's overkill for QEMU's
> needs. If we don't include 'program' in @args, then we have to
> document this, as it isn't discoverable from the QAPI design.
>
> Not separating 'program' and 'args' in QAPI makes it unambiguous
> that 'args' must include everything.
Yes, we need to make user aware of args[0], so keeping it @args along 
with adding a note that @args[0] - path to the new program ? is the best 
alternative here ? - Markus, Daniel
>>> Try to write clear documentation for both alternatives.  Such an
>>> exercise tends to lead me to the one I prefer.
>> Hmm, basically here the @args means, for example ['/bin/bash', args1, args2,
>> ..., <command>], where command -> /some/file/path.
>>
>> Does it even make sense now to break into 3 different parts ?
>>
>> 	'program': 'str'
>> 	'args': [ 'str' ]
>> 	'command': 'str'
> Definitely not. This encodes an assumption that we're spawning via a
> shell. The intent with the new design is that it lets mgmt apps fully
> eliminate use of shell, and directly invoke the program, thus eliminating
> potential (security) pitfalls with shell metacharacters.
Got your point Daniel. Thanks.
> With regards,
> Daniel
Regards,
Het Gala

