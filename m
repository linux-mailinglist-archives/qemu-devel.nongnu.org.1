Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF9C7148A8
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bAm-00082V-9V; Mon, 29 May 2023 07:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3bAa-00081t-Te
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:36:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3bAY-0000st-6V
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:36:11 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34TAUYNc019135; Mon, 29 May 2023 04:36:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=6uZOba/zYRPn4kORvvWR6s43spQyi6PL+jAf0OuYvDA=;
 b=D29kih6IWHwMXDundrGU5nVAfhoZp7aL/sPgt7sFvaMv9NrQqsi1IxgtfyRv4pWk3XwO
 oBIw3oE8gIalICL/u2oo+1xiifl9ieTHBjNTeqepg3zHnBR5Ls8mCtL3E8DF+jnrPb2/
 rV3CBpk0Rl6k2SH72PTv7dOwQprUd+IQJy8Ylt1ql96i0zhabYH9x3J6rhrJ/EkJ0tUs
 i79Cm/wNSzSiY6W6KxrPJEsldIP18zVPpHSRRk+ZIu/nrAz9jiGwB/IlkcOHqSAIJ4F7
 kL5wQgvzBDMmw4YhFHGunxrRKmRFEtFO4JsTAZn0XwIJZoAGVIOum2hEd6FeOh4X+vDF Cw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3quhcxmxbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 May 2023 04:36:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAgMMyjdfD/w5lJgN/SNMuRQj/YF9nIhHIBFzT+UUiIl/Kr+MdUzPGQrf7Ih/4knid6eRa+PGEzC0JGxgzJeCpbCPwq5YNNT3+a7s34wj35ulPaczL6mKAsqZ9cOetA5ykQZCRszrzVolHflIBk0UiSpbkFuP5QuwZpa6lwMYesR++yfTFDCh8qkB8tMp5kqW05RZGeNwONOQN5KZ58WbZCn0CYSiCwTefWHIa1DmPAYivSASF9b/dinuFoJU6fQfsoQ557aC/dird6cc7Y/hPCM75kRsQEJtnTKXVGTEep+CG7w+QuOeCxeANMaJOyySijWtKL+aaRjdonKhW+ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uZOba/zYRPn4kORvvWR6s43spQyi6PL+jAf0OuYvDA=;
 b=MeyUHjGmohHj5fBOwyrm/6QaWVfcoSjYXFkeL/A7bQUHyE5i60zVp/0ayyEr2qW42KnZlC3EihiWr+gMAt1Fmjr2sU4cLKjtTnmMDHe3hKRBNEgyMtxWo6nzGn0hN31VkhJUwGY58Y9eSJCZz/hx6a3xw3cVl/XaruELJU2GlwBL5Hb/6Z+uJvpaAwHbFMwhz45+M/EVJWHsQwN1xy4WZ/RcpiUFwuqC7fX1MAJLJoOGCVRgCweUgu6U1lCxWV45/NK2IyC+4GSilVOd3iuB8ZuXWIsFs5pcQKaX0FkCExHbCFjqejMFCzmbgkopHLF5A4MUluarbj1zrC2qne1REw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uZOba/zYRPn4kORvvWR6s43spQyi6PL+jAf0OuYvDA=;
 b=G7XK4uH7jCcDCc2c7iompsYFuswDGY/B/n59MUINHw2xpHffk5Kz7Mx/E76EWn2YqYMI6sL5e6MaqEsoUDDT4QB0mFQ4Ggogc88rVgyalOoMAJ6tt8mkNQ3zlR8BBoQJFhswUkxNoFWMHn/CewnBQCVJ7dNNcY+GSpUED1noT7v0y91pHniGt6dJYuZ0EE0YVtewVzvG9fmyMnRfIXuZ8N1H4YJUuL76NfavIYQYwLUvH5Vooj7jitJ5nhiaadWauSgpNvoldD3hoLp4YJvYcXwu29egySg685NupLNI62jfnTlTyGPzm5Xg2LuRV9XdSmSv4ipvgrOAuaVev2qkzA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB8037.namprd02.prod.outlook.com (2603:10b6:8:16::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 11:36:07 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 11:36:07 +0000
Message-ID: <fed34a58-3344-a13b-008a-b3442df5134e@nutanix.com>
Date: Mon, 29 May 2023 17:05:55 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 8/9] migration: Introduced MigrateChannelList struct to
 migration code flow.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-9-het.gala@nutanix.com> <871qj4jnl9.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <871qj4jnl9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::14) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM8PR02MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f25cf7-52b1-47be-053b-08db6038e40b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tp0tq/clYxBz/BhMgt4HS2XezTLQn8KbK1JOwSj5BTk8iETshM5JwyP/4ekEMkiAJJs80twX/zKf3NpX//z3z1BJI6TSIPNnhyAEPqNSczoR/YrxwjfqeTZ6OlvHCYG10cFSIm8Pi8s8iE2oDWef5FEyaT1XndS4QU+GC7xdqOhmz1BIOF2kgMa+p0+zf+DnOFBKroRC5YUOgbHx8qqxEB4u6n93SWCF8WHkTbEJa8ws6X4ny99tGx6ZPQSD9zvDJ6ATFSjoywF2AdlylMuXHzyozOePjAtXapXy0HQGSiIJoPou2E1OzBk7NNowCGYklktXlLUXJ/mljmcPFRjMcybzGaVz1s6S/BPQOjoVYWacNj4aQHS6pdKqZ55/V7WcieZ3fhWb+fSxPc5QM9PHdgUvZU9RtDN6FN7RgTs+Yew0EG+CLuMztNNyQMV90n/0MKncM25NJqjd3P1NQ6NVKBbVAN+m3vO95h6KEi1IF0jDYF/uNcfC9XEzvyQuofQREtA/Zf79lYB4gDWkEMkfM3f05tEKK2QKGAx/LLbBsUVtk7WV7cBSCLqS2rGtioYhoEe/7KcWpscfvPi6RmEMGEWNtwmlDr+90oc9Sn8e6cbT+/xuyF3h08hhIEsLm/9HSl4hBTBRMKWsouhFX9Owyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(26005)(6486002)(53546011)(6512007)(6506007)(2906002)(6666004)(316002)(186003)(5660300002)(107886003)(44832011)(41300700001)(36756003)(8676002)(8936002)(478600001)(38100700002)(31686004)(6916009)(31696002)(86362001)(4326008)(2616005)(66946007)(66476007)(66556008)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVIzNWppK0JEc2txdnlMQUM0MGcwQ09mZ1Z4aGFqcytzdXBaNjcraG5pOVpN?=
 =?utf-8?B?Y0pzVlQ5T05XR3BmK1ZTd1hvckhheWYzUlZlNi9PWXovRlI5UldIQk5BV09w?=
 =?utf-8?B?OG10NGJjN00zckgvU0xqMlJ0N0NZNEpyUkFJMXRMdFNoYnRFalVVeDE2VC9T?=
 =?utf-8?B?SjVlWjFWTFZFMVVzTXVMaXlNZEhSc3MwdkFGNzdEMWNNaGRxTCtsYjRERm1B?=
 =?utf-8?B?Z2s5S1J5UHgydStndHN2MFJFYmVqaG1rOVovUTV0WDhCMlhaTUVGei9OMFZ5?=
 =?utf-8?B?dnBOaG92ZTl1QXdHMlBmWGhoUlpvaVowSWF2SWRpUnJnK1hGVnU5YlFQbU9x?=
 =?utf-8?B?WVRYdzBmTFFVMWlNN0pNL2N4ZU5mMWRQdE5SbTkrY3dsWjRhRmZzckE1Zkpz?=
 =?utf-8?B?TzFMS24zQjRxbmRkVG10dUxRR3RiRlhlZ1RJSFJOMnQ1UUU3VzNOblo4SXlh?=
 =?utf-8?B?Y2FITm02bTViVlBNbStmbHljcWZyR2tCcHIxQVpFZmVGQzNPaVFaQlZXanU5?=
 =?utf-8?B?WjB2bjNVWmlIREUzUlNOdXJwSzRKVnBqKytsd1ArSXZMMHMxVVAwVVk4bjFy?=
 =?utf-8?B?QkxmS1Y4QUZBeXV0UGlWUWZyYk9QcytVTUlBT0FyeStpNE02d0FnQys2NFVy?=
 =?utf-8?B?TjV1SGR5U0VoSkdkZkx2Qnk2T0g5TDg3eXFUc3JibDRKTFdMSmxBQmJwTHVy?=
 =?utf-8?B?TTFqYUhwZDY2RUlFaVhtdmNJRWYyWnNlbXdrR1oyR0x3ZmI5QnlObVozbHpp?=
 =?utf-8?B?bFNRcEY3UjZtV2k0bzdRWjNnQ3h2U2xzaWROOTZBenNpS0FvRG1wc2VGZCtU?=
 =?utf-8?B?Wm4zem9FTzgrck02VVJjRmNIeGRWSjFmMGRIOGpjWHprK2RGaE4wMi9SZkpO?=
 =?utf-8?B?eGVUL01veTF6c2xlY3J4K3Jzeis4aVRKTmF2UlZFdjZMblV2VW1tSkdjRHNs?=
 =?utf-8?B?Y01CSWxoZnJ2dEVTQXFDVVREeExvZWxGRFlIbGc2OFVObVN1VGhmMUtxaTJy?=
 =?utf-8?B?R0RPR1YyRzFlT0J2NWFHYnhCeUJvZGV4Mi9obVlLdFM0WnBXeVBkZTEzUWdj?=
 =?utf-8?B?VU5vL1dMMW9kS2wzSlc0TEZYNGpwYk52WVdDcnJCOGlac3Ftcm9TSzZtQnA2?=
 =?utf-8?B?YmdaTll3a1VIT1JpM0VrSUQreE5DdklYQllrSjVYeHBqRHJBVnBqell0OFZj?=
 =?utf-8?B?K1RJRk1TYnNoSlJVVWYxeWFORmxPemIxVFBtZGtHUHgwWllLelFuSGxKV2Uw?=
 =?utf-8?B?c0tOSXVJZUwrdnRxZ1J5ZlFINk9aTlliRDBFcDdya1R5RGlma2M5RzV5OUl3?=
 =?utf-8?B?TTdYV3BWYnJGUGdPRW1oN2xSaWFhWnlDS2dLdUdxREM4R250dy8yekRNVVEv?=
 =?utf-8?B?RmRYN2p1TlJYQ2hReU9iTmF1d2pVVHVCRjludFNPc283MDVZSW4xOVNUY2Ju?=
 =?utf-8?B?YlhkM3VBVlBlVEJSVEJZMUQrRjAxT0lYVmxlaHZRUS9wZE1HM0h0cGtvM3Uv?=
 =?utf-8?B?clJBV2ZaR3piYWpPbFZvcTNZVFd6dkFadEFQdTUrNkFZd1VFczBLVjZINlI0?=
 =?utf-8?B?aUFIMlFlUGhpU1BxczZoUjhGazlYSGtzLzI2c1NkeVJzTFA1dHA0cHlJY0ZI?=
 =?utf-8?B?L3FSMkRxMGgwMXJoRmZlTWR4M3M5dm1MYVp1c1JCL1h6MGhxdlBHTnJXVmtn?=
 =?utf-8?B?WDhHNnVPTHJjYXFrRW01OWwvcSs5bEZsV0NQbHZUSGpiZjExY1dhS0FmOS83?=
 =?utf-8?B?ZU04WDY1emdrcHJmaHhWbWh6VTBDZHVRUHhiZkdqb1BxSlRwdU5CRVpud2Rl?=
 =?utf-8?B?MjgzMlVOZ29MY1FQYUx0ZnNPUWdJbTRNYytUK1dudUtVTVRucUlsb1FOTXIr?=
 =?utf-8?B?YjZqUHJDZFA2TUp3TzVZeG9kbDdXVkZNRTJzeXlPZVdFWUlaMXRybW9VNmli?=
 =?utf-8?B?U3lueEhKVXE2Q094cHMyd1ZlN3dOZmY4bzNtVTlqZ2pYS3Zka0NrRHRWTlRh?=
 =?utf-8?B?SVZST2pyY3J3aDhKQWtERURGektHRXV5NTZiQWlPMlJzSEl6ZTlURlFtUXVq?=
 =?utf-8?B?bG00a2tsZjZZOXB3VE1tYlBMcWZsQzFpZkJBSm5ZVndoV1JsVW80aEthNmVx?=
 =?utf-8?Q?fETpUJJ2pJwjRJm8hKPlCRvu0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f25cf7-52b1-47be-053b-08db6038e40b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 11:36:06.8494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcM06xEhrSNnHGXf49DpR1U0Wfezo3v9f4rlitadqcvgDCk1us2PRk54DQ8h2gdweggiPwBWgxa1SPuFmqShUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8037
X-Proofpoint-ORIG-GUID: aoQU5BiuX6uX-bwCFjFY3_8GxvCE0_pF
X-Proofpoint-GUID: aoQU5BiuX6uX-bwCFjFY3_8GxvCE0_pF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 25/05/23 11:32 pm, Markus Armbruster wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> Integrated MigrateChannelList with all transport backends (socket, exec
>> and rdma) for both source and destination migration code flow.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
> clang warns for me:
>
> ../migration/migration.c:497:13: warning: variable 'addrs' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>          if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../migration/migration.c:503:54: note: uninitialized use occurs here
>      if (!migration_channels_and_transport_compatible(addrs, errp)) {
>                                                       ^~~~~
> ../migration/migration.c:497:9: note: remove the 'if' if its condition is always true
>          if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../migration/migration.c:497:13: warning: variable 'addrs' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
>          if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>              ^~~
> ../migration/migration.c:503:54: note: uninitialized use occurs here
>      if (!migration_channels_and_transport_compatible(addrs, errp)) {
>                                                       ^~~~~
> ../migration/migration.c:497:13: note: remove the '&&' if its condition is always true
>          if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>              ^~~~~~
> ../migration/migration.c:477:36: note: initialize the variable 'addrs' to silence this warning
>      g_autoptr(MigrateAddress) addrs;
>                                     ^
>                                      = NULL
> ../migration/migration.c:1735:13: warning: variable 'addrs' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>          if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../migration/migration.c:1741:54: note: uninitialized use occurs here
>      if (!migration_channels_and_transport_compatible(addrs, errp)) {
>                                                       ^~~~~
> ../migration/migration.c:1735:9: note: remove the 'if' if its condition is always true
>          if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../migration/migration.c:1735:13: warning: variable 'addrs' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
>          if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>              ^~~
> ../migration/migration.c:1741:54: note: uninitialized use occurs here
>      if (!migration_channels_and_transport_compatible(addrs, errp)) {
>                                                       ^~~~~
> ../migration/migration.c:1735:13: note: remove the '&&' if its condition is always true
>          if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>              ^~~~~~
> ../migration/migration.c:1715:36: note: initialize the variable 'addrs' to silence this warning
>      g_autoptr(MigrateAddress) addrs;
>                                     ^
>                                      = NULL
> 4 warnings generated.

Thankyou Markus. Will look into it once again, and make changes in the 
next patchset version.

Regards,
Het Gala

