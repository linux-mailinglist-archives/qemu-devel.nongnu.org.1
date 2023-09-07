Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3790796EDB
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 04:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe4kf-0007OQ-3Y; Wed, 06 Sep 2023 22:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qe4kd-0007O6-2q
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 22:28:11 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qe4kZ-0006fP-T8
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 22:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694053687; x=1725589687;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=umfmbh2NxFydBW83yMSBZ4rDc3mdGiAtPtagNm6p1YM=;
 b=bcEAWiiakNDN4dvXgJc/uN68XZr7PDO/ePKFL7j3rQ8PBQO7Uy2kLURj
 LBrHShnyP/BuvCYeAz0SdocxH3YLrlWDS79j24KV+x9q1dDSVUxTpZXVw
 2a4J9bYeguaIXX062eTxE9sMDklGy0JUUmM6YTW7kmbmhgNM47HmPDHHw
 0ADAuQIFhoxpX6pchdYvxk0WXI6czrJ6pbMR033LjzdRPAjrf9pgkp5W9
 9MTDDyrO7nyksPAtIosa106GCgW2RCU0QrnXdSxqvKxPg5s0TlYmcm2sW
 e5GNLWgOAgrAYDrmgXIASbLSAs8o3iNSRMjRI2AJf0Kr+sAQZbpXA6zUI A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="356720896"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; d="scan'208";a="356720896"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Sep 2023 19:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="865412276"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; d="scan'208";a="865412276"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Sep 2023 19:28:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 19:28:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 19:28:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 19:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILux8oKRz7OODlTrrDPq2vKm9CoUbGnAJWKPGCEDYKWOGkwtdPqHnZU7vpkI13ArPlT86gRQCBS6SM4BVVfJKOvWCWvqBOilo0MQCk2kXXbaOhHubX1btY7MrNVCqjCX88UG1G/AE6q+tCOCVRsleNFNOXAUFLvCgbb4AS9iI6+5fDDnAfZXyuE6sHAHoqIJUIysBEHjz3n6h8zVMKgRjypnjhk8REYp+MoJL+kRQ4PYzXw58iMnKPVs1Ohm39IaHbv/AvgqOYQ+UY1AHG7fD1RGAiGCs1mAMWtcYtCrvG1v512ylwm8CMsik4r0aQFCZ27jj8OPGSnI0rBWp9WaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWouzHrF+12vB/VGIylza3q9htiS8uLtJBpt7s74wg4=;
 b=IgPFHsjYL7pabtMYx6cl2VabRz5scUcjBdAe6epm7Ixph7101Xx10w3sdsw0A9sxfBhbqMQqXoP3Wq14kvaRsLHT2gG7mzyJk6iNQiRn30etEaNv6Y02eETINV49yPtAQdqMZ+ln2LZRZkPi7OFASpAZoD2/ke4JgDnfLaPAMXcyOXPjuZ7WYxQW7xpeAh9Yh1jm5IoiR7W8XoNb51mGXLqZ6wErQ5gyvd+rP98Ww1A3Qd48Lorl/901rdmRKQJfEmOwNVU3DuJ0oD7Ca1EcraH80aBKataLbOpwpWXBxG9cXttU0HQc4+HdXmakU4Ni7XNRmbIsoeBljSBCMAaKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 02:27:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 02:27:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 21/22] vfio/pci: Allow the selection of a given iommu
 backend
Thread-Topic: [PATCH v1 21/22] vfio/pci: Allow the selection of a given iommu
 backend
Thread-Index: AQHZ2zBOkPXW84M/B0Sug6FqvYMFeLAOJIGAgAAQbACAAGTuAIAAELyw
Date: Thu, 7 Sep 2023 02:27:58 +0000
Message-ID: <SJ0PR11MB674457317F85A20959199F4F92EEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-22-zhenzhong.duan@intel.com>
 <ZPjAn1Asi5ZE9yzB@nvidia.com>
 <20230906130926.5c66f9d6.alex.williamson@redhat.com>
 <ZPkjEGZF1D/fLk9w@nvidia.com>
In-Reply-To: <ZPkjEGZF1D/fLk9w@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6944:EE_
x-ms-office365-filtering-correlation-id: 690c663c-10db-4f27-d31d-08dbaf4a0d38
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQY+S5+k2cxFmiX93HSc5xMwCJJCEY+nU1Jv9UNzPcbVuX1vNXaMzMdKHeR1bFLIpp194kq1X2g0+vH/D13nU4psg38dGlU4Y5xnE5UcmRmWbICH5usWEamDzhwN6Bv3aI6+1+4OyEthoOPP6OsThS9vlUZVf7BWvJi+zGgkjp29rTPz+E6y0YWI+bKVr9VR9jk1xvEVdzer5EvJkpwL3Q4OPDnsLCT0ovnSsw9INe3UAK0tECjDutsJXXHRane6ugm7z9b3MJ9TiRUgJn/u+2HIFjEIaHbFsFsyJE8IAweeQdfIJI7EWkqF7ZoqPRxszNYoAizl/ZLHL7N5S+qiT2ZU1BT/AOJ1eK+Rixh/007izeC4XzmTL0SpwfEbjK0c3ScmvtZO0aZvBap+PU3dGti76YVY5iTPXedXRcdXfd/J2217/u0VBwDaHu/pcebH/qdXVqCsWxtZZVPDLg4vkQPS7mni0EPI3reHwL3nrpx4wGByY9GKJYLXsGJtjnSxSLv6RCtdJoIiXSxxEpObvG7qZnFLPEcrUlvhSX1+AlG6F9aga6ivxjLeihUst3J6YEeZKQ0FrIh1MOZwM4Stwiz7liRtnpyU7np0pQ/MRZ1z+F7AiQAXNP6SLoku8SEU8CmdQcg977IzCmgwmA4QzxBQky/6b0uSdfPt+5J+Tbo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(186009)(1800799009)(451199024)(82960400001)(122000001)(38100700002)(26005)(38070700005)(107886003)(7696005)(6506007)(9686003)(55016003)(83380400001)(4326008)(66446008)(478600001)(8676002)(8936002)(110136005)(66946007)(66556008)(76116006)(5660300002)(66476007)(33656002)(86362001)(52536014)(54906003)(316002)(64756008)(2906002)(41300700001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xj4FzrKnNfeRqQEW6/d42yXmmqpsbfTuJoePB2OCBzsOV6dL2Wx5hQjxX3ii?=
 =?us-ascii?Q?T5vRQhGo1dFyWuciiwVC3/WUIoKiV+T/3RZlmx//Bjb0RjGw+jEVCgj2plzO?=
 =?us-ascii?Q?xQAaDy56Dv+Ao/Cb7ramtrw1ey/to8FD9hdVq20lx0VogEnivaecjfpvJOGB?=
 =?us-ascii?Q?u2BPUHTxYBiesHuaQRqez3jmZmzDIKkni9CLIxdyLwnY7tMbwjBj4LwjWed1?=
 =?us-ascii?Q?eNqabj8pNwHZi7z/RtXtvLn5n6jfkry7mbxhXA1yCxgdGdPpCe9p0N6slZoE?=
 =?us-ascii?Q?aOZWEsQDDuHPE6yVMpYcUIGvMffdxr4wzmiUCJIMhsnwUCpCVj789SGYzN/h?=
 =?us-ascii?Q?yL3kLAXTq14mpHlrV2yG40G/A9+nmaoKNSAl1ufMRXhYA/xBdWgLWiWoKnie?=
 =?us-ascii?Q?p59eCy2BDSVWAO6qddEek4gRXWPCq3nD/McP+AuSMIpr7DtAgA9G8S4D5/8R?=
 =?us-ascii?Q?Eo+1aO3QLNDnrozyrg63uaeEArgq7dZl/Cbu/h0hh52WsoiG6m1OM9tFERit?=
 =?us-ascii?Q?xGCg/K7uQ3bWF/nUYIMlTASg924ZHlrxd+VbhqMc0iU0N8fgB98IxCJyxMct?=
 =?us-ascii?Q?r+B8h21zBhbOrxulpasEHxXcU0CSewEun6wjlejJLv7QtHGNn4C0y1icwcr3?=
 =?us-ascii?Q?ZCDDLI6TI71isaNahw7XE+RLehCJoZoV1rlw7YNxfrHJhyTV9bU1Jm3rfPo+?=
 =?us-ascii?Q?ykLmSHm1qDLHYV5h+oMwlK37FjxUwasdsHjcMD/fEdAhlscmOs6OCKztW8OI?=
 =?us-ascii?Q?0Zo38igbkQCwGL4Si6TiSVPxuFNL+ENC0HNROvIrwY6CJrQMJPUWmqJoQAgR?=
 =?us-ascii?Q?UMy8Pqe7itULXEir8GwxDv4ey141nTRthlUprCPC/OxbpZr7NsXluAnPI3DN?=
 =?us-ascii?Q?UvOGGLD7thvSFg8uIQM71o4s6rb8qAE4Czh6SpE93VX+S2e5Yqyxx0LcqqPZ?=
 =?us-ascii?Q?3WV7WaPQuX89JI11KZ+PGXdeUWwnvurx/0xBWq5GBk17dR+ETqMuE3nSOs9E?=
 =?us-ascii?Q?6Jjc3lezc6aYF1uWTuEEAu2HiQOlX3hAAet1GRp2Gz0L0abUxniAUS3ZDqXL?=
 =?us-ascii?Q?XIOR4YMjCRqsIolokq4imsc1am1m1Spjy7YLcdGjDOtR2qTxjcyBHj4h4IUP?=
 =?us-ascii?Q?dBfK6zMo7w59F3MaU/0iLOMdPXpWB47aaOBgv9QnipwSIORkQ0xnrnKiwPCP?=
 =?us-ascii?Q?W2GUw3yUCLWfzTk59j6rHIqDErzwTJ1oEAg/fX0lkvakYetRU7yk0Khfjf/H?=
 =?us-ascii?Q?atPHqjdYJidiY5oN3Il488hr0lYMYbXHcsQ1ND+KBrw9Wr19WGAWL2HEQVjB?=
 =?us-ascii?Q?ifFFgLci6VfrlFF6F8gMdRgoTf8QF8R39ac5oyWUPGEC870Y2Oc2L7uq58UL?=
 =?us-ascii?Q?0B5ncB6YGJLxPnzfQpUDcKYr0Y1O/udkBHE3YVkxn9JuMhlq9pl5ffRzQqDK?=
 =?us-ascii?Q?nGvsNMb9G6xEAvYwopIOKahBuyX9yaEq4vtKKZIvbN2rFJgRw9VD147ciPeZ?=
 =?us-ascii?Q?ivLgsUb/DliV6qE9ITJp54+Vgd2qd/r/szzzEeJjEddERpcGRnvwHFZICAbH?=
 =?us-ascii?Q?0TNUZsZ+vzOic/DddNciAxGHg/FooxOAnI1W0Nck?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690c663c-10db-4f27-d31d-08dbaf4a0d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 02:27:58.6753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6OscLcnq+8bErzplAq0Jj3xl1uojvQeFdpm8A8+hA1ImB7oyf+SEXJ49E0TpUgfYhWem1dFwp52sa1wytGiIIpJDAxzWDrdE865ALY/mS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



>-----Original Message-----
>From: Jason Gunthorpe <jgg@nvidia.com>
>Sent: Thursday, September 7, 2023 9:11 AM
>To: Alex Williamson <alex.williamson@redhat.com>
>Subject: Re: [PATCH v1 21/22] vfio/pci: Allow the selection of a given iom=
mu
>backend
>
>On Wed, Sep 06, 2023 at 01:09:26PM -0600, Alex Williamson wrote:
>> On Wed, 6 Sep 2023 15:10:39 -0300
>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> > On Wed, Aug 30, 2023 at 06:37:53PM +0800, Zhenzhong Duan wrote:
>> > > Note the /dev/iommu device may have been pre-opened by a
>> > > management tool such as libvirt. This mode is no more considered
>> > > for the legacy backend. So let's remove the "TODO" comment.
>> >
>> > Can you show an example of that syntax too?
>>
>> Unless you're just looking for something in the commit log,
>
>Yeah, I was thinking the commit log
>
>> patch 16/ added the following to the qemu help output:
>>
>> +#ifdef CONFIG_IOMMUFD
>> +    ``-object iommufd,id=3Did[,fd=3Dfd]``
>> +        Creates an iommufd backend which allows control of DMA mapping
>> +        through the /dev/iommu device.
>> +
>> +        The ``id`` parameter is a unique ID which frontends (such as
>> +        vfio-pci of vdpa) will use to connect withe the iommufd backend=
.
>> +
>> +        The ``fd`` parameter is an optional pre-opened file descriptor
>> +        resulting from /dev/iommu opening. Usually the iommufd is share=
d
>> +        accross all subsystems, bringing the benefit of centralized
>> +        reference counting.
>> +#endif

Thanks for point out this issue.
I can think of two choices:
1. squash this patch to PATCH16
2. keep this patch separate and to pull fd passing related change from PATC=
H16 into this one
Please kindly suggest which way is preferred in community.

Btw: I only enable fd passing for vfio pci device, let me know if it's pref=
erred
to include all other vfio devices in this series, then I'll add them.

>>
>> > Also, the vfio device should be openable externally as well
>>
>> Appears to be added in the very next patch in the series.  Thanks,
>
>Indeed, I got confused because this removed the TODO - that could
>reasonably be pushed to the next patch and include a bit more detail
>in the commit message

Good idea, will fix.

Thanks
Zhenzhong

