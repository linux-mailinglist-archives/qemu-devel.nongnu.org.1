Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9B7C837C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFeQ-0000RV-S8; Fri, 13 Oct 2023 06:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qrFeN-0000HA-Vd; Fri, 13 Oct 2023 06:44:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qrFeL-0006CP-Ez; Fri, 13 Oct 2023 06:44:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D7O7Si026000; Fri, 13 Oct 2023 10:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QIVmCvuV7aqeHxwM4wSgPSreghIdXrfZ4z6nVAF78vc=;
 b=uI6ClD7QRL38vCpY4lD5zfyTlaV2NQ6LZckuhJ8km7MAKnl7W+fgb0NgIVCtWZH4KMvL
 Dba+QKIrK6X4cQbftQiHqHWKo/ESXk2lBhxje4XEesk47wCl1aL6bD1fIl4oyC0Gc/9w
 ir9RwlguhsQnz4BBy0sjwUiSU4dFA5hdER6PWkk9mPuVxWVJifhTfsIdgrHSb3FLHdX5
 /zZcjok+hXqbXSJdDYx1W2GtkSoYYvCulMA5cWUsxeo2tkRChcR7dBGQI6LEozv9B8wY
 N7Aib/0GA+XgKh61oSloowBOw8jhMEEoPUcBKedpg3LIW6OG73VxBd8Jr27AzGY2dmRO Hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43vs14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 10:43:37 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39D8IpDJ020619; Fri, 13 Oct 2023 10:43:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tptcjd85w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 10:43:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbgkgJKAVGjSp6oe5Xc/+CFyQfM2nyD6BxlKJrYOEoMCC6d4s54dZ+mXl3ya1qiQHgUupoGlDE07YFooJsQk55heOTIztKe+7boAhDw0+BPA7cm+qDJLX5y5Gqf2/RxCF57SZAWxG+XvbbG0Ebx8C3EkYU9iO/WBRt/JEB/woDZuk36BszO26I5f7XSxCN9UtC+T3gES9GRMHLL886a6wL5mwC5FPiAWj3YMoR4rwMNs424t60TymfnNInxky1vFt5WiGbjXqRXxCUwxr1ktAO1HkJwmu5pZwkSBHntirRrAR5JL8GZm1cAbYTHEr+akPVVEOR/5ANDq57nsKphQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIVmCvuV7aqeHxwM4wSgPSreghIdXrfZ4z6nVAF78vc=;
 b=FfgSQawF9r4Cz/5RXqAydN8vIYjjkZC2fEzOnSUpu9m2UrCjKLlkjiGts31H4+sqsk6V0W1+/3+1Mx/Q8b+8YoV/51bwfwt9diPmd6f6VfIoSGVKFT/iYI9OXzbzpSCLDlFgUfZrhJv8l/JAJa/h12+PEy1LkXYFMpvEFnYwwQz7H8dFhnkBfuykyP1TUVXASRdgsU5q6sFM0Khmfm4yja1jiQUOMKKPtJlQBytJGhJiPlBgsoxxJFscD9Xcc/oxdN19s0i9MK0LTrvFdLuRr+D2tTJKgtd/PB/0Q4yglp9C+t2YohnnI2R9ItNs0eaEHx9I5en4BnU2fEGtG+ECzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIVmCvuV7aqeHxwM4wSgPSreghIdXrfZ4z6nVAF78vc=;
 b=d/HD83G3GfeZMQkQslR/oS04ivxZ5v6LsnEG4/FhpZRzwi8U2IR8ggefEPAJBKL2kKXlkRY2Q9cBpDv4z9TiNp9813ziv4xBmHdBjc50juFG0ZoX1CvpF94eRIVTCYB4cJ7pkcF9NGj2KpkaOcGPEC8kXQ1q8AlbPRAawLEou74=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 10:43:33 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 10:43:33 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Salil Mehta <salil.mehta@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Marc Zyngier <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8
 Arch
Thread-Index: AQHZ8GD/mpuWvUZiHkqygTcKHwiwNbBGeuYAgAAOuICAARnQAA==
Date: Fri, 13 Oct 2023 10:43:33 +0000
Message-ID: <B7333DFE-3A70-47E4-8024-4EBF2D410D93@oracle.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <BBD0C802-A71B-473E-A7E3-FDA5D0674D49@oracle.com>
 <3b1e102f20be420eb43d394d713e81f9@huawei.com>
In-Reply-To: <3b1e102f20be420eb43d394d713e81f9@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|BN0PR10MB4822:EE_
x-ms-office365-filtering-correlation-id: f32cb252-48cb-4cb5-ca38-08dbcbd93f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QmReCAJ/B21QNND46Mk6AmSk9fVo/cPntlxzKwELoHnvemOktrdS3gIlrvf/7/ELjfwsYziTe/CY/4e+8a0SW7hBouXTgVLyWhi2f3/xKu+909F/OURe8unB6N/sJTwxUEC4fhBzWS0ieAOdmSAIepiPIs1s91qCwPQ+eNmKe13F4LYmgmqAgAMzQFZTYig8wHjPNOcQk7xheJx9BOYAfNniI/Zc1KmXc6T2fiupzikqjGsdcCygWdU6OVkrVvfoohpNWo+LmcmXBMdpNb0FSR0Y0ZwHkCebaN+vfokbqwSdZ0+y4gbXILsr/fbq5F2NbJQOMHFKaQRB42An/+rwpXjwLZj1lfflFSIzrNYLAfPyoH5bYIYnuR7Jmh/FVP89HAmzufWnSvUpo/k89vO5Ozt+/fZprKN3/pNjM3GK28yH9A+J+nsbCImi3mY8nNqdMzHJTTzDvEcQKyiZ2W1RGiMb2qhKniTQ39oEL10NymjCQErkAWX6CYyHxmnKVFG9S34M17sd7MUARgpqI+or+OWqJXrj5FnX4hM+OUIGgTS8ccGH6/21/4oorBVzlPhMsFSWun03UILuR1IkxtEy6ArKzCqnbcwQ28bojTJX1foOkHJ47Ty39qoxDlG+nW4AjeNueFobccqJ2x5PqW9IhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(71200400001)(6512007)(6506007)(53546011)(478600001)(6486002)(2616005)(316002)(2906002)(7416002)(7406005)(6916009)(41300700001)(54906003)(64756008)(91956017)(66446008)(76116006)(5660300002)(66476007)(44832011)(4326008)(66946007)(66556008)(8676002)(8936002)(36756003)(33656002)(86362001)(38070700005)(38100700002)(122000001)(66899024)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xgN62b6GyO2Q/tBkThs+w7ieoLyeNJ1G63HTnSLzWzVgEFOY7iz+Re9P7+Mi?=
 =?us-ascii?Q?6skmZAbG/FFS/igIvQvJTlHRf15BVU3DUfsEtmeoZsdLaJjPghfjj7Qlc8P6?=
 =?us-ascii?Q?CbWMJcD3pufE0MIEerQ714bDEJ3MXb49i9FwMdy4699ROwelPhSzhX90D2D8?=
 =?us-ascii?Q?ckbwsEHnDMaAvO5IHgdo7UNN2t4Md5O+pT10IJq9G5gB947NSXrgo79soEUg?=
 =?us-ascii?Q?VCcWAOmED0OiX1HENaRl9/ciwUHzaK7TuZFhEPZx/7k+JU4ZnVjSqmuKEUBB?=
 =?us-ascii?Q?Mj3J9+LwqTAl6DcLv29L8x9anjjlySjH47/Hdns6qMnHMzUrkg5WV8Ue5eka?=
 =?us-ascii?Q?c+BmnZ+XI5VWqK8mL58Np20mvguumBZtYySvQu32OQnOXBv2eF/GUo9qCnF0?=
 =?us-ascii?Q?kVUF/YDALiCWF2YsL+5etHfXXyLZAXhHgnr5V1r3WG1w2Du+f47w5mvBL1jd?=
 =?us-ascii?Q?+vIgQ2mX9nS6xFYudACQ4uWIvWo1r1z85+LFVVvuNYIW0KFMnym451kUnfAc?=
 =?us-ascii?Q?V15PA/tveyUysG+6cmTn/zv6ihdVoo9AULYVxgizAOuRxK0QxBC6Sl6WRuoq?=
 =?us-ascii?Q?ZMLrQm6p8tnQJqlZDuRxHeHz4pQhp6SGtEQmFSo2jJ2plbeqx0Jrr7NXqi5e?=
 =?us-ascii?Q?lk4K5Fb4GNxE6IEfE3XuxWcw8DqAkIf1ceirmLBj2WpSIPvqCJYD2CDFB26h?=
 =?us-ascii?Q?7ja4EJOG0DYGcmamRSdem48l+JpXzEKnMMiNgu+5EVCDbhGCypE2Er7FkwGH?=
 =?us-ascii?Q?im7Fl9jNzveKqg0kd2AimAXc6h9ZXQvyKWLeCuvmFHB98JjYIm1jfQ312ALy?=
 =?us-ascii?Q?2uRB/DdhQJr8o6vPTk3jnNPPWzfCOAzt1lb2d7St6LeU3WPaqxS7vccfIauZ?=
 =?us-ascii?Q?GHwCkSXgXNZyzBgX8xlfI8gboqZR7Y6At1jMZRH13xr4fL/ihAJLGMdSDJeL?=
 =?us-ascii?Q?TIYjuC/Fnynj+hM+pD6xTBrpnbt0DpV7C6ViaRftzpvhavqOTIqXi6MUqid3?=
 =?us-ascii?Q?Nps3wNIPyQ8m6x1pKwT3ZAwNyPyAH9kEnKc87rcK3/Ejnc7WkWg5x6CCyolX?=
 =?us-ascii?Q?ozT0IoLOQB+nJp+3N2RQUeR4F76ww7f6TUzbrO3TZB/iX1eA3Yr3Dcc7W4eN?=
 =?us-ascii?Q?r6VMdY+4BSbDcUPlaG4Hjpv1ESwqLkhOuYERWu2dcgk6qGKKWsnhBOxO453g?=
 =?us-ascii?Q?h5j0tAq4UlMGoST9nWoICpGrI+BbxsVMrgzK0mbGsOxdgSLlXjG2fNBFsxAJ?=
 =?us-ascii?Q?MSbVLSAELwqGZqcSx+Fu0vPtzTXouBTytFTEiMIDwk2xQ5IiR3H4i7xNRW0D?=
 =?us-ascii?Q?AI5x9Ggjfl71rVyeZnTwiInnLlDH/HS0B+Z5jPs0n5fUMkFZhiexQJniCmgu?=
 =?us-ascii?Q?yBRHt03VXWoJlpg6DcKaHHYjKCu6MHoP5mZioLfKcLQWXpXR46TspdVQ6tDN?=
 =?us-ascii?Q?0A1xA5z3xfvostK5VTQxo7QUDj6z2MVNwnTlTy5RGFzMDXcZkIDBjC1libfN?=
 =?us-ascii?Q?tB3util+EUUYkwjnGRPX0WZLTI8axphuABbWOIhd9d9ibBzCjl1Bmxs6YusW?=
 =?us-ascii?Q?Lbqc8LtsjpH8t9wnSQkwMiiiZe5aGlFK3k4Jvc7YLhO96QeWdksAhvRRHW8t?=
 =?us-ascii?Q?6lFZ835AXwHJgq6ti+V6V1I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD14DD015D526F478A31C1A616E58B87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jYSjW0gYrfZqyQqz5f+9A1WEPFkd/YlaF5uu11lc63nqHS5OeX9GkOQAE7yj?=
 =?us-ascii?Q?lBEbIXPKyD9+OyypzCRRXlGhjXEahpoaQO89uc9F/jQjNJoEMa67N3LB+P78?=
 =?us-ascii?Q?YMm00DabdsU9TvsQGbaQo2q4Dtk8lzqrXTf7Nvsj2WU6JX8pJkLdD37DDWLU?=
 =?us-ascii?Q?gBEpysEb0h4kIDvGLaxLsnCm3TlFQ+oDd536I76451THfN594hic0oB+dqyx?=
 =?us-ascii?Q?d+tc1+Ug9nplWootxKBq9rDcYaAxmpOYI44OOkh53iLJ7qNhz3uagJnEDLP1?=
 =?us-ascii?Q?2RC16zbZrRXKeo6IP5gzoW8xAQ06n4BXyay2cE2ndLAFLf+8XZaXj7Anvlpg?=
 =?us-ascii?Q?N8MJ+m/itqsm16KqoM50ivzlNlE1Ab39QQgbtPS94Hu0RVlqNe1o2pKdiAMQ?=
 =?us-ascii?Q?O1h0UvTujvUavSz6gbDPrHXl951vCRZ5jL5+YeliFY2H4XprhE6zNycWHpM9?=
 =?us-ascii?Q?xLLQowmxAVxOKJ2c94IiH3r46Buqb61eisxMdW4jRmIU49Oz87yhbAmCqucz?=
 =?us-ascii?Q?igQ4DFyUdOq81/ihSAk3sawGiW7S3c5hhxxRTPntcE/fTJmtBVveDdvlY38B?=
 =?us-ascii?Q?ZcO2PDdIHIwN0vC3vU34L1TBAHBh4ziJ5oVIm28x7Ti4ed3nlr0NDu9zCr1V?=
 =?us-ascii?Q?EegMj78CpRDi2idfweZnrtYHc88HSnVmv0UM6Nn8g7SdSjUISf/s9wdW5l+n?=
 =?us-ascii?Q?a/9MqqhcHa+z/kWbEJTWiSHbmnZIsM7DtuwJsjrjnAXBJh62BMDDLIanRbNk?=
 =?us-ascii?Q?hEvic3egUB9RO8VzZ+nloWTuCDs2Sh+GqIhdbEFYR5tUoqY6A3rp9YIfFco9?=
 =?us-ascii?Q?ZET9+C01UC9q/9MZ9xQ7G16QTOjhR52nAMGM0/Lc/XsuwMvjvfvFcOn//EuB?=
 =?us-ascii?Q?iUUaGEDj/BsZ+ztwO9KaSIgkvHJJJ0hbmM8/e9VQq03IlW/uCVZZUBaPffKR?=
 =?us-ascii?Q?6srUcCkQlXHY30rIY4fv4RE6CtL+H0vTZtURJTxH2pg/m1MpYtWGJk2sY/51?=
 =?us-ascii?Q?CYydfeKvWWmAbDetZiQn6ws9Hg6LyB2mqOG62/GV5yRgJvARs6PffNpI2SIT?=
 =?us-ascii?Q?zXL4IfwEdkA8f06TVAOZhVGWcwyINrAAxiBYQet0rOUWszQ6LVnYxfrpYlnb?=
 =?us-ascii?Q?OyBXTBkWAIIH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32cb252-48cb-4cb5-ca38-08dbcbd93f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 10:43:33.4697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bh4ozj608xaOBmDuOlmMY8WpG0c1UnSTjoJA6gdoIZ9/NTn54Gyq9tOVT2eYgeI0zxTPn+/7gBfddYXxxUJK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130088
X-Proofpoint-ORIG-GUID: JXGKCQnJqYd4RI6PT5mPyKGpumI7lypd
X-Proofpoint-GUID: JXGKCQnJqYd4RI6PT5mPyKGpumI7lypd
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Salil,

> On 12 Oct 2023, at 17:54, Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> Hi Miguel,
>=20
>> From: Miguel Luis <miguel.luis@oracle.com>
>> Sent: Thursday, October 12, 2023 6:02 PM
>> To: Salil Mehta <salil.mehta@huawei.com>
>> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Marc Zyngier
>> <maz@kernel.org>; jean-philippe@linaro.org; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; lpieralisi@kernel.org; Peter Maydell
>> <peter.maydell@linaro.org>; Richard Henderson
>> <richard.henderson@linaro.org>; imammedo@redhat.com;
>> andrew.jones@linux.dev; david@redhat.com; philmd@linaro.org;
>> eric.auger@redhat.com; will@kernel.org; ardb@kernel.org;
>> oliver.upton@linux.dev; pbonzini@redhat.com; mst@redhat.com;
>> gshan@redhat.com; rafael@kernel.org; borntraeger@linux.ibm.com;
>> alex.bennee@linaro.org; linux@armlinux.org.uk;
>> darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
>> vishnu@os.amperecomputing.com; Karl Heubaum <karl.heubaum@oracle.com>;
>> salil.mehta@opnsrc.net; zhukeqian <zhukeqian1@huawei.com>; wangxiongfeng
>> (C) <wangxiongfeng2@huawei.com>; wangyanan (Y) <wangyanan55@huawei.com>;
>> jiakernel2@gmail.com; maobibo@loongson.cn; lixianglai@loongson.cn
>> Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARM=
v8
>> Arch
>>=20
>> Hi Salil,
>>=20
>>> On 26 Sep 2023, at 10:03, Salil Mehta <salil.mehta@huawei.com> wrote:
>>>=20
>>> [ *REPEAT: Sent patches got held at internal server yesterday* ]
>>>=20
>>> PROLOGUE
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [...]
>=20
>=20
>> Tested on Oracle platforms with Ampere processors.
>> vCPU hotplug/unplug features along VM live migration.
>>=20
>> Please feel free to add,
>> Tested-by: Miguel Luis <miguel.luis@oracle.com>
>=20
> This is a great help.
>=20
> Many thanks for your persistent efforts in the past few months.
> It has really helped in expediting fixes, reducing many major
> bugs and also helping in TCG part. Really appreciate it!
>=20

You are welcome!

Likewise, really appreciate you driving this forward and being
open to suggestions. Makes it easy to collaborate while
helping the community coming together.

> Will look forward to collaborate to fix the TCG part next.
>=20

That is great! Looking forward to it.

Cheers
Miguel

> Cheers
> Salil.
>=20
>=20


