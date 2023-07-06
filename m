Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF9274A22A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRoH-00060Q-0Y; Thu, 06 Jul 2023 12:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qHRoE-0005zR-QH
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:26:22 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qHRoD-00058N-6b
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:26:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31434226a2eso958096f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688660779; x=1691252779;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/0EDXFJ0GELT+0mZrlpfESJvEIEMMSsTh8e+8OgZe5A=;
 b=gh9z7VRUuE3bwN4yULq2JX+Y37rpfl6NK2tC8AwCPxWDsLPGNw4X+UdTHDIkc9hkiy
 Bmf+YzVY2Pz4y+Hj1wBkynTR0qtExm1Fm2nOuh88sAHu33ttfzHR+nHRkzfS4bZyaHnH
 0u6agC7i6jog4FULIBIuyewf2+GrNXVf4xbSsMIymZxir42xldSYZO/M29mwtgeiCOUO
 OiA3MbDt5k2f5pDlk8R32HFMj06u5e4NB3FIK4u+RUwsDI44f3oCtwv7Vg7rkGEr72KV
 2z2Gr2xLj2vl86JnDwok0Sho+xv8xE6FaN97scNYQIEsk0DnCQLW7Smxyk/MhYO28XkC
 KYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688660779; x=1691252779;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0EDXFJ0GELT+0mZrlpfESJvEIEMMSsTh8e+8OgZe5A=;
 b=Pm5Cvef/KjdtwEulrK6MyuQX9oyi9AFvL5B/3AzGFXjNgnjykl8dOo7659toOc8kdU
 LTUMvesgel06dZpd6OiBpsh95m1wr2FVgrgnlkjRdRN36W2w3YIZDoXWuVZhvP3/+6Tb
 f0FDjDh6TlxFnkdx1ELR8ZLxTPpevrh6xwpPE18FYtLcDTDzWqc7e58j++H6SmP6xaEl
 TGTwGv7VgY9xBED3gCAk2hwHVQpBWmA3psFaXna/kI18/hDoBbL51D0OWYf2VkI/cRl6
 jsBMnAo+f3OegJn/1Fd3wGbpgUrSqu5+xeXVn5HT0DUhg/thSHkKq6BllXRjKgsxaQBa
 ptNQ==
X-Gm-Message-State: ABy/qLakebFN3QnlAkJXN+wuf2HuXxLR8u+TVYA2POvqFYCichi2qOM0
 F8d3c/dDg38MULAkJCB/6FQ=
X-Google-Smtp-Source: APBJJlHZlK8py8cRWk5PEAfMDSpXKTFSvWcmBSPMXbwUk4lE/a5X8mxn5W7NrlePyVFtQieNLBab9w==
X-Received: by 2002:a5d:48c1:0:b0:314:c7d:78aa with SMTP id
 p1-20020a5d48c1000000b003140c7d78aamr1847533wrs.62.1688660779076; 
 Thu, 06 Jul 2023 09:26:19 -0700 (PDT)
Received: from [10.95.131.194] (54-240-197-233.amazon.com. [54.240.197.233])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a5d5543000000b0030e5bd253aasm2250433wrw.39.2023.07.06.09.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 09:26:18 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <4f6bd285-9477-ef2f-ff31-7b15e75344d2@xen.org>
Date: Thu, 6 Jul 2023 17:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] i386/xen: consistent locking around Xen singleshot
 timers
To: David Woodhouse <dwmw2@infradead.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-33-pbonzini@redhat.com>
 <CAFEAcA-s+sNDn4z_kXd70koFGSLXqjMUXB5Gn9VzTnaSbr2B_Q@mail.gmail.com>
 <d61333c6394697d88dd08d48cc7fa730ff8e1987.camel@infradead.org>
 <CAFEAcA_CR0PraF1DuDxw6q9U=Atut_=v0L1gHr6VfgxHCbmJXw@mail.gmail.com>
 <318049e6f803afa150c38190e5ce3540e1b82c8d.camel@infradead.org>
 <4d45f38c586d17f878034fdec14e53be1cb83059.camel@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <4d45f38c586d17f878034fdec14e53be1cb83059.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 04/07/2023 16:51, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Coverity points out (CID 1507534, 1507968) that we sometimes access
> env->xen_singleshot_timer_ns under the protection of
> env->xen_timers_lock and sometimes not.
> 
> This isn't always an issue. There are two modes for the timers; if the
> kernel supports the EVTCHN_SEND capability then it handles all the timer
> hypercalls and delivery internally, and all we use the field for is to
> get/set the timer as part of the vCPU state via an ioctl(). If the
> kernel doesn't have that support, then we do all the emulation within
> qemu, and *those* are the code paths where we actually care about the
> locking.
> 
> But it doesn't hurt to be a little bit more consistent and avoid having
> to explain *why* it's OK.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   target/i386/kvm/xen-emu.c | 36 ++++++++++++++++++++++++++----------
>   1 file changed, 26 insertions(+), 10 deletions(-)
>

Reviewed-by: Paul Durrant <paul@xen.org>


