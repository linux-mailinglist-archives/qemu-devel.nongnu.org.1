Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E0762253
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONmL-0003G4-UW; Tue, 25 Jul 2023 15:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qONmJ-0003FH-Sb
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:33:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qONmH-0006TO-Fg
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:33:03 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36P9o1Ow027182; Tue, 25 Jul 2023 12:32:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=tTsV4zwb4zgpVqIpdrBV3FTTR9ItdOGJaCACyvjB0
 iQ=; b=VC6it9M0x2uY8jre3sYQjf3vp6WKH+o6X+3oox2tHWxinNNL6Pb58Gxx2
 J73LnTsha09uMyTChMGK4PDzmc5BxmxUX31Q+V12a2kDC2fkRWbXEUcerFynfnyZ
 lI2MiVvx/kKeoOcTIYXDUs6QzdIVLpEQOhe+b+ZUqihcW3CwjCF88Sfls506Oj8E
 ZKma9T4sXq+kuiBJfl04Puqgbr7pC3OkuVAMeyClidMfgCfpr+dZSgqjrfYVXkyi
 7Tg45DG8P3Jgjhkxj8BanYAUxj1dQ2dnA4J48yY8p6phOkJrcV+o2YVgTe4pbQ1g
 HXthvRWEknRxC0q+hPvVCICfnRJag==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b16xhh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 12:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzLFmZKB5DEaJ6kzWISyIyxp1PtdCGrpyUIoijYhVY+fcj4kgP2zPBYkkQxqLVYmcRVr2mABx8DxjDQ0KfT68+1GF9abtUmH6diXzWQJDaVC1xzyBr2QawF7C7PD1QlQQ9MYWIAzfLeAfY74TOB8QUlEl88+U0lLxIK57+RNPMqONLSrjGjKQuT4Y1PviL89pmfsA2RBdjWDWR7VGZaM9MNrL3LqqUB+5heEHSRkAUZDgQq+7/OpzQUMtgBwly5T1qDkCvy7mwxR/qKwBCVCB3xr0shDGlY0sz0x8gXSzPBt9NguQ/8GqCSuE3if1NWeGb4EWpLGNtq71pa8amnlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTsV4zwb4zgpVqIpdrBV3FTTR9ItdOGJaCACyvjB0iQ=;
 b=LnD+XFcgi/OeLGTTT+W2NgmLh8OHd7PI0be/j55ZTrvTQHAZh4bpiWPeCl8GHFECiryHZPXhG6VIcbNFXGU3LWbVm+Ix8ulWZo5Wzf3qpou2U3OZsbWaSk0/0pL0MUb3TS4F7ChD8QzBjIAYoB4uDvUooeFet4NjTL4fJko4LrKyfecXx8ikC4ZJR1WAiV5Pzlsqg9vt5QBV8jh+bbmJMJbp1jTMd8eR8v7vnVzSkI6OEaZzKtWBOHRxuEsP8HczSwfAWm9E+tbdf2rJi6achj9g/yOLBQ8C1w6linwHyHI3KFbt3kVRQOAN6QhGhO6S1Xos/sDJkd6qcu1errIwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTsV4zwb4zgpVqIpdrBV3FTTR9ItdOGJaCACyvjB0iQ=;
 b=QsFk/yKwxD28P502PWNwIx/tRvtf7Fg3ODZ1Q4BCn63IbPWbH69vM3gUPZ6RvOMI3C9QErU+7HeqRhM1eucXcDA/BueB1gfB7YivSp/FbLWCzrKqejyFpbjhlUEWM0Z7lhYMoS9YzD7+oyu+ynjlGwOUZkBwpwKuTxNH6tMMf5xPxvWRFXuVSKMA2+P/BTM5W9Nl0HXZDwgEq3pUy2tsjLK4Vatu78V81qOM/zCy2pzsyazxmIvnwFdZZ6F3ZF19nylaQMAdlQKMHseRS7qkFz4MaB2kj3uwuWshFnJBrK+gYbCXys21XMJrV7al8IDpyxQXCbPUavgDPLQ84xrZPg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB7104.namprd02.prod.outlook.com (2603:10b6:208:1f5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Tue, 25 Jul
 2023 19:32:53 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6631.023; Tue, 25 Jul 2023
 19:32:53 +0000
Message-ID: <2399f5de-6ab2-26cd-67df-517b0fedf323@nutanix.com>
Date: Wed, 26 Jul 2023 01:02:40 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v9 06/10] migration: New migrate and migrate-incoming
 argument 'channels'
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZMAWcnPgZJQvB93A@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MN2PR02MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9aaa4c-e350-4e9e-5a29-08db8d45f06b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/5J2ag7/bXAdAp+U0sPh1Q8nuM9i07PYc9+Py0Us++OOdzZw1LkVvrkx3bKfb96CGesn9pC8zQon3/+9RjTT/tJmLv62Ld4iCw1Eej19yIw/gmVaOgqW6RslS5TXVNDSn1Rs2PO2jGzCZXcPJArS1+hS+MeYihh2wqbbZIBL9b7jOEzoZMJORmj+96Ur78aFlsZRH6232O8j/q3HkP/kcyhXkbvmkovSbw8GBy01aWV3fyhruajLTek1Q0OLzupVheQhJGalk0adRAZ6ynWkmlmPeOomj3OvcnlwgWLLYtc7BSX7VIO+KM6v5/HZGtgzLvDugaABk2+ZpL2S7wltuxpRxULv7EY/e/4Uk9d/+x333DnLU8vjgX0j+O/oN8y22XzFOkW8nASqbGOTVqmozjn2FHs0MalNnaZSHDnJnyNWfh4P3BGjp8HgRjWnUNeDHIehSatbUr78/64WGno/Zmc0gpTMShnZkCJ7l8xvp60+F5xzV/FRsT2hPNJjEBco4ZPOA2NfcG4hqFNwCFlOtgpUsVovctI6sS9b6tVLNSivjfzG0U8BoL9QF6fnpFsJptRv1i34OykwdSjeEv5fwegGPvG7ShfaBgeTanUCXO/JAVWw+K+W8Poy4drEk/jJgMTAUSxPOeEoB9Ih+ycwvkMFogEaWPbIDObWuCjrnypKlKe3TYqmxhQuKayujUT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(6666004)(2906002)(66946007)(66556008)(66476007)(478600001)(966005)(6512007)(83380400001)(110136005)(6486002)(86362001)(31696002)(36756003)(186003)(921005)(2616005)(26005)(53546011)(38100700002)(6506007)(6636002)(41300700001)(8676002)(8936002)(31686004)(5660300002)(44832011)(316002)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alkxU1JUc3FIa09lZWRoWlRaNDRXVDNJWjErN200YUozUWdINWRGS2lKZG1q?=
 =?utf-8?B?MzdVSC9QQVovUzQyamozN01USnUrS2cycE9NaXk4bFpURXYybFJ6RHNKYWJU?=
 =?utf-8?B?RGpTRTRiN0RhNkV4U1VPSVJ4RTZDQ3BwL3N0SWZ2cFhTY0dUTGJYOUlvaytx?=
 =?utf-8?B?RUxFN2FjT3dodGVKWnBTMS9uUDd0Mkp5emNZV285dHdzbDFQUVcvaVBnRFlm?=
 =?utf-8?B?MXlEemtLdTdhY2l2RmZlNlpHTEJjUlgrVkNFQWxqeUNodlExMExPL3lUejVE?=
 =?utf-8?B?Q09ZZ1dXWktiS0VWNnFxU1RNd0pRVHpXU0k2ejhrNzZqWXBaQUtMTjFGYkpx?=
 =?utf-8?B?SFJ6ZmM5U3UxemppOElHeStSOVlzUWtjNXNBNlJsL2gwN2J1Qjd2cEhsYXNn?=
 =?utf-8?B?YjdYc2t4alRaV3FpT3g1RXdNUTBNcHR3QkdzaXZlMFJiRTBLRTdXS1VTcWps?=
 =?utf-8?B?THBpLzN3dnNHNGRJUVUzazIvNVZUd2paby9iSnZEV2t1MVdndjZnUFdDaVNE?=
 =?utf-8?B?eW5qL1ZsVFJSaS94WW5KOXlYem13cnh3TlRKZ3F6bDd0TS8zaW1qa1pmUStF?=
 =?utf-8?B?OTRlQkR5YTJSVm55TjhzVithZ0E3ajBkNXlpYzRyMzZPNkc2OWRKOXptVlBv?=
 =?utf-8?B?Nk56NWVuY3YwZ3ZTSklmK0dJdmdSMXArNnBvVnJhaXNRQXpncS9sNzRuMWpm?=
 =?utf-8?B?dWNVS09FR1RKbG1oaXAyeFN4TGgwUGhESi9qV004d1dwdHlRdVFrbFBkZWhZ?=
 =?utf-8?B?bGd5S1czbDZrd25UU0RaZFBsbTV2Y0xoZGpFVlozVTN3YldXdzBhN1E3OFpp?=
 =?utf-8?B?LzhwbWh6ZU5xK3dIVUNoSjVqK3VDYUdnVmJ6d3QvRWFTT0xVSXgrOGd1V2lW?=
 =?utf-8?B?ZmNWb3hMVDdXMlE3OVplY0tQNzRTUjE3bk1EdXg0QndhUlRLVXVRTmN2RkZt?=
 =?utf-8?B?ZXN4NmtkWmJtdXNRVE5LSEc3SSt6cWhpUU83SEhDSzNSTVdPaGN1NG1sbHha?=
 =?utf-8?B?a2VYTlhuYVcrWGZYNE5rWXc5LzREa3YxS2d4QWJYcXdaMWVoZDR1eWUyeEV4?=
 =?utf-8?B?clVIb09WTkFLZHkyVGNWd0VLaDlGU09hczVtSTMvS0FFcURUWFYyeWMvYU5x?=
 =?utf-8?B?OWVsNFNtMzNMUXJRVE1QaG9jNVE3MTlhNGNWUWZPWnFrQnpsbWZYMU9NOTNi?=
 =?utf-8?B?ZTgyaFlvVm4yM3phUUFDWXdxTzMrci85ZXNuUmRxRnNHRE1YenUvay9Cc0Fw?=
 =?utf-8?B?T2wxTlhVWThXMWpmUXhTK0VjQVN4Z21DVTB0SWtqN1BpbFZXanFMb3NHMlhx?=
 =?utf-8?B?eUxaT2RubVIvcHVsRlc4QSt0N0NVRUc5YjZBS3JHYzRacTZpWXhoSlgzVXo0?=
 =?utf-8?B?UUg0Y3RCbTBKcktlb28xZmpoRmJVT2lkWUZoaDcyNFU4eVFuYzVxczNiZjBa?=
 =?utf-8?B?dFk1NDJkK2VndkpCMEtKUUtxcjNvSUJrYzhsUVBYVDdaWXdmdG5TbW50b3Nj?=
 =?utf-8?B?dXFSeGZ2dXZuaE9QdnRRL2dDVnJvTTM1WnJxVUpiZGZodWZiSzMvS0EwSVBz?=
 =?utf-8?B?QlBXaDM5TjhUZ0pCbW5iY2pJaGF5MXM3bE9DMForaUhhWktLRFo0U3JKamZW?=
 =?utf-8?B?M1pyMjF1Qmd5RnhUaFJBS3UxSzV0VUxJYjIyMndEaVlyak9tSTB2bGtYWlg0?=
 =?utf-8?B?Ujh6TVc2Tkl3UEJWWjlSVXJrcXJaSTdqbUVJa1VscEJoWFlIazVLVWZEbE1Q?=
 =?utf-8?B?bFkvTHBIbFRCbjdUSzM2RVhGTVZmbGxqZzR5TWFaOXEyU3RiMFRMU01zOHNx?=
 =?utf-8?B?YjFrQ1diVk5rWFZwZnpGNXMvUndnWkZNT1dzYnY1UHh6QWZWSEJSK0lja0JU?=
 =?utf-8?B?aFFSSklhdUpOYVRyakJvV1dMMEk1ZHdCZmZuOGdCc3IxOGFJaFBJUkpFeEpl?=
 =?utf-8?B?R0ZKYmFsNUF6aXdHcVV0aXpBdlUrRHNwaE0zL203V0Y0NkNQRFBQWCs5S0Y1?=
 =?utf-8?B?Z2VmNUxJMUNYZ01kQ2F2SmhyVUdyNm8va0hTamxHV1pWeU0xUndTL1ZtaHNp?=
 =?utf-8?B?Qk1xeGxCM0FnK1h6dmJaS1l2amxyNVBYNXdibWs4R1E3TVgwZ01OMGdDbFo4?=
 =?utf-8?Q?qsuvldeiTUzGLzhdiffbvi/w+?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9aaa4c-e350-4e9e-5a29-08db8d45f06b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:32:53.0875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8hDXgV/vYXqNEqPTEsbvbDDLm6MSk1uE32QZtTr3GUaCg5pQ3xI7fSRVEb0jJIAd+4yj4iGPnKiJzOHWBHkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7104
X-Proofpoint-GUID: 32z02bdgHRlcXa_yXmHya3WJOrmY4Ux1
X-Proofpoint-ORIG-GUID: 32z02bdgHRlcXa_yXmHya3WJOrmY4Ux1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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


On 26/07/23 12:07 am, Daniel P. Berrangé wrote:
> On Tue, Jul 25, 2023 at 07:34:09PM +0100, Daniel P. Berrangé wrote:
>> On Fri, Jul 21, 2023 at 02:49:31PM +0000, Het Gala wrote:
>>> MigrateChannelList allows to connect accross multiple interfaces.
>>> Add MigrateChannelList struct as argument to migration QAPIs.
>>>
>>> We plan to include multiple channels in future, to connnect
>>> multiple interfaces. Hence, we choose 'MigrateChannelList'
>>> as the new argument over 'MigrateChannel' to make migration
>>> QAPIs future proof.
>>>
>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   migration/migration-hmp-cmds.c |   6 +-
>>>   migration/migration.c          |  34 ++++++++--
>>>   qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
>>>   softmmu/vl.c                   |   2 +-
>>>   4 files changed, 139 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>> index 9885d7c9f7..49b150f33f 100644
>>> --- a/migration/migration-hmp-cmds.c
>>> +++ b/migration/migration-hmp-cmds.c
>>> @@ -424,7 +424,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>>>       Error *err = NULL;
>>>       const char *uri = qdict_get_str(qdict, "uri");
>>>   
>>> -    qmp_migrate_incoming(uri, &err);
>>> +    qmp_migrate_incoming(uri, false, NULL, &err);
>>>   
>>>       hmp_handle_error(mon, err);
>>>   }
>>> @@ -705,8 +705,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>>       const char *uri = qdict_get_str(qdict, "uri");
>>>       Error *err = NULL;
>>>   
>>> -    qmp_migrate(uri, !!blk, blk, !!inc, inc,
>>> -                false, false, true, resume, &err);
>>> +    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
>>> +                 false, false, true, resume, &err);
>>>       if (hmp_handle_error(mon, err)) {
>>>           return;
>>>       }
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index f37b388876..bd3a93fc8c 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -466,10 +466,22 @@ static bool migrate_uri_parse(const char *uri,
>>>       return true;
>>>   }
>>>   
>>> -static void qemu_start_incoming_migration(const char *uri, Error **errp)
>>> +static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>> +                                          MigrationChannelList *channels,
>>> +                                          Error **errp)
>>>   {
>>>       g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>>>   
>>> +    /*
>>> +     * Having preliminary checks for uri and channel
>>> +     */
>>> +    if (uri && has_channels) {
>>> +        error_setg(errp, "'uri' and 'channels' arguments are mutually "
>>> +                   "exclusive; exactly one of the two should be present in "
>>> +                   "'migrate-incoming' qmp command ");
>>> +        return;
>>> +    }
>> This checks is both are present.
>>
>> Also needs a check if neither are present as that's invalid.
> Also it should (temporarily) raise an error if "has_channels" is
> set, as while we've added the parameter in QAPI, we've not
> implemented it yet. IOW, raise an error now, and remove the
> error in a later patch.
Ack. So in total there should be 3 checks right. 1) if 'has_channels' is 
set, 2) if 'uri' and 'channels' both are present, 3) if 'uri' and 
'channels' both are absent. Basically right now only uri should allowed 
and should atleast be present.
I think overall only 1) would be enough and should be checked before 
'migration_channels_and_uri_compatible()' and if 'has_channels' is set, 
just return for now. With this 2) would not be necessary or not come 
into play in this patch. 3) will be taken care by 
'migration_channels_and_uri_compatible()' itself IMO.
Let me know if I am missing something here.
>>
>>> @@ -1694,6 +1708,16 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>>>       MigrationState *s = migrate_get_current();
>>>       g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>>>   
>>> +    /*
>>> +     * Having preliminary checks for uri and channel
>>> +     */
>>> +    if (uri && has_channels) {
>>> +        error_setg(errp, "'uri' and 'channels' arguments are mutually "
>>> +                   "exclusive; exactly one of the two should be present in "
>>> +                   "'migrate' qmp command ");
>>> +        return;
>>> +    }
>> Same here
>>
>>
>> With regards,
>> Daniel
>> -- 
>> |: https://urldefense.proofpoint.com/v2/url?u=https-3A__berrange.com&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=i0lmmIrs7N4r3uqLYCdRVXLFaEavt77Ltkec0hIlE4aUQITo9-8povsDHWELv-vE&s=AQ1C7WPg2jLYjNXU29Xw7trQcjmB96Yy3-God3-UaIQ&e=       -o-    https://urldefense.proofpoint.com/v2/url?u=https-3A__www.flickr.com_photos_dberrange&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=i0lmmIrs7N4r3uqLYCdRVXLFaEavt77Ltkec0hIlE4aUQITo9-8povsDHWELv-vE&s=aiGUx76ySVL-epTmaFIZUyZbkzeXGedVaXGvFw4xcgo&e=  :|
>> |: https://urldefense.proofpoint.com/v2/url?u=https-3A__libvirt.org&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=i0lmmIrs7N4r3uqLYCdRVXLFaEavt77Ltkec0hIlE4aUQITo9-8povsDHWELv-vE&s=beFwppzRJ_eYlYPZKHlSZpaysLC5AExPh5_inAZBu_k&e=          -o-            https://urldefense.proofpoint.com/v2/url?u=https-3A__fstop138.berrange.com&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=i0lmmIrs7N4r3uqLYCdRVXLFaEavt77Ltkec0hIlE4aUQITo9-8povsDHWELv-vE&s=q6fb1PbChin197qfXnyXa1FpzaC7GecQJOzWO1EUQTo&e=  :|
>> |: https://urldefense.proofpoint.com/v2/url?u=https-3A__entangle-2Dphoto.org&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=i0lmmIrs7N4r3uqLYCdRVXLFaEavt77Ltkec0hIlE4aUQITo9-8povsDHWELv-vE&s=lUJpjpbEMjPFyDvx1GXWR5yrxWfQqTyLI42J5oxavgs&e=     -o-    https://urldefense.proofpoint.com/v2/url?u=https-3A__www.instagram.com_dberrange&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=i0lmmIrs7N4r3uqLYCdRVXLFaEavt77Ltkec0hIlE4aUQITo9-8povsDHWELv-vE&s=u9HElHtI7mdNiWq8I7j1GpnUObfjfopMmpLdvGZRI8k&e=  :|
>>
>>
> With regards,
> Daniel
Regards,
Het Gala

