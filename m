Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C9970DD53
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:17:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Rsp-0004q2-3N; Tue, 23 May 2023 09:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q1RsU-0004iV-QJ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:16:39 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q1RsS-0002sU-LP
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dHW5s58DpZEEy23aYy1s7su59mrkhAWZMLrBBQI+0bE=; b=TwB2bEBkxZtTs5bQacqgEA+cz6
 LJSzEIByoCugEDiuKWFP5wtuCVeoM7ETPQqhh8Ef/SEX5OGvOLg70Vm9Wo083Y70R91TXk4m9On72
 oXbuLwmrpxYVl+khfmehn03me3FbURW/CqBQhnA59/nJMuVYEDA7D3O6Ew54//Vb2saI=;
Message-ID: <11b3f40c-2b2a-1c90-9870-43227dbc375c@rev.ng>
Date: Tue, 23 May 2023 15:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] Hexagon (tests/tcg/hexagon) Clean up Hexagon check-tcg
 tests
Content-Language: en-US
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng,
 bcain@quicinc.com, quic_mathbern@quicinc.com, quic_mliebel@quicinc.com
References: <20230522174341.1805460-1-tsimpson@quicinc.com>
Organization: rev.ng
In-Reply-To: <20230522174341.1805460-1-tsimpson@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 5/22/23 19:43, Taylor Simpson wrote:
> Move test infra to header file
>      check functions (always print line number on error)
>      USR manipulation
>      Useful floating point values
> Use stdint.h types
> Use stdbool.h bool where appropriate
> Use trip counts local to for loop
>
> Suggested-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   tests/tcg/hexagon/hex_test.h             | 145 ++++++++++
>   tests/tcg/hexagon/atomics.c              |  51 ++--
>   tests/tcg/hexagon/brev.c                 |  73 +++--
>   tests/tcg/hexagon/circ.c                 | 152 +++++-----
>   tests/tcg/hexagon/dual_stores.c          |  25 +-
>   tests/tcg/hexagon/fpstuff.c              | 341 ++++++++++-------------
>   tests/tcg/hexagon/hex_sigsegv.c          |  46 +--
>   tests/tcg/hexagon/load_align.c           | 111 +++-----
>   tests/tcg/hexagon/load_unpack.c          | 159 +++++------
>   tests/tcg/hexagon/mem_noshuf.c           | 163 +++++------
>   tests/tcg/hexagon/mem_noshuf_exception.c |  52 ++--
>   tests/tcg/hexagon/misc.c                 | 338 +++++++++++-----------
>   tests/tcg/hexagon/multi_result.c         | 171 +++++-------
>   tests/tcg/hexagon/overflow.c             |  61 ++--
>   tests/tcg/hexagon/preg_alias.c           | 111 ++++----
>   tests/tcg/hexagon/read_write_overlap.c   |  55 ++--
>   tests/tcg/hexagon/reg_mut.c              |  54 ++--
>   tests/tcg/hexagon/usr.c                  | 109 +-------
>   tests/tcg/hexagon/Makefile.target        |  19 +-
>   19 files changed, 1030 insertions(+), 1206 deletions(-)
>   create mode 100644 tests/tcg/hexagon/hex_test.h
>
> diff --git a/tests/tcg/hexagon/fpstuff.c b/tests/tcg/hexagon/fpstuff.c
> index 28f9397155..344b9f7772 100644
> --- a/tests/tcg/hexagon/fpstuff.c
> +++ b/tests/tcg/hexagon/fpstuff.c
> @@ -20,91 +20,44 @@
>    */
>

Reviewed-by: Anton Johansson <anjo@rev.ng>
Tested-by: Anton Johansson <anjo@rev.ng>

