Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94707727831
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 09:08:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q79jf-0006Nk-1g; Thu, 08 Jun 2023 03:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1q79jc-0006NM-Kr
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:07:04 -0400
Received: from mail-mw2nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::616]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1q79jZ-0003w4-Pj
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:07:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3gPtMfabsJAAGISuVmhFQJ+3NVB5iNQr3JD8k5W0odouWwwvleLwGUBv7BclnI7z3skEzEfzig12Zkf5bq+3h0NFqPeg6qoOFovxBSMJB83WLttRtRN42eK9Cj1//70zmifGCfwbBA1/hH39qhkueuSAXoIH5NxQX4pmzEDjGW6jgcY2d2p0uXIJ5o4FzXFPzOYllnHjNnFW4D+dzQ1R/UaBzr/qvGBdFd9Bx3QATL7SrrWKwbpcrHvk8fwt426UJ2/5R2hsqcEKYtij9yyzaM5XzPdqPv2mJdN6r4pXPFiE4IUg2cRidkZJ5IretOtQdJ6KcOip3N44tYd8TLjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4coUB961KUBDW+TwzRGeXmOkSZMYjTGe4/4ArywONo=;
 b=jvWTvPBqS5xPtEC2AKVhdQ5ipeSVU/gAKdaSUA5HksSexGsA/ojU3hgy8TTiKhV+gkfNvkG1rrH1B1jBqOz98lhhqqRJCnpp/kNBpyRShjmuYd9PMwMuJqAnYwCa8K/1/3pFwj9CfgxoTjjAfJo5hA64ZHfPYWSlTVuGYZqI/BT/ug8xe0fbhn3ft67XXu+D/cflVZylacNtSvU7hKxwws0krfCQKdIjfXZw8e8WnOaUwzJkixOhodw/pGIHX4aAUsUfGQYRjaX/W00wW7337xgD2STuLquAm+LxSh4JKZLqQ8RsvxTKjXpDVvrp0wR8yzY5s4nUfHsNaMtV8bKqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4coUB961KUBDW+TwzRGeXmOkSZMYjTGe4/4ArywONo=;
 b=u4G2d6Wwjl6q76AVRLjbDa7uVE1jBhzKsHNMnbFKiUa+wNfUGsARNqZDWDJI+7qc26hQS5LgWc15+gaGtwL+Al5jqpEvRYO6V9FO9+kWASkcT1zVHYTGorqb711VPHJPbsxBPzLq5ljunQ1UXz2ZWDnlndYqwYFstfdwYRk4bD0=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 07:06:55 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::4ef5:2244:743b:9989]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::4ef5:2244:743b:9989%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:06:54 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony.perard@citrix.com>, =?iso-8859-1?Q?Roger_Pau_Monn=E9?=
 <roger.pau@citrix.com>, Jan Beulich <jbeulich@suse.com>, Antonio Caggiano
 <antonio.caggiano@collabora.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Robert Beckett <bob.beckett@collabora.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
 <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
 <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>
Subject: Re: [QEMU PATCH 0/1]
Thread-Topic: [QEMU PATCH 0/1]
Thread-Index: AQHZmbUg+D/AFshzGkyCkFnupRc4g6+BASWA
Date: Thu, 8 Jun 2023 07:06:54 +0000
Message-ID: <BL1PR12MB5849FA0F7DF456E83F099926E750A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230608025655.1674357-1-Jiqian.Chen@amd.com>
In-Reply-To: <20230608025655.1674357-1-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA0PR12MB8254.namprd12.prod.outlook.com
 (15.20.6455.003)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SJ0PR12MB6928:EE_
x-ms-office365-filtering-correlation-id: c2803e9c-c8f6-4760-2126-08db67eef0fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIT3qmrUQVy9iWnNn/Q54K7TAhLbE4KPnegMwGsHQnVbPrkbGvBLlwe+qbGOljG6QcmZmgPMs4ilMWVLlvdrfdvjTWtIFgwO+Fi6nZx9U0yup2Q9sf+hRlVSZwpO2SO8TQpGAsfIMVqDtRiUr4MSdxB9DPuAOhUa0A12uPtoEgG3OO8ClB8LsDDz3IwjSeiwUbNMSbmTZRUHK8fSWXiOeQBgw9RocCkjDnweET5O6E09hzO/1hWoHMWFmH4D7qp6tLI85FxfKaArhPxQnc50zrAQTbhP0yBzpisOUQn3ezlTxOyLiSxeoeZ0JfWZFZGYLZrVj4HvmaHwL/YbV4e8y61B/At1+pxsXCefo4OEMrbMk1pqqXrY3wqbeyc9VhMHFXXbmUhVetnXa5FDwnLd2a4p6vTosN1aZJKRNjjnafckvzCdU+RvqIEVZ7KMtbIbXxv9oZF2IhHUAkjEwECOljJSqN3cih+1kOqnKDjn3XL61GmNWcD0engq/AFpxuE0bplzSyF4zgvVkT7BhI/RXvU+nE2uwqNpEi62UCcTBTsqfE5+CKkslnc0Jk8gZqnDQE21f4Y9Cm7ACmA92V4zW6mDVsUTPZgXFk7/nfEYdIj1tJY8YlWI2tgk0XECa8i1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6506007)(53546011)(9686003)(186003)(966005)(26005)(7696005)(71200400001)(122000001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(921005)(4326008)(478600001)(83380400001)(38070700005)(8936002)(8676002)(33656002)(5660300002)(52536014)(55016003)(38100700002)(110136005)(54906003)(316002)(7416002)(41300700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eWX2xNZh3ZMuZXr+hX1h8psWEvubwBITOCF2LFVg6Q2uiflOz7Y9k8pLh9?=
 =?iso-8859-1?Q?vx8hdWs0vvvUPKDAdYS0Q2Zh0r+VUYRP+LisfCXd9U3ZVnuK+Wi6480mKb?=
 =?iso-8859-1?Q?ex5wH0lgu0Nyj75X+5XHfG3fgWPenD46OYY/T38MEU9aAhBYnZZC1XikNp?=
 =?iso-8859-1?Q?ikOH7jeNobF/+58Jl5N5mJn+4d1GCqyW7ErZv0W4ZUlTwNM+suRzIWHaJH?=
 =?iso-8859-1?Q?wniULysOlITxj04ijcgniML79//Lnl2vXnoOk6sHIBZX13qji0GDqGZ6GT?=
 =?iso-8859-1?Q?IgiVHeweGr+v4Xyv+5kuteecIJhDMsCFMbeNcLh5OtL61eKcLR4gtaAOKk?=
 =?iso-8859-1?Q?V5lNe2IG+Ftm/y/VW37nZdorEgo5RhjEt2Hb2XQQEHZ5ki+RY6mMdCeT+z?=
 =?iso-8859-1?Q?XPZ9PQ5xtSgjULa//oCEBoTrQdqfgFZEQbhNXYaYZgdl7WoEMq9/T7Eb5W?=
 =?iso-8859-1?Q?LyD98eWMi/w24QK6DMid+gvIkCqMUo6tur+2rPS7UG48iaaEm3p0zfTWYp?=
 =?iso-8859-1?Q?HsXvg9yRefd5AXHeFqdUVgDOUrelQ4V8GgQYU1dQPxACNZz66M0mg5SXhf?=
 =?iso-8859-1?Q?Shf9C+KTfk9HzlCGCSD73XWlkTMsgTLJgRawpuDx7cveaDN9vMYq3ttluj?=
 =?iso-8859-1?Q?Ucr9mcoQlFCDLrHq+FxPqQTWu7+mG8iQs8WuuRusWhp9oVBXPpFtj69+10?=
 =?iso-8859-1?Q?l+/0um4brqIUmBKZZ5+BMft6CqRLzKr74GfmQoZK8Njd7mcZ/ctfKLHigZ?=
 =?iso-8859-1?Q?hmx8ksMoUIcIaD+pUyvYvLW4vxOlrvbPRWia6DTvg1Lm+/OlPit4P4F27p?=
 =?iso-8859-1?Q?66m3I/cij4W1s1P7XcLUmcfdPHtIycOXaPOqot6zohE2orDilPsNOCqrlk?=
 =?iso-8859-1?Q?O9mg1zBw+Wgr8pPhIn+2z7YwpwDbKLqcTweyCCZsNJV4VcqKQQz2jub0zW?=
 =?iso-8859-1?Q?1Ghr/uiSfu7Oc+P5SO+JLBJ5kSFp4W2qXOklF+xYJ6byIy1EC4J7+vxdRO?=
 =?iso-8859-1?Q?TMbPQNXbviANovKKqz0WBKARU5QD2pbQJDJ9iYm0ay3f6y2dKOgdEW0HpF?=
 =?iso-8859-1?Q?zZKFHpwYl01+gpp9fHIhIaGWnHUF3LRCXIZXzBn4/a9n+CB59KZkGmWHz3?=
 =?iso-8859-1?Q?zrcbuqYtgetv/uuxMEf3AerVdqn5sDLuEJtvrj2QxWbf1R0dU2vcRcTYp3?=
 =?iso-8859-1?Q?kbViZxjy14tIUhVvW5GkvTOW8QKhb0nb0DcyqQmlJP3YE/NNJCnFeGiWvp?=
 =?iso-8859-1?Q?0T/qO3Dr4xH66ozdmHNLmjWLXo3m29flKR/R7Xu0iZTR6ps/vZb62TNfk0?=
 =?iso-8859-1?Q?/DZYUOEe7rj/U6yg51a9WoEQyDAXhIoL4K2YnAvH2UyMJK08saO/Bjjjqf?=
 =?iso-8859-1?Q?vI1+Y+gz9As/y00QsMDisyWOTdZtagfnojs1qCzaryEuphvvl7dVPX1u88?=
 =?iso-8859-1?Q?1PHLwpxVl6i8ui7UFVjEDjj/QZqhQKq+D8rlnTooGxuQhVbHofPYBZfLyl?=
 =?iso-8859-1?Q?SKSKsWR/nnob00VuLo67Kp3+n+3Iu8LBwbNH+RyWNWUgrkpd7dE8CYjXoC?=
 =?iso-8859-1?Q?Id0J3E7GsBMTuBCwrPxRy2q2iK8/4L6Zlc36orv5P2Nnj+EkFbu2UqSoV5?=
 =?iso-8859-1?Q?MrZ2FgXQx7Cvc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1B7724F9128152459879568A95F8D6D0@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2803e9c-c8f6-4760-2126-08db67eef0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:06:54.5761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnPAO6fvvHx8MmzYRpLGOZuN/pkymc14ogBljB8vU7+IFn1oON2XPao4mb6Qfi3yOV/NzKuRZbwMWvMlR80ZxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
Received-SPF: softfail client-ip=2a01:111:f400:7e89::616;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, SUBJ_ALL_CAPS=0.5,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi all,

Modifications on kernel end is:
https://lore.kernel.org/lkml/20230608063857.1677973-2-Jiqian.Chen@amd.com/T=
/#u


On 2023/6/8 10:56, Jiqian Chen wrote:
> Hi all,
>=20
> I am working to implement virtgpu S3 function on Xen.
>=20
> Currently on Xen, if we start a guest who enables virtgpu, and then
> run "echo mem > /sys/power/state" to suspend guest. And run
> "sudo xl trigger <guest id> s3resume" to resume guest. We can find that
> the guest kernel comes back, but the display doesn't. It just shown a
> black screen.
>=20
> Through reading codes, I founded that when guest was during suspending,
> it called into Qemu to call virtio_gpu_gl_reset. In virtio_gpu_gl_reset,
> it destroyed all resources and reset renderer. This made the display
> gone after guest resumed.
>=20
> I think we should keep resources or prevent they being destroyed when
> guest is suspending. So, I add a new status named freezing to virtgpu,
> and add a new ctrl message VIRTIO_GPU_CMD_STATUS_FREEZING to get
> notification from guest. If freezing is set to true, and then Qemu will
> realize that guest is suspending, it will not destroy resources and will
> not reset renderer. If freezing is set to false, Qemu will do its origin
> actions, and has no other impaction.
>=20
> And now, display can come back and applications can continue their
> status after guest resumes.
>=20
> Jiqian Chen (1):
>   virtgpu: do not destroy resources when guest suspend
>=20
>  hw/display/virtio-gpu-gl.c                  |  9 ++++++-
>  hw/display/virtio-gpu-virgl.c               |  3 +++
>  hw/display/virtio-gpu.c                     | 26 +++++++++++++++++++--
>  include/hw/virtio/virtio-gpu.h              |  3 +++
>  include/standard-headers/linux/virtio_gpu.h |  9 +++++++
>  5 files changed, 47 insertions(+), 3 deletions(-)
>=20

--=20
Best regards,
Chen, Jiqian.

