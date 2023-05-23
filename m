Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E312C70DDD6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SM6-0007Re-DP; Tue, 23 May 2023 09:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1q1SM0-0007OM-T2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1q1SLw-0000y3-To
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:06 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-306dbad5182so4928281f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684849623; x=1687441623;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AqAUPw1sOesNEKn4pzcnsnJJIEHYY5QtRcpWD3pK1yM=;
 b=H3uwaReMlSsc/MSJGm/izsWCuVQL6bPeAHxWmGUyW0BWLtQNVGohGn8FNWtldfwZQA
 gOYGPV68ObcJrZYZ10udnu4n2DptSAmyQUuT7/1Bb6aSxYbVmfKUjX/SHi8BACO7yKSZ
 CBRMLRn1twCmZKBybMimkhL04hRims5tUoebLDe4MKvSnJ0O3/fTQqKpUXZ2SSteKiY9
 JcsTpXp1XOcOVImpavc9Aqd+nuiAt0gqp+efMx0GS7JJyKNk6OGxTdGDCxHq9Zco9mQ4
 rzvHEc0tiRCeJhl/77J3s984DH2C41XEVtwlputxCrADkBloF+oDQ0wDs9B2kwcoo3yx
 jizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849623; x=1687441623;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqAUPw1sOesNEKn4pzcnsnJJIEHYY5QtRcpWD3pK1yM=;
 b=cnJih/DRIMq1M4iAwaXtWJz5lMmkc4VYdgNVf0Psq4pKSJZ5D4jf6O4ij2nMaNPbw3
 pFxsMjfPPv9qsuBLNYk8iLMbvEgVKOQOoThoqvI1fDnjFjXWxdatUQ/upYVWMqZCzf62
 dU9ox0IT3bFyo+IGA/woy9+fbSykcYOgCqc03HlBt+Oqhzm7gVgO2Y3Cdesaax98XgQ6
 x5IHZbhYvFhak6NiLOWlfQrdZJL5CVEG1Ma5mMIuYVn28e46t9FkLf+fSYeoGE90LSm/
 UMzXdgX33P3+X0bW2K72rMQ8SDMXTJ+uyIpRwislE6o6od9tlrCWhP7qdYN3lGL0cetS
 0Cqw==
X-Gm-Message-State: AC+VfDwGzE05rR6QmsDSSHh8ooIAwV6Fkx0BHwAfm+AcNNxlvIEKfQ6H
 +hFtymgkknkQiOnctrFRcx4=
X-Google-Smtp-Source: ACHHUZ73+IoOVkJ5tKRPCGq0osbSCo6X5PlFL191s+/a9wJQPmeOJi9SimnUZpPoo0gmkkPgqYRqaQ==
X-Received: by 2002:a5d:49cd:0:b0:309:507a:3f5b with SMTP id
 t13-20020a5d49cd000000b00309507a3f5bmr9944430wrs.8.1684849622466; 
 Tue, 23 May 2023 06:47:02 -0700 (PDT)
Received: from [192.168.27.65] (54-240-197-224.amazon.com. [54.240.197.224])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a5d56c4000000b003062d815fa6sm11169943wrw.85.2023.05.23.06.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:47:01 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <401f3424-9716-5bdd-3adf-1a33604ff0b2@xen.org>
Date: Tue, 23 May 2023 14:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] i386/xen: consistent locking around Xen singleshot timers
To: David Woodhouse <dwmw2@infradead.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-33-pbonzini@redhat.com>
 <CAFEAcA-s+sNDn4z_kXd70koFGSLXqjMUXB5Gn9VzTnaSbr2B_Q@mail.gmail.com>
 <d61333c6394697d88dd08d48cc7fa730ff8e1987.camel@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <d61333c6394697d88dd08d48cc7fa730ff8e1987.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/05/2023 19:52, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Coverity points out (CID 1507534) that we sometimes access
> env->xen_singleshot_timer_ns under the protection of
> env->xen_timers_lock (eg in xen_vcpu_singleshot_timer_event()) and
> sometimes not (the specific case Coverity complains about is in
> do_vcpu_soft_reset()).
> 
> This isn't strictly an issue. There are two modes for the timers; if
> the kernel supports the EVTCHN_SEND capability then it handles all the
> timer hypercalls and delivery internally, and all we need to do is an
> ioctl to get/set the next timer as part of the vCPU state. If the
> kernel doesn't have that support, then we do all the emulation within
> qemu, and *those* are the code paths where we actually care about the
> locking.
> 
> But it doesn't hurt to be a little bit more consistent and avoid having
> to explain *why* it's OK.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> 
> On Tue, 2023-05-09 at 15:55 +0100, Peter Maydell wrote:
>> Hi; Coverity points out (CID 1507534) that we seem to sometimes
>> access env->xen_singleshot_timer_ns under the protection of
>> env->xen_timers_lock (eg in xen_vcpu_singleshot_timer_event())
>> and sometimes not (the specific case Coverity complains about is
>> in do_vcpu_soft_reset()). Is this a false positive, or is there
> 
> Thanks. As noted, I think it's harmless but it doesn't hurt to clean it
> up a bit. I've pushed this to my tree at
> https://git.infradead.org/users/dwmw2/qemu.git/shortlog/refs/heads/xenfv
> on top of the other fixes that didn't make 8.0.
> 
>   target/i386/kvm/xen-emu.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


