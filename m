Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B27B079D345
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:08:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg43h-0006WB-2g; Tue, 12 Sep 2023 10:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qg43M-0006Oj-N7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qg43K-0007KD-Ec
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694527661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRN2zNzEIRdt9mVIxmAhTfWZatfHk2JC63APMxesKYw=;
 b=X8FZbZvFGb4jW4Yt0JVmdY2w9rM1r8/uEzIiK2jw0pFTxBQG46deCz7jC9HR4wOpXIhnTT
 yety10c/gIWMAhbMKhl07Y9k7r4vS34JPvX2s4gcD07m6+OI/PMojSRb+hgrLjQxgLYKpG
 8k8IsTJZI3GpjcarqOqUPMOXnH2G8V4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-9H53u04fNi-2A7s1eOknCw-1; Tue, 12 Sep 2023 10:07:40 -0400
X-MC-Unique: 9H53u04fNi-2A7s1eOknCw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so25213355e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527658; x=1695132458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QRN2zNzEIRdt9mVIxmAhTfWZatfHk2JC63APMxesKYw=;
 b=s3TmcZONQ2Ox+tGGMVeIgr9IOajHiQ5F6tsZrwwB6ni3ATqFUGJhDMbzTh36pYg5K5
 oHZ//D0PuiXjHZIR+qG2m5auRVOJQIlLClyMRT4HwLL7zPsco1uMsRAu1wmRBif0x1bt
 13fphVP8IwfF8Gzr2ry+FerO9zGA/SmNYQnCBuH6VHcmo8lgdqW3JYJrCwB282nq+ank
 m3L84qttszkT8KBGTO5ECR7bJLNSfcpMiF9pkL45yAvJqqOozv+POdvLvWedX1nS/+FI
 SEAxACxhhFV1jy3CemhsAKw9V2Auox021cTFZMz0fmshM58pvZCAY/29IzxCBxUgNgcS
 ujTA==
X-Gm-Message-State: AOJu0YytDA60ovy3SbaWv9/RtwcBdxCq28A1gMs1QX7iwWbtFJO0MLlc
 LMDJCcq464Jt4pnFvrwC3UL5xGJPb+TeWVeFW+NVPxnXD6/J060H/tO4KPJd0xjKKB4wqWpzsSH
 HBefnJKLxDxfbOsI=
X-Received: by 2002:a7b:ca47:0:b0:3fb:c075:b308 with SMTP id
 m7-20020a7bca47000000b003fbc075b308mr2071596wml.12.1694527657839; 
 Tue, 12 Sep 2023 07:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7DFNhJSaXDU85WH3j5/sSakZlESk56Xn91pig/o3p2nP0S9nFEbdN3YcyLiQgbtnDSG6WhQ==
X-Received: by 2002:a7b:ca47:0:b0:3fb:c075:b308 with SMTP id
 m7-20020a7bca47000000b003fbc075b308mr2071575wml.12.1694527657499; 
 Tue, 12 Sep 2023 07:07:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 y18-20020adfd092000000b003179d5aee67sm13007052wrh.94.2023.09.12.07.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 07:07:36 -0700 (PDT)
Message-ID: <fabf2451-e8ad-8171-b583-16b238c578e7@redhat.com>
Date: Tue, 12 Sep 2023 16:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/3] target/i386: Restrict system-specific features
 from user emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230911211317.28773-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230911211317.28773-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/11/23 23:13, Philippe Mathieu-Daudé wrote:
> Too many system-specific code (and in particular KVM related)
> is pulled in user-only build. This led to adding unjustified
> stubs as kludge to unagressive linker non-optimizations.
> 
> This series restrict x86 system-specific features to sysemu,
> so we don't require any stub, and remove all x86 KVM declarations
> from user emulation code (to trigger compile failure instead of
> link one).
> 
> Philippe Mathieu-Daudé (3):
>    target/i386: Check kvm_hyperv_expand_features() return value
>    RFC target/i386: Restrict system-specific features from user emulation
>    target/i386: Prohibit target specific KVM prototypes on user emulation

At least, patch 2 should be changed so that the #ifdef'ery is done at a 
higher level.

However, the dependency of user-mode emulation on KVM is really an 
implementation detail of QEMU.  It's very much baked into linux-user and 
hard to remove, but I'm not sure it's a good idea to add more #ifdef 
CONFIG_USER_ONLY around KVM code.

Paolo


