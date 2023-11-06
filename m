Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 397627E2988
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:16:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02Gh-0004B4-Me; Mon, 06 Nov 2023 11:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r02Gc-00045p-W5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:15:59 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r02Ga-0004LW-Ep
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:15:58 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27ddc1b1652so4227707a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699287355; x=1699892155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4FKWy6tGAfs3oWKJTKqTf/FK/16LajqkDpCM7tfDZpg=;
 b=sxV4H2+gUbtunC/cGzwNR5cPdnYY8R8YF+6E6hM0wxQWqQITRs78aQoHjVuhV/rpZt
 UZACtTH4Jfc+/uawba+SytelvUR6NkQQX/dTQsl7TNrojDDs/6/QghCI62X/qRBhMnID
 c3g3jLXNu1hBUDZrt2J5ursvyXGTc/GuMw6T/Py8c+wyKtwBoVSUOPKtG1MPfY4kOGg6
 6IOSOP49/O+0uNYBkI+wjXQBvaZEnUi+ECiSCvtDZ/orQPtS/y0vnQaAaC6Hsds1PYsB
 SuQJtiS2QepnbwpSZC0wTMLc4FqMpcCDgRUTgCToBmFhyv8hV9RZWM+jjBLrrjPLVd7T
 TuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699287355; x=1699892155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4FKWy6tGAfs3oWKJTKqTf/FK/16LajqkDpCM7tfDZpg=;
 b=YbsJRO1YEyQkdWA+INQ+bRbzDrf06m294GxTDR6yr+zeqA1oadRcfjEoo1fUolUCuu
 TT+AJXV6pooH1myKnWem5w1UpICAZpymQUCXMWpFk8iqZcNV2MkyaKMRJeFy2aA518b6
 wg5lmI7P5QsgW4cDD3kpWdlLkXpEgToyPG7dEpecixNbEzDauQDuErPWRkVYobz1UqFG
 oonpyT+1/ibYEmBAz5rdivBETCgJnBoSNWXZ51SfVmHv/SkU3o0w2l/SHpB2ELozFD2r
 eFKwOvLFOxT16lazNlMyEBiQklZ+2Qb2D5aThUpHPRa2gaamlN7SBVwH9W0KsQxmbuK5
 yqxQ==
X-Gm-Message-State: AOJu0YxOHgtHBex1HovFSoBm+6erKlLeLIwbJs+54NOcgNgblrEe5rU2
 ckK79cSFEbrkdgUwBPp7Qqew0w==
X-Google-Smtp-Source: AGHT+IHJAd21uqKl+hhSoFaY6RGpUFJkMEDmHW74cyZAr9OkDblVg8SgjHYn3njRdfHVQHgGraOEdA==
X-Received: by 2002:a17:90b:4f91:b0:27d:3f0c:f087 with SMTP id
 qe17-20020a17090b4f9100b0027d3f0cf087mr28616204pjb.25.1699287354856; 
 Mon, 06 Nov 2023 08:15:54 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a17090ad50600b0027d219d3ac6sm5753089pju.47.2023.11.06.08.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:15:54 -0800 (PST)
Message-ID: <636ef27a-4b8f-42e3-b7a2-a8bb16cdad3c@linaro.org>
Date: Mon, 6 Nov 2023 08:15:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] tests/tcg/s390x: Test LAALG with negative cc_src
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20231106093605.1349201-1-iii@linux.ibm.com>
 <20231106093605.1349201-5-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231106093605.1349201-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/6/23 01:31, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/laalg.c         | 27 +++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+)
>   create mode 100644 tests/tcg/s390x/laalg.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

