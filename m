Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D87CC530
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:52:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskUH-0000YI-Im; Tue, 17 Oct 2023 09:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qskU6-0000Sb-9d; Tue, 17 Oct 2023 09:51:46 -0400
Received: from mail-dm6nam12on20604.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::604]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qskTz-0006CJ-0g; Tue, 17 Oct 2023 09:51:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAp9lqz5KhOO5kW9ntbHdMq9cqMfXtMVtWGiRXVKHxtBo0slYKNm7TMF/6L1bHyqLrfBBc7bCFKenJGipgupoTeHs9LDduVPK8N8djnHWfKiBMsJt2ZrOxvWIN0i/HNkhKlLzOpBEbbab0xvR6b2DP20pdDcUwqsPQKaNYWsgCoXfmyAEkBYxz7JR8RtZE9/qTZA97vLo4NMUqAaYzT4/MXYzOBIfRopgpBwP0v0fwbdxmYGkSYlE8xMMkOmtFvd3Lx18/VQLTjMO4AyXsZmLpzETTCFv95vt7LJDX7SVlbBB4fvz+maHw2o5yYAQ+vPQDAPEr0xqpPi4GKHXFx1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu+th3V2yEsN8+2Apt0NdJNT4xylyvt7isfTWA1Mc1E=;
 b=DVh3trQHaU/TWjV1Ykk67ngkeRkQzYb6Hwy4mWupqYfkOEjMsD8TATa6U2Xx484DxD4gcKW2Ue4iDZ/iarhxcAFb8m0r+78mymwNeE868aM+zHo6PZgYD6OwVCL55+GgYR8aGuwKO/++4fQ32rdMXWT7NlKKdkd6PYVfYroVkApILvo0j1S6WG1/0f5f85WAA44+Ji2PkMLI7Yr33sz8zKKgD8eD0q/ei0TQKN9z5e/kMKP4ej8YZM8AnPNzWwiZwsOcjcwj/rIZEtrkvJutLTGsmlQZhoNJO4tFD5quAC8HEdbRJ7e4WDlQdeqwJBpSClenabowrdAi/Ow+qrg70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu+th3V2yEsN8+2Apt0NdJNT4xylyvt7isfTWA1Mc1E=;
 b=jEXXcT+5DwQnwIrPW7rd3jU9WiNj2frTqLQJElEVz5uDsYfoNYuLzZQNBAYi5llr4ZBUuIuKajJiEgmMeOIAPHBf6rDiGYPhWv6PSg6okIjnAyWiLkMK/POavf332sowy73edPIRQXVwWkODNfAzgCr04O9O3PRxijFf26I3QNGSwE25K8Z+BLZk1Z4GrwFDMS8HQPdYCO+unC1L/5YIGVY/TYgtOx98xsJInbUDuuPQgeBipRj30oFjhfUR3Gp8PMy59Cl8uv7pkqIO/TU7HD8rHkLGrBJJvELKa0+JAbBXzUT/8jmKLlcNRXZbf6HpiX2qUL3CXVvl3++4eElhnA==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 13:51:23 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::8df1:6ad8:23c2:fb65]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::8df1:6ad8:23c2:fb65%7]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 13:51:23 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/3] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v2 2/3] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHZ+VtrWTk70ZdgMEa2ZZ1iZJjt1rBB+QIAgAwUWXE=
Date: Tue, 17 Oct 2023 13:51:22 +0000
Message-ID: <BY5PR12MB37631C627C940EC010D0CAA7B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-3-ankita@nvidia.com>
 <20231009151626.28910a90.alex.williamson@redhat.com>
In-Reply-To: <20231009151626.28910a90.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|SA3PR12MB9129:EE_
x-ms-office365-filtering-correlation-id: 7d85878f-8de3-48dc-1369-08dbcf182627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4qpl6015U1dpemUO7TqqXeo34O8yZeZCXBpmAvBQFHv2zC+mCLjMIesptqrE9GBLK0afIcr/HVV7yPvl+trbDkrOVZbYraA91eJxTHUwOSP/cILebdPvo2o6AdR5hu9WEfmhGxPQkxCEP/LAIVxxGUXraI8Ebg6ceEkFsl3E2J3l785EHwGaJ8+PGL8/VmItCSbjg1xc8iE6tPxOqU7cWXvQBJMyOHsyTHfgXixmzZyjIrhJqBHUR3VmAcCUrBves/WeErISkueQs7S5/RV9vCt4xxP/pmKG5rpArwQeraYS7nWyCnvfXuGih9+YAaPbVEyBuCjXMs7OK3f8fA22XlwdqgK+54QnXBn38dW47QwcjLX1oGHNRF00Mo6YOlnHdywezBFiVMTNwd4rIjvBGki1+wRHP9q36Ulzi8iop2UfzDMmS+ghA8R0OLrq5169SKBqqabE35+wzPEjX4wAQWziuzGa8VCUjNpGirC64ExrZNAI9OMrwV4e4CcCcQdJstA6ba5s9wbDTXyJX32T19985BlOsgciH/F0CVSd1Ynnk78hvM2b5knTd5rD//e6MMnwsuRl3DOMNtJxGHfzNtxm1L0+n/x/aTRqwbo92MOWUl4yzcfo7+3xD81YgAp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(8936002)(55016003)(7416002)(66446008)(6506007)(7696005)(2906002)(71200400001)(478600001)(8676002)(4326008)(52536014)(91956017)(5660300002)(76116006)(66946007)(54906003)(66476007)(316002)(66556008)(64756008)(6916009)(41300700001)(33656002)(26005)(9686003)(122000001)(38100700002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BRvPkEo1fkWIAe8YIqWipa80uKmiKIBueYuTayjdgXUFS4vZ9iKwAEw61e?=
 =?iso-8859-1?Q?KZLlAiFYk5mZzRgYXEC1g6vwodMJSoi5G0eVR2VWeUB25gkzqfKa9CBKWY?=
 =?iso-8859-1?Q?iTlIFqHvS9AVWbPknx0/YrgZHNVrhqWKKLPbJZH2Se0ER1Z1JmAFhDrPWG?=
 =?iso-8859-1?Q?czV9i1T5VL8phCOs6glfyqD7HHLtTnofYyEKeb6KK2M8av1SUKvGFWsIZ4?=
 =?iso-8859-1?Q?RcqPdu9KuwR0I+zqMDQRvBa5VCSu5s9g5fw0JXKSlBfhgxgR7bMYG7dbrh?=
 =?iso-8859-1?Q?peOhkBrq26faVE4rcQPwBzXH/OALu74R2RFXMY/hQCsUC82ks+U19Vibsp?=
 =?iso-8859-1?Q?K+MxYVRgwphM02dg4flcRVCdLQS7ylNNIHfEuZTskcR2la/xYnuJdz5VCW?=
 =?iso-8859-1?Q?Qbe0IAuq75GnRWmstcMZ0rY8ql5Sj2sHVL7CcT3WSiFBo60bGX1NTr9lvz?=
 =?iso-8859-1?Q?nmOtYmcpYwCBndxlxrCuXv8jR36qXfvBpiQcfawTY6sIXBG0ENpPvmnOkW?=
 =?iso-8859-1?Q?wKV8jOyaN1MUI0ok1dzjFJ3KQfm3YHnD/NW5Bce2jQIv+hpF2GRSLTQL0X?=
 =?iso-8859-1?Q?+/umY81dqSyeTTsRYLHm+eRxU6z2w1RnK/C4jBxJ7I1Et86wBaQXbIrSa8?=
 =?iso-8859-1?Q?Uydu/rjKqtuZ6C4jb2oCEHCDrfEPAAyaoCReTncHwbsJcVXkfVYq6LVOYF?=
 =?iso-8859-1?Q?OxnwKEKcAwPoi5ejtbiagqycQzZKo8m/IB3uEbC1QqI52LZLtSwS1qKDa6?=
 =?iso-8859-1?Q?yvXyV+i5Zg8myCc5ylTbaLpzoYTcBrNYn1AjSYPW59teGH3Sn0KZJ4XNHH?=
 =?iso-8859-1?Q?L3joLEivm6ZQfucqKw7OdkVB4YT2Ca1kctP+soTIogiVPxsNl7xxBZN6v+?=
 =?iso-8859-1?Q?hF0mzhp7jU/7TD5xCinrjiXRm0yzZuoYmugVcfuD/b3n2S2LN31NZUY3y8?=
 =?iso-8859-1?Q?+zvT0tVfEGngFzcPsn8f5xiH4OnU+8R7mbW9XWR24/BskyQDuE8xG7u+DT?=
 =?iso-8859-1?Q?xTLMZGFqLInAFbv4svUpJIpN4MXbjfUEYGJ2KgKb/MjZVL4ceOlfuZOdRS?=
 =?iso-8859-1?Q?OtXxkewbfrmF8eJSCFXqXRoKUTg6dSg3Wp2MNNrQ3uTsqGZFy+Ee4jDuhw?=
 =?iso-8859-1?Q?Y6m/LnUmlGByY6s6b5m3oO1+YqGRGgvOtVW548s9sRv6ybkkfquQ8q+VRW?=
 =?iso-8859-1?Q?wptjEKO3jF6GgF2qKbJJ0qvO9f+USEYXggespfhnnn7tBf3hzdM+kCtxcO?=
 =?iso-8859-1?Q?9zFuhowfrfR5NMF9PeLzu5ikOHzAyUYxLBLu//l30wLiFRieKSYx4Z1Hu6?=
 =?iso-8859-1?Q?ui3TtkPv7d32jfy0ra+tkIpLK7fKt+wgcMAh+VMLATpfyQB1jXW9WrktQB?=
 =?iso-8859-1?Q?Ak7EO6A3b3ryg/UcFmC+gfMPVYmDv+cZOAjgVhHoOjeG2CAhS25bEDwBTb?=
 =?iso-8859-1?Q?eaZKT6kqi6pnwE4ZGun3+ZbpZ5oVWPZK8god5q6wZ5+iBF2cFxuy2cOUeJ?=
 =?iso-8859-1?Q?ghz2iYD+jfGphvORAew4zH37bplO+JxXX1sM+BAI1LubyicnmIXALy5ym8?=
 =?iso-8859-1?Q?ZLIMW8ViXScWYSbjBD3YX6I6ZUCEnEEw2dJw1N36J70RkFjkV7soE/7Gpy?=
 =?iso-8859-1?Q?xJYHE85oD/7Ic=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d85878f-8de3-48dc-1369-08dbcf182627
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 13:51:22.8802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9IR1oRXInpcDzLNZmyA0tsbjeeiKT1CSMYYIoJt6fqD3yiJ+pbkbaxl0um3cCezj2HXHyxtUHGk9rpYHryCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
Received-SPF: softfail client-ip=2a01:111:f400:fe59::604;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

>> +static void build_srat_generic_initiator_affinity(GArray *table_data, i=
nt node,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 PCIDeviceHandle *handle,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 GenericAffinityFlags flags)=0A=
>> +{=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 5, 1);=A0=A0=A0=A0 /* T=
ype */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 32, 1);=A0=A0=A0 /* Len=
gth */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 0, 1);=A0=A0=A0=A0 /* R=
eserved */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, 1, 1);=A0=A0=A0=A0 /* D=
evice Handle Type */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, node, 4);=A0 /* Proximi=
ty Domain */=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, handle->segment, 2);=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, handle->bdf, 2);=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, handle->res0, 4);=0A=
>> +=A0=A0=A0 build_append_int_noprefix(table_data, handle->res1, 8);=0A=
>=0A=
> Why are we storing reserved fields in the PCIDeviceHandle?=A0 This=0A=
> function is already specific to building a PCI Device Handle, so we=0A=
> could just loop build_append_byte() with a fixed zero value here.=0A=
=0A=
Good point, will make the change.=0A=
=0A=
=0A=
>> +void build_srat_generic_initiator(GArray *table_data)=0A=
>> +{=0A=
>> +=A0=A0=A0 GSList *gi_list, *list =3D acpi_generic_initiator_get_list();=
=0A=
>> +=A0=A0=A0 for (gi_list =3D list; gi_list; gi_list =3D gi_list->next) {=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 AcpiGenericInitiator *gi =3D gi_list->data;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 Object *o;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 int count;=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 if (gi->node =3D=3D MAX_NODES) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=0A=
> Why do we have uninitialized AcpiGenericInitiator objects lingering?=0A=
=0A=
Right, we don't need the check.=0A=
=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 o =3D object_resolve_path_type(gi->device, TYPE_V=
FIO_PCI_NOHOTPLUG, NULL);=0A=
>=0A=
> TYPE_PCI_DEVICE?=A0 Maybe you could check hotpluggable from the device=0A=
> class, but certainly the generic code should not be dependent on being=0A=
> a vfio-pci-nohotplug device.=A0 =0A=
=0A=
Understood.=0A=
=0A=
> The spec also supports an ACPI object=0A=
> description, so should this be build_srat_generic_pci_initiator()?=0A=
=0A=
Sure, makes sense.=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 if (!o) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 }=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 for (count =3D 0; count < gi->node_count; count++=
) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCIDeviceHandle dev_handle =3D {0};=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCIDevice *pci_dev =3D PCI_DEVICE(o);=
=0A=
>> +=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_handle.bdf =3D pci_dev->devfn;=0A=
>=0A=
> Where does the bus part of the bdf get filled in?=0A=
=0A=
Good catch, should have code to added the bus.=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 build_srat_generic_initiator_affinity=
(table_data,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 gi->node + count, &dev_handle,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 GEN_AFFINITY_ENABLED);=0A=
>=0A=
> Seems like the code that built the AcpiGenericInitiator object should=0A=
> supply the flags.=A0 In fact the flag GEN_AFFINITY_ENABLED might be a=0A=
> better indicator to populate the SRAT with the GI than the node value.=0A=
=0A=
Yeah, sure.=

