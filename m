Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DCA7854ED
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 12:10:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYknK-0003Cy-9N; Wed, 23 Aug 2023 06:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYknI-0003CX-IS
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYknG-0006kr-Q6
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692785334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URAi5UC86x22wWgB0+fl4Nms9wMVCGCOmmZ26x82uMk=;
 b=dOSKAwcbhpMZKOZh82AO4Y9c1pX1+Sm+TfPlVRwmUGLln6C7L6DlqBmaPgmYLhItWXnqwF
 9EOaaCz9ShBI0haFa0NCdm0Gq3KjMCio6DVyVbDyUs+RoVTy1/yDZQXYs4Z0sM1/IMLvgL
 LgS2OCdwqhiP5UxSMkPaTCLNkbWRkiY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-gZEV48mbOQGmESnP9u2FsA-1; Wed, 23 Aug 2023 06:08:52 -0400
X-MC-Unique: gZEV48mbOQGmESnP9u2FsA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3feb93ba681so37379625e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692785331; x=1693390131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=URAi5UC86x22wWgB0+fl4Nms9wMVCGCOmmZ26x82uMk=;
 b=E2QQONJHPBBilKchpMkW2+8CfOS+JDc1zl6qinAO0y+SdPHPF0nQDtASHTOevHfH8e
 Oqd4mNVQu3+rN5FWNpYmZj8Ai5cayprGAIFix3BcrhZuX8qnSazsMas7FR4eaxuUKfhi
 RQUPCmtbKeqcN6wMUiwPH+87Vj1KtPEWjBhpKWPA12rPbaHGH6Tg2Ld+OnS2gXeh7QCW
 nLkB/p2+N91eixp67vGYcfHAQ9ldUp1p58Rp6m/ejm4GMdm2nexOQ4s42VxwBKyTyFDv
 dJHWkFxJzidxpbWlramVLHFoSYhmaGb3hKxIDHLtTeX3v8Vm6x6yMENrEbnjR0CaEFJo
 Vl6w==
X-Gm-Message-State: AOJu0YxYynof6rryEfCb6PHIq5WgitjaUI0y7atvAwGgnAgwhSAVHX/j
 wLFzpGCtixXfYpFNdrqvtrUf5cPCcX2VRuKEr3DggoWOjc22+C6Qhfc9GTpDcSuVcN4Gh1jlQ1q
 +RaaPP49B9zDjAE4=
X-Received: by 2002:a05:600c:2807:b0:3fe:111a:d1d9 with SMTP id
 m7-20020a05600c280700b003fe111ad1d9mr9064358wmb.25.1692785331715; 
 Wed, 23 Aug 2023 03:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpTDX7Jqt84UTIRqSO0skW7iMWL+I1hxe2Rq1q7B3LX4H0RadOgbGHtBctWiPnw0jaLSvdGQ==
X-Received: by 2002:a05:600c:2807:b0:3fe:111a:d1d9 with SMTP id
 m7-20020a05600c280700b003fe111ad1d9mr9064345wmb.25.1692785331463; 
 Wed, 23 Aug 2023 03:08:51 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fefd46df47sm3205989wma.29.2023.08.23.03.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 03:08:50 -0700 (PDT)
Message-ID: <259cc575-36a7-42b7-3d76-1867a0111200@redhat.com>
Date: Wed, 23 Aug 2023 12:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] docs/about/license: Update LICENSE URL
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230822125716.55295-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230822125716.55295-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 22/08/2023 14.57, Philippe Mathieu-Daudé wrote:
> In early 2021 (see commit 2ad784339e "docs: update README to use
> GitLab repo URLs") almost all of the code base was converted to
> point to GitLab instead of git.qemu.org. During 2023, git.qemu.org
> switched from a git mirror to a http redirect to GitLab (see [1]).
> 
> Update the LICENSE URL to match its previous content, displaying
> the file raw content similarly to gitweb 'blob_plain' format ([2]).
> 
> [1] https://lore.kernel.org/qemu-devel/CABgObfZu3mFc8tM20K-yXdt7F-7eV-uKZN4sKDarSeu7DYoRbA@mail.gmail.com/
> [2] https://git-scm.com/docs/gitweb#Documentation/gitweb.txt-blobplain
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2: Drop '&ref_type=heads' (danpb)
> ---
>   docs/about/license.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/about/license.rst b/docs/about/license.rst
> index cde3d2d25d..303c55d61b 100644
> --- a/docs/about/license.rst
> +++ b/docs/about/license.rst
> @@ -8,4 +8,4 @@ QEMU is a trademark of Fabrice Bellard.
>   QEMU is released under the `GNU General Public
>   License <https://www.gnu.org/licenses/gpl-2.0.txt>`__, version 2. Parts
>   of QEMU have specific licenses, see file
> -`LICENSE <https://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE>`__.
> +`LICENSE <https://gitlab.com/qemu-project/qemu/-/raw/master/LICENSE>`__.

Reviewed-by: Thomas Huth <thuth@redhat.com>


