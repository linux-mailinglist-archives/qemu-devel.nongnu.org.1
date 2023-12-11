Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 138F480CB29
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:38:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgTe-0003Vc-0i; Mon, 11 Dec 2023 08:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rCgTb-0003SR-CC
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:37:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rCgTY-0003Lc-RD
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:37:39 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BBBn008013587; Mon, 11 Dec 2023 13:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=W8KUyvfeiUyvrqsoJDwhlWAATKdRcgUVUL+oXuVKrNE=;
 b=T5a26eE7oANhei7Sc1Mi2FyZFPyVMt9zTimkZfhDN6UmMd9SWdpVVs4VXA82AKFuCENB
 7B5tQa9daJttIaQtTiwtniWFR4NIaxmqIVVYiRgtxwgbU3tii7YOs1Omwytr0/13XdWO
 yhyrZpBMLTm8JvJxshqx49kfHsnpLDMzc8vbeEo9lPVjuBenGKgSrjY8AOpO0JQ9Q9yx
 Avyo+40AUoP8HlPImHC5qsuBlqYiZpRtRKO0pe9f4q9D8DP9dTNuXB4ziPC1egOvUZGm
 hvsNx1Uvyb8xZvi9Lq6wflDi5oj3g52npofdga/OMIxUrs1bXyiD28WqLg0HDZdZscFV MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu2x9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Dec 2023 13:37:35 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BBDVPA8028510; Mon, 11 Dec 2023 13:37:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep4xuab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Dec 2023 13:37:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdCuHds1F8DNeqAgDqrONwO7p/oHfhtyyRtaiEc5ZSzwE/R8+rj37NF99waUS6qgZOcTFZWmCLvg8nwpVLlthCjHqewXf2G+G9gDZjK7azGEHaAJEowSzS84RObSXc4DmY7+quqERTmQ+aPMfmKlM92dBAyWqIU9wrHjD05LJUU/1eisn/lxmFdADJyRXLc4jj7wmHIvoo6X/bvsl3ffDWqIBdy39aQGpARtcn7omWDlZd4zhB+LfebViWYm5ayncWL+SF0PruaQT3FYp8/T2KpKwzwGXbFQEvwdZi0AblHy1asRP11AoZaUSNPpPpbPyJUEXdjNWaSRxhlcMkV8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8KUyvfeiUyvrqsoJDwhlWAATKdRcgUVUL+oXuVKrNE=;
 b=ID/N79oRMkSr0GgYWnOM4OeJtjpOLMf0Xod9HAXzTLMvpBDjKogGUOAJh3+31e6FJWI45btR1qL+FW9MiZMryyBdjyWorXiROsCLYr0L8hN5WIrkh+VskVu+pnRfK8hLfVSkgw+A2dLlW0GgA7j1qSJ64EE3MFDKxNERe1Yd2ZrQ4nu3ZBp6K7SN+UcNvsxvFFz6OtunfkcMgTcywnkTD75BO8XTGb19sqFcMob6hcHFHKUMxyqFIK7ozr4SJIeffuAbQQ36j73ZloEsL+gL/IKG/3z3MK8odCWiZas+AV+hykbl0TF19XojoD3VvDxUxLCmNBOk/8SR43RM8rspKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8KUyvfeiUyvrqsoJDwhlWAATKdRcgUVUL+oXuVKrNE=;
 b=B0EwYT767qPlBpM3jvB/+KYMX3T32DYxIHfyoJNY8A1tSkXrBDDdj+Lgd4I2lMTMLXN6n7a1LMRoxThyGd3Uh428ih7x8thRG0Z/FmNhSNK+SsIIcu1n+flCpOSDbJQiZvczO3jDKo5F2/uldcI1huzW+Vhk2ytic44u+O+Z7Ws=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:37:31 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:37:31 +0000
Message-ID: <bb0008df-f38b-4c31-9208-2174dd6a4a13@oracle.com>
Date: Mon, 11 Dec 2023 08:37:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 02/12] cpus: stop vm in suspended runstate
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-3-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1701883417-356268-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::7) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: df2c203c-1afb-480d-e466-08dbfa4e530b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjjncotdcMFHVe2n8jKNjPCYW/+oTvOxHA58wffnz7QBOE2hMXT8pQAu8XjumwDMcrpZ3s8v5iAoUZfoAs6KSgjo38STdH2w857abGdNnxovHvA9Hg0Z/hwuFOSeTUM5tjeppuc1PEJxgiRIZg8M74zIzcxRnsAR+y2sKW1zPDMnA+0znyCsGdqlF+v2iJVc+wMcijO6/aB88gBETIuhKeBeLsrSPrz/ZICvYFAUVqiMRFO9GH/l5hUNZ7WG/Uw18WADG0vng2VY4GAFxgr2fMc4uZJXXl8wMdIJWWVgKgpPnFfpZ8g3HzdJGmKklaK7ZydOGMvsva5oquJbV6M3MuBT0qtudk89G+PY6Jb+sG84vVWNq4f5ALDQgGHNvcriPfp2Yb1T8BzP0KO0KshdwywSxGershTGrg+NN+YTcvy/LlIyiWcRMSIEYDTYSHKhtagdPTwLN+YC8XaOtsVSerhfiW3+iZ8+tPts1n/YSPspxkdylg8uYZ5WKYBTL64ka+5kQG3/u0Cht0Rglt0ok4DpbDRNqkJGtnOEVwy+ttZyLhmjJGrwSXi/lmlrK3+zmjgCt4CQgqa3X2lhm1zxW42n7Qh75BG3yP+4INnmW43YQb+h5j9Br0QbTJNLHxGZql2yFQPCe7jpEToK0qw2zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(44832011)(36756003)(7416002)(66946007)(6486002)(54906003)(66476007)(66556008)(2906002)(83380400001)(31686004)(41300700001)(478600001)(86362001)(36916002)(8676002)(8936002)(4326008)(31696002)(110136005)(15650500001)(316002)(38100700002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtJQzJOU3p3a3dlZm5GYlluM3AyL3NmWkxqeVhPa3p5anYyMzJhdmlnYkdp?=
 =?utf-8?B?TEpnaFFTcFhkcmppRlN3QnlQNnFKYVYxUDJWaS8zZHlrcFkxWmtYaWtVS3RD?=
 =?utf-8?B?aDE5dTg2NUtEcTJnQ1ZjTGt0MDNKY2NQdDJJQ3RwQzU2cFpYRUNrM1Q5a2lB?=
 =?utf-8?B?QUEySmgzL1NaTThiZldlUzRjUGkySnNHR0trdnREQllUR1ltUFRIWkNkTThp?=
 =?utf-8?B?Y2psclZaYWdHN1dPQUprM3ZMaTduVlA2WnI1MTZMblI2dUhxc082NmdpVjQ4?=
 =?utf-8?B?UVp4TTg1UGxZenlUQ0lUZ0M5aThueXRXVjFsaVBEY1A2bEdNUkZHUk1neFVW?=
 =?utf-8?B?U3liYmMyNTZHbjY2V01ZbW1SR1hTU3hmNUc4TzdsUlFLcENFN0ZnVGlIS21L?=
 =?utf-8?B?QnpDUEptZjlsU29VQXJHN3RFMjBnRW8renNaRUxiUzFWWlo1dEtzNUFRa2cv?=
 =?utf-8?B?YVZEMTFWTUp0NWUxMlF0eUpPTFJoNU5lbzJnQkd5U2hYL1NaVVk5WXVQbmhl?=
 =?utf-8?B?TEJKQ1djb21OQktuNEVpRndKUmwvZTJ0ai8wZUJKalVTK1g5Vmo4SkZtMmlw?=
 =?utf-8?B?cjJhWUMvaGRrbjZ6Tmdsd3BabjFCTzAwZXkxdlRJRWVvT3hXdHBpME52eXMz?=
 =?utf-8?B?ZVd0cjhuZTNDTzFTazdWMzVIT2xTL09LL2o3bkxzdXMwWUVZTHB6MG5UcEFK?=
 =?utf-8?B?ekZQTnRuTGN3Ump3dys5aHhNY3JYcFN3NGx0SXZqMG1ZeTRxczdRTFZuaU5B?=
 =?utf-8?B?UWdlTGE0Y01VYzRNN0VuMmRNQkIxUXZhYnB2UEtqZ3Jwcng5UEloNm10T3NK?=
 =?utf-8?B?YjRhNGRzQWdBdzc2M1QwVXhHVHpPWjhMYjVpZFhKeU9YSHBnZnNjSTVqaVZ3?=
 =?utf-8?B?ckxMVVpqNkkvaXNYalFSMzBIRHp2UFR4RVNjY1hKUTVoTU5ndE96VXdBejlH?=
 =?utf-8?B?UHhwaU4rblJIM2dXSnh0MlFrM0t5TGdXWGdGWnNGSzV3eVV4L3hFalV3QmJW?=
 =?utf-8?B?YmRaQk5IcFR6dGFNWDRqdjZDTENnMk85MkRqSnU4NGM0V0pOdnQ1UHJxU1RT?=
 =?utf-8?B?amNDRHVuTHY3Tm5WWmo2dy8vNk5uYkVjaVVzMmpSRlVWK2Irdkc2NlVlcDNF?=
 =?utf-8?B?bHJVZ0pBcTdULys4aDRLRTJ0dS9hUmZTSkt1R3ZXQlJiMzR3M0tMUUM5RDMv?=
 =?utf-8?B?Z09QeXllNVpPOVpsY2ZPaVE1Znk5WkFSSllncTFMa2tuL20rSEtOYms5TGIv?=
 =?utf-8?B?MHhKNlB4cDNiUjhqa2VxS2ZwY0ZpVzdydnpoOTRtOHVFaGQ0TXRqT0t3OHkx?=
 =?utf-8?B?RldwOUJwd3lhT0FDSm16YW5yeks3UTVqYW5QMXIzV09Oc0JQa1lxVml5a3RO?=
 =?utf-8?B?UzVXWXpkQWNZU2ZaQmRvZEVRQTIvc0FlNEllNU1yL3Z4c256cHVZL2QzaGhs?=
 =?utf-8?B?aEVmaklKancrVkhkNC9aNE1oV1dKNjUvRGxVT0RiNWg2VUdsbXNXQlB0REtF?=
 =?utf-8?B?QVdtb3VxUW0weUlxd0w4cTBmUy9vYVQyVlJybEczK2hKeFB3cFhQbGJ2WTZU?=
 =?utf-8?B?R3lUTmNRSWZFd1cyVG9PMTFBTkdqUi93UEwrWWw4eHRPempXMHpWcWtPZ3Y2?=
 =?utf-8?B?bWQxVnhjcjU1dlpJMW9MTTJsay9uYkZDMWEwaFJieHVDeGJ2TTBHdkZnQVNL?=
 =?utf-8?B?S0RFSzFYVzZXOEVpUitMVEczYWZVZ2liUlV0VEs5RFB5RDJrYjFWQms3ZHFq?=
 =?utf-8?B?REdSZkViZktwTGFJLzZtb2wwNzlNYklpZmZKSlozcy9JeW9HOXkvY0ZyTEI4?=
 =?utf-8?B?Ulh0U2JLWHlvQ1JQZFQrcit4Yy9VWmpSODM1RW53aEc1NlJRL1BlZktCUzEr?=
 =?utf-8?B?ZHVVK1ErSlpZWUl0N04xQmlxYVJ4bHNmMWIrcE9DbkpqN2ptMHZ0dWRqbERQ?=
 =?utf-8?B?WXUzU0xrbURIa1MyVGdzTGVnSDk5WStuYWtndzFjcWtHQS9DSU9vM2FlTnVk?=
 =?utf-8?B?MFZiSHdIUUhMa1hmVFQrR25KMTdjWW9Ec2E0enBEV2NCMDFSSjFTQ2JwVnRm?=
 =?utf-8?B?d1Q2bWJ5UWpCdFJGaTVXSElNeGVnTVhPemRCMjRLbXBhYnlyRkI2bllHeERT?=
 =?utf-8?B?QXJ4SnN6TGpFTUNwakU0ODFNSDhNNy95b3QxM2Z0Q3lDTjBlU3BraGo3cUhh?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dwFmV1mfm/LDWuRPuQL5TAsKCVidggWL6qkw0tg+Ja/xCqvTJ4OXB/olp4d+4lIvSylyCfOhfvZwkpysS3ZpCfiaNBE4BAWm8ERKt9g/6xAo4ebekK6XXtvXELVPrDClU4wJT3C0sjOYiB5z3azmRS4rxw2MzS+sxlRmJvu6tgI2L0C0aSW/MQqM5yL/q1WNHR2pdUhTvsVPZiY2fGMUJ9raEyzZF0BVvO66n/lZPQSViAm6DwS2gIiIbjShuLGZB/HEEjrwxvMJuU2o88kupM5sw498jk9AWgEW+xPKuNOFsuEEL3y9iBO9JDjIji2YuwPSJmBANm67ad3fm+MoSThi8EUNOLZmz4oxcD09Wj23U3bu7XOQY7e7D/ZeZBKlGpl1vflEmkEvw4EH6Eqj3BbeDW04J6XGyCf9T0nt2IybFWmNr/4lpn/35S5wUojb01GonNdNulqRjv8K5N7F8zMYGz8jvShX0C/FjEHqhl5neULZ9SwAv3VP2OSEo3xJgoTjW7bWtIFzN8AHMmspMoJ9wLAups+gkx+xFQTQQkGPjYakEfayO2lV3BsZdVkVtkg6gwP9cROFFpXqjuXf+KjqXV4J+Jwt7OXPWkzTwgXU5k+URzlh3wjpChNtuRBjVAz0xWeZB2jOoCFubatca1NZq9+sMLX7iIqogFOSu7GUyfvk2aZ6l+o9D/etVyY01B0yoO9Bj9JBPJOkRiCTh8L88HUnMJYZKAtWjHsiVQhUXCDioLQEZjxHa2R4jnAa1qJaK2uBEJEakFZl6hB2YmuwXMDaLOmI/uAq+iRXkOBobCPX5nl4wL8kI+ZcOhOZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2c203c-1afb-480d-e466-08dbfa4e530b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:37:31.2072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFAHskD1uiPvJUhpR8rHNYDS0eN4XjnU3x47zpR3BCq/POnR/tn2z6WYwGHxlJOKJTvVwQ349D1VEVcC04Io1G0rWn2oiNODesIB6V49qhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312110111
X-Proofpoint-GUID: 5zRyA6f-a-0DF1HhqRiKOdVxPd73yDU3
X-Proofpoint-ORIG-GUID: 5zRyA6f-a-0DF1HhqRiKOdVxPd73yDU3
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

Hi Markus, Eric, any comment about this change in stop/cont behavior before
it gets pulled?  There is no change since V6.

- Steve

On 12/6/2023 12:23 PM, Steve Sistare wrote:
> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
> have been paused, but the cpu clock still runs, and runstate notifiers for
> the transition to stopped have not been called.  This causes problems for
> live migration.  Stale cpu timers_state is saved to the migration stream,
> causing time errors in the guest when it wakes from suspend, and state that
> would have been modified by runstate notifiers is wrong.
> 
> Modify vm_stop to completely stop the vm if the current state is suspended,
> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
> Modify vm_start to restore the suspended state.
> 
> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
> cont commands.  For example:
> 
>     (qemu) info status
>     VM status: paused (suspended)
> 
>     (qemu) stop
>     (qemu) info status
>     VM status: paused
> 
>     (qemu) system_wakeup
>     Error: Unable to wake up: guest is not in suspended state
> 
>     (qemu) cont
>     (qemu) info status
>     VM status: paused (suspended)
> 
>     (qemu) system_wakeup
>     (qemu) info status
>     VM status: running
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/runstate.h |  5 +++++
>  qapi/misc.json            | 10 ++++++++--
>  system/cpus.c             | 23 +++++++++++++++--------
>  system/runstate.c         |  3 +++
>  4 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 88a67e2..867e53c 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>  }
>  
> +static inline bool runstate_is_live(RunState state)
> +{
> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
> +}
> +
>  void vm_start(void);
>  
>  /**
> diff --git a/qapi/misc.json b/qapi/misc.json
> index cda2eff..efb8d44 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -134,7 +134,7 @@
>  ##
>  # @stop:
>  #
> -# Stop all guest VCPU execution.
> +# Stop all guest VCPU and VM execution.
>  #
>  # Since: 0.14
>  #
> @@ -143,6 +143,9 @@
>  #     the guest remains paused once migration finishes, as if the -S
>  #     option was passed on the command line.
>  #
> +#     In the "suspended" state, it will completely stop the VM and
> +#     cause a transition to the "paused" state. (Since 9.0)
> +#
>  # Example:
>  #
>  # -> { "execute": "stop" }
> @@ -153,7 +156,7 @@
>  ##
>  # @cont:
>  #
> -# Resume guest VCPU execution.
> +# Resume guest VCPU and VM execution.
>  #
>  # Since: 0.14
>  #
> @@ -165,6 +168,9 @@
>  #     guest starts once migration finishes, removing the effect of the
>  #     -S command line option if it was passed.
>  #
> +#     If the VM was previously suspended, and not been reset or woken,
> +#     this command will transition back to the "suspended" state. (Since 9.0)
> +#
>  # Example:
>  #
>  # -> { "execute": "cont" }
> diff --git a/system/cpus.c b/system/cpus.c
> index 9f631ab..f162435 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -277,11 +277,15 @@ bool vm_get_suspended(void)
>  static int do_vm_stop(RunState state, bool send_stop)
>  {
>      int ret = 0;
> +    RunState oldstate = runstate_get();
>  
> -    if (runstate_is_running()) {
> +    if (runstate_is_live(oldstate)) {
> +        vm_was_suspended = (oldstate == RUN_STATE_SUSPENDED);
>          runstate_set(state);
>          cpu_disable_ticks();
> -        pause_all_vcpus();
> +        if (oldstate == RUN_STATE_RUNNING) {
> +            pause_all_vcpus();
> +        }
>          vm_state_notify(0, state);
>          if (send_stop) {
>              qapi_event_send_stop();
> @@ -694,11 +698,13 @@ int vm_stop(RunState state)
>  
>  /**
>   * Prepare for (re)starting the VM.
> - * Returns -1 if the vCPUs are not to be restarted (e.g. if they are already
> - * running or in case of an error condition), 0 otherwise.
> + * Returns 0 if the vCPUs should be restarted, -1 on an error condition,
> + * and 1 otherwise.
>   */
>  int vm_prepare_start(bool step_pending)
>  {
> +    int ret = vm_was_suspended ? 1 : 0;
> +    RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;
>      RunState requested;
>  
>      qemu_vmstop_requested(&requested);
> @@ -729,9 +735,10 @@ int vm_prepare_start(bool step_pending)
>      qapi_event_send_resume();
>  
>      cpu_enable_ticks();
> -    runstate_set(RUN_STATE_RUNNING);
> -    vm_state_notify(1, RUN_STATE_RUNNING);
> -    return 0;
> +    runstate_set(state);
> +    vm_state_notify(1, state);
> +    vm_was_suspended = false;
> +    return ret;
>  }
>  
>  void vm_start(void)
> @@ -745,7 +752,7 @@ void vm_start(void)
>     current state is forgotten forever */
>  int vm_stop_force_state(RunState state)
>  {
> -    if (runstate_is_running()) {
> +    if (runstate_is_live(runstate_get())) {
>          return vm_stop(state);
>      } else {
>          int ret;
> diff --git a/system/runstate.c b/system/runstate.c
> index ea9d6c2..e2fa204 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -108,6 +108,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
> +    { RUN_STATE_PAUSED, RUN_STATE_SUSPENDED},
>  
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
>      { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
> @@ -161,6 +162,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
> +    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED},
>  
>      { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
>      { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
> @@ -502,6 +504,7 @@ void qemu_system_reset(ShutdownCause reason)
>          qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
>      }
>      cpu_synchronize_all_post_reset();
> +    vm_set_suspended(false);
>  }
>  
>  /*

