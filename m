Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1D8828D9C
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 20:39:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNHwA-0005vQ-Hs; Tue, 09 Jan 2024 14:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1rNHw8-0005tA-G5; Tue, 09 Jan 2024 14:38:56 -0500
Received: from mail-sn1nam02on20610.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::610]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1rNHw6-0002oq-Cd; Tue, 09 Jan 2024 14:38:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loncMlhobnB2ylEN5WShgtMtGmSjqTvRq9jLPW5B/SsRiGjDKRPnWa58Yyl7AJWbUsgxGFLiTTPSgCbgQCPCS4nckatJ7R4zkSkvbOr9AH4jRVhjV55y4vldWSFu5eoEIPbmxd9XJxJltA7r/KzJEuLER6BffqW7zpn/4ihWygu9PeFImrGXf1mLAIKGDsxTyGv48XwLTHszsgi02OMK7w+gUSfx6Uw8Hyf9i3oLdOWqtmiY2Gn6E6F8+SuA01qx+kbsrfV4PCJ3egm09vq76GtZI4JnEU+fohCZnTkblZlaicktPqS9O4GAvgkqQxiVMD4fLDGbFPgxoZdhKeAutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA3o7NnQjDSN/nqTygo5/+BRrkAwg4R10Id71m2xzLY=;
 b=fpsIYwUlottehzXxnhdqXqm2JFMcWY7KsIpUx8yjhS1juKgGf30zdLpAPZEWb0qmPq3MNommoMziHrly/8DlEygPDQ73zYD3zLICU/uN06tHhXDIdCsVgiaihkFmtXbKYaQ7upUOLau5N6lXs89wJjG89GqYeFU1qQ2uf2yn3slf94p7I842mUE3+hTvTRPtbbmF3AK828xBT+smfgbCVQPpcnUK7YOhlzCcAYpQ8NBz9Vdzib/YKWUB3LBlIb9Ljc4iJ/tBbZXKlz0NXOjHr3PxnqQeX/tT+oRqdVYZTz9eG6D463yvs/rI0brdxdmAbg/+QyrURu9KTk10o7tY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA3o7NnQjDSN/nqTygo5/+BRrkAwg4R10Id71m2xzLY=;
 b=k++uzrUFyxLSMqScxHG+UuP65M3mhJyCrv8MlI06Q5qzWFQ37pvM9nV0ESluFLZxf9jMMYI9ALfNbwtBITmE7FJLD+hB10hreh3okoVineLnePBpK4y+4b62tpaoVZV1ndQb3bqtfbEjBIKe2AnoEAAtvNq7izmUnMoH4PR1utjrjoGI2KeB3pxO6uwefwN96qhc2/WAZvZhbQMMFDJqqvqp3XTwZ8+v0uNlrduQKtYWaRy68vTS3N08TxvMQfAWY73EiKN2r2wblioWmDiGyd2EJ0iHNyD3WSjh8BNPT4DoRQCJH6GH2iYN/8SiXHuoo528MPcGHeIGRmdX8kkw6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Tue, 9 Jan 2024 19:38:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 19:38:48 +0000
Date: Tue, 9 Jan 2024 15:38:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Ankit Agrawal <ankita@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Message-ID: <20240109193847.GF439767@nvidia.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104103941.019f9b54.alex.williamson@redhat.com>
 <20240109165221.00003b8b@Huawei.com>
 <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
 <20240109171030.GE439767@nvidia.com>
 <659da02316cab_24a829418@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659da02316cab_24a829418@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:208:e8::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: e4211d5e-96b9-4509-3c93-08dc114a99be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dr41iDrPNgsCTMo11TbV4lArzm2UAtl9U9ofZpybwvcm5FfgFPOoPglcOH78djF5jIvWVFNC+kGDAQX7TL+fZ4RxwnMhlUZtOdSTT3GRjudKFnqhk06pb1zl67KbRoc9duLF7THsz9jVbxzAKA2peAHeL8pzT6QrzR7PexCyvigrO3LLY5XF+e4bd2L3Wv6TxgDJ8o4XCApdXtgfaw+A/0NQN3HkQSQwzYFgj0zxx0C+lMeescq80en6dEp1kioD2NMQcvZklmoPeXOdHLnot+u51yQAINY7krYepS1bvA8B1l8bn9N78YZrhFpCw6//ZNn3Dy947XaKnp5PJJ4ovA4ZYHdtQRPrq6IHf9eBq2mxrMD5NwPcvFimYgaQkSILzYFE/VOArOxqbKMH/le7ybieLLXwTIVoJUf1A5GrHam6yalMjsLLfT91FMXNTEw1tz1/t+rF9vXKFOTmpW3ysMYKCggb9jASTcf9yGo4Fp6LUqGIQzDPlL8Q2UoGfzQsUq2SqC7QJVJxA6JIhIs//lYH1ArVH+35G8f6m2HOP3PnDnNbsv6uk8qFZ4d35tU+vABh9wUII6rmHI5MAHf4G6Xg7LgJt+EyckoZdcDv9GRP9j8SJiw9/RV7ozdnBNrO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(86362001)(8936002)(6486002)(8676002)(6916009)(7416002)(2906002)(5660300002)(66476007)(66556008)(36756003)(316002)(1076003)(66946007)(2616005)(26005)(54906003)(6512007)(33656002)(83380400001)(478600001)(6506007)(4326008)(38100700002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epo02Z2cW/J6ZlZU2BJGzAmlqQ82vfrqnVHZDo0pS8TWGGGY9pok44isirFV?=
 =?us-ascii?Q?go6vMFaiwxUJ6Msr//ssAtdFDgdLH39dZFBZbHaJrYS8/oj3Gaj1BnDohy2z?=
 =?us-ascii?Q?KXxbWXElLvY5pB4yjWweKL+whdzoDV/C8zY/HG/bTQc4YTuVNa9/7rhQJQiN?=
 =?us-ascii?Q?a+/aQa4ESGH6i+9J8UUmtt/erM8VycAyjoN99gpotpijBoNNTUySnHmmgGcg?=
 =?us-ascii?Q?fGdeFT5SOPx29cn2BWMjtowd7cao42lG4v8E5ODF3u80E4ZGZVPT2BGp7PsD?=
 =?us-ascii?Q?iIZRiNwN9VL1vOgXGAdNOPmgXRt/VbwHv+tPQ10DqMZoKQ6I9Bak5qxqnXUy?=
 =?us-ascii?Q?deSJIlXJuYGLgb1xgsL0PmXCDc+AMs3Y/76Bh5e2fAQ+pUpo6w/H4ecK0SZo?=
 =?us-ascii?Q?B04bS7t2tFwhkuOcy+cDuzqvGlCsDNixVL9anx4f7GWWZrSFThXHJT1eqBMq?=
 =?us-ascii?Q?XPkQkVauRDEeuVlQJVDsvI00gj8eKTTZEsSSy0yUL7JsHL3YX3lOSmp5INoH?=
 =?us-ascii?Q?6J5AWpk39scKvWPJ84Kjl2SVEG7nnZht/Rz2q2C96tH90x4f1oRQG1YZfEMk?=
 =?us-ascii?Q?rgF1R8ZjkryzAvWchaPP0OrgEyuxsrCcH4ix/1X1r7O5AWcIHIT8GJMY/cT/?=
 =?us-ascii?Q?MVvCeh8bOdZQWrZaw6hDpKnHMFMr8G3FKlltPZ/scJVSxWz0lSSLliHxjeu3?=
 =?us-ascii?Q?Z1lg4jKRJ9I3uEf8+Jeqi7eNvulv8BH1bj543Jp0VjlcxqhGMnCAEV4cqp8f?=
 =?us-ascii?Q?CG6Us0ya3uvHmvcQFLhSk8iFe75W/JsxEEvJZ60KCYstEq8nPeLMPcGVMzlb?=
 =?us-ascii?Q?sSQRUTEzX09SEgBBtFfuzYsuAspgRmjcTszOwo5Mrqn9x5KoKkypw4Gh/BjD?=
 =?us-ascii?Q?LW+9+kehye6lM7BvbhY6EBmMuFnWUXqs3FUT6JooRd7htvKkYLYXo+mk0UBK?=
 =?us-ascii?Q?4XK8ktK16Qhqa6m8bACnu6NwL2RmIhQAwcnBSX+UaoWgbDtqsgd+edxOy507?=
 =?us-ascii?Q?8JmLCCyyUypUYR4ExUtR1q2znjjlw3W8JD1hKiYLfySmiiTyk5i+kqZz2F+F?=
 =?us-ascii?Q?CtFAvsY5zYOqAUnpstNxda1/ArpiRHMYREUEzMxGAlTAgpMeFJ80YI46txk1?=
 =?us-ascii?Q?s30GJ1DHD0X8brm7N5kLyXkKnuZCSlxNDayr1MbPTmuxiM+uCxKfMeX5YaVG?=
 =?us-ascii?Q?zLz9p/X7NQAFPTcuPruTTcjg1mdpAdL6yoAMjGmvcgCrS5TswaqGuefAFc51?=
 =?us-ascii?Q?FJZNgKk7/DKiTz8IA7aGZcLk6zjHqwEVtCQZEY0u1pirTUZturMMZQuDKcVs?=
 =?us-ascii?Q?d8jyzmvtJZE9qe5BKPdILhi32wWYXZPmkfWscdL+QjxjwYgeZ1KcjiBrzb8j?=
 =?us-ascii?Q?JULfDvwhbQsJIS69ZhFUTCRV5BFo4fwa8jhKkVlZJ3LZLoBaWPbxAKJcAsQI?=
 =?us-ascii?Q?3z7vHGX4/I5A44ClS/95RV1SDvVG5wH4UoY2vKFEV+8DQkpIWsRpp8DJEwHy?=
 =?us-ascii?Q?7ET5Z/Bn4tOhX1xsv68tdYv9g6aO4amMIUn7nhu1fJuNRl6OCXpuYYZhG1lc?=
 =?us-ascii?Q?hmm2Ip9KIxzc5QZNUZ1C3hLS3QpsBVgMJzyXpjtz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4211d5e-96b9-4509-3c93-08dc114a99be
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:38:48.6359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bd45fVkSwSp662Fa6LF/gwpAOoz2owRHaCdP0PeXAy7emdWzWPBYZDolhowkgOfl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::610;
 envelope-from=jgg@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Tue, Jan 09, 2024 at 11:36:03AM -0800, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Tue, Jan 09, 2024 at 06:02:03PM +0100, David Hildenbrand wrote:
> > > > Given that, an alternative proposal that I think would work
> > > > for you would be to add a 'placeholder' memory node definition
> > > > in SRAT (so allow 0 size explicitly - might need a new SRAT
> > > > entry to avoid backwards compat issues).
> > > 
> > > Putting all the PCI/GI/... complexity aside, I'll just raise again that for
> > > virtio-mem something simple like that might be helpful as well, IIUC.
> > > 
> > > 	-numa node,nodeid=2 \
> > > 	...
> > > 	-device virtio-mem-pci,node=2,... \
> > > 
> > > All we need is the OS to prepare for an empty node that will get populated
> > > with memory later.
> > 
> > That is all this is doing too, the NUMA relationship of the actual
> > memory is desribed already by the PCI device since it is a BAR on the
> > device.
> > 
> > The only purpose is to get the empty nodes into Linux :(
> > 
> > > So if that's what a "placeholder" node definition in srat could achieve as
> > > well, even without all of the other acpi-generic-initiator stuff, that would
> > > be great.
> > 
> > Seems like there are two use quite similar cases.. virtio-mem is going
> > to be calling the same family of kernel API I suspect :)
> 
> It seems sad that we, as an industry, went through all of this trouble
> to define a dynamically enumerable CXL device model only to turn around
> and require static ACPI tables to tell us how to enumerate it.
> 
> A similar problem exists on the memory target side and the approach
> taken there was to have Linux statically reserve at least enough numa
> node numbers for all the platform CXL memory ranges (defined in the
> ACPI.CEDT.CFMWS), but with the promise to come back and broach the
> dynamic node creation problem "if the need arises".
> 
> This initiator-node enumeration case seems like that occasion where the
> need has arisen to get Linux out of the mode of needing to declare all
> possible numa nodes early in boot. Allow for nodes to be discoverable
> post NUMA-init.
> 
> One strawman scheme that comes to mind is instead of "add nodes early" in
> boot, "delete unused nodes late" in boot after the device topology has
> been enumerated. Otherwise, requiring static ACPI tables to further
> enumerate an industry-standard dynamically enumerated bus seems to be
> going in the wrong direction.

Fully agree, and I think this will get increasingly painful as we go
down the CXL road.

Jason

