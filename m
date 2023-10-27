Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DC7D93C4
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJBu-0008B2-O8; Fri, 27 Oct 2023 05:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJBs-0008Ak-Ce; Fri, 27 Oct 2023 05:31:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwJBq-0000h5-9p; Fri, 27 Oct 2023 05:31:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so17440315e9.1; 
 Fri, 27 Oct 2023 02:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698399096; x=1699003896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QTs9kivD/Mfn/UAvscBipfMJBB8Bih4r6SL3tafSaEI=;
 b=XND0/CvrTxSZjISJgOl3DAHDBC38GtdJy40nNDhXgnYlpCCQhwDLigatQRm+rp/SqV
 cJ5EZHq4QjS/oC9RK8SYd+V+TJIUI9HgNyZyeNbYm9wt/7LUkAFiN3hqY5gdatL3AUXY
 YVvkspbxJHGZB8K2xsh9/EO+pwjSteSCvn1RdgBO7p4S20Gk/MrNqBUjYf3QDQPkIwkT
 yEQ6pxH9bA0zodhILMuPziLVRUQIqvWaoFmJtCYqnXJg36C1eKXeWb3ozebbkIr2842h
 q3aDPJfs+qUyQvOmCdGXPw0695cwCKJ83SEPIKuk/EQUHnEd0Mf4t46jorHsx4oNa6ex
 y4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698399096; x=1699003896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QTs9kivD/Mfn/UAvscBipfMJBB8Bih4r6SL3tafSaEI=;
 b=DKHS+Cy53apaQf0b2WOK/xxHDndmmOxOcK2OkPddpWyxQmxuE/Ekuu7HUC9sK+1+zo
 +GMH++4Wh4kzS9hQ/7q1yS1ULo1i1qaoNujbel9+pMTP02Utl0oHq7A0WOK0CNnxzgwG
 8rCm1OESt84t8JYZp53XHb6Dw7TmPklD618NGOu7HQoggVeoWsGqzjNKX6ZseajdAPBZ
 iWHwkxAMvQ3UDCFyqnii3JbxZPhkjeLS3E67SZBfWz89Do687ZCyBJp/1eaK37RhzYnL
 o8CZChW8eF+HN+T0F7b44LtFJDrAwv0l18pjbuclO57C5g8fs658ceH+ZU+UY0VQE7Qg
 yddQ==
X-Gm-Message-State: AOJu0YxXq5ttmXab0du/n+kGDix2m3CfcnZJSFUZtPdtIDgzR7aO33Gd
 xo3vGPVCc7DZWE62RmV2P5Q=
X-Google-Smtp-Source: AGHT+IFMyYswcfqDBXUjHeiT0+hX+rLzRUjfI/ImjdtPGYKdKySflidFjyugVF6CSqz3WojMmjv6tQ==
X-Received: by 2002:a05:6000:80b:b0:32d:a045:cf71 with SMTP id
 bt11-20020a056000080b00b0032da045cf71mr3223387wrb.21.1698399095684; 
 Fri, 27 Oct 2023 02:31:35 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 x11-20020adfffcb000000b003258934a4bcsm1356830wrs.42.2023.10.27.02.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:31:35 -0700 (PDT)
Message-ID: <7f5487e0-f794-4e58-8aa3-81ca3dc3f3db@gmail.com>
Date: Fri, 27 Oct 2023 10:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/28] net: report list of available models according
 to platform
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
 <20231025145042.627381-24-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-24-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32d.google.com
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
> By noting the models for which a configuration was requested, we can give
> the user an accurate list of which NIC models were actually available on
> the platform/configuration that was otherwise chosen.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   net/net.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


