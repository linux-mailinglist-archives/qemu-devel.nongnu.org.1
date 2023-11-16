Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD6E7EE5AB
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:05:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3fmZ-0003a3-8n; Thu, 16 Nov 2023 12:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3fmS-0003XG-Gh
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:03:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r3fmP-0005xo-II
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:03:52 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AGGXrI2012781; Thu, 16 Nov 2023 17:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4O4ulc7/WfLjPkgE1re3Hsvaz0QSGoCSBn/0rE0oM0g=;
 b=P7vrZT8mwP6fvpL0+RN0sbF27h6+bxYawE+wSsMJs1BNPQIReldS8VeSDNciQnKsqX0W
 WIiaVr6b/VteRKioM+BP4lSzJgAuXgviuYo0USdhQLealxBhGhWYYhWSqeH1pw7Qz2f1
 55kknftpAsyRksT6VpVeO6XhEVYitsgzqmbKbDkztvRhjA3BBEomiHACLW2d9w1d0C4H
 9o69EGYqHPzYj48NhKS6LG6vlJo+Lk2AvT2CQ6asGtE09sdqJa2kBkj2Xl9W5H36LvFz
 if7TB6gGiUxsLKSkSKx2cZ0ZD79MNLIjLfLxn90L9TUASvH+xy6IxB3sDtBCQ3OO4fT+ SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qdbf5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Nov 2023 17:03:42 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AGGP7C4036968; Thu, 16 Nov 2023 17:03:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k76r00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Nov 2023 17:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj4nYaCaeYZEMppQKUh2OVbnA23jC6y/ArGbQTYFMBHNSqrw7SfvtZddYTFDQEAI1a0F+P9DoOCi357SrVAUy30O4xxZJUXyKiOH7G7gRKfCxCQjF6FO0K0DmsAC/Wjnw1B6ciIDaooEyTJ6kAcNnmE2nlPpUSMv8lRGv+nYRGwsUdlk0tYW7KUhvfp9Pnf9OrSFZ4oUKu7l9uDuRWEqURKjOmCAS8yHc+kBtjSpITE+qkzG3fpRN7HiTb0F+uO90yptd9EehhO7euNvM74bUpDpbeA9DAfEYTcY4E2p24h/O8km0AEcm9qis6NXaVHbjiQKIce+cXoMFVjTgPL1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O4ulc7/WfLjPkgE1re3Hsvaz0QSGoCSBn/0rE0oM0g=;
 b=Uf2vLHH3bPyA1Y6vcCl/QlaD+w+9gf1Do+3iOByjDAPBiJF7XE26qshmS+IM5bbP+TweNu4wO8cyczkWUpAbDyouoUYGatekWWoBjb2dp2W21GjEI4UDFw1cF2NQMdWfIDKaslN+/cq4kXXVfT1eq9ixt3o0ThMX56JxnYc7+MnZ3VxCeD5MdPsFhLGK0O3mvmEAYhhrPHYYry7+GKcvtONkWcw0awI5pcbBoe+YxltTx3GlCOJ0otrZNu1iXbD1bplGCoLfqLeK6pM5Io5wg/MRRv45mRUoHJPZ7dhL5rnrzuvt6uQ1yitGk3H/T71Ya/Ft7w76zTiMEe6g7UDtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O4ulc7/WfLjPkgE1re3Hsvaz0QSGoCSBn/0rE0oM0g=;
 b=APMfhEwtiui/GQNJvDotRpA3pa/PzE0QoXYk6BXuY5ar3St0yGFzNkA9LQuO9U0oWNrlZLY46EdqqVuM9JXdWPmhpu7C17QVc7Q6SrAa3FBhumJofm2lodavFnd+kNxroLj6EDqrU3aHjtVRjfBOkdKmcGU5EwhGJu2mt+icJE4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 17:03:30 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 17:03:30 +0000
Message-ID: <45bfd9b2-09dd-471f-9c54-b7f746bf0baf@oracle.com>
Date: Thu, 16 Nov 2023 12:03:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: flush messages on abort
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com> <875y23s918.fsf@pond.sub.org>
 <17078387-f782-42dc-a5bf-25ee22bc518a@oracle.com>
 <87a5rfkn73.fsf@pond.sub.org>
 <1f51f77e-6793-49a8-b6a2-4f3b1d6a761c@oracle.com>
 <8734x5ennk.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8734x5ennk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:208:239::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: c9350475-50d3-41c9-1e54-08dbe6c5f5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w85ARe7Jd2tc959IqaL2gMfQoCCWwP15LFF8cAXq2b9ES14m5uSWPZsiOC/RBjJ7Jm++YNVpfdFj4NEk5yO+nvyNoEPXIBhzB7B+zTXFyIZ0hd++TsX9+y/oPycYAuDsgrl2LP71OZuQZcct/aUJwO2XxR3V+hacH5CQj793TjT4udcftenI03VkEo/75XeTTfHZWDzfMf4n0ipffxbjlMiV9dNBrdTtKgIBWoE5vYNCvX/LrYRFltQK6K3GW1u4Oe3h63bArDDkWl4alAnwGqVZvmPhKrGNouU35NYOI5lJ0X4fJAMDt+hBQ/AJ5Jz2EaV8aJl3qB9N3T+lxcjLMm3y3AE6Ho+yIGU/zhMFyusvu/DPUgjkVrUPJqRFYc4O83F2U8+zKXtRQAIVymvT9/WTTEIJqzXw/9R6yIAtw8F1DOXcHGR9psjJddmr/kNnpgg1F4bdHF2r5hoe0amX/Ii77a7AD2TlBWlGVHj6Hh6uioYP1OuzpkbdrETowJz2mmo7MNrEGpzEUvSgat6KCJSAz/S58Pe9+GgQDB0kn0KLt0XIZJmVtorcUEg6Ai9p5VldYxiE0Z/FU44N0N1WUZU4oWwmINzthtCsTAsUEdXRX7t/dC7/tQZt1pgUCs7/Fy6uf1uYp8z68LtxnZnIOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(36916002)(53546011)(6512007)(26005)(6506007)(66899024)(2616005)(316002)(6916009)(66476007)(54906003)(66556008)(36756003)(66946007)(4326008)(8676002)(38100700002)(8936002)(15650500001)(2906002)(41300700001)(44832011)(5660300002)(31696002)(31686004)(6486002)(86362001)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2FobGtZTFVEMWdiZjZZQ1hSYXlHbUxCbUhJaVQvVys0ZVpsSVhYT01sbEdO?=
 =?utf-8?B?V0kxblhUU1dKRDVDUkJWRzJOb0l4c3ZlRzgyekFBUDRRSzFMNUJ3a2xHYjVC?=
 =?utf-8?B?cHNMV1kyWmFiVUY4RURIRHBWOFRVMW52YjlqOEpxeFB0N0ZEdTRzSnBpQnRa?=
 =?utf-8?B?eHhuTVdUY1YwNkpadzZGSWcySXN6LytUa21hd3RWZUVxYnk5K2JjczBtdkh2?=
 =?utf-8?B?VVJ6TkRES1l2OXhwRU5TRVRPbmZxK1RIcjFocWNtOFZ5aHFwbkFuNGJOYmpZ?=
 =?utf-8?B?VlljMmlZRlpyZEZ5SHJ1dDQ4SWhvbVczQkJIWG5VYUdmR1Z6WjR4bituYTdx?=
 =?utf-8?B?RjQrb1VWL3g1TGZKRGVnS3M1Sk5aYXkwRE0yT2t5T0Z0TEZWRWlvd284Q0Ur?=
 =?utf-8?B?d2JsenBoWUI0VHJ3TklLcUh3Tm5memVWYVA4Y2MzUWRCSUlPVzVHWXJiQ1M4?=
 =?utf-8?B?blRTTjJKRzhIckxTaW5IY3BPWktJczlBVEVMNzN4VElVSDd5eG5sYkh5UFFi?=
 =?utf-8?B?ZUU4b0hlK0JVbzVVeTV3Y0xDeVpuN25PdDNWUVlPRVVCWFNXWFNvTFdnSXlG?=
 =?utf-8?B?TzhiRDVvb1NDRm43azZMcWVvT2hDTWYrOEhHdTZSV0F1bENYZ3RvY09GRk04?=
 =?utf-8?B?eGF3U2RJV3IzUExSazhkbUZ6ODE2MUhvWFMvR1Qxb2lLVVNRS2VvUVFPTHNZ?=
 =?utf-8?B?MEhtSko2K0JNQkVtalhma05OYUZjbS9yR20xYlZwZVVoQ2FocFdpQ0Y1d0JH?=
 =?utf-8?B?aXJDK3RyVzFNYlUwN0NPNUdUYW1JS292V0hSWUFUR0ZXNCtnUVpaR2l1VG1E?=
 =?utf-8?B?dzlETUJqTkNUS1JhM0UrNUhLSjF4clJITFdXRmExTnFjMExNa0lqS29qWHMv?=
 =?utf-8?B?OWVZbnNLdkhjQlJiRlVTTG4xKzJkdFZvZFpTM0orM2VISU9YUXBUbm5FNSs2?=
 =?utf-8?B?YXlEeEZqdGRzeG5TS1UwSk9oMjFuLzVOVjNZek82cFI1RFdxRGpzTXlWUldx?=
 =?utf-8?B?RllTdDl5NmhYa0RCczQ2TWZuMU1FRElubThJYWpQTTh0MDUvYnFFNnF1ekZv?=
 =?utf-8?B?S0dqaTA5VUkvbzdsYWdmd1NIZGdjMGhHZWxpVWMvYys4UTlvZ0huNkpBcktK?=
 =?utf-8?B?TmdpbTRqVUVZeWE2OUtFb3hTVnRwblE2REdxT09PWWl6RGQxbVRNVXU1VXV1?=
 =?utf-8?B?dlpIVklaeVRpM0VQemRRV0V6TnRPYUsxK0RKSFRkT3dadEFzK0dJaWNrT3BT?=
 =?utf-8?B?eGhlZjJJeDdpa00rVHl2d242dVljK2F4R0RPc1loZFBUR3RHTGdTQjR2SWwy?=
 =?utf-8?B?T2M4N1J3QTFSbzNxWG9PSERsUmdnb3NYTGpYT1YrS2k3dWhUK0Y3V20raHQ2?=
 =?utf-8?B?YndiQ05Kd1VHUHVmZnFWa3grWDhjS2tRZVBabjZXQkpNcWhrRWRIRlMxMFNT?=
 =?utf-8?B?MUU0R3JYeVFUMGJ0dlk5YnBtY3RWUmY1VHhnR0hEQ3RJSExVT3E4NFJON2lN?=
 =?utf-8?B?MnlUNERrOW9TOXJ3aWpOL3E5a2UreTRibHFoZG41QTRISFlzQ0xtSmhQN2tm?=
 =?utf-8?B?TlpXU0Ixcis2Sm5lcFY3aC82RmNEaHZDQXVxVWR0WEhIK093SDBuWW9xN3VW?=
 =?utf-8?B?d0tqRzVWS1p4S29VMTdwTzJRQXZPMWZUMXVyNVhHSkhTSGR2OXpadGhNWjBo?=
 =?utf-8?B?LzVObnJnY1pUTU02UHlDSjJHWDBSRGJOQTBQaTVFU0IyTjNMZGx2aDB0OGdF?=
 =?utf-8?B?WGtCdHdJYzEyMzE4ZlVSUnJ5OUtLS3l0SHEvSHJ0WXMyNFR5SHZNdTZrUkRJ?=
 =?utf-8?B?S0g4NmJTaFU0bWZkbkVTYTFEeWFiVlpKYmRtQ1NHN3pyRGo2UmNLVFRMekxP?=
 =?utf-8?B?UHQ3RzZhc0dacFVNa01MOGdFZnA5bnNpYmNuaUMwdE8rZkFvUGhrQU96R21C?=
 =?utf-8?B?MXRwWW5ZOFFHSzhwd25wSHRlOEdVREJMbWJQeUdkQUJqM1hnVWZxY25QbnFQ?=
 =?utf-8?B?QndtOG9WaWFpYTkvWlNldEk0bVM0TitGS1A5Mm1uK1lCUmZFakNDT3RmSkx3?=
 =?utf-8?B?UFJxeUtkbGxlaVl4NGZlMmJzMW1oZWkrMWkrUlhRNzJPUy9LZGQwV2tUK1Bi?=
 =?utf-8?B?SEp5TTVQNTNJQ0N2SmhzbTRqL1lMNzFuQlJNMldPZTNoWkZRTjZVdnhvRk9s?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l0qNLIqTP84RHSSNsDLOjF04HbRMQrP1M9xJCH1W/Gxu6fAjy6iSPBxVe+qp8lHrijXyi72zLre54w8AXhAxj+REF5+KY43rjDHTZPVgtAA4WGeDY5MFoJQ+fPygbX9EbKsUJRMuknLv5oMTIIdLE4gdgE1hPNfWSUwcYo3dYTpRHVmkqwTZvIyBj6hxGkcL4ByiVcXG7TyMz0TqrKdwQVq9crPulqbHmE7hztWjsNyF9Oeq6NKQ7hgb2bk7nvTTDMT702JOZfi+vUdWIdtxEN3Md/Z+RVoe63KfBAKWvnhXrxF28eb33DE0PDH06rtaYqGhhWTvVTwcB55htBwX4knlRcym6JF6u5Q607T3AnrZhnyPQnn1Nb+5TDEc8D6ImF8vcLMpuskbCq4Rg0cW2bl3IfkSQBLo7qOdte+0ecTjEbUcPK7Rna6AMKrmho40enoQJE1g2Hk36bxapk2UvkM5e9EfYRWfspffBvnUEfoC+s5OwXe2nhjgMYqnHIR1N5RUfEiW0YXL9T9Fo6OKhL4KkHC7QYH1CKBb2uSBWvFTjSDLzBNpjt5af0dMGkaKOEf5WJD6TdDDbyDqlPvg6gEfSfJy9ZkHUiltH2NKWB0257wiLIdPTF08mQHrG9F+yU3JaJGZh4HZ9Pncvc98O8/rbqLhgBwAgU7AF5BA3rN+TG+gwpkq6ACmxmiSMyu3r6MHJyeOm394hNFcVtgqevAqwuAIZp+DeWwStp1vysJTHlTJjaZY++l0f11CpsJP6uJQUhKhYhcXoptF9FZWANd1I5twvmMSim9HNLTuQaspFjFf+e7uN70kqeWpCj7ChxoqeiE2fSWMDXJC0QkznQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9350475-50d3-41c9-1e54-08dbe6c5f5a2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:03:30.8167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rgxwpFxZl449KRazXbSYaGBjSxnIt6jc6xwFzR2gsFXf7NPmqLu7GFwhope+VmSBoWid1S4u6cWrOFgzebbQZmjEzzSIONU4UDrvAWUJ90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_17,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160134
X-Proofpoint-ORIG-GUID: TLMgiaMJA5cY6fJpoQXZrwRmL0E51wpr
X-Proofpoint-GUID: TLMgiaMJA5cY6fJpoQXZrwRmL0E51wpr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/16/2023 10:14 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 11/15/2023 11:15 AM, Markus Armbruster wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>> On 11/15/2023 3:41 AM, Markus Armbruster wrote:
>>>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>>>
>>>>>> On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
>>>>>>> On 11/3/2023 1:33 PM, Daniel P. Berrangé wrote:
>>>>>>>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>>>>>>>>> Buffered monitor output is lost when abort() is called.  The pattern
>>>>>>>>> error_report() followed by abort() occurs about 60 times, so valuable
>>>>>>>>> information is being lost when the abort is called in the context of a
>>>>>>>>> monitor command.
>>>>>>>>
>>>>>>>> I'm curious, was there a particular abort() scenario that you hit ?
>>>>>>>
>>>>>>> Yes, while tweaking the suspended state, and forgetting to add transitions:
>>>>>>>
>>>>>>>         error_report("invalid runstate transition: '%s' -> '%s'",
>>>>>>>         abort();
>>>>>>>
>>>>>>> But I have previously hit this for other errors.
>>>>>
>>>>> Can you provide a reproducer?
>>>>
>>>> I sometimes hit this when developing new code.  I do not have a reproducer for upstream
>>>> branches. The patch is aimed at helping developers, not users.
>>>
>>> I'm asking because I can't see how the error message could be lost.  A
>>> reproducer would let me find out.  "Apply this set of broken patches,
>>> then do that" would serve.
>>
>> $ patch -p1 << EOF
>> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
>> index b0f948d..c9a3aee 100644
>> --- a/monitor/qmp-cmds.c
>> +++ b/monitor/qmp-cmds.c
>> @@ -47,8 +47,12 @@ void qmp_quit(Error **errp)
>>      qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP_QUIT);
>>  }
>>
>> +#include "qemu/error-report.h"
>> +
>>  void qmp_stop(Error **errp)
>>  {
>> +    error_report("injected failure");
>> +    abort();
>>      /* if there is a dump in background, we should wait until the dump
>>       * finished */
>>      if (qemu_system_dump_in_progress()) {
>> EOF
>>
>> # This example loses the error message:
>>
>> $ args='-display none -chardev socket,id=mon1,server=on,path=mon1.sock,wait=off -mon mon1,mode=control'
>> $ qemu-system-x86_64 $args < /dev/null &
>> [1] 18048
>> $ echo '{"execute":"qmp_capabilities"} {"execute":"human-monitor-command","arguments":{"command-line":"stop"}}' | ncat -U mon1.sock
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 8}, "package": "v8.1.0-2976-g4025fde-dirty"}, "capabilities": ["oob"]}}
>> {"return": {}}
>> Ncat: Connection reset by peer.
>> $
>> [1]+  Aborted                 qemu-system-x86_64 $args < /dev/null
>>
>>
>> # This example preserves the error message. I include it to show the ncat-based test is valid.
>>
>> $ qemu-system-x86_64 $args < /dev/null &
>> [1] 18060
>> $ echo '{"execute":"qmp_capabilities"} {"execute":"stop"}' | ncat -U mon1.sock
>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 8}, "package": "v8.1.0-2976-g4025fde-dirty"}, "capabilities": ["oob"]}}
>> {"return": {}}
>> injected failure                <============= qemu stderr
>> Ncat: Connection reset by peer.
>> $
>> [1]+  Aborted                 qemu-system-x86_64 $args < /dev/null
>>
>> - Steve
> 
> Reproduced, thanks!
> 
> Confirms my reading of the code.  Two cases:
> 
> 1. Normal monitor output
> 
>    Flushed on newline.  A partial last line can be lost on crash or
>    exit().
> 
>    Works as intended.
> 
> 2. Output being captured for QMP command human-monitor-command
> 
>    Never flushed.  Instead, the entire buffer is included in the
>    command's success response.  Naturally there is no response on crash.
> 
>    Works as intended.
> 
> Here's how to fish unflushed output out of a core dump:
> 
>     (gdb) bt
>     #0  0x00007efeba52fecc in __pthread_kill_implementation () at /lib64/libc.so.6
>     #1  0x00007efeba4dfab6 in raise () at /lib64/libc.so.6
>     #2  0x00007efeba4c97fc in abort () at /lib64/libc.so.6
>     #3  0x000055588dcc848c in qmp_stop (errp=0x0) at ../monitor/qmp-cmds.c:53
>     #4  0x000055588dcc36ab in hmp_stop (mon=0x7ffc01d47cc0, qdict=0x555891d19200)
>         at ../monitor/hmp-cmds.c:119
>     #5  0x000055588dcc714e in handle_hmp_command_exec
>         (mon=0x7ffc01d47cc0, cmd=0x55588f0689d0 <hmp_cmds+7760>, qdict=0x555891d19200) at ../monitor/hmp.c:1106
>     #6  0x000055588dcc737b in handle_hmp_command
>         (mon=0x7ffc01d47cc0, cmdline=0x7efea80036f4 "") at ../monitor/hmp.c:1158
>     #7  0x000055588dcc8922 in qmp_human_monitor_command
>         (command_line=0x7efea80036f0 "stop", has_cpu_index=false, cpu_index=0, errp=0x7ffc01d47dd0) at ../monitor/qmp-cmds.c:184
> 
>     [...]
> 
>     (gdb) up 4
>     #4  0x000055588dcc36ab in hmp_stop (mon=0x7ffc01d47cc0, qdict=0x555891d19200)
>         at ../monitor/hmp-cmds.c:119
>     119	    qmp_stop(NULL);
>     (gdb) p mon->outbuf
>     $1 = (GString *) 0x555890a65260
>     (gdb) p *$
>     $2 = {str = 0x7efea8002c00 "injected failure\r\n", len = 18, 
>       allocated_len = 128}

Yes. thanks.  With the patch, the computer does the work for us, and sometimes the message
is definitive enough to fix without further investigation, eg
  invalid runstate transition: 'suspended -> 'save-vm'

But, it's no big deal, and I withdraw the patch request.  Thanks for looking at it.

- Steve

