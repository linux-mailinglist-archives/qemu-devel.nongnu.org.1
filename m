Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93932782876
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY3bm-0006pl-FU; Mon, 21 Aug 2023 08:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1qY3bT-0006kQ-Oj; Mon, 21 Aug 2023 08:01:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1qY3bQ-0005Ek-8q; Mon, 21 Aug 2023 08:01:51 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37L2iiHC007102; Mon, 21 Aug 2023 05:01:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=JfOk2kMBwmqY
 m+O7XEJseL8opiDH8ipxNTzwqklq48o=; b=2dVz/7lU0TC5H7YswZ5PHX+tq7zY
 ukcFjVO6cHCsvqqizr7t+QJ8hDEor06Lw1oHURFVtu42JAv0WyxYvhERb5FDX2Op
 nXmnL95FP8hKVhoT5YaANoVI87RcCZS70SJ9ICL9WJEQ96ztf9ByyvG1Cfobi5na
 LnFZQgmDUrSqaPrzfa4rfMroirh8obN8WkmH1yzQUlpSsTfG4br4+Rp3F3aGnZsV
 mqO9g+cAI5PgDXOWRpfwd0YuEXt0F/yCW4xu2mjyqbU0Y8l0SgXDH/a/DaiE7fyI
 huMXQjDMl8uLPnhBfP5MQY0ppSzFizc6iDC4I3fZfBmco/Jv2Mwx4xzX/w==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3sktp1h5d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Aug 2023 05:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC4koHMHgV8lbtrLmaj4tC3dM2O3bV0yHfi4CgXyZm02qe7TbB6h2r0JOwLE44g3cCfb+PRX//3aQmDtCHeGyW3X/ypqW1Hd11/GDg4EeL8d/Eb4NIMKUdb9Rl3j9kpOEdkxWsH5894kz21aBMmpdUNpbXwmODKkB63N8cBiTsTDQpD38+8VRG/PTn+Mk+Uo55gN2pyDliU3h0fcVPgFPQfY70DSmGB4gdYkIFYl39/6v4zlB0P3VT5pcC/tfX14WKila9/thpD1wscPD7/0zJLER/VarDBTiBQy2T2fSn65rhYG6h4RlYLX9E9z8D5f7KNPsLZeamZymi364WYUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfOk2kMBwmqYm+O7XEJseL8opiDH8ipxNTzwqklq48o=;
 b=dt6Ts3avSVuDVSR+Fd9es8J9scsHv1R/eeTJYIBTrIuE0GvKVdsSynRNSHSO/J86flP2VoBOShtzZrhEVD8VoG0L4bg1J0cTZ3AC1AQVYSbai1FthBiQZKca1BAET+NxsE+SsUNKXsEUEfDl2CEoU20AAuvrfQZ8CtGtBi8/n2tE6jNmY7DRCZl0ow7YcCUOfq8xZDVUYObY6m1vq3whVeV2/2jFBYYDeJEV2NsrGfwu1rCKmDaYxOOUANKPZwIuAv4Yw6NCfhU/Z6l1F0PrNMelwcIE4B0sDeB1k6yWoMRBToDUNoTzJiellJ5G6stV6yLkRdQdvgnWNqYrX5vhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfOk2kMBwmqYm+O7XEJseL8opiDH8ipxNTzwqklq48o=;
 b=SZQj14vx3W2lK5zpiu6Ulnt8YciYyvRJMlLmsEoXFpM/kAes1x9gZsJW8vH/EEN/FcUlDvQ7B1ddwxy/JyhsNakyP5tYApY/M1z8zlPdSbNJPpp3eI5j+w5LsC/eUe75XbVma5gcSnK8J4qXCbEtisOko6vBGO72JDWGmB/N4fDs27i/yuw6nXBN6e9QIj4iZooTU1fInuFqCL0W1mH90PsgM6OoJL3RL3EhZQ3/o5vnKIh9udO907OIJTm6IufAcDRG18AxkqAcRHK4Cb07Rlhgbp/pxPZNvMkBI40nkJB/6Z+qHgd/6XqHZ79qvSIgHFeIG2VUgR/TP/rSP5iQZw==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by BL0PR02MB6514.namprd02.prod.outlook.com (2603:10b6:208:1cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:01:40 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::efe6:606c:24a8:a313]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::efe6:606c:24a8:a313%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 12:01:39 +0000
Content-Type: multipart/alternative;
 boundary="------------1r0BehWXGnw4I3XFkawb0zEl"
Message-ID: <16bffa8e-aeb5-187d-ada8-8cf954782528@nutanix.com>
Date: Mon, 21 Aug 2023 17:31:27 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
To: John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 andychiu <andychiu@synology.com>, Prerna Saxena <prerna.saxena@nutanix.com>
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
 <20190910025404-mutt-send-email-mst@kernel.org>
 <9f402933-7256-75da-af77-2e47b656ab27@redhat.com>
 <20190910095329-mutt-send-email-mst@kernel.org>
 <a4a39c82-e5bc-71e9-28e8-25a0c68e2d6e@redhat.com>
From: "manish.mishra" <manish.mishra@nutanix.com>
In-Reply-To: <a4a39c82-e5bc-71e9-28e8-25a0c68e2d6e@redhat.com>
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|BL0PR02MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: a4496701-ac48-456a-59ae-08dba23e6017
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XA72jm3rYky+F0TljDH66j+8yMIYYzxfiIKdgAFvZq5ZT1kz3OO2PXppCdyS5C01wHr3UT2goQpWPkYhFxGlxARR0W5a5OAFBnYrefpm9Jixyc5DlM1nxWxHI+wtrn+T/LRdxDSQv88Qj8IRQa2quv4hsIqIRNCfJzfb/lew8Nerai27DFdNKIIJjeknXR5z88mAfhZv2z+bzDlSvwiGl1LHLvubWAjHkTJT+2uu4IiQobCMpUFzjhnzIodKDmLaKy109iSOg3dbhm0wBY2YdngF1598t7nRNWj1lC4O2qpHE212AKElPtHsuHXm6FjX/C1V5g+81wO1hbTFDYdy+mfh13M9Eo0khL1JDsDIQM0APB4nE62MCcoDwxTchDbl+Oe3zrwOhDCeqD5t9tQcXXWPWpiPof4kcoV9GIeI2SujmTthM5LoR+y4Ru6mc7vBbS1xva2G3N347WYrrbCoDNx3VSwBuYAv65eYFZ2C1quuwVtCD89xeBE/jfMC02UzgNAe4zmDnVTzITyRQMT9Si0oE398AzhtFr+iBfAfwtZBCmGBahVyFRkZBQyCYJItWuGuvtIR4c+ezgmpQJSKqrNdOmtDLQRYVZttTPLgXImOuYXzLEHrUxo/CLk278lazS/e8e845DwehFZa3b73ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39850400004)(451199024)(186009)(1800799009)(33964004)(6666004)(6506007)(53546011)(31686004)(36756003)(107886003)(6512007)(6486002)(478600001)(2616005)(110136005)(54906003)(66476007)(41300700001)(316002)(4326008)(66946007)(66556008)(8936002)(8676002)(5660300002)(2906002)(30864003)(83380400001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGtuQ3ZkdW80aWk0RStnRldNVUVEeExPaXdpYjlFU0NLUDdCYUtYS25ibk1B?=
 =?utf-8?B?RFNSREQvQmNtUmJNVGVwWmgrekkzL2tjN0IxTGlBbXV3ZlkyWUdZNzViOGdn?=
 =?utf-8?B?SFpJVXlwYmlWR0o3OTdmQytka3FJQjhSdCtLUVdyTGJ0S2ZQc0ozengxM3Vj?=
 =?utf-8?B?ZWxRQytVYjNpMjc4UklwRnpLczk3ejk5VGtudGhzbStLZnFFZitmNTYzQUpt?=
 =?utf-8?B?aHM2dXFIc2hwTGF4Y0dSaC9mcTVPa2M5SlpVSnd2WU1DNVZvYTJLbi93M2pS?=
 =?utf-8?B?VmdBb21VaDFpQU9jTXk1SzlaT1U1S2c2dk51cXJXb2VmMkVldE9wYXVDUlJh?=
 =?utf-8?B?TWRBWVpjelpVdnRnSTRBOGNUcHQ2VFpYMEN6NURTVXhPSDVYQno4OGV5L21B?=
 =?utf-8?B?WFRxaXZoYmx4dy9KL3lSV0h6WUxLbE9FV3hncGxxRVg0ZVpkTXR2WlBJZjc5?=
 =?utf-8?B?RTQzRU5IZ3k3VlBQMHhnTytRbVpsUlFIaXNDV3JzaFFNRkJPdXFtVlFTeklH?=
 =?utf-8?B?OE1YanA1bDcwK0dWWU42aWNSK05ZR1VaY1R3amNaS3dtTnpqR05nVkg1SHhy?=
 =?utf-8?B?VTdpbVlCcFZoaWppaG9mSWZpay9pd1o4QlQzL2NVclZpblFCenZsekNEaG5B?=
 =?utf-8?B?MGw4aGRjVjkxTklSMTBiTjcxZEVJRms4ZUlNR1RvVnlGYU9Eck9oSzNSUVhT?=
 =?utf-8?B?RjdPVThlaEpPNWZzUzdPZHNTWitDU2VuVUZ6S1VVWndrOERhRTl3dDJXRmJM?=
 =?utf-8?B?VTRyZW8xZzJJSUZScmg4UjdpSnBUcVB4SmJZYXdSWTZteWhjUTRIRVg5L0tn?=
 =?utf-8?B?aUZrVEtwdkRKck5Cd2llU2hEOVZqczlRUzlIZnluaE9WODdzZC9neGlLcUJv?=
 =?utf-8?B?YlkvaDEwTklVRmdWOVlXQjBWZUxOWnZDamJXZ0ovd0RuZHJDOTRULzhqTmxT?=
 =?utf-8?B?Y3IwTXB4dDNOV2FubXdhWGxxVldCWU42bzhCNFZLZkNOdzFReDhDWmJyVk43?=
 =?utf-8?B?a2hDcStDNG9qQ2JhL0dqZk5ROU1WZ0RydDVQYU1WbEFDOEdzTHJLNWZTbmhR?=
 =?utf-8?B?cHNDR3h1RG5CTS9mUmw4WFFOYUpUTlQ4Z1FZaDNLZ1BwdXFoQVpaVC9RZ2ZD?=
 =?utf-8?B?d1JuaVcvWHlwcDN1RDAxWWZmc0ladTVWY2RtUzlpOUUxVHU1TkNRVm5tRUdr?=
 =?utf-8?B?UDNoRWw3WXd1MHpxZDVhZnBUSGRlU1RiQnkwMG05a2ZER1dZTjlLZVdLN21o?=
 =?utf-8?B?UlgvTTFENHkvYW1zZXdJeG1tL2dURkhRM05rYkdjUnZMcVFTS2tuTE9pVGQ1?=
 =?utf-8?B?alkrZWxKUjN0Z3lUL3k1b1BjVndtZkc4eXFRUDIzL1BFV3VneXlicjJWbWhX?=
 =?utf-8?B?Q1hNV2szeWthVnFKclY4bXRiei9wcTdSY1c2VUN0YWhrbFBXLytlV1lXekl4?=
 =?utf-8?B?YVdzYStuS29ZbmN5enljMmIwd0RmSEVWR3M3TGl0dGRWVm5aL1dHWGl0Y2ZY?=
 =?utf-8?B?N0ZWbFZwOVZRWGZMc29tQStrWEEraTNkaFhvL0h3dmxIc3FZVlAySWlDSjla?=
 =?utf-8?B?U0p0d2IrU2huZFdRM00vVi8zbmp4MzBRMWV1Z1RtejJuMU1hOFhWUUdMMVh3?=
 =?utf-8?B?Qm00YU82OTFwK1lVcXlOWVZwY2JiVVBReEg1NHpsK0hBcFF0amc2K2xTaTIy?=
 =?utf-8?B?MDlPNGdjTUZVenlTanBNeGNoRkFjQ1ZoeDFoa0xUYWVkdWNJUFh4TGlmYVhj?=
 =?utf-8?B?a2NvSXZYUGl3OU5YVmtCNmZQeDIwVWtlYkN4MktMOEFnak1IM2s4UzBKL29p?=
 =?utf-8?B?U252VEQ0c2tUZHM4WUlWNFh6alBwdFZ3Q09aNzNWRzJFemI4YThKTkgzWDYr?=
 =?utf-8?B?ZDZscW1mVGFlYXMyWXJFQVpzNVBzS0JhejliMzd2VlNFUXJ2c2t5SU1UNi9n?=
 =?utf-8?B?OTZ1cTdTc3ZGVlVtanI0WmZwcm9UWkw1TUZ5a29ZSDdTSGc4cm5mdyt4UHJl?=
 =?utf-8?B?eEoxc204ZXZPTDdjQkMzRHFqT2x6ekdyZXdZYWE0Q3h2dWc5OWhXbFowa0FR?=
 =?utf-8?B?cXNJcjFLT0pGYVE2OU5ta2lsUDJQcnY4bGU3VkZ6Zzk3N0h1bW1CaHFQUkp1?=
 =?utf-8?B?RC9qa20vM1ZDaFRTemFVaFZ5R1RpYUw2dXFrOFVEb1c5Ti9sSGowTTd4ekh6?=
 =?utf-8?B?U1VhSFJBNEJ4WlpFSW9zc0hvT0VoQUNHQVM5cTU5RllhdkRObm5xeHdEWUt1?=
 =?utf-8?B?MEhUQkw5aWYzZUNZVW5neTIyTFFnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4496701-ac48-456a-59ae-08dba23e6017
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:01:38.9419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVI7sL74wvpZcbSve+yk1/hHUElA5dMjVgMQztP64MH93f9SNiLxTHumzT+1bJ9TPFdt0LHQppVGVqNRRSkdz6AHE/daI2wM+L6DnHcLmZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6514
X-Proofpoint-ORIG-GUID: NWzEGwD1e4qIb6KRja2FINr0SR5nUCiM
X-Proofpoint-GUID: NWzEGwD1e4qIb6KRja2FINr0SR5nUCiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-3.374, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--------------1r0BehWXGnw4I3XFkawb0zEl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Everyone,

We are facing this issue. I see this conversation was never conversed and discussed issue is still active on QEMU master. Just for summary, the solution mentioned in this thread "temporarily enable bus master memory region" was not taken with the following justification.

"Poking at PCI device internals like this seems fragile.  And force

enabling bus master can lead to unpleasantness like corrupting guest

memory, unhandled interrupts, etc.  E.g. it's quite reasonable,

spec-wise, for the guest to move thing in memory around while bus

mastering is off."


There was an alternate solution mentioned in thread, that is to mark PORT_CMD_FIS_RX and PORT_CMD_START disabled forcefully if the bus master for the device is disabled. But there are no further conclusive discussions on this.


I wanted to start this conversation again to hopefully get a conclusion for this.

Thanks

Manish Mishra


On 10/09/19 7:38 pm, John Snow wrote:
>
> On 9/10/19 9:58 AM, Michael S. Tsirkin wrote:
>> On Tue, Sep 10, 2019 at 09:50:41AM -0400, John Snow wrote:
>>>
>>> On 9/10/19 3:04 AM, Michael S. Tsirkin wrote:
>>>> On Tue, Sep 10, 2019 at 01:18:37AM +0800, andychiu wrote:
>>>>> If Windows 10 guests have enabled 'turn off hard disk after idle'
>>>>> option in power settings, and the guest has a SATA disk plugged in,
>>>>> the SATA disk will be turned off after a specified idle time.
>>>>> If the guest is live migrated or saved/loaded with its SATA disk
>>>>> turned off, the following error will occur:
>>>>>
>>>>> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>>>>> qemu-system-x86_64: Failed to load ich9_ahci:ahci
>>>>> qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
>>>>> qemu-system-x86_64: load of migration failed: Operation not permitted
>>>>>
>>>>> Observation from trace logs shows that a while after Windows 10 turns off
>>>>> a SATA disk (IDE disks don't have the following behavior),
>>>>> it will disable the PCI_COMMAND_MASTER flag of the pci device containing
>>>>> the ahci device. When the the disk is turning back on,
>>>>> the PCI_COMMAND_MASTER flag will be restored first.
>>>>> But if the guest is migrated or saved/loaded while the disk is off,
>>>>> the post_load callback of ahci device, ahci_state_post_load(), will fail
>>>>> at ahci_cond_start_engines() if the MemoryRegion
>>>>> pci_dev->bus_master_enable_region is not enabled, with pci_dev pointing
>>>>> to the PCIDevice struct containing the ahci device.
>>>>>
>>>>> This patch enables pci_dev->bus_master_enable_region before calling
>>>>> ahci_cond_start_engines() in ahci_state_post_load(), and restore the
>>>>> MemoryRegion to its original state afterwards.
>>>>>
>>>>> Signed-off-by: andychiu<andychiu@synology.com>
>>>> Poking at PCI device internals like this seems fragile.  And force
>>>> enabling bus master can lead to unpleasantness like corrupting guest
>>>> memory, unhandled interrupts, etc.  E.g. it's quite reasonable,
>>>> spec-wise, for the guest to move thing in memory around while bus
>>>> mastering is off.
>>>>
>>>> Can you teach ahci that region being disabled
>>>> during migration is ok, and recover from it?
>>> That's what I'm wondering.
>>>
>>> I could try to just disable the FIS RX engine if the mapping fails, but
>>> that will require a change to guest visible state.
>>>
>>> My hunch, though, is that when windows re-enables the device it will
>>> need to re-program the address registers anyway, so it might cope well
>>> with the FIS RX bit getting switched off.
>>>
>>> (I'm wondering if it isn't a mistake that QEMU is trying to re-map this
>>> address in the first place. Is it legal that the PCI device has pci bus
>>> master disabled but we've held on to a mapping?
>> If you are poking at guest memory when bus master is off, then most likely yes.
>>
>>> Should there be some
>>> callback where AHCI knows to invalidate mappings at that point...?)
>> ATM the callback is the config write, you check
>> proxy->pci_dev.config[PCI_COMMAND] & PCI_COMMAND_MASTER
>> and if disabled invalidate the mapping.
>>
>> virtio at least has code that pokes at
>> proxy->pci_dev.config[PCI_COMMAND] too, I'm quite
>> open to a function along the lines of
>> pci_is_bus_master_enabled()
>> that will do this.
>>
> Well, that's not a callback. I don't think it's right to check the
> PCI_COMMAND register *every* time AHCI does anything at all to see if
> its mappings are still valid.
>
> AHCI makes a mapping *once* when FIS RX is turned on, and it unmaps it
> when it's turned off. It assumes it remains valid that whole time. When
> we migrate, it checks to see if it was running, and performs the
> mappings again to re-boot the state machine.
>
> What I'm asking is; what are the implications of a guest disabling
> PCI_COMMAND_MASTER? (I don't know PCI as well as you do.)
>
> What should that mean for the AHCI state machine?
>
> Does this *necessarily* invalidate the mappings?
> (In which case -- it's an error that AHCI held on to them after Windows
> disabled the card, even if AHCI isn't being engaged by the guest
> anymore. Essentially, we were turned off but didn't clean up a dangling
> pointer, but we need the event that tells us to clean the dangling mapping.)
>
--------------1r0BehWXGnw4I3XFkawb0zEl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;" id="docs-internal-guid-95bfb0c6-7fff-8be7-dee5-ab656b644e9a"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Hi Everyone,</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">We are facing this issue. I see this conversation was never conversed and discussed issue is still active on QEMU master. Just for summary, the solution mentioned in this thread  &quot;temporarily enable bus master memory region&quot; was not taken with the following justification.</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">&quot;Poking at PCI device internals like this seems fragile.&nbsp; And force</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">enabling bus master can lead to unpleasantness like corrupting guest</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">memory, unhandled interrupts, etc.&nbsp; E.g. it's quite reasonable,</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">spec-wise, for the guest to move thing in memory around while bus</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">mastering is off.&quot;</span></p>
    <br>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">There was an alternate solution mentioned in thread, that is to mark PORT_CMD_FIS_RX and PORT_CMD_START disabled forcefully if the bus master for the device is disabled. But there are no further conclusive discussions on this.</span></p>
    <br>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">I wanted to start this conversation again to hopefully get a conclusion for this.</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">
</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Thanks</span></p>
    <p dir="ltr" style="line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span style="font-size:11pt;font-family:Arial,sans-serif;color:#000000;background-color:transparent;font-weight:400;font-style:normal;font-variant:normal;text-decoration:none;vertical-align:baseline;white-space:pre;white-space:pre-wrap;">Manish Mishra
</span></p>
    <p><font size="2"></font></p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/09/19 7:38 pm, John Snow wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a4a39c82-e5bc-71e9-28e8-25a0c68e2d6e@redhat.com">
      <pre class="moz-quote-pre" wrap="">

On 9/10/19 9:58 AM, Michael S. Tsirkin wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On Tue, Sep 10, 2019 at 09:50:41AM -0400, John Snow wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">

On 9/10/19 3:04 AM, Michael S. Tsirkin wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On Tue, Sep 10, 2019 at 01:18:37AM +0800, andychiu wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">If Windows 10 guests have enabled 'turn off hard disk after idle'
option in power settings, and the guest has a SATA disk plugged in,
the SATA disk will be turned off after a specified idle time.
If the guest is live migrated or saved/loaded with its SATA disk
turned off, the following error will occur:

qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
qemu-system-x86_64: Failed to load ich9_ahci:ahci
qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
qemu-system-x86_64: load of migration failed: Operation not permitted

Observation from trace logs shows that a while after Windows 10 turns off
a SATA disk (IDE disks don't have the following behavior),
it will disable the PCI_COMMAND_MASTER flag of the pci device containing
the ahci device. When the the disk is turning back on,
the PCI_COMMAND_MASTER flag will be restored first.
But if the guest is migrated or saved/loaded while the disk is off,
the post_load callback of ahci device, ahci_state_post_load(), will fail
at ahci_cond_start_engines() if the MemoryRegion
pci_dev-&gt;bus_master_enable_region is not enabled, with pci_dev pointing
to the PCIDevice struct containing the ahci device.

This patch enables pci_dev-&gt;bus_master_enable_region before calling
ahci_cond_start_engines() in ahci_state_post_load(), and restore the
MemoryRegion to its original state afterwards.

Signed-off-by: andychiu <a class="moz-txt-link-rfc2396E" href="mailto:andychiu@synology.com">&lt;andychiu@synology.com&gt;</a>
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">
Poking at PCI device internals like this seems fragile.  And force
enabling bus master can lead to unpleasantness like corrupting guest
memory, unhandled interrupts, etc.  E.g. it's quite reasonable,
spec-wise, for the guest to move thing in memory around while bus
mastering is off.

Can you teach ahci that region being disabled
during migration is ok, and recover from it?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
That's what I'm wondering.

I could try to just disable the FIS RX engine if the mapping fails, but
that will require a change to guest visible state.

My hunch, though, is that when windows re-enables the device it will
need to re-program the address registers anyway, so it might cope well
with the FIS RX bit getting switched off.

(I'm wondering if it isn't a mistake that QEMU is trying to re-map this
address in the first place. Is it legal that the PCI device has pci bus
master disabled but we've held on to a mapping?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
If you are poking at guest memory when bus master is off, then most likely yes.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Should there be some
callback where AHCI knows to invalidate mappings at that point...?)
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
ATM the callback is the config write, you check
proxy-&gt;pci_dev.config[PCI_COMMAND] &amp; PCI_COMMAND_MASTER
and if disabled invalidate the mapping.

virtio at least has code that pokes at
proxy-&gt;pci_dev.config[PCI_COMMAND] too, I'm quite
open to a function along the lines of
pci_is_bus_master_enabled()
that will do this.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Well, that's not a callback. I don't think it's right to check the
PCI_COMMAND register *every* time AHCI does anything at all to see if
its mappings are still valid.

AHCI makes a mapping *once* when FIS RX is turned on, and it unmaps it
when it's turned off. It assumes it remains valid that whole time. When
we migrate, it checks to see if it was running, and performs the
mappings again to re-boot the state machine.

What I'm asking is; what are the implications of a guest disabling
PCI_COMMAND_MASTER? (I don't know PCI as well as you do.)

What should that mean for the AHCI state machine?

Does this *necessarily* invalidate the mappings?
(In which case -- it's an error that AHCI held on to them after Windows
disabled the card, even if AHCI isn't being engaged by the guest
anymore. Essentially, we were turned off but didn't clean up a dangling
pointer, but we need the event that tells us to clean the dangling mapping.)

</pre>
    </blockquote>
  </body>
</html>

--------------1r0BehWXGnw4I3XFkawb0zEl--

