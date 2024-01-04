Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA18824677
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:41:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQm6-0006b9-Js; Thu, 04 Jan 2024 11:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rLQm0-0006YU-N2; Thu, 04 Jan 2024 11:40:49 -0500
Received: from mail-dm6nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::618]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rLQly-0008VF-FG; Thu, 04 Jan 2024 11:40:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSYm4bIRrgpOtLldFKmu3SF5Lkx+136NfdA1uTtQY+Jkn/MUdaU9C5XlkyG8Ssevp1k+1HQeqjw4LoaD7lvOVkN5Ou6PgI6K/bqpzLjkTCL4F6Jh0DghtLB22grz6Jv626wiN97UsbNaXS8p7IQKpJiTY5fvAStK72uTg+IGo6J5MRwf30EyuTaLHVzJaJrl9nmRTTIeCoGh0yfs6K/2lU6WfMV8kXKqWjjlwb7jGhBLFZ2adgIwW33jQmjVsTCoUE5RoPgZzlwIs5q2pvyrNLrdIYrNLCItZ2yW5h11ISb6y7th/Y6JFerm1lwvwvEYu0Cz6X+IvFxx95Wuy4UWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m13u508Tn7gS9qhdDV9BVBIrAvfiyZwSM716ooCbc5E=;
 b=ftUO/XP0UeXRED+FehLMYLGXgbGLgaQiK3BAmnuKkypeMi8BzU9FhCoLUgrErQD6cjW+C7tzO1SyoWx/RouZB5PvD40Np6DlS32pIVj55ejJcNLNfaro03VmCM6bhdAQHLlhuvKa7ab6JUNd2PugQcun+akl2dIwU/zAWy9WOMWSaVWH1Wpcy7t8rqwjpS5yvTfpDI3keq+1ebXFyJQqjcmoA+5LJlqGmZFNp/soCqSmVSCTzF61DBlsQaqNqWLP7cOXk6CtxWkr8BCm8mBzRD406XFFtzKJDtXeAdwjYPo/BkwzdzKyPrRwrM27S6d7aPsg79QgeYyNdKHWn0B78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m13u508Tn7gS9qhdDV9BVBIrAvfiyZwSM716ooCbc5E=;
 b=ukAPNQS+PIFYG5HpcBovE/696ExqYuLZ8QIVzJ+srfhHxpt07CDDd/NVp9WIedxMIn+k5X3cpEIcQRCBC9Thkw6qnPIN/uC8NcazFQhxKzWs+FJFPh55ugUM9ugmo7Dgu1yu25LP0RsgH7JX8u8PFTnku0Zplv0AxIayu+I7d3Q25PchS9skmYL6zcCoju1adzG3U786NhOFoNQdF+qxCvrh8XE/VfrfTXTQnhPHalQAO7jzmzDOU1FCjV4c5uyzO8h3HbkGpne0RXNGfXjpnPPJ36gnNYns2ot4+G/GcbvYhQ8seVod7J0jKiHRSlmEQ9g8Fv/PpzM/aqIj/pwDnw==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 16:40:39 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 16:40:39 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v6 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaNu661+KkDQN9uEy53AGuuMDfJbDGiNyAgAKAsMCAAODhPg==
Date: Thu, 4 Jan 2024 16:40:39 +0000
Message-ID: <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|BL0PR12MB4899:EE_
x-ms-office365-filtering-correlation-id: f7c9d0cf-d1dc-4451-f0c8-08dc0d43e264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoUydmz59VOkV+gOAwmuHT3BFwZrWyoSikH/QhKE/BbQwV5oCEMNR4y/5MYoZJaJB/9tBM96K2xeW2+/9j3XTDw1S8dh0B/kZkQes1+HBFGWtmu8mLZMgdVft8HDog0s6jZI43HqTyfrbn/TCuOFnpBVgbftShMbmoYoLwIvbwrSa0HVz70AK9vMFLnaEWaxL9+jC6hGpZSDSy4wTXU3u7YROGutxqKjoLM7BcmECzm5CkPPKbW/oCiDpKeFh1m/aWuoiEaNJpnr6nvjX+G0DdzWFXsO7bFTgUFEXXoAZJ9nUYkAYQaR7QjALTbfC+YloYL3506C02VEgMrZLsagZ5+FYR3bNbJZVMwz8AQHqrltJ1wC1rnM+13I8sdhrbgAhwi7dQ5OxPNuk80dkXm03Ta/LK/cQSNRMt5cwwfcum27NHX9dVDlI2fdtROWIPv6OPY+tNuum13K47eI82j1Own1LAG+/G+/h96G31MgbJd0BV4hKQd+Rr+pwkYZ1o83Z0XHXcRSFg3vW/v8oz5jIJu5Ij28jtJl7kAj05B/ATMEMwTjzdI3+Vo7QUj10xFGtAvXzUbqH/KmeqqYHiwOYW5Tsz7KidaO3LTNiU33G1xuwAvRa9FAGio0MPEO/xLk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4744005)(7416002)(55016003)(66476007)(64756008)(66446008)(66556008)(91956017)(66946007)(76116006)(38070700009)(2906002)(5660300002)(52536014)(4326008)(8936002)(8676002)(316002)(54906003)(6916009)(33656002)(6506007)(86362001)(9686003)(26005)(7696005)(83380400001)(41300700001)(122000001)(38100700002)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qjcmaBjMu/WRxCgcVndWtxgD2uZTRggrgMmUHCwSloTQPJUvonr0APLgiI?=
 =?iso-8859-1?Q?7AoDmRuyDciLbDn7oJ2iPpFIHnJ/ja5Z5Rm29Zp3/pYTsIfrHl7vmp7p8C?=
 =?iso-8859-1?Q?YykHgfSbfMC/HINQDZVNO7ocZg1m2yW+SWFcIA6rB/JW2NzoltfTeJ0q95?=
 =?iso-8859-1?Q?04uGqoOGZKCAkhXgOkC7kUz8knDFelMWh3a7oCDfPutJUTgunu+tRt6xKt?=
 =?iso-8859-1?Q?+hgT4Z7oa1VbP0f1IS1bRG3nUOx0kRES1Hit+PZVuka5RHik88I61MEU07?=
 =?iso-8859-1?Q?gqLcmro5nGD6Mk6sUtkqr0+1kxS2bNcBHTL/TvQ+Dbdu8OEafqTY3fvev4?=
 =?iso-8859-1?Q?0+C8G7a+43mba37QkvLSvoGk3KlPlmjlS8mWLK3AkfV7ysJkIMCevIqNw3?=
 =?iso-8859-1?Q?RdI/nSR8OJ/CyaY//DYmErIP/22lpxLfd5rewduV0s0xDrHBUIamJYg3dV?=
 =?iso-8859-1?Q?ldfJmUaFIkjT+BnaJIKFy0DjJc2nLz9+a7VRaYJxo28lLE1yGuAMF/X9O5?=
 =?iso-8859-1?Q?f9EwrONdJLpZtRebSYFZx4dWqGqd9A9/Upt3fWVb91TstwVFNdw3iZ5ipY?=
 =?iso-8859-1?Q?Il8kwDrTdkZvjwddpO4nMCWOzfizxIl38EV82HDiBEk0sOWGb16uRYdB2q?=
 =?iso-8859-1?Q?2pkWEKkuy7hXrSU7jQys5znCDbVhlavV0fslWuCY4INEYlknInUpWyjWqH?=
 =?iso-8859-1?Q?Ik38QvkccarHVzA83I8FjXtx0kukMisaSYa/CqVPpHp1RdncbhYqjzfcW8?=
 =?iso-8859-1?Q?hh1zAlaqk1HBvO0RJTv9YiLP2ikJgAwbUdXUHgnkcm7Xbzof6USwsNX968?=
 =?iso-8859-1?Q?L6eHNeZwzv7UcJjP1V0G0IG7Xl4jGwxYMFqUpaDoegDdmTJpK19mb8EfNZ?=
 =?iso-8859-1?Q?hP32KNezeZTQfYyr/60sgt+Byhq12zZOpRn2FR4TCIp2V1V3T6syBf/khp?=
 =?iso-8859-1?Q?LIDzggjX0gojdnW7ovS9L7+2Oe10lwAIBC7DHkxr7dWsGyx9BgdlvXKnk+?=
 =?iso-8859-1?Q?gQJsmPxJZ7eJGLMIelyrS1DPWLgv8KkmXMEn1C1YHX2nT/RoMLxqQGT7lw?=
 =?iso-8859-1?Q?22Nk6k7AvoN2PPKQ5/lmfbcVEBqrdYjJ/Ipwfc4zn59yOiWuaNcyjQvQRe?=
 =?iso-8859-1?Q?NwXLMA5GUQ2Zc5V8LeI7vTLnXAnpMHR52VHSARgZFe4azGnOS9wEsi+M6q?=
 =?iso-8859-1?Q?ngrIR6W1ahpeWnhFftpog8aV9GKdwVYB2FCg0hyHnWSrYsW8lb1T5g+Yv3?=
 =?iso-8859-1?Q?ThDeE6+0Bh2DZLtOcb6y1Ka4W46ZD/Z9K9MUgC4ysmTlj5rFiddqQA7pjA?=
 =?iso-8859-1?Q?ynTEmfMek8IaNzezowAm+bJJKHCkpGoP4YpawgKQaKxJ+Z12ikU+vJOYp8?=
 =?iso-8859-1?Q?bKDgW/bVcYrGTr14UlUpF5pH7aHstDcgWAISVj3yQ3dnMRvOCnRs+eyOyT?=
 =?iso-8859-1?Q?tfWFmAaGuizUGIGZWmMm+TsND6qhYAu2FCX6j3CJTiJI/3STbgY3kKWV3z?=
 =?iso-8859-1?Q?kIv/wXT4D6YtlX0LtXMcsb7vcrtFMlMv29IwvJ65cn2GR4I5iMHqcPXWqn?=
 =?iso-8859-1?Q?kiPY/3SiBLWYLR/58N+RJHzOqKj8FVHMu3yvl9Tmj2kIYkbUOA9+l5trVx?=
 =?iso-8859-1?Q?5yTGQ/EjEVnqA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c9d0cf-d1dc-4451-f0c8-08dc0d43e264
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 16:40:39.1672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32ffORrmAky6NEUmjy4z44YjZFaarlRC0StZWpdBnfHRnAs1jywqUXVegLwcDCPtEuYHhQvxzq4x+viEuf6jvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
Received-SPF: softfail client-ip=2a01:111:f400:7e88::618;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

Had a discussion with RH folks, summary follows:=0A=
=0A=
1. To align with the current spec description pointed by Jonathan, we first=
 do=0A=
     a separate object instance per GI node as suggested by Jonathan. i.e.=
=0A=
     a acpi-generic-initiator would only link one node to the device. To =
=0A=
     associate a set of nodes, those number of object instances should be=
=0A=
     created.=0A=
2. In parallel, we work to get the spec updated. After the update, we switc=
h=0A=
    to the current implementation to link a PCI device with a set of NUMA=
=0A=
    nodes.=0A=
=0A=
Alex/Jonathan, does this sound fine?=

