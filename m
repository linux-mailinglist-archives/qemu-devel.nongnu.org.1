Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3224D7BB368
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogNo-00033N-7k; Fri, 06 Oct 2023 04:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogNb-00031O-23
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:40:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogNY-0002lB-OX
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:40:14 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3967s6DZ020682; Fri, 6 Oct 2023 08:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=E5NbeD6NQvV47TyOJHMjds6UVDN3lkb3DdJbK1TnPdU=;
 b=3vKwZ5dfRwHlyhnEto7d5gtD/tB+6Wyuf47GfV5wpYCDcw+nO8L2lUqzpdc26V2ehDD1
 EaDQkVCVMFKwzA4ayFdOX6FFNTWAnQS538JD4JGgPdUMJIRROH2JZU7SgiazSVKfOPRf
 2Z5jUndMjRWB4cbPd8Z53nnYz9jOZdm8nTrVd5IxHhUivktnZ/2buYrnOwvRjai4N/nW
 gGmh2D2cnQrI21i1UfBHkgmAp49sA7VtasJGp3KgiPpFTDejFHOtqdZf5KEmuypCxMkW
 byV0iUZ2aq6Gw9nf5WCu6YDdsQY57Iu205dHE/DJY92MA17YoM9cIxTQoF24NvWjjglU ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ukeds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:39:47 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3966hFUm008769; Fri, 6 Oct 2023 08:39:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4av228-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajM+CU8Ud5Quk994M4m/cLKZZQ1Bb+kWodikb19UNA9ApcKa1ceUQDVlRZqIi3vpQnqeXz/drLuwnE4TDaHu+IK1cq5ghNYixkqXs5NuaWhxvNXB7hyuVyAxm6YT2s7qMIhl/jqONmnRCN4vB5ULGQqbh1gaN+EL3PKw/pc5uyLjEiRjFpETvxPpaN/Im2VhLmV5q7j4zu8TS+3gkNvcIUuxfKECoHoc2bHv0RkOb0WYiNVyLD8FD1UXqrIMAibaNBoKWnv7XSD6rW01H5S8Yo5LFLCx0p9Su3A2U8ZgXnI6OoqqEtrX+HGv4emzcky8Q7HnxPKdbFJYY0CaNUgSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5NbeD6NQvV47TyOJHMjds6UVDN3lkb3DdJbK1TnPdU=;
 b=SuLU1GxmGkAQ8sy349UHdsdOHepbmlFTHRT+3I0nfRJopw10A5FRKuA+UolSK4KO0hCaPjuwQWpz479+4qDaUmqo5kZky7Z7Y9/jQqDQMDh/cgz5s4YuS2eDZFYVoUxuMZtKUcGPqX0PP8EobElcp7Sk8Djsjw9GhpOb+p6jArvze4fOYkEnht9LIDcJHgLhCtFscSAf9vIIQFINEZQ/DwCFtDn0iKWFReCdyVs7epltiBAXfhUXj3CGGFbAg/7QQSi1vtVcwR/NpQ1/frefZxBR5nrymR0ntbS51SoP8ZK2/RjRBWvjnc0ja7mYupu/cWngvvjjg8a6dLw6sKilHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5NbeD6NQvV47TyOJHMjds6UVDN3lkb3DdJbK1TnPdU=;
 b=kCtUjWnLnORE1m4kiBmxsooBQX4WCIdalCr5lxnLjHrCLwZq/NdEoWFHzcvtuxGOqpetY5iFfMQhd4qXcE1mZGsN6sLJagv1+lFzVlUBO6tFKowDygpJo0L+13pAB7yuA1vgmobGjRXpZbT3+ARF+cO9cuo+t5jmP87oB5BlrpM=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM6PR10MB4378.namprd10.prod.outlook.com (2603:10b6:5:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 08:39:43 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 08:39:43 +0000
Message-ID: <27aedcfb-c77a-4cfd-8f53-30d9acb29954@oracle.com>
Date: Fri, 6 Oct 2023 09:39:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] hw/pci: Refactor pci_device_iommu_address_space()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
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
 <2380b011-eee6-252b-f523-9025cfdb16b6@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <2380b011-eee6-252b-f523-9025cfdb16b6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM6PR10MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: df31d7c1-3553-4f77-faa5-08dbc647c9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQEPD1d/RTfHOJScg02Af8JpbVU4/oUYuq73ldPeWlZz+RJZbhtK/Mwwfwb2otMYoCAU5BsNy4v2q7VuLTgS+n9ryP4Lif1UmgzINCws3trFT+pTEglWQcjfPXDVeWDG58bTJrR3A7ODVR3ywOZ8/e1EPu5/G2v8vvNgCDVZtjwJ0kScx/vFIgMv8PlNSUte9HbOIWduSN1q2qVMHAxAIqvBpmPSX+j1GEh9QaaHlaR9UPOfO3HLTmBcKXkzbFv3HJAd6zExZatARApiPQSrrhD2uz+wZpSrX0Z5Drjyywrzj9Tf5+/xQD1P0rFhauqIZKqUaIFavK9oMBXWlIVNm9LTL17Sb+Yile67KkhWaZXEl0flfTDMPBtG3PQrebeWs0j4xKdYhzNyao9d70VZPhKwtgqqdF0u0OUuDh7SkdopuY1DHeg49V0qoXYrcssJybQlZvviShJ+AWvGzZy8F6SBoZWBv7gKjYyP7Q8DOdxdbjPQ0iuNpWqe6ts20/9t5EBdckreAP7HEior1yqEu6uv2zQPPhnUMXn3Lmv/chZNAlFr4l2X92u7IGkM6ZwUPEKolIX1HAuV+atPhKnZPU0ZAJc66pJAqjWF+qvcUhP5PdebQvlqyLmrj/iJKuNU3EDzFpVj23099ZrIacXyoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(53546011)(2906002)(83380400001)(7416002)(86362001)(31696002)(38100700002)(36756003)(316002)(6512007)(41300700001)(66946007)(66476007)(66556008)(54906003)(6506007)(966005)(2616005)(6486002)(31686004)(66574015)(8676002)(8936002)(26005)(5660300002)(478600001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTVwV3JLWDRuV21kNXlBams1enY2dGdIR1djYVRLRDRaNUt6ZU85SzJGalY5?=
 =?utf-8?B?M212QlFBaHhOZ2h6bHRxQ3huMW5tbTQ3bER2MlhML0N4L1dnVFpQc0MvMUpC?=
 =?utf-8?B?aXRheE55MExoL056dGhpNmxhckx2TzRrcFJzdFBLZXlmaDZzZlJSR2JENWZY?=
 =?utf-8?B?a3cveVE0MGFSeDRtSU9IaVNxSzRkMkhGRm80aExRYkkvWUI5RCtMQVVsQmtm?=
 =?utf-8?B?UUFXOGZkOXZuRm1IbVFiQXJvTE40bDd0VC9SM3R6SmJSaFlDY2xZWkhQeHJs?=
 =?utf-8?B?R2xRR1hqVzgvbHhmNmtLeDFWdStYaEdEL2hLUUpyNUNqR0pLUWN5T0Vrenk2?=
 =?utf-8?B?NGZQakI5aUl6ODRtZytQWXU2NklNaUF4TWpvZWVJU3Q5R3d6cW5icFNNQ2s1?=
 =?utf-8?B?S1I0dnlKV3RzQnhZNWc4aTE3Z1BhU1M5SnRScFZMQ0ttazBDbUlEdVgvL1RH?=
 =?utf-8?B?Yk1UWW9FREdhYmRBZ2NDa1BQRy9mZkkxcExOaXBlSmIwSm1BSVJMR2FnNW1x?=
 =?utf-8?B?Q21HUE8wUVJyQWFHZStwajBpc2pjSmJDbS9ZZytKa1piZ3VXRFY0ZWJUT25t?=
 =?utf-8?B?d0YvdDZ0MDNjSGlXQS9vRk5lbHVDVXJlUlB4VkJoNmtVS0ZpZVRpYUVLVEVW?=
 =?utf-8?B?ZG5Xa1pIT3MrRWNIWGRkYXRva3lXMFFhVU5kQU1sWDF4bnU1TUUrYlNiZUY1?=
 =?utf-8?B?NEp2MnFkZHVFWFZVNk5pQmY0V1BFV3c4Mm9QS2padDBwdngyTUhGK3dCbFlo?=
 =?utf-8?B?UWhRN2c0TGZLOVhSZTdDV0QxdmE3YXVUUTZEaWNIN0dFb1JWQ2syS2J6VjlX?=
 =?utf-8?B?bFNxQVdmZ3JLUTRmbEpINWlKVjJBcTJQenlZOHRhZm01Q05ha3AxWUtJOGcr?=
 =?utf-8?B?ejUvUC9rS2NHNE0yMUVLT3lydU91VVJNa1Qya0xZNUswQ3NycXlYd2IyUlVO?=
 =?utf-8?B?NWdObVNUVzJmeHFQNEd1cC8rUUF2NUhnL0F5ZXZVcUduR3cyWmZoOWVmOEcv?=
 =?utf-8?B?TzhUR2F5YnJYT2ZrL3EzZGNXS0pNajhiSDRjV1VXQU9MRmtpYTlwZ3UzaURF?=
 =?utf-8?B?Q01lTm5yVW1KYzVVVmNqVVVVNm9EbC83bW9HSm5nZGdhS3VFcTZURW9rVytR?=
 =?utf-8?B?aktPaHFrNXhlK1FweXNLVi9Ham9OOFpaM3hjQWlGMlNMNFhCUTU4RVAyeVM1?=
 =?utf-8?B?bkhrN1B2d1pnTm1QMTJHMVNkd1U5NlhORVNtc1B4R3lRSE1FWE9XVkhzNytq?=
 =?utf-8?B?Rm0rTFBaQlVBMHI5N0FzS3dncTZobTczamhCWTlQYm1qT013amJSNW9tZFQ3?=
 =?utf-8?B?azZ2OU9kbDhPb2dPcWVkOFRNcnBMcU9vNktwVm1LSXNNSnRXWDl4QTgxd3pp?=
 =?utf-8?B?ekw5cXgwK1JRbXQ0YlE1c0pqS2dTZVFzZWJTZllEUGd5aUUxUHArR1lSbmtr?=
 =?utf-8?B?T3NMc1VKNThjaVQwZ1ZhSGRwZUx3Z3VRSU5KYUt5dEk2NDQzQ0NHaCtoUnUx?=
 =?utf-8?B?a2J2U1o0aU94OG4vV0N3bDExZU4rQlB6UEM5cVBUKzArMXgxcmhZSVk0Z3Vi?=
 =?utf-8?B?eXNUQmVibEYvSUZsY3Y2RkJGVXlwb1ZuSkpqY3NlYU4wSkVQSzFGUHFieCsv?=
 =?utf-8?B?azYxU3lDR2dMS1dTUldDS0Nta1pObEFFMGVQWTNWUGgzRExnOHNsVG9hNFh3?=
 =?utf-8?B?M3pmaU5vbFhRSFU5Y3o2LzR1VGZPSVdSYU9xd2psZTJkNzlKVUE1UC9RVnhK?=
 =?utf-8?B?K0NMVG15N1RWekdmdHd4cjlrQWVKOTUwOFd5WDVYWllwTy8wam1BUnRZWTZI?=
 =?utf-8?B?WllicFBoWTRzaFdXdDRpdVBWZTNwM2tqbThPTGtCRzB4VzNNeFljOHNNWVBL?=
 =?utf-8?B?Mm1MdEZhMTNiaWE2RjlrMmtvL3NIeFJ1QlhYM1NaZW9XWGpaUkhNSUZBc3Yv?=
 =?utf-8?B?OUEzdmZ1d0RqSE4wdnRzSmhtRTY2L2VoRnZlc0VwZnF1bVJEblNNUWsvdkMy?=
 =?utf-8?B?anNBalFabENXcWFjTnRkWlo4azh3ck5WQ25hMlVpOGducW1WRXpJWWtKQjJZ?=
 =?utf-8?B?QVFVS1FJYjQ5ejZJL1o3WFF2cFJxN3YxdHFhMSs3bFV3SC9IZ09zV1BIckZs?=
 =?utf-8?B?NlZYMUJKYUoyNkNwcVRUdzI1OEViZTRTcFBZK0liYVlpTWgzdkRKczhHSXJG?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VO+/CyAtcaPX1FC/6c3uzeYHGFVl0nxifLNUji35Qmvjq4ylfBvbsL2Mx8IkzM7jVVQlnxDORi9KPQRDYgLuzA0h+PGWGw4twylBW4ZTAXUMGkKCBKXbHUvYKeThoq/WxW5L82p7lDVXuijsd3fwvSln6kjnxSrCi5CNwQ3h1Wf5RiNXul5fs8c3WtVFO8ZvXUwSgrxKbjeav6pVoH5G/Qazxs07m4LZWXVodMy30bDPnVUNmJJECyk6RGUgl1iYInI1cXAbTPcNsSq/hmvNTCMQoUtNbgDZad4mr5fR8gGls/S7Bokv4P6oXrIdlKQvEhI13fCDr72PkgW2+TU/xcye2VVeaZ857UiFEd8BzEKAtM+blWEzRDDbQVDSZD0HXukduWlIHJSe+5FHaHmhP0sCg6Z+wszfjmbPDJOMqCbxqBS78gLkbMNkNaO1Vu4U9O6hZpCZft8dTScD84DTXSx7CC1FhiPuSO6c8Egxjukqm5nyqaNocz+N1fGss9e6bD5ag/eYXhRfxzGmTyY9NwdiGlfV9VehW7Y6shpQtrN5O99/IN2CYQWhS4lGqaBjg72ey1R3BCjpIRSc7xVQCVgddLWIrf8GHN6Axb7aDUiHDzRW5KHySmv6jzaeMHag51mdB1WOIVb04znLTgDbvs2FkbcQ3d3gNlDLheGwhoam+0kmGn/5OrquGozyf8YvfYVeEpJOPLwrpfrtw976F8TcG+9cfBvtJJ0jvU1brptC+bV4s+Nm0xSm/whXnrXgl2BnpfS7funMtghJPhOz58JHuFYV1CxxdV3XWaVwvjUuVtnZBZCKrtdDo5DinQ6Q6X/kfovCTCnr1pY37vwNNPZyAUjMqvCVCyFVfE67v7TPHU0J35UOirVYqizzZPSXDtC6sAgSnT1s55SJUYLwzcSYUG3SxDVasers85hKRlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df31d7c1-3553-4f77-faa5-08dbc647c9d4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:39:43.6907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIyV4tzAPWgvdnqJ1thX9CfLVpGm/dfVYsoc7FT6e94SlijB/B4GRuMUU2EdmVroBPwjky+gz58hS7x39qBqiDtTamuxrL8rHWBG0h7zb08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_06,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060061
X-Proofpoint-ORIG-GUID: Q6ZFXFjdi1vPFb9UlluvTf8lJUhkcem9
X-Proofpoint-GUID: Q6ZFXFjdi1vPFb9UlluvTf8lJUhkcem9
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



On 02/10/2023 16:22, Cédric Le Goater wrote:
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
> Where is this routine used ?
> 

Patch 7 to understand if a configured vIOMMU supports DMA translation,
regardless of whether the guest is doing.

> Thanks,
> 
> C.
> 
> 
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> [joao: Commit message, and better splitting]
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> Splitted from v1:
>> https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
>> ---
>>   hw/pci/pci.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 4e32c09e81d6..90ae92a43d85 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2632,8 +2632,8 @@ static void pci_device_class_base_init(ObjectClass
>> *klass, void *data)
>>           assert(conventional || pcie || cxl);
>>       }
>>   }
>> -
>> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **pdevbus,
>> +                                           PCIBus **pbus, uint8_t *pdevfn)
>>   {
>>       PCIBus *bus = pci_get_bus(dev);
>>       PCIBus *iommu_bus = bus;
>> @@ -2686,6 +2686,18 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice
>> *dev)
>>             iommu_bus = parent_bus;
>>       }
>> +
>> +    *pdevbus = bus;
>> +    *pbus = iommu_bus;
>> +    *pdevfn = devfn;
>> +}
>> +
>> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>> +{
>> +    PCIBus *bus, *iommu_bus;
>> +    uint8_t devfn;
>> +
>> +    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
>>       if (!pci_bus_bypass_iommu(bus) && iommu_bus) {
>>           if (iommu_bus->iommu_fn) {
>>              return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
> 

