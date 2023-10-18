Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA87CDF65
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Q5-0007TN-AO; Wed, 18 Oct 2023 10:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qt7Q3-0007TD-F0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:21:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qt7Pz-0006Hn-GL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:21:06 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39IDW1D1013621; Wed, 18 Oct 2023 07:21:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=ADarWHhrIWCCBZSF5PKa8RjVseSSfIoMyHIfBcQKP
 As=; b=m3ne+yQZanU6YstsvBMx1vv8BvBTVnQzz1LyuVbFCmMNxSESXZyXTMeCF
 RQ+U+3aHBo0GHZwmSTIQwwUprxQZSop5QPlFyOhkRQKzxrYro5w/9qYMfnHJHbaT
 GD9U2xtG+guESyQiPlWBk5eqt548mRxddv8Zfhi2ByRH60oDL07iaj1AcyXlgZbi
 pJamltGkepYL/y+jjNtjoBTXKDai1QMv7+5XJFQdFuPes9/Q8gH8GgjxyvRZQFiZ
 k0axZQKGfOTwCCiewopMtDCW/oti2FFk7pcculjZOVnRrqSApEXmEQ8HSVWR7IkH
 5ACRPeTjGz6EvvSBoYZOe++Qlsocw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ts6hwnydb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Oct 2023 07:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nb4a3kbdMl3ZtD5A8HAxGnFeo4CbZcqjvchAGZjgqEwLn8gvxZOig0BARor3qctVFIo3RzWjEibdGgGcX61h5VDVCIvevKuer9pMLVtyZD6Ju4c0IfUqbsuVh9JsqirhR/zv3KFsfaz3iul4LWs34lW6KNHKHEldvpNTjtReubq8xdW97wIYNYU3i/kF22Rj97wyzTBWnr53mxXldFwRer/Oa0cviopRBpOhGNn50GI/QcobW5hEy+8R+VgAaud2U9WDqZty5fU7N344G/8RiAglcK6K39RqWtl9vAjrLPgxQikcN+d5RJ1/T96gY8LWq/FnMW2xizleEtVRVFnKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADarWHhrIWCCBZSF5PKa8RjVseSSfIoMyHIfBcQKPAs=;
 b=esFhJH2x2s4KWnAuJuBKEpeUjoHwFpySDpjsVO6EXyTN+H8WWfWOJG/w1MxWMRwhR3SH56ZkI/OjPuNI8jNJKRp5pvNjOhNipQ/dKgwoRv3q6ijetCoOJMA9zOuDjqgfhi+KHNmg8xnQiPIXQb0YoCdBrwHRsHyjuz6913+pV31kwp/ezl4Ztw0TnfpaWySr8Rrg9bEUY6erCa+P4as6kWQh3DSCF0a3YeKl6Rypms2U2lkWxbBIZGXycQETDxpGMq8Oe7A4X3mQhgiyKFu8ieWPhT7JdmeY3Pqmq/nriLIc0duvEmn8+Q40upNx8eVwpS8e3jFdRUd8mFNx662yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADarWHhrIWCCBZSF5PKa8RjVseSSfIoMyHIfBcQKPAs=;
 b=DsLD6UyMoQx7hs8MbXfLY0uagC3xDotWqThlPsmLcExIPPmxzYEyo4HvvS4X6UxKwZ/r5iEUzUIu8cDDY49an2hPo6mCWfHj1MG96MifNdZSkbn/vXtBug0MG8wb6A3uNU072ByIiPTg97sQXtWvgoWTYxBrrEoi3dhhqNbuz2VRoGHG07t/hZien7gncLoxjdup1oUi71XC9HOfYVnoGlL8vO6TVdHp+wXMkZn119MFdj73fspWB1WB4MJkvtjNTe+0Cp8C5S6FqGbyhIOZNd6RQ35Mbd3G4FA2OAts3QhV64KqSPca66X8IxFejGGLt2X5SlkSyfejPFAbMejxPQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB7075.namprd02.prod.outlook.com (2603:10b6:a03:231::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 14:20:58 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.047; Wed, 18 Oct 2023
 14:20:58 +0000
Message-ID: <9c263a67-4971-418a-a3f7-95998491fb8f@nutanix.com>
Date: Wed, 18 Oct 2023 19:50:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
Content-Language: en-GB
To: qemu-devel@nongnu.org, farosas@suse.de
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231012151052.154106-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20231012151052.154106-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::6) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 688b35e5-64b5-4a61-84f2-08dbcfe57256
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJeNDwSsi5Ca5Admnk/uRcHm6FK+vvNBuxuyFgSUCfQZgVyr6zsNAagtGUyZ87o/iHlRud+8GdqWrEP6inY+R1A1XUlWNtfRJqlijHzU+QbXQzQex9aK8GlSqgAfuh4mBXOkfh0dyJ+K/FPNQCQsV9/oWTIa7Z4yWeKs63/kF3BEehv/h0rkLzvy6PCz6/zFq9tIM33Y5RNM84xOU7ESmXx28sAXOpxJ1gWZHJXsmt+P1cxcJASuIAq7EsiTkVchUGcUYY4wjAFDpk/uCcsCtjJk4GVNgx00LhTYZWGs2SYTk96NKuLgKsQGB6H1fSndTl02h22kk371noa+cwW90K8XvUX5MPtNj8Wh+3TYpq/bjPqNF7bYRd98ipiaDj5rTBSsRoR0fdQ23JQV36stM/2Q5wD7iSgZv7Dj9fQ6mCaRYhZeIas4V9o/RKRefcnwxs92xjQckBO6dlXi0Con/rYyTGtj53BJnF74zmT0VBQRvSEIAFZHsF7QKzinLFP/PbqOzOUegKm2N3n1Z6HU/4lEKP/X7SSCVSEyuWHPV9oZxDtahJmVxdtBdSaINn8N18uyf6ELBjA31ro0JIBKUpa+K3TdJamTF2usUd7iigTb0oQW0DtbTfEdf2WHFVxVCgqOu6mWnL9ZlUOxONI9bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(346002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(36756003)(31686004)(66476007)(66556008)(38100700002)(26005)(31696002)(86362001)(6486002)(53546011)(83380400001)(8936002)(6666004)(107886003)(2616005)(966005)(6506007)(6512007)(2906002)(66946007)(478600001)(316002)(8676002)(5660300002)(4326008)(44832011)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3B3K21PRzgvejM2U013UzZGQmhaQlNsalRKQmZHWmQ3QjJRTytXMTByNGx5?=
 =?utf-8?B?VG5IZmJGd2tUUnY4YjV1cFlHWHFPT3p0M01rK0poZXRQSTVWbXBBaUtaaWNt?=
 =?utf-8?B?WFc3TWJLYWtBa2E2S2NzZ3hscUxCbnE2K0MwVStxRS9qdnpRc2doakdTTE4v?=
 =?utf-8?B?WGZhOFBlRkRNckVzb0Z5Y2JsVVI4b0Y4eVZmQ21aU2l5NklLcWJTd3FtNWlD?=
 =?utf-8?B?YVJFSVlEWGNaOGdVSjBkVHRqcGxMeldwTWR6a0JoRDNBR2MvbDNWNFpydkFx?=
 =?utf-8?B?SjhrS2ErK210citwOUNoRTlpaTB2Z0F1L0s4M3crR3hiUk5jU3MzbnVkU2Ev?=
 =?utf-8?B?TkVBb0twYUNCdGpyUmcxd21VSHpSU2FjWnFFSEh6WEJ4RUdUcmphVXVvYzJv?=
 =?utf-8?B?aEpkR3hTaWJzL0U4Nkt2ckdqaEtMTHZid1Z5WGQ0YnJGQUtFRjY3WWRjOHJ1?=
 =?utf-8?B?R2hDR0ZCd1lIMURVL3B1cFk5WkNISGlRSHQzd3hRaEY1Z3c4MU52UFdlWWk2?=
 =?utf-8?B?SHcyTWYwYlEzdDcvZ1pLazlqSzRUNzc4djFLMDNaLzBZM3IzYUhOWHdmWm5W?=
 =?utf-8?B?S0xTdWhmNUgvYmtGUXFVS2RrcXJjcDZWT29DS0d4MVZVMG9nai9ONjNJZ2Va?=
 =?utf-8?B?SEpiN2VORlNpU0EvNExOc0lVUHlrTEhjYjJpUWN3Q0dsNWFyeUMyUE1IaS9z?=
 =?utf-8?B?cVVPTUMyL2NSRXNJZmJDVzFtMlF2WC9mWmpGNWI4OUVyVWZwby9jRHNkeGh2?=
 =?utf-8?B?VE5lSnQ5Z1M5VW9uQXhBUkZ0MGVWektva0NHRUc0RmFxREI2VkhuNFh4MFNu?=
 =?utf-8?B?T21PRFJ1MG9TWXFEUW5aQVMrSHQrSmZjcDJjTWJwcXEvRGovUkh2QVF0bnho?=
 =?utf-8?B?WlMvNzZXU1ljeWZLeU5qajhWK3FSK3NEczJYajRlMDlNcjByNnFRUGZyUTZo?=
 =?utf-8?B?azJ3OEY3WVIzQWhwVTVJWXpJWGdlR2xJM2xBNFNTblpTcHQvOTJhYTMySy9D?=
 =?utf-8?B?TGhyT1pjN3N1N1M0dUpDYzJyMWhGaTFWSW1EeG5ZaDNLM3RaaE9CbUZWQmt2?=
 =?utf-8?B?Q2ErT2VOaXFNMTEwNVZKc1FzVVdOMGgrSTYveVF2Y3crbjNrQmJ3ZUR6WVhj?=
 =?utf-8?B?Y1ZoMlRBandHVFZ0cU1qT0hKeUcrUVpSWnNsWHNvR0I3bXJSdVAvTDgwNkZO?=
 =?utf-8?B?QlVncFFWL3VsaE1Qa2p4RFJHWllITkZ1WGppNTZCNXY4d3dSYVFzUWtuTXc4?=
 =?utf-8?B?bjJSQTYxQkg5R2t2azFyZHBoQTBybVVSY1pieFBnY2RsRDVPYm5uOGExNnpm?=
 =?utf-8?B?TnA5ZHRMWm1UOTVuWHBwcExjNSszdzdXVHFxRXhWMVljOVhXc2RURDh3Qnly?=
 =?utf-8?B?M0VXSTFHQ2MyK2VyUVpVYVY5cWMyYjViOURiUEgxMlhMRzhZSzJQTEVsQWhM?=
 =?utf-8?B?aGNwWG9pZXJCQUY4cEptOXFxWEJsV2FKY09CYXpOK3hoc2E2L2trNFVzMUZ3?=
 =?utf-8?B?UHV5bnlydTUvT2N2ZWkzOG1yWlo3cCszbEFzWjVtT1gvMXVzbUE4eVV6QjRZ?=
 =?utf-8?B?S2RRbkhySWxEZ2F4YUlveXAwdFlTaFlBbkNzV1JscXM5VEZrUjZkRHNpQ2kv?=
 =?utf-8?B?YnJsdUhkOGhaZ2RVY3hwSklLUXVnaEkrbTUzbHZFSDlBNkRxUEtLdWt6TkRt?=
 =?utf-8?B?OU5IdVV1ZmcyRGthVDVEMzgxaElZRnBlMUg4ZURTSzFMTGJmZldrYjBEV0dt?=
 =?utf-8?B?VjJudEFmZVNhRDNJMGt5ZGgzZ1ZZQzRjeGtQdFFCVThKTENsZU1lSHJKU21z?=
 =?utf-8?B?ME5BTUhpMi82NWZWYXZqQloxcUxwYTdvajBUNityL0k4azdvaXRkbjU3dWx4?=
 =?utf-8?B?RExTdDZLZWRXbmZjSlFObVZGdGVBaHc5YU04T1Q0Ty90ZlJiQTVvT2poY2p1?=
 =?utf-8?B?N21YcHBEVVRqb2tJVkN4T2Z1OWRzZGhNN3dCWlVxdUFuRzh0ZUZhbEpKSU45?=
 =?utf-8?B?K0xXS01YRVFtcVpZUU5NSUxpZTdyRTMwRXZJT0tMZGdsVldoNjFlN2EyYXhq?=
 =?utf-8?B?WEhWZm1Fajl5QzdzWnZWZ0JORk5hS1l3MXQ2dVN5aElsaVhHUW93ZUs2WnNw?=
 =?utf-8?Q?dk/dxLck/ZjRFBFr8bWRQX+ej?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688b35e5-64b5-4a61-84f2-08dbcfe57256
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 14:20:57.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YeRtkWU5zstUxev9BOm0/mFJaIHzIrt/zGdvcXqGwh1aYgzt5Z+NERG/fvLuCA83mqdsRPfyn2KmAQFF1pe+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7075
X-Proofpoint-ORIG-GUID: kGtuRLT4I_ljHyOJ2E3ZCgP59ips2tSM
X-Proofpoint-GUID: kGtuRLT4I_ljHyOJ2E3ZCgP59ips2tSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Fabiano, would your below commits impact this patchset 'make check' 
tests ? Because you have added tests for file based migration, which is 
still not included in this patchset.

tests/qtest: migration-test: Add tests for file-based migration
tests/qtest/migration: Add a test for the analyze-migration script

I have tried to address all the g_autoptr() issues observed eariler, and 
make check tests failing as a result. All the tests were passing (even 
-qcow2 181) when the patch was posted for review. What can be the next 
steps here for us? Do we need to add support for file based migration in 
these patches or as you said eariler, you will introduce those patches 
on top of my patches. Please let me know.

On 12/10/23 8:40 pm, Het Gala wrote:
> This is v13 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
> for upstream review.
>
> Would like to thank all the maintainers that actively participated in the v12
> patchset discussion and gave insightful suggestions to improve the patches.
>
> Link to previous upstream community patchset links:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
> v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
> v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
> v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html
> v7: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02027.html
> v8: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02770.html
> v9: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04216.html
> v10: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05022.html
> v11: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg00740.html
> v12: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg02422.html
>
> v12 -> v13 changelog:
> -------------------
> - qcow2 181 test was only failing. Fixed the code to pass that test
> - Added HMP side error propagation in case user entered invalid or wrong uri
>    for migration.
>   
> Abstract:
> ---------
>
> Current QAPI 'migrate' command design (for initiating a migration
> stream) contains information regarding different migrate transport mechanism
> (tcp / unix / exec), dest-host IP address, and binding port number in form of
> a string. Thus the design does seem to have some design issues. Some of the
> issues, stated below are:
>
> 1. Use of string URIs is a data encoding scheme within a data encoding scheme.
>     QEMU code should directly be able to work with the results from QAPI,
>     without resorting to do a second level of parsing (eg. socket_parse()).
> 2. For features / parameters related to migration, the migration tunables needs
>     to be defined and updated upfront. For example, 'migrate-set-capability'
>     and 'migrate-set-parameter' is required to enable multifd capability and
>     multifd-number of channels respectively. Instead, 'Multifd-channels' can
>     directly be represented as a single additional parameter to 'migrate'
>     QAPI. 'migrate-set-capability' and 'migrate-set-parameter' commands could
>     be used for runtime tunables that need setting after migration has already
>     started.
>
> The current patchset focuses on solving the first problem of multi-level
> encoding of URIs. The patch defines 'migrate' command as a QAPI discriminated
> union for the various transport backends (like socket, exec and rdma), and on
> basis of transport backends, different migration parameters are defined.
>
> (uri) string -->  (channel) Channel-type
>                              Transport-type
>                              Migration parameters based on transport type
> ------------------------------------------------------------------------------
>
> Het Gala (10):
>    migration: New QAPI type 'MigrateAddress'
>    migration: convert migration 'uri' into 'MigrateAddress'
>    migration: convert socket backend to accept MigrateAddress
>    migration: convert rdma backend to accept MigrateAddress
>    migration: convert exec backend to accept MigrateAddress.
>    migration: New migrate and migrate-incoming argument 'channels'
>    migration: modify migration_channels_and_uri_compatible() for new QAPI
>      syntax
>    migration: Implement MigrateChannelList to qmp migration flow.
>    migration: Implement MigrateChannelList to hmp migration flow.
>    migration: modify test_multifd_tcp_none() to use new QAPI syntax.
>
>   migration/exec.c               |  74 +++++++++----
>   migration/exec.h               |   8 +-
>   migration/migration-hmp-cmds.c |  27 ++++-
>   migration/migration.c          | 189 +++++++++++++++++++++++++++------
>   migration/migration.h          |   3 +-
>   migration/rdma.c               |  33 ++----
>   migration/rdma.h               |   6 +-
>   migration/socket.c             |  39 ++-----
>   migration/socket.h             |   7 +-
>   qapi/migration.json            | 150 +++++++++++++++++++++++++-
>   system/vl.c                    |   2 +-
>   tests/qtest/migration-test.c   |   7 +-
>   12 files changed, 419 insertions(+), 126 deletions(-)
>
Regards,
Het Gala

