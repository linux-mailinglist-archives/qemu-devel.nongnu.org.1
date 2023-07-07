Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4275674B899
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 23:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsl2-0005pC-EO; Fri, 07 Jul 2023 17:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qHskt-0005oR-BQ
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:12:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qHskm-0002hK-KN
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:12:39 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 367Ko2vN032259; Fri, 7 Jul 2023 21:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dukU0ByGstmK8xRicjwvzDRoVqjdaIMANd+DNg3LvwE=;
 b=u1GkJf2K0rv1BIO6YjyZDgxqczvOhaJsbLw8tntlBKlBQ4x0456io8ZumKgrw+q3p2Dz
 Yo+ABY/W5d7WSOgpKE53LRNNrAI42RXLN5xydFyJNRDNsQTL7OJUoVPhuStzegjmDD8G
 eKa3JO9MLFvYqy2vors6Wgz9G41QC3ELPDJeICaZVW5s9tImVNEov+dtM077U9WCvDIm
 TCEbAGxPc0hI5l+B/4PpM0239v3P1o94unPvG35ZLULG/kwtqJ+ELPY91HPLjvYMR6we
 cnn5EsWqjZLmBXl82GXHuu+mmp9cjWcNHmG5nHGYs1Gm985D5NU0HY7/nk17yGqodbQw bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpt36811m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jul 2023 21:12:32 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 367KSva0013458; Fri, 7 Jul 2023 21:12:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak8y3qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jul 2023 21:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyH9bNZEFH1HEdIBRk5ZCheRhaqsqpo3NAy/eA1o5cyjppoFav0e96pzwI68gpRLLJua3c3d9BvnC8h1GZbv1mT6gHWNvbQBbDpUK18Gd4M4DITXoYegX/WzNHUJ+oD11yS3NuyIrJ1YKQokGA7UaR1v/2JPOZmcRzg4amuEsIQ4PK2DEXnh2FoDFJehsVKM4SUlEZ77+/8I/5+U53Jtl0v0I/dpub2KA2scDvyKH0jSdM4e85oKD2GMuODIBgeto7VW4xD2uDe7M3ne17WihauJrU7HeMm/91+9wrQ8nLah2CT8uMQ5e3oX6kvhjW8YzSlhmOR5+VIVwOQyAPLOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dukU0ByGstmK8xRicjwvzDRoVqjdaIMANd+DNg3LvwE=;
 b=QcwS03DZF4QMjWzwZZRBDykqI2VwwAItwadoyasgvt38rQ4CMl7hxNUt4+fiRSLQJtTcebC53TgtVGS/OI0LscQsj7AGGd1cwn+FpA1oYdU/aTZLCraVtdtqWBGRqQONpjjZt22+mzekmpIRuHmGFvRzLMD7wjfwpZj3qijDZA0vRqcYm5tyh5iG5Kw/F8LUT6CQU9rdpzrq6cJhzeD+23fToJNrlTDsCOck0M4QM3TyQXHHAWJZwP9DWrzk4iX2ivvTaowwX6pmNU3Tukiq9jCfTlEl+Yx8wgXUltjBirU81j36WlfaxoECxGQpnW79LgE0p9J3hfVCIuJvwdZEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dukU0ByGstmK8xRicjwvzDRoVqjdaIMANd+DNg3LvwE=;
 b=lShTCCRTX5PKJh5YSJH5bGuWRFdNTj+w2WjdiLuRvaOKfXu1rsMveau07vicbhr3v1f+hg8zWo/enBSj7TTw6uW1QFUHk5lZTDSVnf1wgrHJvB1Z6BuUJBKooCTsBGQ06koeaDDfVUjSvwMthwIwniFgUpx/EV3/SUrgx5CQQ1o=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 21:12:29 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 21:12:29 +0000
Message-ID: <c70616d3-cc13-8568-4bd0-f98ae60002e3@oracle.com>
Date: Fri, 7 Jul 2023 17:12:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4] migration: simplify blockers
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>
References: <1688761248-32741-1-git-send-email-steven.sistare@oracle.com>
 <ZKh9WYhYwaGIy359@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZKh9WYhYwaGIy359@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::25) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: d98fa501-7fb2-4e61-11b4-08db7f2edf12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chbIe/xSU1jv0LwyqioHIfsnCL8jtYp6mkcOXu8kOhTWjWqRPikmuIc0G9pq9WX0loeQoUMnpbDFcuoqKUEqgxJh97ql33+PdLzk8FT8hHnWRzMZeh5fUAgCFbjAzT+aiXFim5GKqmTDtckyFLFL075Z53zgWqXjmnnHRT0V+AzTnSWwuEW/bmha5VRs+EPSe+Epdbl6X8D8BI3GbvHifE8ggBpRxbO11uC9VAIoJHprFfG/8SdZ65nzOVE6gwYNJuVfT4yvJ3kMGTfXQh3qsu/ZmQ1zr1exlfrk0uS4nssF8/sbS5ZTe32BEHGqLqTOwTtU1xfGOL23j9GuI5b1/1JpVAf6ipljXoLhrghaLu6ucevaVrfpDn0p1kJbYh8cE38zL3qOXp9kyllzH8JFOnLYSA5c1+Y1HzT4uQTRall9KPGG3BYu4T0YFy7DhcnKl8bAzlunsJDdB+hiGPtKgxnyR7tbxx7TN9mhcQhHaqqfnSjc+deTh2ia7sbsavte2AtccYRx8dXByhIYR4WsQnuqjnkz/ZKzovQXu/k+HI/0MaJIjTC8yTTJkJk62m2Nk+MiF6X5mEgDgJA7reaggVweYRME31z2F2KuaVbAlBFuJCP6YRnLRiOHLM3nVZ9wp6StcCpreNnfKSuczhJKvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(2616005)(36916002)(6486002)(478600001)(6666004)(54906003)(26005)(6512007)(186003)(2906002)(53546011)(5660300002)(8676002)(41300700001)(6916009)(316002)(44832011)(66946007)(8936002)(38100700002)(4326008)(66476007)(31696002)(83380400001)(6506007)(66556008)(36756003)(86362001)(4744005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU56aVN0bXJMaUhSc1Eyd2Q1OXlkQnZnWEtaelFCNUZzNzluUTdwUTBlbGxx?=
 =?utf-8?B?MkJDOFhaRGt4ODlTUGxzQkM4c0dMeWtsZURKY0dPZGVPZ2taOXlWcDhJWmxu?=
 =?utf-8?B?eTU5b0twdERVT3ZZUXVLeVhmakEzZU9wby9VYTlQT2xKZXczTDU1RzVNOFRv?=
 =?utf-8?B?NmlMR0kxb2ZxM2NBRTMyRW9pcTROSVFXVVdxNnBZV1NPbkFmUkR5ZUkrS1d5?=
 =?utf-8?B?NnBHMWZGVzAxMlRBY3FJSGN2T2Q4U0QyQ3hlVlhDZnJPNkM5UTRoRjRoS05U?=
 =?utf-8?B?VnlQelJLL2tTNENuSnFHRDQ1dnMwTU8zNUZwWENFNEZ3MkkxRFdhaldPNGpN?=
 =?utf-8?B?NTJCdXhiVTRBR01vNHpqUGJZMG9yNUh4UUtIQ1pZU2F4Y205Q0ZFL1Q5VDIr?=
 =?utf-8?B?M2dsMjFmUmM3OGF2bk5BU0hCRk0zUUltQStqb2hRTUcxUWN2MkdJcSs2TWZ5?=
 =?utf-8?B?R1BuUEo0VFhhcWdRdUVxdU9qVTdTNGtUUGpjNEhicFZVWDNKWElFY2pWYlRk?=
 =?utf-8?B?cTlFbVpNT05CTnczYkhtMXMvSkRIb29idGhUTUlrY0xpWHpPMTlhVXdkZkxw?=
 =?utf-8?B?dFA2d0tJL3NvOXBNWkVEK2NCdWNKcjFyZFpvUTdhV0xQclhyRFJKQjFjdnR0?=
 =?utf-8?B?b2VWTXkyOU9ZSXlNMXBKeGZGUU5qaGNHbEI2dVVKNWc0WWNTWHlxditmekJo?=
 =?utf-8?B?Q0ZzY0JEaUtnYzV6N2FUQlVWQUtCbE45d29wYVNSaHVqRDY2K1R2K3dJSTNR?=
 =?utf-8?B?anNCZFdiam5aNXVmZGVqV2Jvb1JST093S0V3eWU5TS95T1EvMHZsNFhoUTlN?=
 =?utf-8?B?SHJwS1JSblhoT1hzK1l5OXpaaGE0VFVTYlE0U2dINnhnMkxkMTZZT050dTFI?=
 =?utf-8?B?RXMwUzBpNk1admk3SXhsOE01MVFYQUVNM2lMMGZVNVovTWZBbXJVclpuTVhp?=
 =?utf-8?B?MVlsTDM4cFVwbmlDTmY1T0Z0bmM5cnMxek5meWdjRU9Mc0JXb2R4Y2JxYjJO?=
 =?utf-8?B?Vks4TUNYMnF6VktlUjc0ZDROSHUzMjVLY1dBZlR1U0pHdTRERm1ndFZvWnhv?=
 =?utf-8?B?WHpzenVzYmd0NXlyNncvNmRHSS9lMFRDelRGUnBCeFZOSVBkMVZ0TDNON0dL?=
 =?utf-8?B?eldZQXh4MlVhSjFWSE03TnFXODljUGlXZ0hTUk9MREpzY01xa0ZSNVNFRVkr?=
 =?utf-8?B?V2FEVUZRbDEyZlpyQXpkblRORGtKaytHUklOUjJYYXpxaTdCM3JUL09Kazdz?=
 =?utf-8?B?SzJtd040bEV4WFBtOTQ1NU4zWEd6Vkl4VWJxQ1Y5eW50UnFONXh3S2l0ZnF3?=
 =?utf-8?B?eEFZRnJjUnl6LzRLN1BycUdhVjlpNXpuakpkTkxDVzZWN1ErQ2VVbFVOQ1Q4?=
 =?utf-8?B?UVNVVXhVcmVka25aeHpNVnhNVk9nV2JZbEcxUWZJZloxQ0ZvWVdnUHZjdmY5?=
 =?utf-8?B?YURNbGpvY2NCQkF5M1Q0Y1VRenZHSVhMNU5FWlpzdDA1WURMS3NxdXhmcGZN?=
 =?utf-8?B?cHUvcVhxQXVJZkh0cUx1S2dqeCsvcEZ6WDhWVzREeGNvTmFrMDVvQzRTN3Fx?=
 =?utf-8?B?c0dxMmxYcjRsc0twbUI2eC9wT01RaTRrbk8vRWtpWU9SU29PMTVDdkNidERv?=
 =?utf-8?B?SDcrVWJ3TWNqMWVPU0ZxMWZaOGhVSW9pTWg0TkdPMUdBL2dJdmNvbE03ektD?=
 =?utf-8?B?MG9ra0Nod0ZQanNNQkRTUnZCOFhUSWdDWUV2cG1KMWlWaWpzREZFMko5TUZi?=
 =?utf-8?B?QVpZbHdOcndVaGRiUHM1K3BlVU5zRDRzZnloMGNGc1dtdHVvamwwZzNiUUZi?=
 =?utf-8?B?TVMwSU9iY241TllydDMxWGVJblpOZlg3Y1hyL1hFMTB6NzM1SWZ6MU9SWUY4?=
 =?utf-8?B?TTlIL3dhMDZzUDk2aFd0blpDZERXUHBoTU1Bam1YbzRQbms0ZE4vYzI1UGNl?=
 =?utf-8?B?Wm05M29HdFB4aEZHbHdVMk0wUVM2QnJPamJXTVRwYjkxUzVZUllpNndhV2Vh?=
 =?utf-8?B?NkRVUDNyN0JjZWoxUUx3cDBkYVpxK1ZtWTJONkM3Mmh4aUppVDhqeW1HMlJR?=
 =?utf-8?B?d2J1SjRMMitGeXduNFNNZDg3WjZlbW1oSFlsd1dDT2dFSU50ajQyT1Y5S0Ju?=
 =?utf-8?B?VkhUSWRCN0VLNU9aN21yNFY4aWJpNU5rTkk0bHpZSCtuUzBEbklFakRGY2ZT?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BGlUbYI0fmcBnj/LiFxSH4o+XiLKPPPfNSRHUyyRpKpN9oS9EPFq/lSQcXWmHjYMfEbguVQf+bMa8u7O5ppYJjO7tTnT15CTuRK+PahpTVSdDb+QcXRmQZd2p3TsxgEQwO/mKcTPCqWgoarAZN94OQBdIlou75wklGFJwPRH9VbUQkrXhHObvF+ctP4ce+bEfZr5QQLacrzbjTQPh5rvpDr9rrqjjlYu8EkeIAIIjXWyZohyqSiu385ZKIKjw9H6H8cgni1RG7ysIzrQ9Ilm2NHIPP4t+iv5RQBEuC6mEsRFZb8Wl8ACwgsFjf5A9Rd27caF8oLKcowF11ZdHap0Y2xjm0qbyJDHAqsZ2npFUy0wr5MZhXABpSENNJ2TFR0MzM4qoiowL31CeYb6dHV2o7vhervHn9edvfyb0Ys/Ooue0a++YRjdAT9jy8RhPMIKKWC5ScBTOZj6RJojNOwpBQOl5xMRmITKic1zJmMQGO+Vx6M1JPMOWIlI/D7WhtApM1KWrtQ7v5xpC6bJRfQFox6P36c0sFwkO2b2hdV9LhTBzkvAzkIB7/7ECd2OfmKmtWmg970dYILUMokzmy381k8kGW6sPniDqpSvcqMumgwJtvMhZXa2bHZ9lCaLtM138hiVHWRCERgPlYi+Fdjc4SH7zZwqFgz9BPMuL8/VLOoDO1ksExJJpr/2fTP8gIWfF4SCNTQdHD7KZK0EdtVAlUxjt4DAV2tFKuzVBvs3N4FV/XVZtIP9C29k+GRCIwN8T9p3ez/zwM8MOD+ZeSDnuA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98fa501-7fb2-4e61-11b4-08db7f2edf12
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:12:29.3270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKqOxT0qqMhNmdutbU2txatV/Nwlgwh4Rvs4D/tuqe5oaSSfxOY/mKwED7Tdoasqyn3iLVW40wsOH7DCaOJPidJSMMH+WwHNcT4+s4W8FFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_14,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=855 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070194
X-Proofpoint-ORIG-GUID: 7SqYkjZI-i3tGj5YdEbzVuKwMc_6gLor
X-Proofpoint-GUID: 7SqYkjZI-i3tGj5YdEbzVuKwMc_6gLor
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/2023 5:02 PM, Peter Xu wrote:
> On Fri, Jul 07, 2023 at 01:20:48PM -0700, Steve Sistare wrote:
>> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
>> reason.  This allows migration to own the Error object, so that if
>> an error occurs, migration code can free the Error and clear the client
>> handle, simplifying client code.
>>
>> This is also a pre-requisite for future patches that will add a mode
>> argument to migration requests to support live update, and will maintain
>> a list of blockers for each mode.  A blocker may apply to a single mode
>> or to multiple modes, and passing Error** will allow one Error object to
>> be registered for multiple modes.
>>
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> What's the change comparing to v3?
> 
> If no major change, feel free to keep my R-b.

No change, just a rebase.

- Steve

