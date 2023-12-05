Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763C48059AB
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 17:16:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAY4d-0003Bo-PL; Tue, 05 Dec 2023 11:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAY4Y-0003BW-7t
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 11:14:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAY4V-00079R-RZ
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 11:14:57 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5EttYH026297; Tue, 5 Dec 2023 16:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gVduLUlCqsKD7lAU4P3SuxMlO6k1huKSPSdK15B0/3g=;
 b=fkmXUGj3PVSR2nj7H7hH9gxCs0M9tHq8z4PhXtIr6We5St+64v8n4Kj2W3nUYHt/4Ka7
 EHjEqQjsHlJCdL7hvN2WDd+fK0UOrakGAjKyyVg1Z+1L5a0BHcprI5xU+eaSk/Ab3tdF
 bYzgn7XpPWQpjNCX4wXwMlmLEq4H9K23Gr8x+DACGRB93vxQ5Y9YUFd7G5I07BgeJrP8
 IN5VPiWGoSftV/a1HAhCa5AJlET84hvy6oFdUaMkewp+HK3hZhIhRj1TNfIeeV5YWYDy
 7fQqli2ryxFnzix42hGKVC1B6fcwyribTSUF0n016FP444mJwJ609oK7I//K9eUNHvYW Tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut0xw92ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 16:14:52 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B5G02ad018603; Tue, 5 Dec 2023 16:14:51 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu17p868-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 16:14:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIDlZmDppP6SN7r621BpONDaCeT3/48ABI6bVUcbq5L1WKBY2FlfdHC2YToycf3xc4b7tdfJZf5AAaToGWbdynu2JWui8E6Dafr6eLXFVbGe/WfJQxjIHW/29x9NK4GBOxWyBs3xjyssXpmFeO5QukDCPes1r2vMViOgP3M6zPvTKQIzVhhSWCqjU3PH646OVutKtdUEBbD2pwBtVFszGzygPUtoJGmnbtiFMlsQ4V6B8pFkpCRMWRkOSdJRfvjns+XH6+xc3EybhkI5ZfhG28Trb5GiJJ/Hsjji/GdL+2lNYZqFIg9wrNWhQJ8YD4sHNpXynWjAlGVCe8Je/HGhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVduLUlCqsKD7lAU4P3SuxMlO6k1huKSPSdK15B0/3g=;
 b=Ak00fDifRPmUSxSzHLFSj27Vcknzsqie8wIQIFJIY09NnCczAGMk5cd4N2Uk2H74eujMCjtOkLsoNIcD8i6mHljglajil20sPU4291IYogk9MAfVWazyi6Q+TooEVdUB5ojuAtkhtyPLj00m8/KKMtPTuBJ8hGFt1rzbTwbr/nPmv6/MSWxRk0Z01/OzdKJvDe9XHReEhOJLGgzGr1Q0jSajW7rHa1KIXtN6e5C8bAuTFIYLzMWyFjU4FWfOtkFzkT7CR1zGYzXCkc8gb0ClvNE3DtkzHAoKG4iqmbNA55ZqYvChdTh42TncJc6fD6/j2mixqVOXZzjyV/Okzcwwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVduLUlCqsKD7lAU4P3SuxMlO6k1huKSPSdK15B0/3g=;
 b=BuqvBdKJ/ehldh3YOrz909OuiBCHHpRxyzsfieh/89kInDgx2XcKUXmc8Mb5q8ZJUofhXt1m6/Syalii9bOWQ+i9WX9zOIg2C/gJopbtp0RZplicsWsOY03DniKOg5qTDWAVhZtHKthmtOGJevEV+Zi7v++TUk0u9xmAT+R/jdw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 16:14:47 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 16:14:47 +0000
Message-ID: <22e3574f-9fb7-48a6-b5d3-0a016a93a804@oracle.com>
Date: Tue, 5 Dec 2023 11:14:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 11/14] tests/qtest: precopy migration with suspend
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-12-git-send-email-steven.sistare@oracle.com>
 <ZW47TYtPP5uLNKsa@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW47TYtPP5uLNKsa@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: deba5f32-23cf-4efd-2678-08dbf5ad4d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHcM3yE3fqaBgFZ6vMR25ssYonq3q1HZc+m4+2nSk0flP19SL2KIoy2EHLgirHgX5S4qQKm1nQULm6gPeIt4QpPiPZIqOxRPDoVCcK+XNxMLKPoR98lv7l+d79MbA0YHICFKL/TwMs0JIwjLjWV1/I4QhBsM3MOq/phwgIiarSdW5vmI+n3Rt7Ho3W3AOvnABbI5RwVSizPX0ZOq2fWezjG4Ij84fqqtY7mTvM3+/Pqc3ViQL44BxRULcRD60NbnmbcHUjargF0oUnsLIk/TohnmFTMYCmyJARPdSj+UY7jsA+jN6WLXfS7tTJUZAslMyqX3bhcOnSEmq9ju6DsU3UNxQEBxYdgfHepajKNNGAl+SUII0TqBb78x59Daht/pWSQO9sL3eJ6e7zqP3O72xXiWqkAkySfoQ5fMJxADJ/DPah3MUTyp8fXffZaukJRo6i91wKCBTCEbbt681Jju+Uv7ScAy+UJinVukCmQkYMIIDxnFr66QsZrOWJD/1OThwprwW3xSD6k4WBrTclNGy/qzd6isEwlTi2pu9YRxeU3IcdL/oZEqfJnwgGOVJEymfIA5nNRy8YpgpGTi2vid9Sm1owfyetEkqhOEwBOZJYYnE1NnFxhrqilIfeA68TVfpfIkJ52Ju6YdwFG5OMQaBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(26005)(31686004)(38100700002)(15650500001)(5660300002)(83380400001)(53546011)(2616005)(6512007)(36916002)(6666004)(6506007)(2906002)(41300700001)(478600001)(36756003)(6916009)(6486002)(66556008)(31696002)(316002)(54906003)(66946007)(44832011)(8676002)(66476007)(4326008)(8936002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGZPYkxIdU5RUDl0SFEwbjJZMnEvdXo1QTNJSk5OUkkzQW9HeGNGWHBJd2VL?=
 =?utf-8?B?TUUyNXRTU0F0cWtyY3VqLzdWcVJGaWFMVHZ5U3l3akZ2cXdDS0ovV3VUN3V3?=
 =?utf-8?B?UnpDT0pvY1UwQzJ0T2VnNFFGZE9ubnZ2dWxydmtRR29sRzNENWZWMWtKanlW?=
 =?utf-8?B?UVJXQVo0VUQzL0tEZXpaK0hqZTZibHlCQkxsSENjKzlZVk02VUlONEF5YVFO?=
 =?utf-8?B?bGhqZjR2VmQ0cC83dS9Ub0Z0UFB2cTdmSTZFd1czNWJqODA1d2RPaFdnZGxU?=
 =?utf-8?B?TERHT3haV3hHb3d6VXZ1V2JBMjdGbDNkNXpmcjZYM1NpZW4yTXkxWWw4dWto?=
 =?utf-8?B?cG1ZZEg0aEZzWDVWa3J0aFFzd1hncitmT1dPQjc1ZlhvL0xvT1cwZk5OZk4v?=
 =?utf-8?B?VmkrQTltM0pReWJDTm01MHVzS1pJU0NzZVBjVWtramt3SnZ1ck95blY0REoz?=
 =?utf-8?B?T2NtUWxxTXBMZXplUEQ5YTM1b1dFb3NvVWUyNTNSMkUvNXArU1hmTzdFenA5?=
 =?utf-8?B?K2dhTGF5b3h3TnlqbStZYVdwS1pHbzgyNGtzNEJBQklZYVNrYngrOFR0OUdK?=
 =?utf-8?B?K3BmTjlleVJWYzYwM3JLZ3R1MHpiS2pUcmFQeVBPSFd5b2tPYU82WEh3WGg4?=
 =?utf-8?B?d2haaEgzR1VZR3ljVEpKd3lxckVraGxVMlZVdkg0ZjNxbUsrTTRDL2JWSGNB?=
 =?utf-8?B?djZvdTY1eUJlc2w1Yk05ZkdRbFI0TW03aGFQWTBid0k2MUw3clh3YzFINzJr?=
 =?utf-8?B?ekRKNlkvVTJ5dGN0eU5GK2JmcXU3YzJnTEVGRFFaaVRrT1VhN1lKZEFTTTN0?=
 =?utf-8?B?TGwvSXg2bkpadFNkT2p0OWhaMWwvcEtIaVpUZnBIMlRpMS96NkN6cmdXc0VV?=
 =?utf-8?B?R3BpeVA2N2ZodG1YakRha3F1c05aOWovbjMzd1ZxWEZydXVqQkNYSUFoMkV0?=
 =?utf-8?B?STV3UklSVnczQTB1NDhKbm8rNlFrWktKdDY0SGh5eTFmNlBXaWNEbjRNay9p?=
 =?utf-8?B?dEltd1Y1R2pjQjM3bk5nRUxrWXhrdDU2cmlxV2ZtNDF0NzJsQXlHM0hDbXF4?=
 =?utf-8?B?UElxSVZwYjl4a3pIWVVHWVczT2FYMFpYZUdMZHBlK2FucklIYTYvM1gwK0VX?=
 =?utf-8?B?OC9GUDdjSG8veXB0WkNYdFgrelVkWFB6WFFrZmQwSFJ5bTZnQ0RTcFI1Q0RF?=
 =?utf-8?B?YjNBa2x4RlRYN2lzU1duYWN5QkU3NmpieXZodDI3YndHQ3VaLzFOajVlMHNx?=
 =?utf-8?B?M2VJSUI3T2pGUWhqdE1lck1KVlBTNHVDUkJWQmh5RDIyVGhIWjhuWkxDblFt?=
 =?utf-8?B?Z1lNYVV0R2pTdndtWXdZNWJFeHQydnBza3IyMXZnRjFFRm9BU2tQUFR1R3V0?=
 =?utf-8?B?VjZ4Q1RtcXZOZXV2bEVJQkNCKzBvOTJuOER0YzE4bW1hdm9ST1hIY1NnUHlL?=
 =?utf-8?B?U2cwTUxpSXQvNHM2YmlHWlcxZmFNL29BQWRvM3ZjdkVoalBmM2EvbUF3dzNw?=
 =?utf-8?B?SGk0NEtNa3k5cnJPeHVoMXRJenJwZWlnR05OSEJJc3EvUEgvY1BlOERVWFBX?=
 =?utf-8?B?MkxDL0VJelpXMTUzVWFqYUFxaXhuOWtnZTNVL2l2NjZFT0RJbjhqMDJFZVNJ?=
 =?utf-8?B?Mm1GZnhsRTJOay8wRmx4KzNQaDJRMVo0RFdyS2gwNzlyTkFNQjVVYUsxK1BT?=
 =?utf-8?B?WmRyQ0VIMGNrSVF2SW5FMFdOdnF5YkNiVzBrL2lVMTR0cmwveHVQNytWNS9W?=
 =?utf-8?B?dkNwY1hEODU4R045N1I2UDF1RGhGd2F2bTY2Z29sMHp3TVBUN2Rxdyt6QVBz?=
 =?utf-8?B?bjc1ODNyRGsyWWxNZkZKSzRWU1l3b2M0ZW1mbUZjblZsaXVEbHhjWHpnc0s1?=
 =?utf-8?B?YVlMQTYwUFdjQ1VoQlVTTU1PNHljOWNKUW9KVFg5c0FsQ3NIc3hkZHpVVDRp?=
 =?utf-8?B?LzJjRVEwN3c4b2R6Zlk4OS9CLzJSSTNJbGYrMlF5MGpCQmZEZFFmNE1jd1FJ?=
 =?utf-8?B?RjlhMS9kVXVBTFdwNDlQcFByQzFGQzhNZlVWSld2NGM4UFdhYUtscTd6VnAx?=
 =?utf-8?B?a1VPbzRVTUQ3T3Q2NVNNZVBpQU9rL1NBWG1UVndacVhyTU52eFdjM1pWWjVH?=
 =?utf-8?B?aC9NT2xNOUczZXVzeGJFcGxSTUtZSmJwZmFGNTMvYkxBKzhqVXdYTzY3M3hV?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IXKapdj7xAmZDsn23zwluYmpQWOZ+cO8w+gH5KRT0ZXr5nPCfelRPQnFhZ+gHLV/nNFwS/RnXc25jgKA0TuJuRZMknyqhvLZfB6Elyp2bE0mQhCK7TwWbSMwEXnafxEF/9AHeE6SOMa96U1CKNiYQnS6sxH/bPtUmrB+N24WxioYG3QsQRUyYt9y3udwfql+v93BVUc7SKVLV/s/dKfywncZQHZ2NdCkBUVUWNXYa16IJYq+RUx4H98ywJOV0nJUOUmkKozhV5+ctzVaWql7VkZjMmOMQO5/LuEafrQFnFBXDAFunc6+tA7TgmTIS5peSEHiGIdX5rO4ZP89XCOnNyBDWR6yXUDGZBH8fFPIxqpj3DocmfWW0iaetzgELLFkle4bP5nFTHdBQMSMtAgW5HY6V4wSNm1jP7L9qPRsfVgUETfsesfkV3C58XAKuXF4i6O1O/mTeFd7OdZgcbzDmS09v1IILcM9y6gWoyY+YH2F/ZvmwUDNPISrf1bi5pC8yYscIituz0+TlkceCtckYbjxfKhS3gpNaGoTV7qDSBdAPQ3m56ejrU1gAu2v6xrPesLYIwhXQbUSrNgBbDGdv+1jX3PASq/P7gwqEXmYz/u9NF/b5/AiCY+VzJJZ2T1NE/47yjfqI5Yl+M7Y1tLK3WLWMFv/Wv+VNUBg2DpBn4u8QC+uqXVZ4bllEjnle5tjAG9eW/GZama8AYYnjcO82F4YvbVnkrj+gEBnnh2NgrPHaGx8HOI6pqFrb0zsXEQyBZhUkFHf4MuSb1HPRGcxdrPHQFscMnr7g/7nCEn1ywY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deba5f32-23cf-4efd-2678-08dbf5ad4d3f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 16:14:47.8620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/fSS+br+iwZflvXISfceiussCxRY4dLosQ5MPbixQPlLc/prPBuwq8ctPimE3R/qz/YWlW16LBqLzxPJL6vQow2VW1b/XFv1YC0Cwxt3Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_11,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050128
X-Proofpoint-ORIG-GUID: 4a5qaiVX5t13Ka9yJeX3LYOtZbgvHZ_t
X-Proofpoint-GUID: 4a5qaiVX5t13Ka9yJeX3LYOtZbgvHZ_t
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

On 12/4/2023 3:49 PM, Peter Xu wrote:
> On Thu, Nov 30, 2023 at 01:37:24PM -0800, Steve Sistare wrote:
>> Add a test case to verify that the suspended state is handled correctly
>> during live migration precopy.  The test suspends the src, migrates, then
>> wakes the dest.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  tests/qtest/migration-helpers.c |  3 ++
>>  tests/qtest/migration-helpers.h |  2 ++
>>  tests/qtest/migration-test.c    | 64 ++++++++++++++++++++++++++++++++++++++---
>>  3 files changed, 65 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index fd3b94e..37e8e81 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -32,6 +32,9 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>>      if (g_str_equal(name, "STOP")) {
>>          state->stop_seen = true;
>>          return true;
>> +    } else if (g_str_equal(name, "SUSPEND")) {
>> +        state->suspend_seen = true;
>> +        return true;
>>      } else if (g_str_equal(name, "RESUME")) {
>>          state->resume_seen = true;
>>          return true;
>> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
>> index 3d32699..b478549 100644
>> --- a/tests/qtest/migration-helpers.h
>> +++ b/tests/qtest/migration-helpers.h
>> @@ -18,6 +18,8 @@
>>  typedef struct QTestMigrationState {
>>      bool stop_seen;
>>      bool resume_seen;
>> +    bool suspend_seen;
>> +    bool suspend_me;
>>  } QTestMigrationState;
>>  
>>  bool migrate_watch_for_events(QTestState *who, const char *name,
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index e10d5a4..200f023 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -178,7 +178,7 @@ static void bootfile_delete(void)
>>  /*
>>   * Wait for some output in the serial output file,
>>   * we get an 'A' followed by an endless string of 'B's
>> - * but on the destination we won't have the A.
>> + * but on the destination we won't have the A (unless we enabled suspend/resume)
>>   */
>>  static void wait_for_serial(const char *side)
>>  {
>> @@ -245,6 +245,13 @@ static void wait_for_resume(QTestState *who, QTestMigrationState *state)
>>      }
>>  }
>>  
>> +static void wait_for_suspend(QTestState *who, QTestMigrationState *state)
>> +{
>> +    if (!state->suspend_seen) {
>> +        qtest_qmp_eventwait(who, "SUSPEND");
>> +    }
>> +}
>> +
>>  /*
>>   * It's tricky to use qemu's migration event capability with qtest,
>>   * events suddenly appearing confuse the qmp()/hmp() responses.
>> @@ -299,7 +306,7 @@ static void wait_for_migration_pass(QTestState *who)
>>  {
>>      uint64_t pass, prev_pass = 0, changes = 0;
>>  
>> -    while (changes < 2 && !src_state.stop_seen) {
>> +    while (changes < 2 && !src_state.stop_seen && !src_state.suspend_seen) {
>>          usleep(1000);
>>          pass = get_migration_pass(who);
>>          changes += (pass != prev_pass);
>> @@ -595,7 +602,8 @@ static void migrate_wait_for_dirty_mem(QTestState *from,
>>      watch_byte = qtest_readb(from, watch_address);
>>      do {
>>          usleep(1000 * 10);
>> -    } while (qtest_readb(from, watch_address) == watch_byte);
>> +    } while (qtest_readb(from, watch_address) == watch_byte &&
>> +             !src_state.suspend_seen);
> 
> This is hackish to me.
> 
> AFAIU the guest code won't ever dirty anything after printing the initial
> 'B'.  IOW, suspend not seen() should not be called for suspend
> test at all, I guess, because we know it won't.
Calling migrate_wait_for_dirty_mem proves that a source write is propagated
to the dest, even for the suspended case.  We fully expect that, but a good 
test verifies our expectations.  That is done in the first loop of 
migrate_wait_for_dirty_mem.  After that, we must check for the suspended 
state, because the second loop will not terminate.  Here is a more explicit
version:

static void migrate_wait_for_dirty_mem(QTestState *from,
                                       QTestState *to)
{
    uint64_t watch_address = start_address + MAGIC_OFFSET_BASE;
    uint64_t marker_address = start_address + MAGIC_OFFSET;
    uint8_t watch_byte;

    /*
     * Wait for the MAGIC_MARKER to get transferred, as an
     * indicator that a migration pass has made some known
     * amount of progress.
     */
    do {
        usleep(1000 * 10);
    } while (qtest_readq(to, marker_address) != MAGIC_MARKER);

+    /* If suspended, src only iterates once, and watch_byte may never change */
+    if (src_state.suspend_me) {
+        return;
+    }

>>  }
>>  
>>  
>> @@ -771,6 +779,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>      dst_state = (QTestMigrationState) { };
>>      src_state = (QTestMigrationState) { };
>>      bootfile_create(tmpfs, args->suspend_me);
>> +    src_state.suspend_me = args->suspend_me;
>>  
>>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>          memory_size = "150M";
>> @@ -1730,6 +1739,9 @@ static void test_precopy_common(MigrateCommon *args)
>>           * change anything.
>>           */
>>          if (args->result == MIG_TEST_SUCCEED) {
>> +            if (src_state.suspend_me) {
>> +                wait_for_suspend(from, &src_state);
>> +            }
>>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
>>              wait_for_stop(from, &src_state);
>>              migrate_ensure_converge(from);
>> @@ -1777,6 +1789,9 @@ static void test_precopy_common(MigrateCommon *args)
>>               */
>>              wait_for_migration_complete(from);
>>  
>> +            if (src_state.suspend_me) {
>> +                wait_for_suspend(from, &src_state);
>> +            }
> 
> Here it's pretty much uneasy to follow too, waiting for SUSPEND to come,
> even after migration has already completed!

Agreed.

> I suspect it never waits, since suspend_seen is normally always already
> set (with the above hack, migrate_wait_for_dirty_mem() plays the role of
> waiting for SUSPENDED).

Yes, it played that role.  I will delete all the existing calls to wait_for_suspended,
and add them after wait_for_serial("src_serial") in test_precopy_common and
migrate_postcopy_prepare.

- Steve

>>              wait_for_stop(from, &src_state);
>>  
>>          } else {
> 
> IMHO it'll be cleaner to explicitly wait for SUSPENDED when we know
> migration is not yet completed.  Then, we know we're migrating with
> SUSPENDED.  In summary, perhaps something squashed like this?
> 
> ====8<====
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 30d4b32a35..65e6692716 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -605,8 +605,7 @@ static void migrate_wait_for_dirty_mem(QTestState *from,
>      watch_byte = qtest_readb(from, watch_address);
>      do {
>          usleep(1000 * 10);
> -    } while (qtest_readb(from, watch_address) == watch_byte &&
> -             !src_state.suspend_seen);
> +    } while (qtest_readb(from, watch_address) == watch_byte);
>  }
>  
>  
> @@ -1805,7 +1804,12 @@ static void test_precopy_common(MigrateCommon *args)
>                  wait_for_migration_pass(from);
>                  args->iterations--;
>              }
> -            migrate_wait_for_dirty_mem(from, to);
> +
> +            if (src_state.suspend_me) {
> +                wait_for_suspend(from, &src_state);
> +            } else {
> +                migrate_wait_for_dirty_mem(from, to);
> +            }
>  
>              migrate_ensure_converge(from);
>  
> @@ -1814,10 +1818,6 @@ static void test_precopy_common(MigrateCommon *args)
>               * hanging forever if migration didn't converge
>               */
>              wait_for_migration_complete(from);
> -
> -            if (src_state.suspend_me) {
> -                wait_for_suspend(from, &src_state);
> -            }
>              wait_for_stop(from, &src_state);
>  
>          } else {
> ====8<====
> 
> I didn't check the postcopy patch, but I'd expect something similar would
> be nice.
> 
> Thanks,
> 

