Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8307A7A2F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:13:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiv91-0001UD-M6; Wed, 20 Sep 2023 07:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qiv8x-0001U2-1R
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:13:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qiv8u-00007H-Kk
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:13:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38K9sTXP028111; Wed, 20 Sep 2023 11:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=D+92CO/6MPoXsJC0zxrrbQw6lRuraLg1jLbz6a4OpDo=;
 b=c/nIEnSX/dbPWwJwqysTwGJgeN45QQaAGn30pquSNTTrG18j5Ds4ym7fqZd5XITmMgpi
 YSHsDjdkWjmuKPTu5oiXZBPl+XxZr+vHJIsROuxfvknSIw9Y0RDpz/rJINO2k/vjaeFk
 QY+5B4UXwjN0DcvZu377y5m+n8pGWqr+L9j+LOUv/AB+bVdNeLuNVWuhteqSiLUpNX+h
 E4BnCdUBQCLm54a3M2QwGkgVkbqxccYlakqbZ+6SmpBPQhHK52pc48dhvIEFdHZpuVkZ
 cDEcV8qLhziF7h13+m/SrH1I7Mk61S/DspiMXZjx8HO4Ox2vO2QQYskou1fX/8FSJvxV Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52sdy0ty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 11:13:10 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38KBA7R2030814; Wed, 20 Sep 2023 11:13:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t6xdkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 11:13:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSEq3JKrBZxQzYl2HJFRqGlULasiTUx7lFVnQPBQadGd9ym/AEJ3aAez8Pc2kTLyQRCRAMCLyf7t8Zo6STB2/A7jCkSxvd4qG+UJmlqKM20mKYBhk/NZnKxz2/J4KjcA+YNwz4piLrLUKGx005bgJVQYHZc0yiHvAe8l/miwD44E1y9LDNdq4zRGUa1Nc2sIVvKeRnZYKQ4wTcmv7j5ao3jMLiaA60QN7FCSqQsFmLG6uqAhUVW7hgufZDRhDv3rptB258vUDthjBe/w/j0nrN7hEz7A7xIqGZtIyQjWJdOeI5uGqS07uUrD57E4w9QYdAG5m9EHz1FJdTb+4nTrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+92CO/6MPoXsJC0zxrrbQw6lRuraLg1jLbz6a4OpDo=;
 b=lDtYjNBe/b/0lPXuaUdIYY5v3F2zt208THYByWSQYXm5+HDsohwHLO+SPzPqmqg6X59KiSVhl7bElKrEJRG7FC9ybeNIV089AKccCmoy0F7xSEWubgOwpah1RDVeDsDd8nNeDhApIN3StKm6F8gGUB7VfwYa3SxinuGv+JluPQAfRrmUEGQDL4XuXONyBRT6xfPArFyLKnypy9fQSTpKpNDTzC4AtT1wQRkjX4GAmtqlEvnUwBlOmR1SqzHHziysknSGOihmSwJv16wsPgTM4oXfh5n+8TmoyHsG0Z85ItOSB97JqPrylW1v8aioyPKqpkbISH5EKrK0VFfkzL1Nig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+92CO/6MPoXsJC0zxrrbQw6lRuraLg1jLbz6a4OpDo=;
 b=f2VDDJUSliE1yauNNJG4eTXvJusRPdpeSNhRoSI7K+1dlJd1AuNhsCAxmmrdNCkFUFjTdW5lx3izkJuEkUmOv0Njk5ubw810pyUz4tCZ8MtrWIR8G40TlvlmaYbz28S0zDRQdv0Ya5LAdrOHtrjJAHRKNBaPqy/+lis9D/EHsDg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 11:13:06 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 11:13:06 +0000
Message-ID: <948a0ac5-379d-44a7-92b1-d2cc0995e187@oracle.com>
Date: Wed, 20 Sep 2023 12:13:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
To: William Roche <william.roche@oracle.com>, John Allen <john.allen@amd.com>,
 qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
References: <20230912211824.90952-1-john.allen@amd.com>
 <20230912211824.90952-3-john.allen@amd.com>
 <f287de21-8eed-0c88-98a4-69f00bd73be9@oracle.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <f287de21-8eed-0c88-98a4-69f00bd73be9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ab9ce7-0fff-4b72-9f18-08dbb9ca9071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGHHl5ScKEXgRZE5pDrqyfo1mhT2ueicD/WNalr6RPWJZUUBooksbnk8Jg/t4plrhq+c2PtmQG+GU00cb5/2Wk+Wfjc6/mxYoFFZm2GpCViN88wmScnZFExreOEHHYQfaW1/gDjDF88X/wmzWhe1bUY5wNn3Xn2ukkMyK3goeP1uH5MysqgO8qKkE+DMX8pDMdMsONx7hfuOKs9dxTP4fzSoDebaT8Dopbp1Xjhccuha2tImYe8Ppe5oeo+/hln5OL7BXhZi1hZ32LywzpL6N6t+sUW34fa0CSt7BdYhN/hlxsOVMcKn1KcdETzO1gsTjw2UfrPOJ+XRcNYtGXkw6WNoVYc9HHe04L8j3wp9o/A+Lt77gRHtX2cqCtsmmuWvxM9GTTlalZ2t0H03F/HwcpOJ037YlZIhdAATWzQ9jDf0U5zNySOgK/BZW27yia/hzODYgd3/sObTX83B30CIu25EUAXBZ39BZ5OTFiJ1nyMc74omoNnW9OVtzl+ocdCWYRY7CoRXrbSIZoGP+D+2L+SCoBfg9uITEJ7344/V2SqsFO7sMF9bNok6/wxGoP2JDboR4BjfPaHb1wCAaMWXSZvHyZ4JwFTQhP30/N/gfb6xKhSWdYI+4uIItpMHQRoQFhKoW3/oW7rLlKVU6QPvXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(6486002)(6506007)(53546011)(86362001)(6512007)(66946007)(41300700001)(38100700002)(66476007)(66556008)(110136005)(6666004)(5660300002)(31686004)(478600001)(316002)(2616005)(8936002)(8676002)(26005)(2906002)(36756003)(31696002)(66899024)(4326008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01reG1TQ2xrZ1AyNVFhc3U1QVl0OVpRdUNyYTNpVEJ2Y1Y2ODZZajRmcnlR?=
 =?utf-8?B?bDdoKzF0WUZ4UXJUdDFmUW5YWDNTWjRkNEhMeVpYY3A2bEhMRGlMK1hlL1Zy?=
 =?utf-8?B?Z1JHMHliR3J1VVhPZlZydHZHZGh4TjZLWXpyNm0yYUdVVWVjZURmTUxCRkMw?=
 =?utf-8?B?RWg3V050YzRPVitSS3A0S0RtcFIwM2JtT3FvbzRpQXFiS1JWeWtSQW1QNThL?=
 =?utf-8?B?NWs2MGtOSHpDTFoydkRlaFFUQjJWOXhLbzk0cmhvUWFrTjBTK3BEUkoxL0FR?=
 =?utf-8?B?VTN4K0VzRDl4eHFoRVB0dkQ0ODQ0TVVhQjl2emw2elFjQVlUTXZOeHJTRG0z?=
 =?utf-8?B?aHR3Q3lBb2FPQXJWOFZwK2h4WU9qdTIvYXNPVlhHa2VjQk9EdjVuRmhiRjRz?=
 =?utf-8?B?UnBNbjI5eEp0R1ZGa2ozSW96UmlZSDk0ZzdRVWxTTFExZmUrTFE2T1N6Umdl?=
 =?utf-8?B?bE5OQWhFNmU5UDJzTmNETFIwaVQ1NWdoZkg3S2FvRnl1SHZETXgyYUJrZUdD?=
 =?utf-8?B?THJId3RUYXJFSHlyRUdIdWlFV2pEWHg4Rzcvd1Qvb3lSTVlUYlV0N3MvWkhi?=
 =?utf-8?B?TG11ZXVpUGJRZmg1WHNBb0E2VG1rb3FIV055ajhPSzk0MlJ5OXUzRFRsNVh5?=
 =?utf-8?B?T0ZURDBGbTNBbk4xbC9WdTJwYWdoeU95VUVjem1FZnVvcHFqbUhoMUJkaTlx?=
 =?utf-8?B?RjRnZDk1Mk1ybTJId3pIVDg2RlIwa3ZEQkZQSkV2aDRjVWNqNWd3UUs0MHp4?=
 =?utf-8?B?ZWtLcWhTT3lkdVpwZ2R1ZVBRSGpnUUFNcU1VTVVrcVlUTEpQTUErT0ZCVlZL?=
 =?utf-8?B?L3dWaHNRa1dMTFA5ZGs0bFc4bGt0U0E5bUZROFNRTTJVekNFbVN3WnRhVnZF?=
 =?utf-8?B?ZjhtcGJJNFpXR084MlZHTHFDcVl6SXE1M0MvdDREcy8zSU1rc2tMNk16MHcz?=
 =?utf-8?B?eHFTc0Z4V2lXMFZkYXAxZUM5b1A0Qm9id251VjRFUzVDcklzL3pxeS9PQjk1?=
 =?utf-8?B?NWJQN3c2WnR4cS9NL3krOGZqc3BML3RaWnc3UWxXbEpvTDR0UnNrVlNQSnVo?=
 =?utf-8?B?bVFCRm1YWTQ0c0JaekpLR0hPK1gwVGs5bC82MEpYQUkvTG0yaXhCT0c5WThB?=
 =?utf-8?B?dDcyZlVlTzJiY2EvUHdHLy9YM096bldmMHI3WHd6bitLckkxSVM4cUkwa3Np?=
 =?utf-8?B?bklDNHpzRFlkbXhpOE5IQW12b2RTVHNteU9GVW1uN1NROXhJWDBKUGRFOEpZ?=
 =?utf-8?B?dWVDUUdTdjJYMGlsbXloeGpjaTFMZ0tzVkJQV2U3OUwzMkVtRXFycmZiS0Zp?=
 =?utf-8?B?cUlPOXNYQ2paekNoelBnZDNKeHZwMjNUK1daWVV1cnNwS2Z4VlZLcFN4TXF1?=
 =?utf-8?B?bkk1cGE2Z3FzUGFHQ3JER3JTYmN1dTdpV3Bkbnl0YzZqNEFMN1RQSlJ3YWtS?=
 =?utf-8?B?WG91YVBoN3QwYWxobWlyaGVFeXdCeitHNzVhamJHa2hJV1JjT01XWUY4WE9I?=
 =?utf-8?B?WTN1OS8yZW85NHJUYTVFR2QvVVhDNTNaaGtveDFaaVdScXVucUd5ditybHJi?=
 =?utf-8?B?NjZySkllaitLa2hXd0ZPNks1UEJ0ejF6ZURlRE9wYWtXYWdrTE9OSElxMVI5?=
 =?utf-8?B?aGkrUjVQa1dMUG5oN3FZZ0N1dGlqU2R5S2pVNm40cGxXbTlzTXM4aDI3OXRp?=
 =?utf-8?B?K0dCT1MwQlE3NDVtTFpGd3pWS29oSjdzazB5Z3FGTTBuK0kvK1Y0WDFRZm5M?=
 =?utf-8?B?TSsybXl5M3BCYVFYMndwWXRuUTJhNXpBa282L3huSkpBUFZMdE9adS93dTR0?=
 =?utf-8?B?VERHSXBWSGo0SlpoTE1KSVluK0l2VUozMFVhd0JkMUxhYkpwYXZLSFlxY2dG?=
 =?utf-8?B?S0FkU2dRY2pzWEtFZk0zRjRrdlhtYktodnRNK1RadWlmczFjMUZ0aTNVbnFP?=
 =?utf-8?B?dGJ6ckppdnBVN21uK21BV1EvamNSdmVSZjJuZ3hmLzl1UkZSMVFVQXMxMmpL?=
 =?utf-8?B?NlNFTWZpbWtFalp2a1hhZXlXSUNJb0hFVkpFa2RSa2p5amFLdWlOWWEwMlRQ?=
 =?utf-8?B?Q0QvdVhRcy8rQXRXQnlEMWNXeWQxR0s3Vzc1UGNmZlpZbDFNZ2ZIZk9QWjBG?=
 =?utf-8?B?SXdlTlRSQlU4eVgzM0ZyVnVlNWN1VHNGeFNYZUJueFhwWkpTeUd2bEVkbVA4?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DT5LsDWYEJx6W/8MH+el07f3rCYc4W4kRlsSZ+QN1u+/y4uBh3tRxT2DoZ4Ml0mmzsze3Eup3zX6jtlZskAc8VVPxby+qQhZJm6ka6/+uOm6W/Fl22E2ivdO1yKd9UJVifzv59xZ7WOnh/qPf388sgDgU84f9AwkAcQm+j40pkJ3ueJrOviuldUBi6DFbZAeICQ0Og3T4+Gs4bT4R3agvade0efu7o1H1GEoGO3HXd6gv3MIP9K9dRwIMB6kNzxRS8FabBRokqY8YCgfQ1IezPpwQiOGxRFfQWxqG6JwniG+A77Nndny1dJd/hBI8UNCfB5UGl1PTNI70Jbdlfha4fbqEb++bxl5Yt1hW61rENAxi2y+WHq8JktSnmH8A8HcONXR3PjYdx7aCjhfozfk9rNOntzlXx+yoqkkg/DbAnI80VTa9gifDInupuwpgmaOu35l8e9FE1bwaFRqiLUE1OKAfb2GSLngtzDj4TLj8nqVTgThId6IRZPfM2wFUgbdjbPxKA+Dmp+Ek/d9Y7KhM0maKS8P8p9IqJSfvORDheG/nAhMEGResKueGHT9Y18+p6thud+MG9ORhOBv1QLYtesE374S0jF5HTxP0dNOtT4Sg9Ket1sN35YbjhnXgU0msprAzB2jMSMHPqPkLpZN8jIebTELT1MBbmwNVh/ekSEzPoQa+N6DRjA4WW0erUYTeO5sGDLzfug5odNH4kjTaAORk2l4I7oQgGmHJliWFJ9jSFmfiHMk253STQlQ9m3sLw6SyOjLS8rGe8NbZPuBZ3kluEMEGm1GAp+tGUOxF8dcskOeeRbT/+0l83HaPETeLyVoiviYi7SMys8qs+iib4A0hId8mTlbw/nAJOvFVAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ab9ce7-0fff-4b72-9f18-08dbb9ca9071
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 11:13:06.4145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8yHZd7iHXIA6TBNeRZMSaL04yYPixXufWcZBoC1hEXNg2NXneJiHH+C4civAX6kOSN++xzTX6ayjP60cR0sA1xghbSkoghvY/SXzghfN2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200089
X-Proofpoint-GUID: ApcglA02XeSfiHftG4ac-L2l2A62rDc6
X-Proofpoint-ORIG-GUID: ApcglA02XeSfiHftG4ac-L2l2A62rDc6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/09/2023 23:00, William Roche wrote:
> Hi John,
> 
> I'd like to put the emphasis on the fact that ignoring the SRAO error
> for a VM is a real problem at least for a specific (rare) case I'm
> currently working on: The VM migration.
> 
> Context:
> 
> - In the case of a poisoned page in the VM address space, the migration
> can't read it and will skip this page, considering it as a zero-filled
> page. The VM kernel (that handled the vMCE) would have marked it's
> associated page as poisoned, and if the VM touches the page, the VM
> kernel generates the associated MCE because it already knows about the
> poisoned page.
> 
> - When we ignore the vMCE in the case of a SIGBUS/BUS_MCEERR_AO error
> (what this patch does), we entirely rely on the Hypervisor to send an
> SRAR error to qemu when the page is touched: The AMD VM kernel will
> receive the SIGBUS/BUS_MCEERR_AR and deal with it, thanks to your
> changes here.
> 
> So it looks like the mechanism works fine... unless the VM has migrated
> between the SRAO error and the first time it really touches the poisoned
> page to get an SRAR error !  In this case, its new address space
> (created on the migration destination) will have a zero-page where we
> had a poisoned page, and the AMD VM Kernel (that never dealt with the
> SRAO) doesn't know about the poisoned page and will access the page
> finding only zeros...  We have a memory corruption !
> 
> It is a very rare window, but in order to fix it the most reasonable
> course of action would be to make the AMD emulation deal with SRAO
> errors, instead of ignoring them.
> 
> Do you agree with my analysis ?

Under the case that SRAO aren't handled well in the kernel today[*] for AMD, we
could always add a migration blocker when we hit AO sigbus, in case ignoring
is our only option. But this would be less than ideal to propagating the
SRAO into the guest.

[*] Meaning knowing that handling the SRAO would generate a crash in the guest

Perhaps as an improvement, perhaps allow qemu to choose to propagate should this
limitation be lifted via a new -action value and allow it to ignore/propagate or
not e.g.

 -action mce=none # default on Intel to propagate all MCE events to the guest
 -action mce=ignore-optional # Ignore SRAO

I suppose the second is also useful for ARM64 considering they currently ignore
SRAO events too.

> Would an AMD platform generate SRAO signal to a process
> (SIGBUS/BUS_MCEERR_AO) in case of a real hardware error ?
> 
This would be useful to confirm.

> Thanks,
> William.

