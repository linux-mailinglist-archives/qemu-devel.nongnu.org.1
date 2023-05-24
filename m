Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E2570EDD2
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 08:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1hxC-00063T-Bf; Wed, 24 May 2023 02:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1hwc-0005ro-Qv
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:25:58 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1hwX-0006Zx-3x
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:25:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2ebso4599885e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684909550; x=1687501550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=elfdIz5g/ER+semG3iq1xcjFnlP3a+ECnVFlgtSutmk=;
 b=h8GGuKyd9JNrlRkg6DYHGLuen4mykPzQukHbBFhcYAEbC/tMgw7MdN1dU/6BU9uVQQ
 i3PrpD80QEWJEtCIPllTim9xiD8xzHua/IfTRCSexpdnkT8CKvQAxuV5+ibV3mh32klw
 Hds/85j6g8CoiYUx8jKrd77cZdlsZpzbGAWuOzr+u9hnIG+boLAP3oQUurQnqKFoRkPL
 hLkZaYiUUe0FlCpbzljewfTA2uNHveQJTvBFuMRXEA8rb2KygGxqcTYrjvEInvIGjcoJ
 RSjY5FCIcAodV/Jwfmda0jQd5TtsH7OEHPiaKFv3LqLvz5JjX38T1wtRN7t7vxpNfUuw
 Wt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684909550; x=1687501550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elfdIz5g/ER+semG3iq1xcjFnlP3a+ECnVFlgtSutmk=;
 b=OVWY/KOKoCe7jmSTmXahAmuKTvc+GdI8g8OSKXCGhoJbokbnGgXP6ZCCRLSA6j3grf
 XmOxF1S3TbZSVGhFdCuuwxjSghWkQoGHl3f1oa+jD2PW85XQQS/uS8kZlW772pPO4ykS
 zgwHqHnDVbC35VoB8YE8ck6lWhbwP/YYKuyZAHczIIq35BthFIX4cc/VHP3BjNML70iN
 1+++DcGObVqXgh6kglxNpmWoq/+CCgZ3RJBfOK0ny+bws15RHmoS3PVWPNLOTATfhZaM
 meOOg/fKkaFYKE9L+Jyhb4ahEDHytWxX5VEK8vga2Md8Kuid1cpSngDa5OD4cWA4QLhe
 NU6w==
X-Gm-Message-State: AC+VfDyr/capdJU5/BcxQHVNDJXxHTJUUhlduL+d0oRvju1xIcYB/r6v
 JkBLhxA1MHPrQdhhoLg0q3dHeXTbAjPHArQQk3hBbA==
X-Google-Smtp-Source: ACHHUZ67zdKIKOxXgu2aGnAYSq4lAWQwKkamEPQaj5POnjZsjzx75bxrS/KBD2oE8LD9K2ejBPkbqQ==
X-Received: by 2002:a05:600c:294c:b0:3f5:fa8e:aaa3 with SMTP id
 n12-20020a05600c294c00b003f5fa8eaaa3mr9622554wmd.28.1684909550676; 
 Tue, 23 May 2023 23:25:50 -0700 (PDT)
Received: from [192.168.215.175] (35.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.35]) by smtp.gmail.com with ESMTPSA id
 2-20020a05600c028200b003f42cc3262asm1092467wmk.34.2023.05.23.23.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 23:25:50 -0700 (PDT)
Message-ID: <6e05d67f-f5e4-700c-45e4-4c3a541c02c9@linaro.org>
Date: Wed, 24 May 2023 08:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm/Kconfig: Make TCG dependence explicit
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230523180525.29994-1-farosas@suse.de>
 <20230523180525.29994-4-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523180525.29994-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/5/23 20:05, Fabiano Rosas wrote:
> Replace the 'default y if TCG' pattern with 'default y; depends on
> TCG'.
> 
> That makes explict that there is a dependence on TCG and enabling
> these CONFIGs via .mak files without TCG present will fail earlier.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   hw/arm/Kconfig | 123 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 82 insertions(+), 41 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


