Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9312736609
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWeR-0002l0-LG; Tue, 20 Jun 2023 04:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qBWeN-0002kh-6T
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:23:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qBWeK-0005NJ-Sx
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:23:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35K0GlKW006963; Tue, 20 Jun 2023 08:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zwISMa6pVdeOIzXU+RXb9YNcJfuUFTHjDrwFqy4w+N4=;
 b=sIQQj6NOowCo56jGMcCV6Vnwo8rn7J6OJZI0owqw1f3g1e/Ien8wL+ueL0IwJyzxIUDi
 M0BmLUTJakuFZ7Jkdo23BuDJiW4NRdRcAloRIeo3q+WRVuh9OJff5ETGp+zLRAxy+G0t
 FtEjv1scdMdDpSKo3I1vWiMzJKFLDCxMny/X7ZKfz2rVkjBQK+IuojuLqP+LXQ8XeImi
 /p78+Ji9mrUoDYvxDbNfKP/NMaKyxzjtYumH77Sf5nK7mno/gzTPuyuCLjPcpcrN/qGT
 6JS9cDc4mukZ0iC+8DRciHwi/nEvvoKj5nD9pFLgwXGegxXK6eVP8rymIIMkIYsQZcRB hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3m4pe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 08:23:35 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35K68PYD032961; Tue, 20 Jun 2023 08:23:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r93958j1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 08:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRku2Nr1g0ZGgA7GnPGFyaEExWznoNjOW0iSZzZY47YPs8LvLVkFVE+tbuJGsE6ARX1d046M3EDqaZhTfrbQCs7e5JYQNOmo0W5qlubZqgUErlKNZLQ0KHWXpW43HIDe6LPWHwBdG2EWwlsEjKAYSzZKj80EmpbBHzAbrODWbwyeC9QI+uQqRNxgnu3P3hHiaEaO6a8X/5MD613iJL+VqgbIhLDIH/sJo5ekXGsVp59QSU5woXbwTtXfP8GpspbSZFHXT+iUzd4BX5W4tRLGc05XjcRhNdHGyOwwC6jtntC2HQ+kU47FDvAdTdhjX5+7p93grf5nvQzMPh40iGGltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwISMa6pVdeOIzXU+RXb9YNcJfuUFTHjDrwFqy4w+N4=;
 b=QYUmQvNPSSD/Z/mAAu3Us+ijp4uuUQIw/pfarUXNbmbOqj8m0MjG02TFfS2EefOWKj/7en38/uM3FxAbVQb4ud4fgRQWyAn4Hn9kKle1a8fYM+3bRlkgZRkAkY4HrAaSVwk62bcXurrlpd2ldVUy3igAolDWbOhpc3OMH7VZMZDKjksmjKWX89PEr/TC0QpNS92WE3vO/oo1C7lrAGeYVEAhBXME+/EqJkifrkOtXvYB0xKEVDfQ12hdCxjECpkDtfc+hsaZXSILiOvfO88sK1IiRmYekVJLEwsTUnQML2QOEdOrDCVhw5xEvGP2NLycq/gHQhEEaP2zz0Bzcqt9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwISMa6pVdeOIzXU+RXb9YNcJfuUFTHjDrwFqy4w+N4=;
 b=0MbTXtP+bIzEivwmeUut561fcTN40Pmy52yf9pcn8lwc9GK+QeK5p4V/yKJMaAaGwtKFQ4vXYIa8JNFcD1fIF2lgM2TkG8qTKehwY/59UfAQnPAy/M137AfoFLoF7Dw8LLK37bdtRRDWcefCh65+5rBjfrg1IqLq2ZpcywSoUwM=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 08:23:36 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 08:23:35 +0000
Message-ID: <a49cbb60-d2ac-6329-806a-260d602d3056@oracle.com>
Date: Tue, 20 Jun 2023 09:23:25 +0100
Subject: Re: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230619084446.399059-1-zhenzhong.duan@intel.com>
 <41469da8-dae3-df36-6de1-4b44bf6ba508@nvidia.com>
 <SJ0PR11MB67443F8A4A7AF037379355C5925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67443F8A4A7AF037379355C5925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0058.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: d29103ad-9e51-4d62-c445-08db7167a432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: na8QH5FYSOoBEIUPojkEHF7WyTfdlSfR0vCYHdaOXpi/GkQj08KKSno6J88Xvp7/UOunSek5Umr20yYifWukRE/hLrb9+f0jB8a6+rDG+Mx+TglGwIuinrd8xyW8qCq6VrIOnrx/AskMlOF5p/hbIM4nbPJFEkdI/S9nk3T0xibo8x7KS8EUf/ktw5lqYZ1cY5dyETGW+kyf9C2ftyTgBsgGoVqIdFLHPdG1mVlPov2xMNoUQdJJYMdcQN+nSIlWXxWc2MrelM7BAm/BD49jHN0rlfuLJM/genpKHPBnEYdX2JB54NyI+SE8+V19iVjhILsWAEZNicZH5MmbTRxx68hitOZWzO/kezNopEUcjVYpklbNVfwpkoDzgLnBRuSUGrLEONbjuIaY7QrrhGZbeWJm5Rx0tet6wZ5FD1Gh04NgnZxyvfUEqSbUgBdW/gq8Rxn4mlpGTc+dk0wn6wJr/h8OJ1qSej7xG0XY9giSwALQoGGc1E8tp7SVdDYTUXNxqbwBgV+R5mFTU0+MXiPl9YCYljfBwuhyZv8U7gfq59EXxLkPfFyw4X20zva48Vr/cAZoCZwC3HYLCmGRghZi8I8d8Z4PSXtEvHWKMRcGXLRf4EdNjuxcRv9kOZYk0pnS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(5660300002)(2906002)(8676002)(8936002)(83380400001)(36756003)(31696002)(86362001)(38100700002)(31686004)(6666004)(66476007)(66556008)(4326008)(6486002)(66946007)(478600001)(110136005)(54906003)(6512007)(186003)(26005)(41300700001)(2616005)(316002)(53546011)(6506007)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUM5dkNkTEphSGV6NktHUDdHUHF4bDNYTGNwd2RJOHZtOE9vajlmaFFOZjF4?=
 =?utf-8?B?SHNuZG1rdkhqeFY1bUkrS2xCbVBrZ211blltSCtjQlJBV3U3VlJuenJ4SDBq?=
 =?utf-8?B?cEFYUFVPejUzeEs2cXNSMXlIcGlacVJoVmVGQXVHTjJzdER6Ny9yUUQ1elQr?=
 =?utf-8?B?TW5BekFROHdaVXJIRkIrZmVidXpNTnBDVmYvYnJ0K1kzSVZ6S0lyYm5veEF6?=
 =?utf-8?B?djl6d0tPSGVYUU9kSHczSzVYeW9PNTk2T2QrVVJtcHBrTXFZZmp1UlU1UDJH?=
 =?utf-8?B?cm5zQ3ZyRHN5UUpkblB3b1ZNWTNrOGVoZGFJbnNHWS81TFpHc2lxNk44WXM5?=
 =?utf-8?B?UFlDU3UzRTNkcmthdkpPUE96eWlGZkNZWTJ6UkI4THFJbFJpMzhPY1hjdXhu?=
 =?utf-8?B?TXcraDk4STBUR2xERE9ZU0l1YWV0ZGI3TTgrbTRZeFVINHJMSWFXbnFmNU9l?=
 =?utf-8?B?YzFiM1V2VDY0RXdyUkVjMThGamVIMTAyVU0rc25BSEJDRGFkc0ZVQVBUMnI0?=
 =?utf-8?B?ZFQ0eGIrUTNJQVBEeE8zdXhFYXczbExBMTBoZjNWc25KN0ZFUmFUbFNDVzBR?=
 =?utf-8?B?N0pXUGVVVWsrUVZYdmNWbVlBL2NjRU5LYk4vbjBqa3gxYTV3ZklHNDZaMEpi?=
 =?utf-8?B?OHcrUDk3cHVEek1PdCt1TGtiQXNGVFplYnZxZjdWSkMwTWdodzNlOC9rN3Aw?=
 =?utf-8?B?YTlrbjRWSXU1enE2Um5WOGZUL1ZZWmlvYmliblFyQjVmQTBCN3RJZEFsdE5k?=
 =?utf-8?B?bmVGV2xYSm5hSnBtWVBHVC9KWlNUR0tqK0ZieWxGRGRodnBJSVVuNlRLaDRZ?=
 =?utf-8?B?VHJ2MzkrU0Exak52WWV2eFhPclNscmFLNWM5WEdvYTRlMEkxS01zY1pjbEFm?=
 =?utf-8?B?akQrZjhORklaa3hsMnhZQVZtVUpWOVpNakpobTBCMlBKcFpFTEFRTzNHVU02?=
 =?utf-8?B?bk5yR1Z2MFJSSmNUUnh1TDhGUU1sVlNFaGNudnQya256djdBZUVtOEN6MUx1?=
 =?utf-8?B?Q2h0dXdoUzdtQUp4VGY3S0ZjNE5nODV4TzFTNnl1bTVTL3lkaW8yeWFtSXdh?=
 =?utf-8?B?dVh6Qkh5ckIycmk2cGYyNTNzODhJd09LMFFVNVFTOFFQNDFSL2c2MDF3VlFh?=
 =?utf-8?B?S2tnWUR5Z2FuRXoxM2VHeXBjeHc4WmczYytqSzhQUVNqdjlIeU02OUxRL0t0?=
 =?utf-8?B?VFY4aHcxbFF2SWV3R2dXUFZsTzhpSDlOTHlzS0ZCc0VZQ0pzUUlEZEJzSEVX?=
 =?utf-8?B?dmcvdXhlRjd6eDI1Z1gzOFdGWnNud0M1S212R0IxS1dDY1pnTnZCZDNOQUx2?=
 =?utf-8?B?VDcreVN6K2FQWnJZWnVPb3UwZzc1WTRPRG5TcjdlSjhhV2hzN0h6UzJFVWpC?=
 =?utf-8?B?dUNYZzdCUnR1K1B5anpIc0l1MHBnNG9lQ042VHFmQzhSL3hFL3Ftc2Z0cGdI?=
 =?utf-8?B?ZFcyNUNhc1FRU2hXVlBpYnp1UzJBRzh3L0tFanRVUjFZeXpVZHZNeXZQN3Yz?=
 =?utf-8?B?bmUwak14S0wreGhmUWNMZDRMbkVpUnRNdzJDMFZnS3F6TkRlbXhOaWxrdzhJ?=
 =?utf-8?B?bGd3dzVnc1JZQkszRDNtZUk5eW8rRmdwRUxacWZocUlKaTcyeGpPeStZN3Rw?=
 =?utf-8?B?Z29UWmdDK3VEOXYramh2K0UySGNJeE0vbXRGbk1qNy9pVklIMnltb1BkK3Rw?=
 =?utf-8?B?VGUvTWRFMkJoTTZYUnE0VkdtcFl2VmtzN2RYYWVFbEIrY0pMVlNkSjhDTlkx?=
 =?utf-8?B?MnlUc1B5bHJ6cEtJQ1U3Vzc3MXZDRlk1V0pYYnRsVHlzeXM1RTlSbXovNDJo?=
 =?utf-8?B?TmJ2djNtRzhKaDhVZG9FNk5aZHIvSmF3SDI1VWZ4MFBSbFVGdGUzUXExRmpm?=
 =?utf-8?B?V3pVcjFZV0hxd1ViVmZNUlVoM1dBU1dHek9CN2c4c0s0ellLUE8wSFJXeDA3?=
 =?utf-8?B?S2t0NzM2bUtTcThsUTRFZm9qZ0R3NXlOdlJMR1RML2VQVHR2dnlqallCdDg0?=
 =?utf-8?B?a2RCSFpRdnpYZEtqODZoRFY2Qjh1Q2NtcU1lYVNwVUE4VDlIUWdGS2wwaVd0?=
 =?utf-8?B?dEw0bC9VMnlmU3VLdTZSaXBKdlRFUDJtVVhSUmcwTEd6RGlENEVEZVhKNVZH?=
 =?utf-8?B?eUFaVmtLbWJmR3J2bmRHWGwyNmFCbExPei84MXlKUWFENGpGeFdDZS9oVmJz?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rpqn1N1HRDDv5GDQuHgTcIpLdISfkrLGBUM4+eCfVTSpb3PdLQ/zoLmuPu2j/i/NrRir/iyJfzVUS8lHyZL4f/k103lAc9Y5dA3f12iN3ektWBos3Z/CJPhhZvu/Pyl0X09Z37R4dj9HJC8pAKDRO/9A5b9LGWmpdLye8YSdzDVv8ZkY83YDO04VT1X8K6xmADHUA3PsZrL3YFnqKq6atWBnpBHoA1I4oPF4pr1UkO13H0IBxACC8okgJ4ak2kln1AgWDPw++Jg4YmGBbbhZ9j8C2tQOpOvlkOCyP7k3zsj8PwLsPlcgMl91fs1GQz4CJ2qVDWv3tw+IqLj48IOOBWEwA0O5TTRShWSyD4WQODJdXE851ixXngOnRUcV+jnxnWaSIAoMyLz6tLT7eKWWkpHWBnd6zO+tVeu93uZNiEr+ismooBlssfOX09mFpi1+B9USQMHodwf3PWrQJFqwnKaTPZagM4Wxm9hhYnommmpmuFtNZQlMAQEBs649Dtz0gfR7MOJAAOJdDyUZT0J3/AFU5tXCts5RgOiINZGyjhJ42VzkU1uDix3wnnYksCcO9dZSCCT5IWUMvxGwITXMcnkAu+2Y3zZbehco0kLf1PNzmhCpjUXOfzbQCbKR7RkbzMoJTJwpvCw9iUZykk3dsf35QXewDPAHPJlu+xs7TbxIP+KDaqqPudEhS0xDHDYgdtSAPG6H/orVP2rOSayRIFeJHKJp/dQXY4amDAX6+pi5tfx83S3ixLB4dnW6UrxjkoLwFk5V+0k2mKDJ9FbpWnuwS4weT9kcVqhorHC1K9EGhBVrsN9ji7/74xLILXvFCe1WeXNEOqkUJ/tK+2XK/Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29103ad-9e51-4d62-c445-08db7167a432
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:23:35.6889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXH4+m8NGSRmNV/3+CXRbejzyviF4+Lv5aRwKNkuzmz6mZVk3hrzta0fonOBjgZFfpccOGpYaTnwo0c58w9oD8ID7vBk2WWqMNZYtj8YLrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200074
X-Proofpoint-GUID: vW97bCEaaP1pxExlCjF6CkuQ5VRRPVmE
X-Proofpoint-ORIG-GUID: vW97bCEaaP1pxExlCjF6CkuQ5VRRPVmE
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20/06/2023 04:04, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Avihai Horon <avihaih@nvidia.com>
>> Sent: Monday, June 19, 2023 7:14 PM
> ...
>>> a/hw/vfio/migration.c b/hw/vfio/migration.c index
>>> 6b58dddb8859..bc51aa765cb8 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -632,42 +632,41 @@ int64_t vfio_mig_bytes_transferred(void)
>>>       return bytes_transferred;
>>>   }
>>>
>>> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>>   {
>>> -    int ret = -ENOTSUP;
>>> +    int ret;
>>>
>>> -    if (!vbasedev->enable_migration) {
>>> +    if (!vbasedev->enable_migration || vfio_migration_init(vbasedev)) {
>>> +        error_setg(&vbasedev->migration_blocker,
>>> +                   "VFIO device doesn't support migration");
>>>           goto add_blocker;
>>>       }
>>>
>>> -    ret = vfio_migration_init(vbasedev);
>>> -    if (ret) {
>>> +    if (vfio_block_multiple_devices_migration(errp)) {
>>> +        error_setg(&vbasedev->migration_blocker,
>>> +                   "Migration is currently not supported with multiple "
>>> +                   "VFIO devices");
>>>           goto add_blocker;
>>>       }
>>
>> Here you are tying the multiple devices blocker to a specific device.
>> This could be problematic:
>> If you add vfio device #1 and then device #2 then the blocker will be added to
>> device #2. If you then remove device #1, migration will still be blocked
>> although it shouldn't.
>>
>> I think we should keep it as a global blocker and not a per-device blocker.
> 
> Thanks for point out, you are right, seems I need to restore the multiple devices part code.

It's the same for vIOMMU migration blocker. You could have a machine with
default_bus_bypass_iommu=on and add device #1 with bypass_iommu=off attribute in
pxb PCI port, and then add device #2 with bypass_iommu=on. The blocker is added
because of device #1 but then it will remain blocked if you remove it.

