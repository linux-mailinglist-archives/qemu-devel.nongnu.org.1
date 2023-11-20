Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 576677F1E67
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 21:57:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BJR-0001c6-JP; Mon, 20 Nov 2023 15:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r5BJO-0001bX-Rt
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 15:56:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r5BJM-0000VK-1o
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 15:56:05 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKInfju011402; Mon, 20 Nov 2023 20:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OKbQdJTKxFbzm1fYbBLdzhZ8ThaH4wJUIY2nITc1kb0=;
 b=z+U2u6K9lg17r6B69H0MItd4oLiX0qy3/xWRWZ8aDrkB2zIU43Y9CcBJ9x5G0cKpzuQe
 qqhQ+ZMl1jQKYEXI5pqZRRutQ1p3nMBhN9YbQNkPEg/VP9TAm//DJBB9Xz7mnZpSWmHC
 nKmiiZ1Lp82+aNV/8KwMqdP1OT7vyQgBDiRhql4XgRo26roI53obHXRoYntsi/YnyWvq
 IxcFa9Vk6fttUtBVb0MtL/tXzZgtXz9cVLa9699U6AXzb9AjB2u6YGzXHl2DvDZRZx8r
 9C59hBr1XENRwypYECMHsjxIuEaV9i6DqasCIiEhbwE1K3hcq1fcKVz8iatV4cl2yCE/ pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentvbmac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 20:56:01 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AKJo1YC000655; Mon, 20 Nov 2023 20:56:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uekq5qc59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 20:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfGilxN6SKyS3i2+GDie6x5Po5cG2qNDZbLOfDr4s55I1xujVM4zY90mhOH2z8GJ1sNB4+Vcx58ZNNLVJ76HR857CYNWY5rTUpcDkmmZmWU2cYscqToIMPaz/YByktdUxFBDl3Pau61Akvtc7OyskLpXLvS4CV//5nsfA2o6oqMDp78cdMjvV6Dz+vpd6yWlXyWV8VuraCZiAzGgVPDp6ip1bFbEm7gCmZ9OgMonQ7vDnJ0eeuqCREqhNY7Q8qk5UHc4LoS3WQRs0HhsuRFL8UoHflwFd6199wW1NXZIOf+mws3IY/j0KDuJGGM6BCjVylvFgP4gOEkbaWEJsg7ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKbQdJTKxFbzm1fYbBLdzhZ8ThaH4wJUIY2nITc1kb0=;
 b=ezcBbEOQ3o2QCCHyOlrRUFuGx7bk4Jq/7dyPe+Vpzd1AOTpvaNODW6MY7AT/qWy9pDCGHkh7haLiiNbc47wplt7MfKMB+x/22FV/5P/Ln67FqDkqGdtOZvoyDIio5a65yB/wbdkgAgFRVhjOPVpF9NZfADWlop5BuKSdfHcCXWnfQdrLvvwPZpwj9nuMgLCme2ChJPMN0SEawBftvyj+9mO4MUE5e7dF5r3sGl/VMRT9xqMNShCS41TNZ6nGfj0vXwIOyPv/jbdqMwwShMOtkIt8q1ZIj1v6v9aH+LqzGZBlGxpFYIYqguXEsWmdKQ5NOlqpwtCpPM02PvEBo6TJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKbQdJTKxFbzm1fYbBLdzhZ8ThaH4wJUIY2nITc1kb0=;
 b=qalajr9m4BRBMA5gErQ+H4Xp/VU1v8SjFjHvDCHYDyBqDy7+IX4l1nxZM3x4jbnwJQjlxUtL0FyxZgKN/AU7rVEld5RMXTS3t/2Ax9jcRWUzez23I0YsapgHMBpQOmM7mUL3QIsHM+O1/e1lzLNog2indjAqWeoURyTCLJVBK9A=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 20:55:58 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 20:55:58 +0000
Message-ID: <e32d4434-c877-4f98-ac76-da8fa292395c@oracle.com>
Date: Mon, 20 Nov 2023 15:55:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZVu6ohk8_8xzyL-x@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9b0d31-ab34-4fb0-ded7-08dbea0b18bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDf4zLfGRZ6I92YB2r4hhCgdDmkHtqTyXbI7VqLR7g81oZk8Q6yIAh2xqTwiSdq8iqFbyA8777KVLqe+CNmzv6+o8dhR0+EGyYFSpY9p0deTjm6WcTasQO5/bR5297AeOE9sKDSDyhlNhltAqFdeciChwNev+EyIGtfH1zeRnAoaGGkffKw/ok/Aj5cvCmF8yJe+IlfFnhQ6LuHaafqOTYJpQ9yP/WvjdcWh7Ctn98E5bY+7a8vhNgzQFhHVO4voiEpHq1O3e7SUoU8LNjljYltOJoP9RjR8UX8J+d3GB7+yY6Q2U4SUNORahK4h4ROUhIn+rg8c3k6DDVAWsztQ5BbCSSE97Q8ozxg4LH7I9bWhPueLKkNxINaIOzJ8a1wsE58jWS+PvBwubudGM4ei0Rp/1aeJVL7h2wRfLUTRcZ+zEc0pZn3JwXXn0LHoeHGTotXVx9TStAnZUbH4GS2kz+9PLrqV2eOUYynJpGgx0ChjJ9o6/Qyoxx7bJ5I0bg3sAGiyfagSiW8wwa6ECdByl05ZcdFsBELJFu67elVBORJNE5AZLPxh44nW/KBYcDmZGpPxhSljPKDi0DUn/D6Lbp0cutMLRlJmnUBFxXTOjXrHk3/oHBVtgD5vnKv3QpHShluBL1KSyJ6IS5FmCU8r5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(86362001)(31696002)(2906002)(15650500001)(6916009)(316002)(54906003)(66476007)(66556008)(66946007)(44832011)(8676002)(4326008)(8936002)(36756003)(41300700001)(6666004)(31686004)(26005)(2616005)(83380400001)(53546011)(36916002)(6506007)(6512007)(38100700002)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjQ0YVU5ZmJXTWNXS0F2dEJGZy9DY050M0YwdjFYOUxmMTBaUHNWd1pLRTNl?=
 =?utf-8?B?QW5aSWJ0UVloZEpwV2lkQ3J0S1pvRmloZ0cvNkY3dHp5TEJ1V2xSNHlaVE5G?=
 =?utf-8?B?MGQ4WXhEVWNWZGcxanZNSlVrRyt3UFB5OEhzMmNkMnp2cnp4TnF5Qit6Wjdy?=
 =?utf-8?B?MlRra00vb2lJYVUvRkJuRDNYL3VGaUxrOHZTWG5JZnUxZHNhbVhzeWpOcnhp?=
 =?utf-8?B?b0M4OTJ2QURrS2R1a3I1bndycUZWNjJKMmFNZkxkMWJTZVBySFRzM0liOGRQ?=
 =?utf-8?B?bEhmQU9tUGNLWUJxY1lvT2d1ZTh5OUJvOHpWbHJZUXNhTlRBYi9Nc1R5YTF4?=
 =?utf-8?B?SGRKbFMwOHMyeUpmeU5iSlhocjJaTmc0bHZKQURWVWFjRGZRNkprSExsaVhu?=
 =?utf-8?B?TXhDU1ZjY2JhZDg3ZkNGWjVWTzVBNDAzd3lBNXpDRTFwbDltNGowU0FaM3Jp?=
 =?utf-8?B?MHlDeEpiMkpDSThIZnQzTHV1TGVuYllIdGFiZ3BzdWtQY1N4NEszMm9QZ3F0?=
 =?utf-8?B?SmlWODV5UVFURndUdjdpK1FaS1hMeWorSFNDMlJBY2FrdmEzc3FrU0wzYjhD?=
 =?utf-8?B?ZEs4eGl5WEZZMWo2NHM4ZVdOTkMreEFZaGRVQkJ1RGN4RFZQdU1Ya2RVL0o2?=
 =?utf-8?B?QnhmMEhybTRRZ3FNNFh5RFBWZVloeDFhNEFrSzk5ejlpZE1qRytXRllLR1dB?=
 =?utf-8?B?Z2J1Mlo1c3RYc2hBOG40YXFvRmw4MnFROThPYUt3bnB3VjcwNjU3N3pidTVq?=
 =?utf-8?B?NXlhTGFETzV0ejFsY3ozNHNPdExjWmdZQUoxekdrdlZ0SmdTckRYMm90VmF4?=
 =?utf-8?B?OUsyZmd5aWtWS0pvejZBSFozV3JrQ2VyNmluaXcyOE94UjR6am1DTnhmRkJR?=
 =?utf-8?B?MG55RGlsaGRpQUVaU2xiaVNUTDZHVmE5QnpGbDd6d0hNTURvNmZxb0NReUxu?=
 =?utf-8?B?ZjQxTzJENVJ6dmFGSGk4V01XMm5Na1RUS0NaN2hLYWYydGlCSjFsVys0aHY2?=
 =?utf-8?B?Y3dvSkMzbkxuNzhlTFdMRko5OFZENDBJeEZvNEZ1bnEzUmw5Ylg3cXlXWjJz?=
 =?utf-8?B?M2plRmhuSjRHQmJ2Ukp3cUZKY09WRU1nUzlwT2NZNW1CcUVseDNHMkxCNkVs?=
 =?utf-8?B?OVVmdWxlYmdFSFZ5ZUZ2Mmc3RVNySzM3WnJpTG8zYkh1Z0hTcVp0WDRJbks0?=
 =?utf-8?B?Z3NwRUlZVkIrbEYwUWhnTWxpM2dTZjJLNnVoWm1yTVlsQWVFRkwyenIwNGEx?=
 =?utf-8?B?cTh6Vlk4dloybkxUeFI5MFVlR0dmTEt6ZjgyUzJ5YTBxSFRmUEhvWGhTTGdW?=
 =?utf-8?B?aTRLZDB0UzRiTnRhcjVGZmk1ckY5S2poMGdHSk1zSUxSQkplTUdnbnBZUDZk?=
 =?utf-8?B?MDlySWN2OVVrVnQxa3pPMXFDbzZrS1BFMUZkd2NrdXBIQ01GNVFoZHlpSGNN?=
 =?utf-8?B?Tzcvck0xSXZhSXV0bk11RTlVWktBVlpCNkR2Mk5rK2ZEYzBxL1kwRmttbWQ1?=
 =?utf-8?B?NXpBSVVJRkNpZDJDYzVXTDhlNjB2bjFlVis4eXJpaldaNnJDTVpmRFRSZ25Z?=
 =?utf-8?B?T2l2N0dEcnZqWGtrcVMvaDllS2NPNnQvQk9QT1ZnRkN5L0JlZG01cnA0blBU?=
 =?utf-8?B?T2NiU3E4NktBT1N3UU01YzQ4QlZNTE83VVVTc1hYY1Zpc1RGbi9ONktZOFhR?=
 =?utf-8?B?R20wRUZ1SUIzeG5CZ2lqSFI2YytqZ1d4YVd2aURiNklSeFhrUXRFVWo0YUtD?=
 =?utf-8?B?WW0ybzU2T3YyRnNYVlQ2L2tqVmVXSVhQRjdYN3hZUGt1RjA3MEVXREgwYTgr?=
 =?utf-8?B?Sk1lU0JrZzJIRWYzeWxrWFdRSWlLVm9naGZDZ2F2ek5RakF1NW4wc1ZCNWpH?=
 =?utf-8?B?cVBzVUJERnNQVGRIcSsrdEhMZUErZ0ZxQTNnN3MzSkFXRU0rWFFEWmVLQXBo?=
 =?utf-8?B?Qkh5TkpBVzdXYmZqQnR3QW04WUp1cE1IdzdpbU5sbGRuVW1laHI0NVp3SFow?=
 =?utf-8?B?RWsveVZKNi96YWswSzU1NzBqU01vbHd5S2xUaVJzMncwNk5CeWFIQjIxY2Rp?=
 =?utf-8?B?RUE5d2ZmdXMwUy9xNjRDZnMzdkwxQjVlQUpqci9IMGVUQUxmYS9DV3kyakpK?=
 =?utf-8?B?WHpkREwzclBsMlFKUVl5NEVCS0ZCdVpZMFpOcS91aEROQ2lxYTNqOEJlSWlI?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wfnx4fexU6e47JwdF4nmmIUT3bowEkFzyPQkoJk0I1bKEgJyuMKFGmUTDwR+m0PBWYE6ESyUAjnHs62qw+R09Iq78GdOfJHcdKfEmQZrjGN2eDq2Rh55fplgbv1mYoAYiUaxjEWWM2rhekBb3LNB8KvbIIY637l5x78eTXervvok2gWyn1f8a40BbCf5V5Q/tHt/BVrF3vAurR8W8pRxw4ncZrhqEAu/2HayVLUe45HulIbORJxAF+IDdCsOTpM5OCX6N3kUGzfiKpdoNs0dSW//xuPYrzbFhxAnXgIJIdvaT4jkXJderwzAV8MIGvKsy3omp2+qwFtTtodDGMPQHwQCmBLo5LpbHIDLj46bLg9GuesZVg5eqDs0o7uUVtZYnwzIRFKVrMNGeiciZ6RAoNWgcee2h33Zl8D/YxprYQRO0/XzUP0D6+XcJfvYKYWIza+S/F8ZWxg1UlBJFOLQi3GAEZIlg0CK7lZzR0rp7tArwj3c0SP6m9gTkG/5mQzKX28/yeY8KGxOr7u59Uj6AZEWMTyCrJYpHayEcZ0ehQQugE1g7mk3E93f2Kuhcwfc0V3GxMZfDGaI7ZTNeDOCptsBUFg/Z1JDc+I/2PVO7GUr/v21eo3VgHMjm3I1e24ZqHhFN1saZ7O2lexbPZNCYR+IEMjeEJyBYosovlDHHIJjt4pU67/8wKWtL515NIDReR9XA6r5KjRizx/LcZizt5STVXtDuua00FiGVaDThq95CjZ/UdRA+DUX8zxOmZOsOTi9kB86yldn7HF4Q6Xc64YfA1U+xQog1hD1FUwsZxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9b0d31-ab34-4fb0-ded7-08dbea0b18bf
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 20:55:58.5218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yn4GgCJVvKGnY+Op7+ESng5JXpqe/n3VtAn1MpFxupTd/iWXxtg5HGSNfp031vOet+cPyJh5je9+fZTtF8ud4mR1B6supPGqvRPCT92lBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200152
X-Proofpoint-ORIG-GUID: aH74PHELJQMlCj2bzBENn1TY2Bo8QdfY
X-Proofpoint-GUID: aH74PHELJQMlCj2bzBENn1TY2Bo8QdfY
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

On 11/20/2023 2:59 PM, Peter Xu wrote:
> On Mon, Nov 13, 2023 at 10:33:50AM -0800, Steve Sistare wrote:
>> A vm in the suspended state is not completely stopped.  The VCPUs have been
>> paused, but the cpu clock still runs, and runstate notifiers for the
>> transition to stopped have not been called.  Modify vm_stop_force_state to
>> completely stop the vm if the current state is suspended, to be called for
>> live migration and snapshots.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  system/cpus.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/cpus.c b/system/cpus.c
>> index f72c4be..c772708 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -255,6 +255,8 @@ void cpu_interrupt(CPUState *cpu, int mask)
>>  static int do_vm_stop(RunState state, bool send_stop, bool force)
>>  {
>>      int ret = 0;
>> +    bool running = runstate_is_running();
>> +    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
>>  
>>      if (qemu_in_vcpu_thread()) {
>>          qemu_system_vmstop_request_prepare();
>> @@ -267,10 +269,12 @@ static int do_vm_stop(RunState state, bool send_stop, bool force)
>>          return 0;
>>      }
>>  
>> -    if (runstate_is_running()) {
>> +    if (running || (suspended && force)) {
>>          runstate_set(state);
>>          cpu_disable_ticks();
> 
> Not directly relevant, but this is weird that I just notice.
> 
> If we disable ticks before stopping vCPUs, IIUC it means vcpus can see
> stall ticks.  I checked the vm_start() and indeed that one did it in the
> other way round: we'll stop vCPUs before stopping the ticks.
> 
>> -        pause_all_vcpus();
>> +        if (running) {
>> +            pause_all_vcpus();
>> +        }
>>          vm_state_notify(0, state);
>>          if (send_stop) {
>>              qapi_event_send_stop();
> 
> IIUC the "force" is not actually needed.  It's only used when SUSPENDED,
> right?
> 
> In general, considering all above, I'm wondering something like this would
> be much cleaner (and dropping force)?

If we drop force, then all calls to vm_stop will completely stop the suspended
state, eg an hmp "stop" command. This causes two problems.  First, that is a change
in user-visible behavior for something that currently works, vs the migration code
where we are fixing brokenness.  Second, it does not quite work, because the state 
becomes RUN_STATE_PAUSED, so the suspended state is forgotten, and the hmp "cont" 
will try to set the running state.  I could fix that by introducing a new state
RUN_STATE_SUSPENDED_STOPPED, but again it is a user-visible change in existing
behavior.  (I even implemented that while developing, then I realized it was not 
needed to fix the migration bugs.)

- Steve

> ===8<===
> static int do_vm_stop(RunState state, bool send_stop)
>  {
> +    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
> +    bool running = runstate_is_running();
>      int ret = 0;
>  
> -    if (runstate_is_running()) {
> +    /*
> +     * RUNNING:   VM and vCPUs are all running
> +     * SUSPENDED: VM is running, VCPUs are stopped
> +     * Others:    VM and vCPUs are all stopped
> +     */
> +
> +    /* Whether do we need to stop vCPUs? */
> +    if (running) {
> +        pause_all_vcpus();
> +    }
> +
> +    /* Whether do we need to stop the VM in general? */
> +    if (running || suspended) {
>          runstate_set(state);
>          cpu_disable_ticks();
> -        pause_all_vcpus();
>          vm_state_notify(0, state);
>          if (send_stop) {
>              qapi_event_send_stop();
> 

