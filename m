Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E05077BF287
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 07:57:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq5iW-0008K5-Uy; Tue, 10 Oct 2023 01:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qq5iU-0008Jf-Eq
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:55:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qq5iQ-0002nn-SL
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:55:37 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39A3o2UN028591; Mon, 9 Oct 2023 22:55:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=CqQRG5CX3SYS
 MasUZLEfdF0KIoS8pVGaZ6X6NCOPRrs=; b=23AU3B2Lf0GOQ3YgR++9yF2BXXjd
 fRZ6pvcIDFx/H6G/5HteXhZTg5x9NO0PsaTMxONzVYuPJdjPZMrTyovR6CJq++Zj
 0N/nneaFwaQXgCSIl2qqAqrwN6sNFAMXBQAMDJDjLBdCZJiXan187JmCZZYeRZWF
 b9kSjDUkmh0uaO7Zs5KQha5OAU+qipD4LtD2eMMZCjCjS0PACuULCBN0ZJjORF8p
 ygEeeKuimrHfK2mvzjMHtZMJbtR52YgDkkgS4/pxpIMoYltOMKeacVY6disoGYCG
 Xh7sZKy7IgE+ZnC7bOBHIZoL4QBekI7J128qfTMUeOwkuLfDapbfLH6Q6A==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhxt36dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 22:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9yMzMnNH17ktkeGo58GNV09wkCM5lOolp1WgP+E8WWDndy//cC+0TLYGvnhQxeaVRpeOT908kMouGmYdktjMM4c63JikJBpIe/d0UNAvElnnMu3gD/lKD0B8n4Iwu8QPxQYE61rZcxr+yYfzK11UpocdRr4RS3qkvtbwaMZs05JKI7BLYb4ljRvEDS+QXbkodlh5g8efXKBri5mDGBPX6seC80kh86zC3C0a0iOck+qgPlVjcwcgUxxC7Uothx47TOE0ldZZXQZ5WsCAANMDEYgqx0k0h/YynmGjxafga+1DuCqW36vFAWODc8OzvGJmD4gU99meJZcTyy+xzkZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqQRG5CX3SYSMasUZLEfdF0KIoS8pVGaZ6X6NCOPRrs=;
 b=RT4sdQoTsoZvSqIe39q6/VH/xF/rKNQTt5zEn162NgRbawVY/jmKZ6n6BRAXbqgFsfXJhGlJ7nKxhoLbqWE/yf/np/duvOz/WBUxJMBvZwbddwjM/OecCkhEqFEoc1WdBWLybiQE4bCo9uZiMDgIU84/yTc2ReIshs6FxrO8SeGXFAKGmiNy9l9YcjkXjbaNyJ+UjJdKGL9mJIW9R8rTf9BCeRgGGg/b6Ph/7pKE9kRiDpXv20d7FlXb/R0BKpk8gRI+ePQ3mtnAa9zMalxP21pEEKHghqPUYGWg9Qky/Ga6Jo8KeJDKF1FQnqkA7cF424ceDWGPcA1LqSKSQ2j6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqQRG5CX3SYSMasUZLEfdF0KIoS8pVGaZ6X6NCOPRrs=;
 b=T4il1bJSu2a2uW8r+uUgiRqTxHkgp7cB339KSaQvZSdRfwzEKRUA0CZji4hgWh6SiN2Z037y0lX4Y1er9MhHSq7RjMAtD6dJQWVXMyrIO5g+ngM1p0YQfhzCNxUyKwuGaQzbHiUQ34Zd7ST2wWIRtNOxMCS2tGiHnqr2kI32NthMXVP4uRh2u4iykuiUBNBK1nJcQHXIvz1cvnuYQ8M+smOMk9BhE9JbzTbixLkgF13D8iYL8eqFfnXqxxk95sTUR3XQ3cS98hJt5XY9ZNhkXX6OBpiExk5jyWzcyusStP35qkMD13Q8ETglBUFbwrUjG6zLO2JMct+jD19u8jRrOg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6505.namprd02.prod.outlook.com (2603:10b6:610:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 05:55:27 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 05:55:27 +0000
Content-Type: multipart/alternative;
 boundary="------------cT5C6lgA83XlvlY0BDDgfQtH"
Message-ID: <5e59637a-d6ba-46e6-9c28-cc8c16c7fa16@nutanix.com>
Date: Tue, 10 Oct 2023 11:25:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231009143615.86825-1-het.gala@nutanix.com>
 <87wmvvjymi.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87wmvvjymi.fsf@suse.de>
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: cd972200-d13c-4d20-efc6-08dbc95580b0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TRYOHbPJhq/lPbNjU7M0o2/0JjquwSd5q1QQSwZCrhkAxBsVpASKLaZwEytYSzuuU9BXofNfN+inJi7KXaeW/PP1JGQKXzDIj05lL8JEwQca3vf5RkZCSeLFV0VPSIn2ZVxxnrXtK35/rB99Q25pwA6+6aAVzH38iZBZph6RJHR7BhcKqjmHXkjO48hiHV0/41X3kIb3uoMbQTXEYMuICjQyMI8EigwFOcvQiK6oza8oPZKkozGAX32OoxxK8Z/a8QWg6ie6d984S7FUWMnB+NqijSaC4K9DYtYjmlYkERvNFPR4mf/ir7zFfoFxuIeNAMnsxRB+BJx4bMQHrAup7VXxTwwOexiYBlUkIPZxlm1A86ppBAagwTVd5QHI7GR78gYDShREcwnDqMsppdTA94xzl9rk113PK8H47/HKLeINIfgrwRL7oe7dpKUzyc2KWmCzQqpHMnS+W8NHyirs652B93JP3GedquioLNPgppc4Zp7eEEDwlY+zgH1//SAVozehqN+EIo4MbICZENxVLK0LkO0+xm+frl1Vt1pR/wBa9iMK/L0R6yWdcX5OHMtLiWcgdh9POD13bgvidJdtsYixCLSv080d6nliOh/BGCKjJMSbdE+yUhAjHYVHN/CVqwQm5xLgmFYO67tJBntrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31696002)(2906002)(86362001)(30864003)(6486002)(966005)(31686004)(478600001)(44832011)(5660300002)(166002)(83380400001)(26005)(4326008)(8936002)(8676002)(107886003)(2616005)(66476007)(66556008)(66946007)(38100700002)(6512007)(36756003)(6506007)(53546011)(316002)(33964004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhaTFhNR0F6YWh2dXlHaHV5OGJBZjZMd1VqT2ZGdTkvdmxBY2JBSGhySm02?=
 =?utf-8?B?b0N0T0MvYVFHeFoxL3hpa2JiUmdvbXRtYnRJbDdFNjYweUEwVXdEakgxZmRr?=
 =?utf-8?B?V3dQanEyNXoreDh1c2tLb2RIUnhHbm1ob1hmZ0RwMDlMSHNhemZNNnladnRp?=
 =?utf-8?B?WVlyZ3dCS2ZuaHJPSWsxOC9qWklnaTl3VjF3ZzZISHlRMXJXa2lQemp2TnB4?=
 =?utf-8?B?T2lVMk9xZ1BqVEloV0RRMGtKYTYxSlRkdUQ0TllZMXdrOUVpSXlUUlJwRzJr?=
 =?utf-8?B?MlhuR2doQWx5ZHNhSmpPNDk5dGhwSStKNGlqZUNsVnR5TVpmSElUL0MrSzZo?=
 =?utf-8?B?R0plUHpXTnZnbGRxSkU2azlFdmNzdFI2cmhvZmdzK3RBVDBqNkJ1TVBWL0xW?=
 =?utf-8?B?cVdEdTFJK3lsRHZWVGJDK2pCZ2dJbkNranFCd1lTM3FSTVFNZHFLUHdhRzFq?=
 =?utf-8?B?bExZQ1oya25hVzdxZTJ3YXh2RjRhODBaYzlCTm1lcldDRzg3Ky9wVHRLNUJ2?=
 =?utf-8?B?L2M3WjdjblIxaGMxM0crVzNvSlMvSXZuVnoyTmtjKyttOGpyMm5MTWIrNzlp?=
 =?utf-8?B?UmtudzVWRTFaYlJMdVBpMThqOFJ5b0dlaW5ERkQzM1puamZ6TitrZmlzY0lT?=
 =?utf-8?B?ZndiRUNzYWFSZWlDOFVyWUxIRHdQM0ZENm81b1BiVWVrMXY2V3Z5L2ttbVZK?=
 =?utf-8?B?WjNNb3lhQzlxaGRNenBKYkh1c0dpQ29EQll0U3hwRW9nd0crekJzQk9EZEhC?=
 =?utf-8?B?MWkzZlg4eVlmSkJqQXpLcXg0ZWpkYjhOVEFpV1EyRUZmSUkxWTJvaDE1VHZR?=
 =?utf-8?B?MnllYkpZaHkvTVRmbWxxcmZDYTAxTldHV0NDWHc2NExOOTJHWkpGenc3TjBx?=
 =?utf-8?B?U0tmdHpEcnNOWFJIZGlFOVZmWVJxcisrdStYamV3VllXUGRiZWR0MUZ1MFND?=
 =?utf-8?B?TTlkVEJmVGlFeHpaZEluTlA0bzV4cGRab3p1ZFdZQWZJM0YrK3BZWU5pRUJy?=
 =?utf-8?B?TXZqQzY1N1luZEFuZ09EUk9ib1IyRk5wVGxRNkpqN1VrdUxEMnFEOFBGVFpX?=
 =?utf-8?B?OFl4VHdrWnM4bzZkakJiQWgzcXdOU3ZqMnc2ekoxR3hUN096d1JVdXhHa2NG?=
 =?utf-8?B?QXFFV0hTYVZqYmV4SXdaemh2MzEzYldzZTcyT1Z6TXdOSHpiQXJSLy9xZFNj?=
 =?utf-8?B?YWpmYnNUdkxwdXBXMWVBWWJSZDhhVkpXdjA5ajZBaThaUjRxbjZHaGVnSlNv?=
 =?utf-8?B?Y3ZSeWg1bUZMMmZseWxlWEt4ZHdINDRoZnhTdWpsOTBEeTAyT1dnZHo1Y3VQ?=
 =?utf-8?B?bW1DUkpjNGpIRWJ0OStnSkxVOVFOTUx4UUV3dEt0cmswOTFSM0tvVVFTTXE1?=
 =?utf-8?B?bkZRL0lZd0JYSW9oYlpMR1RpRkxXT3kvKzJ0VElnL0JkZ2FxZ2hGWnRVcmU1?=
 =?utf-8?B?UlZEcnZkdXFoMFJ6eWtlTUhtV0lFaCtsN0JqY3p5cmJYTnZBQ2E3bFJ3TFJG?=
 =?utf-8?B?aENnWFVvSmcwQlU0Mmdta1loazJYZXlxUm01N2JMdmJvWEoxRkIvWTdxVFBS?=
 =?utf-8?B?bDdLSWFnTW1rL1RoZTdsMkgwajMrQ2tHa1RRY1FISU9pNUdMZnVXL1FwOTVr?=
 =?utf-8?B?UTRCR1lQYnBUTnVRTUFDMUVPUnBVc3JhMDEwTTRBNFBXZ0NhUFhKYXA2cHRK?=
 =?utf-8?B?ZXlKVGJMK1NYSE1BdHBXODhIRk5VS2ZPb0tPeE9CZlIzVnNOa2tuejZ2N3JR?=
 =?utf-8?B?Z0ErWHU3VFlZRHZJUC9vbWVxVVRia1BSdDZJR1ptY2tzZVorL1M2ZzBlVjNI?=
 =?utf-8?B?VGk1Zk1sejFlVE9GQmdRNFlobTJISXlMUXNTQjl3MWVjd0RMTS9QdW9ZQk14?=
 =?utf-8?B?TThTc1JpOVhaUjdrMCtCY0J2UDUxVS9Yb2liNGhIb0ZtSHFCQ1MvMzB6VG54?=
 =?utf-8?B?VkZBZ0s3Qkljd25LazBrY2VaV1pnbHhVRWlVV2pjdzdZUHRhU01PNVJzaVB2?=
 =?utf-8?B?N2Y0T2JtTmVHNDBmSndUYTJPbWJKNlA2U1Z1d0NLK3JTcnA0dStOUkM0dk9i?=
 =?utf-8?B?NTUvdHdCalpZOThVU2dCRytLK1pyV21aQ0MwSFBMSmNrQ1NqUjVTMTRuSEFV?=
 =?utf-8?Q?eVybCd+24+PT6Z3HiSIOkOYta?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd972200-d13c-4d20-efc6-08dbc95580b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 05:55:27.7045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szx9ldTSE/BINAPLh8h5Vg5ZBepNRpwYi4b549Syb/7cVrWuBaN5n50fLLHhBCYUv+MYUGGS7JEAemtC8hB+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6505
X-Proofpoint-GUID: YVvzQIb2OcTGdJb7SL-3-rQAqCaWt8yH
X-Proofpoint-ORIG-GUID: YVvzQIb2OcTGdJb7SL-3-rQAqCaWt8yH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_04,2023-10-09_01,2023-05-22_02
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

--------------cT5C6lgA83XlvlY0BDDgfQtH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/10/2023 2:34 AM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> This is v12 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
>> for upstream review.
>>
>> Would like to thank all the maintainers that actively participated in the v11
>> patchset discussion and gave insightful suggestions to improve the patches.
>>
>> Link to previous upstream community patchset links:
>> v1:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=OXhp-cq93AZ1ZRIwKL5wXhx5-8ei7RfBdmmbU9KNDfg&e=  
>> v2:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=r7SYaB2fxLcEP2DiHslsbEyaY7ZPrXxageSBRtRZ7TA&e=  
>> v3:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=fnGhJw56ypUavnslnUL6JeK4OLi7xwh7TGsafaSSZvw&e=  
>> v4:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=SA4q18GEE4q3Eh7sy5nhQ8OZO5KM8kfapiBkSPZYDxE&e=  
>> v5:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=QRW_aAGHmTBajBnu1a4jcxQFZ1lf1N3RCyLgOt82Ji4&e=  
>> v6:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=7Dmgm47UdQ0h0Y9-XffsUW_ZdeQ-eCCVzhUkigTMKbc&e=  
>> v7:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=8a3tAfIJ-6st1tlYkbjsRWEv-JvEFxokXzanf0WCqzw&e=  
>> v8:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=4q_F05ZPdhWsPJ0fa850gHS90AsVX7MbsaIHi-3OsMI&e=  
>> v9:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=1wNhJSfSvAoadG06F2JKFHZ2mA4QWSgqvYpt1zRX9qw&e=  
>> v10:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=guEm3FuFn7jutT4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&e=  
>> v11:https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=W7rbQhebtuWtT2ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&e=  
>>
>> v11 -> v12 changelog:
>> -------------------
>> - Resolved double-freeing when using g_autoptr in structures that are
>>    nested into another.
>> - Overwriting of pointers to an existing allocated memory is solved at
>>    various places.
>> - Use of g_autoptr caused make check errors in non-error path while going
>>    out of scope inside function. Added g_steal_pointer() in the non-error
>>    paths wherever required.
> Please run make check before sending:
> ▶ 242/355 qcow2 181  FAIL
>
> You can also push your code to your gitlab and run a pipeline with the
> branch.

I tested on my setup, and it passed all the checks.

[root@06f1b38a5d6a build]# make check
/rpmbuild/SOURCES/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 0  
--num-processes 1 --print-errorlogs
   1/348 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/qom-test                        OK 14.00s   8 subtests passed
   2/348 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/migration-test                  OK 82.28s   13 subtests passed
   3/348 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/bios-tables-test                OK 79.38s   51 subtests passed
   4/348 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/test-hmp                        OK 5.67s   9 subtests passed
   5/348 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/ahci-test                       OK 21.16s   74 subtests passed
   6/348 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/qos-test                        OK 34.48s   119 subtests passed
   7/348 qemu:unit / check-block-qdict OK              0.01s   10 
subtests passed
   8/348 qemu:unit / check-qdict OK              0.01s   15 subtests passed
   9/348 qemu:unit / check-qnum OK              0.01s   8 subtests passed
  10/348 qemu:unit / check-qstring OK              0.01s   4 subtests passed
  11/348 qemu:unit / check-qlist OK              0.01s   4 subtests passed
[...]
340/348 qemu:softfloat+softfloat-compare / 
fp-test-lt_quiet                    OK              0.10s
341/348 qemu:softfloat+softfloat-ops / 
fp-test-add                             OK              1.61s
342/348 qemu:softfloat+softfloat-ops / 
fp-test-sub                             OK              1.55s
343/348 qemu:softfloat+softfloat-ops / 
fp-test-mul                             OK              7.81s
344/348 qemu:softfloat+softfloat-ops / 
fp-test-div                             OK              6.84s
345/348 qemu:softfloat+softfloat-ops / 
fp-test-rem                             OK              4.24s
346/348 qemu:softfloat+softfloat-ops / 
fp-test-sqrt                            OK              0.10s
347/348 qemu:softfloat+softfloat-ops / 
fp-test-log2                            OK              0.25s
348/348 qemu:qapi-schema+qapi-frontend / QAPI schema regression 
tests          OK              0.20s

Ok:                 339
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            9
Timeout:            0

I am not sure if something is different in the configuration. I have 
never run a pipeline on gitlab though.  Can you point me out to the 
documentation of gitlab once again

Regards,
Het Gala
--------------cT5C6lgA83XlvlY0BDDgfQtH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/10/2023 2:34 AM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87wmvvjymi.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This is v12 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Would like to thank all the maintainers that actively participated in the v11
patchset discussion and gave insightful suggestions to improve the patches.

Link to previous upstream community patchset links:
v1: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=OXhp-cq93AZ1ZRIwKL5wXhx5-8ei7RfBdmmbU9KNDfg&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=OXhp-cq93AZ1ZRIwKL5wXhx5-8ei7RfBdmmbU9KNDfg&amp;e=</a> 
v2: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=r7SYaB2fxLcEP2DiHslsbEyaY7ZPrXxageSBRtRZ7TA&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=r7SYaB2fxLcEP2DiHslsbEyaY7ZPrXxageSBRtRZ7TA&amp;e=</a> 
v3: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=fnGhJw56ypUavnslnUL6JeK4OLi7xwh7TGsafaSSZvw&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=fnGhJw56ypUavnslnUL6JeK4OLi7xwh7TGsafaSSZvw&amp;e=</a> 
v4: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=SA4q18GEE4q3Eh7sy5nhQ8OZO5KM8kfapiBkSPZYDxE&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=SA4q18GEE4q3Eh7sy5nhQ8OZO5KM8kfapiBkSPZYDxE&amp;e=</a> 
v5: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=QRW_aAGHmTBajBnu1a4jcxQFZ1lf1N3RCyLgOt82Ji4&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=QRW_aAGHmTBajBnu1a4jcxQFZ1lf1N3RCyLgOt82Ji4&amp;e=</a> 
v6: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=7Dmgm47UdQ0h0Y9-XffsUW_ZdeQ-eCCVzhUkigTMKbc&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=7Dmgm47UdQ0h0Y9-XffsUW_ZdeQ-eCCVzhUkigTMKbc&amp;e=</a> 
v7: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=8a3tAfIJ-6st1tlYkbjsRWEv-JvEFxokXzanf0WCqzw&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=8a3tAfIJ-6st1tlYkbjsRWEv-JvEFxokXzanf0WCqzw&amp;e=</a> 
v8: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=4q_F05ZPdhWsPJ0fa850gHS90AsVX7MbsaIHi-3OsMI&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=4q_F05ZPdhWsPJ0fa850gHS90AsVX7MbsaIHi-3OsMI&amp;e=</a> 
v9: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=1wNhJSfSvAoadG06F2JKFHZ2mA4QWSgqvYpt1zRX9qw&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=1wNhJSfSvAoadG06F2JKFHZ2mA4QWSgqvYpt1zRX9qw&amp;e=</a> 
v10: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=guEm3FuFn7jutT4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=guEm3FuFn7jutT4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&amp;e=</a> 
v11: <a class="moz-txt-link-freetext" href="https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=W7rbQhebtuWtT2ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&amp;e=">https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&amp;d=DwIFaQ&amp;c=s883GpUCOChKOHiocYtGcg&amp;r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&amp;m=s4FkORPOMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&amp;s=W7rbQhebtuWtT2ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&amp;e=</a> 

v11 -&gt; v12 changelog:
-------------------
- Resolved double-freeing when using g_autoptr in structures that are
  nested into another.
- Overwriting of pointers to an existing allocated memory is solved at
  various places.
- Use of g_autoptr caused make check errors in non-error path while going
  out of scope inside function. Added g_steal_pointer() in the non-error
  paths wherever required.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Please run make check before sending:
▶ 242/355 qcow2 181  FAIL

You can also push your code to your gitlab and run a pipeline with the
branch.</pre>
    </blockquote>
    <p>I tested on my setup, and it passed all the checks.</p>
    <p>[root@06f1b38a5d6a build]# make check<br>
      /rpmbuild/SOURCES/qemu/build/pyvenv/bin/meson test&nbsp; --no-rebuild
      -t 0&nbsp; --num-processes 1 --print-errorlogs<br>
      &nbsp; 1/348 qemu:qtest+qtest-x86_64 /
      qtest-x86_64/qom-test&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      14.00s&nbsp;&nbsp; 8 subtests passed<br>
      &nbsp; 2/348 qemu:qtest+qtest-x86_64 /
      qtest-x86_64/migration-test&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      82.28s&nbsp;&nbsp; 13 subtests passed<br>
      &nbsp; 3/348 qemu:qtest+qtest-x86_64 /
      qtest-x86_64/bios-tables-test&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      79.38s&nbsp;&nbsp; 51 subtests passed<br>
      &nbsp; 4/348 qemu:qtest+qtest-x86_64 /
      qtest-x86_64/test-hmp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      5.67s&nbsp;&nbsp; 9 subtests passed<br>
      &nbsp; 5/348 qemu:qtest+qtest-x86_64 /
      qtest-x86_64/ahci-test&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      21.16s&nbsp;&nbsp; 74 subtests passed<br>
      &nbsp; 6/348 qemu:qtest+qtest-x86_64 /
      qtest-x86_64/qos-test&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      34.48s&nbsp;&nbsp; 119 subtests passed<br>
      &nbsp; 7/348 qemu:unit /
      check-block-qdict&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.01s&nbsp;&nbsp; 10 subtests passed<br>
      &nbsp; 8/348 qemu:unit /
      check-qdict&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.01s&nbsp;&nbsp; 15 subtests passed<br>
      &nbsp; 9/348 qemu:unit /
      check-qnum&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.01s&nbsp;&nbsp; 8 subtests passed<br>
      &nbsp;10/348 qemu:unit /
      check-qstring&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.01s&nbsp;&nbsp; 4 subtests passed<br>
      &nbsp;11/348 qemu:unit /
      check-qlist&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.01s&nbsp;&nbsp; 4 subtests passed<br>
      [...]<br>
      340/348 qemu:softfloat+softfloat-compare /
      fp-test-lt_quiet&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.10s<br>
      341/348 qemu:softfloat+softfloat-ops /
      fp-test-add&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.61s<br>
      342/348 qemu:softfloat+softfloat-ops /
      fp-test-sub&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.55s<br>
      343/348 qemu:softfloat+softfloat-ops /
      fp-test-mul&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.81s<br>
      344/348 qemu:softfloat+softfloat-ops /
      fp-test-div&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.84s<br>
      345/348 qemu:softfloat+softfloat-ops /
      fp-test-rem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4.24s<br>
      346/348 qemu:softfloat+softfloat-ops /
      fp-test-sqrt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.10s<br>
      347/348 qemu:softfloat+softfloat-ops /
      fp-test-log2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.25s<br>
      348/348 qemu:qapi-schema+qapi-frontend / QAPI schema regression
      tests&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.20s<br>
      <br>
      Ok:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 339<br>
      Expected Fail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
      Fail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
      Unexpected Pass:&nbsp;&nbsp;&nbsp; 0<br>
      Skipped:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9<br>
      Timeout:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
    </p>
    <p>I am not sure if something is different in the configuration. I
      have never run a pipeline on gitlab though.&nbsp; Can you point me out
      to the documentation of gitlab once again</p>
    <span style="white-space: pre-wrap">Regards,</span><br>
    <span style="white-space: pre-wrap">Het Gala
</span>
  </body>
</html>

--------------cT5C6lgA83XlvlY0BDDgfQtH--

