Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD707DEE52
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 09:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyTMy-0005Mc-81; Thu, 02 Nov 2023 04:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qyTMv-0005MJ-Rx
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:48:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qyTMs-00020C-5L
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:48:01 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A282g7g020920; Thu, 2 Nov 2023 08:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UY+TiwFqHqoMS3DyXUZRmpgerD6vt4TPUy/LNYlNgKo=;
 b=ah2+4pxoymQ4p0DU/R5RNyPCDeGq7OF2qL754le0f/jVIGxeh83H6BA9qOGMbQYa1/CI
 5lz0eOg3eTwJgRYmrIgxXngRdvgAGEv8YLCRFxTABs+I1S5e84FnpMjB6NI915k4tU6I
 Txz+1k6tHcDrsflu52/hHRlG/kDRrIr9ytaLqxUmg4OTZjp3ltJAmyGCfHvvT6Kfj5fs
 L5Pc+l7ANIGJiecZRsVh4ji0QwPkgqNv4HT5W1HeaErhcwZMqOR9CwMMNL8FVbGxfyyX
 xZwpFyMVqbIH5QCMzESoyWhEVk289C+mve+9nZsYfsYBLduF6c47Xy106eaKSCnmS7QA 4A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdsan9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 08:47:50 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A27okiE022572; Thu, 2 Nov 2023 08:47:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rr88d2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Nov 2023 08:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZwMjv6Y7m9MgINkB5PE+pKDBEluZuRiGoEt90VJv4nO4Nmp9D7Cb97NxxeqNTjEZ1XW9O72+eAMv0c5dE8Ly2uvLdmeT0MabbwDMFufexCESxocoxGZsRu1m46rDFEHByvnHinXTon76FyzLkjYuIQ1Sl/zwAQa+S2fBO4JuUVu8/877eInDALrkL9HHylTK/QCMyMJuzH6sgpwNoDGk2Ic0rrZikX5HcPg2Ht6vgUtbiHpHb5v/AH16mn6sE9EEULAFhjPInZV9243OndnK8unXd0lNa01tCv3vUmzgyNZb3vhiGtDQW2xdeyenvp2qfcTNbRC69AWwVM/TMpyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY+TiwFqHqoMS3DyXUZRmpgerD6vt4TPUy/LNYlNgKo=;
 b=MPYY4FUi+nTuL/zMqi2tjEUzTa36Jjh0YHdXCvQYMxpVDCpXsRT9MFRStQelNj8ahetz3MDtp7qJXEWX1KnzqeSxxK9DmA77UyB6fS9Iu7jKbTkD/Lut3/EOw8Pvs5Z2cv161HQmKC+E/OqlHwWX0cBgwttDcxQ8o83u8Ky6nhfQg1CN8/7ul7lciSh6k4NnqVL6eG7Dk12kZdVgXxDVLwIBb4rlhDC/IXqq776dw6yTgeRRapbVufevqFSMxJ4D2vtgGwXEjLEWelsDdJaZcEmLPKGUGycPEhERFIPFHSrKwPJ+fTYoY95uMc4DE29j4cUAC2jBvExIrSwyMCfDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY+TiwFqHqoMS3DyXUZRmpgerD6vt4TPUy/LNYlNgKo=;
 b=BtbS70d0boIFQxQBwZ9oLMdGnnmC+83ruG74pY1zHZLFC3TZBjX57dK6eICvdbUyVkYZO2UFwZH9WzSQ8+z2QpcFefqfH8Q0ZQMRMoYyvc1iTeL1usM0GZCTsxnd2sw8Swot7NeSa/qG9G6WtwC5zMruul+XCm0v3znvaU3QmMY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY5PR10MB6190.namprd10.prod.outlook.com (2603:10b6:930:32::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Thu, 2 Nov
 2023 08:47:47 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 08:47:47 +0000
Message-ID: <b031ffc0-76e7-4e17-b755-60923731314f@oracle.com>
Date: Thu, 2 Nov 2023 01:47:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/18] vdpa: move shadow_data to vhost_vdpa_shared
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
 <20231019143455.2377694-5-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231019143455.2377694-5-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY5PR10MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 7418cc40-2e3d-4ee4-6ba0-08dbdb806325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUZ7b1+AYXxZyDsczHRG0W5h0rc9z1sKA3uJR0EqfYJ/2tF16353s1QlCLM4my0gUEeEWkbJH3m6C2lRmDAWWFIACRerCgpZf7QvuWGb7JaWNVNUFIeT1sQ4HVF25Q97uelstsREt2pI9pITaXbVjAYzGEVBTMk7f3AFycIiXt0w/Ait7hzVUxE37/QwPQygVNb157N5i2wMKkpm98wI89jsTkCz4MOcLKRoUZ1k86brHZwbJEFtN/mR2CTV3uscV8F6+z5r7TK0Hgg83iVhcgneK+hDPtbVNg8mzawmY9l5whi6kOdsPXn3Ft2S/uhU5c+uG/cwOckiHw4pEcKyPTcZgX6TYyFPa+ttLr3cI7/c8GdjnYMaWTTS6Y/lLlD15eE8W0gw8LmBM/zP7LYNlBduuMEuuot20iT2TJs09PRWKoAToLeF5yroHRuk5vwqvDIDEeinvdy+6z7QsuhXhTmWJ4ou3Rn3kfJxDlq0PmFnZ73hwSYV+Ez4FLz/grBCu5HAGlEMct+yqC5tM74q/M0Dh2VwY19Cq3QLmeEfjJcfzqebeh7VKxEZI/WsRPef7j+wRG1ft6MF9+EF/U5/4K3bHKzJi9v8YIC+4hSlwPIuhqZgQ/96dsKVsPIzhUMJJ5cMUFsfiQU6YzhwsgrMqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66574015)(4326008)(7416002)(31686004)(6486002)(53546011)(6666004)(66476007)(6506007)(36916002)(6512007)(38100700002)(478600001)(86362001)(36756003)(31696002)(54906003)(2616005)(83380400001)(41300700001)(2906002)(5660300002)(26005)(66556008)(316002)(8936002)(66946007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNQQkpPS1d3YUJtUk9yc0QrLzJ0ZmVtY3BKVWJqcWl5Y20vcUh5NTR4eC9W?=
 =?utf-8?B?dmZmNHZuSWtUQWFLeGRGaVUyRWNqQVpJQU9XcjlDSVd6ZEZvMEI3K2VhVW5s?=
 =?utf-8?B?UnhIbWE2VmtHY2JxdUF0QU80bXlIejd5R2NoRFVtS0RVRGN6RjQyeEF6N00r?=
 =?utf-8?B?dEJYK1RXOTVhWG5UdXpVOXVhMWIwOVFoekFmSDMzbXdaR0QwRzh1M1ZXSUFT?=
 =?utf-8?B?c1RFL1o0ZGdldUxLcE9SZk9Mc3BBS2syQi9qT2lNRFRlZ09Ta3J0dHdIYnl0?=
 =?utf-8?B?dEw0QjQ4M3pydUlCY2x6WFlOb0NKdlgvanN3dDVmS1R1WFRWbU54d3QrOThJ?=
 =?utf-8?B?eHZMRy9VMXg2S2dzMzFrRFBlZ2F0alBBOGdUQnZIK2VrSEVqYW9oRDdSdEg4?=
 =?utf-8?B?YmdzUGJWRkU4b0Z3d2tsU2tidTB3eVY1d3VjWHlNcEk0YUNFbE1MclFaVnpH?=
 =?utf-8?B?dUFkVHFKVWRCdlAxS3VIMEk0Q0E4ZkFadzNrRld2RHh5Yk56U1Fna3Z2RG5T?=
 =?utf-8?B?clZybU93Qjgyc1k4MldZRUxjV00wQXhld2ZaM0VEZjZCcExtNHZGY3Vhazls?=
 =?utf-8?B?TExBdXBReEZTVWFYd2x5SmY4eHFqUUdxa3Q1Nk1ObzIyZEVXMktBNEY3NmU3?=
 =?utf-8?B?TnVzWC9EZksvQVYrZkE4T01jT013czlhWWp3T1V0ZG9rVndpMEdOeGZDYktC?=
 =?utf-8?B?dFRmank2bzNYeTVBRkJ1Sk56a2VlZkdHUVVTUEtCTjdOU1NGU2Z5SGQ0Tmh2?=
 =?utf-8?B?aUJ5Vm5qODlFUFFEdWN0Tm9vdHp0bWZKRllzWDJLL2o4OEJpK0hkQW9rU1V2?=
 =?utf-8?B?WFBYeDJpTHhVV2hwaEpmK2V4YWcxWXJ3Z3ZOVVdTcFZCUVZKdG1kbFJyZ3dx?=
 =?utf-8?B?U0NLMlpoMFNGVm5hMzQzR0RYSFR2ajIyUitkRWdJcFliUVIwS0xUN3FLbURF?=
 =?utf-8?B?aVFyK1B3V1A2Zm9WemdaV3I2bno2bFRFYnFvWHRoaVk2V09hK3g2TENob2JE?=
 =?utf-8?B?dXR5ZXZYbFA0OEl4aEhVeU9YTzQrR0pmc1pEeHp2UTJZWkh0RWg0QWlvTUtJ?=
 =?utf-8?B?MkNpSnBWUDZsdlFXQWpjK1dLeWMydmp5a2s4aGdOWU9qczJjS1RDTUF6K0Q5?=
 =?utf-8?B?bFIwcFUrSFc3a3JqcVozOC82dVF2Y0djSzM0cDlDY1ZVekFRZEFwblZDTXNN?=
 =?utf-8?B?ck5nVEdJUTJ2dVRDdWtCc3U3aWhneStUS2hRWENyMlI5UGoydjcvU3Q3c3Nu?=
 =?utf-8?B?MHd4NUpZcXlLZXZiMDRxRkJjSTdvbUxQVDVjdW1RQjREQklkbE9YbHc1dVpC?=
 =?utf-8?B?eEJZQVpLVGRVSGRPMFI5eTFxNkh0emd0ZzdVME1rbDdhZUJETmlpNy90Unh2?=
 =?utf-8?B?QVRlekxWNE9DSUdmUWN6bTR6bm9jTHAwbG5TRzVsRTU5NU1LWjkzKzJGYnJs?=
 =?utf-8?B?cjQ5M21HSm8xZVBtanU0WStqT2MzSk5KZkk1eW44QXliVHVSVFN0K2ZlRzNi?=
 =?utf-8?B?YlFzV2tuVzkvSXA2S0tNSDM2STdCeHZuUkhpUXNNMTZXdkp4aUNERnYwVXRW?=
 =?utf-8?B?NlJDSWprTDNSSmtGSURiSE0reTZkQlVOUS9wMHlPM2RwNWQvTmFiNTEvdmRH?=
 =?utf-8?B?M3d0UnBmTHJWWCtYUDR3bGV4UVd0UnNadmtTeVExT3ZlQWhKSjR4dzB3eTg1?=
 =?utf-8?B?WkhrSitnVVByZi9kTG9WTWFGMG1Ka1dWai91RzFMRzFoYU1mUlh6VlBGQmRC?=
 =?utf-8?B?YW1WTDVrRXdpTkpBS2NxVzU0N0ZMcjRnQ01ueG9LRnlhRjF4dHc0VHdsaVRq?=
 =?utf-8?B?aTlCNkFwWFhOQmU0U0RNQXBOcU03YUgzRGc5cWNBTWcvWXhBWXFzSlBOeFlx?=
 =?utf-8?B?Sk56dkRCY01IV3daTGtUdWJsdndlT1FtRnJUNkhnM3VNVmFUNndkQ1pQY0NV?=
 =?utf-8?B?ZjFtcUJ4VGRPbG85ZENCa2t6bDRiY05JQVdFZUpmNHhCWFFkVHRaeUpWOVNN?=
 =?utf-8?B?MEFZUDBCTFFNZ2d2SHM4M2ZDVUFSLy9QK2F1dlJ2bFVCbEFpTElZUTdRSUdE?=
 =?utf-8?B?MXJiVTdMZ25LdURYWVkrM29OMXZQWU1GVXVGUEovTVM3NmU4eGhDNzdJWTZl?=
 =?utf-8?Q?CrcdBpfydo6nMHtz0f1mSpiG7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q2V1aUNsSXpSUjMvUWhPMURoNStYWUdpTEduYWluQndDQ2x6Z3dPZ3VyUWJp?=
 =?utf-8?B?T0RLVGdFa0krdjA5OVMxVDVoOEdKYk51ZEVPdjVyc1ZOY2JCeisxeXAxNGVU?=
 =?utf-8?B?ZGsreXB1elR3ejNCNWFjcTluK0JsaTV3SW54MDNzQ0ZnR21XRjg4MFAwVEQw?=
 =?utf-8?B?VnZVeXNSelhNNUZoZFVMSHlLZW9ucCtDM2g2RytXOTk3elE1dmVmbDN4Mzlk?=
 =?utf-8?B?S1gxSmRUb1ZuaGI2aUIxbXg3Zmlnazd2SE5wbUdjanFHVkV0dVdJUGZoTkox?=
 =?utf-8?B?YXIyYWdZV2YvczM1K3BZSStsdHBoMHRINHZ0K2dCbU5UZmpyNklUQ3dNUE44?=
 =?utf-8?B?SXRWd2doakxmazExSzBYWXFwSGJkL2lPOXQxOTVHbWZIT0M2SW54ZXB3UEJi?=
 =?utf-8?B?VW1LOFhmVUlmbWZQZFRQTGxCbnNSL3dTNk5rSFB1TTBUUHV6dU1vaVpSR0FV?=
 =?utf-8?B?Z3VoSTl4emFQdDRScTZ0VzlGc09Cc0k4YTBpYmphS0V1eE5RUlFLa2JRUUNQ?=
 =?utf-8?B?ZEV1Wm9FOTR6cGdzcTd5NytzV1l2MlA3Sm5XcXgxT3JqLzN4YjlHN2loQmV2?=
 =?utf-8?B?RTl4TjNBd25IcnVnZzlkdXpoRUQ1MXphYi8zSWZQN2VucVNjZTVHSW1zSmti?=
 =?utf-8?B?TW9IU3g3SC9jR1FrU0p0WHdwc1lMWmN3NDdaN2gxQ3RqNmg0dXB0RXg1REVH?=
 =?utf-8?B?TVE4MTB1b21QYW96aE9jTGo4MVNpOFVSTU5TSnFOUTB6NFA2YVBmeHhQUE5q?=
 =?utf-8?B?ZUxJSmRjdW5acHpTWit1dUVCMTg2NmZlbVEzUnFld2dkR2cwWWJPV29zQXZq?=
 =?utf-8?B?MWhOVzhPV1NERENZRDFXcCs4SGQ5dkY0cmdGZnhsVysxUXBadlUwQU54bUdJ?=
 =?utf-8?B?TkNKU01MQXQyS0d2eDZtbEpCNlV2NTVobFQ4eElNdUFQSXFteHl0RUprczNE?=
 =?utf-8?B?QkZwTjZIYTJ2cFlvNUZoVUFhbjVXbXNpcVUyYnlja2dpKzl2MnpqZFBiNmNp?=
 =?utf-8?B?QlFDTXVQaU5HZ1UyY2FmOGZaeXU2MG1SdlMyRUxQMjlvYXZob3pGMHZUQlo0?=
 =?utf-8?B?dXJVYlhzK1RMeVNRK0Y1MG1VMDg4UnZQbndwbmZwdmZMdzA3bitRSlpDOEZu?=
 =?utf-8?B?UWVxc1BqeEZTVHYzZ3RjM3p2Z0M1QjJ6Q2tzNjh0ZTZrMVJmMTNzd3hGcnhK?=
 =?utf-8?B?aUdqYWlOUEM0czNRVkpvSnlCN09SRkdIUHRZZnFpNGJRR2tnbW1SS0UwenRR?=
 =?utf-8?Q?BciO+TlNNMYFBxx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7418cc40-2e3d-4ee4-6ba0-08dbdb806325
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 08:47:47.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRY6CjFIJIKrvdcY9hv4EPI+zXGj6fPVMY6UqW5tGcAY1B45Wa73IhVJtltuck9LFS2ooL/ndQ6Qw5siTniiMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020068
X-Proofpoint-GUID: CmLX7YCshXSb6qxsI016hw7nLntoLv7J
X-Proofpoint-ORIG-GUID: CmLX7YCshXSb6qxsI016hw7nLntoLv7J
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
> Move the shadow_data member to VhostVDPAShared so all vhost_vdpa can use
> it, rather than always in the first or last vhost_vdpa.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   include/hw/virtio/vhost-vdpa.h |  5 +++--
>   hw/virtio/vhost-vdpa.c         |  6 +++---
>   net/vhost-vdpa.c               | 23 ++++++-----------------
>   3 files changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
> index 8d52a7e498..01e0f25e27 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -36,6 +36,9 @@ typedef struct vhost_vdpa_shared {
>   
>       /* IOVA mapping used by the Shadow Virtqueue */
>       VhostIOVATree *iova_tree;
> +
> +    /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
> +    bool shadow_data;
>   } VhostVDPAShared;
>   
>   typedef struct vhost_vdpa {
> @@ -47,8 +50,6 @@ typedef struct vhost_vdpa {
>       MemoryListener listener;
>       uint64_t acked_features;
>       bool shadow_vqs_enabled;
> -    /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
> -    bool shadow_data;
>       /* Device suspended successfully */
>       bool suspended;
>       VhostVDPAShared *shared;
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 2bceadd118..ec028e4c56 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -353,7 +353,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>                                            vaddr, section->readonly);
>   
>       llsize = int128_sub(llend, int128_make64(iova));
> -    if (v->shadow_data) {
> +    if (v->shared->shadow_data) {
>           int r;
>   
>           mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
> @@ -380,7 +380,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>       return;
>   
>   fail_map:
> -    if (v->shadow_data) {
> +    if (v->shared->shadow_data) {
>           vhost_iova_tree_remove(v->shared->iova_tree, mem_region);
>       }
>   
> @@ -435,7 +435,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>   
>       llsize = int128_sub(llend, int128_make64(iova));
>   
> -    if (v->shadow_data) {
> +    if (v->shared->shadow_data) {
>           const DMAMap *result;
>           const void *vaddr = memory_region_get_ram_ptr(section->mr) +
>               section->offset_within_region +
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9648b0ef7e..01202350ea 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -282,15 +282,6 @@ static ssize_t vhost_vdpa_receive(NetClientState *nc, const uint8_t *buf,
>       return size;
>   }
>   
> -/** From any vdpa net client, get the netclient of the first queue pair */
> -static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
> -{
> -    NICState *nic = qemu_get_nic(s->nc.peer);
> -    NetClientState *nc0 = qemu_get_peer(nic->ncs, 0);
> -
> -    return DO_UPCAST(VhostVDPAState, nc, nc0);
> -}
> -
>   static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
>   {
>       struct vhost_vdpa *v = &s->vhost_vdpa;
> @@ -360,10 +351,10 @@ static int vhost_vdpa_net_data_start(NetClientState *nc)
>       if (s->always_svq ||
>           migration_is_setup_or_active(migrate_get_current()->state)) {
>           v->shadow_vqs_enabled = true;
> -        v->shadow_data = true;
> +        v->shared->shadow_data = true;
>       } else {
>           v->shadow_vqs_enabled = false;
> -        v->shadow_data = false;
> +        v->shared->shadow_data = false;
>       }
>   
>       if (v->index == 0) {
> @@ -513,7 +504,7 @@ dma_map_err:
>   
>   static int vhost_vdpa_net_cvq_start(NetClientState *nc)
>   {
> -    VhostVDPAState *s, *s0;
> +    VhostVDPAState *s;
>       struct vhost_vdpa *v;
>       int64_t cvq_group;
>       int r;
> @@ -524,12 +515,10 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
>       s = DO_UPCAST(VhostVDPAState, nc, nc);
>       v = &s->vhost_vdpa;
>   
> -    s0 = vhost_vdpa_net_first_nc_vdpa(s);
> -    v->shadow_data = s0->vhost_vdpa.shadow_vqs_enabled;
> -    v->shadow_vqs_enabled = s0->vhost_vdpa.shadow_vqs_enabled;
> +    v->shadow_vqs_enabled = s->always_svq;
This doesn't seem equivalent to the previous code. If always_svq is not 
set and migration is active, will it cause CVQ not shadowed at all? The 
"goto out;" line below would effectively return from this function, 
resulting in cvq's shadow_vqs_enabled left behind as false.


>       s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
>   
> -    if (s->vhost_vdpa.shadow_data) {
> +    if (v->shared->shadow_data) {
>           /* SVQ is already configured for all virtqueues */
>           goto out;
>       }
> @@ -1455,12 +1444,12 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>       s->always_svq = svq;
>       s->migration_state.notify = vdpa_net_migration_state_notifier;
>       s->vhost_vdpa.shadow_vqs_enabled = svq;
> -    s->vhost_vdpa.shadow_data = svq;
>       if (queue_pair_index == 0) {
>           vhost_vdpa_net_valid_svq_features(features,
>                                             &s->vhost_vdpa.migration_blocker);
>           s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
>           s->vhost_vdpa.shared->iova_range = iova_range;
> +        s->vhost_vdpa.shared->shadow_data = svq;
>       } else if (!is_datapath) {
>           s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
>                                        PROT_READ | PROT_WRITE,


