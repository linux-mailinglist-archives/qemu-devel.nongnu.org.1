Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B334080CA97
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCg6A-0001wP-Iv; Mon, 11 Dec 2023 08:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rCg67-0001wD-RZ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:13:24 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rCg64-0006xh-NS
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:13:23 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BAMdMNj017431; Mon, 11 Dec 2023 05:13:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=izcZh6wCkqd9
 tvg3Vdo9unRCe3y5AunSPlJIwL1PO7U=; b=qoati1InIPOwvHHRE2gMQzMAOcYf
 Gm2EAg6HWcqtIAEBARViRx5imoAe/7GUHcXbeYGIqBfCKGgWweurd0vsd8kfg7U5
 HL8NORSSq/KuY4leRqm1CS6b+gyR5Lmdgz36GRVfLPfHIK63LAxVqv8RjEfmzxqc
 +rqIXU2VUYrJuCeMSQ0DycVYgs5umkbLmpCF5L2kptcFwVb0Bdr8GjHIR7lwi5EK
 DxmOYBDW+U8p9mdXdxDgYCzVR5RSMOwuZEZ/T2pFetYAGq9LRUSitQbUaHQqH+L8
 BKUnpmGTs/TaSgec3+lvMbTGEbyvb3uqcqRc4YNqL/amFwEVAunJBMALYw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3uvpnab5kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Dec 2023 05:13:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iue+Hs4B27MNm42SZtzkFSKpwvU4ZzgDk/9jlSQ7cb1Z3DaEhSiixjE5MhqwP6uocFonDhpSSdkuWfGxKFTG1JSK1rP9az3foeQgw9FNuvnXzd5oJ3BpI3LXvdO2ucqdSKVEDk6SwbAN/0ZnV5bwY30SgRROgq+rGurYeOg5dfvYXjMWLBol+tXf5+JKBw2SRroA5XvmwnmfbFZJnu2F5rQbhQVrDv3wDVDYUG6iWK6rAMtMiOYeAwHNyicrSwHp+j/L9Jumm3a2goPZ4ulYem/mJ9ch6EclYVizWWa0kTkShii6IMjZ7Y5me45AZZjlRF0mgFzylrXF+/u8vJ+3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izcZh6wCkqd9tvg3Vdo9unRCe3y5AunSPlJIwL1PO7U=;
 b=jEZdATyq4qB+Jo3fhdS7TnPWBzl2NO4/mYLOgfo2rBjxMIsXWNp7OJ2lnkDVWkpRopn8EBsBoOWM1k8u8QsJYGNfBcxVcd7k+UizwLVQxtbt3TuJEHmAJGxROBB/1zQqSi2OdPQmkO5aQMfDTT/rr5cLft8Ebc21++JGYQM6wu86HUU2oCJYRbf56uAkf2wXH7V2NxvoJn8oarChLlxiH9LApcaxNqyjHra+XofGG1G3GEhyQPnAXQmBANfEH6O2aRdoqWoIW78l46bRCYZ5VBrRjNEKw45t6nex9qvMw2eL+nD1/Yj7Krr52xTEqGBrmKjOEvOr1t31gEPU4szc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izcZh6wCkqd9tvg3Vdo9unRCe3y5AunSPlJIwL1PO7U=;
 b=tRmycQ9ku9mKNwYRpdtxOS/FVvYNSK55nanD80Wp1YoIAMyqra7hzS1pqUxuCiKYKy20PGqBPaKHmKFH/8e2KhlUFsq9trxDHtCjP9dgjzI0pPu5aw9W+2bRqyWPXr7SG+BnSM1M+Nr7FQMKII9bYNT4r36z5PGic110yImdcE6VQ+pgKxMVnr64R2I821cHifibbmbL/5A0dBGsnhXmPwM2ozMHEpg1enHgH/UCamoQTsHEqaoBGEg1wWmCf4rhCXxympp4doWlsSpk2TfsF4o3o2DURrHv4BPa/uu5/BfTQHiJVHf6tqzTAkh4SeA9VJyW55M5wDnL3IzWr8rXzA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY5PR02MB9016.namprd02.prod.outlook.com (2603:10b6:930:34::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:13:14 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:13:14 +0000
Content-Type: multipart/alternative;
 boundary="------------GB88E9ejTW3BWxSbihGLx0qq"
Message-ID: <62ae7ae7-76bd-4526-a002-515cd9660ed4@nutanix.com>
Date: Mon, 11 Dec 2023 18:43:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Simplify initial conditionals in migration for
 better readability
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, armbru@redhat.com
References: <20231205080039.197615-1-het.gala@nutanix.com>
 <87a5qon6vj.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87a5qon6vj.fsf@suse.de>
X-ClientProxiedBy: PN0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::9) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY5PR02MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: b0395f13-cbf7-41c1-c6d3-08dbfa4aee4f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WS95iXUusSngwdHYHDqqKCmwIxkyq6RtZMUsnMF7E4GVIJDZggkfMUd7pNFqWtldmLujyJ3gGPfI1yN278kAfe4dgo6aLrKcBl6u42GL/1YroVu6WIh/qtAbbGAZVbBq9GJdwYb8Msvjk2J/f8Svg6O8Z6r8EEAt/acZ8fRniM5BTQCE4ne0ga7RMLgcVi5rBg6ALdwicRO09dLvKPhEL/Rki9jIr9Kq65m3fxTsj7CHO8c1dZOahEtVAH3o+dbwOkPRwD2bDm7gJdAOJTA4XJ3xV9OCabYABF/4yNzkycmYtLkLiaxteh0vLmFQww7qqym6fPXF2zjPzSQG7cMSsu0jWXEVJaMuZL7hdYW7ZkO5YGqxzVWJtLz0Ari3FQ0ftO3uJa7plqfBwnBOGncmGTCSaEfLcwpOhDnE7oC/Eg8d/irl1/P1bHpSNbF3f3v89oreNg6jQF2ic/jI52xHVK/GQUaL/D6QzpoQNFyO8pxFgg2FlqfyqeWArA2itO/SjxlBUctUP/ECtQPlb+1vJpYin/Dk555gLWOQ/F5ZqZSOiFIJ8FiRUyS05L9cxt6EDo0WIXoC7TLOMJJr2MfCD6axPOGqSiCNYMELvudQdB/SyloxkHNqsd0IAEWS9cuwuvZSMgSqQvlDWd6Ui2Gueg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(6506007)(6666004)(33964004)(6512007)(53546011)(5660300002)(44832011)(41300700001)(2906002)(4326008)(478600001)(6486002)(66946007)(8936002)(8676002)(316002)(66476007)(66556008)(31696002)(38100700002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJwWkErRk0wNlhyWWRHYjRBTUZVNW9ZYkJjTVhQNGZianp6cVdRcHd4OENq?=
 =?utf-8?B?Vmo2dnhXcVIvSGVlNXZFRUFqZzROUllMMFl2c1JObmVhNnFxcHRxRGd5RUVT?=
 =?utf-8?B?bmp4c0hGTU0vRTk2U3ZiZ1BPQ3R6NjZSbDdRV1UxWThWNXNuTGgrOEhGWENG?=
 =?utf-8?B?YjZHQUJGL2RTc2NOMFF4WVk3ZENNcTNoMDFkUEV2bm45ZldsZlJ6eFdCTHV1?=
 =?utf-8?B?U0h1WkdSaTJyMHdJWmkrTWZoZmUrT3JrdEtWS0hDVWVQczBzeGExcFllZGZk?=
 =?utf-8?B?V2o0YTNQK1Y3bGxKRGFmV2FYaERUQ3JTanRCMVlEUUF1d3lBai80bXA5bDlu?=
 =?utf-8?B?dWw1Q2gxTUhqdXB1VExSYUQxYmVyM1hjajhWZmdDdnFDZm9rYzl6VnYrRVFC?=
 =?utf-8?B?bXAzSkwzQ21yUGJ5ZGV0RFBYdE1TbEVBY3dXU3Y4QmxXMFcrcnVXaG9iWUNt?=
 =?utf-8?B?MVNJQm9hRWxpV1VxellCanpYbXFQaUQ2eFBsTHV2djVJV3BIM3ljdHRoMVRp?=
 =?utf-8?B?MmMxYWp3djlUWkdhY25veFZIM2pKaG1OdXlnYjdTV3BidDlqT0QycDVSWlc4?=
 =?utf-8?B?V3FMZmJFZTQ1OW91TjZuSVRGb2RwVUdraUhQUU1UbXZEK0NXc3RScUVsTnIv?=
 =?utf-8?B?bE9qVVBSQ2dtcVRmV3ZJWWlBTjlGaUhwV2E3K0hPeGE0MEU2d0tWK1JrNUQ2?=
 =?utf-8?B?UDc4bDlZRk5LZXV0T2cyVmowU0NEVW5pU0ZPeVcyQzhwYTBnNmxwcXNFMGQ5?=
 =?utf-8?B?MFIwTWNLY3VZTnNGb2p6UXhJS0d5S1l6WFZPaHVnVEpCS2dUOXpheEpvV1Bk?=
 =?utf-8?B?amY2am5zTEs0bmRDS1JKazNFbjVQY3dJR25oTVppZ1ZiRnpLT3d5dE9SR2hW?=
 =?utf-8?B?M3dCaVhJVENZdWdYOFlsNFRnSytSR0wrZ3dEV3NNaWt2eUtBMmZ3WUt4K0VJ?=
 =?utf-8?B?RGtYUHh3OXNNbUtxcTVZWXB2VnZ6MlBqeFlTbEZITFlJZmpibnRpMmRGM1Yw?=
 =?utf-8?B?ZmlpQ0VHdWMrM0VyQ3RobzRESGtMajRaMk00dmFVTGorWGU4cFBmeTJYSjI1?=
 =?utf-8?B?NkszakRMWVNrMVF0bDNlSUdUbGQxTFdvelkzVHh5MEV6aHBVUlNzRVhrN2RQ?=
 =?utf-8?B?R28wTVNGNUFXVDA1ZUhzM21tYWlQQ1hMcFIrQW5Wc2cydGdoZ2NBNm90OFJa?=
 =?utf-8?B?V2IxejBrUy85aHpIZkNRY0JNZll5WDh1Z2V2cStONGUrSlhnaE1jRDh5REVR?=
 =?utf-8?B?aWJYRE5KZU8wVjlsRFZtS2l6akRpOVlMbVkwekRsRFcrUkl6d1M3N1Bid09s?=
 =?utf-8?B?UElZc3ZUclk0M2tFa3BjOUV1VUF3azJYcEs1OFRoV2VDL3BvS1poMmdwYXN2?=
 =?utf-8?B?dkJBTkdZQlo2YURscnZYaVJPTEpyN3Y2S3JUWFJqVDR1RTIwL3RXaVlZRkky?=
 =?utf-8?B?OE1jZEI5MmZIaVhMdSs2Z1VETWVVdFNmcVVzWWh5NHRKNGpiL1B3ZS9iS08v?=
 =?utf-8?B?MFQvTjBPZnNueXAvS0NialJpOWRwOTNLNEZBODJrUWJGUXlaQ05IYkVyVzNP?=
 =?utf-8?B?dTJOcS9MR05kNW9EaTlpTythRzdkN294Vk1BYWxDdG5kZkhhNEdTK0drR0lo?=
 =?utf-8?B?M1RJc3lyS3haRWZ4SDZnNHRyT3pLSzRjNlQxazQ5R3NBbHljSXBjRnBjcUpX?=
 =?utf-8?B?RTVVS3JScXp2MlEySmVERTNET2ZLaFZWUmU0RVJ2aU9TbjQxSzBBV1hlTWxt?=
 =?utf-8?B?anVtWEMxWFYvRytxUTBXY3hibFRTYnRLQkZjOG1nRkdBby9MSHg2RzdwOWJM?=
 =?utf-8?B?eDlpSEN5L2dJRkx2dkE5dTI4clllaVZ0R2ZhZjNENGpiM09JUjdVWldCM2ZD?=
 =?utf-8?B?Nkh0YVZrMmliSXdtUGlLL3UyM0JVNTRvVmtXWGFpVXBwdzRoTHA0QXNqRkdX?=
 =?utf-8?B?d1RFL01XZVQ0bGtGOE1sS0RsTG43U016QktGSzM2VzV6Sm8zYTRuWDRWSG5y?=
 =?utf-8?B?Ym9PZFo5VUZ2akYxR2syckZWRGh4VUQ4dHRvL1Jrdzd5K1Nkdkh5NmxySzhm?=
 =?utf-8?B?NGt6L3NhcWxhL0p0WVNtNndCZU15Z1EwOWRRbDBxeGc5YTZid2JLS0F1WlRl?=
 =?utf-8?Q?GF0Vu3mde69akPWdxo2/TNWFn?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0395f13-cbf7-41c1-c6d3-08dbfa4aee4f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:13:13.9520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: To22Xg6gELKe8bhsSjcn9dHwuEbm0TxST8l7XBVk0aEbdES4YNiwL9GviSQ3P/ghM4vTGHQVQUJNRQ9c9oZg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9016
X-Proofpoint-ORIG-GUID: vK6F7jhd2jyCJtH5QP4l-pOl59SnOBz3
X-Proofpoint-GUID: vK6F7jhd2jyCJtH5QP4l-pOl59SnOBz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--------------GB88E9ejTW3BWxSbihGLx0qq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping? Waiting for other maintainers to respond on this patch

On 05/12/23 6:28 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> The inital conditional statements in qmp migration functions is harder
>> to understand than necessary. It is better to get all errors out of
>> the way in the beginning itself to have better readability and error
>> handling.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Suggested-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Fabiano Rosas<farosas@suse.de>
>
Regards,

Het Gala

--------------GB88E9ejTW3BWxSbihGLx0qq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre style="color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; margin: 0em;">Ping? Waiting for other maintainers to respond on this patch
</pre>
    <p></p>
    <div class="moz-cite-prefix">On 05/12/23 6:28 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87a5qon6vj.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The inital conditional statements in qmp migration functions is harder
to understand than necessary. It is better to get all errors out of
the way in the beginning itself to have better readability and error
handling.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Markus Armbruster <a class="moz-txt-link-rfc2396E" href="mailto:armbru@redhat.com">&lt;armbru@redhat.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Reviewed-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>

</pre>
    </blockquote>
    <pre>Regards,</pre>
    <pre>Het Gala</pre>
  </body>
</html>

--------------GB88E9ejTW3BWxSbihGLx0qq--

