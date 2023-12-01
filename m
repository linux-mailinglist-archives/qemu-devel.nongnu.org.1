Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D1B800DAF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:49:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r94oJ-0000LB-US; Fri, 01 Dec 2023 09:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1r94oH-0000Ky-Qg
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:48:06 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1r94oG-0000Wm-1b
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cItUlszb7UJ5jinh2UMK9p+13dP0s9MpHbS1S895+a8=; b=uDqOhvEmFj0a1y5fmsFfIFwsF2
 T/rMqOC4CGdsCjAYh4ksOtCzC8MrK+/Lnp0EsJpGRSgfYXwG5ChUMsD+x9nK2ZYELYvWwGwq1Z1UT
 sZIrjj5RsDZHfIpMaC1xDoQ8VXYF43FR+gjX50+CVYX8X9XB6tbyh9D4hvKpQGG3wKvQ=;
Date: Fri, 1 Dec 2023 15:47:35 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 Alessandro Di Federico <ale@rev.ng>
Subject: Re: accel/tcg: Define TCG_GUEST_DEFAULT_MO in cpu-param.h?
Message-ID: <4vqr2qj4km6emwr3rwybcquilqlu44v3cb6p43megoi5qo26fd@w7diid5l4old>
References: <2ee26bcc-6f0c-4a83-a25b-4a1609466a04@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ee26bcc-6f0c-4a83-a25b-4a1609466a04@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 01/12/23, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Trying to restrict "cpu.h" to target-specific code,
> any objection to define TCG_GUEST_DEFAULT_MO (used in
> accel/tcg/) in cpu-param.h?
> 
> Thanks,
> 
> Phil.

Not from our end, seems like a good idea!

Btw, I've managed to get cputlb.c to compile once for all system mode 
targets. I'll submit an rfc once I've sorted out some failing tests.

//Anton

