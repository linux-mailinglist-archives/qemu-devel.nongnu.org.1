Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDD78843C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTel-0001YZ-Su; Fri, 25 Aug 2023 06:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qZTei-0001Y3-7t
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:03:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qZTef-0000lz-Ox
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:03:03 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso621187f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692957780; x=1693562580;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kY08QU+d4mWdQ0tk6M3OcaOkEWEvY8tiOOSEuKl6UuA=;
 b=r8JfUO7KWaz2yP5UCx83o6gOtW9lVOb1FHNx2t0xC/VO3MTNxJgtKSkVy50nN7RkEb
 6fKKLXHdbJYZiWqqEtiH6x3e5puC0NZtO6xlLMPP6ZO6gX4R/WC2pnJsTQoXbsDk1eyZ
 pFDbpQ/oWfYcuTUBzhMQHeSfxZPswhA3UlAlpucZcP2z/E5nfhPRFCoGyJ+gupw0KhAx
 76h7ni/8a5B9JsXUdXi/cBdVRmRNGQUwwW930PNemAn4f1h+N5BTiV8XiO4mIpsyVCAq
 5cy9GYgpoFdUWksqf8Us1d2GvKi8p5pw/2NjtthzWm8raq+YRecA34rblsv0jwwqGcxt
 xpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692957780; x=1693562580;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kY08QU+d4mWdQ0tk6M3OcaOkEWEvY8tiOOSEuKl6UuA=;
 b=gP1M/9E5YD+OBved3JBsq6lL4Kk/n5E745UCB5Hax8Ve5pPqUxZ4WvLJ3J9i/gIb0f
 aRqMwBZGGmkv1Q0XJv7ARzdyoEmQ9+Et668VM6eZ4L6I72d13CBMbpfpaZ7RMQ/sIrub
 tmwMo9x87YK2maJ7Ipia009Nz7b7ODGPciEBZbms5Ce9A6UixcfLFCNnMrM397cjEvyE
 sUfpHbq9rMMVZ4zZVKZ2Ig8tpZXpGnha7qw5xHWRUAHzVoZT0v3EUkDhHTAPqIZ/XKYz
 LlCu00M2d+dxdcCfSibEpIzUEkm1OIMol3Pw3vwy5wlrweEI1sQapzs3G3YI95+cQXgJ
 gN8Q==
X-Gm-Message-State: AOJu0YwkHHGq75X1k+dQxeHxj+5HwYIoYJA28wkM4NfOHDoJpbbzwpoS
 K0S7y+8vkcUnEP4gMsVnC2g=
X-Google-Smtp-Source: AGHT+IE761JfNoeL6m1CDjrqlbvr6Dma1fChCAD47U5lpiYaunz235f0Bn1JLnTp4s5ifUBA9EldNQ==
X-Received: by 2002:a5d:4d85:0:b0:315:998d:6d25 with SMTP id
 b5-20020a5d4d85000000b00315998d6d25mr12678580wru.1.1692957779441; 
 Fri, 25 Aug 2023 03:02:59 -0700 (PDT)
Received: from [10.95.145.119] (54-240-197-227.amazon.com. [54.240.197.227])
 by smtp.gmail.com with ESMTPSA id
 z12-20020adff1cc000000b00317f29ad113sm1772305wro.32.2023.08.25.03.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 03:02:58 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <fe5bfc42-c940-b14e-d866-56ffb22313ca@xen.org>
Date: Fri, 25 Aug 2023 11:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] i386/xen: Ignore VCPU_SSHOTTMR_future flag in
 set_singleshot_timer()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm <kvm@vger.kernel.org>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Jan Beulich <jbeulich@suse.com>
References: <5b30b245ba7714eb1420da43da979f9e8cb7e02c.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <5b30b245ba7714eb1420da43da979f9e8cb7e02c.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 23/08/2023 12:58, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Upstream Xen now ignores this flag¹, since the only guest kernel ever to
> use it was buggy.
> 
> ¹ https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=19c6cbd909
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> We do take an argument to emulate a specific Xen version, and
> *theoretically* we could ignore the VCPU_SSHOTTMR_future flag only if
> we're emulating Xen 4.17 or newer? But I don't think it's worth doing
> that (and QEMU won't be the only instance of Xen emulation or even real
> older Xen versions patched to ignore the flag).
> 
>   target/i386/kvm/xen-emu.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


