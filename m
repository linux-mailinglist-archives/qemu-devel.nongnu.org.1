Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A587763FA3
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:30:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOj8r-0003Z5-FB; Wed, 26 Jul 2023 14:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOj8p-0003Ys-71
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 14:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOj8n-0008GG-P9
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 14:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690395700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCPaISCfgH8GkIPOWFaHoTth6gOE8hm60IM3F7rtrEo=;
 b=aB2rJnnzUjcEgrKeW4UZe9etmEKMGmD6wuMqLoaaGosscmv8PjoF2h+SLqqAKFg/lQ7h5v
 e0qmEK40QXOkgC6Qdar/L/eW0SGvdH66qola3rYMIrOpWJHHrsK5N95NzrDXagqdk5HOlv
 yjHCRDBCwJwb/SgSFFhIr7uNZZW95WA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-ElJ33nonOMqoHw2eYyALHw-1; Wed, 26 Jul 2023 14:21:39 -0400
X-MC-Unique: ElJ33nonOMqoHw2eYyALHw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-317421b94a4so43592f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 11:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690395698; x=1691000498;
 h=content-transfer-encoding:in-reply-to:subject:from:content-language
 :references:cc:to:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RCPaISCfgH8GkIPOWFaHoTth6gOE8hm60IM3F7rtrEo=;
 b=TzNcxlo1SF+skX9ylEFjuzgZpDnsr0Q7hQB7OK3yBIY7T3a9p0t2NvnGxkX9X73lsz
 +s9ONCVIPhoTAMCa+b1ciC2ZxHWI5Y57jZXmw+9BAwV4sOM6rN9dMz7lJPTLUe2MkXvI
 l6mFR1OhlTNaZiZykkeDWIWJlRyQss4BbL+PV5EE7JcNJ+u/gDVi0+FQ81QwznwYM6sB
 j7FfVs40qpb4kr5ibvoEX+SMsYvHX/G5JnsW6B6gx/FzmBGg9HTLFpw8Rfu2Am8OWT3y
 f0cceXcYuh6r/5zQk6PqiWyT/TMjDyHb3qd9mzfaNMpUA+SPv8vgD/uBixgE6YT+igLL
 +dSg==
X-Gm-Message-State: ABy/qLbD6AjR+GphxNNLI8GdBfbeIDQ0icPGqz9lycWg+hUf+0Gh+aol
 qi3CWQLA8XOK7dMQZuzSEz9FTnPwIjF1VPWbVifCDy5GGatq7SHaTQULsXCfe/UMN+PGfZyyghT
 JkvSBldmuGwgpPKQ=
X-Received: by 2002:a05:6000:12d2:b0:314:1f6:2c24 with SMTP id
 l18-20020a05600012d200b0031401f62c24mr2017201wrx.36.1690395697965; 
 Wed, 26 Jul 2023 11:21:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGN23pgPuGNbuZAYB5yqzt9FdSKo3vltf/dNI/axf5xq9xpXvYBrqgLu97fxyprawTsryVlkQ==
X-Received: by 2002:a05:6000:12d2:b0:314:1f6:2c24 with SMTP id
 l18-20020a05600012d200b0031401f62c24mr2017195wrx.36.1690395697670; 
 Wed, 26 Jul 2023 11:21:37 -0700 (PDT)
Received: from [192.168.8.101] (tmo-099-211.customers.d1-online.com.
 [80.187.99.211]) by smtp.gmail.com with ESMTPSA id
 b13-20020a5d4d8d000000b0031417fd473csm7302377wru.78.2023.07.26.11.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 11:21:37 -0700 (PDT)
Message-ID: <0d0f9f65-2ead-6852-20c2-a83e256eecac@redhat.com>
Date: Wed, 26 Jul 2023 20:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>
References: <20230726161942.229093-1-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab: remove duplication between msys jobs
In-Reply-To: <20230726161942.229093-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/07/2023 18.19, Daniel P. Berrangé wrote:
> Although they share a common parent, the two msys jobs still have
> massive duplication in their script definitions that can easily be
> collapsed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 132 +++++++++++++++------------------------
>   1 file changed, 49 insertions(+), 83 deletions(-)

We originally had different sets of packages in the 32-bit and 64-bit jobs, 
to distribute the load between the two jobs ... but it got unified in commit 
14547e0877f3522. Now considering that we are facing timeouts again, we 
should maybe rather revert that commit instead of unifying the lists forever?

Anyway, before we unify the compiler package name suffix between the two 
jobs, I really would like to see whether the mingw Clang builds QEMU faster 
in the 64-bit job ... but so far I failed to convince meson to accept the 
Clang from the mingw package ... does anybody know how to use Clang with 
MSYS2 properly?

  Thomas


