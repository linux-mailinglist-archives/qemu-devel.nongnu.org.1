Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F87B6DEB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 18:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhrA-0000Ja-0J; Tue, 03 Oct 2023 12:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnhr7-0000IN-Sq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 12:02:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnhr6-0007C6-DZ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 12:02:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c5db4925f9so8310005ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696348958; x=1696953758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sVV/60md6UTA8bNGRck53WOsmLRvjYk6hRbd3CAsgEY=;
 b=W08Gf07MFg6n/QX29GBsYBD1/zrEfOdTVM43Xskrl3Gmer18M7ZuB7M4sUCC3XUvQ1
 Iju94X6khlQspnuB9dHuBc4kAM///wCvSzwRM0+/Gt9inb+rYXkOVy/d9F4Tyio7oGja
 sDGG4eZFlXeiDLmzVB/6Jrz5dWRhmYnQ2PRnGfGx7IYLUNaOi4qiLMOox1m7YEHbOGxP
 rYTjiJQ0lqSsrgV+LqbQOkEul0cJhT3kLPggHOPyhBuZtNCLOK+SdqUyoWPmmTDNPi4b
 tsn8UwbBNq+rYyEKR9ZLwh+8O2UJ05jpSOgy8dRh7QGVwJfDE7tZ9vZBOT0JOa0CNByJ
 YjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696348958; x=1696953758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sVV/60md6UTA8bNGRck53WOsmLRvjYk6hRbd3CAsgEY=;
 b=ksLXqBIqm5gWCa/8cfoc+SrmrmBgbUq8O0ResRXPHp+6fFJ9fjIhxx468p3iDQ9Ksu
 GfF5yhU7+JKt1l/hHnQn4T9IZVW/lYLx/UZSu7Al+E3kVvbdPHq/zccjLX2GMAjPw/z8
 xn4u2/V4/2HN0P299xHhrhFtQWnKclSt2QzlKRFh3Ik5mdEH7sGrfT70w2fytOAJOie5
 Mq7oGORO+FGuzv7znf5NTxgNDL9abRy29/Wja7GhZfsb4G0XW77Xs79bOsEvn2mHXRNo
 vZP7cDjHajRaJ0p3peG7b7y5ggT0IysCJttMglKvLSOmhYJowluhDBuzedbCsuwfO/rg
 lhDA==
X-Gm-Message-State: AOJu0YwL9k+lSKR2UuZajTDdDuSF7O9Z9mZgo6mYPaXoINpnf9OLIb2f
 E8tNuQsyQrr3SefBO143jmnITOF/4mgJ3qo+ukM=
X-Google-Smtp-Source: AGHT+IEvEqPZQ+DR0k8LUG1+eyMFnzgqbxZG1B9bkAcJEpckkAYgHokRYwzGgVprr6o/5kivsqv0sA==
X-Received: by 2002:a17:903:41d1:b0:1c3:9928:7b28 with SMTP id
 u17-20020a17090341d100b001c399287b28mr4308533ple.6.1696348958050; 
 Tue, 03 Oct 2023 09:02:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jb17-20020a170903259100b001bbdd44bbb6sm1742609plb.136.2023.10.03.09.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 09:02:37 -0700 (PDT)
Message-ID: <e6476524-a8bc-0071-eef8-1ee9e1dcba37@linaro.org>
Date: Tue, 3 Oct 2023 09:02:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/7] accel: Restrict tcg_exec_[un]realizefn() to TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang
 <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20231003123026.99229-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/3/23 05:30, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Use 'target'/'common' in function names (Claudio)
> - Added Claudio R-b tags
> 
>  From v1:
> - Add missing accel_cpu_common_unrealize()
> - Add AccelClass::cpu_common_[un]realize handlers
> - Use tcg_exec_[un]realizefn as AccelClass handlers

Thanks, queued to tcg-next, replacing v1 that I queued before my holiday.  :-)


r~

