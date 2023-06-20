Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F74737470
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 20:38:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBgE6-0006MS-UX; Tue, 20 Jun 2023 14:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qBgE3-0006Lz-0i
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 14:37:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qBgE0-000240-Lg
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 14:37:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35KGE7I9013732; Tue, 20 Jun 2023 18:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=k/sxRufScvvA3i8eqlLTDd3Imjb/hncaqpxXsKdPSSA=;
 b=ls/UWeOlgBF3DOuJi9Y7vhz003fDOhWQbBICuQen6q97L5G0e+lN/Jf/mP4Na4hBtf9i
 3lfyvbeXm2CYWDEsZV/hdVq69cJzhwD8w5WIxOPG6pr1idj0VtWe+YjMU9elhu+ZsnSB
 U0i1fgv0bICNtW/g3e6EUO3BZ63xwh6hkpudzQ1hlakvtj2HvnrUsT7Zpi9ZMBVfGfVs
 4JTQlN6IcLYTZI16328cb72hHT1+5hupDxy0UQ9MDH2OYc4bw3IGKbpowI2VYmddJOGt
 qpZlazYYuGURdmOmqHXKXJji3EB2eZ0AWd6g3ObQklTUGx/rWzhJ8EEatKL8GLfr3dya 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95ctwetf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 18:37:05 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35KHojif032932; Tue, 20 Jun 2023 18:37:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9395yjdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 18:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmPeeXaw7SJ4FbMTkEl3P4winbSd6zJimDLOF0nJgnl5KpeIWM8UUlRaZURFDxU9N7cHim5dg/dS8CHYQuaGWayLNmIxOxZtpJSnT2+wuq9no0r7CJcK9w5UXR6Kq6edPP69jeOk+RFVieJjrfL3/4XNT6FCZxunuavNwHTCHSqZ8dQJNDEGMyyFn5+KJhl4Oh463qRz3wOf3YvFFnFrT/ctmwxTSOPnqbCeNoRokG1qgbieM3tUlsunjAOJO+1I4+0triCvP830+8UI8MuQi2r/IrU9MLvXuwj6xmfC1vT+49w0pqG7JF61T9ZllPSFAUTiYvjBI6Kq3kOgTq1Row==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/sxRufScvvA3i8eqlLTDd3Imjb/hncaqpxXsKdPSSA=;
 b=aDbO3mL1l3nNUf+fb4F6nBME1Zx6U9iC886Xz9m9OoAfFZzfGg8NeValrfgsF8i8UnsQ7+Tq5WXFYEycRVZzZQYV8iJh8KGnWqVL3RirQ02Gl9isxvLrFHSSoNMPNZVC+QQ6qmQlrLryhWhnSraat2Vf7hIrliURd6SQ1Cryb4cjDJ5Koii1zoTb5x+95G6qdnmuhhXGgr/mxFVU7fpxALMEymSFPsHyc5oGCxpymuKDpXtiG8pT7E3TJfJbe/lc6LRO1SoSYJ1lcx22hIiwuyGf3LckNaWZNTD/1kAdX2FVMDExvlNeS1u48jUfhqjXmpssIFfj5PGroA9foKBhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/sxRufScvvA3i8eqlLTDd3Imjb/hncaqpxXsKdPSSA=;
 b=RdYFGoENP3nhPLT2PZWpXVkpGUgJcWXshyc6ZCfqEhp3Atwo5qTQKuCxMGjgrAFaawXzVOHQFU7654/rwn5tm0NSeTRGD1wFk/obBoumAgy25oLlC7xjgbcWBitEIYz+j2ZgGB6aTyhfB7giT8ETMf3EWGM1O+SEwGhKq0UESSU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 18:37:01 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%6]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 18:37:01 +0000
Message-ID: <5d158448-4c11-21b9-5e41-e7d57c1b2c7c@oracle.com>
Date: Tue, 20 Jun 2023 14:36:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2] migration: file URI
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZIdnj7Hr1L3iDVUG@x1n> <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
 <ZId4LggDVgxbtGTn@x1n> <877cs6ujtu.fsf@suse.de> <ZInhvxq9YgoM9ykZ@x1n>
 <874jn9vs9x.fsf@suse.de> <ZIoJFoBlkS5WFOyZ@x1n> <87cz1wzsnf.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87cz1wzsnf.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0158.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a82ced-fdd0-46db-cece-08db71bd5625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUzlgfZjswYS+obkWQldrgizJxj0Z+1v4dsaktaKpXkIIAVtt4WIj0z/ge7oNdAZEmUh1BjkgkRwjf7fdOqu+M3e+YFXYhtwRiddiBaJdvcsBdLu+pHDyrS7CwQAT2+3MwfF6jvgFUuQuDXyMaMtJlJF9ofQsDeC21Zx+AjHuqmDx4GVSW1G2vOsFbfvN2Xj3pi5OQpM0/ysnlNbOfNjjh40WH1K+uBJcP+lx1BkHZ5zEhnhvUm7MF7De1ERzWWZke/hmf1OgJRBKKG+sOYSpQPQATfVZZBjlQIu3cKfC2+T1YHqHcIf8dfw+/tpi1mOtseQ2SkrMc6mr/rE/L+7JBQbv1m84BmuYUl2OyQr7cJZTuUBqSt6Bei3whNgXZpJ0WskMjas7Ow/puAPm1r6ZqSdILDJnbYkOYC/1FhHO8x4yXJkHDDoP0UlzDuhEt/FUSiphX0o3FlqBwCh1a7j5c1F5kxT5TmWu5Q110mWTEAKoT8WXbfPowVLl3lFDciLV+3Rju6xIgsY26rEho0b0DDU9JOVvJf1q/VrW04M2LlAVUdjQGfEJ1WXjbui0xDxPq0jOhHUEXkKbif8gg/wi6GOuu1tg5t9gktAFfyYeeqHLYAyGlpeThltQ27IpPROi6C2/67nU1opUhnTscQ6BcrBPBSr4nPvPYrChqnrUOplcNmpCysdpTCcRepOnLmS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(186003)(478600001)(966005)(36916002)(6486002)(6666004)(86362001)(31696002)(26005)(6506007)(6512007)(53546011)(54906003)(2616005)(31686004)(38100700002)(316002)(83380400001)(66556008)(66476007)(6916009)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(2906002)(66899021)(41300700001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldORWhxNFVBNm1kVFJDdTV5c3N1Qnc5ZHNrUXRDdERPdmp4NzlXM3NEQ0Jx?=
 =?utf-8?B?aHljS0g1YnhlSXFyYjZ1Qm9GNHRkQVpXS2FvRG9UejBZVS9aOUI4TnhTTThW?=
 =?utf-8?B?eTlZZGdVK29XTFoySE9haTI0YUdraHNmT0YrVVNndHlxK3ZoNU9Nck5FcjFz?=
 =?utf-8?B?R3NjZWY4aUtRNHRWOGFYeFpqS3cxYzJFMnR1NEhFOEJYYVFKZzZtRXFRU0kr?=
 =?utf-8?B?ajhnamxreVNRM1c2Y0xCNmdOd2RPS0NMUFk1WkErZzJ5R2UzbWQ4NEZ5NlBh?=
 =?utf-8?B?VkdIeUdHZnZYOU1mbnhUMFA5OE93QWxhV09XNGNBemxFbHVMU2tKSDJocWNP?=
 =?utf-8?B?SU13Y2pNZGxjRVdkZzRBcUJUNWFvR3dyRjNiVUJBQU05TnFRTzdCR3dVeTBM?=
 =?utf-8?B?Skl3ZDNQaW16b1Q1SzhoMEt0R3VzRXFKZW5MWDM0TnNGMTBIdjVPbjduL3Ey?=
 =?utf-8?B?ZXI1TmkyUU1yYUJPbXlVNFVmZFU2czJ6SmdUWm9EaVBYL3hZUG52OExwWEli?=
 =?utf-8?B?eThqczU5S1hMeWdsZWR4ZEhzZElkM1ZEUm9NaDR4S1dydzJGTTJhTHNoM0tM?=
 =?utf-8?B?SDJRTUVtR0dXMUN6bkMyTEpMRWptV1NGc2lwT3U5M3d2bTVxZTF0QUhaOWFi?=
 =?utf-8?B?VlIwOHYvWHZRUFZIZnFQckp5U1RYZCsya2s3K1FQUFlLaW9vaXY0QXZXaHE3?=
 =?utf-8?B?c3k4eEdOcmxNVUdncmNtR2RBTmkvS3RkV1VTZDhuMXM1bXZscE5nT3FJMjFh?=
 =?utf-8?B?TW1YRzA5bEYrcFh3Vm85ZkNUZk9YYXV5UFU3WDNhWG52QlhCNE1oeHZpd0t5?=
 =?utf-8?B?RnNSUHN2Mk9YMlFzMmNkcStLNVpHYkswOWg3dmxqeWRNMHZpVXNCc0h1QkY0?=
 =?utf-8?B?WTJwSGkxb1B6d1VUZEs1MWlEZjBPdzZSb2hXVW14OTJWVURsd0sxYkRJMDNs?=
 =?utf-8?B?SEhES3M0TG9oYjVPL3JoWVY3dHNWSForSjAxRTViT2Fnd3o1ZHBkOGg0N2gv?=
 =?utf-8?B?R0c1NlUrdHVoV0paVlEzK3JoZFNOeHRLZmJtSURWZ1RXTVBrUkp5NXJrc3R1?=
 =?utf-8?B?cjRNalNHWkd3dTJHcG40MERGWk1rSFpqRmlUSWVvbHd1L3RhbFBaa0U4M3g0?=
 =?utf-8?B?eW1Qd3BxS1grTnlyOUpTZi9jbWVBc1p5UWNURUdrQTFGK3RMVmRuMnhtUWls?=
 =?utf-8?B?RXpOSHNGanQyYUo1NFk0aTVYY25SUHg3UUlLTHF4eG13YnNyTkNsZ1haVnhS?=
 =?utf-8?B?ZEMwS3JMMTJxbW9SeHFRaGVVWnJhN1hWTVlneHBaZ24wNm5aSzlnQVNZZnU2?=
 =?utf-8?B?Y3ZtcmJ6SllzM29RbGtpZFR1K0pyZ1BDWTFoTU9yQmtzUHoyYUVnblp1U2Z4?=
 =?utf-8?B?TndBcUJLSVY2MlpKMVZSUEhtd0dDWW1vRjVvR255MGRuWTBDZXFPd1V0blFH?=
 =?utf-8?B?ZXZteTIwS0dESjFBcXlTL0U0VlVRYTJBT3NYSmFWaDhCR3FISExNUnpxRnBa?=
 =?utf-8?B?UDdHZ1Rrai9Tc0VXejZFV3pXaThONzNnOC9Ga2ZrOFIyYkEveUdsMjlLZTRG?=
 =?utf-8?B?TUYxbjl3ZDBqYjhEdC9LUWV6cXJ0ZmlsbkRYTjhoK2gwYmJab05qbHk1T05M?=
 =?utf-8?B?TXBFcVlwYzZSRnB5bE5VYzc0eHN5NkdVT3NVY0JGZEVJbHh5eWo2alNzbnRj?=
 =?utf-8?B?NFB2ZHlXdmQzYmMxak5kd29nTThrc0JvN09XVURXUURpLzZOREFOOHh2WDVC?=
 =?utf-8?B?OVNLMmEveHQ2REZNbmoweVBoWlBmN0hLMkd0WVJjeDlic1UxTnV3VkxidkFJ?=
 =?utf-8?B?TXdIQnB3K3h5WS9GQVF6dHNZVHlmb2QwckR1SlFVWDUwR09IcFBlS3N5bEZ1?=
 =?utf-8?B?K282V2Q0bXN2QjEvdEZyUkhvemg3SVlScmREbmJHYmRHN21EalZCSGlhL2Mx?=
 =?utf-8?B?aDZqei8xMXk1SWtsUDgwczgzZzB2bUhUZ0hYVlIremNMZmwzSXRXc3RrbmZt?=
 =?utf-8?B?SXh4dG1mWk80LzFuL1M4S1dZSkR2bkRrazhnOE5SSXJBejlqMC9QY0V0RGlM?=
 =?utf-8?B?cUJIenFyVkROZG1Nd2JKandMaW9PVHVaN0xVdDRjNFBENFZRWEkwOFZyV1Fq?=
 =?utf-8?B?T25qUUUrbHQ5aGwyVmpyUklSaXVoSUhRWFBlTlhGZFVtcW5JMU1OaEFVVWhE?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SiOU4SDMfVWX3+OKILdhXAuI6nd82ICcxR51DyzOInyvjcYvERJmE8QYVgFMhjOMyt4IyUr+EMflEA32ozZEvkTVtXxk7XkH429LmgolKFF/DfCZa1Yjf0v+oQpB3b+gs5Xw3QzbWZtiegtMeDpzeki/wCbM8oEQ8UMVx3aFOHCDxv3eErxEVHnCCDT7DgZMwAuzPfROaU+dttLtWAkxIwVc2/Vf+gM4M+YpQNUAAdMuOcuCpJVHntGnHR00X1LLGKRaZPD3L3GAIfdnqexKHK2RB5JcoVHvLC7swQa2sXmEuBu8pz53jgXkVx+vhuAzQB2hpV5DIbTbrXPQOvNPn4wVgL1LxpNRPcFcFQcP8ghU0IVfQd/hvIXDbepXhiZL4D00184uCF7xFDSnIhyIH5aacGs3r/0aZazO9ePzUTTPAbjQmAzbmS5SAtneSXmhNKbkVq5aHLADUoEpdtP6gk3zGF3G/JbR97cIkLESc8UoQkr3OgickulsV+yoaW3cIhWDdaMoqOQxhlMy0LfU+bR1pPldJRxkpgcoYp1HNd+pUd6kOK1/V19Td3e3wZiSFUbTgvKhq/0V+bTd+zblXgSX40qIuXek5sn/W1j4sGMD62HX8Wnwoc6lR2hahC4QYhEmA5wIVadP4QUeA5/B84g1p7CI5ObKrmSI0JgU/PiKLtgFp5DFcx/wEbJq31wz1jPOYu5+kXnaYfwDq/P1cDQh92fYQKS+/Oa8uROxkyw8R8x3ergTcbvacnriw9mq3+PRh21RRR8hA3XsNeqdoLH/Peas1Q1I/AqgmWXnGfiRjujaBLtadf6XO9Rpsn7CIQe+IFOSAHrKFwyjsCY6PA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a82ced-fdd0-46db-cece-08db71bd5625
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 18:37:01.2830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoXlFst5REna0vsGxsrjKOVqcP8AhWoPPff2Hta0NQRjGFnashMOFTBJwnxF2F4v1/I25hbIUfDdZRmPMIw/xR094kiX9yVD0o3h1+G4SDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200168
X-Proofpoint-GUID: xJyTlYiZEv9Hi8daaoI6Np6JgQg57ksY
X-Proofpoint-ORIG-GUID: xJyTlYiZEv9Hi8daaoI6Np6JgQg57ksY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/15/2023 10:50 AM, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Wed, Jun 14, 2023 at 02:59:54PM -0300, Fabiano Rosas wrote:
>>> In this message Daniel mentions virDomainSnapshotXXX which would benefit
>>> from using the same "file" migration, but being done live:
>>>
>>> https://lore.kernel.org/r/ZD7MRGQ+4QsDBtKR@redhat.com
>>>
>>> And from your response here:
>>>  https://lore.kernel.org/r/ZEA759BSs75ldW6Y@x1n
>>>
>>> I had understood that having a new SUSPEND cap to decide whether to do
>>> it live or non-live would be enough to cover all use-cases.
>>
>> Oh, I probably lost some of the contexts there, sorry about that - so it's
>> about not being able to live snapshot on !LINUX worlds properly, am I
>> right?
>>
> 
> Right, so that gives us for now a reasonable use-case for keeping live
> migration behavior possible with "file:".
> 
>> In the ideal world where we can always synchronously tracking guest pages
>> (like what we do with userfaultfd wr-protections on modern Linux), the
>> !SUSPEND case should always be covered by CAP_BACKGROUND_SNAPSHOT already
>> in a more performant way.  IOW, !SUSPEND seems to be not useful to Linux,
>> because whenever we want to set !SUSPEND we should just use BG_SNAPSHOT.
>>
> 
> I agree.
> 
>> But I think indeed the live snapshot support is not good enough. Even on
>> Linux, it lacks different memory type supports, multi-process support, and
>> also no-go on very old kernels.  So I assume the fallback makes sense, and
>> then we can't always rely on that.
>>
>> Then I agree we can keep "file:" the same as others like proposed here, but
>> I'd like to double check with all of us so we're on the same page..
> 
> +1
> 
>> And maybe we should mention some discussions into commit message or
>> comments where proper in the code, so we can track what has happened
>> easier.
>>
> 
> I'll add some words where appropriate in my series as well. A v2 is
> already overdue with all the refactorings that have happened in the
> migration code.

Peter, should one of us proceed to submit the file URI as a stand-alone patch, 
since we both need it, and it has some value on its own? 

My version adds a watch on the incoming channel so we do not block monitor commands. 
It also adds tracepoints like the other URI's.

Fabiano's version adds a nice unit test.  

Maybe we should submit a small series with both.

- Steve

