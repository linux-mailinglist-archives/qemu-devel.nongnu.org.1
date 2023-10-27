Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C87D8FAC
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:23:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHBX-0006qW-Uf; Fri, 27 Oct 2023 03:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwHBW-0006o1-87; Fri, 27 Oct 2023 03:23:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwHBU-0003WO-1M; Fri, 27 Oct 2023 03:23:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32db8924201so1095826f8f.1; 
 Fri, 27 Oct 2023 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698391385; x=1698996185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=dSCOMydOnsCaHq17QXAhhoXbOK1DobHQBIwwTw48NnM=;
 b=EkIehhJGI5/FGI1kpmWMlGvId5G/+ruDDffdhu6Zr6E+459EvzwE1JYIWLFZ4SghC1
 JUQFsXNmValbaFiXgc0oUxmdnLJRj+y+q27iLZaVbCIy+tagRIw0Cv33cRnMChukDB8C
 96xSTRGCzZjY3HMjsDGpgsJVrBrbaoS/HCxfweRT5CwDeV8OlqfoS1n0TEdzI5bdslSQ
 9EL3ml7t3dT7QXLfzb5iBTpQVrxHS94gMwWlnZMTJioA2+OA4zbbGfJ9MxQp63cE+kTt
 +EMGOHU/nksKcMAJfnMp871gvNl0VbXFJHSxr74Q44vUEM5NZz1usTjpI/PA7Pw1S3cf
 3Ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698391385; x=1698996185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dSCOMydOnsCaHq17QXAhhoXbOK1DobHQBIwwTw48NnM=;
 b=vLhRJkqfYFuan+BkJ6eVXoCrLgGG4pduNYdNxOL6zSNBE8XZa/OIaf+ILgaaVcL1U/
 dKYJLcMl+7t26T11zqlyzGB8pMzYJB7r3hfU9spAIno0D7RD7AQUpAiEFveyCeKmVxsT
 g5Zfv1jNGzFeVrCRy4VdgeS9QuYfoXK9uuvN5iGE7myihzv+gAH0dZAcMuv2XKFo3J2h
 Sj2fXpSebIn0WjvFgUoDyocSRQU8W1edTmzgD9gcos6Wte0aZRova2yA/dp50EphNQQw
 R76ea6mG1ztYRl9gchHakzzQQJMPrIcZ2RQKw0v8cDSoTp4QtYwzIXFJK1zR0UDqVjwi
 FaKQ==
X-Gm-Message-State: AOJu0YySFg2Hma0Xj+fQ+Kx+LZUlrlJjqRvDSfIT9XhuMqwatprLpdtk
 aIcFE2BvjkDxHjBUkSLUZfA=
X-Google-Smtp-Source: AGHT+IGcJqs+3Lj5Br/+siV+aN+YMItskE6Hk6MaX+RfvRLeEZhRqSD3XuVFCG4gSuppLBynhA6zLA==
X-Received: by 2002:adf:e992:0:b0:321:6a61:e45a with SMTP id
 h18-20020adfe992000000b003216a61e45amr1332680wrm.15.1698391385492; 
 Fri, 27 Oct 2023 00:23:05 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adfef90000000b0032326908972sm1126352wro.17.2023.10.27.00.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:23:05 -0700 (PDT)
Message-ID: <65c0d093-e83c-4307-9edb-2b4f04cde607@gmail.com>
Date: Fri, 27 Oct 2023 08:23:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/28] i386/xen: Ignore VCPU_SSHOTTMR_future flag in
 set_singleshot_timer()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-9-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Upstream Xen now ignores this flag¹, since the only guest kernel ever to
> use it was buggy.
> 
> ¹ https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=19c6cbd909
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> ---
>   target/i386/kvm/xen-emu.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


