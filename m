Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233937BB5F5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:08:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoigf-0002SO-5e; Fri, 06 Oct 2023 07:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoiga-0002Nl-MG
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:08:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoigY-0007Br-Iv
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:08:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3969E4rj008330; Fri, 6 Oct 2023 11:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CpN+8EYGlXBrLB/II00YCnziqRuaU4CVytaHSlq3cnA=;
 b=rzsuUNhftjTbvo2JhJqcal8qJ7iMhibuU70TRQN+2WX/TQmPTkedSnOOwrPYOMymXLCQ
 DkEi/pnALCyn2doprH6FTI3dfakYuzw+vTVplRu27azXFIBNqF0yBvp/GCXV5agTQP3f
 oM7M1VBySF4X0d9y+7IQv6HYoSi2gt32TzssV7o979m2vjLZV7lfgXYHH1hD9iRtOWE5
 L1GGicWdXYXCNzU/BKIbPSrA2tQZtWU0KFc9DcqGTgWEI5b4NefBO3uo2WGMEoFdnPiL
 /yWmK0PAT+b877F/RegjUshpN6horuoX7Go+oiVnpkWVe4Icz1Se1igdUhUZMakEqAZr Dg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vkhvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:07:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3969C47f008802; Fri, 6 Oct 2023 11:07:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4b16m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:07:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9QPMZScgjxIAbOMOE68F2GMe6vRDOJ2rts2rtM4F2cNKnWFQM7smVxpYEfYDe2SmlCT99PdPBMG/A+mvbw14jEQ6rSDV7buccMDLMfnNxZMiaQaSBHI3lttI9sSH+6q+b7y8Eq93AaGjUqFEngzOrsFwAEONp5R4uhX9pYGb3YoqyMYp1Hl8NEJ9yhDyQ3Zor+YVeSsfzDNdHFX1DrB12lXf4bgXKcvR1A+7GMdSvAyqwPPVOXryX03hjXot7gC0kNDUDVeQEXMDACiVIxgG+Ez41LbkVJ++FqqATe6x9+ShryWMm7zO7va8CPvtzn5EFcbmjKY5uZ95AfegItmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpN+8EYGlXBrLB/II00YCnziqRuaU4CVytaHSlq3cnA=;
 b=alVd7sABk1KUt3iab1on8ISHgOzAdvRogzIBaEv/ltdYLUEsZlKVdHFWaesiaB2hpG4TObzP/8cBWCuEpELtqo9kcoGgh9QI/ktesGPJfFVBeNzbsiU4DMTw/lDRISijkYnJhnav0YFLmFnO+oZoQDLuHA7V1rPcahWHCP2DKuPbe6lovd5rfG2iNaCJvQceQKTfhWc/SMoWmhgXplaaYpyZnxS3smTSzen4CbNj61l8MlxUz6nJlP1pz3IPrDil/1AJmsqKFEW/cIzgaSEgfrFhZd6wOH/y6TSxS3Tqp2/7BJ6n1JnLy8vrJgyaNW8Pil15PfVgY2cV4Rr2LzMp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpN+8EYGlXBrLB/II00YCnziqRuaU4CVytaHSlq3cnA=;
 b=Ivyk71dE8NAsKMqDL+RNeMTfWVIFXvUIeTBIN8yk8fg1QQC3uUyFCanet4W6Oo4OB7WegUz3+wpmwsqiI8uxXy/TjDOvpyJpv79J8RKDgjFxD9OsYAWJwmJJcjha5IQal1pg8KhgkwE41MImd310XgbaQbQ4dInwPLfi38qXDOQ=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BN0PR10MB5285.namprd10.prod.outlook.com (2603:10b6:408:12e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 11:07:44 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 11:07:44 +0000
Message-ID: <e753e339-e4b1-414d-921f-b0f56867ed9d@oracle.com>
Date: Fri, 6 Oct 2023 12:07:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] hw/pci: Refactor pci_device_iommu_address_space()
Content-Language: en-US
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-3-joao.m.martins@oracle.com>
 <40b3bd8a-8c59-e61a-14d1-a45dba95a235@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <40b3bd8a-8c59-e61a-14d1-a45dba95a235@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0147.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::16) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BN0PR10MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2a3a72-5cf1-4f7c-5628-08dbc65c76f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpjSqpALgwXAi84M03maeNe1NAw2hWD5VO/JeHuA90DCTxt69a6tDM3KTaOuKz35GOyKnRGZ2iCf99Sk2dPOljdvJL3DMvfz9fBM4qajYQEUKkxw7lHRdn9pQHlNKXr6vKZ7l6VLhI3Yb8f2w7y1bR3T/FSDHJcOU9UA00wH7UY7KMmn2sPjFTbQA+JMu474uglinJ+76WhKYQu+edQ488Xef0AngP6yY80gDpBW65DQeXsHrhKxAFhEjwTeXisdUzVApiGQukRKebBZpWnJWJMk19MZxGVCoyNBRFyWlYiVIN7Tn06khwsPzGBQqPBBeI5Z73u5rnM2aq9AIJoawDIzhuvsQOYdQncYM1GMkeWAO+8vFpSpduf2zmPa1wyjZMab8FD5Hty+95+SA7RR8NgrCk3EBuNcXL+4Skzncfv5fIilLxNTL1px0OA3iVOhI5nPLbVMTApRfU5VnoEkQ51M2hle59BDpc5deJsaFlh9D5pxoJ5ld2oeFZujlFLyqO+1STNs1zDJljdYhnUQwQMXav76PFPFzKIeP3+gW28BJQ41FKR7Ze9nXmR5a5rPhrUGCOap5iFDF3EeUB82OjJ6GW9wrLCF5ktVnIzNxCl7h5ibEIbBz8i9pTYpuAIeiZ8yc6UUjLXvE25XG4jUyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(53546011)(6506007)(6666004)(478600001)(6486002)(6512007)(83380400001)(2616005)(26005)(2906002)(7416002)(4744005)(316002)(41300700001)(54906003)(66476007)(66556008)(66946007)(5660300002)(8936002)(4326008)(8676002)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBpcnphNDc3VmhoR2g2eThFRU1HOHhScVVMTjRPbDIzTkdtZWdqaEZiellM?=
 =?utf-8?B?aXJFSnRGVDNsN04wRDlRWi96bzg2NUVtNHJEdWcxTm1zM2JsV2hrcVZMT3p2?=
 =?utf-8?B?R0ROTWFXSXM3MGs0aFh0Ui94VEJoWGVob0c4VHV1eDFQcDE0Kzh3MHMzYVJy?=
 =?utf-8?B?MHhneXJnL2pUNm1iZFZnRVNoV1BtOWsrSzlBYXNwZUxvdEFTb1lISHQ3eHhM?=
 =?utf-8?B?Q3FMVTJNcHNtaFF2eXhQdUE1Y29yeVJWaWJOZlpHYTgxU0Fja1N3MlRSeHBu?=
 =?utf-8?B?dy83YVZrT3RNMlcyZUZnYlRrdElSdXd3VFZpUU1FOUdPbU1nQWx6czhUTkdB?=
 =?utf-8?B?K0RDY29xamhSU013UHRidkVjODZBRWxUUXMxdlBUY0FOYnNMak9OSWMwRlE0?=
 =?utf-8?B?Y0dTUnZFbUlhSFFaTkpDOFVqMUlkTDI0bHdIMWJyd3pNcWFaZ2JIRVNPMStY?=
 =?utf-8?B?dXZxUzVsU3RlWDJuZk02dm51R2lpQlBhVi9XZ0dZUE1mZW1aRTBMQ2p3aEZw?=
 =?utf-8?B?WUJlMjM0SGh2MlNmMWlvOTZTOEFtNGFyZ1VQc3hSNitZSVBON2ZCY0sxWWh1?=
 =?utf-8?B?em1JRG1SMXZndTNObFVkR1lqcWZxR1JWWW1TcjlNZWxST2FYZjdWN0RnYzZ6?=
 =?utf-8?B?enFIQkdoLytJOVRnUDgwT3FFRm9oNVV5aWlxanNRVkVOVzBpWlFUaTFXeHB3?=
 =?utf-8?B?aTUwL2lWK1Fkd0QzVHhaQS82b2tOZ3preDlMdjZMYkRmbTZJTGI2YWpxU2Ri?=
 =?utf-8?B?ZXFiVXFibEtEVExGRjcyaXlvVm5aYm5sdEQ3T043MWtycVQzRGxRMVVGZkVm?=
 =?utf-8?B?YkhvQnVzQW8rcGdaRGg1MGVCcmZXVnNUVmxoY3hZMUpsUXNPSlRwbFdvUklM?=
 =?utf-8?B?NXZmUHhZS1NQNU5VeDhBdXpXaDJ6VTF6Q1V6NUFLNFpFZ0FCQ0NZVHIwb0px?=
 =?utf-8?B?Q3VBeFU0SlRxM0JwUGlvSU53UnBJV1pwRkplN0dxRFg3TEUxV0xuYTA5ckxH?=
 =?utf-8?B?aVRwdWM4SEtBYTF0MXBzcGdDOW5KRnlIYys2V1BPMEZIYTkxRmJjOEg3Rmpa?=
 =?utf-8?B?SUpPZ3RQWEI4NndMdDhBTXFhWWlYTVBRVW5YTWhQYlZXU0FUaU5iTnlWNFYy?=
 =?utf-8?B?cDR4TW00TnRqRXp5Z0VFeDRnOVA2SE5VQVVJSFp3b3N5Vm8vT1d1U1F5ZEV3?=
 =?utf-8?B?UkhUWFBFRW0rNXVzZmd0OWJIQTZsaUZKZmNJWHZZbFl3ZWhiZjdRNmgzOE5C?=
 =?utf-8?B?YUU0NHdQdXlwNVRIRDZST1FIU0ZpK2NPcS9hT1A1Wis5SXQ1VFQxb0ZZYXox?=
 =?utf-8?B?ZEU1YmhaMnllWVNGYVZzWE5ENm55VmhHTEZLOEgwU2ZEdFZFM0xTR0I0czRC?=
 =?utf-8?B?b2hZaUdoVVNvTys2cGlZZ3crckVIWmJKcUtFUFcxVWpzajNrcFBvOWdXOU05?=
 =?utf-8?B?S09IU1VpQXZEaHFNM3pZekJ2MzlRaHNYRXNxVGt4aUZMb1lTc1A5Sjh4Sm5V?=
 =?utf-8?B?YjJJbGp2eFVJRGg5Wm0xV09WQkZJNUxoNEgyeEptZ2JDeUkvakRvWlE5NEtD?=
 =?utf-8?B?b3h1aUJqTENxWTdIZkI4V0hwSWtsMUlZOVZEUkF5STg0OVN3L3dxS1JJcCti?=
 =?utf-8?B?K3hHMDM3NitXQjExcGpaQXlLZXFZTm9nYklOa2xQRm9MRjdGaytMUTdUWDc2?=
 =?utf-8?B?cGlIU29iYTF1TUdGbFkvY2RUM1VOdUxVVElsTzRyblMvdHZGY1FZeUdQVFhF?=
 =?utf-8?B?a2p5ZCtyTGtLS0RJWllkQnVldzkxbktDQWxxVjBuNTBnWWxxbWtaZHZZUytU?=
 =?utf-8?B?L2VSRW90THQxd1FlNXZ4ME1wWFlCbVBVZkM2MlZlYitmY0lQWm15VnVtYk9r?=
 =?utf-8?B?M3hFUWd5M2JsckxuOU5MbHQ1MzVDRjNFMTZKb2tYZVM1T0VPS0E2NlVpL25C?=
 =?utf-8?B?ZlMzSnlZMmVsd2tzamJHYWo5aVlKbmFIQlpkNGg2QTdVdVovNk0wN3dNTjVk?=
 =?utf-8?B?REFZWW1qVzExU1Y2VkJ1UkQzVjA2YldDZ1JQcDBtTmVQZ2FXN2FxR0s2eDZi?=
 =?utf-8?B?VjZiTkpUc1l4WUMzZVphODE3MFViaC9BVW12ckVVYXErVC9EUkFkdTZJbUtj?=
 =?utf-8?B?N1oxWWE4dGRmUndheFZodmVvc0ZnUmoxSzA0b1Y0TlptbWtrcFVHcW41SVE4?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TjWR7Tp4iW6YfXWoob+E539U2mVe+2IqBOQlERP0UDAhQnwctfDg31cD98buu3DOOfkSK7XpGYG+AUulWUUBMCY3f0qRfafIkr91beBNPjGM+vrdDYgIiGeq12jxjz8xJqElQowmibe2xueRJlRFoYvLgLqlTkv/VNvFIW/Q7dcayhaT7SDaT3jStCdnnR9IKxPZHFvhrnXkG+vAO0g7v6C0VANDWgCMotvsuDiPkwW0lVZRYtv6AHVJAyfTvqy47Ya0IOsp4Ta/FnxnpDeWR7hwncmNA5oGkBxE0vSUWp+jfOojFxaZz5G+r9cfv5kaf7/EZhFDnep46iPW58KFiEIsEq9l+aYRJ7HKvusahxufGTcqs3fgdwaRr0HFU85yF71/utbYBtfs7vC+1zepmVNY4edGcsIgDrKYNepp/EVDgyRusgoDe5nQ2BWotGpFW7f0U+xXhCc9RTWaaOpwqMm5UfL8De3mCXsNJyqgm1dtsj1G1lrB8JCCauRZY/NlZfZk1G/q8uheBMxcXqCeZ/z8Ff8Ob5iRz5DCnS3jllmSVPnpm/Dz+G8rtN3aHrZ+IUTvAmHeXB8Uahkz6hwKFNGQrcmohdzA2tP/1LeMPrhoUItyShRnyOZ9JRLmWPAil8r5G4RBAbXsk/9Sro6OpHgtm+aPqfPkXdHcxwxinphYQKTpbAmugPJuOeKmjE14uAFWU5VkgS75yZenj1gHRfX/CbaRj7UrtalDqYWDfXSBEftSpjClIGdyXXr8ubPPFHXe9x+NVvrvNmKJMFZLZVJEUVSrACNV/pNeju2Dp2yYji7f2YE5cJLTwxv42KH+oyXMJ6LHOD8qY61iKbnVqXfte0Q4Z6IJbzPxzaiWiGxpX09EcO2ELRmavSLc7uCUsMyBfvts9tH7TLKZ5KynYe5yDPr0gGBWWzr1v56UBaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2a3a72-5cf1-4f7c-5628-08dbc65c76f6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:07:44.0065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXClvJvU4LRsYqsCHxyq8PrucvIwzBm945PgLAhV/uVRsAudXz5RyUr5uFSWomDmmRAidHZPCoqVFaLCNJafrTA54c2OxtrqNQu9xcAzZl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_08,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060081
X-Proofpoint-ORIG-GUID: 2YjNUspHd6vVxO-VXGwG5agMh9BrKL55
X-Proofpoint-GUID: 2YjNUspHd6vVxO-VXGwG5agMh9BrKL55
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 06/10/2023 09:52, Eric Auger wrote:
> Hi Joao,
> 
> On 6/22/23 23:48, Joao Martins wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> Refactor pci_device_iommu_address_space() and move the
>> code that fetches the device bus and iommu bus into its
>> own private helper pci_device_get_iommu_bus_devfn().
>>
>> This is in preparation to introduce pci_device_iommu_get_attr()
>> which will need to use it too.
> 
> you may add:
> no functional change intended.

OK

>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> [joao: Commit message, and better splitting]
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thank you

