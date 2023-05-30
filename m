Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BE715E35
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:58:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xzi-0002Y7-AE; Tue, 30 May 2023 07:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3xze-0002XT-Eu
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3xzc-0001Oz-Er
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/OizjmdwSxoh5Rw6Id2e+/Qf1nb0LjNtqRjBC9yzzQ=;
 b=FwPyVjojFxmN41LY1gH8wm37pAnIQ5hqv+6kph4XLdwoHsN+kDFDumKnykC/9VxRXFoZFD
 3XcaEhituOk69mqyBqAoJk140UTvQI8R8meWYdklKNdU2MtGTkB6J4h6TcXz/Lx46GbBzx
 LbR3GZSTZbgl9PMpxTddyVnLboAcpEY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-aHHKqegAMZyfR4StrH_g6Q-1; Tue, 30 May 2023 07:58:22 -0400
X-MC-Unique: aHHKqegAMZyfR4StrH_g6Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3062e5d0cd3so1682989f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 04:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685447901; x=1688039901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z/OizjmdwSxoh5Rw6Id2e+/Qf1nb0LjNtqRjBC9yzzQ=;
 b=hXO0XAwNHZrlwp29gl0Ppo6Q+qPar8jBUMsyQcZo8sGrG/ZC25qgWXb+oIrXHGVO/8
 dRktsvCju00tUmozybzfa4Iu774iA3eURVhRsEOS4V0cLnzQ7TlRwMQhKOPNKlcIhyXL
 4ZzZmuvQkDWvNCGTag6BJzTCPkMz2hrpk/YSA6Zju2MMv/kY92eXT0ZEbB8WOF9eWLsy
 CSHlhmmhiUUVWUmJVGIHULxDfwdxVOGbMoFzE5FO9y+ZOuy9NkvBHt4DjlUOtvO7RKuC
 Z0JXRt8wM8Rvm6rX3toJZV251IGj88pLn10mUDRcEREH6u4eZeujMFDmQz8aMfx6Cfgt
 3zIw==
X-Gm-Message-State: AC+VfDyQGLEvgVSLmxvMYwrNW4cTNgFDDSuundNvstmOJ2IlWw+DyTvx
 L2KrtDdhbLHJIyjI4NeeNnLI0Y0FBiDyweIM9FTnLjZLlISHau+8aTrcCAwpdhiavNhREYMQ2A4
 ckPUwCwnMe6aB8Bk=
X-Received: by 2002:a5d:4c42:0:b0:30a:d731:a220 with SMTP id
 n2-20020a5d4c42000000b0030ad731a220mr1564384wrt.41.1685447900977; 
 Tue, 30 May 2023 04:58:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MzeEr5rxh3YJSDPfoEtOGEiVWBC0vs7trgxNw4iaV/+6Ja0Q4KxfTWGqb0U/Y54DW9OWl3A==
X-Received: by 2002:a5d:4c42:0:b0:30a:d731:a220 with SMTP id
 n2-20020a5d4c42000000b0030ad731a220mr1564376wrt.41.1685447900744; 
 Tue, 30 May 2023 04:58:20 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-11.web.vodafone.de.
 [109.43.176.11]) by smtp.gmail.com with ESMTPSA id
 n2-20020a5d6602000000b0030903d44dbcsm3019356wru.33.2023.05.30.04.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 04:58:20 -0700 (PDT)
Message-ID: <cb9da1f6-183a-151f-49b2-8ec103bba828@redhat.com>
Date: Tue, 30 May 2023 13:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] configure: remove --with-git= option
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com
Cc: peter.maydell@linaro.org
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230527092851.705884-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 27/05/2023 11.28, Paolo Bonzini wrote:
> There is not really any scenario where one would use any other git
> binary than "the first git in the PATH" aka $(command -v git).  In
> fact for example "meson subprojects download" or scripts/checkpatch.pl
> do not obey the GIT environment variable.
> 
> Remove the unnecessary knob, but test for the presence of git in
> the configure and git-submodule.sh scripts.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Makefile                 | 2 +-
>   configure                | 6 ++----
>   meson.build              | 1 -
>   scripts/git-submodule.sh | 8 +++++++-
>   4 files changed, 10 insertions(+), 7 deletions(-)

The commit cc84d63a42e31c2a that introduce this switch gave a
rationale:

     Some users can't run a bare 'git' command, due to need for a transparent
     proxying solution such as 'tsocks'. This adds an argument to configure to
     let users specify such a thing:
     
       ./configure --with-git="tsocks git"

But if the plain "git" command is unusable on their system,
they should likely introduce a proper wrapper on their end
for this command anyway, so IMHO it's ok if we remove this
again. Daniel, what do you think?

  Thomas


