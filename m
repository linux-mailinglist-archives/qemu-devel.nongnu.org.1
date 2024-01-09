Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60063827DC8
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 05:13:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN3TG-0001Z0-6T; Mon, 08 Jan 2024 23:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rN3TE-0001Yn-ON; Mon, 08 Jan 2024 23:12:08 -0500
Received: from mail-dm6nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::624]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rN3T9-0002Bk-6H; Mon, 08 Jan 2024 23:12:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBDinNMlRi1Sv2icYewwviztX7A2Y5iHH4vyUPYGq8ZZuSa+PnyyGCUGDLoPH4H3ovDVW5FymHZELU5dPwhHpoxKBvsClDHBd6Kf/JPNbQ93yqx313rmWSHEt8K3byywzzcVmFnVuVVXgqbIaaDhEbY+BRmlgHEs1iCKit1FIXwmMRMuDA6x7LHcIZrZ88yGLmJx9RBDifrzqJz9D9amB/OMts5pYwZfOADXozq8RJnJF9pg+0z5KbabBOviKCTjiiLvTmUl/xmiR9wWRSBbYEzsam3hUAEAi58zC+9FA6zHihveH0DhrCZGAx4lkL/tCxRll32HOMLunChYL29DHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE3rXvtl5np6oPUzR2baQS0ghOXAyhowFOF1VG0Hp5I=;
 b=mJO8DFjk0zsBX3D1L6oPeMTayV4Exv+UF3P8fX89shJurIyMBPH7hE64wBizxky5hRysJqL9I67h6tDpbuyp5R6BgdEF+K9R4XF9WL0cfh8zfbE29rwW8csHTQmGAag3HDPZAr9xu2r6vKkx4Bj4mXN3dgAKWlAc0BEYuENlf2lk/u9O1xsPAafGX1Z+BXjIX00XM5Ex9HcxBhpQNkUZ4JAOuZnqEF+kJmkmsDFEINgrh0RHaog3HTA64lchy5U3RxB0mNWZMkPSwAKAM1ZCi9+BPOyQjgbLByr92RlutV2/yDNjTx4Q2EEomGT4nQiwOGdT5l18ihUqmcD7BQFjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE3rXvtl5np6oPUzR2baQS0ghOXAyhowFOF1VG0Hp5I=;
 b=IKT4EJdiAGCGixbzOUjcGALY/i++Rg9e9fX2x75vVWAywnAugx68DO5Pl0KrlFasXKWnDhfLd/SjJKq6A4QD9cKqYBkBFg37TNrqmDf9lwNMPZTrGc15QdeGlucHchZ9Ll/khdXSkxaImd3WF3KREDSqe567R43l21st2pK+UYE+8vmfJtbmWXANUXZ5u3El2ChVptce+a/Zxq3te1m2W10cXXzK/y99dRdBgs6RzuBgTLxrOCDGfBzx+uUPpRaJvvHAPxjbAOsjFrXEeiYcJFm0lak9K+E2eBVjOxsIQAb7Ns9LCje/FLraLbn7S5G8MRREd9YmRRL73xQ1aEnKTA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 04:11:57 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::e23f:7791:dfd2:2a2d%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 04:11:57 +0000
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
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v6 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaNu661+KkDQN9uEy53AGuuMDfJbDP6S/hgAEMYas=
Date: Tue, 9 Jan 2024 04:11:57 +0000
Message-ID: <SA1PR12MB7199E73CDBB9FA04E188638DB06A2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com> <87v884t4b4.fsf@pond.sub.org>
In-Reply-To: <87v884t4b4.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|DM6PR12MB4314:EE_
x-ms-office365-filtering-correlation-id: aac8e058-d5ef-402e-69d4-08dc10c91ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9R/FQB+j7A6jVujgCjmg1GBejMVV3a4DNiSEz5w4E/b1MVtxCQu/7x+Cuw/pFac99ubutBS317Rap3UXCOsley9MUssW5ezuP0AVp9vlP0COj29iKpGajcqxy7SGy81mV8O94Zf9ay6/7kK/caj7m7D1qsKA/yCVkP+SSo3RMDRA6Va0Jg90SGz8CxzFBUH868n0mES+ta/IuMWyGA5+OEq0Gxq6F2HEFMRkQtCv0UxD7B9MtJwuNE/ZhXd4cJFigJIFLh/7vUMX2VZhQrW/nOScZgV7IFR6+Pmv12C+0u8Eg1GP5gbxCwGYR18LaU5T1MExanAn7DwYWNm+B96IHaJlSlXAg2uANkUaB6H8saRN1YzvB3bWHVziefyOGoytTwq37DCsw9prP1RwvhhAiJoEMjShmB45qECD5QjlWFZBgKCca+1S4/dTPGLdw/QZLX0URFUU9ywZxcnO/7lKxzU8yMVGdn7/+ymh4SHM/1SbVn9iRki8U+E5AWlUUrd5r68F2zlVos1ZLDhOHXGyoZTCJU4YNciKcEkCVXt0tld54d5+rCbf/3f4Bo0v7homm4+d2V4eAtHJXj8tlM/eOFQA2qYBtZ+EOe2C4bsWiUEhNjgbmqWai0pQue5IcXP7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(76116006)(6916009)(66476007)(66946007)(64756008)(66446008)(66556008)(4744005)(2906002)(7416002)(5660300002)(316002)(8676002)(8936002)(4326008)(52536014)(54906003)(41300700001)(91956017)(478600001)(38100700002)(38070700009)(86362001)(33656002)(26005)(6506007)(9686003)(122000001)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HgOUvD9vhVHUL8FvCTB+94lklrPNiX8W4Er7nSiQKX9TaTcrE0kq4lB3Rs?=
 =?iso-8859-1?Q?fp5gEvjT2rgmd82R5JwANSYvNxYBuNpV8C5/ZAdn7KFxm+1J2y3S8R6Dj8?=
 =?iso-8859-1?Q?akNzUrmyZzLcrL0gsNg/dmL3+iG3ti6Ma0H2YPsnmL4Pdt4ddM4W3XiFFj?=
 =?iso-8859-1?Q?C0/w7XTFeTHfCyVmgv26pMqfcnKsYQduL4rz5RWCC2CxJSmNiKRPTGIXTt?=
 =?iso-8859-1?Q?TZMonaqguAiaSjWILbh9pVoDbFHjOZTkra6d1Q3uTw5uQsCXKMDvNs8BpY?=
 =?iso-8859-1?Q?jDX5DQOtPYdcEN5c7mF1MBluzDkmLZRSGmXg0Ql1mibl+uwjApnbxgX3oF?=
 =?iso-8859-1?Q?5ynIHZjlFQMkKAQOyd8ehbXkqHVBdJM4Zc7Pe8zhn3qR9WzhvaAxtHNMMH?=
 =?iso-8859-1?Q?FTNTlzBtfl/klai8bX7CR8gRh1YtjmXzGE4lE9/F5y4W/I8QXhQsPjehLP?=
 =?iso-8859-1?Q?jbX6B9FXuGdL7xeyzf9vJUHbswBBXiaEWfgzrZW6LzxMG1z9alSZT9w0AR?=
 =?iso-8859-1?Q?jBL9f1gL3r/HYv7tfuYCyHV6da335KmI9PkPdnB4Jz6bacEvivifKx17iq?=
 =?iso-8859-1?Q?wKjb/HtRvBUjpfsPvjOyYeyUjbXCAo5A6i2h7Zz3piE59nASub+9JAZqVW?=
 =?iso-8859-1?Q?fVAmFFQnxvg8KsipHWAbrS0ysOSWvQX3FiuDr+jpf7H7w2RVikh1JGhbcU?=
 =?iso-8859-1?Q?96Eww91KEyKHyJIfPWm0MQrpp5V5NewT4lnmnxCwY29brOM2Btm6E0FQYT?=
 =?iso-8859-1?Q?srPKl5dWrHCIAz4XuHoMYlee2b2qr2Kwy7CiBPMKVxUWSj3cuxCtORp9no?=
 =?iso-8859-1?Q?AwgO9cCYfgV4rcdgDpJjWOmfJCLyX4AEAiLhjNQyLvLN4EQh9wjf9TmPjD?=
 =?iso-8859-1?Q?MIWgVfNYPmD4EjfqZvOwkDz5ugvrU4KKPVOxNFHhEkIfr1UtJ599Xi/OcI?=
 =?iso-8859-1?Q?ZVdUJW3Hr5jF8altFjK7DuOkKHL4K9dCl+oMyosS0GbljlK6X0QY+J/lTW?=
 =?iso-8859-1?Q?F/MjdbK8t/o9JKxQQnx267JqoZOjJehwT5/h4Cw3oyhW75hNEpch6BOGFE?=
 =?iso-8859-1?Q?e2q/4FvfBXiOmRS1fPh6g8UpqWHxqlWZm4znuwUlZKKKdn+Tcq/obQPO0F?=
 =?iso-8859-1?Q?ygqBkCb521/Uulsp7763xzN4PAaflF1L2N36b+Lw7AJ5bkY6QZbID52fVT?=
 =?iso-8859-1?Q?eSepPJNWUnLUbVQsDXLSVu+IPEVF4+8IxGVYjonLtZ7d92bexOL0ni5fIB?=
 =?iso-8859-1?Q?q7Bll01jTZfB7CwjXgH8jJin4D7EfktlvvP/PB7jaGd57ZNe0eaP2AkcE+?=
 =?iso-8859-1?Q?Lvib8RUF4rlBW4utuPPjKvd9v87EnXjThfGBYrc42Spd72BvybZdB+fFg2?=
 =?iso-8859-1?Q?RDLvYgeR9dIMIRal0or1aeVhtoBwD4jNX41pfpjaw2w0zze9jCqJtbdy4B?=
 =?iso-8859-1?Q?/6nORtBbeISZy6JX3rLcn41ASdUlZ56xknuL8fSvrDrCzycnpLqnFGCg90?=
 =?iso-8859-1?Q?EO2mPDdI1kn0XPbeThJ3VFrUDArIilWiysjwEGgE9xm1wi6mnr9zxrxBxT?=
 =?iso-8859-1?Q?GljGSA6giSnM28NOdpxnuSaJ6A7CRT874OzhMgN4V7gsri+/aszFHP3k81?=
 =?iso-8859-1?Q?iCEQsvpzuQe2g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac8e058-d5ef-402e-69d4-08dc10c91ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 04:11:57.2341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVCUIZv5XwLiP1HbXkxcgADk3hUOLwfRdp5fv/KwXnV4EDOROganm/hNb/ahMWvuKaAuCcv+/i6mxNIWZvTpdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
Received-SPF: softfail client-ip=2a01:111:f400:7e88::624;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
>> +##=0A=
>> +# @AcpiGenericInitiatorProperties:=0A=
>> +#=0A=
>> +# Properties for acpi-generic-initiator objects.=0A=
>> +#=0A=
>> +# @pci-dev: PCI device ID to be associated with the node=0A=
>> +#=0A=
>> +# @host-nodes: numa node list associated with the PCI device.=0A=
>=0A=
> NUMA=0A=
>=0A=
> Suggest "list of NUMA nodes associated with ..."=0A=
=0A=
Ack, will make the change.=0A=
=0A=
>> @@ -981,6 +997,7 @@=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'id': 'str' },=0A=
>>=A0=A0=A0 'discriminator': 'qom-type',=0A=
>>=A0=A0=A0 'data': {=0A=
>> +=A0=A0=A0=A0=A0 'acpi-generic-initiator':=A0=A0=A0=A0 'AcpiGenericIniti=
atorProperties',=0A=
>>=A0=A0=A0=A0=A0=A0=A0 'authz-list':=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 'AuthZListProperties',=0A=
>>=A0=A0=A0=A0=A0=A0=A0 'authz-listfile':=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 'AuthZListFileProperties',=0A=
>>=A0=A0=A0=A0=A0=A0=A0 'authz-pam':=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 'AuthZPAMProperties',=0A=
>=0A=
> I'm holding my Acked-by until the interface design issues raised by=0A=
> Jason have been resolved.=0A=
=0A=
I suppose you meant Jonathan here?=

