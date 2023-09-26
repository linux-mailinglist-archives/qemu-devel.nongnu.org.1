Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B497AEE8D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:53:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9QW-0005XA-NQ; Tue, 26 Sep 2023 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ql9QP-0005WX-Tj; Tue, 26 Sep 2023 10:52:34 -0400
Received: from mail-bn8nam04on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::627]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1ql9QN-0008BI-EY; Tue, 26 Sep 2023 10:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYj4BQfVZ2UdnM3veqB/mpqM/SoK+/HYvwtJMgdk5aBa5NyUgK9yEriovJksP+uboV4Jhk6xnbtUDbQ2veyPr2T2reDBu+VJI/s/L8QAIFI/w0X2wKJJkMbmGha7zfrJyHPUlEyHTv6L+Ryzj50z9miXnW1gdz0Ad3MOWdERu/TEB0eZhq6SYUphTz0LB05BP756MD1FGDb1JPX0ONcJFpwLbJQ3vbVulkauoPIpSb/ioxMOuZyz/TRkkRr9QhzDsboT1Y+4ChXrqx6slW3ic3QgQ994hBtWgzsoDnvHaRB0M9Oz0s0puFnbXlIDFkPeoXbqZEpxZ+unvXj+WGIVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcsG7Eg+oafLt3LS60cYo0uoJ9+zZ7o9e2kdP8/qDSk=;
 b=WK6ltt29/o70UWrkt9CGBr8kiKRlnIKxGAAWRccXUgikG96VeNQRLb9ceo6U5vI5XmNJueQCatHXRBm77TzM9UolmA/boQWp2OgOFnombVBe2v0D814hLDJoOwxXFhOPmP9FNTDI+eEXbrIRv24YF3k6g9ycYsVOOA0kPq2J0jyHyHT6zZIUkpP2pB2mj8es93Fva3ysprJBVIV/JioFYKtz4MnuFGude7pNrKXwifkNeROP1HHX7rgDkXSYDctbXtesWRHfvXVB6r/mw4TEgibo3CFmpL1+poixWaYQbeYNpAVv7MXy/BPpcaTvWdoWjcA9hO6VOYflSXta+O/+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcsG7Eg+oafLt3LS60cYo0uoJ9+zZ7o9e2kdP8/qDSk=;
 b=BOnKTn808EdSoiUiHU+cB5y3ExRFicghMbuKglmDHB6byBbOAaPZjn91IhrjVtMFDoI5umTyG4hcUyiRApxKPPbDofrvLoOKoqwZYpXZDhEp9JJPM3OJlweEG/RhwGrmD4FK2vL9SBnrPWkxobYzKTrN+yZ1AmZ12/8y1Tvzoze+47LwXOxl5kl0We1+BlRoDPNsgR8h59sJ/8JpHJsi/U0o85wqIj7OHRJoyU0kmO7/Se1sOgzYWXS2d8XxYNsuPMbdrpDynd6dNUYSmrkHHy6rVSaW8eIqos1YntVxrho/li7WlMIE4pNWsMFxRmaP25twb+JbC9nL7bBK0yx6ZA==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 14:52:25 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060%2]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 14:52:25 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: David Hildenbrand <david@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Thread-Topic: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Thread-Index: AQHZ537JxLWb7mRoJ0CHc31F6ORMKbAb8EmAgAAH8ACAAD9dgIAKT71wgAADi4CABrQ0Bw==
Date: Tue, 26 Sep 2023 14:52:25 +0000
Message-ID: <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
In-Reply-To: <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|BN9PR12MB5099:EE_
x-ms-office365-filtering-correlation-id: bc00df31-f0aa-45ad-8bf4-08dbbea0326c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gyBRG6aXmAyAvfDO2LDXYmIzAZIjfrI7Vek9Z/T63pwEdPSmAySHqEeqxRuvaX2J0/hCMeU/c6C8H3yOly4qIaOacmt3d21+nLSHLOeLAbFfnSr20SvehCMqTIkWzoy8N1DQOvqoxbgXxe6a0HDtNCBjBGn/R6c7zxZZwJPLLrw4VRDNtOlTDsVnIWRON5rYxdkhZlocbJ1SM/iJt2p6P63X5Rhc/lSa/FGOL731VZ2g50hxtPMGk+ewRA8ylaRX/H1VMDwDdImEzR33z/0DTjBUxi8bRG5aCnmJB7IeV5ZqZg0jEPjq8Gvfw8QHnL3SmnzzFgmn+CS8FsbT9PU3K/ABRn02V+OGohr1nOP+fXyDeSjhxUCUYR63gKTmpgfgz6i32j7wiyOFlAdEWg9hwPlaXMTKVxRN193IxUsPjssKX7HkaWNTpO/hP0ABptGh4XJKhjpX6NTIhvHdgR59mN7go0zQ+c+kUQXjMoflimI4YIYR6s73qLxJ/JLeMmlxgDqP9QJinxA3IbboIkm7IOCy5vcogewuWJcwQoO16MPyvrBPGnhvhB4F0rWXrCj6eR4fOu0HmsOzjR73Zc7I2YUFwMHYRXI7TVAnKq+BYtQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(86362001)(26005)(41300700001)(6506007)(7696005)(9686003)(38070700005)(38100700002)(55016003)(33656002)(122000001)(316002)(8936002)(8676002)(83380400001)(4326008)(64756008)(66446008)(66556008)(52536014)(66476007)(5660300002)(91956017)(110136005)(66946007)(76116006)(2906002)(478600001)(71200400001)(966005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bSaJiFO/qV3gu0ePtNsqocegENz3HxRbqII7LPpmHOUIQtrMZ3m48EK3ph?=
 =?iso-8859-1?Q?W2N+K9NXVwha/qE5+1hhHiWII6s420zky9KJ0/bQRN1Yam4j28MoHKHwFl?=
 =?iso-8859-1?Q?LitiRJbf3rbObCI7e6LCnI/1QlH/UNp+fd/izYYZPNv0mjuql7dhR0UALc?=
 =?iso-8859-1?Q?knHcj0XcHqznt1KeM2l36ww5GF8ESwJf+EHP0wCys3dMUzinPSlZZrT7PK?=
 =?iso-8859-1?Q?1zS5Eh2bUeDOteQih8u4jnQ3uetdJQSgWLDsCBetx242QhDRtuXxhzOC4O?=
 =?iso-8859-1?Q?mEwViAmrhCJnQe4rKj4LWp/6h9cC/EbuxoGmVPXIMh6ckrU+mTlo99cbVQ?=
 =?iso-8859-1?Q?JvIt8V64oGBCO8dI8pkLsw1W7wFfN3bstuOINUth2HE3Grp6Zd0AXyibmI?=
 =?iso-8859-1?Q?Zi0BT9C5Bb5Us5uTdXR8fl1TAeRDW3DOaubW5nzbWQfpsNaJR74j+B48T+?=
 =?iso-8859-1?Q?T3qVakqJI5zrvJKcgspQKnzwUdRkSbipwJ6uslJvHAz6LJlDB/kBmf9L+A?=
 =?iso-8859-1?Q?kjk47IH68dWvJgthkS0N6vDydeXcQnq9+T8mZ4b9ubYES5Kj2WURphHC5q?=
 =?iso-8859-1?Q?rA6Q8HtGHiXePJR27TuarfywdECK+J2IXwyPKc8L61Z5p8xMISxRcC7SDh?=
 =?iso-8859-1?Q?qL7RlgS+45Wan6igF6n/zSgJwkPzsBhkUuEW/Ac9l6Ut5kB9TWgdWL3Afm?=
 =?iso-8859-1?Q?+Ge5J3btCcnCMHgBwhElUX/M8xUei/18Z0BtA2DBhlNojRIzySadBYA2Oa?=
 =?iso-8859-1?Q?YY4J2jPNQXJqKgC3byLEvkB0Ukia+OCX0dKvQd3BMkXDSgDGK+eNkLsBca?=
 =?iso-8859-1?Q?qV4NdKtUWPvwKXr5B1CSgOsT4ouasqNph+0UTrn04D92et85IXLT/nlq9T?=
 =?iso-8859-1?Q?gZybsEVpp0JdNJoRPxiKEZUDXRJhMP6SteyS14k/pLsX9y3rgDz8Jxo8qq?=
 =?iso-8859-1?Q?DGoiRfqH625veLOMsJeRTx6Z9BYk8ZOrmCVLxYkLClWbGrEiaiWdwyf21X?=
 =?iso-8859-1?Q?/bAcG8+PZHG42FiotMUxrYcw895pJvP8At5VhK/Cp7RATQS1sZql8r8PqX?=
 =?iso-8859-1?Q?McF9ibfJIr7ou/HeTwbmPugs5Y7gbWvEq+PBm7DcglKij+IIpl36ii96x2?=
 =?iso-8859-1?Q?cvbXimGw2TKYxJPo8AiEJdCkOdLdlTgE2y6pp3yn8wuTALV7+k1pfp/c3L?=
 =?iso-8859-1?Q?Fhw/HXPxgA8yPKEhTIdsrInpdBaPj/DEyG+f996u1QIhm9yAyxhCLZcN6r?=
 =?iso-8859-1?Q?f3ns87qo/LpK/jhq1foxKCrFKzb77t5DFSK2pHjwSsgSw2Njg+4ai+Hoj8?=
 =?iso-8859-1?Q?SG51zFjINCbhuHIRwSD/KXaFEy/6WJa5hKDAZWL/XrHkQa7ystDicyRsun?=
 =?iso-8859-1?Q?qC6A5ENPJ/GfoHDI/qtiPkGM+5tA/qncbqTsoeTa8cf9FdeNpPqqzJDmvI?=
 =?iso-8859-1?Q?2DJXbhfMbP7WxxjlDGK3TN7c5tlqO0/r9GpK2TkCGt7Nlkgl3Y2FDzyou8?=
 =?iso-8859-1?Q?+Z7W6eXhD2k7cpuHawuAITuiRyBotNJSUFvIRea6BAV8Rc1+B07Ypjz/MI?=
 =?iso-8859-1?Q?x4PqiRb8APYoUzlO5txqjjRUAWxewL3wCidHv5E7kXoiDR3RtDkjYlt9nW?=
 =?iso-8859-1?Q?Epb+vXA9814WA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc00df31-f0aa-45ad-8bf4-08dbbea0326c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 14:52:25.2615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwkzeRRldJ3IY3yR3RYspMBf9eUzUB02HQ90QqoUYgW5i8hAflv2++REmRPEcIa32bYzr4lqtRMvyw8H/53AnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::627;
 envelope-from=ankita@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

>>>> Good idea.=A0 Fundamentally the device should not be creating NUMA=0A=
>>>> nodes, the VM should be configured with NUMA nodes and the device=0A=
>>>> memory associated with those nodes.=0A=
>>>=0A=
>>> +1. That would also make it fly with DIMMs and virtio-mem, where you=0A=
>>> would want NUMA-less nodes ass well (imagine passing CXL memory to a VM=
=0A=
>>> using virtio-mem).=0A=
>>>=0A=
>>=0A=
>> We actually do not add the device memory on the host, instead=0A=
>> map it into the Qemu VMA using remap_pfn_range(). Please checkout the=0A=
>> mmap function in vfio-pci variant driver code managing the device.=0A=
>> https://lore.kernel.org/all/20230915025415.6762-1-ankita@nvidia.com/=0A=
>> And I think host memory backend would need memory that is added on the=
=0A=
>> host.=0A=
>>=0A=
>> Moreover since we want to passthrough the entire device memory, the=0A=
>> -object memory-backend-ram would have to be passed a size that is equal=
=0A=
>> to the device memory. I wonder if that would be too much of a trouble=0A=
>> for an admin (or libvirt) triggering the Qemu process.=0A=
>>=0A=
>> Both these items are avoided by exposing the device memory as BAR as in =
the=0A=
>> current=A0 implementation (referenced above) since it lets Qemu to natur=
ally=0A=
>> discover the device memory region and do mmap.=0A=
>>=0A=
>=0A=
> Just to clarify: nNUMA nodes for DIMMs/NVDIMMs/virtio-mem are configured=
=0A=
> on the device, not on the memory backend.=0A=
> =0A=
> e.g., -device pc-dimm,node=3D3,memdev=3Dmem1,...=0A=
=0A=
Agreed, but still we will have the aforementioned issues viz.=0A=
1. The backing memory for the memory device would need to be allocated=0A=
on the host. However, we do not add the device memory on the host in this=
=0A=
case. Instead the Qemu VMA is mapped to the device memory physical=0A=
address using remap_pfn_range().=0A=
2. The memory device need to be passed an allocation size such that all of=
=0A=
the device memory is mapped into the Qemu VMA. This may not be readily=0A=
available to the admin/libvirt.=0A=
=0A=
Based on the suggestions here, can we consider something like the =0A=
following?=0A=
1. Introduce a new -numa subparam 'devnode', which tells Qemu to mark=0A=
the node with MEM_AFFINITY_HOTPLUGGABLE in the SRAT's memory affinity=0A=
structure to make it hotpluggable.=0A=
2. Create several NUMA nodes with 'devnode' which are supposed to be=0A=
associated with the vfio-pci device.=0A=
3. Pass the numa node start and count to associate the nodes created.=0A=
=0A=
So, the command would look something like the following.=0A=
...=0A=
        -numa node,nodeid=3D2,devnode=3Don \=0A=
        -numa node,nodeid=3D3,devnode=3Don \=0A=
        -numa node,nodeid=3D4,devnode=3Don \=0A=
        -numa node,nodeid=3D5,devnode=3Don \=0A=
        -numa node,nodeid=3D6,devnode=3Don \=0A=
        -numa node,nodeid=3D7,devnode=3Don \=0A=
        -numa node,nodeid=3D8,devnode=3Don \=0A=
        -numa node,nodeid=3D9,devnode=3Don \=0A=
        -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.0,addr=3D=
04.0,rombar=3D0,numa-node-start=3D2,numa-node-count=3D8 \=0A=
=0A=
Thoughts?=

