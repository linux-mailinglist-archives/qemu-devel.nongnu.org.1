Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF5792912
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZCf-0006aC-O0; Tue, 05 Sep 2023 12:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdZCc-0006Zb-Mw
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:46:58 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdZCY-00033x-NJ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:46:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so2390890f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693932413; x=1694537213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cYDSC9rRdOPE5Af0cIS/0UupUuBAJ30xxKNs78+lhNc=;
 b=WXjXx7mzXrKxtuHxo4jucLU+rRlhw6xr2PuYEZ3U2vd8E+yFw6VUVuzCZ/E6XmnWf6
 9TSKRvhYS5ZaIDFtjSf9aiRygXWI8ilWk+rH6Z9XzKWTFRtZTUYwcQqbaqfBQjU91FVl
 qn1ZltSNVImnwTnBsLDcyBbmrF6FZANc4i78anjGBSSGBAGTzmDZNmdNu8R739/k74Hl
 7qLJfZJHGN/nKoxbrHH63EsJUHnbc2nstHkhKNw4mmBSqliooozzMWXChcYY2SndTHVl
 ahmHSS/nH9C16jYhUqrb71zFKyY7mFu9u37iqvv0GbubAQGb9OPSrNu93VZjIK5M3VNI
 S6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693932413; x=1694537213;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cYDSC9rRdOPE5Af0cIS/0UupUuBAJ30xxKNs78+lhNc=;
 b=cAm+Ut24ZzHpNBWw2WbBqdgEWfU4g1yRWahbXeMhOIJfS4i3rLajmYnVrQWEtcWlYj
 9yV0CkxRPyzfh1PRkH4R9YsFP7B6028QdBjDzfEq5i72Wcha4lHSXoVxZSz9emvwdU7v
 IUZnityKzlEQajB6g7AgCyzI1GzltAfsHNogDDUGFO1EKuojuNlRPf7mp/72q73dgHUf
 N/gW8UAp/NNtsz/LQSeIoxIB0In7qw0Kaf4KBrJZKnfBywl8ZstE8ZM8enWXtuXqcEkb
 5NjYrJBl239gqfDycbtKp20EIcCoNP0k7CYQcJeseILfy7TZ9VIj+vStMyxyhOcxGSVr
 5G/g==
X-Gm-Message-State: AOJu0Yx3hcvawNTk7MprnS+jGcjjdEcDRxWHKbmUu57MymJzYJRJvhsu
 m+/4+WORt+w0PIyX5fakhBsXFg==
X-Google-Smtp-Source: AGHT+IFIn9xpuOEg3AQ1L02shEpwV3qe4oCtM90iTYtrquja8T22BTEbblBMPUTXppndhoqTmdO0mQ==
X-Received: by 2002:a5d:6785:0:b0:31a:d6cb:7f9d with SMTP id
 v5-20020a5d6785000000b0031ad6cb7f9dmr256051wru.24.1693932412782; 
 Tue, 05 Sep 2023 09:46:52 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 f3-20020a5d6643000000b00318147fd2d3sm17940255wrw.41.2023.09.05.09.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 09:46:52 -0700 (PDT)
Message-ID: <932ee6f0-f8bb-f9eb-49bd-3ffee7afd265@linaro.org>
Date: Tue, 5 Sep 2023 18:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: mips system emulation failure with virtio
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
 <87pm2whfyn.fsf@linaro.org>
 <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
 <d35f5c16-e75c-fc7f-57cb-c6f7a5e696fc@linaro.org>
 <58b3aa9437ac94d7665e7b93f4868f7e7d3f71b3.camel@linuxfoundation.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <58b3aa9437ac94d7665e7b93f4868f7e7d3f71b3.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 5/9/23 17:53, Richard Purdie wrote:
> On Tue, 2023-09-05 at 17:12 +0200, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 5/9/23 16:50, Richard Purdie wrote:
>>> On Tue, 2023-09-05 at 14:59 +0100, Alex Bennée wrote:
>>>> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>>>>
>>>>> With qemu 8.1.0 we see boot hangs fox x86-64 targets.
>>>>>
>>>>> These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmmu:
>>>>> Use async_run_on_cpu in tcg_commit) but if I add that commit, mips and
>>>>> mips64 break, hanging at boot unable to find a rootfs.
>>
>> Are you testing mipsel / mips64el?
> 
> No, it was mips/mips64, i.e. big endian.

Sorry my question was not clear. I meant: Do you also
test mipsel / mips64el guests, and if so, do they work?
(IOW, is this bug only big-endian guest specific?)

Thanks,

Phil.

