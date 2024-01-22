Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFB5835933
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 03:01:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRjbQ-0000m8-1D; Sun, 21 Jan 2024 20:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1751e82f17=kai.kang@windriver.com>)
 id 1rRjb8-0000lj-LY
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 20:59:40 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1751e82f17=kai.kang@windriver.com>)
 id 1rRjb4-0008B3-V4
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 20:59:37 -0500
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40M1vYqW026195; Sun, 21 Jan 2024 17:59:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=g/OR29WMDK5GQd8Bmt+K9PVObwE++mtca3iK8hrWqD0=; b=
 Cbj5XS85Wc5Cr+o1f/zH9xqFsQAvlkWFCxq0ULDrB+OgyGr2hxXmh8+QsKVI48jf
 a/jEnXDpmKf6K6T/t09EBGLK/GtI6inLlKo8cU6p/sLzpelxTXRBimo0OucSPKQ/
 jVl3Xf38hBrmnTciD/w7gX6EkMkAuHbSgGemBmwaQcOb+6YlIf15umzWJdvFm3gt
 Rt1LZ5GfDAy7NxZIJteXqmpI36idPbk9izPNdQvm/gZT12JXweINGsvJlyjvQ+DL
 OqJf8Jdr90g7/nVmLpd3RAdZFdBvV4GDaHf+dOvtFefwqhQUBmBBGBTIhnqfBIrN
 Uz+i/NRkMFcuiST6bnC4AQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vrab4s7te-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 21 Jan 2024 17:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieGz71Wf4F/4Un8bJAlDBxhPdKOxWJJixbcKwyX4EQUoNQwcgZpwE/Zj7NhxOPUdgefZlEeJWIb5Vr42U4P0LajtGAaVnFmGIEb0MwWgXl2pnpR7RCPoyjSOHZpYGs5JLNkAx6+UkidPnVpkreLwR/tSMDorUYYfhKBkXnXEsUXxiR3HebX6dKtrICJ1u2fLlLKqNfDdvVTm/i+KHCBCVsIKw5bsox9C5RWITHeZvhkF5JWfG6EYyRE8LIETIKWwKx0wELQ7Iip6h9mKHIG4x+ix0zUkKQiUIGQygmCXoGAo0wr3UgVR36llLxXCLSxbVC4YMmCHzzbLIj5GtEqCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/OR29WMDK5GQd8Bmt+K9PVObwE++mtca3iK8hrWqD0=;
 b=O2IYvmxTLVST9QLDH9sgXp6kpDyqYg7g3yRx5i/+zx/xsFkhvmqJsUfajgaLLcrLxrnw6imwUEccxeHxDhG/YIu+WDMaXcZnD/PUKwIvuGraRsyJrGIcgRUgkJUsih+/+aC9njJAOUbuI51zH1TsZuiN9Kz//qSuXdEDZ6xtb/BGGUy3Hq8re0ChsxkhvbbXyXkv7aQHN5XVgeeSHkItCtmTvX3YGhUUIGmqvyGVjLA17yyifgPXViEQZFPd5BcBQ6CPy2CwIIhXZ6eExNZeqMs5Vnac+wLCbqwGhCAwF42S5GN24vuX6hlTxUlqn5ZmW0+eFAqegcF7LJomPR1D8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) by
 DM4PR11MB5517.namprd11.prod.outlook.com (2603:10b6:5:388::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.31; Mon, 22 Jan 2024 01:59:12 +0000
Received: from DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::dca9:26e2:b46:2372]) by DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::dca9:26e2:b46:2372%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 01:59:12 +0000
Message-ID: <d9f93bd0-7cf5-4d3b-82b5-349a10ed6862@windriver.com>
Date: Mon, 22 Jan 2024 09:59:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] qdev: not add devices to bus in reverse order
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, mst@redhat.com
References: <20240109092015.4136865-1-kai.kang@windriver.com>
 <CAFEAcA9LBXMxOzJwmXYEVj+q0hTzMQZrpZHOOKFYWZDKXFyHig@mail.gmail.com>
 <1db86e7c-9d4a-6c7d-9e6b-52054b2382cd@windriver.com>
 <20240118130730.02ff9194@imammedo.users.ipa.redhat.com>
From: Kai <kai.kang@windriver.com>
In-Reply-To: <20240118130730.02ff9194@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To DS7PR11MB6064.namprd11.prod.outlook.com
 (2603:10b6:8:77::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6064:EE_|DM4PR11MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b3c7dc-2f89-4693-7498-08dc1aedba8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNs+qIcsSSs72xZUglxWcyHmNQhTY+RF+Ly88ULx1jbVpOKvgEPqGygT91aPzdlcoSCp05rP8t2KpTR8cuYzmX9f++T/TYhvcNpBKCfKB1OZtnqPtOAr/ihldd4llBPzFxb+I09SpS3Jm/NSEndC3T1g1pN4ZKLsOPR0SwEtju5PGGfG4eMT9fxNHfyNtgljhOSrWTYZIRsX6nMpX1evPFk4C707ry5NCDKiuhLuW2dgumLiF1TNIjEABtHgYLf7/88CDl2slr5wY8MK3w5Ap4uSdzCWzD9N7Yfdpzz3oYO631rQrl2X4IFDnlM7YZgbC4C5M7HqjVrq764DXD40bDWRV2+BsAcdoryx+H/J+xh/VXgB/Tl3CThWbGAQjaOQICzVCATiU7+KxQDsKEA59PlWQxzZmin5AHoC8rZMWPeKBlGwVVHBzo4UT+HV5JUnDqiCaPDukRYDm9gCHt+zKYWZfbiVkDY0yCeT5lQZh+ORz0iASNBe7mQ1HpL7x83+nLdV7L73hqwPMT21lDCfMK8Zj1Dxk357m+m8fmYeCOUU7FazhFazkVKPGmMcnm1SSJ93ClKsDoQrI1f72OsVUjCnTd7VN6LwN22fQNgyC+U81scedSDfk2BpasaZUk//tNtYRRCvnUgL92xuSXSKwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB6064.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39840400004)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6666004)(53546011)(6512007)(2616005)(26005)(6506007)(86362001)(31696002)(38100700002)(41300700001)(83380400001)(5660300002)(478600001)(2906002)(8676002)(8936002)(66476007)(66556008)(6486002)(4326008)(66946007)(36756003)(316002)(54906003)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdCbDNxYlhKVVc0M3FJckZFVXRZdXR5aC81OE9yN0dRcFBDYUMxMitDZzc3?=
 =?utf-8?B?RllEV0R6MmVJdWQ4MFN6L25nY0dodHhVbk9lZDZLZGtWZUNTT3NKbmdQVEQ0?=
 =?utf-8?B?YWh6OWZ1WTZpaE05d0p6Z09mdUF0c0llN1RSUXVDRVdVbjhxNFNvcTBhemha?=
 =?utf-8?B?RGtHOGhlYm9CQXpnM0RvTUNnY0FwdGhPc21iVjRSMUJQaGtudUhYR0sxdDVK?=
 =?utf-8?B?UW5yd2thMmVRbGpjb09xd3cvR1JOOXlEb0VzSElVTXNXQ2JmZWtCVHlVYVha?=
 =?utf-8?B?TmJ6emx1bkZWcmZubFBkSGRYbklIeHFiN0pRS1pYdEgxZERmVnVxWjhkTmE1?=
 =?utf-8?B?QXBPUEZ0NGtzVElxTnlLWWhjZURRdEdRckRJQWxhQzY5SGJSZ0lSempGOE5t?=
 =?utf-8?B?NWgyN1cvM3BscmdvSEtXNTFndERjZUxlOTlUdk04RG8zNE5hMGg5am9ZWE5m?=
 =?utf-8?B?QytHVGJEdnF5QjhvREJjRGFzVndKenZYdldvM1BJTHBBQzl2Rml0MlZ5ckVL?=
 =?utf-8?B?dGJzb2IwckU2NSsrdjduRzBmcVhXSTQ3ZFlrTXd6TUZBOFdGMWZndzhOU1dH?=
 =?utf-8?B?MmZVTzhqbUVyTGZqS2Zzc1JBdCtKZk4vWEgrVWxWeGZBRWpudXJaYTQrVEdV?=
 =?utf-8?B?Q2cxRUpzSnNpdGEyRXp0NTBxOGpmcU05aGdtdXJuWEJiQjNJODQ2c1NvSlBm?=
 =?utf-8?B?dlFzaXpmS2pyMEJMZlQyNTRXbExMbzZ2SSs2Wlc0SHZkQ0kwUmNlYXUwQ1BI?=
 =?utf-8?B?Q0xVbjcxRlBSdEN4R2xFNnprYm5UdDBDM1lSRlliY0Y0MEY2S1RWb3ZvdVB0?=
 =?utf-8?B?RWhzandZMXRURU1wMGR0Rm1GMUlSamNjTUs5M3RudHhUdWQydzF6WlVhZzRV?=
 =?utf-8?B?MnkrVmVCME1KN1l2emVqRlhweEoxRWhkSEtJVzNPdHpQa0Rnb21FVzZWOXdQ?=
 =?utf-8?B?NzgwcGEreHExWWcvbmhUeHUvMzRYYmllMlAzYjh5S2FWc1hlbUp0WUtsVGxy?=
 =?utf-8?B?SjRyQTdheFZWTTR3WnJjZHErMTJXMFExMFlCKzZLakpDclRrZUdsZkF5dTBz?=
 =?utf-8?B?T0J4Z0pKSm9tZStDSXF0UEpHZVRjcHorakdra2VTTUhQbGRXWG55OHF6Qmtv?=
 =?utf-8?B?NUVyeDhJZElTbHVZeVROOEZCQlFQbnZNelhZdkg5K1FYMkRYQko1NlBhWjhl?=
 =?utf-8?B?dTlpMnJ2WjBZbGozNFBCTlp3ZGxtV1JmNFIreFAvK3YzZGV1THJ6UmJFeUdT?=
 =?utf-8?B?bWRXaVQySXdjNEJvTllCVlhJcFlMY0luTC9nTW9mMWhZMnRSNy9GM1FMcFhj?=
 =?utf-8?B?RzlFZXN4K0RuTVN4dVJwOVpWK3FCQVJJQnFaOHR2QnV1NERjUFY0TzFlZ1Qz?=
 =?utf-8?B?V2w1RWl0eWgrMXg5N1dwekFYZ3QvbFIwcnY3SGtKOVVLZ2dwRW1OWnZwZ0RG?=
 =?utf-8?B?TXczRnRia2pxM0ZVdEQ2bEFGcmo1S1Q5QU1kd2RDTzZySnppT2VIM3RtM1RB?=
 =?utf-8?B?cjliVktzZjg4RFFCTmdMWXh6WkJVVXFlbGJIV1hUclZYMUQ0Q0Jpb2gwanY4?=
 =?utf-8?B?blNOSXlpMHFpYVRpb29HVU0yTnFsY1hqdWcwcWFEc2hiRGZSdkQxOHJFcWNF?=
 =?utf-8?B?dmJFUmJGRzY4ZEIwOWxqLzRHekV3K1ptdGt2aldkei9CVW1VUnd0MnVKTUNx?=
 =?utf-8?B?V0x0QVc3eHBSZkc4QUNlM3U3WXpZMjdaQmFSSlEwVzZkWnIrREhRalV3VXo0?=
 =?utf-8?B?M1pGdjdFSGF2aUpCVW9tTERKbEFVNy9UazByaXJPT3lDTlUySmsrTUJqTG50?=
 =?utf-8?B?azlLaFAwSko5ZHhjRU5raUdYeElJTWJRMDM2Qkw2MlhuM0RiaG9laGpQUDdB?=
 =?utf-8?B?UTN4cjRuZWZUUEdHVk9jQkNzclJwUWk1ZzVXK2cvaVlSNVNJcFFleWhNL1A1?=
 =?utf-8?B?NVBKVXRrMGlXcnhScCt0bDNCdkttMGxUcGtyOGtHTnZNWnFYZDNUbDMwRnF5?=
 =?utf-8?B?QmszM0lFb2ljWWNTT2UrcGxpQ002SU9kSS9mQ3ZkU0Zmbm5jUjF0TE5NK0VH?=
 =?utf-8?B?aW9QMnNUcCtxZGU0L3U5MitwaUNtVmRqTU1LdmFhaW5RTkswOEx1VUNWbUox?=
 =?utf-8?Q?S++4zBXk8839EDavBBLFO3eHO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b3c7dc-2f89-4693-7498-08dc1aedba8c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 01:59:11.9944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UtGLPAKprGQDVQBJSBUQ/MbwmZf7wSFBVRYgL065CTSDOj3JYpO377egWz4dtOz2ELuFle92PNbXW9GPSNRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5517
X-Proofpoint-ORIG-GUID: K7qOGD9wMM3mlGIy4Tj5juSKgIc2mknA
X-Proofpoint-GUID: K7qOGD9wMM3mlGIy4Tj5juSKgIc2mknA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220013
Received-SPF: pass client-ip=205.220.166.238;
 envelope-from=prvs=1751e82f17=kai.kang@windriver.com;
 helo=mx0a-0064b401.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.72,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/18/24 20:07, Igor Mammedov wrote:
> On Thu, 18 Jan 2024 14:48:50 +0800
> Kai <kai.kang@windriver.com> wrote:
>
>> On 1/18/24 01:31, Peter Maydell wrote:
>>> (cc'd the people listed for this file in MAINTAINERS)
>>>
>>> On Tue, 9 Jan 2024 at 13:53, Kai Kang <kai.kang@windriver.com> wrote:
>>>> When this section of source codes were added via commit:
>>>>
>>>> * 02e2da45c4 Add common BusState
>>>>
>>>> it added devices to bus with LIST_INSERT_HEAD() which operated on the
>>>> single direction list. It didn't have something like LIST_INSERT_TAIL()
>>>> at that time and kept that way when turned to QTAILQ.
>>>>
>>>> Then it causes the fist device in qemu command line inserted at the end
>>>> of the bus child link list. And when realize them, the first device will
>>>> be the last one to be realized.
>>>>
>>>> Replace QTAILQ_INSERT_HEAD_RCU() with QTAILQ_INSERT_TAIL_RCU() to make
>>>> sure that devices are added to bus with the sequence in the command
>>>> line.
>>> What are the problems being caused by the the list items being added
>>> in reverse order? Your commit message doesn't say what specific
>>> bug or problem it's trying to fix.
>> The problem I met was just as I asked for for help in the maillist on
>> Dec 18, 2023.
>>
>> The indexes of serial isa devices changes with the commit dcdbfaafe90a
>> since qemu 6.2.0.
>> Before the commit, it creates devices literally with "1" & "2":
>>
>> @@ -1252,8 +1222,6 @@ static void build_isa_devices_aml(Aml *table)
>>            aml_append(scope, build_fdc_device_aml(fdc));
>>        }
>>        aml_append(scope, build_lpt_device_aml());
>> -    build_com_device_aml(scope, 1);
>> -    build_com_device_aml(scope, 2);
>>
>> After apply the commit, it uses the 'aml builder' way and the devices
>> are handled in reverse way.
>> Then the indexes are reversed. It affects guest os such as freebsd. When
>> run `pstat -t` on freebsd
>> with qemu, the sequence of the output is not right.
>>
>> root@freebsd:~ # pstat -t
>>         LINE   INQ  CAN  LIN  LOW  OUTQ  USE  LOW   COL  SESS  PGID STATE
>>        ttyu2     0    0    0    0     0    0    0     0     0     0 IC
>>        ttyu3     0    0    0    0     0    0    0     0     0     0 IC
>>        ttyu1     0    0    0    0     0    0    0     0     0     0 IC
>>        ttyu0  1920    0    0  192  1984    0  199     0   664   668 ICOi
>>
>> It is expected with ascend order which keeps the same behavior with
>> older version qemu.

Hi Peter & Igor,

Thanks for your reply.

> this problem description should be in commit message.

Will do next time.


> As for fixing it I'd wouldn't touch bus order as Peter already noted
> it has high chances to break behavior elsewhere.
>
> current state of COM naming:
>     1: QEMU 6.1  all machine types: COM1 { uid: 1, irq: 4}, COM2 { uid: 2, irq: 3}
>     2: QEMU 6.2+ all machine types: COM1 { uid: 2, irq: 4}, COM1 { uid: 1, irq: 3}
> all of above in default case where user doesn't supply 'index' explicitly.
>
> With 'index' provided explicitly old case #1 might break due to
> hardcoded resource values in former build_com_device_aml().
> #2 (current code) doesn't have issues with resource values
> when explicit 'index' is used (which can be a possible workaround)

How to assign explicit 'index' in the command line? I don't figure it 
out the option for it.


>
> So we essentially have changed enumeration for 6.1 and older
> machine types in incompatible way with QEMU-6.2+ builds.
> (and that in it's turn breaks exiting VM config when it
> is started on QEMU-6.2+)
>
> Kai,
> Does above sum-up the issue you are encountering?

Yes, it does.

Thanks,
Kai

>
>> Regards,
>> Kai
>>
>>> In general this kind of patch is something I'm very cautious about,
>>> because it seems very likely that various bits of the code where
>>> order does matter will currently be expecting (and working around)
>>> the reverse-order behaviour, because that's what has been done by
>>> bus_add_child() for the last 20-plus years. (As one concrete example,
>>> see the big comment at the top of create_virtio_devices() in
>>> hw/arm/virt.c. There are probably others where we didn't comment
>>> on the ordering but just assume it.)
>>>   
>>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>>> index 43d863b0c5..5e2ff43715 100644
>>>> --- a/hw/core/qdev.c
>>>> +++ b/hw/core/qdev.c
>>>> @@ -89,7 +89,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
>>>>        kid->child = child;
>>>>        object_ref(OBJECT(kid->child));
>>>>
>>>> -    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
>>>> +    QTAILQ_INSERT_TAIL_RCU(&bus->children, kid, sibling);
>>>>
>>>>        /* This transfers ownership of kid->child to the property.  */
>>>>        snprintf(name, sizeof(name), "child[%d]", kid->index);
>>> thanks
>>> -- PMM
>>

-- 
Kai Kang
Wind River Linux


