Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03F7622B9
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:55:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOO7l-0002tS-LV; Tue, 25 Jul 2023 15:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOO7j-0002tJ-HQ
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:55:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOO7h-0003IU-7h
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:55:11 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36PGFx4w001614; Tue, 25 Jul 2023 12:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=jieQpQTWj02WPMxIouGQ6Gfgoy8ICnEkDHqhZPxiN
 og=; b=Mxel5T04pPqEtkEcs6N7E6Za9i81rFNu+royHgsdGssMAT946Nsx2VgPD
 SCKNMlGIipZbMSeMleefOdJAFsV90VmBRxjJnOUJ29Vq/whBEpU+aLOf8vZlEoJB
 R2qonHn6gF2iSzrQPrt3hHulceqx/M8ciiAGeKw5QRJwJtC+Dk9A6E5iZxPIO1Sn
 kiwiYPU2Pmdsxo+aryAGOlhPrgQ07jz7KCOPBklzujjgNR61ZGfBoj62RMygjTON
 vblmx/IvZPqhwAFSebpu8HTaKYbIZKHRy9q5mDZXDREhIu75lcFgxJXxX4ycM/3g
 mwD+qUFtPdLv066EmDc+bZxtCV3QA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0eec6hth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 12:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9vcfRz9Oz4gwt5jKFEVKR0xVQuTPX7np5HvYz1jViaaYHhdrBy/+0X8ICrzPSw8BAuLxlKSeA3LAelmYRONHgStOXU2OdCLapBF5o1pcjeGAKphwTjT4DSOZMK5OxW8xP0qTYbPgnmLqDQzYRe2si4+MW63cHC7l5EzXH91ZcrrqLih1Vu+TJ3nYtglbN8qSKN/Yh8XE+PZq8LcJf9HZmOMt3B3zNQT/hDFVnqRe8mJ62hLzqp4vVMWQe5eV3H+hnyQXL7UmT/qe03S1/Rd7UdsVQWs5/nEEeQxXOvatap2HqApLRNsjTXywNQbf7ZAwTAL+wuTTuy+kGiWRB/S9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jieQpQTWj02WPMxIouGQ6Gfgoy8ICnEkDHqhZPxiNog=;
 b=nDvIHHrWdQN0goU99Xtd6slPn3d8Wbx4ohWG2CdSND8YuYVk6ygCjRsHK/OiZ/T1LTakTVc2nqh2n+aS5nHrctua3TX9IQ3njfPrtZAu61Sov1Wjr8CZoEgh4FR2BY96KwTo5gV4ndP2NHc5IdGaZEi2RE9P9N4a1AdsllyGhx3KnTqyfv2hZuV2IQjvySRiSX67eeBwLi+xOTPzc4d3OpCiQypmQH0iqR5dGo31f4QPfGAV5ZIzztoMBw2vfLY+fuho+l3VEsAKxZlQMFxcMUP+1PfTPPey9hm/odWRSoIi6cxgPmEB27NhxtLSJSj8bAFf0kgRiPJDVKZvb68b3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jieQpQTWj02WPMxIouGQ6Gfgoy8ICnEkDHqhZPxiNog=;
 b=SolN5E+xgeDPa+ZjGiUp3VARM2JmfftRN5+YEtM2RNgt+QViNz00DnCGAUytoL2v1XYyIVgeu8JAs6R3nMd5W9C4W+JZJ085qMdfOGBtugyXjI45JNQ1n60EmPMbAgpZR9a94as+SAzjF25vVRnPEi6DY5jf46AAx/Jp0acADS+myNMNeuTHRkt4JbmAKIA5MsjBCnmP88uHraXnPCfvduhxHps7T5YLyrccmGsS+0+Z5WLH36MAXXyoe3c6L6EkWkCs4AVUmeecOPYNUnRzLCm0nKpelJiEjiKylgLKeW5SM00Y7tOPdN15rhfAd7X4DoHydOeJjYKvt/K43Qd9bA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DS0PR02MB9175.namprd02.prod.outlook.com (2603:10b6:8:13f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Tue, 25 Jul
 2023 19:55:03 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::89a1:d75c:813:618e%7]) with mapi id 15.20.6631.023; Tue, 25 Jul 2023
 19:55:02 +0000
Message-ID: <f5109fbe-ce45-020d-fcb7-e32892d9135d@nutanix.com>
Date: Wed, 26 Jul 2023 01:24:48 +0530
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
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DS0PR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 6287e1e3-b5d7-403f-1862-08db8d490911
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4w7aqyR/nrP6XT3tjlD+OuNk4uCd3Iz9gzMWkzjM6whBWRHJzYX12uf6+Vt2UECsLSi3V9S3BGQZtBnBDfecIj5uMsTZRtgLXy6pl5ge4mxflGqFCJPb6YMo00PRa6nTLmijgvn1uDH79yk0FIpbrny2aS6PSVE1lMEBPwGTDGsNBd8Vb+IQ99wLH217JWaNKboIUIWqdCDEmNGndjbLHpUkbFmG4vsBF4th9P1X12tkzGL0z8BzGNiLkbqa+Rjh578mA3uW3SrdQYhMGDgFCVlALtd4GjQvf+ltRCF6eZIKbpf/uv2TsiYf56JOKkgfLYnSjRPGHibeSUMb52KxlWgxNA6GcSSfzBtpqqYCyEQ0AhcgP/iRmcDK1wz+FRZCQwPGOCAwNiSkinMQxqjfJCLm44q5Q7Hyv/4/XNr5d3Q+Dl0ZlNkE2ef+/cWF0RyCZ4IMRavAEgH2Bu8rnoLC9LULwM5QsDkDjwgTCyj9Ayp6YDq4gzMUC8yKimbdQP7wnbCuc3Te8Xd3xN1bYyUOtXJotU/UVhIpZ7pO3DZxRCmafjgMNl3sUhMOtLSfpp72APYs5r+sBdQKXCZnkf+mdfV7ubgyH5ZvyG0KSROtXNZx7fM3LX1GdeJdzcJ1K9p1DMTkhflFoJtpzGKC9ErsOA+wj1lPvRN9OM0rweq5rKSTwWEtq+iejNRm8ysJuSwH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(31686004)(966005)(478600001)(6486002)(6512007)(110136005)(6666004)(86362001)(83380400001)(31696002)(36756003)(2906002)(44832011)(26005)(2616005)(53546011)(6506007)(921005)(66476007)(38100700002)(8676002)(316002)(41300700001)(6636002)(8936002)(66946007)(5660300002)(66556008)(186003)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdCaTRsOTB1K0tCNGV0dVdSTGxXN3Jld3pwOGxQYmFvWlNyZXJldUYxMEVN?=
 =?utf-8?B?aGxmQVZZV044cHRkRFh2Nnp6OW5kVXdlcU96clEzMnJ2NHJ0U1o4RThYaGRp?=
 =?utf-8?B?QS85ODQxNWNHMnZoaDRodkVDQnRWQ3VpODRUUTh6NXBCaHF6SGluYWlFNHlU?=
 =?utf-8?B?bnFTbnVYSWc0N2c5cGRlZTVpb2g1by91WWxQeGE5Z0ZHVitWbDdpS1ZmZTR3?=
 =?utf-8?B?Z2NoSk16d0dvM2t0RUpTbmVhYkdBTno3OEM3MHhYblJldE5RQ0YwVll6V3Ra?=
 =?utf-8?B?cUUwYS9nbWxXTFQ4TklVdVJWa3kvYW5hMGhtR3I5b2xINm1hZjNLelphTko2?=
 =?utf-8?B?ZW1TMXVhTjBhaW80WmVNK3pRY0h2eFFRSGZMTlVGNmU2VXEzVWs1aU1CK2tF?=
 =?utf-8?B?dEd0a1REcWtLVmFWamxQdHV1QTZ6c3hHT1BSYjF0OFZWVmdudEZPRk9aeFVp?=
 =?utf-8?B?VGxXaUFIVU9LM25YNkFpRWZiaUhESzdtKzYwa1J0QktMVzVhSitoa2U3SVlO?=
 =?utf-8?B?VkdReXlYVmJmK2cwS1cxNThmUFhHTVFEWFd2ZHBzWVhva2hBNTR1L0cya2Ji?=
 =?utf-8?B?T2VuN2NCMFVoYmFkcmVUMEMvK2RTVnhBZVdJRktUNnpqYldKYXBydU9IaUxG?=
 =?utf-8?B?alg5WkV5YkhNUVFlUFpLV1NWS1J5ZHVISG9oMFBtYit4NHdvNXpkZHh3Yy8r?=
 =?utf-8?B?d0RZWFU0RGZ6WXRqWi9nVDd2VVFkTWtGUW8rYzd0bkpjQmtWK2tZakoyUHVl?=
 =?utf-8?B?MTJibDc3L3NMV0hOYXF2R20rNmR2cGRudXVIbEZLVVpjUzh0emYyRGoweHRu?=
 =?utf-8?B?ZW82b3JWcG1MeVpwNFM0NDQzUE42eDJ1bVJwQkI3YldvRjhnRFdtTDBqcEps?=
 =?utf-8?B?dktvSXVENlNZV0lzU1hsRG1ra0prOTZwTFpYT1BxbUU2T0czTmlZK3NxMlRo?=
 =?utf-8?B?ODkzZXpxM1ZMMFhqYW5vamVZL3BQK2dqVlBOTGlGOVJGcVN5YmxDOVFCK200?=
 =?utf-8?B?K3JaYWVjR1orOE9IcE4xd1VOQWxMR1FLNXNqdVNId0pFZnNIckhiNjkvYXRQ?=
 =?utf-8?B?YU4wVmRtbEl0N1ozS3RQVzVnZWNWNjdIRUxmZnJzWnlzS0szSlVDTE5oaW5k?=
 =?utf-8?B?SUN4RWY1TzdDcG43UXlOV2hYTkZQWHgwM0tzUVIxWVpDWjlVeUtoNUxVNlBF?=
 =?utf-8?B?RWVJcWdvT2RJTnErVXRTNWY0Wk9uNzJGY3hoZGt4NVdINmUvTkdqR2ZGb3h4?=
 =?utf-8?B?c2hwTnBuVEJnODBad3dLUmZkSUdRQmQxQ09qNnh1WTFvbFVXaFUveTluQXJM?=
 =?utf-8?B?c2MvSzl6VWN2WXBaVlp2WlJmK1ZzNmtmU1B1N085UjZmMkorSlRFMVVaa1Bh?=
 =?utf-8?B?ekx1ZnZFNWtGQ0ZvaU9ZdXg4Tkp1TnVJNENwOEJpZHh4K1B3N2YwWm9KblFy?=
 =?utf-8?B?aDhuMnd2MDljSFJkc3M4RFgxM3dmaVNZL0gyTCtpa3Y5akJ3dlZoRzZQQ2Yv?=
 =?utf-8?B?SGJydnZ2bFFqUUZqYnlIUlUxT3YzRmlUTDFhOWtUODQ4MWhJREl4bkxrbFJV?=
 =?utf-8?B?dzQ0ajV0ZW80dTJydHJ6eXpCWlZ6emFSQW5yZktrSE5OVk5GUTlLZ2lBZ1ph?=
 =?utf-8?B?eTdsUmdRMzZEeFpwTlZLWHhqK0dUQy9Nc3lrcklHbDNhbFlRSWlmVlRISktF?=
 =?utf-8?B?SXNvV2I1L3U2blAwbHV4SUtIbkxJQ1RHQmk1TmN2Q1VLU09wc0ZpdndIMUZ3?=
 =?utf-8?B?UUdYKy8zdU9oZ0xUZENJeSt4STRVWnhONWExUEhya0VFVnRJNHBQMlNWektB?=
 =?utf-8?B?VXFldTduSnR4R1c4NjNCMk15QlRUbUZmbDI3QllqSjdsc2lFV0xRbUpzTUNW?=
 =?utf-8?B?OHFLZ2FrckUvMHQwaDNkWUpUWEYzY2RGWXd0SktiODZJUE5FeXlDSkpqcGRt?=
 =?utf-8?B?cWduRXlkU3hFL3c4UjRCSmJrNDJxTXlJK3hMNWZNTHRCRzRvTDBFWFB4aVpR?=
 =?utf-8?B?RlRTczJnSXJkT2VFQVhURS94ZFVjbklzalF2b0d5ZHV6SjBMWUdTSUJqdVdQ?=
 =?utf-8?B?a25qN0tBTXc1QXRQNXkwblFDS3BoZWgrQUNoSmloam1WRlFIREJlOU9JODdK?=
 =?utf-8?Q?A0v1LrgJUzaanwrV5plSdqLcW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6287e1e3-b5d7-403f-1862-08db8d490911
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:55:02.8759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+VWJvFRGwnkKyb28qn6Rg0RKs30boYmwxTHo7P7sUr5I9+O9tqtnKcBOGrQejIRcnUnCLJF8UU0LtW63nL0bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9175
X-Proofpoint-ORIG-GUID: 3RTdyR9AGewV-5j6RsNPwbNds2i6MvVz
X-Proofpoint-GUID: 3RTdyR9AGewV-5j6RsNPwbNds2i6MvVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_11,2023-07-25_01,2023-05-22_02
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

Sorry, last reply on this patch was accidently replied only to Daniel. 
Pasting the reply again so it is received by all the active maintianers 
here. Apologies for the error 😅

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

