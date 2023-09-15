Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1297E7A1E9D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:24:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7qW-0003Lo-0J; Fri, 15 Sep 2023 08:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh7qT-0003LK-Bf
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:22:49 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qh7qK-0002Ik-UB
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=irpleKcRZzERsgwckCs+nWBmQ1PsU03yTyabRRYHzGk=; b=ghhjoizawvwAjDyXRoPqdMqqtz
 Q4HXXxOK0SPAmjcKchoIx1rR/PHTRSrIzLH8UV7b4gScpIey4etKaD5SznY4230jgOAAIDgbxmWr1
 RNyLCNgZbZ+4CD+BHP8eYQHnHQ4I7ApI0YcQ3eshlVb9XjrCgeDXTdDyEloCZ//TQz5w=;
Date: Fri, 15 Sep 2023 14:22:20 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Alessandro Di Federico <ale@rev.ng>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 00/11] accel/tcg: Make more files target agnostic (&
 exec/ housekeeping)
Message-ID: <ua62nmnpt4sclbgrsz5nfaf3av3byowuzabxsklm56nvw7ndtt@ry3k62zheawt>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 14/09/23, Philippe Mathieu-Daudé wrote:
> While reviewing Anton/Richard series [*] it was a bit hard
> for me to figure out which headers are target specific and
> "taint" the source which include them, in that we can not
> compile them once for all targets.
> 
> My understanding is -all.h suffix is a target specific header,
> and -common.c is a target agnostic file. I tried to consolidate
> a bit renaming some files with the -target.c suffix (I'd like
> to rename -all.h -> .target.h for parity / clarity, but that
> is too much code churn at this point).

Nice, very much appreciated, I've also been struggling a bit with 
keeping track of especially target-agnostic/dependent headers.

-- 
Anton Johansson
rev.ng Labs Srl.

