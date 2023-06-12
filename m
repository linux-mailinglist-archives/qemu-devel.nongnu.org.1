Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0372C5B2
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hRV-0002FO-EK; Mon, 12 Jun 2023 09:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q8hRO-0002Eq-1H; Mon, 12 Jun 2023 09:18:38 -0400
Received: from mail-bn7nam10on2071f.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::71f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1q8hRM-0001w8-7o; Mon, 12 Jun 2023 09:18:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMs1tW3Ubv1XcRVoSBJkVfg4U1e2Bfmnz1PEADt1aJPclO8zCedJ33gqAmP0lJTQhyGZ2a2OMGqfTCu1zsHZjpg4hl3f4wEIlVsnGrxTl06QD8Z94Enj5hZ5QUXHR2GTO16PIw8IuURNpovJuT1/hTZrGoKz+mHtXF7DXdzmun4QkMEUou6ZzfNJca9HmlDaU+27fxWQwQLHJSexfhZrq+ZB0gATmLVqmm/CnqWhCLY4A1Y024PIxNOLSg4bqGL9uuZeY4jFLaAZ2otJawOXYMjaIGAxQi/AbdpdQx+Xe3JXNJDz7gGQ7Oa5zb1/oTsnJ26S3PLQhu97d1tfNaW8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAdObKJ/ZklxbnrCPTGmh15MOjr2/PmQ1hvkiUjfZ/w=;
 b=c0fFWU3MZu9xVHy3WTJ9jmf11Aflg5J/3Xmq4ChNKozcI9M3mRHJ6pjX5QeFgYBTahtboH8j/ppbCJIh869Z4zJc2DueEiBrBUbOJdFuuNvWp79eScF9kkh2oDEsHrGBj1GU1j0iLABP9CTXoMC0sT+U+NhwbJfhAohEOOkRdRUjFSJD8ktr/uIA7X9TUcSHIc4WhKSjYRb+ZxFSOHpIj9ldID0YDmPXRLhO2AhiBYlmXPx9c0KgcD5urGxqGQofe5BpsEi9Oye4GXD4pyBaTD3+By9pVlt55tCup03bTAZzj35HgjKoo11hjL5qbzNEJSIkSInAC8iNemrofHEb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAdObKJ/ZklxbnrCPTGmh15MOjr2/PmQ1hvkiUjfZ/w=;
 b=RorqHZStGtZCE7Mbv5XVAoeNk6Lvalmp0UUoaj4FvPSvwMSRi7C18qQfThWcgC2DK++/f/A7Ts1K+uih6Uz2qLbYooYM1AEI0Ca7vys8UnKYXoKy5WxQeERlWP2QitcgQRkldhx9YoEcionzJH5O2KUONRgngF1mNy4ROFXq1CQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB7124.prod.exchangelabs.com (2603:10b6:610:f3::20) by
 SA1PR01MB6560.prod.exchangelabs.com (2603:10b6:806:1aa::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Mon, 12 Jun 2023 13:18:28 +0000
Received: from CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed]) by CH0PR01MB7124.prod.exchangelabs.com
 ([fe80::9a78:4703:c6a9:16ed%6]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:18:28 +0000
Date: Mon, 12 Jun 2023 09:18:15 -0400
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Vincent Dehors <vincent.dehors@smile.fr>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/8] target/arm: Add ID_AA64ISAR2_EL1
Message-ID: <ZIcbF8zShOr1N2Sl@strawberry.localdomain>
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
 <20230609172324.982888-2-aaron@os.amperecomputing.com>
 <a8db353d-b258-c856-d5ce-1236b0893a53@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8db353d-b258-c856-d5ce-1236b0893a53@linaro.org>
X-ClientProxiedBy: CH0PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:610:74::30) To CH0PR01MB7124.prod.exchangelabs.com
 (2603:10b6:610:f3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7124:EE_|SA1PR01MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daf7138-17cc-438c-c690-08db6b4782b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Py+TNA/julEpCK9b3y+u5WDpKyY/Yi23JUmS3VEqO0kPPWgyLgFvZRpqf0gPFxargU3j/OhWs2NgEZWTHyFg3iR47opOT2oKaZENjiJWrdUUvHl+rtXsAzWUQpcesbW6o6jzjTfCWTyW9NUZEas7bqoNaQoKcII2rxXY/yXSNrDMYxncPtC298IkQV7F7wjmK+pLq8G1AyoIWuW2HLW7Xd55Cactzyhsjs1+2Hg1jA4qlRExe7mfokWGkJeoHapMSdSj8VLW/7pqurbRmVmTzcZdyYWS9LmU+i0QprahSYz/m+jdtbz2ptZd+nuPJt5G3GPtiGDzNijPF4YzK102wYRjSz5Q8Tthd0vp6ONPk21SoKrnB84xh9QPXNp0pQyET9egIfvodntexgr3wjRqHh/ywv3FoAzGeYsjOK2OlrVAMKjcC2LkA8erN/NYQ3TdxIbVGRiFDKvLgvwBmrQjhYOEBbTov/8qb8n3T3rodH5+aYtY+tQlDhlU5PJsUf7Z/XWwbana2ur5WgBl7sh+bNT3gDKv6e/5hkKoHl4kXNN/mdW5waotuJyDCV21W4EB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR01MB7124.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(451199021)(54906003)(5660300002)(4326008)(66946007)(66556008)(6916009)(8936002)(8676002)(41300700001)(316002)(186003)(2906002)(478600001)(66476007)(6666004)(6486002)(6512007)(6506007)(53546011)(26005)(83380400001)(9686003)(86362001)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b+NRnTPopHhnbCp9D2OZhfEhGt0j4STJsHlQcKFVt4wGw39AI9tzhF/hwEFY?=
 =?us-ascii?Q?DIKb65/bBZCrg1vG2wQizfgxiNyhS8ffDM9EfLqc0W6DCe/ACPUW8JauFxFB?=
 =?us-ascii?Q?/ZVScFSjk2wsRejSgKlLaB8WxmGYQVupfah9cXPfhT7Ksvknk0rmqRaNJMVs?=
 =?us-ascii?Q?xlfLBV8xCMVyLEBOHnnEOJcpWfqR0XU2GnynixGt03GL1VUdpI4dY1vS1i3Z?=
 =?us-ascii?Q?M/erYuubFMopMkIY8GbdMgyKgjt0HDoSKtiPc6lHH1VDZZ1iL21YUhr6AmWk?=
 =?us-ascii?Q?s2PsfZ9SzCjzj0J3Crwp0bGILM3OKU99IUPkUT4K1nlMU0ULuGJZ9U325TqG?=
 =?us-ascii?Q?Q9JnaVEhN6XpE9PtPW6jivyfntLTUPcUvTP6kGkEeR04cIjX/ZKxltiuS6Th?=
 =?us-ascii?Q?uI70GrqbLLwudNrUaTYWLBXoO0b7O3pHwBv4MmDfdVM69YwWG+zDVQeMQoyE?=
 =?us-ascii?Q?qK/lFKPUW8usUIKNmeDYF/qIHOc7S+ct0WSm0BW2jDaRIXFk+UrfEDvqHNKq?=
 =?us-ascii?Q?Qu+vpk5+9ErMrI1UJDuwlhrgfU5abIYQ44caiEKJLfj355CvZM2dUKZhFyWj?=
 =?us-ascii?Q?L4pxaUGNrKD/9/+a3UW5qwx3HzRlnRy8UFJAVIdT0fdW6ZNGrhIGu3EMSVzF?=
 =?us-ascii?Q?zvFwMBroxI7DwHdNOO2VuzVAqhqgLbMDjj7oDJb713nBl0HDGTuk1E/GjPUT?=
 =?us-ascii?Q?nigbTPqt+ygXALt0/fsN1zkftAc4hg7kH57OhNH3mu3XkYBwphUKh/Ht57YG?=
 =?us-ascii?Q?7Ur6KCYduX/biUPPxj23iTTvR/lgzjf21aIIZeKN2V7nyeE4Rmlq0G4f7cnu?=
 =?us-ascii?Q?7jmqQR+bo3qwNkunA7+b0Z1IPKsvbO6dj4fquVoadU/Mzvcxorw3jlyJSE/H?=
 =?us-ascii?Q?D7N2R6IyL+SXyHUvZ33LTpq0QPG/cJP8mocvhjRGSRqnFoX4z3OKj2o/iQiX?=
 =?us-ascii?Q?5Vbu07Z3DAB+H6ewlRKszPuc1D8+39J90qp0DbbrGGi7MSKWsp8+w0Jj7h9d?=
 =?us-ascii?Q?VHf95s3kuWMJxaCiqSgd5Ix/pY/4L4ICkq25VRK5trpxMtvI45Utc21lNzFd?=
 =?us-ascii?Q?FHv8f/s98Brmbizggz9CvACjFfBdwX1tpj+ggyW7+gG2ejhXK0VNY/OAv8R1?=
 =?us-ascii?Q?93+xTZ5xZ5Ba5SGoiBvqLT7TOQKC6UOWzghFWKMiRmXKA1Mwr7itoWUYLJ0D?=
 =?us-ascii?Q?gsKGYOcbSQOa4gdnRU0WobVB3nztoylH8Y2r1RI7ckWmIbAMPRruo0gaIMV8?=
 =?us-ascii?Q?boWL1kYOM3QCrSxaWNYUw+poqx6WhtU7Ev199QO92jstKsQZqtrRC5HHfnPN?=
 =?us-ascii?Q?2KubCT+AMwbwD4HqNBeb+6arBMmlHBEvWFbnhNnWvyw5cWRWGa69zeryxLgp?=
 =?us-ascii?Q?R9YlC1ULQ2wsfxdwQOJ1aSNxFogJGpvJz5QS8yx97C5OBDNdQWO5ri5r8vRe?=
 =?us-ascii?Q?PYrBtmvbzQ3FFL0XwO3AxdfNDzZE0qeGNLQVdfH2VlZZHL6S4nvpE1A9aS+8?=
 =?us-ascii?Q?9ACazw7Yd+9dr+PrTd17NacbFIUODmQzxt/l6QlJoBYmtUcM6m2Z0kjPoeEy?=
 =?us-ascii?Q?2C4d715PeJtUdNOtge+1e0FuMLC57sZr3+W5DwNEYcmC8pnWCluvQEMXcOQ3?=
 =?us-ascii?Q?4yhKf4BbxCYXcS7zkdwr5vw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daf7138-17cc-438c-c690-08db6b4782b9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7124.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:18:28.5328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRxpvmbb++hMTpKXIna0tURCpG+D055hMGrXcm1B51QErpBIkrmsEXVT3qTfCPbKBqhI044Epqnu7y9YzIEvp3/l/pjKt41axqjUU7VsoNYZOhivdFJC0jXAtSFXxI8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6560
Received-SPF: pass client-ip=2a01:111:f400:7e8a::71f;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Jun 09 13:49, Richard Henderson wrote:
> On 6/9/23 10:23, Aaron Lindsay wrote:
> > --- a/target/arm/hvf/hvf.c
> > +++ b/target/arm/hvf/hvf.c
> > @@ -847,6 +847,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >           { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
> >           { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
> >           { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
> > +        { HV_SYS_REG_ID_AA64ISAR2_EL1, &host_isar.id_aa64isar2 },
> 
> Sadly not defined for MacOSX13.1.sdk, and it's an enum so you can't #ifdef it either.
> 
> You'll need a meson probe for it.

I'm not very familiar with HVF or meson - I am not sure I understand
what you're suggesting here (and a few attempts to grep around for an
example didn't turn up anything that looked helpful). Are you suggesting
some sort of build-time auto-detection, a "dumb" configuration switch
that a user could use to manually enable this, or something else? And/or
is there an example you could point me to of what you're thinking?

-Aaron

