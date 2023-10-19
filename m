Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C4D7CEEF1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 07:19:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtLQi-0005nF-19; Thu, 19 Oct 2023 01:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qtLQf-0005mq-Rn
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 01:18:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qtLQc-0004Uo-OX
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 01:18:41 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39J51CuU025732; Wed, 18 Oct 2023 22:18:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=+2YGxuhOubN7NPQvDIRPbMo5mBLPFqytDVU6BJsTH
 Ds=; b=q50VHJvSOSe6+RIOyzigy1O5GNi2DPpvYn18YCIzcYxi+r46tmVyKL9P+
 v+lUOgl4cO6nJsdf79TmkmNWqU+hHy/8Itsb8p9PePiWMpiJjvUe9HUT+Qlh6onZ
 d9EiFTgrXoGQWxhCcCNc3/+RnBexxLjSLodt8shj6k+DigM+fMrFw8oGmKEmldW1
 eDm/3xnDx2UQNRqRM8d2o2gk/XazQNdwCDGGyKSkHuYg1ODStZEYS+KcHb/tJay/
 Xuh07WRcxMISDk3H8Ia6sRdSDvys4G1z9lSg14/WQRe6xSFQSDeK+tvHvc4fZBi8
 rfhCvcUkCiKqjyuTebDmeNc9ruEAg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ts6htmpxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Oct 2023 22:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW9zsmODzjIsZrX2HN4Ll3qg0jPGMIafcIsk2ld9pxiv0oax61UyyzSvcWQq2KcFRozcNCuNtCgBAcNXlKHMhighc8wVoYcbR+RwAcwGfviHDgwCiqYGoCHOtkd0M4u5nRzYI9kkmw6498poUtUMUFX4QAJ+k57tCHFYFE90NrHtXXYv86EtcqQWLU/1zCN/jA9+92G/bG+XX9Cubc5bK544RRNzVu/u46DsqETaZraIz5IltOB+qEm+nFwXks1JhZa+RxB5h1Hlrjp/cYphrRip3TnvXZd5HeVJ3SZQXcnts6RWLIsTrb6W52L+Jq9ymsCFDiaD5R8Zx0KUc8yzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2YGxuhOubN7NPQvDIRPbMo5mBLPFqytDVU6BJsTHDs=;
 b=Kn3fsrx2aRCKIXYHiUyqdCvnBJhT4KQOVQcOIGRWgae4NEu7W+KyaOee/pPi1BtASlKHLsqdueq7QwicRxUEmSSJCkAVUb7pQs4bnR4lkHv4W8ll+7qckU+5rAsDQxkaUbWyI/1PGJ+ewzZbMiKsyedPGXJeFs4KWTUwRulSwEgiKyzSBd0orMq4MtkLyxZEHZsLxCpSUaN3Sv91e30r7ExYrLFc1q6nf9I4y+xtQt4N1aDOPdSkhdwNnEQDkFR1qq8r085U6Pi/6NFVpixlhES5xggkeda+Q2MZciMdUplGZykCFEMkDTNfUcu7OO0ZZ1Z2LrTDLhqJE6JhGzxhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2YGxuhOubN7NPQvDIRPbMo5mBLPFqytDVU6BJsTHDs=;
 b=fqs8LVifEqKhB4/Ar8QtgUHqK+6Sx4t18F0eDPNXwmKYPAt5VLXMUR+D1T7wbyx1Et9Y5D8SMgyVvlt5Nemr/Kg+hYZ2uikkKTAh9buuMy6h/ZpH+QMM07VXmrXg3L42ObvK9GHW5WEKn9203j6+QdK+i3geBLUsPNzXJNUeEpxphxoaGXS5QhyX9XHjcNQ6cNfF5WjnGRg9X3C+xXStsZTCzRz4rvNgljXUkhLJXRALXK46koHzAzY7Jemjkv9kJ7olEa+SA3OG7hpfQNHJx4e99Vfs0EG+WVboz6yZSga3po+uD/k0spqgROxYjmVGU0JkJTNqf8TRS84ncGzvdA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH0PR02MB7686.namprd02.prod.outlook.com (2603:10b6:510:4c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 05:18:34 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.047; Thu, 19 Oct 2023
 05:18:33 +0000
Message-ID: <0967bdb1-6754-4b86-b552-acec84bd31bd@nutanix.com>
Date: Thu, 19 Oct 2023 10:48:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231012151052.154106-1-het.gala@nutanix.com>
 <9c263a67-4971-418a-a3f7-95998491fb8f@nutanix.com> <87h6modmy0.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87h6modmy0.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::32) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH0PR02MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a45369-27b4-437d-ec0c-08dbd062d61f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZP8G0Miq30fnWaS7UQTTLTmi3OCbAAoOCRc6wFQWCLhPDjbbO9Tu7yp68+doD8LlCn4WcPZdiKX/FGMBknZscxLtn++tcqN+mzuRiGPlWR7SOdWQt5RUQd37paISK6EHfXJB1/7ahs5rMpgZH1ImJkLVEpAB0Upkmv45wnljL795BZ9WmeCT3DqE5D+lV04zx/BXR0M5aRvVq4PYbL0V8PscYF4RVeyo88ej2C8oETUSqxK4KNERbZaSmPuNBQm8S+jFKZUP2gfmE1x4/XYdRlUnhAu2KAG0c2X591nhSla5qyk1rg5ztwpFYf/vHL69Fmy4JwYG402jYnNJggnr8k22pi8aNIka/1X7cb7ACpdn3xWtbFJ+2dT+csKUpnARoVREIz2wja6GYXJy4bW89ttys4Z5GdBn47XGWx9+ntVAt0wD91JjrKDluN5OeCLoy583rT4bbXIYh6HepVEpbADvamgUZPQbuLEH/46puGuBXPI+cExf5K7bBMvAEYrFTVmhOIFdAVaWs5DDOnn9yzpZM3SkLSbhThL7b2VD4CglPyFc0O2HIHKb41ptnNhbKn3xGNZj2HzpQYNp8AFMHf4vNb4RjHjHW1/MmCYPjgSHnol3ueAO1PMBn0XirItQqGbjoqr43fwHvu3/d9VgkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(6512007)(6486002)(6666004)(966005)(478600001)(53546011)(6506007)(316002)(107886003)(41300700001)(2616005)(4744005)(66946007)(8676002)(66476007)(4326008)(5660300002)(66556008)(44832011)(8936002)(38100700002)(36756003)(83380400001)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzN5T1g3RUE4ZWdUZm1DMVBrY3NoYTVUYkR0TEEwZUhTdUZlcnJDRDU2bm10?=
 =?utf-8?B?bzhxdzdsSUU1UWxGekhzSFl5aXlyQmUrdGJMMWNKcFhMZ3hRRFdnMFZCT05j?=
 =?utf-8?B?Q0p0NnZ3L2EvT1BWbTlVd3JwQUpJb0I1VzZZMlovMFpkSmRmK09uVmlHNDh5?=
 =?utf-8?B?VUxraE1lNlR5L25iTm1IOGhvbDRhVmNSYyt5ZFlVQkRTRWJ2anlYZFlVK2dI?=
 =?utf-8?B?Q0MwNjFKUFRmZjV2NEFKcFZHVU4vbGQzT1IrRmJNMVRPSTZrc2tPd0gvSE5r?=
 =?utf-8?B?L3NoZHFLQUJ1dnVMUmxkRWgzZml2VGo1dVA0OFlya0xlWEJXYnFrZVVpSlNY?=
 =?utf-8?B?aXR3dFhodGlaYlgybE56UDYwenpQK1NrZExkTzFEdENwdDV2UnR4dGF5Nnln?=
 =?utf-8?B?aEd4ZnZ1VnVZTXI4R0Z0cTU3Z2lObm53QklTUFVIQWJSUHQwVE93d28wNjhs?=
 =?utf-8?B?ZjVQZ3VUV3YwTEpYUGp5bnJPRGY0SmVYUU95OEMzN2hqZCsxQ2JHMndmVnAz?=
 =?utf-8?B?aC9wQ1h6RDN0ckZVLzRBTWYvTEtIeVZmREt4TEtXTGZuVTU3aDdFTjNWVmhq?=
 =?utf-8?B?TUJGZGorRXhyZi90VHlqa0xjWnRtQ0pzUmJpZ1JyS3Q4WW9LaExXRXVVeVBn?=
 =?utf-8?B?V1hqNkxUc0o2WjBaT0xNYm4vOXZWNDRKeGxYUHpNVXVQQWR3WUY1MTE0Y2FR?=
 =?utf-8?B?MWVJckpRaStsQ1BCRk5jcXFDdWJlWjZJbmtqU1FRZnlvZHR1czZxQ1VOdTVP?=
 =?utf-8?B?VWZ0dlpiUUx0UXRrdnBBMjVMaXJBTkljOWJRTWQ1SGZHN3JGajRONmdqQ3A4?=
 =?utf-8?B?QmlRTnBJS2JRTkFUYURXUmFoTjVHQkFEcDlvT0xrTXk2MUZVMUQydFdPZ3NC?=
 =?utf-8?B?YjQ5alQySzIyQ1hYWHA4YmZ5ZTNhWG95VmlwNkNOMVBEVGp5V1JtemQ3S21E?=
 =?utf-8?B?eEF0eEdPRUtVRmVLUk5FLzhxajhkci9iV3Qxa0E4TnFXa2VVdUtnbWpER2VW?=
 =?utf-8?B?SVRFdzQycFV4UlFMWlJaeWtIVmxkVTlxWXpOZDc4WEJFcHQ1ZXRPRHFpT201?=
 =?utf-8?B?L2Q2MVpCYlIzaHRiSWkvdm4zSmdYNlBUa0ZYdU5hZExtUWNDSzF3RXV6Y0Rp?=
 =?utf-8?B?U21jRExnUjY1UEVsdDFUSXBqOFB2SVBScm5zZjNtUFBMTSsxaFZtODcxRzc4?=
 =?utf-8?B?K1AybWZ3eE91SEllMnFYNW8ybHRCczMwUmVBbUwrclpuVWhLQ0d1YTRha3d4?=
 =?utf-8?B?YStNOXNIT0NEaGJRR3J3VEMvYVQ3cUxNODBhZHd1NXRuUitkZmR3TG91a0Rv?=
 =?utf-8?B?YnY5NDRzdjBpSy9kTXpYMzd5V1VTSndCVkxObXpMRUQxWW5NQmwxaXZUR0li?=
 =?utf-8?B?ejBLZGwvOEEydXhjelBmZUdsdDBaL3EvakJNQXVMa2h4OXErWXZqR2dxYkho?=
 =?utf-8?B?Sk9VV09SUjEvSExHZVZvaXQxREdjRUJlMnlQakFReVFSUnltQ0hGbWczQTk2?=
 =?utf-8?B?cHBnajl2VjZxWitYWS9yR0pIaDcrSzJ0dlluZGVmbmlXeExRODhwMDg1dnJi?=
 =?utf-8?B?d3NMV3BiQlNUY05hNHYwTlZmRSs0TTZNS0hOK2lhcEhGNUdZN1hnMEdOK0RX?=
 =?utf-8?B?ZTh6a3VXZkE1VWEzNHhFYzVKRGZoY1RubTZHQXhWb3ovTG5RK1gzdTN4QzdC?=
 =?utf-8?B?NzhVTGZsNXEybkxVcnZ6OURsa3F3amo4SWg5YkZuQkt2WTVUbEI3UWtvWXlE?=
 =?utf-8?B?bUNOSFlNL09Mdit0djBLV3VtVDBlUUk0OU03Lzd4UVc3MWpZNyszdHhTd3pr?=
 =?utf-8?B?MHFQVllTbGNCYjhJR0tCZ0VqUW9nQStGNVFUekpsdndOcE1hb1hLdDdQR3Br?=
 =?utf-8?B?bXl2SEs0a2Zwd0kzMkVYWFRuTThYM0JpMHAyamVKYTZwRVhzL0pxNmFENVJO?=
 =?utf-8?B?d0EzY3JMWHA3NnZJTkY3WEJSSVRXbE5CSi9WN2JVaFZXTHY3a2RSSzlZRUZX?=
 =?utf-8?B?bHJyakN4K0hheGNMalpPNUdDazM3SmY1Vm5oRjlFUkY0bERqOGRVcnc3UHM3?=
 =?utf-8?B?Z2psdHcxcGZlVTNDeGNyOE44c1VBb2dvRzZYeCsrR0tXVkUwYW1tZlFhUFNH?=
 =?utf-8?B?ZjV3Q1JCUmhNU2MxVklJZ05DT1VoTjFYWThrK3ZQcEY5TlpIYTdwRXlYV2ZB?=
 =?utf-8?Q?YjNbOf5HtI1jWSIpVbimpCFjqL9H19a9Ksavwh6VMxk5?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a45369-27b4-437d-ec0c-08dbd062d61f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 05:18:32.4777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HheGc5qB3BUC3aacDhzop4xSh0iAbc7WcevcIzSaF0xWnAVvXkQRSKXoHrC7INa3HTLmg8VvdMJ503AuW59kEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7686
X-Proofpoint-ORIG-GUID: y6TfSQEnr-RHQWETVLaaH50e7H2bjCD6
X-Proofpoint-GUID: y6TfSQEnr-RHQWETVLaaH50e7H2bjCD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_03,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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


On 18/10/23 7:58 pm, Fabiano Rosas wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> Fabiano, would your below commits impact this patchset 'make check'
>> tests ? Because you have added tests for file based migration, which is
>> still not included in this patchset.
> AFAICS, the tests shouldn't break.
>
I tried two builds to run on Qemu CI/CD pipeline,

Build without those two commits which involved file based migration - 
https://gitlab.com/galahet/Qemu/-/pipelines/1041554569

Build with those two commits and only 2 patch of the current patchset - 
https://gitlab.com/galahet/Qemu/-/pipelines/1041215154

I am not 100% certain but because the 'qtest/migration-test' test 
failed, I was of the view that might be because of those two commits.

Regards,
Het Gala

