Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B1B828ABB
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:11:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFd7-0006du-0x; Tue, 09 Jan 2024 12:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1rNFcf-0006cV-Dy; Tue, 09 Jan 2024 12:10:41 -0500
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1rNFcc-00018A-Ln; Tue, 09 Jan 2024 12:10:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkPJy4tqXGOADWmaQ9JY/0mB287ZcR9pG/yl+tT7bJTWMwza4+cKL00K4hecIhckliDlT9ManneENYI2l9HmIckvyWvnYgE5gcCNTBzlMvlYbaFHPItiIYZq/Kfvo0EBiqAnDErVkswkSj+YgvHtk+5W+/dU/cZNUUJSb+icmAFd2iZmzkX6YI/lReQu7p5pGSblkibi7n2flv1d7gjP2swzyupEIb+FUH35DYn87oxYT5tFGjkNWDxEBclmEBJdE1i8xucvsj/SgZyRMKtibmjkok/bWXJ9D2qwGaOYsIkBIbtrXkOppbmbUBYJ1EnghCgKtFBYIy0tqoVAlTjJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuvI+e2KqIno9wB7RiPBKHDAgPSkaavgIestmaGZCBg=;
 b=EXHnSgoYX4BeBz+HV4GECULTfgmJSG4jsvTjx/OYySuuqgCn3f1qsPb8+8SLtr3tKtrT7pRFrvzHwMSBapl/P/fjzGyXpTNAW18omnVH9xpapZ7ER0gMIEJ6DvyYyR+zzvV0VJ4FoLuvBuhtgg8H1ea5wJGjLiAV4qyJe6JijR0Xfs65seldSG9jKF22ySmGvRVBr6DwcGnVHlgjdGawModoiXosSekhLhvWs7uTJz0Og4lHM43sMkDvHIJX8MwZ1CSWokcQ9mXRIgEhgXpK5By+AuUd/l4dMCXelqUCSYJs0QTcRw0Z6QoefgkSy3Z5ZHnfFe55mcU/41RN1c7mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuvI+e2KqIno9wB7RiPBKHDAgPSkaavgIestmaGZCBg=;
 b=rnaCvzFpc5lWxvfIIsD/civ10CM1FrI6Aji8moED9HnN2Y77dTxZ9LrMfe/9JpolhzSexVyvp0Yy7WjymKbqeT4G9BL1wnvKxajoL5jy2lzuLznTFwMvRyU9YTd+wWzp2lJVedjJeH/iz6uF4eI+EQubKY4tjEfsb8fNMRywUZNGs4lN1HTEUMgYbr09Z4gYQSraDlJzJKD7znT82fiEsY4xGDunHpljjiAao6VHMJ4Ein1gsos/ipxNzET/KwUgDlGTFwKtU0XHo5o64XIUirSW5dwQWmt+60p6VSQi5bcMy9/uZ8DEPaQOdBY04x4lTyDoYvHUE1ormeX1cTM3Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 17:10:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:10:31 +0000
Date: Tue, 9 Jan 2024 13:10:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Message-ID: <20240109171030.GE439767@nvidia.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104103941.019f9b54.alex.williamson@redhat.com>
 <20240109165221.00003b8b@Huawei.com>
 <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
X-ClientProxiedBy: BLAPR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:208:32e::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: a99e78e0-4c54-486a-3819-08dc1135e2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btKAMtgxhT5eur48u7eCLYIrSLi7wPsuNjoed3sQevFeZcVmgPkH9d4AsclZ22wxDlkNVVd9/NN3S3PU4bf5gjeEK7+tGVhhYIBC7uWB0I7uC1JH98pou/naUpuUFQoDBAbsvH+UNxoSXABr6rAFXCZOjX9sc0PcB85qqV/Kp/gI0e3OFR7M92vUqCo96nKMvEY7B6FV/Ipp50BhGhft+0MAKPwh4JlICFVKTYdKrulJrSkNN4fmfzvpWQyKZFNzKLsO8WJ69IC9x0DLckEFAJWPcBb9qZA09LJ9Kz5qmtx2pJSPifipjYGS5WAMrwMAS8cFERAsyCB91Q65PhqP38JOd7x7rLd1BafcxT/cYYy8bQOA4Jslw5kC95V6J7O4ntEitKDz5++T7/LLWe1W5Qe5LtCLQ0XJtpQtSo0YBUczPmcuy+4u5RikOgjWG7rvXh7W1SoAYIR5LHWkT1EavETG1dPMx4yukVWLKc8SDeBAaHyHSvLxMYL/PkILfaE0/z0Ag9ACJTes2Vn/uCyeNDPSnRVsNE+9wrdKeMLW8ChGUQTw41V7fxvektzB6fr14VXZL0IgfvdU66EGbN9cjJC3JWN4YSrEO+wk2MiNxTlUPMRYTEWfxv6ztNNp6o2t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(38100700002)(7416002)(5660300002)(41300700001)(86362001)(316002)(54906003)(36756003)(8676002)(8936002)(66946007)(6486002)(2616005)(1076003)(66556008)(66476007)(6916009)(6512007)(26005)(478600001)(6506007)(33656002)(4326008)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eWE+VVL5Xq7euEQfdOb7qjfF/Fml+FtgdBAPjlz7Af1IGxifBtIS8GRq6h6R?=
 =?us-ascii?Q?/8vn4AhrhLZ8nSWazz6sQnxB2klgrpj7lnZ1qdwxlyIv5oewKgbyNYsqxKvn?=
 =?us-ascii?Q?mvKVXybVIX3aJmrU+V9c4fRGyXXRIwsXj4qh/epUPoZQM401ynPjyEIGiYmu?=
 =?us-ascii?Q?VauQmWHUWtVmo7q+Pdd6Bx4abu23wvCygfM/oUoR3UGHnh892mXrbpTPbUzN?=
 =?us-ascii?Q?E9WfrpjY0vKP06guaepBIefC+KKGtNUWnKZdqTP0CK3xVKyLfMuhCKYUmcBu?=
 =?us-ascii?Q?qief29YGMgYMJgXrzLFO6RFYydXehbEpa+2nhQHObJ02nTkepfGZsVA6SbOl?=
 =?us-ascii?Q?7UEKzRrnpOKs1Pjg51eHIVJWplv/0of/h8GE0cqcRLjtRNLI22V+sfLUmOe6?=
 =?us-ascii?Q?3S8pcFJFqrZOb/eaUYQI5gfV9TzFYecgeLNvfT1Wnbp7HUoP0gPv5/vwQ8Xr?=
 =?us-ascii?Q?EwYJTUgVXe0ELqJlFUQ846KibMd4v1xdfB2qoUJIZ5Jcq0gvjX8kZb0/z6GJ?=
 =?us-ascii?Q?LSuTAj9hwppHolA0w12UY8DiEwibBYwA36HP6qXLLv27II11KmoGLHt4oR8y?=
 =?us-ascii?Q?kreOZ8tnjkm+BWYFN21gUxVgnMHDaTc1y0TepWSkjFNhSF7YWvktErCCAXTa?=
 =?us-ascii?Q?3yi+3vhzEDQUw55XPC4VOBz44Cebun6uOBNk6RXhtzRFflPs0ulyAOush3pV?=
 =?us-ascii?Q?j4mbZZkkUh0O4S7zgizgEwP+J9iRk2os4jH5hgMGhRLuU6IKOsPzKM4PzbPM?=
 =?us-ascii?Q?oN7+g3uyUk5fj93orUuVjTar2wDlfbjKOnlYaRCvGshAEAoQ4qYgHpev/oaU?=
 =?us-ascii?Q?G+p1T2yFCO7Ip9Tra6PW+3rvFRZxw6bK857Axrh01tzk0+IGZMd4Fw+2EcUp?=
 =?us-ascii?Q?LSugD4DkIj/nDrkUCOPJcnDarmBSPnfuS/kBnmzaRc3c0G3pHgc3Q17Im8XR?=
 =?us-ascii?Q?VPQgAXZtFmtLQMXEzWk9wf1r6mrOdFEblaAcJIa1lk49Mdqc69vkycFyvyep?=
 =?us-ascii?Q?RMEC5qOp8e/XFwZ13DSWpy3bLdaRHJxHRiQEQ+kOY+FH0TuszayMGkff8naq?=
 =?us-ascii?Q?J3TCzVNtQs59NeaOPPs8ay8HPayQFHblvlQp3UMUHuClFr2GtTPR6LbY6F/n?=
 =?us-ascii?Q?VBqimN7neReK8m3vc+Nl0hBGUJmTqHO69O750s8oq08Cw2SYDYj3psHUggRZ?=
 =?us-ascii?Q?SQ2FI6NuO4GhtaRRMzf2ySLHDTx5Tx/Sv1ZB3Q0iFDszYDriIlrl7awzsPZL?=
 =?us-ascii?Q?WV/gF6aAi0cXjdtGSUHaWMrl0f9jmOS5DfH8LjJktEMiNfS/uWXFAQ2187gZ?=
 =?us-ascii?Q?C2d9QdFwFbgWNg7n1W1w+7P2JGMSSKtlDi7HNeBsBKZZgvE85UFegz4E/Udf?=
 =?us-ascii?Q?cRgylTSS+7ZNf+L7p6Ucn98X+w9NuRm18TYTDAE7jyXM82jetG2GpBFbRsO4?=
 =?us-ascii?Q?ZuwEudqsN4RitBLkypvWZB/bOzgyfv0MOrARkUKFIzV6TL7u+hEGHyTzNNp1?=
 =?us-ascii?Q?9Niuht6KSXVJpAktw78WDciMPX+VWC3OkkWEXbioYjeX6gDkhokw/IzNYpVC?=
 =?us-ascii?Q?iEz4zsH9x3lX04PbqWl7aWHMO4zLGTQTm529cdZE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99e78e0-4c54-486a-3819-08dc1135e2af
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 17:10:31.5830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4S9DtpY5Nie8w2sj6quhtnK9a1X0AUal+atenew6B8EaJKy6RwNiHbIR4bWtgh7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
Received-SPF: softfail client-ip=2a01:111:f403:2416::600;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Tue, Jan 09, 2024 at 06:02:03PM +0100, David Hildenbrand wrote:
> > Given that, an alternative proposal that I think would work
> > for you would be to add a 'placeholder' memory node definition
> > in SRAT (so allow 0 size explicitly - might need a new SRAT
> > entry to avoid backwards compat issues).
> 
> Putting all the PCI/GI/... complexity aside, I'll just raise again that for
> virtio-mem something simple like that might be helpful as well, IIUC.
> 
> 	-numa node,nodeid=2 \
> 	...
> 	-device virtio-mem-pci,node=2,... \
> 
> All we need is the OS to prepare for an empty node that will get populated
> with memory later.

That is all this is doing too, the NUMA relationship of the actual
memory is desribed already by the PCI device since it is a BAR on the
device.

The only purpose is to get the empty nodes into Linux :(

> So if that's what a "placeholder" node definition in srat could achieve as
> well, even without all of the other acpi-generic-initiator stuff, that would
> be great.

Seems like there are two use quite similar cases.. virtio-mem is going
to be calling the same family of kernel API I suspect :)

Jason

