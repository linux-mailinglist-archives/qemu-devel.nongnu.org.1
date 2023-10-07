Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7E57BC796
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6YJ-00016J-9Y; Sat, 07 Oct 2023 08:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qp6YG-0000vx-UM
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:37:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qp6YE-0002Yc-MS
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:37:00 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 397Bre7l003445; Sat, 7 Oct 2023 05:36:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=DlpWeKimusfN
 ZbuB4VYeu3GPXpSAfOLuYX74YIwlPFs=; b=kJJKtZp2ojTzImnMLUrs3lABRPVv
 jf7ov3KfXNNj08HU8AkS6AJ0nYrN7/cRyi8ecOMSJ6XB1yfL0vwhW3lHxit7RAL1
 bSpGwm7niAucYXb8cu4WZsEWtX4k8LQNdsQ1qMD1nvlrSxkqRVqCg25242GmICZ4
 9G3BxwnQrxMH2ciKbInD7ojGOrUc8CczMmuCtvrGDMPElyLrV7i74fLIs8GXNLP4
 BkmGqq7JKt4YKXVzrT+3bbEn6iF7hlIHiJNiTp35UTYkZYW2r2lO5rkpSKkNB/5n
 Lv+Dgj6dkG5+Jlcm17iPrPXgF+TVejt9VF6B59x5dQJPDdYKJ2kS8YNjLw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tk6uxr1h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Oct 2023 05:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXYDpLgdcnvJEZT5knMNpDh6NaYQnGrzp1Xl4sVrZcKJcRF0j3CPtvfQxEO4qOrJsp7KK0jD0F8E/A2qLurq0PTv4ZBwMW1gw+M+Te+sVUi/pI+oc9Tt75aujw1fceayYc5rZd1CeEGYkXjY0goOe8n1IyrrWNy8QW14/GJUiX9Iy3D6wL604bp24A+Ybn2y3uhluYcN46jNkeoge7eVFbqrOGmkVNkNSf47Ad8Jwt6NuP7UUqkUem3B8pprsHSyEeGAzyFzjVAiqg/DwMuQe9ijd1l3i95dge13wIDhSe3ks0oWppZE4LwVnye6zMDdY5obDnMKGmruTu9HkMFkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlpWeKimusfNZbuB4VYeu3GPXpSAfOLuYX74YIwlPFs=;
 b=Nj+dDk4rHPBpJKO4av+gLtJPXB6CGeE1JP3Q8t8SIVOyV7ZBm4KQOuoM8iipFCykcTnwD8EXK41NDsjsG3JuFdXjmMuxRRGl6dWpL6QTZjo8xGoyMcETsYoY6FPIVHxVPq28Sry3CdC9B/st0txHK0Vv4jAluFU84sbwNcJX+Y+pJnqDumI2wl2XyyHM2r9A/1gXPLglPPZGwP8wA5htX8xdUrFICOEjnR1NJovk339EN4la7pq6Aa7+a82ek4rVsE8qZX+2pP5WSzFgCjNbnHpb92uSttY6LBcASpR0srBMap42b2eVzrwmMes/X9FUy2+/dkC0v058J4qQMxqD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlpWeKimusfNZbuB4VYeu3GPXpSAfOLuYX74YIwlPFs=;
 b=e/zumfoH778ICpYdlYpXEzPKMcjekbessuShMdgDpwRdMLYjPfBK3x6AoApFjp2x1D2XajhryKsS/i77QWTu1CWcbpIXV6rstkreahNpkX1r6b6XVd6uDmXN3mWHk1VqR32UBuJmVzgl5kAAexGoUdph6bgjgUM3m8Zry2MdcCfVIRmPfbBYF4znZmu79C5uGvGzYGyaAh54kBcHvxEPTcVDm809wOU0ZJTyEvImENkMooGfKlCfOkrupJ/fm/0dYTwcbTlOq/eqsm4ckccMuhlS+QgYgus3h/NcHq8mIAe2wpW0K//m52bhCVYf5NHsc40RXkXxZjBH7VGkXhcAZQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA3PR02MB9994.namprd02.prod.outlook.com (2603:10b6:806:37e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Sat, 7 Oct
 2023 12:36:50 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.039; Sat, 7 Oct 2023
 12:36:49 +0000
Content-Type: multipart/alternative;
 boundary="------------n7JAdFySzAzi87sVhsQQKFhA"
Message-ID: <d6734494-ecc3-4eba-9920-0ba12d6b1a69@nutanix.com>
Date: Sat, 7 Oct 2023 18:06:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/10] migration: convert exec backend to accept
 MigrateAddress.
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-6-het.gala@nutanix.com> <87h6n6phcs.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87h6n6phcs.fsf@suse.de>
X-ClientProxiedBy: BY5PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::47) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA3PR02MB9994:EE_
X-MS-Office365-Filtering-Correlation-Id: cb55efd8-5001-43b2-bdbe-08dbc7321315
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dB2meLbcKTnhzpv8mfOJhesEhtt0RNr2lyib+MvyDKOkU/ZQ1N761+BfSB6tZapS8Sb6JRFTMoHD3ni62E3Qm4GOkQeres7EHZniawT2kOWM5cRT1EMOZZ7bywYmppDVM7v53kLqkmzRZBItMutQ20ol/2IP+8o5ckHenOskReqpjlrUhqx67/5hV+tdl6D4v+bDavtrdZgmT6fds1Xkomtm3LVYUDXTNTZitqeDnxKDyzURLF0Cfronpd2nkYQPCsBOuTjq07WLAdHCKgi74nuizMDt4Y13boWBtIvg07sqrjaEvQ38UcBph6edK544aTByP49F+PAWGIfgXnA2WEbyLma2RFJ6rB4vYJJvjzjkYy6KMveZHcHFZoiPara9OUbZZ5SbnFChgl82ZO7IUL/xz++doKTQ6JILUqMS+1RWfgYh0CouE9AxclzL/vkEcGnIGUkQ0qq9PvHhP0aEscxlPEU5djHSl9d7k2or62s7irVclIK1D4/yPBXZhSGyjxf16jeKGE6PlC1ZPy4DwFZ2oL2Z8JMvbV3Ug9VTOG9d5ntNVzsAGt7njKrxuOmnNaY5tn5HDogeI+2x9fu/G+3H5FwHdVDjMztQg9FZl5VXPlFSd6rmwZRFxjusi815pYiBIHg2oOEQLPcNwdBvotAbIpJTU8YmVsuOxdU7E70=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(230922051799003)(451199024)(1800799009)(186009)(83380400001)(107886003)(2616005)(26005)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(5660300002)(44832011)(6506007)(33964004)(53546011)(6512007)(2906002)(6486002)(508600001)(36756003)(38100700002)(31696002)(86362001)(31686004)(218753002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUh2d3l3ZHZSQU1GQjR5UkVkS3lJL0Nod1NKZ2FGSWNUNFl6Q3RFOXpVczZY?=
 =?utf-8?B?SklvM2RGNnV5T2EvcGFnbzBob2dCcldnN2s2SnM1UWtPU2d0WTAvVjhQY0Nq?=
 =?utf-8?B?a3JpOXAvQ3pOSmZrekRBNW1tQ1RQdnhoeGRqNjJxOG9xQ3dkcE5PWEthNEti?=
 =?utf-8?B?UnZ4Y25zMHdyWmRHbTNXL2M3WUNqZ0ZrbmtWL0cvblZuNEx1QnNKNTY5NGlM?=
 =?utf-8?B?TVJmT0VXd1gxQnFyQTBYUkJrSGRjQlpxOE9CY2xNemNURmtBWWlIaHllU0hV?=
 =?utf-8?B?NUQ5d2wyQzl5Z0V5bU0yRGNzZ2JBTnFld3UrSWE4clJaYUhJNTIwbkFzTUtw?=
 =?utf-8?B?ZEpFeU95MytLNEtvQldwTmRpN2NqbjY0bGt4WDY2dC9sbU9nMHlqMEVTeGx3?=
 =?utf-8?B?VCtsZ0VhQzhKeG9jOHNCdndDQlNaUkpmZGV3eEpZcVBDWXZ4cUF5K1k5NVZI?=
 =?utf-8?B?akZhM0krQmtQRTdNWHYvNmdsSlNJbi9saEk5VFZWY0VIYXZmZ0RsWXE5M3I2?=
 =?utf-8?B?UURCRGdjLzN4ejVqZis1WmFxYUlsNDloZ1U0L3BXNlFpelViS3BTM3lVODY0?=
 =?utf-8?B?QlEzNXVsdDVwSENPbmdlNnFGOFg0c1NScFZUdFpwaTJFTGttUDVRMVpHS1I2?=
 =?utf-8?B?S2FXTTdIaDZWZEZyZzkxSXFvUXdTb3dlSFlNdE9FSm0xTFFGM0ZJU2ZFNExs?=
 =?utf-8?B?bUVMakxqeDZJUkFZeUV1OFRuY2U3SGtWZ2xMaUd0UFVZMVVtTVh6Ti9YT1pL?=
 =?utf-8?B?ZlhHbUdyRHBWdFNNVXdsRWVZdmpOOVkyUE9UMndQODd5dHp5by93MzN3RWxx?=
 =?utf-8?B?VmlWbkQwSkVEMUs4WTZEdVhSb1lvZ0FzVkhWZlJRVVY1cEFjSWVxaGdEblBY?=
 =?utf-8?B?bVhDSkwzWm9WcHY4bmllamxIVWhleGtycEwzNDQrNFRpdjYyV2tMYkZBTUlV?=
 =?utf-8?B?VUZTdk9PZytZLzIrd0FWYTJnWFlJNzhycEtudjJvVjA0TjFBMXlmdlJFRUVk?=
 =?utf-8?B?cWlYbDhHR2JUVGRlN0RnenNsdDAwcmZNaWJpNDRIV1lHcVZFRnY3a003TnNt?=
 =?utf-8?B?Wi9DWUYxaE01N3lOOXNyNGVkQk5ZWnRHTFlPZHVieTAxUWt3NU5UdDVHUWZ1?=
 =?utf-8?B?ZDZGWEY4UUdkZDZLUnBKWGNjZFFHaDhBWmRWRlhudzlYeHIydkVDOE1mOEZ0?=
 =?utf-8?B?dy9vSHdjbHU2eUpxUEt5Q0hwZnh0eHhMbXRZcGZBVG5scGdHVnhJa2YweEsy?=
 =?utf-8?B?S29YTHBRYkt0bTNTQkJxaHVsMldyVGdmeFRVcnJaRHdZN3p4WjJrclkxNDlU?=
 =?utf-8?B?ZXQ1L0RCQ1lDcklxSm1MTVRhWkczUHNTRkE0M0Q0RnhPZk9Mbzh1L3JheDJC?=
 =?utf-8?B?VGFQWGg0eTQxTEdoUTBmVndpaEV5cndoYUkyenczNlNpT2RsM1ZiamlnY0RM?=
 =?utf-8?B?ZTBoNHVVclRtQTZQbUk0RHdXYklVNEhQYWNHTk9wd1EwbEEyUVp4S1JHWW1L?=
 =?utf-8?B?MjE3VEFnQ1FCWjNFbUh3SWpTN3ZnQ0NnOXpESkFMNUlVaVA5NU45MFVacUda?=
 =?utf-8?B?RlJFbFBoNHRVQm9kNU80dTluZWZ5TUpFSnJhNXBabDE5UnpKMEU3ZXRMbmNa?=
 =?utf-8?B?bjhyWGVKbitIOGVtbVgxbVdxNm5RblQzaVFSbU5zWnB4Q3VaRTB0dENrWXBx?=
 =?utf-8?B?c2NIWGVma29BdXZJTTVVTFp2cGxuNGJMYlhCM0Z5ckxCSGtYYll2Q3NHZjRp?=
 =?utf-8?B?VEl5c0RYSmNEVXkyc1haOXhRb0tENnRPVUFURENzbEJ3UGVieFllcHV0b3pq?=
 =?utf-8?B?MmlRN1VmZ2V3Q1FEeFhZSjdYNDJYQVd4WngwY3NpZW5OZGsreVAyeUtaa3VU?=
 =?utf-8?B?dGM0eTBJUFZhMTFCSDR0U0ZlSkxmWGVzeC9mRTY2eUpBOGRwQ0d0dnBGRVFQ?=
 =?utf-8?B?UHBUWTVIQVo0MnQ3SGtZeFRIRy9nN0p5eS9WYk9HWnorZ1VxcnRKeHVJOHZI?=
 =?utf-8?B?Uk1zTmswMENrSDVldVdYQURZcWVqcEQ2SkxNZ216bHhDTCtVenFiTFoyNnFF?=
 =?utf-8?B?ZlRaWkNMU25TVEhQVmRHdFRzWHNQN2hQdmNTaklVeVVTUlh6RWtQN1hPajdG?=
 =?utf-8?Q?pzTSryUMh7MAvoWx/UPjdmUFt?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb55efd8-5001-43b2-bdbe-08dbc7321315
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 12:36:48.6931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDMIIJ0PM3gM76gqHnWGkqQlrwHduYjjm32t+clSJUbFvMtIgeonwXZdovwTLi+xCQs3TfU8YJm7BankhilSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9994
X-Proofpoint-ORIG-GUID: Sravmgx8TeL57Lp9rRlSI7bhRbT6KYlm
X-Proofpoint-GUID: Sravmgx8TeL57Lp9rRlSI7bhRbT6KYlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_10,2023-10-06_01,2023-05-22_02
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

--------------n7JAdFySzAzi87sVhsQQKFhA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/2023 8:25 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
>> new wire protocol of MigrateAddress struct.
>>
>> It is achived by parsing 'uri' string and storing migration parameters
>> required for exec connection into strList struct.
>>
>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>> ---
>>   migration/exec.c      | 71 +++++++++++++++++++++++++++++++------------
>>   migration/exec.h      |  4 +--
>>   migration/migration.c | 10 +++---
>>   3 files changed, 57 insertions(+), 28 deletions(-)
>>
>> -void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
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
>> +static void
>> +init_exec_array(strList *command, char **argv, Error **errp)
>> +{
>> +    int i = 0;
>> +    strList *lst;
>> +
>> +    for (lst = command; lst; lst = lst->next) {
>> +        argv[i++] = lst->value;
>> +    }
>> +
>> +    argv[i] = NULL;
> This will write out of bounds.
Yes, will increase the length of argv in exec_start_outgoing_migration() 
by one, that would solve the issue right.
>> +    return;
>> +}
>> +
>> +void exec_start_outgoing_migration(MigrationState *s, strList *command,
>> +                                   Error **errp)
>>   {
>>       QIOChannel *ioc;
>>   
>> -#ifdef WIN32
>> -    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
>> -#else
>> -    const char *argv[] = { "/bin/sh", "-c", command, NULL };
>> -#endif
>> +    int length = str_list_length(command);
>> +    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
> This allocation does not leave space for the NULL byte.

Yes you are rigght. I assumed the user will itself have to end the list 
of argument with a 'NULL', but that's not correct. Thanks for pointing 
it out. Will make the length of argv from length -> length+1.

>>   
>> -    trace_migration_exec_outgoing(command);
>> -    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
>> -                                                    O_RDWR,
>> -                                                    errp));
>> +    init_exec_array(command, argv, errp);
>> +    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
>> +
>> +    trace_migration_exec_outgoing(new_command);
>> +    ioc = QIO_CHANNEL(
>> +        qio_channel_command_new_spawn((const char * const *) argv,
>> +                                      O_RDWR,
>> +                                      errp));
>>       if (!ioc) {
>>           return;
>>       }
>> @@ -71,20 +101,21 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
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
>> +    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
> Here as well.
Ack, will increase length of argv by one while initalization.
Regards,
Het Gala
--------------n7JAdFySzAzi87sVhsQQKFhA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 10/4/2023 8:25 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87h6n6phcs.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for exec connection into strList struct.

Suggested-by: Aravind Retnakaran <a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Daniel P. Berrangé <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
---
 migration/exec.c      | 71 +++++++++++++++++++++++++++++++------------
 migration/exec.h      |  4 +--
 migration/migration.c | 10 +++---
 3 files changed, 57 insertions(+), 28 deletions(-)

-void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
+/* provides the length of strList */
+static int
+str_list_length(strList *list)
+{
+    int len = 0;
+    strList *elem;
+
+    for (elem = list; elem != NULL; elem = elem-&gt;next) {
+        len++;
+    }
+
+    return len;
+}
+
+static void
+init_exec_array(strList *command, char **argv, Error **errp)
+{
+    int i = 0;
+    strList *lst;
+
+    for (lst = command; lst; lst = lst-&gt;next) {
+        argv[i++] = lst-&gt;value;
+    }
+
+    argv[i] = NULL;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This will write out of bounds. </pre>
    </blockquote>
    Yes, will increase the length of argv in <span style="white-space: pre-wrap">exec_start_outgoing_migration() by one, that would solve the issue right. </span>
    <blockquote type="cite" cite="mid:87h6n6phcs.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    return;
+}
+
+void exec_start_outgoing_migration(MigrationState *s, strList *command,
+                                   Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), &quot;/c&quot;, command, NULL };
-#else
-    const char *argv[] = { &quot;/bin/sh&quot;, &quot;-c&quot;, command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This allocation does not leave space for the NULL byte.</pre>
    </blockquote>
    <p>Yes you are rigght. I assumed the user will itself have to end
      the list of argument with a 'NULL', but that's not correct. Thanks
      for pointing it out. Will make the length of argv from length
      -&gt; length+1.<span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:87h6n6phcs.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
-    trace_migration_exec_outgoing(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(&quot; &quot;, (char **)argv);
+
+    trace_migration_exec_outgoing(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn((const char * const *) argv,
+                                      O_RDWR,
+                                      errp));
     if (!ioc) {
         return;
     }
@@ -71,20 +101,21 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void exec_start_incoming_migration(const char *command, Error **errp)
+void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), &quot;/c&quot;, command, NULL };
-#else
-    const char *argv[] = { &quot;/bin/sh&quot;, &quot;-c&quot;, command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Here as well.</pre>
    </blockquote>
    Ack, will increase length of argv by one while initalization.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87h6n6phcs.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
    </blockquote>
    <span style="white-space: pre-wrap">Regards,</span><br>
    <span style="white-space: pre-wrap">Het Gala
</span>
  </body>
</html>

--------------n7JAdFySzAzi87sVhsQQKFhA--

