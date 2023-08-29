Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F1E78C704
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:13:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazSS-0005ok-47; Tue, 29 Aug 2023 10:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazS9-0005oC-VL
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:12:24 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazS7-0007gG-Jh
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:12:21 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe1b00fce2so7068251e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693318338; x=1693923138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vRarZfBbzx3oK6hdkQ2sfQTB/pBosxOjdtdv8zUAkP8=;
 b=OlyUN09K+OF2PCDvrmnxMcM/n3juYw96hKB9yeO6Y/ipnf1WSTSJiXaL+tmNW4GPzT
 Uxhfqm2+BgdWPeSOfWKU52rnKo1unnKn8VrCHmRsygEn7mAfloqVGf8a/cVb8x2NNHsC
 lcrD3oFxH8JarZ/5wmy6ojzG3SHInGSlu4dD0SsZegTQ6wTAImCzL4Q4DDFE1RnidmiM
 8YtTuUi1TbaYR/sRb/EpXvY3GdIxzF6GiirvFk1yegrGaalWXXcAuT6oPULUBNeA9Bm+
 +PGRISFxbgFE1Ep577rm8iKls+noLWrvjLbxY+9A4RmC+K/gh4JHs8s4kV8kvsikIjKs
 FOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318338; x=1693923138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vRarZfBbzx3oK6hdkQ2sfQTB/pBosxOjdtdv8zUAkP8=;
 b=UeqTe5bty0DBEY7xIfIVDgWsTt91ebCDTj3iSsRJmVfijeePTgemu59NhPiK26KjPL
 CDa9WxaB9HMI7cErjzGZiYy5Whsp51KBFW8MB8m3vdEYs9w2pNHPPYXPqiLzSHX+B1Ou
 Tysk6aHjzvPgch9sbQ1V3ZfiW0009K5SEHYg3KLo7LZYSL7kjxKzVP9eF021i3lNLmgJ
 95WpAUlL6EPSNsInYw8lAiknu2J/M1fA2WHO6x1FVTjpZ0xrwZtOzVHgYC0d0jFCAOp8
 MaUEUGfk52dz4FQsDdkKYRILgawlB8Xch1Xud0CZI56/RdPlhjIJ9aYDykAR1NjKNJ4u
 78yA==
X-Gm-Message-State: AOJu0YzbLrVbLeGqJvU1n/GqSXYhelkT16DLS/QCT+5XWBAxxTjHFaQX
 6VlrmVu4qi9omFbdGNbkP66r4g==
X-Google-Smtp-Source: AGHT+IFvac749iBrbobgU5KTzrhhQtr3NI44/slLiE+kvdbsbQnluB5C6i02Zb8DbzOu8E+cnGn0mw==
X-Received: by 2002:ac2:551d:0:b0:500:9a45:638 with SMTP id
 j29-20020ac2551d000000b005009a450638mr10672479lfk.2.1693318337666; 
 Tue, 29 Aug 2023 07:12:17 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 s1-20020aa7c541000000b0052333e5237esm5663954edr.88.2023.08.29.07.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:12:17 -0700 (PDT)
Message-ID: <60864c2c-9012-a2c8-58de-956a47d80108@linaro.org>
Date: Tue, 29 Aug 2023 16:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/4] migration/qmp: Fix crash on setting tls-authz with
 null
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
References: <20230825171517.1215317-1-peterx@redhat.com>
 <20230825171517.1215317-2-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230825171517.1215317-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/8/23 19:15, Peter Xu wrote:
> QEMU will crash if anyone tries to set tls-authz (which is a type
> StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
> qstring just like the other two tls parameters.
> 
> Cc: qemu-stable@nongnu.org # v4.0+
> Fixes: d2f1d29b95 ("migration: add support for a "tls-authz" migration parameter")
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/options.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


