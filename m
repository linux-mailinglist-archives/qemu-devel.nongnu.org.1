Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28E7E6B2B
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:22:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14zB-0005po-DD; Thu, 09 Nov 2023 08:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r14z9-0005oc-Lo
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:22:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1r14z7-0004Hh-Ce
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:22:15 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A91idTY017356; Thu, 9 Nov 2023 13:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b/X3Btr7kwm+be+JeQoFUlGgKfqq7Zj9x227XkwRwcc=;
 b=SmUzj/8TKyFkpwdAnn3BD0y2YCJN/i/ZhOry66stSrzijjbAsJ+gG8aTsfdh7t0X7Ciz
 jiO5h1qgd8R8MOHvCZd5oGCushbkSV9Ev/33KuvpwIUGRNckbC5Bss25VupBapzQLWR4
 iGrNqKOI283ROilgkKAbXJrBkjvyF+IbWXfK4ibNtKFg1E9MSQMyOB0M0zkstlsiqf0B
 9tTTezUOYyZeCtaRsNzwp5LX6zSDUpuFDwnfVRg1QUMRbAh8pah93VkAjeEPsho1fY1i
 hpffbBPrOTk9suEZbUuEDhOhknl1/qdWyn7XSl4u1Vf08fP+lNufPHsydPQQMXcjkklK gQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23kw74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 13:22:09 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A9CpuWx003884; Thu, 9 Nov 2023 13:22:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u7w1ydxrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Nov 2023 13:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMKU8qj58w+wY8NZWzvVbqJTZotzfJOpkNGTMMdePcwXnsbYUhnu7ShQ3YJOpCs0Tnurl8Eju544g9b1+8z1HlxbSEPCKBqPnC59Lgu629ns6nZx9Jame9tjjg67Bda+216OnprcA4qhPqeA8PfUjrZudoK+74opiOwCzFtau/X6BNM30rVLKUkqWQ7aKfzHCFJKCAIrbyFxicZuFzA7SI78+0Kq+n1PUXA+MlknHcBks8QhtNF2qsYl+TNJRWWPZkrVqGT4xrAn3BovaAiIiYEdGKCl8TerlL219SoYWkHiQKtEccemumS5cD2JgY0JRYtTzS8ZKzNrEchLNWufOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/X3Btr7kwm+be+JeQoFUlGgKfqq7Zj9x227XkwRwcc=;
 b=YqJ1WNaafPK3GKWVz6EwJniTB0+mykjJtsQ4wGxI2Erj1WWbWBwt66VQElQg++5ZvRDAnpzeLq7tJbc9lAhbQJjML9byY22wYVJhU7feDW0rix05sSMNKXAi25gaNHmY1d3PXZ6bfBPjTbaYXbFQL+w5SvwvFOCGbJWO2WVzAJ5Li4Wp1yaa/A0vSwg9iilSWRw48pdlYljBtUMeg+wL0Lk6HWbGaUsfGlBAqK45qHQZZyBjaFoKQeL7G8gFCx6AtLeRrQtr1Qp4Nldy1Mhku+kzv94kM1flp+LaudK98rz+USPU8mL1yYWGm5NuUdnMCR9dzl5HPd5CHU6viFbSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/X3Btr7kwm+be+JeQoFUlGgKfqq7Zj9x227XkwRwcc=;
 b=dxSSFxD0iKqU6050y3AyNbeZwgSiH/jMEfHTXoQnkDF5BfCXCULZiCEZqo6SQiRGRzA7PHwo/3nfZs7GdRE6eaE5RSQ3oaxwVOb3P/Zu6WFunk3tB+jJCF2qofoCGzdIEdw1VuwZZU+SUhRkwu4yxZaH9j6P28zUaF1kq7U+pXQ=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SA2PR10MB4649.namprd10.prod.outlook.com (2603:10b6:806:119::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 13:22:06 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 13:22:05 +0000
Message-ID: <c761227b-360e-47d5-868d-2cfb71080a46@oracle.com>
Date: Thu, 9 Nov 2023 13:21:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
 <20231109125700.GZ4488@nvidia.com>
 <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
 <d7475721-2388-4b9c-a47f-1891e82a635e@oracle.com>
 <20231109130921.GC4488@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231109130921.GC4488@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0005.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SA2PR10MB4649:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ee6417-8a32-4987-d4b2-08dbe126de38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTVIklbgIh3qdPS6TvnRVUV0h0y6k483g6gS4clweV+tWDv03a/uSFmBabneoOMMorCOLsT4AGdvjMAmi4VuKj+rYX1aHQwPmhLt0jIUb2OsvIRpAPuGHMr7U4spfLpoRKPR0trlG2zE9KUaY+m+7lzk/pXblCRalzD4UsykDXAXscolGMfSHEl0MxO1283h2ablb424f36W7fmr8pqTPu4CkogZuWIy1SI3UBQa8u59GsjmS8dsGxlxL3ueRBbDcxoWGGCMcyXPXnW3lMhuu30nMwwgsNQg/n8L0YpNX0JmaI+DAsubuk5RJPGEbjzXCuae44gKMoa9bP6b7jkMttXyt5rP7qNij3ijaDdifHKe0BrnLbq8jW3PVRfwXoojDyLs0yTMLkLPYTinWGl11d+UEUeBFZpfXyzF424n62CmcyRGPSgztUo0ojTAmTSXSYVmPiwzRjYKauW3yFsu+bXs4cXWtM9LI7nO8giAkeMf3Tc5YADzF+4ylQqKsNpKD3lhZHaoBrh/bI/xq0WMfepVbyPp9+PayZoEUjD+qpVDGueHjH5wdkoPRJrShrWFtpxFN44Pki8MebdjeF0tVTN6m+CiYKLLYO/2UjUdqEsDq07NvQJOT4CTeowOjdve6+KWw2h0CbxF79EeMXeB5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(36756003)(4326008)(316002)(8676002)(8936002)(6916009)(66556008)(66946007)(54906003)(26005)(5660300002)(2906002)(66476007)(6512007)(478600001)(6486002)(41300700001)(2616005)(6666004)(53546011)(6506007)(7416002)(31686004)(86362001)(31696002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGZTemhxZnpPOU1NTkQ1ZWNFZ3FESW9QL3NUdXVFZ2N5L1dnVDRwL2Noc2ZH?=
 =?utf-8?B?bE9NN2tlL2xWWHFxTWNvZDFrT05wMlIrb0pyaTBUSExuRzdOUGpGcWxQUjht?=
 =?utf-8?B?ZG9reHUwRnN4Z0NYbEVRRE1tWG10bjVxUWI5bWJaVFIvRmZYUU9yaDRUK0g2?=
 =?utf-8?B?TVE1MHk4NGlQT3EwTUc1TklQWHBOQ2ExRHJYSWhUV2UxcStOTG9IUXRoVjVs?=
 =?utf-8?B?UW1hb3FPZVFaQm5ZZDd5aDdJM0RjNy9xTmdteWVxckNtRk9JVWlhYTE5aTl6?=
 =?utf-8?B?TThiUFkxU3RDaVBaZ2wyQ0JiTE10VFpKOXB5ZEV2cTZNM3V6RFd5NnhrbmJU?=
 =?utf-8?B?aXdid2N4ZWhKbmtOZlBnSDMvYW9JdXNnbjZvQUpzMVhZcmJaeWNQMUx4bUd6?=
 =?utf-8?B?eTVGck15TUlxWk9NcDZPME53TWJ1c0N6OUMvbk9MeGFXMkxzWC9EMlVwNXNn?=
 =?utf-8?B?VHVRdkJJbEN0TzQ1UTNsNVB6MEdrUXVSS29vS2U2bVJmaStJWDYzYmtTcTVt?=
 =?utf-8?B?ajVsa2E4cngydCtZRDJPMldGSGxRdzBNWS9ZdGc5RnNNcFFaZFhlUEtUV28r?=
 =?utf-8?B?bmY5R2VyTFB2cVFvREUzaGVQeHNhVE8xRmxTMi84NkNTdWpVNG9MdnMwalVX?=
 =?utf-8?B?U0pmZE1JZlVYSFRaTFcyRE9yWGR4eG1yZVZ3MDBOQ3JBcjR2SHlNNGh2Z05Q?=
 =?utf-8?B?TFoybFhxdW90S3VoM0x4NkVGZWhNZStZRnVPSC9yWWFxeEM4NnpzT3l5QVBw?=
 =?utf-8?B?K1NRWHNlL1F1UllrR2NMTzFXVUc3SE1GUU42bVRoNXR5bmV5ejRoNkluNXhJ?=
 =?utf-8?B?WldSV2h5M3RwOGpMOVJBQlB4djhUQXRuQmN3amwySkJnK0hVV2crRFlSQnRv?=
 =?utf-8?B?U0dJNE85dUZGMmxTY3c4bitYS1N1K1l0bjc5WkdBVnQzR2t5UkZWeG1TVzdB?=
 =?utf-8?B?OVhtMEk4Wm9iaTZLbkRJdTc1QkR1d2VrVWN0aUpxcWhPaDR2L3lVWHF2TnFB?=
 =?utf-8?B?MUZpb2c2azluamhLMFlqY1lKdGd6cXBqTTZPL2twN2c2QXp0SVBEeXZDSHJv?=
 =?utf-8?B?aDBLb3pjblpLdFdEWWU4b0Q4cUxqQ0pna1VYZnNUcklvRVNtdjZoanlzY2VY?=
 =?utf-8?B?bFFhb0g3b2lReHVVNk1scDMyZFlKZDVEQVNWazUwaWg1NTZRMjQ0cUJoWVZ5?=
 =?utf-8?B?cUdSL0RRSXFFcWQzeFc3eFA5Wm9TNWlQTUl3VEFHemUwdkpYZVZSTTBNclgw?=
 =?utf-8?B?M1FSdDZ2T1JybFNtaEZLbmJkekRrY2ZoNjkxUk9HWld3aG1LYVRDTDdab1o1?=
 =?utf-8?B?YmJaU2tPMWQ4NVN1S1lFVjRiZGNKM3Q5Z21DYlExRE5DLy85UlBPUTlXN1Vu?=
 =?utf-8?B?YXFtczBlc0xMQ3hSOWpTanZXUG1IaDUxVWNBUFlJN0xrWEJKcGkxcDNHOHds?=
 =?utf-8?B?aW1QbW9WZ0RxZWtPQjB2aGF3YWZsWHF4VU0wWVhTeW1ickdlcmVLWSsrQWNE?=
 =?utf-8?B?RFkyNEIrbkV3R2ZCWTh2aklNdHpMYnRGYm83bzV5dmNKSHZENHFYOEUvc1FY?=
 =?utf-8?B?WkVGRzltOUIzcTRyOS9mczNsdk9iNHVLMVE5MmU3cHpIM1ZYb2tqRTRSNUFN?=
 =?utf-8?B?aUtDaFBha1dXakFhcTRCaXVZd2paNXh6T09ZYmZEWUk0TjFmYk5qeFBLMU5N?=
 =?utf-8?B?R2NBbW1WYUhsb0JoUkNlcExLZWIzUUd3MGg3MmdpbzVYNXczS3REMGxBLys2?=
 =?utf-8?B?K2R4eFZlNENFWU1tZkNUSGJCM0hhMjRRTm1kUWJ3ekdsbWtkbURicEJSYkdu?=
 =?utf-8?B?SE9BSndwM1VsSWNqekJlOFVvYjFSMVJBL2Z0SGVoNGpySHlUTzROMURMK3Vo?=
 =?utf-8?B?R1VadXRLY1lEd1ROSkdvMmg0NVhxSHc1SHh2S3ZNNzhVcEtXWW5uQWZQdzBL?=
 =?utf-8?B?RU14Zzd5RXY5aE1odVE3cXR6bXJzTThrQzJSSlFtZnB5V1NCUkRjT3Y4V3dr?=
 =?utf-8?B?emxLVk52dUhWbTFYcHRlbjNVVHRBM1hzR1FwRGV6ZmpUSkp2VnpINTRUQzc3?=
 =?utf-8?B?T1hzdzAyMkl5c1lGVHpUbW5oNEo2WjBWbGx3ZU5iY21KRUNOY2ZTSkdHYUUz?=
 =?utf-8?B?VlpsRHBmbXdvRGNqZk5Xam5RZXlOMGxTZGJuZk0vWkpibGQzcnFFSVhoMFl1?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GbS4FIiy84JezBn5Rs38C+ArwBDCeBi9qg8lw/jIHTWk9z4Ikzd19AUvkIlZAJ0mMv+JmG7gY69l5dTc8VJ3BZqqV8YHYGF8HP2A1zxMssnSZZcwA3mv2R10TTvA/QakkL8rHlWR/DESuSMFce+Qok2wNBYS2vJtZx9naMvkn/58Qf3kFxVMvRSPjB90xe/UrFZQQHBY0HtZAKzRGufttEDcGgwqcKZlAxQlVvYr7+BE4Li4yqv7iTVIV9jsaJZdbTjkrvIxDmweuKKELpr7kYurMTkqxvzkmC+eCKCBsa5LYBP7zvEjB59julpXihvo5+NLdszjOYaOOEsV+4vgmkXfvi8ZsG7Xjk0qHch0JltbAfhS/3XYRblbKDqCUSUeRJgW9POnT6FlhzOOSuar/8jWQwo7+owT0FDZ411dFFmT43gHFPtYliKGq4crig7vRLfJGbwkJ8NQH/0qeQSYO29OsiGSFf90qy3YTdpuz6Hf1WILS/+qGZB/LtlnDCsErxnycHKY8NEnLUI8/+dlITHZoFAai1e5M1rdL0TeEaCC8LwXlwOBWSZxXVtv0CW/5oc+uVk0JlA/uvjZw3gIftBJZLfmCcP04ZBxHIRMzWsWTJPejNM0Gv/76KQ67aiEIj2yYPgAunQy/vSSAz8JrwruoWLvtgdxXM5/4yZPENd1/m7xSgv9zAZfAZFXD+T48GArgQwZa123YNZg7gkAP/i8E8Dlzpiddl4hAM/V2xHf8syAPiw0rXbr1pFYGxqwx/NbXQWfrAofz4mvZKoiD18K68+NxZybJRlfs7gvnZY3H1NtRcmDRtVXALSFBx2EB4VGuyBgNI5EHbBCWC6cpJZg+1fcZ1ZoyYJqU4ZySnRneY9YrfBnwlgcXhIAl7fq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ee6417-8a32-4987-d4b2-08dbe126de38
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:22:05.8113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2W4CywuuazwlzjPIZ8FCFetdD+7TFzCGitBpNlwpD7MEqafVe/8fH5w4hI5jr/Hnm5CHyZbB+7h9LrhC4if0Zg5JmwV7DJlVpW3KpFRGBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311090100
X-Proofpoint-GUID: zuiUBbFGm5ySwTuJsQqQN7G4FfHnqJ9S
X-Proofpoint-ORIG-GUID: zuiUBbFGm5ySwTuJsQqQN7G4FfHnqJ9S
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

On 09/11/2023 13:09, Jason Gunthorpe wrote:
> On Thu, Nov 09, 2023 at 01:03:02PM +0000, Joao Martins wrote:
> 
>>> I am not talking about mdevs; but rather the regular (non mdev) case not being
>>> able to use dirty tracking with autodomains hwpt allocation.
>>
>> ... without any vIOMMU.
> 
> Ah, well, that is troublesome isn't it..
> 
> So do we teach autodomains to be more featured in the kernel or do we
> teach the generic qemu code to effectively implement autodomains in
> userspace?

The latter is actually what we have been doing. Well I wouldn't call autodomains
in qemu, but rather just allocate a hwpt, instead of attaching the IOAS
directly. But well mdevs don't have domains and we overlooked that. I would turn
the exception into an exception rather than making the norm, doesn't look to be
much complexity added?

What I last re-collect is that autodomains represents the 'simple users' that
don't care much beyond the basics of IOMMU features (I recall the example was
DPDK apps and the like). You could say that for current needs IOMMU autodomains
suffices for qemu.

For more advanced features we have advocating into our new iommu domain
manipulation i.e the more advanced API or manipulation domain objects. Nesting
is obviously the one that stresses 99% of the hwpt APIs (beyond alloc), and the
other one has been dirty tracking as the domain is where we enforce current
device support and future device attachments.

Connecting autodomains to this enforcing on the hwpt is relatively simple btw,
it just needs to connect the dirty tracking flag with same semantic of
hwpt-alloc equivalent and pass the hwpt flags into the domain allocation.

It's more of what of a question should be the expectations to the user when
using ATTACH_HWPT with an IOAS_ID versus direct manipulation of HWPT. I am
wondering if dirty tracking is alone here or whether there's more features that
start to mud the simplicity of autodomains that would approximate of hwpt-alloc.

	Joao

