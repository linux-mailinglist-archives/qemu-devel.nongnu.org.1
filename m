Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9262D7D18F0
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 00:15:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxlE-0006Ve-Gw; Fri, 20 Oct 2023 18:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtxl8-0006VK-TN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:14:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtxl6-0004Ty-5r
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:14:22 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KLDsaw020907; Fri, 20 Oct 2023 22:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9ejCYRfahG7Qwxc2uBM89iLbMVN1ZZJ0nliV12VMwLg=;
 b=GoG4P4hTiAuo/wpzbDgbnZ200TD+09kblLEmcTeG/5Xz9rjJo06OSNDLkagknXnGAM4F
 DOmOsCvTqEBM1XQGfFy/aXnzDEAwtCvkx3mccJEapHRLaTMrEe9w2xui16keP121m1T2
 CFPXxSar/YIIIJHad0g1uarbkIrs4v/el1qDlLarQ6/pyfgynlc73dvGLPnQ20Czosid
 DuJ0HtDc+IavFij6TP/rDmYZqYLZub/Mhym5Fi+D4SRNYwEtAhAVTs6DkxarNTORmCWX
 BpixuPTeqePercAPOBz/8qmgbuCIlwn1kP+UZ16lcYF9DTl0Fz1K25qjd3nkXWx+9fmq iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwc2t5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 22:14:16 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39KLb4Ec038507; Fri, 20 Oct 2023 22:14:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tubw5b6qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 22:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfyjHOSZ38zeHyUj4ikYwGT733Ns59mrj8g4s/xuT30hmKq5lk30V9glKGZBq2bbQ0f5VFuYL/Yy2gCU8l59d0b+9dnFPdwaTgBgK29C1Eqa7OYk75iXyTjZwWS6aZJT0sSXIAMUE6S0ZdbYaiOndcCxWC/doniaj1rnsVIfqg5t1vgP/l7dQKKUZ3AkwOOeC6Hkd6uGhBjamxsAS2rkcCFY90k23+hCnVUvyJojdEAZiZTQfgf4skEhH/1V865o+1qAi6+TsMa9c+va5aRPBlO4WsjAGCWwTwn4SqxZJoEhsqG2OLO39n39h79RmkOnNDrbnPNnwv7IVzSWLgZ1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ejCYRfahG7Qwxc2uBM89iLbMVN1ZZJ0nliV12VMwLg=;
 b=UMI0ZqOL1p39U01FyGIsRpTXb3/6zbHdnm++lIrJbncMJVZNom8oiqN9XJ+z67QXYlckOs58fsg+rlRuxlrX1oEFmU2zBV1wU0vczo6apN7c7WuQ1NuH+7ROuc3peruib0+/qBNRHzYiOAErUNDQDJtKmlMciwpaombzalS/y6iq4bPXyzOwTE8n8A1a8NsEhPLO/6Zg0GUALmtY9Hv+VRBvwIW4sbFBIk8Uf9Fk2vFVtgbVnYLgWkxTrcpVgL7HrvsSJKVrpq+X71/aNjdHjik5EyCGWLT75xesUPJ5U2Qiw25UDkjcbeFgUc5QYDALQd7k2skWxzFqk8fsf8yM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ejCYRfahG7Qwxc2uBM89iLbMVN1ZZJ0nliV12VMwLg=;
 b=Fdopd5akS4m3AyF/jLL08ldKcW4N32ulr5cwAEzdXVxhRcDS33PbYfuUeWr/RmsVWu5d5Duhx62ge7ygMMDqt+Z2QiMFWR9eVwsxCjjZ33F1l7vsMFbt+xlOIEu9WT7LvOPOPO1uQ0lz+6GPrsFLjnrSHuJxhPRVdCw1oosqbh8=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB5564.namprd10.prod.outlook.com (2603:10b6:510:f3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Fri, 20 Oct
 2023 22:14:11 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 22:14:11 +0000
Message-ID: <d7b4beb7-b0ad-4732-b344-afcaefa46983@oracle.com>
Date: Fri, 20 Oct 2023 18:14:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/4] migration: mode parameter
Content-Language: en-US
To: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-2-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1697748466-373230-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:806:125::6) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e849916-d6eb-47a1-9a62-08dbd1b9e2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMZWrTm5gFICun3ebQBQYAr/hD8DPiS39JbOjPFd2SS9yCeaO1CJNU/6kE4Wz3uSS97TiUircMtGKyuu+VT12iFxp7j0GqsCBLz1EIxj8fHX9mqb9ZsvFoGyzRCl9jDAuR0NORI+cAuc0gDMMW7MiJjFigb0iyUtYFfcOfR3pieTOH42Cdzw7tPzNLeu9KUb01mc6bkkFIz3bnBxePFOB9hx8O7bmz73URLHkJ7cqWxifEaaWsyvwU0M8MfLHry0nI/QQsWHzVM2d+lDX9vGaVNea8c/EgmEMWAhuXVNtSpAN/WqCJY6heSMy6aA0w4sedlBlR49SQLZLozqpId8pmZvXMqKuE8rSGt02x+mcRlrWUieCST4/vn0mpOtGqZ49PlrJdskwdPkpV3WHLAk0amq44SocvHx/JzAq2Bt9j8V3cSsNzI8NR7yBojMn14D6Q009MISMMMvKEhofxeifVLm9GvRLTDbun8v0ge5O0g2jd4L7NE4dMkx5AxdRHYgntWalHFbRqYhxzo0pjbTz1hQstxpAq9VtYeiez0FutVdhKF2IvnioTIsydviQPxe1rDHuXrawpzsCVG+ygxvlVoUMEao+i6k7AvwlGRHgY87oTGL+Paljjmetjo7MBwZQhJ35oPQP3tIZKLabpau0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66946007)(66556008)(66476007)(6916009)(54906003)(316002)(6486002)(478600001)(86362001)(31696002)(36756003)(5660300002)(8936002)(8676002)(4326008)(44832011)(41300700001)(83380400001)(6666004)(38100700002)(2616005)(53546011)(36916002)(2906002)(6512007)(6506007)(45080400002)(26005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytFYmVMUytDdUdJRW10TE1GUkFNOVhvNWxOVXVQQUdlRFJORld2cjhiQ0lI?=
 =?utf-8?B?SmtjQ3VoREcwTGhuakU1RlQ3SmtocHlaSkwrTC9pUzhaRVZoem9JRWIvL2Jk?=
 =?utf-8?B?bE5VVWpkdGVwSTF5dm5LTE5wMkxJbG9RbUluU3dGdDllR2lTSk1PMXluRWNq?=
 =?utf-8?B?VHNMZHc5UnJyUzNxUEJhOVlRQTloVDhZKy9kbktPd0lUZVlML3V0MGp4bmhJ?=
 =?utf-8?B?MkxjT3dBeHBGR1d1MTNLcVJLRENNdGFZZDN6bjVsODd3RTRvZ2YvbEFJQTYw?=
 =?utf-8?B?Vk9MdzhyZ2o1Q1drclhVYmFRMnJXejBLUHN4c0VPMm1wZkhVdHVHN2krcEF3?=
 =?utf-8?B?QzM0WlZpTDk1MDY5cVBETTV0TUJjUFRsM1dmUHRmMURPckQ3UlpMWTlnRjE0?=
 =?utf-8?B?eUluTFV1ZDZCN2hlZ2xzV20vN21Fdk52Q3BpTmt1eUVGK3IvOUpRN080NHdw?=
 =?utf-8?B?bHBNblpUWC84a2lSYjNhNEsxYkM0OGRVbnh6OWxvSElTWmhzVmpldXp6TGR0?=
 =?utf-8?B?RGtqNmxQUDNiRjNPckpoMXkxYnlxaGNBTGVmTmJMTm5BaDl6a252NzBiaXRE?=
 =?utf-8?B?bTYyOUpZS3pDc2dWaFlhZFFtL0pxbFJHdXVzWkxuZlNiKzRpL3BEMEhQMk0w?=
 =?utf-8?B?U3l6K3hwMVFENXdFNTJKaVJ0VDMyYmRwU0dJNGk2Riswam0yeklnZmxoOUZI?=
 =?utf-8?B?QTNsSllMMWgrS0J2U2ZoK1dsZGVkcCtvN3Ztc2dTWDFrMGF3bXZ0SE80TGdN?=
 =?utf-8?B?OGxOSyswSXlOWFpKMkNkYm1ldHdhK2JwdGk3SDZOYTEzYUZVdmgwbzJUT2wz?=
 =?utf-8?B?b1NZNjlIdmtkTldiWlRqTkxpdW9pWjhtdjFxQjUrNUR6VGhNWjVIYnQrOWVU?=
 =?utf-8?B?dlhzWnFwNFhkSGs0Zmh1Wi9wbHpKV284eEtoUmZ3T2lUNThkL1JEdUR2WnRs?=
 =?utf-8?B?d1ZYRHZzWlRZRitXalo1SmtJWXREOWVxN1BxZC9IZmtaYlQ2S0EwRXVBamdH?=
 =?utf-8?B?dzBhc3FZeisxNlZIWFZMQmF0Q2oxcmw1VXl5dUJhdTYvaEZDaERJenRTRUN4?=
 =?utf-8?B?dVpWYS9xYnJINGlZTTNHWXZ6UEtveTVhQy9obGRuNFhteHFCZllqblJqcjhV?=
 =?utf-8?B?MkF4QUFZVjBMTWtFRkp0d3pua2FLa2V2TXkvQ24vRmVRZ1ZuMUVjVDZwazFt?=
 =?utf-8?B?MkQ3MEpoWVdYdTRBc09zNGZhS2l5NXltS3Z6dENFeDhRQlhTSHRwQ1RaUVpy?=
 =?utf-8?B?ZGQyQng5VVhqTE5aV09qUzFVZUVUSUpQT2lRcC85Ui9Ua2hhKzUwTFQxdEF6?=
 =?utf-8?B?SUREazY0MFE5WDRFeXUxc2pxY05QbGlPbGtJbkhKdGtDZkxrZDdUcVdKZUU1?=
 =?utf-8?B?V0NmTGVIZi9zalUvbFE3ZlZRaVFzZ2Q5S3hzNVF2N3J4YnpiMEQwTTF4V0ZN?=
 =?utf-8?B?NzNnVHU4MjhnK0hjV21pZ0VLdEhyQUlTUUszLzg1MXh5Y09Ld3N6dFJxV3do?=
 =?utf-8?B?bGxNVm9EalYxSEZUNU9XR3FLeWxMUmxRSG1HUUcxb01udUFzNDBFbDVMNVpt?=
 =?utf-8?B?TmhRaTNiYmZOMW9lQTdzQXJ6RzJHMWR3d2djakNpaWgza3QzUitKM1piQkdo?=
 =?utf-8?B?emI4UHgxOUZJZ1lGb1lTb25VbzVJL0U0Rmp1TElmeUJZNDg3SEZpaitSYW1M?=
 =?utf-8?B?MnI5V0w5cE1ycGFobURBWHROb0ZwcTV3OG9jU2xYNmlTVTNkT0VRei9OMFRk?=
 =?utf-8?B?NUc1V3JBVCtXNGlicjNsYVg0Z3lsNU9FWVlodi9KT0t1WllHc092QSsxSE5k?=
 =?utf-8?B?STFkdDlPRmxGMG9ibWtGa3dENytENlE0U0JrSTBLNEQ2UE85NUlPOFNtbkNm?=
 =?utf-8?B?d3dWUmJNYVZEd0lJbkcyb0IxK3JTTUJCakdOOExMNEwyVkFBYjNVRXRqWEZ6?=
 =?utf-8?B?eTB2TWhPT2FsQUNObU5Ob2tOT25MTk9abENRWTlLUm5QWUZqbC9MOHpFb3hR?=
 =?utf-8?B?aFdiazExSHZlNklFMEVtR2ZBbXc3SERFR25aL2EwamhuYi9NVGJjUTR5Y2xh?=
 =?utf-8?B?dENFTEJUTTg2U29OUUMyQ1FWTTZ2S25PWXZCQnJ6aDA1cTBONnduTS93VEtm?=
 =?utf-8?B?Y0VPU29nNjFHcWZEUHE2NmRIZTFYb29QdzVDR2tnWk5sL3c3dWllam8ybkJJ?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GPyjI46s9hWEuS5ZxuJiRsDE97Fl0BwFPtAHPuLKa6rKx8N2klxa7rpuxrPLcrxNHw9WMbjw0i7qKFeLDzxpaLNzqYuEkeCrBWTZR3gmubBEgSR0Lg8hrMbTWnBCV0ogJK2d0bB0Dep+Lq4AbNHd1fneXlbshkqJHfO4EcUauSWFG4wiYYYzYIcPJswXSaWhP6MxlLBIqruO7Pdd1rfLHRPQhRNBWcQYBLNP4hH/i9+VrTCsUSlmvs40JqHqVgyDhqQfPzMbJla5aM57taXuznQ8gPQNTUOKvxZDNBchi6+24esaCmGnaDcFJ/eIp/jZX/pTugcQUjYcPkb3yThE2hVhNcdURrrtAPHAQM5bLgnWgTlXxHucnYUSZuhiYx3n4V8862W+yo2roPoJ5d9l0P4ftIvby1NdpXD49TjsHDmKbW9rC3+VPXlXIgNkVDA2Q/Zhv0vMowqu/UcHTA+5MJeRaboFM/kyQ9WYGlIT8VlGo0K7Ssj8pOXQA+Ofn5iqdFa7HXX4H2rxUbWaL40om1I/KJc8i1FOjIWPAkIYOpJEtDtAr3auvn7SIvxB53DD3i2+kp+Kb51wZ7l3s4EfqJR3D3TgMj6AtIqsQfQna92EHVxzHrn8DkfHqkUR766MF0WBfbahjXU6A/1TPQulCo8xgvOp1vGpre5T7vXBuyT0xxvp/osXi9sZv+KvIbPgO+tYP5IEUs+nn71JQ94Ek/vc6g3jBAbz2oGamKXQclitdMrZnw44Y1JEsD5zXGWUxFA1r6IeZ49SsVnnSXO1esr5bZC4EKOqkjbcN05lOj4mxI0+UIxaCRsT6RUtZtM3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e849916-d6eb-47a1-9a62-08dbd1b9e2ed
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:14:11.3423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0iRYAvS8lmYky8RDjU5AfVy6vbZJ4P6yDCGSHp+yVy7OlTi0BZhdTsmo7YYEWFEdXEMbWdufqPSbt9KS4q83t8yIBoc1qrEe8DEoAG1TBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200189
X-Proofpoint-GUID: 7PgW14ifr49hBfSJjC0PU93V2Wv7R5nI
X-Proofpoint-ORIG-GUID: 7PgW14ifr49hBfSJjC0PU93V2Wv7R5nI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Daniel, does the addition of MigMode in qdev below look OK to you?
It exactly mirrors qdev_prop_blockdev_on_error + DEFINE_PROP_BLOCKDEV_ON_ERROR.

I realize I need to add:
    QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
and I need to delete "exec" from the .description.

I will cc you when I submit V2 of the patch.

- Steve

On 10/19/2023 4:47 PM, Steve Sistare wrote:
> Create a mode migration parameter that can be used to select alternate
> migration algorithms.  The default mode is normal, representing the
> current migration algorithm, and does not need to be explicitly set.
> 
> No functional change until a new mode is added, except that the mode is
> shown by the 'info migrate' command.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/core/qdev-properties-system.c    | 12 ++++++++++++
>  include/hw/qdev-properties-system.h |  4 ++++
>  include/migration/misc.h            |  1 +
>  migration/migration-hmp-cmds.c      |  8 ++++++++
>  migration/options.c                 | 21 +++++++++++++++++++++
>  migration/options.h                 |  1 +
>  qapi/migration.json                 | 27 ++++++++++++++++++++++++---
>  7 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 6883406..c6fd430 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -673,6 +673,18 @@ const PropertyInfo qdev_prop_multifd_compression = {
>      .set_default_value = qdev_propinfo_set_default_value_enum,
>  };
>  
> +/* --- MigMode --- */
> +
> +const PropertyInfo qdev_prop_mig_mode = {
> +    .name = "MigMode",
> +    .description = "mig_mode values, "
> +                   "normal/exec",
> +    .enum_table = &MigMode_lookup,
> +    .get = qdev_propinfo_get_enum,
> +    .set = qdev_propinfo_set_enum,
> +    .set_default_value = qdev_propinfo_set_default_value_enum,
> +};
> +
>  /* --- Reserved Region --- */
>  
>  /*
> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
> index 0ac327a..1418801 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -7,6 +7,7 @@ extern const PropertyInfo qdev_prop_chr;
>  extern const PropertyInfo qdev_prop_macaddr;
>  extern const PropertyInfo qdev_prop_reserved_region;
>  extern const PropertyInfo qdev_prop_multifd_compression;
> +extern const PropertyInfo qdev_prop_mig_mode;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
>  extern const PropertyInfo qdev_prop_blockdev_on_error;
>  extern const PropertyInfo qdev_prop_bios_chs_trans;
> @@ -41,6 +42,9 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>  #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
>                         MultiFDCompression)
> +#define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
> +                       MigMode)
>  #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>                          LostTickPolicy)
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 673ac49..1bc8902 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -15,6 +15,7 @@
>  #define MIGRATION_MISC_H
>  
>  #include "qemu/notify.h"
> +#include "qapi/qapi-types-migration.h"
>  #include "qapi/qapi-types-net.h"
>  
>  /* migration/ram.c */
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index a82597f..d8ad429 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -274,6 +274,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
>              params->announce_step);
> +        assert(params->has_mode);
> +        monitor_printf(mon, "%s: %s\n",
> +            MigrationParameter_str(MIGRATION_PARAMETER_MODE),
> +            qapi_enum_lookup(&MigMode_lookup, params->mode));
>          assert(params->has_compress_level);
>          monitor_printf(mon, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
> @@ -514,6 +518,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>      }
>  
>      switch (val) {
> +    case MIGRATION_PARAMETER_MODE:
> +        p->has_mode = true;
> +        visit_type_MigMode(v, param, &p->mode, &err);
> +        break;
>      case MIGRATION_PARAMETER_COMPRESS_LEVEL:
>          p->has_compress_level = true;
>          visit_type_uint8(v, param, &p->compress_level, &err);
> diff --git a/migration/options.c b/migration/options.c
> index 42fb818..4f26515 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -101,6 +101,9 @@ Property migration_properties[] = {
>                       preempt_pre_7_2, false),
>  
>      /* Migration parameters */
> +    DEFINE_PROP_MIG_MODE("mode", MigrationState,
> +                      parameters.mode,
> +                      MIG_MODE_NORMAL),
>      DEFINE_PROP_UINT8("x-compress-level", MigrationState,
>                        parameters.compress_level,
>                        DEFAULT_MIGRATE_COMPRESS_LEVEL),
> @@ -867,6 +870,13 @@ uint64_t migrate_xbzrle_cache_size(void)
>      return s->parameters.xbzrle_cache_size;
>  }
>  
> +MigMode migrate_mode(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.mode;
> +}
> +
>  /* parameter setters */
>  
>  void migrate_set_block_incremental(bool value)
> @@ -911,6 +921,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>  
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>      params = g_malloc0(sizeof(*params));
> +    params->has_mode = true;
> +    params->mode = s->parameters.mode;
>      params->has_compress_level = true;
>      params->compress_level = s->parameters.compress_level;
>      params->has_compress_threads = true;
> @@ -985,6 +997,7 @@ void migrate_params_init(MigrationParameters *params)
>      params->tls_creds = g_strdup("");
>  
>      /* Set has_* up only for parameter checks */
> +    params->has_mode = true;
>      params->has_compress_level = true;
>      params->has_compress_threads = true;
>      params->has_compress_wait_thread = true;
> @@ -1206,6 +1219,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>  
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>  
> +    if (params->has_mode) {
> +        dest->mode = params->mode;
> +    }
> +
>      if (params->has_compress_level) {
>          dest->compress_level = params->compress_level;
>      }
> @@ -1315,6 +1332,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>  
>      /* TODO use QAPI_CLONE() instead of duplicating it inline */
>  
> +    if (params->has_mode) {
> +        s->parameters.mode = params->mode;
> +    }
> +
>      if (params->has_compress_level) {
>          s->parameters.compress_level = params->compress_level;
>      }
> diff --git a/migration/options.h b/migration/options.h
> index 237f2d6..d9ec873 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -92,6 +92,7 @@ const char *migrate_tls_authz(void);
>  const char *migrate_tls_creds(void);
>  const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
> +MigMode migrate_mode(void);
>  
>  /* parameters setters */
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index db3df12..184fb78 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -616,6 +616,15 @@
>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>  
>  ##
> +# @MigMode:
> +#
> +# @normal: the original form of migration. (since 8.2)
> +#
> +##
> +{ 'enum': 'MigMode',
> +  'data': [ 'normal' ] }
> +
> +##
>  # @BitmapMigrationBitmapAliasTransform:
>  #
>  # @persistent: If present, the bitmap will be made persistent or
> @@ -675,6 +684,9 @@
>  #
>  # Migration parameters enumeration
>  #
> +# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
> +#        (Since 8.2)
> +#
>  # @announce-initial: Initial delay (in milliseconds) before sending
>  #     the first announce (Since 4.0)
>  #
> @@ -841,7 +853,8 @@
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> -  'data': ['announce-initial', 'announce-max',
> +  'data': ['mode',
> +           'announce-initial', 'announce-max',
>             'announce-rounds', 'announce-step',
>             'compress-level', 'compress-threads', 'decompress-threads',
>             'compress-wait-thread', 'throttle-trigger-threshold',
> @@ -862,6 +875,9 @@
>  ##
>  # @MigrateSetParameters:
>  #
> +# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
> +#        (Since 8.2)
> +#
>  # @announce-initial: Initial delay (in milliseconds) before sending
>  #     the first announce (Since 4.0)
>  #
> @@ -1020,7 +1036,8 @@
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrateSetParameters',
> -  'data': { '*announce-initial': 'size',
> +  'data': { '*mode': 'MigMode',
> +            '*announce-initial': 'size',
>              '*announce-max': 'size',
>              '*announce-rounds': 'size',
>              '*announce-step': 'size',
> @@ -1074,6 +1091,9 @@
>  #
>  # The optional members aren't actually optional.
>  #
> +# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
> +#        (Since 8.2)
> +#
>  # @announce-initial: Initial delay (in milliseconds) before sending
>  #     the first announce (Since 4.0)
>  #
> @@ -1231,7 +1251,8 @@
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> -  'data': { '*announce-initial': 'size',
> +  'data': { '*mode': 'MigMode',
> +            '*announce-initial': 'size',
>              '*announce-max': 'size',
>              '*announce-rounds': 'size',
>              '*announce-step': 'size',

