Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8367083E7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeYU-0004Mz-1z; Thu, 18 May 2023 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1pzeYO-0004Mg-Un
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:24:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1pzeYM-0007re-M0
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:24:28 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IAiEs4008399; Thu, 18 May 2023 07:24:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=ntgE2g77VksBLZNt9nPQxq1r/1U72p7Ukc1ZEYw3XoQ=;
 b=dPORY86L2V4tRDi45fVgVK94eswAs88yp7ZVSNIs9ctOWJcus8wUp7Y9XZNFoN6rn1TE
 Dt0NG+T0P2uxib5dyFd4iEMcjyVNQk+hMcVGi4ArAl7vZh5zV+B1vmQprozVS5SlhoF7
 TauOtSjM/54rUhqs1N1NCteEXrSMTYrs+tPNJDp69gQdGYAHP4WYLjVJJpC2JjHEUaVp
 ek3f47+2ATEGbC1+2he3RHQPoix0FUnT9jf2MsozDanu8G6N+GYxHU39k7byj4jz8h8y
 BnNVyIByufL6c0AoknqlyiND4tKHhgdXvz9BVFNtyxSas8rKBLcOAcDAZ+K3LCW8Tjqn Jw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmvu7b3up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 May 2023 07:24:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9/ioAKgSsmvnTT7K2vBzc8SY4Irl8Qa7Un+1heP6GC+bEKEbWiAxRA22J96MMVVMvpveDuTXZwWD+sB5CrgLatGf+w0B0hVjUuzmIUy8qJ1hcZJi+GGKAWD4TX9FeGK7gegkvLh0kvfnFLk63bz5ty2UH+oG7jSfVsGdeErpe08mVPq0McW+POrDkm4CAcLauP7aSDs6QyqWRITKs/WBe3t96cTnC+cEqwBYAABpkwVDMdFTbzBrpF+6sBxd9q2MKM15ognYFGW37WfxstgyooEa7nlJL/uEYwp37ESfs9+ZfoI4E9FZmHRAC8W2+W4v+aQLQtF1DMvEk1PotO3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntgE2g77VksBLZNt9nPQxq1r/1U72p7Ukc1ZEYw3XoQ=;
 b=SruHFrnQDO9xCi9UyjHcAmr9hsHAwceVbH5RuQ9wUXT/2su3+O/GJM0+04hr3Op89rn3z7aE/saziqVH7P2+KIuw88nQWwK5IyzcWxa3GL4QLDnyHJyXw6C8bgzrl7rxlcCoIGfwaPsdcUqHgSKR+e+N2gOGUSZonCJn+U++mKiykp30+Mc9itnrWXw1lJg+dJeBgUZqy6CjkwDKv1q86vqBjiGFHdponTZRpfC9v3QeckAY8JqB+BOiZumYsLQW+do0ch2pNMqjW5wwl5ZA4680n8ENqvQiti1H0llDIjgdrFR5/kau+q0AVB+EPAS4esa7a7izUSSbKiXKyoa/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntgE2g77VksBLZNt9nPQxq1r/1U72p7Ukc1ZEYw3XoQ=;
 b=mPiqY5TBtTx536N+H7bsW+eEkWs4TtIrJMAVEi5l2GYs0iOGjT6HM1BP+FcXsxzQW1H5WtprABZbRhiE5luuEIf0KGSuFaqm68L8kdMYopWEpxsJqy8z6QrbNYttfS9gGLQ+ZB4hhJ5s86I+I/XfiquKf0N839CYLpcg/Gl76Z0wmanLVbltiD8eWLqw9H6lptsC0KXuAYuPgbALI8MRzHKtnlshrM9fcaOhS5CZKHiy2AEPopo51AU2zdtXl5Wuf0lF1gkl8ZAjglTge8GPP1DHkEiT78iPzy4cp1n4rDRDpk8VxeUP+JIIKSasaFd3z0mNRuhGWhNpu0fY9j7r1Q==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CH2PR02MB6540.namprd02.prod.outlook.com (2603:10b6:610:34::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 14:24:20 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::cad7:83e8:9ee:87d1%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 14:24:20 +0000
Message-ID: <85e292ed-e458-75ea-3e21-7cdc282b09ba@nutanix.com>
Date: Thu, 18 May 2023 19:54:06 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC v3 2/2] migration: Update error description whenever
 migration fails
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, shivam.kumar1@nutanix.com
References: <20230518062308.90631-1-tejus.gk@nutanix.com>
 <20230518062308.90631-3-tejus.gk@nutanix.com> <87ilcpdfg0.fsf@secure.mitica>
From: Tejus GK <tejus.gk@nutanix.com>
In-Reply-To: <87ilcpdfg0.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::23) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CH2PR02MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 987678b9-f9cd-4595-f080-08db57ab919d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXHS2zhn1vm/wKh7tp0KgH2qjJZMsS8TFE8nKyD3CfyAtiCXcoMI9CTZ4kuVV9eU1AZAXSxXFTqgUX6KNP2wwrpXKhzQyfKoa60fO4XYv/OQPDF1NXb3sTXWZKYnaNRz4BNY7HlMN+9MN88NFlDUrTkFkSFD/VYNDR9AF6pD0OAd0jjZimctt9cmpjSl7sOFMjyHSZVCJN6AeiLZgthlKUGG+7i8f1NN18o1uyMJpfJjASHF7MfR8ICKGZbqEDtu9UvcTeuc2DYpgDkhVIbYez69a5le9yoDLXzM1Fsy2rI2xl/COwbI8TmOoL7PZAhxSiBvGIRmU6Z9a2rvuTvo2rFApK7AFf2anoqpZfjm5KzindWsVWDQ+5n0jQ+3KWEZexFNaVly+V1YBs7DVafEr/dQtyN8dMluoPvPvu1uvqjH9C5DahafhrK3DoS/E+EniuzfO+1qwq5i/kSCFm6o+nuxDHtzDSBvfWU7wCuNU9XgYt4BiUOto86gpDivebGdbGk7JD9eQzJbDAgrBA6YSc7pvCPsDgiiaP6RIPGEytjmizzJ2lvxd70nx4HL787nhCSYJ20a+d1bNSASw5D1jAg5RGq65B3TPUMWy5dMRrfN0YBKJDuMa8z1QfRoZwi4k11PkG0CBpwJwpZMaLZMO5YWwtBUqL1aJmAkvBGCBgskKpsVjMB/FztzLEUacFXe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(6506007)(26005)(6512007)(53546011)(107886003)(52116002)(36756003)(2616005)(31696002)(86362001)(83380400001)(38350700002)(38100700002)(186003)(478600001)(316002)(2906002)(15650500001)(41300700001)(5660300002)(4326008)(66556008)(8676002)(8936002)(6916009)(66946007)(31686004)(66476007)(6486002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtIUUVjcHQyZVFKUVpwU3V6N0pJNDZxUmRLdVJmdTZ4UVRtdUdmUzB1K2ZD?=
 =?utf-8?B?RHJQL0V2SFFEVWcwODFZY0o5a2IyQThpVHlpRVAvVjl2bkpYeUtTOExiWTN4?=
 =?utf-8?B?QmhyZ09LRWFFekVJc0IwWFlYVzVMNHltOVlKdXpyWlAxd2d2WGJ4L2htc1NO?=
 =?utf-8?B?NVNrQVJyTWJxY3QvRytGdzJNRUY5ZFc4TE55Mk9DQktaSlgxWVNxdXEydVMx?=
 =?utf-8?B?Yy9rSUN4VWYyRU9ydUNmV1BZY2lWZncyR0txTlZJZFVvejY4UFFZWGxWUXVl?=
 =?utf-8?B?UnpYaWVjZXpndHNyRDJpTVZWSmdybFZwemwyNFRtcFZiNXZFcXVGNnpnTU94?=
 =?utf-8?B?amR5WitUMUkrajJXZklCY3BXWU5MTkhpazNTcXlmWjdHL25KcUhZNW1CcG9Y?=
 =?utf-8?B?dnpxbzFQL2pXNG5ENThxMlpFNzdLcGlsMFl4S3ZBVGpMRnZHM1Uyb2dnT3E2?=
 =?utf-8?B?Q3V2WXRhaCtMSXZZL2JYU0FRWkkvTDMxajNYbGtYaVVlb1NNZ1JHWFRseUlE?=
 =?utf-8?B?OXZmejQyZXVueFlmT05RNmp3MzBJUmYxWndydGhJUmNTZnAvRzRTQjVjaThH?=
 =?utf-8?B?TnhUeDQ2V2FlRWFmN1RqeEl5a3dvQ1ZENkN0MVNXU0FVcmlFS3plZWd6azYz?=
 =?utf-8?B?cHZUQ0dOTXVCSnlDWUZ3NVhiaVJQMWtxanUvL2NITVhIS3QydkJCQjlZcElU?=
 =?utf-8?B?ZUd3ZjNLNjlpbjZjTlcwVTM4Y2pSclVNcjdla3BQZEVzb3FSNzV4L2Q4TDRI?=
 =?utf-8?B?Zk9SbXVZMHZSMEsvQ2pkTG5EUTB3b2swZHhNTnk4Q1hNSzQwS3ZrVGNmbitE?=
 =?utf-8?B?OVpiUEg3TmNtUU9TRXFmVDdpM1hPRW1DNG04T2doQkNML0tJcXZjUVdJUkkx?=
 =?utf-8?B?MTNvMjQzQkd4aFlJdEx0K2o4Skd4Z0JEUUc4UXVvS2Y1VHdqdjc2bGhtNHRr?=
 =?utf-8?B?L24wdmJycjFvckpuMkp2R3NpcUltWEE2aU5oRGFZanRjeGZTR3RZYTRpaHYz?=
 =?utf-8?B?NHU0c2FZZE5pWnpVcWQ0eVFYRGFXa1Vxb1dDWGk1aURzaHhuMnl0dXcxMGxq?=
 =?utf-8?B?ai9hOGVpMDBPdkluSEFyRUpTbit3YldHSEQ1RXF2Q1p6MlllTTd6MkJqWFl4?=
 =?utf-8?B?MFBPWXUzY1kzWkJHOFpHVlNDRjI1RWpWaHU0NXRGSmNCcFFPUGpwVmVhYjFx?=
 =?utf-8?B?WXlURWFsa1Rxc2l3RnJWcER3aTJpM25nQ1FYSXN6UFE1bGEvQWY2OUcyekZV?=
 =?utf-8?B?RDgvbVVRKzZPZU16U3N6YzhodTRpUWFXY1BZR21ybS9ZVWt2SXZQRGcrYUZ3?=
 =?utf-8?B?bGtCblhjSndRakZJOGl4ZWUzYU9lN0hVVHZlVWMvRUFua2tUNHpWUithNld5?=
 =?utf-8?B?NXB1cHpXcEhZWTdhdmlXMkJuVHYzVU9pcy9lZGpSRnpCdzlDS1dKS3QrS2lH?=
 =?utf-8?B?OWs4SFVzbkcrZVV3QThoczU1Tmhudk00d2pJVzZnZTFQeSsyMnZaZ3JpMUxw?=
 =?utf-8?B?VXRNYmtBVkFIdXkxQW1JeG4xSjdzczNUNENqMWVtVmE5TzkyR0hFakJOSC9w?=
 =?utf-8?B?a3lTTHpSVWU0RGFGQ2J5ZWFmajFwdVBVMVVEM3krOHlJdkhsdUliS1BGdG85?=
 =?utf-8?B?WWxqcmJxMTlXT0lhRjBsdGwvNzduUFlLTEN0UXd0OTBmN00yWjgxQXlzZms1?=
 =?utf-8?B?cWlDMUljRWxJaFd3dWpZOWxTcDBPRG5jNmYvM0FvdWEvd1Z5MnJBaWwrUlRr?=
 =?utf-8?B?WUpTSlNtZHVpVCt1ZzlrZTJTQm9xZCtVbmxQTTdYZlhjbVRob2pkYmpPckJL?=
 =?utf-8?B?a0l5WGszK2dtVC9ianEwUVVsYkRWd2s0MXBhclJ5cU1rVi9manBJaHVZSGI3?=
 =?utf-8?B?NXo3d1BaOWozMk9uZGpvOGdSdGgrS3c1dHJLanNERHVhcFk5cC9YYUg4emlS?=
 =?utf-8?B?d2lJMWl2QWI2a0ZUVTl5RmtML3kxQkNhOFFyNCsvTTNpaDRWLzV4QWo3Mitj?=
 =?utf-8?B?K3JFYmRKL1c1bFhVRy92S1VWNTE0UkJMWUJGd0J3VG1xdGdGbDdyZmNKTHl3?=
 =?utf-8?B?aGlpOWhJaURObmRDUDhlZTloTy9TK25rZXFBTEFQMGYwREVnZ0EzTDk4czZF?=
 =?utf-8?Q?RzQ+s1amezYkWs+Mb//3JOQzT?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987678b9-f9cd-4595-f080-08db57ab919d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:24:19.9756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YaSu5I9yhQuQLmchOCaneBCv/zqQ0ev7yLhn/r6hn5It+R02acApW24vZGiU3+NpoMn+eX58IDIfVe5OxpRMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6540
X-Proofpoint-ORIG-GUID: cTtjCb2ZNPEslnpJq2gsRy0BYHJu_uzT
X-Proofpoint-GUID: cTtjCb2ZNPEslnpJq2gsRy0BYHJu_uzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18/05/23 5:22 pm, Juan Quintela wrote:
> Tejus GK <tejus.gk@nutanix.com> wrote:
>> There are places outside of migration.c which eventually leads to a
>> migration failure, but the failure reason is never updated. Hence
>> libvirt doesn't know why the migration failed when it queries for it.
>>
>> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thank you for the reviews Juan, but I believe that this particular patch shouldn't be approved yet. I have mentioned it in the RFC cover letter that the changes in this patch, in the file vmstate.c, end up breaking the build for a unit-test, eventually breaking the entire build. 

I was not sure how to implement the error reporting properly in such cases, and the aim of this patch was to receive advice on the same.  
> 
> 
> If you have to respin:
> 
>> @@ -1456,6 +1460,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>>      int vmdesc_len;
>>      SaveStateEntry *se;
>>      int ret;
>> +    Error *local_err = NULL;
> 
> You can declare this:
> 
>>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>>          if (se->vmsd && se->vmsd->early_setup) {
>> @@ -1475,8 +1480,10 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>>           * bdrv_activate_all() on the other end won't fail. */
>>          ret = bdrv_inactivate_all();
>>          if (ret) {
> 
> here
> 
>> -            error_report("%s: bdrv_inactivate_all() failed (%d)",
>> -                         __func__, ret);
> 

