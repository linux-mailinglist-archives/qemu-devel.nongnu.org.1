Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F07DEF0F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 10:38:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyU8b-0006OA-Po; Thu, 02 Nov 2023 05:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qyU8Y-0006Nx-22
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:37:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qyU8V-0006js-MX
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:37:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A28325a003845; Thu, 2 Nov 2023 09:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6ZjIoskgSrAgcYYhURDI8+Z50wwaXUmnCXSF06/dUu0=;
 b=HhT7N/aV9lX8f+w/Nb3W8EGSgil2wpVQJX4XsLU8pCnQbUdDSqMnISOU3RtryS9itPmW
 dVJBucPWMPT5SVBpCE2muwOCcL3uo/0znDxzG9paRS5z9LqlWVY5rcTe3ZbwgKKPmqW8
 u98Q9m+tuAtdf2Sj1GqDlyqMTkZF41ZjxFqTG5ZHnQu2WRxMJP8+DRR4rrRsk9Nc+LOK
 PJQgpNFDwKjWmE+/x94Lu8YKHkQSlUrfm3VuUSAw1tHtsYaFn6ZL4JZagUEhUdxyqxOF
 J6fzjrpSZUWvtyMZmJKR2/XONz+UxGzgOlo0oMAbRy6zOfnRvO7B/PYLmSJ4nWtQhGDR 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqe1aw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 09:37:04 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A27eW58020354; Thu, 2 Nov 2023 09:37:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rreguk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 09:37:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UufU/CdnNlITFXie9w/MDarVzx+zyVHvt9ebgyVP27UTUc3PrtFp2oqKDDvR2qKcThYNC9f9QO0fQKlgWsedMs2l4HXuEqWb9TFlGwjeDDtrf88vCdXcZZsmt2y2RaWc9D/lSouZUfbtK1jJm9nMcmHlb8nVHh03XU67sKtN60VcwAJdHEsfwTJLdBURKqZa3TtrmWgH03+D3LB53kWDv85q5CevJMSpdx4BrkiisjRNR/V+QlO2W869hcszg7Lh8UpeS72i8oq8CFvLBbqJW5eJtL+vqkYLkgzLBj3Kz7gaWuXjJ8ualcy/PxhIxzUEOHwjT90xNAR9zbAhufgN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZjIoskgSrAgcYYhURDI8+Z50wwaXUmnCXSF06/dUu0=;
 b=Z2Pm3W7WRNei+Z7kROFleZJ9wSAuyyzz61nABZ+DbpxCTCenf1NMiHyoI6/VQOuQgopn/p/p1xMlr6z7l9Dcr66tssxKOqSVKvQmTrTORIYP65ZlHZrBMfMjyvdcfF16Ahzj56TfsQiVPskN6yXFOmh/tdy/AArtvdkWLSz1hTqa5cHPbK3aJEvBTy3bPBF4tvxkcq4qrJOIlWTUQiZEagSNteijtWerqHM+Pbxvp96KeGCT5b7qVrMv2Z31yWNalarGbbzf+p80b+fN/HKJNi7l6WXo/LV+crNViaxHharXL6gGqJ8Jxx3j/vjdjDCGg9IH+V7KFMODInO+keJclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZjIoskgSrAgcYYhURDI8+Z50wwaXUmnCXSF06/dUu0=;
 b=OtNvaw3Z/egR4IVKCngKq9IVe++XdSk10RzeMznfjSswuJSXfeQGpqYxg6kfNuveli40/jtp1R2BM9tytYDsnvz7cWpD/CTBHCQsWE91U3e6kkTMt9jnTgQUJ5Y7fXej3S+JcQGD4U0JDzI/ZwFg6gSdNTSdt4lsfUrlAdCABvA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB4983.namprd10.prod.outlook.com (2603:10b6:408:121::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 09:37:00 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 09:37:00 +0000
Message-ID: <e263633d-7f80-4ed7-87d8-c9e824758e73@oracle.com>
Date: Thu, 2 Nov 2023 02:36:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/18] vdpa: move iova tree to the shared struct
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gautam Dawar <gdawar@xilinx.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <20231019143455.2377694-3-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231019143455.2377694-3-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33)
 To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 2601e20d-7d87-4a10-f8a9-08dbdb87438e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZGXioA5xQW7BzrKnUXtx6j8Pb7/BCs+zeOdPY7lvnJOhvRJtKP160xctjfSj5MnJW5u6HORUEX73+12GPAfbawvUAiSCJV0hDIjBCwQVagExZOxShM75GyRHeJQiLpmCiYcWlhS8rep67tOOJhRJjnVIJdACw/d+KMQ3XfQrSxUURe8LDkE8r+VfM2T7XcnlC3rqOTBjnHbMtMNnCOAwvtkWZkRykzZbFlZqe2CPTvMh8yE/+BgknViQpoRPIrYhCIGdRuM0+Sgr0ptf5lssKM4n9raqKxanMwtrdXYUMOG44R6hXXxJnFLvPZKEqI0xIv6YSqWQ/3knWK5RHQVq6uimc7dlmbjq8hCU55M1HyQvGda4TmCv9xIx0Ad9nWxDnlQIeyzQlquLkgCjkdgGeJoQcf7rVgE+TyiMVC8ES8WHC9aT1TvfX+jhcWteeD717M7u8FAOrh7jCqWMf1vCoR56ha7L7/10SY/R7pFyVp0tJaaewLix53am8VmhLLWPs9zADkn07vmQvX4sY8sJQOV+c38weZablP2sD0xJr8KKtUTaMCJX5GhyukyF0ogSBz3hLKCLUKYFiMGlytd95rBRK1H+lsWl6XPW1AOFfcPIKI+rPxQ+5A1bzJKiydf6fbLkcPCZTSQP0n9vNlnHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(26005)(6512007)(478600001)(6666004)(36916002)(6506007)(53546011)(2906002)(66574015)(83380400001)(7416002)(30864003)(5660300002)(41300700001)(66946007)(66476007)(8936002)(6486002)(66556008)(8676002)(316002)(54906003)(4326008)(38100700002)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZuWUl0SXVJWXh4UlptVWNFZmo0ZnFCZVIvV3Z2Ky9SdmhlOG5uUjFqYm8z?=
 =?utf-8?B?Q2lGVmJkYmxzcWJmcjdpZUlTaUxWWDJMZVZjeVA3SEdnWEhzSklUalhiY0NJ?=
 =?utf-8?B?bWY5SWlYckZ6SGtEM1pPazUxNjN5UmtWQktLUWhNTU1GdThnaGVRRksxZ2pM?=
 =?utf-8?B?SnFjUG51VE8wc3EzOEkwVkRWMnE3dWQrT2ZYSUgwNkJ1Rm1IT3ZvM0tvVkZP?=
 =?utf-8?B?c3J4eGs0c3FzUGRHY1M1RFBDQTRGNC9vak5qM0I1SllZTkNjc25pdkpmTXVX?=
 =?utf-8?B?ZjFBMzNsdTZXaHJqWFBnVUlXOUZBNEhlbEhaTXZET3JyTkovT1krOUxTTE1M?=
 =?utf-8?B?em5SS2o5b2ZEekdaenZiWThudjNnbmYyS1BTamdYaDBOOHgwb0xVREZML1hK?=
 =?utf-8?B?UmtqVmsxd2xiK2ZEV25mdjMvclhxSzhmWHhBbWorK3ZTK1dsVSsrY0lZbmow?=
 =?utf-8?B?ZVhQSnFZdE5WdFRkb2doZ0VYTS94TEp4dHZGYS90dCsvUkpZRnpzemZOUW5M?=
 =?utf-8?B?bTMrV3RnMEdXZEJXWFpnUFFaLzV0RGdJWGQ3T1IyYmVrUW9yZlRqWCtnTmo5?=
 =?utf-8?B?dkF3VXdXRk1INzNKU3BXSURTa29IcWx6d2cvMVRSekdFK3JZZlI5YSt1VnVX?=
 =?utf-8?B?MGYzMmxtbEN6YTBqenI0VFVqY3hnTW9oTDBraysxSXloOFV0ckU1TkU3MGNn?=
 =?utf-8?B?Uk9PZUVEWHJSUmxGbWRjU0JNUVpHdk16dlU0YW1JNURFVFZxSGlReHRqbVNI?=
 =?utf-8?B?REFTVURGUjNEMTY3UTNuVGw0TE5FNXAxOXVvR2xaZU5aQWJyNzhYb09hemF6?=
 =?utf-8?B?bmpENXY3a015eHhpbU5JOFhnajFoN05sZFpqUDIwYkI4KzVVREJieWttYkFU?=
 =?utf-8?B?cDBlcFFxSkVJNEMxZzhlNGl0MjV4KzFycHBkNi9UZk9MSzNjdEZtbGliZ0NI?=
 =?utf-8?B?Sk9TZFlzaXp3dmJxWWRGMHlLK0pZMnl3TTlUTnA1YXJja0Z1bHozVWIrVEt6?=
 =?utf-8?B?RkpLcTY2Q3BpbWlDVC9xOFpyQXkzcFg5TVQvaVVGUFdUQkVDUldNYW9qTnJM?=
 =?utf-8?B?YzhkN3JzQ3J1UGllQXJHZzJ1ZXFnMEhYMTdRUnNzQWVtRFQ2b0RXbU9pVjNY?=
 =?utf-8?B?ZUlaVFF3bWZ4QmpFMWw0aEdCeHdJVXJSVjhOTGJYazhnVGNBcVdLS2tRaWMz?=
 =?utf-8?B?cG9MR2h0SUFMSmJnbTQvZWRXaFZmL1Y4NFFSSFJucEtDTmRLTWZsM1pPQVZ6?=
 =?utf-8?B?dXJJNjR3UVR3QjZ1UjEvQisyUnVWRm9CdkdLUEM2U1VqSGpuSjZMN1BXMEhz?=
 =?utf-8?B?aks3ZVU3TWprbXQ5S3VPblgyL3hIL3RTMXVQaVQxWFJGWER5SUYrVnU4TWgr?=
 =?utf-8?B?UjUxUUVqaThyS3FxeXZGV1M4dlQ0cHhBZHFRR1ZQekxheTEzUTY5ajJPZGYr?=
 =?utf-8?B?TitiZWlQOVcweUEyQTVKL3pCZWhUcmxWdDEyTkVnSTdLRTlCQ29Jd21hSmU4?=
 =?utf-8?B?T25KWEttZlh4azR6eHBYNlRLZi93dUpPQ3VaazdkZmVBckd6c0o1aUhDMy9O?=
 =?utf-8?B?aG1aWXJXd3l4WEtZQVBNYnU4bG5Nck92bGVUYXo3VWpkSnlHeEZXQllkV2tT?=
 =?utf-8?B?bWR0LzZQeDQ3azhtSXZ6SUIrMGRZOG1VUUlWZ0hJSy8wdG1tTFV3S3UwaWVw?=
 =?utf-8?B?Y2VDdC9UaklMZGphTHR4RCt0dVIrMHY5NTN4SGNGU2paUmpKMVR1TERsZXNX?=
 =?utf-8?B?Ky9MT2ZMdnNUOFlUSnpQWDAxK1h0cXRxb3dyRmZoQndsR2Q3elJPU2V4MGFx?=
 =?utf-8?B?M0xRb05GSjZTend5czF0Rm1KalBidjhoTEdWd3lMN202Yko0ekJLczVLYlU4?=
 =?utf-8?B?bnNvalREZDBHY29tN0p1VlRYbmQxZUVOU1NrUGl0Z3ErVmJNNXNxekgyTFFN?=
 =?utf-8?B?eUFYUWEvVlB1SldRYmJjZ1JlRVlFeE1DemV2YVlHWkZDN3RTUWNzdldMU3lu?=
 =?utf-8?B?cGNjU3dzWmtIb1QzMXVBUnpHQm0zMmZoeHZRYjVBVG9OSHd3TW1XcmN2SlZR?=
 =?utf-8?B?NUgzc21qWFdXd1hJUUFRNks3eWhEcVRMTmhMQ2hndzN4SVJaQWFWb3UrWGxG?=
 =?utf-8?Q?TiL3b27gk6EpgbM9PxWVd1ZZu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aGdKbWUwU2g0cEg2bThJdFN4ait5bGZIbU9haWFscjhCNEZISE0vbTY4ak1n?=
 =?utf-8?B?RURkV0Q5aUhMd0kxTWVHV0NFSk44b0tLdEJpbStJRGZNalBZWDkrZUJLRGRZ?=
 =?utf-8?B?SmRxT3NvN0g4ajcxRjZLRnNwcnJwMmtSWkM5ZDVWM3hJT2ZIUTFrK1MwUFFS?=
 =?utf-8?B?MmZRR2twNVkxM20wcm56aVFpTTlPSVZ2dHNObGI2ZGl0enJ3YTY2eHQydzFn?=
 =?utf-8?B?dnVRVTdzUVVFemR5TmQ0ZVQzRkpiMXZIQlBxT3R3cU1SWFVKQ3ZQdGQvMXVL?=
 =?utf-8?B?SFRUbnl0YkZyQlF6Y0RrMmI3MmIvWWF1YitvVmswTDVFcndTdEFzSVhQK0xr?=
 =?utf-8?B?OHRZcW5BK01OOWtxZ2lNNk8zWVFlYTZLVXhTZzNPamFPOVVNdlpZZXpoejEz?=
 =?utf-8?B?dzJ2RzlHMW01VW5jWEdZMjVoTTA4akpKZklyVWFxVHdmUVkwdXBBMXRIODMx?=
 =?utf-8?B?QUNjS205dDNUY0ZVbkNFWE5adWJ4bUpZdUM4K0kraWQ5MUJwM0FHc2RJdTFh?=
 =?utf-8?B?ZzAzT0JobGF6cG5ZY2tVcnQybUpxQTdwTUdjdUhwTjFtM0FWUTFTRThRTlho?=
 =?utf-8?B?aXlSNWo1YmxPSkNTVnFmR3U3RmhlOFRZaEU4NXhNanFBV0hvN2dEeDZqczY0?=
 =?utf-8?B?TmJMT1JJcE9lZU9aWWNGQlRwa0t6cnZ0SUU2ZU5ENFlQODZkSTdJdkxSVzVm?=
 =?utf-8?B?ODY3WXJ4TEVvOWhyNm92aFVWUW5iME1POFdydmVlSEpNcHp5ZWh6Vm1kemFl?=
 =?utf-8?B?YTJTdWVWZjZqNXhxVVhWV281U0ZLazJMUFpUU0Myeko2K2o1ZnJCa0I4Unlu?=
 =?utf-8?B?WGxVWm1IV3cxZHhhalM2bHlVMzB0Uk9ZSTMxS1U2SU1vOGs1UHVxVWQrNER3?=
 =?utf-8?B?Qi93ODUxTlFTeXpiOTBhcUw2czBJWm1tUlNzOW9VMlNjNkw5c01WakZ5ME1J?=
 =?utf-8?B?QnRaOFJWTmMrRnowSlI4eDdIVCtvdzN2dzc3S0pQWmdGZHdrM1I2bzFMLzVa?=
 =?utf-8?B?QldUNVZKYkl3WW5DNFhPTXgwRjI3a3hLTHV0OWhKNUw4alNHZUtiYmo5Rld4?=
 =?utf-8?B?a0hOVGxMOGtLcXdKUGc2TzVFaGF6OFI5QjJURUJ5cm5MdjBVTEcxcmZWb2xt?=
 =?utf-8?B?QXVVdlJzd01maU9QOC9YanRyaWtDMkM2QTMzQVN0bnZ6YmNXbVptWFk5SW9V?=
 =?utf-8?B?Vm5jdDBDVjFQMFVqR2U4cW9ZSTlUNjQvSTNVV2ZSTmtReDZBbU1IU0ZNM2tp?=
 =?utf-8?Q?UYpBMj/C8Zq9AcD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2601e20d-7d87-4a10-f8a9-08dbdb87438e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:37:00.5241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jImmvH+TNG6ubFkK5uif/lyMGpu7WzBNB2W4jNAIRbUA9Lx5rjzMlvmtrGa0j5t6Hs/2wPFZe6lZoorm3eRL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020076
X-Proofpoint-ORIG-GUID: HiGfBhnly_yfwf1sD0lxU3UV8yorDGHY
X-Proofpoint-GUID: HiGfBhnly_yfwf1sD0lxU3UV8yorDGHY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 10/19/2023 7:34 AM, Eugenio Pérez wrote:
> Next patches will register the vhost_vdpa memory listener while the VM
> is migrating at the destination, so we can map the memory to the device
> before stopping the VM at the source.  The main goal is to reduce the
> downtime.
>
> However, the destination QEMU is unaware of which vhost_vdpa device will
> register its memory_listener.  If the source guest has CVQ enabled, it
> will be the CVQ device.  Otherwise, it  will be the first one.
>
> Move the iova tree to VhostVDPAShared so all vhost_vdpa can use it,
> rather than always in the first or last vhost_vdpa.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   include/hw/virtio/vhost-vdpa.h |  4 +--
>   hw/virtio/vhost-vdpa.c         | 19 ++++++------
>   net/vhost-vdpa.c               | 54 +++++++++++++++-------------------
>   3 files changed, 35 insertions(+), 42 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
> index eb1a56d75a..ac036055d3 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -32,6 +32,8 @@ typedef struct VhostVDPAHostNotifier {
>   
>   /* Info shared by all vhost_vdpa device models */
>   typedef struct vhost_vdpa_shared {
> +    /* IOVA mapping used by the Shadow Virtqueue */
> +    VhostIOVATree *iova_tree;
>   } VhostVDPAShared;
>   
>   typedef struct vhost_vdpa {
> @@ -48,8 +50,6 @@ typedef struct vhost_vdpa {
>       bool shadow_data;
>       /* Device suspended successfully */
>       bool suspended;
> -    /* IOVA mapping used by the Shadow Virtqueue */
> -    VhostIOVATree *iova_tree;
>       VhostVDPAShared *shared;
>       GPtrArray *shadow_vqs;
>       const VhostShadowVirtqueueOps *shadow_vq_ops;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 819b2d811a..9cee38cb6d 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -358,7 +358,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>           mem_region.size = int128_get64(llsize) - 1,
>           mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>   
> -        r = vhost_iova_tree_map_alloc(v->iova_tree, &mem_region);
> +        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &mem_region);
>           if (unlikely(r != IOVA_OK)) {
>               error_report("Can't allocate a mapping (%d)", r);
>               goto fail;
> @@ -379,7 +379,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>   
>   fail_map:
>       if (v->shadow_data) {
> -        vhost_iova_tree_remove(v->iova_tree, mem_region);
> +        vhost_iova_tree_remove(v->shared->iova_tree, mem_region);
>       }
>   
>   fail:
> @@ -441,13 +441,13 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>               .size = int128_get64(llsize) - 1,
>           };
>   
> -        result = vhost_iova_tree_find_iova(v->iova_tree, &mem_region);
> +        result = vhost_iova_tree_find_iova(v->shared->iova_tree, &mem_region);
>           if (!result) {
>               /* The memory listener map wasn't mapped */
>               return;
>           }
>           iova = result->iova;
> -        vhost_iova_tree_remove(v->iova_tree, *result);
> +        vhost_iova_tree_remove(v->shared->iova_tree, *result);
>       }
>       vhost_vdpa_iotlb_batch_begin_once(v);
>       /*
> @@ -1059,7 +1059,8 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
>       const DMAMap needle = {
>           .translated_addr = addr,
>       };
> -    const DMAMap *result = vhost_iova_tree_find_iova(v->iova_tree, &needle);
> +    const DMAMap *result = vhost_iova_tree_find_iova(v->shared->iova_tree,
> +                                                     &needle);
>       hwaddr size;
>       int r;
>   
> @@ -1075,7 +1076,7 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
>           return;
>       }
>   
> -    vhost_iova_tree_remove(v->iova_tree, *result);
> +    vhost_iova_tree_remove(v->shared->iova_tree, *result);
>   }
>   
>   static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
> @@ -1103,7 +1104,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>   {
>       int r;
>   
> -    r = vhost_iova_tree_map_alloc(v->iova_tree, needle);
> +    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>       if (unlikely(r != IOVA_OK)) {
>           error_setg(errp, "Cannot allocate iova (%d)", r);
>           return false;
> @@ -1115,7 +1116,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>                              needle->perm == IOMMU_RO);
>       if (unlikely(r != 0)) {
>           error_setg_errno(errp, -r, "Cannot map region to device");
> -        vhost_iova_tree_remove(v->iova_tree, *needle);
> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
>       }
>   
>       return r == 0;
> @@ -1216,7 +1217,7 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
>               goto err;
>           }
>   
> -        vhost_svq_start(svq, dev->vdev, vq, v->iova_tree);
> +        vhost_svq_start(svq, dev->vdev, vq, v->shared->iova_tree);
>           ok = vhost_vdpa_svq_map_rings(dev, svq, &addr, &err);
>           if (unlikely(!ok)) {
>               goto err_map;
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index a2f9855288..15e7579b13 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -345,8 +345,8 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
>   
>       add_migration_state_change_notifier(&s->migration_state);
>       if (v->shadow_vqs_enabled) {
> -        v->iova_tree = vhost_iova_tree_new(v->iova_range.first,
> -                                           v->iova_range.last);
> +        v->shared->iova_tree = vhost_iova_tree_new(v->iova_range.first,
> +                                                   v->iova_range.last);
This code change is okay so far without .load_setup involved, but if 
interacting with .load_setup the iova_tree can be NULL when x-svq=on. 
Below is a stacktrace showing the problem.

#0  0x00005582bf00944c in vhost_iova_tree_map_alloc (tree=0x0, 
map=map@entry=0x7fb16bfffde0) at ../hw/virtio/vhost-iova-tree.c:89
#1  0x00005582bee8cdb3 in vhost_vdpa_listener_region_add 
(listener=0x5582c138ee58, section=0x7fb16bfffe50)
     at ../include/qemu/int128.h:33
#2  0x00005582bf029d4b in memory_listener_register (as=0x5582bfb53d20 
<address_space_memory>, listener=0x5582c138ee58)
     at ../system/memory.c:3026
#3  0x00005582bf029d4b in memory_listener_register 
(listener=0x5582c138ee58, as=0x5582bfb53d20 <address_space_memory>)
     at ../system/memory.c:3096
#4  0x00005582bee8e712 in vhost_vdpa_load_setup (shared=0x5582c138ee50, 
dma_as=0x5582bfb53d20 <address_space_memory>)
     at ../hw/virtio/vhost-vdpa.c:1550
#5  0x00005582bef0b7df in vhost_vdpa_net_load_setup (nc=0x7fb172a27010, 
nic=<optimized out>) at ../net/vhost-vdpa.c:415
#6  0x00005582beeeb4f5 in qemu_loadvm_state (f=0x5582c1c1a800) at 
../migration/savevm.c:2682
#7  0x00005582beeeb4f5 in qemu_loadvm_state (f=0x5582c1c1a800) at 
../migration/savevm.c:2866
#8  0x00005582beed5e17 in process_incoming_migration_co 
(opaque=<optimized out>) at ../migration/migration.c:548
#9  0x00005582bf21b29b in coroutine_trampoline (i0=<optimized out>, 
i1=<optimized out>) at ../util/coroutine-ucontext.c:177
#10 0x00007fb16e448190 in __start_context () at /lib64/libc.so.6

-Siwei
>       }
>   }
>   
> @@ -371,11 +371,6 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
>           return 0;
>       }
>   
> -    if (v->shadow_vqs_enabled) {
> -        VhostVDPAState *s0 = vhost_vdpa_net_first_nc_vdpa(s);
> -        v->iova_tree = s0->vhost_vdpa.iova_tree;
> -    }
> -
>       return 0;
>   }
>   
> @@ -408,9 +403,8 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
>   
>       dev = s->vhost_vdpa.dev;
>       if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
> -        g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_delete);
> -    } else {
> -        s->vhost_vdpa.iova_tree = NULL;
> +        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
> +                        vhost_iova_tree_delete);
>       }
>   }
>   
> @@ -464,7 +458,7 @@ static int vhost_vdpa_set_address_space_id(struct vhost_vdpa *v,
>   
>   static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
>   {
> -    VhostIOVATree *tree = v->iova_tree;
> +    VhostIOVATree *tree = v->shared->iova_tree;
>       DMAMap needle = {
>           /*
>            * No need to specify size or to look for more translations since
> @@ -498,7 +492,7 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>       map.translated_addr = (hwaddr)(uintptr_t)buf;
>       map.size = size - 1;
>       map.perm = write ? IOMMU_RW : IOMMU_RO,
> -    r = vhost_iova_tree_map_alloc(v->iova_tree, &map);
> +    r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>       if (unlikely(r != IOVA_OK)) {
>           error_report("Cannot map injected element");
>           return r;
> @@ -513,7 +507,7 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>       return 0;
>   
>   dma_map_err:
> -    vhost_iova_tree_remove(v->iova_tree, map);
> +    vhost_iova_tree_remove(v->shared->iova_tree, map);
>       return r;
>   }
>   
> @@ -573,24 +567,22 @@ out:
>           return 0;
>       }
>   
> -    if (s0->vhost_vdpa.iova_tree) {
> -        /*
> -         * SVQ is already configured for all virtqueues.  Reuse IOVA tree for
> -         * simplicity, whether CVQ shares ASID with guest or not, because:
> -         * - Memory listener need access to guest's memory addresses allocated
> -         *   in the IOVA tree.
> -         * - There should be plenty of IOVA address space for both ASID not to
> -         *   worry about collisions between them.  Guest's translations are
> -         *   still validated with virtio virtqueue_pop so there is no risk for
> -         *   the guest to access memory that it shouldn't.
> -         *
> -         * To allocate a iova tree per ASID is doable but it complicates the
> -         * code and it is not worth it for the moment.
> -         */
> -        v->iova_tree = s0->vhost_vdpa.iova_tree;
> -    } else {
> -        v->iova_tree = vhost_iova_tree_new(v->iova_range.first,
> -                                           v->iova_range.last);
> +    /*
> +     * If other vhost_vdpa already have an iova_tree, reuse it for simplicity,
> +     * whether CVQ shares ASID with guest or not, because:
> +     * - Memory listener need access to guest's memory addresses allocated in
> +     *   the IOVA tree.
> +     * - There should be plenty of IOVA address space for both ASID not to
> +     *   worry about collisions between them.  Guest's translations are still
> +     *   validated with virtio virtqueue_pop so there is no risk for the guest
> +     *   to access memory that it shouldn't.
> +     *
> +     * To allocate a iova tree per ASID is doable but it complicates the code
> +     * and it is not worth it for the moment.
> +     */
> +    if (!v->shared->iova_tree) {
> +        v->shared->iova_tree = vhost_iova_tree_new(v->iova_range.first,
> +                                                   v->iova_range.last);
>       }
>   
>       r = vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer,


