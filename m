Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDD57474AF
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:02:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhXw-0005Qk-0F; Tue, 04 Jul 2023 11:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGhXX-0005M7-IL
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:02:06 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGhXU-0005mf-Pf
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:02:03 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51d9890f368so6376587a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482918; x=1691074918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJNdG3kc+XhhTJZGszgqViT985Cu75mIYQQW0+ON9MQ=;
 b=wRTAlAefM6jEPCWDIgbIkEAtaBzf/xq2LXLY/IchV6fUMmm2/oL35ru0LhD4Cc5Cnq
 NaUGc1Wj2utE551LeBzEr10fHjXyCBYRAq/aCtdIYrdobqcIpw3foiiKmiqTRQ4CUJPe
 9ARNN8FCdPE5zcgjMJqX5PZBgo7j2UtI9DOqMLC3GYM2Z/A+sJeq9ehqsI497Kjiif1T
 GKZcMMS9kxiGCroUwJkNnfl0EPr0gsZwajmiKTBbt/a+XusN0a9FUn3WkNRdkMPfJNdl
 2e+kzNjsEmF+omfZ/u/VmqVP3ROVvdla4XAqKMtsg8oCR5lHREKIPSTdjBpMQf/5wEZT
 j8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482918; x=1691074918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJNdG3kc+XhhTJZGszgqViT985Cu75mIYQQW0+ON9MQ=;
 b=DE7149vehk33L9/XeKm6csJ1DIFNCeB4sUO5wvzhuOBRY4Buu1iCcYCeNVSAbEYOZ2
 d9PHagRTv6yVrKLvVS7MLlutdXL1ADdo7P8tLRTV64Zm+vr39aubEV6MB9cJjQQkUCWr
 4iJLdAwzoHkgWETbNIfsV7mLe/aOTx305f9NZ76rQfTSjamqBgrMFOhPrvtfb5nrtOpX
 dof3bluqihUCGooHooIjWPFUbXKnvOJKGZsIR54xAfYuWCrwCbhFY3tIb9TsXUlMFFXY
 1L4tnyb2/rgyXsCiXdxo5DFbp8hfm2RBjAVakZskCfWSLhz5oExGc9P6bDK1w8Xzm9Fh
 IAtw==
X-Gm-Message-State: ABy/qLbCqXV78pufv80rbaPH0wx4b48QTlLGcOnnOB7/NJbuwguhvukf
 bUwy8mH/wbb7lGPEHe0lLiYI+KN7xxPydxYF9sI6sA==
X-Google-Smtp-Source: APBJJlGUVecw6ef2AnOkqxzLgjolFM2onXbfyP/SxMGDqviT6cyyjaBmimxafNFXSqwfZn8zLKRAEz+JRQpdostJpBw=
X-Received: by 2002:aa7:c1c4:0:b0:51d:e4c5:7910 with SMTP id
 d4-20020aa7c1c4000000b0051de4c57910mr9835655edp.14.1688482918379; Tue, 04 Jul
 2023 08:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
In-Reply-To: <20230609172324.982888-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 16:01:47 +0100
Message-ID: <CAFEAcA9zB_SRVTmMAJpQ9K3gryPsYhJJYU7ZDxsaFsQpb1Up3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Implement Most ARMv8.3 Pointer Authentication
 Features
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Vincent Dehors <vincent.dehors@smile.fr>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 9 Jun 2023 at 18:23, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> Changes from v2 of this patchset [0]:
> - Remove properties for EPAC, Pauth2, FPAC, FPACCombined
> - Separate out aa64isar2 addition into its own patch
> - Comment clarifications
> - Several code formatting/simplifications
> - Rebase on top of latest upstream changes (for example, those which
>   reorganized decoding PAC branch instructions)
>
> [0] - https://lists.nongnu.org/archive/html/qemu-devel/2023-02/msg06494.html

I was looking at trying to bring this into target-arm.next,
since the changes in patches 1 and 2 for code review
comments are not large. However I found that it fails
"make check":

ERROR:../../tests/qtest/arm-cpu-features.c:425:pauth_tests_default:
assertion failed: (g_str_equal(_error, "cannot enable pauth-impdef
without pauth"))

as a result of patch 8's changes to the handling
of the CPU pauth related properties.

The assertion seems to be because patch 8 has changed
the error string to something different from that which
the test case is looking for.

Patch 8 needs to also update the test case to include
testing of the handling of the new properties it adds.

thanks
-- PMM

