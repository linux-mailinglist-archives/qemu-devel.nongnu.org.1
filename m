Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 929097E799C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 07:53:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1LNZ-0008M8-Gh; Fri, 10 Nov 2023 01:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=s8KG=GX=kaod.org=clg@ozlabs.org>)
 id 1r1LNW-0008Lq-NH; Fri, 10 Nov 2023 01:52:30 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=s8KG=GX=kaod.org=clg@ozlabs.org>)
 id 1r1LNU-0008Mg-88; Fri, 10 Nov 2023 01:52:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SRTyp3w6pz4wd2;
 Fri, 10 Nov 2023 17:52:18 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SRTym55tGz4wd1;
 Fri, 10 Nov 2023 17:52:16 +1100 (AEDT)
Message-ID: <5cc3d394-b9d0-4926-bc99-3999faf3e5f1@kaod.org>
Date: Fri, 10 Nov 2023 07:52:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Content-Language: en-US
To: John Platts <john_platts@hotmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Cc: "npiggin@gmail.com" <npiggin@gmail.com>,
 "danielhb413@gmail.com" <danielhb413@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB583760D0AEB19A3516E216329DAFA@SN6PR05MB5837.namprd05.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SN6PR05MB583760D0AEB19A3516E216329DAFA@SN6PR05MB5837.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=s8KG=GX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Hello John,

On 11/9/23 23:18, John Platts wrote:
> What is the status of integrating the fixes to the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros in target/ppc/fpu_helper.c?

You sent a couple of times the same patch :
  
  https://patchwork.ozlabs.org/project/qemu-ppc/list/?submitter=87426

I suppose v3 is the one to consider.

> 
> The bug that is currently there with the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros is that float_invalid_cvt is incorrectly called if the current source value is a non-NaN value and a previous NaN source value from the same source vector was encountered.
> 
> The link to a patch that fixes the above bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros can be found at https://patchew.org/QEMU/SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com/.
> 
> A description of this bug can be found at https://gitlab.com/qemu-project/qemu/-/issues/1941.
> 
> Here is a link to a test program that will detect the bugs that are currently there with the emulation of the xvcvspsxws, xvcvspuxws, xvcvspsxds, xvcvspuxds, xvcvdpsxws, xvcvdpuxws, xvcvdpsxds, and xvcvdpuxds instructions if the source vector contains at least one NaN value:
> https://gitlab.com/qemu-project/qemu/uploads/fcbb97896ff2f4ab435affae94467f4d/vsx_f2i_nan_test_102523.c

If you have time, could you please respin a v4 and include the
test case under tests/tcg/ppc64 ? Please add a Fixes: tag with
the commit id also.

The plan is to merge fixes, such as this one, in the coming weeks,
and I will send one PPC PR before the end of the 8.2 cycle.

Thanks,

C.


