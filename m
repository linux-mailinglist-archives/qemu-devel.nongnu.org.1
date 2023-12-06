Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF568073FA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 16:50:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAu9o-0000Hr-Kv; Wed, 06 Dec 2023 10:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1rAu9g-0000H8-5G
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:49:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1rAu9X-0003Ay-D2
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:49:43 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EY5MP023124; Wed, 6 Dec 2023 15:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=48IzqU7yFqVAVWZ0fSvobci8O77N/px+dXiCQ42YauM=;
 b=eJcJd6JT6k2KzrPC7SW3VMC+IIb37/bHHz4RNfYqlZWlCLjPlhCjMYICV9U97hYjypq4
 dP4ydOBqkDniwBRdYU5AQe1kis2mDAgOanPlsnnP6BcCYN5tXIYPGtebM3y7k3UYwWqK
 EEqa2zJ2/6dXZv7bt4Jyy0ezmPFnLcrwm6kv0all/JL3IE6JLw/+Xp5h7cj7JEdV8dV2
 oW82CJJGTWJ6WWwBuUsySu22KR4cP3r4Kug73TACP3Zp8iKJg5QJOZHalvCwdrGfb7aE
 711i6zrUpSWz1eFMTTMMPYbtjYCjAmeHz2ZpM4jVkIMNArYWWAgsd2H6/RnPEvhFPAi8 PQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbhssu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 15:49:32 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6FRAvW039579; Wed, 6 Dec 2023 15:49:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan62uur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 15:49:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbNHAhlsy9DNc9FEM1LfixQLkXN1xiyOoipkn1sy2AhtlSXeSD8Fl2CXl3LR64TM7Azjnl84tjoEy+pKSABxYkSla1Ne+1+tIxex7XSvm5i3ifi9NeyniuxObYRG6Y6qWHddujNLF4jYIGvL6iq5r9xRr3xV9NNc+aTI4Ga1ROmZfMkTWq7+scR6/ameb1yHPtZoyn40AToTCT5PE0xJiI710V+lpSatOLupe3YkoM76z9ypfvV84UI+slpRr1AR/SGcEakw4FcZ9eXM8E+yylDZdgMG8PYtJiwfZwEIFf4g7XqjjWLYaeQhubK805ZDmMJLIowCez8z/sDnkxjteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48IzqU7yFqVAVWZ0fSvobci8O77N/px+dXiCQ42YauM=;
 b=Cz1xrgit5k5xqlbAi5kLmvPLKT4rY3xmeetLGNr+GN6yXoNzl39jLR76fOp08pGYJKuA/VysSf+/gCJ4K9uZ+TFLmbrDfBT/8o2+95ruRk7DcY5OtDVgZ4dEDjlL2Jbev1UthKfQZKSTMn+sYHO+0a0iKY4KgNqf83FZ3ymWBWYuqxcDTQkeqyB87ZjaQ+WvKtvRUAvTED3Yqip4g7F4W3M/ntw43nKsmLgNcz8lb5ierDcxzUleSgXNuEQi+eDl29A9zymghB/uFuv58TfeQ3UX88PsROzCyJuBVLt1jsnDUpuJ06ZD1qLimZ7sWXdCpGskOciArD3NvUK8NGJfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48IzqU7yFqVAVWZ0fSvobci8O77N/px+dXiCQ42YauM=;
 b=MB6ae+TMHEI8txsJSauB07KY8G++0MNgVFT8jsjUjU4gcAWVrxktaOWFpssKRSTJcdbfRlnJSKxkJjOAJuoVGvSbhoI0H1IzbbNx0C9SPMbKET6JXPw+3XrBOhrNgFzfV+0dfljgI6+dcV8q7sCPBDQ1RWTEYjrYrD6vSwuQ4So=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB7803.namprd10.prod.outlook.com (2603:10b6:510:30d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:49:28 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 15:49:28 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: =?utf-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan
 Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Thread-Topic: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Thread-Index: AQHaJunm3372qqaOckWMrQvYOflQBbCcPzMAgAAj7YCAAAaUAA==
Date: Wed, 6 Dec 2023 15:49:28 +0000
Message-ID: <40492473-0C4F-40E2-A301-7990A4891815@oracle.com>
References: <20231204194039.56169-1-philmd@linaro.org>
 <4fd5951c-b19a-48fe-bef2-4383fcbbae46@oracle.com>
 <20231206152543.GJ9696@kitsune.suse.cz>
In-Reply-To: <20231206152543.GJ9696@kitsune.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH7PR10MB7803:EE_
x-ms-office365-filtering-correlation-id: e45fbec4-d080-428d-cb02-08dbf672edeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBQ5BDASHduUt1t27gYpPt57wPE4y4PUG2Or6UQIrdUF9SnKwATk/gvvivFdnSv8YibHIHNpktbVTXi9ByUPaZ1XSKcmKmX6V1QTk0TXt+3LsBxwmpIVqWNv3OYCUyhw575eEA3WMj6zMz2t/R+LozSfQD0VVBK35eGdSHfeKrURMS29bjNyEJ0gYVVsjmJCTarqHjQ5d7lP3eThSdIjfPMKv/mF6AlLw3EoP0Lrw3wdA+caNipcLEECyvSpxW+VYVS+55tS6xS4i1G1RuFcPLR3e7/vk55o57urr3Cg57jZUTw0RYhYJnStL8fIEhQN8xAwns60o1i+5BCwOVT0K5pTI7rdzLqIjpZRBIZcczZsSccOK7rGEDCV+9FgI+PHi1PvP6oE0ELQpLQLldwHejG+7t4cbaB7nLV2qJpP13mR7u0a1atcNRLVi89sPeTHIH46j2JUSiR3ec+PXloLxU+BGzV6QYESkpKFEpo/QdtPXHbr6IQs+cZjioah7TSizmDj6lDaJbbH+tx1wcCNRT3V2FzYxeqLlHzPGMBJo3SQ6DGQvqOcHOY4v6b0LqmYzauAW3IckQzLbLmW2Mq4+3/zUGi/CZKSJCvAzHeIqBzaRZkticItPgpgTdg5jY1uuusvibSPWG3QfRXCPwmVdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(86362001)(44832011)(36756003)(5660300002)(2906002)(41300700001)(38070700009)(33656002)(71200400001)(122000001)(53546011)(6512007)(66574015)(6506007)(2616005)(478600001)(6486002)(966005)(83380400001)(38100700002)(8676002)(8936002)(4326008)(76116006)(66446008)(66476007)(66556008)(54906003)(316002)(64756008)(6916009)(91956017)(66946007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3pQYU1CUHJRZks2UGRhUHJZbVJmTE1LQkRZaWc0TmExdjB0Nmx1VjN1RW1y?=
 =?utf-8?B?Y2ZBYWJscDd1cmpCZ0VSanFMbGZ2L00wc29EbHo5Mm93dVc2RDE0LytGZVhD?=
 =?utf-8?B?WFp5Y2x4SjJ0Mk8zQ0V1TkZTUHEwM1QwcUE0WEhCWksvRGxxZ3RaeFNtbHhY?=
 =?utf-8?B?c1Z5WDJtZnZMSkhEaDdkSC9BVDVudkdZa1JkOXpYdCtMWFJQRndGS3VjdjAr?=
 =?utf-8?B?TmZIQ0RTR0VRY1VKOXJqMmpKWlJwSUp2ajZtbU9lZE42K3lYaHpuUWVYdDFt?=
 =?utf-8?B?ZzNweVgwck9PV1A1eUhCY2k2VmRwcHNtemZ3cC90V0Vnd25BWGtpTWN4ZE1Z?=
 =?utf-8?B?dllsT2ZPVVFibUdpOHFXZDd4SXhrRUlYY25CUFg3Sk9TMlc4a3gzNFZucnBi?=
 =?utf-8?B?NDVweDcyL1VEYnFuOGp0RG1ESE9PSDEyOWhpQWgrLzB4T0RnbW03Wi8zUkEw?=
 =?utf-8?B?OEpqeXVQTzN3Y3FBSlVnMnJFS0E1ZDh2UitFQ0pYWStFMXlvVHZzNHFHbHZu?=
 =?utf-8?B?KzI4QXlaSWJUaEtWR1dvbmt2REUrL0crbi81em53dUVCWjZyMmlYaEJHUzJ6?=
 =?utf-8?B?L0x6ZTJZdG14YWlEQzR2emxTYVpMY09XRnErdlJKRlQxdlZ0RFErNDMxZmpT?=
 =?utf-8?B?YVpJL0Z5TFhQNmpCSEdSL1RsQ3MxNUhkWlBtK3pjaHpheE43TW80RWRsS0Vn?=
 =?utf-8?B?bEIxT1BoUmQyY1lxWjhPekx4RjNna1prZ204ZnlsSkUrL1NPeTVOYmw4Zy9v?=
 =?utf-8?B?MjR1eDczOXlPa2lDRlZEZThWMkxoZXBldEhMYXpEb2oyZ00yem9rWFo0NFEy?=
 =?utf-8?B?c25Ca3FkaUlJZGQzSCtrK3dQSTd6R0pTNFBCekR0WTk5U2hDSFdicGN2MVZz?=
 =?utf-8?B?d2hwK2VZSmxweTlLSFJJZUNobE9oaXA5aWkxNGthSDlNbk1ONlN4clAraEhy?=
 =?utf-8?B?NE5qNEdvRHZVZDlWbnNyVmFJaG9TdTB6WXRmUEFRNmM2V2tGZWZnK0EwRE9Q?=
 =?utf-8?B?NHFpaWlYZkVLUVZmSGs0RmVxK253VjJhVUY3dDN3T0thQjEzV3V3aG1KaGo1?=
 =?utf-8?B?R3JzT0VpQVJ5dUM2RytDalk4ejVJUHg4ams1d2RkbG5WRlgxN3c4NWhPdVdI?=
 =?utf-8?B?YW4yZFpKdHh6MldLWENXUXlxeDdrbmdGVDgrUHVUZVAyYnlQWVphM3BXM0dF?=
 =?utf-8?B?SjJWYjNOYkN5R3dtRWRGa1N2alpXaEo1NXEzNHIrYVBueThuUWZtTGZkU1JO?=
 =?utf-8?B?cmpYQUhFRkw0ajk0ckZhd25ZWm15NnIxd1p1eVU4Rm50aVViR0xxdkJUc24r?=
 =?utf-8?B?SW5jZkVlQklaSS9RUDl1MWlYZ2prYW1wOVdMZ0YvSXVYTkt6c0pxZG9hdE0v?=
 =?utf-8?B?VkpkUllyVzRsaEQ5aHdyM2NaYTQrRWp2UldMNk9QNStBcDN0NnVNUTBBSjdr?=
 =?utf-8?B?S2NnOEsremVKaTM5RW8zSlZsT0oxSWp3NUF3YkNmQThYSG5sdngzS2hQamFw?=
 =?utf-8?B?MXRObUd1Ym1HSXdGRE1sZCtZYnE2UGxvSjBVOHRqQWRlVnBGdjVEWTBFRmg5?=
 =?utf-8?B?TTBTU2tuNGlQZkIzU3lYUE5QUndaSFB6SXpSbnphNzMzR01UamFpRmVGMXJh?=
 =?utf-8?B?RlJ4QkxuQXFGZVdWUkVIVGdGaDVuaVZwUlg4aGxxdHp1U01kUFNtV2ZjRFFM?=
 =?utf-8?B?NFI2V0M4N0NBNUZkUWNBR3p6UlV3ZjFOVVlHMjdoUE1nUjB1NnpwcGV4UWNR?=
 =?utf-8?B?aDI4RG52QUxEa0VyTk9QVHFOL3VUR0E4TURGZFYxQmxCdERBZ0Y0RUhRNmVr?=
 =?utf-8?B?TkNYVnJRM25SZm4xZXRmVk1kSkpZaEhsQmtzaXBWRzFhQ3VVbThpbGEvMFg3?=
 =?utf-8?B?Vzkyc3d4dldydW8zYnhqSXUvZzcyLzd2STdaVU5KU1JzaGg2Y2JEZkxyWHdu?=
 =?utf-8?B?UjN0VHpJRXU4WUNwUGcxaXBteWw4NVdWYWNtWW5GSGlBeHRQNWkwcllJQ1lH?=
 =?utf-8?B?TDdiWitTdWFLL2VQa2FZbXFhczUvKzcxTUFHUTdwZjQ1eURXVWoycFc2MGEy?=
 =?utf-8?B?WUlkc1pLdDhQTEpVZld1aGF0Z2VNTCtadzJhaWpwQzI0cjBhZmZqU2JQcFBS?=
 =?utf-8?B?SERBaFUraDVjamlDV3NGWTFvWVRINjJ6OVBJSEJ4dENQK09DYUkyekhtTkJS?=
 =?utf-8?Q?wXl5np1BMy366GBKnW/6YIo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C85B5A54C85B6B4C98FF64C17C176574@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: acncOtBnAhgIkooN20EwWr9rmC2o9kio9jqwfZj2CTMFRZnR3ZvWY4h79tQUoPbgaWTRpCzaRTeuMQ0/LjfxLwu2vcZt85blkEfFLUUwfYgEx8zmjS9ACqe5UUr28GTMbjYGVeb6gVEcK7q3SfG5ZIQR8jfcug11tTD827pdrcIhUuGX/2VovqkajZD2koM4Zma/LCB+f6JKYmM/joh3I8aarv7pOUe86DKi5hAa4wAE740WI9HQb0IpE26uR3RRC0kgy21wmaKO/cfXADGCgbpiBYYFcxQqjuvmvqAgQwQRby1XOM3bzN9lZh7x2YVahvKdrTQRMC4NmMdtwBmLt0QSi7XC0Wepw/d/j5RDcqFkaPCcB9sRyfpumUcNtTLuodDNYQGYj44F/mAn3lSrfLp1ny1tmX0+7us0Uiz9euPiDEPq0qRSPBBLbeQ8CnZ+k1j0rHujTtQBBj5zgyAkfi610cgm5HjmNLDtc3ovvHv67o0K3tQiryWmOVIJBSthlzHkERC4/9W5yvd083DqH4rwUt1r+qP9cQmB/EQAgh36viWBRbqfDqFC1BDtwdBQic99wnUdcZFYEX9bMY3p1qOU0OiWIDcGGs/In9vCj77CvPCDavtXnY9nmOS+LFs4qTtX8QB0PyWJGbGKsWOEQMZSl+3wv9zxZf7psT9VJJ0Q1/wn2q87GYzx7X9q6RKRvknnV2Ivfh+EyACOv9thC8kjiK+A2TR+rcFmD3oWAHLuG83CM2/yf92K2FYUXP1e+0fzSOdHS6JROBJEJGv9VFcQYKRZM6Ubj3eiVThSMypWoH4Np6rqbB+NW+r0XVOlWFfU8DJb+nWMjKyztqQg9wgLn2SyF0RQYzWXDDx3iz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45fbec4-d080-428d-cb02-08dbf672edeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 15:49:28.1128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJpRhltasuEWBlxdQS/KJ8FJoXgUXufIZ7KJWtUywynEDj0/5H5rjI+7VAvk0kUan7H60zXMlfSEmTrnDnLR8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_13,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=950
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060128
X-Proofpoint-ORIG-GUID: sf1chEiwgMvftmWPaKMasSR8Uhg0eGvK
X-Proofpoint-GUID: sf1chEiwgMvftmWPaKMasSR8Uhg0eGvK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4gT24gNiBEZWMgMjAyMywgYXQgMTQ6MjUsIE1pY2hhbCBTdWNow6FuZWsgPG1zdWNoYW5l
a0BzdXNlLmRlPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgRGVjIDA2LCAyMDIzIGF0IDAxOjE3OjA4
UE0gLTAxMDAsIE1pZ3VlbCBMdWlzIHdyb3RlOg0KPj4gSGkhDQo+PiANCj4+IE9uIDA0LzEyLzIw
MjMgMTg6NDAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+IFVucGx1Z2dpbmcg
dkNQVSB0cmlnZ2VycyB0aGUgZm9sbG93aW5nIGFzc2VydGlvbiBpbg0KPj4+IHRjZ19yZWdpc3Rl
cl90aHJlYWQoKToNCj4+PiANCj4+PiA3OTYgdm9pZCB0Y2dfcmVnaXN0ZXJfdGhyZWFkKHZvaWQp
DQo+Pj4gNzk3IHsNCj4+PiAuLi4NCj4+PiA4MTIgICAgIC8qIENsYWltIGFuIGVudHJ5IGluIHRj
Z19jdHhzICovDQo+Pj4gODEzICAgICBuID0gcWF0b21pY19mZXRjaF9pbmMoJnRjZ19jdXJfY3R4
cyk7DQo+Pj4gODE0ICAgICBnX2Fzc2VydChuIDwgdGNnX21heF9jdHhzKTsNCj4+PiANCj4+PiBJ
bXBsZW1lbnQgYW5kIHVzZSB0Y2dfdW5yZWdpc3Rlcl90aHJlYWQoKSBzbyB3aGVuIGENCj4+PiB2
Q1BVIGlzIHVucGx1Z2dlZCwgdGhlIHRjZ19jdXJfY3R4cyByZWZjb3VudCBpcw0KPj4+IGRlY3Jl
bWVudGVkLg0KPj4gDQo+PiANCj4+IEkndmUgaGFkIGFkZHJlc3NlZCB0aGlzIGlzc3VlIGJlZm9y
ZSAocG9zdGVkIGF0IFsxXSkgYW5kIGhhZCBleGVyY2lzZWQNCj4+IGl0IHdpdGggdkNQVSBob3Rw
bHVnL3VucGx1ZyBwYXRjaGVzIGZvciBBUk0gYWx0aG91Z2ggSSB3YXMgbm90IHN1cmUgYWJvdXQg
d2hhdA0KPj4gd291bGQgYmUgbmVlZGVkIHRvIGJlIGRvbmUgcmVnYXJkaW5nIHBsdWdpbnMgb24g
dGhlIGNvbnRleHQgb2YNCj4+IHRjZ191bnJlZ2lzdGVyX3RocmVhZC4gSSBndWVzcyB0aGV5IHdv
dWxkIG5lZWQgdG8gYmUgZnJlZWQgYWxzbz8NCj4gDQo+IERvZXNuJ3QgaXQgaGF2ZSB0aGUgc2Ft
ZSBwcm9ibGVtIHRoYXQgaXQgd2lsbCByYW5kb21seSBmcmVlIHNvbWUgY29udGV4dA0KPiB3aGlj
aCBpcyBub3QgbmVjZXNzYXJpbHkgYXNzb2NpYXRlZCB3aXRoIHRoZSB1bnBsdWdnZWQgQ1BVPw0K
PiANCj4gQ29uc2lkZXIgbWFjaGluZSB3aXRoIDQgQ1BVcywgdGhleSBhcmUgbGlrZWx5IGFkZGVk
IGluIG9yZGVyIC0gY3B1MA0KPiBnZXR0aW5nIGNvbnRleHQwLCBjcHUxIGNvbnRleHQxLCBldGMu
DQo+IA0KPiBVbnBsdWcgQ1BVIDEuIEdpdmVuIHRoYXQgY29udGV4dCAzIGlzIHRvcCB0aGUgd291
bGQgYmUgdW5hbGxvY2F0ZWQgYnkNCj4gdGhlIGRlY3JlbWVudCwgb3IgYW0gSSBtaXNzaW5nIHNv
bWV0aGluZz8NCj4gDQoNCkkgdGhpbmsgeW914oCZcmUgcmlnaHQgYW5kIEkgc2hhcmUgb2YgdGhl
IHNhbWUgb3BpbmlvbiB0aGF0IG1hdGNoaW5nIGEgdGNnIHRocmVhZA0KdG8gYSB2Q1BVIHdvdWxk
IGJlIGhhbmR5IHRvIHNvbHZlIHRoaXMgYW5kIG1heWJlIHNvcnRpbmcgdGNnX2N0eHMgYWZ0ZXIN
CnVucmVnaXN0ZXJpbmcgdGhlIHRocmVhZC4NCg0KVGhhbmsgeW91DQoNCk1pZ3VlbA0KDQo+IFRo
YW5rcw0KPiANCj4gTWljaGFsDQo+IA0KPj4gDQo+PiBUaGFuayB5b3UNCj4+IA0KPj4gTWlndWVs
DQo+PiANCj4+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDky
NjEwMzY1NC4zNDQyNC01LXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQoNCg==

