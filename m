Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B073AC72
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 00:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSdd-0002F3-E0; Thu, 22 Jun 2023 18:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSdb-0002Eu-AV
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 18:18:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSdZ-0008Dz-0e
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 18:18:47 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MM4uB2003436; Thu, 22 Jun 2023 22:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DVVEojPVZS1BXn28hDA9p2ozdQnkWSc+5h20ug8xc8g=;
 b=xc23MJC0bnpfcCPDQ5eX6GK6wRWap8JQYn7zFS6VPW4JueSNsDdXugRHcG3a8p9bT1wn
 1Zl4G9q6Ka7EyuDQ0UMQxqB8iVo1KRdqaVhECH7UVR0AgCtAd0iBRbtVsX5wmWxGsrpL
 1piHvAb3re4hRLvHYkhrpGpZ6sgl6lHyRqwA/Q+/n3KlkJci9dQvpu3HRPc4MFZQg7H3
 lgAXNS4fuIfgp69KHPbJj7YVj4W+RMQjmqAJeWablvF+I5bu8/Euuu9+WNdaoFYyJmZi
 FKpg/fhPfRpXTovwG4uPQeJFKiYs9mO3vajjdlI3N3BrDSgtljzRIlfJtPRCjr8Ei3Fv Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbtx22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 22:18:38 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MKqPno028861; Thu, 22 Jun 2023 22:18:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r939e76kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 22:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5OVwMjlHR+DUp2LUlOq5HKRltYv3XJW+OqNKxMi0+SVj1zyDAgSpRXyzaaQm17k140nfGnFdlShEi9wv6Eg/wMoMQI4PJb6YcRIULecq4csdiwbAYhNuwqOHPEV6RLqgyw0DDjCWLDQobt2FVvsqrz+kYMudnjown6G/sFA2yrYqmBuZqvsytCUPM+iNohvtUJkbQbT8nu8XhfsMWDHHJQpaCxFwaRNlti+IlErrXMPNa3JW6VoVkLADNhK+2hULG8fnMuB8lnimwJd8gOUs9M0XSaA35J6BQLtAxrpuR51SLRTaTXOEO8ercsNt3sMgv0hLm/IAGBKV3lSNkbIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVVEojPVZS1BXn28hDA9p2ozdQnkWSc+5h20ug8xc8g=;
 b=OsegjEqvOAvxa9SqtbWn6yK0oXr6pJsc8Jmi3Vkk9vujQJ7/7gmuCd5aR2+7qoaF4ceaFxvbPqxsalYU0rVPCq4zHduyiQvlIdjzVZBMqZbZkx3XwONLtmG0tzcFIK2sQmrPEdWyk2538V1MtFglr07/CeJA6tWpy5dyXZmImFmDsBlHG4pGgAMYosj+9FkVSyBUz5E6bh13iQ23hQy3DtrNsR2zJeLvXUNb0nGEFTn5q14ZYmgzWIJ4WxvkS8UJm0Fwc4LeY8K5e2cCQlUaon2+ZpOeqpEfVztmT0ckgMh/tAorJArx/vaGwnA+J543JglvRcr7P+sSYNcrw8/EFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVVEojPVZS1BXn28hDA9p2ozdQnkWSc+5h20ug8xc8g=;
 b=uJscZcbzEkIIkc8bUmSBOIdteP+sEUaIBqmSSScjq3NlVNKTDHHSRH+YasG9WKtRGhBtmfyrq8bUqgMDa1W8VLh+uUWOAWlOdIZzC2Gd/UvdGFI+PD/Q2f8IVPUz5TUZID8wgFl/K8yhlJesH465QJtIHMD74MpwnUWMf6/gLo4=
Received: from DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 22:18:25 +0000
Received: from DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::4f55:49b6:d081:f58f]) by DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::4f55:49b6:d081:f58f%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 22:18:24 +0000
Message-ID: <0944d783-60cf-a627-a7c2-daee2f07edd1@oracle.com>
Date: Thu, 22 Jun 2023 23:18:17 +0100
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::33) To DS7PR10MB4846.namprd10.prod.outlook.com
 (2603:10b6:5:38c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4846:EE_|BLAPR10MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: c856b2a6-674e-42eb-21b7-08db736e9892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp7xT2SBiR0YadJRlMiM5mFw4dykDiaK3DDncd98iI8JFlBY4D8cPMk9qJLg4qpinwpaTqHsInI/di44dF/gIDe6KxOp0Nb/gEbQBq0Vvgcdd+Iku/n+s8y36FHWdOdrXPon0PERVQ0P24zBlvVl415rpYdZELsoYixvO+JtuOjNM6ZdbwquDa9Lwqy8T9r+VS7BtV8tyi4oKcpvAm+vRg4QpA14n38h/wQFpMlPDLj22PEGnRdfNK+ftMIA6T0FWe3NtG2VTCCIBBVRhNyPZg4FgcpGenWzbc2D4Vetdqu9dvhghjErIw0I2KTMVdts0fPcI3+QiIfePjKjfr+2rW9RfYYVuywT7Yk6vS1V2sj7e7LP/MDCDIKCln/a8PRBD2/9eVbGEXtbsHq5XnYZyEjCPxMPg4/cJ2vHF/7WrkOl3rsWJijL3c2QmkTB9SKGf/ksoKf8f4OyB79+S9AqJ5SK7ef9cMG7AOMkaZp07soZYqSuZwr0Jglx5INmPFyw7B0dHbPEpm/iaDExOPMJj6PAcy7o6ZGeX3KcADw+w525rsq6AIJk8lqhiYnjY0p2O/xSM8N7voOhkOsXEE3qLgDU60DgVLWVEg/zOLdsS2hMnmEumC87J4fkqfwtP4N2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4846.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2906002)(6916009)(36756003)(66574015)(66556008)(83380400001)(4326008)(66476007)(2616005)(54906003)(31696002)(316002)(66946007)(86362001)(478600001)(6486002)(41300700001)(6666004)(38100700002)(8676002)(6506007)(6512007)(26005)(8936002)(7416002)(186003)(5660300002)(31686004)(66899021)(53546011)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2tlZFVJWE5zU3Noejlsa3BkUkpRTGdRL2JzdHR4OFNZSUU4T1BpV1BTcW50?=
 =?utf-8?B?SEgrOW5VQ2xYaW1Yb0ZBVjU5ODZWZ0ZCbWNIQnJjQmlNNkJQRkxoSUE2K3pu?=
 =?utf-8?B?RHgyUW42clpEcVh4Q3U0YkYvVVBUVFBNdU1FWTI2RXVXOVNLUlg5WFJTTWRN?=
 =?utf-8?B?UjJCWGp4TEdNMVdHaU1PcjUxYXNZUE1oeW5KWERNSjc1Ui9BNVA3SHJxYUkx?=
 =?utf-8?B?ME0zNCtUSExVMURYK2REdTBnY2w4a2lMK0FwQkg2dm5OcXhVbDNmdnNUMlpM?=
 =?utf-8?B?VUk4QmpwVzZMK2R3ZHlkV0o2Tk1pZCt1UTVvWFVoekQzZ2hHaElkeHIzSW1y?=
 =?utf-8?B?c00xazc4dnZNdEY4OHdSOW9URGdjcWhSdzM1U0swS241bTZiRWJZOE1OVGk3?=
 =?utf-8?B?OFZpazhOMjNCM1hRbUk5UEJqdXRyT3FZT0xyQzZHTWxYSWI5U2QxckVxWWVy?=
 =?utf-8?B?MS93OWV1Zm5CS0Z5bUtlTGo4VTA5L01VVENlK1BMSTIxRXEyVDM4QzlQU3Ru?=
 =?utf-8?B?emxYbFgrQWFRWlJ2WW55WjR2MW9rVmQ3TUtSWFdqbWwySXZEMFBhcnhqTG9p?=
 =?utf-8?B?TEZCNFVKVG00SkpsUkFkUWJzdEh3bG1QTUpGdHNQcjlKbDV0aTFEajVLSEJz?=
 =?utf-8?B?MC9zV3BLNkZpRmNqTld1YlpGRGxGcWtwNDJzcnBneVBFbGhpakJuTysycGNZ?=
 =?utf-8?B?VWV2SzNsMUVZZDJhOHRJcjJJb05DRitYSzRRQ0VWMHEvOW9pU0VEQk1wS0pa?=
 =?utf-8?B?TWdZT3B0ZDdoRFdIQTRLRzEyY0Q5VndrQ3N0eDJKbERRYlVHbmVXMDdvZ3lC?=
 =?utf-8?B?OUZFTG1jQU1GVGFaS1ZBVU96THlDR2VSQWN2OFQxdmNKejRoMTRKeEp2cXIy?=
 =?utf-8?B?cU4zTEY0SkM4WG45bWwwRUpKNnRYVDNzVXZZZW5RV3JQUDIrbW9WdEhIYzJr?=
 =?utf-8?B?VXg2Z29laGF3Y0M5eWNRcVJ5bVdIdW5xUFh0Zkh6L0YybmZqNStXY3JtSkkw?=
 =?utf-8?B?b1JvcHBXYURmdGdQRmVZOGF4L3hIT1FWZlIwNVVvMzcxYUhDVzdTbWcrUW9Y?=
 =?utf-8?B?MVJqN3RVNHYyQlg5MUo1N1BCWkQxN0NOMngzNWs2RmxNOXhhSk8vYjU1NXJB?=
 =?utf-8?B?Q2pPYTlEa2VRK0Y1WGdzQ2xvdVl3NzIwU1FMNGkzU1MrQ1ptTHlPVlVIVkQx?=
 =?utf-8?B?V0w3OUUxeEN3bXQ0bmV0U3p1NG0xVVBXSDhnMjd3eE1QYk5zWnlINkRLVmNi?=
 =?utf-8?B?QlEwcFN0SDJqbjFXbXp3WmQyRS9aUVlhS3NTTFVuY2dUeWdXQnFHVzZTU0lP?=
 =?utf-8?B?Lytwc1ZwdU9IMlRaeXAxbktjeVN5cUhZQWZGWjJORGFKby9lSWQyVU5KaGJX?=
 =?utf-8?B?KzkweUdreXlvSm5obDAxd3pBcWptZWdPUzEwcUdFc3l1ZHZpeHJ0WkcwTElh?=
 =?utf-8?B?bU95RDhHMGtKeE5UeE53VS94ZVlvRThpZlVwK3lzL3ZFYkt4bnVzZXNTYTVO?=
 =?utf-8?B?bmgyNk5Vczh1Qy9RS3lSZ0pnMHRraHhMUVo4SlRMRHN3bDJlc3I5cTdUaEx1?=
 =?utf-8?B?dU1NTlp3WDYvdmJEVVpKV2NCcm5HWUNMVUNseisyQWV4SVF4aWlidks3OTNs?=
 =?utf-8?B?QTV6bFpVZG8rL1RHRS9Zc21lVTBxTTVNWjhEZnBuUmJSNEF1NEVDY01CbTRu?=
 =?utf-8?B?bGg5TE5wQmhQVTFoOUdVakNPTkovNmdIbzdWZEZNcTBjM0tNenR4Ny9FMzdE?=
 =?utf-8?B?bHdPWVNuK0xBUHhuZEF0Sml0a00rTU14Zy9SaWlzR3N1aXVmdlNHN0pySzRq?=
 =?utf-8?B?OTZRUFUvdFZjQ1RlazZnclNUYW9EOTFMZEdTWGsya2lwU3lDejg4aTV1Vktn?=
 =?utf-8?B?eUt0M1NsQ0pBdnVpQ2FjTDMzNjdoUWRHTzFPelIxaGdsRUZadVVmSUs3UmZE?=
 =?utf-8?B?ZmNlb1FwQzVKT1YyZTFReXZKZzR3bVVEc0VqQTZqL0UxVGhsaktPdkdSNXdl?=
 =?utf-8?B?UlVHOVpLYU9FeUlyK3J4ajhybXhxWWRzMzBXYXJzZm5aMWFYWnRmNGxpWnZB?=
 =?utf-8?B?R05UYVhWMFIzZVFwZWpjcVI0QU15ZWZsMXd2VlFZam1WWlNycFBBYzJiMk9p?=
 =?utf-8?B?M2hVY3NnWWRZdjhkSk5ES2QvQWlNb244MmhDZFV0ZlhIaUgwSUI0Z3pIaUtK?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: srlV3VRJzG7vTRTlmQubjVIf8QQ/SS+opnvKe0HN0Im9Z0h3S96ApwgViPzM7LiVdJCIX6FeYKW4kRjEHURmLk0YWOoKeSntT/20GuDt2sKVaX+hDAfhEpTL2RfsfNype9OoIx0KlNoA7yJZf/VBPLHP5f+UzjMJ2e/I9jNKvYKMhD2MfgQPRm1QdBcIuH2XBzNCQGdL51Jh4kEhGkYX6UwA30simpcAJH83YBpZ4CZzb3dFDuUp32C4pC7y5iuUGjCCfqMeCLRWqA0l7oDX8sUxb/ZbZN6I+itorxz0icjFdzaT0/lpw1hLHdg3OTSzclRvsd1Fg7tV4CwReM/vNohgCrgvwAY4jlHdYyyzA2zxnDn3iOLW5LlGhGbWnoBb3TqZqHBm1mEpGCAhZopR09x6JTd0kdNElDOxF8DuQ255hKVw+Aw5t/HL+uc2M6cpsdY0BplUBhpjSPocvzXrCd+90h9sICy3RmSoEh8J5UjN4IDe/ty+4ObHRUIW/SXheG2Z+0E4YKC96koRmVvpt9Kr7/plM+970CEwwp0Aml2sFCeDnXd8nQ6hKo0EKOCn6lu+BvEJEbCpvG6oPSbWenlNij85bvMlpmLIfQSTPN+ARw64REMZvxlr85E1SUACXw04RgaAk8v4p/59eRmOHGg7NNcrN62e1ZwNyuuXuj0KUECCe+f5Z6IMiBj6ibqdiDi/gNAcK6/Db+lXv1Oo2ZdWneYlN9GgZjJdsQLU8Vz7O/hlLSoKYg7quRSBmfhh8kQaRFo7dt3yBYyO4MIbGplt7nnkgXiojheE7kK/9+IGAXwYRRsir2U9Qk9b+FDdWgIEZtUPXp2GqJXfbV+KU/A78JBOK34LKjPh+ncz7M1XOXXI4Er9LfCmLlgE/dvp0jliXM5Fy0lGBxaOmGRSSPZfuED/PJXu7m1Sur9NTTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c856b2a6-674e-42eb-21b7-08db736e9892
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4846.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 22:18:24.8369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAFObt/da5YL2lHw3WQ/ZXHMhNmfjWq5B2HT3TCWSbSECsOeeyvEAOZcQkQHqVp73zlynPVW62+WEzZYVyPoJrTpLZud/oBfgiXTIF3CM3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220191
X-Proofpoint-ORIG-GUID: _xWFAArPbZzWkHztBYLwOGIZyBuZVICA
X-Proofpoint-GUID: _xWFAArPbZzWkHztBYLwOGIZyBuZVICA
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 22/06/2023 22:48, Joao Martins wrote:
> Hey,
> 
> This series introduces support for vIOMMU with VFIO device migration,
> particurlarly related to how we do the dirty page tracking.
> 
> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
> provide dma translation services for guests to provide some form of
> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
> required for big VMs with VFs with more than 255 vcpus. We tackle both
> and remove the migration blocker when vIOMMU is present provided the
> conditions are met. I have both use-cases here in one series, but I am happy
> to tackle them in separate series.
> 
> As I found out we don't necessarily need to expose the whole vIOMMU
> functionality in order to just support interrupt remapping. x86 IOMMUs
> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
> can instantiate a IOMMU just for interrupt remapping without needing to
> be advertised/support DMA translation. AMD IOMMU in theory can provide
> the same, but Linux doesn't quite support the IR-only part there yet,
> only intel-iommu.
> 
> The series is organized as following:
> 
> Patches 1-5: Today we can't gather vIOMMU details before the guest
> establishes their first DMA mapping via the vIOMMU. So these first four
> patches add a way for vIOMMUs to be asked of their properties at start
> of day. I choose the least churn possible way for now (as opposed to a
> treewide conversion) and allow easy conversion a posteriori. As
> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
> allows us to fetch PCI backing vIOMMU attributes, without necessarily
> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
> was doing in v3.
> 
> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
> DMA translation allowed. Today the 'dma-translation' attribute is
> x86-iommu only, but the way this series is structured nothing stops from
> other vIOMMUs supporting it too as long as they use
> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
> we've then tackled item (1) of the second paragraph.
> 
> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
> IOVA address space, leveraging the logic we use to compose the dirty ranges.
> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
> addressing limits. This tackles item (2). So far I mainly use it with
> intel-iommu, although I have a small set of patches for virtio-iommu per
> Alex's suggestion in v2.
> 
> Comments, suggestions welcome. Thanks for the review!
> 

By mistake, I've spuriously sent this a little too early. There's some styling
errors in patch 1, 6 and 10. I've fixed the problems already, but I won't respin
the series as I don't wanna patch bomb folks again. I will give at least a week
or 2 before I do that. My apologies :/

Meanwhile, here's the diff of those fixes:

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 989993e303a6..7fad59126215 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3880,7 +3880,7 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
     {
         hwaddr *max_iova = (hwaddr *)(uintptr_t) data;

-        *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);;
+        *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);
         break;
     }
     default:
@@ -4071,8 +4071,9 @@ static int vtd_get_iommu_attr(PCIBus *bus, void *opaque,
int32_t devfn,
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);

     vtd_as = vtd_find_add_as(s, bus, devfn, PCI_NO_PASID);
-    if (!vtd_as)
-       return -EINVAL;
+    if (!vtd_as) {
+        return -EINVAL;
+    }

     return memory_region_iommu_get_attr(&vtd_as->iommu, attr, data);
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 91ba6f0927a4..0cf000a9c1ff 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2700,10 +2700,10 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
     if (!pci_bus_bypass_iommu(bus) && iommu_bus) {
         if (iommu_bus->iommu_fn) {
-           return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
+            return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
         } else if (iommu_bus->iommu_ops &&
                    iommu_bus->iommu_ops->get_address_space) {
-           return iommu_bus->iommu_ops->get_address_space(bus,
+            return iommu_bus->iommu_ops->get_address_space(bus,
                                            iommu_bus->iommu_opaque, devfn);
         }
     }

