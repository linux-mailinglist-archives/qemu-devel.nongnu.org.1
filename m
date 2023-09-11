Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 819E179A721
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:12:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdtP-0005X3-Qw; Mon, 11 Sep 2023 06:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfdtN-0005VR-U3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:11:41 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfdtL-0001Bc-Ne
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:11:41 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b962c226ceso70482611fa.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694427097; x=1695031897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/3lVEHOxDAbrY9hHe/9AdIsfb47d/TxD01cBh4Uteg=;
 b=kZ/XING0hIomXXsmRIQl6EwljmGzPZY5pnv6hjgjBTR0h6jGwUoESNes5AAeTSO8Ds
 THKBfKwpZrkB4etV1w/EYK3VWJ41RqyXpPwVmu1s5GYWxiIPPvaC4VC/E8ols+WKjOFB
 AArthNsocgNv49QgB9mbu/Mm1EAZCzTwBp1k4bOcDskbBIfF2C4kJ/QuuhyDbRc6w7yw
 RQycZS9a8kHEeDqVYRNnrG0tpMQCeGSGIEkaBJRqUo/0WNuEu7kc9fm3YWrEqdMp99v/
 LuAwbHh4Y3v2O1MWV+SE72ySrbZN76jTrF8Q7NNwzm2dWTbs7lIoRwOWoKDFAVnAti7s
 rR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694427097; x=1695031897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E/3lVEHOxDAbrY9hHe/9AdIsfb47d/TxD01cBh4Uteg=;
 b=SOfCPSwzVkiGccANV8sSQYTn2kBQ7bm27ukrGnWLPFP+E4QNll6WCQDwcTdT0TVVsZ
 P2ckANKZHdDjcHC9bgqz5YRCKvx1fNqyv6sxj9OS0NrB+DLnExBzuabcva6TrhVXoaXt
 +ZcvGcZEFqLKbBM+cjTxK6z2cXhkpFkOL8smflTjoPqApQpTo4Neu2E962LeDHA/GtfS
 rKm1A6i6b6L9zRh2Sn41ezLDW1S/wvaCTPKeQgh9LkeFwRdGtwGA82Babc7ifhjP0n4/
 89PDlp2RlwP3K7OHJ6O1vdHUFxs2tozblbka4PI2xawzpgMcNImXCKKdgOrPo3eESYIN
 Uibw==
X-Gm-Message-State: AOJu0YxyNmoc8cO2UtfPbSL8HyMtbPGYJ/wfALR/Lr5+XsfcrAGPnPnB
 Y3De93VbA+al7f3UQs2N7vUYBQ==
X-Google-Smtp-Source: AGHT+IGNM07jkYGHAWpf6OQt9cRCfCcFnC/MxNn13SOlkj8SFtk4U5HAj5qQ+ReEEptOO2wvIoFtOw==
X-Received: by 2002:a2e:9988:0:b0:2b4:5cad:f246 with SMTP id
 w8-20020a2e9988000000b002b45cadf246mr6919128lji.7.1694427097167; 
 Mon, 11 Sep 2023 03:11:37 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 mb8-20020a170906eb0800b00992b71d8f19sm5068173ejb.133.2023.09.11.03.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 03:11:36 -0700 (PDT)
Message-ID: <ec32b24d-9ca1-3436-0c7b-5e3ce1ee27da@linaro.org>
Date: Mon, 11 Sep 2023 12:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <521ab2c6-f617-1a9e-fef6-29add2e62137@linaro.org>
 <ZPtW4PXsVTo83IpN@redhat.com> <ZPtZvXcQhIWA3Iu0@redhat.com>
 <CABgObfaNCLDWXYN82Qxus3wothUdOu9C_dh_7aw16x8NfWSOsQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CABgObfaNCLDWXYN82Qxus3wothUdOu9C_dh_7aw16x8NfWSOsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/9/23 21:21, Paolo Bonzini wrote:
> On Fri, Sep 8, 2023 at 7:28 PM Kevin Wolf <kwolf@redhat.com> wrote:
>> Maybe the calls aren't eliminated because --enable-debug implies -O0?
> 
> My experience is that it will still fold simple dead code like "0 &&
> foo()" or even "if (0) { ... }", but maybe it's a GCC vs. clang
> difference. Philippe, I take it that you are looking at it?

Yes, I'll send a patch soon. Sorry I didn't catch that case.


