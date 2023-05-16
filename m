Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B017044E0
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 07:50:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pynYU-0006Gm-EK; Tue, 16 May 2023 01:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pynYA-0006GK-6v
 for qemu-devel@nongnu.org; Tue, 16 May 2023 01:48:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pynY3-0003U3-Qc
 for qemu-devel@nongnu.org; Tue, 16 May 2023 01:48:40 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G4ngEQ005486; Mon, 15 May 2023 22:48:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=k0MiZw8FWmggtI1fMsYvDPD/FOa6kG/FOX1gcDRXPCo=;
 b=dEgp4EtMAGQ48QbrnTxvGoSE83jj97uhb3emfMe3lok0dU78qbVpfwJYVTTssalowhVI
 hfCJS6VgOIijrNxGuhIe+npiS3+1nkvDmy3liscwsWMpr1a40KmovVdVXORmpDH6j2OO
 c1bZI5sDUuENBJmbXPoD1XADyz+TnYyv2mfyQBNulzmWeo3qLW49W3qSS9AoOgwYUtFu
 75w/4ynnDSuJ6lUUnNO+7X8Pxgt65VTs7lkjwoFjQV9FJiotxmCX3UcVRJazPyvwJyRW
 +yh9+FqQcRsLtf5Ko+YbHC2iqW+dkatHNU0jCxfib8uYr6vA5nVq6cf2+UYD13qLDpRf lA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qj9veda6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 May 2023 22:48:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivlZthmwut0YnczcUcWSKdU+qZKOed69cEuSWdbUys2d80ruU8fxoFgO4CCbEHU8Fx2WNeJcDSktFHkOU327pHjCsg2tsMk3LrW15j6Ho+LsLRiFJmLYl05nu2JlBdDcKPvYrSqTaUFFC46o5b9+LVzlJ+D5GgZw6fbeYpKXM2/ksNG+mF6mOPshCsKI6uy1MHbdXXS6Mn0+ENDrCgRA120rrD2JcfgNvuLu/2Y/kMUgu8w8h/YIcjalPAYbc2B3r0c1FOwrvS3zRFTXBbB0ldc5ZiDLPrPHqvixqHMc8Epc2TwNFm1YpWd4XO8tFMzlBycL8+cl1Hg6lrlWOE+2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0MiZw8FWmggtI1fMsYvDPD/FOa6kG/FOX1gcDRXPCo=;
 b=D5av0f5EtxHwdaVmGwriT+nAmlXQf6ZcPeI1XcL8KJ0dXeTJM/Qf5YgQZsF+D1CCrH1OLAxhiEfOOyEtLF9TDbbgqIp4JVe0XFeOLp2nH9E/MuFIJLLx3qgSss+OLiHAdSKbhMqPJX6hvmsaJyBx36nX+GqElmcx2Zc/L81gE1En5EN3yDxGYhzS8ZNqhkIed+6pRifXaGw3EMaXiki9VcPmheVqNjiUVhd8sFfUgdfLZhoDvvc0ifBU0rC4mCwbWvcFuvMFCm3m2KYVTm6BEy2dMA0d0smD72MVzXQ6wlAYMqTBy95U09c2w17P38B7X3sXRgZatvotdAdjfEV0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0MiZw8FWmggtI1fMsYvDPD/FOa6kG/FOX1gcDRXPCo=;
 b=lwFU9HDSRnwBc7bUE4Cq7ksDuC+IKlCt1y+mwHW2AawMPT5SoKLoy+i1iSbGucN5w/3m4p3EIh61J+66aHYPMKH2XUOGgslIb8dZtPgoSvIVX+HFqFCESHQPxuSJxoEq7lIA1CCEXkn00Ib4d7j73Wf3e5FXIh2h2CfEt450dumorpLWBk1OAb4u9lG4+x8YY3oX0e16JTOTocQBUuTuvRQYhitGvZH5ieKdWkznZUPcym6OGc4k7NxtXuDmn5FuXZdSmiSJBRURMxHemU4x2BLLwHkZW3NghaGsGNJSGhWhAByJtLIjBW+RwZrHxNC9Pov183Oa440m8oFcHjAehw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7495.namprd02.prod.outlook.com (2603:10b6:510:12::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 05:48:27 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 05:48:27 +0000
Message-ID: <04881f8e-f903-9886-a39f-141605d634a5@nutanix.com>
Date: Tue, 16 May 2023 11:18:16 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 6/8] migration: modified 'migrate' QAPI to accept
 'channels' argument for migration
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-7-het.gala@nutanix.com> <ZGILNQxb6VD0CwSR@redhat.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZGILNQxb6VD0CwSR@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|PH0PR02MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 985d3c0e-3408-43bf-2cd2-08db55d12b4b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rde8iiDwMEqlArxaRqQ4ZDSoe/psDHT9aM8hzv8hImkzf9wFkASNLAbK3aFiBI8taetClZoOIGM/kEcWDTNprnLzzk0E7xT7I5DRUZWZRt8Mx/wmSC7ENc19NUUrTJGXyxNpROcLvVJf/16VjRiduWdrd9NvOr2v6kujUQpZ0p4tOTC7bl4CT0a9CdPmWm3ZhekYvvTNxmOo2GE9rVyaxU5dBYFuCBOu5FmjgywtunMkeT2PZZio7hvjE99atVMQYXmRhp+Z6QIGZUxYhW0UOcFrcx82IXVMzSahrnnV4PyYF5AusECaFWJLgBILXAYib7SnAGxX+50yfAvKvZ2qSwEYdgXCnHqf8rJNW/YIDBkZG4uRHXPEChiqLT23AhTix8y2omiz1939ScBBFnUPcAI75G27ZXYM+ZC6wWtUA1Ur8FFE/9GEHAVoO6hsmJZN71KS7PYPqXZ6KCkvRy9ygPnFwJf8LpU6zQ/zLwFWLVZmQb3jjbb/pCxOJ4tHepySATzTYlrJVNTYWWchKayYDBYlMRIF2r37+Jl80pLWZ6AcKDTHQP8Ro55GFbq3SszqeVmdQE1B2i2uZzRCF5MzIYF/YflRKVQXxAE41Xxs+q0iahuBZ3IZfyHgcmVCRfPtnb6Lml6XusmkKFbc3C3obg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(66476007)(478600001)(6916009)(4326008)(66556008)(66946007)(6666004)(6486002)(316002)(8936002)(2906002)(8676002)(44832011)(5660300002)(26005)(107886003)(31696002)(41300700001)(86362001)(36756003)(38100700002)(2616005)(83380400001)(53546011)(186003)(6512007)(6506007)(31686004)(66899021)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHFQM0N5V2lRNzF3QmtzNExUMXMzZXlNcG9lbHg4MVFZRVh5ZCtrb2YvQktR?=
 =?utf-8?B?MlM1RXZvWWx5WVcwMVBWdGlUVGk1ZjkrNkNNZ0dzOXVYaUQxUGpBWTNnRU5Y?=
 =?utf-8?B?RFhVYUdiRW56YWV6TjEySEVuK0NJUkJqbEVZY3Y3c3c3UHpOeFB1Ymw5MnpL?=
 =?utf-8?B?N21lMlEvZlNhYVRhUFgvK2Uzd1ZZZWc5TElxb3JWUkc1bUNBRnVVY0I0M2hr?=
 =?utf-8?B?MTNJU2VLZGdqM283d3QyTmJLNElycWxXaWdzam1LS0g3ZGVkMC9UeDJ2SU1i?=
 =?utf-8?B?L2FydjJRMEord3ZkME9aNDAxS2V2NWdSSGJNM1UzWTRLcGNrNkRpbFdUZ3h3?=
 =?utf-8?B?cWVieDl2SFFIclY1QlBDcllWazBCK28wQXJNTitzNWx4RjU2V1FWcWRwbUZ0?=
 =?utf-8?B?M2JpMCtXTElxM2RzZEVvNVlwTi85SjUzb1RZeGVTWWtQaVZjN2VraTczN0hm?=
 =?utf-8?B?Wk9YQTZIYm0vYWluczd4OTBsTEozbG1jcTFFdDdMMFc3ZS9YNEtCMXlwMVFy?=
 =?utf-8?B?dmMzMjdFRllmYXRROFprQm4rNE9QemZOMUdubUltSjFPem14T1JjT09pOFRo?=
 =?utf-8?B?bFBPeTdGNGNZdENZTG5tQmJsaEEvTHprdDBlcEtIMytCWUpWNktDVjNRc3VF?=
 =?utf-8?B?TEdqbTBaZWtCYU5Xb3QxamN5N1VZWUJYVUxuUjRaUk16TDJxL2tlY1o2ZW9J?=
 =?utf-8?B?N1RoZzdsWlRBK1o0S2FGcmtPZnVqMUlVSmpxNTdqR1VuQXhkWVBWSDRCdG5B?=
 =?utf-8?B?OUxQa3BCVEFCQU8vQS9VcWthVFp5dERXVUR2QW1SL3U3a1Y1ZlBuVVp2c1JY?=
 =?utf-8?B?VjZkUFpXUThtK3VlNkIxQ2JjK3JQSWF5Q295emdqNXpGdVRCeW14RWc4RUpK?=
 =?utf-8?B?Mi83SVhzczExNWI4Y1ZEczJKTndHTE9hMVM4Z0VLZ1hxK0E4MVBlTjIwdEtX?=
 =?utf-8?B?ckFGclZXa1c1UnBsY3FLVUt6ZlBxWmJFTDZHeWtxS21McnFmMGFLcm5RRFdv?=
 =?utf-8?B?M0pwcEcwSlhCNDE5UXV5azdOQUJrdTROeTU1bjJ6Ylg0Snk0WXgzL2VrU0Fy?=
 =?utf-8?B?dzJoc3h0RWxoUHRTSW8zbDVEQkpIUlVzNnBzcElKL08xUmtuUEowbm1PUGhU?=
 =?utf-8?B?ek1EUURWVFE4dStUN21adTVldHZ4YnR4V0IzRGtBQjFvL1h2enNXQmQvTFhz?=
 =?utf-8?B?VDRvS25rcHllTllwUWU2NXVEUFRTcENsM2F4d1VDelAwTml0ZzJMdGM3K01z?=
 =?utf-8?B?NXZmOGM4TG1BY3V4MVhlSXIxcDdPQXplWkNmbVFtQ3hIdFErR1JtVzZRdk0x?=
 =?utf-8?B?Y0hCU2x1VVlBZHF5UFZnRFAyNDNHNStyTUpPOGJYeFFHOEpZbHNsRDJuZTFO?=
 =?utf-8?B?NVRZRThDU3dkSWJLV2ZCQjI0YlRlTCtlT3JtVGxFUXlTSUVJTVp5Ym04KzBL?=
 =?utf-8?B?azdXZHpYeDN6cW1wb3VjRnN3TmRpcGV3WlRPalpxalZvNmVvdWdaMElzYmdY?=
 =?utf-8?B?OEFFMVNaaklJRnBXa00rYnI0THE3NXFoVGZxYVY1bW5samkzdHBEM0xESkhz?=
 =?utf-8?B?NGZ4VVV5eDNzazZXMXI0eUQ5aVk2RGVyYXFCY1RZeHgwUUQvMy9kVXcvTEhK?=
 =?utf-8?B?UWU3YWJvSmc2aS93UyszSisxenZFT203b0dMdWhENzByRU56cVhGRTRxQlJl?=
 =?utf-8?B?L1dzRnRJZlFHMytjUkxnRjRiaXJ6NWNESDNYeWpGZzhnVmEyZ1lmajQ4bXhP?=
 =?utf-8?B?Z2VVL2FtUFBEQ1JrcmVrWDJ4M29iOEtaSGdEbFNPTFhLM1U1b0NXQlRCS0tv?=
 =?utf-8?B?Wm9vQTc5TzN4U1BPeVhVdmk2TkJsOTVZdnA2eGwzV2lpTFR2VTVoUFJQTitU?=
 =?utf-8?B?R3NsSUpYSVpTSlVjdG9TdnZtYjNTNW1RbHZCazVWS2V2QUozQmVrZnFNWnNi?=
 =?utf-8?B?Q2NhNWtGeGx1b0ZkQytsMVdYRUZUMVJIOGl4NjFPOXp0T0FubmF6QnJWdlJt?=
 =?utf-8?B?eS9ndCtNTU8vM3pzcGFxYitPTVU2QU4rK3ZMdi9WQTNyenQ2N1lNUFU1TnRC?=
 =?utf-8?B?SDNmN3VUdmRjY0tDZEQ4UkNGc1hrYzY3N3hQc0JyVzMwU2p1ZmFycjZDNVN0?=
 =?utf-8?Q?BrDkEBoJ5um6h0uOqZfGb46hC?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d3c0e-3408-43bf-2cd2-08db55d12b4b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 05:48:27.0652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chtD8suMGmcHG3Ts9B9xjgj7qqADaq9UASjc0fPslpLrlznmgeWKw4OrZPfqa+TarnupwvcM1n58P6Ere4ET8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7495
X-Proofpoint-ORIG-GUID: WKDzERxlz5n4pmfjLH6lGURjcQPCD6f-
X-Proofpoint-GUID: WKDzERxlz5n4pmfjLH6lGURjcQPCD6f-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 15/05/23 4:06 pm, Daniel P. Berrangé wrote:
> On Fri, May 12, 2023 at 02:32:38PM +0000, Het Gala wrote:
>> MigrateChannelList ideally allows to connect accross multiple interfaces.
>>
>> Added MigrateChannelList struct as argument to 'migrate' qapi. Introduced
>> MigrateChannelList in hmp_migrate() and qmp_migrate() functions.
>>
>> Future patchset series plans to include multiple MigrateChannels
>> for multiple interfaces to be connected. That is the reason, 'MigrateChannelList'
>> is the preferred choice of argument over 'MigrateChannel' and making 'migrate'
>> QAPI future proof.
>>
>> For current patch, have just limit size of MigrateChannelList to 1 element as
>> a runtime check.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   migration/migration-hmp-cmds.c | 113 ++++++++++++++++++++++++++++++++-
>>   migration/migration.c          |  17 ++++-
>>   qapi/migration.json            |  69 +++++++++++++++++++-
>>   3 files changed, 192 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 4e9f00e7dc..f098d04542 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -51,6 +51,101 @@ static void migration_global_dump(Monitor *mon)
>>                      ms->clear_bitmap_shift);
>>   }
>>   
>> +static bool
>> +migrate_channel_from_qdict(MigrateChannel **channel,
>> +                           const QDict *qdict, Error **errp)
>> +{
>> +    Error *err = NULL;
>> +    const char *channeltype  = qdict_get_try_str(qdict, "channeltype");
>> +    const char *transport_str = qdict_get_try_str(qdict, "transport");
>> +    const char *socketaddr_type = qdict_get_try_str(qdict, "type");
>> +    const char *inet_host = qdict_get_try_str(qdict, "host");
>> +    const char *inet_port = qdict_get_try_str(qdict, "port");
>> +    const char *unix_path = qdict_get_try_str(qdict, "path");
>> +    const char *vsock_cid = qdict_get_try_str(qdict, "cid");
>> +    const char *vsock_port = qdict_get_try_str(qdict, "port");
>> +    const char *fd = qdict_get_try_str(qdict, "str");
>> +    QList *exec = qdict_get_qlist(qdict, "exec");
> THis seems to be implicitly defining a huge set of extra parameters
> for the migrate 'HMP' command, but none of it is actually defined
> at the hmp-commands.hx
I don't have a lot of knowledge on HMP commands. I had code changes here 
in HMP merely to to keep it compatible with QMP command as it used to 
call qmp_migrate() function.
> Do we even need todo this ?  For HMP it is not unreasonable to just
> keep using the URI syntax forever?

Daniel, I didn't completely understand your ask here. Are you implying 
that for the HMP wrapper on top of QMP, we should pass it as a string 
only to qmp_migrate() function ?

In that case, we won't be needing migrate_channel_from_qdict() function 
at all right ? Please guide.

>> +    MigrateChannel *val = g_new0(MigrateChannel, 1);
>> +    MigrateChannelType channel_type;
>> +    MigrateTransport transport;
>> +    MigrateAddress *addr = g_new0(MigrateAddress, 1);
>> +    SocketAddress *saddr = g_new(SocketAddress, 1);
>> +    SocketAddressType type;
>> +
> With regards,
> Daniel
Regards,
Het Gala

