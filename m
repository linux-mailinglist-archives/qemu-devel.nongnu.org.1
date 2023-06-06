Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC584724A7D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 19:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ajf-00056e-GA; Tue, 06 Jun 2023 13:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q6ajb-00056V-P3
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:44:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q6ajX-0006g6-TI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:44:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 356DENej030345; Tue, 6 Jun 2023 17:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kNMKAdUcqyevQUxNWLv+4YwfY7fyNX8/KSFxdUGhyYA=;
 b=2zdE8DMHdghLAVaJz09sTAPeptsIXHlLgAvVznp/f6vLQp73ueNpmyvXpxQlohFNMmZh
 Z6Dp8e7m9V0oA2+HwwXY4o4wT36vZsBCI9p1XxdsIC58ygvabd3wro5J4PYfKT/vZ5bb
 HwLOQikl0iY6l+SIQHehESEch56dH75hccNk88+A4LewoBGtIJ05A5dEIt1HiaOTE63g
 gei3t9zHSfTQSijxnLuwI0wKWoHGmfkZvGVQDZYZLqj1P39N7nT9zestJH5lmHauu+lI
 eNei6as/KrP29jhIP2EppI1gWRxPna8yaWEO8ctPAPWY4MIwMm180LH5KP75SQJkgLBU CA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx43wvuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 17:44:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 356GiGQl019994; Tue, 6 Jun 2023 17:44:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r0tsy0e7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 17:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQLy3lzkBboVO3GC3sgs7E0Nz76jVOCkZ7HLxJTde6LUmtLyuQdEVQG7mH5xttzKXAXK+YZ8OyaJsz0iK8w9GeFKUkQaQnlgYiHaUUFggJjgRhqkyuh7blU70CaRvD494srHSEp5rdQydEP0uAHFlGyRFD82SEexAdwJ/jv2rLDTI/aZJpIANFWJQncLrTIbsGSOwXlfUrEILk3i2KY3HwR56kHtiyo2PK4uXHdLNtRYcI4uojXyI5N+bXbTRa6DP10LseFPGyl/ucZUgeevVMQeevg0V0jsZGGMxGeiJkbVO5g3QEEwm+9YgIIT+TkHOvbNEg3QKNh8odTczoBU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNMKAdUcqyevQUxNWLv+4YwfY7fyNX8/KSFxdUGhyYA=;
 b=EmzsQ9vA9eiIZKxuAKBiIsTPKShwTtQz7wnfXR64MH5DsAh85ecwmOWP2E2LSr9tOUAz4ssAHPGrZr9Aq0wg8CSMcZd877nS4UMYiL5GmBT9f51RW++CY4em10MohDHJH+jUmIcgS6fV8FGupzEbmk+9dNooDHSjP1KfVu48yzhJe4JulWpBhfTZNOQYTaCZcGOlZYNq/L05tQS/EExi93/j0QSpdr/ZjwShYb2eDt+MxA3UR//G4ipJyIADVvfPU5wM2Wyv8HJfXH7T/EwDs0mYaLg1sjAFMRJpRL0mTk/xSrZA6QDsSUFsGDUjVbyYAk76HhGat2/O/JYX/Kl71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNMKAdUcqyevQUxNWLv+4YwfY7fyNX8/KSFxdUGhyYA=;
 b=ONXoaZXhPd/B1HW+LkwZySgx9C66RzYbsWwirrHv5bkltebwEojOyw6qt0a4gSJuFosVwOhm5UmdLXApkRcPu19qxNDTJidf9qNuJaWzKm0tzFY7peLP4uq5XPRn8bcZjGKzyQfApSCKKM9DcwGZmqXIlchYxZcyjtfKSA+nmj8=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CY5PR10MB5938.namprd10.prod.outlook.com (2603:10b6:930:2d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 17:44:26 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 17:44:26 +0000
Message-ID: <6f8ff730-1793-f31f-fa84-434ffd63d7c3@oracle.com>
Date: Tue, 6 Jun 2023 18:44:15 +0100
Subject: Re: [PATCH v3 03/15] hw/pci: Add a pci_device_iommu_memory_region()
 helper
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-4-joao.m.martins@oracle.com> <ZH4UAtl1v8JDWsl1@x1n>
 <8db546c9-395a-432e-ef07-ed6d6447a097@oracle.com> <ZH9Kr6mrKNqUgcYs@x1n>
 <ZH9LIqTK2KBafcXO@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZH9LIqTK2KBafcXO@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::19) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CY5PR10MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: c29c63f7-244d-4b7e-18e8-08db66b5ab9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyCOrVRDhl/7niBwfaoNtxmQmC2IJEObyJPxMB6cHLhy9yfdlDgTAdl3WH6kbrnw6vP3EOMJdegg6bCEXnAI7K51rxApNdiPPunbGR1fvzHRl86frcnKW1jKHa7dEjRuW1mYvLLC/5QNPU2flXjwQbslmcgTIj8PLpX9bxwUUOjBfOcqhkyUcUOMEeDz4D2R+B0yj+Yrx162WIDc+p95J+w+Yp/szH/wzuGqNBuszDM+NI3w6q5zMa3W2GX6qRIaL8v/5FZ8bGnGtFeuUuNUm+7vVw2xQmEz0vDGKdQhBBwocjn8S1OLtfEgAGVO6ukIFUv1Z0llc73zpIk2U4ast8e88iendF278HJVgAUv3fPH2YG6nzFUIUGL+eE1Ly/D9neVFCrkH09Iygq6/nR7bUcMAXSxwLKJRiwX809HNR49Sy/ea+aa2xiLrbmof3s/Xi32CeAS7cJUHb5ZkHscgU3Vn/zGCw5OkGMBPVzU7lbYlX3HeiJK5atfcQ/rxv4JYWjNQcGzMEKYOKv8Jr8ho9IZPj0aJzEG0bhWHPtsc4S2AEgOtf43En8WRHMXzigk+zcXaH/kL6tV26aAgFjeBJjBgae4OJlUTSwYDHxQx/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(36756003)(2906002)(31696002)(86362001)(5660300002)(7416002)(31686004)(6666004)(966005)(6486002)(83380400001)(53546011)(26005)(6506007)(6512007)(478600001)(186003)(54906003)(316002)(38100700002)(41300700001)(66946007)(4326008)(2616005)(66476007)(66556008)(6916009)(8676002)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW9aUU11NElvazJ2UzhhYVNQUGpWSW1wRUx6L2FzVVJ4NXgzOWNGRGNZWUMv?=
 =?utf-8?B?ekFhMGVrallwZ1FXVnYwTUFDVXlvUnZvMnk5SXVXakpSTXE3S1FBWnA5a29U?=
 =?utf-8?B?VENyTk0wUVJ5SXhQelU5MGdwU2lCOUFRUXpjcHREZzN2dk5EcWdGS0Jua0tR?=
 =?utf-8?B?UEpjV0JMVWhtdktuK0hmSENLTzllTVZMYzlJUnJMdm9hZHllNXhMSFdyRkh4?=
 =?utf-8?B?bkw0NG1hcitJNjFqbXpFS3BEdUlrRk9rQkswSWVackVrOENtcFRqZTJVNk4z?=
 =?utf-8?B?R0lTb0xJWnNJQ3hTLzMyMzliRCtjU2paVlFNVm1EclNmU1Frb1NoSkNnY3Bp?=
 =?utf-8?B?YmtLSWNldlRJOVlhT3JsUk5nVVUwbFN4RGQ0ZFRHWlFMUDNyY2ZSMW91aENV?=
 =?utf-8?B?R1hXOEVXYzQ1T1E5UGxGbkl6THYwMHVvMHo4UkZZbE1kbklGdjQ4dngwNjNK?=
 =?utf-8?B?dVFPRUpZdEk3Nk80RzBXQ0N5NTNuZHNKV0d0bDZPbWNySEI1bVlsZFEzUnlX?=
 =?utf-8?B?cFhxT21CUGxkbjVsZ05nd1kwc2tDM014b1JiSHNYcXdSQVJKREw4bWxQS1g1?=
 =?utf-8?B?Y2Nwa3BTSDJDTi9xM0dCQ1hQbVprUlVYaE41VTk3NEgyUXlPaE9yYlhGMk5p?=
 =?utf-8?B?K3NNMXErZEd1TGdZaFRHYjBaRFhjQVA5UWNwVzVNVjNyVUJ1YmdlL1pmak82?=
 =?utf-8?B?c0k1OTI5SmpDeVArZmVWTzVqWTQyMnRkMDFVVTZnY2Rjcmo4YkppK0RYSENN?=
 =?utf-8?B?TXhWVzkrdGtaREx2dEdNY2ROM243ajVhRGtIa3QxRlBpdWpLOFlsSVREa2JC?=
 =?utf-8?B?QkYzSEx3QnJ6M3JLVW93M1VEQStFY0w2YWJ2VGZ5WUQ1czR6SnNQSG4vZ3gz?=
 =?utf-8?B?Y2pNaXZWbTBjSXB4eENBcnN5VFlBOFhLd2FJWVF0NFJ4RnZ1c0FEOER4ODlk?=
 =?utf-8?B?NkE5UTcwVWZveTBUb3hKaVkzNTFtMXpiVHNuMEYzN2xEV29EOUxLQ21XMnUw?=
 =?utf-8?B?TEgyMldpR1VkbVRNMW9Qa0lzNUtub0VGRG5sZ0ZpTFZIVXVFemF5TG1ZdXZs?=
 =?utf-8?B?YlJydGp5ck1BVm1MRmlpWkYvZUQ3eTRvc0ZWejVpVzhhb0hIL3pZem93QVY1?=
 =?utf-8?B?TCtSNHQzc3lNS3FwcEFNem9GSld2NzA4aFd1SGZ6MFk1Zll2WE5TclhkQWVS?=
 =?utf-8?B?cmlUYzdlVnJiUUFocWFUaFhCRFRxazdzbVROWHZZdkhVdndvUkJCSTJLVXRJ?=
 =?utf-8?B?dFpGUGRvcFJpTG51aVVpUTkrWEdIemlkWUM0eDFjSExhMTV3VXJ0ZEpzWHVy?=
 =?utf-8?B?WGM2S3RVclg1TU54T1NmWkVUSkZUMVp1WXJocjF2RkY0V1pWM202NWZ6UkRn?=
 =?utf-8?B?K0l2NEJQbWVZc0FjN3p0RkpjV1VNYmJQbVBmVnRrd2krTTVDaEJDcjh2L21t?=
 =?utf-8?B?YlRPUEt2V1FsOWFhdmhEeXJHbjdlZ3ZHUWxxZE5PTXM4UG5sNDJKZU0rb1JB?=
 =?utf-8?B?NTNmaUZlOGJyS2F3NUJZZGd4Q3I4MFgrOXFtMm1EbmEwM0pjUmljdmpEY3ha?=
 =?utf-8?B?UUdnUi9pUzBaRVViSzE2M2c5QUV3aGxNZ2ZaNDgvK0ZFemJqVzFaRHR1TXRS?=
 =?utf-8?B?a0ZROWZadytIQllqRlJEUHJma3IvcWxid050TjZlaVhZdzJtYVFCaTB4b1Zw?=
 =?utf-8?B?UGxhd0ZxbTFUeFROcHVMOVRPM1ZiVzgrVFlOV016S0djcFpNTnFFRjRUTldl?=
 =?utf-8?B?MkxEWjR1S3IyeWhGTnlkTk53Ymp4NzRoaC94ejFPckgvcnZGTFVLeFk3OE9p?=
 =?utf-8?B?dEJpTWdsZEpIUEtuY2hlVVFuR0ZXK3RUNEdVTjM4Sm0vd2NLSlg5ZEY3YTl5?=
 =?utf-8?B?NVMxZnVHUUF2MDN2aHlxWFdTL29Xc0FDa0gvTy9uaVhVQzhSMDVnaExmc0lv?=
 =?utf-8?B?anBaanF6OE1jekhTNDVvT3hldHBGcHRET3ArNEd6VTI4cDhManFlSHJTRE5v?=
 =?utf-8?B?cUVIUUhsWVVUWnZCcmJOeVRMSTZDbzVtV1cwc2FwQXh2TjUwbnlYSUEzcWRw?=
 =?utf-8?B?dDFKc0wvWGFVMytxdzczTUh1L3ZFQ0d6SGZHenNwSGZSeU5MNE1MOURiMVFQ?=
 =?utf-8?B?RXdnVTIyMWhLVVhzckNFelZXaEc0QmxWY0RSRW5yakpVWDg2Sld0MjdQcFFy?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NUpjbk1wWHhQdWNwMVVpUUdyNS9zQ0lXenp6QVYyc0Y2aHdsRXRQTlJaK1N4?=
 =?utf-8?B?c2xoRGo5bWg0UTlqc2daRjlnTE1GVVFpK1B3bG5XcFVIUFdjK0gyZm9uMkVp?=
 =?utf-8?B?ZUtIOE5QeHpLREdiRjF1UVd6S0lYNlZmMjBHVE1ORTdXSTkwL3V3VVlEajdY?=
 =?utf-8?B?Qi9zRHAyL25aNEVKZ25MYUN4MUNHc3FzVk1aQjBSRUlwMGh1Tlg0dzlLa01U?=
 =?utf-8?B?NWZaeVFRT083OW1WalhrNUFvOGk1ZXFSSG1oU21acThMaFN4NzZLYVpHU0gy?=
 =?utf-8?B?ekNXamFwdnhqd3o5bWx6aGtDdFg2cXAvS05NaHNzVE9kN29UNDU0eGo4cWpF?=
 =?utf-8?B?R3hVY00rNEVtQms1WkdWOVZoRjdoTTB4eU45N0JDQmh4ZUtSaVllUnVlS0NR?=
 =?utf-8?B?WUFoNTE0d2JnUlNDUHVpK0dpYTdBaTIzYU1sMHl3UlBJS2Q0emJ4amhQM1g1?=
 =?utf-8?B?dmVlMURCWmlpUDJrV3VKV3A0cG9Kd2NRbVVmZFlrZEo4cDJMOXhOUU9KYkNW?=
 =?utf-8?B?N1o1YzJ6Qk9LMks2eEg1ZS9IWEhmMU5BUFBtdW4yWjFHTTZrbVVPT0pTODdH?=
 =?utf-8?B?ZWE2MEd6WEwvbGdjRUtlK3hxT25oSUo5azlkbndVQ1FsVjBSWEtrMUhTRjg1?=
 =?utf-8?B?UTNFVTZTK2NBWjlFTmxJZzV6NzFsRUtBVE02eDNRL0U1VU9IcGxSTXpLVTFy?=
 =?utf-8?B?YmhqbnNFZ0JXR2hpaDFwYjh5dVVOZzF0cUN5SllkanU5T2hOZldaUDhEK0Nw?=
 =?utf-8?B?cnFoQzhjOS8wdTR1cVdQQll2dzRnQWc5Q0tYaDFVZlRaY1JpV2FJY1FlcW56?=
 =?utf-8?B?QjRpWk9DVi9PZ1pxVjFjVkMrSEFpMysxR01kTVoxTU9YMGVoTk5WcXNicXpn?=
 =?utf-8?B?dFRub2VmaVhzRkowa0tWRmxjNTRXek9pRDQybmNDZWgwSWwzS0xiZFc5em5m?=
 =?utf-8?B?MkVnRDRiUzcxZHZzVC9rYS94RXpPRzB2U0Y1SHVjMWE0WkpvdzVCTktxYWFV?=
 =?utf-8?B?M2N1YUswc2JLQzJmT20yZGJ6NDF0VFdkcUFxa0RzeDNFR2xKejB4WjRjNkhO?=
 =?utf-8?B?VkZQd1hBQzJhNGFEVGtlYlFsdnBXbjJjZXpDNlZKOTd5ZnJKWDBiVWNZbTB3?=
 =?utf-8?B?UUhjWThhQ2hrVi9IZ0lNcDJYVHZIeFAvT2YzV3MrUU5DUDFhM3RmMW9yT3lt?=
 =?utf-8?B?Q2YyOE82SkFLUHNKTDNIeVBtUzl3Y2IzSE1JV1YxMGVPVi9VM1pRM0ZuWGtE?=
 =?utf-8?B?aVRCeWhxcUpFRUhtaUczcit2ZnkvQjNsK2U3dXE2Vi9NbHhUdWxDRmcwaFBE?=
 =?utf-8?Q?ixuPUKxi1gesg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29c63f7-244d-4b7e-18e8-08db66b5ab9f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 17:44:25.9880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Rw3LoFFKL1t+dSVHMAec+2XRzWF/fZFAT+bosWHqlniyL8GJz1pYOVy0xZlHdC7TH+4WkVgiKiQld8Da+W0AFywpApidTGKCSQPfMWW/K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060153
X-Proofpoint-ORIG-GUID: 0SUYvOHwFVNJhdUZB0D1yvDpAU2-Nn7k
X-Proofpoint-GUID: 0SUYvOHwFVNJhdUZB0D1yvDpAU2-Nn7k
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

On 06/06/2023 16:05, Peter Xu wrote:
> On Tue, Jun 06, 2023 at 11:03:11AM -0400, Peter Xu wrote:
>> On Tue, Jun 06, 2023 at 12:22:16PM +0100, Joao Martins wrote:
>>> On 05/06/2023 17:57, Peter Xu wrote:
>>>> On Tue, May 30, 2023 at 06:59:25PM +0100, Joao Martins wrote:
>>>>> Much like pci_device_iommu_address_space() fetches the IOMMU AS, add a
>>>>> pci_device_iommu_memory_region() which lets it return an the IOMMU MR
>>>>> associated with it. The IOMMU MR is returned correctly for vIOMMUs using
>>>>> pci_setup_iommu_info(). Note that today most vIOMMUs create the address
>>>>> space and IOMMU MR at the same time, it's just mainly that there's API
>>>>> to make the latter available.
>>>>
>>>> Have you looked into other archs outside x86?  IIRC on some other arch one
>>>> address space can have >1 IOMMU memory regions.. at least with such AS and
>>>> MR layering it seems always possible?  Thanks,
>>>>
>>>
>>> I looked at all callers of pci_setup_iommu() restricting to those that actually
>>> track an IOMMUMemoryRegion when they create a address space... as this is where
>>> pci_device_iommu_memory_region() is applicable. From looking at those[*], I see
>>> always a 1:1 association between the AS and the IOMMU-MR in their initialization
>>> when iommu_fn is called. Unless I missed something... Is there an arch you were
>>> thinking specifically?
>>
>> If only observing the ones that "track an IOMMUMemoryRegion when they
>> create a address space", probably we're fine.  I was thinking ppc but I
>> don't really know the details, and I assume that's not in the scope.
>> Copying David Gibson just in case he got some comments here.
>>/me nods

>>>
>>> [I am not sure we can track today an 1:N AS->IOMMU association today in Qemu]
>>
>> IIUC we can?  The address space only have a root MR, and with that after
>> translate() upon the root mr (per address_space_translate_iommu(), it can
>> even be a few rounds of nested translations) it can go into whatever MR
>> under it IIUC.  Different ranges can map to a different IOMMU MR logically.
>>

I'll look some more into address_space_translate_iommu(). From a data structure
PoV wasn't obvious how two different AS can be routed via two different IOMMU
MRs from different AS (or vice versa). Thanks for clarifying;

>>>
>>> [*] alpha, arm smmu, ppc, s390, virtio, and some pci bridges (pnv_phb3 and pnv_phb4)
>>
>> I just worried what we need here is not a MR object but a higher level
>> object like the vIOMMU object.  We used to have a requirement with Scalable
>> IOV (SVA) on Intel.  I tried to dig a bit in my inbox, not sure whether
>> it's the latest status, just to show what I meant:
>>
>> https://lore.kernel.org/r/20210302203827.437645-6-yi.l.liu@intel.com
>>
Oh nice; I wasn't aware of this series.

>> Copy Yi too for that too.  From that aspect it makes more sense to me to
>> fetching things from either an IOMMUops or "an iommu object", rather than
>> relying on a specific MR (it'll also make it even harder when we can have
>> 1 vIOMMUs so different MR can point to different IOMMUs in the future).
>>
>> I assume the two goals have similar requirement, iiuc.  If that's the case,
>> we'd better make sure we'll have one way to work for both.

Yeap, makes sense, definitely more future-proof. We essentially were trying to
do the exact same thing in the PCI layer just different purposes. All I meant in
this series is a way to fetch some vIOMMU attribute that tell me if DMA
translation is enabled or not and max IOVA for the IOMMU under a particular PCI
device.

Perhaps I would instead do a bit like this series and have a
pci_setup_iommu_ops() and convert existing users to it as a separate step or
series, to avoid regressing those who don't care.

I am happy to pick those up if Yi's is OK with it -- should help for the nesting
work down the road too.

	Joao

