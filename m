Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B1C717CBA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 12:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IgL-0004xD-Ey; Wed, 31 May 2023 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q4IgE-0004sT-Oi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:03:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q4IgA-0005zT-Sv
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:03:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34V9qU5n031562; Wed, 31 May 2023 10:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tNZyajRFBenvMOnagzv+KWc5wwq4L97k6ph6vKb2ovA=;
 b=Io7LfNRd0vMbKmgfeTmc1EP5N12hIGtPpRKqb6eNo9R7zvQA+84Bc9EipZrOentBavx0
 rsIVw53ecQi2uHaRhG9u37JaXHyLMIHw/zWabqHAniXs7pXOLYGG0dSPue937Fwkb8Nr
 qxqDQs6WsZXW7IApTo5U+GCMOYvBw8JGWD6u+3GOU2oUyxL7Wzcs9Oo3OWYXwnsy5EC9
 fBSn3/oxW9RlpmBZSF/3FYyQzoFwCY6QXUQX6o8iHZLedjkZOYnziGWYpGnGNnb1xUvB
 NMNAGydLb0E3Utm8qtulowamLQWNsJY3DcTsQOYKjcjlZae7Is/hK2TJHKxgOPQWKqEL iA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjncd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 10:03:35 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34V8FlPn000392; Wed, 31 May 2023 10:03:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8q9t28p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 10:03:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJXCYXFDbLaQNRqM9okK2z4v5GBuFV4r87OZ2JOU2pODOBEOGj+adQQi+bMqsXx0JQvLesHLI226VzVeQPkW22fV7fW4hCR7Vpy8pAqRDXmV+YfwtSfXmdoA/Z1Tawc43oiauRXHjaLOpUeREiLp9AVlGrgLDRqfKTatB2uH56mJtnQ+wmCuMnQuVqdSy/YCZ1lsvcnfoEH3maoZQNJ12L5UJDnTyqqltWJdJ5E33j98pxWfwuyna3yLFhzIUt7koooi6zy/Srf2UL02xTsE5I7aEXw58NkwbkGsxk0zcky8cWeHYEk1Mp6/0lvDq1/G4wMFSPFMKVEGX1rQC8gNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNZyajRFBenvMOnagzv+KWc5wwq4L97k6ph6vKb2ovA=;
 b=azufDPiFAhaOFjUIXZHOZElmEi5Hmmr4ohidoUT8vvGQLuVtJlifmtqZNDFgwUgMf050d5zK956jmo/kgwxYG8by+1g2OxHRMOJQgxk1ikTSkmw7riudtmfDgP0T0+VbuOVOZW2d6ePolUK2hy5HvIMmFopuYf2FPiPOhn2SphiG4zEPJRE2idSiCNMmaIcRD0M7KaJiui8bwH0iKB++jZ/Cws/V9zQ7zUPC917Egsog4i/50G1cyzLrwY4xkM1H2M5T8FTEWeQgNuVahqjqtrbYg2uEta+gSZBN5zT9rvhv8nmeti1IczYS4fpBoxYCuv5wHGduMCEhhlNOaihCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNZyajRFBenvMOnagzv+KWc5wwq4L97k6ph6vKb2ovA=;
 b=MYlmLbNlP5BkI7n0V62aOCjcoT4mbS6up47lU/GKUXfhoVetOF2BcANHTk9KK13OTUhKOniqGJHQNjdQTwwvyIYd8zBHqyBevq7cQjWcmVuaDkLKdC8TOIqyvptICXgfraj6ohk9LcEA6+12N6C323RU/kvfSwkgm9XqrNBkTIs=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 10:03:31 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 10:03:31 +0000
Message-ID: <41a452d7-5b17-d2b8-401e-5b5e7ddb5299@oracle.com>
Date: Wed, 31 May 2023 11:03:23 +0100
Subject: Re: [PATCH v3 01/15] hw/pci: Refactor pci_device_iommu_address_space()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-2-joao.m.martins@oracle.com>
 <ad557a25-0cca-518e-9d0f-f69f8bbd98c6@linaro.org>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ad557a25-0cca-518e-9d0f-f69f8bbd98c6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::16) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BY5PR10MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b7db78-1dbf-462a-1e78-08db61be49db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VVlDWIlUGs9OV4MD52D4lKoY4m5mlpHloYEPaOOZJ+JXiU0OxFvki+TjAnCli6jlWApgQDCVOTipIoV/kOmpRTKUBg6Rc9tHRB1GqiRxGpvKv4FiAYxHI1J0Lj3jQuxjTeNbDyljOPjNEDG/h5UCVu5kZwdM+L7L5lUF15cqTOieUROJsFjO61cNaQn80vZQgMAjtGEwRkbSN8IAwiBKst3SyykXXTxI0jZF18sAYS7J6V/TIuEOYpwOm+HDgPWgr23o51JD4LrPDJvfeaRUaBb26rY8uhMexHtsIzuNspFTPHC+5r7omldUUkp0G9E6H8B85ziGB6WhPA51c+zYSbM7eeH828UKpPg+hX3xDXuu8aolSNKknoTzgyGZ+0JLX9FoCCzdSF6HEJVIJjI205JVHefxYeY/cO/RKsNT9Co3LczTOHCZJVzTVZpcMDa+HSg3ERnVZV9OGupkTTWKbxhf7WQT5eLX4OiQk0UF/jMBoDVPrMkQ1id+wtcQqMYs10yvZpoNlhStpy20hPJCl6brQ+uKRWSQH63Z518/VvlPusX6dmlcbw/5dOfV6/27WBAIMqSuoPP//y4OrPZtuNWoNn96isVTQW8MWn713I7UbE5iXhaDmvkQ2XA+Y12
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(2906002)(54906003)(2616005)(6512007)(186003)(6486002)(6666004)(31696002)(86362001)(36756003)(6506007)(26005)(53546011)(478600001)(83380400001)(7416002)(5660300002)(38100700002)(4326008)(66946007)(41300700001)(66476007)(66556008)(8676002)(8936002)(316002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmt6a3JWVWVqNjA0Y2Q2WmZ0aGxEWWdNSzlxRFdqRWJycksrMGZqcEFkd1JO?=
 =?utf-8?B?TkdnZDJMWFFVMFNoWDVGZVR5ckFxV0dSeVM4UHJNc1BqNXFiS3Blcm9GYzFW?=
 =?utf-8?B?eklRLzRJVndZajRCR0FGbjlkVk4ySW4yaURCQVlxUVJiZHBkejZ2eGtmeFcz?=
 =?utf-8?B?SVpaSjZmZU9tVUJIMmZkbk5acWRSb3k3RDhsVjh3cjhoU1NISU80eTlUbm5z?=
 =?utf-8?B?TjlQWVlHSC9MRGtMa1lmVnZKZ1BOVjdhZjdTMnU4blFJTnZNbGZ3bWJEeHFP?=
 =?utf-8?B?ZExISFc0QXpNRWhBUTNGK3dzQ0pBV1pmTjZHVU9pNWVTNHVHb3ozLyt0L2xm?=
 =?utf-8?B?dEx3NXkwdURNV0VtdTEzQ2hSZS9zRXR4QUhGL1hYOTlDZWFpNGk5UEI1U3hL?=
 =?utf-8?B?c2tlazJOZGpiTUEzRUNTd3JOTHc2SEpZeDlaYkhMMnFPYjZXd3k3OHFVcTBh?=
 =?utf-8?B?ekVLVjkxcE1FbGppazNuZFo4YnN2MVhpSUN3eEhhUzNXWENNS3V4Q0QrYlU4?=
 =?utf-8?B?VG40VkFvV0ZHNmN0QTBzSEoxNzJDL1NuRkFPL1RNbDFyVE40TlBCcmFEZ2dK?=
 =?utf-8?B?QU5xZEZmUkdaUktmQU0xOEsvOFQzR2JMZ2NuaHRxKzd3MWhobEJVMFJTNmc1?=
 =?utf-8?B?Tm9Ib1lyZi9ZMzBYeXpoMDQ4ZUxlaEdhZ01GZjlRaEV5dVVFRzB5eitNVWgr?=
 =?utf-8?B?dlFOaWFhNGF4WXhoVmVOdmRZN3BpNlFtbzNkT2lyS1NTZWg0LytBYlh5SlFr?=
 =?utf-8?B?NWJaTnAxaXlQaStDZkpVYllETFN0V3ZYdFp0ZWsrMTFyVERWMTkrQTd5Skw4?=
 =?utf-8?B?cnkxUXRGMWNlSG96cnpRaVYrMllYN01uaForWVdCaENkNWh6WEt1TnVMaVFV?=
 =?utf-8?B?emZWc1dXRGt5WG9PaEVEbmpYbzFPMXhCZmlid0dkTHJocnd6RTZtSUk5YldF?=
 =?utf-8?B?WXk3azkyNXhmakJEb1JYWlRMVWhpb0hYV2tCUTFJNm1PQi8zSmlhK0tHWmJx?=
 =?utf-8?B?QlZLTGh5K0lmcVVCSEZleTFVR2NZelVuQmlQcjgrcWlNSDhCaWVWMDFka1lx?=
 =?utf-8?B?aFIrcVlYRHZBNTVSM0xHY3d2bXh2OS9RbU1mamYzdGlaTWxTQzB3QmtVblNm?=
 =?utf-8?B?Z0g5eEdCaHI3alFFVWJzdTZNNG5RT0hUZ3Q1V0VFbXZOS2V1UW5CVzIwaENl?=
 =?utf-8?B?ZHlaK20zRDhUWFhUc2l2KzdpbHlqRGROcW9LYWpwQklNRmRvdG9UenBIL3lD?=
 =?utf-8?B?Q3VwWkhMUWZWemM2OUM2MFVmVXVhTEZIemhkeVJ2Z1lDR2p2emNpdkF2Y2Nu?=
 =?utf-8?B?cnlPNHA3amZhd1hweE9tRHpGQnlvZnhMQmVUUGQvam1vL1d0ak8zOExkOXdV?=
 =?utf-8?B?aXZ4a3lzaGpwSHJrNHFnY2ZNVVQ1bzFtMkR1VXBSd2Y3MDd5UndEV1NScEZV?=
 =?utf-8?B?L0sxaHROdWR6ZG91bDNOM2o5bzNtUjR0YnZBU2dBaWNTMFhWYTZCSExlRXJl?=
 =?utf-8?B?ZHFzUU1GTG9NcDc0UnJ4SC80VXRpMHVDaFN0Q2hNd1VreVE0M1h4SWdrcFhY?=
 =?utf-8?B?aGwwcmZTZ00ySjZNNEVtTElNQUsrR3JPTjZreEROc3JtSlgyMndjQXpyc1Q4?=
 =?utf-8?B?YTlXaVNFUnp4bVhSbHU4dnU4c2RIQzllU3JVS25yYUZleHBRT0RDaEV2WlZC?=
 =?utf-8?B?eUNGL0JiQ2JIRU1qMnFxbVhraU9JNWt1KzBVODBkZWZjeE56dFJLcnpNbDZO?=
 =?utf-8?B?eXpwdzBEUnlTT01la1Zjak5WZWNtYnkzeGlzZ2k0YkYyZW94K0VzUVBSV3N4?=
 =?utf-8?B?djBNTnBwRER6dzBoaVdpdDhVT2x1d0NITXhvRnhrRWgzdWVXUDNOZk1PV2g1?=
 =?utf-8?B?RTBFbnJEdVJXZFpZbmw1QStpamZGK3hNOGR3M0F4c3NXOUZxZXNmNllycXBB?=
 =?utf-8?B?dVdzR1gzT3ZLcW5LZTNWdWpZNEYwWWR6M0FpTGcrUmYwQWxkYnJrcVVaOHF2?=
 =?utf-8?B?ZWE4YnlyM1ZmSEgzWks0aDR0djFuOC84TmRYR0c5ZDlSU2U2Z1QvUGNOVlRy?=
 =?utf-8?B?ZzNpYXY4eGd1TGxDL1NRYkhrSmNTekZOZXg2b2Q4dktuOHhnb1M5ckFNRFNh?=
 =?utf-8?B?azZjbm0vSys4QkFNUmh6dnh2U2VMOWdZWUtzU20xNllDdTNqTUlEUnl5RHZj?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g0HM1a9tcVD8c7PFzy6q244h8ABAIUijODenAIQOVx7EDFW2PG3qORcwQ23FOVrXPdmd6vZRP9wsP1oVyj7srXFN79IaJ1cIoSIKjOK2AraKtJVw05TXDEKk8imAAHRNR8Tcxs3Fy5JxTL1glYebteJbinF6hAgYJM/RVNU+LuVmmffAfMyKsbyPQCtTY1ZTzZBZTDSpMnPIwRigys8sMS0CttiLb14JC/ADlNDxAvRQ3FhQ9tK2TrnjE/gaDxnxeX2RKATmS6XJ1VNWKvaypnzxb68cam1qLp1K/AEOAdISkQWs5MpO5X2N8UI1TjD4EZ0gXysy1X8VKk+Qb5aeMqPJcdzUJjTShiGAPXCmKqYtUH9m6I2eU4HCW7phTCbHC10H5ELs7egdF+7Lga2PtigrVjuQWO5PSfhGK4RbPtQLF75sCfdkNv2JT3hTfPOWeCmr62K5M+BXRJmsS27dAqFe9E3EpbX1o3g1yb2xGE/BDl5QrJ9Axs97elnFcMyXieIuj1eNFyU9cwY00uw0QR3OBXKGW+6nv1mG8B5YE6WxChMzg/1fsw92KS4+dqy7RBYwGktbU5C9hWU/nN03MRrPgZjrrYF94Ngopj/0Eo7wI7lzshG8bWQi0L4LbX8oES5Mdf4usLqzFd1tAhZmffUAPEthiQGT0erZL/HnE+PKAnJvyrJ8eig1t+lm/rowoy0wyZqTZBvekEWTApUAiy1dGGT6iHA+3oX1W9EwNYFHpLa1i9IqhBoRikKV6FAhvqGXRM4TzN5V1ZQvHek4fMUGPy+gOrNqvqLALumQdEroBeW99Iy84n93V476rUvhhuyFNNIP22uuM+gbF5UFQUMpGrB47zOyykuQN1UrhWuyjl7YTRoZMj30bAVIs5nkxYRKjUEAXM/zBLYFtbZQqA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b7db78-1dbf-462a-1e78-08db61be49db
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 10:03:31.6154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dGPeIZxOm0mol7CmZrkapcD9PkSx92Y1Rk+XwY/go9J3X7u0hD7Flvd5HLF9v8C/K58YeRjG/UT+Rlmluyzl5iiicTS5xFuhk6pBHBl+nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_06,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310087
X-Proofpoint-ORIG-GUID: HG1wYdWbj7on8P81qWNBQZWr7VNFdthP
X-Proofpoint-GUID: HG1wYdWbj7on8P81qWNBQZWr7VNFdthP
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

On 30/05/2023 23:04, Philippe Mathieu-Daudé wrote:
> Hi Joao,
> 
> On 30/5/23 19:59, Joao Martins wrote:
>> Rename pci_device_iommu_address_space() into pci_device_iommu_info().
>> In the new function return a new type PCIAddressSpace that encapsulates
>> the AddressSpace pointer that originally was returned.
>>
>> The new type is added in preparation to expanding it to include the IOMMU
>> memory region as a new field, such that we are able to fetch attributes of
>> the vIOMMU e.g. at vfio migration setup.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/pci/pci.c         |  9 ++++++---
>>   include/hw/pci/pci.h | 21 ++++++++++++++++++++-
> 
> Please consider using scripts/git.orderfile.
> 
Will do -- wasn't aware of that script.

>>   2 files changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 1cc7c89036b5..ecf8a543aa77 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2633,11 +2633,12 @@ static void pci_device_class_base_init(ObjectClass
>> *klass, void *data)
>>       }
>>   }
>>   -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>> +PCIAddressSpace pci_device_iommu_info(PCIDevice *dev)
>>   {
> 
> This function is PCI specific, ...
> 
>>   }
>>     void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index e6d0574a2999..9ffaf47fe2ab 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -363,9 +363,28 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range);
>>     void pci_device_deassert_intx(PCIDevice *dev);
>>   +typedef struct PCIAddressSpace {
>> +    AddressSpace *as;
> 
> ... but here I fail to understand what is PCI specific in this
> structure. You are just trying to an AS with a IOMMU MR, right?
> 
Right. The patch is trying to better split the changes to use one function to
return everything (via pci_device_iommu_info) with the PCIAddressSpace
intermediate structure as retval, such that patch 3 just adds a
IOMMUMemoryRegion* in the latter for usage with the
pci_device_iommu_memory_region().

I've named the structure with a 'PCI' prefix, because it seemed to me that it is
the only case (AIUI) that cares about whether a PCI has a different address
space that the memory map.

>> +} PCIAddressSpace;
>> +
>>   typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>> +static inline PCIAddressSpace as_to_pci_as(AddressSpace *as)
>> +{
>> +    PCIAddressSpace ret = { .as = as };
>> +
>> +    return ret;
>> +}
>> +static inline AddressSpace *pci_as_to_as(PCIAddressSpace pci_as)
>> +{
>> +    return pci_as.as;
>> +}
>> +
>> +PCIAddressSpace pci_device_iommu_info(PCIDevice *dev);
>> +static inline AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>> +{
>> +    return pci_as_to_as(pci_device_iommu_info(dev));
>> +}
>>   -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>   void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>>     pcibus_t pci_bar_address(PCIDevice *d,
> 

