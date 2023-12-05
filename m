Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FDC805B61
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 18:48:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAZXC-0001ML-6l; Tue, 05 Dec 2023 12:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAZX9-0001M1-5s
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:48:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAZX6-0002H4-Et
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:48:34 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5HO2aZ018740; Tue, 5 Dec 2023 17:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=d4gCzCF7aLxReRiyUtLwe1C6J/W3dnHLnKnwEFR7JLE=;
 b=SFkHW3KORi9Ryq6GHURyuRNNWHRHtzMjwTu28vhwj7JpcOdRWCATItS/koBnt1enVx6f
 WCy+M4nAm3eMDHF7COSdwAolF7/Nf26j7zbsPnQXdPOR8IV+9OSpbQiwZryQeXNXA3AJ
 apU75aSgJ56sbnsBPp5NsCCfnQIKMgKc93EHbD/N3rgIi7BlZGJEY9oMQu9ojUmsauYg
 P8WV7bdn/k9t4kKIH0OeealTPiREz6jRxJ1aokCY7qHqZiOJYGS2hQNAlNAUw31RqNr8
 0MN0LRG5nsvBivE1TO5lMjC2MjznjdrrOvQb/p1HphdD6EE2Txz/TyNLt5QTYjvRqkKg hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usyhesf13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 17:48:29 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B5HBphD004967; Tue, 5 Dec 2023 17:48:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu17mstd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 17:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnGAQiSkx7WgXC/r9Gmt5/stXh/elEdc26hAc6G3fzQP0XkIa5j6SVyuOgYJIaocYekNyIOKqV1PT2LHE0qlRSPf847DyQZJP5utODiDOWFgf3o9NIkeBiOmNvtuCWE6pbxDFlce1zQaXrSW5E6uRq8BM6C0m8AsylfTsEbdCmXdmZqM23k2SQJnOMjp1ycp3TcF7WvHr7UMstJerc/IsvIJG4l01Ni6Xaw5n2hOVnU4uGhCm7GdkPtco+vTyR1k6ZjUB+VO9H4PIz/EGLOgG1KjpciQvbrLBfcNhO7znsYRyAWsaSOua4TblFl3yCbbc2KQBdx5nfQCr9M60xRJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4gCzCF7aLxReRiyUtLwe1C6J/W3dnHLnKnwEFR7JLE=;
 b=fI3nj0T4gMP6RzCxsQhJRVx6dcud8gy08dVMdFhYOIGlYRGYEcyk1GjRmTJppKZT5trcGuNO0EFvHHPb8S4jEyAEcyC2/ZkHYqASIYoR0KP7dEZPvHsuPs+brrpTd0gy0pB0xMvHv1J6XZ4zV4ZIRdT0/jYVZdeENHXV4vJJNfXjrfhkWtDKDEgO0hKQfKCWM+15WaPQGgQTZ1mNfVRaGgul8LLyfXMiTAYitJ+kuPRTLkjd6WNNdoPwvyQbj3lzu76/1nFVWPRcd7HXWAcgxIrlpgnOwtrsKA8ftPR8sFd90iW9ZfGenxqmnPUONwunmNvfxEUTj5Z57vejCAztJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4gCzCF7aLxReRiyUtLwe1C6J/W3dnHLnKnwEFR7JLE=;
 b=A0p6WlKGK3K4kw2WhVOmd3jz9wsTazHsf8n5K81e22W9x0X3ieyxdnJ/jrVbweYriSNqXLAJtiSnbnkJ2I4dCDu01PbgRrG/zjMY0KIJ/5W0QKjo8oSznw1l1BTsIm324pkMMDtzDtbIjJaoyCKgaO4T7DfTjUptPzR46SPbHqU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:48:08 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 17:48:08 +0000
Message-ID: <f1d02b13-b1e2-4d16-b7e1-a6b7a37e6287@oracle.com>
Date: Tue, 5 Dec 2023 12:48:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n> <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n> <38a8b047-4c60-4e6f-9ccd-a307d0358f53@oracle.com>
 <ZW9Uxpcc5RO-m3l9@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW9Uxpcc5RO-m3l9@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35)
 To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f0681e-3a6e-4269-9fe2-08dbf5ba573d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9Ylr9z0A7PlEobrQeKQwTpUXhtuaDVaX61LBBPYuXiS81pyCy1bolfu+g/3BSYTBU1o8dUtG54VHz4KWi9vEn+vM3v65UYecmvYEmGvXGLXchOYCu5OUhJZeBIZLDMSDqoypWTQt62Zutiq7NnTMYyFxwQ2Bx5uDf7h24DcJ5U4HxtPHAoyhm/8Fxtu1mhtGJEscZHOY6f+7M1XiH6rY6/hJrqFxxZJ5daGNoRktlkVmA4uXIDfbiXlOSTvfJN5f56ojwCuisEiOQhe8VTFZ/LNczPeaX4bQYYcrnqmP5bOZPCSEJP7MuVr1/6/7Jx8aFp2SpFiIqcIxfitvi0fgv33Z9dJutMXFRFiqHpr9ElhGW18ZWqKtmS+Htix0/fDd7I9o+u2raa+BJdnmyfPkOJckGnovTnDXVfngA4i7xPUKtVBpBxlO03n8jcf+CF+DmbubwsJJ3iMMGTy31Bht82NMdXM9X5ASBfufydXX/IkRAtYoS82tbrXHSG40VUF8/inhoiMlwgokfbxlN/D5a1mn+n/IqPjq9aXdFaQhOSx8g81z4kpo0ioenHd+ufrk2IztsBr+sMjZC28paGb6UnrKE7dlxUhJ5vilwhzHAM51CSL5irJZaMVJlbbszqtwZVhL8DPJ2jIM+Tqcaig+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(54906003)(6916009)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(316002)(478600001)(6486002)(6666004)(15650500001)(5660300002)(36756003)(41300700001)(2906002)(44832011)(86362001)(31696002)(6512007)(83380400001)(26005)(38100700002)(2616005)(53546011)(31686004)(6506007)(36916002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFJekdPek5pbnRzRm1Uc0FQS0YxTDJtWlpGc1llY0tLMjY4RGdHZFlZNDBi?=
 =?utf-8?B?RzFSNnVqZmk1aDlibXJBVDdIMUt2RXdVNzkrRHBOU3NlcjFsTC9tcmU0djRp?=
 =?utf-8?B?d3RHQ0g4SEFkTnNjeW91RmJvZ2VnMEc2STJ3TDhmanRNTXFMb3RXM3JZbnlT?=
 =?utf-8?B?Zy8wMEFIK0U0UldXM29odnd6OG1QU0JHME1oVWJINEpGWmZlT2xFRDVXNkVR?=
 =?utf-8?B?aUk4bHlZUnhKSEVISUFIcDVaVUF3NlV2WEllM3ZGLzZvZXE3SmRrc1o2dzJS?=
 =?utf-8?B?a1lMcU1rZUlTN1RuSExBUUNrUklwMVRkYmZjdU1WWlpMakN1dUYyVEZISjRm?=
 =?utf-8?B?NkhCWmFuNVpIRGtpK2NLMGR2RHI2K21GK2xSeEZoRndmUk93STk4TmY2Q01Y?=
 =?utf-8?B?Q3JnbFJCOHF5c050SlNpNllYclpRNUJZOEdaVXdZQTBSVEVxL3lOZkxTNDVp?=
 =?utf-8?B?eTFaZ2hLcVZCM1ZaT3BJQWQ0dDFlTmhBQzN3OXZjZ0cxemwzRldFUVVETjQ0?=
 =?utf-8?B?eGRzdkJFMHh4Z3ZldDltVkZ4L1dhdG11RlZZS2prTW1lZVVEYzdRb1d5eFFN?=
 =?utf-8?B?RWxhR2dFeUR6TEozTzlyUE9SL1V6NkhuTDlEYjVrNzZHSGI5NTgwN2toZ2ZN?=
 =?utf-8?B?M2lVdkZoS0hBMzd6YXJGTE9YYzBpV0hBUEFFZHp2NEk0R2g4VkwyUk8ya0Fl?=
 =?utf-8?B?Ujh3ZjRDVDAyZVIvQ1pRRm1Hc2kyZmx3TWNLRE5aYm1EcG1LR0ZSd3E1NitO?=
 =?utf-8?B?UTRiZTNRNDl1M3BDelNlRTJsaVZmbDV5NmlzVFo4RkI1L2Qza0F0c21ReHZ4?=
 =?utf-8?B?SGlPWTBoaGl0bzdiNHJHN3NucVpKUS8vRVRkK3JJcWV4Z2FsSEFTT1hmZm9Y?=
 =?utf-8?B?SXZpSTZCc3M3Rk1JRVEvRUEzWUZHMjk3ZFE3NHByZHRJYlVTdGlsU0pTVVE0?=
 =?utf-8?B?TjFXRXZBUHUzN1lHaG5FNnF6QkJrUHJoV1paYVYzakM2WVFEMWVPVUk5STNN?=
 =?utf-8?B?RUJhaWJINVJsUjVWb2s4VDIrNmxHS3E2Nkw2ZFRhT0ZTU1FZb0pXczQxd3I3?=
 =?utf-8?B?MWR2TTlkRFVjVlF4VENueVpMK1R4a1pmVkZUUkwrMnNhNEZpb3F1Mnl2K0Qv?=
 =?utf-8?B?cnozenppQWY2cmZEV3JTZVE1ekt5eW1OM29pdXNuMVpDdXQxWSt3RTI1TlVV?=
 =?utf-8?B?dFRvdFhoQklCY2JxTGxLUE1ERnBETHh0Mklzd25ZOHRxMjU5eFFpU043bFhC?=
 =?utf-8?B?WG04Tlg2ejBhT1hqcWhJcmNKQlVMQ0RpUU85akppU1VqMWRmUEdnZmdadm9k?=
 =?utf-8?B?SytNSW95ZW05ZzQyalMyK3JQSTgrYlBzTDhPQ25tdDF2UDh5a0JVZ2cvZk13?=
 =?utf-8?B?SXVjMjk4MFVHcHVrbndNeDZxVGVLeHZkWnRRcm15aklFRmMwY0Q2VXYyNDR4?=
 =?utf-8?B?Zm9YZFlxTWltMWcyNlBBUFpxeWxoSXVCdktQSGF0Y2gzT05MQXJFVkJsb1dt?=
 =?utf-8?B?VUF3VnlzMW1nZGRvdHpyL09TUVIwWkE1OHVLNXdSaEZDNFZhNmNJeTBpeEFF?=
 =?utf-8?B?bGNJeTQyTDE1emJ0Z1BYVUUzcjBSTytPYVk4YTV0Nk1IN3lkMHlQQTlyYit3?=
 =?utf-8?B?TWFlSlNGTnhaaVREMGljaGliREdneHhkZE1WUEQ3bllrME9vZit6UGEyZm9z?=
 =?utf-8?B?QkZ6S2F2elBhU05VSWlpa1VPZUt1MjJWaS81elVqbjFEUVNJQjVrUVBHZUZL?=
 =?utf-8?B?WDE1TW1NbmNpYkxtT0VmYjFnZXpxZ3pJVFV4VUptZUFyUzh5UWNTNU0vTVJK?=
 =?utf-8?B?dDQ1MFNRUCtIbkZ2ZDM5eERWK2JxcHp5VnBJZnM5R3BWVjA5SVpkNXBHRm5t?=
 =?utf-8?B?WGdzcnVicHhieHlmQWo0enZiMnZjTXFkYTRPQmhrY0xhU0lDckFpQjhpRi9N?=
 =?utf-8?B?Vi9QdDhCaTd0RGVZSVNYOHV4ZG5WTHR6OElJbTlURTFQUFkzYkVZTGw4RU1k?=
 =?utf-8?B?NHQrbUYwR1RuQmRQY1I4bUdZU05JSTZrZGNSbjVGUTZQL0VLQVJ0U2RzT2x6?=
 =?utf-8?B?VTlVUWc4UU1IaTdZN3k1STNXcVgzVDh1YzUxaFRjZXVqUzhGYWtKZE54M2tG?=
 =?utf-8?B?TEwyak8zRjZ1N0E2M0dkZ0RDMjVmZHpDY2d3Q2kvVmpSWmo2azY2cFlqeUYv?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c+ZWXhIT9SomZAD+CLOhqVG5xy55E1n/2fMfr4Npph27jHRgImkg8DWtzmqIitT6FYT892kEZB9S8MnzNJmKskgfI/7nXVQGR7dchGw6/teez6mi7eZ591xGQXIChx2tjlcD1CzUvJtD9V7qd7G0qnC96sabjDEcvmkP4Iz6imOBCGQsNi4deIujXlwNnM72wp9eR21uR/KukbiuFypVsqE4NBIm2YfVZopVdJcmL0a2RQW/M9Jl+DewhH9dhdNgDYmfDMgnmOql3W0UV9AbACnwWq9Boybz4uJJ0Yp9r79H/y3CYmk2j6yAwlOJwGpMI1cfqGuSIX/7atpoS2iOT4o1crnNDwyAwFao2k+HhCiRdEbFBwuUr2Fq4urfDEWNty0qKotFJRCeXvPnZnH/Q3xW0H6kN91TbABniVx1O6xpnnzuVAsTuf/7Lqc2GWLD/oFqqT+Mz6tAhDwmhtmnD1UoAcL0CJlWLS4J7ZLMDOX70Cjeocy+I5x5AikBySg3dCa25BvkEHsmZw5MoOvl+kyixHqBPxWDzjdBnNI90iawDRQWurRybris2TH4xLivEn1C7F4G5fGgBjxLx8el3gUE+8SK0VgKnKLeHOEYOwdpVZpnO0mKYFqBETeiEf6FVLAQ6eRMkBWDLi/feXXXFRX9b/Wjr2ooprmojBSIIrfVfFKw8V6KDVC2UCEZKnniDJ4+E7VFhZt1rGSimg8VPjSJfZRevExBTHIIc2/2I9iT4sPx1JfWuy/s/ogMJHqu6WoW17jwKyrG3wCxWRH40U7GDI4hDfMq+cZsFsQbSJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f0681e-3a6e-4269-9fe2-08dbf5ba573d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:48:08.1138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltdfkRRf+5MZqC57ml+pDLf6DSt74qcPTzsMOa0fm3Y9SLHdJ/T4gEHeC3DIFsbK5aevGDTI4IDK5+snD9E7zcwFY9LdXDFnQVw7nLu2Ncw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_13,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=807 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050141
X-Proofpoint-ORIG-GUID: lfnTDp9BEWaITCiPQSUcjx-bvkr6b8JS
X-Proofpoint-GUID: lfnTDp9BEWaITCiPQSUcjx-bvkr6b8JS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 12/5/2023 11:50 AM, Peter Xu wrote:
> On Mon, Dec 04, 2023 at 05:23:57PM -0500, Steven Sistare wrote:
>> The V6 code does not pass a state to vm_start, and knowledge of vm_was_suspended
>> is confined to the global_state and cpus functions.  IMO this is a more modular
>> and robust solution, as multiple sites may call vm_start(), and the right thing
>> happens.  Look at patch 6.  The changes are minimal because vm_start "just works".
> 
> Oh I think I see what you meant.  Sounds good then.
> 
> Shall we hide that into vm_prepare_start()?  It seems three's still one
> more call sites that always pass in RUNNING (gdb_continue_partial).
> 
> If with above, vm_prepare_start() will go into either RUNNING, SUSPENDED,
> or an error.  It returns 0 only if RUNNING, -1 for all the rest.  Maybe we
> can already also touch up the retval of vm_prepare_start() to be a boolean,
> reflecting "whether vcpu needs to be started".

Yes, that is even nicer, thanks.

/**
 * Prepare for (re)starting the VM.
 * Returns 0 if the vCPUs should be restarted, -1 on an error condition,
 * and 1 otherwise.
 */
int vm_prepare_start(bool step_pending)
{
    int ret = vm_was_suspended ? 1 : 0;
    RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;
    ...
    vm_was_suspended = false;
    return ret;
}

void vm_start(void)
{
    if (!vm_prepare_start(false)) {
        resume_all_vcpus();
    }
}

- Steve

