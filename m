Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C3FA2964C
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Feb 2025 17:29:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfiFa-0000Sm-Ca; Wed, 05 Feb 2025 11:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tfiFX-0000Sa-AN; Wed, 05 Feb 2025 11:27:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1tfiFT-0006hD-MB; Wed, 05 Feb 2025 11:27:39 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GMsOB028796;
 Wed, 5 Feb 2025 16:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=N1HelwHsiaf4UZwztMp4aZg0+/XF8a7NpwAerNidJ+4=; b=
 dnBQMLNcoLquCb/5hVXJUdNNPuXf2DL8Ts6xxErx0uQ6C5OusEfr6RVWRKDUIEW1
 jiiinYjCYjQXslbx3qmNZD027qZwry0RexOAbBetV2SIGbptCMyzCNa9ZaiZkQaI
 KVWwG9ME2XJklXCZ9RgeowMNHBiiDlaApoIAaWWXj2LOhlbCtdgJPoh9dyapjmDb
 3Eg5nNfQi3PZN1CTNdoLcnE9vDO7EIsYN6UjovT8DX4+bk5DHEN9AgceQMZQ/cJi
 vpyyx4Lb/TmYUKnNhoSNpuIB7r9+WptphPAOERYNUfI4/wkx6xXcEoIq3RCibcTV
 Sti4LwEVu91GXp27dH/IeQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtfkfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 16:27:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515GNtUq027798; Wed, 5 Feb 2025 16:27:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8p4m15f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 16:27:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC02x8TdQEtooX89KBUlk4esihXtjJFl7x4DfuXRyMZtxaCJN3yoaYDc8CwphmwDmDj9dLwtrfidqaghaIrSjkJHtduQ/RvfX29Y3C5oQQUmxJ8PNeo0HBOnQpQyrDTekqUJ91GXH4gLOsc7WXySefcpGHRFkIN9m66jCGtoNAVD1zAI1/IyzzRO2ijWILIRXnpUIcdwzCySb2CSJLu9L70/hVywCz82kv+gKPMLUy5ng09G76eD/Cqtv0c94koZysrFbi/YqBUXyha6xvQezhwbg1GwJIYEYt/2/lWUkilG52zjaGqgEPxpwLRiNBRqasWc9h/s0GWciVD28y0yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1HelwHsiaf4UZwztMp4aZg0+/XF8a7NpwAerNidJ+4=;
 b=jB+pOmHUAuc+BaYdtNkyTOyhyQYpKTNnjozEqExOVSwDPDbbOaAnbIjbbIObxVewLzAWNyCWqVx1YpiQtoidhPrEB+2ctipyu4SJ8Kj45fbqQOcI9o/mmFg1ShzGWCqjQRKKM8YQeFa7LF5+8NsmB7INFSnrUJisjvMNGeOvZiUBi5VzHlFQoz4RujPY3YhFT+f9K1QCqvyIZORH1YnIcx7dWVr6t3cDu1b9vaJIvmSn3Dlg7ujqWYpgAumdxcrGgAWjQ/ARWq9ikTTX5vkzNChSfIpE/4MFZzey5Am5uKkUfA4oodi9+z3nEOqqyJx14U4RlnevI8DT/6rHj65LtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1HelwHsiaf4UZwztMp4aZg0+/XF8a7NpwAerNidJ+4=;
 b=xJfl7T2RE9Ghs116uZ25KTm6Kr3Mndzs1dMX3yG+apnXr7jSSHTTTR6OFBwVc1eZhFywyVm+VAxOe6CThZ/6oXTZn4B3cXKTl+l7itMFIOSJjLl8g6CY5tUWkCrlpRauGCC6K1NPuMWhfvapCFF97z0QbNXnke5LKv0imwTpZiM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 16:27:17 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 16:27:17 +0000
Message-ID: <3f3ebbe8-be97-4827-a8c5-6777dea08707@oracle.com>
Date: Wed, 5 Feb 2025 17:27:13 +0100
User-Agent: Mozilla Thunderbird
From: William Roche <william.roche@oracle.com>
Subject: Re: [PATCH v7 3/6] accel/kvm: Report the loss of a large memory page
To: Peter Xu <peterx@redhat.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-4-william.roche@oracle.com>
 <Z6JH_OyppIA7WFjk@x1.local>
Content-Language: en-US, fr
In-Reply-To: <Z6JH_OyppIA7WFjk@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ1PR10MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: e32f25db-0772-4554-5794-08dd4601f4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0dtamo1Yko0eTNRYTdieGc2Nko5R0l0dDNDSWlQRS8wRnQ2TE1NdEhVYlJC?=
 =?utf-8?B?M0JWOVkzbWVuZHFsMmRCYlFBbWF4SGNwMEVzb3NzK01vcld3S2hTUGQrclIy?=
 =?utf-8?B?UzAxL2JteTdvTmwwWkYzdzFUWHBXY29qR0w4cUl5U3FlQ04xZFlGRmRWV3R2?=
 =?utf-8?B?MVdTRk5IaUtDTkY1ek9UL04vUk13Mm5henNPN1lyeG1vOTlVbDF5cnE4bGZm?=
 =?utf-8?B?cHM0Wlh3R3ZhYUx3b3R4YlJLN2RpMVdUTHBuZ1p4anA2S0JaaktIUzlGR1ZX?=
 =?utf-8?B?UEl4NmtGV3QwRHBpTlNYd2JrMWZKNkNCeTBCb3lwQkx2aE1ZbFphaHZnQ3ds?=
 =?utf-8?B?Ui9yMVFhdHpqQnFHOUtVcEhlMUtQckYyVldRZE5qTDdxUlpWSERneHhwK3Ux?=
 =?utf-8?B?VXJINWJGUTl1NmZOb3VZdFgvMUEyK0hzZGJITnNtY005YXFEZ0p4OEtZY0NN?=
 =?utf-8?B?SXRKNTI5WWZsYjhIV3NOaUprU29qWnF6ell4blNJY2pVOU5pamsraW1EK0R4?=
 =?utf-8?B?bjgxaFFNcmNXRmVNUEl6QllwRExyUCtuNEZORW1UanlYcnMyZlduenB1dU5v?=
 =?utf-8?B?dW15eXkvQmwyR1dvcVI4QW5nRk9uUVFtai9pSHFNa1IwUTdiTVFDSkt0aWJk?=
 =?utf-8?B?a1VtZTgyVFF0YnlFR055ODVlMXQzeW5zQnY5R3ltemlqQnJ6dDFmOXBOZ2xQ?=
 =?utf-8?B?cGVPeHhFU3kzYiswT0JrWlhYbjQ0cmlWUitMOHpsNG9wTnp6MklocGgrbzBh?=
 =?utf-8?B?cjVxb0h0Y2kxb0VRWC9vVHkydm5GaFJla2JUTHdNTEpWVEZEV1FBUmc4bUdn?=
 =?utf-8?B?MEVHanE0ejZWZlJFajNtcmhXbklrck9uY0c4YzRweEFCd1haUmxBd2ZldzBB?=
 =?utf-8?B?WmZFNDVnWTQ4dEFXSlltT3dBdW9CTlA0YlF0Rkc5aDFWc09xRmtFVkcxdXl6?=
 =?utf-8?B?SUc0dGdKSkwrTThyWjZTK2NoWVE3MWM3aWNzR1NzeHpaeGhuZ3JqWlNMUDUx?=
 =?utf-8?B?TlY5ZVJyS0g3MDBEZ1dJUElzUitFeERPREQ4VlAxV045ZmgrVnI3b2hUcnVV?=
 =?utf-8?B?QnJUWmRIV0duWDg1QzNCMTlESVFJSFdJY2VUbkgzZDROSklxMDJsd0xkRk5n?=
 =?utf-8?B?R2FndnIzUklWdkxDT1VCZlZkL0g0WTcwY0RPbStoVHpTbVFHeUJlOVlxK1gv?=
 =?utf-8?B?Y2F2VFVLWmxDRVFrT3pxSmlLNVdFR2NQUzI2MW1nSmNqSk11aEY0SHNwMWhi?=
 =?utf-8?B?RE85UE1BNUpHMlo4S1ZyTGtrVEpJZy9yQVdZYmNQMkVvQWhlOVV5TWZNK3Rz?=
 =?utf-8?B?Qk5MZ29ZTHVxYXdRUkIvcXgzeUlSaVpucHlkV3BtWlc4cFIwaXBtQUtTYjIr?=
 =?utf-8?B?NExmeDJhWmUrQ2luMFRiSHRSdHVEWGNvcnF5UHFRWHhwT3hObXpjTWZmb1Fz?=
 =?utf-8?B?K0YybmU3VnBuVU9oK1N6WGJ0N01qd1c2WlVKYlpJaEE2VG9vL0w4d253cklt?=
 =?utf-8?B?OEVyWDVWU3lzdE9yZ1p2M3RYeDhNdlAxWWxzM2ZOU3NoM21XelNFbzNIUjBN?=
 =?utf-8?B?ZUhQV3lSbk1YR1JIRUtIcTg5eWNCckRlejRKQUZVVlFLV2kyV2wzRjJWVis0?=
 =?utf-8?B?SjRmNXlNMEk1aXVBVXVJbFNkMmo4WU9UQWxUUlRZR1E4M2Rsc0NTdW1MaGFt?=
 =?utf-8?B?cTlpSGlXZUNDVWRiNm1DZER6b0tjczZYelFFeXZxc2x4QUZMdjVqbXN5cHlk?=
 =?utf-8?B?eTFCbVhQbmxkanRlN3pDcjBXYVpVRWg5VElXbnozeWQvcUVDM2xocGpDM1NQ?=
 =?utf-8?B?MXcvU2grRXQvRWtWV0VCT0wyRXBpWFMwUUZxS3ZVRUR2eXZOTVVXZkdqa3FN?=
 =?utf-8?Q?6B2tKtlr9treq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWYyMW1KaGZ2b2pNUXFkT3owc203UmxVU0JHbExQb09NaVBibGJQbEF1d0tG?=
 =?utf-8?B?Njhud2NhUDFFRTMxNmM2ekE4dDcxeUM2OHM3ZUc2RHRZZDRCVWVRUzg5Qjcy?=
 =?utf-8?B?TGpFVW44QUw5Umk0NmljeDA0SFQ1Y3dYMWdHR0N6NWZsSzJXQzlQaWNHWGdm?=
 =?utf-8?B?ZkNTUGVrMTlSczB0dXk3aFhnVDM4WG5aRkV1LzdNZTNTKzFzalZGUHVJTm5p?=
 =?utf-8?B?RXZyZC9ubERVcEpackh3dEFwYmVkbHh0eXp1cVBVMXk5d0V1c0Eyc2U3enhS?=
 =?utf-8?B?R08zZU1NNDBiWWtjcFh6QkxOQ1I1elhwdUVpc2p6YUpMZS9MSG1jRlpGYjEr?=
 =?utf-8?B?T2duTVdDUkU4WnZRZGtGaFJxL1FYWjBUQlArZm5CSXdENUlZTldub2lscWJO?=
 =?utf-8?B?Rk4rZm5sSWMvU0x2UnYzR0wrKzlKd25MZzNvYjZyb0NpMW83dXVOaWxTN0ZN?=
 =?utf-8?B?VTl1MUt2blkxWmlvTDFnS0JmTmpLZ0syMlFaekxmZVVEV2R3Q0VvNzVQQzBq?=
 =?utf-8?B?ZXlqYjN3NTQ0YjhWeDVYeXNlRVlPNUVNbUNMTXlBMWR4d0U4djFCT0R6Q0dU?=
 =?utf-8?B?SzhrblBrTVhHL0ZUSHpSSGhTVnZrTitZc0lmSTFjMWplbDA5Y0pGdVFiWXc5?=
 =?utf-8?B?QkNCL3YwNEtDNHhkMm1Ba1hJdTRzeVRieitXZHBtNWxsejFkazZGMGhiZERm?=
 =?utf-8?B?amwxVmRPLzZPSGxFY21LdkxMRzRSZVZZRVlDNXBwWnRJenRvamt0dmtBbHVy?=
 =?utf-8?B?TW1nZ3o2UlRuYnl2b0MxUEdkKzNNMmt1dnd2dlRrcUxGbG1iRjlNbkkzNWMx?=
 =?utf-8?B?U2NRWmZIMnc0dm1SWFZlRlpaT1FTYmJYMEo1RWVHUldXMWgzVTRRRXJDU1ZY?=
 =?utf-8?B?cmVGZThkNEJZWnpMQ1h0Ym8yYVhsODBxUVR2Q2srYVRkbEJqWjV4VGJyRXlM?=
 =?utf-8?B?Q1JsRzJXNEVtaGdXQ0plY3ltVzdIQW5YVHBUYzdCU2lFVmZtSXVkdzZOeG44?=
 =?utf-8?B?UkVYSXlGWk1YdVBMSXFGaU5GNXo5WUQwL1BLcEoyWmg5NEJqc05NNlcwaUtp?=
 =?utf-8?B?UTZaWEIzbzZXY0wwMGEwUDlZcVJRTG01Qk91enJsSFR4cWRkRkpxQWwzVXo3?=
 =?utf-8?B?ZlU0emVObE5oN1JjUlZFVXJBS1BRUnBDRDQ3ajM1T3VJYkkvdEF5TVYyNm5o?=
 =?utf-8?B?dnk3N3RQWEdXU3RMaVBoM0YvZzZLOVc3ckdwTFlzYWQ3cG9oc1F3WDYwOWhm?=
 =?utf-8?B?Ym9vZDl5eW1Pc1J6alhvVDJoR1JiQlk5LzdFRlBKSlNaNHIzZHFBbVZLU0NR?=
 =?utf-8?B?cGZnajdxMDhTQWRXcmhjTFJXSUJSTUNVZGNQSHlCSkZmYTFHZ3ZHdGJjcm55?=
 =?utf-8?B?QTA1Z1ovRXVFMTQwc2g4S3U3aTE4dU1yVWVVdlM3Y3R5SXBlMTBHVFZEL0ps?=
 =?utf-8?B?QlI1cThXZmZkUFRiWllSUm1PUHJMS0t1QVFoTzFtYUsrRU9GTG1ZdmQ2N2lD?=
 =?utf-8?B?dS9pTzgrUTczcXU5SXJhWUdvSG9BMFNGaUtrMmdXdHQxY2k1THJpYnRaRkJy?=
 =?utf-8?B?aGJUSDFjTFhJZFlTUVhDSHFjTm5Kd1NyclBYcU4zL2NtbCtSUlNnTFhIY1Vh?=
 =?utf-8?B?ViswcWtjajJrQ3VvZGVJbFJkb0Rza3FiaUs5RzNaSVpzTFNYMmxYd2pmYW5n?=
 =?utf-8?B?SnBaaGkyNDhEUnN6dXVQbGwrNjRuVVpiZmVEbnRPTUlRT2k0RURVSUk5TzR4?=
 =?utf-8?B?b0FJT05yQ2QyTFFkM2VZWmp2bjNyNmNSeW5DY1FlejFFNGUyaTJzM0FQOXYy?=
 =?utf-8?B?eGtIUzFIYTZZQ05LV2N2aEJIUVYwb2o3bHk1SEF6bGtuRXBhalpmUXdERnJD?=
 =?utf-8?B?YU50cGNrSUV6ZFAvOVdOWFJrQVJXZDRiY09IbCs5bUdoeCt6Yy9MKzZ5QVNu?=
 =?utf-8?B?dk8reU5DazhYelQwdzRpalZlckFlQTZWZUN0Vnp2ODN4THhRWTVia0RoaFMy?=
 =?utf-8?B?RlZPZHZIR0EzaGhiRXB0d3N2WXB1OFVoUlFPVzJKRDM5RFNITGYvTG9ZaFpQ?=
 =?utf-8?B?dmVDNU9CK1NLTFJaU20rU0V5SnRud0JjaDV4VldYNmtWcG8rcjRtbWV2Nnd5?=
 =?utf-8?B?NDI4dlNhYkQyTlJZMkdBZW05cHJuUXcxckkvRUdqcVo5TjBBeDFlM0dhNWU1?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ved1UscWttN0J3hLurzNLKdl8mF6FTFOVjsYvEQldc9ACWoDEVdjq2xgQOUrffJpSVW92pnn875dsD69vTLip/2o64E7ixRrZWPphcCkmFBOhPl8nda/PSP3Bmm6kk81Gt0RzsRSl7udKni4kr/emIYxivYwDYlkNTdzC5cUGp1UY5WUrTT8I8hIdf8BCcrLXo+GSYXCLUhks5BXF0wD8usYFFr7aH7myiHVVhOam+fKBoajEJpxhwtwtUJVQ/SdellUJF0ndBD0BftkpmwXCuY8OOTAi8gL48PcmON0nCcbzaJFNL98H6UKSRToDZLep94s3n0Ji1NR/nDP+DsvXoYZ6YTtVGdI8clCmv2shT1N/6AKUMWNm7dBwxxPAiD9GG+Fu5oy8AD3+lvFvwVje//IETqg+gU8OvYv/kNc0iE6pGcOMmPtrs8BIPKV6vU28tR+3PG8L+A1UmQW6R4CQIUBdQkpSmO9ZOtQaywz6GrjZg7jQ0uuX+kOBoQ1ywmCL+0SGA5WbcoKR6zR5ak0idnqfYFsPVTpzuXH1vhN8qEDz7znpdVetO/Kk4YPlat8zBnOn1BILt44iRQIbFHdIoR1pR8ky+J0caVBPNA9zM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32f25db-0772-4554-5794-08dd4601f4d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:27:17.6002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeeabJKA48Gluy7MJmEZU3x6TsLkkxMSPnlMiyK3M96SQxhEOh8lQ5gvLhvfwlPxTac7N0ZuKMOsfZ0dJfBFLNSGGT4one2nJqI2Ns0UJhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050127
X-Proofpoint-GUID: dS3bpcTFm4bIajcJPFBE0QNGgEthgpxL
X-Proofpoint-ORIG-GUID: dS3bpcTFm4bIajcJPFBE0QNGgEthgpxL
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/4/25 18:01, Peter Xu wrote:
> On Sat, Feb 01, 2025 at 09:57:23AM +0000, “William Roche wrote:
>> From: William Roche <william.roche@oracle.com>
>>
>> In case of a large page impacted by a memory error, provide an
>> information about the impacted large page before the memory
>> error injection message.
>>
>> This message would also appear on ras enabled ARM platforms, with
>> the introduction of an x86 similar error injection message.
>>
>> In the case of a large page impacted, we now report:
>> Memory Error on large page from <backend>:<address>+<fd_offset> +<page_size>
>>
>> The +<fd_offset> information is only provided with a file backend.
>>
>> Signed-off-by: William Roche <william.roche@oracle.com>
> 
> This is still pretty kvm / arch relevant patch that needs some reviews.
> 
> I wonder do we really need this - we could fetch ramblock mapping
> (e.g. hwaddr -> HVA) via HMP "info ramblock", and also dmesg shows process
> ID + VA.  IIUC we have all below info already as long as we do some math
> based on above.  Would that work too?

The HMP command "info ramblock" is implemented with the 
ram_block_format() function which returns a message buffer built with a 
string for each ramblock (protected by the RCU_READ_LOCK_GUARD). Our new 
function copies a struct with the necessary information.

Relaying on the buffer format to retrieve the information doesn't seem 
reasonable, and more importantly, this buffer doesn't provide all the 
needed data, like fd and fd_offset.

I would say that ram_block_format() and qemu_ram_block_info_from_addr() 
serve 2 different goals.

(a reimplementation of ram_block_format() with an adapted version of 
qemu_ram_block_info_from_addr() taking the extra information needed 
could be doable for example, but may not be worth doing for now)

