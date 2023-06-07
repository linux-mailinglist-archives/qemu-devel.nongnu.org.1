Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD9372678F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6x6Q-0004oo-N6; Wed, 07 Jun 2023 13:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6x6O-0004oD-Hk
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:37:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6x6L-0002fJ-Ce
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:37:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357ErUd0026215; Wed, 7 Jun 2023 17:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=u3uUtzKJxpizre4oMLnFTEidLqnZaFGPXzmEOc3y93I=;
 b=L0ig2rJFIsUMkriIKJelbPD5kqtcWeDQ91gsqsqILzYIalM00ICC6Ft6zB3nKU+oMUe0
 A13zCpNMjoeZNpam8rzVhReqHgX9puoJKb9XQwSU8PPFX6lt9NZogD7ApnI9zLrTfM+m
 Kn+MdCPHP5kFuj6L8yTeawASnYvlYEoqfgOw8+88ZFBtDKa5RV9iTjdTNUrCryyoRluL
 4fu3wAmXrhHFYmLaabBACPfPNHD+J6QseoPlG4QPI9sxzP8198jtgP5wfkPTkjRRqjvO
 /BaYqAMER6mw0EUUaftUA67y9iqn9kLRLfefyhmJkxz1Jf4/dshyx+rTtQoFMIQVuBqM YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rabp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 17:37:23 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357GhVDr036037; Wed, 7 Jun 2023 17:37:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6rtvrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 17:37:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuCm/PXE90FxuGmgGjNoZFosaI+RDALLGPNZXgLpaRHS6t+bRMg4lg4jsTmjnM/4SxhMe/3HiNxpVj6iOVcWtkt0/bIDvDbDwPyZ/EAwZq0K3JuT7FNr1MAKMXvkmf/64Ve3Vv7yzrA5BP6oDXBMaVxBhaWlbEiLjgMtizxs/Yp5MWr6Oq4TgX3WfI6X7ciAq8CnObP1k/EpEtsRJI0GrhGEAFBOnSIeTjjC9wePnMuTMLwxzm811DhcXrsARpCBmbGc8ZCXLkEibnvPIB8iNoQujWY8bgj/jzi0B2nIU3qmTR119M2vxEdbx4Z9wamUoXOZtTQWZroHM+Oso8C+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3uUtzKJxpizre4oMLnFTEidLqnZaFGPXzmEOc3y93I=;
 b=NUigbL9Bc2e/AUEYTBsK5qYnapqpynLmPF7Iyav4JRW/CVrTbqzNtLnXOaMmN8QGqicgqd4Zvz+ak1/DJ5L1ina2uTgHSyRs7KxhVy/ENJIQSwBc9qcC/mnB7rUJbhz3S6WaawJ3hTIaOwllgoXvqO5lQbOj+c37pjNElYaAh6Ann01ka/C/SWOMskSeGNPHMMPGbrRJfCqEFrrEWWn2xHTXLLR6Tcc4Az3THua830kZ9gcLaa1ZlFw7s0iTtZFIsPEFUEpPK/onnWBDVNYMbRLebntGgYxR43bNQZs+LywC+vwYzUUtA2LFOC0ER9G3XR6UxTnvyvPymi6OkqCxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3uUtzKJxpizre4oMLnFTEidLqnZaFGPXzmEOc3y93I=;
 b=KpGNN3Q64Ic4xSteW+fCoRQQOTegRRMUz+X7HyTGdgdmAPLYdQom65cQZ3v6S/siRKf+FED0Ny0X36LL60uh/aJs+JKFpgwHZNNYb/VptAmtJB/aPsRM9dUn5vLEr1cWtc6TbUSdiu+gdgmz+mZc9e9qvsC7r7CkS38tzozbIqg=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by DM6PR10MB4252.namprd10.prod.outlook.com (2603:10b6:5:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.34; Wed, 7 Jun
 2023 17:37:19 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 17:37:19 +0000
Message-ID: <2ed16545-c0f0-0103-a1e0-03fcc49959e1@oracle.com>
Date: Wed, 7 Jun 2023 13:37:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V9 00/46] Live Update
Content-Language: en-US
To: Michael Galaxy <mgalaxy@akamai.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jason Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
 <zhengchuan@huawei.com>,
 Mark Kanda <mark.kanda@oracle.com>, Guoyi Tu <tugy@chinatelecom.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Peng Liang <tcx4c70@gmail.com>, "Hunt, Joshua" <johunt@akamai.com>
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <53075574-9e73-f773-ccb1-cca42a719801@oracle.com>
 <ada81103-d4eb-dd02-45a8-176dae06d26c@akamai.com>
 <c4f8a36f-53e6-9d88-f542-bcbcf5deabd4@akamai.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c4f8a36f-53e6-9d88-f542-bcbcf5deabd4@akamai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:806:22::28) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|DM6PR10MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 5328b9e6-627d-4d88-4077-08db677dd7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLpdZbEmP6Ykl4bO8hyXe7BScwN8VLd+USX/rOGQhvYfHSPdg8RRmAoKjaoAMQBjO460ybm3kkxMmnoDQg9azwVXrb42cxnuEY9esbXgEL/0HRDxZJrxpv61OT77uHQb3lI0a+Xjuevnfq1Yq1gx/5Dwii8pI2v2GkRbgdbx8lUSjSipy/FMTqpwQXZJdpNhfZAdRl1fq+1w7pKu0/tMCUpKIKRSFS0Fe6GJ/4cQEdcHmPE/I8kqnOW0DtdYwTld5riNWm9Pa/icXDLWuByV3JXw/z3VRXcbugHgalWi+SR90KRZBNOM+Xe5Ccrjux4Yf0Z1YRxFh6Ecuj5dyufjDfjt4oJupOvJ33E+E8dQgelLySS+Xk8UB+6Au7/1GAYq5BhNPpYXVms7bZoMqaFDrpkWjke4g/OD45fC34LCBj7TmftaQCtZlnRxxb1KPxMxPNM9fLFMZUdqxQgcR4ErNgdhcnMAWtGrer7aELVyo9XuC3p+OXLYhhCuFfDL3BfJLC8WjtmQtRKAXKVbTie6WyaVI4akAFtIBpjQBmpIkiGFCYwbeDcEHz+Nn/t9mArfZVpFbpS9w6BT9sht9kj9rzEEH1ROASquyNd3n5/XlHpU5yCJXrX/pUIkMrIS9pRJGyaNEn7Df1LLnCZmtDKSCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(36916002)(6486002)(6666004)(2906002)(66946007)(66556008)(66476007)(36756003)(54906003)(110136005)(38100700002)(44832011)(8936002)(5660300002)(8676002)(7416002)(31696002)(41300700001)(86362001)(15650500001)(4326008)(316002)(478600001)(2616005)(53546011)(26005)(6506007)(6512007)(31686004)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enF3cjFGSndWZnpCd1pFR2FyektCU3JDK1ZGOUJQVjM5ODVySzlGbWRFNG9o?=
 =?utf-8?B?OFBJd1F6SnY5YkVqeGpBUW04NW04VjhFMHVSU3dzSkxULzNSa3BsaFBWaG1u?=
 =?utf-8?B?TVh4T1ZPYXRDZkd2bkNmNUh1UmNBZ05NYUdoVnRVdGZUTFFlODlZaVFWUUZl?=
 =?utf-8?B?eG81cit5ZXpWenZoQXdicGdqSWg0MmZOcGtYb0taeWEvaFNWMk9RMDFweVhE?=
 =?utf-8?B?ZFhKbTlsaXZ0Z3VFdnozUG9OZE1CSG5JekVNMFg4T3dyOFY4bWM2dXY0cE1S?=
 =?utf-8?B?bUQ1UjdXMDBZZ0tzZWdWb29UbTcwOEhBUVp1RHRsemF4OVBUa1ZWbVhGVTl0?=
 =?utf-8?B?NnpMUmxEaXFWR0xlbnUzbVRLalFjMGRqVEJBWVNVNWpSd1FMalB4MW16RlQx?=
 =?utf-8?B?SWYycVF1WEpjbnByaGlBTERML1IybllNMDlxYm5QSTczdnI1Sy9md29Hd0Rh?=
 =?utf-8?B?NzNXSjVrcGxOeXE4RWROU0M1OGlYeCsyWTQwN0NCSHFxdlc4Z3FhdWdtcGxV?=
 =?utf-8?B?N1cwMFJVRnd0WVY2WmY1MWtYbHZCWWhlRlBlL20ycHloZHRENUxIM3ovU1FP?=
 =?utf-8?B?R3RFZFRDeFFsV214VW53VWVId0tOM1RLUWlrbmlJeXRvZ2VvMHRSYjg0M05u?=
 =?utf-8?B?dEhIVHNpNnU3M2U2RGUxYk1oTDVJTm9iMGx1eWZJajJyZXRBakJwNnZIbWpM?=
 =?utf-8?B?dE42K1QwK2VueGwzS3hVSlFiRFpDTVhqL3NDdlo5L0FtQ3c0aVVLUVowQ0dK?=
 =?utf-8?B?QmNaa3M2ajFISDFXdGUwSWxFSGRCWWw4SEZqc29QTzBXT3UzUjFEUTZ6NDQ0?=
 =?utf-8?B?TENwTGFxcVlUcDl2a0J0Q0I3aUlQN3FSSmx5Um1YQUp5OGFaYjdCWERsODU4?=
 =?utf-8?B?enNVNVJCV09ndXJweUdjK0RZalRlczJ5anEzbTVWcHk0aEV5dHl0VVdHYytE?=
 =?utf-8?B?TUlaM2NpMUM2NjhOTURDcmVBVkx2amYzZFR5MzZmblRMMFNBMGJFaWVjai84?=
 =?utf-8?B?ZEdkTCt0MVdaZCszMXFjNE8rUG9NVkl4NjRUQ2xBL0QwdER0Wk1SSjJaQlAv?=
 =?utf-8?B?czd5c1k2b0l5T1JkWjU4cUFwUVhTS2dwbkJCeFR4QmxXYVBqU09oS3Q2dnM4?=
 =?utf-8?B?WjBQVnBBeE53R1JkakRqZkZJOHRUd1ZKNmNZaWpMTU1OWW92YzV1OTlrS2Za?=
 =?utf-8?B?N296ZHBvNDU4eVRPM0RMdDEwb0wydURsU21OMlZwMlBmdlNkR09GMXp1TjZH?=
 =?utf-8?B?Y2RJU0FubDMrVXMvN0JSNXBSK2xqU3lxTU5JeGpaRVMrc29POUsrY0ZWMTRs?=
 =?utf-8?B?Z0VYZm5vYjNhNy9EMVpndnN4YUNBV1lMRGxsWVVPdVg1eTkxVWJkSGVML0xl?=
 =?utf-8?B?NDFuR05VM3hScmJEcTh4OGdkM3dZY2FFdUU1bXNuY3BVU0FBT3JYY0g4dmhw?=
 =?utf-8?B?dkZYK3JUbTV3SWs1cktCSFptYk56SzIyU3hxcWNUcyswV2hSOXhFMlltbVZQ?=
 =?utf-8?B?MmtwU21NKzdDNm85T2lvSHZsWjhQdlVxbFUxYVJQaU5zVm4yK3YxOE1WTTdv?=
 =?utf-8?B?aEhDTkpvb0VXeW1rcmJWWkUxMzRJVjhDa1IyVEVINDlyb2JhczdsNTJ3dDlW?=
 =?utf-8?B?bVNmdktoa1QzbFh5aWJZTnJGNnl6cTlSZ2oydENzcWo3Mk9ZRVhQd1hYalp5?=
 =?utf-8?B?dkxjeWI5WER5RW9jMWpaSjVOOFRLN1BHZ09UMzdPTUgrblBTMjcyZUdLTXJ0?=
 =?utf-8?B?a2l5VWRIeFlXZ1VUOU9BejNHVXczZnREV2tSbEYxMk5nRzNleVFvOFJUdWd1?=
 =?utf-8?B?YWNGb2EyQ1JSWHd1NmhwU1NUTGdmK1JQNlBEMDlsSWhyWTJTWUIvVFlPZGc4?=
 =?utf-8?B?UHZyNUVldVNsbHkxNVB4Y2NDMFFNV3NwOTdmcU82TFlLMzlpd05sMmxJalEr?=
 =?utf-8?B?dFlpTzhZNGh0TklaN24zT1d3N0xocmcyNzhpblJxeHBDbGYwcVY3UTM2Ri9Y?=
 =?utf-8?B?QndmSXBBSllFUGZnVisyOXVDbDMwYXUreTV6SW1Wa1Frck1rMFEyeWRzTXdH?=
 =?utf-8?B?ZjJMNHdMcHNGc1Qyb0FLZk4veDJGaGFQRnRiNU9ITnpwNk1tUmhxSys1Snhw?=
 =?utf-8?B?R1o4N2pxcFR3ZmtJWlIwNlU1RDhoK3hhaEsyYmdCRFB1VDNhbjVYbGVyM1Qy?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eHB4eVcxN1BOenBNaVQvYlNGVjkxOExwOWc0RUtvbHJJelJQdEdCQVFMNFhw?=
 =?utf-8?B?amh3ek5SSnE5OEN3dXpTMi9hUjVaNGN2aDVDdGljdmd0NU04QXIwY3o5VlVV?=
 =?utf-8?B?ejZUczRTSjBoSklxdkFHa3RvUC9HcGxkZUZVNlRBNDlZS1ZpcFJFU1ZHRjRH?=
 =?utf-8?B?UFNzbHJzQkFQcjhwZFpRRml1QXJ2b0YzdDltbEp6bzZWRDZWSVE4b29vYXQ0?=
 =?utf-8?B?aFdQZWNnU2dpWkk3amxXMmRGR1J1VGl0YnppRTJkSFJ5ZzZkcERDcHFEbmN4?=
 =?utf-8?B?Q1NZdE9XbHYyem1LUGk0UUc5c21pSTN2dTRRUUVaTmFkY2F2d3NpQUF4amxN?=
 =?utf-8?B?TWdEVFhIcGlqdUxqUHdtd1pLQkxzZmxMTzJ4L1N1MGEzYTRqOCtCOFM1NG1C?=
 =?utf-8?B?QkhkY0hLV1VGSnh5aEx4MjdaaVc1ZmNuNHFaSDVrYXFWVVF4R3gyL2FSMndY?=
 =?utf-8?B?TU9JZFlLYkU1MDN2NG5kaE4rdW1IelBJLzgrNWxjRTJVakp3Y21kYTFZUGJM?=
 =?utf-8?B?dnhWZTY2U3d5RnhuejVYTjVPZjZ6d1IvQUhDM3p5RExCZytuaml1QkV5N1RZ?=
 =?utf-8?B?c2ZnVXRKelBFWnVDTEYrZWthTlorRkNtK0VmQ3lUNmpIMWZJTERhbERSVTcv?=
 =?utf-8?B?QmgzcFNNMUhWdnlTN2p3T0htalhsdnRSRkZYZDdaQlR2d0lwTXhvckNyays4?=
 =?utf-8?B?cWxCK3FUdnhCRFo3SU0vUkRyMkNSUk5wSzNwU2FXeVpzQ0xWYkJ4bWcrdWpI?=
 =?utf-8?B?d1JmcVBrUzViSk1GUFVjRFVqZ00reDdpUWpZaGRmNTVGRU9PNk1kbXE3YXdk?=
 =?utf-8?B?RzZrNGtpTU4rTkg0LzZGb2hjVkNGU29OMGxQN2g2UEJhV2s3MEprNitqZno2?=
 =?utf-8?B?ZS9xbW1iNE8zZ2tLc3l2MksvbUdzRkFRQU1xd3VxTWFvbVc0UE0wVjdBemdp?=
 =?utf-8?B?NFdrNy9oKzIvWlBvY3ptS2tGYlJIQ2Jsa1pTWThHQlVmMm5WK3ptZVVZdnZ0?=
 =?utf-8?B?SlBEN2pqTXN5MWljRGJ6emFsUnVkTDRpV2NlTTJsbDhmUklaaEFENmZaZTBR?=
 =?utf-8?B?MVNlL3JzOVM3YnF3NjM0eGo4bkRhRUoydVh3dHpucmNNU3ZRcjZHU1VlTUYx?=
 =?utf-8?B?bTF6dG12TDhEb3hlT0Z0ZHdGMzBzcStOK2cyR3hwNlcxUWlONzAwYnFSTXZM?=
 =?utf-8?B?VkR4SGZsaHhJcFJIWERJWmFtbWQ1RFFpWmgxaVFmZmY3MUdDbTlOVWhMb1N5?=
 =?utf-8?B?ZjRmN01FOHdFdDdRa2JZRjl2ZjFqQWFzZm5mNTNQUkRNbThOd2lHbWNOTiti?=
 =?utf-8?Q?4YyzNA8mzJxRw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5328b9e6-627d-4d88-4077-08db677dd7e4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:37:19.5757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61/UUXI8q30E04bym+iTNyVG2VPAdo/pJYbY90dwHgQ9nnsxhas5SX+Gd/5CbXAistMJU0aWYHrAUxMbbsZkcO9ezczcHgBLGDOP/F0WHa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_09,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070150
X-Proofpoint-ORIG-GUID: 1kaXtMoqSFCy29g1ulOhM8z9tzy5oTCB
X-Proofpoint-GUID: 1kaXtMoqSFCy29g1ulOhM8z9tzy5oTCB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/7/2023 11:55 AM, Michael Galaxy wrote:
> Another option could be to expose "-migrate-mode-disable" (instead of enable) and just enable all 3 modes by default,
> since we are already required to switch from "normal" mode to a CPR-specific mode when it is time to do a live update,
> if the intention is to preserve the capability to completely prevent a running QEMU from using these modes
> before the VM starts up.
> 
> - Michael
> 
> On 6/6/23 17:15, Michael Galaxy wrote:
>> Hi Steve,
>>
>> In the current design you have, we have to specify both the command line parameter "-migrate-mode-enable cpr-reboot"
>> *and* issue the monitor command "migrate_set_parameter mode cpr-${mode}".
>>
>> Is it possible to opt-in to the CPR mode just once over the monitor instead of having to specify it twice on the command line?
>> This would also match the live migration model: You do not need to necessarily "opt in" to live migration mode through
>> a command line parameter, you simply request it when you need to. Can CPR behave the same way?
>>
>> This would also make switching over to a CPR-capable version of QEMU much simpler and would even make it work for
>> existing libvirt-managed guests as their command line parameters would no longer need to change. This would allow us to
>> simply power-off and power-on existing VMs to make them CPR-capable and then work on a libvirt patch later when
>> we're ready to do so.
>>
>>
>> Comments?

Hi Michael,
  Requiring -migrate-enable-mode allows qemu to initialize objects
differently, if necessary, so that migration for a mode is not blocked.
See callers of migrate_mode_enabled.  There is only one so far, in
ram_block_add.  If the mode is cpr-exec, then it creates anonymous ram
blocks using memfd_create, else using MAP_ANON.  In the V7 series, this
was controlled by a '-machine memfd-alloc=on' option.  

migrate-enable-mode is more future proof for the user.  If something new must
initialize differently to support cpr, then it adds a call to migrate_mode_enabled,
and the command line remains the same.  However, I could be persuaded to go either way.

A secondary reason for -migrate-enable-mode is to support the only-cpr-capable
option.  It needs to know which mode will be used, in order to check a
mode-specific blocker list.

- Steve

