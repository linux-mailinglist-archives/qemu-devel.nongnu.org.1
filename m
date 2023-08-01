Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C4A76BF78
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:46:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxC2-0005CI-OV; Tue, 01 Aug 2023 17:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxC0-0004rg-72
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:46:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxBy-0001n0-Jb
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:46:11 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe2d218eedso6867335e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926369; x=1691531169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QBJ9WpbYJ/9qOaI7YWlwMfT+OlnFuNzR3c7GpYDGEyY=;
 b=PTWbpTp5jpO9QVEY//FoVDp9MyVOi1s3eaWW2v9LHdseq8sUDKYDN2xvI6wmQqXe84
 Q2bHqmk9dlN2pdK+42rXWMUoGlm+UG5pY21oCFkeC34zJmirsqhfYHNPaZskY5UL/R8p
 oOjwoqzcMPZ3wp8Z0xmv5X23Rp/9ybrOoc56daS7XzZjcFFYQbIE2ZcLva45HK+GH+83
 aKlUuk/f3VZ498WxyA8+uqMsqf/kgrXvN/Q7+kGugeUID67K5s/5RLT27GXKTEjxXPSG
 wI52K7fvRNHJduX+pBRopySDrgerXFWO4UoHKL39Lab5UMAvKGwZBuG5zjyXiVYNwMDi
 0rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926369; x=1691531169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QBJ9WpbYJ/9qOaI7YWlwMfT+OlnFuNzR3c7GpYDGEyY=;
 b=PPyawkkevu0MgIB+ai0JNJOLRn5PN8m24kZH/OgogqzkYyENA66qR+PrtZc74mZwq6
 F2+/T76QQw8SW4+EQ3ELIgkX79/XIBgji2nz4j1NicGwMEoDhNW6CnT4C8OETpStbR9Q
 G0zJyf+g6Ca6z1LAu3BCmnGNutXHx0oCBo6M0gHdzGf0hYPAZuR0yLAtI6f//iixJg1P
 yVckuxibPGTjpmF/UrX3HYegEgWgwhxsvy7CVu/pbcpp/KNlQE0RWe9X9bq8gXPOGeBg
 RdRq1zw+A7LMvD+s9iVj5Pk8EwJVVqOHtPVASYE1nPwCDMth29hXt3N20WE6YRgjY+HA
 ZqQw==
X-Gm-Message-State: ABy/qLb4usLnx8B3j3/0HVuiJHJiBwFuN9uIMXcZs/jRIBbpb+f4WZzm
 3KQGQA/+0pnHBkr30GZi/A8+rg==
X-Google-Smtp-Source: APBJJlGlOALsCc5aS8SVhmHPl504oepavvxMjaNckYhr1oXtbiuKXAOQdX6os7LZQQg73XZLcDPvzg==
X-Received: by 2002:adf:e88f:0:b0:314:35e2:e28d with SMTP id
 d15-20020adfe88f000000b0031435e2e28dmr3015966wrm.13.1690926369066; 
 Tue, 01 Aug 2023 14:46:09 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a5d6a86000000b003143add4396sm17072761wru.22.2023.08.01.14.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:46:08 -0700 (PDT)
Message-ID: <07c4b978-4ad9-c9ff-38d1-d24f4c701dd6@linaro.org>
Date: Tue, 1 Aug 2023 23:46:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] Misc Xen-on-KVM fixes
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>
References: <20230801175747.145906-1-dwmw2@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801175747.145906-1-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 1/8/23 19:57, David Woodhouse wrote:
> A few minor fixes for the Xen emulation support. One was just merged, but
> there are three outstanding.
> 
> David Woodhouse (3):
>        hw/xen: fix off-by-one in xen_evtchn_set_gsi()
>        i386/xen: consistent locking around Xen singleshot timers
>        hw/xen: prevent guest from binding loopback event channel to itself
> 
>   hw/i386/kvm/xen_evtchn.c  | 15 +++++++++++----
>   target/i386/kvm/xen-emu.c | 36 ++++++++++++++++++++++++++----------
>   2 files changed, 37 insertions(+), 14 deletions(-)

Thanks, since the series is reviewed, I'm queuing via misc-fixes.


