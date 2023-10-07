Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DC67BC42F
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 04:29:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qox2z-0005KU-F4; Fri, 06 Oct 2023 22:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qox2w-0005KK-Ox
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 22:28:02 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com
 ([40.107.94.41] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1qox2u-0005DP-2z
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 22:28:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTzynTYijll6Gaj+/4X/dpL0mYFKT6sntbFe97oEZZlbjYL4DpwH7xTZ6C0CgILj69ueLhoFcc3woh+WDASiT54Czy7VWsv9TJgR+wAFGF4W65u/EJJCet3q1+YEB59HcGtkIAsp5a/RIz9eiW9IXZvohXNJ4aV6vVqbTS5h/ChqoPB6Kt1CEGfmyy2iVGGAlTrX3QFgqIfdp9C+oQGEN5PSmYZaGu8IohMAKK7GCUxJtlpTXwNa9wQSil2TqWfC0MBMYXqzraXE7XCCC+1IK45io6ViYeKvHmOtD8I6K5sQdaizMoyLDe7yTxBF/xgOndtW/Zwa1cN+/ovGpr7DSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UfpmXtNo0VF+zJvWzAUyaxNz6iuNBfvf15tnkt5wqM=;
 b=ZZcW3SRe9D/Y+jjYDGlGWC//iQMpm8MtHK/PAyed7WFoVaCjXE20CFrMK1h2vRVIcLOiNA3cw6bg0j5fs9XqBoDUHLCRCRCM0acVINNXEqNh5akj2BaDPASvrO1vWPsgSKvXqUNlci3x/4miBVmYZ3+A5qgzT6pszpnuJmXDf5bRV9t6OGXZrV4i27vsWHkHuEB5Q019WO+ue2b6zwtbqZPWDIN4v1Meh2TCP2QICOwJKEBzkeZ16l3uvc8JV9SiUJN1IY5WsFb+F7VejTN/KGunh3G56GybF7RcGQj+nRC9Gik+7QkMGiZ4TUZ0Ck0twJls9RuUpCy2gVAZFqyNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UfpmXtNo0VF+zJvWzAUyaxNz6iuNBfvf15tnkt5wqM=;
 b=tpEgAsC6uBFkrTBw6CTOnFzXofamn5oj8gaaxugCH2dJ5okFthhf3CvC1yTXRdJAHTY8RFBR6oVfW3W4jSgrbAUS535hXiUaheTOoD1+VB0Vavqsbj14q2/0MHcIEaT581l6lFkxumdt55YwR6wwUry89e1WJQcTXoGH6LFkZb+PosDUMH+hmXKzk7RARolnAeh2jdfypwblk6SjL5bt6YwsSWNk1YZT9MJpjkfJsub+8hWrTdr0pvuPX8wTbrda/BWm4vLTVvwsPmPu2htAfyhtDG+qeibOwE9mQUK1XvxJVtZAYzQ5sJWUXvxVAFx2oDL8EAoH++H69ODj8P0ApA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.31; Sat, 7 Oct 2023 02:22:54 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::c036:b432:597b:cca7%5]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 02:22:54 +0000
Message-ID: <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
Date: Sat, 7 Oct 2023 10:22:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
To: "Michael S. Tsirkin" <mst@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, parav@nvidia.com,
 maxime.coquelin@redhat.com
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <20231006055229-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:820:c::13) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 253672c6-63bf-4f20-9e75-08dbc6dc4fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yYx0vA57qMZKY9A5IVwyJ3TIBYdk8x79pGt21hwipgi4zzQ8h2XgmQqua34Nrugrblaw1/uuCn//kNha/Ehj6d1eAbWL8HWtrC031jIVXa4lw990AOmm/cdZa2vlGIaknYXrK67AesnSupzpYDraDT5/vVeZoV7UqKyIbNIQYc91ZLSaJN/HDCG08LngdJwCCCBzhDGJNu9wIAiY3kKDAsoH7cOC3+PnTIILNoLk62024xl1F2HbyAHKzLi6zuJmZZpA3SZ3tragrkrJ1Q+wN+cjEkauzh5vmQLCFXVuv/0DoBbt9uwgA28yxVYsIrn1uygbdNYUVPzhcr9JN2MGoZrhn3bYk2Ij0W59RbpyKWQJp7madUwJY4R8g3DAnTuykVLymZG+RMbaDxRpaEx4TOGoF0AeUZn0HDXoLpO/sdf9lD2vQyripvei45ghWUYMQiC88iK/64iqw6kTBtOZBfty+Cx10Ly3e8PuL22IdBKlNW1wx6IcGyrh8eZwC5lRXmVEzIZvIrNTxWg5bU+JcZlN9hsVif6cw6OMKIncsXOiG1wwWHKRGbZM1AQ+eIta+Gz1mM7K3SDnYVq0Sa7RrhkD2ykCSYsKDi3tCj1u93KqTgOALDLsMgLTwylHSMHgGYxqN+UuUhZvid1x4asSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(31686004)(6506007)(53546011)(478600001)(6512007)(6666004)(6486002)(38100700002)(86362001)(31696002)(316002)(41300700001)(2906002)(2616005)(26005)(54906003)(36756003)(5660300002)(66476007)(66556008)(66946007)(8676002)(110136005)(8936002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REViNk9OcVRuVkdBUUJ0b0szeitGUWlQclUvdlBZMUhzaHVPcFZrQXA0WTFO?=
 =?utf-8?B?QkIrVFRMd2thTUJnT3hJd3hVdTRVWkl2VTM2bHdTZnJISU5SVXpNR3gxL1g4?=
 =?utf-8?B?TWJqOXpac3B4OGtBS3pyYnN6QnYyTDMxRVphUkJtaDJDZnRXOTJ3MHZSeXpB?=
 =?utf-8?B?UWNpM24zUVdlcGJYNUVXa0dhS0dzc0pWSWZGbjFrc0VaOFlpNzUraDZMV2JP?=
 =?utf-8?B?MUlWL0p3c00vVlBDYjFXNTQrdE1qdkg1TXJNcTVoWThBOGpiaE5VYXRJa2dQ?=
 =?utf-8?B?UTdOWTBXZ01QNnJSYTc5V3YwQ3lGMkdLeGxwUHlzUjNMZ2V5MXBuYVQ1d2wx?=
 =?utf-8?B?TnBaTTZZOHFPeEs3c2tMT1VYWE9lZVZjUzBOSmVGeG5aeDBRdU5ZSXBnRTFV?=
 =?utf-8?B?ZkRTcW9wRmo1S3dWQk1CMEpYVGNJNEJaN2RhWUhoTWdJaU1zMTNMZnJ0YTRW?=
 =?utf-8?B?ZDBDa0c5dXc2YzVlME55NXZUdUhTVWQ2bjlvSnd2ZVRtM2tvOTY5RDkrSGg3?=
 =?utf-8?B?SXRpWThMUDdCQ1BLWTF2K3JmbjZva0JrRjU4Z21kM25yOGRCUG9rcnplMmdr?=
 =?utf-8?B?anF3TlVmUjF4emxvb3lvYVVObzFsbXJicVJTbUZsbzcvS1pNZkVIS3cwYjBJ?=
 =?utf-8?B?aDFKZU5iWEltUmZydFEyOTQ4ZlBBRVdPRGR6OU9wdVVLaitmMkRQbk0zV2ps?=
 =?utf-8?B?Y3ZQY1NqdG4wVUpsSnM0aEJ1WFIyZGlEK2t1MFhLSE1URUp6Nzh6ODJ1OFdF?=
 =?utf-8?B?VzJaUVlQNVR5NTN4bWdmRDh4ZlZMMEo1TVpnTGpiRWV6RERTcGk5NTQ5SDI3?=
 =?utf-8?B?R2wyMDJwSmE3TjdsNmlNTTIyVUpKbzBOUStHNmJJcmxzN3UralFlUnd0dnVH?=
 =?utf-8?B?TGZzeEZIbkRiYmFtTkxjUklVRkFaNEZBT1ZxZ3BjMXk2Ti9XeWc2WDZTVCtS?=
 =?utf-8?B?cFhDcFdhanRYbS9IUTNVbm1BZW1xTS9OdTVVSXhqKzMwbVVlK25hRVk2UWwx?=
 =?utf-8?B?eUUrN3hOdVIzUkFVOVkrK0ZBZytGWFhkTlVWUjVISkNhanlGQm11bjMxc2Fi?=
 =?utf-8?B?MkVJdTRIYmFOR1hxY1crVFZ6a3AwSmNuV29RVW1mYkp3WExua3hWdVdGd1h5?=
 =?utf-8?B?eVptc29xNGo0TS85ZGhyOHZPc1FMbnk5Z3k0ZGZHTXMwdC9tQ2lmaGZnWjAy?=
 =?utf-8?B?ZGwxL256elBSWjhGeXVHRDExTjVZRHdGRzd4RWlRY0NoWFQxSjB6MkhOcGlx?=
 =?utf-8?B?MEU4NzFtUnMvaWtpZnE0Sy9lRzRsWHVTZDZKaUd5QjVhdFlpKzhUVHpvTCt1?=
 =?utf-8?B?cndqOGowT0VVcnBvN2xSTGJYdEkvZTJrN2dMNjQ5M3AzdVVrSHFlSjF2dDkr?=
 =?utf-8?B?aTNESjU2TER1QUY0cDBIZU1BUXB1L1lmTUtQSWliMEpZdFRUdy96MWZNbkQ0?=
 =?utf-8?B?c0FmYlpiL0F6bGhwNWt0MHYvdGdLWm1DS3FGSHJ6ckhydFF0bGlzbHhFWXVs?=
 =?utf-8?B?SytrdUFFQk9ZZmF6TFFoblJqbUtuTG93bUc1bkI0MWw5M0NwVEpnSXh1RFJT?=
 =?utf-8?B?dW5MMzdIWitvSVg0NXR4WDg1V0cvWnBTUWVNSGw5cEFSc2tZZjIrS2Z5dFYv?=
 =?utf-8?B?Zm9YV1BZZFhBbzhVQVVUaGdYMXJZcTlxOHlZTUQ1TDNpbzFYcUgwVWlzZVpM?=
 =?utf-8?B?bW5iT3ZRTS8vZnFLSk9wbnJHRkR1T1FCaStZelpEN1hNalNxR2t4ZFRGQUFu?=
 =?utf-8?B?eGRTZkFiVnpQdUpwYzRYMldTMFVPcTdCWFpVUmdIRG9GcTNKaStRdVYva1k3?=
 =?utf-8?B?T3dyeWh0Z25BTjZPUXc4Z3RKWGJvOU9XcEpSUXdiendiT2ZscTVhaU5vTUZ2?=
 =?utf-8?B?WkN4c2Z6YnZLRWVGSnhUV0hqRk40bXVMMDRxOHlqN2lwejZYMEdkOFQ4dnBI?=
 =?utf-8?B?bloxTDRMbEQzYmk1RXgwSUFTdjBHb3Vyay83cVIrbC83MUN4T0pCdjFBQ2h3?=
 =?utf-8?B?N1ZFVGZOZEFtOC9WUzQ4R0lDc3NGZ29lQ0pjRXFkdVM2OEFrR05zZG5NQmFK?=
 =?utf-8?B?K0FVOFJlSjJTbGE2NjNIazloMFpoTWNjenUyMHZKRWJPbGJ5MUFSTklnZThI?=
 =?utf-8?Q?fzzHtJ8oV+NKPaaF3jWAvDJgw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253672c6-63bf-4f20-9e75-08dbc6dc4fe1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 02:22:54.1364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQ4wog33k+EVH7vzakefJU1Hb0rTGh8Kb0ehB5XiUq8pwd0AyTaEVy81fpJjQY+K3E/LSLlI1GH/aq0QFYxKtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
Received-SPF: softfail client-ip=40.107.94.41; envelope-from=yajunw@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.499,
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


On 10/6/2023 6:34 PM, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
>>>>>>>>> There is no clearly defined purpose for the virtio status byte in
>>>>>>>>> vhost-user: For resetting, we already have RESET_DEVICE; and for virtio
>>>>>>>>> feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_ACK
>>>>>>>>> protocol extension, it is possible for SET_FEATURES to return errors
>>>>>>>>> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
>>>>>>>>>
>>>>>>>>> As for implementations, SET_STATUS is not widely implemented.  dpdk does
>>>>>>>>> implement it, but only uses it to signal feature negotiation failure.
>>>>>>>>> While it does log reset requests (SET_STATUS 0) as such, it effectively
>>>>>>>>> ignores them, in contrast to RESET_OWNER (which is deprecated, and today
>>>>>>>>> means the same thing as RESET_DEVICE).
>>>>>>>>>
>>>>>>>>> While qemu superficially has support for [GS]ET_STATUS, it does not
>>>>>>>>> forward the guest-set status byte, but instead just makes it up
>>>>>>>>> internally, and actually completely ignores what the back-end returns,
>>>>>>>>> only using it as the template for a subsequent SET_STATUS to add single
>>>>>>>>> bits to it.  Notably, after setting FEATURES_OK, it never reads it back
>>>>>>>>> to see whether the flag is still set, which is the only way in which
>>>>>>>>> dpdk uses the status byte.
>>>>>>>>>
>>>>>>>>> As-is, no front-end or back-end can rely on the other side handling this
>>>>>>>>> field in a useful manner, and it also provides no practical use over
>>>>>>>>> other mechanisms the vhost-user protocol has, which are more clearly
>>>>>>>>> defined.  Deprecate it.
>>>>>>>>>
>>>>>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>>>>> ---
>>>>>>>>>      docs/interop/vhost-user.rst | 28 +++++++++++++++++++++-------
>>>>>>>>>      1 file changed, 21 insertions(+), 7 deletions(-)
>>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>> SET_STATUS is the only way to signal failure to acknowledge FEATURES_OK.
>>>>>>> The fact current backends never check errors does not mean they never
>>>>>>> will. So no, not applying this.
>>>>>> Can this not be done with REPLY_ACK?  I.e., with the following message
>>>>>> order:
>>>>>>
>>>>>> 1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATURES is
>>>>>> present
>>>>>> 2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_REPLY_ACK
>>>>>> 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
>>>>>> 4. SET_FEATURES with need_reply
>>>>>>
>>>>>> If not, the problem is that qemu has sent SET_STATUS 0 for a while when the
>>>>>> vCPUs are stopped, which generally seems to request a device reset.  If we
>>>>>> don’t state at least that SET_STATUS 0 is to be ignored, back-ends that will
>>>>>> implement SET_STATUS later may break with at least these qemu versions.  But
>>>>>> documenting that a particular use of the status byte is to be ignored would
>>>>>> be really strange.
>>>>>>
>>>>>> Hanna
>>>>> Hmm I guess. Though just following virtio spec seems cleaner to me...
>>>>> vhost-user reconfigures the state fully on start.
>>>> Not the internal device state, though.  virtiofsd has internal state, and
>>>> other devices like vhost-gpu back-ends would probably, too.
>>>>
>>>> Stefan has recently sent a series
>>>> (https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg00709.html) to
>>>> put the reset (RESET_DEVICE) into virtio_reset() (when we really need a
>>>> reset).
>>>>
>>>> I really don’t like our current approach with the status byte. Following the
>>>> virtio specification to me would mean that the guest directly controls this
>>>> byte, which it does not.  qemu makes up values as it deems appropriate, and
>>>> this includes sending a SET_STATUS 0 when the guest is just paused, i.e.
>>>> when the guest really doesn’t want a device reset.
>>>>
>>>> That means that qemu does not treat this as a virtio device field (because
>>>> that would mean exposing it to the guest driver), but instead treats it as
>>>> part of the vhost(-user) protocol.  It doesn’t feel right to me that we use
>>>> a virtio-defined feature for communication on the vhost level, i.e. between
>>>> front-end and back-end, and not between guest driver and device.  I think
>>>> all vhost-level protocol features should be fully defined in the vhost-user
>>>> specification, which REPLY_ACK is.
>>> Hmm that makes sense. Maybe we should have done what stefan's patch
>>> is doing.
>>>
>>> Do look at the original commit that introduced it to understand why
>>> it was added.
>> I don’t understand why this was added to the stop/cont code, though.  If it
>> is time consuming to make these changes, why are they done every time the VM
>> is paused
>> and resumed?  It makes sense that this would be done for the initial
>> configuration (where a reset also wouldn’t hurt), but here it seems wrong.
>>
>> (To be clear, a reset in the stop/cont code is wrong, because it breaks
>> stateful devices.)
>>
>> Also, note the newer commits 6f8be29ec17 and c3716f260bf.  The reset as
>> originally introduced was wrong even for non-stateful devices, because it
>> occurred before we fetched the state (vring indices) so we could restore it
>> later.  I don’t know how 923b8921d21 was tested, but if the back-end used
>> for testing implemented SET_STATUS 0 as a reset, it could not have survived
>> either migration or a stop/cont in general, because the vring indices would
>> have been reset to 0.
>>
>> What I’m saying is, 923b8921d21 introduced SET_STATUS calls that broke all
>> devices that would implement them as per virtio spec, and even today it’s
>> broken for stateful devices.  The mentioned performance issue is likely
>> real, but we can’t address it by making up SET_STATUS calls that are wrong.
>>
>> I concede that I didn’t think about DRIVER_OK.  Personally, I would do all
>> final configuration that would happen upon a DRIVER_OK once the first vring
>> is started (i.e. receives a kick).  That has the added benefit of being
>> asynchronous because it doesn’t block any vhost-user messages (which are
>> synchronous, and thus block downtime).
>>
>> Hanna
>
> For better or worse kick is per ring. It's out of spec to start rings
> that were not kicked but I guess you could do configuration ...
> Seems somewhat asymmetrical though.
>
> Let's wait until next week, hopefully Yajun Wu will answer.
The main motivation of adding VHOST_USER_SET_STATUS is to let backend 
DPDK know
when DRIVER_OK bit is valid. It's an indication of all VQ configuration 
has sent,
otherwise DPDK has to rely on first queue pair is ready, then 
receiving/applying
VQ configuration one by one.

During live migration, configuring VQ one by one is very time consuming. 
For VIRTIO
net vDPA, HW needs to know how many VQs are enabled to set 
RSS(Receive-Side Scaling).

If you don’t want SET_STATUS message, backend can remove protocol 
feature bit
VHOST_USER_PROTOCOL_F_STATUS.
DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device 
close/reset.

I'm not involved in discussion about adding SET_STATUS in Vhost 
protocol. This feature
is essential for vDPA(same as vhost-vdpa implements VHOST_VDPA_SET_STATUS).

Thanks,
Yajun
>
>>>> Now, we could hand full control of the status byte to the guest, and that
>>>> would make me content.  But I feel like that doesn’t really work, because
>>>> qemu needs to intercept the status byte anyway (it needs to know when there
>>>> is a reset, probably wants to know when the device is configured, etc.), so
>>>> I don’t think having the status byte in vhost-user really gains us much when
>>>> qemu could translate status byte changes to/from other vhost-user commands.
>>>>
>>>> Hanna
>>> well it intercepts it but I think it could pass it on unchanged.
>>>
>>>
>>>>> I guess symmetry was the
>>>>> point. So I don't see why SET_STATUS 0 has to be ignored.
>>>>>
>>>>>
>>>>> SET_STATUS was introduced by:
>>>>>
>>>>> commit 923b8921d210763359e96246a58658ac0db6c645
>>>>> Author: Yajun Wu <yajunw@nvidia.com>
>>>>> Date:   Mon Oct 17 14:44:52 2022 +0800
>>>>>
>>>>>        vhost-user: Support vhost_dev_start
>>>>>
>>>>> CC the author.
>>>>>

