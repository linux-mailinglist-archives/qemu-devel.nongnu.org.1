Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5733E7CC50E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:45:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskMq-0002sX-Oq; Tue, 17 Oct 2023 09:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qskMj-0002qw-M2; Tue, 17 Oct 2023 09:44:09 -0400
Received: from mail-dm6nam10on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qskMh-0004BT-LW; Tue, 17 Oct 2023 09:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA5beG0w/fScg9cCnZvPseUFTFl/+amol5E0pWq7g0PQKnKZO40f9r18ZhEzWuccX61d0m9WHY+RvMmxeAUIza9x9ilQe4R3MaZ4AJFJlIYvxUszChaXKoTr4wk/csjqtxlcxgLsxD1LKpZvdtmJnB5Y/5KMuMh8WFqg0ODuTjlxwotSELTYH+k4xl0AjOJWurMVZBTQac7TYSGBDm1HAb07tnmRCEhmZy9F9nfJdooyxMfewKOOotID4IOQ/lYmQKNaKDSfCXaFRtP7mkOAmITaYVMKoK3e8CQuHQ8LixOKe8PzknMPCFIan1mK5cXd6e73GAtvuREWBzDN1N8+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3ZnzU0x3jk0uLG/NMl6mHcziDuqSSdgOdmcHHAJbSk=;
 b=B8QZDCOpUEiNdoU8QYHECJxCpVtFZSu6HyadT9sSlfnjv9++rCX3Nnib7i5P7YO+BSF6hzMp2JayinXLqVVDkHj4z1kZLJ3FfJnsrOFa3A16AaTzLx7G1rknnJkxtqictJz+1he8NDvfE34tQvL3zWDo2iAJobkFlNl+mZePOHrnBgjQBzYs9Xo65pS3S9/B0Bb38/Vjvpcp8ssfY307Vz1pisAQwhDRWtHg/T8NCiOwXLf3//UDZXIIvpaCgLfRoQ6351pXyX1ocJH2Anvhjdzvn9p19SOKqXDXYNgNUgfpT3RmuHyAiL0obHWvsMcAAq28BI8Xezu1vG+mfJS80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ZnzU0x3jk0uLG/NMl6mHcziDuqSSdgOdmcHHAJbSk=;
 b=tBDU7+mYQjgtsSPPR0gvwfWb48WP2ONwXuaaiS1aCs1roWj/VEZY2K90WF9YtL7BOs1eyEnfnw/50caWf+J8Nb0NHxLLOiAU4LLcqDAG/EbXcOepm5LW3lb5YCppV9z7TR6yW0FgWVBuwkCem8fPbGBi8TGn5R5acFnuj5hR6ihIZ3VSF23E7KLP+qzOwdOWfeA2sJhUfk+Vu3NFMt2DQHpaFpFzwQ/YM7Lt9HWQgLnW/SHrT7Hvw4/LfCB5k8ohT8nuukMU9VCtnpF6C0AGrdGyImB0nGX3JBLXmaevFj0iUtrIpr4I7NUvPvvKNT1wsLFqUYCkm20dGi+fHfzRBw==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 13:44:02 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::8df1:6ad8:23c2:fb65]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::8df1:6ad8:23c2:fb65%7]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 13:44:02 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/3] qom: new object to associate device to numa node
Thread-Topic: [PATCH v2 1/3] qom: new object to associate device to numa node
Thread-Index: AQHZ+VtrD7rYTzRh8km7T9+uuhuqzbBHvGjLgAZPjKI=
Date: Tue, 17 Oct 2023 13:44:01 +0000
Message-ID: <BY5PR12MB376320AC300DB2CBC3EF2221B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-2-ankita@nvidia.com> <87sf6efyrf.fsf@pond.sub.org>
In-Reply-To: <87sf6efyrf.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|SA3PR12MB7880:EE_
x-ms-office365-filtering-correlation-id: 9caa5475-2705-468a-6da2-08dbcf171f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vcCq+EYQF8r6cv4pGA+ofOmobp29DQ9vnvhaTIeSuDuEGo29PnTpczqiJdFruhguYKkz3Jr2m4oXnxlUKGnrES/YJP+tryy2LjtiU4p0A4irfrbY+OpVev2JGKooszTbpcPoL8rfHww1i9C0tgO7w9WGV4NSj6lQFlFcs3d9Ize590w6318aemn0IhVbGQcVnZ9D8RcJ6nt9yASjpPCJIcOjx5NffKf8770qTxmfFcLkTzlev7YCsKgXj/+VftYPlhaG1vOqKG2N+g+4cNrqL0KLrT1iUqG7SmC6iFeqo1OaJHAbWIurscBJHdtCzOonOtMohtGi5hXG1EnhyUYKugIJKaq6UtLPOkciNPvWAs/yNJET+MI+w4xL/lFoZWAtbSIYrAEpGKSHiV12dWxQjwvx+qGf301vixyBnxPnbnDDcjX/258tZsrmuVS6Jo5MLK0z6aUG4PhpMeCdL27SvVDxktWXXTiwsEdBF8+MddAayJ5GICJEDWF/9vkpWB2Do4OgpOMm63yN0DlaefQYG5LWcUQCwcxxRgg9qjGjcwyemBxwxrcn/BOwlrbNxO+QkMPd+3bVowmebdy7MEGbnqF0x3P3V+QMczTw0OXjzsykzEvDbABJr5rjSIb91Tub
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(71200400001)(478600001)(66446008)(66946007)(64756008)(76116006)(91956017)(6916009)(66476007)(54906003)(66556008)(86362001)(38100700002)(316002)(9686003)(7696005)(26005)(6506007)(41300700001)(5660300002)(7416002)(38070700005)(122000001)(52536014)(2906002)(4326008)(33656002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Fkiw/9rps3/pk9qF5cc8iNZ5o8Wd37RfxV/FLTkWFE22lfCkmhHaFgwhLp?=
 =?iso-8859-1?Q?UvG8aXqoIEEyutG+womzF6ob/B555UIrFc5KL1sKhS98kUaH0NyFdD3I+1?=
 =?iso-8859-1?Q?L6fK8Ihesu49+eD2tJopasv3IAZ/eON9qVQuVmWVSNT+l3hVY45YvrBGM6?=
 =?iso-8859-1?Q?iEQvKXIkdOSF5ACnVhfP3ZDUctYOfF1EU+Twj0N8qd7lZrT2vlme5hk/NG?=
 =?iso-8859-1?Q?9eG1sc6ONYoK54827kDYuxqVcqUNAbEysfetLRUFgPj3FLPvL73ZBuYQbH?=
 =?iso-8859-1?Q?JR5hCdbbDQdANTRo2FqXzYjGTTLx07m6v7nopFLblJjESL2WAAyl0CoAxt?=
 =?iso-8859-1?Q?YM/V9BCq9fd+bsyybqSEDD7i5IMncQwSgDKtHkqDyaZMq+0LPZn5Jd/OzP?=
 =?iso-8859-1?Q?AwzK9DM60YOQDXBnNci6VjBIa7KzefIP36CXRnemeaQ5MVvWBUSJleewLK?=
 =?iso-8859-1?Q?vRoczjbPvEXgnXW5ed/pdgNs8ytehzFgk7TFY0c3kPODbLdCWeNQ/XQk9J?=
 =?iso-8859-1?Q?2gTIstQm1RCjRscOs3tYLj5ltF8S5egjv0Dfmpn/u551+CbaGNeLLOp32F?=
 =?iso-8859-1?Q?1yEMrDVXdOc8vYO3t7mgJjErWn2LXJl7Zdj2AsIM32of0Rekh/9IIK1u/p?=
 =?iso-8859-1?Q?7U5J2if9k8Tg9o+P7ylBDDFWUhaFsSA3GHsRiXrb8Gs+0b1AbKo3EtGCU2?=
 =?iso-8859-1?Q?z85UKulXyNRrS28JrA1+edyU00MgsbBOkHcz8nSd8Fc4aRGu8EVcnyGk3M?=
 =?iso-8859-1?Q?k7L3PH/1vok1UlewoCv+2hLq8/2sbzKC3YK6tDz9Kuvh+b1xwd8QMYtenP?=
 =?iso-8859-1?Q?YZTgkco0NaiteI1h8PBke8fqUew0M7G9bb74GwsFWm4rxSM26R2INhDHKf?=
 =?iso-8859-1?Q?/oUebiFLVu/97z57TMAbwVKYL/pRDw9qvk5YCbV0PkMR1yCsxJ5eYcRC7G?=
 =?iso-8859-1?Q?cwaz+R6Mm94vYqAPPeL+C9E91cganhiSPdzH22nkUGmB1wqipp4eTgwHQx?=
 =?iso-8859-1?Q?t+jRt9B1/m/27as8gjEfOgtrhSm9JW2/M842dhSSS1IsQYOnnY90bp6hz3?=
 =?iso-8859-1?Q?tmrY4DdoSxOLImsGLMOMpR4EXW/D0G6J7+vOttqhgGsy6xAQQ2mawqe6dL?=
 =?iso-8859-1?Q?4TlZHJVMPZHGelLzpD6EdFeRztmIZS0QT02X21sUjcYnZanbAuEPginf9m?=
 =?iso-8859-1?Q?lYGRIrqHspiDIapp4julAG9x5VMdkM1QS5QkMHJSwdFnaqmCZvAw5RuKnm?=
 =?iso-8859-1?Q?yIhMma53rcu8DwF1PoAqn+KCYwFLHzhQ95fGcN2MyB8XlakvLfI2GGMUxP?=
 =?iso-8859-1?Q?lbXEeE1vtmYus4irqTiWOsNhceO0tkMIPzY9acb/MD9qffa76XeiDAOgPD?=
 =?iso-8859-1?Q?JGxooutp5K3N+uzwT+FftDCNoMExfYcqiA+SJeYdf8nNwfxjjBfy5GEFSh?=
 =?iso-8859-1?Q?0E66iXP2N4UmLoPAnlk2pWq9KRMX+27ecy0KrEZJL/NbaKByLirnfwNyYn?=
 =?iso-8859-1?Q?TJPmPgp7zW0YJYovqu1XfwQrybxWqEpFQHN+8nDOmD+NV8pGdKYyqvPP0v?=
 =?iso-8859-1?Q?8pWR+kc/4OsG1tp6YeB/jWi1P3K6sidqoWCHTbQGu5dxsamwnTmxiYtzwq?=
 =?iso-8859-1?Q?bVPnGpobY0CeY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caa5475-2705-468a-6da2-08dbcf171f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 13:44:01.8939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7n762Ajs3e3L2+f6p37e6c0f7a1iKpw4u6F1WslpaQHDCQl4atU6vvd9GMf2u0sbluAYTywFVNPk+DdHUcTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62b;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

>> +static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,=0A=
>> +                                            const char *name, void *opa=
que,=0A=
>> +                                            Error **errp)=0A=
>> +{=0A=
>> +    AcpiGenericInitiator *gi =3D ACPI_GENERIC_INITIATOR(obj);=0A=
>> +    uint32_t value;=0A=
>> +=0A=
>> +    if (!visit_type_uint32(v, name, &value, errp)) {=0A=
>> +        return;=0A=
>> +    }=0A=
>> +=0A=
>> +    if (value >=3D MAX_NODES) {=0A=
>=0A=
> error_setg() here?  Thanks,=0A=
=0A=
Thanks for pointing out, will make the change in the next version.=0A=
=0A=
>> +##=0A=
>> +# @AcpiGenericInitiatorProperties:=0A=
>> +#=0A=
>> +# Properties for acpi-generic-initiator objects.=0A=
>> +#=0A=
>> +# @device: the ID of the device to be associated with the node=0A=
>> +#=0A=
>> +# @node: the ID of the numa node=0A=
>> +#=0A=
>> +# Since: 8.0=0A=
>=0A=
> Since 8.2=0A=
=0A=
Thanks, will make the change.=0A=
=0A=
>>=A0=A0=A0=A0=A0 'tls-creds-x509',=0A=
>>=A0=A0=A0=A0=A0 'tls-cipher-suites',=0A=
>>=A0=A0=A0=A0=A0 { 'name': 'x-remote-object', 'features': [ 'unstable' ] }=
,=0A=
>> -=A0=A0=A0 { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }=
=0A=
>> +=A0=A0=A0 { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] },=
=0A=
>> +=A0=A0=A0 'acpi-generic-initiator'=0A=
>=0A=
> Please keep the object types sorted alphabetically.=0A=
=0A=
Ack.=0A=
=0A=
>> @@ -1014,7 +1029,8 @@=0A=
>>=A0=A0=A0=A0=A0=A0=A0 'tls-creds-x509':=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 'TlsCredsX509Properties',=0A=
>>=A0=A0=A0=A0=A0=A0=A0 'tls-cipher-suites':=A0=A0=A0=A0=A0=A0=A0=A0=A0 'Tl=
sCredsProperties',=0A=
>>=A0=A0=A0=A0=A0=A0=A0 'x-remote-object':=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 'RemoteObjectProperties',=0A=
>> -=A0=A0=A0=A0=A0 'x-vfio-user-server':=A0=A0=A0=A0=A0=A0=A0=A0 'VfioUser=
ServerProperties'=0A=
>> +=A0=A0=A0=A0=A0 'x-vfio-user-server':=A0=A0=A0=A0=A0=A0=A0=A0 'VfioUser=
ServerProperties',=0A=
>> +=A0=A0=A0=A0=A0 'acpi-generic-initiator':=A0=A0=A0=A0 'AcpiGenericIniti=
atorProperties'=0A=
>=0A=
> Likewise.=0A=
=0A=
Ack, will make the change.=0A=
=0A=

