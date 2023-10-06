Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB0C7BB055
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 04:38:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoaiU-00054u-1Z; Thu, 05 Oct 2023 22:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1qoaiR-00054i-Kr
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 22:37:23 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1qoaiO-0005AD-69
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 22:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail; t=1696559826; x=1696819026;
 bh=PWBdDG2H8VYvn9//gUfNO7dZ6OcU7NGsaMMKYIEpauA=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kPAbChMmMqDI2fRT0vbnz2GvtQ5fND6wJuOuBYmlzbnTQpkhso/Fa3+yGSfNaU5/4
 IkzZqM1WXj3IMQ8rjhmtyB2fdmLxczuf8D3KU3NVo5S7RZQeinAE6tlNHeADygKhrk
 1C+WaKIq1E7+4+t0sQsJWMX5RfLDfy82omSMyvf3GggPeFrjYuSr3wN+H0mHvCzxIG
 0mStpL8w8Qf/FUCjqEKLU0vbnWCwLnRxrbqMQYHXTAr2OPnv6hsxfUTMK/xgjeEJi/
 bfAe6NuwEwFiPFGCKN1+w+IF1Xlief+maW44wVjLwDzULuLgmVUxr9McTMk97q+xns
 szXCe8+XlnopQ==
Date: Fri, 06 Oct 2023 02:36:52 +0000
To: mjt@tls.msk.ru
From: Damien Zammit <damien@zamaudio.com>
Cc: damien@zamaudio.com, mst@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH qemu] timer/i8254: Fix one shot PIT mode
Message-ID: <57fad6fa-c27c-b534-c644-1f96318f8972@zamaudio.com>
Feedback-ID: 43209410:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.77.79.158; envelope-from=damien@zamaudio.com;
 helo=mail-0201.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>From: Michael Tokarev <mjt@tls.msk.ru>
>26.02.2023 04:58, Damien Zammit wrote:
>> Currently, the one-shot (mode 1) PIT expires far too quickly,
>> due to the output being set under the wrong logic.
>> This change fixes the one-shot PIT mode to behave similarly to mode 0.
>>=20
>> TESTED: using the one-shot PIT mode to calibrate a local apic timer.
>
>Has this been forgotten, or is it not needed anymore?

This is still required but nobody uses the
PIT one-shot mode (probably because it *is* currently broken).

Can it be merged?

Thanks,
Damien


