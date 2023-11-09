Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11DE7E6C78
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:34:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r165p-0001kS-7V; Thu, 09 Nov 2023 09:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r165m-0001jO-65
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:33:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r165j-0005sc-L7
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:33:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9DbJ3Q018594; Thu, 9 Nov 2023 14:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=J59dBEkf33vFpd0Fun1CUbFhmd101VM6yZibQbI1+Ko=;
 b=YpqWZA7q0tFj8cFC77cdxmeH3JtS9dpBCNWx0RdCr9TuD6yPO5GjRk05+J+N5GoQojM7
 rbbCpufN70Csy85DLVOnou6GlWELBZ7z0H+5o6wFgP+6SXx+r9TB1eAXcoKqxMx2rbWV
 JXFiWQZ66t3pjq87v7lgJGMqQUR/LsHxP+iz/nm1XBEUpHOpKhiQqINMas3+bNF75j3L
 SL0QNqKWlW2tFjYaZ7lUtNX3ncfYgMjZmG/emVW4bDzwVceHQcpcRvGSLh42aHk5zWX1
 2YaSUc60/q43ufq0cU52vBZyQ9X+NRdrVFKqAe60xjzqyDep8EWsDqCZ6athjI103oKt AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23m3ef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 14:32:49 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A9Db6eZ017608; Thu, 9 Nov 2023 14:32:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u8c00f55a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 14:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFWP1Hpvo9BUrGmBGQsAi2lxEN3mBkEFipsTpLblYOZAeNLr3zBjHcvMhs7oRv/897gDBjK6BasYMHil/prX6TQc2iMCPzpVa41RIYL73f5bjN2nnZtNecakVVR+ljGtw7P3wf55v6RU3elJo/FeRrNmQ15XNNWbL9dfgdgnouqhXw0KBAiVS7hY3h4H9gj1IkxGFrqkjPcd+2wyCnLGCwApvmBD/tbey7DhGiwx4PyE/kd4odPSGr8KaF+N7YK8tveMNgYkyZfDEOZmbzSvww0RR/yIiYakH8DqyYG8Mj7Naou/mvkFktAc1l0huoejqdSW33M3rNG4Gj38Lv8h5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J59dBEkf33vFpd0Fun1CUbFhmd101VM6yZibQbI1+Ko=;
 b=i4VlJXdGlVLUivE+0qlUXPviSXf/PRuhuya6mZvFrDgk/QMEbmjHnFpMNaN1tbT1UrtNqdG+5jSKWm1qH3NP2fFsr9Szj5DBJoelFElRGICiYOhnEN2bIEVDrew40iO+GcW8OVe/1/iMWkLHK3YUpaU4KkxNa5m0vCspHsBlGMKZ37CgWpGnIPmSwL/aGHRTHh9CbudT7jiZmsek4qLQ4oMPTOybjUly3mF5eDoObrojIVlFsR6trEE7FqGKsKnpcvA0D1KYSTL+REnxBkuHuWvmdTpVvPg6Gq5d6vikeljRfZMMSfhsFpHrQA4oMHphO7qDm7JVKp6nORFxoSD4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J59dBEkf33vFpd0Fun1CUbFhmd101VM6yZibQbI1+Ko=;
 b=SSOffA801N55wQoZrRJLrflxOC6v/ISgOeizTyTTPkTdqtDCsImWS5CTBJbIxEUH6bvzE+9YnYmCvHNOqLXSbJkJjNcaohVfNlZqPqwazmoGh+sugf8/C5Q2vBS5aVs0foy1gYWQVMrvvsDuaXj3WEIla/UNz7CnEFXI2VAK3fs=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 14:32:44 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 14:32:44 +0000
Message-ID: <756919c3-13ed-4fcc-a4b2-30cd431746a4@oracle.com>
Date: Thu, 9 Nov 2023 14:32:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] Support x2APIC mode with TCG accelerator
Content-Language: en-US
To: Bui Quang Minh <minhquangbui99@gmail.com>,
 Santosh Shukla <santosh.shukla@amd.com>, qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
 <8bbae7b9-3923-b5cd-ff89-50baeccb5d02@amd.com>
 <1c4cf652-9b31-4b22-8bb9-df27dce74cfd@gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <1c4cf652-9b31-4b22-8bb9-df27dce74cfd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0646.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ0PR10MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: 50862960-d0b9-4d7b-e720-08dbe130bc9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZYMN76hJ0QzRPioqrniANu4EVZNov1KfVxfWmiqPy+6QeNVyVkDmGqFCDItp9tIqJcGVQ7+Ap/TYY7ZtrTTJov/s2HsAGKNgncXYnjC5VDEAeTXuOnnODpayfaXk8YxsdJ6OpK9D/q5BwDm8l8yAmffZoq+YN+X1DGmVLXsPFpZyWGyO0m9BpGCfmTjstLTqxPRV7btfNMjyWYB7jtAeQ3cxFbOzHbDumRxrs7k4pO3dsDgWhOWSok4taT35rx1JxnUrBEt9KBHd2V/ytQaGOWWKsRrAd/xRSmGJOKL5ps2eliB5g8BPj5naKbxD0LujhZexO/smvnZ3QFdyVhaK6GIcHs7vZglnX2/0QGgFBOOoVHgbptZaXyUSKDuLIgHyiI0E+5oDjQvbpMCQRanCvyi3O8Z5jfGAOeU433DfNVxoK9FKW/WPmnvEDcMziPRg0iuYvgoUZZtxCibPE+nOmWa5t4jum1T8uPoivvU9+zVl4ZOc17khavc6CgxyTNtiKfs45iSb7wmIl+/Dcjvmp9elw54O3td/AntUSA4taE7w1QQ1pfGOT/Edo2655j32Cw3cUMImWfN8pDpUDapa9YNIua40Q7UxbfYQxZK/JrUb+sOVCcgKugHiTMQtTd3p+KO9eUn58/R/SY/8DFAOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(7416002)(26005)(83380400001)(8936002)(38100700002)(2616005)(5660300002)(2906002)(316002)(8676002)(41300700001)(4326008)(54906003)(478600001)(6666004)(6512007)(66556008)(110136005)(53546011)(6506007)(31696002)(86362001)(36756003)(66946007)(66476007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1xSkFNQi9xNkRISXA0RTlaalY5ODlkUVBvdWx5KzZsWWpBSEpwYWlHSkxI?=
 =?utf-8?B?RlIxWjU5c1FzcUl0dVd5NERFNVhLWjgzeGdCMW44MUhxalFJbk1wSmIvSkd2?=
 =?utf-8?B?NDlZNHFnUmRGbVAwcS9KSkZXTzNpVlpzNXpJNnZwNm1OTSsyM0p4VHY4cGhT?=
 =?utf-8?B?R0ZHZEgxVStQcUV6UGM1bDRObjFObUh0cndDUlY3OEJ6NGs1MDJ4WG9LbkhC?=
 =?utf-8?B?NmUxc2Z5Q2NueERRU1lZRzBSaVN3b3B3QTR3YUtOaEF6a3ZVNU96QVRqQU9v?=
 =?utf-8?B?OUxmU0V1cE04NFpJbWI5OHNKSWpLeUFhdW5IMDBYWXpNUUtaS2VYeDdQdzRQ?=
 =?utf-8?B?a05SenVnNlJPRCszVkFFWFNPOHY3bzZkSStHcHVFM21pZmhkcDR6Yk1xQ0Za?=
 =?utf-8?B?NW9VNU50dk5KQXhtMVovNFJNWXJxUlhWaFlQYjVQKzFYd0ptVFQxQ2VjK2hK?=
 =?utf-8?B?VzlKeDFiQWh2OXRRWDA4YVRqQkMwSEVYVW5yYTBPRVExTEtVRVRmMkZRV0dG?=
 =?utf-8?B?MmUwbUhEZlQ0VlRJZmlnaDZvaHRac1VyUkNXdm96amxnc1hNNlhNY0J6Uk1W?=
 =?utf-8?B?QnVMWWI5R3ZHdXVjVFJJUVNGNnR0Mzlod2FVR1A2WlRZQzlYTXFXS1FyZkVU?=
 =?utf-8?B?dnVUSFVoOVJ3S1phMmZXd3NtN1F4V3k2ZXpDQTY2QWFiUE1ZaHVQVDdIWHRj?=
 =?utf-8?B?YUhBM1Zrc25CczBOSVRCdjlwSVpRTnhOUmUwOE02UXh2cGg2RGNSRlloa2hK?=
 =?utf-8?B?OWtmMUR5TG5VTXZXRktLeTlmYWFsNDJyYURIdDVoZWd5bkZWMytrV0d6U2RJ?=
 =?utf-8?B?YlRDZUMwVWl1NWZGQ1B2YnB0MVFCQUwxR1RjUEdTejRvNW82dkg3NGFCNndO?=
 =?utf-8?B?dVlZYllqMy96Ylh1VDNETHY0RzRXd2J1ZkFYMUtnTmtuK1BDdzlUQTJqWlFB?=
 =?utf-8?B?UTlpUllnSFF5MW85SVNGMzVYeHF4ZERxNVpSQkR1R0Uya2NBMGJxY1VNdnkw?=
 =?utf-8?B?WmQ2M3RreGVYeExRM2ViSkZZcVErOFRSRncreFV1Um1MbHFkY242YTd4dm5O?=
 =?utf-8?B?RlhhS3hybkFLUzJDQ1V6M0h6TUFWZmxLSEV2clh3MU9Fc1VCV1NOR2gzN3Fs?=
 =?utf-8?B?d25Wdktva01TU3k3SUs5NEdHSG4zSWxWV3ZaQVd2c0Izby8wdzNyS2w0V1lO?=
 =?utf-8?B?MEx2L2tTa2o2TUhrd09OMTJ3T3Zoc2kyc3FFWDA4UFZMR0Vza1h5Smw1M2px?=
 =?utf-8?B?TzVYNWJFUXA1NmZwVWo0WllaRG55aG1aNC8zSnVHSHNxSDhDUS9MRnpSYS9x?=
 =?utf-8?B?YmxpR3dTbWhjNnZ1Y0MwUUx2L05LdSt5NVFIK0MwM3RydldrWlc1UnQvQW5j?=
 =?utf-8?B?eG1hb0kvMVBqeWdqc3M3RmZZQlduNzYwREVjVGY2NVhpckt3WE1yODVYMnp3?=
 =?utf-8?B?N2hXUjdWRmUwOS9aa0V1cXMyeXpUS3ZOS2x2ajN1eHRkaGxzWktINUtEdVhK?=
 =?utf-8?B?MU1hdVhGUDlla1lld1BvSWl0RzRFbkFYdG13dlFLSnJQNXQxREFNdUZyTndn?=
 =?utf-8?B?R3hCTTR3cTBJRkRTR0FtaFdjTEt0N1F5c1lidkhQb2ZRN3diTC9kejFSWSt1?=
 =?utf-8?B?blUwVk1UY2lLT0RBTEh6YWZiUytxU2Q0SHhoUnBwYXh6TG1HbE8zL2FyQnVE?=
 =?utf-8?B?ZmVYYTVETnpSbE9RTmlIMVpoQUs5M1A4SmYyeGJPRGNiNWN5RURtRjJ0Yjhi?=
 =?utf-8?B?WUpsVnBWcWM3OUdFdjlqOWRlUEtRMXg4UDl4V01CRUdQS2UveXpYV21ESEUy?=
 =?utf-8?B?cDVqOCsrR0h5czJDMUFmcDNDU2ZiOXdVbjZrdklvU2QwWWNYTmFDeEtSaEkr?=
 =?utf-8?B?RERpeGROdHhQVlk3NkhObHRvWW9XckdudERkTngza3BaaE9aUWhycmhWanJy?=
 =?utf-8?B?R1lxOVRJcG1LVDE3bTMyT1ZJR1NqWGlZSi9Day9rTTh2KzN6TE00d21TUTVs?=
 =?utf-8?B?NnBPMjJod0wwOTcyU3kvcEh0akJ2TzVvSi9wVnpMalh6a1ZzdU80T3hMMGIy?=
 =?utf-8?B?SWtrcGFNRFpkVFpFWHMzdVo3K01pc0dDdVVXVGNDbnZ4aTB6OVJPVnk5V3k0?=
 =?utf-8?B?Zks5QTlVTm4vY2NHVlBrZHBudUJydWx4OFd0UWVwd01DZWZ0bHd0ZjBIT3Nn?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YkRSWnJsdm96Tm10VnY2U2k0UXNSNXV1dWJXdEJNZHQxN1JqbEtPcmdMKytV?=
 =?utf-8?B?NkZDTkdyUllyTEdXZkVhYUdDb0t3Z2dBaVdONFNjN2pjanpPTVM4WThoU0Nl?=
 =?utf-8?B?S0IrRWRZUUkrMDQ5TTNZVzRmV1V0TEJXZjZkbUpYb2RCV2tlUkpSY1UyTHhS?=
 =?utf-8?B?ci84VG9VRVNZemdiaUZMM2dhangzalRla1RtRE5NYys1SURvb29xZVhZa0dK?=
 =?utf-8?B?Z0tzMHNiTDgzS3lqOHpmNjl2RmVudFB6YzVWVnhFQjJBdFBwWUQ4SStHcnQy?=
 =?utf-8?B?U25DRUw0T3lBemxudnZ0ODEyWkVYVW5RL0V3VGpqT1c0WEJNOGZScVgraU9n?=
 =?utf-8?B?RHRCSVlqb2RQUVBuWXNkcUJxM3YyVlJDdkRDN1FYMHpka3lVVlpUYVVqMGtJ?=
 =?utf-8?B?cXhadkFjNFp3NzlWeDVpdjAxZVVaYU1wYXpIMHU0Ymk4Z3NvK3BjUVZDY1hi?=
 =?utf-8?B?QkhFNkg1SFhUaVRTR0RDWURoUFJhNWprV2tLL0NRWGljKy9LT29KTFZBQVha?=
 =?utf-8?B?bVZNZXlhSG9vT0JkZllHRWp2MzRIUnRuNDQ4WkRzN0FMTkVBUkpoOGk0WjFC?=
 =?utf-8?B?UnRqRE8wYlI3MkhLZkMwYmVRRVltaU9DRXE1MEVNMGlpbkhKbDkvT0s2dnQ4?=
 =?utf-8?B?SWEvVFhvK2NoNjQrUEtJT1BweGovK0RqeTYvQ0JhTlhPWG16N0pWeXAvVnlq?=
 =?utf-8?B?RVRVR29IbjRadEdjNkVEZVV4MzBSNUd1emtGSUd6N0VnbnZBZHE5WmVCdVVv?=
 =?utf-8?B?U3hiNnFxQU85dGV1SWpuVXdmKzlkVWxXVGNuUHFnZEcxMmxkSm5vTWxaaDJn?=
 =?utf-8?B?cXJmTnJNTVFITXpRc1ZuN1dCWlBsQzRhaGhYYk5FNkRreGJPWnIxRkE3Zncy?=
 =?utf-8?B?b1BTYW9vNi9SK2VYSW4vWGg2NTZJRkcrQmx3cHFrNkM5a1ZnZTVEMEg1U1R1?=
 =?utf-8?B?Ti9XaXZBUnI4VlpVTFNwM2hDcHFURkxMYXdkRDlYOFJsQlovUmJjMkI4R0hN?=
 =?utf-8?B?V0FnRzZpV1FpSVVNQVpRQzM3S3duWW9DeW9oeDBGVUI2aFlTaVNaNVBqeTE2?=
 =?utf-8?B?aXpDdkpFNWNqejVUMm1HQ3NrS2RBdnhYc0RBajZXRk5SME5jVVBrSk8xUDM3?=
 =?utf-8?B?dHdPZFREcytFRkJnL1Zub3pmVHMxUDRIMHNuS3lrS01JRGlXZUZrRkdhUmpH?=
 =?utf-8?B?R3ZVdEk4UnJtK3NDbzhTSGI1SVZqZWFjOFNsR0FYbWpveTJONDdxZ1hZKzk1?=
 =?utf-8?B?cGhINktTZmZhcm1kNTl1MDVKbmg3WTliZmE5TWVZVDl6TkFuQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50862960-d0b9-4d7b-e720-08dbe130bc9a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:32:44.3658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJrs/qHbYmaKHxcDPzpN/ycV0v/4AjN7THVPEm1kUqZWzoSBF1IpYsBFxJhwEen1mkcG5DA5HIiID0Y1nTlynDf3trznHNgstT40P2yVa+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_11,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090110
X-Proofpoint-ORIG-GUID: eNObfMcZNFPNiGLWyKUjFp_Yo-Z4BRli
X-Proofpoint-GUID: eNObfMcZNFPNiGLWyKUjFp_Yo-Z4BRli
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 09/11/2023 14:10, Bui Quang Minh wrote:
> On 11/9/23 17:11, Santosh Shukla wrote:
>> On 10/24/2023 8:51 PM, Bui Quang Minh wrote:
>>> Hi everyone,
>>>
>>> This series implements x2APIC mode in userspace local APIC and the
>>> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
>>> and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
>>> series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
>>> using either Intel or AMD iommu.
>>>
>>> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
>>> with enabled x2APIC and can enumerate CPU with APIC ID 257
>>>
>>> Using Intel IOMMU
>>>
>>> qemu/build/qemu-system-x86_64 \
>>>    -smp 2,maxcpus=260 \
>>>    -cpu qemu64,x2apic=on \
>>>    -machine q35 \
>>>    -device intel-iommu,intremap=on,eim=on \
>>>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>>    -m 2G \
>>>    -kernel $KERNEL_DIR \
>>>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial
>>> net.ifnames=0" \
>>>    -drive file=$IMAGE_DIR,format=raw \
>>>    -nographic \
>>>    -s
>>>
>>> Using AMD IOMMU
>>>
>>> qemu/build/qemu-system-x86_64 \
>>>    -smp 2,maxcpus=260 \
>>>    -cpu qemu64,x2apic=on \
>>>    -machine q35 \
>>>    -device amd-iommu,intremap=on,xtsup=on \
>>>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>>    -m 2G \
>>>    -kernel $KERNEL_DIR \
>>>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial
>>> net.ifnames=0" \
>>>    -drive file=$IMAGE_DIR,format=raw \
>>>    -nographic \
>>>    -s
>>>
>>> Testing the emulated userspace APIC with kvm-unit-tests, disable test
>>> device with this patch
>>>
>>> diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
>>> index 1734afb..f56fe1c 100644
>>> --- a/lib/x86/fwcfg.c
>>> +++ b/lib/x86/fwcfg.c
>>> @@ -27,6 +27,7 @@ static void read_cfg_override(void)
>>>
>>>          if ((str = getenv("TEST_DEVICE")))
>>>                  no_test_device = !atol(str);
>>> +       no_test_device = true;
>>>
>>>          if ((str = getenv("MEMLIMIT")))
>>>                  fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;
>>>
>>> ~ env QEMU=/home/minh/Desktop/oss/qemu/build/qemu-system-x86_64 ACCEL=tcg \
>>> ./run_tests.sh -v -g apic
>>>
>>> TESTNAME=apic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/apic.flat -smp 2
>>> -cpu qemu64,+x2apic,+tsc-deadline -machine kernel_irqchip=split FAIL
>>> apic-split (54 tests, 8 unexpected failures, 1 skipped)
>>> TESTNAME=ioapic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/ioapic.flat -smp
>>> 1 -cpu qemu64 -machine kernel_irqchip=split PASS ioapic-split (19 tests)
>>> TESTNAME=x2apic TIMEOUT=30 ACCEL=tcg ./x86/run x86/apic.flat -smp 2 -cpu
>>> qemu64,+x2apic,+tsc-deadline FAIL x2apic (54 tests, 8 unexpected failures,
>>> 1 skipped) TESTNAME=xapic TIMEOUT=60 ACCEL=tcg ./x86/run x86/apic.flat -smp
>>> 2 -cpu qemu64,-x2apic,+tsc-deadline -machine pit=off FAIL xapic (43 tests,
>>> 6 unexpected failures, 2 skipped)
>>>
>>>    FAIL: apic_disable: *0xfee00030: 50014
>>>    FAIL: apic_disable: *0xfee00080: f0
>>>    FAIL: apic_disable: *0xfee00030: 50014
>>>    FAIL: apic_disable: *0xfee00080: f0
>>>    FAIL: apicbase: relocate apic
>>>
>>> These errors are because we don't disable MMIO region when switching to
>>> x2APIC and don't support relocate MMIO region yet. This is a problem
>>> because, MMIO region is the same for all CPUs, in order to support these we
>>> need to figure out how to allocate and manage different MMIO regions for
>>> each CPUs. This can be an improvement in the future.
>>>
>>>    FAIL: nmi-after-sti
>>>    FAIL: multiple nmi
>>>
>>> These errors are in the way we handle CPU_INTERRUPT_NMI in core TCG.
>>>
>>>    FAIL: TMCCT should stay at zero
>>>
>>> This error is related to APIC timer which should be addressed in separate
>>> patch.
>>>
>>> Version 9 changes,
>>
>> Hi Bui,
>>
>> I have tested v9 on EPYC-Genoa system with kvm acceleration mode on, I could
>> see > 255 vCPU for Linux and Windows Guest.
>>
>> Tested-by: Santosh Shukla <Santosh.Shukla@amd.com>
> 
> Hi Santosh,
> 
> With KVM enabled, you may be using the in kernel APIC from KVM not the emulated
> APIC in userspace as in this series.
> 

Your XTSup code isn't necessarily userspace APIC specific. You can have
accel=kvm with split irqchip and things will still work. I suspect that's how
Santosh tested it.

	Joao

