Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 475F579AB81
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfoHQ-0006VG-CZ; Mon, 11 Sep 2023 17:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfoHO-0006Up-45
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:17:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfoHK-0005qh-MD
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:17:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68fbb10dec7so1407813b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694467024; x=1695071824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t/6jRAUfYPCl01MpsZyW/MJchcnupdESzndqBpVBt04=;
 b=I4Lgpq07p7LlsbPepoKBkFm1bQynTwilYw6WQohNvfYwHv07BazeAmA9ZI6G4LLgqd
 sYUn+l37SnBfc3Ly3LGuU1IjBTPlIzlcmDxdFUrF9MJIER4qbyb5qFxq0LeJ4Ohk9AQZ
 IhZCuXDjFFT8bUD0VTktaqCB0G53dvABBGV6/CPmcV9zhXwfjBTh6isHWE3Y2edNj4Bt
 5+4Vf8tIlRDzqPFOz0PV67YchPAppWikH+VZFIz2sDOHpTYV7OeCXpirgcDF4CtBISCM
 7WgTt2sDTc714z4bPVtM84U21PnStaC+0pKasYMlkfSztNm98AVz6OhnAMueS5zwk4nG
 jARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694467024; x=1695071824;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t/6jRAUfYPCl01MpsZyW/MJchcnupdESzndqBpVBt04=;
 b=GgnpU20OgHYTHop8ISdZ8t/thOwgG/Y4gSt7/sY46mp/ztSPh0ZN+H295MkrqI3snU
 QsSzxDJqRF+N3fAIaeMKgZUlK+OCMs4hc3QH3rEDXsbtq/gN/t3XL/7Naoeak6ozozmh
 J2kQ89jpA6Hn2s9yfZStNot1xo+s1WC6sBuyIgcwVBNmD8izPW3t/+wTLUpMvKcbvB5m
 fiIEj7YIUYtU8Qc6e89f087ECo/xhsOFGWC7O+9f2PgCd5iETsGFhbrJ73pstWECU2da
 Ukwk55EoRmk2kQOln+Euk1BcVrjMYQBcXWeNAk0ZxfMX4ti2LvaLyWP+Rm5egjkToNys
 5bqA==
X-Gm-Message-State: AOJu0YwZeAA3dlcUmaKnkv/L9qK54p/6H3T3eQL1aoa07Y1XzcYKAv4q
 F39x4UskikKJD1xuwFxcz0w7yw==
X-Google-Smtp-Source: AGHT+IHiqBLbkCsDwND2wrw33CG+0xJGg3XLxpvEcHEWF7Ctq2QvDKbOLHvX21Y0VZML33rtGABfcQ==
X-Received: by 2002:a05:6a00:13a6:b0:68e:2822:fb36 with SMTP id
 t38-20020a056a0013a600b0068e2822fb36mr11262585pfg.8.1694467024042; 
 Mon, 11 Sep 2023 14:17:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 fm22-20020a056a002f9600b00679a4b56e41sm1967662pfb.43.2023.09.11.14.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 14:17:03 -0700 (PDT)
Message-ID: <e925d8cd-d82a-2478-236c-89deaa95c423@linaro.org>
Date: Mon, 11 Sep 2023 14:17:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 11/14] target/arm: Implement the SETG* instructions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-12-peter.maydell@linaro.org>
 <fbc33e98-2f8e-d503-c219-20c2b6eb02d2@linaro.org>
 <CAFEAcA8V_8wFpLJd7mNygEeU2iCdmMEZz4cXANXfwzD=FBGqkw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8V_8wFpLJd7mNygEeU2iCdmMEZz4cXANXfwzD=FBGqkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 9/11/23 07:17, Peter Maydell wrote:
>> I think it would be a little better if set_tags was visible to the compiler, via inlining,
>> so that all of the conditions can be folded away.
> 
> Do you mean having a separate triplet of helper functions
> for setg, which then call an inline function shared with
> the normal setp/setm/sete to do the actual work, rather than
> passing "is this setg" via the syndrome ?

Yes.


r~


