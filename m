Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B467D88FD
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 21:35:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw66v-0004QS-M9; Thu, 26 Oct 2023 15:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qw66h-0004KQ-KE
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 15:33:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qw66f-00040y-55
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 15:33:27 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QItouK025495; Thu, 26 Oct 2023 19:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FK5jZM0084bzjzz9JpiVk5P2Xy8TV3Ss/AU/9q7+m50=;
 b=driMntoSyWr+SiYFr6Jf6KS01sN52cRGw1ukjvFfD+Qyd0FkqoYIZdB+2f0wqE92CiMv
 PapfqMjkY1vMLCtDrxVn2EwqFt3R72rnlpjVmlOswQ37ILgQ0mtB9aLNw7XYTq0z5pqK
 JlwEVKWpgOOUz6KaOuJpUlYUPqvEOGFwVNviQI28VmodxawPzI3rhlBLZE+SsTpaTlvi
 SGs/xYWoRIXukWhaCscM6zb04WAWWzXf5nWp/qXMJ8j6kxC1WfanjdRPijaVCxXwe2Qi
 xDLjoUVSLZD7dfeKgil37A7BnrCiWEJAUeDRj44Jjp7xtpiUtCOzjZrpLECM7AxMZUlM Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtt02j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 19:33:22 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QImm03022868; Thu, 26 Oct 2023 19:33:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqhhkhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 19:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4Ko56jxd7l5ezRVmPSht9k+nrPpLjedzJHESe2AjAMMCHgKEwsKV+MPm4UTDneDHAain85toUdyzGUOyo2zoHfByclWS5uRtHJ4Dy7mIRnq/O722quDfBC45l5+5hM7JsHsIbSwD5Oih6c7bUaYjLzjMYQCafjFMxSAL5yw9KP9dQB4l1ClCD3ye0HUrVl76QmSLnyTaxesm4v1jU/pbV5AAaifDWHyQQWeoF2xaCi165uULeHUEn3CHqgVR94WGLSCpl3rIcDPdG9LmfFkC4At3N+luCDacPf7tie7F6/LLF2f4d1bb8JE+JrgGzjroq1PElI9Mchn6DwLozdOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK5jZM0084bzjzz9JpiVk5P2Xy8TV3Ss/AU/9q7+m50=;
 b=SrWJlrmrJVC0fsJq0VtxAcw1AwHjUwGM7VNYaxahkOODYmu42TnwHunqr4vAJmIHC8vyO8FQZ+nb8zQe8l9CIs2AVstnUWNErbxLFk2NWGZqVD3mv3f2y8W0MYHgGeOnF4CLaCSkYlfltpMrn4yHwleOxq/oOcbCrPEEk6HQp8adKcltECP9i9ClTmgxxU0kypV8yzSAfnDVX4CuMjol/S0QZCjh4cXSsLDcu1GlskYWfWc5f34E69XbZdb+iLwFQQ3FcsGRoVt5aTls4TziLEmFuimX6x0ainEmtUSwmwYf48Rk4L3KRPK6ljZIONfYLB3smMc4cH7sPacNONQMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK5jZM0084bzjzz9JpiVk5P2Xy8TV3Ss/AU/9q7+m50=;
 b=DuUT0y/qa7d2ZY4ynublz8MnWYFV7i7StPlGIr6FrjFd0KFp7D7ASeqw9+fyoQv6saCVumHSlZ9dwKtjEDUTha8b9U9w2zURPk4CBI7KVwVbFzbQfhW5Sdd17ANmr3J0KoFd+VaenEVgvPKzGAj9K1oleGI49n369s2/MlVZLEQ=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM6PR10MB4329.namprd10.prod.outlook.com (2603:10b6:5:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 19:33:19 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 19:33:19 +0000
Message-ID: <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
Date: Thu, 26 Oct 2023 20:33:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com> <ZTqb/XDnwhkTUL3s@x1n>
 <ZTqtieZo/VaSscp5@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZTqtieZo/VaSscp5@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:205::48)
 To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM6PR10MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: e932a2a7-1ce1-4691-6381-08dbd65a6856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1EZ0Dlh9DzW2Tnr+pMpM7RTwxIODpk1r3KlLMhfesRsYyyU8lJoz08QixQuxg0NeX+CyDvbwgtjM8H8xw+FXU/ZR4+QzBPo0M5ajNBxbtUvwWLsElsj37Yj1WjtK42h4IK8uHWbhKYKj96ngcRA3j+1OOCrSYINkgpLU38Pn6TInQb5/GYocw3JqUufVVFJ0nomQ8VQsOOJAo2OSIupEqHRcZhzxtkGhhsGOmO0/Rbn3hs0RYn0yIADtpuYaQLT8Q7JRsIh5lQvNI6sc/7HSpk+qv8DZJCy6i9evFd27LBnYtQGo6nOK+V+ClbkTFEO4iicXeHCu/ZAPwrB8S9GfApBiAkBwoVGp4Ii7NZtgKzpJ+K+oBNY+wKoD7omNFq+B/mbcwUvL4Dljregt0XQjKoJoMf0Uz9/qQo2PBEe1lOtiw2M2ZzPrD4PrGWD64eZ04vZPbMEBzTwdePOihIl2ZSLdWQa3qOsV3lnKXpXYVAmgvBEAeH3BNddot/Kb4YiWS2ne4PWyP2FBgzaXlgApp1fYreLGmOV8b/3XO7qP88YEIo2uc4MDs3CwowmQzQPXpbSZX5G6kSs+6zY8CNCx9FDgs8yIVebcxhczPszwGZSqXJ9+i+xiJmsDXUaBu6iULi6n7Y30IrJjNDz1dlrFAuK5LzUYMSDGKo8ng+UvGTRnkMDZSb9Ng9NdwQ8YdOX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(2906002)(53546011)(2616005)(66556008)(31696002)(6512007)(6506007)(26005)(54906003)(6486002)(966005)(66946007)(6916009)(6666004)(83380400001)(38100700002)(5660300002)(4326008)(36756003)(41300700001)(66476007)(316002)(8936002)(8676002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1pRd2FBdTJZKzVDKzdUVXVJMGVuYXBFYXYzbG4zWmd2QTBPL3FtWEJrVFFF?=
 =?utf-8?B?ZU93V2NMNnJtcEhQMGZDczBlWk45ckdxSThKc0taNG1sWTJMaFRINFpwZG1N?=
 =?utf-8?B?clZkb0hXaXR1aVFub3duc1kzR2hPcFlCZklTTytkWkpRQ1VrNDZORS9vcCs4?=
 =?utf-8?B?b1R6NGNtbjFZSStweDdQOTJpaVNhRnV1WTlYcm40Mk5MVkdlY1Y1QUNTdHRv?=
 =?utf-8?B?bzIzOU1QSWhSeXdablYrd1QvcmxSSlZoMzVwTjh2bHIyWUthQWppKzBMaU1h?=
 =?utf-8?B?R21tRkk4cm1TYWJjTE9CL0hXWmdEeDlXODF1ZDUyUGJZQ1JFZE5md3p1Vjc1?=
 =?utf-8?B?andESk05U1NqRGdCdXZNNzJsZGFtUlo1K0JKTklBOWMwc2NFcWdxcE1pTU1F?=
 =?utf-8?B?UHN3MXZmblVMQWpiSmhpUFNPeW9yZlZIdXAzNk01WGhDaWQ0STNERGpsRysz?=
 =?utf-8?B?NlFXSHMwT1NlcHkyK2FMa2dNMTZoVjRTb3g4NndLd3JEQllFODREanFseWtu?=
 =?utf-8?B?RHprMlZqUktTMHAwR0E1Q0FzZFR2YXBmVHMzaXk1VzVVTGhRUmw4Y1FmSjR1?=
 =?utf-8?B?elNjWTM5cm9rdGxIcTFpSUJabzRKdll5T3ZBS2hUR0ZqZ29nZnBwL01RQ2Nu?=
 =?utf-8?B?V0QzdFhyb1hFTithVzVwUjIxMEw3TTJoa2VMMUJYVytLTVlZdUpwcFpoTGFi?=
 =?utf-8?B?eDYzNnQ4VVNlUXkwTXBVNWdSS0ZQaW9vQWI4S1lGSVdMZHZaUlRJMFhLYTVX?=
 =?utf-8?B?Um9TMUM4c1lOblR3QTlxQi9nazkvMnRZanpGVGFYMFhtcHBLM3ZPbTU1dkYy?=
 =?utf-8?B?K0tvMXVJQllYQUM3SktwWnVyY0xrM2dtcVhOcTVmbUc5RGxaYmZnOTZwSm9U?=
 =?utf-8?B?L0FNdi9sdE9DeWxjTE02RkY5SkFhU3hsczNtTnZHY2V3TWFzanNLSWVJdGo4?=
 =?utf-8?B?aUNJam9BNGltMkZveVRQdGE0VkVZalkyVGF2UnJzVXd5MGtMQ2JQTmw3YUd4?=
 =?utf-8?B?dG9sRFdSUERoT3AvM1FkcTdvbjBSOWY1dTBkVE5QcWoxODJUVEk2cEtBTC92?=
 =?utf-8?B?Sk9ML2lZcDRhN0pzVDBra2g1RGZYMm5aancyZWFRa3UwUkhoaVhIWmM5SjQv?=
 =?utf-8?B?VlhuWGNUYktBbDluWW1ZQzFpZlpFclEzdDlIcU1XVytmdjB6cW9LLzR5Snh6?=
 =?utf-8?B?OVJmdkw4UWRnQ3JRRVBXcU1vZDJuS1ZwUk96MjFscVdSRmw3clBFTURQNUhU?=
 =?utf-8?B?SWJpL2l3NUkvUnJlNi9HWktzbmlQa2JIbTJGSlNvbjJSbzFwNlZicDJWUXlK?=
 =?utf-8?B?NmFnSWhLYzBDKzZxaWdLUlpDUld3UGRxYXRhWHZDMVZUTmxEK0VjOG8yNXFI?=
 =?utf-8?B?RUpnbkFtUUoxMGNoVSt6YS9CeFk4c0FNSkhleWhEZHc3SDRSQzRxZDhOWDNW?=
 =?utf-8?B?NnlDYmlyY1hxME5Pd2V1bVpVVnU0RzY1dHlUTTRpaDVnYVlTR3M4UGxCVlQr?=
 =?utf-8?B?NTI3d0o5bUxSRkF0N3p1eGdpWVM3L051cmFIN0pzWThPSE90V0NzVGFPN3ZQ?=
 =?utf-8?B?NWVNSmFOYjFHYWNGeVVLNFZnQXBhNTg0ZDNzRndHMGJVbXRCS2F1MEw3Zjlp?=
 =?utf-8?B?NitvZ3d3VlVITExFQmtuUmdYUU1oQTVMSUpiL0l4SWZqK1puay9ibVhRRlpD?=
 =?utf-8?B?VVRUNlBBRkkraTBkZ0FYNTY4cFI4YTkxZmozVldDaVpLZVJoZ2N5TzJhUVVD?=
 =?utf-8?B?VDFLbmRmellJSFlnc1VERjg3MEJaUUp1R09KTTVVNkdjaFFST2Z1bXhWaktT?=
 =?utf-8?B?VlFXNTJFQzdOWVhNT2NGNytRVTdMYXdqNGVCU3czN0grZlhreFptVjlXMHlF?=
 =?utf-8?B?SXJLbDBNZFQxOFA3MVNhcHREeWpaQ0Rhb2Fhbk9GM0tMa05VamV2Y2IxS0Rs?=
 =?utf-8?B?Z28vWGxuYjJlSUF6bnNpZStveWxnMVVvWW5CUVdTUER5b3lKb1FYNkprRFFp?=
 =?utf-8?B?eVRLMDQ1cVRMdHFFS1poZU9pYVVJYm5ZaWxxOEFiR1h5WXpoRzJDTFZPL2pn?=
 =?utf-8?B?M0l5UmR3UnRwUGpJcDRTcGxjalh2cEJiWGFLYi9oZllpWUFabktiaFhuY0ll?=
 =?utf-8?B?UEl5TE9FMnlVUlVDekpMbnFuWkJxUGNnOC9oL0pLZWowemg2eFhIQTBwZ09E?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZwVjaKSAqwXESzLkl6DOlZgjKY/C+3d3J7iHcnS5SI9yhvbFzQv+f6/iNJW5cb+BFSuYvsMriOxqnovwfxEI/pp1HHCWL0lUTTomL9xdUhsRdoWheo9D1nsSwmRPjv3I+DWkV6pMCJ1L6GLNl1ZkrS9rc6OgfxsQ/vlotGO4IsF/3bI4n5+c4gfitJIDK/rIk/G4T7uYvEKVxJNaqDSfl5l2pFmY4Uk7VSXvBuHQWrtjnenRNzCmM7TFTdelZjjaPZee6pLYYwh2Oi7YA0Pa+RwoZAQMgIxrGATbeZwbNb6uelAic/ewAe5KQjbpui7WGKcHT5+/hfb5V58kLRyr9PKKbRl1jzh73M1z4CjnSOToMI6YHnVNfpZw3aV1CjshljRCv5RLOSYKdlH5ppR4TtdKaun6CksPWaLWCiFtH7HEGecDwIXLVYcvpSKOsCGuG4fnCh7A3awiHEceA4WxyMLEANtQiaG19sX03jV+G4vUEUhGk1Yrd9/RR0gzavnHsVAIX/80fNNXHrxhOTA45yFhrIWBBycmb1m/05ek2L9zuai1qp/or99p7tu91SNGuS1x58u8BrVLcregRtsf0cMND4Wr7toEOawwtAahvf5DmwEoo4XJ1Q/Mrh7ZmQrNv0jOkZYs2FCgML5zfHsWcOgeWDYK+unLY1LtF5wh2Ul0vWZllJjBzSGDifkXwopKGCOtwSYUkEtwl9woYNiazTeNDTSQaEQVRTHOiZzUBg37EJwojxmiypdOG2c8gAb3PhQ3Q+1Koty38euwHbu1bdBIYVAf/NEcfr/h9c/nxoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e932a2a7-1ce1-4691-6381-08dbd65a6856
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 19:33:19.0822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSuSx71ufkoPobjX963/do1YK2hGm6qZz3FdBgl9gLqPnQep54Y8Ds8+9QqlkxmC8z7rIFkOCXeRI9EPQftGQzQxgcivLGJO0qeVKTZIPLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_18,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260169
X-Proofpoint-GUID: soqWZqcJcHaH4QJ8y-0ajV_qFG_ioGeV
X-Proofpoint-ORIG-GUID: soqWZqcJcHaH4QJ8y-0ajV_qFG_ioGeV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/10/2023 19:18, Peter Xu wrote:
> On Thu, Oct 26, 2023 at 01:03:57PM -0400, Peter Xu wrote:
>> On Thu, Oct 26, 2023 at 05:06:37PM +0100, Joao Martins wrote:
>>> On 26/10/2023 16:53, Peter Xu wrote:
>>>> This small series (actually only the last patch; first two are cleanups)
>>>> wants to improve ability of QEMU downtime analysis similarly to what Joao
>>>> used to propose here:
>>>>
>>>>   https://lore.kernel.org/r/20230926161841.98464-1-joao.m.martins@oracle.com
>>>>
>>> Thanks for following up on the idea; It's been hard to have enough bandwidth for
>>> everything on the past set of weeks :(
>>
>> Yeah, totally understdood.  I think our QE team pushed me towards some
>> series like this, while my plan was waiting for your new version. :)
>>

Oh my end, it was similar (though not by QE/QA) with folks feeling at a blank
when they see a bigger downtime.

Having an explainer/breakdown totally makes this easier to poke holes on where
problems are.

>> Then when I started I decided to go into per-device.  I was thinking of
>> also persist that information, but then I remembered some ppc guest can
>> have ~40,000 vmstates..  and memory to maintain that may or may not regress
>> a ppc user.  So I figured I should first keep it simple with tracepoints.
>>

Yeah, I should have removed that last patch for QAPI.

vmstates is something that I wasn't quite liking how it looked, but I think you
managed to square a relatively clean way on that last patch.

>>>
>>>> But with a few differences:
>>>>
>>>>   - Nothing exported yet to qapi, all tracepoints so far
>>>>
>>>>   - Instead of major checkpoints (stop, iterable, non-iterable, resume-rp),
>>>>     finer granule by providing downtime measurements for each vmstate (I
>>>>     made microsecond to be the unit to be accurate).  So far it seems
>>>>     iterable / non-iterable is the core of the problem, and I want to nail
>>>>     it to per-device.
>>>>
>>>>   - Trace dest QEMU too
>>>>
>>>> For the last bullet: consider the case where a device save() can be super
>>>> fast, while load() can actually be super slow.  Both of them will
>>>> contribute to the ultimate downtime, but not a simple summary: when src
>>>> QEMU is save()ing on device1, dst QEMU can be load()ing on device2.  So
>>>> they can run in parallel.  However the only way to figure all components of
>>>> the downtime is to record both.
>>>>
>>>> Please have a look, thanks.
>>>>
>>>
>>> I like your series, as it allows a user to pinpoint one particular bad device,
>>> while covering the load side too. The checkpoints of migration on the other hand
>>> were useful -- while also a bit ugly -- for the sort of big picture of how
>>> downtime breaks down. Perhaps we could add that /also/ as tracepoitns without
>>> specifically commiting to be exposed in QAPI.
>>>
>>> More fundamentally, how can one capture the 'stop' part? There's also time spent
>>> there like e.g. quiescing/stopping vhost-net workers, or suspending the VF
>>> device. All likely as bad to those tracepoints pertaining device-state/ram
>>> related stuff (iterable and non-iterable portions).
>>
>> Yeah that's a good point.  I didn't cover "stop" yet because I think it's
>> just more tricky and I didn't think it all through, yet.
>>

It could follow your previous line of thought where you do it per vmstate.

But the catch is that vm state change handlers are nameless so tracepoints
wouldn't be tell which vm-state is spending time on each

>> The first question is, when stopping some backends, the vCPUs are still
>> running, so it's not 100% clear to me on which should be contributed as
>> part of real downtime.
> 
> I was wrong.. we always stop vcpus first.
> 

I was about to say this, but I guess you figured out. Even if your vCPUs weren't
stopped first, the external I/O threads (qemu or kernel) wouldn't service
guest own I/O which is a portion of outage.

> If you won't mind, I can add some traceopints for all those spots in this
> series to cover your other series.  I'll also make sure I do that for both
> sides.
> 
Sure. For the fourth patch, feel free to add Suggested-by and/or a Link,
considering it started on the other patches (if you also agree it is right). The
patches ofc are enterily different, but at least I like to believe the ideas
initially presented and then subsequently improved are what lead to the downtime
observability improvements in this series.

	Joao

