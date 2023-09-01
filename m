Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414E5790227
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc93R-0008DI-Pz; Fri, 01 Sep 2023 14:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qc93O-0008Ch-Eu
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:39:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qc93L-00008c-Mc
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:39:34 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 381CApT0008040; Fri, 1 Sep 2023 18:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Nvvv4TnNtjpThhLdH/Ta53EOKJYsnMutDHgjMGDb0ic=;
 b=kwubtRKNHcZejoWFfHLN9M5gb/D+tcWFKt9hP7ZpIfAvVpSjnI3Vznt7GeiD2RNbGr03
 lvbJm4XRFQixh5zZHFreuPQKyi5W6t4Jq37z12WsP2BYTcbiadJolMVOrun6Hu7dfvvg
 0avoGInL3WnvwN+G0m5bKzLhma9bLFKelGEDivj2Rjy5y+jpvnl34a6Sr2MXTGnrjijn
 IYqNYhgyxWVI+ulpGQXP/EocyeWHAs/OgRJfG1lCC87ugpmBLAgEQPoE3BJyB03F3vME
 p+XWK5ETZwf7x2I/vJZMWAEVAQOddjIFD7blu2WgwIXE8sKtkOJMNdPwg/AOkBwQP8yP Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fkcmy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Sep 2023 18:39:28 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 381Gqca9024348; Fri, 1 Sep 2023 18:39:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dsnetk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Sep 2023 18:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJfe0fbX2afSXAtec89zxY9YYF/5t10L13QMG7Kppyd/W/vIIXEoRLxaVwdLX2ycDAmZx39E6oPTldIKkI+TZQe5Fm6JWqgwTEsH0kQATzkGIxglZzQKaHqUn88IvT411tFLNor6DJ3J9r8+//XVSbiVSZNTJZ/R9/wLYS9Wx7L0roOBeQk7Lq5tgE6sqSBaalyw2/RftdoNNfoXi6V6gKkCIxaN0Z3qfixJRk13ZAFohmP7Dl/EqG+rwEF+HhS3nCdEteGqrrkIPbq6cagnIN2568Ng0xg2ldPVKJmon1ucb7bSNh1XTXCRDB8h1QMNJL27QzJuh/BOKRcTRVY2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvvv4TnNtjpThhLdH/Ta53EOKJYsnMutDHgjMGDb0ic=;
 b=VLnMvdMQIDVH7/nbzZN0ewqhjUEIVZzOjR2KUS/wIfHu6NN38lbljz1lXlb66KD6Tl9DrBgI83Y0OtklxFd06Gn0mwGBUvaGKPnu8/D00MEUikXU+5HtHuxR6sE0fPTD3aEgz1YGTf4rY+7G7L28CjGyyf0Wpe6qrL0QFh7geODzmclhrL8VFdIzXlVN+RfF5UhVbrMTaFSksrTnzFuRSLryRVUBGUH0iepYic8mHUe36FU8sNUUgBTjIUcdFpj+CYGL/efkm2WLFfj32gyykx/aAYeL3yQ3t8jIYxuhK+SDMzhWYZ4fKZU4QnX03Q8KkiBG+YPBsupYv+gS1hpQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvvv4TnNtjpThhLdH/Ta53EOKJYsnMutDHgjMGDb0ic=;
 b=n4JUnS8Z2Xwt6+06zCAjmEIUVAFyN4HmcOl+5rxCT1waGx7jWAFlPBSHdhzIX2qvNgIoHVH8bO51K1yYalst5SX6MVKxRUBc8wZwwkuA8u4LWatWouI/Cccp7P3n9FKrIbwNXRKs5eYyA/UXKSl5anqMMM8eEFspB/n2sBC9MeA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 18:39:15 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 18:39:15 +0000
Message-ID: <ec2f4daa-f094-a1b4-107c-509e21aa4553@oracle.com>
Date: Fri, 1 Sep 2023 19:39:07 +0100
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify migration
 switchover bandwidth
From: Joao Martins <joao.m.martins@oracle.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Zhiyi Guo <zhguo@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, Chensheng Dong <chdong@redhat.com>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
 <2f53f68e-7876-9cb1-4804-82fa08116aad@oracle.com>
Content-Language: en-US
In-Reply-To: <2f53f68e-7876-9cb1-4804-82fa08116aad@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SJ0PR10MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: e8233ff9-b51f-4fb8-2bd8-08dbab1abdb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JC6zPEudEqObvxmd9AMwgzdwq5daos+tvdimqQExTcLlojFS5hOEI3pAzxQzKoXi3fRYo/Nfl36X+tNeCrowl1nQakNh8SBJBi9LP5kqhYWRPxPneNQWim1JYXJYhtHm79KZByTj0ACbrgdGn7uG4RlYPGHtltI9vZ7G1xOsrghmJpYF15SVBhtsy8GB53erQKgZo5JH/gvvvCHRp28tKRcGpjO6rd25iXayrkHNazF1dn4evbPPkzs8PN8cZ25soxeUo5dSrnw8st2xRfh1FOi+s09Gl1+cSKjzA63kFBY08RisID0fvP7xsOArmQVgM1+CfIQB+Izqt7oV3kSjhNNnsJdP6/EeBO5eZCpFP4nxlWwlqrpNQFmTUFPRWH+w8ATy94vcLh2aFznzZ16H39Tz+0vDKHNRM76NyBcoCAjmsz+Ra/qgRN7n2kWi87rbsEnTVU0eFO7Ax17DtEtrrvsl5pM2KVI0spPdDNyCi0h4GwfAboN/8/5SI92BT8ph3mereYlbheyKnLBMbfJJFdS99VKUWgfshUT1D4c+WgTORSHyho1H3xejPY40Q5MhmEEoSq22sEaJkaOi8IuZzSdX5qd8XD/zNqCVXItsaT/X3rintcJkKAWutJhEV/m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(53546011)(6666004)(478600001)(38100700002)(31696002)(6506007)(86362001)(2616005)(83380400001)(6512007)(6486002)(7416002)(26005)(36756003)(66556008)(66476007)(316002)(66946007)(54906003)(2906002)(5660300002)(8676002)(8936002)(4326008)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEV2ZlhmczZPWWp5SUNqVUZkNkRBQytXWG4rTGZFcThONm1tRVM0b3ZmTUp1?=
 =?utf-8?B?eWNQTkZxZEl5eWV2SFF5R0RnUXZFK3cvdVlWaWs0QTEyL2s1VC9jVEpoNDFQ?=
 =?utf-8?B?cmtYTi9yZG05SmJodVYxelpQNFhiN1lYZ2lMUC9sbWEvYmdiYXlTUjI5ZGli?=
 =?utf-8?B?bGlJeXhoTU9LaytyMFRSdnB6a25qNjhPTzFtSTFCNUtxQmROWi82Q1g3bjdh?=
 =?utf-8?B?RWFrUTRUdzc4SWs0aFdQQ1pQLzgvamJpV25Eeks2RHRGUGdBTVd2bmdyekZE?=
 =?utf-8?B?YU1CRWppZG9XY0pscXRMcjBNUkgxcDAyUTZYcXZsemx0Vmp0REM5RGpOdEpw?=
 =?utf-8?B?OVIwMjV5RG5TZkhBQ1VvRGpYb1lEK1ZLQjBiVThFWmxPdVd2T3dXb1JkbEJp?=
 =?utf-8?B?Zm5JamtoVHNmdUtPbk43ZTNkRkJsQ2c2dnh2elRHKzRmSFJtdi9VYnBCN0tI?=
 =?utf-8?B?SDFIOWRZbmhhTVdBSVFuWHpVTXd5b0tHK1lBVFFQTjBKbnQ0eGFwK2MxZVRt?=
 =?utf-8?B?NDZCU3g4SXp2YU16bVp5TEpNOVlMQytUOTJJZFZNeTN4ZEwra2tjVnUzNk94?=
 =?utf-8?B?L25oU1htMkk3eDVtRHJBdWdJNFZTWnBoMjdiSWUyZldXZzZmeGdyTUhxcEFL?=
 =?utf-8?B?SEhmRjcrSmpEL3o1M3ZEUGRrQmFaS1pNNUl5WHoydEFOcnI5RzhZWUhJelZ6?=
 =?utf-8?B?bVhqYUhoTERLTHlYQlFWNFFGNkFkdElzeGF6TDlHV2x6N0NIK2gvT2Jta3Jm?=
 =?utf-8?B?R1NGVWcrN2VaaHc1Z0ZaL2FOSy84ejhZYm9tK0RINlRVWkpXNERma3RCMTZh?=
 =?utf-8?B?SFM3SEFpTEY5bEs4aVhzWmZpOTRNeCtUVUttQnlJMU5XL1Jqc1J2MllxVVo4?=
 =?utf-8?B?OHliTVYwU2VJOFY2NnEvTWJPWGJPQ2xqd0lqR2RNWTkyVjBjaEgrcmRWUG1t?=
 =?utf-8?B?VVZLbHJ5eVJ6NG92SDZGZHRDV3NEME1rM3A5RXU4cTM3ZEdUbkwxTkFTS0lK?=
 =?utf-8?B?WjUrc1JrQkd2WXV2MzBiR2JVWXdXam1WaXB2dHdDUkZCMjBqekZlMjVISzlX?=
 =?utf-8?B?UkU0MnFxcC8wVERNOUhCdjd5ZmNGc05welRqc1haQlk1YlhzWTFQdnl1Q2dH?=
 =?utf-8?B?c2lhWGQyUTZFWVBsb1RZeFlDRUppdUs5clRxSUUwdFFQbUJNRGhSY0JjeUU1?=
 =?utf-8?B?WGxGK0Q0REJsRmZic3lNeXRXRHBmdWt3YzA2NVJoRTB5VG4vYWpDbUk2OFRw?=
 =?utf-8?B?U1JRWllKSi9CUCtpdFVuUTZnNWhib2lKaXk3blhQSWtYV0lBclNnN1d4Uzlp?=
 =?utf-8?B?eVB4aDluY0tyQzRZUnhuTUkwZWdEbWZFYkRMV0J2NnBNZHJDTWFaT053TUJ3?=
 =?utf-8?B?all2cTRvaXRLUzZPR3BtTVBOMlEvTlNaaEh2VnI3MTlZdmN0KzJoaXg2S1Rm?=
 =?utf-8?B?akdTUi8yL2pmM0lDVXFDaVRIZE45Nll3K0E5TnhzZHdLZm1xazVvSTcyd3dx?=
 =?utf-8?B?UXdVMWNTK24wSmljbUNLWFlzb3V6K2ErdlQxWHgrcTRtVlk4OERyS1VQN3pU?=
 =?utf-8?B?dHFVK3lvd3VLSEw0cnVIaExpNVFRdzVxK0prdHh6L2dnNTdHcEV2cSs3Vjd0?=
 =?utf-8?B?QVdqVWxTcWQ4NDV3Mnl5TzVmSHZoYnF6eG1QWXZ5NDRDRW1xNFlUVWNUK3Br?=
 =?utf-8?B?L2NqUlFsSFBKQ0ZnTExhNjV3S2puS3dlS1pyL1RvcWsxWmI4N0ZNb1dXeUx0?=
 =?utf-8?B?aVNXcWtKeWEweFVYeTdTbVVycktIRUh2SjJpdjdwbGwwUjV2UkpFRzMydTBN?=
 =?utf-8?B?ZnFOT1JGN3N3UlE1dTdHUHE5UkcxRmNBeXNDSDloTmJLSEJBZEx0cCtaa2xS?=
 =?utf-8?B?MlZyUXYvMHk0TG1WZUFNZXhtQjdLZW9TZnNsdlJUaWVGUHpoSy9ocDhGZkVj?=
 =?utf-8?B?N2JwMmtVSnh5NzVzZ3B3ZTlpL2pPSjdwb1JabmFQN0J3Tml3dlB5c3BoNXZx?=
 =?utf-8?B?bU9vSlM5MFYzcFZibm1yRElRSTNQTkNrN0VTbDF6RDQ2RWQramhzLzJtYTFq?=
 =?utf-8?B?by9WM08rdlRqdlkrQ2dmdFVBU0pSZzVqeXNQZy9mN3R2TkFhK0oyR3h1MDhh?=
 =?utf-8?B?QXpXYjVmY2U5MnN5QjNoU2x5VmFOZ1V5UE96aHc5QzRIRHBxa0w0c2dkYUJF?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tSwhxUTEqnTnT7u0BPQnF4m+zp74mSS5WDCBoau2y9834SaJBz3g8OW0+6Cg31iVDA12yFkEQLm0QMIKsoPjz4WJBXYShcNr14y4oXpN26W30maEBvkdUaRMrRIY8mTHcHzGOFBskNsKc6qKXwCXkUXGn+s7GuxhrNMA4SWQQepxlqwMTaSka5WmFSi0pqdmYGdr9VHcYFDBZXcm9JedEnDN88eHQxrQeXiYZ+SJiL7nbVfpvV9gh/j4qzh9LsTbHcZDCaRH94cRGPMIGOu/AeOxGAvVtc1/2ja4JZx8edoF1wunhJdu3D1VF5gyJeSpVA5VSZAXWIR49e4DEFGoWLvKW5HILR3tgoIoCHMVkMMZi0vcQHNIl8q1By+xPjGg6x4c9f6sD0GTfFHJhoEMd6INLHYxq522kVl2G9TpbK2MplZlsBMW9HeaaiSVmiyNZTYnjFDMUclJUrEyB53zWUbG/r5olOCotEdUox/mj4pBqhjUUsofjdaHF6i8HxuyjUSLWjFKLgtPioLSQ5lVigeo3f6J5khGGIQzOyLF8B7YB3te1DRSbUp3QupyAyCp7agOjJfG8mOBvvJIk18xm8qgQVJwQThatYvO+V7tS0MztanuCF6wZpQamJIV0hdzJwYGQDBA9GnZl+OLqARAgPfo5Dn1nb+duwbc3TdI8JhOF/o1PdElQldPEhkxXPtDGxoNjezrwx1qP/E+fhB1KlYXX2B+aZtg1QaHoA9Pf7Hxkng7jQLAHUpt0PSiLqdg+6yadkGFQ9sREq9BClbECqMFC2bXanT1fBsdco0lecs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8233ff9-b51f-4fb8-2bd8-08dbab1abdb1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:39:14.9512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjzCHwLx8JqC7C1AxRUHrWUbnw4J8IGB7tEyi5Zxew+7dH7qnz3dmtMuDkRKDXR+iaqp7vjSNTZkll9go3APkkviZA+FmP9CRljS4TpP2Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_16,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309010175
X-Proofpoint-GUID: gD-5bCJoLLUwhUyd_zghhslMiB5NpsT0
X-Proofpoint-ORIG-GUID: gD-5bCJoLLUwhUyd_zghhslMiB5NpsT0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 01/09/2023 18:59, Joao Martins wrote:
> On 03/08/2023 16:53, Peter Xu wrote:
>> @@ -2694,7 +2694,17 @@ static void migration_update_counters(MigrationState *s,
>>      transferred = current_bytes - s->iteration_initial_bytes;
>>      time_spent = current_time - s->iteration_start_time;
>>      bandwidth = (double)transferred / time_spent;
>> -    s->threshold_size = bandwidth * migrate_downtime_limit();
>> +    if (migrate_max_switchover_bandwidth()) {
>> +        /*
>> +         * If the user specified an available bandwidth, let's trust the
>> +         * user so that can be more accurate than what we estimated.
>> +         */
>> +        avail_bw = migrate_max_switchover_bandwidth();
>> +    } else {
>> +        /* If the user doesn't specify bandwidth, we use the estimated */
>> +        avail_bw = bandwidth;
>> +    }
>> +    s->threshold_size = avail_bw * migrate_downtime_limit();
>>  
> 
> [ sorry for giving review comments in piecemeal :/ ]
> 
> There might be something odd with the calculation. It would be right if
> downtime_limit was in seconds. But we are multipling a value that is in
> bytes/sec with a time unit that is in miliseconds. When avail_bw is set to
> switchover_bandwidth, it sounds to me this should be a:
> 
> 	/* bytes/msec; @max-switchover-bandwidth is per-seconds */
> 	avail_bw = migrate_max_switchover_bandwidth() / 1000.0;
> 
> Otherwise it looks like that we end up overestimating how much we can still send
> during switchover? If this is correct and I am not missing some assumption, 

(...)

> then
> same is applicable to the threshold_size calculation in general without
> switchover-bandwidth but likely in a different way:
> 
> 	/* bytes/msec; but @bandwidth is calculated in 100msec quantas */
> 	avail_bw = bandwidth / 100.0;
> 

Nevermind this part. I was wrong in the @bandwidth adjustment as it is already
calculated in bytes/ms. It's max_switchover_bandwidth that needs an adjustment
it seems.

> There's a very good chance I'm missing details, so apologies beforehand on
> wasting your time if I didn't pick up on it through the code.
> 
> 	Joao
> 

