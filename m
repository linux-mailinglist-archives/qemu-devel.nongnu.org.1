Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B86F772215F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65ss-0001kx-3u; Mon, 05 Jun 2023 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q65se-0001dc-8i
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q65sc-0002X1-PW
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685954878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eidoc9mFsqsFxYE2EDnR1lrudoxa0bnY8vwoFSWeWqI=;
 b=KTeKqAe+0rxYX3iz0U/NR/S6GQ/uORwB7gq9M+iJOOKljbcRTk4Fap0uawqJlike2Ilw7g
 z9Sg5y7KUpZ2o4w9ltHo0XMMB9Q/1dwTPFdKCz/cvx/xkOvUODDaMoVnMnrpCbEqXp+BFA
 TSYMHxBH6actYyB7rEYbS8j9afksi3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-gwvka4zsNaSrF96KBwhpWQ-1; Mon, 05 Jun 2023 04:47:55 -0400
X-MC-Unique: gwvka4zsNaSrF96KBwhpWQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30ae7bd987dso1899217f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 01:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685954875; x=1688546875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eidoc9mFsqsFxYE2EDnR1lrudoxa0bnY8vwoFSWeWqI=;
 b=j4vcHjNw5tuA9XoRBTPDRgQtt4eQeC1kKs9stZiF/mI8JnbmvRHm9ykB5R5ohJxMmm
 iIJDlhUqm3o2QWQA+/H7Y92Bw1Ls5QqLvsK/txwRrYp3nZF7LfEQMJn1dImgdYVvEgBD
 6qQCRIgO2SuRuzSO61OX5WUBXhqUnV/FeBy2r8pM/kbPpQeP1kAhM+CR0gRZmHq8S73C
 h9PwMG5ZugTOcZkTqYN/reR9j3kaCm5mOscCbKQiy1t6oMSZRBIS75gT0IIAIVjbiBNh
 WMboWjoEbVq4sPEoNTmOvo428EsWhziWOfwj8nzkaWqCH84SK+1iZ3UUF6OxYc/P8SSO
 wfdw==
X-Gm-Message-State: AC+VfDy/biUPI6J93W3MWqXICCClpA+zCoez3hHAZqsZ0qZcNUPkfhEm
 z7JLQMeU+KuAnEPBgNo5sMh7+11Uj+YTOaR1hasq2ZbXgXLvNRH/D24Zn4zUjybv3ePJ/FhbNts
 Q9aKiR6rGvHcO8rU=
X-Received: by 2002:a5d:4884:0:b0:306:b3f9:e2c9 with SMTP id
 g4-20020a5d4884000000b00306b3f9e2c9mr3979981wrq.6.1685954874910; 
 Mon, 05 Jun 2023 01:47:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4j3sA24mYy10c2nPj4Fvc8ZmbmkVryezSSpENhf1+ndPzpxDZmP9rQwAjeG4It5zp65APJSw==
X-Received: by 2002:a5d:4884:0:b0:306:b3f9:e2c9 with SMTP id
 g4-20020a5d4884000000b00306b3f9e2c9mr3979969wrq.6.1685954874664; 
 Mon, 05 Jun 2023 01:47:54 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-115-143.web.vodafone.de.
 [109.42.115.143]) by smtp.gmail.com with ESMTPSA id
 x11-20020a5d650b000000b00307972e46fasm9020161wru.107.2023.06.05.01.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 01:47:54 -0700 (PDT)
Message-ID: <4352552f-67ba-b964-7a7e-b13c9b19a27c@redhat.com>
Date: Mon, 5 Jun 2023 10:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] meson.build: Use -Wno-undef only for SDL2 versions
 that need it
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-trivial@nongnu.org
References: <20230605082748.53989-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230605082748.53989-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 05/06/2023 10.27, Paolo Bonzini wrote:
> Queued, thanks.

Please unqueue it again, I'm still seeing some issues with the patch (not 
sure why yet):

  https://gitlab.com/thuth/qemu/-/jobs/4411089009

  Thomas


