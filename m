Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9878B7E9AD2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:14:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UtR-0007Oc-5m; Mon, 13 Nov 2023 06:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r2UtP-0007OH-N8; Mon, 13 Nov 2023 06:14:11 -0500
Received: from mail-dm6nam12on2060a.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::60a]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1r2UtN-0002Ii-96; Mon, 13 Nov 2023 06:14:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aooeACX7ZrduQ1T3IzW7Se7QgVgajipu6ZgzKctlaNCxdGIbxL4eJhczwhJ5dLcEdVjhuvwNkTy7qiz9MFH8NLn2cphwXLI6Q2FsSbeJ8GhUjdtDffLG1sE6pZ/UKX7ZIJJ/lG0iFxk23FHDU+vfCPO5UgwHJQC6R+7AVCTsgD6Y9IYzKmx8PxKgeme5qM1z5+UXlTpXVbM40LhI9Fiq0OxshRmWbASLaaOFzVFWBVciDNqJHGc+x7XHRFyrXlitRfH5ghCUWxZlZHGoucYymB6d+AuH3TYTb0v0hLTj2Dlsb42xioNIw8iKoimO5Ww9+99rzNQyRjekZV5k6/Qr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk4AxTK80/olf0nT0AghfkkPpHBmSIFYOdc0Hq6i8uw=;
 b=EBNcGhmLbDFjdRiAoBtBF0us18m1230WS26eYVw2FNgPyGr/sJxcRckk0i3wQ95DHcXwVdWTXB0tQzfNzv+9pXIC+7j59rHUpxmnmh9kqVF2Osl3DvaIC7PeiBN8aVFR9Dj6/tm/YLbtQaSxFGyEfesfp4hrvYW2T3kvR5OAYQE7Tq8M7Pez6HnvLgbQbo3AT1dLjnJe2dO3yFX5NISORDd7oeSLati37Cfd8ltWyjnxoMb9SgusAdb5ccpFyBWuOTEuQe0u0dxRqeZl7V1/nU95hp2jRYrJsZpEKaCPMmCp74kge6edUs9ZSvh8Ve5eLib42rxdx/FQg+qY9/yvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk4AxTK80/olf0nT0AghfkkPpHBmSIFYOdc0Hq6i8uw=;
 b=DB86/RSXyDXqsgmTyx6MRWwRpYiFJR1WwjmQP5qGPnLrwBjrqCiSbIRtr4h+IeFLQ76JTMqBYRxg984gLJTHfAN/NvSvdnnZvcLNPPAyIMuDUlAZQwA7j5tKS6k7+275BRXW4Bo8My6dLcJYl8kRJs2ty3I6qrKck6qhrW03WU0Bsyp2QdPYktJuyfqx+cMET2Xa5rk/VYVQcFXo/twL9/8Bz7sX2WruO1q1OS77YHCvRgALCQBtOiESH12Sf7XisbKloyVtsteDku0B553+6VQaS8VJyeN90Y0f0LfOPC/s8Faol7tx1c8UNwfzrQvjtL0VQ3O1dGrycdW9dMbGoA==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 11:14:01 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::946b:df84:1f08:737a]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::946b:df84:1f08:737a%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 11:14:00 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "david@redhat.com"
 <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Topic: [PATCH v3 2/2] hw/acpi: Implement the SRAT GI affinity structure
Thread-Index: AQHaEazTOeKIE4XgF0qerAxHLKOa8rBvbzCAgAJ8Bb4=
Date: Mon, 13 Nov 2023 11:14:00 +0000
Message-ID: <BY5PR12MB376329341A19E4FA1B5B63FDB0AFA@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20231107190039.19434-1-ankita@nvidia.com>
 <20231107190039.19434-3-ankita@nvidia.com>
 <20231107172318-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231107172318-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|DS7PR12MB9042:EE_
x-ms-office365-filtering-correlation-id: 55cf8adf-c3ab-4bdc-024d-08dbe439a34b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P4082z3DByjMutHD/O6I11/12oK5/vnmfQ9l0IlegA1oQSLvOK0LCmbnbLFU39RtcBeEiiNI8kUZXUxX3XlahA90AjFT4I1pqgwK15fNFQBqwN3tYRWx7iyHLvMySRIOw8riUPOU0hpgrinzGX7AZWmPMEB3L4cpePhH/D3D3BGINdoRT8Mo7S7SeCeW87Om26op0NbXyoZL1m6yjI1zLKNyB2RdUKs61gS6DtHnaG0AAQNo0eGwPm0sFprix/eDX+TaWc3wWx23lE/iuW+3c0EXzvUmDGdUGRcWLgX9CVbBuihhupASbaI2mLAbtUNeanoxglsBN5jpXB12lCfbwFmXhBv58NE76kjms19YYofdU1Xa2rjEuDBmIhQrLV/f4YcDYV6hm3xAcw9D3LT11YPWQ8hExpFW6LQqVxPZnmNVgXcTcpssxTJi/lJry7IFhbRseiTif+zgBqm9xoXrL1147ibpXHTjuf0ivD51S3Dng8K0WIYcmMG0l64yegpAWh049GoAfvjJfnmo2UCkOJygc8VWDV5WVeOHPrP2+Je3uuFPFUdgADXkq982JNwlzKfmjFaUPu+4qesCH0BQpn+3uW0qltTcHLLTFWkBgEqLHN3hP/c4ZT0wpekInfiK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(38070700009)(2906002)(52536014)(71200400001)(5660300002)(86362001)(41300700001)(33656002)(26005)(91956017)(9686003)(54906003)(66446008)(66556008)(66946007)(76116006)(66476007)(6916009)(316002)(55016003)(64756008)(83380400001)(38100700002)(478600001)(122000001)(7696005)(6506007)(8676002)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3S4ZxKNLZm5LfPuOooyPiP3yV5OhPUqenh24MlFUO8NMRQe/bHZ4t/UN8C?=
 =?iso-8859-1?Q?0/zYq8L0MnSjxlpIHylabMxDuBqhggoCqkMkXvp0E7e3EQJyXBNQfiym/h?=
 =?iso-8859-1?Q?eaUGHb58AUdIU+sjo1TOEnfKH1qL6R1q8WN5goB4Fx0/HtjPvPl3b0CYku?=
 =?iso-8859-1?Q?inL7IUcXghuPxUdEkTPx5zlKJ8e7B+YzQdLDlICFn5A/oOVVPllkuQdoBg?=
 =?iso-8859-1?Q?7S+XPfbgqONv8IxarGYCSSCGHDhIXm6Z+/FMJ8Z1+RiE67GbchtQ8lMsLp?=
 =?iso-8859-1?Q?K8BJDnTDnJ4TCaVZzIz6FupdXZI8rho6tMHD4WMAe3SjJ9xBb9sbWRTNa0?=
 =?iso-8859-1?Q?4Q4ZgMN3c/zDftxXfrPGeE7wRsgM5+7Lr3NeBCUqbxpNmGSLLoaVVAa0o9?=
 =?iso-8859-1?Q?gjTm5aQK/j8PTVARxzxdcP2HemR8RxrJRY6CjXur0J+BOrWPPUWZbZlxXQ?=
 =?iso-8859-1?Q?8y6P+Cpzw0bSulLgA+kjP8l2W2UJlyR2OL/l5FxhjQrzQxihIQ9cFC6SVf?=
 =?iso-8859-1?Q?76e4d2FRfRvvCeoY/ub9tMDj1L/KN8nQWGslf+jlj2FIko5UHVlAwG44W4?=
 =?iso-8859-1?Q?CeT6Kw7mjYaMYDt/LkLog9yovNdbzG3PUe4U4jxC4h33k6Asd9bJZT+ffW?=
 =?iso-8859-1?Q?8XGRKHOobdCqbTKQM0i+IAsVH/m6t/SEA6LM+R5JqCHODf42Xfdmaay73y?=
 =?iso-8859-1?Q?vL+nmOZUP9EHOebGUcdJdTWcGMNSm+4M6friFTgLG/+JUhwTtT9QOV36Js?=
 =?iso-8859-1?Q?WPPWpdX0NYFK0IkqBZraQE79yBx+n1+Ai6kpP7cdi6Lpi4YWjscJlUvEs1?=
 =?iso-8859-1?Q?eMVCp8UPzGWtqZ9MmMk3GOGB21qlgbWIxneuW6KNtmD7bewPV5jfGqHSX6?=
 =?iso-8859-1?Q?SwOfsSJqcEGjx6wHz1dKUnvJ8IE0UTOEVgG6x6oMPDwfllidJwByS1RE+3?=
 =?iso-8859-1?Q?+CoBgzUSgsILZJb/crvv4vPNi7Zn3JaSxX+UFClsBvey8ttjk/3loFrwE/?=
 =?iso-8859-1?Q?A8+dvEV56689QJ8xGUwAE2jVfK1nUe+09+wd7tVLZOPT8S0Gq3Qc67CZJY?=
 =?iso-8859-1?Q?OYM3H0E2kS4vyhhXs/SWgX892FaSivCeynM6mY10wQ6Tlk6E4Tz9Ngh8ml?=
 =?iso-8859-1?Q?GSm3V2wtIhVyywpk5DM+9PlOZo8cTPUh3ndyLrdnWnATZIoc30RFkv15K6?=
 =?iso-8859-1?Q?FJOh0PfQ2elPxwzeiR5x9TtVotz3+2pI7wJlm/j27g1WPLzx6QIvAD4qJE?=
 =?iso-8859-1?Q?oST6sIJjAAVD632msy6sHrYnp4ru5/MdjG8MFPaPHAfOpp6gv3DWYJgUXk?=
 =?iso-8859-1?Q?UFhantJeJ/yeLjEJ5JGgAiYYPSxQrZUmpIzmPrZkXVf9lPDVEEZbKpTn1x?=
 =?iso-8859-1?Q?sCNbcFJDMwhdB/oE+eBXVDaLq2phFQME6KBMj+3A+LTng27C+KmVfPhi1h?=
 =?iso-8859-1?Q?c1ywYJH50dDffNk9kRzFwIU3Zu5dbV1N5ckCVIKR3lgR00x/A05zyaDWEz?=
 =?iso-8859-1?Q?zH97oxDWRUUnAZpVVKc+rW5YMlZ8u9SKEgQR+SIZhq9sGWTOliEdLor0i9?=
 =?iso-8859-1?Q?Lfu003OP47b8wn36ly+bhfooyzrJdDGgE9ycd7WYabtfgSmHfyF1fcRpTb?=
 =?iso-8859-1?Q?g2ce1pFzme6qo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cf8adf-c3ab-4bdc-024d-08dbe439a34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 11:14:00.6724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/PimcnD1utrx8YyhFgGXYr59HEsr5Lvcv837jobCBdWKAXDNKsMKAXQ//TjuIR4kTbWJNYrzWQajkbEOJI1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
Received-SPF: softfail client-ip=2a01:111:f400:fe59::60a;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

>> +=A0=A0=A0=A0=A0=A0=A0 for (l =3D gi->nodelist; l; l =3D l->next) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCIDeviceHandle dev_handle =3D {0};=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCIDevice *pci_dev =3D PCI_DEVICE(o);=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_handle.bdf =3D PCI_BUILD_BDF(pci_=
bus_num(pci_get_bus(pci_dev)),=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 pci_dev->devfn);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 build_srat_generic_pci_initiator_affi=
nity(table_data,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 l->value, &dev_handle);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 }=0A=
>> +=A0=A0=A0 }=0A=
>=0A=
> if you never initialize segment then I don't see why have it.=0A=
> It's just the bdf, just pass that as parameter no need for a struct.=0A=
>=0A=
> I'd explicitly set the segment to zero just to make it more apparent=0A=
> that it would need to be addressed when QEMU adds multi-segment=0A=
> support.=0A=
=0A=
Okay, so I'll keep the segment id, but set it to 0 explicitly.=0A=
=0A=
>> + * ACPI spec, Revision 6.5=0A=
>=0A=
> we normally just say ACPI 6.5 even though a couple of places are more=0A=
> verbose.=0A=
>=0A=
> In ACPI we document *earliest* spec version that includes this, not just=
=0A=
> a random one you looked at. I checked 6.3 and it's there.=0A=
> Pls find earliest one.=0A=
=0A=
Will make the change.=0A=
=0A=
>> +typedef enum {=0A=
>> +    GEN_AFFINITY_NOFLAGS =3D 0,=0A=
>> +    GEN_AFFINITY_ENABLED =3D (1 << 0),=0A=
>> +    GEN_AFFINITY_ARCH_TRANS =3D (1 << 1),=0A=
>> +} GenericAffinityFlags;=0A=
>=0A=
> Don't add these one-time use flags. They are impossible to match to=0A=
> spec without reading and memorizing all of it. The way we do it in ACPI=
=0A=
> code is this:=0A=
>=0A=
> (1 << 0) /* [text matching ACPI spec verbatim ] */=0A=
>=0A=
> this also means you will not add a ton of dead code just because it is=0A=
> in the spec.=0A=
=0A=
Ack.=0A=
=0A=
>> +typedef struct PCIDeviceHandle {=0A=
>> +    uint16_t segment;=0A=
>> +    uint16_t bdf;=0A=
>> +    uint8_t res[12];=0A=
>=0A=
> what is this "res" and why do you need to pass it? It's always 0 isn't=0A=
> it?=0A=
=0A=
It is 12 bytes reserved field in the "Device Handle - PCI" described in =0A=
ACPI 6.5, Table 5.66. I'll remove it.=0A=
=0A=
>> +=0A=
>> +        o =3D object_resolve_path_type(gi->device, TYPE_VFIO_PCI, NULL)=
;=0A=
>=0A=
> As per previous comments, this should not be tied to vfio.  This should=
=0A=
> be able to describe an association between any PCI device and various=0A=
> proximity domains, even those beyond this current use case.=0A=
=0A=
Sure, will change it to use TYPE_PCI_DEVICE.=0A=
=0A=
> It also looks like this support just silently fails if the device=0A=
> string isn't the right type or isn't found.  That's not good.  Should=0A=
> the previous patch validate the device where the Error return is more=0A=
> readily available rather than only doing a strdup there?  Maybe then we=
=0A=
> should store the object there rather than a char buffer.=0A=
=0A=
AFAIU in a normal flow currently, a qemu -object is (parsed and) created mu=
ch=0A=
earlier that a -device. This complicates the situation as when the=0A=
acpi-generic-initiator object is being created, the device is not available=
 for=0A=
error check. Maybe I should treat this object specially to create much late=
r?=0A=
=0A=
> Don't we also still need to enforce that the device is not hotpluggable=
=0A=
> since we're tying it to this fixed ACPI object?  That was implicit when=
=0A=
> previously testing for the non-hotpluggable vfio-pci device type, but=0A=
> should rely on something like device_get_hotpluggable() now.=0A=
=0A=
I think this will be similarly problematic as above due to the sequence of=
=0A=
object creation.=0A=
=0A=
> Also the ACPI Generic Initiator supports either a PCI or ACPI device=0A=
> handle, where we're only adding PCI support here.  What do we want ACPI=
=0A=
> device support to look like?  Is it sufficient that device=3D only=0A=
> accepts a PCI device now and fails on anything else and would later be=0A=
> updated to accept an ACPI device or should the object have different=0A=
> entry points, ex. pci_dev =3D vs acpi_dev=3D where it might later be=0A=
> introspected whether ACPI device support exists?=0A=
=0A=
I am fine with either way. If we prefer different entry points, I can make =
the=0A=
change.=

