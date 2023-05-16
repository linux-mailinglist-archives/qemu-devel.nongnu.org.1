Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC870596A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 23:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz295-0005d3-Fu; Tue, 16 May 2023 17:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pz28w-0005aM-QI; Tue, 16 May 2023 17:23:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pz28u-0001kJ-A0; Tue, 16 May 2023 17:23:38 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34GJwrpA019747; Tue, 16 May 2023 21:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/52ktn/3mO0UioKB+hO5BWAB1w3Eo5fjiXZKRAg6UmM=;
 b=qJjH/hCFTdZ3DHPHcbO5KR2v4w8urfegYJth3/5M1NuiZJ3996BJCa67nZ+gSRAyLfF6
 /cMElicArmglUxG0b3Udz91TW1DAAOlgQUf1hf6EFK5wI2Os7UfuHR7YCHJ6GKV8JZGC
 3iNSyDmPkdA+tVUH7EXGUPyHQtehbXoQzwYKkWB9AJ7j6yGP29/WYNnkEoOr2+v/Myw4
 R6Bjic02x656PQY4pfNJjhVKnqjKEQC2r1XZ7urqMl+qm+GuTYDbQVeYRpVqDjN2xt8/
 z+XtwOeVth6mMm9y1h3Y3yW21fg/tW70Ov+AzEJISckHE2dJOeoOpudL0VFBSVfKyXBR WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdmdcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 21:23:05 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34GKk8A9023730; Tue, 16 May 2023 21:23:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10avtmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 21:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSYFlAZly93JSP5duieAJ1g8l9dvSuX+4swuYEsjMpkxT5l8tulMvXkldJCJhXiWGLCI0iZ1zDljZ6PVi1JVH6bE1z2tGDQ8fjB83Nfj7NT7BuZiG0iJXMXa+Q1jwEWTnr6KrYT4sXj6FpZSpttN9Vxlx3U2EEuDxphS3T6TIdNRCPLYtoj/zS2tBOn2yjRPLrVBeRZaijyyuinsKmRccN51e7k3HYD0Tiwj6LbqrqFVlL+1mo9iRW3pZzS0jCrJGg/pl4U4rgtUMsHmGrvxh/axokuUj80hyLRkeshvXwBEuF/t+HDC2rZW34EuxJICfm/whfaaPZEyzK/X2efDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/52ktn/3mO0UioKB+hO5BWAB1w3Eo5fjiXZKRAg6UmM=;
 b=DY+hvu5TDN5n7QjiobObfEmfRWZ7VcQ02TqIJWHPUlzOxAwl2L+pF3S7MYjXbz6zEhr+Kp8sykzCcs43L8d3mUZ8dihzm2lARmKOhvakJV+M0+nQdVBcTs0lV8mwx9VHN6vnu2p+f2woqcxIGJENcHm5D3IMvKmlpTrVuvf6HrUP9ehq93fzTFqgHiQRJPtZjSgf3cQGh2nwchGpH6h/8EoDp5a9Nh0bQUNcb2wJ6rbdE9mnflAhxz61Fykrgzbr5mwBa70YrIDJRuV3SzE6FqGqZL3o7wN88WL5xGzlUCTm9YVcqGCsxYmYK8gdG61NmEsxetmz1P3niyW2h0lBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/52ktn/3mO0UioKB+hO5BWAB1w3Eo5fjiXZKRAg6UmM=;
 b=T3GfMrdZFk3HdYbjCrg50Du62L5CwfLg2WLd8FaAhHbxZ1AcCYNWLTHBw1w49bQ3r3V6lwkwph6N6OEOoh3ydcENVOhnkY9piicRF14WB2J9H7XVKtJ89z+/yGQDonv0ERkyjced7UvOaITV5evblx6V07PSk0zidPe8f0NsU1U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6975.namprd10.prod.outlook.com (2603:10b6:8:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 21:23:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 21:23:01 +0000
Message-ID: <72a526b6-420e-6a85-8cbd-dc589c220c58@oracle.com>
Date: Tue, 16 May 2023 16:22:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] ACPI: i386: bump to MADT to revision 3
Content-Language: en-US
To: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 boris.ostrovsky@oracle.com, miguel.luis@oracle.com
References: <20230515203311.2139-1-eric.devolder@oracle.com>
 <20230515203311.2139-3-eric.devolder@oracle.com>
 <20230516143149.42ad6810@imammedo.users.ipa.redhat.com>
 <CAARzgww1zX5Ss9gpredzt9X83df5yd3Y_P7kVzauw58yXTryZA@mail.gmail.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <CAARzgww1zX5Ss9gpredzt9X83df5yd3Y_P7kVzauw58yXTryZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:d3::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b6ff47-75a8-4646-974f-08db5653ba8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bx5p4QCmU4T1N+ww1ZIUCHSnXsP08MRqflnXADNSxFZygdfaw9eWHpYZXEQm2UX72naxjJkxlvkhhiM03e1vk2SvcsfYlA2ipG1OPDwkIXiMptjUW9tpm37iOLSH2gQSSfvIhyw/tGpqQsC49rAr2hqrQ9+tLnNPANnwinQJNzAe8fjnb6sUPGWGdBmYEvBQhPCMmg8/vcHaZ9y7T3BNW5kybxsMdvjcduwRwEk505Sq6Su86RQMVFWWO88YedbN9FTvLBTWFii2NTlL5W60/uYafSVDtxWpyUt5lwpp+EDH+7s+MuIyuX8ERhoK5qLo7yJ1RMxB7ZjhDGWfM3jDSWsCN/+GP/6WgHSXnJxy7b5qe845NTqzpPpB5soSfnXrIAbx3vaRZdgXPdyGFuGUtg1MuLafYx/zxN+z4nw2wlhjuTiNaioxnUNTRhu6FrMgo5e4eKhgkmpxxMN/wZTnCUKPmCYSj+cunW5r89DuZ31ttyIvJdDc78aR1J1ZE77ozRI4GF162ZTtrgLwAgR9zLFmrvPoyidPHWWyv4vtLooWdA6eD8JeIFlcFC4KzYABMtQyFeiQbyMVAZk2dOVBrlAXjYPiJtV1msy5vDWZSFz+7qGe2OJjU3TBaFKz92jzDweGmrPOIu6rYY4HeA3FLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(31686004)(83380400001)(36756003)(4326008)(7416002)(2906002)(86362001)(31696002)(8676002)(316002)(5660300002)(66946007)(66476007)(38100700002)(66556008)(8936002)(84970400001)(966005)(53546011)(6506007)(26005)(6512007)(186003)(110136005)(107886003)(6486002)(6666004)(478600001)(41300700001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUlKNE9kd0xRYjFjUGN3bEhKaEF4L2ZneThhNFQrS2Q0QkFkT3FKVENKcXdK?=
 =?utf-8?B?OVdvZmVkSUJDOTF6aDRCOWRBUWkxd2RWT0NFNVJtMDk4RGF5ZGR2QkR6cmY2?=
 =?utf-8?B?RXYwZTkxVzVoVy9yNWR6YUFQWEorMXF6OWtOdE16dGg2d0xJQm1EbnEwUmJ2?=
 =?utf-8?B?eW54QjFIYys0Zk5yMXkwdno1a2ozRVh3RnNjanNmV2hnQUdVQ0gzWkZ5VTlD?=
 =?utf-8?B?amhRZWxEUmlDM0dieUt0Vzhnb3JiaTRmVlJ5WFF2UHgrRVZhS0xGL2JYQUlG?=
 =?utf-8?B?WnN6K21FM2dLQW9xVEgxdzJJM2wranVFWlVRZHlQaUo5UDdKYjNjN1ZZODJY?=
 =?utf-8?B?RWNSd1g2SXluTEtkVnN2bUVNaURuUEJVdG84c3BBSzdya09OOEFvRjV1QkI3?=
 =?utf-8?B?amhCN1V3L2N5bDNsajhPTGl6MUh2VVcvMzc2SkZrR3FHOHFkRUk1cmhUZ29n?=
 =?utf-8?B?SUsxTW9teGlHM3AzTEZYWjRMQU5JZjUzTURGSHFzUXhrcEdSSTlZTVVzTjY1?=
 =?utf-8?B?VmhlNm9pbGRlTkZaMk50YnpwYlNjd2dkbG5VaUwvS2UvVFRUTWxmNERlcEZs?=
 =?utf-8?B?TVhZNnB6OGg2WWZmTkZiWkNQV09wanFXMDdsYmgwT2dqaVZTZkxlVHBJKzJC?=
 =?utf-8?B?clZpeFpmeUVxTzh5TUQyQUMwZkNybWVUcStwTnd0UGFLTzNDUzhiZjlMQysy?=
 =?utf-8?B?b2VUWENlQWkvOWZ6VEpTcG1FM1J6WDBpOGlEcnR4WkF5ZUxoTmEyM1J5VkRr?=
 =?utf-8?B?T1gwbXdDWlVMZmNKR1p1TDNJYjJNNVFvd3h6a2V1V3RtcklVcDJCam1CVG5E?=
 =?utf-8?B?RWJUZmsxdCs4QjNnc0ZCeEtRQU1OcHlnVlBzTEZMelhYS0NQK1IzcU9EdVZq?=
 =?utf-8?B?eVVMbGxDSmc4eklGMkcvdUYwdlQ5em5oWUtmanpCUnp1TFhXcmJXNnh5MTRa?=
 =?utf-8?B?djl0R1VMSTc1YzRnWnpxNk81TDdIbnNkRFZyd0x0aUExbk9mb3lmYnZhcVYx?=
 =?utf-8?B?Z3U4eFlxMmlKRGNXM0dCaVVQb0xOeHdrRmUveVZ3UXA1OCtLeHdsc0Y2SEMx?=
 =?utf-8?B?aVBXK28rZHFUUStidnh2ZGttc0U0Kzc2YU81RmVSeWNaanlHMVFBcjVXWUpr?=
 =?utf-8?B?RThtMTFtMlZOR1RxRmJlekdVY1dKcEVwKzZ2cE91ZFhIanVSanhkb3BMVzRu?=
 =?utf-8?B?NWFjVUJnRjVlejM2S0ZSV3pkVkJOS2RCWHM0Q2J1Um9WVFhkSG1ZamF0ajdV?=
 =?utf-8?B?N3d4alcvWGNVMXJlVjQzSUhpU29OajhreUhCbzhTWGQ0MGo3dmdZeU56MGhu?=
 =?utf-8?B?Nk9pZFBXempMZ1oxT2NUM3R5bWFYQnV5OENNMVF5R00zTmpmVkp1V3pPcVNy?=
 =?utf-8?B?S3N5Uk02aWk0Mk5vMElJY2t1U01FVklhVURPTjNFdk5aRWVxRzhEMkNDZGFq?=
 =?utf-8?B?d2JORmhZZ3FyMDdGamxUYkVQMTNwNldPd0YyNC9wMWZodXA3Y3EycTJ3M0I2?=
 =?utf-8?B?eG9kRVdjQWZsTmp5TEF4THBRcFN0RTVQRVJ1c0xEVjlnejRnTmdVMVovcVp3?=
 =?utf-8?B?amFXM3pXd21WbXozWnlQUFpYK3ZuT1FWQm1BOXc3Vk1zMVM0akJyUHNDZVFJ?=
 =?utf-8?B?d3lDTVROdjdSYVl0Z0ZxMzh1WmtMZEZvV3Bka2xYRjl5NHU4UzBleTlLbFRv?=
 =?utf-8?B?aWMrN29pcytIV1FrajhCWGNaM0wvWk9zdURzV3NiQVdGQnNRMm4xeG80Z1Vu?=
 =?utf-8?B?WEtqbnlqRHhjUnZzdTR6UWY1MGtCc0djb1BERXpoMy9xdWZMd0VxRTZtRDJh?=
 =?utf-8?B?ZlVaVzNramRucmpUSzhEYkZuaUNFYTVvbzdsNE1RcGVsckgyUE1MTmRpbldH?=
 =?utf-8?B?NUxQYWdtdlFuOTdneG9IeXBTWG5ERVlhNFFJbzBtUllveUxxaWxhOXJtRE0v?=
 =?utf-8?B?RHVYaGFhbjc1aGY2cEVTMGFOTitvSnRNbXF1N2JXUSswbFN1dXdXZHJmZDdn?=
 =?utf-8?B?Rko3MDkxVVlNS1crK2F4NGxOa1BXb1ZXOXBpK3ZNOXZVQWQzUHE0Q2JXNTlL?=
 =?utf-8?B?bVFuby9jN3NURzNwUTBoMEJoZW5Fc2ZHRDgzWlRKdUszeXo0aVlITStRbnBS?=
 =?utf-8?B?dEx5YmxQUmxZclduZlAycmkvczVZQ0pvcTZsV1k4NE81eklGSU1JVlhRNi9I?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +pRr5ujypK2DK5KKM6EfgqR2kyuXHWeGs/eDsTEkwnYhO4kv5aNMger6JlKzXt3XxZWO/AgD0LbzV9hhIjcGMEyOe5ycULCRel/DZ0yfHPAw4P5oiu/ndUYyU7DsKR6xgqD30vDTj8zUIFYwEu29dIB7hSug7VnalZ2EIDEQR9lF7iSsLn6zT+4sy59CmddYBm39SX317EgpmHCs/Z/SXpk5BOZ92SBXvl2VTgMY95+747liLCXTEc2JjdK8BbcrWi+v23eTGg1vGsaGfrvIP2ZGR3QBzV+N9HaTKA3cOcOHCP50AK2AJlCtO4TfpXkTwiquSzAI/iWsGZ8DQnYK4/+N8O/nMRP1yEIDYtFFmuyo3Ng4ZVpLkL6J0gCn5HfglnSqbP1ILorbscke13EcGvND/Yu0g2VieAhbZGWvpgxpD7LeK0ytNkBdjtzmY4Q2cz7Yji5QD2R0OtPWPj1FYNO16XGWPsSDH19tdnRg+OSW4WK6gHx3KqsfZGP8Q5ebSHkbDq7GWkOnmH71Qi1/sDcXSihRM+tpzWYBvd0WofyghI1+FEnOA7EMrmqVW3Err5tj2S9/mddHAX+TlTcB1WlhJgLQ37Tm1aqpsY6kLxW6WTLpiTyCwkWqC805JXa9VNTnf5hsBNuBNecy6Mhnrv2vuiWvp454/aHwmcTZEaYkzgoa+iOVVZyLKHQAXFmsWgsRAhd37L+7DSH7ZUdeMUh3aNuJeQvzzfvY+Wk5oWzYXJVi6hSy2Pap/5ModO12b+KVQjpp72V9P+20uksHCqQheTOOti7cYTZNMCI5+ipXWRZnMZ3MaeT06O46B7xPyjDsiL9saZcCh9pVrgxb4lt0fIDo/n0uGjKaWCS/ZFUAPxXpJEpAlUCGpEm9pHpbJJrfzzqgNdp3kO6tEeJGkA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b6ff47-75a8-4646-974f-08db5653ba8c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 21:23:01.7314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKo+b1dj1EkLTE1jNqy9JAprOaPvGxn7rBbfogHJLZYp8pYk1r2CnB32gblBj1xaDoI4N9houvfYquW4C9JdW2BZ9LjhPBn74D9snioXxNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160180
X-Proofpoint-GUID: slPgUT5PHGl2Iw0nuxkrqZvLN5rI8Mt_
X-Proofpoint-ORIG-GUID: slPgUT5PHGl2Iw0nuxkrqZvLN5rI8Mt_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 5/16/23 07:51, Ani Sinha wrote:
> On Tue, May 16, 2023 at 6:01 PM Igor Mammedov <imammedo@redhat.com> wrote:
>>
>> On Mon, 15 May 2023 16:33:10 -0400
>> Eric DeVolder <eric.devolder@oracle.com> wrote:
>>
>>> Currently i386 QEMU generates MADT revision 3, and reports
>>> MADT revision 1. Set .revision to 3 to match reality.
>>>
>>> Link: https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@ora
>>> cle.com/T/#t
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> ---
>>>   hw/i386/acpi-common.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
>>> index 52e5c1439a..8a0932fe84 100644
>>> --- a/hw/i386/acpi-common.c
>>> +++ b/hw/i386/acpi-common.c
>>> @@ -102,7 +102,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>>>       MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>>>       const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
>>>       AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
>>> -    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = oem_id,
>>> +    AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
>>>                           .oem_table_id = oem_table_id };
>>>
>>>       acpi_table_begin(&table, table_data);
>>
>> make check fails for me at this point
>> (my guess is that not all APIC tables are whitelisted)
> 
> I think the patchset needs to be rebased and the blobs regenerated.

So I've been trying to overcome this today and not having much luck.

When I run "make check V=2", I see at the end:

Summary of Failures:

  45/786 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test
  68/786 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test

If I go look at 45/786, for example, I see:

Looking for expected file 'tests/data/acpi/pc/FACP'
Using expected file 'tests/data/acpi/pc/FACP'
Looking for expected file 'tests/data/acpi/pc/APIC'
Using expected file 'tests/data/acpi/pc/APIC'
Looking for expected file 'tests/data/acpi/pc/HPET'
Using expected file 'tests/data/acpi/pc/HPET'
Looking for expected file 'tests/data/acpi/pc/WAET'
Using expected file 'tests/data/acpi/pc/WAET'
Looking for expected file 'tests/data/acpi/pc/FACS'
Using expected file 'tests/data/acpi/pc/FACS'
Looking for expected file 'tests/data/acpi/pc/DSDT'
Using expected file 'tests/data/acpi/pc/DSDT'
acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-R4D741], Expected 
[aml:tests/data/acpi/pc/APIC].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-GVD741.dsl, aml:/tmp/aml-R4D741], Expected 
[asl:/tmp/asl-1F9641.dsl, aml:tests/data/acpi/pc/APIC].
--- /tmp/asl-1F9641.dsl 2023-05-16 15:18:31.292579156 -0400
+++ /tmp/asl-GVD741.dsl 2023-05-16 15:18:31.291579149 -0400
@@ -1,32 +1,32 @@
  /*
   * Intel ACPI Component Architecture
   * AML/ASL+ Disassembler version 20230331 (64-bit version)
   * Copyright (c) 2000 - 2023 Intel Corporation
   *
- * Disassembly of tests/data/acpi/pc/APIC, Tue May 16 15:18:31 2023
+ * Disassembly of /tmp/aml-R4D741, Tue May 16 15:18:31 2023
   *
   * ACPI Data Table [APIC]
   *
   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
   */

  [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
  [004h 0004 004h]                Table Length : 00000078
-[008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : 8A
+[008h 0008 001h]                    Revision : 03
+[009h 0009 001h]                    Checksum : 88
  [00Ah 0010 006h]                      Oem ID : "BOCHS "
  [010h 0016 008h]                Oem Table ID : "BXPC    "
  [018h 0024 004h]                Oem Revision : 00000001
  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
  [020h 0032 004h]       Asl Compiler Revision : 00000001
[...]

And the q35 looks very very similar.

It suggests that I need to list tests/data/acpi/pc/APIC, which I have done
in bios-tables-test-allowed-diff.h:

/* List of comma-separated changed AML files to ignore */
"tests/data/acpi/pc/APIC",
"tests/data/acpi/q35/APIC",
"tests/data/acpi/microvm/APIC",
"tests/data/acpi/virt/APIC",

But as I looked closer at the files that changed in the last step
of the previous post, there are a bunch of them:

  tests/data/acpi/microvm/APIC                  | Bin 70 -> 70 bytes
  tests/data/acpi/microvm/APIC.ioapic2          | Bin 82 -> 82 bytes
  tests/data/acpi/microvm/APIC.pcie             | Bin 110 -> 110 bytes
  tests/data/acpi/pc/APIC                       | Bin 120 -> 120 bytes
  tests/data/acpi/pc/APIC.acpihmat              | Bin 128 -> 128 bytes
  tests/data/acpi/pc/APIC.cphp                  | Bin 160 -> 160 bytes
  tests/data/acpi/pc/APIC.dimmpxm               | Bin 144 -> 144 bytes
  tests/data/acpi/q35/APIC                      | Bin 120 -> 120 bytes
  tests/data/acpi/q35/APIC.acpihmat             | Bin 128 -> 128 bytes
  tests/data/acpi/q35/APIC.acpihmat-noinitiator | Bin 144 -> 144 bytes
  tests/data/acpi/q35/APIC.core-count2          | Bin 2478 -> 2478 bytes
  tests/data/acpi/q35/APIC.cphp                 | Bin 160 -> 160 bytes
  tests/data/acpi/q35/APIC.dimmpxm              | Bin 144 -> 144 bytes
  tests/data/acpi/q35/APIC.xapic                | Bin 2686 -> 2686 bytes

Should all of these files be listed in allowed-diff.h?
And I would also need to provide the diff for each in the patch
containing this last step, correct?

Thanks,
eric


