Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53105805DE3
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 19:44:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAaOw-0007lz-PJ; Tue, 05 Dec 2023 13:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAaOo-0007h5-1c
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:44:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAaOl-00011N-Mp
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:44:01 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5HO8JW009333; Tue, 5 Dec 2023 18:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h1vChdr8yMFVTlmNLa+LuFzHgM3GzgTdl4PfcOtdgmA=;
 b=T0co3m/7+GrUEF9FGOhp27LWKJEqEZiJ9hDaIryU0HhJz4kyaCi3E/pTkKP2qawrg6y4
 6TR2CAE5SGzy0hdVnwEDfDgaZyxVNqUJYiRnDwutC2NKL53gZA+ZMtJi20yqbMjs2bxY
 jDSy2LWnHmqovfhWqSZpMzOM+Z8igoNCQAWdjxknvumwvRFGPeGuSRRwLn8XXWDDifXt
 WmapSCcY5pwhSS+BAeDOEJhtfSCXehwzSADiCeezNaoO3/pn+NOu1ypYMda8WZtGDpAU
 aqk004dg9gBo2P0Y4IAIFKHqsDEWiv9ydL5Vawy+zZTvyIdtHTBpCJ8YhpFboyvqq+VI Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut076sg1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 18:43:56 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B5HEVpg026011; Tue, 5 Dec 2023 18:43:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu17yqyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 18:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjWC1hzST7V+8nu2ZNpaxBuK7n5yVK9ZnS2PEMi50hHSlYFofAo3eYDV5Rw1smCJwf1VRQZp9O5AZ0ScxZTfmYvc+hegq6UCLc4dHz6aKct6LIv3iUCEe3Q3xj6cVfUi2tRkxRde6R6SEy+/KZhhlBZ8JlpUdEd+6AwdR6KrFjQcoaOAioyJX0MC1jFMvRCvJANFAFR11NVriQNpoYICHRPYAhU2794/nbflINKyaKWm27jfqP5EHRjf/uCdVTPwgXW6ZXMMcNAGfNegdx+F4zZhMgzNCJdkK7CBNNJPJmXe5mmxeZ8nkbR/eZtTPwtQgW2TME74hc76ogx/7Jt2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1vChdr8yMFVTlmNLa+LuFzHgM3GzgTdl4PfcOtdgmA=;
 b=GuXJ3CImPqBaWG/UpqmrV8CqhYMLEsJps9DzLFm08mJMVMcmR37W/QnlfjMQUfSNClCqf2+moxHr+t/qQOwBL/0eDwdjI/JO6zMRgWjEng/t5cDHscc/6SK/7yPaf/oHS+ciEfVs731egwVX4m3mZdWY+05zrJP6ffqXC1ndJOg80cZQy1T3sUdflyNdCPPo8TZjp5LpTYzRG0cUfDtbJY3Z7c3ruYtYnmVF69cFOa+f162oikF2IvMlawA4Px+Gnxu1JownyiDVu4f5ASeQOP1wTPX1ksuperWibm0N75mupjm0vR8i3TDEcfWNlKuhMq4vSEvpJrX5mVIKYYYyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1vChdr8yMFVTlmNLa+LuFzHgM3GzgTdl4PfcOtdgmA=;
 b=iSsUzdsQ65R3C7zEET+nROrKz02XW8MosaSwvo78M4dG9YFfOlxOJCLHeRTeYW5unJU9aVCWHkkvm+N3B62zf9O6ndeh95z3OQdkakyzUnqjPWeakJkQge4BIguufyLvbipe2XyqMhfNAF+tR/qY/SBQIaq6UpRvRmfpOASbBpc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB5181.namprd10.prod.outlook.com (2603:10b6:5:3a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:43:53 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 18:43:53 +0000
Message-ID: <1e61d3ed-4b91-4ffc-bd71-fe04789594ff@oracle.com>
Date: Tue, 5 Dec 2023 13:43:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 13/14] tests/qtest: bootfile per vm
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Andrey Gruzdev <andrey.gruzdev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-14-git-send-email-steven.sistare@oracle.com>
 <87lea9n01r.fsf@suse.de> <ZW5UsIhP7GcKbwZK@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW5UsIhP7GcKbwZK@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0391.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::19) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e08103-b78b-46c3-5096-08dbf5c2215f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ChdA4b1u0bhSXr1o8t1y4dS5X6Biq4NABMODW4pvyTCeD4Qvz3Caaf9dfwRaUFQsVLAOPayjpROgjB7bfjKp/0DDIgz1iML7keezeAAlpX/s02TSaZw0yy88fr1dytbDJSWm+oc/cOcfbk/NfRDKbf+QkWL2pazT84m+BNk9PdSs/PQSVWqDXvMp7ACHW2fFozR83VcZbXS27PZGqfWQZ4PK5hcsTAgt4s+R1dPTzbwI9ZLuACr7d1sPvBju9uI9bc5OK09so7gBcvnrhqI0e7Yrrssst6e+odSp8pHLbKhFOwp4kaB2i7bHoBSo7ljFZr4rE+qy/FlAtzFrEfbVAf0vJr6Q5ss+fs+36558gnyz3MITOM3Jf+e3dtiU/7n4DGjPDmJmn4c/eaATEp1eayx6tDsTu++oiv4LpOruEKmfdzxvsicUTA9KmDfU/dkzxCZQWBItW8eEudNaKlDbgxK9LsMDAysddaYZIrGUIZLzaV7i1Ng3VfNYaG+fsM2fOEFOeZ9JYCquDMIHL2a72vQm32C/ZM0c/Lc94Zcx959jZr1kC1OZ+GcO8ipYaz8ty/2tqNIl39Q3EFzrvmiG8mp7PNCbJlCYzOCWuMuan1w5+MsyEeV9zLwDKLo+krBKFldk437v5yq+vrJAI/1Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(54906003)(66476007)(66556008)(66946007)(4326008)(8936002)(316002)(110136005)(8676002)(6666004)(478600001)(6486002)(5660300002)(41300700001)(36756003)(2906002)(86362001)(31696002)(44832011)(83380400001)(2616005)(26005)(38100700002)(31686004)(6506007)(6512007)(36916002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QklOSlNISGJsMmZlTVJlTnlncUdsdUFqN2lnUmdBUVg0RTdTSXJ6amtUZUhw?=
 =?utf-8?B?eUpyY2w5UmNMNWJaZ2d4YWhRWDg3bC84OEhHRHVndWlqVWNIaHBjMjVVaXE5?=
 =?utf-8?B?Nnl4TkF5MzllTlFEU3BJbk1LYUpIbTNzN3V3L1JaM2J0MXZwMkRudVRNUFBN?=
 =?utf-8?B?M2hPYVVrWkpLSStpSHgvQnNmOW4vazQvVE9QZVk5V0oxK29SOE50NHFMcVY5?=
 =?utf-8?B?S3BtOEZ0N25Hall1bitTOGlQbnU3dW9hUlVLUzFLbEdIYTZlWjBSL3Z4ZExx?=
 =?utf-8?B?YlFmZHNYdFFaUVgrM1gwMjBsNzdCNjNEdmJQd3BMTEVBSC9jdDdaRkZYakJ3?=
 =?utf-8?B?VXJuVlNYQ2dwTUdoandPNHpweTVHY3lNKzRZbW0wa05lOE9WbkxsZWR2UHBI?=
 =?utf-8?B?Nll6aE1rNXhVK05hbG9WV3RRdXkrU1NEOEZCRVBSR0trT0FSMEhMUDlrRlEv?=
 =?utf-8?B?dnJRVEUxamhPU3NoZlgxLzVBSVVUeXVmc1VmcnF2UitHQzFBSnJmVHluM0Y5?=
 =?utf-8?B?RTBhQ3I1Z2lHMi8vRThHSDlJcFRiOHNTR09hdXh5bERtQ1RiNUwycGROdkpm?=
 =?utf-8?B?bzVqQTN3emNmUWZUM3Z0MEs0UG8vMDdJdnlhUG1KUm5Kb25NdlorMjQ0b0VD?=
 =?utf-8?B?QXhzT0ZOY2ROaEN5dUNnbTJCOWoxUkY3TXBiNWlPTTNWRmlwelNNaUJUSjh0?=
 =?utf-8?B?WWNkUUVmcDg2YUQ2dndMQi9SSVM4anpGUGpibVFZc2lhaVMxcnBTQ0lSNGIy?=
 =?utf-8?B?UG4vK2lxSG5kZHlBK3JjTXhkVGJIZlFFQ2ViTGZ4alE5NGs3ZkcwakZPeUVJ?=
 =?utf-8?B?NjR3ZTZKUER0MWZiMUtEN3VBbGlCdVVwb0RSK0ZqRnFBSFVCMjJOUEM2YmtU?=
 =?utf-8?B?cVFOcy80M0R4OStoTUJZSEJRcTlMUHVCTHV1d0ZEWGc3Ym1tRG82bFdBMWJy?=
 =?utf-8?B?elBOMU1yTlRMbUpucXFOZmpaL0ZFNEszaXhnbjVmYUMvd3lPRGR5MTdPMG1v?=
 =?utf-8?B?VUVvVHVkL1hsWEh4M1FXcUhIQXhlZGp0NndkTVRDR3B3UGkwOUk5Ykt1YUQx?=
 =?utf-8?B?aWY5b0srS0JXd0E2UzFuMXJWaCszcUtWY1hnVFpSKzRqdDVFWWpoVUh0VXF3?=
 =?utf-8?B?akx0cTZibzFpakFpekZuYXlJVmxpNWVoc3BBT1NTampZa04reWJwTDl5RjlC?=
 =?utf-8?B?dWNlTkRQa0RtY3NvN05tTVp3RlFMdU42UlNkZ3dqS0VCdDVFUzh3RHpwQnNZ?=
 =?utf-8?B?elIwWTNaUmZveHpPbURsR1l4QjBqSkQwRjlJb2NNTnBTVlZZSXBzUlI5ZGJB?=
 =?utf-8?B?UnZJNjBsVGdBKzdlTDlTTXZKWjlSd0I3ekwwalFzczB5QlV4b3g0TVVIM283?=
 =?utf-8?B?MldaWXNUTDJmYS9Pb2xhNVlDRzB3QWpEeUN0bEdHTEZ0L05XRVZjY0JhQnZX?=
 =?utf-8?B?ZGhFWHRVUzBVOG1lcUJ3UlVkSWFoQTZSS1NqVE1kZnI1SjVMY2RSVitYTWxi?=
 =?utf-8?B?NWZuNk4ySHhqWFJ6OWVxWDZjdFFLNkZDalRhUEVreXI3bUpWWGs5anBXMkpP?=
 =?utf-8?B?VEtLY3dlL2p1Y0EwSzBIckJhTkRBam96dzExcXY1VVJYczJiUlJQV3F6TlJO?=
 =?utf-8?B?Z2dJMk00R0h1aE12V3lsbWhtZUhEeTAvYmVhckVKOThaUStwbnA5TDVPQy83?=
 =?utf-8?B?bnFWTXhsN3BsK2kwUzJuRXFHQmJSNUIvUEhqckdwV0ozRS9NOEV3WlJSS0pY?=
 =?utf-8?B?czdpaldmWkdIUFJHWlZTYnVnU0FrWDE4aUFlNC95NUxodXlIV2R4L0w2RkJU?=
 =?utf-8?B?SDRhTExzMTN4WHhUVnFJYTJ3dlFnNWVyMWh1clMvelZxenNNR0F0UExLYzdo?=
 =?utf-8?B?eEoxR09RdmxGMjNqVy94b2xqdkI1UktRbmF5RnhKOWRqMkoydTFJdEpFcnBl?=
 =?utf-8?B?VlhZaEJkTVNONGlYczJWWkZEZ1FFS3MvVXJMTnI5ak1wbVVhVXRpUHpLd1FZ?=
 =?utf-8?B?ejFQdVhVQVBJQmxyOEZuakNHUGhabzlLbVloZytUbDR1dGRxcXhRRnpQTnFV?=
 =?utf-8?B?NktuRjRzUTA5eFNPUGoyRXU4VHJ3WCs4cnk4aW85Y1lUVjBFeHpzK1BIcy9K?=
 =?utf-8?B?M2FYMlY5cXM2WE9FaTdXd052eC9BdWtKTDBVUktZM2MwUFZHVnFncUZQOVVY?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q7FVZQ/WHd8nSDNpiC2tPzCohVCV4arK7emI4sMKj7ruDW/apw5eTYuWIb/xD/Vwu1gbTHsKfKjzU5+Nb7ICoeSc000QZ20goWECWKth8Y1wby1FMZY6gmWp2lG1coSrY6oqyolpxX/tzIqMT0owwjiX5EiL3HXFfQIzJMvA7fmqza+7CI+mXTfPSIdHR9Uwy7YblvLEWQleZSzpefNjg/RS5dcFOyFOItn8trm7zuVpE8ATlfOBXFO1GWy05Q1u4N9VXfabdgZ46oSiIvWCFWK7kvDcWbfWhBNVNvqf+tMQGBgVNNFDhImElsY133Fda7vTX8XXkiFSFo7vi+JPExyjs769cv7eOHjQuCHGsH+P2b8FGH3cVwVTyLXink3kEZ9OBDKWg/CzFE2rF4FVeyIq+N0AkbULBJ5D+uUCNdKZAh/iRkOelKUsSzQkJohn/Za6GZveqwMBgunSbRht3oLitXLJLXj99QR+KP71uzcQF0fINXqPS2GjLWyCEaqGl5/vvJUKkWT43Ig75wzXg9Hc44lsiOMPeL1et11cZpCe1nBt9Iu/WRNYIKNQhNr+KfLgJvzWv2FB7tCcE/dKIvDDXTAhPr6Xp45MsQ7Cp11nAvhZ88wYXTww+KN2Yzq05BsvQOinnsGwwZTDDacKxmLB8w+Tb2mDmT0QfCuxoZPqWB8IEg/RVyWJJ0wFWQrDbOrbv7c8VBstIjaj96IV87mAlBO0gNxXTpToR5yr00cZ2wY/MJiJCTlemq5bMX2LAX+jBFAWgUyuaVuz5icc1wMxoDC9AGMsj32T+jCfae/xPP5lt2bBNgo0i5wDV9Ee+nCb/3sXmiPpS2uTb+1hAA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e08103-b78b-46c3-5096-08dbf5c2215f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:43:53.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EucwSxccJ7+j0sW0sKx420tJzaQxv0JEqKkYRP03dwKGTb2h1ALGzcuiIaQxDZSw/Ruu1JmU3XUaOfiLoGMuevNwbL6U3S2uarV7IAzbDtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_13,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050149
X-Proofpoint-ORIG-GUID: JWObXLxrDeprEE53wzUKqb2dEPboaFXQ
X-Proofpoint-GUID: JWObXLxrDeprEE53wzUKqb2dEPboaFXQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 12/4/2023 5:37 PM, Peter Xu wrote:
> On Mon, Dec 04, 2023 at 06:13:36PM -0300, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Create a separate bootfile for the outgoing and incoming vm, so the block
>>> layer can lock the file during the background migration test.  Otherwise,
>>> the test fails with:
>>>   "Failed to get "write" lock.  Is another process using the image
>>>    [/tmp/migration-test-WAKPD2/bootsect]?"
>>
>> Hm.. what is the background migration even trying to access on the boot
>> disk? @Peter?
> 
> I didn't yet notice this patch until you asked, but background snapshot is
> not designed to be used like this, afaict.
> 
> It should normally be used when someone would like to use "savevm", then
> background snapshot makes that snapshot save happen with VM running (live)
> and mostly as performant as "savevm" due to page write protections (IOW, it
> is not dirty tracking, but wr-protect each page so not writtable at all
> until unprotected).
> 
> Another difference (from "savevm") is, instead of storing that image onto
> the block images, it stores that image also separately just like migrating
> with "file:" as of now.
> 
> When the dest QEMU starts it'll try to grab the image lock already because
> it should never run with src running, just like when "loadvm" QEMU doesn't
> assume the QEMU that ran "savevm" will be running.
> 
>>
>> This might be a good use for the -snapshot option. It should stop any
>> attempt to get the write lock. Not a lot of difference, but slightly
>> simpler.
> 
> We don't yet have a background-snapshot test case.  If we ever need,
> that'll need to be done in two steps: start src, save snapshot into file,
> start dest, load from snapshot file.  We just shouldn't boot two together.
> 
> Now after two years when I re-read the snapshot code a bit, I didn't even
> find where QEMU took the disk snapshots.. logically it should be done at
> the start of live background snapshot when VM was dumping device states,
> something like bdrv_all_can_snapshot() orshould be needed to make sure all
> images support snapshot on its own or it should already fail, and take
> snapshots to match the image.
> 
> IOW, I don't even think current raw disk would be able to support
> background snapshot at all, otherwise if VM is live I don't see a way to
> match the image (which is still lively updated by the running VM) to a live
> snapshot taken.  Copy the author, Andrey, for this question.
> 
> Before that is confirmed, maybe the easiest way is we can go without a
> background snapshot test case for suspend vm scenario.

I am OK with dropping the test patches.  It's a lot of change for a trivial test.
  tests/qtest: background migration with suspend
  tests/qtest: bootfile per vm

- Steve

