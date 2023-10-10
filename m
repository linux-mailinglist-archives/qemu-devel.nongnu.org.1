Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA17BF130
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:02:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq30o-0000cV-Hj; Mon, 09 Oct 2023 23:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qq30m-0000cI-07
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:02:20 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com
 ([40.107.244.69] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qq30j-00005i-75
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:02:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT13hsJ2/WFCnKZ2dRN+I5lmV+kB5WNqDEbwtjUFOu2Z9p47shhloVjhrd88jHdadfBa8tQoau1iTHkv1Ie3N7UNjTyCLoXilmVwIOkAOG5Ca9HX253HWsY3fSoIbsc+RXttouEE3H6ZJpYCFsZqTjHwF58Qgyu63t+x9NDkv2PTqiZ8zmojyTFHwaC0tztLeF9J2x0HTGryySw2NCZEVue+0p9IXam8ipLpxWmmQTYsNSOVlqTaP0BN2jkO5tU1vWZNi4A1orSZhnZ0NZfVLyF/xiokWGE/UMSnwryJk+x7xTKfkO2w/mshT0mv+5Ut73oX6RkYUYdQlhYc3ARp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLy0uHEYzggIVQV/ZUHJroxsV2FFBcEb5sXVC+l6jvY=;
 b=W9Tqf+6ORxtGcoMvG45jRM7XbQlSiil1r9dhFmXY0TtD6aEf2ffZJlQ6Yv7I7EmtTX1k7Fh/P2CMheZB+Z7gxr4RClsZ5xHTIgTuy84KC3npyaWXZM+O3rdIpK6MNnOJBd1BRnWUuC5m58WX4r4TW+s2wkg415+MWBkEQ1pARVEMUSIJtSSJt+GbeZ86g1heigtBrYrwhrPbXxQXSDd06puyQBY4JoNLWuTF3NJ9hkLas9tHdeWIZWz7PSwNlWMlECLX0xoMPgoHZdNVUpAHr/UGBz8zJFA1C31GeZ/brnxye1qRxDnTdKNNYn2umHsE7Op6vKht+DVUMXWmNif+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLy0uHEYzggIVQV/ZUHJroxsV2FFBcEb5sXVC+l6jvY=;
 b=SRHFJt34pJs9sD735NBHHHdN7jpwcw2p70beU5i/w0OQFxlE0MMmAe8C6lpSwH3OjFNr42ZG6oHhOJJtb5Ept7IHy3OJtAwkir90GRXe7rqt8wXR4TCaWZ5Hj+mqAGev1GlF1Me7/5h0RNL8x/m0eoFxCBgNZVoy6k+nB5rQfJzhuQqm0bDFbcBS9toPWBSEVT/KARKGGUYaRQiohtJkor5C78ojBVOSVV9UOAQvTCTVzZSMIm9vTalgijIHZXxicasbYGyR0oq5RI2/4ebqrI0Rm0wwrt0VhdEyMuPucpAZMEV2dDdyS0odjtgcUlAkgtAKhX3eXrU3c3yODPROaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 02:57:09 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 02:57:08 +0000
Message-ID: <ccfb153c-0e2e-15dd-b543-5b5a8bebbff4@nvidia.com>
Date: Tue, 10 Oct 2023 10:56:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
To: German Maglione <gmaglione@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hanna Czenczek
 <hreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Parav Pandit <parav@nvidia.com>, Anton Kuchin <antonkuchin@yandex-team.ru>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
 <CAJh=p+5OFrx4nP5rYKrgZ_y02n358wy70c4L0L4fHKQUo9fU5Q@mail.gmail.com>
Content-Language: en-US
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <CAJh=p+5OFrx4nP5rYKrgZ_y02n358wy70c4L0L4fHKQUo9fU5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e29bc4-cf7c-4025-a676-08dbc93c97de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5afGVYbVO48+gIZWAdnpq6IaNJsO7HHVJ4UVC+UsUQkCvODlwD3dh1fF9nQD1FK/7W8RAAgOgTlAYMZDoUNW3VHO05bPL5G7Vi/g0hnI/zaF67OcJcMeiL+9VzF8RUt074QlwjV5rXU6wbp9NOxUdg2z95mu9B6kPiMb2L5YEUwdrWu+0EBBY+Uau3vfT9eZR3qpmG+SWsi70oF1s302+jK2nFkjKZ+xz249AiCyZwuVfGltKs5PbqkJ88cBfNsJYK4rUrqmKI1x/DmK1b0LUf47KYwsEuIByF/LlKhFtvnz+946o4S3OdX/hWTLP/FkHzFvjGojeIbmjwzXw1EVuJy6MIwKFiy3iYWOxOD9CCXqQ1Kl9M2F0NlaUni1Sak829AucIgO6rgR4PmtkOf8b8N0wuQJzYuUTf2Idtol9dZWdy7EwFI417ijvi9kxqR/QJS373QDNhgPazhyiaynUyj+gJop92IHQTHl4t4sVdcTgTjtvz+wJXNpTJk3k3HlbvuA1AlaQ0LkogODsQAhsRAVsYuWCt9CqUotc21P25PguxFmED8Q+i5Yud0ofCXZQBHs5H5jKT2tGZ4jAL6wHWduQ8Zl/enuOHPIESv+VgCIqblULFv9ajrDbmrHstVFNoPseY906wAvpjmST4fMvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(86362001)(38100700002)(36756003)(31686004)(6512007)(45080400002)(478600001)(53546011)(30864003)(2906002)(8936002)(316002)(8676002)(966005)(41300700001)(6486002)(6506007)(6666004)(5660300002)(83380400001)(2616005)(66556008)(66946007)(66476007)(4326008)(6916009)(54906003)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWEwRFNoSHloK2VwazZkY0ljcG9HQTgxRzZqYVp5VW5DWDJrWHF3d0p0R29J?=
 =?utf-8?B?M211NTM1NlNYOHFheGI5U3hZeDN4MVFpbHBzdlhoUzhoMExTaUZmdDJBTzZ1?=
 =?utf-8?B?R2VMcFhNellSaDZlTHNHVTVWZE1mcG16UXdFUHN4S2lycUFUVG1vUW5rek1z?=
 =?utf-8?B?V2duT3Z5WnNzYUlDYkxsMDVVcU9DTzFUbUNDeUg0eDU2SjlJT3FpU2kvQ3RK?=
 =?utf-8?B?MjNtSTFZdFAzb25YY2ZpbXdSTWpFMzB2WHgxN2dxTWNYc3g3U2dzYzFNVk1o?=
 =?utf-8?B?dklHVmdORzlqOXp1VHhUdWZ3a0pSQjlKeVNBSFlhRlBVeFJSNnUveHFWT3NL?=
 =?utf-8?B?QW1NR0R1bG9YbzRrdm9mUXNnb1BVY0MxQ1d2Q2hxdUJxWGxpSXY5Ym5VTFBv?=
 =?utf-8?B?bUpOTThvSkpoUURyc2QvVlluUkNWTFRJandWVnUzUjRKL2pZQXgzMEpmTEhu?=
 =?utf-8?B?bFA2RlJKTHRNdEwzZmR5L3dBNWJQa1JlVnQ0eURjMkRjcDVJOWgvUEViQnRD?=
 =?utf-8?B?S015MXl6c0p6UFNVTFRsdEd2NkFtWjkvOXVsOHk0OFh6OENpWXRKWXg5Smk3?=
 =?utf-8?B?RkZJeUN6eUh2ZEt2RGlKTWpubm1XUlg5SzJEdGJOUTZISElBUWFIZ21Md2p4?=
 =?utf-8?B?dUNwWGpkWmtEclBWdDlPSnpOTWQzek1BcmJpTFVsUVlpUmpsNkZQZzg2a0d6?=
 =?utf-8?B?ekJTVFBQVWxqSy9RWnZKTUZ3aFpyaTFRMXFzcFNBUnRiL3FGbm42aloxdnBv?=
 =?utf-8?B?RHF2c1F3M0tBN2wzZ1huNXI3SEVrS2p3K2FLbVBWNGtNVlR3S3BCdjNZSnBh?=
 =?utf-8?B?bzQ3U1ZXaHp6a0hnZlV3VmdYU0hyWW5OVXUxSVlQY011cml0SmkwZnZ4V1p3?=
 =?utf-8?B?ZE9HeWdEOHBGb2NiQTZJNkU4VnNheVJwYm84Q3FPbzA0U0JVQlNyQXNFbFQ0?=
 =?utf-8?B?V2hUNnpYY2dIc2tjREdPT3BLUVFZL29ZaklFWEdueXZsTVRjdjZ6RVRGbXgx?=
 =?utf-8?B?Njhod0RWTFFBaVEwQXpGZ2hWZTh6UUFqbm5UaERzdHVzTG00Vzl6Z0VMOEo3?=
 =?utf-8?B?Nm40blo5OUVyUmdITzdhR3F1TmxmdlpTcEFrNEkrOUM5d1g4OFg3RnZ5alQ3?=
 =?utf-8?B?MzRrcDhlMVYzTUtBR0hsbTFOWDdGcHlpZy9xU0NMZEJPcTBuR1hGRzlNV2sy?=
 =?utf-8?B?MHVwejlFQ0lIRDJiOXBLaWVuK01zOEJOVDlUdUQzRkU0L1JUaDZlcElIeElz?=
 =?utf-8?B?SnF6MTBNdVRFRFFqUDAwVm55QnpZaDJ6L3h1OVE0eDE0TG9wZEFEcnlYUDUr?=
 =?utf-8?B?VnhFWFRGeVRNRk1lUVN4dldMQVVwVEZ2WnpnYWtTa3JMYjFycDFTZ253U1h5?=
 =?utf-8?B?OEh3NUdNbTBYTWU2ZW1EWUxmRkNVOGNrWUR2SFg3cHRyVXVvdjZtY1VWZXpi?=
 =?utf-8?B?Z3ZoOFkxL2lZbEc1K0pCL1I3Z0NMdHl6QnlFNlJSODVuWHN6T2tQb2MwY0VW?=
 =?utf-8?B?bHlubmh6YU51QkNuUTNCNGFKcGxsL2ZwdEphNG95S2hDNW5raUVWWGNKdXJQ?=
 =?utf-8?B?d2U0NWo1VkFQUGxQOEFlYWlUVHJNeGh6NHpwbmJGMGJPbDJYY1l6MUt6d2x6?=
 =?utf-8?B?TExZZG10QXFwSnkxM2ZRWnRpUnNmazlhajM3L0ZMWUxnaTFvT2tQWitjQmMr?=
 =?utf-8?B?amR2ZmNyQTd3WCs5TFIwNVBpR01MNjRFY1B5bGZyTHdCbU9BdkVRSFNxaStw?=
 =?utf-8?B?ekxYWkFpNExhOW0vSjdLTEUrSWxuREduNU95d0RKSmJaaUhNV3NnaHdNM3RT?=
 =?utf-8?B?eFNEcEgzM2RDekNtVUlFSlJSaWl4cUo0aTlRdFFFVmxLcDF0RkhUTFhnUEpK?=
 =?utf-8?B?TmRYMUFqQlpuVUhob000YzJrSHlYSE9JdUNad3MyaWQ2bGYwS1B0dER6RkZI?=
 =?utf-8?B?MXV3dXJHOVRhbW5QQmpWMm1PanRSb0d4WHFuVmo0MGYvOGZuVVdJR3VnSXFt?=
 =?utf-8?B?M3RYQlRJTE56b20vc1UwUkk3aWV1WEpEblY4aGxKbEpIMVhNUHAwN3QxSzRV?=
 =?utf-8?B?T2xQcWExMzgwR2xFR29mdUtweUswQkJpc09tUG9jVWVhcFR0VFRwUmVjcENH?=
 =?utf-8?Q?um5h+Z8tSrCDqXdf2xkbZgfI5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e29bc4-cf7c-4025-a676-08dbc93c97de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 02:57:08.9386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qG3w8g8/xQ4o/Fm9U9NtpPjOIntMtDjJw6Gz4NmeTf7L/0sfghJk8/H7BDkod3Yz6QKLL1fHsFXGjgOPhwZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
Received-SPF: softfail client-ip=40.107.244.69; envelope-from=yajunw@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 10/9/2023 6:28 PM, German Maglione wrote:
> External email: Use caution opening links or attachments
>
>
> On Sat, Oct 7, 2023 at 4:23 AM Yajun Wu <yajunw@nvidia.com> wrote:
>>
>> On 10/6/2023 6:34 PM, Michael S. Tsirkin wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
>>>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
>>>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
>>>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>>>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
>>>>>>>>>>> There is no clearly defined purpose for the virtio status byte in
>>>>>>>>>>> vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
>>>>>>>>>>> feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
>>>>>>>>>>> protocol extension, it is possible for SET_FEATURES to return errors
>>>>>>>>>>> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
>>>>>>>>>>>
>>>>>>>>>>> As for implementations, SET_STATUS is not widely implemented.  dpdk does
>>>>>>>>>>> implement it, but only uses it to signal feature negotiation failure.
>>>>>>>>>>> While it does log reset requests (SET_STATUS 0) as such, it effectively
>>>>>>>>>>> ignores them, in contrast to RESET_OWNER (which is deprecated, and today
>>>>>>>>>>> means the same thing as RESET_DEVICE).
>>>>>>>>>>>
>>>>>>>>>>> While qemu superficially has support for [GS]ET_STATUS, it does not
>>>>>>>>>>> forward the guest-set status byte, but instead just makes it up
>>>>>>>>>>> internally, and actually completely ignores what the back-end returns,
>>>>>>>>>>> only using it as the template for a subsequent SET_STATUS to add single
>>>>>>>>>>> bits to it.  Notably, after setting FEATURES_OK, it never reads it back
>>>>>>>>>>> to see whether the flag is still set, which is the only way in which
>>>>>>>>>>> dpdk uses the status byte.
>>>>>>>>>>>
>>>>>>>>>>> As-is, no front-end or back-end can rely on the other side handling this
>>>>>>>>>>> field in a useful manner, and it also provides no practical use over
>>>>>>>>>>> other mechanisms the vhost-user protocol has, which are more clearly
>>>>>>>>>>> defined.  Deprecate it.
>>>>>>>>>>>
>>>>>>>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
>>>>>>>>>>>       1 file changed, 21 insertions(+), 7 deletions(-)
>>>>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>>> SET_STATUS is the only way to signal failure to acknowledge FEATURES_OK.
>>>>>>>>> The fact current backends never check errors does not mean they never
>>>>>>>>> will. So no, not applying this.
>>>>>>>> Can this not be done with REPLY_ACK?  I.e., with the following message
>>>>>>>> order:
>>>>>>>>
>>>>>>>> 1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATURES is
>>>>>>>> present
>>>>>>>> 2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_REPLY_ACK
>>>>>>>> 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
>>>>>>>> 4. SET_FEATURES with need_reply
>>>>>>>>
>>>>>>>> If not, the problem is that qemu has sent SET_STATUS 0 for a while when the
>>>>>>>> vCPUs are stopped, which generally seems to request a device reset.  If we
>>>>>>>> don’t state at least that SET_STATUS 0 is to be ignored, back-ends that will
>>>>>>>> implement SET_STATUS later may break with at least these qemu versions.  But
>>>>>>>> documenting that a particular use of the status byte is to be ignored would
>>>>>>>> be really strange.
>>>>>>>>
>>>>>>>> Hanna
>>>>>>> Hmm I guess. Though just following virtio spec seems cleaner to me...
>>>>>>> vhost-user reconfigures the state fully on start.
>>>>>> Not the internal device state, though.  virtiofsd has internal state, and
>>>>>> other devices like vhost-gpu back-ends would probably, too.
>>>>>>
>>>>>> Stefan has recently sent a series
>>>>>> (https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg00709.html) to
>>>>>> put the reset (RESET_DEVICE) into virtio_reset() (when we really need a
>>>>>> reset).
>>>>>>
>>>>>> I really don’t like our current approach with the status byte. Following the
>>>>>> virtio specification to me would mean that the guest directly controls this
>>>>>> byte, which it does not.  qemu makes up values as it deems appropriate, and
>>>>>> this includes sending a SET_STATUS 0 when the guest is just paused, i.e.
>>>>>> when the guest really doesn’t want a device reset.
>>>>>>
>>>>>> That means that qemu does not treat this as a virtio device field (because
>>>>>> that would mean exposing it to the guest driver), but instead treats it as
>>>>>> part of the vhost(-user) protocol.  It doesn’t feel right to me that we use
>>>>>> a virtio-defined feature for communication on the vhost level, i.e. between
>>>>>> front-end and back-end, and not between guest driver and device.  I think
>>>>>> all vhost-level protocol features should be fully defined in the vhost-user
>>>>>> specification, which REPLY_ACK is.
>>>>> Hmm that makes sense. Maybe we should have done what stefan's patch
>>>>> is doing.
>>>>>
>>>>> Do look at the original commit that introduced it to understand why
>>>>> it was added.
>>>> I don’t understand why this was added to the stop/cont code, though.  If it
>>>> is time consuming to make these changes, why are they done every time the VM
>>>> is paused
>>>> and resumed?  It makes sense that this would be done for the initial
>>>> configuration (where a reset also wouldn’t hurt), but here it seems wrong.
>>>>
>>>> (To be clear, a reset in the stop/cont code is wrong, because it breaks
>>>> stateful devices.)
>>>>
>>>> Also, note the newer commits 6f8be29ec17 and c3716f260bf.  The reset as
>>>> originally introduced was wrong even for non-stateful devices, because it
>>>> occurred before we fetched the state (vring indices) so we could restore it
>>>> later.  I don’t know how 923b8921d21 was tested, but if the back-end used
>>>> for testing implemented SET_STATUS 0 as a reset, it could not have survived
>>>> either migration or a stop/cont in general, because the vring indices would
>>>> have been reset to 0.
>>>>
>>>> What I’m saying is, 923b8921d21 introduced SET_STATUS calls that broke all
>>>> devices that would implement them as per virtio spec, and even today it’s
>>>> broken for stateful devices.  The mentioned performance issue is likely
>>>> real, but we can’t address it by making up SET_STATUS calls that are wrong.
>>>>
>>>> I concede that I didn’t think about DRIVER_OK.  Personally, I would do all
>>>> final configuration that would happen upon a DRIVER_OK once the first vring
>>>> is started (i.e. receives a kick).  That has the added benefit of being
>>>> asynchronous because it doesn’t block any vhost-user messages (which are
>>>> synchronous, and thus block downtime).
>>>>
>>>> Hanna
>>> For better or worse kick is per ring. It's out of spec to start rings
>>> that were not kicked but I guess you could do configuration ...
>>> Seems somewhat asymmetrical though.
>>>
>>> Let's wait until next week, hopefully Yajun Wu will answer.
>> The main motivation of adding VHOST_USER_SET_STATUS is to let backend
>> DPDK know
>> when DRIVER_OK bit is valid. It's an indication of all VQ configuration
>> has sent,
>> otherwise DPDK has to rely on first queue pair is ready, then
>> receiving/applying
>> VQ configuration one by one.
>>
>> During live migration, configuring VQ one by one is very time consuming.
>> For VIRTIO
>> net vDPA, HW needs to know how many VQs are enabled to set
>> RSS(Receive-Side Scaling).
>>
>> If you don’t want SET_STATUS message, backend can remove protocol
>> feature bit
>> VHOST_USER_PROTOCOL_F_STATUS.
>> DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device
>> close/reset.
> This is incorrect, resetting the device on GET_VRING_BASE breaks
> the stop/cont. Since you don't want to reset the VQs on stop/cont.
Sorry for the misunderstanding, dpdk vhost backend framework doesn't 
have RESET concept(only device level .dev_conf and .dev_close). On 
receiving DRIVER_OK does dev_conf, on receiving GET_VRING_BASE does 
dev_close. For every VM suspend/resume, dpdk issues dev_close then dev_conf.
>
>> I'm not involved in discussion about adding SET_STATUS in Vhost
>> protocol. This feature
>> is essential for vDPA(same as vhost-vdpa implements VHOST_VDPA_SET_STATUS).
>>
>> Thanks,
>> Yajun
>>>>>> Now, we could hand full control of the status byte to the guest, and that
>>>>>> would make me content.  But I feel like that doesn’t really work, because
>>>>>> qemu needs to intercept the status byte anyway (it needs to know when there
>>>>>> is a reset, probably wants to know when the device is configured, etc.), so
>>>>>> I don’t think having the status byte in vhost-user really gains us much when
>>>>>> qemu could translate status byte changes to/from other vhost-user commands.
>>>>>>
>>>>>> Hanna
>>>>> well it intercepts it but I think it could pass it on unchanged.
>>>>>
>>>>>
>>>>>>> I guess symmetry was the
>>>>>>> point. So I don't see why SET_STATUS 0 has to be ignored.
>>>>>>>
>>>>>>>
>>>>>>> SET_STATUS was introduced by:
>>>>>>>
>>>>>>> commit 923b8921d210763359e96246a58658ac0db6c645
>>>>>>> Author: Yajun Wu <yajunw@nvidia.com>
>>>>>>> Date:   Mon Oct 17 14:44:52 2022 +0800
>>>>>>>
>>>>>>>         vhost-user: Support vhost_dev_start
>>>>>>>
>>>>>>> CC the author.
>>>>>>>
>> _______________________________________________
>> Virtio-fs mailing list
>> Virtio-fs@redhat.com
>> https://listman.redhat.com/mailman/listinfo/virtio-fs
>
>
> --
> German
>

