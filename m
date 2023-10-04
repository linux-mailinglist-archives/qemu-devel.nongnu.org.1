Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B737B8342
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3Xn-00029x-JZ; Wed, 04 Oct 2023 11:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qo3Xl-00025s-0o
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:12:09 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qo3Xj-000254-BK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MtlAgjzH0mooShSNYxz3APPHnC6Tw2U5G9Z8CAARVX8=; b=e90sbcK/UVMvvvF8uaoNbYMtpF
 V10sgXqJM2RlMZoXLEvxR/i6qYbGT4+DcDp/Ei/lfS10UPpZbIcPOGypeCgPHqJTF4UHoNrb9Mm8N
 lGwYQyJMk+oa5mbQW7peC8jy/38J+n33kW/CAI1K6whQb9FMItW48Z7C3He99hAUTz9s=;
Date: Wed, 4 Oct 2023 17:11:34 +0200
To: Brian Cain <bcain@quicinc.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org, 
 philmd@linaro.org, peter.maydell@linaro.org, quic_mathbern@quicinc.com, 
 stefanha@redhat.com, ale@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com
Subject: Re: [PATCH 0/2] Fix usage of GETPC(), variable shadowing
Message-ID: <6sjolxezgdzyjz26brymfvzan5dwaltvkkdbuxzixxttvpe4ft@yd2j65m7fcld>
References: <20231004123957.1732915-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004123957.1732915-1-bcain@quicinc.com>
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

On 04/10/23, Brian Cain wrote:
> Matheus' patch has previously been reviewed, but I based my -Wshadow
> patch on his.  So I'm submitting the series for review.
> 
> Brian Cain (1):
>   target/hexagon: fix some occurrences of -Wshadow=local
> 
> Matheus Tavares Bernardino (1):
>   target/hexagon: move GETPC() calls to top level helpers
> 
>  target/hexagon/imported/alu.idef |  6 +--
>  target/hexagon/macros.h          | 19 ++++----
>  target/hexagon/mmvec/macros.h    |  2 +-
>  target/hexagon/op_helper.c       | 84 ++++++++++++--------------------
>  target/hexagon/op_helper.h       |  9 ----
>  target/hexagon/translate.c       | 10 ++--
>  6 files changed, 50 insertions(+), 80 deletions(-)
> 
> -- 
> 2.25.1
> 

Both patches:
Reviewed-by: Anton Johansson <anjo@rev.ng>
Tested-by: Anton Johansson <anjo@rev.ng>

