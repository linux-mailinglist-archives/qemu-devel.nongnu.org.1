Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EDB707CEA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzZy2-0007kd-Ic; Thu, 18 May 2023 05:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzZxz-0007kU-WA
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzZxy-00059W-2w
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684402232;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TIUgTvfp0bTTs7uamP7ElEA1+Nm0Xe8R9wdCgvdMjS4=;
 b=WvnLpkYM5RVwy3y+jmevuBbHFu2ImrGu7dS/dIqeIrsyvw3T8oRfOvMZXQVt/oZAFSYi44
 NDBCGOvCryxjcTcP0WIzDDOv1Pr78aE7k3InD8kFRV8nt1h4T/CYJ1ThQX/Zy20KoX/UP4
 R68Eil6jqTiYqJCL9QmOilZr1UIcoSo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-E7HVfSvCNB2gyymaWo1v2Q-1; Thu, 18 May 2023 05:30:31 -0400
X-MC-Unique: E7HVfSvCNB2gyymaWo1v2Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f420742d40so6760625e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684402230; x=1686994230;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIUgTvfp0bTTs7uamP7ElEA1+Nm0Xe8R9wdCgvdMjS4=;
 b=g6SpxdxLcGfM4hr0w4CFFQ40UQ8ELhzlXtRLdSVNZEwTyorL2etEkIUlTFWOwCCGNJ
 J5gcr9J8h4V6NyFPPE9s9P9advuK+ZGyCnKPDgoxjhC3IDQD7RCTFy1FpuTnJkxeDnPf
 BBA4BJlnybqtvWWDcwtt9j09mA2fDKu4gaqkdeqltskZhcAin2tmYN+/Jt4TrsN6XSqL
 pQQFzXs4bptPwk/8B0KL+z70YMHLiYwu3BGn256stJOTdSPyDptk3rp9jsdSJd+n94q8
 hult5X2epdTQgIueMtmpxlK4Y3MvjFyCGhNWra/YR5geGTk6Le2IfPK9quVZmWBko9eL
 9ksw==
X-Gm-Message-State: AC+VfDz9YlXa72lc59PtyEKGXw1mS6nwKofKP+gn/MZ+h/gQzyEHzbyA
 +B79dDq2Ww9x4RHlH0uCRJnhQL7EVluaGkayGF2Ti/Y1XMPQM8SWk2a7kxmfMCUG5w0NMDM9cCb
 FZpQ1xexsfdHlQLk=
X-Received: by 2002:a05:600c:3786:b0:3f4:2e01:83fa with SMTP id
 o6-20020a05600c378600b003f42e0183famr980311wmr.26.1684402229924; 
 Thu, 18 May 2023 02:30:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7guDuB2r8aOYRz5mRB0SKF31EpYv17uYpBygGOgmrO3oNGfbIJkDeHtWYuKL2swYzQa2VC5w==
X-Received: by 2002:a05:600c:3786:b0:3f4:2e01:83fa with SMTP id
 o6-20020a05600c378600b003f42e0183famr980294wmr.26.1684402229616; 
 Thu, 18 May 2023 02:30:29 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 z14-20020a5d4d0e000000b003063a1cdaf2sm1551897wrt.48.2023.05.18.02.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 02:30:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 1/9] util: Introduce host-specific cpuinfo.h
In-Reply-To: <20230518044058.2777467-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 17 May 2023 21:40:50 -0700")
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-2-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 11:30:27 +0200
Message-ID: <871qjef0lo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> The entire contents of the header is host-specific, but the
> existence of such a header is not, which could prevent some
> host specific ifdefs at the top of the file for the include.
>
> Add include/host/{arch,generic} to the project arguments.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


