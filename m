Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F5763319
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 12:04:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qObLd-0002Fi-65; Wed, 26 Jul 2023 06:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qObLa-0002FX-NZ
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 06:02:22 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qObLY-0007yj-JD
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 06:02:22 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36Q7TVg6004821; Wed, 26 Jul 2023 03:02:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=hkS+k3RAGQtS87TJrlU/i51VGjBYYZUXeE3gx2e4E
 aQ=; b=HvW9v2j04YJxSm464iBogTbS+8OpARZJdhuhE9OsTEESEz2j1rCVWdWZa
 vv6Cxvl3fhmTUJeOjrhTKLCcwSUWRZnFMR36WArpcrpFPQTILE23rfTumxkdczRm
 GOLz+l0OoOEbjDFBv+FjcbOlFtjXWM/4LbP12wP49YGsxcY9vR6vaOCNLi89Tggs
 /B7byOKJ9qcukUEoQ7trkd+W33DDda+sRDmwCtuziXC2aiHHqWdRVuAfXnRDhunN
 IAfJNtrNHvTTeu8q/oDu2CrV+88G5oLQBTWWYFClcUbS/QvyBG5BsyXGaELkiQOx
 mVyyv0Q7UnaXtyI5MVSnzINVG47Gg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0d7eyw02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 03:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdgUdLCK8W7jfnAwjmWZDwjPacSJGaV3d1ooBz42d6KWR54SE64pUp3HsbuimGRqzwvsD1r65GyZ4MJqUUUBfNSxncKFWsQEiE0e9+omPNakXiS+AJQhXUiDrc0ODg0ju4jNiMWZeL6pXwmf+nUDH9N1Vr0bRzbmqgrIxb7AvKK1gzT0zX29UkxWIX3bfSMF5ZYTftA3ujuUW+O/aiayPM8wpuz5DW7+VEArbwfa2FpeUbJ2fXVAt2PqVWPYoKYljGwyiWg2d2/MdQAfEXP2Fx0+buZ1USBcvp1vL7FEHwsVctMwqOtJlwvdgfYuyrN9ivkrJhXgCzRfpcLpV0QEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkS+k3RAGQtS87TJrlU/i51VGjBYYZUXeE3gx2e4EaQ=;
 b=TmubATHfEf/wTiWJoJEeWXsiTRPcerEi2/+Ymc+8Z1OfzGCMYlvYJORhbjEOBe+P9l1qIZjQxNUlLEqZXACDCaFiKMb2BO6oEu0oJsgxDM8A+fa7L9vycz2Sa+2U0zgmei9b6KfIutXy+2Ku9fQwsL40m6dA44w2lXDMf/XD+r0e/zj6ouIHjv0IYhgE58fr0QZcoHdYMxzSQbSEv7BRl1cUa/YRF00Kmx2CWhicQT4SASB79D4vv3STjZ7olX5rV+nz0Vb5adDqzbOdXQPFRubXxeecH5FgVAyOS+wmfHzHYvO+0+pIRH0yQv6tr3yGQfpUfVsaY3KkgvNYliUhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkS+k3RAGQtS87TJrlU/i51VGjBYYZUXeE3gx2e4EaQ=;
 b=MZ9xY7zqY5rQSB2kaJ3a4AGM2vaJa8H1N/rVFas3SWvrgWerwDIlsO4InFHA8vKf8iB391WoDg+b3zQI0FM7sDndMEQnshShh+8UaecpJTUI9BgzxPe0ThyKZExJXQvQ/4rEyYtNY4Ye7UIn6QjdW69doAzqNndpqM/RrEV1O/SF2d2+T7BUQLAH/cRYYFTPp0W0rDYuNOxHe0PLr9woM2ehiAdsoy05b4eyNw3HvlD3Zp8BXkuteNVLC/558uvkxuNRE5lbxaGhs3FQP5MsiNZg+rKu447LeW3GdvqRBXOcNEqEfxgVOl3H8JjdZCeCvK3+t1ObIP37SSyh3xvhHw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DS0PR02MB10272.namprd02.prod.outlook.com (2603:10b6:8:1b6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 10:02:15 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 10:02:14 +0000
Message-ID: <de808ef9-948e-cbf1-c887-90e418dd345c@nutanix.com>
Date: Wed, 26 Jul 2023 15:32:02 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v9 06/10] migration: New migrate and migrate-incoming
 argument 'channels'
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Aravind Retnakaran <aravind.retnakaran@nutanix.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
 <20230721144914.170991-7-het.gala@nutanix.com> <ZMAVodWyElfN9EFb@redhat.com>
 <ZMAWcnPgZJQvB93A@redhat.com>
 <f5109fbe-ce45-020d-fcb7-e32892d9135d@nutanix.com>
 <ZMDa6WNFeylS00QK@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZMDa6WNFeylS00QK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DS0PR02MB10272:EE_
X-MS-Office365-Filtering-Correlation-Id: 14902a0b-1b0f-45e0-2713-08db8dbf62fc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaYc8z2iLHz2SKcyAWatLGnAKPukL+5rrBIDkrFJ+RzS7tWIkEw9jQBqM3+z69l/F7BLY2gE6oRdXtNZmQfKi5Fa9IKySnFX/rZp7SujsdDdrLaz6t6ExQGlgefAJZJnc/55bTSU1XV+PDCa44/BYCafa0gSV26LhSLvO9qxAlIOcGItWjOskryarz4I4Md+La/UJZ5uLKJ4LYJkNx+nZOhYqtxvdTveZ0Yyj4gyId70XWNWF8VbfZVeFZW/gFeceo/O6JSTaYGlZrk1U3iQpK88pdvS/V+7oMqUxvjZ1fbbej9DrGB/zp/3NlUuhijxCYrCUNh1h+aT8NKazcmg53oV8Wx0OOzl8iujQnp3RlQnJNVYQlfdfDsDDEvvq0XuHjMGBfwsvLv67zSe1TWUr5j16oZeHh9UGE4/JHPJ2E5/Gd5u6hYSznuVxC2SjgjLTJBVA+Tiroc7t8mFkCSbusU5kOBy0lu0x2BHoi39K1fLFTMleqY0kuZtyekOo/gNiULrNyr15SeD+uazefjIcFtftnUtFmFit6rAHwnES5/iPIBvCR07uLLfkyoKJ469Ll8i1wCFe31YoAs7qwvJX9MYpSzQLO6Qjs5ANF4wLe+5tQ4iBSNrMgVt2N3Jr94jNhtwrNLtT8Wk0vSSOPiqKPVIE6bk9bRaEy6xs8kpJgAYWr69Q2NuIJIT9oj0pchc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(478600001)(31696002)(54906003)(36756003)(38100700002)(86362001)(66476007)(66946007)(6916009)(5660300002)(4326008)(316002)(66556008)(6506007)(186003)(6666004)(6512007)(6486002)(26005)(107886003)(53546011)(8676002)(44832011)(8936002)(41300700001)(2906002)(2616005)(83380400001)(31686004)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRraVQxWmtQY0o1Zk1qbDUzRGI2RjdoS2RydWsyT0VtdzM4M2N3T2ZoTndo?=
 =?utf-8?B?R2ZtRUg4S3pOSW1hN1NmbnFHeGRrZTdRNlRFbWFrSVdHVW5pcGhtMURiZGs0?=
 =?utf-8?B?b3F5bUtmM3NNb0M5Ukhoc29mSGowNnpDVm5jUU5uWU9nZEh6WmN2T2pnS0RW?=
 =?utf-8?B?MkwyMCtnSXF4Z3pxdFVvTGNVZ2tOYzh1VGU0cnZnNEprdkEvUDNFSllMZ1Jz?=
 =?utf-8?B?cHJUNFRIb1RVM0xRQjFBTk9TcUdNVnBMMFFoc0VYSzEzUmE2VHhLWnVERHh2?=
 =?utf-8?B?R0YwWnB0blpJRTF3YSt2SjVpc3VuZ2wyYjVJbGt5bG8xemdYQVBxbllnd2w1?=
 =?utf-8?B?KzlRMVJKZVFVb2gyZFdadWhRRzRJVmZ6UGZkNk1qb0FHZ2c3K3UyTGdvQzFL?=
 =?utf-8?B?SFV2V3pOVkJyZ0VSSkk4YVR5UE8xRmN0Y3JFQU1xU20rSHpEeHpLcFMzQ0pC?=
 =?utf-8?B?Tkovd1JjRWU0OTVGNGZORkhNYTRIRURBcEE2NDcycU9zTVhWdDFTQ1FOVkFO?=
 =?utf-8?B?VVdmNFlVZUQ1K3J2d0RMaC9wY25scVdKTVE2UGhhTm5PS2pTelBjVlhBV0Vk?=
 =?utf-8?B?V0NLb0Nnbm0rWmlaaU44QlQydk9VMldsRHllbTJhUTR3d3lMd1dWT3EyTk13?=
 =?utf-8?B?Wlg4MjVsVHV1YzVTdjBtaVZUbGo4TVVKMlIzdGJnTFpmN0c1K0pEWnpMb0tU?=
 =?utf-8?B?S09EYThJWFM2QVhWQ3hCbXhMbzZ5WnNSbk1TdE1YQ2ZIN1VDbFdkb0VYVkxO?=
 =?utf-8?B?YVF1YWVQNmZzUFlXRFZNRXhwMUMyVEx3YktnZi9TQ2ZSdWZKZjdNdjVmNTlu?=
 =?utf-8?B?bGp4MW1wR2U5cmZaMU1qUExucUpoREtsNGJIYnFESE45dGJ1WmtGdGcxOVJj?=
 =?utf-8?B?VEdRVmtmVEN6ZFAxOHJVQ2dGRVZvSGYzWlZsMU0vTnZ2T05tT3Q4YXlOK1Vj?=
 =?utf-8?B?ZzlMbTBYSURMaUNkMEJSWEgyejhXNXljYzZuVjUza2pkNkNFalFPY2ltNW1P?=
 =?utf-8?B?VTNueHpvb1JjanZ3Z3E4dXhjTXFMZWF3WGRBaHhTTzBmdDByYTk4SDhTbzI1?=
 =?utf-8?B?Njl0MS9QazNLVlVOc0hQOTFOWFlEcXU1cVVQQTY2MFFFSDdYaHE3VUc3OC94?=
 =?utf-8?B?TXVwVzRlU1U3VG1vY2VGRjAyV1BURGZHc1I5SXZZNi90dm9HQllnVTdZNy9m?=
 =?utf-8?B?eEY4ZitwODdSWi9ERU5iWDhGenBpQ2s4Z1JOSElUaG9LMEU3YnpqTk0zNVho?=
 =?utf-8?B?dFpUUC91OTRBZjI2Nm1jWHBZaTdQb21CM1lGbG8xU25XUldMTS9Ga21Na25J?=
 =?utf-8?B?VUdhbkZ0NEFlYlM5b1hFdTdBcVhnNS9jTHllQVdSY3AvMG1veTkzanpPbkZ6?=
 =?utf-8?B?ZXVRQUFIMTNHNVJLMWdMdVdsSmI5eXJubTVmbk9YRFJ0K0lyNThuLy9ycFdV?=
 =?utf-8?B?SGc3dVVLZlRYcFlaYzh4WUNWOGx0TWIySE1hVGlpaWJFejJQNWtqQ3RpSk9s?=
 =?utf-8?B?TTdNeTl0b0pWWk5VZU4xTW5YWGVyR0MyeHY1UlpGMnZHY3ZBR1VqK1hCc2xh?=
 =?utf-8?B?VzdtRFgwYWZuR0k0QllVcEY0dElnWWVROE43T2xpVHdBM0lLTk9PNnI2NHg3?=
 =?utf-8?B?M1BBcUI1clFwTzE2OVR1OEZBdGZVVzZMaksybms1aHlCNmpOUEFIekpvNERQ?=
 =?utf-8?B?ZXhud0RTNWpzWUo2TG93MkFUM3ltSllDYWR6WmZhNmIwVmVCby9xdTAvUktM?=
 =?utf-8?B?VmZCSWtUL3BBUDVCV3NubWpkdkNURkFrczFONkVsSnRXc0EwOXExZE1uZ2N3?=
 =?utf-8?B?dUZWYVY0Y0wyd3Y5L29DaEgyVHBvL21HWEZCSjEveFNLUERiWjBXVUJETEl3?=
 =?utf-8?B?bmhjSXcwcGMvMFZ1SXI4NVpnQ0ErMGt0MGNpZVlRYUdPTGF4MzVvbElLa1Iz?=
 =?utf-8?B?cGRkelk4ZjlRQzBZRG50TFFGdkJSM2JIUGRrb0VhNE4vampwNjJWcVJSQmJG?=
 =?utf-8?B?VnNBVXBjQ3hIRzRqc2pzOXQzN2liTG1XVmROSG82UnFieHdjM0EzQnhES1Rh?=
 =?utf-8?B?YmkrMmlMWlBqRkxpRUMrWlFCaG9CU0lFbGRwLzNVZHJOYjcyOGIxbjZKL0JS?=
 =?utf-8?Q?Y/ykujEf3YwkLUEJjlc5nWDas?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14902a0b-1b0f-45e0-2713-08db8dbf62fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 10:02:14.5772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le3qDuLqeeDbYv5tRiUzZOMQ1iKiLDx6Pb6Cto517zG3f4DU8BN6nIrUTWq8xd9nWvsbPEydNYDlHkz1rsyb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10272
X-Proofpoint-GUID: WsfFY0dYcfpkkeQsr66IibaHvxnwKm7B
X-Proofpoint-ORIG-GUID: WsfFY0dYcfpkkeQsr66IibaHvxnwKm7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_04,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 26/07/23 2:05 pm, Daniel P. Berrangé wrote:
> On Wed, Jul 26, 2023 at 01:24:48AM +0530, Het Gala wrote:
>> Sorry, last reply on this patch was accidently replied only to Daniel.
>> Pasting the reply again so it is received by all the active maintianers
>> here. Apologies for the error 😅
>>
>> On 26/07/23 12:07 am, Daniel P. Berrangé wrote:
>>> On Tue, Jul 25, 2023 at 07:34:09PM +0100, Daniel P. Berrangé wrote:
>>>> On Fri, Jul 21, 2023 at 02:49:31PM +0000, Het Gala wrote:
>>>>> MigrateChannelList allows to connect accross multiple interfaces.
>>>>> Add MigrateChannelList struct as argument to migration QAPIs.
>>>>>
>>>>> We plan to include multiple channels in future, to connnect
>>>>> multiple interfaces. Hence, we choose 'MigrateChannelList'
>>>>> as the new argument over 'MigrateChannel' to make migration
>>>>> QAPIs future proof.
>>>>>
>>>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>> ---
>>>>>    migration/migration-hmp-cmds.c |   6 +-
>>>>>    migration/migration.c          |  34 ++++++++--
>>>>>    qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
>>>>>    softmmu/vl.c                   |   2 +-
>>>>>    4 files changed, 139 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>>>> index 9885d7c9f7..49b150f33f 100644
>>>>> --- a/migration/migration-hmp-cmds.c
>>>>> +++ b/migration/migration-hmp-cmds.c
>>>>> @@ -424,7 +424,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>>>>>        Error *err = NULL;
>>>>>        const char *uri = qdict_get_str(qdict, "uri");
>>>>> -    qmp_migrate_incoming(uri, &err);
>>>>> +    qmp_migrate_incoming(uri, false, NULL, &err);
>>>>>        hmp_handle_error(mon, err);
>>>>>    }
>>>>> @@ -705,8 +705,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>>>>        const char *uri = qdict_get_str(qdict, "uri");
>>>>>        Error *err = NULL;
>>>>> -    qmp_migrate(uri, !!blk, blk, !!inc, inc,
>>>>> -                false, false, true, resume, &err);
>>>>> +    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
>>>>> +                 false, false, true, resume, &err);
>>>>>        if (hmp_handle_error(mon, err)) {
>>>>>            return;
>>>>>        }
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index f37b388876..bd3a93fc8c 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -466,10 +466,22 @@ static bool migrate_uri_parse(const char *uri,
>>>>>        return true;
>>>>>    }
>>>>> -static void qemu_start_incoming_migration(const char *uri, Error **errp)
>>>>> +static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>>>> +                                          MigrationChannelList *channels,
>>>>> +                                          Error **errp)
>>>>>    {
>>>>>        g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>>>>> +    /*
>>>>> +     * Having preliminary checks for uri and channel
>>>>> +     */
>>>>> +    if (uri && has_channels) {
>>>>> +        error_setg(errp, "'uri' and 'channels' arguments are mutually "
>>>>> +                   "exclusive; exactly one of the two should be present in "
>>>>> +                   "'migrate-incoming' qmp command ");
>>>>> +        return;
>>>>> +    }
>>>> This checks is both are present.
>>>>
>>>> Also needs a check if neither are present as that's invalid.
>>> Also it should (temporarily) raise an error if "has_channels" is
>>> set, as while we've added the parameter in QAPI, we've not
>>> implemented it yet. IOW, raise an error now, and remove the
>>> error in a later patch.
>> Ack. So in total there should be 3 checks right. 1) if 'has_channels' is
>> set, 2) if 'uri' and 'channels' both are present, 3) if 'uri' and 'channels'
>> both are absent. Basically right now only uri should allowed and should
>> atleast be present.
> Correct.
Ack.
>> I think overall only 1) would be enough and should be checked before
>> 'migration_channels_and_uri_compatible()' and if 'has_channels' is set, just
>> return for now. With this 2) would not be necessary or not come into play in
>> this patch. 3) will be taken care by
>> 'migration_channels_and_uri_compatible()' itself IMO.
> I think all the checks should be in this method, as it is the entrypoint
> for execution of the QMP command and thus where parameter validation
> should live. Spreading it across methods will make it very easy to open
> bugs by refactoring code and not realizing the new codepaths don't do
> the right checks.
Okay, I got the concern here. Will add these 3 checks in this patch and 
later remove 'has_channels' check in the patch where we are implementing 
MigrateChannel.
> With regards,
> Daniel
Regards,
Het Gala

