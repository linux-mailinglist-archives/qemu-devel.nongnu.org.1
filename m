Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E187C8B7D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrL7V-0005bg-ID; Fri, 13 Oct 2023 12:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qrL7T-0005av-8D; Fri, 13 Oct 2023 12:34:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1qrL7P-00060R-MZ; Fri, 13 Oct 2023 12:34:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DE0pd7008991; Fri, 13 Oct 2023 16:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=y1Cn7H21DevrS9F9ETBWxG81Lef8qu/V2cjqx7FN43s=;
 b=rkmqJSsgf0ZqNKY1tRVMKGd9VbIEyhSAQTe/Ka30G1ZD768Evy5ovGp3y/rnWCbbVb3q
 5bnA0RjY+FNQYtEDCdZExLrXO+p4XL0W+Y9Xz2sOzRlZMYFlbuojb25NLTiFyLEJcUVM
 h7oghecghP7d8USVkb8+uhPg7CckAwuyQlLf+rb4o4OGtbfhrraT/feZLwVLFoEVpUA0
 a1dsOpEihDreQ+fGHdsIf15M0upp0Xqaskh6kmYPawwU8hNaTqr5gDKuUcQtWRLqGbU9
 A3F1ow8CG7xK/E1gV93gj3mD7YXi1OIqtrRyWMGF/2bUoz4m3IzxDtXZWNzWnvVmEiZ+ Hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxudday-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 16:34:05 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39DFHIbn040154; Fri, 13 Oct 2023 16:34:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tpteau2sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 16:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXMc9FOGCVWjxn6M5VoHWpsJKBQUrFeID5olRuSeFTDfYeuxN7HNcZJuSepC0MLnxAfzRdppu7Vz39WG4V1fqXFXKXOb7STnXpUtN3fPyA1bFrCQ+o20KAFIrMEXLPDc4G7wxquxUZYn5sZkBj6lIaagUqt/lV00+cNFor2K2vZKpcZnbp0vE4k7xeGKkJ7LUGd24QM08HRp/9qCflP94uWxnpDoe9C/3QXy25CxXjo3cXv7O4ga0tDqmn9JGxoNxx3D8DeCpsIscS7vnDFUgogaPHwrrn+x/fGskO7Ke9+cpNgDjO2901Tvd0a3JWBIRDAs3PmDpjoVaWuM2Yih8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1Cn7H21DevrS9F9ETBWxG81Lef8qu/V2cjqx7FN43s=;
 b=iq6y6NdFaet+iu9tbA2ukUg9Jjh1RX0+1w+eazLPjajP/RShbXyGjwWofqY/hS4Gve3kI8a/PPFKGx8RhYNk1YQlexcVU6maeXZyZx5XgHAveTqMa0JZjQmIvO0RtoVCxmkwuPVEMQh5BRPkGcsdoWJYI5d7Da+MhI0fpoiJkzq2fBlXK6iWKB7iX3ERCwQSxdfyeEiT8wldq4aCtkttISnSqSz1aLsviGvToMpOEUwoteN2Uu6FtSCOxNJ/chqPx7i/7OSJ5P0t0r9/+IOASrzTi0BFmf9OYULFnomSZnULXuo4yVUKbhKoMkglA+HlPgRuut3sGlXgv4D4ScryEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1Cn7H21DevrS9F9ETBWxG81Lef8qu/V2cjqx7FN43s=;
 b=SuCOVV+2tj1nW8uWMLhItXp3eRVziD9Env2LgyFPXtrTp5wzDriTZozgdL2gKM5k1YFekjMmTlBFr0AzSMhDniZGxmlZWqbAjIOxCYSDLf0Msb/EUljF7Hrk1Kgd26z0GERzOVK6wNGCOXYe4fHLT85vjolmTczM1ct7ozRlMU0=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB7717.namprd10.prod.outlook.com (2603:10b6:510:308::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:33:56 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 16:33:56 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Salil Mehta <salil.mehta@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Marc Zyngier <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, Peter Maydell
 <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, "zhukeqian1@huawei.com"
 <zhukeqian1@huawei.com>, "wangxiongfeng2@huawei.com"
 <wangxiongfeng2@huawei.com>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHZ/cNWJqm/pSxZvkeMuMYpUSehELBH6oqA
Date: Fri, 13 Oct 2023 16:33:56 +0000
Message-ID: <4764CF47-47CA-4685-805C-BBE6310BE164@oracle.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
In-Reply-To: <20231013105129.25648-1-salil.mehta@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH7PR10MB7717:EE_
x-ms-office365-filtering-correlation-id: 4472f6d4-744c-414e-5788-08dbcc0a3200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9tZ+E8GZ3DB0jV0Gi/x7FfeivekSBelJoVant5udUsdgWhB8LEKMx0/pSHSljzsp2WQo0jbeXhaabxzQFqV9NpPs26EjmHbdg2Dnm3kXJD48k3cmn0AnbOKQNkMmc1rVX/rKfhx0cOObnoGvzkrJCxWdiHQ6YqUZocVFd4PNX7C/mFnuJyoh6N6NCb3OrbkgnLyXSV1vgDUmf66m4cGbEFFVUWhGOeVApTJmDzbOoDB4lYAL6SQm+GBftKEzaNkVBVrHFAYjEAumB3Mi21GQF7r2ukoLja3+EsBk0CJme8oBszdXRKq0CK27ab7J11XBRCUhJbF1TgqejWK082BiYZWH5MLyvu/XWvduscfAM043O/LfP3+2kW7k+RqikSx2CkL9G8T0KqrK6CMgltF5u7mJajxBoXH2PmxzrF2AhMrGIksLmW3K9C1hv5W6KuqDhp8Z+nvykDTf6+H1Qf876jf/sVbjYnMw3GTG31mNIXfETKwS8Av42+Y9uaI4zY7dpExBi/ZE4r968r8iy7kT/Iynou7duEck/jyB0tzIc4KKP/hTVAraQ+GYI7AKSAfzAn5UDL926uFX3uAtNTTLbPyw/R1MqfN8x3obx8T7SMA5dBqbM/grYaLhfpHD7L8LswkKq8/egFEYfVWz3kA0RAZWojwWrcgdFjWGg+Igc5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(4326008)(8936002)(8676002)(6506007)(53546011)(54906003)(76116006)(66946007)(64756008)(6512007)(66446008)(316002)(6916009)(66556008)(38100700002)(66476007)(5660300002)(71200400001)(44832011)(2616005)(478600001)(966005)(91956017)(41300700001)(6486002)(66574015)(2906002)(38070700005)(83380400001)(36756003)(122000001)(7406005)(7416002)(33656002)(86362001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THFlbkgwb1dxRGhuRkoyMnFXMjlUUXF3dXZkK2h0b1h1YlZjbmN1MmIrMity?=
 =?utf-8?B?UWw4NVdTUmNOVjlITml1bFVjYjlmQzRqSnZ1bGZkSURXOTVRK2RndThXT3Q2?=
 =?utf-8?B?WlM5ZXhIamE1Mm1yUWVOcGRVeWh6empid3lTb2MyanIxYVZtdE5QUEl3UjBh?=
 =?utf-8?B?OGdjQUd0MU9EaHBaVGYySmgxckRoNXY0OHlPRVN0MzVaWHB4OVlybG9Velhl?=
 =?utf-8?B?YVdJRCsvWWRWWk43ME9JNTVYdzdxaDVmVXlyeUJtWExEM0s0dis0UXp3NmVM?=
 =?utf-8?B?U0ZLQ0tIcUVXV3JkM2VJSUpFMWcxYnAzZ2tSSjhrR0c3U213M1h2YzBKbWVh?=
 =?utf-8?B?MGhCK2FKWGpTcVVHbUJtcDM1VDNQaWY0TWh0Y0FrL2kwSitlU2FvN3dEL1NW?=
 =?utf-8?B?dGpYbCtJT29xam5ZM3dmRWxOUTVObjUrdWdDM3I2bHphUDJSQkJuWEVFeGZQ?=
 =?utf-8?B?aFVETDhyTWxKaWI2cE9iYzVvN0NMS1V0dE5xSXNiN1ZXZllsOTdoT2RRbVVC?=
 =?utf-8?B?VFptK1RQOXZlMDcwOUxtMjNKY2dMRkRCZExOT0YrUmFhQnpDTVlKNitmNVFC?=
 =?utf-8?B?Q25xUlVQTEdjMmQxclVwSzJ3RGhsZktEUmdDcEtwMEY1T1JMKzB6NzR5MXVU?=
 =?utf-8?B?WE5ETVl0QndHdFZhem1zRmVsTXZ2SU8ybXgwZWNTYnR4TlQvR1RWN2tpVzZL?=
 =?utf-8?B?ZEJoeHZCSjBxaWNRMXc0YXExUWRJSXBwMGhRR1dLUW14Rit1b1pSQStmL0dk?=
 =?utf-8?B?ektmWmdWNE1RRjFPZm1vMXdKTTZjYmw4VUEwZWlXSldjNkIzUTFZRVFRa0po?=
 =?utf-8?B?ZnBNdEhzd2NLb0plaTczMml0MU5SWHBDVzhQU1JPTndWNGxZQVhmU2V2VVh4?=
 =?utf-8?B?a0lTWXZ5M0VVdnAzWVY1NkNOMUhjdjZtNFlmdERPUGhBQWhXeWpqNlMvbTNS?=
 =?utf-8?B?WmhGK05Dc1FWTHBlVTRLdHRGcWJaRkhzMFYxUTRwbElKWFY4SExpUmVYK3la?=
 =?utf-8?B?czA5dWVYMGxDSlh4bUp1RTRBcVpsUno1R0JwYmtLRklobjdSZ0llUXhFazM2?=
 =?utf-8?B?Lzd6NDQ2MVQwZzNySkhZdy82VTVQSjB5SFMrblNvSGd2VU5RUFlaRng3cHFO?=
 =?utf-8?B?NVp4OVQ4MFJqenljWEZLdThNTHRkMDB1NjhlMGpGSjFTdWgvSDgyUXlFd1BZ?=
 =?utf-8?B?NFVzNHhWUmluQTFlK0VpdHhwaU4veHYvUjBySnZFNVFxZDJjT0p4Z3NmR1pB?=
 =?utf-8?B?VlU3SVkwOUpUQ3dlTk1uSW9mTEMzc3FPbnF3d1lmT3phaVNwOXQ3TUNtUFZz?=
 =?utf-8?B?OXU1T3NWU2RvdW1nd0V1Syt1dmFYT21NTWJxb1d6dWk0cGFYY016ZWFNTjky?=
 =?utf-8?B?MStWQ0dCTVZhZUVQTjZ1Qm1tWGx5Z05veHZrZUtMaWt6YWtLZWE0UjVhNGlF?=
 =?utf-8?B?anJyZUFVMU0xSHM2UjFnN2J3aHhJWGhRcUFkbWYyQVZrdlQ5RjFhbjRtaDJv?=
 =?utf-8?B?L1RLQU5EN01vSnpzTU1EeVRqcVVicGxWUDg3VmhEVmxEczN3LzVwd3d1UXdy?=
 =?utf-8?B?RVY5OU8vbFdZOGpNL1hWTXAvMDZTdDM5Tzg0WmhDR1ZNdTdSZDRCZ1IvRkJx?=
 =?utf-8?B?TVB4RDF2R253eDdWTVp2LzlBUFQ3RlJVUE1ncU81MEpLRnhteGJaTkdqU3lh?=
 =?utf-8?B?M0lFbmhpSXdiUHF5anZaNS9SbGxSRFdQRkgzV3JXRmUzOW1RZzdVa1BraEN6?=
 =?utf-8?B?NERqckNCd2Q4WlJEcExwYlE1bFNVelFLc1Z6NFQvZWgwQS91TEFLbUJycm1z?=
 =?utf-8?B?czdQcUtSbnVsemJ2ODdCd3hiQjl3QmY5czFoOXEyZDJkcE9KaGZGR3hxREhq?=
 =?utf-8?B?VWtoL2kyV1JhNlk3RXdpVUE5T1JSVkpia054TjhIQzZ1Zm5aZVBJaXZmbGdx?=
 =?utf-8?B?VytaNWxrMXMxRUJGbWZEcUZROUw1Tzk0M0tORjI2dVFQNkFqMElKdVVESlo1?=
 =?utf-8?B?TkhraE5tSlVwV29JbE1EbHR4aWR1djd0dmdYdTVuYkdFWGNHSFZjMkxYcFM1?=
 =?utf-8?B?TEFub2JZVzdhd1hBUkZxbG9JZ1czZEhSM1I2a2phaXNqS2JyMmc2Ujl2SGUx?=
 =?utf-8?B?cFdzemhSZndtNGR6azJqMS9oNm1JQURhbThFTlhFWWN6MFEydVhjL09NcUFD?=
 =?utf-8?Q?RbYBGQvEANF4xOktYYhQovU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE1B01C032AD1547A13F31F4EAD9D8E0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?anRrbDZWSHFpTnphY1ZqVDQ4Mk9BQ3N0b0h4cHpJUUptVUZuY3oyV2gzQ2Fq?=
 =?utf-8?B?QnQ2MEJaN3UyaytBMWtYQnBVVVZXN1EvWkpmMUV2eThJVzRKcW1KK2VvbzVz?=
 =?utf-8?B?K1J2RjRLZXBjSjhmVU5DdzhMbEk0bHVwZ3NSUytHWlRrU01VQlZZdk1mbWlP?=
 =?utf-8?B?ZmhlV1JEczNmZnBmNmpOdVFnOHFpQ1JndGdITWpsUStEWVNraWJuQ1lWbHJB?=
 =?utf-8?B?TVZ0b3V6MjZCNlUwRjJSWmt0bEdiOUphVitMSzViOHVHd3BiT01tclFBMTl0?=
 =?utf-8?B?K09BSmdZOHE2bkVtSWZNL2p0ZnRmNk5SMDgvaEx5SlIxM1N0NStuY2RqQ1dL?=
 =?utf-8?B?aG5HZXBuTG1vKzlxMlRIa1VtRmdCYTZjNktlZ2tSOVIvRUFheElIVS9QR2tD?=
 =?utf-8?B?SU1zMU9wdXJ4TzRLVHArdFF4MnZEbVIwQVdWbUhsQ2dRR0U3YmJ6NzZaNExv?=
 =?utf-8?B?MmUxUlJud1NXZE81Z1orT0lEczh2a3psL2QySlZBdG5kN2g3My9JOHg5VW1o?=
 =?utf-8?B?WUFhVlhIbWF0OGlZUE1pTXlZRnRvYUxEVTJGaHIwU09hSks3WmhQZDhnVytK?=
 =?utf-8?B?TXRMem04SUdHMFRCdTJpM1pGTTVNRDZ2Z1pVZERIazY5L3IzK084TEVJdlUy?=
 =?utf-8?B?WUNZWTFTbTdsY0NCb0JueEVLcFdWaVo0UUFLU0lWSzlLblNXeTJCdFUrUUEy?=
 =?utf-8?B?Wlhmc3BVMUUwaXRkSjNNZVIrMXN4aTJKcGdxWXJBdDZoV3FHa3NnSE1adFNp?=
 =?utf-8?B?Wjdla2F4aDV5MjlZc2FjekVDdVVqMEVHMnd2NXBTTlI4bDBQZUFOK0ZKaUcr?=
 =?utf-8?B?cDBrTHFySkJneXVtcTRpdmkyRXNqcTd0NWU4TSt5ZHlFZ2h6aHAvcUhyc2ht?=
 =?utf-8?B?V1NhZ2liOXB6ZmFXOURiMFg5b1JnNi9RRHBZeFpnSDYyQXVjLzR6Ty9mdW5n?=
 =?utf-8?B?YkwrenY1S3JiSTdQbk9iUEdEeGF4emNEdDFTWjI1MjZ0YUFKNWY3VzM5YUIw?=
 =?utf-8?B?MDRNTmE0MWlRTG1vVmhlQm95STZhdWliM3JFYjVJanVUZnQ3Q1JYTU9JU0RI?=
 =?utf-8?B?NWVKdHAyZXp4anpIQzdWenJjWmpKT1lmY2JSU2h4cEVTM3JlRFlvRXpsZjEx?=
 =?utf-8?B?NFdjenlUU0orcXkvOHJ3SUpWZmVjTG5TbENxTmpnRjZZSXpLYSswZElQTHpn?=
 =?utf-8?B?Q1dsVDhzRzVSekJMNEliQ3M1UFE5bGhJSDRjaXpPVmZvclJOQndLVkZXekh0?=
 =?utf-8?B?U0VucktXMHRmT1N3NFJ5aHRLK2FxcDRzT3BOYVo4Unl4Zm1IWGR4N2JRL2ll?=
 =?utf-8?B?VzM2d2YvUldKYnFZUGhnWUdxbG1KVWhIS0RUTFlpV01SNjRwUWQySmFtSGIv?=
 =?utf-8?B?U2U4QjZtcU5pMzRBUkdZSzRDT0IvK3VydkZ2NlRlTnFqbXpRbmk5UVpOQXlZ?=
 =?utf-8?B?eHJWaERQbnF3ckRrUG5sNm1qMnU3MmpFK1A0VWp3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4472f6d4-744c-414e-5788-08dbcc0a3200
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 16:33:56.3633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dxgaz0Fvp5Izsn885/RYmM8Aw6axTYD/DSLCo27fO9EHeocL11+7dTZI1aZ0UBKGiD/aOmWT6TchvGKKAt/EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_07,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130141
X-Proofpoint-GUID: jW1Jd9BKXis1_ExfdeVQkJLhApJlqKk1
X-Proofpoint-ORIG-GUID: jW1Jd9BKXis1_ExfdeVQkJLhApJlqKk1
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

SGkgU2FsaWwsDQoNCj4gT24gMTMgT2N0IDIwMjMsIGF0IDEwOjUxLCBTYWxpbCBNZWh0YSA8c2Fs
aWwubWVodGFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPiBWaXJ0dWFsIENQVSBob3RwbHVnIHN1
cHBvcnQgaXMgYmVpbmcgYWRkZWQgYWNyb3NzIHZhcmlvdXMgYXJjaGl0ZWN0dXJlc1sxXVszXS4N
Cj4gVGhpcyBzZXJpZXMgYWRkcyB2YXJpb3VzIGNvZGUgYml0cyBjb21tb24gYWNyb3NzIGFsbCBh
cmNoaXRlY3R1cmVzOg0KPiANCj4gMS4gdkNQVSBjcmVhdGlvbiBhbmQgUGFya2luZyBjb2RlIHJl
ZmFjdG9yIFtQYXRjaCAxXQ0KPiAyLiBVcGRhdGUgQUNQSSBHRUQgZnJhbWV3b3JrIHRvIHN1cHBv
cnQgdkNQVSBIb3RwbHVnIFtQYXRjaCA0LDYsN10NCj4gMy4gQUNQSSBDUFVzIEFNTCBjb2RlIGNo
YW5nZSBbUGF0Y2ggNV0NCj4gNC4gSGVscGVyIGZ1bmN0aW9ucyB0byBzdXBwb3J0IHVucmVhbGl6
YXRpb24gb2YgQ1BVIG9iamVjdHMgW1BhdGNoIDgsOV0NCj4gNS4gTWlzYyBbUGF0Y2ggMiwzXQ0K
PiANCj4gDQo+IFJlcG9zaXRvcnk6DQo+IA0KPiBbKl0gaHR0cHM6Ly9naXRodWIuY29tL3NhbGls
LW1laHRhL3FlbXUuZ2l0IHZpcnQtY3B1aHAtYXJtdjgvcmZjLXYyLmNvbW1vbi52Ng0KPiANCj4g
DQo+IFJldmlzaW9uIEhpc3Rvcnk6DQo+IA0KPiBQYXRjaC1zZXQgIFY1IC0+IFY2DQo+IDEuIEFk
ZHJlc3NlZCBHYXZpbiBTaGFuJ3MgY29tbWVudHMNCj4gICAtIEZpeGVkIHRoZSBhc3NlcnQoKSBy
YW5nZXMgb2YgYWRkcmVzcyBzcGFjZXMNCj4gICAtIFJlYmFzZWQgdGhlIHBhdGNoLXNldCB0byBs
YXRlc3QgY2hhbmdlcyBpbiB0aGUgcWVtdS5naXQNCj4gICAtIEFkZGVkIFJldmlld2VkLWJ5IHRh
Z3MgZm9yIHBhdGNoZXMgezgsOX0NCj4gMi4gQWRkcmVzc2VkIEpvbmF0aGFuIENhbWVyb24ncyBj
b21tZW50cw0KPiAgIC0gVXBkYXRlZCBjb21taXQtbG9nIGZvciBbUGF0Y2ggVjUgMS85XSB3aXRo
IG1lbnRpb24gb2YgdHJhY2UgZXZlbnRzDQo+ICAgLSBBZGRlZCBSZXZpZXdlZC1ieSB0YWdzIGZv
ciBwYXRjaGVzIHsxLDV9DQo+IDMuIEFkZGVkIFRlc3RlZC1ieSB0YWdzIGZyb20gWGlhbmdsYWkg
TGkNCj4gNC4gRml4ZWQgY2hlY2twYXRjaC5wbCBlcnJvciAiUWVtdSAtPiBRRU1VIiBpbiBbUGF0
Y2ggVjUgMS85XSANCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8y
MDIzMTAxMTE5NDM1NS4xNTYyOC0xLXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQo+IA0KPiBQYXRj
aC1zZXQgIFY0IC0+IFY1DQo+IDEuIEFkZHJlc3NlZCBHYXZpbiBTaGFuJ3MgY29tbWVudHMNCj4g
ICAtIEZpeGVkIHRoZSB0cmFjZSBldmVudHMgcHJpbnQgc3RyaW5nIGZvciBrdm1fe2NyZWF0ZSxn
ZXQscGFyayxkZXN0cm95fV92Y3B1DQo+ICAgLSBBZGRlZCBSZXZpZXdlZC1ieSB0YWcgZm9yIHBh
dGNoIHsxfQ0KPiAyLiBBZGRlZCBTaGFvcWluIEh1YW5nJ3MgUmV2aWV3ZWQtYnkgdGFncyBmb3Ig
UGF0Y2hlcyB7MiwzfQ0KPiAzLiBBZGRlZCBUZXN0ZWQtYnkgVGFnIGZyb20gVmlzaG51IFBhamp1
cmkgdG8gdGhlIHBhdGNoLXNldA0KPiA0LiBEcm9wcGVkIHRoZSBBUk0gc3BlY2lmaWMgW1BhdGNo
IFY0IDEwLzEwXQ0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIw
MjMxMDA5MjAzNjAxLjE3NTg0LTEtc2FsaWwubWVodGFAaHVhd2VpLmNvbS8NCj4gDQo+IFBhdGNo
LXNldCAgVjMgLT4gVjQNCj4gMS4gQWRkcmVzc2VkIERhdmlkIEhpbGRlcmJyYW5kJ3MgY29tbWVu
dHMNCj4gICAtIEZpeGVkIHRoZSB3cm9uZyBkb2MgY29tbWVudCBvZiBrdm1fcGFya192Y3B1IEFQ
SSBwcm90b3R5cGUNCj4gICAtIEFkZGVkIFJldmlld2VkLWJ5IHRhZ3MgZm9yIHBhdGNoZXMgezIs
NH0NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMTAwOTEx
MjgxMi4xMDYxMi0xLXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQo+IA0KPiBQYXRjaC1zZXQgIFYy
IC0+IFYzDQo+IDEuIEFkZHJlc3NlZCBKb25hdGhhbiBDYW1lcm9uJ3MgY29tbWVudHMNCj4gICAt
IEZpeGVkICd2Y3B1LWlkJyB0eXBlIHdyb25nbHkgY2hhbmdlZCBmcm9tICd1bnNpZ25lZCBsb25n
JyB0byAnaW50ZWdlcicNCj4gICAtIFJlbW92ZWQgdW5uZWNlc3NhcnkgdXNlIG9mIHZhcmlhYmxl
ICd2Y3B1X2lkJyBpbiBrdm1fcGFya192Y3B1DQo+ICAgLSBVcGRhdGVkIFtQYXRjaCBWMiAzLzEw
XSBjb21taXQtbG9nIHdpdGggZGV0YWlscyBvZiBBQ1BJX0NQVV9TQ0FOX01FVEhPRCBtYWNybw0K
PiAgIC0gVXBkYXRlZCBbUGF0Y2ggVjIgNS8xMF0gY29tbWl0LWxvZyB3aXRoIGRldGFpbHMgb2Yg
Y29uZGl0aW9uYWwgZXZlbnQgaGFuZGxlciBtZXRob2QNCj4gICAtIEFkZGVkIFJldmlld2VkLWJ5
IHRhZ3MgZm9yIHBhdGNoZXMgezIsMyw0LDYsN30NCj4gMi4gQWRkcmVzc2VkIEdhdmluIFNoYW4n
cyBjb21tZW50cw0KPiAgIC0gUmVtb3ZlIHVubmVjZXNzYXJ5IHVzZSBvZiB2YXJpYWJsZSAndmNw
dV9pZCcgaW4ga3ZtX3Bhcl92Y3B1DQo+ICAgLSBGaXhlZCByZXR1cm4gdmFsdWUgaW4ga3ZtX2dl
dF92Y3B1IGZyb20gLTEgdG8gLUVOT0VOVA0KPiAgIC0gUmVzZXQgdGhlIHZhbHVlIG9mICdnZGJf
bnVtX2dfcmVncycgaW4gZ2RiX3VucmVnaXN0ZXJfY29wcm9jZXNzb3JfYWxsDQo+ICAgLSBGaXhl
ZCB0aGUga3ZtX3tjcmVhdGUscGFya31fdmNwdSBwcm90b3R5cGVzIGRvY3MNCj4gICAtIEFkZGVk
IFJldmlld2VkLWJ5IHRhZ3MgZm9yIHBhdGNoZXMgezIsMyw0LDUsNiw3LDksMTB9DQo+IDMuIEFk
ZHJlc3NlZCBvbmUgZWFybGllciBtaXNzZWQgY29tbWVudCBieSBBbGV4IEJlbm7DqWUgaW4gUkZD
IFYxDQo+ICAgLSBBZGRlZCB0cmFjZXMgaW5zdGVhZCBvZiBEUFJJTlRGIGluIHRoZSBuZXdseSBh
ZGRlZCBhbmQgc29tZSBleGlzdGluZyBmdW5jdGlvbnMNCj4gTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDkzMDAwMTkzMy4yNjYwLTEtc2FsaWwubWVodGFAaHVh
d2VpLmNvbS8NCj4gDQo+IFBhdGNoLXNldCBWMSAtPiBWMg0KPiAxLiBBZGRyZXNzZWQgQWxleCBC
ZW5uw6llJ3MgY29tbWVudHMNCj4gICAtIFJlZmFjdG9yZWQgdGhlIGt2bV9jcmVhdGVfdmNwdSBs
b2dpYyB0byBnZXQgcmlkIG9mIGdvdG8NCj4gICAtIEFkZGVkIHRoZSBkb2NzIGZvciBrdm1fe2Ny
ZWF0ZSxwYXJrfV92Y3B1IHByb3RvdHlwZXMNCj4gICAtIFNwbGl0dGVkIHRoZSBnZGJzdHViIGFu
ZCBBZGRyZXNzU3BhY2UgZGVzdHJ1Y3Rpb24gY2hhbmdlIGludG8gc2VwYXJhdGUgcGF0Y2hlcw0K
PiAgIC0gQWRkZWQgUmV2aWV3ZWQtYnkgdGFncyBmb3IgcGF0Y2hlcyB7MiwxMH0NCj4gTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDkyOTEyNDMwNC4xMzY3Mi0x
LXNhbGlsLm1laHRhQGh1YXdlaS5jb20vDQo+IA0KPiBSZWZlcmVuY2VzOg0KPiANCj4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyMzA5MjYxMDA0MzYuMjgyODQtMS1z
YWxpbC5tZWh0YUBodWF3ZWkuY29tLw0KPiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjMwOTEzMTYzODIzLjc4ODAtMS1qYW1lcy5tb3JzZUBhcm0uY29tLw0KPiBbM10gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9jb3Zlci4xNjk1Njk3NzAxLmdpdC5saXhpYW5n
bGFpQGxvb25nc29uLmNuLw0KPiANCj4gDQo+IFNhbGlsIE1laHRhICg5KToNCj4gIGFjY2VsL2t2
bTogRXh0cmFjdCBjb21tb24gS1ZNIHZDUFUge2NyZWF0aW9uLHBhcmtpbmd9IGNvZGUNCj4gIGh3
L2FjcGk6IE1vdmUgQ1BVIGN0cmwtZGV2IE1NSU8gcmVnaW9uIGxlbiBtYWNybyB0byBjb21tb24g
aGVhZGVyIGZpbGUNCj4gIGh3L2FjcGk6IEFkZCBBQ1BJIENQVSBob3RwbHVnIGluaXQgc3R1Yg0K
PiAgaHcvYWNwaTogSW5pdCBHRUQgZnJhbWV3b3JrIHdpdGggQ1BVIGhvdHBsdWcgZXZlbnRzDQo+
ICBody9hY3BpOiBVcGRhdGUgQ1BVcyBBTUwgd2l0aCBjcHUtKGN0cmwpZGV2IGNoYW5nZQ0KPiAg
aHcvYWNwaTogVXBkYXRlIEdFRCBfRVZUIG1ldGhvZCBBTUwgd2l0aCBDUFUgc2Nhbg0KPiAgaHcv
YWNwaTogVXBkYXRlIEFDUEkgR0VEIGZyYW1ld29yayB0byBzdXBwb3J0IHZDUFUgSG90cGx1Zw0K
PiAgcGh5c21lbTogQWRkIGhlbHBlciBmdW5jdGlvbiB0byBkZXN0cm95IENQVSBBZGRyZXNzU3Bh
Y2UNCj4gIGdkYnN0dWI6IEFkZCBoZWxwZXIgZnVuY3Rpb24gdG8gdW5yZWdpc3RlciBHREIgcmVn
aXN0ZXIgc3BhY2UNCj4gDQo+IGFjY2VsL2t2bS9rdm0tYWxsLmMgICAgICAgICAgICAgICAgICAg
IHwgNjQgKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gYWNjZWwva3ZtL3RyYWNlLWV2ZW50
cyAgICAgICAgICAgICAgICAgfCAgNCArKw0KPiBnZGJzdHViL2dkYnN0dWIuYyAgICAgICAgICAg
ICAgICAgICAgICB8IDEyICsrKysrDQo+IGh3L2FjcGkvYWNwaS1jcHUtaG90cGx1Zy1zdHViLmMg
ICAgICAgIHwgIDYgKysrDQo+IGh3L2FjcGkvY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMjcgKysrKysrKy0tLS0NCj4gaHcvYWNwaS9nZW5lcmljX2V2ZW50X2RldmljZS5jICAgICAg
ICAgfCAyMiArKysrKysrKysNCj4gaHcvaTM4Ni9hY3BpLWJ1aWxkLmMgICAgICAgICAgICAgICAg
ICAgfCAgMyArLQ0KPiBpbmNsdWRlL2V4ZWMvY3B1LWNvbW1vbi5oICAgICAgICAgICAgICB8ICA4
ICsrKysNCj4gaW5jbHVkZS9leGVjL2dkYnN0dWIuaCAgICAgICAgICAgICAgICAgfCAgNSArKw0K
PiBpbmNsdWRlL2h3L2FjcGkvY3B1LmggICAgICAgICAgICAgICAgICB8ICA1ICstDQo+IGluY2x1
ZGUvaHcvYWNwaS9jcHVfaG90cGx1Zy5oICAgICAgICAgIHwgIDQgKysNCj4gaW5jbHVkZS9ody9h
Y3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmggfCAgNSArKw0KPiBpbmNsdWRlL2h3L2NvcmUvY3B1
LmggICAgICAgICAgICAgICAgICB8ICAxICsNCj4gaW5jbHVkZS9zeXNlbXUva3ZtLmggICAgICAg
ICAgICAgICAgICAgfCAxNiArKysrKysrDQo+IHN5c3RlbS9waHlzbWVtLmMgICAgICAgICAgICAg
ICAgICAgICAgIHwgMjkgKysrKysrKysrKysrDQo+IDE1IGZpbGVzIGNoYW5nZWQsIDE4NCBpbnNl
cnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQoNCkkgdGVzdGVkIGl0IGZvciBBcm02NCwg
bWFrZSBjaGVjaywgYm9vdC9yZWJvb3QsIGxpdmUgbWlncmF0aW9uIGFuZCBmb3VuZCBubyBpc3N1
ZXMsDQpzbyBmb3IgdGhpcywgcGxlYXNlIGZlZWwgZnJlZSB0byBhZGQ6DQoNClRlc3RlZC1ieTog
TWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+DQoNClRoYW5rIHlvdSwNCk1pZ3Vl
bA0KDQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCg==

