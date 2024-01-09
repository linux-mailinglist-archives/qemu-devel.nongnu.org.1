Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8629827DD1
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 05:23:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN3cW-0003A7-E3; Mon, 08 Jan 2024 23:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rN3cT-00039X-QU; Mon, 08 Jan 2024 23:21:41 -0500
Received: from mail-mw2nam04on20612.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::612]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rN3cR-0007uY-Q3; Mon, 08 Jan 2024 23:21:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbEPLWzCAy7wpWVK4hKyAcuWFVhHEUZPiHo4d0H297xmVH6jrp/5GcR3z36KUhDopSBXgtrdXT4d7tH3UY98VdDT7vc4Kv6GcqomroofaAO+R7xoIq5rqoS2fEb0bwk+JQlo0WAFvBmAlbAaNbGKerrEJOVKx9gpnZfOc3WTJtdj9KmO/W8tu/EtmCGB1dr1Po0XweneQLx9TrWKXMNlnjydvuL9KxmArHeqmWL5jAd3431kM+yVQVi/FeRdqJVzxm2aVVy5O94FCmDC6KjAcXiqBkiZRdWQGcjwsvEH8sb20zZprQIWcxmf2Jl9F0f56tdDwqGWvmuqLh908TSDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1Z4EA0zHvP+uph4Ucr8oS6Id8CtuRuXV5gEthbe9T4=;
 b=ctnug9mzkrWLEiO5AFlxlHBiJD7PbgOJP5PVEcbXU0CAVBg1kUo3G66uraKF3BUMfnsQGKNZL31ULBKkKg2XbDozXSV8dVxcpqS46qn/LZOxr+u4ihHqD+ZOStA20U2pWC74dtwoB8o95170g/t5KCATi3fdS7eMudh8W/CkXGUbcwKOxKIn1Rh3ZePud77Ii0dbwLHNtN6G5EZbPtC2txGxG+J+VGAY7MxxhQ7KDA4xu8SrbGodXTC8oX90WIhoNBU2Xq5US2RIPHzLTGV1xj2JtTF93d0M3xmfxZP2oCWNFA9XHINATRXNlXmmzGauZkI/ibRWymNayb8lAkEBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1Z4EA0zHvP+uph4Ucr8oS6Id8CtuRuXV5gEthbe9T4=;
 b=XdrImozo3shFFrwS6NGeeF4Ac2XJRxF0Mo4Mnx0O65juFDJxHzlg+0c6FfVFowWwjfYiHCwr/dKbfOB5R47/rzpJXo9gbyVBq+F9IAh4+YEX8R/TJ4DN/AYtWIPHL4EKEU25+r79vD/CgKAnvDWLmEIXrt+cK6XQjEzuW8ELocihp7OqmZSjF5VPTADrTMda7DIo8D5Az/vxQSzq/XjHRPffK9vobTO7fHJEXAlxl1zeIEl6NGmZfUyQLbEuRU4hv71dbhWTFUKWBjpYKBzJh4KFK4jDrMq7OZv9tcGgWiTGiMpNpxnqxtiiQ6D3NFKBXxWG14qKzOdxiOvQVZcNoQ==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 04:21:33 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 04:21:33 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
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
Thread-Index: AQHaNu661+KkDQN9uEy53AGuuMDfJbDGiNyAgAKAsMCAAO3rAIAHAJ1O
Date: Tue, 9 Jan 2024 04:21:33 +0000
Message-ID: <SA1PR12MB7199A64262A2586BB5508778B06A2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104102300.0f9e5aa1.alex.williamson@redhat.com>
In-Reply-To: <20240104102300.0f9e5aa1.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|PH8PR12MB7349:EE_
x-ms-office365-filtering-correlation-id: 9b77a828-6f11-4a7c-d10a-08dc10ca768c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0a2AjteYbhb89plcdt4e/z/R9h9IOccP5YX3U00c8U0X0QvOgFITQzWuxO4VjndHnLaPM4uK+JlLwhZIjlX8RddCz+Sajh/xNseWtfn9S5TQooMt62zfBri/81rS87E7ZRDZtMSxRWfJGOiL45p1aN8MeXJjLJ1bgPLJLtdTG6mRXkUQI43MYk6LTubbf9FCX9KLWg9esXvqNy35neSQCrlExePFbhorVD4/m5SKzKOS63tlRcamonzwf7vGJz1HtQx1z/8eS5WkFjo4mwfvMQ70lVNNoQ55nDwzIL8lQZ/AwcfMRaAx1JtMYxXBtjRtXmZU+ogU/ZmuSU6wna0ljS2q1b/ngqWJqjxMYVd2c3avtQmp14hUpjWsSw/JiG1efP6ECiKAt5JGB3qVMV7tTJwSlRq2DasIVGS+wlih6VFid8hkj/XmOoeXw0dEReLUD6Ynh/0scBl13/AS/LzkJAnSbwrxEY2qkvl0CbggWQDRIpAaHQGvTrTR6n4fUphIP7aeMQP7QwzsMqW0yZJwstlV0DwIo/K+BCHR7AnemMWbAJRLt2cjop2CpFP19OMRpK3++6RU1csAJ86Oqwq3heuHL7qJtHTxaewwgbQVuZE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6506007)(9686003)(478600001)(71200400001)(26005)(7696005)(38070700009)(66476007)(7416002)(316002)(41300700001)(2906002)(66946007)(76116006)(4326008)(6916009)(64756008)(91956017)(5660300002)(8936002)(66556008)(8676002)(52536014)(66446008)(54906003)(86362001)(38100700002)(122000001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VeV+95OnNt1kdsC4eKSEsYs8Fe2E86VIHhKXpsXNUHqqOytYcrUg0jmYd+?=
 =?iso-8859-1?Q?eHq7Ohs0S04ulhsX6lSZxKhg+7kdL6sfm+nIGeO8ydnRKWk4bsZZG9lCQj?=
 =?iso-8859-1?Q?MrDpL/xNGCbDGf9IQxXRuF/HqwFg9j7bkKCM6EzbKk2fy1jsP4b1nDt5iA?=
 =?iso-8859-1?Q?B/Em8tMsz/HGHwZWrYanLfbhfhsfr+nr/hFtCLICCSJEu7s5qwAzYb9RXD?=
 =?iso-8859-1?Q?ahtIP+/7ROkcrz3tQDtZdhobeJsHN8f8iAgoueaHEjlZKt5DVO4wDwLg6n?=
 =?iso-8859-1?Q?6ftyIJrbxxSTBAHuTkXuPKE9KmKq7PW8/sKVx6aE+xPkEMAPfBJaInx3Rj?=
 =?iso-8859-1?Q?AVC1s8ntEhPrvX0QFjjJIKgoddQD0uXFAEKAklG39yfu4Urm4jZ/m1Yb0j?=
 =?iso-8859-1?Q?qQnWq5jIXHGM3x2UUQ2prD4SS3CsVWNNmXtbKpxFEBHRRDPwosIH5ryvPb?=
 =?iso-8859-1?Q?T/AUj6JRkCVzidYMPcfQrdPa1PyuOb1PGgUUSEtmD8Vj5/3W1IfGJNHX1x?=
 =?iso-8859-1?Q?EotGu/OLBPPfpj7SdvT5IVrHvKW1FbA5wE6DulWbEIUj6L/wqIFKKKgIHN?=
 =?iso-8859-1?Q?A+VKZ9PML6/mwU7l2PV5snsfr2dLPut4v8X8fw8uF716lZ+rsFSd+0CXza?=
 =?iso-8859-1?Q?/tPyDVN5QXgkFHo5i5Ce0fG6rKMUDrFsIVXZ1fTFi7RlAe3Ppk2Wp2QXfu?=
 =?iso-8859-1?Q?Vofq5uTO4N5AoZtX0u4cq5uKlK1nOHps4ncGlm9pJm4Z/9htFXJMUMkLeY?=
 =?iso-8859-1?Q?ogH0QLeygSdCiLv8Gp3X+Kj6S87fWUnlcZ3CG4HaqFKFBgfY1cTeXe2ss1?=
 =?iso-8859-1?Q?9meUfuLfr662XKbVIlC0O0u8mUPcWChJmFNl7chNd17ISbO5v/aozS7mFh?=
 =?iso-8859-1?Q?ocSI70bclGBKc5ACCKTRo2rhkXOlRfqhCTost6onepwmDClBEIr1/mznLU?=
 =?iso-8859-1?Q?AUwq/V4Aqi21aTXr+jksCRO7B7G02iNKewiUwuQguswxVsC1rgmmDsKNy8?=
 =?iso-8859-1?Q?Tbuddx3Got0r1Fzn8bN8SjLH7xgmw77nTz8CjI4PES3LDpJkBA8ifQXuTd?=
 =?iso-8859-1?Q?blA4UVGCn74RPob1E0ioDyj42u+8k6N9AK84I6PDIV8k/DRi35mfIHG9Tt?=
 =?iso-8859-1?Q?4mt0EiKwdOHsL3chOWjTU8IHqJPtGfAieujMwVLi/1n0SXiiLC/XauTd2R?=
 =?iso-8859-1?Q?1bHQV/2ALKZAb4J3SQOztIQtE3LREWNWNgj5eZMHg6P6whLp6l+Lc8Uxop?=
 =?iso-8859-1?Q?LZW3xLi2DtmYQDivim0Vj3VyUcEsZcEiZnIFEdX+IDZX9nAQiSjIw/2P1i?=
 =?iso-8859-1?Q?3902FdpaVQaUWGC+YQBY9/DMjpsDbWoGzv1NoC6pJ0FUsVFAq+r32SESFH?=
 =?iso-8859-1?Q?ChlGKVOMzl+HHY2tEg7c9nelwO0ujkyQ5S6Qi3GRmDNjxTznzwCs4ABosm?=
 =?iso-8859-1?Q?sAYUHJrixyG51ndp8ZxmCbMBYIqhPzBCSC8rDQZlZ3lyT9Ev+aP0tu9ILu?=
 =?iso-8859-1?Q?MIzc3wA8kNfyCW4AwtrMDE3KKV4P2GZtbW4RvHVLIE39FWFYWyH/3wfsiH?=
 =?iso-8859-1?Q?kKpfk5g5o6y/19ZggNhgKqfTYVlxKiSVFO6lVvspmfLu7gMvILUcJrbaqk?=
 =?iso-8859-1?Q?xyZkPvjEkM/rc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b77a828-6f11-4a7c-d10a-08dc10ca768c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 04:21:33.7922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQFJroA69Oj1fjCYyBWHR4cGg5hJpKBGOq34ij0Jq+3JmI9IdOhhAEOn0aupUY+0koJG/VwgZLKx9BkZGodmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::612;
 envelope-from=ankita@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

=0A=
>> > However, I'll leave it up to those more familiar with the QEMU numa=0A=
>> > control interface design to comment on whether this approach is prefer=
able=0A=
>> > to making the gi part of the numa node entry or doing it like hmat.=0A=
>>=0A=
>> > -numa srat-gi,node-id=3D10,gi-pci-dev=3Ddev1=0A=
>>=0A=
>> The current way of acpi-generic-initiator object usage came out of the d=
iscussion=0A=
>> on v1 to essentially link all the device NUMA nodes to the device.=0A=
>> (https://lore.kernel.org/all/20230926131427.1e441670.alex.williamson@red=
hat.com/)=0A=
>>=0A=
>> Can Alex or David comment on which is preferable (the current mechanism =
vs 1:1=0A=
>> mapping per object as suggested by Jonathan)?=0A=
>=0A=
> I imagine there are ways that either could work, but specifying a=0A=
> gi-pci-dev in the numa node declaration appears to get a bit messy if we=
=0A=
> have multiple gi-pci-dev devices to associate to the node whereas=0A=
> creating an acpi-generic-initiator object per individual device:node=0A=
> relationship feels a bit easier to iterate.=0A=
>=0A=
> Also if we do extend the ACPI spec to more explicitly allow a device to=
=0A=
> associate to multiple nodes, we could re-instate the list behavior of=0A=
> the acpi-generic-initiator whereas I don't see a representation of the=0A=
> association at the numa object that makes sense.=A0 Thanks,=0A=
=0A=
Ack, making the change to create an individual acpi-generic-initiator objec=
t=0A=
per device:node.=0A=
=0A=
Alex=0A=

