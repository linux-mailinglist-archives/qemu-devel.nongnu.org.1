Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6C756F0A
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVwK-0000sp-1t; Mon, 17 Jul 2023 17:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLVwI-0000sh-1o
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:39:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLVwG-00009U-9z
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:39:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3159da54e95so4512570f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689629966; x=1692221966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IsPi6qBNncFss9RMQNak2ay+GwXvvabJa63S7H7q65Q=;
 b=u1ngW+DNkhaTEW7Jku3f8A4scasiS6Xkr12tz0vA0Nk9Dii//I3eiEmtTmjxGwoswJ
 MfPulRfYZ+/m8Xana6dFm2pmnSqIRRl6jocdCfxgbHl6RGdjz+QL3aCQ7K7hts2nEA66
 b7fiYmAo6BbRJaXayNuki1/w2mnxEip8zGzUX0XlG/8nnIdN5mCljrSVY9iHPkTvw/WE
 8T98t0KESBgEW0J40HgyOnzbt5+KLtWvAcHStGZHMOH9CEyKkZi5juL1PSb3f/G+Hbcl
 yxDcJtdcVIdnDCENCbMOwscbNuGhuIqy8pAvqhgGOxmfX9Zyj5s0mY0W4zYlvtlJF+5a
 Y12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689629966; x=1692221966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IsPi6qBNncFss9RMQNak2ay+GwXvvabJa63S7H7q65Q=;
 b=gn9BmmFxySbgOdpbuopPrcBHZ5MQhoWaffC4mpbrfBiTwzjcqK+r7FC+6tCljQlzCQ
 wf8DQHTNXOmk6Zatrc1Ur7O1jAmEr6adfIR/Nm11CN3ZbchiYz5EYo1nIqIkm/mecvSt
 NTY30ekkwUV1Nqq9n8tiQKKFf/JEyR6PtG+DJ/6KM6btm6E6dZimUty5xo5iPmtPzTn3
 4prwCq/ja4YdWuApjqsx73P6JsCvzEshjvr2ttDG5JMItyhG0v9PgsrodMBGZAcf8Sct
 qDeiZsIVqWG2IINwdSPgwH5Met1cLDirHHQMs5cFHQ/JwTD4UkrWT4M3vymrD9BBP7tf
 rhRA==
X-Gm-Message-State: ABy/qLYZuEaWwHlZcfTSswhKZd49CqRnBaKqTwAlNabHgNG8BQ+lIWEM
 Vx4FCkYIAYkVvkm24djkU0V53w==
X-Google-Smtp-Source: APBJJlF7fHD0ynZ6BtKKp5l8U1GL20w7nh6Nb78tT2t/C3imIKnfoxvngjvmfYdinlGgcCcBXRALFQ==
X-Received: by 2002:adf:e852:0:b0:314:14be:1004 with SMTP id
 d18-20020adfe852000000b0031414be1004mr280797wrn.63.1689629966492; 
 Mon, 17 Jul 2023 14:39:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020adfde91000000b00315a57f1128sm453758wrl.115.2023.07.17.14.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 14:39:26 -0700 (PDT)
Message-ID: <c466671f-2c5a-6c7a-f9ee-cdc2f466b7ae@linaro.org>
Date: Mon, 17 Jul 2023 23:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH-for-8.1] i386/xen: fix off-by-one in xen_evtchn_set_gsi()
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "paul@xen.org" <paul@xen.org>
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-57-pbonzini@redhat.com>
 <CAFEAcA9KXrRscf9QK2Z5Say91KDm7xRLMZGh4A1rQ1+0TCHtcA@mail.gmail.com>
 <4eb4c9868798cbfd2819c317a80037f4820b0502.camel@amazon.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4eb4c9868798cbfd2819c317a80037f4820b0502.camel@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

Hi David,

On 4/7/23 17:12, Woodhouse, David via wrote:
> Coverity points out (CID 1508128) a bounds checking error. We need to check
> for gsi >= IOAPIC_NUM_PINS, not just greater-than.
> 
> Also fix up an assert() that has the same problem, that Coverity didn't see.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Better to post new patches as new thread:

   Patches are easier to find if they start a new top-level thread,
   rather than being buried in-reply-to another existing thread.

(Per 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-git-format-patch)

Regards,

Phil.

